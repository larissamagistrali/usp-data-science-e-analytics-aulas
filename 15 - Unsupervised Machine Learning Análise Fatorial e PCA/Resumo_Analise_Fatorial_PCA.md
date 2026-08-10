# 🔵 Resumo - Unsupervised Machine Learning: Análise Fatorial e PCA

## MBA em Data Science e Analytics USP/ESALQ
### Prof. Dr. Wilson Tarantin Junior

---

## 🎯 Contextualização

### Quando aplicar a análise fatorial?
- Quando as **variáveis forem métricas**: depende das correlações de Pearson
- Trata-se do **agrupamento das variáveis originais em fatores**, buscando analisar o comportamento conjunto dessas variáveis. Os objetivos podem ser:
  - **Redução estrutural**: diminuição da dimensão do banco de dados
  - **Análise de construtos**: identificação das variáveis alocadas aos fatores
  - **Elaboração de rankings** para classificação com base nos fatores extraídos
  - **Criação de fatores ortogonais** para posterior uso em modelos supervisionados

### Exemplos de aplicação
- Geração de indicadores socioeconômicos
- Avaliação de desempenho acadêmico
- Gestão de marcas (pesquisa de opinião e percepção)
- Testes psicológicos (traços psicológicos ou construtos não observáveis)

### Análise fatorial por componentes principais (PCA)
- **Componentes principais**: método de determinação dos fatores que se baseia na criação de fatores **não correlacionados** a partir da combinação linear das variáveis originais
- **Análise fatorial PCA**: modelo **não supervisionado** de machine learning
- O intuito é encontrar um padrão latente nas relações entre as variáveis
- **Não tem caráter preditivo** para observações fora da amostra
- Se mudarem as observações e/ou as variáveis, **novos fatores atualizados** devem ser gerados

---

## 1. Matriz de Correlações de Pearson

- A PCA fundamenta-se na **existência de correlações** entre variáveis originais para a criação dos fatores
- Coeficiente de correlação de Pearson: relação linear entre duas variáveis métricas
- **Correlações próximas dos valores extremos** (-1; +1) propiciam a extração de um único fator (indicam relação entre variáveis)
- **Correlações próximas de zero** propiciam a extração de diferentes fatores (relação praticamente inexistente)

$$
\rho = \begin{bmatrix} 1 & \rho_{12} & \dots & \rho_{1k} \\ \rho_{21} & 1 & \dots & \rho_{2k} \\ \vdots & \vdots & \ddots & \vdots \\ \rho_{k1} & \rho_{k2} & \dots & 1 \end{bmatrix}
\qquad
\rho_{12} = \frac{\sum_{i=1}^{n}(X_{1i}-\bar X_1)(X_{2i}-\bar X_2)}{\sqrt{\sum_{i=1}^{n}(X_{1i}-\bar X_1)^2}\cdot\sqrt{\sum_{i=1}^{n}(X_{2i}-\bar X_2)^2}}
$$

```python
import pingouin as pg
pg.rcorr(notas_pca, method='pearson', upper='pval', decimals=4,
         pval_stars={0.01: '***', 0.05: '**', 0.10: '*'})
```

---

## 2. Adequação Global da Análise (Teste de Esfericidade de Bartlett)

- Para que a análise fatorial seja viável, devem existir valores mais elevados (em direção a -1 e +1) e estatisticamente significantes na matriz de correlações
- Avalia se os coeficientes de correlação de Pearson são **estatisticamente diferentes de zero**, comparando a matriz de correlações com a matriz identidade de mesma dimensão

$$
H_0: \rho = I \qquad H_1: \rho \neq I
$$

$$
\chi^2_{Bartlett} = -\left[(n-1) - \left(\frac{2k+5}{6}\right)\right]\cdot \ln|D| \quad \text{com } \frac{k\cdot(k-1)}{2} \text{ graus de liberdade}
$$

- Espera-se que $\rho$ e $I$ sejam estatisticamente diferentes para que a análise fatorial seja aplicável

```python
from factor_analyzer.factor_analyzer import calculate_bartlett_sphericity
bartlett, p_value = calculate_bartlett_sphericity(notas_pca)
```

**Exemplo real (base `notas_fatorial.xlsx`, variáveis finanças/custos/marketing/atuária)**: Qui² Bartlett = 191,88; graus de liberdade = 6; p-valor ≈ 1,01×10⁻³⁸ → rejeita-se $H_0$, análise fatorial aplicável.

---

## 3. Autovalores

- A matriz de correlações ($\rho$), de dimensão K x K, apresenta K autovalores ($\lambda$), obtidos pela solução de:

$$
\det(\rho - \lambda \cdot I) = 0
$$

