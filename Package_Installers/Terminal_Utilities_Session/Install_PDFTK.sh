#!/bin/bash

# Install_PDFTK.sh - Instalar o PDFTK no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de instalar o PDFTK para manipular arquivos
# PDF pelo terminal.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2026-05-03 às 17h05, Marcos Aurélio:
#   - Versão inicial, Instalar o PDFTK no Linux.
#
# Licença: GPL.

clear

packageVersionName="pdftk"
packageName="PDFTK"

if ! command -v ${packageVersionName} >/dev/null 2>&1; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 50

    clear

    sudo apt-get update

    if ! sudo apt-get install -y pdftk; then
        sudo apt-get install -y pdftk-java
    fi

    clear

    if ! command -v ${packageVersionName} >/dev/null 2>&1; then
        dialog --msgbox "Erro na instalação de ${packageName}!" 8 45
    else
        pdftkVersion=$(pdftk --version | head -n 1)
        dialog --msgbox "${packageName} instalado com sucesso!\n\n${pdftkVersion}" 10 70
    fi
else
    clear
    pdftkVersion=$(pdftk --version | head -n 1)
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação...\n\n${pdftkVersion}" 10 70
fi
