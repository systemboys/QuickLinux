#!/bin/bash

# Install.sh - Instala e executa o QuickLinux no diretório "/tmp/".
#
# URL: https://github.com/systemboys/QuickLinux
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa instala o QuickLinux em "/tmp/QuickLinux" quando necessário e
# executa o menu principal.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-11-06 às 18h18, Marcos Aurélio:
#   - Versão inicial, script para instalar o QuickLinux no diretório "/tmp/".
# v1.0.1 2026-05-03 às 16h05, Marcos Aurélio:
#   - Melhorado fluxo de instalação para reaproveitar o repositório local quando
#     ele já existir e validar os arquivos essenciais antes de executar.
#
# Licença: GPL.

set -euo pipefail

repositoryUrl="https://github.com/systemboys/QuickLinux.git"
installBaseDir="/tmp"
installDir="${installBaseDir}/QuickLinux"
mainScript="${installDir}/QuickLinux.sh"
updateMenuScript="${installDir}/Package_Installers/Menu_QuickLinux/Menu_QuickLinux.sh"

clear

run_as_root() {
    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    elif command -v sudo >/dev/null 2>&1; then
        sudo "$@"
    else
        echo "Erro: este comando precisa de privilégios de superusuário e o sudo não está instalado."
        exit 1
    fi
}

ensure_git_installed() {
    if command -v git >/dev/null 2>&1; then
        echo "Git já está instalado."
        return
    fi

    if ! command -v apt-get >/dev/null 2>&1; then
        echo "Erro: Git não está instalado e o apt-get não foi encontrado para instalá-lo."
        exit 1
    fi

    echo "Git não encontrado. Instalando..."
    run_as_root apt-get update
    run_as_root apt-get install -y git
}

quicklinux_is_valid() {
    [ -f "$mainScript" ] && [ -f "$updateMenuScript" ]
}

clone_quicklinux() {
    echo "Clonando QuickLinux em ${installDir}..."
    git clone "$repositoryUrl" "$installDir"
}

prepare_install_dir() {
    mkdir -p "$installBaseDir"

    if [ ! -e "$installDir" ]; then
        clone_quicklinux
        return
    fi

    if quicklinux_is_valid; then
        echo "QuickLinux já existe em ${installDir} e parece estar íntegro."
        return
    fi

    echo "A instalação existente em ${installDir} está incompleta ou inválida."
    echo "Recriando o diretório do QuickLinux..."
    rm -rf "$installDir"
    clone_quicklinux
}

run_quicklinux() {
    if ! quicklinux_is_valid; then
        echo "Erro: instalação inválida."
        echo "Arquivos esperados:"
        echo "- ${mainScript}"
        echo "- ${updateMenuScript}"
        exit 1
    fi

    chmod +x "$mainScript"
    cd "$installDir" || exit 1
    ./QuickLinux.sh
}

ensure_git_installed
prepare_install_dir
run_quicklinux
