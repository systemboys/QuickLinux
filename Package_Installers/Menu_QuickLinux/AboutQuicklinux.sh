#!/bin/bash

clear

# Obtém o caminho do arquivo que contém o histórico
fileHistory="../../QuickLinux.sh"

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "$fileHistory" | tail -n 1)

dialog --msgbox "Sobre o QuickLinux

QuickLinux: $lastVersion

Bem-vindo ao QuickLinux, sua ferramenta interativa definitiva para simplificar sua jornada no mundo do Linux. Projetado para tornar as operações diárias no Linux rápidas, fáceis e acessíveis, o QuickLinux é seu parceiro confiável para tarefas essenciais no terminal.

O QuickLinux foi projetado para fazer com que você se sinta em casa no Linux, mesmo se você for um iniciante ou um usuário experiente. Simplifique sua experiência no Linux, reduzindo o tempo gasto em comandos complexos e focando no que realmente importa: seu trabalho, seu projeto e sua criatividade. Experimente a facilidade do QuickLinux agora mesmo!

O QuickLinux é desenvolvido pela GLOBAL TEC Informática, uma empresa que trabalha no ramo de informática desde 2008." 8 40