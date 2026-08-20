# 🕷️ Resumo do Curso: Coleta de Dados - Crawlers e Web Scraping

**MBA em Data Science & Analytics - USP/ESALQ**

**Professor:** Guilherme Lima

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos técnicos, éticos e legais da **coleta automatizada de dados na web (Web Scraping)**, incluindo a arquitetura cliente-servidor, o protocolo HTTP, a estrutura HTML das páginas, o uso de ferramentas de desenvolvedor (DevTools) para inspeção de requisições, e a aplicação prática de bibliotecas Python (`requests` e `BeautifulSoup`) para extração de dados quando não há API ou acesso direto disponível — sempre observando os limites de consentimento, impacto técnico e intencionalidade que separam o scraping ético de práticas indevidas.

---

## 📚 Conteúdo Principal

### 1. FUNDAMENTOS DO WEB SCRAPING

#### 1.1 O que é Web Scraping

- **Definição do curso**: "Extraindo informações de forma automatizada"
- **Na prática**: Web scraping é quando seu **programa assume o papel de um navegador**, acessando e interpretando sites automaticamente
- **Quando usar**: Principalmente **quando não há API ou acesso direto aos dados** disponibilizado pelo site/serviço

#### 1.2 Web Scraping ≠ Hacking

Uma distinção central destacada na aula:

| **Scraping** | **Hacking** |
|---|---|
| É legal, **desde que seja ético e público** | 1. Quebrar a segurança |
| | 2. Invadir um sistema |
| | 3. Explorar vulnerabilidades |
| | 4. Acesso não autorizado |

> ⚠️ Scraping não é, por definição, uma atividade maliciosa — mas depende de **como** e **o que** é coletado.

#### 1.3 Fluxo Geral de um Raspador de Dados

Um slide da aula (intitulado "Como o Scrapy funciona") ilustra o fluxo geral de coleta com o seguinte esquema:

```
CÓDIGO  →  SITE  →  HTML  →  Extrai os dados
```

1. O **código** (script) faz uma requisição ao site
2. O **site** responde com sua página
3. O conteúdo chega como **HTML**
4. O script **extrai os dados** relevantes desse HTML

---

### 2. ARQUITETURA DA WEB — O QUE É PRECISO SABER

#### 2.1 A Internet não tem uma autoridade central

- Curiosamente, **não há uma autoridade central com poder legal** que controle e organize toda a internet
- A internet foi construída por **diversas organizações que surgiram de maneira espontânea e colaborativa**, responsáveis por administrar diferentes aspectos da rede:
  - **IETF** (Internet Engineering Task Force)
  - **W3C** (World Wide Web Consortium)
  - **ICANN**
  - **ISOC** (Internet Society)
  - **ARIN**
- **Ignorar os padrões** definidos por essas organizações pode resultar em problemas — sites e aplicações podem simplesmente **não funcionar corretamente** na internet
- Referência histórica: **Tim Berners-Lee**, criador da World Wide Web

#### 2.2 Componentes da Web (o que é realmente necessário para Scraping)

A aula apresenta 6 componentes fundamentais da Web, mas destaca que para fazer scraping **não é necessário dominar todos**:

| Componente | Descrição | Necessário para Scraping? |
|---|---|---|
| **Rede** | Fundamentos da conectividade | ❌ Não essencial |
| **HTML** | A arquitetura das páginas web | ✅ **Essencial** |
| **CSS** | Estilizando a experiência visual | ❌ Não essencial |
| **JavaScript** | Tornando a web dinâmica | ❌ Não essencial (para scraping estático) |
| **Cliente** | O ponto de acesso do usuário | ✅ **Essencial** |
| **Servidor** | O fornecedor de conteúdo | ✅ **Essencial** |

> 💡 O foco prático do scraping recai sobre **HTML + Cliente + Servidor**, pois é aí que a informação é solicitada, entregue e estruturada.

#### 2.3 HTML

- **Definição**: Linguagem usada para **estruturar e organizar** o conteúdo de páginas na web
- É o formato de resposta que o script de scraping precisa interpretar

#### 2.4 Protocolo HTTP e o Modelo Cliente-Servidor

- **HTTP**: Um protocolo que define as regras para **troca de informações** dentro do modelo cliente-servidor na web
- **Cliente-servidor**: Um modelo de comunicação entre **dois lados**

```
Resumindo:
HTTP            → Como as partes se comunicam
Cliente-servidor → Como as partes se organizam
```

**Diagrama do fluxo:**

```
   Client  ---(requisição)--->  Server
   Client  <---(resposta)----   Server
```

- Múltiplos **Clients** (laptop, celular, desktop) se conectam através da **Internet** a um **Server** central que fornece o conteúdo.

#### 2.5 DevTools — Ferramentas de Desenvolvedor

- **Definição**: Conjunto de recursos **embutidos nos navegadores modernos** que permitem inspecionar, editar e depurar páginas da web em tempo real
- **Uso essencial no scraping**: a aba **Network** permite observar as requisições feitas pelo navegador, revelando:

| Campo | O que mostra |
|---|---|
| **Request URL** | A URL para a qual a solicitação foi enviada |
| **Request Method** | O método HTTP usado (ex: GET) |
| **Status Code** | O status da resposta (ex: 200 OK) |

> As DevTools são o ponto de partida para entender **como um site realmente se comunica com o servidor** antes de escrever o código do scraper.

---

### 3. FERRAMENTAS PYTHON PARA WEB SCRAPING

#### 3.1 BeautifulSoup (bs4)

- **Definição**: Uma **biblioteca do Python** usada para **analisar e extrair informações** de arquivos HTML de forma simples
- **Principais funções**:
  - **Ler páginas da web** e extrair títulos, links, tabelas, etc.
  - **Transformar o HTML em objetos Python navegáveis**, facilitando buscas por **tags, classes, IDs e conteúdos**
- **Curiosidade histórica**: o nome é apresentado na aula como uma **homenagem ao livro/poema** *Alice's Adventures in Wonderland*, de **Lewis Carroll**

#### 3.2 A Web é imprevisível: "Web e um quarto bagunçado"

- A web é **desorganizada e imprevisível**
- Um scraper pode falhar por **um simples erro de estrutura** (ex: uma tag que muda de lugar, uma classe renomeada)
- **Lição central**: mais do que culpar o site, é **essencial prever exceções** e tornar o código **resistente a imprevistos** (tratamento de erros robusto)

#### 3.3 Exemplo de código apresentado em aula

```python
from bs4 import BeautifulSoup
import pandas as pd

url = "https://br.investing.com/currencies/"
response = requests.get(url)
```

A aula usa esse trecho para uma reflexão proposta em sala: **"Que tipo de erro poderia acontecer neste código?"** — destacando pontos como:
- Falta do `import requests` (biblioteca não importada)
- Possibilidade de o site **bloquear a requisição** (sem headers/user-agent)
- **Timeout** ou instabilidade de conexão
- Necessidade de verificar o **status code** da resposta antes de seguir com o parsing

---

### 4. PERMISSÕES, ÉTICA E ASPECTOS LEGAIS

#### 4.1 LGPD e Web Scraping

- A **LGPD não menciona explicitamente o termo "scraping"**
- Mas, de acordo com o **artigo 7º, §3º da LGPD**, o tratamento de dados pessoais cujo acesso é público **deve considerar**:
  - A **finalidade**
  - A **boa-fé**
  - O **interesse público** que justificaram a disponibilização dos dados

#### 4.2 Caso Real: Pete Warden e o Facebook (2010)

Uma história do mundo real usada como estudo de caso na aula:

- Em **2010**, o programador **Pete Warden** fez scraping do **Facebook**
- Coletou dados de aproximadamente **200 milhões de perfis públicos**, incluindo:
  - **Nomes**
  - **Localizações**
  - **Amigos**
  - **Interesses**
- O Facebook (à época já com Mark Zuckerberg à frente) exigiu que ele **parasse a atividade**
- A situação levantou questões sobre **big data**, uso comercial dos dados coletados e a **possibilidade de ação legal (advogados)**
- **Conclusão da aula**: mesmo dados publicamente acessíveis podem gerar consequências legais e éticas quando coletados em massa

#### 4.3 Três Critérios que Precisam ser Atendidos

Para que um scraping seja considerado eticamente/legalmente aceitável, a aula propõe observar três critérios:

| Critério | Descrição |
|---|---|
| **Consentimento** | Termos de Serviço de muitos sites **proíbem especificamente** o uso de scrapers |
| **Problemas físicos** | Scrapers podem **derrubar um site** ou **limitar sua capacidade** de atender outros usuários (sobrecarga de requisições) |
| **Intencionalidade** | A real **intenção do código** — o que ele efetivamente faz com os dados coletados |

---

## 🐍 Implementação Python

### Bibliotecas Essenciais

```python
# Requisições HTTP
import requests

# Parsing de HTML
from bs4 import BeautifulSoup

# Manipulação de dados extraídos
import pandas as pd
```

### Exemplo Comentado em Aula (slide 42)

```python
from bs4 import BeautifulSoup
import pandas as pd

url = "https://br.investing.com/currencies/"
response = requests.get(url)
```

A aula usa esse trecho incompleto/com erro proposital para uma discussão em sala sobre o que poderia falhar nele (ver item 3.3), reforçando a necessidade de importar as bibliotecas corretamente, verificar o `status_code` da resposta e prever exceções antes de seguir com o parsing, já que "a web é um quarto bagunçado" e um scraper pode falhar por um simples erro de estrutura.

---

## 📊 Exemplos Práticos do Curso

### Exemplo 1: Coleta de Cotações (Investing.com)

- **Site-alvo**: `br.investing.com/currencies/`
- **Objetivo**: Ilustrar como uma requisição simples com `requests.get()` é o primeiro passo de um scraper
- **Discussão em aula**: Identificar os possíveis erros no trecho de código (import faltante, ausência de tratamento de exceção, bloqueio pelo servidor)

### Exemplo 2: Inspeção via DevTools

- **Ferramenta**: Aba **Network** das DevTools do navegador
- **Objetivo**: Demonstrar como visualizar a **Request URL**, o **Request Method** e o **Status Code** de uma requisição real feita por um navegador — etapa fundamental antes de programar um scraper, pois revela exatamente como o site se comunica com o servidor

### Exemplo 3: Caso Pete Warden x Facebook

- **Contexto**: Estudo de caso histórico (2010) sobre os limites éticos e legais do scraping em larga escala
- **Objetivo**: Discutir os **três critérios** (consentimento, problemas físicos, intencionalidade) usando um exemplo real de conflito entre uma plataforma e um coletor de dados independente

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Scraping vs. Hacking

| **Aspecto** | **Web Scraping** | **Hacking** |
|---|---|---|
| Legalidade | Legal, se ético e público | Ilegal |
| Objetivo | Extrair dados publicamente acessíveis | Quebrar segurança / invadir sistemas |
| Autorização | Pode operar em zona cinzenta de ToS | Sempre não autorizado |
| Consequência típica | Bloqueio de IP, notificação, ação civil | Ação criminal |

### 🔑 O que é Necessário Saber para Fazer Scraping

| Camada | Necessária? | Papel |
|---|---|---|
| HTML | ✅ Sim | Estrutura os dados que serão extraídos |
| Cliente | ✅ Sim | Quem faz a requisição (seu script) |
| Servidor | ✅ Sim | Quem fornece o conteúdo (HTML) |
| Rede | ❌ Não | Infraestrutura de conectividade |
| CSS | ❌ Não | Apenas estilização visual |
| JavaScript | ❌ Não (scraping estático) | Necessário só para conteúdo dinâmico |

### 🔑 Os Três Critérios Éticos/Legais do Scraping

```
1. Consentimento     → Verificar Termos de Serviço do site
2. Problemas físicos → Não sobrecarregar/derrubar o servidor
3. Intencionalidade  → Definir claramente o propósito da coleta
```

### 🔑 Componentes de uma Requisição HTTP (via DevTools)

```
Request URL    → Endereço de destino da solicitação
Request Method → Verbo HTTP (GET, POST, etc.)
Status Code    → Resultado da resposta (200 OK, 403, 404, 429...)
```

### 📐 Base Legal (LGPD)

- **Art. 7º, §3º da LGPD**: dados pessoais de acesso público devem ter seu tratamento avaliado quanto à **finalidade**, **boa-fé** e **interesse público**
- A LGPD **não cita "scraping" explicitamente** — a análise é sempre contextual

---

## ⚠️ Erros Comuns a Evitar

1. **Confundir Web Scraping com Hacking**: scraping de dados públicos, feito eticamente, é legal
2. **Não verificar o Status Code da resposta**: seguir o parsing sem saber se a requisição teve sucesso
3. **Esquecer imports básicos** (ex.: `import requests`) antes de usar a função
4. **Não tratar exceções**: um scraper sem `try/except` quebra facilmente diante de mudanças na estrutura do site
5. **Ignorar os Termos de Serviço** do site antes de coletar dados
6. **Sobrecarregar o servidor** com requisições excessivas, causando problemas de disponibilidade para outros usuários
7. **Coletar dados pessoais em massa sem considerar finalidade, boa-fé e interesse público** (LGPD, art. 7º §3º)
8. **Assumir que a estrutura HTML de um site nunca muda**: a web é "um quarto bagunçado" — imprevisível
9. **Não usar as DevTools antes de programar**: pular a etapa de inspecionar como o site realmente se comunica com o servidor
10. **Ignorar a intencionalidade do código**: não definir claramente o que será feito com os dados coletados

---

## 📚 Materiais de Apoio

### Arquivos da Aula

- **Coleta de dados 300626_SLpdf Portugues.pdf**: Slides principais da aula (54 páginas)
- **script colab coleta dados_MCzip Portugues.zip**: Script/notebook complementar de apoio (Google Colab)

### Ferramentas Mencionadas

- **DevTools** (nativas dos navegadores: Chrome, Edge, Firefox, Opera, Safari) — aba **Network** para inspeção de requisições
- **BeautifulSoup (bs4)** — parsing de HTML em Python
- **requests** — biblioteca Python para requisições HTTP
- **pandas** — estruturação dos dados coletados
- Um slide intitulado "Como o Scrapy funciona" ilustra o fluxo genérico Código → Site → HTML → Extração

### Organizações de Governança da Internet

- **IETF**, **W3C**, **ICANN**, **ISOC**, **ARIN** — responsáveis por padronizar diferentes aspectos da rede

---

## 📖 Referências Recomendadas

(Sugestões de leituras apresentadas ao final da aula)

1. **Mitchell, R. (2024).** *Web Scraping with Python* (3ª ed.). Editora Novatec.
   Livro-referência do tema — cobre exatamente a progressão da aula: `requests`, `BeautifulSoup`, navegação por árvore HTML, formulários/login e **Selenium** para conteúdo dinâmico. Inclui um capítulo forte sobre **ética e legalidade do scraping**.

2. **Sweigart, A.** *Automate the Boring Stuff with Python* (2ª ed.).
   Ideal para o público iniciante da aula. Tem capítulos práticos sobre requisições web, parsing de HTML e automação de navegador, com leitura leve. Disponível gratuitamente em [automatetheboringstuff.com](https://automatetheboringstuff.com).

3. **Gourley, D.; Totty, B.; Sayer, M.; Aggarwal, A.; Reddy, S. (2002).** O'Reilly Media.
   Aprofunda o que a aula só tangencia: o protocolo **HTTP** por baixo do `requests.get()` — status codes, headers (como o `HEAD` do código visto em aula), cookies, sessões e cache. Entender HTTP é o que separa quem "usa requests" de quem "domina coleta web".

---

## ✅ Checklist de Estudo

### Conceitos Teóricos

- [ ] Entender a diferença entre Web Scraping e Hacking
- [ ] Compreender por que a internet não tem autoridade central e conhecer as principais organizações de governança (IETF, W3C, ICANN, ISOC, ARIN)
- [ ] Identificar os componentes da web realmente necessários para scraping (HTML, Cliente, Servidor)
- [ ] Explicar o protocolo HTTP e o modelo cliente-servidor
- [ ] Entender o papel das DevTools na inspeção de requisições

### Aspectos Legais e Éticos

- [ ] Conhecer o artigo 7º, §3º da LGPD e sua relação com dados públicos
- [ ] Analisar o caso Pete Warden x Facebook (2010)
- [ ] Aplicar os três critérios (consentimento, problemas físicos, intencionalidade) antes de qualquer coleta
- [ ] Verificar Termos de Serviço de um site antes de fazer scraping

### Implementação Python

- [ ] Fazer uma requisição HTTP com `requests.get()`
- [ ] Verificar o `status_code` da resposta antes de processar o conteúdo
- [ ] Usar `BeautifulSoup` para transformar HTML em objeto navegável
- [ ] Buscar elementos por tag, classe e ID com `find`/`find_all`/`select`
- [ ] Estruturar dados extraídos em um `DataFrame` do pandas
- [ ] Implementar tratamento de exceções (`try/except`) para tornar o scraper resistente a imprevistos

### Ferramentas de Apoio

- [ ] Abrir as DevTools do navegador e explorar a aba Network
- [ ] Identificar Request URL, Request Method e Status Code de uma requisição real
- [ ] Explorar o script/notebook complementar do Colab fornecido na aula

### Casos Práticos

- [ ] Reproduzir a inspeção de uma página real via DevTools
- [ ] Testar o trecho de código da aula (investing.com) e identificar/corrigir seus erros
- [ ] Discutir criticamente o caso Facebook/Pete Warden aplicando os três critérios éticos

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_
_Módulo 25 - Coleta de Dados: Crawlers e Web Scraping_
