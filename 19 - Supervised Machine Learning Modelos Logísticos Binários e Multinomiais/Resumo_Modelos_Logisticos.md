# 🎲 Resumo do Curso: Supervised Machine Learning - Modelos Logísticos Binários e Multinomiais

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Dominar técnicas de **Regressão Logística Binária e Multinomial** como ferramentas de Machine Learning Supervisionado para classificação, incluindo estimação por máxima verossimilhança, interpretação de odds ratios, avaliação de modelos através de matriz de confusão, curva ROC, AUC, e aplicação em problemas reais de classificação binária e multiclasse.

---

## 📚 Conteúdo Principal

### 1. CONCEITOS FUNDAMENTAIS

#### 1.1 Diferença entre Regressão Linear e Logística

- **Regressão Linear**: Variável Y contínua (valores reais)
  - Exemplo: Predizer salário, temperatura, preço
- **Regressão Logística**: Variável Y categórica (classes discretas)
  - **Binária**: 2 categorias (sim/não, 0/1, sucesso/falha)
  - **Multinomial**: 3+ categorias (baixo/médio/alto, A/B/C/D)

#### 1.2 Função Logística (Sigmoide)

- **Problema**: Regressão linear pode gerar probabilidades < 0 ou > 1
- **Solução**: Transformar saída linear em probabilidade entre 0 e 1
- **Fórmula da Sigmoide**:

```
P(Y=1) = 1 / (1 + e^(-z))

onde: z = β₀ + β₁X₁ + β₂X₂ + ... + βₖXₖ (logito)
```

#### 1.3 Interpretação do Logito (z)

- **z → -∞**: P(Y=1) → 0 (improvável)
- **z = 0**: P(Y=1) = 0.5 (equiprovável)
- **z → +∞**: P(Y=1) → 1 (provável)

#### 1.4 Visualização da Curva Sigmoide

```python
from math import exp
import numpy as np
import matplotlib.pyplot as plt

def prob(z):
    return 1 / (1 + exp(-z))

# Logitos de -5 a +5
logitos = np.arange(-5, 6)
probs = [prob(z) for z in logitos]

plt.figure(figsize=(15,10))
plt.plot(logitos, probs, color='darkorchid', linewidth=3, marker='o', markersize=10)
plt.axhline(y=0.5, color='grey', linestyle=':', label='P=0.5')
plt.axvline(x=0, color='grey', linestyle=':', label='z=0')
plt.xlabel("Logito Z", fontsize=20)
plt.ylabel("Probabilidade", fontsize=20)
plt.title("Curva Sigmoide", fontsize=22)
plt.legend()
plt.show()
```

---

### 2. REGRESSÃO LOGÍSTICA BINÁRIA

#### 2.1 Estimação do Modelo

- **Método**: Máxima Verossimilhança (Maximum Likelihood Estimation - MLE)
  - Não usa OLS (Mínimos Quadrados)
  - Maximiza a probabilidade de observar os dados
- **Função em Python**: `sm.Logit.from_formula()`

```python
import statsmodels.api as sm

# Estimação do modelo
modelo = sm.Logit.from_formula('atrasado ~ dist + sem', df).fit()

# Visualização dos parâmetros
modelo.summary()
```

#### 2.2 Interpretação dos Coeficientes

- **Coeficientes (β)**: Efeito no logito (log-odds)
- **β > 0**: Aumenta probabilidade do evento
- **β < 0**: Diminui probabilidade do evento
- **Odds Ratio (OR)**: e^β
  - OR > 1: Aumenta chances do evento
  - OR = 1: Sem efeito
  - OR < 1: Diminui chances do evento

#### 2.3 Exemplo de Interpretação

```python
# Modelo: P(atrasado=1) = f(β₀ + β₁*dist + β₂*sem)
# Resultado: β₁ = 0.1904, β₂ = 2.3629

# Interpretação:
# - βtempo₁ = 0.1904: Cada km adicional aumenta o logito em 0.1904
# - β₂ = 2.3629: Cada semáforo adicional aumenta o logito em 2.3629

# Odds Ratio:
import numpy as np
OR_dist = np.exp(0.1904)  # ≈ 1.21
OR_sem = np.exp(2.3629)   # ≈ 10.62

# Cada km adicional aumenta as chances de atraso em 21%
# Cada semáforo adicional aumenta as chances de atraso em 962% (!!)
```

#### 2.4 Predições

```python
# Probabilidade de atraso com dist=7km e sem=10 semáforos
prob = modelo.predict(pd.DataFrame({'dist': [7], 'sem': [10]}))
print(f"Probabilidade de atraso: {prob[0]:.4f}")

# Cálculo manual (verificação)
z = -26.1665 + 0.1904*7 + 2.3629*10  # Logito
prob_manual = 1 / (1 + np.exp(-z))
print(f"Verificação: {prob_manual:.4f}")
```

---

### 3. MÉTRICAS DE AVALIAÇÃO - CLASSIFICAÇÃO BINÁRIA

#### 3.1 Matriz de Confusão

- **Estrutura**:

```
                 Valor Real
              |  0  |  1  |
         -----|-----|-----|
Predito  0   | TN  | FN  |
         1   | FP  | TP  |
```

- **TN (True Negative)**: Previu 0, era 0 ✅
- **TP (True Positive)**: Previu 1, era 1 ✅
- **FP (False Positive)**: Previu 1, era 0 ❌ (Erro Tipo I)
- **FN (False Negative)**: Previu 0, era 1 ❌ (Erro Tipo II)

#### 3.2 Cutoff (Ponto de Corte)

