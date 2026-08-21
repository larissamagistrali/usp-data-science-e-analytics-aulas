# 📝 Resumo do Curso: Text Mining, Sentiment Analysis e NLP

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos de Processamento de Linguagem Natural (NLP), Text Mining e Análise de Sentimentos (Sentiment Analysis), incluindo a lógica da comunicação humana como base para a linguagem de máquina, as etapas de pré-processamento de texto (lowercasing, remoção de pontuação, tokenização, remoção de stopwords, stemming e lematização), o pipeline completo de extração de conhecimento a partir de dados textuais, os níveis de granularidade da análise de sentimento (documento, frase e aspecto - ABSA), e os desafios atuais e futuros da área.

---

## 📚 Conteúdo Principal

### 1. COMUNICAÇÃO E LINGUAGEM: A BASE DO TEXT MINING

#### 1.1 Por que entender linguagem é fundamental

- **Uma língua não é apenas um conjunto de palavras**: ela representa a cultura, as tradições e a união de um povo.
- Carrega a **história** e a **identidade** de uma comunidade, tornando-se parte essencial do que ela é.
- **Antes de entender sentimentos, é preciso entender a linguagem.**

#### 1.2 Computadores não sentem, identificam padrões

- **Computadores não sentem emoções.**
- **Eles identificam padrões na linguagem** — é essa a lógica que sustenta todo o campo de NLP: transformar texto (não estruturado) em representações que um algoritmo consiga processar matematicamente.
- Diferente de uma linguagem de programação (sintaxe rígida e formal), a **linguagem natural** é ambígua, cheia de contexto, gírias e exceções — por isso exige técnicas específicas de tratamento antes de qualquer modelagem.

#### 1.3 Áreas relacionadas da Ciência da Computação

| **Área** | **Definição** |
|---|---|
| **NLP (Processamento de Linguagem Natural)** | Processa e entende a linguagem humana por meio de algoritmos computacionais |
| **Análise de Sentimento** | Detecta emoções e opiniões em textos, classificando como positivas, negativas ou neutras |
| **LLMs (Large Language Models)** | Modelos de IA treinados em grandes volumes de texto para gerar e compreender linguagem natural |
| **Text Mining** | Extrai padrões, insights e informações úteis a partir de grandes quantidades de texto |

---

### 2. TEXT MINING: CONCEITOS FUNDAMENTAIS

#### 2.1 Definição

- **Text Mining**: processo de descobrir padrões, informações úteis e conhecimento a partir de grandes volumes de dados textuais.
- Analogia usada no curso: **"Garimpar ouro em meio a um rio de texto"** — a maior parte dos dados gerados hoje (redes sociais, documentos empresariais, artigos científicos) está em formato **textual e não estruturado**, e vivemos em uma **era de sobrecarga de informações**.
- Text Mining surge como a solução para extrair **valor** e **conhecimento** desse volume gigantesco de dados brutos.

#### 2.2 Onde o Text Mining Brilha (Aplicações)

| # | Aplicação |
|---|---|
| 1 | Análise de Sentimentos |
| 2 | Extração de Informação |
| 3 | Sumarização de Textos |
| 4 | Classificação de Textos |
| 5 | Modelagem de Tópicos |
| 6 | Detecção de Fraudes e Spam |

#### 2.3 Pipeline Geral de Text Mining

```
Coleta de Dados Textuais
        ↓
Pré-processamento de Texto
        ↓
Modelagem e Análise
        ↓
Avaliação e Interpretação dos Resultados
        ↓
Insights e Conhecimento
```

- **Coleta**: obtenção dos dados brutos (documentos, redes sociais, avaliações, etc.)
- **Pré-processamento**: limpeza e padronização do texto (etapa crítica que impacta diretamente na acurácia final)
- **Modelagem e Análise**: aplicação de técnicas estatísticas ou de Machine Learning
- **Avaliação e Interpretação**: validação dos resultados obtidos
- **Insights e Conhecimento**: entrega de valor a partir do texto originalmente bruto

---

### 3. PRÉ-PROCESSAMENTO DE TEXTO

> **⚠️ CRÍTICO**: O pré-processamento impacta diretamente na acurácia final de qualquer modelo de NLP. Cada etapa ajuda a preparar o texto para análise.

Texto de exemplo usado ao longo de todo o curso para ilustrar cada etapa: **"Eu amo DS!"** / **"Eu amo MBA!"**, e o conjunto de frases-base do pipeline completo:

```python
textos_brutos = [
    "Eu estou aprendendo processamento de linguagem natural!",
    "Os algoritmos de machine learning são incríveis.",
    "O cachorro correu rapidamente pelo parque.",
    "Hoje eu comprei um livro sobre NLP.",
    "As árvores estão balançando com o vento forte."
]
```

#### 3.1 Lowercasing (Padronização de Caixa)

- **Objetivo**: padronizar o texto, evitando que a mesma palavra seja tratada como diferente por causa de maiúsculas/minúsculas.
- **Exemplo do curso**:
  - Original: `"Eu amo DS!"`
  - Após lowercasing: `["eu", "amo", "ds", "!"]`

```python
texto = "Eu estou aprendendo processamento de linguagem natural!"
texto_lower = texto.lower()
print(texto_lower)
# "eu estou aprendendo processamento de linguagem natural!"
```

#### 3.2 Remoção de Pontuação

- **Objetivo**: eliminar sinais de pontuação que não agregam significado estatístico ao conteúdo.
- **Exemplo do curso**:
  - Original: `"Eu amo DS!"`
  - Após remoção: `["eu", "amo", "ds"]`

```python
import string

def remover_pontuacao(texto):
    return texto.translate(str.maketrans('', '', string.punctuation))

texto_sem_pontuacao = remover_pontuacao(texto_lower)
print(texto_sem_pontuacao)
# "eu estou aprendendo processamento de linguagem natural"
```

#### 3.3 Tokenização (Tokenization)

- **Objetivo**: dividir um texto em unidades menores (tokens), geralmente palavras.
- **Exemplo do curso**:
  - Original: `"Eu amo MBA!"`
  - Após tokenização: `["Eu", "amo", "MBA", "!"]`

```python
from nltk.tokenize import word_tokenize
import nltk
nltk.download('punkt')

tokens = word_tokenize(texto_sem_pontuacao, language='portuguese')
print(tokens)
# ['eu', 'estou', 'aprendendo', 'processamento', 'de', 'linguagem', 'natural']
```

#### 3.4 Stopwords (Remoção de Palavras Comuns)

- **Definição**: palavras comuns que não agregam muito significado ao conteúdo (artigos, preposições, conjunções).
- **Exemplos**: "a", "o", "e", "de", "que", "em"
- **Efeito no exemplo do curso**: a frase *"eu estou aprendendo processamento de linguagem natural"* torna-se apenas **"aprendendo processamento linguagem natural"**.

```python
from nltk.corpus import stopwords
nltk.download('stopwords')

stop_words = set(stopwords.words('portuguese'))
tokens_sem_stopwords = [palavra for palavra in tokens if palavra not in stop_words]
print(tokens_sem_stopwords)
# ['aprendendo', 'processamento', 'linguagem', 'natural']
```

#### 3.5 Stemming (Reduzir à Raiz)

- **Definição**: reduz a palavra à sua **raiz** (stem), cortando sufixos, de forma mais "bruta" e baseada em regras — pode gerar radicais que não são palavras reais.
- **Exemplo do curso** ("Amasse" → Stemming): `"am"`
- **Exemplo com o corpus da aula**:
  - `aprendendo, processamento, linguagem, natural` → `aprend, process, linguag, natur`
  - `algoritmos, machine, learning, incríveis` → `algoritm, machin, learn, incriv`
  - `cachorro, correu, rapidamente, parque` → `cachorr, corr, rapid, parqu`
  - `comprei, livro, nlp` → `compr, livr, nlp`
  - `árvores, balançando, vento, forte` → `arvor, balanc, vent, fort`

```python
from nltk.stem import RSLPStemmer
nltk.download('rslp')

stemmer = RSLPStemmer()
tokens_stem = [stemmer.stem(palavra) for palavra in tokens_sem_stopwords]
print(tokens_stem)
# ['aprend', 'process', 'linguag', 'natur']
```

#### 3.6 Lemmatization (Lematização)

- **Definição**: reduz a palavra à sua **forma canônica** (o lema, forma de dicionário), preservando o sentido gramatical — mais precisa e linguisticamente correta que o stemming.
- **Exemplo do curso** ("Amasse" → Lemmatization): `"amar"`
- **Exemplo com o corpus da aula**:
  - `aprendendo, processamento, linguagem, natural` → `aprender, processamento, linguagem, natural`
  - `algoritmos, machine, learning, incríveis` → `algoritmo, machine, learning, incrível`
  - `cachorro, correu, rapidamente, parque` → `cachorro, correr, rápido, parque`
  - `comprei, livro, nlp` → `comprar, livro, nlp`
  - `árvores, balançando, vento, forte` → `árvore, balançar, vento, forte`

```python
import spacy
nlp = spacy.load("pt_core_news_sm")

doc = nlp(" ".join(tokens_sem_stopwords))
tokens_lemma = [token.lemma_ for token in doc]
print(tokens_lemma)
# ['aprender', 'processamento', 'linguagem', 'natural']
```

> **📌 Stemming x Lemmatization**: Stemming é mais rápido e simples (regras de corte), mas menos preciso. Lemmatization é mais lento (usa dicionário e análise gramatical), porém retorna sempre uma palavra válida da língua.

#### 3.7 Pipeline Completo de Pré-processamento

O pipeline completo integra todas as etapas anteriores (lowercasing → remoção de pontuação → tokenização → stopwords → stemming) em uma única função. As bibliotecas utilizadas são **NLTK** (para tokenização, stopwords e stemming) e **spaCy** (para lematização).

---

### 4. SENTIMENT ANALYSIS (ANÁLISE DE SENTIMENTOS)

#### 4.1 O desafio: como uma máquina entende emoções?

- Frases de exemplo usadas para introduzir o tema:
  - `"Adorei o produto ♥"` (positivo)
  - `"Odiei o produto"` (negativo)
  - `"O produto é ok"` (neutro)
  - `"Jogo difícil de largar, é muito viciante!!!"` (ambíguo/positivo com carga emocional forte)
- **Milhões de opiniões são geradas todos os dias** em avaliações, redes sociais, atendimento, pesquisas, notícias e comentários — **opiniões estão em toda parte**.
- **Objetivo da Análise de Sentimentos**: descobrir o sentimento por trás de um texto.

#### 4.2 Como funciona (fluxo conceitual)

```
Texto → Palavras → Contexto → Sentimento
```

```
PESSOA → TEXTO → NLP → ANÁLISE → DECISÃO
```

- Exemplo: `"Nossa... que atendimento maravilhoso… 🤗"` — o modelo precisa interpretar palavras, contexto e até emojis para extrair a polaridade correta.

#### 4.3 Definição formal

- Análise de Sentimentos (AS) combina **Processamento de Linguagem Natural (PLN)** e **Aprendizado de Máquina (AM)** para **extrair emoções, atitudes e opiniões em texto**.
- **Princípio central do curso**: *"Qualidade do dado > Qualquer algoritmo de ponta"* — nenhum modelo sofisticado compensa dados mal coletados ou mal pré-processados.
- **AS não é uma técnica única, mas um processo** (pipeline de várias etapas).

#### 4.4 Espectro de Categorias (Polaridade)

| **Categoria** | **Valor** |
|---|---|
| Muito Positivo | +2 |
| Positivo | +1 |
| Neutro | 0 |
| Negativo | -1 |
| Muito Negativo | -2 |

#### 4.5 AS como Pipeline de Decisões Técnicas

| **Decisão** | **Descrição** |
|---|---|
| **Granularidade** | Definição do nível de análise: documento, frase ou aspecto |
| **Algoritmo** | Escolha entre léxico, ML clássico ou Deep Learning |
| **Métrica** | Validação técnica dos resultados |

---

### 5. GRANULARIDADE DA ANÁLISE DE SENTIMENTO

#### 5.1 Nível de Documento

- Classifica o **texto inteiro** como uma única opinião.
- Útil para reviews globais, mas **pouco detalhado** para análises complexas.

#### 5.2 Nível de Frase

- Classifica **cada sentença individualmente**.
- Primeiro identifica se a frase é **subjetiva ou objetiva**, depois define a **polaridade**.

#### 5.3 Nível de Aspecto (o mais refinado)

- Foca em **características específicas** e é essencial para um feedback detalhado.
- **⚠️ ESTRATÉGIA**: A escolha da granularidade deve ser feita **antes** de definir a arquitetura do modelo.

#### 5.4 Aspect-Based Sentiment Analysis (ABSA)

- **Definição**: em vez de atribuir um único rótulo geral a um texto inteiro, o ABSA **identifica os diferentes aspectos** (características, entidades ou tópicos específicos) presentes no texto e atribui uma polaridade a cada um deles separadamente.

**Exemplo 1 (restaurante):**

> "O **atendimento** foi excelente, mas a **comida** demorou muito para chegar."

- Aspecto "atendimento" → sentimento **positivo**
- Aspecto "comida"/tempo de espera → sentimento **negativo**

**Exemplo 2 (hotel):**

> "O **quarto do hotel** estava limpo e confortável, mas o **Wi-Fi** era extremamente lento."

- Aspecto "quarto" → sentimento **positivo**
- Aspecto "Wi-Fi" → sentimento **negativo**

```python
# Exemplo ilustrativo de ABSA simplificado com regras léxicas
def absa_simplificado(frase, aspectos_positivos, aspectos_negativos):
    resultado = {}
    for aspecto, palavras_chave in aspectos_positivos.items():
        if any(p in frase.lower() for p in palavras_chave):
            resultado[aspecto] = "positivo"
    for aspecto, palavras_chave in aspectos_negativos.items():
        if any(p in frase.lower() for p in palavras_chave):
            resultado[aspecto] = "negativo"
    return resultado

frase = "O atendimento foi excelente, mas a comida demorou muito para chegar."

aspectos_positivos = {"atendimento": ["excelente", "ótimo", "maravilhoso"]}
aspectos_negativos = {"comida": ["demorou", "lento", "ruim"]}

print(absa_simplificado(frase, aspectos_positivos, aspectos_negativos))
# {'atendimento': 'positivo', 'comida': 'negativo'}
```

---

### 6. PIPELINE COMPLETO: DO DADO BRUTO À CLASSIFICAÇÃO

| Etapa | Descrição |
|---|---|
| **01 - Coleta** | Obtenção de dados brutos via APIs (Twitter/X, reviews, logs) ou web scraping |
| **02 - Pré-processamento** | Limpeza: tokenização, lematização, stemming e remoção de stopwords |
| **03 - Extração** | Transformação de texto em vetores numéricos (TF-IDF, Word Embeddings) |
| **04 - Classificação** | Aplicação do modelo (ML ou DL) para rotular a polaridade do sentimento |

> **⚠️ CRÍTICO**: O pré-processamento impacta diretamente na acurácia final.

```python
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report

# 03. Extração de características (TF-IDF)
corpus = [
    "adorei o produto",
    "odiei o produto",
    "o produto e ok",
    "jogo dificil de largar e muito viciante",
    "atendimento maravilhoso",
]
sentimentos = ["positivo", "negativo", "neutro", "positivo", "positivo"]

vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(corpus)

# 04. Classificação (exemplo didático com poucos dados)
X_train, X_test, y_train, y_test = train_test_split(
    X, sentimentos, test_size=0.2, random_state=42
)
modelo = LogisticRegression()
modelo.fit(X_train, y_train)
print(classification_report(y_test, modelo.predict(X_test)))
```

---

### 7. DESAFIOS ATUAIS E DIREÇÕES FUTURAS

#### 7.1 O que ainda precisa ser resolvido

1. **Sarcasmo, ironia e emojis complexos**
2. **Dependência de dados do Twitter/X** (viés de fonte de dados)
3. **Polaridade intermediária e ambiguidade**
4. **Viés linguístico**

> **💡 Essas lacunas são onde o Data Scientist agrega maior valor diferencial hoje.**

#### 7.2 Previsões para o futuro da Análise de Sentimento

- Desafios **além do texto**, integrando **imagens** e **áudio** (análise multimodal).
- Interpretar emoções humanas de forma precisa exigirá modelos cada vez mais inteligentes, capazes de compreender **múltiplas fontes de informação** e lidar com **ambiguidades e diversidade cultural**.
- Referência citada no material: *Computational Intelligence Methods for Sentiment Analysis in Natural Language Processing Applications* (Ed. D. Jude Hemanth) — capítulo "1.8 Future direction": destaca que Deep Learning ainda é pouco explorado em Sentiment Analysis, que a incorporação de informação de sentimento em *word embeddings* é uma frente de pesquisa aberta, e que a **fusão multimodal** (texto + voz + imagem + emoticon) é um componente central do futuro da área.

---

## 🐍 Implementação Python

### Bibliotecas Essenciais

```python
# Manipulação de dados
import pandas as pd
import numpy as np
import string

# Pré-processamento de texto (NLP)
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.stem import RSLPStemmer
import spacy

# Extração de características
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer

# Modelagem / Classificação
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score

# Downloads necessários do NLTK (executar uma vez)
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('rslp')

# Modelo de linguagem do spaCy para português (lematização)
# python -m spacy download pt_core_news_sm
nlp = spacy.load("pt_core_news_sm")
```

### Pipeline Completo - Text Mining e Sentiment Analysis

O pipeline de Sentiment Analysis segue as etapas: 
1. **Coleta** de dados de avaliações/comentários
2. **Pré-processamento** (lowercasing, limpeza, tokenização, remoção de stopwords)
3. **Extração de características** (TF-IDF ou word embeddings)
4. **Classificação** (com modelos como LogisticRegression, Naive Bayes)
5. **Avaliação** de desempenho
6. **Predição** em textos novos

### ABSA (Aspect-Based Sentiment Analysis) - Conceito

ABSA identifica aspectos específicos (substantivos) e seus sentimentos associados. Utilizando análise de POS (Part-of-Speech) com spaCy, é possível extrair substantivos como aspectos e adjetivos próximos como indicadores de sentimento, criando um mapeamento aspecto → sentimento ao invés de uma polaridade única para todo o texto.

---

## 📊 Exemplos Práticos do Curso

### Exemplo 1: Polaridade Básica de Sentimento

- **Frases**: `"Adorei o produto ♥"`, `"Odiei o produto"`, `"O produto é ok"`
- **Objetivo**: introduzir o conceito de polaridade (positivo/negativo/neutro) de forma intuitiva antes de qualquer formalização técnica.

### Exemplo 2: Avaliação de Jogo (Sentimento Ambíguo)

- **Frase**: `"Jogo difícil de largar, é muito viciante!!!"`
- **Desafio**: a frase tem carga emocional forte, mas as palavras isoladas ("difícil", "viciante") poderiam sugerir negatividade sem o contexto completo — reforça por que contexto é essencial em NLP.

### Exemplo 3: Atendimento (Interjeições e Emojis)

- **Frase**: `"Nossa... que atendimento maravilhoso… 🤗"`
- **Objetivo**: mostrar como interjeições, reticências e emojis carregam informação de sentimento que o pré-processamento tradicional pode eliminar se não for tratado com cuidado.

### Exemplo 4: ABSA em Restaurante

- **Frase**: `"O atendimento foi excelente, mas a comida demorou muito para chegar."`
- **Resultado esperado**: aspecto "atendimento" = positivo; aspecto "comida" (tempo de entrega) = negativo.
- **Aprendizado**: uma classificação de documento único perderia a informação de que existem dois sentimentos opostos na mesma frase.

### Exemplo 5: ABSA em Hotel

- **Frase**: `"O quarto do hotel estava limpo e confortável, mas o Wi-Fi era extremamente lento."`
- **Resultado esperado**: aspecto "quarto" = positivo; aspecto "Wi-Fi" = negativo.
- Disponível também como notebook: **Exemplo Colab** (ver seção Materiais de Apoio).

### Exemplo 6: Pipeline de Pré-processamento com Frases Diversas

- **Corpus utilizado**: frases sobre NLP, machine learning, um cachorro no parque, compra de um livro e árvores ao vento.
- **Objetivo**: demonstrar de forma progressiva o efeito de cada etapa (lowercasing → remoção de pontuação → tokenização → stopwords → stemming/lematização) sobre o mesmo conjunto de frases.

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Etapas do Pré-processamento de Texto

| **Etapa** | **O que faz** | **Exemplo ("Eu amo DS!")** |
|---|---|---|
| **Lowercasing** | Padroniza para minúsculas | `["eu", "amo", "ds", "!"]` |
| **Remoção de Pontuação** | Elimina sinais de pontuação | `["eu", "amo", "ds"]` |
| **Tokenização** | Divide o texto em unidades menores | `["Eu", "amo", "MBA", "!"]` |
| **Stopwords** | Remove palavras comuns sem carga semântica | remove "a", "o", "e", "de", "que", "em" |
| **Stemming** | Reduz à raiz (bruto, baseado em regras) | "Amasse" → "am" |
| **Lemmatization** | Reduz à forma canônica (lema, gramaticalmente correto) | "Amasse" → "amar" |

### 🎯 Áreas Relacionadas

| **Área** | **Foco** |
|---|---|
| NLP | Processar e entender linguagem humana |
| Análise de Sentimento | Detectar emoções/opiniões (positiva, negativa, neutra) |
| LLMs | Redes neurais/modelos de IA treinados em grande volume de texto |
| Text Mining | Extrair padrões e insights de grandes volumes de texto |

### 📐 Espectro de Polaridade

```
Muito Positivo  +2
Positivo        +1
Neutro           0
Negativo        -1
Muito Negativo  -2
```

### 🔍 Granularidade da Análise de Sentimento

| **Nível** | **Escopo** | **Detalhamento** |
|---|---|---|
| Documento | Texto inteiro | Baixo |
| Frase | Cada sentença | Médio (subjetiva/objetiva → polaridade) |
| Aspecto (ABSA) | Características específicas | Alto (múltiplos sentimentos no mesmo texto) |

### 🧩 Pipeline de Sentiment Analysis

```
01 Coleta         → APIs, reviews, logs, web scraping
02 Pré-processamento → tokenização, lematização, stemming, stopwords
03 Extração       → TF-IDF, Word Embeddings
04 Classificação  → ML clássico ou Deep Learning
```

### ⚙️ Decisões Técnicas em AS

| **Decisão** | **Opções** |
|---|---|
| Granularidade | Documento / Frase / Aspecto |
| Algoritmo | Léxico / ML clássico / Deep Learning |
| Métrica | Validação técnica dos resultados |

---

## ⚠️ Erros Comuns a Evitar

1. **Ignorar o pré-processamento ou fazê-lo de forma incompleta**: impacta diretamente a acurácia final do modelo.
2. **Confundir Stemming com Lemmatization**: Stemming corta por regras (pode gerar radicais inválidos); Lemmatization retorna sempre uma palavra real do dicionário.
3. **Remover stopwords sem avaliar o contexto**: em alguns casos (negação, ex. "não gostei"), remover certas palavras pode inverter o sentido da frase.
4. **Escolher a granularidade depois de montar a arquitetura do modelo**: a escolha (documento/frase/aspecto) deve ser feita **antes**.
5. **Acreditar que qualidade do algoritmo compensa dados ruins**: *"Qualidade do dado > Qualquer algoritmo de ponta"*.
6. **Tratar Análise de Sentimentos como uma técnica única**: é um **processo** com múltiplas etapas e decisões (granularidade, algoritmo, métrica).
7. **Ignorar sarcasmo, ironia e ambiguidade**: são desafios ainda não resolvidos e fontes comuns de erro de classificação.
8. **Depender de uma única fonte de dados (ex. apenas Twitter/X)**: gera viés e reduz a generalização do modelo.
9. **Desconsiderar emojis e pontuação expressiva (ex. "!!!", "...")** durante o pré-processamento: podem carregar sinal de sentimento relevante.
10. **Achar que o computador "sente" algo**: computadores não sentem emoções, apenas identificam padrões estatísticos na linguagem.

---

## 📚 Materiais de Apoio

### Links e Repositórios do Curso

- **Projeto de pré-processamento (demo interativa)**: https://guilhermeonrails.github.io/pre-processamento/
- **Repositório de pré-processamento**: https://github.com/guilhermeonrails/pre-processamento
- **Notebook Colab - Análise de Sentimentos**: https://colab.research.google.com/drive/1q_inokFdOqyqRiKVdcIrReLGI5ixf4R
- **Notebook/exemplo Colab - ABSA (Exemplo 2)**: referenciado nos slides da Aula III
- **API de dados globais (exemplo de coleta)**: https://raw.githubusercontent.com/guilhermeonrails/api/refs/heads/main/dadosglobais.json
- **Tabela de cotações (exemplo de dados externos)**: https://www.x-rates.com/table/?from=USD&amount=1
- **Dólar turismo (exemplo de dados externos)**: https://dolarhoje.com/dolar-turismo/

### Arquivos Complementares (.zip)

- **sentiment analysis_MCzip Portugues.zip**: material complementar de Sentiment Analysis
- **sentiment-analysis-2zip Portugues.zip**: material complementar adicional de Sentiment Analysis
- **text-mining-1_MCzip Portugues.zip**: material complementar de Text Mining

### Bibliografia Citada no Material

- **Hemanth, D. Jude (Ed.).** *Computational Intelligence Methods for Sentiment Analysis in Natural Language Processing Applications*. Morgan Kaufmann (Elsevier). — Citado o capítulo "1.8 Future direction", sobre direções futuras da Análise de Sentimentos (Deep Learning, word embeddings com informação de sentimento, e fusão multimodal).

### Professor

- **Prof. Guilherme Bezerra de Lima**
- LinkedIn: https://www.linkedin.com/in/guilherme-lima-developer/

---

## 📖 Referências Recomendadas

### Livros e Capítulos

1. **Hemanth, D. Jude (Ed.).** *Computational Intelligence Methods for Sentiment Analysis in Natural Language Processing Applications*. Morgan Kaufmann.
2. **Bird, S., Klein, E., & Loper, E.** *Natural Language Processing with Python* (NLTK Book) - referência clássica para pré-processamento de texto em Python.
3. **Jurafsky, D. & Martin, J. H.** *Speech and Language Processing* - referência completa em NLP.

### Bibliotecas e Documentação Técnica

- **NLTK**: https://www.nltk.org/ — tokenização, stopwords, stemming (RSLPStemmer para português)
- **spaCy**: https://spacy.io/ — lematização e análise sintática (pt_core_news_sm)
- **scikit-learn**: https://scikit-learn.org/ — TF-IDF (`TfidfVectorizer`), `CountVectorizer` e modelos de classificação
- **Hugging Face Transformers**: https://huggingface.co/ — modelos de Deep Learning e LLMs pré-treinados para NLP

### Recursos Online

- Repositório e demo interativa de pré-processamento do curso (Prof. Guilherme Lima): https://github.com/guilhermeonrails/pre-processamento
- Notebook Colab de Análise de Sentimentos do curso (link na seção Materiais de Apoio)
- Kaggle: datasets de reviews e textos rotulados para prática de Sentiment Analysis

---

## ✅ Checklist de Estudo

### Conceitos Teóricos

- [ ] Entender por que a linguagem natural é mais complexa que uma linguagem de programação
- [ ] Diferenciar NLP, Análise de Sentimento, LLMs e Text Mining
- [ ] Compreender o pipeline geral de Text Mining (coleta → pré-processamento → modelagem → avaliação → insights)
- [ ] Entender por que "qualidade do dado > qualquer algoritmo de ponta"

### Pré-processamento de Texto

- [ ] Aplicar lowercasing em um texto
- [ ] Remover pontuação de um texto
- [ ] Tokenizar um texto em palavras
- [ ] Remover stopwords de uma lista de tokens
- [ ] Aplicar stemming (RSLPStemmer) e comparar com o texto original
- [ ] Aplicar lematização (spaCy) e comparar com stemming
- [ ] Construir um pipeline completo de pré-processamento em Python

### Análise de Sentimentos

- [ ] Entender o espectro de polaridade (muito positivo a muito negativo)
- [ ] Diferenciar granularidade por documento, frase e aspecto
- [ ] Compreender o conceito de ABSA (Aspect-Based Sentiment Analysis)
- [ ] Identificar aspectos e polaridades em frases com múltiplos sentimentos
- [ ] Conhecer o pipeline: coleta → pré-processamento → extração (TF-IDF/embeddings) → classificação

### Implementação Python

- [ ] Usar NLTK para tokenização, stopwords e stemming
- [ ] Usar spaCy para lematização
- [ ] Vetorizar texto com `TfidfVectorizer` ou `CountVectorizer`
- [ ] Treinar um classificador de sentimento simples (ex. `LogisticRegression`)
- [ ] Avaliar o modelo com `classification_report` / `confusion_matrix`
- [ ] Implementar um exemplo simplificado de ABSA

### Desafios e Visão Crítica

- [ ] Reconhecer os desafios atuais (sarcasmo, ironia, emojis, viés de fonte de dados)
- [ ] Refletir sobre limitações da análise apenas textual (multimodalidade: texto + voz + imagem)
- [ ] Identificar onde o Data Scientist agrega mais valor diante dessas lacunas

### Casos Práticos

- [ ] Reproduzir o pipeline de pré-processamento com o corpus de exemplo da aula
- [ ] Reproduzir o exemplo de ABSA do restaurante (atendimento x comida)
- [ ] Reproduzir o exemplo de ABSA do hotel (quarto x Wi-Fi)
- [ ] Explorar o notebook Colab de Análise de Sentimentos indicado no material complementar
- [ ] Aplicar o pipeline completo em um dataset próprio de reviews ou comentários

---

**📌 Nota Final:** Text Mining, NLP e Sentiment Analysis não são "uma técnica", mas sim um **processo** de múltiplas etapas — desde entender a complexidade da linguagem humana até transformar texto bruto em insights estruturados. A qualidade do pré-processamento e dos dados coletados é o fator que mais determina o sucesso de qualquer projeto nessa área, mais até do que a sofisticação do algoritmo escolhido.

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_
_Módulo 26 - Text Mining, Sentiment Analysis e NLP_
