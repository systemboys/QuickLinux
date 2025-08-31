#!/bin/bash

# System_Information.sh - Opções relacionadas à redes.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de Opções relacionadas à redes.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-10-29 às 17h00, Marcos Aurélio:
#   - Versão inicial, Opções relacionadas à redes.
#
# Licença: GPL.

# Incluindo o GlobalVariables.sh para acessar as variáveis
source ../../GlobalVariables.sh

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "../../QuickLinux.sh" | tail -n 1)

# Verifica se o número de argumentos é correto
if [ "$#" -ne 2 ]; then
    echo "Erro: Número incorreto de argumentos."
    exit 1
fi

# Obtém os valores dos argumentos
fileName="$1"
developer="$2"

# Variáveis úteis
sessionName="${programName} ${lastVersion}"
sessionDescription="Opções de referência a Redes."

# Função para verificar o IP
Check_IP() {
    ./Check_IP.sh
}

# Função para disparar um PING
Trigger_Ping() {
    ./Trigger_Ping.sh
}

# Configuração de IP e interfaces
IPConfigurationAndInterfaces() {
    ./IPConfigurationAndInterfaces.sh
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 12 40 2 \
            0 "Voltar..." \
            1 "Verificar IP" \
            2 "Disparar PING / Traçar rota" \
            3 "Configuração de IP e interfaces" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        cd ../..
        ./${fileName}
    fi

    case $choice in
        0)
            clear
            cd ../..
            ./${fileName}
            ;;
        1)
            clear
            Check_IP
            ;;
        2)
            clear
            Trigger_Ping
            ;;
        3)
            clear
            IPConfigurationAndInterfaces
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done