# 🔢 Resumo do Curso: Supervised Machine Learning - Modelos para Dados de Contagem

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Dominar a especificação e estimação por máxima verossimilhança dos modelos **Poisson** e **Binomial Negativo (Poisson-Gama)** para variáveis dependentes de **contagem**, com diagnóstico de **superdispersão** (teste de Cameron e Trivedi, 1990), **modelos inflacionados de zeros** (ZIP e ZINB) e **teste de Vuong**, implementados em Python.

---

## 📚 Conteúdo Principal

### 1. MODELOS LINEARES GENERALIZADOS (GLM) E DADOS DE CONTAGEM

#### 1.1 O que caracteriza "Dados de Contagem"

- Variável dependente apresenta-se na forma **quantitativa, com valores discretos e não negativos**.
- É necessário definir também a **exposição** (unidade temporal, espacial, social, etc.) à qual a contagem se refere.

#### 1.2 Exemplos e Aplicações

- Quantidade de vezes que um grupo de pacientes idosos vai ao médico por ano, em função da idade, sexo e características do plano de saúde.
- Quantidade de ofertas públicas de ações (IPOs) realizadas em uma amostra de países emergentes em determinado ano, em função de inflação, taxa de juros, PIB e taxa de investimento estrangeiro.
- Ambos os casos: variável dependente **quantitativa, discreta, não negativa e com exposição anual** → são **dados de contagem**.
- Outros campos de aplicação citados nos slides: Ecologia e Mercado Imobiliário.

---

### 2. DISTRIBUIÇÃO POISSON E MODELO POISSON

#### 2.1 Função de Probabilidade

Para uma observação `i` (i = 1, 2, ..., n), a probabilidade de ocorrência de uma contagem `m` em determinada exposição é:

```
p(Yᵢ = m) = (e^(-λᵢ) . λᵢ^m) / m!
```

em que **λᵢ** é o número esperado de ocorrências (taxa média estimada de incidência do fenômeno) para uma dada exposição.

#### 2.2 Média e Variância da Poisson

```
E(Y)   = λ
Var(Y) = λ
```

> Propriedade fundamental: na distribuição Poisson, **média e variância são iguais** (equidispersão). Essa propriedade é a base do teste de superdispersão.

#### 2.3 Especificação do Modelo Poisson

```
ln(λ̂ᵢ) = ln(Ŷᵢ)_poisson = β₀ + β₁X₁ᵢ + β₂X₂ᵢ + ... + βₖXₖᵢ
```

- Função de ligação: **logarítmica**.
- Estimação: **Máxima Verossimilhança (MLE)**.

#### 2.4 Estimação em Python

```python
import statsmodels.api as sm

modelo_poisson = sm.Poisson.from_formula(
    'violations ~ staff + post + corruption',
    data=df_corruption).fit()

# Parâmetros do modelo
modelo_poisson.summary()
```

#### 2.5 Apresentação Compacta com `summary_col`

```python
from statsmodels.iolib.summary2 import summary_col

summary_col([modelo_poisson],
            model_names=["MODELO"],
            stars=True,
            info_dict={
                'N': lambda x: "{0:d}".format(int(x.nobs)),
                'Log-lik': lambda x: "{:.2f}".format(x.llf)
            })
```

#### 2.6 Visualização da Distribuição Poisson para Diferentes λ

```python
from math import exp, factorial
import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d

def poisson_lambda(lmbda, m):
    return (exp(-lmbda) * lmbda ** m) / factorial(m)

m = np.arange(0, 21)
lmbda_1 = [poisson_lambda(1, item) for item in m]
lmbda_2 = [poisson_lambda(2, item) for item in m]
lmbda_4 = [poisson_lambda(4, item) for item in m]

df_lambda = pd.DataFrame({'m': m, 'lambda_1': lmbda_1,
                          'lambda_2': lmbda_2, 'lambda_4': lmbda_4})

def smooth_line_plot(x, y):
    x_new = np.linspace(x.min(), x.max(), 500)
    f = interp1d(x, y, kind='quadratic')
    return x_new, f(x_new)

x_new, lambda_1 = smooth_line_plot(df_lambda.m, df_lambda.lambda_1)
x_new, lambda_2 = smooth_line_plot(df_lambda.m, df_lambda.lambda_2)
x_new, lambda_4 = smooth_line_plot(df_lambda.m, df_lambda.lambda_4)

plt.figure(figsize=(15,10))
plt.plot(x_new, lambda_1, linewidth=5, color='#440154FF')
plt.plot(x_new, lambda_2, linewidth=5, color='#22A884FF')
plt.plot(x_new, lambda_4, linewidth=5, color='#FDE725FF')
plt.xlabel('m', fontsize=20, style='italic')
plt.ylabel('Probabilidades', fontsize=20)
plt.legend([r'$\lambda$ = 1', r'$\lambda$ = 2', r'$\lambda$ = 4'], fontsize=24)
plt.show()
```

---

### 3. TESTE DE SUPERDISPERSÃO DE CAMERON E TRIVEDI (1990)

> CAMERON, A. C.; TRIVEDI, P. K. **Regression-based tests for overdispersion in the Poisson model**. Journal of Econometrics, v. 46, n. 3, p. 347-364, 1990.

