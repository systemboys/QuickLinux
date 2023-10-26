#!/bin/bash

clear

# Variáveis úteis
packageVersionName="docker" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Docker" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    curl -fsSL https://get.docker.com | bash

    clear
    dialog --msgbox "${packageName} instalado com sucesso!" 8 40
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi