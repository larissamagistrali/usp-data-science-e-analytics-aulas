# 🔵 Resumo - Unsupervised Machine Learning: Exercícios Aplicados

## MBA em Data Science e Analytics USP/ESALQ
### Prof. Dr. Wilson Tarantin Junior

---

## 🎯 Técnicas Não Supervisionadas: Revisão

### Características gerais
- Avaliam a **relação conjunta entre as variáveis** (interdependência); também chamadas de técnicas **exploratórias** → o objetivo é descobrir os padrões ocultos nos dados
- Úteis para lidar com dados **"não rotulados"** → não há a proposição de modelos que especificam relações de dependência $Y = f(X)$
- **Não são adequadas para fins de inferência**: não têm caráter preditivo para observações de fora da amostra
- Se observações (ou variáveis) forem adicionadas ou retiradas do banco de dados, é adequado **refazer a análise**

### Análise de Cluster
- **Objetivo**: agrupamento de observações em grupos homogêneos internamente e heterogêneos entre si
  - Dentro do grupo: observações semelhantes com base nas variáveis utilizadas
  - Entre grupos distintos: observações diferentes com base nas variáveis utilizadas
- Fundamenta-se em **medidas de distância (dissimilaridades)** entre observações → utiliza **variáveis métricas**

### Análise Fatorial (PCA)
- **Objetivo**: agrupamento das variáveis métricas (combinação das variáveis originais em fatores)
- Depende das **correlações entre variáveis** → foco em variáveis métricas
- Possíveis finalidades:
  - Obter o comportamento conjunto de variáveis, combinando-as para **redução estrutural**
  - Análise da validade de construtos pela identificação das variáveis alocadas aos fatores
  - Elaboração de **rankings** de desempenho por meio dos fatores
  - Criação de **fatores ortogonais** para posterior uso em modelos supervisionados

### Análise de Correspondência
- **Objetivo**: identificar a associação entre **variáveis categóricas**
- Verificar se existe associação estatisticamente significativa entre as variáveis qualitativas (duas ou mais) e entre suas categorias
- Busca-se criar o **mapa perceptual** para visualizar as associações — análise pela proximidade das categorias no mapa

---

## 🔗 Uso Conjunto das Técnicas Não Supervisionadas

- É possível utilizar as técnicas não supervisionadas **conjuntamente**, desde que respeitadas as características das variáveis (quantitativas ou qualitativas)
- Feito isso, o **output de uma técnica pode ser utilizado como input em outra**

**Exemplos citados no material:**
- Utilizar o output do cluster como input em uma análise de correspondência
- Realizar uma análise de cluster com base em fatores selecionados na análise fatorial
- Obter as coordenadas das observações de um mapa perceptual (análise de correspondência) e utilizá-las em uma clusterização ou análise fatorial PCA

Os três scripts da aula ilustram, cada um, uma dessas combinações na prática.

---

## 🐍 Exercícios Aplicados (scripts da aula)

