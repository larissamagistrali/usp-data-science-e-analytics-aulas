# 🏗️ Resumo do Curso: Supervised Machine Learning - Modelagem Multinível

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Dominar a construção de modelos **HLM2 (2 níveis)** e **HLM3 (3 níveis, com medidas repetidas)**, com efeitos fixos e aleatórios (interceptos e inclinações), reconhecendo as limitações de OLS e dummies em dados hierárquicos, implementados em Python.

---

## 📚 Conteúdo Principal

### 1. CONTEXTO E FUNDAMENTAÇÃO TEÓRICA

#### 1.1 O que são Modelos Multinível?

> "São modelos que reconhecem a existência de estrutura multinível ou hierárquica nos dados."
> — Raudenbush, S.W.; Bryk, A.S. *Hierarchical linear models: applications and data analysis methods*. 2. ed. Sage, 2002.

- Reconhecem que observações de **Nível 1** (ex.: indivíduos) estão agrupadas (aninhadas) em unidades de **Nível 2** (ex.: escolas, firmas, países), que por sua vez podem estar agrupadas em unidades de **Nível 3** (ex.: setores, regiões).

#### 1.2 Estrutura Multinível

- Exemplo: Nível 1 (alunos) → Nível 2 (escolas) → Nível 3 (redes/municípios)
- Dados não são independentes entre si dentro do mesmo grupo, violando premissa de independência do OLS clássico.

#### 1.3 Por que a Regressão OLS Tradicional Falha

- Regressão única (OLS) ignora que cada grupo tem seu próprio intercepto e sua própria inclinação:

```
Escola 1: Y_i1 = β01 + β11.X_i1 + ε_i1
Escola 2: Y_i2 = β02 + β12.X_i2 + ε_i2
Escola 3: Y_i3 = β03 + β13.X_i3 + ε_i3
Escola 4: Y_i4 = β04 + β14.X_i4 + ε_i4
```

- Ao empilhar grupos em reta única, **mistura efeitos individuais com efeitos de grupo**, gerando estimativas viesadas e resíduos correlacionados.
- A visualização de "Reflexão" do módulo mostra como diferentes especificações (Modelo 1, Modelo 2, Modelo 3) geram *fitted values* muito distintos quando a hierarquia não é tratada corretamente.

#### 1.4 Dummies Não Resolvem o Problema

- Incluir dummies de grupo apenas ajusta **intercepto** por grupo, mas:
  - Não modela variação nas **inclinações** entre grupos;
  - Não separa **variância intragrupo** da **variância entre grupos**;
  - Consome muitos graus de liberdade;
  - Não permite estimar efeito de variáveis de **nível superior** de forma parcimoniosa.

---

### 2. O MODELO MULTINÍVEL (FORMULAÇÃO GERAL - HLM2)

#### 2.1 Nível 1 (dentro dos grupos)

```
Y_ij = β0j + β1j.X_ij + ε_ij
```

- `i`: índice do indivíduo; `j`: índice do grupo (ex.: escola)
- `β0j`: intercepto específico do grupo j
- `β1j`: inclinação específica do grupo j
- `ε_ij`: erro de Nível 1 (intragrupo)

#### 2.2 Nível 2 (entre os grupos)

```
β0j = γ00 + γ01.Wj + ν0j
β1j = γ10 + γ11.Wj + ν1j
```

- `Wj`: variável explicativa de Nível 2 (característica do grupo)
- `γ00, γ10`: efeitos fixos (médias gerais dos interceptos/inclinações)
- `γ01, γ11`: efeitos fixos das variáveis de nível 2 sobre intercepto/inclinação
- `ν0j, ν1j`: **efeitos aleatórios** (desvios de cada grupo em relação à média geral)

#### 2.3 Modelo Combinado (substituindo Nível 2 em Nível 1)

```
Y_ij = (γ00 + γ01.Wj + ν0j) + (γ10 + γ11.Wj + ν1j).X_ij + ε_ij

Y_ij = γ00 + γ10.X_ij + γ01.Wj + γ11.Wj.X_ij + ν0j + ν1j.X_ij + ε_ij
       └──────────────── Efeitos Fixos ────────────────┘ └── Efeitos Aleatórios ──┘
```

