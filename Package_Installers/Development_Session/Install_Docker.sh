#!/bin/bash

# System_Information.sh - Instalar o Docker no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o Docker no Linux.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Instalar o Docker no Linux.
#
# Licença: GPL.

clear

# Variáveis úteis
packageVersionName="docker" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Docker" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    sudo apt update
    curl -fsSL https://get.docker.com | bash

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