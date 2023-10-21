#!/bin/bash

clear

# Variáveis úteis
packageVersionName="opera" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Opera" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    sudo apt-get update
    sudo apt-get install apt-transport-https
    wget -qO- https://deb.opera.com/archive.key | sudo gpg --dearmor -o /usr/share/keyrings/com.opera-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/com.opera-archive-keyring.gpg] https://deb.opera.com/opera-stable/ stable non-free" | sudo tee /etc/apt/sources.list.d/opera.list
    sudo apt-get update
    sudo apt-get install opera-stable

    clear
    dialog --msgbox "${packageName} instalado com sucesso!" 8 40
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi
