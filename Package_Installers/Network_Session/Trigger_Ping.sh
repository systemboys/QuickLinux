#!/bin/bash

# Função para realizar o ping e mostrar o resultado em uma janela de mensagem
pingDomain() {
    # Solicita ao usuário que insira o domínio usando o dialog
    domain=$(dialog --inputbox 'Digite o domínio:' 8 40 3>&1 1>&2 2>&3)

    # Verifica se o campo de domínio está vazio
    if [ -z "$domain" ]; then
        dialog --msgbox "O domínio não pode estar vazio. Por favor, tente novamente." 8 40
        return
    fi

    # Pinga o domínio e armazena o resultado
    ping_result=$(ping -c 5 "$domain")

    # Exibe o resultado em uma janela de mensagem usando dialog
    dialog --title "Resultado do Ping para $domain" --msgbox "$ping_result" 20 100
}

# Inicia o loop para o menu interativo usando dialog
while true; do
    # Mostra um menu para escolher entre pingar um domínio ou sair
    choice=$(dialog --clear --backtitle "Ping Tool" \
            --menu "Escolha uma opção:" 10 40 2 \
            1 "Pingar um Domínio" \
            2 "Sair..." \
            2>&1 >/dev/tty)

    # Verifica a escolha do usuário
    case "$choice" in
        1)
            # Chama a função para pingar um domínio
            pingDomain
            ;;
        2)
            # Sai do script se o usuário escolher sair
            clear
            exit 0
            ;;
    esac
done
