# 🎲 Resumo do Curso: Data Wrangling

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Compreender o processo de **Data Wrangling** — a preparação, organização, junção e transformação dos dados brutos em uma estrutura adequada à análise — situando essa etapa dentro do processo CRISP-DM, conhecendo a biblioteca **pandas** como ferramenta principal de manipulação de dados em Python, e adquirindo as ferramentas de apoio necessárias ao trabalho colaborativo e reprodutível: **Git**, **GitHub** e **Google Colab**.

---

## 📚 Conteúdo Principal

### 1. CONCEITO DE DATA WRANGLING

#### 1.1 Definição

- **Data Wrangling**: processo de transformar a base de dados de sua estrutura original (dados brutos) para uma nova estrutura mais adequada que permita a extração de informações
- Raramente os dados brutos estão disponíveis na estrutura mais apropriada para as análises
- É uma etapa de **preparação**, **organização** e **manipulação** dos bancos de dados
- Ocorre **antes** da análise exploratória dos dados, da criação de gráficos e da modelagem
- Quanto melhor a etapa de data wrangling, melhores serão os dados e maior tende a ser a qualidade da análise e das informações extraídas → **dados mais consistentes e confiáveis**
- **Não é uma atividade padronizada!** Dado o contexto, diferentes etapas são aplicadas

#### 1.2 Atividades Comuns no Tratamento dos Dados

| Atividade | Descrição |
| --- | --- |
| **Coleta e importação** | Os dados podem ser provenientes de diversas fontes e em vários formatos. Exemplos: dados em XLSX, CSV ou Parquet provenientes de sites especializados, APIs, ERPs e CRMs (consultas SQL), entre outros |
| **Junção** | Os dados provenientes de diferentes fontes precisam ser organizados para possibilitar a união de observações e variáveis. Exigem variáveis que sejam "chaves" para o relacionamento entre as tabelas |
| **Transformação** | Contempla as etapas de modificação dos dados. Exemplos: limpeza dos dados, criação e alteração de variáveis, seleção de observações, agregações, resumos... |

---

### 2. CRISP-DM (Cross-Industry Standard Process for Data Mining)

- Modelo de referência amplamente utilizado em projetos de mineração de dados e ciência de dados
- Fases do ciclo: **Business Understanding → Data Understanding → Data Preparation → Modeling → Evaluation → Deployment** (com retorno ao Business Understanding)
- O **Data Wrangling** se insere principalmente nas fases de **Data Understanding** e **Data Preparation**, antecedendo a etapa de **Modeling**
- Fonte de referência do diagrama: https://commons.wikimedia.org/wiki/File:CRISP-DM_Process_Diagram.png

```
Business Understanding ⇄ Data Understanding
        ↑                       ↓
   Deployment ← Data ← Data Preparation
        ↑                       ↓
    Evaluation  ←———————  Modeling
```

---

### 3. AS 6 ETAPAS DO DATA WRANGLING (6 Steps of Data Wrangling)

Fonte: https://online.hbs.edu/blog/post/data-wrangling

| Etapa | Descrição (original) |
| --- | --- |
| **1. Discovery** | Familiarizing yourself with data to conceptualize how you might employ it |
| **2. Structuring** | Transforming raw data to readily use it |
| **3. Cleaning** | Removing inherent errors in data that might distort your analysis |
| **4. Enriching** | Determining whether to enrich or augment your existing data |
| **5. Verifying** | Confirming your data is consistent and high quality |
| **6. Publishing** | Making your data available for analysis |

- **Discovery**: familiarização inicial com os dados para entender como poderão ser utilizados
- **Structuring**: transformação dos dados brutos para um formato de uso mais direto
- **Cleaning**: remoção de erros inerentes aos dados que poderiam distorcer a análise
- **Enriching**: decisão sobre enriquecer ou complementar os dados existentes (ex.: com outras bases)
- **Verifying**: confirmação de que os dados são consistentes e de alta qualidade
- **Publishing**: disponibilização dos dados tratados para a análise final

---

### 4. PYTHON E A BIBLIOTECA PANDAS