- **Definição**: Limiar de probabilidade para classificar como 1
- **Padrão**: cutoff = 0.5
  - Se P(Y=1) ≥ 0.5 → Classificar como 1
  - Se P(Y=1) < 0.5 → Classificar como 0
- **Ajustável**: Depende do contexto do problema

#### 3.3 Indicadores da Matriz de Confusão

```python
from sklearn.metrics import confusion_matrix, accuracy_score, recall_score

def matriz_confusao(predicts, observado, cutoff):
    # Classificação binária baseada no cutoff
    predicao_binaria = (predicts >= cutoff).astype(int)

    # Matriz de confusão
    cm = confusion_matrix(observado, predicao_binaria)

    # Métricas
    sensitividade = recall_score(observado, predicao_binaria, pos_label=1)
    especificidade = recall_score(observado, predicao_binaria, pos_label=0)
    acuracia = accuracy_score(observado, predicao_binaria)

    return {
        'Sensitividade': sensitividade,
        'Especificidade': especificidade,
        'Acurácia': acuracia
    }
```

#### 3.4 Sensitividade (Recall, Taxa de Verdadeiros Positivos)

- **Fórmula**: Sensitividade = TP / (TP + FN)
- **Interpretação**: Proporção de positivos corretamente identificados
- **Contexto**: "Dos que realmente são positivos (1), quantos % o modelo acertou?"
- **Exemplo**:
  - 100 pessoas doentes, modelo identificou 85 → Sensitividade = 85%
  - Perdeu 15 casos (Falsos Negativos)

#### 3.5 Especificidade (Taxa de Verdadeiros Negativos)

- **Fórmula**: Especificidade = TN / (TN + FP)
- **Interpretação**: Proporção de negativos corretamente identificados
- **Contexto**: "Dos que realmente são negativos (0), quantos % o modelo acertou?"
- **Exemplo**:
  - 100 pessoas saudáveis, modelo identificou 90 → Especificidade = 90%
  - 10 alarmes falsos (Falsos Positivos)

#### 3.6 Acurácia (Accuracy)

- **Fórmula**: Acurácia = (TP + TN) / (TP + TN + FP + FN)
- **Interpretação**: Proporção total de acertos
- **⚠️ ATENÇÃO**: Pode ser enganosa em datasets desbalanceados!
  - Exemplo: 95% da classe 0, 5% da classe 1
  - Modelo que sempre prevê 0 terá 95% de acurácia, mas é inútil!

#### 3.7 Trade-off: Sensitividade vs Especificidade

- **Cutoff baixo (ex: 0.3)**: ↑ Sensitividade (detecta mais positivos), ↓ Especificidade (mais falsos alarmes)
- **Cutoff alto (ex: 0.7)**: ↓ Sensitividade (perde alguns positivos), ↑ Especificidade (menos falsos alarmes)
- No script da aula, o modelo `atrasado` e o modelo `fidelidade` foram testados nos cutoffs 0.3, 0.5 e 0.7, com o aviso explícito de que a escolha de um cutoff que iguale sensitividade e especificidade tem fins **apenas didáticos** e não garante maximizar a acurácia do modelo

```python
# Testando diferentes cutoffs
for cutoff in [0.3, 0.5, 0.7]:
    metricas = matriz_confusao(df['phat'], df['atrasado'], cutoff)
    print(f"Cutoff {cutoff}: {metricas}")
```

#### 3.8 Encontrando Cutoff Ótimo

```python
def espec_sens(observado, predicts):
    cutoffs = np.arange(0, 1.01, 0.01)
    lista_sensitividade = []
    lista_especificidade = []

    for cutoff in cutoffs:
        predicao_binaria = (predicts >= cutoff).astype(int)

        sens = recall_score(observado, predicao_binaria, pos_label=1)
        espec = recall_score(observado, predicao_binaria, pos_label=0)

        lista_sensitividade.append(sens)
        lista_especificidade.append(espec)

    return pd.DataFrame({
        'cutoffs': cutoffs,
        'sensitividade': lista_sensitividade,
        'especificidade': lista_especificidade
    })

# Plotar sensitividade e especificidade vs cutoff
dados = espec_sens(df['atrasado'], df['phat'])

plt.figure(figsize=(15,10))
plt.plot(dados['cutoffs'], dados['sensitividade'], marker='o',
         color='indigo', label='Sensitividade')
plt.plot(dados['cutoffs'], dados['especificidade'], marker='o',
         color='darkorange', label='Especificidade')
plt.xlabel('Cutoff', fontsize=20)
plt.ylabel('Métrica', fontsize=20)
plt.legend(fontsize=20)
plt.show()

# Encontrar cutoff onde sensitividade ≈ especificidade
dados['diff'] = abs(dados['sensitividade'] - dados['especificidade'])
cutoff_equilibrado = dados.loc[dados['diff'].idxmin(), 'cutoffs']
print(f"Cutoff equilibrado: {cutoff_equilibrado}")
```

---

### 4. CURVA ROC E AUC

#### 4.1 Conceito da Curva ROC

- **ROC**: Receiver Operating Characteristic
- **Eixo X**: 1 - Especificidade (Taxa de Falsos Positivos)
- **Eixo Y**: Sensitividade (Taxa de Verdadeiros Positivos)
- **Objetivo**: Avaliar desempenho do modelo em todos os cutoffs possíveis

#### 4.2 Interpretação Visual

- **Linha diagonal (y=x)**: Modelo aleatório (AUC = 0.5)
- **Quanto mais próxima do canto superior esquerdo**: Melhor
- **Área abaixo da curva (AUC)**: Métrica de qualidade geral

#### 4.3 AUC (Area Under the Curve)

- **Intervalo**: 0 a 1
- **AUC = 0.5**: Modelo tão bom quanto jogar moeda (equivale à linha diagonal do gráfico)
- Quanto mais próxima de 1, melhor a capacidade de discriminação do modelo

#### 4.4 Coeficiente de GINI

- **Fórmula**: GINI = (AUC - 0.5) / 0.5 = 2×AUC - 1
- **Interpretação**: Normalização do AUC entre -1 e 1
- **Valores**:
  - GINI = 0: Modelo aleatório
  - GINI = 1: Modelo perfeito
  - GINI < 0: Modelo pior que aleatório

#### 4.5 Implementação

```python
from sklearn.metrics import roc_curve, auc

# Calcular pontos da curva ROC
fpr, tpr, thresholds = roc_curve(df['atrasado'], df['phat'])

# Calcular AUC
roc_auc = auc(fpr, tpr)

# Calcular GINI
gini = (roc_auc - 0.5) / 0.5

# Plotar curva ROC
plt.figure(figsize=(15,10))
plt.plot(fpr, tpr, marker='o', color='darkorchid',
         markersize=11, linewidth=3, label=f'ROC (AUC = {roc_auc:.4f})')
plt.plot([0, 1], [0, 1], color='gray', linestyle='dashed',
         label='Modelo Aleatório')
plt.title(f'Área abaixo da curva: {roc_auc:.4f} | GINI: {gini:.4f}',
          fontsize=22)
plt.xlabel('1 - Especificidade (FPR)', fontsize=20)
plt.ylabel('Sensitividade (TPR)', fontsize=20)
plt.legend(fontsize=18)
plt.show()
```

---

### 5. LOG-LIKELIHOOD E TESTES DE QUALIDADE

#### 5.1 Log-Likelihood (LL ou llf)

- **Definição**: Logaritmo da verossimilhança dos dados dado o modelo
- **Valores**: Sempre negativo (log de probabilidade < 1)
- **Interpretação**: Quanto maior (menos negativo), melhor o ajuste
- **Acesso**: `modelo.llf`

```python
# Log-likelihood do modelo
print(f"Log-Likelihood: {modelo.llf:.4f}")
```

#### 5.2 Modelo Nulo (Null Model)

- **Definição**: Modelo apenas com intercepto (sem variáveis explicativas)
- **Uso**: Baseline para comparação

```python
# Estimação do modelo nulo
modelo_nulo = sm.Logit.from_formula('atrasado ~ 1', df).fit()
print(f"LL Nulo: {modelo_nulo.llf:.4f}")
```

#### 5.3 Teste de Razão de Verossimilhança (LLR - Chi²)

- **Objetivo**: Testar se o modelo completo é melhor que o modelo nulo
- **H₀**: Modelo completo não é melhor (todos β = 0, exceto intercepto)
- **H₁**: Modelo completo é melhor (pelo menos um β ≠ 0)
- **Fórmula**: Chi² = -2 × (LL_nulo - LL_modelo)
- **Graus de liberdade**: Número de variáveis explicativas

```python
from scipy import stats

# Cálculo do Chi²
chi2 = -2 * (modelo_nulo.llf - modelo.llf)
print(f"Chi²: {chi2:.4f}")

# Graus de liberdade (número de variáveis explicativas)
gl = 2  # 'dist' e 'sem'

# P-value
pvalue = stats.distributions.chi2.sf(chi2, gl)
print(f"P-value: {pvalue:.6f}")

# Interpretação
if pvalue < 0.05:
    print("Rejeita H0: Modelo é significativamente melhor que o modelo nulo")
else:
    print("Não rejeita H0: Modelo não é melhor")
```

#### 5.4 Pseudo R² de McFadden

- **Análogo ao R² da regressão linear**, mas para regressão logística
- **Fórmula**: Pseudo R² = 1 - (LL_modelo / LL_nulo)

```python
# Cálculo do Pseudo R² de McFadden
pseudoR2 = 1 - (modelo.llf / modelo_nulo.llf)
print(f"Pseudo R² de McFadden: {pseudoR2:.4f}")

# Método alternativo (equivalente), demonstrado no script da aula
pseudoR2_alt = ((-2*modelo_nulo.llf) - (-2*modelo.llf)) / (-2*modelo_nulo.llf)
print(f"Verificação: {pseudoR2_alt:.4f}")
```

---

### 6. VISUALIZAÇÕES PARA REGRESSÃO LOGÍSTICA

#### 6.1 Ajuste Linear (ERRADO - apenas didático)

```python
# ERRO COMUM: Usar regressão linear para variável binária
plt.figure(figsize=(15,10))
sns.regplot(x='sem', y='atrasado', data=df, ci=None,
            scatter_kws={'color':'orange', 's':250, 'alpha':0.7},
            line_kws={'color':'darkorchid', 'linewidth':7})
plt.axhline(y=0.5, color='grey', linestyle=':')
plt.xlabel('Semáforos', fontsize=20)
plt.ylabel('Atrasado', fontsize=20)
plt.title('ERRADO: Ajuste Linear (pode gerar P>1 ou P<0)', fontsize=18)
plt.show()
```

#### 6.2 Curva Sigmoide (CORRETO)

```python
# Ajuste logístico determinístico (0s e 1s observados)
plt.figure(figsize=(15,10))
sns.regplot(x='sem', y='atrasado', data=df, ci=None,
            logistic=True, marker='o',
            scatter_kws={'color':'orange', 's':250, 'alpha':0.7},
            line_kws={'color':'darkorchid', 'linewidth':7})
plt.axhline(y=0.5, color='grey', linestyle=':', label='P=0.5 (cutoff)')
plt.xlabel('Semáforos', fontsize=20)
plt.ylabel('Probabilidade de Atraso', fontsize=20)
plt.legend(fontsize=16)
plt.show()

# Ajuste logístico probabilístico (probabilidades preditas)
plt.figure(figsize=(15,10))
sns.regplot(x='sem', y='phat', data=df, ci=None,
            logistic=True, marker='o',
            scatter_kws={'color':'orange', 's':250, 'alpha':0.7},
            line_kws={'color':'darkorchid', 'linewidth':7})
plt.axhline(y=0.5, color='grey', linestyle=':')
plt.xlabel('Semáforos', fontsize=20)
plt.ylabel('Probabilidade Predita', fontsize=20)
plt.show()
```

#### 6.3 Pairplot com Classes

```python
# Scatters coloridos por classe
cores = {0: 'springgreen', 1: 'darkorchid'}
g = sns.pairplot(df[['atrasado', 'dist', 'sem']],
                hue='atrasado', palette=cores)
plt.show()
```

---

### 7. PROCEDIMENTO STEPWISE EM REGRESSÃO LOGÍSTICA

#### 7.1 Aplicação

```python
from statstests.process import stepwise

# Modelo completo
modelo_completo = sm.Logit.from_formula('falha ~ temperatura + pressao', df).fit()

# Aplicar Stepwise (remove variáveis não significantes)
modelo_step = stepwise(modelo_completo, pvalue_limit=0.05)

# Resultado: mantém apenas variáveis com p < 0.05
modelo_step.summary()
```

---

### 8. REGRESSÃO LOGÍSTICA COM VARIÁVEIS CATEGÓRICAS

#### 8.1 Dummização

```python
# Dataset com variáveis qualitativas
# fidelidade (Y): sim/não
# sexo: masculino/feminino
# atendimento, sortimento, acessibilidade, preço: ruim/regular/bom

# 1. Transformar Y para 0 e 1
df.loc[df['fidelidade'] == 'sim', 'fidelidade'] = 1
df.loc[df['fidelidade'] == 'nao', 'fidelidade'] = 0
df['fidelidade'] = df['fidelidade'].astype('int64')

# 2. Dummizar variáveis explicativas categóricas
df_dummies = pd.get_dummies(df,
                            columns=['atendimento', 'sortimento',
                                   'acessibilidade', 'preço', 'sexo'],
                            dtype=int,
                            drop_first=True)

# 3. Criar fórmula automaticamente
lista_colunas = list(df_dummies.drop(columns=['id', 'fidelidade']).columns)
formula = "fidelidade ~ " + " + ".join(lista_colunas)
print(f"Fórmula: {formula}")

# 4. Estimar modelo
modelo = sm.Logit.from_formula(formula, df_dummies).fit()
```

---

### 9. REGRESSÃO LOGÍSTICA MULTINOMIAL

#### 9.1 Conceito

- **Uso**: Variável dependente com 3+ categorias
- **Exemplos**:
  - Nível socioeconômico: baixo/médio/alto
  - Satisfação: insatisfeito/neutro/satisfeito
  - Gravidade: leve/moderado/grave
- **Categoria de Referência**: Uma categoria é escolhida como baseline

#### 9.2 Estimação

```python
from statsmodels.discrete.discrete_model import MNLogit
import statsmodels.api as sm

# Preparar dados
# Y deve ser numérica (0, 1, 2, ... k-1)
# 0: categoria de referência
# 1, 2, ...: demais categorias

df['atrasado2'] = df['atrasado'].map({
    'nao chegou atrasado': 0,           # referência
    'chegou atrasado primeira aula': 1,
    'chegou atrasado segunda aula': 2
})

# Variáveis explicativas
X = df[['dist', 'sem']]
X = sm.add_constant(X)  # Adicionar intercepto manualmente

# Variável dependente
y = df['atrasado2']

# Estimação
modelo_multi = MNLogit(endog=y, exog=X).fit()

# Parâmetros
modelo_multi.summary()
```

#### 9.3 Interpretação dos Parâmetros

- **O modelo estima k-1 equações** (k = número de categorias)
- **Cada equação**: Compara uma categoria com a referência

```
# Exemplo com 3 categorias (0, 1, 2):
# Categoria 0 = referência

# Equação 1: P(Y=1) vs P(Y=0)
log[P(Y=1)/P(Y=0)] = β₁₀ + β₁₁*dist + β₁₂*sem

# Equação 2: P(Y=2) vs P(Y=0)
log[P(Y=2)/P(Y=0)] = β₂₀ + β₂₁*dist + β₂₂*sem
```

- **β₁₁ > 0**: Aumentar 'dist' aumenta probabilidade de Y=1 vs Y=0
- **β₂₁ < 0**: Aumentar 'dist' diminui probabilidade de Y=2 vs Y=0

#### 9.4 Teste Chi² Global

```python
from scipy import stats

def Qui2(modelo_multinomial):
    maximo = modelo_multinomial.llf
    minimo = modelo_multinomial.llnull
    qui2 = -2 * (minimo - maximo)

    # Graus de liberdade: (k-1) * p
    # k = número de categorias, p = número de variáveis explicativas
    gl = 4  # (3-1) * 2 = 4

    pvalue = stats.distributions.chi2.sf(qui2, gl)

    return pd.DataFrame({
        'Qui²': [qui2],
        'p-value': [pvalue]
    })

# Teste
resultado_teste = Qui2(modelo_multi)
print(resultado_teste)
```

#### 9.5 Predições Multinomiais

```python
# Predição para dist=22km, sem=12 semáforos
pred = modelo_multi.predict(pd.DataFrame({
    'const': [1],
    'dist': [22],
    'sem': [12]
}))

print(pred)
# Resultado: array com 3 probabilidades (P(Y=0), P(Y=1), P(Y=2))
# Exemplo: [0.15, 0.35, 0.50] → Classe predita = 2

# Identificar classe predita
classe_predita = pred.idxmax(axis=1)
print(f"Classe predita: {classe_predita[0]}")
```

#### 9.6 Adicionar Probabilidades ao Dataset

```python
# Obter todas as probabilidades
phats = modelo_multi.predict()

# Converter para dataframe
df_probs = pd.DataFrame(phats, columns=['P(Y=0)', 'P(Y=1)', 'P(Y=2)'])

# Concatenar com dataset original
df_resultado = pd.concat([df, df_probs], axis=1)

# Adicionar classificação predita
df_resultado['predicao'] = phats.idxmax(axis=1)

# Adicionar label da predição
df_resultado['predicao_label'] = df_resultado['predicao'].map({
    0: 'não chegou atrasado',
    1: 'chegou atrasado primeira aula',
    2: 'chegou atrasado segunda aula'
})
```

#### 9.7 Eficiência Global (Acurácia Multinomial)

```python
# Tabela de contingência
table = pd.pivot_table(df_resultado,
                      index=['predicao_label'],
                      columns=['atrasado'],
                      aggfunc='size',
                      fill_value=0)

print(table)

# Eficiência global (acurácia)
table_array = table.to_numpy()
acuracia = table_array.diagonal().sum() / table_array.sum()
print(f"Acurácia: {acuracia:.4f}")
```

---

### 10. VISUALIZAÇÕES MULTINOMIAIS

#### 10.1 Probabilidades 2D por Variável

```python
# Probabilidades em função de 'dist'
plt.figure(figsize=(15,10))

# P(Y=0) - não atrasado
sns.regplot(x='dist', y=df[0], data=df, ci=False, order=4,
           line_kws={'color':'indigo', 'linewidth':4},
           scatter_kws={'color':'indigo', 's':80, 'alpha':0.5},
           label='Não atrasado')

# P(Y=1) - atrasado 1ª aula
sns.regplot(x='dist', y=df[1], data=df, ci=None, order=4,
           line_kws={'color':'darkgreen', 'linewidth':4},
           scatter_kws={'color':'darkgreen', 's':80, 'alpha':0.5},
           label='Atrasado 1ª aula')

# P(Y=2) - atrasado 2ª aula
sns.regplot(x='dist', y=df[2], data=df, ci=None, order=4,
           line_kws={'color':'darkorange', 'linewidth':4},
           scatter_kws={'color':'darkorange', 's':80, 'alpha':0.5},
           label='Atrasado 2ª aula')

plt.xlabel('Distância Percorrida', fontsize=18)
plt.ylabel('Probabilidades', fontsize=18)
plt.legend(fontsize=14)
plt.show()
```

#### 10.2 Superfícies 3D (Plotly)

```python
import plotly.graph_objects as go
import plotly.io as pio

pio.renderers.default = 'browser'

# Superfície para P(Y=0)
trace0 = go.Mesh3d(
    x=df['dist'],
    y=df['sem'],
    z=df[0],
    opacity=1,
    intensity=df[0],
    colorscale='Viridis',
    name='P(Y=0)'
)

# Superfície para P(Y=1)
trace1 = go.Mesh3d(
    x=df['dist'],
    y=df['sem'],
    z=df[1],
    opacity=1,
    intensity=df[1],
    colorscale='Greens',
    name='P(Y=1)'
)

# Superfície para P(Y=2)
trace2 = go.Mesh3d(
    x=df['dist'],
    y=df['sem'],
    z=df[2],
    opacity=1,
    intensity=df[2],
    colorscale='Oranges',
    name='P(Y=2)'
)

# Plotar todas juntas
fig = go.Figure(data=[trace0, trace1, trace2])
fig.update_layout(
    scene=dict(
        xaxis_title='Distância',
        yaxis_title='Semáforos',
        zaxis_title='Probabilidades'
    ),
    template='plotly_dark'
)
fig.show()
```

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
import plotly.io as pio

# Modelagem
import statsmodels.api as sm
from statsmodels.discrete.discrete_model import MNLogit
from statsmodels.iolib.summary2 import summary_col

# Avaliação
from sklearn.metrics import (confusion_matrix, accuracy_score,
                             ConfusionMatrixDisplay, recall_score,
                             roc_curve, auc)

# Testes e processos
from scipy import stats
from statstests.process import stepwise

# Interpolação
from scipy.interpolate import UnivariateSpline

# Requisições (carregar imagens)
import requests
from PIL import Image

import warnings
warnings.filterwarnings('ignore')
```

### Pipeline Completo - Regressão Logística Binária

```python
# 1. CARREGAMENTO E PREPARAÇÃO
df = pd.read_csv('dados.csv')
print(df.info())
print(df.describe())

# Verificar distribuição da variável Y
print(df['Y'].value_counts())

# 2. ANÁLISE EXPLORATÓRIA
# Pairplot com cores por classe
cores = {0: 'springgreen', 1: 'darkorchid'}
sns.pairplot(df[['Y', 'X1', 'X2']], hue='Y', palette=cores)
plt.show()

# 3. ESTIMAÇÃO DO MODELO
modelo = sm.Logit.from_formula('Y ~ X1 + X2', df).fit()
print(modelo.summary())

# 4. APLICAR STEPWISE (SE NECESSÁRIO)
modelo_step = stepwise(modelo, pvalue_limit=0.05)

# 5. ADICIONAR PROBABILIDADES PREDITAS
df['phat'] = modelo_step.predict()

# 6. MATRIZ DE CONFUSÃO (TESTE MÚLTIPLOS CUTOFFS)
for cutoff in [0.3, 0.5, 0.7]:
    print(f"\n=== Cutoff = {cutoff} ===")
    metricas = matriz_confusao(df['phat'], df['Y'], cutoff)
    print(metricas)

# 7. CURVA SENSITIVIDADE vs ESPECIFICIDADE
dados_plot = espec_sens(df['Y'], df['phat'])
plt.figure(figsize=(15,10))
plt.plot(dados_plot['cutoffs'], dados_plot['sensitividade'],
         'o-', color='indigo', label='Sensitividade')
plt.plot(dados_plot['cutoffs'], dados_plot['especificidade'],
         'o-', color='darkorange', label='Especificidade')
plt.xlabel('Cutoff', fontsize=20)
plt.ylabel('Métrica', fontsize=20)
plt.legend(fontsize=20)
plt.show()

# 8. CURVA ROC
fpr, tpr, thresholds = roc_curve(df['Y'], df['phat'])
roc_auc = auc(fpr, tpr)
gini = (roc_auc - 0.5) / 0.5

plt.figure(figsize=(15,10))
plt.plot(fpr, tpr, 'o-', color='darkorchid', markersize=11, linewidth=3)
plt.plot([0, 1], [0, 1], '--', color='gray')
plt.title(f'AUC: {roc_auc:.4f} | GINI: {gini:.4f}', fontsize=22)
plt.xlabel('1 - Especificidade', fontsize=20)
plt.ylabel('Sensitividade', fontsize=20)
plt.show()

# 9. TESTES DE QUALIDADE
# Modelo nulo
modelo_nulo = sm.Logit.from_formula('Y ~ 1', df).fit()

# Teste Chi²
chi2 = -2 * (modelo_nulo.llf - modelo_step.llf)
gl = len(modelo_step.params) - 1  # graus de liberdade
pvalue = stats.distributions.chi2.sf(chi2, gl)
print(f"Chi²: {chi2:.4f}, p-value: {pvalue:.6f}")

# Pseudo R²
pseudoR2 = 1 - (modelo_step.llf / modelo_nulo.llf)
print(f"Pseudo R² de McFadden: {pseudoR2:.4f}")

# 10. VISUALIZAÇÃO SIGMOIDE
plt.figure(figsize=(15,10))
sns.scatterplot(x=df['X1'][df['Y']==0], y=df['Y'][df['Y']==0],
               color='springgreen', alpha=0.7, s=250, label='Y=0')
sns.scatterplot(x=df['X1'][df['Y']==1], y=df['Y'][df['Y']==1],
               color='magenta', alpha=0.7, s=250, label='Y=1')
sns.regplot(x='X1', y='Y', data=df, logistic=True, ci=None,
           scatter=False, line_kws={'color': 'indigo', 'linewidth': 7})
plt.axhline(y=0.5, color='grey', linestyle=':')
plt.xlabel('X1', fontsize=20)
plt.ylabel('Probabilidade', fontsize=20)
plt.legend(fontsize=20)
plt.show()
```

### Pipeline Completo - Regressão Logística Multinomial

```python
# 1. PREPARAÇÃO DOS DADOS
df = pd.read_csv('dados.csv')

# Transformar Y categórica em numérica (0, 1, 2, ...)
df['Y_num'] = df['Y'].map({
    'categoria_referencia': 0,
    'categoria_1': 1,
    'categoria_2': 2
})

# 2. ESTIMAÇÃO
X = df[['X1', 'X2']]
X = sm.add_constant(X)
y = df['Y_num']

modelo_multi = MNLogit(endog=y, exog=X).fit()
print(modelo_multi.summary())

# 3. TESTE CHI² GLOBAL
resultado_teste = Qui2(modelo_multi)
print(resultado_teste)

# 4. PREDIÇÕES
phats = modelo_multi.predict()
df_probs = pd.DataFrame(phats, columns=['P(Y=0)', 'P(Y=1)', 'P(Y=2)'])
df = pd.concat([df, df_probs], axis=1)

# 5. CLASSIFICAÇÃO
df['predicao'] = phats.idxmax(axis=1)

# 6. EFICIÊNCIA GLOBAL
table = pd.pivot_table(df, index=['predicao'],
                       columns=['Y'], aggfunc='size', fill_value=0)
acuracia = table.to_numpy().diagonal().sum() / table.to_numpy().sum()
print(f"Acurácia: {acuracia:.4f}")

# 7. VISUALIZAÇÃO DAS PROBABILIDADES
plt.figure(figsize=(15,10))
for i, label in enumerate(['Cat 0', 'Cat 1', 'Cat 2']):
    sns.regplot(x='X1', y=df[i], data=df, ci=False, order=4,
               label=label, scatter_kws={'s':80, 'alpha':0.5})
plt.xlabel('X1', fontsize=18)
plt.ylabel('Probabilidades', fontsize=18)
plt.legend(fontsize=14)
plt.show()
```

---

## 📊 Exemplos Práticos do Curso

### Exemplo 1: Atraso de Estudantes (Binário)

- **Dataset**: atrasado.csv
- **Objetivo**: Predizer se estudante chegará atrasado
- **Variáveis**:
  - Y: atrasado (0=não, 1=sim)
  - X₁: dist (distância em km)
  - X₂: sem (número de semáforos)
- **Resultado**: Semáforos têm efeito muito maior que distância

### Exemplo 2: Acidente do Challenger (Binário + Stepwise)

- **Dataset**: challenger.csv
- **Contexto**: Acidente do ônibus espacial Challenger (1986)
- **Objetivo**: Predizer falha em função de temperatura e pressão
- **Variáveis**:
  - desgaste: Quantidade de stress térmico (≥1 = falha)
  - temperatura: Temperatura de lançamento (ºF)
  - pressão: Pressão de verificação (psi)
- **Resultado**:
  - Temperatura significante (p < 0.05)
  - Pressão não significante (removida pelo Stepwise)
  - P(falha) a 34ºF ≈ 99.6% (temperatura real do acidente)
- **Conclusão**: O acidente era estatisticamente previsível

### Exemplo 3: Fidelidade de Clientes (Binário + Dummies)

- **Dataset**: dados_fidelidade.csv
- **Objetivo**: Predizer fidelidade de clientes à loja
- **Variáveis**:
  - Y: fidelidade (sim/não)
  - Quantitativas: idade, tempo_compra
  - Qualitativas: sexo, atendimento, sortimento, acessibilidade, preço
- **Técnicas**: Dummização, Stepwise, ROC
- **Resultado**: Identificação dos atributos que mais influenciam fidelização

### Exemplo 4: Atraso Multinomial

- **Dataset**: atrasado_multinomial.csv
- **Objetivo**: Predizer nível de atraso
- **Variáveis**:
  - Y: atrasado (0=não atrasou, 1=atrasou 1ª aula, 2=atrasou 2ª aula)
  - X₁: dist (distância)
  - X₂: sem (semáforos)
- **Resultado**: Visualização de 3 superfícies sigmoides 3D

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Diferenças Fundamentais

| **Aspecto**   | **Regressão Linear**    | **Regressão Logística**        |
| ------------- | ----------------------- | ------------------------------ |
| **Y**         | Contínua (reais)        | Categórica (classes)           |
| **Objetivo**  | Predizer valores        | Classificar (probabilidades)   |
| **Método**    | OLS (Mínimos Quadrados) | MLE (Máxima Verossimilhança)   |
| **Função**    | Linear                  | Sigmoide (não linear)          |
| **Output**    | Valor real              | Probabilidade [0,1]            |
| **R²**        | R² clássico             | Pseudo R² (McFadden)           |
| **Avaliação** | RMSE, R², R² ajustado   | Acurácia, AUC, matriz confusão |

### 🎯 Fórmulas Essenciais

```
1. Função Sigmoide:
   P(Y=1) = 1 / (1 + e^(-z))
   onde z = β₀ + β₁X₁ + β₂X₂ + ... + βₖXₖ

2. Logito (Log-Odds):
   z = ln[P(Y=1) / P(Y=0)]

3. Odds Ratio:
   OR = e^β
   - OR > 1: Aumenta chances
   - OR < 1: Diminui chances

4. Sensitividade:
   Sens = TP / (TP + FN)

5. Especificidade:
   Espec = TN / (TN + FP)

6. Acurácia:
   Acc = (TP + TN) / Total

7. AUC (Area Under ROC Curve):
   AUC ∈ [0, 1]
   AUC > 0.8: Excelente

8. GINI:
   GINI = 2×AUC - 1

9. Pseudo R² (McFadden):
   Pseudo R² = 1 - (LL_modelo / LL_nulo)

10. Teste Chi² (LLR):
    Chi² = -2 × (LL_nulo - LL_modelo)
```

### 📐 Interpretações Importantes

**Coeficiente β:**

- β = 0.5 → OR = e^0.5 = 1.65 → Aumenta chances em 65%
- β = -0.5 → OR = e^(-0.5) = 0.61 → Reduz chances em 39%

**AUC:**

- 0.5: Aleatório
- 0.7-0.8: Aceitável
- 0.8-0.9: Excelente
- 0.9-1.0: Excepcional

**Pseudo R²:**

- 0.2-0.4: Excelente (!)
- > 0.4: Excepcional

---

## ⚠️ Erros Comuns a Evitar

1. **Usar regressão linear para Y binária**: pode gerar P<0 ou P>1 (o script traz explicitamente esse gráfico como "errado, apenas para fins didáticos")
2. **Interpretar β como efeito direto na probabilidade**: β afeta o logito, não P diretamente
3. **Esquecer de adicionar a constante em MNLogit**: a função exige que a constante seja definida manualmente com `sm.add_constant(X)`

---

## 📚 Materiais de Apoio

### Datasets Utilizados

- **atrasado.csv**: Atraso binário (distância + semáforos)
- **challenger.csv**: Acidente Challenger (temperatura + pressão)
- **dados_fidelidade.csv**: Fidelidade de clientes (variáveis quali + quanti)
- **atrasado_multinomial.csv**: Atraso em 3 níveis (multinomial)

### Arquivos Excel

- **AtrasadoMáximaVerossimilhança.xls**: Cálculo manual de MLE binário
- **AtrasadoMultinomialMáximaVerossimilhança.xls**: Cálculo manual de MLE multinomial
- **Sigmoide.xlsx**: Visualização da curva sigmoide
- **Cálculo do número de Euler_Neper.xlsx**: Constante e

### Pacote `statstests`

- **Autores**: Luiz Paulo Fávero e Helder Prado Santos
- **URL**: https://stats-tests.github.io/statstests/
- **Função principal**: `stepwise()` para seleção de variáveis

---

## 🎯 Pontos Importantes para Reter

### Quando Usar Cada Modelo

| **Situação**                     | **Modelo**                              |
| -------------------------------- | --------------------------------------- |
| Y com 2 classes                  | Regressão Logística Binária             |
| Y com 3+ classes (não ordenadas) | Regressão Logística Multinomial         |
| Y com 3+ classes (ordenadas)     | Regressão Logística Ordinal (não visto) |

### Checklist de Qualidade do Modelo

✅ **Coeficientes significantes** (p < 0.05)  
✅ **Teste Chi² significante** (p < 0.05) → Modelo melhor que o nulo  
✅ **Pseudo R² de McFadden calculado**  
✅ **AUC calculada e próxima de 1** (quanto maior, melhor a discriminação)  
✅ **Sensitividade e Especificidade calculadas para o(s) cutoff(s) escolhido(s)**

### Interpretação de Resultados - Passo a Passo

**1. Análise dos Coeficientes:**

```
β₁ = 2.36, p < 0.001
Interpretação: β₁ é significante. OR = e^2.36 = 10.59
Cada unidade adicional de X₁ multiplica as chances de Y=1 por 10.59
```

**2. Qualidade Global:**

```
Chi² = 45.32, p < 0.001 → Modelo é significativamente melhor que o nulo
Pseudo R² = 0.38
AUC = 0.87
```

**3. Escolha do Cutoff:**

```
Cutoff 0.3: Sens=0.95, Espec=0.60 → Prioriza não perder casos positivos
Cutoff 0.5: Sens=0.80, Espec=0.85 → Balanceado
Cutoff 0.7: Sens=0.60, Espec=0.95 → Prioriza evitar falsos alarmes
```

**4. Predição:**

```
P(Y=1 | X₁=10, X₂=5) = 0.82
Com cutoff=0.5 → Classificar como 1
Com cutoff=0.9 → Classificar como 0
```

---

## 📖 Sugestão de Leitura (Material Complementar da aula)

- Christensen, R. 1997. *Log-linear models and logistic regression.* 2. ed. New York: Springer-Verlag.
- Fávero, L.P.; Belfiore, P. 2019. *Data science for business and decision making.* Cambridge: Academic Press.
- Fávero, L.P.; Belfiore, P. 2024. *Manual de análise de dados: estatística e machine learning com Excel®, SPSS®, Stata®, R® e Python®.* Rio de Janeiro: GEN.
- Garson, G.D. 2012. *Logistic regression: binary & multinomial.* Asheboro: Statistical Associates Publishing.
- Gujarati, D.N. 2011. *Econometria básica.* 5. ed. Porto Alegre: Bookman.
- Hilbe, J.M. 2009. *Logistic regression models.* London: Chapman & Hall / CRC Press.
- Hosmer, D.W.; Lemeshow, S.; Sturdivant, R.X. 2013. *Applied logistic regression.* 3. ed. New York: John Wiley & Sons.
- Hosmer, D.W.; Taber, S.; Lemeshow, S. 1991. *The importance of assessing the fit of logistic regression models: a case study.* American Journal of Public Health, v. 81, p. 1630-1635.
- Kleinbaum, D.G.; Klein, M. 2010. *Logistic regression: a self-learning text.* 3. ed. New York: Springer.
- Fávero, L.P. 2019. *Machine Learning e modelos supervisionados: o uso correto do GLM na tomada de decisão.* IT Forum.

---

## ✅ Checklist de Estudo

### Conceitos Teóricos

- [ ] Entender diferença entre regressão linear e logística
- [ ] Compreender função sigmoide e logito
- [ ] Interpretar coeficientes como log-odds
- [ ] Calcular e interpretar Odds Ratio
- [ ] Conhecer estimação por máxima verossimilhança
- [ ] Diferenciar modelo binário e multinomial

### Matriz de Confusão

- [ ] Construir matriz de confusão manualmente
- [ ] Calcular sensitividade, especificidade, acurácia
- [ ] Entender trade-off entre sensitividade e especificidade
- [ ] Escolher cutoff apropriado ao contexto
- [ ] Reconhecer problema de classes desbalanceadas

### Curva ROC e AUC

- [ ] Plotar curva ROC
- [ ] Calcular e interpretar AUC
- [ ] Calcular coeficiente de GINI
- [ ] Comparar modelos usando AUC
- [ ] Identificar visualmente bom modelo na ROC

### Testes Estatísticos

- [ ] Realizar teste de razão de verossimilhança (Chi²)
- [ ] Calcular Pseudo R² de McFadden
- [ ] Interpretar log-likelihood
- [ ] Comparar modelos com AIC e BIC
- [ ] Testar significância individual de coeficientes

### Implementação Python

- [ ] Estimar modelo binário com sm.Logit
- [ ] Aplicar procedimento Stepwise
- [ ] Criar matriz de confusão customizada
- [ ] Plotar curva ROC com AUC
- [ ] Plotar sensitividade vs especificidade
- [ ] Estimar modelo multinomial com MNLogit
- [ ] Fazer predições e interpretar probabilidades

### Visualizações

- [ ] Plotar curva sigmoide teórica
- [ ] Criar scatter plot com ajuste logístico
- [ ] Pairplot colorido por classes
- [ ] Gráficos 3D de superfícies de probabilidade (multinomial)
- [ ] Visualizar matriz de confusão

### Casos Práticos

- [ ] Reproduzir Exemplo 1 (atraso binário)
- [ ] Reproduzir Exemplo 2 (Challenger + Stepwise)
- [ ] Reproduzir Exemplo 3 (fidelidade + dummies)
- [ ] Reproduzir Exemplo 4 (multinomial)
- [ ] Aplicar em dataset próprio

### Projeto Final

- [ ] Carregar dataset de classificação
- [ ] Análise exploratória (distribuição de classes)
- [ ] Estimar modelo logístico
- [ ] Avaliar qualidade (AUC, Pseudo R², Chi²)
- [ ] Testar múltiplos cutoffs
- [ ] Escolher cutoff justificado
- [ ] Fazer predições
- [ ] Apresentar resultados com visualizações

---

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_  
_Módulo 19 - Supervised Machine Learning - Modelos Logísticos Binários e Multinomiais_
