#!/bin/bash

clear

# Variáveis úteis
packageVersionName="remmina" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Remmina" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    apt-get update
    apt-get install remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice remmina-plugin-vnc
    dnf install remmina remmina-plugins-rdp remmina-plugins-secret remmina-plugins-spice remmina-plugins-vnc

    clear
    dialog --msgbox "${packageName} instalado com sucesso!" 8 40
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi
