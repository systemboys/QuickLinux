#!/bin/bash

# install_NodeJs_NPM.sh - Script que Instalar Node.js e NPM (NodeSource).
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar Node.js e NPM (NodeSource).
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2025-08-31 às 18h16, Marcos Aurélio:
#   - Versão inicial, Instalar Node.js e NPM (NodeSource).
#
# Licença: GPL.

clear

# Variáveis úteis
packageName="Node.js e NPM"

# Função para verificar se um comando existe
command_exists() {
    command -v "$1" &> /dev/null
}

# Verifica se Node.js e NPM já estão instalados
if command_exists node && command_exists npm; then
    clear
    dialog --msgbox "${packageName} já estão instalados! Ignorando a instalação..." 8 50
else
    clear
    dialog --msgbox "${packageName} não estão instalados! Instalando a versão mais recente via NodeSource..." 8 50

    clear

    # Instala dependências
    sudo apt update
    sudo apt install -y curl

    # Adiciona o repositório oficial do Node.js (exemplo: versão 20 LTS)
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

    # Instala Node.js + NPM
    sudo apt install -y nodejs

    clear

    # Valida a instalação
    if command_exists node && command_exists npm; then
        node_version=$(node -v)
        npm_version=$(npm -v)
        dialog --msgbox "${packageName} instalados com sucesso!\n\nNode.js: $node_version\nNPM: $npm_version" 10 50
    else
        dialog --msgbox "Erro na instalação de ${packageName}!" 8 50
    fi
fi