- As raízes da equação característica da matriz são os **autovalores**
- **Os autovalores mostram o percentual da variância compartilhada** pelas variáveis originais para a formação de cada fator extraído — a quantidade de informação (variância) explicada por cada fator

```python
fa = FactorAnalyzer(n_factors=4, method='principal', rotation=None).fit(notas_pca)
autovalores = fa.get_eigenvalues()[0]
```

**Exemplo real (base Notas)**: $\lambda_1$ = 2,5181 (62,95%); $\lambda_2$ = 1,0004 (25,01%); $\lambda_3$ = 0,2976 (7,44%); $\lambda_4$ = 0,1839 (4,60%) — soma total = 4 (número de variáveis).

---

## 4. Autovetores

- Os autovetores da matriz de correlações são obtidos para cada autovalor, resolvendo o sistema:

$$
\begin{bmatrix} 1-\lambda & \rho_{12} & \dots & \rho_{1k} \\ \rho_{21} & 1-\lambda & \dots & \rho_{2k} \\ \vdots & \vdots & \ddots & \vdots \\ \rho_{k1} & \rho_{k2} & \dots & 1-\lambda \end{bmatrix}
\cdot
\begin{bmatrix} v_{1k} \\ v_{2k} \\ \vdots \\ v_{kk} \end{bmatrix}
=
\begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix}
$$

- Os autovetores contêm as combinações das variáveis originais que expressam os **principais padrões de correlação** nos dados: como as variáveis se comportam juntas e os contrastes entre elas. Representam as dimensões latentes do relacionamento entre variáveis

---

## 5. Obtenção dos Fatores e Scores Fatoriais

- **Scores fatoriais**: parâmetros que relacionam o fator com as variáveis originais, em um modelo linear
- Para K variáveis originais, existem no máximo K fatores ($F_1, F_2, ..., F_K$)
- Os scores fatoriais são obtidos a partir dos autovalores e autovetores da matriz de correlações:

$$
s_k = \begin{bmatrix} s_{1k} \\ s_{2k} \\ \vdots \\ s_{kk} \end{bmatrix} = \begin{bmatrix} v_{1k}/\sqrt{\lambda_k} \\ v_{2k}/\sqrt{\lambda_k} \\ \vdots \\ v_{kk}/\sqrt{\lambda_k} \end{bmatrix}
$$

- O valor de cada fator é obtido a partir das variáveis padronizadas por Z-Score ($ZX$). Os fatores são **ortogonais entre si** (não correlacionados):

$$
F_{1i} = \frac{v_{11}}{\sqrt{\lambda_1}}\cdot ZX_{1i} + \frac{v_{21}}{\sqrt{\lambda_1}}\cdot ZX_{2i} + \dots + \frac{v_{k1}}{\sqrt{\lambda_1}}\cdot ZX_{ki}
$$

```python
fatores = pd.DataFrame(fa.transform(notas_pca))
scores = fa.weights_  # scores fatoriais
```

### Exemplo numérico manual (lousa da aula, base Notas)

Fórmulas dos 2 primeiros fatores para a base finanças/custos/marketing/atuária:

$$
F_{1i} = 0{,}356\cdot ZFin_i + 0{,}371\cdot ZCustos_i - 0{,}017\cdot ZMkt_i + 0{,}364\cdot ZAtuária_i
$$
$$
F_{2i} = 0{,}007\cdot ZFin_i + 0{,}049\cdot ZCustos_i + 0{,}999\cdot ZMkt_i - 0{,}01\cdot ZAtuária_i
$$

Para a estudante **Gabriela** ($ZFin=-0{,}0109$; $ZCustos=-0{,}2934$; $ZMkt=-1{,}658$; $ZAtuária=0{,}2743$):

$$
F_{1,Gabriela} = 0{,}356\cdot(-0{,}0109) + 0{,}371\cdot(-0{,}2934) - 0{,}017\cdot(-1{,}658) + 0{,}364\cdot(0{,}2743) = 0{,}0152
$$
$$
F_{2,Gabriela} = 0{,}007\cdot(-0{,}0109) + 0{,}049\cdot(-0{,}2934) + 0{,}999\cdot(-1{,}658) - 0{,}01\cdot(0{,}2743) = -1{,}673
$$

---

## 6. Seleção de Fatores: Critério de Kaiser (Raiz Latente)

- Embora seja possível estabelecer a priori quantos fatores são desejados, é fundamental analisar a **magnitude dos autovalores**
- Fatores formados a partir de autovalores **menores do que 1** podem não ter representatividade
- **Critério de Kaiser**: considerar apenas fatores com **autovalor > 1**
  - Autovalor > 1 significa que o fator explica mais variância do que uma variável original isoladamente

