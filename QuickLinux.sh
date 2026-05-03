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
# v1.0.0 2023-09-30 às 19h30, Marcos Aurélio:
#   - Versão inicial, menu de controle de instalações de pacotes e outros
#     comandos para sistemas Linux.
# v1.0.1 2023-10-01 às 07h30, Marcos Aurélio:
#   - Testes de instalações de pacotes e alguns comandos Linux.
# v1.0.2 2023-10-02 às 21h15, Marcos Aurélio:
#   - Alguns ajustes nas linhas de comandos, para melhorar o entendimento.
# v2.0.0 2023-10-19 às 10h00, Marcos Aurélio:
#   - O menu foi mudado para o modelo de janelas "Dialog", ficando mais elegante.
# v2.1.0 2023-10-24 às 14h15, Marcos Aurélio:
#   - Adicionado uma variável que "Obtém o número da última versão do histórico do script"
# v2.1.1 2023-10-24 às 20h50, Marcos Aurélio:
#   - Correção da instrução na primeira tela do menu, uma palavra errada foi corrigida.
# v2.2.1 2023-10-26 às 00h20, Marcos Aurélio:
#   - Opção para instalar o Docker na sessão "Desenvolvimento" e incrementação de
#     verificação de instalação de pacotes no termino de cada instalação.
# v2.3.1 2023-10-26 às 01h17, Marcos Aurélio:
#   - Opção para instalar o Docker Compose na sessão "Desenvolvimento".
# v2.4.1 2023-10-27 às 14h17, Marcos Aurélio:
#   - Opção para sessão de Utilitários de Termianl.
# v2.5.1 2023-10-27 às 15h40, Marcos Aurélio:
#   - Opção para sessão de Redes.
# v2.6.1 2023-10-27 às 16h20, Marcos Aurélio:
#   - Opção para "Verificar IP" sessão de "Redes".
# v2.7.1 2023-10-27 às 17h00, Marcos Aurélio:
#   - Opção para "Disparar PING" sessão de "Redes".
# v2.8.1 2023-10-27 às 17h15, Marcos Aurélio:
#   - Opção para "Pingar um Domínio" em "Disparar PING" sessão de "Redes".
# v2.9.1 2023-10-27 às 17h22, Marcos Aurélio:
#   - Opção para "Pingar um Domínio forçando IPv4" em "Disparar PING" sessão de "Redes".
# v2.10.1 2023-10-28 às 00h15, Marcos Aurélio:
#   - Adicionada a opção "Traceroute", "traçar rota". Comando para identificar a rota
#     percorrida por um pacote de dados pela rede até a chegada em seu destino.
# v2.10.2 2023-11-01 às 01h10, Marcos Aurélio:
#   - Alterada a opção "Disparar PING" para "Disparar PING / Traçar rota" na sessão "Redes".
# v2.11.2 2023-11-04 às 17h20, Marcos Aurélio:
#   - Adicionada a opção "Informações do Sistema" na sessão "Utilitários do Sistema" para
#     fornecer informações detalhadas sobre o processador e a memória do sistema.
# v2.12.2 2023-11-04 às 22h20, Marcos Aurélio:
#   - Adicionada a opção que permite que o usuário insira comandos no terminal Linux.
# v2.12.3 2023-11-04 às 23h46, Marcos Aurélio:
#   - Adicionado os caracteres (🚀🐧) no título do QuickLinux.
# v2.12.4 2023-11-06 às 23h00, Marcos Aurélio:
#   - Adicionadas as variáveis globais que estão no arquivo "GlobalVariables.sh".
# v2.12.5 2023-11-07 às 02h00, Marcos Aurélio:
#   - Foi colocado uma verificação na janela "Sobre o QuickLinux" onde compara a versão
#     local com a versão do QuickLinux no repositório no GitHub.
# v2.12.6 2023-11-07 às 22h00, Marcos Aurélio:
#   - Extraindo o Histórico de Versões do QuickLinux e exibindo em "Sobre o QuickLinux"
#     na sessão "Menu QuickLinux."
# v2.12.7 2023-11-08 às 22h00, Marcos Aurélio:
#   - Alteração na exibição de versão disponível.
# v2.12.8 2023-11-08 às 23h25, Marcos Aurélio:
#   - Exibição do local de instalação do QuickLinux.
# v2.13.8 2023-11-09 às 00h45, Marcos Aurélio:
#   - Script que verifica a versão do kernel Linux na sessão Linux.
# v2.13.9 2023-11-09 às 01h28, Marcos Aurélio:
#   - Incrementação do "sudo apt update" junto com o "sudo apt upgrade" -y para atulizar
#     o Kernel Linux".
# v2.13.10 2023-11-10 às 14h10, Marcos Aurélio:
#   - Corrigir pacotes quebrados ou dependências ausentes, opção incrementada na sessão "Linux".
# v2.14.10 2023-11-11 às 00h30, Marcos Aurélio:
#   - Opção "Configuração de IP e interfaces" na sessão "Redes".
# v2.15.10 2023-12-06 às 18h22, Marcos Aurélio:
#   - Adicionada a opção 'Sensores de Hardware do Linux' na sessão 'Utilitários do Sistema'.
# v2.16.10 2025-08-31 às 18h16, Marcos Aurélio:
#   - Versão inicial, Instalar Node.js e NPM (NodeSource).
# v2.16.11 2025-09-01 às 00h20, Marcos Aurélio:
#   - Incrementação da versão do Docker Compose na sessão "Desenvolvimento".
# v2.16.12 2025-09-29 às 17h00, Marcos Aurélio:
#   - Adicionada a opção "Instalar Beekeeper Studio" na sessão "Desenvolvimento".
# v2.16.13 2025-01-25 às 21h49, Marcos Aurélio:
#   - Adicionada a opção "Manutenção automática do sistema" na sessão "Linux".
# v2.16.14 2026-01-08 às 13h30, Marcos Aurélio:
#   - Adicionada a opção "Instalar Docker Desktop" na sessão "Desenvolvimento".
# v2.16.15 2026-03-19 às 23h08, Marcos Aurélio:
#   - Adicionada a opção "Otimizar memória do Linux" na sessão "Linux".
# v2.16.16 2026-04-07 às 21h24, Marcos Aurélio:
#   - Adicionada a opção "Atualizar sistema (seguro, sem kernel)" na sessão "Linux".
# v2.16.17 2026-05-03 às 11h50, Marcos Aurélio:
#   - Ajuste no retorno das sessões para manter selecionado no menu principal o último
#     item acessado.
# v2.17.17 2026-05-03 às 12h25, Marcos Aurélio:
#   - Atualizadas opções de desenvolvimento e adicionada preparação de ambiente para
#     executar o Breeze em VPS.
# v2.17.18 2026-05-03 às 12h40, Marcos Aurélio:
#   - Renomeada a preparação de ambiente da sessão Desenvolvimento para uso genérico
#     em projetos Docker/Node.js locais ou remotos.
# v2.18.18 2026-05-03 às 13h05, Marcos Aurélio:
#   - Adicionadas opções na sessão Desenvolvimento para gerenciar container de testes
#     com acesso ao Docker do host.
# v2.18.19 2026-05-03 às 13h20, Marcos Aurélio:
#   - Adicionados ícones aos itens dos menus para melhorar a navegação visual.
# v2.18.20 2026-05-03 às 13h25, Marcos Aurélio:
#   - Alterado ícone da sessão Desenvolvimento para simbolizar construção.
# Licença: GPL.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "${SCRIPT_DIR}/QuickLinux.sh" | tail -n 1)

# Incluindo o GlobalVariables.sh para acessar as variáveis
source "${SCRIPT_DIR}/GlobalVariables.sh"

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
sessionName="${programName} ${lastVersion}"
sessionDescription="Selecione as opções usando (↓ ↑ → ←) e pressione \"Enter\". Pode usar os números ou o clique também:"

# Função para executar sessão Menu QuickLinux
Menu_QuickLinux() {
    (cd "${SCRIPT_DIR}/Package_Installers/Menu_QuickLinux" && ./Menu_QuickLinux.sh "$fileName" "$developer")
}

# Função para executar sessão Linux
Linux_Session() {
    (cd "${SCRIPT_DIR}/Package_Installers/Linux_Session" && ./Linux_Session.sh "$fileName" "$developer")
}

# Função para executar sessão Internet
Internet_Session() {
    (cd "${SCRIPT_DIR}/Package_Installers/Internet_Session" && ./Internet_Session.sh "$fileName" "$developer")
}

# Função para executar sessão Desenvolvimento
Development_Session() {
    (cd "${SCRIPT_DIR}/Package_Installers/Development_Session" && ./Development_Session.sh "$fileName" "$developer")
}

# Função para executar sessão Utilitários de Terminal
Terminal_Utilities_Session() {
    (cd "${SCRIPT_DIR}/Package_Installers/Terminal_Utilities_Session" && ./Terminal_Utilities_Session.sh "$fileName" "$developer")
}

# Função para executar sessão Redes
Network_Session() {
    (cd "${SCRIPT_DIR}/Package_Installers/Network_Session" && ./Network_Session.sh "$fileName" "$developer")
}

# função para executar sessão Utilitários do Sistema
System_Utilities_Session() {
    (cd "${SCRIPT_DIR}/Package_Installers/System_Utilities_Session" && ./System_Utilities_Session.sh "$fileName" "$developer")
}

# Menu interativo usando dialog
lastChoice=1

while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --default-item "$lastChoice" \
            --menu "${sessionDescription}" 15 40 2 \
            1 "🧭 Menu QuickLinux" \
            2 "🐧 Linux" \
            3 "🌐 Internet" \
            4 "🏗️  Desenvolvimento" \
            5 "⌨️  Utilitários de Terminal" \
            6 "📡 Redes" \
            7 "🖥️  Utilitários do Sistema" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        echo "Saindo do menu. Até mais!"
        exit 0
    fi

    case $choice in
        1) # Sessão Menu QuickLinux
            lastChoice=1
            clear
            Menu_QuickLinux
            ;;
        2) # Sessão Linux
            lastChoice=2
            clear
            Linux_Session
            ;;
        3) # Sessão Internet
            lastChoice=3
            clear
            Internet_Session
            ;;
        4) # Sessão Desenvolvimento
            lastChoice=4
            clear
            Development_Session
            ;;
        5) # Sessão de Utilitários de Terminal
            lastChoice=5
            clear
            Terminal_Utilities_Session
            ;;
        6) # Sessão de Redes
            lastChoice=6
            clear
            Network_Session
            ;;
        7) # Sessão Utilitários do Sistema
            lastChoice=7
            clear
            System_Utilities_Session
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
