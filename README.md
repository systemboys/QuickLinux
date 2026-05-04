# **Bem-vindo ao  QuickLinux!**

> **( ! )** Esse menu ainda está em desenvolvimento!

![Menu de instalações de pacotes Linux](./Images/QuickLinux.png?raw=true "Menu de instalações de pacotes Linux")

QuickLinux: Facilite a vida no Linux com um menu interativo. Instale pacotes, atualize o sistema e execute comandos essenciais com apenas alguns cliques. Simplifique sua experiência no Linux.

**Recursos Principais:**

1. **Instalação Descomplicada:** Esqueça os comandos complexos e a pesquisa por tutoriais. Nosso menu oferece opções simples e diretas para instalar programas populares com seleção via setas direcionais ou cliques.

2. **Variedade de Pacotes:** Desde navegadores populares como Google Chrome e Mozilla Firefox até ferramentas de desenvolvimento como Docker, Docker Compose, Node.js e Beekeeper Studio, o menu cobre uma ampla gama de necessidades.

3. **Configurações Pré-Definidas:** Além de instalar pacotes, o menu também oferece opções para configurações pré-definidas, economizando tempo e esforço dos usuários.

4. **Documentação Clara:** Cada comando é acompanhado por documentação clara e instruções detalhadas. Não importa se você é um iniciante ou um usuário avançado, você encontrará orientações claras para cada passo.

5. **Comunidade Ativa:** Faça parte de nossa comunidade crescente de usuários. Compartilhe suas experiências, faça perguntas e contribua para melhorias contínuas.

**Como Usar:**

1. **Instalação Recomendada:** Execute o instalador direto pelo terminal. Ele verifica se o `Git` está instalado, instala se necessário, usa `/tmp/QuickLinux` como diretório padrão, reaproveita a instalação quando ela já está íntegra e recria o diretório apenas se os arquivos essenciais não existirem.

   ```bash
   bash -c "$(curl -fsSL https://github.com/systemboys/QuickLinux/raw/main/Install.sh)"
   ```

   O instalador valida estes arquivos antes de executar o QuickLinux:

   ```tex
   /tmp/QuickLinux/QuickLinux.sh
   /tmp/QuickLinux/Package_Installers/Menu_QuickLinux/Menu_QuickLinux.sh
   ```

2. **Instalação Manual:** Se preferir, clone o repositório do GitHub para ter acesso ao **_QuickLinux_**.

   ```
   git clone https://github.com/systemboys/QuickLinux.git
   ```

3. **Navegue e Execute:** Navegue até o diretório do menu e execute os comandos diretamente do terminal. É tão simples quanto isso!

   ```
   cd QuickLinux
   ./QuickLinux.sh
   ```

   > Você também pode executar o seguinte comando no terminal Linux. Obs.: **( ! )** Certifique-se de que o `Git` esteja instalado:
   
   ```bash
   cd /tmp
   if [ ! -d QuickLinux ]; then
       git clone https://github.com/systemboys/QuickLinux.git
   fi
   cd QuickLinux
   ./QuickLinux.sh
   ```

4. **Explore e Instale:** Explore as categorias, escolha os pacotes que deseja instalar e siga as instruções. Em poucos instantes, você terá os programas desejados em seu sistema Linux.

> **Nota:** os menus preservam a última opção executada. Ao concluir uma ação e fechar a mensagem com "Aceitar", a sessão volta com o mesmo item selecionado.

**Comportamento Atual:**

- A opção **Atualizar pacotes Linux** atualiza a lista de pacotes com `apt-get update` e evita uma nova consulta quando a lista já foi atualizada há menos de 1 hora.
- A opção **Atualizar sistema (seguro, sem kernel)** protege os pacotes de kernel com `apt-mark hold`, atualiza a lista de pacotes quando necessário, conta os pacotes atualizáveis e só executa o upgrade quando houver atualizações disponíveis.
- Os instaladores Docker usam o repositório apt oficial do Docker para Debian/Ubuntu e removem a fonte legada `/etc/apt/sources.list.d/docker.list` antes de configurar `/etc/apt/sources.list.d/docker.sources`, evitando conflito de `Signed-By`.
- O instalador `Install.sh` reaproveita `/tmp/QuickLinux` quando a instalação já possui os arquivos essenciais e só clona novamente quando o diretório não existe ou está incompleto.
- Ao abrir o QuickLinux, é possível escolher entre executar **com ícones** ou **sem ícones**. Essa escolha evita caracteres quebrados em distribuições/fontes que não exibem emojis corretamente.

**Contribua e Compartilhe:**

Este menu é um projeto de código aberto, e encorajamos contribuições da comunidade. Sinta-se à vontade para abrir problemas, enviar solicitações de pull e ajudar a melhorar esta ferramenta para todos.

Com o QuickLinux, queremos tornar a experiência de instalação de software no Linux tão simples e acessível quanto possível. Esperamos que você aproveite usar o menu tanto quanto nós gostamos de criá-lo!

*Divirta-se instalando, configurando e explorando no Linux!* 🚀🐧

> Marcos Aurélio Rocha da Silva | [https://www.gti1.com.br](https://www.gti1.com.br "Site em desenvolvimento") | systemboys@hotmail.com

---

## Estrutura de arquivos

Este menu contém scripts de instalação de pacotes de software dentro do diretório "/QuickLinux/". Estão armazenados vários arquivos `.sh`. Veja a estrutura de arquivos:

```tex
/QuickLinux/
├─ /Images/
│  └─ QuickLinux.png
├─ /Package_Installers/
│  ├─ /Development_Session/
│  │  ├─ Development_Session.sh
│  │  ├─ Development_Test_Container.sh
│  │  ├─ Install_Beekeeper_Studio.sh
│  │  ├─ Install_Docker_Compose.sh
│  │  ├─ Install_Docker_Desktop.sh
│  │  ├─ Install_Docker.sh
│  │  ├─ Install_NodeJs_NPM.sh
│  │  └─ Prepare_Development_Environment.sh
│  ├─ /Internet_Session/
│  │  ├─ Install_AnyDesk.sh
│  │  ├─ Install_Discord.sh
│  │  ├─ Install_FileZilla.sh
│  │  ├─ Install_Google_Chrome.sh
│  │  ├─ Install_Google_Earth_Pro.sh
│  │  ├─ Install_Microsoft_Edge.sh
│  │  ├─ Install_Mozilla_Firefox.sh
│  │  ├─ Install_Opera.sh
│  │  ├─ Install_Remmina.sh
│  │  ├─ Install_Skype_for_Linux.sh
│  │  ├─ Install_TigerVNC_Viewer.sh
│  │  └─ Internet_Session.sh
│  ├─ /Linux_Session/
│  │  ├─ FixBrokenPackages.sh
│  │  ├─ LinuxKernelVersion.sh
│  │  ├─ Linux_Session.sh
│  │  ├─ ManutencaoSistema.sh
│  │  ├─ OtimizarMemoria.sh
│  │  └─ RunCommandsInTerminal.sh
│  ├─ /Menu_QuickLinux/
│  │  ├─ AboutQuickLinux.sh
│  │  └─ Menu_QuickLinux.sh
│  ├─ /Network_Session/
│  │  ├─ Check_IP.sh
│  │  ├─ IPConfigurationAndInterfaces.sh
│  │  ├─ Network_Session.sh
│  │  └─ Trigger_Ping.sh
│  ├─ /System_Utilities_Session/
│  │  ├─ Linux_Hardware_Sensors.sh
│  │  ├─ System_Information.sh
│  │  └─ System_Utilities_Session.sh
│  └─ /Terminal_Utilities_Session/
│     ├─ Install_ImageMagick.sh
│     ├─ Install_PDFTK.sh
│     ├─ Install_Links2_browser.sh
│     ├─ Install_Lynx_browser.sh
│     └─ Terminal_Utilities_Session.sh
├─ GlobalVariables.sh
├─ Install.sh
├─ QuickLinux.sh
└─ README.md
```

Dentro do diretório "Package_Installers", você pode ter vários `arquivos.sh`, cada um responsável por instalar um pacote de software específico. Isso torna a estrutura do seu projeto organizada e fácil de entender.

### Todas as opções do QuickLinux

Aqui estão todas as opções em desenvolvimento.

- [x] **Menu QuickLinux**
  - [x] Voltar...
  - [x] Atualizar QuickLinux
  - [x] Deletar QuickLinux
  - [x] Recarregar QuickLinux
  - [x] Sobre o QuickLinux
  - [x] Alternar ícones
- [x] **Linux**
  - [x] Voltar...
  - [x] Atualizar pacotes Linux
  - [x] Atualizar sistema (seguro, sem kernel)
  - [x] Reiniciar o Linux
  - [x] Desligar o Linux
  - [x] Senha do usuário root
  - [x] Executar comandos no terminal
  - [x] Versão do kernel Linux
  - [x] Corrigir pacotes ou dependências
  - [x] Manutenção automática do sistema
  - [x] Otimizar memória do Linux
- [x] **Internet**
  - [x] Voltar...
  - [x] Instalar AnyDesk
  - [x] Instalar Microsoft Edge
  - [x] Instalar Google Chrome
  - [x] Instalar Google Earth Pro
  - [x] Instalar Skype para Linux
  - [x] Instalar Remmina
  - [x] Instalar Opera
  - [x] Instalar FileZilla
  - [x] Instalar Discord
  - [x] Instalar Mozilla Firefox
  - [x] Instalar TigerVNC Viewer
- [x] **Desenvolvimento**
  - [x] Voltar...
  - [x] Instalar Docker
  - [x] Instalar Docker Compose
  - [x] Instalar Docker Desktop
  - [x] Instalar Node.js e NPM (NodeSource)
  - [x] Instalar Beekeeper Studio
  - [x] Preparar ambiente de desenvolvimento
  - [x] Criar container de testes
  - [x] Acessar container de testes
  - [x] Parar container de testes
  - [x] Remover container de testes
- [x] **Utilitários de Terminal**
  - [x] Voltar...
  - [x] Instalar navegador Links2
  - [x] Instalar navegador Lynx
  - [x] Instalar PDFTK
  - [x] Instalar ImageMagick
- [x] **Redes**
  - [x] Voltar...
  - [x] Verificar IP
  - [x] **Disparar PING / Traçar rota**
    - [x] Voltar...
    - [x] Pingar um Domínio
    - [x] Pingar um Domínio forçando IPv4
    - [x] Traçar rota percorrida
  - [x] **Configuração de IP e interfaces**
    - [x] Voltar...
    - [x] Obter as interfaces de rede
    - [x] Obter IP das interfaces de rede
    - [x] Configurar interface de rede
- [x] **Utilitários do Sistema**
  - [x] Voltar...
  - [x] Informações do Sistema
  - [x] Sensores de Hardware do Linux

---

# Rascunho para novos itens

Aqui você pode editar o arquivo caso necessário, adicionando mais recursos.

## Incrementações de itens

Para adicionar uma nova sessão, crie um diretório com o nome da sua nova sessão (Ex.: `/New_Session_A/`), dentro do diretório `/Package_Installers/` e dentro do diretório de sua nova sessão crie o arquivo `.sh` (Ex.: `New_Session_A.sh`) e segue abaixo seu conteúdo:

```bash
#!/bin/bash

# Option_A.sh - Script que xxx.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de xxx.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-12-06 às 17h50, Marcos Aurélio:
#   - Versão inicial, xxx.
#
# Licença: GPL.

# Incluindo o GlobalVariables.sh para acessar as variáveis
source ../../GlobalVariables.sh

# Obtém o número da última versão do histórico do script
lastVersion=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "../../QuickLinux.sh" | tail -n 1)

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
lastChoice=0

while true; do
    choice=$(dialog --clear --backtitle "${sessionName} | ${developer}" \
            --title "${sessionName}" \
            --default-item "$lastChoice" \
            --menu "${sessionDescription}" 15 40 2 \
            0 "$(ql_label "↩️" "Voltar...")" \
            1 "$(ql_label "▶️" "Opção A")" \
            2 "$(ql_label "▶️" "Opção B")" \
            2>&1 >/dev/tty)

    # Se o usuário pressionar Cancelar, sair do loop
    if [ $? -ne 0 ]; then
        clear
        exit 0
    fi

    case $choice in
        0)
            clear
            exit 0
            ;;
        1)
            lastChoice=1
            clear
            Option_A
            ;;
        2)
            lastChoice=2
            clear
            Option_B
            ;;
        *)
            dialog --msgbox "Opção inválida. Tente novamente." 8 40
            ;;
    esac
done
```

Para chamar sua nova sessão a partir do menu inicial, adicione a função que executa a mesma:

```bash
# ... (outras funções)

# Função para executar sessão Internet
New_Session_A() {
    (cd "${SCRIPT_DIR}/Package_Installers/New_Session_A" && ./New_Session_A.sh "$fileName" "$developer")
}

# ... (restante do código)
```

Dê a opção no menu:

```bash
# ... (outras opções)
3 "New_Session_A" \
# ... (restante do código)
```

Depois coloque a posição da chamada da função na **_case_**:

```bash
# ... (restante do código)
3) # Sessão New_Session_A
    lastChoice=3
    clear
    New_Session_A
    ;;
# ... (restante do código)
```

Para separar os scripts de execuções de comandos em cada opção da nova sessão, você pode criar um arquivo (`Option_A.sh`) para cada opção dentro do diretório da nova sessão `/New_Session_A/`, no arquivo `New_Session_A.sh` da sua nova função.

Altere o conteúdo da função:

```bash
# Função para Opção A
Option_A() {
    # Your commands here...
    dialog --msgbox "Seu comando A foi executado!" 8 40
}
```

Para:

```bash
# Função para Opção A
Option_A() {
    ./Option_A.sh
}
```

E dentro do arquivo `Option_A.sh` o seguinte conteúdo:

```bash
#!/bin/bash

# Option_A.sh - Script que xxx.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de xxx.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-12-06 às 17h50, Marcos Aurélio:
#   - Versão inicial, xxx.
#
# Licença: GPL.

clear

# Your commands here...

dialog --msgbox "Seu comando A foi executado!" 8 40
```

Caso você queira verificar se determinado pacote está instalado e ignorar a instalação, ou avançar na instalação caso não esteja instalado, o código acima pode ser alterado para o seguinte:

```bash
#!/bin/bash

# Option_A.sh - Script que xxx.
#
# Autor: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
# Manutenção: Marcos Aurélio R. da Silva <systemboys@hotmail.com>
#
# ---------------------------------------------------------------
# Este programa tem a finalidade de xxx.
# ---------------------------------------------------------------
# Histórico:
# v1.0.0 2023-12-06 às 17h50, Marcos Aurélio:
#   - Versão inicial, xxx.
#
# Licença: GPL.

clear

# Variáveis úteis
packageVersionName="filezilla" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="FileZilla" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    clear
    dialog --msgbox "${packageName} não está instalado! Instalando..." 8 40

    clear

    sudo apt-get update
    sudo apt-get install filezilla -y

    clear
    
    if ! command -v ${packageVersionName} &> /dev/null; then
        dialog --msgbox "Erro na instalação de ${packageName}!" 8 40
    else
        dialog --msgbox "${packageName} instalado com sucesso!" 8 40
    fi
else
    clear
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi
```

Após criar o arquivo `Option_A.sh`, não esqueça de dar permissão de execução com o comando para garantir sua funcionalidade:

```bash
chmod +x Option_A.sh
```

> **_( i )_** No exemplo acima, o pacote é o "FileZilla". O script verifica se está instalado para ignorar a instalação caso esteja, caso contrário, segue a instalação do pacote.
