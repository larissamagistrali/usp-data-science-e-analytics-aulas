# 🔵 Resumo - Unsupervised Machine Learning: Análise de Correspondência Simples e Múltipla

## MBA em Data Science e Analytics USP/ESALQ
### Prof. Dr. Wilson Tarantin Junior

---

## 🎯 Contextualização

### Quando aplicar a análise de correspondência?
- Quando o objetivo for analisar **variáveis categóricas (qualitativas)**
- O intuito é verificar se há associação estatisticamente significativa entre as variáveis e suas categorias, criando um **mapa perceptual** para visualizar tais associações
- Caso exista uma variável quantitativa que deva participar da análise, é necessário que ela passe, previamente, por um procedimento de **categorização**
  - Exemplo: idade (25, 42, 50, 73, 81 anos) → faixas de idade: 0-30, 31-60, 61-90 anos...

### Características da técnica
- Técnica **não supervisionada (exploratória)**
- Avalia a **relação conjunta** entre as variáveis (interdependência)
- Não há especificação de modelos do tipo $Y = f(X)$
- **Não é adequada para fins de inferência**
- Se novas observações forem adicionadas aos dados, é adequado **refazer a análise**

### Exemplos de aplicação
- Faixa de renda e acesso ao crédito
- Tipo de escola frequentada e aprovação no vestibular
- Severidade dos sintomas da doença e comorbidades
- Qualidade do produto, nível de satisfação do cliente e recomendação de compra

### Vantagem sobre ponderação arbitrária
- Evita o problema de ponderação arbitrária na análise de variáveis qualitativas (ex.: variáveis em **escala Likert** — concordo plenamente, concordo parcialmente, não concordo/nem discordo, discordo parcialmente, discordo plenamente)
- Cada ponto da escala é uma categoria da variável na análise de correspondência

---

## 1. Análise de Correspondência Simples (ANACOR)

- Também conhecida como **ANACOR**
- Objetivo: estudar a associação entre **duas variáveis** e suas categorias
- Duas etapas:
  1. Análise da significância estatística da associação (**teste qui-quadrado**, $\chi^2$)
  2. Elaboração e interpretação do **mapa perceptual**

### 1.1 Teste qui-quadrado para associação

**Tabela de contingência** (cross-tabulation): frequências absolutas observadas para cada par de categorias

**Frequência absoluta esperada** (para a célula das categorias 1 das duas variáveis):
$$
\text{freq. absoluta esperada}_{11} = \frac{\sum L1 \cdot \sum C1}{N}
$$

**Resíduo**:
$$
\text{resíduo}_{11} = \text{freq. absoluta observada}_{11} - \text{freq. absoluta esperada}_{11}
$$

**Estatística $\chi^2$ por célula** (somadas, resultam no $\chi^2_{total}$):
$$
\chi^2_{11} = \frac{(\text{resíduo}_{11})^2}{\text{freq. absoluta esperada}_{11}}
$$

**Teste de hipótese**:
- $H_0$: as variáveis se associam de forma aleatória (são independentes)
- $H_1$: a associação entre as variáveis não se dá de forma aleatória (há dependência)
- Se $\chi^2$ > valor crítico, há associação significante ($H_1$)
- Valor crítico da distribuição $\chi^2$ com $(I-1)\cdot(J-1)$ graus de liberdade

```python
from scipy.stats import chi2_contingency
tabela = pd.crosstab(dados["Perfil"], dados["Tipo de Aplicação"])
teste_qui2 = chi2_contingency(tabela)
```

### 1.2 Aprofundando: resíduos padronizados e ajustados

- A análise do $\chi^2$ mostra **se** há dependência; os resíduos padronizados ajustados aprofundam **como** as categorias se relacionam entre si

**Resíduo padronizado**:
$$
\text{resíduo padronizado}_{11} = \frac{\text{resíduo}_{11}}{\sqrt{\text{freq. absoluta esperada}_{11}}}
$$

**Resíduo padronizado ajustado**:
$$
\text{resíduo padronizado ajustado}_{11} = \frac{\text{resíduo padronizado}_{11}}{\sqrt{\left(1-\frac{\sum C1}{N}\right)\cdot\left(1-\frac{\sum L1}{N}\right)}}
$$

- **Análise**: se o valor absoluto do resíduo padronizado ajustado em uma célula for **maior do que 1,96**, existe associação estatisticamente significativa (nível de 5%) entre as duas categorias daquela célula; se for menor, não há associação significativa
- 1,96 é o valor crítico da normal padrão para significância de 5%

```python
import statsmodels.api as sm
tab_cont = sm.stats.Table(tabela)
tab_cont.fittedvalues        # freq. esperadas
tab_cont.chi2_contribs       # valores qui² por célula
tab_cont.resid_pearson       # resíduos padronizados
tab_cont.standardized_resids # resíduos padronizados ajustados
```

### 1.3 Elaboração do mapa perceptual

**Autovalores** ($\lambda$):
- Quantidade $m$ de autovalores: $m = \min(I-1, J-1)$
- Referem-se às inércias (variâncias) principais parciais
- % da inércia por dimensão: $\lambda_{dimensão}/\lambda_{total}$
- Inércia principal total: $\chi^2/N$ (= $\lambda_1+\lambda_2+\dots+\lambda_m$)
- Quanto maior a inércia principal total e o $\chi^2$, mais forte é a associação

Cálculo (a partir da matriz de resíduos padronizados):
$$
\text{matriz } A_{11} = \frac{\text{resíduo padronizado}_{11}}{\sqrt{N}} \qquad W = A' \cdot A \qquad \det(W - \lambda \cdot I) = 0
$$

**Massas**: influência de cada categoria sobre as demais de sua variável
$$
\text{Massa Linha}_1 = \frac{\sum L1}{N} \qquad \text{Massa Coluna}_1 = \frac{\sum C1}{N}
$$

**Autovetores**: para cada autovalor $k$, com valor singular $\sigma_k=\sqrt{\lambda_k}$, obtém-se o autovetor da variável coluna ($v$) e, a partir dele, o da variável linha ($u$): $u_k = A \cdot (v_k/\sigma_k)$

**Coordenadas no mapa perceptual**:
- Variável em linha: $X_l = \sigma_1\cdot(1/\sqrt{D_l})\cdot u_1$ ; $Y_l = \sigma_2\cdot(1/\sqrt{D_l})\cdot u_2$
- Variável em coluna: $X_c = \sigma_1\cdot(1/\sqrt{D_c})\cdot v_1$ ; $Y_c = \sigma_2\cdot(1/\sqrt{D_c})\cdot v_2$

```python
import prince
ca = prince.CA().fit(tabela)
ca.eigenvalues_summary
ca.total_inertia_
ca.row_masses_
ca.col_masses_
ca.svd_.U          # autovetor linha
ca.svd_.V.T        # autovetor coluna
ca.row_coordinates(tabela)
ca.column_coordinates(tabela)
```

### 1.4 Exemplo numérico real (material complementar — Perfil x Tipo de Aplicação)

Tabela de contingência (100 investidores; Perfil: Agressivo/Conservador/Moderado x Tipo de Aplicação: Ações/CDB/Poupança):

| Perfil | Ações | CDB | Poupança | Total |
|---|---|---|---|---|
| Agressivo | 36 | 20 | 2 | 58 |
| Conservador | 5 | 4 | 8 | 17 |
| Moderado | 4 | 16 | 5 | 25 |
| **Total** | 45 | 40 | 15 | **100** |

- $\chi^2_{total}$ = 31,76; graus de liberdade = 4 (= (3-1)×(3-1)); p-valor ≈ 2,14×10⁻⁶ → rejeita-se $H_0$, há associação significativa
- Resíduos padronizados ajustados mais fortes: Agressivo-Ações = 4,03; Agressivo-Poupança = -3,80; Moderado-Ações = -3,37 (todos |valor| > 1,96 → associação significativa)
- Autovalores: $\lambda_1$ = 0,2332 (73,42% da inércia); $\lambda_2$ = 0,0844 (26,58%) — inércia principal total = 0,3176 = $\chi^2/N$ (31,76/100)
- Massas linha: Agressivo = 0,58; Conservador = 0,17; Moderado = 0,25. Massas coluna: Ações = 0,45; CDB = 0,40; Poupança = 0,15
- Coordenadas finais no mapa perceptual (1ª e 2ª dimensão):

| Categoria | X | Y |
|---|---|---|
| Agressivo | -0,396 | -0,066 |
| Conservador | 0,787 | -0,434 |
| Moderado | 0,384 | 0,447 |
| Ações | -0,405 | -0,210 |
| CDB | 0,071 | 0,353 |
| Poupança | 1,025 | -0,314 |

→ No mapa, "Agressivo" aproxima-se de "Ações", e "Conservador" aproxima-se de "Poupança", confirmando visualmente a associação identificada nos resíduos.

---

## 2. Análise de Correspondência Múltipla (MCA)

- Objetivo: analisar a associação entre **mais de duas** variáveis categóricas
- Só participam da ACM as variáveis que apresentarem associação estatisticamente significativa com **pelo menos uma outra** variável da análise
  - Antes de elaborar a ACM, aplica-se o teste $\chi^2$ para cada par de variáveis; se alguma não tiver associação significativa com nenhuma outra, é retirada da análise
- A ACM segue a mesma lógica de análise da ANACOR

### 2.1 Dois métodos de obtenção

**1º método — Matriz binária Z → coordenadas-padrão**
- Transforma as variáveis qualitativas em variáveis binárias (0 ou 1: ausência/presença do atributo)
- Tratando Z como tabela de contingência, obtêm-se inércia parcial, autovalores, autovetores e coordenadas
- Quantidade de dimensões: $J - Q$ (J = total de categorias em todas as variáveis; Q = quantidade de variáveis)
$$
\text{inércia principal total} = \frac{J-Q}{Q}
$$

**2º método — Matriz de Burt → coordenadas principais**
- Matriz de Burt: $B = Z' \cdot Z$
- Combina em uma única matriz o cruzamento de todos os pares de variáveis/categorias (frequências absolutas observadas de todos os cruzamentos)
- Tratando a matriz de Burt como tabela de contingência, realiza-se uma ANACOR para obter as coordenadas das categorias

```python
import prince
mca = prince.MCA(n_components=2).fit(dados_mca)
mca.J_                 # qtde total de categorias
mca.K_                 # qtde de variáveis
mca.total_inertia_
mca.eigenvalues_summary
mca.column_coordinates(dados_mca)                       # coordenadas principais (Burt)
mca.column_coordinates(dados_mca)/np.sqrt(mca.eigenvalues_)  # coordenadas-padrão
mca.row_coordinates(dados_mca)                          # coordenadas das observações
```

---

## 🐍 Exemplos Práticos em Python (scripts da aula)

### 1. Perfil de Investidor x Tipo de Aplicação (`Script - Perfil_Aplicação.py`) — ANACOR
- Base: `perfil_aplicacao.xlsx` (Fávero & Belfiore, 2024, Capítulo 11)
- Variáveis: `Perfil` (Agressivo/Conservador/Moderado) x `Tipo de Aplicação` (Ações/CDB/Poupança)
- Fluxo: tabela de contingência (`pd.crosstab`) → teste $\chi^2$ (`chi2_contingency`) → resíduos (`sm.stats.Table`: freq. esperadas, resíduos, contribuições $\chi^2$, resíduos padronizados e ajustados) → mapa de calor interativo dos resíduos padronizados ajustados (`plotly`, destaque em azul para valores > 1,96) → ANACOR (`prince.CA`) → autovalores, inércia total, massas de linha/coluna, autovetores (`ca.svd_.U`/`ca.svd_.V.T`) → coordenadas de linha e coluna → mapa perceptual (`matplotlib`/`seaborn`) → coordenadas médias das observações (média das coordenadas de suas categorias)

### 2. Satisfação com a Gestão Municipal — Escala Likert (`Script - Gestão (Likert).py`) — ANACOR
- Base: `gestao_municipal.xlsx` (Fávero & Belfiore, 2024, Capítulo 11)
- Contexto: pesquisa aplicada ao longo de 3 anos com a afirmação "Estou satisfeito com a gestão do atual prefeito!", respondida em **escala Likert de 5 pontos**
- Variáveis: `avaliacao` (a escala Likert) x `ano`
- Fluxo: tabela de contingência → teste $\chi^2$ → mapa de calor dos resíduos padronizados ajustados (destaque em verde para valores > 1,96) → ANACOR (`prince.CA`) → autovalores e inércia total → coordenadas de linha/coluna → mapa perceptual → coordenadas médias das observações

### 3. Perfil, Aplicação e Estado Civil (`Script - Perfil_Aplicação_Civil.py`) — MCA
- Base: `perfil_aplicacao_civil.xlsx` (Fávero & Belfiore, 2024, Capítulo 11)
- Variáveis: `perfil`, `aplicacao`, `estado.civil` (removida a coluna `estudante`)
- Fluxo: tabelas de contingência e teste $\chi^2$ para cada par de variáveis → MCA (`prince.MCA`, `n_components=2`) → quantidade de dimensões ($J-Q$) → construção didática das **matrizes binária e de Burt** (`pd.get_dummies` + produto matricial) → autovalores e inércia total → coordenadas principais (Burt) e coordenadas-padrão → mapa perceptual 2D (`seaborn`)

### 4. Adaptabilidade de Estudantes ao Ensino Online (`Script - Adaptação Estudante.py`) — MCA
- Base: `estudantes_adapta.csv` (adaptado de Kaggle — Students' Adaptability Level in Online Education; Suzan et al., 2021)
- Variáveis: `Education`, `Institution`, `Financial`, `Internet`, `Adaptivity`
- Fluxo: tabelas de frequência de cada variável → tabelas de contingência de cada variável **contra `Adaptivity`** → teste $\chi^2$ para cada uma → MCA com **3 componentes** (`prince.MCA(n_components=3)`, mapa perceptual em 3D) → quantidade de dimensões, autovalores, inércia principal total → **inércia média por dimensão** (critério para decidir quais dimensões plotar: reter as com autovalor acima da média) → coordenadas principais e coordenadas-padrão → coordenadas das observações → gráfico 3D interativo (`plotly.express.scatter_3d`, exportado em `assoc_mca_adapta.html`)

### 5. Doença Cardíaca (`Script - Coração.py`) — MCA com categorização prévia
- Base: `dados_cor_acm.xlsx` (adaptado de Kaggle — Heart Failure Prediction)
- Demonstra a **categorização de variáveis métricas** antes da MCA: `idade`, `ps.descanco` (pressão sistólica de descanso), `colesterol` e `bc.max` (batimento cardíaco máximo) são discretizadas em 3 faixas cada, via `pd.qcut` (ex.: idade → `menores_idades`/`idades_medias`/`maiores_idades`)
- Fluxo: gera **todas** as tabelas de contingência possíveis entre pares de variáveis (`itertools.combinations`) e roda o teste $\chi^2$ para cada par → MCA (`prince.MCA(n_components=2)`) → quantidade de dimensões, autovalores, inércia total → coordenadas principais e coordenadas-padrão → coordenadas das observações → mapa perceptual das categorias e mapa das observações coloridas pela variável-alvo `doenca.card`

---

## 📚 Bibliotecas Python Utilizadas

```python
import pandas as pd
import numpy as np
from scipy.stats import chi2_contingency
import statsmodels.api as sm
import seaborn as sns
import matplotlib.pyplot as plt
import prince
import plotly.express as px
import plotly.graph_objects as go
from itertools import combinations
```

Instalação (executar no console, sem o `#`):
```
pip install pandas numpy scipy plotly seaborn matplotlib statsmodels prince
```

---

## 📖 Referência / Sugestões de Leitura

- Fávero, Luiz Paulo; Belfiore, Patrícia. (2024). *Manual de análise de dados: estatística e machine learning com Excel®, SPSS®, Stata®, R® e Python®*. 2 ed. Rio de Janeiro: LTC.

**Sugestões de leitura complementar:**
- Anton, H.; Rorres, C. (2012). *Álgebra Linear com Aplicações*. 10 ed. Bookman.
- Benzécri, J. P. (1992). *Correspondence analysis handbook*. 2 ed. Marcel Dekker.
- Greenacre, M. J. (1984). *Theory and applications of correspondence analysis*. Academic Press.
- Steinbruch, A.; Winterle, P. (1995). *Álgebra Linear*. 1 ed. Pearson Universidades.

---

**Módulo**: 16 - Unsupervised Machine Learning: Análise de Correspondência Simples e Múltipla
**Curso**: MBA em Data Science e Analytics - USP/ESALQ
**Professor**: Dr. Wilson Tarantin Junior
