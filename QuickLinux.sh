#!/bin/bash

# QuickLinux.sh - Executa o menu de instalações de pacotes e outros
# comandos Linux.
#
# URL: https://github.com/systemboys/QuickLinux.git
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de agilizar nas instalações de
# pacotes e comandos Linux.
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-09-30 às 19h30, Marcos Aurélio:
#   - Versão inicial, menu de controle de instalações de pacotes e outros
#     comandos para sistemas Linux.
# v0.0.2 2023-10-01 às 07h30, Marcos Aurélio:
#   - Testes de instalações de pacotes e alguns comandos Linux.
# v0.0.3 2023-10-02 às 21h15, Marcos Aurélio:
#   - Alguns ajustes nas linhas de comandos, para melhorar o entendimento.
# v0.0.4 2023-10-19 às 10h00, Marcos Aurélio:
#   - O menu foi mudado para o modelo de janelas "Dialog", ficando mais elegante.
# v0.0.5 2023-10-24 às 14h15, Marcos Aurélio:
#   - Adicionado uma variável que "Obtém o número da última versão do histórico do script"
# v0.0.6 2023-10-24 às 20h50, Marcos Aurélio:
#   - Correção da instrução na primeira tela do menu, uma palavra errada foi corrigida.
# v0.0.7 2023-10-26 às 00h20, Marcos Aurélio:
#   - Opção para instalar o Docker na sessão "Desenvolvimento" e incrementação de
#     verificação de instalação de pacotes no termino de cada instalação.
# v0.0.8 2023-10-26 às 01h17, Marcos Aurélio:
#   - Opção para instalar o Docker Compose na sessão "Desenvolvimento".
# v0.0.9 2023-10-27 às 14h17, Marcos Aurélio:
#   - Opção para sessão de Utilitários de Termianl.
# v0.1.0 2023-10-27 às 15h40, Marcos Aurélio:
#   - Opção para sessão de Redes.
# v0.1.1 2023-10-27 às 16h20, Marcos Aurélio:
#   - Opção para "Verificar IP" sessão de "Redes".
# v0.1.2 2023-10-27 às 17h00, Marcos Aurélio:
#   - Opção para "Disparar PING" sessão de "Redes".
# v0.1.3 2023-10-27 às 17h15, Marcos Aurélio:
#   - Opção para "Pingar um Domínio" em "Disparar PING" sessão de "Redes".
# v0.1.4 2023-10-27 às 17h22, Marcos Aurélio:
#   - Opção para "Pingar um Domínio forçando IPv4" em "Disparar PING" sessão de "Redes".
# v0.1.5 2023-10-28 às 00h15, Marcos Aurélio:
#   - Adicionada a opção "Traceroute", "traçar rota". Comando para identificar a rota
#     percorrida por um pacote de dados pela rede até a chegada em seu destino.
# v0.1.6 2023-11-01 às 01h10, Marcos Aurélio:
#   - Alterada a opção "Disparar PING" para "Disparar PING / Traçar rota" na sessão "Redes".
# v0.1.7 2023-11-04 às 17h20, Marcos Aurélio:
#   - Adicionada a opção "Informações do Sistema" na sessão "Utilitários do Sistema" para
#     fornecer informações detalhadas sobre o processador e a memória do sistema.
# v0.1.8 2023-11-04 às 22h20, Marcos Aurélio:
#   - Adicionada a opção que permite que o usuário insira comandos no terminal Linux.
#
# Licença: GPL.

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "$0" | tail -n 1)

# Verifica se o script está sendo executado como superusuário
if [ "$EUID" -ne 0 ]; then
    dialog --msgbox 'Este script precisa ser executado como superusuário.' 6 40
    clear
    exit 1
fi

# Verifica se o dialog está instalado
if ! command -v dialog &> /dev/null; then
    echo "Dialog não está instalado. Instalando..."
    sudo apt-get update
    sudo apt-get install -y dialog
fi

# Variáveis úteis
fileName=$(basename "$0")
sessionName="QuickLinux ${lastVersion}"
sessionDescription="Selecione as opções usando (↓ ↑ → ←) e pressione \"Enter\". Pode usar os números ou o clique também:"
developer="$(echo -e "\u00A9") $(date +%Y) - GLOBAL TEC Informática $(echo -e "\u24C7") | www.gti1.com.br"

# Função para executar sessão Menu QuickLinux
Menu_QuickLinux() {
    cd Package_Installers/Menu_QuickLinux
    ./Menu_QuickLinux.sh "$fileName" "$developer"
}

# Função para executar sessão Linux
Linux_Session() {
    cd Package_Installers/Linux_Session
    ./Linux_Session.sh "$fileName" "$developer"
}

# Função para executar sessão Internet
Internet_Session() {
    cd Package_Installers/Internet_Session
    ./Internet_Session.sh "$fileName" "$developer"
}

# Função para executar sessão Desenvolvimento
Development_Session() {
    cd Package_Installers/Development_Session
    ./Development_Session.sh "$fileName" "$developer"
}

# Função para executar sessão Utilitários de Terminal
Terminal_Utilities_Session() {
    cd Package_Installers/Terminal_Utilities_Session
    ./Terminal_Utilities_Session.sh "$fileName" "$developer"
}

# Função para executar sessão Redes
Network_Session() {
    cd Package_Installers/Network_Session
    ./Network_Session.sh "$fileName" "$developer"
}

# função para executar sessão Utilitários do Sistema
System_Utilities_Session() {
    cd Package_Installers/System_Utilities_Session
    ./System_Utilities_Session.sh "$fileName" "$developer"
}

# Menu interativo usando dialog
while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --menu "${sessionDescription}" 15 40 2 \
            1 "Menu QuickLinux" \
            2 "Linux" \
            3 "Internet" \
            4 "Desenvolvimento" \
            5 "Utilitários de Terminal" \
            6 "Redes" \
            7 "Utilitários do Sistema" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        echo "Saindo do menu. Até mais!"
        exit 0
    fi

    case $choice in
        1) # Sessão Menu QuickLinux
            clear
            Menu_QuickLinux
            ;;
        2) # Sessão Linux
            clear
            Linux_Session
            ;;
        3) # Sessão Internet
            clear
            Internet_Session
            ;;
        4) # Sessão Desenvolvimento
            clear
            Development_Session
            ;;
        5) # Sessão de Utilitários de Terminal
            clear
            Terminal_Utilities_Session
            ;;
        6) # Sessão de Redes
            clear
            Network_Session
            ;;
        7) # Sessão Utilitários do Sistema
            clear
            System_Utilities_Session
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
