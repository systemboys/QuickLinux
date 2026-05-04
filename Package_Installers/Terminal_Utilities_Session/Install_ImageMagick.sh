#!/bin/bash

# Install_ImageMagick.sh - Instalar o ImageMagick no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de instalar o ImageMagick para converter e
# manipular imagens pelo terminal.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2026-05-03 às 17h15, Marcos Aurélio:
#   - Versão inicial, Instalar o ImageMagick no Linux.
#
# Licença: GPL.

clear

packageVersionName="magick"
fallbackCommandName="convert"
packageName="ImageMagick"

imagemagick_is_installed() {
    command -v "$packageVersionName" >/dev/null 2>&1 || command -v "$fallbackCommandName" >/dev/null 2>&1
}

imagemagick_version() {
    if command -v "$packageVersionName" >/dev/null 2>&1; then
        magick --version | head -n 1
    else
        convert --version | head -n 1
    fi
}

if ! imagemagick_is_installed; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 55

    clear

    sudo apt-get update
    sudo apt-get install -y imagemagick

    clear

    if ! imagemagick_is_installed; then
        dialog --msgbox "Erro na instalação de ${packageName}!" 8 45
    else
        imageMagickVersion=$(imagemagick_version)
        dialog --msgbox "${packageName} instalado com sucesso!\n\n${imageMagickVersion}" 10 70
    fi
else
    clear
    imageMagickVersion=$(imagemagick_version)
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação...\n\n${imageMagickVersion}" 10 70
fi
