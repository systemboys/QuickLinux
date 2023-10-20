#!/bin/bash

# Verifica se o número de argumentos é correto
if [ "$#" -ne 2 ]; then
    echo "Erro: Número incorreto de argumentos."
    exit 1
fi

# Obtém os valores dos argumentos
fileName="$1"
developer="$2"

# Variáveis úteis
sessionName="Sessão Linux"
sessionDescription="Opções de referência ao Linux."

# Função para sair do script
sair_do_script() {
    clear
    echo "Saindo do menu. Até mais!"
    exit "$1"
}

# Função para atualizar pacotes Linux com barra de progresso
update_packages() {
    (
        # Inicia a atualização em segundo plano e redireciona a saída para um arquivo temporário
        sudo apt-get update > /tmp/apt_progress 2>&1 &
        
        # Obtém o número total de linhas no arquivo temporário
        total_lines=$(wc -l < /tmp/apt_progress)

        # Loop para processar o arquivo temporário e atualizar a barra de progresso
        while true; do
            # Obtém o número atual de linhas no arquivo temporário
            current_lines=$(wc -l < /tmp/apt_progress)
            
            # Calcula o progresso como uma porcentagem
            progress=$(( (current_lines * 100) / total_lines ))

            # Atualiza a barra de progresso
            echo "$progress"
            
            # Aguarda 1 segundo antes de verificar novamente
            sleep 1

            # Sai do loop quando a atualização estiver completa
            [ "$current_lines" -eq "$total_lines" ] && break
        done
    ) | dialog --title "Atualizando Pacotes" --gauge "Aguarde, atualizando pacotes..." 10 70 0

    # Limpa o arquivo temporário
    rm -f /tmp/apt_progress

    # Exibe a mensagem de conclusão
    dialog --msgbox "Pacotes Linux atualizados!" 8 40
}

# Função para atualizar o kernel Linux
update_kernel() {
    sudo apt-get upgrade -y
    dialog --msgbox "Kernel Linux atualizado!" 8 40
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "... Voltar" \
            1 "Atualizar pacotes Linux" \
            2 "Atualizar kernel Linux" \
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
            update_packages
            ;;
        2)
            clear
            update_kernel
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done