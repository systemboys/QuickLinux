#!/bin/bash

# System_Information.sh - Instalar o Docker Compose no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o Docker Compose no Linux.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Instalar o Docker Compose no Linux.
# v1.0.1 2025-09-01, Instalar a versão mais recente do Docker Compose.
# v1.0.2 2026-05-03 às 12h25, Marcos Aurélio:
#   - Atualizada instalação para o Docker Compose plugin oficial e wrapper compatível
#     com docker-compose.
#
# Licença: GPL.

clear

# Variáveis úteis
packageName="Docker Compose" # Apenas o nome do pacote

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
    apt-get install -y ca-certificates curl
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

install_compose_compatibility_wrapper() {
    if ! command -v docker-compose >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
        cat > /usr/local/bin/docker-compose <<'EOF'
#!/bin/sh
exec docker compose "$@"
EOF
        chmod +x /usr/local/bin/docker-compose
    fi
}

# Verificar se está instalado
if ! docker compose version >/dev/null 2>&1; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    if ! command -v docker >/dev/null 2>&1; then
        apt-get remove -y docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc 2>/dev/null || true
        install_docker_repository
        apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        systemctl enable --now docker
    else
        install_docker_repository
        apt-get install -y docker-compose-plugin
    fi

    install_compose_compatibility_wrapper

    clear
    
    if ! docker compose version >/dev/null 2>&1; then
        dialog --msgbox "Erro na instalação de ${packageName}!" 8 40
    else
        compose_version=$(docker compose version)
        compat_command="docker-compose indisponível"
        if command -v docker-compose >/dev/null 2>&1; then
            compat_command=$(docker-compose version)
        fi
        dialog --msgbox "${packageName} instalado com sucesso!\n\n${compose_version}\n${compat_command}" 10 70
    fi
else
    install_compose_compatibility_wrapper
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi
