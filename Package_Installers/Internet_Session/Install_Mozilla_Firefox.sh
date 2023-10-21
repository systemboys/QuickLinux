#!/bin/bash

clear

# Variáveis úteis
packageVersionName="firefox" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Mozilla Firefox" # Apenas o nome do pacote

# Verificar se o está instalado
if ! [ -d "/opt/${packageVersionName}" ]; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    sudo apt update
    sudo apt install firefox-esr
    sudo apt install -t buster-backports firefox

    clear
    dialog --msgbox "${packageName} instalado com sucesso!" 8 40
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi
