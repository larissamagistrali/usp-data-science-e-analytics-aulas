# 📊 Resumo - Fundamentos de Estatística

## MBA em Data Science e Analytics USP/ESALQ

---

## 🎯 Objetivo do Módulo

Desenvolver conhecimentos sólidos em conceitos estatísticos fundamentais necessários para análise de dados, inferência estatística e tomada de decisões baseadas em dados.

---

## 📚 Conteúdo Principal

### 0. **Tipos de Variáveis**

- **Qualitativas**: variáveis não métricas, atribuem categorias ou classificações (ex.: faixa de renda, nacionalidade, estado civil, escolaridade, cor do veículo, crédito aprovado ou não, escalas Likert)
  - A análise descritiva é feita por meio de tabelas de frequência e gráficos, pois não permitem cálculo de medidas de posição e dispersão
- **Quantitativas**: variáveis métricas, atribuem contagem ou mensuração (ex.: idade, renda, quantidade de filhos, altura, peso, retorno de ações, temperatura, lucro/prejuízo)
  - Podem ser discretas ou contínuas

### 1. **Estatística Descritiva**

#### 1.1 Tabela de Frequências

- Frequência absoluta, frequência relativa, frequência absoluta acumulada e frequência relativa acumulada

#### 1.2 Medidas de Posição

- **Média**: soma dos valores dividida pelo número de observações
- **Mediana**: elemento central da distribuição (valores organizados de forma crescente)
- **Moda**: valor que ocorre com maior frequência
- **Percentis**: dividem a distribuição em 100 partes iguais
- **Quartis**: Q1 (25%), Q2 (50% - mediana), Q3 (75%)
- **Decis**: dividem a distribuição em 10 partes iguais

#### 1.3 Medidas de Dispersão

- **Amplitude**: diferença entre o valor máximo e o mínimo
- **Amplitude Interquartil (AIQ)**: AIQ = Q3 − Q1; usada para identificar outliers univariados (representada no boxplot)
  - Outlier: valor < Q1 − 1,5·AIQ ou valor > Q3 + 1,5·AIQ
- **Variância** (amostral): S² = Σ(Xᵢ − X̄)² / (n − 1)
- **Desvio Padrão**: S = √S²
- **Erro Padrão**: S_x̄ = S / √n — quanto maior a amostra, menor o erro padrão (mais precisa a média estimada)
- **Coeficiente de Variação (CV)**: CV = (S / X̄) × 100 — medida de dispersão relativa; quanto menor o CV, mais homogêneos os valores

#### 1.4 Medidas de Forma

- **Assimetria**: curva simétrica (média = mediana = moda); assimétrica à direita (média > mediana); assimétrica à esquerda (média < mediana)
  - Coeficiente de assimetria de Fisher (g₁): g₁ = 0 indica simetria; g₁ > 0 assimétrica positiva; g₁ < 0 assimétrica negativa
- **Curtose**: achatamento da curva em relação à normal (mesocúrtica, platicúrtica, leptocúrtica)
  - Coeficiente de curtose de Fisher (g₂): g₂ = 0 indica distribuição normal; g₂ > 0 alongada; g₂ < 0 achatada

---

### 2. **Distribuições de Probabilidade**

#### 2.1 Distribuições Discretas

- **Uniforme discreta**: todos os resultados têm a mesma probabilidade de ocorrência — P(X = xᵢ) = 1/n
- **Bernoulli**: variável com apenas dois resultados possíveis (sucesso x=1, fracasso x=0) — P(X = x) = pˣ · (1−p)^(1−x)
- **Binomial**: n repetições independentes do experimento de Bernoulli com probabilidade de sucesso p constante — P(X = k) = C(n,k) · pᵏ · (1−p)^(n−k)
- **Binomial Negativa**: quantidade de ensaios (x) necessários até se obter uma quantidade fixa (k) de sucessos — P(X = x) = C(x−1, k−1) · pᵏ · (1−p)^(x−k)
- **Poisson**: número de sucessos (k) em uma exposição contínua (tempo ou área) — P(X = k) = e^(−λ) · λᵏ / k!

#### 2.2 Distribuições Contínuas

- **Normal (Gaussiana)**: curva em formato de sino, simétrica em torno da média; parâmetros μ e σ
  - 68,26% dos dados entre μ ± 1σ; 95,44% entre μ ± 2σ; 99,74% entre μ ± 3σ
  - **Normal Padrão**: transformação por Z-score → Z = (X − μ)/σ, resultando em média 0 e desvio padrão 1
- **Qui-Quadrado (χ²)**: forma influenciada pelos graus de liberdade; assimétrica e positiva para poucos graus de liberdade, aproximando-se da normal conforme eles aumentam. Aplicação: teste de associação entre variáveis categóricas
- **t de Student**: parecida com a normal padrão, porém com caudas mais longas (permite valores mais extremos); aproxima-se da normal conforme os graus de liberdade aumentam. Aplicação: teste de médias, útil para amostras pequenas
- **F de Snedecor**: trabalha com razões entre valores; forma influenciada pelos graus de liberdade do numerador e denominador. Aplicação: comparação de variâncias

#### 2.3 Graus de Liberdade

- Quantidade de observações da amostra que pode variar de forma independente e aleatória e ainda assim permitir obter o valor em análise
- Cada teste estatístico tem um cálculo específico de graus de liberdade (não há padrão único); normalmente considera-se o tamanho da amostra e a quantidade de parâmetros estimados
- Os graus de liberdade influenciam o valor crítico da distribuição, impactando o teste de hipótese

---

### 3. **Intervalo de Confiança**

- Fornece um intervalo de valores possíveis para o parâmetro populacional, dado um nível de confiança (ex.: 95%)
- **Grandes amostras / variância conhecida**: IC = (X̄ − Z·σ/√n, X̄ + Z·σ/√n)
- **Pequenas amostras / variância desconhecida**: IC = (X̄ − t·s/√n, X̄ + t·s/√n), com t utilizando n−1 graus de liberdade
- Z e t utilizados são os valores bicaudais

---

### 4. **Testes de Hipóteses**

#### 4.1 Conceitos Fundamentais

- **Hipótese Nula (H₀)** e **Hipótese Alternativa (H₁)**
- **Nível de Significância (α)**: probabilidade de rejeitar H₀ quando ela é verdadeira (erro tipo I); valores comuns: 1%, 5%, 10%
- **Nível de confiança do teste**: 1 − α
- **p-valor**: probabilidade associada ao valor da estatística de teste calculada
  - Se p-valor < α: rejeita-se H₀
  - Se p-valor > α: não rejeita H₀

#### 4.2 Tipos de Erros

|  | H₀ é Verdadeira | H₀ é Falsa |
|---|---|---|
| **Não Rejeitar H₀** | Correto | Erro Tipo II |
| **Rejeitar H₀** | Erro Tipo I (α) | Correto |

#### 4.3 Tipos de Testes

- **Teste bilateral (bicaudal)**: H₀: θ = θ₀ / H₁: θ ≠ θ₀ — região crítica em ambas as caudas
- **Teste unilateral à esquerda**: H₀: θ = θ₀ / H₁: θ < θ₀
- **Teste unilateral à direita**: H₀: θ = θ₀ / H₁: θ > θ₀

#### 4.4 Testes Estatísticos Abordados

