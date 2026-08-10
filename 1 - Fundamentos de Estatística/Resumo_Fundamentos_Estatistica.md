# 📊 Resumo - Fundamentos de Estatística

## MBA em Data Science e Analytics USP/ESALQ

---

## 🎯 Objetivo do Módulo

Desenvolver conhecimentos sólidos em conceitos estatísticos fundamentais necessários para análise de dados, inferência estatística e tomada de decisões baseadas em dados.

---

## 📚 Conteúdo Principal

### 1. **Estatística Descritiva**

#### 1.1 Medidas de Tendência Central

- **Média Aritmética**: soma dos valores dividida pelo número de observações
- **Mediana**: valor central que divide o conjunto de dados em duas partes iguais
- **Moda**: valor que ocorre com maior frequência
- **Média Ponderada**: média considerando pesos diferentes para cada observação

#### 1.2 Medidas de Dispersão

- **Amplitude**: diferença entre o maior e o menor valor
- **Variância**: média dos quadrados dos desvios em relação à média
- **Desvio Padrão**: raiz quadrada da variância
- **Coeficiente de Variação**: razão entre desvio padrão e média (expressa em %)
- **Amplitude Interquartil (IQR)**: diferença entre Q3 e Q1

#### 1.3 Medidas de Posição

- **Quartis**: Q1 (25%), Q2 (50% - mediana), Q3 (75%)
- **Decis**: dividem a distribuição em 10 partes iguais
- **Percentis**: dividem a distribuição em 100 partes iguais

#### 1.4 Medidas de Forma

- **Assimetria (Skewness)**:
  - Simétrica: média = mediana = moda
  - Assimétrica positiva: média > mediana > moda
  - Assimétrica negativa: média < mediana < moda
- **Curtose (Kurtosis)**:
  - Leptocúrtica: concentração alta ao redor da média
  - Mesocúrtica: distribuição normal
  - Platicúrtica: distribuição mais achatada

---

### 2. **Probabilidade**

#### 2.1 Conceitos Fundamentais

- **Experimento Aleatório**: processo que gera resultados não determinísticos
- **Espaço Amostral**: conjunto de todos os resultados possíveis
- **Evento**: subconjunto do espaço amostral
- **Probabilidade**: medida da chance de ocorrência de um evento (0 ≤ P(A) ≤ 1)

#### 2.2 Regras de Probabilidade

- **Regra da Adição**: P(A ∪ B) = P(A) + P(B) - P(A ∩ B)
- **Regra da Multiplicação**:
  - Eventos independentes: P(A ∩ B) = P(A) × P(B)
  - Eventos dependentes: P(A ∩ B) = P(A) × P(B|A)
- **Probabilidade Condicional**: P(A|B) = P(A ∩ B) / P(B)
- **Teorema de Bayes**: P(A|B) = [P(B|A) × P(A)] / P(B)

#### 2.3 Independência Estatística

- Dois eventos são independentes se: P(A|B) = P(A)
- Ou equivalentemente: P(A ∩ B) = P(A) × P(B)

---

### 3. **Distribuições de Probabilidade**

#### 3.1 Distribuições Discretas

**Distribuição Binomial**

- Aplicação: eventos com dois resultados possíveis (sucesso/fracasso)
- Parâmetros: n (número de tentativas), p (probabilidade de sucesso)
- Fórmula: P(X = k) = C(n,k) × p^k × (1-p)^(n-k)
- Exemplos: lançamento de moedas, testes de qualidade

**Distribuição de Poisson**

- Aplicação: eventos raros em intervalo de tempo/espaço
- Parâmetro: λ (taxa média de ocorrência)
- Fórmula: P(X = k) = (e^(-λ) × λ^k) / k!
- Exemplos: chegada de clientes, defeitos em produtos

**Distribuição Uniforme Discreta**

- Todos os resultados têm a mesma probabilidade
- Exemplo: lançamento de dado justo

#### 3.2 Distribuições Contínuas

**Distribuição Normal (Gaussiana)**

- A mais importante em estatística
- Parâmetros: μ (média) e σ² (variância)
- Forma de sino, simétrica em relação à média
- Propriedades:
  - 68% dos dados entre μ ± 1σ
  - 95% dos dados entre μ ± 2σ
  - 99,7% dos dados entre μ ± 3σ
- **Distribuição Normal Padrão**: Z ~ N(0,1)
  - Transformação: Z = (X - μ) / σ

**Distribuição t de Student**

- Utilizada quando σ populacional é desconhecido
- Mais achatada que a normal para amostras pequenas
- Converge para normal quando n → ∞

**Distribuição Qui-Quadrado (χ²)**

- Utilizada para testes de variância e independência
- Sempre positiva e assimétrica à direita
- Parâmetro: graus de liberdade (gl)

**Distribuição F**

- Comparação de variâncias
- Utilizada em ANOVA
- Parâmetros: gl1 e gl2

**Distribuição Exponencial**

- Tempo entre eventos em processo de Poisson
- Parâmetro: λ (taxa)
- Aplicação: tempo de vida de componentes, tempo de espera

---

### 4. **Amostragem**

#### 4.1 Conceitos Básicos

- **População**: conjunto completo de todos os elementos de interesse
- **Amostra**: subconjunto da população
- **Parâmetro**: medida descritiva da população (μ, σ, π)
- **Estatística**: medida descritiva da amostra (x̄, s, p)

#### 4.2 Tipos de Amostragem

**Amostragem Probabilística**

- **Aleatória Simples**: cada elemento tem mesma chance
- **Estratificada**: população dividida em estratos homogêneos
- **Por Conglomerados**: população dividida em grupos heterogêneos
- **Sistemática**: seleção a intervalos regulares

**Amostragem Não Probabilística**

- Por conveniência
- Por julgamento
- Por quotas
- Bola de neve (snowball)

#### 4.3 Teorema Central do Limite (TCL)

- Para n suficientemente grande, a distribuição das médias amostrais aproxima-se de uma distribuição normal
- Independente da forma da distribuição populacional original
- Geralmente, n ≥ 30 é considerado suficiente
- **Erro Padrão da Média**: σx̄ = σ / √n

---

### 5. **Inferência Estatística**

#### 5.1 Estimação por Ponto

- Estimativa única do parâmetro populacional
- Propriedades desejáveis: não-viesado, consistente, eficiente

#### 5.2 Estimação por Intervalo (Intervalo de Confiança)

**Para a Média (σ conhecido)**

- IC = x̄ ± z(α/2) × (σ/√n)
- Nível de confiança comum: 90%, 95%, 99%

**Para a Média (σ desconhecido)**

- IC = x̄ ± t(α/2, n-1) × (s/√n)
- Usa distribuição t de Student

**Para Proporção**

- IC = p̂ ± z(α/2) × √[p̂(1-p̂)/n]

#### 5.3 Interpretação do Intervalo de Confiança

- IC de 95% significa que, se repetirmos o processo de amostragem muitas vezes, 95% dos intervalos conterão o parâmetro populacional verdadeiro

---

### 6. **Testes de Hipóteses**

#### 6.1 Conceitos Fundamentais

- **Hipótese Nula (H₀)**: afirmação a ser testada (status quo)
- **Hipótese Alternativa (H₁ ou Hₐ)**: afirmação que contradiz H₀
- **Nível de Significância (α)**: probabilidade de rejeitar H₀ quando ela é verdadeira (erro tipo I)
  - Valores comuns: 0,01, 0,05, 0,10
- **p-valor**: menor nível de significância que levaria à rejeição de H₀
  - Se p-valor < α: rejeita H₀
  - Se p-valor ≥ α: não rejeita H₀

#### 6.2 Tipos de Erros

- **Erro Tipo I (α)**: rejeitar H₀ quando ela é verdadeira (falso positivo)
- **Erro Tipo II (β)**: não rejeitar H₀ quando ela é falsa (falso negativo)
- **Poder do Teste**: 1 - β (probabilidade de rejeitar H₀ quando ela é falsa)

#### 6.3 Tipos de Testes

**Teste Bilateral (bicaudal)**

- H₀: μ = μ₀
- H₁: μ ≠ μ₀
- Região crítica em ambas as caudas

**Teste Unilateral (unicaudal)**

- **Cauda direita**: H₀: μ ≤ μ₀ | H₁: μ > μ₀
- **Cauda esquerda**: H₀: μ ≥ μ₀ | H₁: μ < μ₀

#### 6.4 Testes Paramétricos

**Teste Z para Média (σ conhecido)**

- z = (x̄ - μ₀) / (σ/√n)
- Distribuição: Normal Padrão

**Teste t para Média (σ desconhecido)**

- t = (x̄ - μ₀) / (s/√n)
- Distribuição: t de Student com (n-1) gl

**Teste t para Duas Médias Independentes**

- Compara médias de dois grupos independentes
- Pressupõe normalidade e variâncias homogêneas

**Teste t Pareado (amostras dependentes)**

- Compara médias antes/depois de intervenção
- Analisa as diferenças entre pares

**Teste Z para Proporção**

- z = (p̂ - p₀) / √[p₀(1-p₀)/n]

**Teste F para Igualdade de Variâncias**

- F = s₁²/s₂²
- Pressupõe normalidade

**ANOVA (Análise de Variância)**

- Compara médias de três ou mais grupos
- H₀: μ₁ = μ₂ = ... = μₖ
- Estatística F compara variância entre grupos vs dentro dos grupos

#### 6.5 Testes Não Paramétricos

**Teste Qui-Quadrado (χ²)**

- **Teste de Aderência**: compara distribuição observada vs esperada
- **Teste de Independência**: verifica associação entre variáveis categóricas
- χ² = Σ [(Oᵢ - Eᵢ)² / Eᵢ]

**Teste de Kolmogorov-Smirnov**

- Verifica se dados seguem distribuição específica

**Teste de Mann-Whitney (Wilcoxon rank-sum)**

- Alternativa não paramétrica ao teste t para duas amostras independentes

**Teste de Wilcoxon (signed-rank)**

- Alternativa não paramétrica ao teste t pareado

**Teste de Kruskal-Wallis**

- Alternativa não paramétrica à ANOVA

---

### 7. **Correlação**

#### 7.1 Coeficiente de Correlação de Pearson (r)

- Mede associação linear entre duas variáveis quantitativas
- Valores: -1 ≤ r ≤ 1
  - r = 1: correlação positiva perfeita
  - r = -1: correlação negativa perfeita
  - r = 0: ausência de correlação linear
- Interpretação da força:
  - |r| < 0,3: fraca
  - 0,3 ≤ |r| < 0,7: moderada
  - |r| ≥ 0,7: forte

#### 7.2 Coeficiente de Determinação (r²)

- Proporção da variabilidade de Y explicada por X
- Valores: 0 ≤ r² ≤ 1

#### 7.3 Correlação de Spearman (ρ)

- Versão não paramétrica da correlação de Pearson
- Utiliza postos (ranks) ao invés dos valores originais
- Menos sensível a outliers

#### 7.4 Correlação vs Causalidade

- **Importante**: Correlação não implica causalidade
- Pode haver variáveis confundidoras (confounders)

---

### 8. **Visualização de Dados Estatísticos**

#### 8.1 Gráficos para Variáveis Quantitativas

- **Histograma**: distribuição de frequências
- **Box Plot (Diagrama de caixa)**: mediana, quartis e outliers
- **Gráfico de dispersão**: relação entre duas variáveis
- **Gráfico de linhas**: evolução temporal

#### 8.2 Gráficos para Variáveis Qualitativas

- **Gráfico de barras**: frequências de categorias
- **Gráfico de pizza**: proporções de categorias
- **Gráfico de Pareto**: ordenação por importância

#### 8.3 Gráficos Especializados

- **Q-Q Plot**: verificação de normalidade
- **Matriz de correlação (heatmap)**: correlações múltiplas
- **Pair Plot**: dispersão múltipla de variáveis

---

## 🐍 Implementação em Python

### Bibliotecas Essenciais

```python
import numpy as np              # Cálculos numéricos
import pandas as pd             # Manipulação de dados
import scipy.stats as stats     # Funções estatísticas
import matplotlib.pyplot as plt # Visualização básica
import seaborn as sns          # Visualização estatística
```

### Estatística Descritiva

```python
# Medidas de tendência central
dados.mean()    # Média
dados.median()  # Mediana
dados.mode()    # Moda

# Medidas de dispersão
dados.std()     # Desvio padrão
dados.var()     # Variância
dados.min()     # Mínimo
dados.max()     # Máximo

# Medidas de posição
dados.quantile([0.25, 0.5, 0.75])  # Quartis

# Resumo completo
dados.describe()
```

### Distribuições de Probabilidade

```python
from scipy.stats import norm, binom, poisson, t

# Distribuição Normal
norm.pdf(x, loc=mu, scale=sigma)    # Função densidade
norm.cdf(x, loc=mu, scale=sigma)    # Função acumulada
norm.ppf(q, loc=mu, scale=sigma)    # Quantil

# Distribuição Binomial
binom.pmf(k, n, p)                  # P(X = k)
binom.cdf(k, n, p)                  # P(X ≤ k)

# Distribuição de Poisson
poisson.pmf(k, mu)                  # P(X = k)

# Distribuição t de Student
t.ppf(q, df)                        # Quantil
```

### Testes de Hipóteses

```python
from scipy.stats import ttest_1samp, ttest_ind, ttest_rel
from scipy.stats import chi2_contingency, f_oneway

# Teste t para uma média
t_stat, p_value = ttest_1samp(dados, popmean=mu0)

# Teste t para duas médias independentes
t_stat, p_value = ttest_ind(grupo1, grupo2)

# Teste t pareado
t_stat, p_value = ttest_rel(antes, depois)

# ANOVA
f_stat, p_value = f_oneway(grupo1, grupo2, grupo3)

# Teste Qui-Quadrado
chi2, p_value, dof, expected = chi2_contingency(tabela)
```

### Correlação

```python
# Correlação de Pearson
correlacao = dados.corr()
dados['var1'].corr(dados['var2'])

# Correlação de Spearman
correlacao_spearman = dados.corr(method='spearman')
```

### Visualizações

```python
# Histograma
plt.hist(dados, bins=20, edgecolor='black')

# Box Plot
sns.boxplot(data=dados)

# Gráfico de dispersão
plt.scatter(x, y)
sns.scatterplot(x='var1', y='var2', data=df)

# Matriz de correlação
sns.heatmap(correlacao, annot=True, cmap='coolwarm')

# Q-Q Plot (teste de normalidade visual)
from scipy.stats import probplot
probplot(dados, dist="norm", plot=plt)
```

---

## 📊 Aplicações Práticas em Data Science

### 1. Análise Exploratória de Dados (EDA)

- Estatísticas descritivas para entender distribuições
- Identificação de outliers usando box plots e IQR
- Análise de correlações entre variáveis

### 2. Preparação de Dados para Machine Learning

- Teste de normalidade para escolha de transformações
- Análise de correlação para seleção de features
- Detecção de multicolinearidade

### 3. Validação de Modelos

- Testes de hipóteses para comparar performance
- Intervalos de confiança para métricas de avaliação
- Testes estatísticos para significância de features

### 4. A/B Testing

- Testes de hipóteses para comparar grupos de controle e tratamento
- Cálculo de tamanho de amostra necessário
- Determinação de significância estatística

### 5. Controle de Qualidade

- Gráficos de controle estatístico
- Testes de proporções e variâncias
- Análise de capacidade de processo

---

## 💡 Conceitos-Chave para Data Science

### Premissas dos Testes Estatísticos

1. **Normalidade**: dados seguem distribuição normal
2. **Independência**: observações independentes entre si
3. **Homocedasticidade**: variâncias homogêneas entre grupos
4. **Aleatoriedade**: amostragem aleatória

### Verificação de Premissas

- **Teste de Shapiro-Wilk**: normalidade (n < 50)
- **Teste de Shapiro-Francia**: normalidade (n ≥ 30)
- **Teste de Kolmogorov-Smirnov**: normalidade
- **Teste de Levene**: homocedasticidade
- **Teste de Bartlett**: homocedasticidade (assumindo normalidade)

### Quando Usar Testes Paramétricos vs Não Paramétricos

**Paramétricos** (mais poderosos, mas com premissas):

- Dados seguem distribuição conhecida (geralmente normal)
- Variáveis quantitativas
- Amostras grandes

**Não Paramétricos** (mais robustos, menos premissas):

- Distribuição desconhecida ou não normal
- Variáveis ordinais ou com outliers
- Amostras pequenas

---

## 📚 Materiais de Apoio

### Arquivos da Disciplina

- **PDF**: Fundamentos de Estatistica 0914 e 16052025pdf Portugues.pdf
- **Exercícios**: Lista de Exercicios Complementares (PDF e Excel)
- **Planilha**: Planilha Suporte - Fundamentos de Estatística

### Recursos Python

- **NumPy**: computação numérica
- **Pandas**: análise de dados
- **SciPy.stats**: funções estatísticas
- **Statsmodels**: modelagem estatística avançada
- **Seaborn**: visualizações estatísticas

---

## 🎯 Pontos Importantes para Memorizar

1. **Significância estatística ≠ Relevância prática**
   - Um resultado pode ser estatisticamente significativo mas sem importância prática

2. **P-valor não é a probabilidade de H₀ ser verdadeira**
   - É a probabilidade de observar os dados (ou mais extremos) assumindo H₀ verdadeira

3. **Tamanho da amostra importa**
   - Amostras grandes podem detectar diferenças pequenas
   - Amostras pequenas podem não detectar diferenças grandes

4. **Correlação ≠ Causalidade**
   - Sempre considerar variáveis confundidoras

5. **Escolha do teste apropriado**
   - Considerar tipo de variável, distribuição e premissas
   - Quando em dúvida, use testes não paramétricos

6. **Intervalo de Confiança > Teste de Hipótese**
   - IC fornece mais informação (magnitude e precisão)

---

## 📖 Referências Recomendadas

- Fávero, L. P., & Belfiore, P. (2017). Manual de Análise de Dados. Elsevier.
- Bussab, W. O., & Morettin, P. A. (2017). Estatística Básica. Saraiva.
- Montgomery, D. C., & Runger, G. C. (2018). Applied Statistics and Probability for Engineers.
- Field, A. (2013). Discovering Statistics Using IBM SPSS Statistics.

---

## ✅ Checklist de Estudo

- [ ] Compreender medidas descritivas (média, mediana, desvio padrão)
- [ ] Calcular probabilidades básicas
- [ ] Identificar e aplicar distribuições de probabilidade adequadas
- [ ] Construir e interpretar intervalos de confiança
- [ ] Formular hipóteses nula e alternativa
- [ ] Realizar e interpretar testes de hipóteses
- [ ] Calcular e interpretar correlações
- [ ] Verificar premissas de testes estatísticos
- [ ] Escolher teste apropriado para cada situação
- [ ] Criar visualizações adequadas para cada tipo de dado
- [ ] Interpretar resultados estatísticos no contexto do problema
- [ ] Implementar análises estatísticas em Python

---

**Última atualização**: Março 2026
**Curso**: MBA em Data Science e Analytics - USP/ESALQ
**Módulo**: 1 - Fundamentos de Estatística
