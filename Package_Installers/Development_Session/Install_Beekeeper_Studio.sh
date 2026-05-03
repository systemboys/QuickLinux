#!/bin/bash

# Install_Beekeeper_Studio.sh - Script que Instalar o Beekeeper Studio.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Instalar o Beekeeper Studio.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2025-09-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Instalar o Beekeeper Studio.
# v1.0.1 2026-05-03 às 12h25, Marcos Aurélio:
#   - Ajustada instalação para garantir pré-requisitos do repositório apt oficial.
#
# Licença: GPL.

clear

# Variáveis úteis
packageVersionName="beekeeper-studio" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Beekeeper Studio" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    if ! [ -d "/opt/${packageVersionName}" ]; then
        clear
        dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

        clear

        apt-get update
        apt-get install -y ca-certificates curl gnupg

        # Install our GPG key
        curl -fsSL https://deb.beekeeperstudio.io/beekeeper.key | gpg --dearmor --yes --output /usr/share/keyrings/beekeeper.gpg \
        && chmod go+r /usr/share/keyrings/beekeeper.gpg \
        && echo "deb [signed-by=/usr/share/keyrings/beekeeper.gpg] https://deb.beekeeperstudio.io stable main" \
        | tee /etc/apt/sources.list.d/beekeeper-studio-app.list > /dev/null

        # Update apt and install
        apt-get update && apt-get install beekeeper-studio -y

        clear
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
