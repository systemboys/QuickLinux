#!/bin/bash

clear

# Variáveis úteis
packageVersionName="google-earth-pro-stable" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Google Earth Pro" # Apenas o nome do pacote

# Verificar se o está instalado
if ! [ -x "$(command -v google-earth-pro)" ]; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    # Baixar o pacote
    wget https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb

    # Instalar o pacote
    sudo dpkg -i google-earth-pro-stable_current_amd64.deb

    # Dar permissões e apagar o arquivo
    chmod 777 google-earth-pro-stable_current_amd64.deb && rm -r google-earth-pro-stable_current_amd64.deb

    clear
    
    if ! [ -x "$(command -v google-earth-pro)" ]; then
        dialog --msgbox "Erro na instalação de ${packageName}!" 8 40
    else
        dialog --msgbox "${packageName} instalado com sucesso!" 8 40
    fi
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi
