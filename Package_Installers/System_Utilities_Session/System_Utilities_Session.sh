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
# v0.0.1 2023-11-04 às 17h20, Marcos Aurélio:
#   - Versão inicial, adicionada a opção "Utilitários do Sistema" na sessão
#     "Utilitários do Sistema" para fornecer informações detalhadas sobre o
#     processador e a memória do sistema.
#
# Licença: GPL.

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
sessionName="Nova Sessão A"
sessionDescription="Opções de referência a Nova Sessão A."

# Função para Opção A
Option_A() {
    # Your commands here...
    dialog --msgbox "Seu comando A foi executado!" 8 40
}

# Função para Opção B
Option_B() {
    # Your commands here...
    dialog --msgbox "Seu comando B foi executado!" 8 40
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "Voltar..." \
            1 "Opção A" \
            2 "Opção B" \
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
            Option_A
            ;;
        2)
            clear
            Option_B
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
