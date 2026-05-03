#!/bin/bash

# Development_Test_Container.sh - Gerenciar container de testes para desenvolvimento.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa cria e gerencia um container de testes com acesso ao Docker
# do host, diretório compartilhado e portas expostas para testar aplicações
# antes do deploy.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2026-05-03 às 13h05, Marcos Aurélio:
#   - Versão inicial, criar, acessar, parar e remover container de testes para
#     desenvolvimento.
#
# Licença: GPL.

clear

containerName="quicklinux-dev"
imageName="node:24-bookworm"
workspaceDir="/opt/projects"
logFile="/tmp/quicklinux-dev-container.log"
readyFile="/tmp/quicklinux-dev-ready"

action="$1"

ensure_docker() {
    if ! command -v docker >/dev/null 2>&1; then
        dialog --msgbox "Docker não está instalado. Instale o Docker antes de usar esta opção." 8 70
        exit 1
    fi

    if [ ! -S /var/run/docker.sock ]; then
        dialog --msgbox "Socket do Docker não encontrado em /var/run/docker.sock. Verifique se o serviço Docker está ativo." 8 75
        exit 1
    fi
}

container_exists() {
    docker ps -a --format '{{.Names}}' | grep -qx "$containerName"
}

container_running() {
    docker ps --format '{{.Names}}' | grep -qx "$containerName"
}

prepare_workspace() {
    mkdir -p "$workspaceDir"

    if [ -n "${SUDO_USER:-}" ] && id "$SUDO_USER" >/dev/null 2>&1; then
        chown "$SUDO_USER:$SUDO_USER" "$workspaceDir"
    fi
}

wait_until_ready() {
    local attempts=90
    local current=0

    while [ "$current" -lt "$attempts" ]; do
        if docker exec "$containerName" test -f "$readyFile" >/dev/null 2>&1; then
            return 0
        fi

        sleep 2
        current=$((current + 1))
    done

    return 1
}

create_container() {
    ensure_docker
    prepare_workspace

    if container_exists; then
        if ! container_running; then
            docker start "$containerName" >/dev/null
        fi

        dialog --msgbox "O container ${containerName} já existe.\n\nUse a opção de acesso para entrar nele." 8 70
        return
    fi

    dialog --yesno "Criar container de testes para desenvolvimento?\n\nNome: ${containerName}\nImagem: ${imageName}\nWorkspace: ${workspaceDir} -> /workspace\nDocker do host: /var/run/docker.sock\nPortas: 3000, 3333, 5173, 8000, 8080, 9080\n\nO primeiro start pode demorar porque a imagem será baixada e ferramentas serão instaladas no container." 17 78
    if [ $? -ne 0 ]; then
        clear
        return
    fi

    docker run -d \
        --name "$containerName" \
        --hostname "$containerName" \
        --workdir /workspace \
        -v "$workspaceDir:/workspace" \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -p 3000:3000 \
        -p 3333:3333 \
        -p 5173:5173 \
        -p 8000:8000 \
        -p 8080:8080 \
        -p 9080:9080 \
        "$imageName" \
        bash -lc '
            set -e
            rm -f /tmp/quicklinux-dev-ready
            rm -f /etc/apt/sources.list.d/docker.list
            apt-get update
            apt-get install -y ca-certificates curl gnupg git unzip zip openssl default-mysql-client nano htop
            install -m 0755 -d /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
            chmod a+r /etc/apt/keyrings/docker.asc
            printf "%s\n" \
                "Types: deb" \
                "URIs: https://download.docker.com/linux/debian" \
                "Suites: bookworm" \
                "Components: stable" \
                "Architectures: $(dpkg --print-architecture)" \
                "Signed-By: /etc/apt/keyrings/docker.asc" \
                > /etc/apt/sources.list.d/docker.sources
            apt-get update
            apt-get install -y docker-ce-cli docker-compose-plugin
            if ! command -v docker-compose >/dev/null 2>&1; then
                printf "%s\n" "#!/bin/sh" "exec docker compose \"\$@\"" > /usr/local/bin/docker-compose
                chmod +x /usr/local/bin/docker-compose
            fi
            touch /tmp/quicklinux-dev-ready
            tail -f /dev/null
        ' >"$logFile" 2>&1

    if [ $? -ne 0 ]; then
        dialog --textbox "$logFile" 22 90
        dialog --msgbox "Erro ao criar o container ${containerName}." 8 60
        return
    fi

    (
        echo "20"; echo "Container criado. Instalando ferramentas internas..."
        if wait_until_ready; then
            echo "100"; echo "Container pronto."
        else
            echo "100"; echo "Tempo esgotado aguardando preparo."
        fi
    ) | dialog --title "Preparando container de testes" --gauge "Aguarde..." 10 75 0

    if ! docker exec "$containerName" test -f "$readyFile" >/dev/null 2>&1; then
        docker logs "$containerName" >"$logFile" 2>&1
        dialog --textbox "$logFile" 22 90
        dialog --msgbox "O container foi criado, mas ainda não confirmou que terminou a preparação.\n\nTente acessar em alguns instantes ou veja os logs com:\ndocker logs ${containerName}" 10 75
        return
    fi

    dialog --msgbox "Container ${containerName} pronto.\n\nEntre pela opção de acesso.\n\nDentro dele:\n- Projetos ficam em /workspace\n- Docker do host está disponível\n- Aplicações podem ser acessadas no host pelas portas expostas." 12 75
}

access_container() {
    ensure_docker

    if ! container_exists; then
        dialog --msgbox "O container ${containerName} ainda não existe. Crie o container primeiro." 8 70
        return
    fi

    if ! container_running; then
        docker start "$containerName" >/dev/null
    fi

    clear
    echo "Entrando no container ${containerName}..."
    echo "Workspace: /workspace"
    echo "Para sair, use: exit"
    echo
    docker exec -it "$containerName" bash
}

stop_container() {
    ensure_docker

    if ! container_exists; then
        dialog --msgbox "O container ${containerName} ainda não existe." 8 60
        return
    fi

    if container_running; then
        docker stop "$containerName" >/dev/null
        dialog --msgbox "Container ${containerName} parado." 8 50
    else
        dialog --msgbox "Container ${containerName} já está parado." 8 50
    fi
}

remove_container() {
    ensure_docker

    if ! container_exists; then
        dialog --msgbox "O container ${containerName} ainda não existe." 8 60
        return
    fi

    dialog --yesno "Remover o container ${containerName}?\n\nA pasta compartilhada ${workspaceDir} não será apagada." 9 70
    if [ $? -ne 0 ]; then
        clear
        return
    fi

    docker rm -f "$containerName" >/dev/null
    dialog --msgbox "Container ${containerName} removido.\n\nA pasta ${workspaceDir} foi preservada." 8 65
}

case "$action" in
    create)
        create_container
        ;;
    access)
        access_container
        ;;
    stop)
        stop_container
        ;;
    remove)
        remove_container
        ;;
    *)
        dialog --msgbox "Ação inválida para o container de testes." 8 50
        exit 1
        ;;
esac