#### 3.1 Motivação

Todas as variáveis preditoras podem se mostrar estatisticamente significantes no modelo Poisson (p < 0.05), mas isso **não garante** que a estimação Poisson seja a mais adequada — é preciso verificar se **média = variância** (equidispersão) de fato se sustenta nos dados.

#### 3.2 Passo a Passo do Teste

1. Estimar um modelo Poisson.
2. Criar uma nova variável **Y\*** utilizando os *fitted values* (λ estimados) do modelo Poisson.
3. Estimar um **modelo auxiliar OLS**, com Y\* como variável dependente, os fitted values do Poisson como única variável preditora e **sem intercepto**.
4. Observar a significância do parâmetro β desse modelo auxiliar.

```
Y*ᵢ = [(Yᵢ - λ̂ᵢ_poisson)² - Yᵢ] / λ̂ᵢ_poisson
```

- Se o **p-value do parâmetro** de `lambda_poisson` for **maior que 0.05** → equidispersão (Poisson é adequado).
- Se for **menor que 0.05** → **superdispersão** nos dados, o que favorece a estimação de um modelo **binomial negativo**.

#### 3.3 Implementação Manual (OLS sem Intercepto)

```python
# Fitted values do modelo Poisson
df_corruption['lambda_poisson'] = pd.DataFrame(modelo_poisson.predict(linear=False))

# Criação da variável Y* ('ystar')
df_corruption['ystar'] = (((df_corruption['violations']
                            - df_corruption['lambda_poisson'])**2)
                          - df_corruption['violations']) / df_corruption['lambda_poisson']

# Modelo auxiliar OLS, sem intercepto
modelo_auxiliar = sm.OLS.from_formula('ystar ~ 0 + lambda_poisson',
                                      df_corruption).fit()

modelo_auxiliar.summary()
```

#### 3.4 Implementação Direta com o Pacote `statstests`

```python
from statstests.tests import overdisp

# Elaboração direta do teste de superdispersão de Cameron e Trivedi (1990)
overdisp(modelo_poisson, df_corruption)
```

> Autores do pacote `statstests`: **Luiz Paulo Fávero e Helder Prado Santos**.

---

### 4. A DISTRIBUIÇÃO POISSON-GAMA (BINOMIAL NEGATIVA) E O MODELO NB2

#### 4.1 Função de Probabilidade

Para uma observação `i` (i = 1, 2, ..., n), a função de distribuição de probabilidade de Y é:

```
p(Yᵢ = m) = [δ^θ . m^(θ-1) . e^(-m.δ)] / (θ-1)!
```

- **θ** (theta): parâmetro de forma (θ > 0)
- **δ** (delta): parâmetro de taxa de decaimento (δ > 0)

#### 4.2 Média e Variância (Modelo NB2)

```
E(Y)   = λ_bneg
Var(Y) = λ_bneg . (1 + α.λ_bneg)
```

em que **α (fi)** é o parâmetro de superdispersão do modelo (inverso do parâmetro de forma θ). Diferentemente da Poisson, a variância **cresce com o quadrado da média**, incorporando a superdispersão.

#### 4.3 Especificação do Modelo Binomial Negativo

```
ln(λ̂ᵢ) = ln(Ŷᵢ)_bneg = β₀ + β₁X₁ᵢ + β₂X₂ᵢ + ... + βₖXₖᵢ
```

#### 4.4 Estimação em Python

```python
modelo_bneg = sm.NegativeBinomial.from_formula(
    'violations ~ staff + post + corruption',
    data=df_corruption).fit()

modelo_bneg.summary()
```

#### 4.5 Encontrando o α (fi) Ótimo por Maximização do Log-Likelihood

```python
import statsmodels.formula.api as smf
from tqdm import tqdm

alphas = np.linspace(0, 10, 2000)
llf = np.full(len(alphas), np.nan)

for i, alpha in tqdm(enumerate(alphas), total=len(alphas)):
    try:
        res = smf.glm(
            'violations ~ staff + post + corruption',
            data=df_corruption,
            family=sm.families.NegativeBinomial(alpha=alpha)
        ).fit()
        llf[i] = res.llf
    except:
        pass

fi_otimo = alphas[np.nanargmax(llf)]
float(fi_otimo.round(3))

# Plotagem Log-Likelihood x fi (alpha)
plt.figure(figsize=(12, 8))
plt.plot(alphas, llf, label='Log-Likelihood', color='darkorchid', linewidth=4)
plt.axvline(x=fi_otimo, color='darkorange', linewidth=4, linestyle='dashed',
            label=f'$\\phi$ ótimo: {round(fi_otimo, 3)}')
plt.xlabel('$\\phi$ (alpha)', fontsize=20, style='italic')
plt.ylabel('Log-Likelihood', fontsize=20)
plt.legend(loc='lower right', fontsize=17)
plt.show()
```

#### 4.6 Visualização da Distribuição Binomial Negativa

```python
def bneg(theta, delta, m):
    return ((delta ** theta) * (m ** (theta - 1)) * (exp(-m * delta))) / factorial(theta - 1)

m = np.arange(1, 21)
bneg_theta2_delta2 = [bneg(2, 2, item) for item in m]
bneg_theta3_delta1 = [bneg(3, 1, item) for item in m]
bneg_theta3_delta05 = [bneg(3, 0.5, item) for item in m]
```

---

### 5. COMPARAÇÃO ENTRE OS MODELOS POISSON E BINOMIAL NEGATIVO

#### 5.1 Comparação Lado a Lado

```python
summary_col([modelo_poisson, modelo_bneg],
            model_names=["Poisson", "BNeg"],
            stars=True,
            info_dict={
                'N': lambda x: "{0:d}".format(int(x.nobs)),
                'Log-lik': lambda x: "{:.2f}".format(x.llf)
            })
```

#### 5.2 Teste de Razão de Verossimilhança (LR Test)

```python
from scipy import stats

def lrtest(modelos):
    modelo_1 = modelos[0]
    llk_1 = modelo_1.llnull
    llk_2 = modelo_1.llf

    if len(modelos) > 1:
        llk_1 = modelo_1.llf
        llk_2 = modelos[1].llf
    LR_statistic = -2 * (llk_1 - llk_2)
    p_val = stats.chi2.sf(LR_statistic, 1)  # 1 grau de liberdade

    print("Likelihood Ratio Test:")
    print(f"-2.(LL0-LLm): {round(LR_statistic, 2)}")
    print(f"p-value: {p_val:.3f}")
    if p_val <= 0.05:
        print("H1: Different models, favoring the one with the highest Log-Likelihood")
    else:
        print("H0: Models with log-likelihoods that are not statistically different at 95% confidence level")

lrtest([modelo_poisson, modelo_bneg])
```

#### 5.3 Predições Comparadas

```python
# Quantidade média esperada de violações: staff=23, período pré-lei, corruption=0.5
modelo_poisson.predict(pd.DataFrame({'staff': [23], 'post': ['no'], 'corruption': [0.5]}))
modelo_bneg.predict(pd.DataFrame({'staff': [23], 'post': ['no'], 'corruption': [0.5]}))

# Mesma previsão, período pós-lei
modelo_poisson.predict(pd.DataFrame({'staff': [23], 'post': ['yes'], 'corruption': [0.5]}))
modelo_bneg.predict(pd.DataFrame({'staff': [23], 'post': ['yes'], 'corruption': [0.5]}))
```

#### 5.4 Gráfico Comparativo de Log-Likelihoods

```python
df_llf = pd.DataFrame({'modelo': ['Poisson', 'BNeg'],
                       'loglik': [modelo_poisson.llf, modelo_bneg.llf]})

fig, ax = plt.subplots(figsize=(15,10))
c = ['indigo', 'goldenrod']
ax1 = ax.barh(df_llf.modelo, df_llf.loglik, color=c)
ax.bar_label(ax1, label_type='center', color='white', fontsize=30)
ax.set_ylabel("Modelo Proposto", fontsize=20)
ax.set_xlabel("LogLik", fontsize=20)
plt.show()
```

#### 5.5 O Que Ocorre Quando NÃO Há Superdispersão

- Filtrando o dataset para manter apenas observações com `violations <= 3` (reduzindo a dispersão da variável dependente), o teste `overdisp()` deixa de detectar superdispersão.
- Nessa situação, o teste de razão de verossimilhança entre `modelo_poisson2` e `modelo_bneg2` **não rejeita H0**: os modelos passam a ser estatisticamente equivalentes.
- **Conclusão pedagógica**: quando não há superdispersão, **não existem diferenças significantes entre os modelos Poisson e binomial negativo** — a escolha do binomial negativo só se justifica quando a superdispersão é confirmada.

---

### 6. MODELOS INFLACIONADOS DE ZEROS

#### 6.1 Conceito

- São considerados uma **combinação entre um modelo para dados de contagem e um modelo para dados binários**.
- Servem para investigar simultaneamente:
  - as razões que levam a determinada **quantidade** de ocorrências (contagens) de um fenômeno; e
  - as razões que levam (ou não) à **ocorrência propriamente dita** do fenômeno, independentemente da quantidade de contagens observadas.
- **ZIP (Zero-Inflated Poisson)**: combinação de uma distribuição **Bernoulli** com uma distribuição **Poisson**.
- **ZINB (Zero-Inflated Negative Binomial)**: combinação de uma distribuição **Bernoulli** com uma distribuição **Poisson-Gama**.

> LAMBERT, D. **Zero-inflated Poisson regression, with an application to defects in manufacturing**. Technometrics, v. 34, n. 1, p. 1-14, 1992.

#### 6.2 Dois Processos Geradores de Zeros

Os modelos inflacionados de zeros apresentam **dois processos geradores de zeros**:

- **Zeros estruturais**: gerados pela distribuição binária (componente logit/inflate).
- **Zeros amostrais**: gerados pela distribuição de contagem (Poisson ou Poisson-Gama), entre os quais também podem existir zeros.

#### 6.3 Especificação do Modelo ZIP

```
p(Yᵢ = 0) = plogitᵢ + (1 - plogitᵢ) . e^(-λᵢ)

p(Yᵢ = m) = (1 - plogitᵢ) . (e^(-λᵢ) . λᵢ^m) / m!     , m = 1, 2, ...

λᵢ = e^(β₀ + β₁X₁ᵢ + ... + βₖXₖᵢ)

plogitᵢ = 1 / (1 + e^(-(γ₀ + γ₁W₁ᵢ + ... + γqWqᵢ)))
```

#### 6.4 Especificação do Modelo ZINB

```
p(Yᵢ = 0) = plogitᵢ + (1 - plogitᵢ) . [1 / (1 + α.λᵢ)]^(1/α)

p(Yᵢ = m) = (1 - plogitᵢ) . [δ^θ . m^(θ-1) . e^(-m.δ)] / (θ-1)!    , m = 1, 2, ...

λᵢ = e^(β₀ + β₁X₁ᵢ + ... + βₖXₖᵢ)

plogitᵢ = 1 / (1 + e^(-(γ₀ + γ₁W₁ᵢ + ... + γqWqᵢ)))
```

#### 6.5 Função Ilustrativa de Distribuição ZIP (didática)

```python
def zip_lambda1_plogit07(m):
    lmbda = 1
    plogit = 0.7
    if m == 0:
        return (plogit) + ((1 - plogit) * exp(-lmbda))
    else:
        return (1 - plogit) * ((exp(-lmbda) * lmbda ** m) / factorial(m))
```

#### 6.6 Teste de Vuong (1989)

> VUONG, Q. H. **Likelihood ratio tests for model selection and non-nested hypotheses**. Econometrica, v. 57, n. 2, p. 307-333, 1989.

- A definição sobre a existência ou não de uma quantidade **excessiva de zeros** na variável dependente Y é elaborada por meio de um teste específico: o **teste de Vuong**.
- É um importante output a ser analisado na estimação de modelos de regressão para dados de contagem, quando há suspeita de inflação de zeros.
- Compara o modelo "puro" (Poisson ou BNeg) contra sua versão inflacionada de zeros (ZIP ou ZINB).

```python
from statsmodels.discrete.discrete_model import NegativeBinomial, Poisson
from statsmodels.discrete.count_model import ZeroInflatedNegativeBinomialP, ZeroInflatedPoisson
from scipy.stats import norm

# Função vuong_test — Fávero, L. P.; Duarte, A.; Santos, H. P. (2024)
# "A new computational algorithm for assessing overdispersion and zero-inflation
# in machine learning count models with Python". Computers, v. 13(4), n. 88.

def vuong_test(m1, m2):
    supported_models = [ZeroInflatedPoisson, ZeroInflatedNegativeBinomialP,
                        Poisson, NegativeBinomial]

    if type(m1.model) not in supported_models or type(m2.model) not in supported_models:
        raise ValueError("Model type not supported.")

    m1_y = m1.model.endog
    m2_y = m2.model.endog

    m1_linpred = pd.DataFrame(m1.predict(which="prob"))
    m2_linpred = pd.DataFrame(m2.predict(which="prob"))

    m1_probs = np.repeat(np.nan, len(m1_y))
    m2_probs = np.repeat(np.nan, len(m2_y))

    which_col_m1 = [list(m1_linpred.columns).index(x) for x in m1_y]
    which_col_m2 = [list(m2_linpred.columns).index(x) for x in m2_y]

    for i in range(len(m1_probs)):
        m1_probs[i] = m1_linpred.iloc[i, which_col_m1[i]]
    for i in range(len(m2_probs)):
        m2_probs[i] = m2_linpred.iloc[i, which_col_m2[i]]

    m = np.log(m2_probs) - np.log(m1_probs)
    v = np.sum(m) / (np.std(m) * np.sqrt(len(m)))
    pval = 1 - norm.cdf(v) if v > 0 else norm.cdf(v)

    print(f"Vuong z-statistic: {round(v, 3)}")
    print(f"p-value: {pval:.4f}")
    if pval <= 0.05:
        print("H1: Indicates inflation of zeros at 95% confidence level")
    else:
        print("H0: Indicates no inflation of zeros at 95% confidence level")

# Teste propriamente dito
vuong_test(modelo_poisson, modelo_zip)   # Ocorrência de inflação de zeros!
vuong_test(modelo_bneg, modelo_zinb)     # Ocorrência de inflação de zeros!
```

#### 6.7 Estimação do Modelo ZIP em Python

```python
from statsmodels.discrete.count_model import ZeroInflatedPoisson

# Variável dependente
y = df_corruption['violations']

# Variáveis do componente de contagem
x1 = df_corruption[['staff', 'post', 'corruption']]
X1 = sm.add_constant(x1)
X1 = pd.get_dummies(X1, columns=['post'], dtype=int, drop_first=True)

# Variáveis do componente logit (inflate)
x2 = df_corruption[['corruption']]
X2 = sm.add_constant(x2)

# 'exog_infl' corresponde às variáveis do componente logit (inflate)
modelo_zip = sm.ZeroInflatedPoisson(y, X1, exog_infl=X2,
                                    inflation='logit').fit()

modelo_zip.summary()
```

#### 6.8 Estimação do Modelo ZINB em Python

```python
from statsmodels.discrete.count_model import ZeroInflatedNegativeBinomialP

modelo_zinb = sm.ZeroInflatedNegativeBinomialP(y, X1, exog_infl=X2,
                                               inflation='logit').fit()

modelo_zinb.summary()

# O parâmetro 'alpha' (fi) é o inverso do parâmetro 'theta' (forma da Poisson-Gama).
# Se 'alpha' for estatisticamente diferente de zero, há superdispersão nos dados
# (forma alternativa de detectar superdispersão).
```

---

### 7. ESCOLHA DO MODELO E COMPARAÇÃO FINAL

#### 7.1 Fluxo de Decisão

```
1. Estimar modelo Poisson
2. Aplicar teste de superdispersão de Cameron e Trivedi (overdisp)
   ├── Sem superdispersão → manter Poisson
   └── Com superdispersão → estimar modelo Binomial Negativo
3. Investigar excesso de zeros na variável dependente (histograma)
4. Aplicar teste de Vuong (Poisson vs. ZIP / BNeg vs. ZINB)
   ├── Sem inflação de zeros → manter Poisson ou BNeg
   └── Com inflação de zeros → preferir ZIP ou ZINB
5. Comparar Log-Likelihoods e usar LR test para decisão final
```

#### 7.2 Comparação de Previsões entre os Quatro Modelos

```python
# staff=23, período pré-lei, corruption=0.5

modelo_poisson.predict(pd.DataFrame({'staff':[23], 'post':['no'], 'corruption':[0.5]}))
modelo_bneg.predict(pd.DataFrame({'staff':[23], 'post':['no'], 'corruption':[0.5]}))

modelo_zip.predict(pd.DataFrame({'const':[1], 'staff':[23], 'corruption':[0.5],
                                 'post_yes':[0]}),
                   exog_infl=pd.DataFrame({'const':[1], 'corruption':[0.5]}))

modelo_zinb.predict(pd.DataFrame({'const':[1], 'staff':[23], 'corruption':[0.5],
                                  'post_yes':[0]}),
                    exog_infl=pd.DataFrame({'const':[1], 'corruption':[0.5]}))
```

#### 7.3 Gráfico Final Comparando os Quatro Modelos

```python
df_llf = pd.DataFrame({'modelo': ['Poisson', 'ZIP', 'BNeg', 'ZINB'],
                       'loglik': [modelo_poisson.llf, modelo_zip.llf,
                                 modelo_bneg.llf, modelo_zinb.llf]})

fig, ax = plt.subplots(figsize=(15,10))
c = ['indigo', 'deeppink', 'goldenrod', 'darkorange']
ax1 = ax.barh(df_llf.modelo, df_llf.loglik, color=c)
ax.bar_label(ax1, label_type='center', color='white', fontsize=30)
ax.set_ylabel("Modelo Proposto", fontsize=20)
ax.set_xlabel("LogLik", fontsize=20)
plt.show()
```

#### 7.4 Comparação com Modelo Linear (OLS) e Box-Cox

O material complementar também mostra que **não se deve** usar um modelo linear (OLS) diretamente sobre uma variável de contagem, mesmo com transformação de Box-Cox:

```python
modelo_linear = sm.OLS.from_formula('violations ~ staff + post + corruption',
                                    df_corruption).fit()
modelo_linear.summary()

from statstests.tests import shapiro_francia
shapiro_francia(modelo_linear.resid)   # residuos não normais

# Transformação de Box-Cox (necessário somar constante, pois há zeros)
from scipy.stats import boxcox
df_corruption['violations1'] = df_corruption['violations'] + 0.001
yast, lmbda = boxcox(df_corruption['violations1'])
df_corruption['bc_violations'] = yast

modelo_bc = sm.OLS.from_formula('bc_violations ~ staff + post + corruption',
                                df_corruption).fit()
shapiro_francia(modelo_bc.resid)  # ainda não normais

# Comparação de todos os LogLiks (Poisson, ZIP, BNeg, ZINB, OLS, OLS Box-Cox)
df_llf = pd.DataFrame({'modelo': ['Poisson','ZIP','BNeg','ZINB','OLS Linear','OLS Box-Cox'],
                      'loglik': [modelo_poisson.llf, modelo_zip.llf, modelo_bneg.llf,
                                modelo_zinb.llf, modelo_linear.llf, modelo_bc.llf]})
```

---

## 🐍 Implementação Python

### Bibliotecas Essenciais

```python
# Manipulação de dados
import pandas as pd
import numpy as np

# Funções matemáticas
from math import exp, factorial

# Visualização
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
from scipy.interpolate import interp1d

# Modelagem GLM / Contagem
import statsmodels.api as sm
import statsmodels.formula.api as smf
from statsmodels.discrete.discrete_model import Poisson, NegativeBinomial
from statsmodels.discrete.count_model import ZeroInflatedPoisson, ZeroInflatedNegativeBinomialP
from statsmodels.iolib.summary2 import summary_col

# Testes estatísticos
from scipy import stats
from scipy.stats import norm, boxcox
from statstests.tests import overdisp, shapiro_francia

# Utilitários
from tqdm import tqdm
import webbrowser

import warnings
warnings.filterwarnings('ignore')
```

