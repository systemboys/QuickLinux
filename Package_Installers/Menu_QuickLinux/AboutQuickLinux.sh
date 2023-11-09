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
# v0.0.2 2023-11-08 às 22h00, Marcos Aurélio:
#   - Alteração na exibição de versão disponível.
# v0.0.3 2023-11-08 às 23h25, Marcos Aurélio:
#   - Exibição do local de instalação do QuickLinux.
#
# Licença: GPL.

clear

# ---ÚLTIMAS VERSÕES---
# Obtém o número da última versão do histórico do script local
lastLocalVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "../../QuickLinux.sh" | tail -n 1)

# Obtém o número da última versão do histórico do script no GitHub
lastGitHubVersion=$(curl -s https://github.com/systemboys/QuickLinux/blob/main/QuickLinux.sh | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | tail -n 1)

# Obtém o histórico de versões entre # Histórico: e # Licença: GPL
versionHistory=$(sed -n '/# Histórico:/,/# Licença: GPL/p' ../../QuickLinux.sh)

# Comparar as duas variáveis
if [ "$lastLocalVersion" != "$lastGitHubVersion" ]; then
  versionMessage="Há uma atualização disponível para o seu QuiskLinux!
Versão disponível: $lastGitHubVersion
Versão atual: $lastLocalVersion"
else
  versionMessage="Seu QuickLinux está atualizado!
Versão atual: $lastLocalVersion"
fi
# ---/ÚLTIMAS VERSÕES---

# ---LOCAL DE INSTALAÇÃO---
# Caminho absoluto do arquivo
fileName="../../QuickLinux.sh"

# Obtém o diretório atual onde o script está sendo executado
current_dir=$(dirname "$fileName")

# Obtém o caminho completo do arquivo
file_path=$(realpath "$current_dir")
# ---/LOCAL DE INSTALAÇÃO---

dialog --msgbox "Sobre o QuickLinux

**Sobre o QuickLinux<<<**

$versionMessage

Bem-vindo ao QuickLinux, sua ferramenta interativa definitiva para simplificar sua jornada no mundo do Linux. Projetado para tornar as operações diárias no Linux rápidas, fáceis e acessíveis, o QuickLinux é seu parceiro confiável para tarefas essenciais no terminal.

**O Que o QuickLinux Oferece:**

Local de instalação: $file_path

- **Atualização e Manutenção Simples:** Atualize seus pacotes com um clique. Mantenha seu sistema funcionando sem complicações.
  
- **Navegação Rápida:** Instale navegadores populares como Google Chrome, Mozilla Firefox e outros com facilidade para uma experiência de navegação suave.
  
- **Ferramentas de Desenvolvimento:** Implemente rapidamente ambientes de desenvolvimento com Docker e Docker Compose. Ganhe eficiência em seu fluxo de trabalho de desenvolvimento.
  
- **Controle de Rede:** Verifique seu IP, faça testes de ping e trace rotas para diagnosticar problemas de rede sem complicações.
  
- **Exploração do Sistema:** Obtenha informações detalhadas sobre seu processador e memória, compreendendo melhor o funcionamento interno do seu sistema.
  
- **Facilidade em um Cenário Terminal:** Execute comandos complexos com um clique, economizando seu tempo e esforço.
  
- **Flexibilidade e Personalização:** Selecione e personalize suas instalações de acordo com suas necessidades específicas.

# O QuickLinux foi projetado para fazer com que você se sinta em casa no Linux, mesmo se você for um iniciante ou um usuário experiente. Simplifique sua experiência no Linux, reduzindo o tempo gasto em comandos complexos e focando no que realmente importa: seu trabalho, seu projeto e sua criatividade. Experimente a facilidade do QuickLinux agora mesmo!

** Histórico de versões **

$versionHistory" 20 95

