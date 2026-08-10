# 📈 Resumo do Curso: Supervised Machine Learning - Análise de Regressão Simples e Múltipla

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Dominar técnicas de **Regressão Linear Simples e Múltipla** como ferramentas de Machine Learning Supervisionado para modelagem preditiva de variáveis contínuas, incluindo estimação OLS, diagnósticos, transformações não lineares, tratamento de variáveis categóricas, e uso adequado de pressupostos estatísticos para construção de modelos robustos e interpretáveis.

---

## 📚 Conteúdo Principal

### 1. REGRESSÃO LINEAR SIMPLES

#### 1.1 Conceito Fundamental

- **Definição**: Modelo que estima a relação entre uma variável dependente (Y) e uma variável explicativa (X)
- **Equação**: Y = β₀ + β₁X + ε
  - β₀: intercepto (valor de Y quando X = 0)
  - β₁: coeficiente angular (variação em Y para cada unidade de X)
  - ε: termo de erro aleatório
- **Objetivo**: Minimizar a soma dos quadrados dos resíduos (método dos Mínimos Quadrados Ordinários - OLS)

#### 1.2 Estimação OLS (Ordinary Least Squares)

```python
import statsmodels.api as sm

# Estimação do modelo
modelo = sm.OLS.from_formula('tempo ~ distancia', df).fit()

# Visualização dos parâmetros
modelo.summary()
```

#### 1.3 Interpretação dos Parâmetros

- **R² (Coeficiente de Determinação)**: Proporção da variância de Y explicada por X
  - Varia de 0 a 1 (0% a 100%)
  - R² = (correlação)² em regressão simples
  - Quanto maior, melhor o ajuste do modelo
- **p-value**: Significância estatística dos coeficientes
  - p < 0.05: coeficiente estatisticamente significante (nível de confiança 95%)
  - p < 0.01: alta significância (nível de confiança 99%)
- **Std err (Erro Padrão)**: Medida da precisão da estimativa do coeficiente

#### 1.4 Fitted Values e Resíduos

```python
# Adicionar valores preditos ao dataset
df['fitted'] = modelo.fittedvalues

# Adicionar resíduos (diferença entre valor real e predito)
df['residuos'] = modelo.resid

# Visualizar ajuste
sns.scatterplot(x='distancia', y='tempo', data=df, label='Valores Reais')
sns.lineplot(x='distancia', y='fitted', data=df, color='red', label='Fitted Values')
```

#### 1.5 Intervalos de Confiança

- **Definição**: Faixa de valores dentro da qual o verdadeiro parâmetro populacional está contido com determinado nível de confiança
- **Níveis comuns**: 90%, 95%, 99%
- **Interpretação**: IC 95% significa que em 95% das amostras, o intervalo conterá o valor verdadeiro

```python
# Intervalos de confiança dos coeficientes
modelo.conf_int(alpha=0.05)  # 95% de confiança
modelo.conf_int(alpha=0.10)  # 90% de confiança
```

#### 1.6 Predições

```python
# Fazer predição para novo valor de X
novo_valor = pd.DataFrame({'distancia': [25]})
predicao = modelo.predict(novo_valor)
print(f"Tempo estimado: {predicao[0]}")
```

#### 1.7 ⚠️ ERRO COMUM: Remoção Indevida do Intercepto

```python
# ERRADO: Remover intercepto quando ele é significante
modelo_errado = sm.OLS.from_formula('tempo ~ 0 + distancia', df).fit()
# Isso causa VIÉS nas estimativas e reduz a qualidade do modelo!

# CORRETO: Manter intercepto quando significante
modelo_correto = sm.OLS.from_formula('tempo ~ distancia', df).fit()
```

- **Regra**: Só remova o intercepto se houver justificativa teórica ou se ele não for estatisticamente significante

---

### 2. REGRESSÃO LINEAR MÚLTIPLA

#### 2.1 Conceito Fundamental

- **Definição**: Modelo com múltiplas variáveis explicativas
- **Equação**: Y = β₀ + β₁X₁ + β₂X₂ + ... + βₖXₖ + ε
- **Vantagem**: Controla efeitos de múltiplas variáveis simultaneamente (ceteris paribus)

#### 2.2 Estimação

```python
# Modelo com 2 preditores
modelo_multiplo = sm.OLS.from_formula('cpi ~ idade + horas', df).fit()
```

#### 2.3 R² Ajustado (Adjusted R²)

- **Necessidade**: R² sempre aumenta ao adicionar variáveis, mesmo irrelevantes
- **Solução**: R² Ajustado penaliza modelos com muitas variáveis
- **Fórmula**: R²_adj = 1 - [(1-R²)(n-1)/(n-k-1)]
  - n: número de observações
  - k: número de variáveis explicativas
- **Uso**: Comparar modelos com diferentes números de variáveis

```python
print(f"R²: {modelo.rsquared}")
print(f"R² Ajustado: {modelo.rsquared_adj}")
```

#### 2.4 Matriz de Correlações

```python
# Correlação simples
correlation_matrix = df.corr()

# Mapa de calor
plt.figure(figsize=(15, 10))
sns.heatmap(correlation_matrix, annot=True, fmt=".4f",
            cmap='viridis_r', vmin=-1, vmax=1)
plt.show()

# Correlações com p-valores (pingouin)
import pingouin as pg
correlation_table = pg.rcorr(df, method='pearson', upper='pval',
                             pval_stars={0.01: '***', 0.05: '**', 0.10: '*'})
```

#### 2.5 Visualização 3D

```python
import plotly.graph_objects as go

# Gráfico 3D interativo
fig = go.Figure(data=[go.Scatter3d(
    x=df['idade'], y=df['horas'], z=df['cpi'],
    mode='markers',
    marker=dict(size=5, color=df['cpi'], colorscale='Viridis')
)])
fig.update_layout(scene=dict(
    xaxis_title='Idade',
    yaxis_title='Horas',
    zaxis_title='CPI'
))
fig.write_html('grafico3d.html')
```

#### 2.6 Pairplot com Correlações

```python
from scipy.stats import pearsonr

def corrfunc(x, y, **kws):
    (r, p) = pearsonr(x, y)
    ax = plt.gca()
    ax.annotate(f"r = {r:.3f}", xy=(.30, .9), xycoords=ax.transAxes)
    ax.annotate(f"p = {p:.3f}", xy=(.30, .8), xycoords=ax.transAxes)

graph = sns.pairplot(df, diag_kind="kde")
graph.map(corrfunc)
plt.show()
```

---

### 3. VARIÁVEIS CATEGÓRICAS E DUMMIES

#### 3.1 Problema das Variáveis Qualitativas

- **Erro Comum**: Atribuir números arbitrários a categorias
  - Exemplo ERRADO: África=1, Américas=2, Ásia=3, Europa=4, Oceania=5
  - **Problema**: Isso implica que Oceania é "5x melhor" que África, o que não faz sentido!

#### 3.2 Solução: Variáveis Dummy

- **Definição**: Variáveis binárias (0 ou 1) que indicam presença/ausência de categoria
- **Regra n-1**: Para k categorias, criar k-1 dummies
  - A categoria omitida é a **categoria de referência**
  - Evita multicolinearidade perfeita

#### 3.3 Criação de Dummies

```python
# Método 1: get_dummies com drop_first
df_dummies = pd.get_dummies(df, columns=['regiao'], dtype=int, drop_first=True)

# Resultado para 5 regiões: cria 4 dummies
# regiao_Americas, regiao_Asia, regiao_Europa, regiao_Oceania
# África fica como referência (todas as dummies = 0)
```

#### 3.4 Interpretação de Coeficientes com Dummies

```python
modelo_dummy = sm.OLS.from_formula('cpi ~ regiao_Americas + regiao_Asia + regiao_Europa + regiao_Oceania', df_dummies).fit()
```

- **Intercepto**: Média da categoria de referência (África)
- **Coeficiente da dummy**: Diferença média em relação à categoria de referência
  - Exemplo: β_Americas = 2.5 → Américas tem CPI 2.5 pontos maior que África, em média

#### 3.5 Visualização com Dummies

```python
# Gráfico com interpolação não linear
from scipy import interpolate

df_grouped = df_dummies.groupby('regiao_numerico')['fitted'].median().reset_index()
x = df_grouped['regiao_numerico']
y = df_grouped['fitted']

tck = interpolate.splrep(x, y, k=2)
xnew = np.arange(1, 5, 0.1)
ynew = interpolate.splev(xnew, tck, der=0)

plt.scatter(df['regiao_numerico'], df['cpi'], color='darkorange', alpha=0.5)
plt.scatter(df['regiao_numerico'], df['fitted'], color='limegreen')
plt.plot(xnew, ynew, color='indigo', linewidth=2.5)
plt.show()
```

---

### 4. TRANSFORMAÇÃO DE BOX-COX

#### 4.1 Motivação

- **Problema**: Relações não lineares entre X e Y
- **Sintoma**: Resíduos não normais, ajuste visual ruim
- **Solução**: Transformar Y para linearizar a relação

#### 4.2 Conceito de Box-Cox

- **Objetivo**: Encontrar a melhor transformação potência que normaliza os resíduos
- **Fórmula**: Y\* = (Y^λ - 1) / λ
  - λ = 1: sem transformação
  - λ = 0.5: raiz quadrada
  - λ = 0: logaritmo natural (limite quando λ→0)
  - λ = -1: inverso

#### 4.3 Aplicação

```python
from scipy.stats import boxcox

# Calcular lambda ótimo e transformar Y
yast, lmbda = boxcox(df['comprimento'])
print(f"Lambda ótimo: {lmbda}")

# Adicionar variável transformada ao dataset
df['bc_comprimento'] = yast

# Estimação com Box-Cox
modelo_bc = sm.OLS.from_formula('bc_comprimento ~ idade', df).fit()
```

#### 4.4 Reversão da Transformação (Predições)

```python
# Predição na escala transformada
pred_transformado = modelo_bc.predict(pd.DataFrame({'idade': [52]}))

# Reverter para escala original
pred_original = (pred_transformado * lmbda + 1) ** (1 / lmbda)
print(f"Comprimento estimado: {pred_original[0]}")
```

#### 4.5 Comparação de Modelos

```python
from statsmodels.iolib.summary2 import summary_col

summary_col([modelo_linear, modelo_bc],
            model_names=["LINEAR", "BOX-COX"],
            stars=True,
            info_dict={'N': lambda x: "{0:d}".format(int(x.nobs))})

# ⚠️ CUIDADO: Os parâmetros NÃO são diretamente comparáveis!
# Compare apenas R², AIC, BIC, normalidade dos resíduos
```

#### 4.6 Verificação dos Resultados

```python
# Comparação de R²
print(f"R² Linear: {modelo_linear.rsquared:.4f}")
print(f"R² Box-Cox: {modelo_bc.rsquared:.4f}")

# Salvar fitted values
df['yhat_linear'] = modelo_linear.fittedvalues
df['yhat_bc'] = (modelo_bc.fittedvalues * lmbda + 1) ** (1 / lmbda)

# Visualização comparativa
plt.figure(figsize=(15,10))
sns.scatterplot(x='idade', y='comprimento', data=df, color='grey', s=350)
sns.lineplot(x='idade', y='yhat_linear', data=df, color='darkorange',
             linewidth=2.5, label='Linear')
sns.lineplot(x='idade', y='yhat_bc', data=df, color='darkviolet',
             linewidth=2.5, label='Box-Cox')
plt.legend()
plt.show()
```

---

### 5. PROCEDIMENTO STEPWISE

#### 5.1 Objetivo

- **Problema**: Muitas variáveis preditoras, algumas podem ser irrelevantes
- **Solução**: Seleção automática de variáveis com base na significância estatística

#### 5.2 Tipos de Stepwise

- **Forward**: Adiciona variáveis uma a uma (da mais significante)
- **Backward**: Remove variáveis uma a uma (da menos significante)
- **Stepwise**: Combinação de forward e backward

#### 5.3 Aplicação

```python
from statstests.process import stepwise

# Modelo completo inicial
modelo_completo = sm.OLS.from_formula('retorno ~ disclosure + endividamento + ativos + liquidez', df).fit()

# Aplicar Stepwise
modelo_step = stepwise(modelo_completo, pvalue_limit=0.05)

# O modelo resultante contém apenas variáveis com p < 0.05
```

#### 5.4 Interpretação

- **Variáveis incluídas**: Todas com p-value < 0.05 (ou outro limite definido)
- **Variáveis excluídas**: Não estatisticamente significantes
- **Benefício**: Modelo mais parcimonioso e interpretável

#### 5.5 ⚠️ Limitações

- Não garante o melhor modelo teórico
- Pode excluir variáveis teoricamente importantes
- Sensível a multicolinearidade
- Deve ser combinado com conhecimento do domínio

---

### 6. DIAGNÓSTICO DE MULTICOLINEARIDADE

#### 6.1 Conceito

- **Definição**: Correlação alta entre variáveis explicativas
- **Problema**:
  - Coeficientes instáveis e imprecisos
  - Erros padrão inflados
  - Dificuldade de identificar efeitos individuais

#### 6.2 VIF (Variance Inflation Factor)

- **Definição**: Mede quanto a variância de um coeficiente é inflada pela multicolinearidade
- **Fórmula**: VIF = 1 / (1 - R²ⱼ)
  - R²ⱼ: R² da regressão de Xⱼ sobre as demais variáveis explicativas
- **Interpretação**:
  - VIF < 5: Multicolinearidade aceitável
  - 5 ≤ VIF < 10: Multicolinearidade moderada
  - VIF ≥ 10: Multicolinearidade severa (PROBLEMA!)

#### 6.3 Tolerância

- **Definição**: Inverso do VIF
- **Fórmula**: Tolerância = 1 / VIF
- **Interpretação**:
  - Tolerância > 0.20: Aceitável
  - Tolerância < 0.10: Problema de multicolinearidade

#### 6.4 Cálculo em Python

```python
from statsmodels.stats.outliers_influence import variance_inflation_factor

# Preparar dados (adicionar constante)
X = sm.add_constant(df[['rh1', 'econometria1']])

# Calcular VIF
VIF = pd.DataFrame()
VIF["Variável"] = X.columns[1:]
VIF["VIF"] = [variance_inflation_factor(X.values, i+1)
              for i in range(X.shape[1]-1)]

# Calcular Tolerância
VIF["Tolerância"] = 1 / VIF["VIF"]
print(VIF)
```

#### 6.5 Exemplo Prático

```python
# EXEMPLO 1: Correlação baixa (r = 0.168) entre rh1 e econometria1
# Resultado: VIF ≈ 1.03, Tolerância ≈ 0.97 → SEM problema

# EXEMPLO 2: Correlação alta (r = 0.964) entre rh2 e econometria2
# Resultado: VIF ≈ 14.16, Tolerância ≈ 0.07 → PROBLEMA SEVERO!
```

#### 6.6 Soluções para Multicolinearidade

1. **Remover uma das variáveis correlacionadas**
2. **Combinar variáveis** (ex: criar índice ou média)
3. **Aumentar tamanho da amostra**
4. **Ridge Regression** ou outras técnicas de regularização
5. **Análise de Componentes Principais (PCA)** antes da regressão

---

### 7. DIAGNÓSTICO DE HETEROCEDASTICIDADE

#### 7.1 Conceito

- **Homoscedasticidade**: Variância dos resíduos constante (IDEAL)
- **Heterocedasticidade**: Variância dos resíduos não constante (PROBLEMA)
- **Consequência**:
  - Erros padrão incorretos
  - Testes de hipótese inválidos
  - Intervalos de confiança imprecisos

#### 7.2 Detecção Visual

```python
# Gráfico de resíduos vs fitted values
plt.figure(figsize=(15,10))
sns.scatterplot(x='fitted', y='residuos', data=df)
plt.axhline(y=0, color='red', linestyle='--')
plt.xlabel('Fitted Values')
plt.ylabel('Resíduos')
plt.show()

# Padrão desejado: Nuvem aleatória ao redor de zero
# Padrão problemático: Forma de cone, funil, ou padrão sistemático
```

#### 7.3 Teste de Breusch-Pagan

- **H₀**: Ausência de heterocedasticidade (homoscedasticidade)
- **H₁**: Presença de heterocedasticidade
- **Interpretação**:
  - p-value > 0.05: Não rejeita H₀ (homoscedasticidade, OK!)
  - p-value < 0.05: Rejeita H₀ (heterocedasticidade, PROBLEMA!)

```python
def breusch_pagan_test(modelo):
    df_temp = pd.DataFrame({
        'yhat': modelo.fittedvalues,
        'resid': modelo.resid
    })
    df_temp['up'] = (np.square(df_temp.resid)) / \
                     np.sum((np.square(df_temp.resid)) / df_temp.shape[0])

    modelo_aux = sm.OLS.from_formula('up ~ yhat', df_temp).fit()
    anova_table = sm.stats.anova_lm(modelo_aux, typ=2)
    anova_table['sum_sq'] = anova_table['sum_sq'] / 2

    chisq = anova_table['sum_sq'].iloc[0]
    p_value = stats.chi2.pdf(chisq, 1) * 2

    return float(chisq), float(p_value)

# Aplicar teste
chisq, p = breusch_pagan_test(modelo)
print(f"Chi-square: {chisq:.4f}")
print(f"P-value: {p:.6f}")

if p > 0.05:
    print("Ausência de heterocedasticidade (OK!)")
else:
    print("Heterocedasticidade detectada (problema!)")
```

#### 7.4 Causas Comuns

- **Omissão de variável relevante** (mais comum!)
- **Forma funcional incorreta** (relação não linear)
- **Outliers** ou observações influentes
- **Erro de especificação** do modelo

#### 7.5 Soluções

1. **Adicionar variáveis omitidas** (variáveis dummy, quadráticas, etc.)
2. **Transformar variáveis** (Box-Cox)
3. **Usar erros padrão robustos** (White, HC3)
4. **Weighted Least Squares (WLS)**

```python
# Exemplo: Adicionar dummies de Estado para controlar heterogeneidade
df_dummies = pd.get_dummies(df, columns=['uf'], dtype=int, drop_first=True)

# Lista de variáveis dummy
lista_colunas = list(df_dummies.drop(columns=['Y', 'X', 'outras']).columns)
formula = "Y ~ X + " + " + ".join(lista_colunas)

# Novo modelo
modelo_com_dummies = sm.OLS.from_formula(formula, df_dummies).fit()

# Aplicar Stepwise
modelo_step = stepwise(modelo_com_dummies, pvalue_limit=0.05)

# Re-testar heterocedasticidade
breusch_pagan_test(modelo_step)
```

---

### 8. TESTE DE NORMALIDADE DOS RESÍDUOS

#### 8.1 Importância

- **Pressuposto**: Resíduos devem seguir distribuição normal
- **Consequência**: Validade dos testes de hipótese e intervalos de confiança
- **Robustez**: Regressão é razoavelmente robusta a violações com amostras grandes

#### 8.2 Teste de Shapiro-Francia

- **Aplicação**: Para n ≥ 30
- **H₀**: Distribuição aderente à normalidade
- **H₁**: Distribuição não aderente à normalidade

```python
from statstests.tests import shapiro_francia

# Aplicar teste
teste_sf = shapiro_francia(modelo.resid)
teste_sf = teste_sf.items()
method, statistics_W, statistics_z, p = teste_sf

print(f'Statistics W={statistics_W[1]:.5f}, p-value={p[1]:.6f}')

alpha = 0.05
if p[1] > alpha:
    print('Não se rejeita H0 - Distribuição aderente à normalidade')
else:
    print('Rejeita-se H0 - Distribuição não aderente à normalidade')
```

#### 8.3 Teste de Shapiro-Wilk

- **Aplicação**: Para n < 30

```python
from scipy.stats import shapiro

statistic, p = shapiro(modelo.resid)
print(f'Statistics={statistic:.5f}, p-value={p:.6f}')
```

#### 8.4 Visualização - Histograma com Curva Normal

```python
from scipy.stats import norm

# Calcular parâmetros da distribuição normal teórica
(mu, sigma) = norm.fit(modelo.resid)

# Criar histograma com densidade
plt.figure(figsize=(15,10))
sns.histplot(modelo.resid, bins=20, kde=True, stat="density",
             color='darkorange', alpha=0.4)

# Adicionar curva normal teórica
x = np.linspace(modelo.resid.min(), modelo.resid.max(), 100)
p = norm.pdf(x, mu, sigma)
plt.plot(x, p, 'k', linewidth=2)

plt.xlabel('Resíduos do Modelo', fontsize=20)
plt.ylabel('Frequência', fontsize=20)
plt.legend(['Distribuição Normal Teórica', 'Distribuição Real', 'Histograma'])
plt.show()
```

#### 8.5 Q-Q Plot

```python
import scipy.stats as stats

fig, ax = plt.subplots(figsize=(12, 8))
stats.probplot(modelo.resid, dist="norm", plot=ax)
ax.set_title("Q-Q Plot", fontsize=18)
ax.set_xlabel("Quantis Teóricos", fontsize=14)
ax.set_ylabel("Quantis Observados", fontsize=14)
plt.show()

# Interpretação: Pontos devem estar próximos à linha diagonal
```

---

### 9. REGRESSÃO NÃO LINEAR MÚLTIPLA COM BOX-COX

#### 9.1 Workflow Completo

```python
# 1. Modelo inicial completo
modelo_inicial = sm.OLS.from_formula('retorno ~ disclosure + endividamento + ativos + liquidez', df).fit()

# 2. Teste de normalidade
teste_sf = shapiro_francia(modelo_inicial.resid)
# Se rejeitar normalidade → aplicar Box-Cox

# 3. Transformação Box-Cox
yast, lmbda = boxcox(df['retorno'])
df['bc_retorno'] = yast

# 4. Novo modelo com Y transformado
modelo_bc = sm.OLS.from_formula('bc_retorno ~ disclosure + endividamento + ativos + liquidez', df).fit()

# 5. Stepwise para seleção de variáveis
modelo_step_bc = stepwise(modelo_bc, pvalue_limit=0.05)

# 6. Verificar normalidade no modelo final
teste_sf_final = shapiro_francia(modelo_step_bc.resid)
# Deve não rejeitar H0 (normalidade OK!)

# 7. Fazer predições (lembrar de reverter transformação!)
pred_transformado = modelo_step_bc.predict(pd.DataFrame({
    'const': [1],
    'disclosure': [50],
    'ativos': [4000],
    'liquidez': [14]
}))
pred_original = (pred_transformado * lmbda + 1) ** (1 / lmbda)
```

#### 9.2 Comparação de Modelos

```python
# Adicionar fitted values ao dataset
df['yhat_linear'] = modelo_step_linear.fittedvalues
df['yhat_bc'] = (modelo_step_bc.fittedvalues * lmbda + 1) ** (1 / lmbda)

# Gráfico: Fitted vs Real
from scipy.optimize import curve_fit

def objective(x, a, b, c, d, e, f):
    return (a*x) + (b*x**2) + (c*x**3) + (d*x**4) + (e*x**5) + f

plt.figure(figsize=(17,10))
plt.plot(df['retorno'], df['retorno'], color='gray', linestyle='-', label='Linha 45°')
plt.scatter(df['retorno'], df['yhat_linear'], alpha=0.5, s=150, color='darkorange', label='Linear')
plt.scatter(df['retorno'], df['yhat_bc'], alpha=0.5, s=150, color='indigo', label='Box-Cox')

# Linhas de tendência
popt, _ = curve_fit(objective, df['retorno'], df['yhat_linear'])
x_line = np.arange(df['retorno'].min(), df['retorno'].max(), 1)
y_line = objective(x_line, *popt)
plt.plot(x_line, y_line, '--', color='darkorange', linewidth=3)

popt, _ = curve_fit(objective, df['retorno'], df['yhat_bc'])
y_line = objective(x_line, *popt)
plt.plot(x_line, y_line, '--', color='indigo', linewidth=3)

plt.xlabel('Valores Reais', fontsize=17)
plt.ylabel('Fitted Values', fontsize=17)
plt.legend(fontsize=18)
plt.show()
```

---

### 10. MODELOS COM MÚLTIPLAS DUMMIES

#### 10.1 Exemplo: Planos de Saúde

```python
# Dataset com variável categórica 'plano' (3 categorias)
df_planosaude = pd.read_csv('planosaude.csv')

# Variáveis: despmed (Y), idade, renda, plano (categórica)

# Dummização
df_dummies = pd.get_dummies(df_planosaude, columns=['plano'],
                            dtype=int, drop_first=True)

# Resultado: plano_2, plano_3 (plano_1 é referência)

# Modelo
modelo = sm.OLS.from_formula('despmed ~ idade + renda + plano_2 + plano_3',
                             df_dummies).fit()
```

#### 10.2 Interpretação com Múltiplas Dummies

- **Intercepto**: Despesa média para plano_1 (referência) com idade=0, renda=0
- **β_plano_2**: Diferença de despesa entre plano_2 e plano_1, controlando idade e renda
- **β_plano_3**: Diferença de despesa entre plano_3 e plano_1, controlando idade e renda

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
import plotly.graph_objects as go

# Estatística e modelagem
import statsmodels.api as sm
from statsmodels.iolib.summary2 import summary_col
from statsmodels.stats.outliers_influence import variance_inflation_factor
from scipy.stats import pearsonr, boxcox, norm, shapiro
from scipy import interpolate, stats, optimize
import pingouin as pg

# Testes e procedimentos (pacote statstests)
from statstests.tests import shapiro_francia
from statstests.process import stepwise

# Grafos de correlação
import networkx as nx
import matplotlib.cm as cm
```

### Pipeline Completo de Análise

```python
# 1. CARREGAMENTO E EXPLORAÇÃO
df = pd.read_csv('dados.csv')
print(df.info())
print(df.describe())

# 2. ANÁLISE EXPLORATÓRIA
# Matriz de correlações
correlation_matrix = df.corr()
sns.heatmap(correlation_matrix, annot=True, cmap='viridis_r')
plt.show()

# Pairplot
sns.pairplot(df, diag_kind="kde")
plt.show()

# 3. MODELO INICIAL
modelo_inicial = sm.OLS.from_formula('Y ~ X1 + X2 + X3', df).fit()
print(modelo_inicial.summary())

# 4. DIAGNÓSTICOS
# 4.1 Normalidade dos resíduos
teste_sf = shapiro_francia(modelo_inicial.resid)
p_normalidade = teste_sf.items()[3][1]

# 4.2 Heterocedasticidade
chisq, p_hetero = breusch_pagan_test(modelo_inicial)

# 4.3 Multicolinearidade
X = sm.add_constant(df[['X1', 'X2', 'X3']])
VIF = pd.DataFrame()
VIF["Variável"] = X.columns[1:]
VIF["VIF"] = [variance_inflation_factor(X.values, i+1)
              for i in range(X.shape[1]-1)]
print(VIF)

# 5. CORREÇÕES SE NECESSÁRIO
# Se resíduos não normais → Box-Cox
if p_normalidade < 0.05:
    yast, lmbda = boxcox(df['Y'])
    df['bc_Y'] = yast
    modelo_bc = sm.OLS.from_formula('bc_Y ~ X1 + X2 + X3', df).fit()
    modelo_inicial = modelo_bc

# Se heterocedasticidade → adicionar variáveis/dummies
if p_hetero < 0.05:
    # Adicionar dummies ou outras variáveis
    pass

# Se multicolinearidade → remover variáveis ou PCA
if (VIF['VIF'] > 10).any():
    # Remover variáveis com VIF alto
    pass

# 6. SELEÇÃO DE VARIÁVEIS
modelo_final = stepwise(modelo_inicial, pvalue_limit=0.05)
print(modelo_final.summary())

# 7. VALIDAÇÃO FINAL
teste_sf_final = shapiro_francia(modelo_final.resid)
chisq_final, p_hetero_final = breusch_pagan_test(modelo_final)

# 8. PREDIÇÕES
df['fitted'] = modelo_final.fittedvalues
df['residuos'] = modelo_final.resid

# Se usou Box-Cox, reverter transformação
if 'lmbda' in locals():
    df['fitted_original'] = (df['fitted'] * lmbda + 1) ** (1 / lmbda)

# 9. VISUALIZAÇÕES FINAIS
plt.figure(figsize=(15,10))
plt.scatter(df['Y'], df['fitted_original'], alpha=0.5)
plt.plot([df['Y'].min(), df['Y'].max()],
         [df['Y'].min(), df['Y'].max()], 'r--')
plt.xlabel('Valores Reais')
plt.ylabel('Valores Preditos')
plt.title('Ajuste do Modelo')
plt.show()
```

---

## 📊 Exemplos Práticos do Curso

### Exemplo 1: Regressão Simples - Tempo vs Distância

- **Dataset**: tempodist.csv
- **Objetivo**: Predizer tempo de percurso em função da distância
- **Variáveis**: tempo (Y), distancia (X)
- **Resultado**: R² ≈ 0.97, relação linear forte

### Exemplo 2: Regressão Múltipla - Corrupção em Países

- **Dataset**: paises.csv
- **Objetivo**: Explicar índice de percepção de corrupção (CPI)
- **Variáveis**: cpi (Y), idade (X₁), horas (X₂)
- **Técnicas**: Visualização 3D, matriz de correlação

### Exemplo 3: Variáveis Dummy - Corrupção por Região

- **Dataset**: corrupcao.csv
- **Objetivo**: Comparar CPI entre regiões do mundo
- **Variáveis**: cpi (Y), regiao (categórica - 5 níveis)
- **Técnicas**: n-1 dummies, interpolação spline

### Exemplo 4: Box-Cox - Crescimento de Bebês

- **Dataset**: bebes.csv
- **Objetivo**: Modelar crescimento não linear (comprimento vs idade)
- **Variáveis**: comprimento (Y), idade (X)
- **Resultado**: λ ≈ 2.66, R² saltou de 0.87 para 0.97

### Exemplo 5: Regressão Múltipla com Box-Cox - Retorno de Empresas

- **Dataset**: empresas.csv
- **Objetivo**: Prever retorno financeiro
- **Variáveis**: retorno (Y), disclosure, endividamento, ativos, liquidez
- **Técnicas**: Stepwise, Box-Cox, normalização de resíduos
- **Resultado**: Disclosure volta ao modelo após transformação

### Exemplo 6: Multicolinearidade - Salários

- **Dataset**: salarios.csv
- **Objetivo**: Demonstrar efeitos da multicolinearidade
- **Comparação**:
  - rh1 vs econometria1: r = 0.168, VIF = 1.03 (OK)
  - rh2 vs econometria2: r = 0.964, VIF = 14.16 (PROBLEMA!)

### Exemplo 7: Heterocedasticidade - Desempenho SAEB

- **Dataset**: saeb_rend.csv
- **Objetivo**: Modelar desempenho escolar vs rendimento
- **Variáveis**: saeb (Y), rendimento (X), uf (dummies), rede (categórica)
- **Técnicas**: Teste de Breusch-Pagan, dummies de UF, Stepwise
- **Resultado**: Heterocedasticidade eliminada após adicionar dummies

### Exemplo 8: Múltiplas Dummies - Planos de Saúde

- **Dataset**: planosaude.csv
- **Objetivo**: Explicar despesas médicas
- **Variáveis**: despmed (Y), idade, renda, plano (categórica - 3 níveis)
- **Técnicas**: Dummização, Stepwise, diagnósticos completos

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Fundamentos de Regressão

1. **OLS (Mínimos Quadrados Ordinários)**: Método que minimiza soma dos resíduos ao quadrado
2. **β₀ (Intercepto)**: Valor estimado de Y quando todos os X = 0
3. **β₁, β₂, ... (Coeficientes)**: Variação em Y por unidade de X, mantendo demais variáveis constantes
4. **Resíduo**: Diferença entre valor observado e valor predito (e = Y - Ŷ)
5. **Fitted Value (Ŷ)**: Valor predito pelo modelo

### 🎯 Métricas de Qualidade do Modelo

1. **R²**: Proporção da variância de Y explicada pelo modelo (0 a 1)
2. **R² Ajustado**: R² penalizado pelo número de variáveis (preferir para comparar modelos)
3. **AIC/BIC**: Critérios de informação para comparação de modelos (menor é melhor)
4. **p-value dos coeficientes**: Significância estatística (< 0.05 é significante)
5. **Erro Padrão**: Precisão da estimativa do coeficiente

### 🔍 Diagnósticos Essenciais

1. **Normalidade dos Resíduos**: Shapiro-Francia (n≥30) ou Shapiro-Wilk (n<30)
2. **Heterocedasticidade**: Teste de Breusch-Pagan (H₀: homocedasticidade)
3. **Multicolinearidade**: VIF > 10 indica problema
4. **Tolerância**: < 0.10 indica multicolinearidade severa
5. **Linearidade**: Verificar visualmente com scatter plots

### 🛠️ Técnicas de Transformação e Seleção

1. **Box-Cox**: Transformação Y\* = (Y^λ - 1)/λ para normalizar resíduos
2. **Reversão Box-Cox**: Y = (Y\*×λ + 1)^(1/λ)
3. **Stepwise**: Seleção automática de variáveis (p < 0.05)
4. **n-1 Dummies**: Para k categorias, criar k-1 dummies
5. **Categoria de Referência**: Categoria omitida nas dummies (intercepto representa ela)

### ⚠️ Erros Comuns a Evitar

1. **Remover intercepto quando significante**: Causa viés nas estimativas
2. **Codificar categorias com números arbitrários**: Use dummies!
3. **Comparar coeficientes entre modelos linear e Box-Cox**: Escalas diferentes!
4. **Ignorar multicolinearidade**: Resulta em coeficientes instáveis
5. **Não verificar pressupostos**: Testes de hipótese podem ser inválidos
6. **Adicionar variáveis sem critério**: Aumenta R² mas piora interpretação
7. **Usar todos os dummies**: Causa multicolinearidade perfeita (singularidade)
8. **Esquecer de reverter Box-Cox nas predições**: Resultados na escala errada

### 📐 Fórmulas Importantes

```
1. Modelo Linear Simples:
   Y = β₀ + β₁X + ε

2. Modelo Linear Múltiplo:
   Y = β₀ + β₁X₁ + β₂X₂ + ... + βₖXₖ + ε

3. R² Ajustado:
   R²_adj = 1 - [(1-R²)(n-1)/(n-k-1)]

4. VIF:
   VIF = 1 / (1 - R²ⱼ)

5. Tolerância:
   Tol = 1 / VIF

6. Box-Cox:
   Y* = (Y^λ - 1) / λ

7. Reversão Box-Cox:
   Y = (Y*×λ + 1)^(1/λ)
```

---

## 📚 Materiais de Apoio

### Datasets Utilizados

- **tempodist.csv/xls**: Tempo de percurso vs distância
- **paises.csv**: Índice de corrupção, idade e horas de trabalho por país
- **corrupcao.csv**: CPI por país e região
- **bebes.csv**: Crescimento de bebês (comprimento vs idade)
- **empresas.csv**: Retorno financeiro, disclosure, endividamento, ativos, liquidez
- **salarios.csv**: Salários vs notas em disciplinas (multicolinearidade)
- **saeb_rend.csv**: Desempenho escolar SAEB vs rendimento municipal
- **planosaude.csv**: Despesas médicas vs idade, renda e tipo de plano

### Pacote `statstests`

- **Autores**: Luiz Paulo Fávero e Helder Prado Santos
- **URL**: https://stats-tests.github.io/statstests/
- **Funções principais**:
  - `shapiro_francia()`: Teste de normalidade para n ≥ 30
  - `stepwise()`: Seleção automática de variáveis

### Arquivos de Apoio

- **Script principal**: 01 - SCRIPT - REGRESSÃO SIMPLES E MÚLTIPLA.py
- **Script complementar**: script complementar.py
- **PDFs**: Supervised M Learning 03 10 2402 e 03032026_SLpdf Portugues.pdf
- **Material didático**: SML - Analise de Regressao Simples e Multipla_MCzip Portugues.zip
- **Som interativo**: sound.mp3 (pygame para demonstrações)

---

## 🎯 Pontos Importantes para Reter

### Workflow de Análise de Regressão

1. **Exploração de Dados**: Estatísticas descritivas, correlações, visualizações
2. **Modelo Inicial**: Estimar OLS com todas as variáveis teoricamente relevantes
3. **Diagnósticos**: Normalidade, heterocedasticidade, multicolinearidade
4. **Correções**: Box-Cox, dummies, remoção de variáveis
5. **Seleção**: Stepwise ou seleção manual baseada em teoria
6. **Validação Final**: Re-verificar pressupostos no modelo final
7. **Interpretação**: Coeficientes, significâncias, intervalos de confiança
8. **Predições**: Fazer predições, lembrando de reverter transformações

### Quando Usar Cada Técnica

| Problema                     | Diagnóstico                   | Solução                                  |
| ---------------------------- | ----------------------------- | ---------------------------------------- |
| Relação não linear           | R² baixo, resíduos com padrão | Box-Cox, termos quadráticos              |
| Resíduos não normais         | Shapiro-Francia p < 0.05      | Box-Cox, transformações                  |
| Heterocedasticidade          | Breusch-Pagan p < 0.05        | Adicionar variáveis, Box-Cox             |
| Multicolinearidade           | VIF > 10                      | Remover variável, combinar, PCA          |
| Variáveis categóricas        | -                             | n-1 dummies                              |
| Muitas variáveis             | Interpretação difícil         | Stepwise, seleção teórica                |
| Coeficiente não significante | p > 0.05                      | Remover (se não teoricamente importante) |
| R² baixo                     | -                             | Adicionar variáveis relevantes           |

### Interpretação de Resultados

**Para Regressão Simples:**

```
Y = 5.2 + 2.3X
```

- Interpretação: Para cada unidade de aumento em X, Y aumenta 2.3 unidades, em média
- Quando X = 0, Y = 5.2

**Para Regressão Múltipla:**

```
Y = 10 + 3X₁ + 1.5X₂
```

- β₁ = 3: Mantendo X₂ constante, cada unidade de X₁ aumenta Y em 3 unidades
- β₂ = 1.5: Mantendo X₁ constante, cada unidade de X₂ aumenta Y em 1.5 unidades

**Para Dummies:**

```
Y = 50 + 2.5X + 10Dummy₂ + 20Dummy₃
```

- Categoria 1 (referência): Y = 50 + 2.5X
- Categoria 2: Y = 60 + 2.5X (10 unidades a mais que categoria 1)
- Categoria 3: Y = 70 + 2.5X (20 unidades a mais que categoria 1)

### Checklist de Qualidade do Modelo

✅ **R² ou R² Ajustado razoável** (depende do contexto, mas > 0.6 é bom em muitos casos)  
✅ **Todos os coeficientes significantes** (p < 0.05)  
✅ **Sinais dos coeficientes fazem sentido** teórico  
✅ **Resíduos normalmente distribuídos** (Shapiro-Francia p > 0.05)  
✅ **Ausência de heterocedasticidade** (Breusch-Pagan p > 0.05)  
✅ **VIF < 10** para todas as variáveis  
✅ **Gráfico resíduos vs fitted sem padrão** sistemático  
✅ **Predições fazem sentido** prático

---

## 📖 Referências Recomendadas

### Livros

1. **Fávero, L. P. & Belfiore, P.** "Manual de Análise de Dados: Estatística e Modelagem Multivariada com Excel, SPSS e Stata"
2. **James, G., Witten, D., Hastie, T., & Tibshirani, R.** "An Introduction to Statistical Learning" (disponível gratuitamente)
3. **Montgomery, D. C., Peck, E. A., & Vining, G. G.** "Introduction to Linear Regression Analysis"
4. **Kutner, M. H., Nachtsheim, C. J., Neter, J., & Li, W.** "Applied Linear Statistical Models"

### Artigos e Tutoriais

- **Box, G. E. P., & Cox, D. R. (1964).** "An Analysis of Transformations" - Journal of the Royal Statistical Society
- **Breusch, T. S., & Pagan, A. R. (1979).** "A Simple Test for Heteroscedasticity and Random Coefficient Variation"
- Documentação statsmodels: https://www.statsmodels.org/
- Documentação scikit-learn: https://scikit-learn.org/

### Recursos Online

- **Statsmodels**: Documentação completa de regressão OLS
- **Seaborn/Matplotlib**: Galeria de visualizações para regressão
- **Plotly**: Gráficos 3D interativos
- **Stack Overflow**: Comunidade para dúvidas específicas
- **Kaggle**: Datasets e notebooks de regressão

---

## ✅ Checklist de Estudo

### Conceitos Teóricos

- [ ] Entender diferença entre regressão simples e múltipla
- [ ] Saber interpretar R², R² ajustado, p-values
- [ ] Conhecer pressupostos da regressão linear (LÍNEA)
  - **L**inearidade
  - **I**ndependência dos resíduos
  - **N**ormalidade dos resíduos
  - **E**quality of variance (homocedasticidade)
  - **A**usência de multicolinearidade
- [ ] Compreender conceito de ceteris paribus
- [ ] Entender diferença entre correlação e causalidade

### Técnicas de Diagnóstico

- [ ] Realizar teste de normalidade (Shapiro-Francia/Wilk)
- [ ] Aplicar teste de Breusch-Pagan
- [ ] Calcular e interpretar VIF e Tolerância
- [ ] Analisar gráfico de resíduos vs fitted values
- [ ] Criar e interpretar Q-Q plot

### Transformações e Correções

- [ ] Aplicar transformação Box-Cox
- [ ] Reverter Box-Cox para predições
- [ ] Criar variáveis dummy (n-1)
- [ ] Interpretar coeficientes de dummies
- [ ] Usar procedimento Stepwise

### Visualizações

- [ ] Criar scatter plots com linha de regressão
- [ ] Gerar mapas de calor de correlação
- [ ] Fazer gráficos 3D interativos (plotly)
- [ ] Plotar histogramas de resíduos com curva normal
- [ ] Criar pairplots com correlações

### Implementação Python

- [ ] Estimar modelo OLS com statsmodels
- [ ] Extrair e interpretar summary do modelo
- [ ] Fazer predições com novos dados
- [ ] Salvar fitted values e resíduos
- [ ] Comparar múltiplos modelos (summary_col)

### Casos Práticos

- [ ] Reproduzir Exemplo 1 (regressão simples)
- [ ] Reproduzir Exemplo 2 (regressão múltipla)
- [ ] Reproduzir Exemplo 3 (dummies)
- [ ] Reproduzir Exemplo 4 (Box-Cox simples)
- [ ] Reproduzir Exemplo 5 (Box-Cox múltipla)
- [ ] Reproduzir Exemplo 6 (multicolinearidade)
- [ ] Reproduzir Exemplo 7 (heterocedasticidade)
- [ ] Reproduzir Exemplo 8 (múltiplas dummies)

### Projeto Final

- [ ] Carregar dataset próprio
- [ ] Realizar análise exploratória completa
- [ ] Estimar modelo inicial
- [ ] Fazer todos os diagnósticos
- [ ] Aplicar correções necessárias
- [ ] Selecionar variáveis (Stepwise ou manual)
- [ ] Validar modelo final
- [ ] Fazer predições
- [ ] Interpretar resultados
- [ ] Apresentar conclusões

---

**📌 Nota Final:** A Regressão Linear é a base de todo Machine Learning Supervisionado. Dominar esses conceitos é essencial para avançar para técnicas mais complexas como Regressão Logística, GLM, LASSO, Ridge, Elastic Net, e até mesmo Redes Neurais. A compreensão profunda dos diagnósticos e pressupostos garante modelos confiáveis e interpretáveis.

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_  
_Módulo 18 - Supervised Machine Learning - Análise de Regressão Simples e Múltipla_
