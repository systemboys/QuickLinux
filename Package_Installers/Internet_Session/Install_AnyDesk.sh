#!/bin/bash

# Verifica se o número de argumentos é correto
if [ "$#" -ne 1 ]; then
    echo "Erro: Número incorreto de argumentos."
    exit 1
fi

# Obtém os valores dos argumentos
fileNameSession="$1"

clear
# Your commands here...
dialog --msgbox "AnyDesk instalado!" 8 40
