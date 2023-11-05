#!/bin/bash

# System_Information.sh - Instalar o navegador Microsoft Edge no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o navegador Microsoft Edge no Linux.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Instalar o navegador Microsoft Edge no Linux.
#
# Licença: GPL.

clear

# Variáveis úteis
packageVersionName="microsoft-edge-stable" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Microsoft Edge" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    # Adicionar o Repositóro
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-stable.list'

    # Atualizar a Lista de Pacotes
    sudo apt update

    # Instalar o Microsoft Edge
    sudo apt install microsoft-edge-stable -y

    # Resolver dependências quebradas
    if ! command -v microsoft-edge-stable &> /dev/null; then
        apt-get install -f
    fi

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