> "Os modelos tradicionais de regressão ignoram as interações entre variáveis no componente de efeitos fixos e as interações entre termos de erro e variáveis no componente de efeitos aleatórios."
> — Goldstein, H. *Multilevel statistical models*. 4. ed. Wiley, 2011.

- **Efeitos Fixos**: `γ00` (intercepto médio), `γ10` (inclinação média de X), `γ01` (efeito de W), `γ11` (interação cross-level W.X)
- **Efeitos Aleatórios**: `ν0j` (variação do intercepto entre grupos), `ν1j.X_ij` (variação da inclinação entre grupos), `ε_ij` (erro de nível 1)

#### 2.4 Variância dos Termos Aleatórios

> "Se as variâncias dos termos aleatórios ν0j e ν1j forem estatisticamente diferentes de zero, procedimentos tradicionais de estimação dos parâmetros do modelo, como mínimos quadrados ordinários, não serão adequados."
> — Tabachnick, B.G.; Fidell, L.S. *Using multivariate statistics*. 6. ed. Pearson, 2013.

- Antes de estimar um modelo multinível completo, é preciso testar se as variâncias de `ν0j` (e, se aplicável, `ν1j`) são significativamente diferentes de zero — se forem, o OLS tradicional é inadequado e a modelagem multinível se justifica.

---

### 3. MODELAGEM HLM2 COM DADOS AGRUPADOS (2 NÍVEIS)

Sequência de especificação de um HLM2, do modelo mais simples ao mais completo (exemplo do curso: variável dependente `desempenho`, variável de Nível 1 `horas`, variável de Nível 2 `texp` - tempo de experiência):

#### 3.1 Modelo Nulo (Null Model / Modelo Vazio)

```
Nível 1: desempenho_ij = β0j + ε_ij
Nível 2: β0j = γ00 + ν0j

Substituindo: desempenho_ij = γ00 + ν0j + ε_ij
```

- Contém **apenas o intercepto**, sem variáveis explicativas.
- Serve de **baseline** para verificar se existe variabilidade entre grupos que justifique a abordagem multinível (decompõe a variância total em `Var(ν0j)` — variância entre grupos — e `Var(ε_ij)` — variância dentro dos grupos).

#### 3.2 Modelo com Interceptos e Inclinações Aleatórios

```
Nível 1: desempenho_ij = β0j + β1j.horas_ij + ε_ij
Nível 2: β0j = γ00 + ν0j
         β1j = γ10 + ν1j

Substituindo: desempenho_ij = γ00 + γ10.horas_ij + ν0j + ν1j.horas_ij + ε_ij
```

- Adiciona a variável de Nível 1 (`horas`), permitindo que **tanto o intercepto quanto a inclinação** variem aleatoriamente entre os grupos j.

#### 3.3 Modelo Final HLM2 (com variável de Nível 2)

```
Nível 1: desempenho_ij = β0j + β1j.horas_ij + ε_ij
Nível 2: β0j = γ00 + γ01.texp_j + ν0j
         β1j = γ10 + γ11.texp_j + ν1j

Substituindo:
desempenho_ij = γ00 + γ10.horas_ij + γ01.texp_j + γ11.texp_j.horas_ij + ν0j + ν1j.horas_ij + ε_ij
```

- `texp_j` (variável de Nível 2, ex.: experiência do professor/gestor do grupo) explica parte da variação dos interceptos e das inclinações entre grupos.
- O termo `γ11.texp_j.horas_ij` é uma **interação cross-level** entre variável de Nível 2 e variável de Nível 1.

#### 3.4 Comparação HLM2 x OLS x OLS com Dummies

- Gráfico de *fitted values* vs. valores reais de `desempenho` mostrando três curvas: **OLS** (reta única, ajuste pobre nos extremos), **OLS com Dummies de grupo** (melhora o intercepto, mas ainda distante da diagonal de 45°), e **HLM2 Modelo Final** (acompanha de forma muito mais próxima a diagonal de 45°, indicando melhor aderência entre valores previstos e reais).

---

### 4. MODELAGEM HLM3 COM MEDIDAS REPETIDAS (3 NÍVEIS)

Utilizada quando há uma estrutura de **3 níveis**, típica de dados em painel/longitudinais:

- **Nível 1**: períodos de tempo *t* (medidas repetidas)
- **Nível 2**: indivíduo *j*
- **Nível 3**: grupo *k*

```
Estrutura: Período t (Nível 1) → dentro de Indivíduo j (Nível 2) → dentro de Grupo k (Nível 3)
```

#### 4.1 Modelo Nulo HLM3

```
Nível 1: desempenho_tjk = β0jk + ε_tjk
Nível 2: β0jk = γ00k + ν0jk
Nível 3: γ00k = δ000 + τ00k

Substituindo: desempenho_tjk = δ000 + ν0jk + τ00k + ε_tjk
```

- Decompõe a variância total em três componentes: **entre grupos** (`τ00k`), **entre indivíduos dentro do grupo** (`ν0jk`) e **dentro do indivíduo ao longo do tempo** (`ε_tjk`).

#### 4.2 Modelo de Tendência Linear com Interceptos e Inclinações Aleatórios (*Growth Model*)

```
Nível 1: desempenho_tjk = β0jk + β1jk.mes_jk + ε_tjk
Nível 2: β0jk = γ00k + ν0jk
         β1jk = γ10k
Nível 3: γ00k = δ000 + τ00k
         γ10k = δ100 + τ10k

Substituindo:
desempenho_tjk = δ000 + δ100.mes_jk + ν0jk + τ00k + τ10k.mes_jk + ε_tjk
```

- Modela a **tendência de crescimento/queda** de `desempenho` ao longo dos meses (`mes_jk`), permitindo que a taxa de crescimento (inclinação) varie entre grupos (Nível 3).

#### 4.3 Modelo Final HLM3 (com variáveis de Nível 2 e Nível 3)

```
Nível 1: desempenho_tjk = β0jk + β1jk.mes_jk + ε_tjk
Nível 2: β0jk = γ00k + ν0jk
         β1jk = γ10k + γ11k.ativ_jk
Nível 3: γ00k = δ000 + τ00k
         γ10k = δ100 + δ101.texp_k + τ10k
         γ11k = δ110

Substituindo:
desempenho_tjk = δ000 + δ100.mes_jk + δ110.ativ_jk.mes_jk + δ101.texp_k.mes_jk
                 + ν0jk + τ00k + τ10k.mes_jk + ε_tjk
```

- `ativ_jk`: variável de **Nível 2** (característica do indivíduo, ex. nível de atividade)
- `texp_k`: variável de **Nível 3** (característica do grupo, ex. tempo de experiência do grupo/gestor)
- Contém interações cross-level entre `mes` (Nível 1) e variáveis de Nível 2 e Nível 3.

#### 4.4 Comparação HLM3 x OLS com Dummies

- Gráfico de *fitted values* vs. `desempenho` mostra o **HLM3** acompanhando quase perfeitamente a diagonal de 45° (excelente aderência), enquanto o **OLS com Dummies** apresenta uma curva suavizada bem distante da diagonal, especialmente nos valores extremos — evidenciando a superioridade do tratamento hierárquico correto sobre o simples uso de variáveis binárias de grupo.

---

### 5. APLICAÇÕES E RELEVÂNCIA DA TÉCNICA

#### 5.1 Penetração em Periódicos por Área (Índice h5 - Google Scholar)

O material apresenta o percentual de artigos que utilizam modelos supervisionados multinível nos principais periódicos de cada área:

| Área | % média de uso (aprox.) |
|---|---|
| Business, Economics & Management | ~9,26% |
| Engineering & Computer Science | ~4,28% |
| Social Sciences | ~0,64% |
| Health & Medical Sciences | ~1,70% |

- **Conclusão do curso**: a Modelagem Multinível é mais utilizada em periódicos de Negócios/Economia do que em Ciências da Saúde ou Ciências Sociais, apesar de sua relevância metodológica ser transversal a todas as áreas.

#### 5.2 Por que a Baixa Utilização?

> "Interações Profundas e Capacidade de Processamento; Métodos de Estimação dos Parâmetros; Clusterização da Amostra."
> — Andrew Gelman, *Multilevel Conference*, Columbia University, 2015.

Razões apontadas no material:
- Estrutura dos dados nem sempre é reconhecida como hierárquica;
- Falta de consideração da natureza multinível nos dados;
- Capacidade computacional por vezes insuficiente, principalmente na presença de interações profundas (múltiplos níveis com muitas interações cross-level).

#### 5.3 Estudo de Caso: Estrutura de Capital (Rajan & Zingales, 1995)

- **Artigo**: Rajan, R.G.; Zingales, L. "What do we know about capital structure? Some evidence from international data." *Journal of Finance*, v. 50-5, p. 1421-1460, 1995.
- **Dados**: Compustat Global e MSCI, 4.557 empresas, 7 países, período 1987-1991.

| País | Índice de Mercado Local | Nº de Empresas |
|---|---|---|
| United States | S&P 500 | 2.583 |
| Japan | Nikkei 500 | 514 |
| Germany | FAZ Share Index | 191 |
| France | CAC General Index | 225 |
| Italy | MIB Current Index | 118 |
| United Kingdom | FT 500 | 608 |
| Canada | TSE 300 | 318 |

- **Modelo OLS único (equação de referência)**:

```
Leverage_i = β0 + β1.(Tangible Assets)_i + β2.(Market to Book)_i + β3.(Log Sales)_i + β4.(ROA)_i + ε_i
```

- **Modelo Multinível (empresas aninhadas em países)**:

```
Nível 1: Leverage_ij = β0j + β1j.(Tangible Assets)_ij + β2j.(Market to Book)_ij
                       + β3j.(Log Sales)_ij + β4j.(ROA)_ij + ε_ij
Nível 2: β0j = γ00 + ν0j    β1j = γ10 + ν1j    β2j = γ20 + ν2j
         β3j = γ30 + ν3j    β4j = γ40 + ν4j
```

- Cada coeficiente (intercepto, Tangible Assets, Market to Book, Log Sales, ROA) recebe um componente fixo (γ) e um componente aleatório (ν) por país.
- **Resultado gráfico**: a curva de *fitted values* do modelo **Multilevel** acompanha muito mais de perto a diagonal de 45° (valores reais) do que a curva **OLS**, que se distancia sistematicamente nos extremos.
- **Interceptos e inclinações aleatórias por país**: gráficos de barras mostram que os efeitos de Tangible Assets, Market to Book, Log Sales e ROA sobre o Leverage variam em magnitude e até em sinal entre Estados Unidos, Japão, Alemanha, França, Itália, Reino Unido e Canadá — evidência direta de que um único coeficiente OLS "médio" mascara heterogeneidade real entre países.

---

## 🐍 Implementação Python

### Bibliotecas Essenciais

```python
# Manipulação de dados
import pandas as pd
import numpy as np

# Visualização
import matplotlib.pyplot as plt
import seaborn as sns

# Modelagem multinível (HLM / GLMM)
import statsmodels.api as sm
import statsmodels.formula.api as smf
from statsmodels.regression.mixed_linear_model import MixedLM

import warnings
warnings.filterwarnings('ignore')
```

> **Ambiente do curso**: a estimação foi demonstrada no **Spyder (Scientific Python IDE)**, com o script completo do curso organizado por seções (indicadas nas aulas pelas marcações "linha 324", "linha 415", "linha 511", "linha 1159", "linha 1246" e "linha 1302" do script complementar).

### Pipeline HLM2 - Modelo Nulo

```python
# 1. CARREGAMENTO DOS DADOS (estrutura: indivíduo aninhado em grupo/escola)
df = pd.read_csv('dados_desempenho.csv')
print(df.info())

# 2. MODELO NULO (apenas intercepto aleatório por grupo)
# Nível 1: desempenho_ij = beta0j + eps_ij
# Nível 2: beta0j = gamma00 + nu0j
modelo_nulo = smf.mixedlm(
    "desempenho ~ 1",
    data=df,
    groups=df["escola"]
).fit()

print(modelo_nulo.summary())

# Teste de significância estatística do efeito aleatório de intercepto
# (razão entre a variância do efeito aleatório e seu erro-padrão, comparada à normal)
teste = float(modelo_nulo.cov_re.iloc[0, 0]) / float(pd.DataFrame(modelo_nulo.summary().tables[1]).iloc[1, 1])
p_value = 2 * (1 - stats.norm.cdf(abs(teste)))
print(f"Estatística z: {teste:.3f} | P-valor: {p_value:.3f}")
```

### Pipeline HLM2 - Modelo com Interceptos e Inclinações Aleatórios

```python
# Nível 1: desempenho_ij = beta0j + beta1j.horas_ij + eps_ij
# Nível 2: beta0j = gamma00 + nu0j
#          beta1j = gamma10 + nu1j
modelo_aleatorio = smf.mixedlm(
    "desempenho ~ horas",
    data=df,
    groups=df["escola"],
    re_formula="~horas"          # permite inclinação aleatória de 'horas' por grupo
).fit()

print(modelo_aleatorio.summary())
```

### Pipeline HLM2 - Modelo Final (com variável de Nível 2 e interação cross-level)

```python
# Nível 1: desempenho_ij = beta0j + beta1j.horas_ij + eps_ij
# Nível 2: beta0j = gamma00 + gamma01.texp_j + nu0j
#          beta1j = gamma10 + gamma11.texp_j + nu1j
modelo_final_hlm2 = smf.mixedlm(
    "desempenho ~ horas + texp + horas:texp",   # inclui interação cross-level
    data=df,
    groups=df["escola"],
    re_formula="~horas"
).fit()

print(modelo_final_hlm2.summary())

# Predição (fitted values) para comparação com OLS e OLS com dummies
df['fitted_hlm2'] = modelo_final_hlm2.fittedvalues

# Comparação visual: OLS x OLS com dummies x HLM2
modelo_ols = smf.ols("desempenho ~ horas + texp", data=df).fit()
modelo_ols_dummies = smf.ols("desempenho ~ horas + texp + C(escola)", data=df).fit()

df['fitted_ols'] = modelo_ols.fittedvalues
df['fitted_ols_dummies'] = modelo_ols_dummies.fittedvalues

plt.figure(figsize=(15, 10))
sns.regplot(x='desempenho', y='fitted_ols', data=df, lowess=True,
            scatter=False, line_kws={'color': 'navy', 'label': 'OLS'})
sns.regplot(x='desempenho', y='fitted_ols_dummies', data=df, lowess=True,
            scatter=False, line_kws={'color': 'orange', 'label': 'OLS com Dummies'})
sns.regplot(x='desempenho', y='fitted_hlm2', data=df, lowess=True,
            scatter=False, line_kws={'color': 'magenta', 'label': 'HLM2 Modelo Final'})
plt.plot([df['desempenho'].min(), df['desempenho'].max()],
         [df['desempenho'].min(), df['desempenho'].max()],
         linestyle='--', color='grey', label='45º')
plt.xlabel('Desempenho', fontsize=18)
plt.ylabel('Fitted Values', fontsize=18)
plt.legend(fontsize=14)
plt.show()
```

### Pipeline HLM3 - Medidas Repetidas (3 Níveis)

```python
# statsmodels MixedLM nativamente trata 2 níveis (grupos simples).
# Para 3 níveis (tempo dentro de indivíduo dentro de grupo), utiliza-se
# estrutura de efeitos aleatórios aninhados (variance components) ou
# a combinação de "groups" (nível mais alto) e "vc_formula" (nível intermediário).

import statsmodels.formula.api as smf

# Nível 1: tempo (mes) dentro do indivíduo
# Nível 2: indivíduo (j) dentro do grupo
# Nível 3: grupo (k)

# Modelo Nulo HLM3:
# desempenho_tjk = delta000 + nu0jk + tau00k + eps_tjk
modelo_nulo_hlm3 = smf.mixedlm(
    "desempenho ~ 1",
    data=df,
    groups=df["grupo"],                       # Nível 3 (mais externo)
    vc_formula={"individuo": "0 + C(individuo)"}  # Nível 2 aninhado no Nível 3
).fit()

print(modelo_nulo_hlm3.summary())

# Growth Model (tendência linear com interceptos e inclinações aleatórios):
# desempenho_tjk = delta000 + delta100.mes_jk + nu0jk + tau00k + tau10k.mes_jk + eps_tjk
modelo_growth_hlm3 = smf.mixedlm(
    "desempenho ~ mes",
    data=df,
    groups=df["grupo"],
    re_formula="~mes",
    vc_formula={"individuo": "0 + C(individuo)"}
).fit()

print(modelo_growth_hlm3.summary())

# Modelo Final HLM3 (com variáveis de Nível 2 'ativ' e Nível 3 'texp'):
# desempenho_tjk = delta000 + delta100.mes + delta110.ativ.mes + delta101.texp.mes
#                  + nu0jk + tau00k + tau10k.mes + eps_tjk
modelo_final_hlm3 = smf.mixedlm(
    "desempenho ~ mes + mes:ativ + mes:texp",
    data=df,
    groups=df["grupo"],
    re_formula="~mes",
    vc_formula={"individuo": "0 + C(individuo)"}
).fit()

print(modelo_final_hlm3.summary())
```

---

## 📊 Exemplos Práticos do Curso

### Exemplo 1: Modelagem HLM2 com Dados Agrupados

- **Contexto**: variável dependente `desempenho`, aninhada em grupos (escolas/turmas).
- **Sequência de especificação**: Modelo Nulo → Modelo com Interceptos e Inclinações Aleatórios (variável de Nível 1: `horas`) → Modelo Final (adição da variável de Nível 2: `texp`, tempo de experiência).
- **Resultado**: o Modelo Final HLM2 apresenta *fitted values* muito mais próximos da diagonal de 45° do que o OLS simples e o OLS com dummies de grupo.

### Exemplo 2: Modelagem HLM3 com Medidas Repetidas

- **Contexto**: dados longitudinais/em painel — `desempenho` medido em múltiplos períodos (`mes`) para cada indivíduo, que por sua vez pertence a um grupo.
- **Sequência de especificação**: Modelo Nulo (3 componentes de variância) → *Growth Model* (tendência linear com interceptos e inclinações aleatórios) → Modelo Final (com `ativ` de Nível 2 e `texp` de Nível 3).
- **Resultado**: o HLM3 acompanha quase perfeitamente a diagonal de 45° nos *fitted values*, superando amplamente o OLS com dummies.

### Exemplo 3: Estrutura de Capital Internacional (Rajan & Zingales, 1995)

- **Dataset**: Compustat Global e MSCI — 4.557 empresas, 7 países (EUA, Japão, Alemanha, França, Itália, Reino Unido, Canadá), 1987-1991.
- **Variáveis**: `Leverage` (Y), `Tangible Assets`, `Market to Book`, `Log Sales`, `ROA` (X), aninhadas por país (Nível 2).
- **Resultado**: o modelo Multilevel supera o OLS único em aderência (fitted vs. real), e os interceptos e inclinações aleatórias revelam que o efeito de cada variável explicativa sobre o *leverage* varia (inclusive de sinal) entre países.

---

## 💡 Conceitos-Chave do Módulo

### 🎯 Fórmulas Essenciais

```
1. HLM2 - Nível 1 (dentro do grupo):
   Y_ij = β0j + β1j.X_ij + ε_ij

2. HLM2 - Nível 2 (entre grupos):
   β0j = γ00 + γ01.Wj + ν0j     (intercepto com efeitos aleatórios)
   β1j = γ10 + γ11.Wj + ν1j     (inclinação com efeitos aleatórios)

3. HLM2 - Modelo Combinado:
   Y_ij = γ00 + γ10.X_ij + γ01.Wj + γ11.Wj.X_ij + ν0j + ν1j.X_ij + ε_ij
          └──────── Efeitos Fixos ────────┘ └── Efeitos Aleatórios ──┘

4. HLM2 - Modelo Nulo:
   desempenho_ij = γ00 + ν0j + ε_ij

5. HLM3 - Estrutura de 3 Níveis:
   Nível 1 (tempo t) → Nível 2 (indivíduo j) → Nível 3 (grupo k)

6. HLM3 - Modelo Nulo:
   desempenho_tjk = δ000 + ν0jk + τ00k + ε_tjk

7. HLM3 - Growth Model:
   desempenho_tjk = δ000 + δ100.mes_jk + ν0jk + τ00k + τ10k.mes_jk + ε_tjk

8. Coeficiente de Correlação Intraclasse (ICC) - a partir do modelo nulo:
   ICC = Var(ν0j) / [Var(ν0j) + Var(ε_ij)]
   - Mede a proporção da variância total explicada pela estrutura de grupo
   - ICC próximo de 0: pouca dependência intragrupo (OLS seria quase adequado)
   - ICC próximo de 1: forte dependência intragrupo (multinível é essencial)
```

### 📐 Interpretações Importantes