- Embora muitas bibliotecas sejam úteis no processo de manipulação de dados, o curso utiliza o **pandas** como ferramenta principal para Data Wrangling em Python
- **Manual do usuário**: https://pandas.pydata.org/docs/user_guide/index.html
- **Material de consulta (cheat sheet)**: https://pandas.pydata.org/Pandas_Cheat_Sheet.pdf

---

### 5. GIT E GITHUB — CONCEITOS

#### 5.1 Definições

- **Git**: software instalado no computador que realiza o **controle de versões** dos arquivos com códigos, isto é, rastreia e armazena as alterações e gera um histórico sobre tais modificações
- **GitHub**: site que hospeda os arquivos na nuvem, mostra o histórico das versões, permite que os projetos sejam feitos colaborativamente, inclusive compartilhados publicamente com todos que utilizam a rede (quando desejado)

#### 5.2 Esquema Básico do Fluxo Git

```
Arquivo → git add → git commit → git push → GitHub
```

#### 5.3 Instalando o Git

- Acesse: https://git-scm.com/install/
- **Windows**: clique em "Click here to download", execute o instalador mantendo as configurações padrão ("Next" em todos os passos) e finalize com "Install"
- **macOS**: a instalação via **Xcode Command Line Tools** costuma ser a mais simples

```bash
xcode-select --install
git --version   # confirma a instalação
```

- **Linux**: escolha a distribuição adequada (ex.: `apt-get install git` no Debian/Ubuntu, `yum install git` no Fedora até a versão 21, `dnf install git` a partir da versão 22) e siga as instruções do site oficial

#### 5.4 Criando uma Conta no GitHub

- Acesse: https://github.com/
- Clique em **Sign up** (Criar uma conta) no canto superior direito e siga o cadastro solicitado

#### 5.5 Configuração Inicial do Git (primeira utilização)

```bash
git config --global user.email "inserir_aqui_seu_email"
git config --global user.name "inserir_aqui_nome_usuário"
```

#### 5.6 Criando e Acessando a Pasta do Projeto

```bash
# Crie uma pasta na área de trabalho, por exemplo "ProjetoDS"
# Copie o caminho da pasta e no terminal execute:
cd inserir_caminho_de_sua_pasta
```

#### 5.7 Clonando um Repositório Remoto

```bash
# 1. Crie um repositório remoto (privado) no GitHub
# 2. No repositório criado, clique em "Code" e copie a URL
# 3. No terminal:
git clone inserir_URL_de_seu_repositório
```

- Na primeira vez, é solicitada a autenticação com o GitHub. A opção **"Sign in with a code"** (autenticação por dispositivo) costuma ser a mais simples:
  1. Acesse o link informado (`https://github.com/login/device`)
  2. Informe o código gerado no terminal
  3. Autorize o Git (Git Credential Manager) no GitHub

#### 5.8 Enviando um Arquivo para o GitHub (add → commit → push)

```bash
# 1. Acesse a pasta interna do repositório
cd inserir_caminho_de_sua_pasta_interna

# 2. Crie um script (ex.: no Spyder) com o conteúdo "# Versão 1"
#    e salve como Exemplo.py

# 3. Adicione o arquivo ao índice de arquivos a serem enviados
git add Exemplo.py

# 4. Verifique o estado do repositório
git status

# 5. Faça o commit (nomeando a versão)
git commit -m "Primeira_Versao"
git status

# 6. Envie o arquivo local para o repositório remoto
git push
```

#### 5.9 Criando e Comparando Versões

```bash
# Edite Exemplo.py adicionando "# Versão 2" e salve o arquivo
git add Exemplo.py
git commit -m "Segunda_Versao"
git push

# Verificar o histórico de versões
git log --oneline
```

#### 5.10 Ramificações (Branches)

```bash
# Criar uma nova ramificação chamada "nova"
git switch -c nova

# Editar Exemplo.py adicionando "# Versão 3" e salvar
git add Exemplo.py
git commit -m "Terceira_Versao"
git push -u origin nova

# Visualizar as branches disponíveis e alternar entre elas
git branch
git switch main
git branch
```

#### 5.11 Sincronizando Alterações Remotas e Fazendo Merge

```bash
# Baixar e integrar localmente alterações feitas na branch "nova"
git switch nova
git pull

# Após validar as alterações, incorporá-las à branch principal (main)
git switch main
git merge nova
git push
```

---

### 6. GOOGLE COLAB — TUTORIAL DE ACESSO

1. Acesse o site: https://colab.research.google.com/
2. **Caso já tenha uma conta Google**: clique em "Fazer login" e realize o acesso
   - Nota: se ao acessar o site não aparecer a opção "Fazer login", mas sim uma janela "Abrir notebook (Open notebook)", significa que já está logado e pronto para iniciar
3. **Caso não tenha uma conta Google**: clique em "Fazer login" → "Criar conta" → "Para uso pessoal" e finalize o cadastro
4. Após a criação/login da conta, o Google Colab estará disponível para uso, permitindo a execução de notebooks Python (`.ipynb`) diretamente no navegador, sem necessidade de instalação local

---

## 🐍 Implementação Python

### Bibliotecas Essenciais Citadas no Módulo

```python
# Manipulação de dados (ferramenta principal do módulo)
import pandas as pd
import numpy as np
```

- **pandas**: biblioteca central de Data Wrangling em Python indicada no módulo, utilizada para coleta/importação, junção e transformação de dados
- Consulta rápida de sintaxe: **Pandas Cheat Sheet** (https://pandas.pydata.org/Pandas_Cheat_Sheet.pdf)
- Documentação completa: **User Guide** (https://pandas.pydata.org/docs/user_guide/index.html)
- Os exercícios práticos e notebooks completos de manipulação com pandas (importação de arquivos, junção de tabelas, limpeza e transformação de variáveis) constam no material complementar em Python distribuído no arquivo `Data Wrangling Python_MCzip Portugues.zip`

### Comandos Git — Referência Rápida

```bash
# Configuração (uma única vez por máquina)
git config --global user.email "seu_email"
git config --global user.name "seu_nome"

# Fluxo básico de trabalho
git clone <url_do_repositorio>
git add <arquivo>
git status
git commit -m "mensagem_da_versao"
git push

# Histórico
git log --oneline

# Branches
git switch -c <nome_da_branch>     # cria e alterna para uma nova branch
git branch                         # lista as branches
git switch <nome_da_branch>        # alterna entre branches
git push -u origin <nome_da_branch>

# Sincronização e integração
git pull
git merge <nome_da_branch>
```

---

## 📊 Exemplos Práticos do Curso

### Exemplo 1: CRISP-DM aplicado ao Data Wrangling

- Situa as fases **Data Understanding** e **Data Preparation** do CRISP-DM como o momento em que o Data Wrangling ocorre, antes da modelagem (**Modeling**)

### Exemplo 2: Versionamento de um Script com Git/GitHub (`ProjetoDS`)

- **Cenário**: criação de uma pasta local `ProjetoDS`, clonagem de um repositório remoto privado do GitHub e versionamento de um arquivo `Exemplo.py`
- **Etapas reproduzidas**:
  1. Configuração inicial do Git (`user.email`, `user.name`)
  2. Clonagem do repositório (`git clone`)
  3. Criação da "Versão 1" do arquivo `Exemplo.py`, `git add`, `git commit -m "Primeira_Versao"`, `git push`
  4. Criação da "Versão 2", novo commit e push
  5. Consulta do histórico com `git log --oneline`
  6. Criação da branch `nova`, "Versão 3", commit, push para a branch (`git push -u origin nova`)
  7. Alternância entre branches (`git branch`, `git switch main`)
  8. Sincronização (`git pull`) e integração da branch `nova` à `main` (`git merge nova`, `git push`)
- **Resultado**: fluxo completo de versionamento colaborativo, do arquivo local até o histórico compartilhado no GitHub

### Exemplo 3: Acesso ao Ambiente de Execução em Nuvem (Google Colab)

- **Cenário**: acesso ao Google Colab via conta Google (login existente ou criação de conta nova) para execução de notebooks Python sem instalação local, útil para os exercícios práticos de pandas do módulo

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Data Wrangling: Onde se Encaixa

| **Etapa do CRISP-DM** | **Papel do Data Wrangling** |
| --- | --- |
| Business Understanding | Não é foco do Data Wrangling |
| Data Understanding | Familiarização inicial com os dados (Discovery) |
| **Data Preparation** | Núcleo do Data Wrangling (Structuring, Cleaning, Enriching, Verifying, Publishing) |
| Modeling | Ocorre **depois** do Data Wrangling |
| Evaluation / Deployment | Dependem da qualidade dos dados tratados anteriormente |

### 🎯 As 3 Atividades Comuns do Tratamento de Dados

```
1. Coleta e importação → múltiplas fontes/formatos (XLSX, CSV, Parquet, APIs, ERP, CRM/SQL)
2. Junção            → união de tabelas via variáveis "chave"
3. Transformação     → limpeza, criação/alteração de variáveis, seleção, agregação
```

### 🎯 As 6 Etapas do Data Wrangling (HBS)

```
Discovery → Structuring → Cleaning → Enriching → Verifying → Publishing
```

### 📐 Git vs GitHub

| **Aspecto** | **Git** | **GitHub** |
| --- | --- | --- |
| **O que é** | Software local de controle de versão | Plataforma web de hospedagem de repositórios |
| **Onde roda** | No computador do usuário (terminal) | Na nuvem |
| **Função principal** | Rastrear e armazenar alterações (histórico) | Hospedar, compartilhar e colaborar em projetos |
| **Comandos típicos** | `add`, `commit`, `status`, `log`, `branch` | Interface web: criação de repositórios, `Code`/URL, autenticação |
| **Conexão entre eles** | `git push` / `git pull` / `git clone` | Recebe/envia dados do Git local |

### 📐 Sequência de Comandos do Fluxo Básico

```
1. git clone   → traz o repositório remoto para a máquina local
2. git add     → adiciona arquivo(s) ao índice (staging area)
3. git status  → verifica o estado atual do repositório
4. git commit  → registra uma nova versão com uma mensagem
5. git push    → envia a versão local para o repositório remoto
6. git pull    → traz atualizações remotas para o repositório local
7. git branch/switch → cria e alterna entre ramificações
8. git merge   → integra as alterações de uma branch a outra
```

---

## ⚠️ Erros Comuns a Evitar

1. **Pular a etapa de Data Wrangling e ir direto para a modelagem**: compromete a qualidade e a confiabilidade das informações extraídas
2. **Tratar Data Wrangling como processo padronizado**: cada contexto exige etapas diferentes — não existe um "checklist" único aplicável a todos os casos
3. **Ignorar a etapa de Junção quando há múltiplas fontes de dados**: sem variáveis-chave corretamente definidas, a união das tabelas gera inconsistências
4. **Esquecer a configuração inicial do Git** (`user.email`/`user.name`) antes do primeiro commit
5. **Fazer commit sem mensagem clara**: dificulta o entendimento do histórico de versões (`git log --oneline`)
6. **Esquecer o `git push` após o `git commit`**: as alterações permanecem apenas localmente, sem chegar ao GitHub
7. **Trabalhar direto na branch `main` sem criar branches de trabalho**: aumenta o risco de sobrescrever versões estáveis
8. **Não fazer `git pull` antes de iniciar novas alterações em uma branch compartilhada**: pode gerar conflitos de versão
9. **Confundir o papel do Git (controle de versão local) com o do GitHub (hospedagem/colaboração na nuvem)**

---

## 📚 Materiais de Apoio

### Slides Principais

- **Data Wrangling 020916230626_SLpdf Portugues.pdf**: conceito de Data Wrangling, atividades comuns, CRISP-DM, 6 Steps of Data Wrangling e introdução ao pandas

### Materiais Complementares (Pré-Aula)

- **Tutorial Acesso Google Colab_MCpdf Portugues.pdf** (Data Wrangling III): passo a passo de acesso ao Google Colab
- **Tutorial Git e GitHub 23062026_MCpdf Portugues.pdf** (Data Wrangling IV): instalação do Git (Windows/macOS/Linux) e criação de conta no GitHub
- **Introducao ao Git e GitHub_MCpdf Portugues.pdf** (Data Wrangling IV): conceitos de Git/GitHub e tutorial prático completo (configuração, clone, add/commit/push, branches, merge)

### Material Prático em Python

- **Data Wrangling Python_MCzip Portugues.zip**: notebooks e exercícios práticos de manipulação de dados com pandas (não detalhados neste resumo — conferir o conteúdo do arquivo compactado)

### Links Citados no Módulo

- Diagrama CRISP-DM: https://commons.wikimedia.org/wiki/File:CRISP-DM_Process_Diagram.png
- 6 Steps of Data Wrangling: https://online.hbs.edu/blog/post/data-wrangling
- Manual do usuário pandas: https://pandas.pydata.org/docs/user_guide/index.html
- Pandas Cheat Sheet: https://pandas.pydata.org/Pandas_Cheat_Sheet.pdf
- Instalação do Git: https://git-scm.com/install/
- GitHub: https://github.com/
- Google Colab: https://colab.research.google.com/

---

## 📖 Referências Recomendadas

### Livros

1. **CHEN, D.** "Pandas for Everyone: Python Data Analysis." Addison-Wesley Professional, 2017.
2. **FÁVERO, L. P.; BELFIORE, P.** "Manual de análise de dados: estatística e machine learning com Excel®, SPSS®, Stata®, R® e Python®." 2 ed. LTC, 2024.
3. **GRUS, J.** "Data Science do zero: noções fundamentais com Python." 2 ed. Alta Books, 2021.
4. **HARRISON, M.** "Effective Pandas: Patterns for Data Manipulation." Treading on Python (Livro 2).
5. **McKINNEY, W.** "Python Para Análise de Dados: Tratamento de Dados com Pandas, NumPy & Jupyter." Novatec Editora, 2023.
6. **VANDERPLAS, J.** "Python Data Science Handbook: Essential Tools for Working with Data." 2 ed. O'Reilly Media, 2023.

### Recursos Online

- **Pandas**: Documentação oficial (User Guide) e Cheat Sheet
- **Git**: Documentação oficial de instalação (git-scm.com)
- **GitHub**: Plataforma oficial para criação e hospedagem de repositórios
- **Google Colab**: Ambiente de execução de notebooks Python em nuvem

---

## ✅ Checklist de Estudo

### Conceitos Teóricos

- [ ] Entender o que é Data Wrangling e por que raramente os dados brutos já estão prontos para análise
- [ ] Diferenciar as três atividades comuns: coleta/importação, junção e transformação
- [ ] Localizar o Data Wrangling dentro do ciclo CRISP-DM (Data Understanding e Data Preparation)
- [ ] Memorizar as 6 etapas do Data Wrangling (Discovery, Structuring, Cleaning, Enriching, Verifying, Publishing)
- [ ] Reconhecer o pandas como ferramenta principal de manipulação de dados em Python

### Git e GitHub

- [ ] Instalar o Git no sistema operacional utilizado (Windows, macOS ou Linux)
- [ ] Criar uma conta no GitHub
- [ ] Realizar a configuração inicial do Git (`user.email`, `user.name`)
- [ ] Criar um repositório remoto e cloná-lo localmente (`git clone`)
- [ ] Executar o fluxo `git add` → `git commit` → `git push`
- [ ] Consultar o histórico de versões (`git log --oneline`)
- [ ] Criar e alternar entre branches (`git switch -c`, `git branch`, `git switch`)
- [ ] Sincronizar alterações remotas (`git pull`) e integrar branches (`git merge`)

### Google Colab

- [ ] Acessar o Google Colab com uma conta Google (existente ou nova)
- [ ] Reconhecer a interface básica do Colab (Índice, Código, Texto, Ambiente de execução)

### Aplicação Prática

- [ ] Reproduzir o exemplo de versionamento do `Exemplo.py` (Versão 1, 2 e 3)
- [ ] Reproduzir a criação da branch `nova` e o merge com a `main`
- [ ] Explorar o material prático em Python (pandas) disponível no arquivo `.zip` complementar

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_
_Módulo 24 - Data Wrangling_
