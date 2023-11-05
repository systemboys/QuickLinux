#!/bin/bash

# System_Information.sh - Instalar o Discord no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o Discord no Linux.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Instalar o Discord no Linux.
#
# Licença: GPL.

clear

# Variáveis úteis
packageVersionName="discord" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Discord" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    sudo wget -O /usr/share/keyrings/discord-archive-keyring.gpg https://discord.com/api/download/keyring
    echo 'deb [signed-by=/usr/share/keyrings/discord-archive-keyring.gpg] https://packages.discord.com/debian/ stable main' | sudo tee /etc/apt/sources.list.d/discord.list
    sudo apt update
    sudo apt install discord

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