**Exemplo real (base Notas)**: dos 4 autovalores (2,5181; 1,0004; 0,2976; 0,1839), apenas os 2 primeiros são > 1 → seleciona-se **2 fatores**, que juntos explicam 87,96% da variância.

```python
# Critério de Kaiser identificado -> refazer com n_factors = nº de autovalores > 1
fa = FactorAnalyzer(n_factors=2, method='principal', rotation=None).fit(notas_pca)
```

---

## 7. Cargas Fatoriais

- Mostram as **correlações de Pearson entre os fatores e as variáveis originais**
- Interpretadas como a importância de cada variável original para a constituição daquele fator
- Quanto maior a carga fatorial, mais o fator é influenciado pela variável original

```python
cargas_fatoriais = fa.loadings_
```

**Exemplo real (base Notas, 2 fatores)**:

| Variável | Fator 1 | Fator 2 |
|---|---|---|
| finanças | 0,8954 | 0,0071 |
| custos | 0,9340 | 0,0486 |
| marketing | -0,0425 | 0,9989 |
| atuária | 0,9177 | -0,0101 |

→ Fator 1 concentra finanças/custos/atuária; Fator 2 é dominado por marketing.

### Loading Plot
Gráfico de dispersão das cargas fatoriais (Fator 1 x Fator 2) para visualizar quais variáveis mais se associam a cada fator.

```python
plt.scatter(tabela_cargas['Fator 1'], tabela_cargas['Fator 2'])
plt.axhline(y=0, color='grey', ls='--')
plt.axvline(x=0, color='grey', ls='--')
```

---

## 8. Comunalidades

- Ao aplicar o critério da raiz latente, apenas os fatores com autovalor > 1 são considerados
- As **comunalidades** mostram a variância total compartilhada, por variável, em todos os fatores extraídos e selecionados
- Permitem analisar se houve perda de variância por variável após a exclusão de fatores: quanta informação das variáveis originais é retida nos fatores selecionados

```python
comunalidades = fa.get_communalities()
```

---

## 9. Rotação de Fatores (Varimax)

- Em certos casos, a **rotação de fatores** pode melhorar a interpretação (analisada pelo loading plot)
- Método mais comum: **varimax** — rotação ortogonal dos fatores
- Objetivo: aumentar a carga fatorial em um fator e diminuir em outro (redistribuição de cargas fatoriais)
- A rotação **redistribui a variância entre os fatores**, mas o total permanece o mesmo
- As **comunalidades não se alteram**; as **cargas fatoriais e os scores fatoriais são alterados** (fatores rotacionados)
- Os fatores continuam **ortogonais** entre si após a rotação

```python
fa = FactorAnalyzer(n_factors=2, method='principal', rotation='varimax').fit(emprestimo_pca)
```

---

## 10. Criação de Rankings (Soma Ponderada e Ordenamento)

- Para criar rankings a partir dos fatores extraídos, calcula-se para cada observação:

$$
R_i = (F_{1i}\times \%\text{var. comp. } F_1) + (F_{2i}\times \%\text{var. comp. } F_2) + \dots + (F_{ki}\times \%\text{var. comp. } F_k)
$$

- Multiplica-se o resultado de cada fator pelo respectivo percentual de variância compartilhada, somando-se em seguida; depois, ordena-se o resultado

```python
notas['Ranking'] = 0
for index, item in enumerate(list(tabela_eigen.index)):
    variancia = tabela_eigen.loc[item]['Variância']
    notas['Ranking'] = notas['Ranking'] + notas[tabela_eigen.index[index]] * variancia
```

---

## 🐍 Exemplos Práticos em Python (scripts da aula)

### 1. Notas de Estudantes (`Script - Notas.py`)
- Base: `notas_fatorial.xlsx` (Fávero & Belfiore, 2024, Capítulo 10)
- Variáveis: `finanças`, `custos`, `marketing`, `atuária`
- Fluxo: matriz de correlação de Pearson (`pg.rcorr` + heatmap) → Teste de Bartlett → `FactorAnalyzer` inicial com `n_factors=4` (todos possíveis), `method='principal'`, `rotation=None` → autovalores e variância acumulada (gráfico de barras) → cargas fatoriais e loading plot → comunalidades → extração dos fatores (`fa.transform`) → scores fatoriais (`fa.weights_`) → confirmação de que os fatores extraídos são ortogonais (correlação = 0) → **Critério de Kaiser**: 2 autovalores > 1 → refeito com `n_factors=2` (cargas fatoriais e scores não se alteram, apenas a seleção) → **Ranking** por soma ponderada usando a variância de cada um dos 2 fatores retidos

