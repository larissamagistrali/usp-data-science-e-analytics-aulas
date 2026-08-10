# 🔵 Resumo - Unsupervised Machine Learning: Clustering (Análise de Cluster)

## MBA em Data Science e Analytics USP/ESALQ

### Prof. Dr. Wilson Tarantin Junior

---

## 🎯 Contextualização

- Quando aplicar a análise de cluster: quando o objetivo for **agrupar as observações** em grupos homogêneos internamente e heterogêneos entre si
  - **Dentro do grupo**: observações semelhantes com base nas variáveis utilizadas
  - **Entre grupos distintos**: observações diferentes com base nas variáveis utilizadas

### Exemplos de aplicação

- Segmentação de clientes para marketing
- Análises socioeconômicas e demográficas de regiões
- Detecção de fraudes em transações (transações atípicas)
- Controle de qualidade no processo produtivo
- Identificação de grupos de pacientes para prevenção de doenças

### Técnica exploratória (não supervisionada)

- Busca identificar o padrão latente de agrupamento presente nos dados: não há especificação prévia de quais grupos devem ser formados
- **Não tem caráter preditivo** para observações de fora da amostra
- Se observações forem adicionadas/retiradas da amostra, um **novo agrupamento** deve ser formado
- Se forem alteradas as variáveis da análise, um **novo agrupamento** deve ser realizado

---

## 📚 Métodos

Dois métodos analisados:

- **Método Hierárquico Aglomerativo**: a quantidade de clusters é definida ao longo da análise (passo a passo); método mais analítico e exploratório
- **Método Não Hierárquico K-means**: define-se a priori quantos clusters serão formados; método mais objetivo, pois baseia-se em minimização

---

## 1. Tratamento Inicial dos Dados

- Antes de iniciar, analisar as unidades de medida das variáveis
- Se estiverem em unidades/escalas distintas, **padronizar** antes da análise de cluster (aplica-se o Z-Score)

$$
Z X_{ji} = \frac{X_{ji} - \bar X_j}{s_j}
$$

Onde $\bar X_j$ é a média da variável $j$ e $s_j$ é o desvio padrão da variável $j$ (resulta em média = 0 e desvio padrão = 1)

```python
from scipy.stats import zscore
dados_pad = dados.apply(zscore, ddof=1)
```

---

## 2. Método Hierárquico Aglomerativo

### 2.1 Escolhas inerentes ao método

- **Medida de dissimilaridade (distância)**: quanto as observações são diferentes entre si, com base nas variáveis escolhidas
- **Método de encadeamento**: especifica qual distância considerar quando já existem clusters formados

### 2.2 Esquema de aglomeração

- Parte de $n$ observações separadas (estágio 0, $n$ clusters)
- Une-se as duas observações com **menor distância** ($n - 1$ clusters)
- Um novo grupo é formado pela união de duas observações ou pela inclusão de uma observação a um cluster já formado (sempre pela menor distância, conforme o método de encadeamento)
- Repete-se até restar 1 único cluster com todas as observações
- O **dendrograma** é o gráfico que permite visualizar essa formação

### 2.3 Medidas de dissimilaridade			



    

- **Distância euclidiana**: $d_{pq} = \sqrt{\sum_{j=1}^{k}(ZX_{jp} - ZX_{jq})^2}$
- **Distância euclidiana quadrática**: $d_{pq} = \sum_{j=1}^{k}(ZX_{jp} - ZX_{jq})^2$
- **Distância de Manhattan (City Block)**: $d_{pq} = \sum_{j=1}^{k}|ZX_{jp} - ZX_{jq}|$
- **Distância de Chebychev**: $d_{pq} = max\,|ZX_{jp} - ZX_{jq}|$
- **Distância de Canberra**: $d_{pq} = \sum_{j=1}^{k}\dfrac{|ZX_{jp}-ZX_{jq}|}{|ZX_{jp}| + |ZX_{jq}|}$
- A **correlação de Pearson** entre observações também pode ser usada, mas é uma medida de semelhança (ajustar a interpretação)

```python
from scipy.spatial.distance import pdist
dist_euclidiana = pdist(dados_pad, metric='euclidean')
# opções de metric: euclidean, sqeuclidean, cityblock, chebyshev, canberra, correlation
```

### 2.4 Métodos de encadeamento

| Método de Encadeamento                                   | Regra                                            | Recomendado quando                  |
| --------------------------------------------------------- | ------------------------------------------------ | ----------------------------------- |
| **Único** (Nearest neighbor / Single Linkage)      | $d_{(MN)W} = \text{mínimo}\{d_{MW}; d_{NW}\}$ | Observações distintas             |
| **Completo** (Furthest neighbor / Complete Linkage) | $d_{(MN)W} = \text{máximo}\{d_{MW}; d_{NW}\}$ | Observações parecidas             |
| **Médio** (Between groups / Average Linkage)       | $d_{(MN)W} = \text{média}\{d_{MW}; d_{NW}\}$  | Meio-termo entre os dois anteriores |

```python
import scipy.cluster.hierarchy as sch
dend = sch.linkage(dados_pad, method='complete', metric='euclidean')
sch.dendrogram(dend, color_threshold=8)
plt.axhline(y=8, color='red', linestyle='--')
plt.show()
# method: single, complete, average
```

### 2.5 Exemplo numérico manual (Single, Complete e Average Linkage)

Exemplo do material complementar, com 5 estudantes e as notas em matemática, física e química (distância euclidiana):

- Distâncias iniciais entre pares: Gabriela-Luiz Felipe = 10,13; Gabriela-Patrícia = 8,42; Gabriela-Ovídio = 3,71; Gabriela-Leonor = 4,17; Luiz Felipe-Patrícia = 7,19; Luiz Felipe-Ovídio = 10,29; Luiz Felipe-Leonor = 8,22; Patrícia-Ovídio = 6,58; Patrícia-Leonor = 6,04; Ovídio-Leonor = 5,47

**Single Linkage (mínimo)**:

1. 1º estágio: Gabriela-Ovídio = 3,71 → cluster {Gabriela, Ovídio}
2. 2º estágio: d(Gab-Ovídio)Leonor = mín{4,17; 5,47} = 4,17 → {Gabriela, Ovídio, Leonor}
3. 3º estágio: d(Gab-Ovídio-Leonor)Patrícia = mín{8,42; 6,58; 6,04} = 6,04 → {Gabriela, Ovídio, Leonor, Patrícia}
4. 4º estágio: d(...)Luiz Felipe = mín{10,13; 10,29; 8,22; 7,19} = 7,19 → cluster único final

**Complete Linkage (máximo)**:

1. 1º estágio: Gabriela-Ovídio = 3,71 → {Gabriela, Ovídio}
2. 2º estágio: Ovídio-Leonor = 5,47 → {Gabriela, Ovídio, Leonor} (usando o máximo das distâncias)
3. 3º estágio: Luiz Felipe-Patrícia = 7,19 → como esse par isolado tem distância menor que unir ao cluster já formado, forma-se um novo cluster {Luiz Felipe, Patrícia}
4. 4º estágio: une-se os dois clusters remanescentes com d = 10,29 (máximo entre todos os pares)

**Average Linkage (média)**:

1. 1º estágio: Gabriela-Ovídio = 3,71 → {Gabriela, Ovídio}
2. 2º estágio: d(Gab-Ovídio)Leonor = (4,17+5,47)/2 = 4,82 → {Gabriela, Ovídio, Leonor}
3. 3º estágio: d(Gab-Ovídio-Leonor)Patrícia = (8,42+6,58+6,04)/3 = 7,01 → {Gabriela, Ovídio, Leonor, Patrícia}
4. 4º estágio: d(...)Luiz Felipe = (10,13+10,29+8,22+7,19)/4 = 8,95 → cluster único final

> Observação do material: quando as variáveis já estão na mesma escala (ex.: notas de 0 a 10), o Z-Score não precisa ser aplicado antes do cálculo — avaliar caso a caso.

### 2.6 Quantos clusters escolher?

- Critério: observar o **tamanho dos saltos de distância** no dendrograma
- Saltos elevados podem indicar a união de observações mais distintas (grupos heterogêneos)
- É importante comparar dendrogramas obtidos por diferentes métodos de encadeamento

```python
from sklearn.cluster import AgglomerativeClustering
cluster_comp = AgglomerativeClustering(n_clusters=5, metric='euclidean', linkage='complete')
indica_cluster = cluster_comp.fit_predict(dados_pad)
dados['cluster'] = indica_cluster
dados['cluster'] = dados['cluster'].astype('category')
```

### 2.7 Análise dos agrupamentos (Teste F / ANOVA)

- Após a clusterização, compara-se se a **variabilidade dentro do grupo** é menor que a **variabilidade entre grupos**

$$
F = \frac{\text{Variabilidade entre grupos}}{\text{Variabilidade dentro dos grupos}}
$$

- Graus de liberdade no numerador: $K - 1$ (K = número de clusters)
- Graus de liberdade no denominador: $n - K$ (n = tamanho da amostra)
- Hipóteses do teste F (ANOVA um fator):
  - $H_0$: a variável apresenta a mesma média em todos os grupos formados
  - $H_1$: a variável apresenta média diferente em pelo menos um dos grupos em relação aos demais grupos
- A variável mais discriminante é a que apresenta **maior estatística F** (com significância)

```python
import pingouin as pg
pg.anova(dv='child_mort', between='cluster_complete', data=paises_pad, detailed=True).T
```

---

## 3. Método Não Hierárquico K-means

### 3.1 Esquema de aglomeração

- A quantidade **K** de clusters é escolhida **a priori** e usada para identificar os centros de aglomeração (centroides)
- Os K centroides iniciais são determinados **aleatoriamente**; as observações são alocadas ao centroide mais próximo
- Recalcula-se o valor de cada centroide como a média dos pontos do grupo
- Ao recalcular, observações podem mudar de cluster (processo iterativo)
- O processo encerra quando não há mais realocações possíveis (centroides não se alteram mais)
- A solução final minimiza o **WCSS** (Within-Cluster Sum of Squares):

$$
WCSS = \sum_{k=1}^{K}\sum_{x_i \in C_k} \|x_i - \mu_k\|^2
$$

```python
from sklearn.cluster import KMeans
kmeans = KMeans(n_clusters=3, init='random', random_state=100).fit(dados_pad)
clusters = kmeans.labels_
dados['cluster_kmeans'] = clusters
dados['cluster_kmeans'] = dados['cluster_kmeans'].astype('category')

# Centroides finais
centroides = pd.DataFrame(kmeans.cluster_centers_)
centroides.columns = dados_pad.columns
centroides.index.name = 'cluster'
```

### 3.2 Identificação da quantidade de clusters (K)

**Método de Elbow**:

- Calcula-se o WCSS para várias opções de K
- No gráfico, busca-se a dobra ("cotovelo"): ponto a partir do qual a redução no WCSS deixa de ser expressiva

```python
elbow = []
K = range(1, 11)
for k in K:
    kmean = KMeans(n_clusters=k, init='random', random_state=100).fit(dados_pad)
    elbow.append(kmean.inertia_)  # inertia_ = WCSS

plt.plot(K, elbow, marker='o')
plt.xlabel('Nº Clusters')
plt.ylabel('WCSS')
plt.title('Método de Elbow')
plt.show()
```

**Método da Silhueta**:

- Para cada observação, calcula-se (a) a distância média dentro do cluster onde está alocada e (b) a distância média para o cluster mais próximo onde não está alocada

$$
\text{silhueta} = \frac{(b-a)}{\max(a,b)}
$$

- Quanto mais próximo de **1**, melhor a clusterização; quanto mais próximo de **-1**, pior
- Calcula-se a silhueta média para várias opções de K e escolhe-se a de maior valor

```python
from sklearn.metrics import silhouette_score
silhueta = []
K = range(2, 11)
for k in K:
    kmean = KMeans(n_clusters=k, init='random', random_state=100).fit(dados_pad)
    silhueta.append(silhouette_score(dados_pad, kmean.labels_))

plt.plot(K, silhueta, color='purple', marker='o')
max_sil = silhueta.index(max(silhueta)) + 2
plt.axvline(x=max_sil, linestyle='dotted', color='red')
plt.show()
```

---

## 4. Considerações Finais

- A análise de cluster é **bastante sensível à presença de outliers**
- Quando há variáveis categóricas, aplica-se a **Análise de Correspondência**
- O output do método hierárquico pode ser usado como **input** para o método não hierárquico, na identificação inicial da quantidade de clusters
- O K-means pode ser aplicado em amostras maiores, pois o dendrograma torna-se difícil de analisar com muitas observações

