#!/bin/bash

# AboutQuickLinux.sh - Executa o que exibe o Sobre o QuickLinux.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de exibir o conteúdo do "Sobre o QuickLinux".
# ---------------------------------------------------------------
# Histórico:
# v0.0.1 2023-11-06 às 23h00, Marcos Aurélio:
#   - Versão inicial, exibindo o conteúdo sobre o QuickLinux.
#
# Licença: GPL.

clear

# Baixa o arquivo do GitHub para o diretório /tmp
curl -sLJO https://github.com/systemboys/QuickLinux/blob/main/QuickLinux.sh -o /tmp/QuickLinux.sh

# Obtém a versão do arquivo local
lastLocalVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "/tmp/QuickLinux/QuickLinux.sh" | tail -n 1)

# Obtém a versão do arquivo do GitHub
lastGitHubVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "/tmp/QuickLinux.sh" | tail -n 1)

# Exibe as saídas para diagnóstico
echo "Versão local: $lastLocalVersion"
echo "Versão no GitHub: $lastGitHubVersion"

# Exibe as versões em uma caixa de mensagem usando dialog
dialog --msgbox "Versão local: $lastLocalVersion | Versão no GitHub: $lastGitHubVersion" 10 60



# dialog --msgbox "Sobre o QuickLinux

# **Sobre o QuickLinux: $lastLocalVersion >>> $lastGitHubVersion <<<**

# Bem-vindo ao QuickLinux, sua ferramenta interativa definitiva para simplificar sua jornada no mundo do Linux. Projetado para tornar as operações diárias no Linux rápidas, fáceis e acessíveis, o QuickLinux é seu parceiro confiável para tarefas essenciais no terminal.

# **O Que o QuickLinux Oferece:**

# - **Atualização e Manutenção Simples:** Atualize seus pacotes com um clique. Mantenha seu sistema funcionando sem complicações.
  
# - **Navegação Rápida:** Instale navegadores populares como Google Chrome, Mozilla Firefox e outros com facilidade para uma experiência de navegação suave.
  
# - **Ferramentas de Desenvolvimento:** Implemente rapidamente ambientes de desenvolvimento com Docker e Docker Compose. Ganhe eficiência em seu fluxo de trabalho de desenvolvimento.
  
# - **Controle de Rede:** Verifique seu IP, faça testes de ping e trace rotas para diagnosticar problemas de rede sem complicações.
  
# - **Exploração do Sistema:** Obtenha informações detalhadas sobre seu processador e memória, compreendendo melhor o funcionamento interno do seu sistema.
  
# - **Facilidade em um Cenário Terminal:** Execute comandos complexos com um clique, economizando seu tempo e esforço.
  
# - **Flexibilidade e Personalização:** Selecione e personalize suas instalações de acordo com suas necessidades específicas.

# O QuickLinux foi projetado para fazer com que você se sinta em casa no Linux, mesmo se você for um iniciante ou um usuário experiente. Simplifique sua experiência no Linux, reduzindo o tempo gasto em comandos complexos e focando no que realmente importa: seu trabalho, seu projeto e sua criatividade. Experimente a facilidade do QuickLinux agora mesmo!" 16 80