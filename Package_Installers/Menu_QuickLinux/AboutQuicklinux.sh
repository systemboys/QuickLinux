#!/bin/bash

clear

# Obtém o caminho do arquivo que contém o histórico
fileHistory="../../QuickLinux.sh"

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "$fileHistory" | tail -n 1)

dialog --msgbox "Sobre o QuickLinux

**Sobre o QuickLinux: $lastVersion**

Bem-vindo ao QuickLinux, sua ferramenta interativa definitiva para simplificar sua jornada no mundo do Linux. Projetado para tornar as operações diárias no Linux rápidas, fáceis e acessíveis, o QuickLinux é seu parceiro confiável para tarefas essenciais no terminal.

**O Que o QuickLinux Oferece:**

- **Atualização e Manutenção Simples:** Atualize seus pacotes com um clique. Mantenha seu sistema funcionando sem complicações.
  
- **Navegação Rápida:** Instale navegadores populares como Google Chrome, Mozilla Firefox e outros com facilidade para uma experiência de navegação suave.
  
- **Ferramentas de Desenvolvimento:** Implemente rapidamente ambientes de desenvolvimento com Docker e Docker Compose. Ganhe eficiência em seu fluxo de trabalho de desenvolvimento.
  
- **Controle de Rede:** Verifique seu IP, faça testes de ping e trace rotas para diagnosticar problemas de rede sem complicações.
  
- **Exploração do Sistema:** Obtenha informações detalhadas sobre seu processador e memória, compreendendo melhor o funcionamento interno do seu sistema.
  
- **Facilidade em um Cenário Terminal:** Execute comandos complexos com um clique, economizando seu tempo e esforço.
  
- **Flexibilidade e Personalização:** Selecione e personalize suas instalações de acordo com suas necessidades específicas.

O QuickLinux foi projetado para fazer com que você se sinta em casa no Linux, mesmo se você for um iniciante ou um usuário experiente. Simplifique sua experiência no Linux, reduzindo o tempo gasto em comandos complexos e focando no que realmente importa: seu trabalho, seu projeto e sua criatividade. Experimente a facilidade do QuickLinux agora mesmo!" 16 80