### 2. Preço de Casas (`Script - Casas.py`)
- Base: `preco_casas.xlsx` (adaptado de Kaggle — Jiff's House Price Prediction Dataset)
- Objetivo: extrair fatores que capturem o preço de venda das casas; a variável `property_value` é **mantida fora** da análise fatorial (apenas para validação posterior)
- Fluxo: estatísticas descritivas → matriz de correlação (heatmap) → Bartlett → `FactorAnalyzer` com `n_factors=8` (todos) → autovalores → **critério de Kaiser**: 3 autovalores > 1 → refeito com `n_factors=3` → gráfico de variância acumulada → cargas fatoriais (gráfico de barras por variável) → comunalidades → extração dos fatores → scores fatoriais (gráfico de barras) → **Ranking** (soma ponderada dos 3 fatores) → correlação entre `Ranking` e `property_value` (`pg.rcorr`) para checar se os fatores se alinham ao preço de venda

### 3. Empréstimo Bancário (`Script - Empréstimo.py`)
- Base: `emprestimo_banco.xlsx` (adaptado de Kaggle — Bank Loan Modelling), removida a coluna `ID`
- Fluxo: matriz de correlação (heatmap interativo `plotly.graph_objects`, exportado em `correl_emprestimo.html`) → Bartlett → `FactorAnalyzer` com `n_factors=6` (todos) → autovalores → **critério de Kaiser**: 2 autovalores > 1 → refeito com `n_factors=2` → cargas fatoriais e loading plot → comunalidades → extração dos fatores → scores fatoriais
- Demonstra a **rotação Varimax**: reaplica `FactorAnalyzer` com `rotation='varimax'` sobre os 2 fatores → nova tabela de autovalores/variância (redistribuída, mas soma igual) → novas cargas fatoriais e novo loading plot (fatores rotacionados) → comunalidades inalteradas → novos scores fatoriais (gráfico de barras) → confirmação de que os fatores continuam ortogonais após a rotação

### 4. Atlas Ambiental de São Paulo (`Script - Atlas SP.py`)
- Base: `atlas_ambiental.xlsx`, removidas `cód_ibge` e `distritos`
- Fluxo: matriz de correlação (heatmap interativo `plotly`, exportado em `correl_atlas.html`) → Bartlett → `FactorAnalyzer` com `n_factors=9` (todos) → autovalores → **critério de Kaiser** → refeito com `n_factors=2` → gráfico de variância acumulada → cargas fatoriais e loading plot → comunalidades → extração dos fatores
- Considera o **Fator 1** como indicador socioeconômico para rankear os distritos (critério distinto da soma ponderada)
- **Visualização geográfica**: importa o shapefile `DEINFO_DISTRITO` (mapa dos distritos de São Paulo — fonte: `dados.prefeitura.sp.gov.br/dataset/distritos`) via biblioteca `shapefile` (pyshp) → função para ler o shapefile e montar um DataFrame de coordenadas → plotagem do contorno dos distritos → divisão dos valores do Fator 1 em **6 faixas** (`pd.qcut`) com paleta de cores (`seaborn`, `'YlOrBr'`) → **mapa coroplético** do indicador socioeconômico por distrito

---

## 📚 Bibliotecas Python Utilizadas

```python
import pandas as pd
import numpy as np
from factor_analyzer import FactorAnalyzer
from factor_analyzer.factor_analyzer import calculate_bartlett_sphericity
import pingouin as pg
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
import seaborn as sns
import sympy as sy
import scipy as sp
import plotly.express as px
import plotly.graph_objects as go
import shapefile as shp   # pyshp
```

Instalação (executar no console, sem o `#`):
```
pip install pandas numpy factor_analyzer sympy scipy matplotlib seaborn plotly pingouin pyshp
```

---

## 📖 Referência / Sugestão de Leitura

- Fávero, Luiz Paulo; Belfiore, Patrícia. (2024). *Manual de análise de dados: estatística e machine learning com Excel®, SPSS®, Stata®, R® e Python®*. 2 ed. Rio de Janeiro: LTC.

**Para revisar conceitos de álgebra linear:**
- Anton, Howard; Rorres, Chris (2012). *Álgebra Linear com Aplicações*. 10 ed. Bookman.
- Steinbruch, Alfredo; Winterle, Paulo (1995). *Álgebra Linear*. 1 ed. Pearson Universidades.

---

**Módulo**: 15 - Unsupervised Machine Learning: Análise Fatorial e PCA
**Curso**: MBA em Data Science e Analytics - USP/ESALQ
**Professor**: Dr. Wilson Tarantin Junior
