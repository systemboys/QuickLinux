#!/bin/bash

clear

# Obtém o caminho do arquivo que contém o histórico
historico_file="../../QuickLinux.sh"

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "$historico_file" | tail -n 1)

dialog --msgbox "A última versão registrada no script é: $lastVersion" 8 40