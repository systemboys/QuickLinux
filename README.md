# **Bem-vindo ao  QuickLinux!**

> **( ! )** Esse menu ainda está em desenvolvimento!

![Menu de instalações de pacotes Linux](./Images/QuickLinux.png?raw=true "Menu de instalações de pacotes Linux")

QuickLinux: Facilite a vida no Linux com um menu interativo. Instale pacotes, atualize o sistema e execute comandos essenciais com apenas alguns cliques. Simplifique sua experiência no Linux.

**Recursos Principais:**

1. **Instalação Descomplicada:** Esqueça os comandos complexos e a pesquisa por tutoriais. Nosso menu oferece opções para os comandos simples e diretos para instalar programas populares com seleção de opções via setas direcionais ou apenas cliques.

2. **Variedade de Pacotes:** Desde navegadores populares como Google Chrome e Mozilla Firefox até ferramentas de desenvolvimento como Visual Studio Code e Docker, o menu cobre uma ampla gama de necessidades.

3. **Configurações Pré-Definidas:** Além de instalar pacotes, o menu também oferece opções para configurações pré-definidas, economizando tempo e esforço dos usuários.

4. **Documentação Clara:** Cada comando é acompanhado por documentação clara e instruções detalhadas. Não importa se você é um iniciante ou um usuário avançado, você encontrará orientações claras para cada passo.

5. **Comunidade Ativa:** Faça parte de nossa comunidade crescente de usuários. Compartilhe suas experiências, faça perguntas e contribua para melhorias contínuas.

**Como Usar:**

1. **Clone o Repositório:** Clone nosso repositório do GitHub para ter acesso ao **_QuickLinux_**.

   ```
   git clone https://github.com/systemboys/QuickLinux.git
   ```

2. **Navegue e Execute:** Navegue até o diretório do menu e execute os comandos diretamente do terminal. É tão simples quanto isso!

   ```
   cd QuickLinux
   ./QuickLinux.sh
   ```

   > Você pode executar o seguinte comando no seu terminal Linux. Obs.: **( ! )** Sertifique-se de que o `Git` esteja instalado em seu Linux!:
   
   ```bash
   cd /tmp/ && rm -rf QuickLinux && git clone https://github.com/systemboys/QuickLinux.git && cd QuickLinux && ./QuickLinux.sh
   ```

   Uma outra alternativa direta, é colar a seguinte linha de comando diretamente no seu terminal caso não tenha o Git instalado no seu Linux, assim, tanto o Git quanto o QuickLinux serão instalados:

   ```bash
   bash -c "$(curl -fsSL https://github.com/systemboys/QuickLinux/raw/main/Install.sh)"
   ```

3. **Explore e Instale:** Explore as categorias, escolha os pacotes que deseja instalar e siga as instruções. Em poucos instantes, você terá os programas desejados em seu sistema Linux.

**Contribua e Compartilhe:**

Este menu é um projeto de código aberto, e encorajamos contribuições da comunidade. Sinta-se à vontade para abrir problemas, enviar solicitações de pull e ajudar a melhorar esta ferramenta para todos.

Com o QuickLinux, queremos tornar a experiência de instalação de software no Linux tão simples e acessível quanto possível. Esperamos que você aproveite usar o menu tanto quanto nós gostamos de criá-lo!

*Divirta-se instalando, configurando e explorando no Linux!* 🚀🐧

> Marcos Aurélio Rocha da Silva | [https://www.gti1.com.br](https://www.gti1.com.br "Site em desenvolvimento") | systemboys@hotmail.com

---

## Estrutura de arquivos

Este Menu contêm scripts de instalação de pacotes de software dentro do diretório "/QuickLinux/". Estão armazenados vários arquivos.sh. Veja a estrutura de arquivos:

```bash
/QuickLinux
  ├─ /Imagens/
  │    └─ QuickLinux.png
  ├─ /Package_Installers/
  │    ├─ /Development_Session/
  │    │    ├─ Development_Session.sh
  │    │    ├─ Install_Docker_Compose.sh
  │    │    └─ Install_Docker.sh
  │    ├─ /Internet_Session/
  │    │    ├─ Internet_Session.sh
  │    │    ├─ Install_Package1.sh
  │    │    ├─ Install_Package2.sh
  │    │    ├─ Install_Package3.sh
  │    │    └─ ...
  │    ├─ /Linux_Session/
  │    │    └─ Linux_Session.sh
  │    ├─ /Menu_QuickLinux/
  │    │    ├─ AboutQuickLinux.sh
  │    │    └─ Package_Installers.sh
  │    ├─ /Network_Session/
  │    │    ├─ Network_Session.sh
  │    │    ├─ Install_Package1.sh
  │    │    ├─ Install_Package2.sh
  │    │    ├─ Install_Package3.sh
  │    │    └─ ...
  │    ├─ /System_Utilities_Session/
  │    │    ├─ System_Utilities_Session.sh
  │    │    ├─ Install_Package1.sh
  │    │    ├─ Install_Package2.sh
  │    │    ├─ Install_Package3.sh
  │    │    └─ ...
  │    └─ /Terminal_Utilities_Session/
  │         ├─ Terminal_Utilities_Session.sh
  │         ├─ Install_Package1.sh
  │         ├─ Install_Package2.sh
  │         ├─ Install_Package3.sh
  │         └─ ...
  ├─ GlobalVariables.sh
  ├─ Install.sh
  ├─ QuickLinux.sh
  └─ README.md
```

Dentro do diretório "Package_Installers", você pode ter vários `arquivos.sh`, cada um responsável por instalar um pacote de software específico. Isso torna a estrutura do seu projeto organizada e fácil de entender.

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
# v0.0.1 2023-12-06 às 17h50, Marcos Aurélio:
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
sessionName="${programName} ${lastVersion} 🚀🐧"
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
```

Para chamar sua nova sessão a partir do menu inicial, adicione a função que executa a mesma:

```bash
# ... (outras funções)

# Função para executar sessão Internet
New_Session_A() {
    cd Package_Installers/New_Session_A
    ./New_Session_A.sh "$fileName" "$developer"
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
# v0.0.1 2023-12-06 às 17h50, Marcos Aurélio:
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
# v0.0.1 2023-12-06 às 17h50, Marcos Aurélio:
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

> **_( i )_** No exemplo acima, o pacote é o "FileZilla". O script verifica se está instalado para ignorar a instalação caso esteja, caso contrário, segue a instalação do pacote.