---

## 🐍 Exemplos Práticos em Python (scripts da aula)

### 1. Segmentação de Países (`Script - Países.py`)

- Base: `dados_paises.csv` (Kaggle - Unsupervised Learning on Country Data)
- Variáveis: `child_mort`, `exports`, `imports`, `health`, `income`, `inflation`, `life_expec`, `total_fer`, `gdpp`
- Fluxo: estatísticas descritivas → matriz de correlação (heatmap) → padronização Z-Score → dendrogramas (single, average, complete linkage, distância euclidiana) → `AgglomerativeClustering` com **5 clusters**, linkage complete → ANOVA (`pg.anova`) para cada variável → gráficos 3D (`plotly`) → estatísticas descritivas por cluster

### 2. Segmentação de Clientes de Cartão de Crédito (`Script - Cartão.py`)

- Base: `cartao_credito.csv` (Kaggle - Credit Card Customer Data)
- Objetivo: agrupar clientes por comportamento de uso (avaliar lealdade à marca)
- Variáveis: `Avg_Credit_Limit`, `Total_Credit_Cards`, `Total_visits_bank`, `Total_visits_online`, `Total_calls_made`
- Fluxo: remoção de IDs (`Sl_No`, `Customer Key`) → padronização Z-Score → gráfico 3D inicial → **Método de Elbow** (K de 1 a 10) → **Método da Silhueta** (K de 2 a 10) → K-means final com **3 clusters** (`init='random'`, `random_state=100`) → ANOVA por variável → gráficos 3D em 3 perspectivas → médias por cluster

### 3. Regional Varejista (`Script - Regional.py`)

- Base: `regional_varejista.xlsx` (Fávero & Belfiore, 2024, Capítulo 9)
- Variáveis (mesma escala, **sem padronização**): `atendimento`, `sortimento`, `organização`
- Fluxo: dendrograma single linkage + distância cityblock (corte em 60) → `AgglomerativeClustering` com **3 clusters** → dendrograma complete linkage + distância euclidiana (corte em 55) → K-means com **3 clusters** (mesmo padrão dos métodos hierárquicos) → Método da Silhueta (K de 2 a 8: silhueta praticamente igual em 2 ou 3 — optou-se por manter 3 para melhor interpretação) → centroides finais → ANOVA por variável → gráfico 3D

### 4. Vestibular (`Script - Vestibular.py`)

- Base: `vestibular.xlsx` (Fávero & Belfiore, 2024, Capítulo 9)
- Variáveis (notas de 0 a 10, **mesma escala — não é necessário padronizar**): `matemática`, `física`, `química`
- Boxplot confirma que a padronização não é necessária nesse caso
- Fluxo: dendrogramas single (corte 4,5), complete (corte 6) e average linkage (corte 6), todos com distância euclidiana → `AgglomerativeClustering` com **3 clusters** para cada linkage → Método de Elbow (K de 1 a 4) → K-means com **3 clusters** → centroides finais → ANOVA por variável (matemática, física, química) → gráfico 3D com rótulo de estudante

---

## 📚 Bibliotecas Python Utilizadas

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.cluster.hierarchy as sch
from scipy.stats import zscore
from scipy.spatial.distance import pdist
from sklearn.cluster import AgglomerativeClustering, KMeans
from sklearn.metrics import silhouette_score
import pingouin as pg
import plotly.express as px
import plotly.io as pio
pio.renderers.default = 'browser'
```

Instalação (executar no console, sem o `#`):

```
pip install pandas numpy matplotlib seaborn plotly scipy scikit-learn pingouin
```

---

## 📖 Referência / Sugestão de Leitura

- Fávero, Luiz Paulo; Belfiore, Patrícia. (2024). *Manual de análise de dados: estatística e machine learning com Excel®, SPSS®, Stata®, R® e Python®*. 2 ed. Rio de Janeiro: LTC.

---

**Módulo**: 14 - Unsupervised Machine Learning: Clustering
**Curso**: MBA em Data Science e Analytics - USP/ESALQ
**Professor**: Dr. Wilson Tarantin Junior
