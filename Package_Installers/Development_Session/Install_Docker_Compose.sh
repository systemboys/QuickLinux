#!/bin/bash

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

    # Baixe a versão atual do Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # Dê permissão de execução ao binário
    sudo chmod +x /usr/local/bin/docker-compose

    # Verifique se o Docker Compose foi instalado corretamente
    docker-compose --version

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