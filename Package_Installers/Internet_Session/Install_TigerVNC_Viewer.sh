#!/bin/bash

# System_Information.sh - Instalar o Visualizador TigerVNC no Linux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o Visualizador TigerVNC no Linux.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Instalar o Visualizador TigerVNC no Linux.
#
# Licença: GPL.

clear

# Variáveis úteis
packageName="TigerVNC Viewer" # Apenas o nome do pacote

# Verificar se o Flatpak está instalado
if ! command -v flatpak &> /dev/null; then
    echo "Flatpak não está instalado. Instalando..."
    sudo apt install flatpak
else
    echo "Flatpak já está instalado. Ignorando a instalação."
fi
# Instalar TigerVNC
sudo apt update
flatpak install flathub org.tigervnc.vncviewer
flatpak run org.tigervnc.vncviewer

clear
dialog --msgbox "${packageName} instalado com sucesso!" 8 40