### 1. Preço de Casas — MCA (variáveis qualitativas) + PCA (variáveis quantitativas) — `SCRIPT - Casas (Completo).py`
- Base: `preco_casas_completo.xlsx` (Kaggle — Jiff's House Price Prediction Dataset)
- **Etapa 1 — ACM nas variáveis qualitativas**: `large_living_room`, `parking_space`, `front_garden`, `swimming_pool`, `wall_fence`, `water_front`, `room_size_class`
  - Tabelas de frequência de cada variável → testes qui-quadrado de todas contra `large_living_room` (referência) → `prince.MCA(n_components=2)` → autovalores → coordenadas-padrão das categorias → **coordenadas-padrão das observações** (`mca.row_coordinates`) → mapa perceptual (`seaborn`)
- **Etapa 2 — PCA nas variáveis quantitativas**: `land_size_sqm`, `house_size_sqm`, `no_of_rooms`, `no_of_bathrooms`, `distance_to_school`, `house_age`, `distance_to_supermarket_km`, `crime_rate_index`
  - **As coordenadas das observações obtidas na ACM são concatenadas ao banco de variáveis quantitativas** (`pd.concat`), entrando como variáveis adicionais na análise fatorial
  - Teste de Bartlett → `FactorAnalyzer` com todos os fatores possíveis (`n_factors=10`) → autovalores → **critério da raiz latente automatizado** (`sel_fator = sum(autovalores > 1)`) → refeito com a quantidade de fatores selecionada → tabela de autovalores/variância, cargas fatoriais, comunalidades → extração dos fatores para as observações → scores fatoriais (gráfico de barras)
  - Exemplo prático do "uso conjunto": **coordenadas de um mapa perceptual (ACM) viram input de uma análise fatorial PCA**

### 2. Notas do PISA — PCA (ranking) + Teste Qui-Quadrado — `SCRIPT - PISA.py`
- Base: `notas_pisa.csv` (OECD PISA Data Explorer)
- Mantidas apenas as notas de 2022 (`mathematics_2022`, `reading_2022`, `science_2022`); conversão para numérico e remoção de valores faltantes (`dropna`)
- Fluxo: matriz de correlação de Pearson (heatmap) → estatísticas descritivas → teste de Bartlett → `FactorAnalyzer` inicial com `n_factors=3` (todos) → autovalores → **critério da raiz latente**: apenas 1 autovalor > 1 → refeito com `n_factors=1` → tabela de autovalor/variância, cargas fatoriais, comunalidades → extração de um **único fator** (`fator_2022`), usado para **ordenar os países** (`sort_values`, ranking direto pelo fator, já que há apenas 1 fator)
- **Categorização do fator**: `pd.qcut` em 4 grupos (`menores`, `médio_menor`, `médio_maior`, `maiores`)
- **Teste de associação (ANACOR)**: tabela de contingência entre a categoria do fator e a variável `group` (grupo do país) → teste qui-quadrado → resíduos padronizados ajustados (`sm.stats.Table`) → mapa de calor interativo (`plotly`, destaque para valores > 1,96)
- **Conclusão do próprio script**: como a variável `group` tem apenas 2 categorias, $m = \min(I-1,J-1) = 1$, não havendo mapa perceptual bidimensional — a análise se encerra nos resíduos padronizados ajustados; havendo mais variáveis categóricas, poderia ser feita uma ACM
- Exemplo prático do "uso conjunto": **fator da PCA categorizado e testado via ANACOR/qui-quadrado**

### 3. Segmentação de Clientes — Cluster (K-means) + ANOVA + MCA — `SCRIPT - Segmentação.py`
- Base: `clientes_segmenta.xlsx` (adaptado de Kaggle — Customer Segmentation), remoção de valores faltantes (`dropna`)
- **Etapa 1 — Clusterização nas variáveis quantitativas** `Age` e `FamilySize`:
  - Padronização Z-Score → Método de Elbow (K de 1 a 10) → Método da Silhueta (K de 2 a 10) → K-means final com **5 clusters** (`init='random'`, `random_state=100`)
  - ANOVA (`pg.anova`) para `Age` e `FamilySize` por cluster, validando a significância das variáveis na clusterização → médias de idade e tamanho da família por cluster
- **Etapa 2 — ACM nas variáveis qualitativas, incluindo o cluster como categoria**:
  - Variáveis: `Gender`, `EverMarried`, `Graduated`, `SpendingScore` e **`Cluster`** (resultado do K-means, tratado como variável categórica)
  - Testes qui-quadrado de cada variável contra `SpendingScore` (referência) → todas com associação significativa → `prince.MCA(n_components=3)` → autovalores, inércia total → **inércia média por dimensão** (critério para reter dimensões) → coordenadas-padrão das categorias → mapa perceptual 3D interativo (`plotly.express.scatter_3d`, exportado em `segmenta.html`)
- Exemplo prático do "uso conjunto": **o cluster obtido no K-means é incluído como variável categórica em uma MCA**

---

## 📚 Bibliotecas Python Utilizadas

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.stats import zscore, chi2_contingency
from factor_analyzer import FactorAnalyzer
from factor_analyzer.factor_analyzer import calculate_bartlett_sphericity
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
import pingouin as pg
import statsmodels.api as sm
import prince
import plotly.express as px
import plotly.graph_objects as go
```

Instalação (executar no console, sem o `#`):
```
pip install pandas numpy matplotlib seaborn scipy statsmodels factor_analyzer prince scikit-learn pingouin plotly
```

---

## 📖 Referência / Sugestão de Leitura

- Fávero, Luiz Paulo; Belfiore, Patrícia. (2024). *Manual de análise de dados: estatística e machine learning com Excel®, SPSS®, Stata®, R® e Python®*. 2 ed. Rio de Janeiro: LTC.

---

**Módulo**: 17 - Unsupervised Machine Learning: Exercícios Aplicados
**Curso**: MBA em Data Science e Analytics - USP/ESALQ
**Professor**: Dr. Wilson Tarantin Junior
