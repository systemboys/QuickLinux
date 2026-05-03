#!/bin/bash

# Install_Docker_Desktop.sh - Instalar o Docker Desktop no Linux (Debian).
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o Docker Desktop no Linux (Debian).
# Baseado na documentação oficial: https://docs.docker.com/desktop/setup/install/linux/debian/
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2026-01-08 às 13h20, Marcos Aurélio:
#   - Versão inicial, Instalar o Docker Desktop no Linux (Debian).
# v1.0.1 2026-05-03 às 12h25, Marcos Aurélio:
#   - Ajustada configuração do repositório oficial do Docker para Debian e Ubuntu.
#
# Licença: GPL.

clear

# Variáveis úteis
packageVersionName="docker-desktop" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Docker Desktop" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v docker-desktop &> /dev/null && [ ! -f "/opt/docker-desktop/bin/docker-desktop" ]; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    # Passo 1: Configurar o repositório apt do Docker
    dialog --infobox "Configurando o repositório apt do Docker..." 8 40

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
            dialog --msgbox "Distribuição não suportada pelo instalador oficial do Docker Desktop: ${PRETTY_NAME:-$ID}" 8 70
            exit 1
            ;;
    esac
    
    rm -f /etc/apt/sources.list.d/docker.list

    # Instalar dependências necessárias
    apt-get update -qq
    apt-get install -y -qq ca-certificates curl gnupg
    
    # Adicionar chave GPG oficial do Docker
    install -m 0755 -d /etc/apt/keyrings
    if [ ! -f /etc/apt/keyrings/docker.asc ]; then
        curl -fsSL "https://download.docker.com/linux/${docker_repo_os}/gpg" -o /etc/apt/keyrings/docker.asc
        chmod a+r /etc/apt/keyrings/docker.asc
    fi
    
    # Configurar repositório
    cat > /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/${docker_repo_os}
Suites: ${docker_repo_codename}
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
    
    apt-get update -qq
    
    # Passo 2: Baixar o pacote DEB mais recente
    dialog --infobox "Baixando o pacote DEB do Docker Desktop..." 8 40
    
    # Criar diretório temporário para download
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    # Baixar o pacote DEB mais recente
    DEB_URL="https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb"
    DEB_FILE="docker-desktop-amd64.deb"
    
    if curl -L -o "$DEB_FILE" "$DEB_URL"; then
        # Passo 3: Instalar o pacote
        dialog --infobox "Instalando o Docker Desktop..." 8 40
        
        if apt-get install -y -qq ./"$DEB_FILE"; then
            # Limpar arquivos temporários
            cd /
            rm -rf "$TEMP_DIR"
            
            clear
            
            # Verificar se foi instalado com sucesso
            if command -v docker-desktop &> /dev/null || [ -f "/opt/docker-desktop/bin/docker-desktop" ]; then
                dialog --msgbox "${packageName} instalado com sucesso!\n\nPara iniciar o Docker Desktop, execute:\nsystemctl --user start docker-desktop\n\nOu navegue até o Docker Desktop no seu ambiente de desktop (Gnome/KDE)." 12 50
            else
                dialog --msgbox "Instalação concluída, mas não foi possível verificar a instalação. Verifique manualmente." 8 50
            fi
        else
            cd /
            rm -rf "$TEMP_DIR"
            clear
            dialog --msgbox "Erro na instalação do pacote ${packageName}!" 8 40
        fi
    else
        cd /
        rm -rf "$TEMP_DIR"
        clear
        dialog --msgbox "Erro ao baixar o pacote ${packageName}! Verifique sua conexão com a internet." 8 50
    fi
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi
