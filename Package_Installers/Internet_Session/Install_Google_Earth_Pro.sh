#!/bin/bash

# System_Information.sh - Instalar o Google Earth Pro no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o Google Earth Pro no Linux.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Instalar o Google Earth Pro no Linux.
#
# Licença: GPL.

clear

# Variáveis úteis
packageVersionName="google-earth-pro-stable" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Google Earth Pro" # Apenas o nome do pacote

# Verificar se o está instalado
if ! [ -x "$(command -v google-earth-pro)" ]; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    # Baixar o pacote
    wget https://dl.google.com/dl/earth/client/current/google-earth-pro-stable_current_amd64.deb

    # Instalar o pacote
    sudo dpkg -i google-earth-pro-stable_current_amd64.deb

    # Dar permissões e apagar o arquivo
    chmod 777 google-earth-pro-stable_current_amd64.deb && rm -r google-earth-pro-stable_current_amd64.deb

    clear
    
    if ! [ -x "$(command -v google-earth-pro)" ]; then
        dialog --msgbox "Erro na instalação de ${packageName}!" 8 40
    else
        dialog --msgbox "${packageName} instalado com sucesso!" 8 40
    fi
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi
