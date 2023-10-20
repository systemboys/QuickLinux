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

   > Ou você pode ir direto ao ponto, execute o seuinte comando no seu terminal Linux:
   > ```bash
   > git clone https://github.com/systemboys/QuickLinux.git && cd QuickLinux && ./QuickLinux.sh
   > ```
   > **( ! )** Sertifique-se de que o `Git` esteja instalado em seu Linux!

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
│    ├─ /Internet/
│    │    ├─ Install_Package1.sh
│    │    ├─ Install_Package2.sh
│    │    ├─ Install_Package3.sh
│    │    └─ ...
│    ├─ /Development/
│    │    └─ ...
│    └─ ...
├─ QuickLinux.sh
└─ README.md
```

Dentro do diretório "Package_Installers", você pode ter vários `arquivos.sh`, cada um responsável por instalar um pacote de software específico. Isso torna a estrutura do seu projeto organizada e fácil de entender.

## Rascunho para novos itens

Aqui você pode editar o arquivo caso necessário, adicionando mais recursos.

### Incrementações de itens

Para incrementar um novo item, edite o arquivo `./QuickLinux.sh` e adicione a nova verificação na estrutura `case ... esac`, no exemplo abaixo, o **Microsoft Edge** é o novo item incrementado:

```bash
    case $choice in
        ...
        3) # Instalar Microsoft Edge
            clear
            install_MicrosoftEdge
            ;;
        ...
```

Em seguida, crie uma função para executar os comandos ou o arquivo:

```bash
...
# Função para instalar o Microsoft Edge
install_MicrosoftEdge() {
    # Your commands here
    dialog --msgbox "Microsoft Edge instalado!" 8 40
}
...
```

**_( ! )_** Você pode também criar um novo arquivo `./Package_Installers/Internet/Install_Microsoft_Edge.sh` com o seguinte script:

```bash
#!/bin/bash

# Verifica se o número de argumentos é correto
if [ "$#" -ne 1 ]; then
    echo "Erro: Número incorreto de argumentos."
    exit 1
fi

# Obtém os valores dos argumentos
fileName="$1"

# Variáveis úteis
packageVersionName="microsoft-edge-stable" # Nome do arquivo na instalação para procurar a versão no pacote
packageName="Microsoft Edge" # Apenas o nome do pacote

# Verificar se o está instalado
if ! command -v ${packageVersionName} &> /dev/null; then
    dialog --msgbox "${packageName} não está instalado!" 8 40

    # Your installation command...

    dialog --msgbox "${packageName} instalado com sucesso!" 8 40
else
    dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40
fi

# End of commands

cd ../..
./${fileName}
```

E chamar o arquivo de instalação da seguinte forma:

```bash
...
    3) # Instalar Microsoft Edge
        cd Package_Installers/Internet/
        ./Install_Microsoft_Edge.sh "$fileName"
        ;;
...
```

> **_( ! )_** Obs.: Esse novo arquivo deve está dentro do diretório `./Package_Installers/Internet/`.

**Ou apenas outros comandos qualquer**

O exemplo a seguir, é para outros comandos sem verificações:

```bash
#!/bin/bash

# Verifica se o número de argumentos é correto
if [ "$#" -ne 1 ]; then
    echo "Erro: Número incorreto de argumentos."
    exit 1
fi

# Obtém os valores dos argumentos
fileName="$1"

# Start of commands

# Your Linux commands...

# End of commands

dialog --msgbox "${packageName} já está instalado! Ignorando a instalação..." 8 40

cd ..
./${fileName}
```

> **_( ! )_** Caso você desejar executar outros comandos que não tenha estrutura de controle como a anterior.