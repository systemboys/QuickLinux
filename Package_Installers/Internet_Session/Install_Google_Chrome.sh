#!/bin/bash

clear

# Variáveis úteis
packageVersionName="google-chrome-stable" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Google Chrome" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    # Fazer download do pacote
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    # Instalar o pacote
    sudo dpkg -i google-chrome-stable_current_amd64.deb

    # Dar permissões e deletar o arquivo
    chmod 777 google-chrome-stable_current_amd64.deb && rm -r google-chrome-stable_current_amd64.deb

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
