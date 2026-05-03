#!/bin/bash

# Prepare_Development_Environment.sh - Preparar ambiente de desenvolvimento/deploy.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa prepara um ambiente Debian/Ubuntu, local ou remoto, para executar
# aplicações Docker/Node.js com Docker Compose, Git, Node.js LTS e utilitários de
# operação.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2026-05-03 às 12h25, Marcos Aurélio:
#   - Versão inicial, preparar ambiente de desenvolvimento/deploy para aplicações
#     Docker/Node.js.
#
# Licença: GPL.

clear

packageName="Ambiente de Desenvolvimento"
nodeMajorVersion="24"
workspaceDir="/opt/projects"

if [ "$EUID" -ne 0 ]; then
    dialog --msgbox "Este instalador precisa ser executado como superusuário." 8 60
    exit 1
fi

install_docker_repository() {
    . /etc/os-release
    case "$ID" in
        debian)
            docker_repo_os="debian"
            docker_repo_codename="$VERSION_CODENAME"
            ;;
        ubuntu)
            docker_repo_os="ubuntu"
            docker_repo_codename="${UBUNTU_CODENAME:-$VERSION_CODENAME}"
            ;;
        *)
            dialog --msgbox "Distribuição não suportada pelo instalador oficial do Docker: ${PRETTY_NAME:-$ID}" 8 70
            exit 1
            ;;
    esac

    rm -f /etc/apt/sources.list.d/docker.list

    apt-get update
    apt-get install -y ca-certificates curl gnupg
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL "https://download.docker.com/linux/${docker_repo_os}/gpg" -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

    cat > /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/${docker_repo_os}
Suites: ${docker_repo_codename}
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    apt-get update
}

install_nodejs_lts() {
    installedNodeMajor=""
    if command -v node >/dev/null 2>&1; then
        installedNodeMajor=$(node -v | sed 's/^v//' | cut -d. -f1)
    fi

    if command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1 && [ "$installedNodeMajor" -ge "$nodeMajorVersion" ] 2>/dev/null; then
        return
    fi

    apt-get install -y ca-certificates curl gnupg
    curl -fsSL "https://deb.nodesource.com/setup_${nodeMajorVersion}.x" -o /tmp/nodesource_setup.sh
    bash /tmp/nodesource_setup.sh
    apt-get install -y nodejs
}

install_compose_compatibility_wrapper() {
    if ! command -v docker-compose >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
        cat > /usr/local/bin/docker-compose <<'EOF'
#!/bin/sh
exec docker compose "$@"
EOF
        chmod +x /usr/local/bin/docker-compose
    fi
}

prepare_workspace() {
    mkdir -p "$workspaceDir"

    if [ -n "${SUDO_USER:-}" ] && id "$SUDO_USER" >/dev/null 2>&1; then
        chown "$SUDO_USER:$SUDO_USER" "$workspaceDir"
        usermod -aG docker "$SUDO_USER" 2>/dev/null || true
    fi
}

dialog --yesno "Preparar este ambiente para projetos Docker/Node.js?\n\nSerão instalados/atualizados: Docker Engine, Buildx, Docker Compose plugin, Git, Node.js ${nodeMajorVersion} LTS, cliente MySQL e utilitários básicos.\n\nNenhum projeto será clonado e nenhum deploy será feito automaticamente." 14 78
if [ $? -ne 0 ]; then
    clear
    exit 0
fi

(
    echo "10"; echo "Atualizando lista de pacotes..."
    apt-get update >/tmp/quicklinux-development.log 2>&1

    echo "25"; echo "Instalando utilitários básicos..."
    apt-get install -y ca-certificates curl gnupg git unzip zip openssl build-essential default-mysql-client htop nano >>/tmp/quicklinux-development.log 2>&1

    echo "45"; echo "Configurando repositório oficial do Docker..."
    apt-get remove -y docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc >>/tmp/quicklinux-development.log 2>&1 || true
    install_docker_repository >>/tmp/quicklinux-development.log 2>&1

    echo "65"; echo "Instalando Docker Engine, Buildx e Compose plugin..."
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >>/tmp/quicklinux-development.log 2>&1
    systemctl enable --now docker >>/tmp/quicklinux-development.log 2>&1
    install_compose_compatibility_wrapper >>/tmp/quicklinux-development.log 2>&1

    echo "82"; echo "Instalando Node.js ${nodeMajorVersion} LTS..."
    install_nodejs_lts >>/tmp/quicklinux-development.log 2>&1

    echo "94"; echo "Preparando diretório ${workspaceDir}..."
    prepare_workspace >>/tmp/quicklinux-development.log 2>&1

    echo "100"; echo "Concluído."
) | dialog --title "Preparando ${packageName}" --gauge "Aguarde..." 10 75 0

if ! command -v docker >/dev/null 2>&1 || ! docker compose version >/dev/null 2>&1 || ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
    dialog --textbox /tmp/quicklinux-development.log 22 90
    dialog --msgbox "Erro ao preparar o ${packageName}. Veja o log acima." 8 60
    exit 1
fi

dockerVersion=$(docker --version 2>/dev/null)
composeVersion=$(docker compose version 2>/dev/null)
nodeVersion=$(node -v 2>/dev/null || echo "Node.js indisponível")
npmVersion=$(npm -v 2>/dev/null || echo "NPM indisponível")

dialog --msgbox "${packageName} preparado com sucesso!\n\n${dockerVersion}\n${composeVersion}\nNode.js: ${nodeVersion}\nNPM: ${npmVersion}\n\nDiretório preparado: ${workspaceDir}\n\nPróximos passos típicos:\n1. Clonar o projeto em ${workspaceDir}\n2. Configurar arquivos .env\n3. Executar o comando de build/deploy do projeto\n\nSe o usuário foi adicionado ao grupo docker, abra uma nova sessão antes de usar Docker sem sudo." 18 80
