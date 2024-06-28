#!/bin/bash

# System_Information.sh - Instalar o navegador Mozilla Firefox no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o navegador Mozilla Firefox no Linux.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Instalar o navegador Mozilla Firefox no Linux.
#
# Licença: GPL.

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
    
    if ! [ -d "/opt/${packageVersionName}" ]; then
        dialog --msgbox "Erro na instalação de ${packageName}!" 8 40
    else
        dialog --msgbox "${packageName} instalado com sucesso!" 8 40
    fi
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi
