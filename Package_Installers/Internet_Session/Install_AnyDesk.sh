#!/bin/bash

# System_Information.sh - Instalar o AnyDesk no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o AnyDesk no Linux.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Instalar o AnyDesk no Linux.
#
# Licença: GPL.

clear

# Variáveis úteis
packageVersionName="anydesk" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="AnyDesk" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    # Adicionar a chave GPG
    wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -

    # Adicionar o repositório
    echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list

    # Atualizar os pacotes
    sudo apt update

    # Instalar o AnyDesk
    sudo apt install anydesk -y

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
