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
#
# Licença: GPL.

clear

# Variáveis úteis
packageVersionName="docker-compose" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Docker Compose" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    # Atualize o sistema
    sudo apt-get update

    # Instale as dependências
    sudo apt-get install -y curl jq

    # Descubra a última versão estável do Docker Compose
    latest_version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)

    # Baixe a versão mais recente do Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/${latest_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # Dê permissão de execução ao binário
    sudo chmod +x /usr/local/bin/docker-compose

    # Crie um link simbólico para garantir que o comando esteja disponível no PATH
    if [ ! -e /usr/bin/docker-compose ]; then
        sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    fi

    # Atualize o hash do shell para reconhecer o novo binário
    hash -r

    # Verifique se o Docker Compose foi instalado corretamente
    if ! docker-compose --version &> /dev/null; then
        echo "Erro: Docker Compose não foi instalado corretamente."
        exit 1
    else
        docker-compose --version
    fi

    clear
    
    if ! command -v ${packageVersionName} &> /dev/null; then
        dialog --msgbox "Erro na instalação de ${packageName}!" 8 40
    else
        dialog --msgbox "${packageName} instalado com sucesso!" 8 40
    fi
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi