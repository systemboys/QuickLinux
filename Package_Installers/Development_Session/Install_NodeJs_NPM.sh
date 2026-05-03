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
# v1.0.1 2026-05-03 às 12h25, Marcos Aurélio:
#   - Atualizada instalação para Node.js 24 LTS via NodeSource.
#
# Licença: GPL.

clear

# Variáveis úteis
packageName="Node.js e NPM"
nodeMajorVersion="24"

# Função para verificar se um comando existe
command_exists() {
    command -v "$1" &> /dev/null
}

installedNodeMajor=""
if command_exists node; then
    installedNodeMajor=$(node -v | sed 's/^v//' | cut -d. -f1)
fi

# Verifica se Node.js e NPM já estão instalados na versão alvo
if command_exists node && command_exists npm && [ "$installedNodeMajor" -ge "$nodeMajorVersion" ] 2>/dev/null; then
    clear
    dialog --msgbox "${packageName} já estão instalados! Ignorando a instalação..." 8 50
else
    clear
    dialog --msgbox "${packageName} não estão instalados! Instalando Node.js ${nodeMajorVersion}.x LTS via NodeSource..." 8 60

    clear

    # Instala dependências
    apt-get update
    apt-get install -y ca-certificates curl gnupg build-essential

    # Adiciona o repositório oficial do Node.js LTS
    curl -fsSL "https://deb.nodesource.com/setup_${nodeMajorVersion}.x" -o /tmp/nodesource_setup.sh
    bash /tmp/nodesource_setup.sh

    # Instala ou atualiza Node.js + NPM
    apt-get install -y nodejs

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