### Pipeline Completo - Modelos para Dados de Contagem

```python
# 1. CARREGAMENTO E PREPARAÇÃO
df_corruption = pd.read_csv('corruption.csv', delimiter=',')
df_corruption.info()
df_corruption.describe()

# 2. ANÁLISE EXPLORATÓRIA
# Tabela de frequências da variável dependente
contagem = df_corruption['violations'].value_counts(dropna=False)
percent = (df_corruption['violations'].value_counts(dropna=False, normalize=True)*100).round(2)
table = pd.concat([contagem, percent], axis=1, keys=['contagem', '%'], sort=True)

# Histograma
sns.histplot(data=df_corruption, x='violations', bins=20,
             color='dodgerblue', edgecolor='white', kde=False)
plt.show()

# Diagnóstico preliminar média x variância
pd.DataFrame({'Média': [df_corruption.violations.mean()],
              'Variância': [df_corruption.violations.var()]})

# 3. ESTIMAÇÃO DO MODELO POISSON
modelo_poisson = sm.Poisson.from_formula(
    'violations ~ staff + post + corruption', data=df_corruption).fit()
modelo_poisson.summary()

# 4. TESTE DE SUPERDISPERSÃO (Cameron e Trivedi, 1990)
from statstests.tests import overdisp
overdisp(modelo_poisson, df_corruption)

# 5. SE HOUVER SUPERDISPERSÃO: ESTIMAR MODELO BINOMIAL NEGATIVO
modelo_bneg = sm.NegativeBinomial.from_formula(
    'violations ~ staff + post + corruption', data=df_corruption).fit()
modelo_bneg.summary()

# 6. COMPARAR POISSON x BNEG (LR TEST)
def lrtest(modelos):
    modelo_1 = modelos[0]
    llk_1 = modelo_1.llnull if len(modelos) == 1 else modelo_1.llf
    llk_2 = modelo_1.llf if len(modelos) == 1 else modelos[1].llf
    LR_statistic = -2 * (llk_1 - llk_2)
    p_val = stats.chi2.sf(LR_statistic, 1)
    print(f"-2.(LL0-LLm): {round(LR_statistic, 2)} | p-value: {p_val:.3f}")

lrtest([modelo_poisson, modelo_bneg])

# 7. ESTIMAR MODELOS INFLACIONADOS DE ZEROS (ZIP E ZINB)
y = df_corruption['violations']
x1 = df_corruption[['staff', 'post', 'corruption']]
X1 = sm.add_constant(x1)
X1 = pd.get_dummies(X1, columns=['post'], dtype=int, drop_first=True)
x2 = df_corruption[['corruption']]
X2 = sm.add_constant(x2)

modelo_zip = sm.ZeroInflatedPoisson(y, X1, exog_infl=X2, inflation='logit').fit()
modelo_zinb = sm.ZeroInflatedNegativeBinomialP(y, X1, exog_infl=X2, inflation='logit').fit()

# 8. TESTE DE VUONG (INFLAÇÃO DE ZEROS)
vuong_test(modelo_poisson, modelo_zip)
vuong_test(modelo_bneg, modelo_zinb)

# 9. COMPARAÇÃO FINAL DE LOG-LIKELIHOODS
df_llf = pd.DataFrame({'modelo': ['Poisson', 'ZIP', 'BNeg', 'ZINB'],
                       'loglik': [modelo_poisson.llf, modelo_zip.llf,
                                 modelo_bneg.llf, modelo_zinb.llf]})

fig, ax = plt.subplots(figsize=(15,10))
ax1 = ax.barh(df_llf.modelo, df_llf.loglik,
             color=['indigo', 'deeppink', 'goldenrod', 'darkorange'])
ax.bar_label(ax1, label_type='center', color='white', fontsize=30)
plt.show()

# 10. FITTED VALUES E PREDIÇÕES PONTUAIS
df_corruption['fitted_poisson'] = modelo_poisson.predict(linear=False)
df_corruption['fitted_bneg'] = modelo_bneg.predict(linear=False)
df_corruption['fitted_zip'] = modelo_zip.predict(X1, exog_infl=X2)
df_corruption['fitted_zinb'] = modelo_zinb.predict(X1, exog_infl=X2)
```

---

## 📊 Exemplos Práticos do Curso

### Exemplo Central: Corrupção e Multas de Trânsito Diplomáticas (dataset `corruption.csv`)

- **Fonte**: FISMAN, R.; MIGUEL, E. **Corruption, Norms, and Legal Enforcement: Evidence from Diplomatic Parking Tickets**. Journal of Political Economy, v. 15, n. 6, p. 1020-1048, 2007.
- **Contexto**: até 2002, diplomatas na cidade de Nova York eram imunes a punições por multas de estacionamento. O estudo analisa a relação entre o índice de corrupção dos países de origem dos diplomatas e a quantidade de multas de trânsito não pagas, antes e depois da entrada em vigor de uma lei que passou a permitir a punição (revogação da imunidade).
- **Variáveis**:
  - `country`, `code`: país e código ISO do diplomata
  - **Y = violations**: quantidade de violações de trânsito não pagas (variável de contagem)
  - `staff`: número de membros do corpo diplomático (tamanho da equipe)
  - `post`: indica se a observação é anterior (`no`) ou posterior (`yes`) à vigência da lei
  - `corruption`: índice de corrupção do país de origem
- **299 observações** (registros repetidos por país: um "antes" e um "depois" da lei).
- **Achados do curso**:
  - Todas as variáveis preditoras são estatisticamente significantes no modelo Poisson (p < 0.05).
  - O teste de Cameron e Trivedi detecta **superdispersão** → o modelo **Binomial Negativo** é mais adequado que o Poisson.
  - O teste de Vuong detecta **inflação de zeros** tanto na comparação Poisson × ZIP quanto BNeg × ZINB.
  - Quando o dataset é artificialmente restringido a `violations <= 3` (menor dispersão), a superdispersão desaparece e Poisson e BNeg passam a ser estatisticamente equivalentes — demonstrando de forma didática a relação entre dispersão dos dados e adequação do modelo.
  - Um modelo linear (OLS), mesmo com variável dependente transformada por Box-Cox, apresenta resíduos não normais (teste de Shapiro-Francia) e Log-Likelihood inferior aos modelos de contagem — reforçando que **regressão linear não é adequada para dados de contagem**.
- **Visualização**: mapa-múndi (choropleth, Plotly) com o índice de corrupção por país; gráficos de dispersão comparando `violations` (log) versus `corruption`, separados por período (`post`); gráficos de barras horizontais comparando Log-Likelihoods de todos os modelos estimados.

### Exemplo Complementar: Distribuições Teóricas

- Simulação e histograma de uma distribuição Poisson com `λ = 2` via `np.random.poisson`.
- Simulação e histograma de uma distribuição Binomial Negativa via `np.random.negative_binomial`, parametrizada por `theta` (forma) e `delta` (taxa de decaimento).
- Cálculo manual (fora do Python, com apoio de planilhas Excel) da máxima verossimilhança dos modelos Poisson, Binomial Negativo, ZIP e ZINB para o dataset `corruption`.

---

## 💡 Conceitos-Chave do Módulo

### 🎯 Fórmulas Essenciais

```
1. Distribuição Poisson:
   p(Yᵢ = m) = (e^(-λᵢ) . λᵢ^m) / m!
   E(Y) = λ    Var(Y) = λ  (equidispersão)

2. Modelo Poisson (log-linear):
   ln(λ̂ᵢ) = β₀ + β₁X₁ᵢ + ... + βₖXₖᵢ

3. Distribuição Poisson-Gama (Binomial Negativa):
   p(Yᵢ = m) = [δ^θ . m^(θ-1) . e^(-m.δ)] / (θ-1)!
   E(Y) = λ_bneg    Var(Y) = λ_bneg . (1 + α.λ_bneg)  (superdispersão)

4. Teste de Superdispersão (Cameron e Trivedi, 1990):
   Y*ᵢ = [(Yᵢ - λ̂ᵢ)² - Yᵢ] / λ̂ᵢ
   Modelo auxiliar: Y* ~ 0 + λ̂  (OLS sem intercepto)
   p-value(β) > 0.05 → equidispersão (Poisson OK)
   p-value(β) ≤ 0.05 → superdispersão (usar BNeg)

5. Modelo ZIP:
   p(Yᵢ=0) = plogitᵢ + (1-plogitᵢ).e^(-λᵢ)
   p(Yᵢ=m) = (1-plogitᵢ).(e^(-λᵢ).λᵢ^m)/m!    , m ≥ 1

6. Modelo ZINB:
   p(Yᵢ=0) = plogitᵢ + (1-plogitᵢ).[1/(1+α.λᵢ)]^(1/α)
   p(Yᵢ=m) = (1-plogitᵢ).[δ^θ.m^(θ-1).e^(-m.δ)]/(θ-1)!   , m ≥ 1

7. Teste de Razão de Verossimilhança (LR test):
   LR = -2.(LL_modelo_1 - LL_modelo_2)
   Comparar com χ² (graus de liberdade = diferença de parâmetros)

8. Teste de Vuong (1989):
   v = Σ(ln p₂ᵢ - ln p₁ᵢ) / [desvio-padrão . √n]
   p-value ≤ 0.05 → indica inflação de zeros
```

### 📐 Interpretações Importantes

**Superdispersão (α / phi):**

- α = 0 (ou não significante) → Poisson é suficiente
- α > 0 e estatisticamente significante → há superdispersão, use Binomial Negativa

**Parâmetro α no modelo ZINB:**

- Representa o "fi", que é o **inverso do parâmetro θ** (forma da Poisson-Gama).
- Se α for estatisticamente diferente de zero → confirma superdispersão (forma alternativa de diagnóstico).

**Log-Likelihood (LL / llf):**

- Sempre negativo; quanto **mais próximo de zero (menos negativo)**, melhor o ajuste.
- Usado para comparar modelos encaixados (LR test) e não encaixados (teste de Vuong).

**Escolha final do modelo:**

- Sem superdispersão e sem inflação de zeros → **Poisson**
- Com superdispersão, sem inflação de zeros → **Binomial Negativa**
- Sem superdispersão, com inflação de zeros → **ZIP**
- Com superdispersão e com inflação de zeros → **ZINB**

---

## ⚠️ Erros Comuns a Evitar

1. **Usar regressão linear (OLS) para variável de contagem**: gera resíduos não normais e estimativas inconsistentes.
2. **Assumir equidispersão sem testar**: sempre aplicar teste de Cameron e Trivedi (`overdisp`) antes de decidir entre Poisson e Binomial Negativo.
3. **Ignorar excesso de zeros na variável dependente**: aplicar teste de Vuong quando houver suspeita de inflação de zeros.
4. **Confundir componente de contagem com componente inflate (logit)**: argumento `exog_infl` define variáveis logísticas (probabilidade de zero estrutural).
5. **Comparar Poisson e Binomial Negativo sem LR test**: sempre testar significância antes de escolher modelo mais complexo.
6. **Usar LR test para modelos não encaixados**: para Poisson vs. ZIP, use **teste de Vuong**.
7. **Manter ordem incorreta dos parâmetros na predição de ZIP/ZINB**: ordem das colunas do `DataFrame` deve seguir ordem dos parâmetros do modelo.

---

## 📚 Materiais de Apoio

### Datasets Utilizados

- **corruption.csv**: 299 observações sobre violações de trânsito de diplomatas em Nova York, índice de corrupção do país, tamanho do corpo diplomático (`staff`) e período em relação à vigência da lei (`post`). Fonte: Fisman e Miguel (2007).

### Arquivos Excel

- **corruption POISSON Máxima Verossimilhança.xls**: cálculo manual de MLE do modelo Poisson.
- **corruption BNEG Máxima Verossimilhança.xls**: cálculo manual de MLE do modelo Binomial Negativo.
- **corruption ZIP Máxima Verossimilhança.xls**: cálculo manual de MLE do modelo ZIP.
- **corruption ZINB Máxima Verossimilhança.xls**: cálculo manual de MLE do modelo ZINB.
- **Dist. Poisson.xlsx** / **Distribuição ZIP.xlsx**: visualização das distribuições Poisson e ZIP.
- **Dist. Binomial Negativa.xlsx** / **Distribuição ZINB.xlsx**: visualização das distribuições Binomial Negativa e ZINB.

### Scripts Python do Curso

- **03 - SCRIPT - MODELOS PARA DADOS DE CONTAGEM.py**: script principal, com toda a pipeline de estimação (Poisson, superdispersão, Binomial Negativa, ZIP, ZINB, teste de Vuong).
- **SCRIPT COMPLEMENTAR.py**, **Código Complementar 01.py**, **Código Complementar 02.py**: cálculos manuais de fitted values, comparação com modelo linear/Box-Cox e teste de Shapiro-Francia.

### Pacote `statstests`

- **Autores**: Luiz Paulo Fávero e Helder Prado Santos.
- **URL**: https://stats-tests.github.io/statstests/
- **Funções relevantes para este módulo**: `overdisp()` (teste de superdispersão de Cameron e Trivedi) e `shapiro_francia()` (teste de normalidade de resíduos).

---

## 📖 Referências Recomendadas

### Referências Principais

**Artigos**

- **Cameron, A.C.; Trivedi, P.K.** (1990). "Regression-based tests for overdispersion in the Poisson model". *Journal of Econometrics*, v. 46, n. 3, p. 347-364.
- **Vuong, Q.H.** (1989). "Likelihood ratio tests for model selection and non-nested hypotheses". *Econometrica*, v. 57, n. 2, p. 307-333.
- **Lambert, D.** (1992). "Zero-inflated Poisson regression, with an application to defects in manufacturing". *Technometrics*, v. 34, n. 1, p. 1-14.
- **Famoye, F.; Singh, K.P.** (2006). "Zero-inflated generalized Poisson regression model with an application to domestic violence data". *Journal of Data Science*, v. 4, n. 1, p. 117-130.
- **Gardner, W.; Mulvey, E.P.; Shaw, E.C.** (1995). "Regression analyses of counts and rates: Poisson, overdispersed Poisson, and negative binomial models". *Psychological Bulletin*, v. 118, n. 3, p. 392-404.
- **Fávero, L.P.; Duarte, A.; Santos, H.P.** (2024). "A new computational algorithm for assessing overdispersion and zero-inflation in machine learning count models with Python". *Computers*, v. 13(4), n. 88, p. 1-15.
- **Fisman, R.; Miguel, E.** (2007). "Corruption, Norms, and Legal Enforcement: Evidence from Diplomatic Parking Tickets". *Journal of Political Economy*, v. 15, n. 6, p. 1020-1048.

---


---

**📌 Nota Final:** Os modelos para dados de contagem (Poisson, Binomial Negativo, ZIP e ZINB) são essenciais sempre que a variável dependente representa uma contagem de eventos. Usar regressão linear nesses casos é um erro comum e leva a estimativas inadequadas. O diagnóstico correto de superdispersão (teste de Cameron e Trivedi) e de inflação de zeros (teste de Vuong) é o que orienta a escolha do modelo mais adequado entre as quatro alternativas apresentadas.

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_
_Módulo 20 - Supervised Machine Learning - Modelos para Dados de Contagem_