- **Teste Z para a média de uma amostra**: aplicado quando o desvio padrão populacional é conhecido — Z = (X̄ − μ₀)/(σ/√n); distribuição normal padrão
- **Teste t para a média de uma amostra**: aplicado quando o desvio padrão populacional é desconhecido — T = (X̄ − μ₀)/(S/√n); t de Student com n−1 graus de liberdade
- **Teste qui-quadrado para uma amostra**: verifica se há diferença entre frequência observada (O) e esperada (E) — χ² = Σ(Oᵢ − Eᵢ)²/Eᵢ; qui-quadrado com k−1 graus de liberdade
- **Teste F para comparação de variâncias de duas amostras independentes**: F = S²maior/S²menor; distribuição F de Snedecor
- **Teste t para comparação de médias de duas amostras independentes**: exige antes verificar (por exemplo, com teste F) se as variâncias populacionais são homogêneas ou diferentes, pois o cálculo da estatística T e dos graus de liberdade muda conforme o caso

---

### 5. **Relação entre Variáveis**

#### 5.1 Variáveis Qualitativas — Teste Qui-Quadrado de Associação

- Parte-se de uma **tabela de contingência** com as frequências absolutas observadas para cada par de categorias
- Calculam-se as **frequências absolutas esperadas**: freq. esperada₁₁ = (ΣL1 · ΣC1)/N
- Calcula-se o **resíduo** de cada célula: resíduo₁₁ = freq. observada₁₁ − freq. esperada₁₁
- Calcula-se o χ² individual de cada célula: χ²₁₁ = (resíduo₁₁)² / freq. esperada₁₁, e soma-se para obter o χ² total (estatística do teste)
- H₀: as variáveis se associam de forma aleatória / H₁: a associação não se dá de forma aleatória
- Valor crítico com (I−1)·(J−1) graus de liberdade

#### 5.2 Variáveis Métricas — Correlação de Pearson

- Inicia-se pelo cálculo da **covariância**: cov(X,Y) = Σ(Xᵢ − X̄)·(Yᵢ − Ȳ) / (n−1)
- Coeficiente de correlação de Pearson: r_XY = cov(X,Y) / (S_X · S_Y), variando entre −1 e 1
  - r = −1: correlação perfeita negativa; r = 0: sem correlação; r = 1: correlação perfeita positiva
- **Teste t para significância da correlação de Pearson**: t = r / √[(1−r²)/(n−2)]; distribuição t de Student com n−2 graus de liberdade

---

## 📊 Materiais de Apoio

### Arquivos da Disciplina

- **PDF principal (slides)**: Fundamentos de Estatistica 0914 e 16052025pdf Portugues.pdf — Prof. Dr. Wilson Tarantin Junior
- **Material complementar**: Lista de Exercícios Complementares (PDF e Excel)
- **Planilha de suporte**: Planilha Suporte - Fundamentos de Estatística (contém as abas com os bancos de dados de cada exemplo/exercício, resolvidos em Excel)

### Referência bibliográfica citada no material

- Fávero, L. P.; Belfiore, P. (2024). *Manual de Análise de Dados: estatística e machine learning com Excel, SPSS, Stata, R e Python*. 2ª ed. Rio de Janeiro: LTC.

---

## ✅ Checklist de Estudo

- [ ] Diferenciar variáveis qualitativas e quantitativas
- [ ] Compreender medidas de posição, dispersão e forma
- [ ] Identificar outliers pela amplitude interquartil (boxplot)
- [ ] Reconhecer as distribuições de probabilidade discretas (uniforme, Bernoulli, binomial, binomial negativa, Poisson) e contínuas (normal, qui-quadrado, t de Student, F de Snedecor) e suas aplicações
- [ ] Entender o papel dos graus de liberdade em cada distribuição/teste
- [ ] Construir intervalos de confiança para a média (variância conhecida e desconhecida)
- [ ] Formular hipóteses nula e alternativa e identificar os tipos de erro (I e II)
- [ ] Aplicar os testes Z e t para médias, teste F para variâncias e teste qui-quadrado (uma amostra e associação entre variáveis)
- [ ] Calcular e testar a significância da correlação de Pearson
- [ ] Resolver os exercícios das planilhas de suporte e da lista de exercícios complementares

---

**Curso**: MBA em Data Science e Analytics - USP/ESALQ
**Módulo**: 1 - Fundamentos de Estatística
