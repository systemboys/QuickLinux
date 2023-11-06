#!/bin/bash

# Install.sh - Executa o script que instala o QuickLinux no diretório "/tmp/".
#
# URL: https://github.com/systemboys/QuickLinux
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de executar o script que instala o QuickLinux
# no diretório "/tmp/".
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-11-06 às 18h18, Marcos Aurélio:
#   - Versão inicial, script para instalar o QuickLinux no diretório "/tmp/".
#
# Licença: GPL.

clear

# Verificar se o Git está instalado
if ! command -v git &> /dev/null; then
    echo "O Git não está instalado. Instalando..."
    sudo apt update
    sudo apt install git -y
else
    echo "O Git já está instalado. Ignorando a instalação."
fi

# Processo de clonagem do QuickLinux do repositório no GitHub
echo "Clonando o QuickLinux do repositório no GitHub..."
cd /tmp/ && rm -rf QuickLinux && git clone https://github.com/systemboys/QuickLinux.git && cd QuickLinux && ./QuickLinux.sh

