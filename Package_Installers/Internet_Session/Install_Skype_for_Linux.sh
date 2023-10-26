#!/bin/bash

clear

# Variáveis úteis
packageVersionName="skypeforlinux" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Skype para Linux" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    # Atualizar os pacotes
    apt update

    # Instalar o pacote SkypeForLinux
    apt install skypeforlinux

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