**Componentes de Variância (Modelo Nulo HLM2):**

- `Var(ν0j)`: variância **entre** os grupos (ex.: entre escolas)
- `Var(ε_ij)`: variância **dentro** de cada grupo (ex.: entre alunos da mesma escola)
- Se `Var(ν0j)` não for estatisticamente diferente de zero → a estrutura de grupo não é relevante e o OLS tradicional seria suficiente.

**Componentes de Variância (Modelo Nulo HLM3):**

- `Var(τ00k)`: variância **entre grupos** (Nível 3)
- `Var(ν0jk)`: variância **entre indivíduos dentro do grupo** (Nível 2)
- `Var(ε_tjk)`: variância **dentro do indivíduo ao longo do tempo** (Nível 1)

**Efeitos Fixos vs. Efeitos Aleatórios:**

- **Efeitos Fixos** (`γ`, `δ`): estimam o efeito médio das variáveis explicativas sobre a variável dependente, válido para toda a população de grupos.
- **Efeitos Aleatórios** (`ν`, `τ`): capturam o **desvio específico de cada grupo** em relação à média geral — não são estimados diretamente como coeficientes, mas como **componentes de variância**.

---

## ⚠️ Erros Comuns a Evitar

1. **Ignorar estrutura hierárquica dos dados**: OLS único gera resíduos correlacionados e viola premissa de independência.
2. **Confundir dummies com modelagem multinível**: dummies ajustam apenas intercepto, não capturam efeitos contextuais nem decompõem variância.
3. **Não testar significância das variâncias dos efeitos aleatórios** (`ν0j`, `ν1j`).
4. **Especificar inclinações aleatórias sem necessidade**: se não variam entre grupos, usar modelo apenas com intercepto aleatório.
5. **Esquecer interações cross-level**: variáveis de Nível 2/3 frequentemente interagem com Nível 1.
6. **Aplicar HLM3 sem identificar hierarquia correta**: definir bem Nível 1 (tempo), Nível 2 (indivíduo) e Nível 3 (grupo).

---

## 📚 Materiais de Apoio

### Arquivos do Módulo

- **SML Modelagem Multinivel 07-140426_SLpdf Portugues.pdf**: slides principais da aula (45 páginas), com fundamentação teórica, exemplo Rajan & Zingales (1995), e demonstrações HLM2/HLM3.
- **Material complementar 07 e 14042026_MCpdf Portugues.pdf**: lista de leituras complementares e referências bibliográficas do módulo.
- **SML - Modelagem Multinivel_MCzip Portugues.zip**: material complementar em formato compactado (dataset e/ou script de apoio).
- **lousas_MCzip Portugues.zip**: anotações de lousa da aula.
- **script complementar_MCzip Portugues.zip** e **scripts complementares_MCzip Portugues.zip**: scripts Python demonstrados em aula no Spyder, com a numeração de linhas referenciada nos slides (linha 324: Modelo Nulo HLM2; linha 415: Modelo com Interceptos e Inclinações Aleatórios; linha 511: Modelo Final HLM2; linha 1159: Modelo Nulo HLM3; linha 1246: Growth Model HLM3; linha 1302: Modelo Final HLM3).

### Pacotes Python Relevantes

- **statsmodels**: `MixedLM` / `smf.mixedlm()` — estimação de modelos lineares mistos (multinível) com efeitos fixos e aleatórios, interceptos e inclinações aleatórios, e componentes de variância (`vc_formula`) para estruturas de 3+ níveis.

---

## 📖 Referências Principais

**Artigo Central:**

- **Rajan, R.G.; Zingales, L.** 1995. *What do we know about capital structure? Some evidence from international data.* Journal of Finance, v. 50-5, p. 1421-1460.

---

**📌 Nota Final:** A Modelagem Multinível é essencial sempre que os dados apresentam estrutura hierárquica — indivíduos em grupos, grupos em países, medidas repetidas no tempo. Ignorar essa estrutura (via OLS único ou mesmo via dummies de grupo) leva a estimativas viesadas e à perda de informações contextuais valiosas para predição e tomada de decisão. Dominar HLM2 e HLM3 amplia significativamente o repertório do cientista de dados para tratar corretamente dados aninhados e longitudinais.

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_
_Módulo 21 - Supervised Machine Learning - Modelagem Multinível_
