#!/bin/bash

# System_Utilities_Session.sh - Executa a "Sessão Utilitários do Sistema".
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de facilitar na execução de comandos
# diversos relacionados à utilitários do sistema.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-11-04 às 17h20, Marcos Aurélio:
#   - Versão inicial, adicionada a opção "Informações do Sistema" na sessão
#     "Utilitários do Sistema" para fornecer informações detalhadas sobre o
#     processador e a memória do sistema.
# v1.1.0 2023-12-06 às 18h10, Marcos Aurélio:
#   - Adicionada a opção Sensores de Hardware do Linux.
#
# Licença: GPL.

# Incluindo o GlobalVariables.sh para acessar as variáveis
source ../../GlobalVariables.sh

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "../../QuickLinux.sh" | tail -n 1)

clear

# Resto do script...

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
sessionDescription="Opções de referência a Sessão Utilitários do Sistema."

# Função para Opção Informações do Sistema
System_Information() {
    ./System_Information.sh
}

# Função para Opção Sensores de Hardware do Linux
Linux_Hardware_Sensors() {
    ./Linux_Hardware_Sensors.sh
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "Voltar..." \
            1 "Informações do Sistema" \
            2 "Sensores de Hardware do Linux" \
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
            System_Information
            ;;
        2)
            clear
            Linux_Hardware_Sensors
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
