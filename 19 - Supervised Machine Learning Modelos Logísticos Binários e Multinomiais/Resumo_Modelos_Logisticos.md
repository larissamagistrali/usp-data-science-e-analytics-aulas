# Resumo - Supervised Machine Learning: Modelos Logísticos

**MBA em Data Science & Analytics - USP/ESALQ**

---

## Objetivo do Módulo

Regressão Logística Binária e Multinomial para classificação: estimação por máxima verossimilhança, interpretação de coeficientes e odds ratios, avaliação via matriz de confusão, curva ROC, AUC, e aplicações em problemas reais.

---

## Conteúdo da Aula

### 1. Função Sigmoide e Logito

**Sigmoide — transforma valores lineares em probabilidades [0,1]:**
```
P(Y=1) = 1 / (1 + e^(-z))
onde: z = β₀ + β₁X₁ + β₂X₂ + ... + βₖXₖ (logito)
```

**Interpretação**: z=0 → P=0.5; z→+∞ → P→1; z→-∞ → P→0

---

### 2. Regressão Logística Binária

**Estimação por Máxima Verossimilhança (MLE):**
```python
import statsmodels.api as sm
modelo = sm.Logit.from_formula('Y ~ X1 + X2', df).fit()
```

**Coeficientes e Odds Ratio:**
- β > 0: Aumenta P(Y=1)
- β < 0: Diminui P(Y=1)
- **Odds Ratio (OR) = e^β**: Multiplicador de chance
  - OR=1.21 → Aumenta chances em 21%
  - OR=0.61 → Reduz chances em 39%

**Predição:**
```python
df['phat'] = modelo.predict(df[['X1', 'X2']])
```

---

### 3. Matriz de Confusão e Métricas

**Matriz de Confusão:**
```
                Real
           |  0   |  1   |
Predito  0 | TN   | FN   |
         1 | FP   | TP   |
```

**Métricas:**
- **Sensitividade** = TP/(TP+FN): Detecta casos positivos reais
- **Especificidade** = TN/(TN+FP): Evita falsos alarmes
- **Acurácia** = (TP+TN)/Total: Taxa geral de acertos (⚠️ pode enganar em classes desbalanceadas)

**Cutoff (ponto de corte)** — padrão 0.5:
- Baixo (0.3): ↑ Sensitividade, ↓ Especificidade
- Alto (0.7): ↓ Sensitividade, ↑ Especificidade

```python
from sklearn.metrics import confusion_matrix, accuracy_score, recall_score

cutoff = 0.5
y_pred = (df['phat'] >= cutoff).astype(int)
cm = confusion_matrix(df['Y'], y_pred)
sens = recall_score(df['Y'], y_pred, pos_label=1)
spec = recall_score(df['Y'], y_pred, pos_label=0)
```

---

### 4. Curva ROC e AUC

**ROC (Receiver Operating Characteristic):**
- Eixo X: 1 - Especificidade (Taxa de Falsos Positivos)
- Eixo Y: Sensitividade (Taxa de Verdadeiros Positivos)

**AUC (Area Under Curve):** [0, 1]
- 0.5 = modelo aleatório (linha diagonal)
- > 0.8 = excelente discriminação

**GINI = 2×AUC - 1** (normalização entre -1 e 1)

```python
from sklearn.metrics import roc_curve, auc

fpr, tpr, _ = roc_curve(df['Y'], df['phat'])
roc_auc = auc(fpr, tpr)
gini = (roc_auc - 0.5) / 0.5

plt.figure(figsize=(12,8))
plt.plot(fpr, tpr, marker='o', color='darkorchid', linewidth=3, label=f'AUC={roc_auc:.4f}')
plt.plot([0, 1], [0, 1], '--', color='gray', label='Aleatório')
plt.xlabel('1 - Especificidade'); plt.ylabel('Sensitividade')
plt.legend(); plt.show()
```

---

### 5. Testes de Qualidade

**Log-Likelihood (LL):** Logaritmo da verossimilhança (quanto maior/menos negativo, melhor)

**Teste de Razão de Verossimilhança (Chi²):**
- Compara modelo com o modelo nulo (apenas intercepto)
- Chi² = -2 × (LL_nulo - LL_modelo)
- H₀ rejeitado se p < 0.05 → modelo significante

**Pseudo R² McFadden = 1 - (LL_modelo / LL_nulo)**
- 0.2-0.4: Excelente | >0.4: Excepcional

```python
modelo_nulo = sm.Logit.from_formula('Y ~ 1', df).fit()
chi2 = -2 * (modelo_nulo.llf - modelo.llf)
pvalue = stats.chi2.sf(chi2, df=len(modelo.params)-1)
pseudoR2 = 1 - (modelo.llf / modelo_nulo.llf)
```

---

### 6. Visualizações

**Curva Sigmoide (CORRETO):**
```python
sns.regplot(x='X', y='Y', data=df, logistic=True, ci=None)
plt.axhline(y=0.5, color='grey', linestyle=':')
plt.show()
```

**Pairplot com classes:**
```python
cores = {0: 'springgreen', 1: 'darkorchid'}
sns.pairplot(df[['Y', 'X1', 'X2']], hue='Y', palette=cores)
```

---

### 7. Procedimento Stepwise

Remove variáveis não significantes (p ≥ 0.05):
```python
from statstests.process import stepwise
modelo_step = stepwise(modelo, pvalue_limit=0.05)
```

---

### 8. Variáveis Categóricas

**Dummização:**
```python
df['Y'] = (df['Y'] == 'sim').astype(int)
df = pd.get_dummies(df, columns=['sexo', 'atendimento'], drop_first=True)
```

---

### 9. Regressão Logística Multinomial

**Quando Y tem 3+ categorias** (ex: baixo/médio/alto)

**Estimação:**
```python
from statsmodels.discrete.discrete_model import MNLogit

# Y deve ser numérica (0=referência, 1, 2, ...)
X = sm.add_constant(df[['X1', 'X2']])
modelo_multi = MNLogit(endog=df['Y'], exog=X).fit()
```

**Modelo estima k-1 equações** (k=número de categorias). Cada compara categoria com a referência:
```
log[P(Y=1)/P(Y=0)] = β₁₀ + β₁₁*X₁ + β₁₂*X₂
log[P(Y=2)/P(Y=0)] = β₂₀ + β₂₁*X₁ + β₂₂*X₂
```

**Predição:**
```python
phats = modelo_multi.predict()  # Retorna matriz de probabilidades
y_pred = phats.idxmax(axis=1)   # Classe com maior probabilidade
```

**Acurácia:**
```python
table = pd.crosstab(df['Y'], y_pred)
acuracia = table.diagonal().sum() / table.sum().sum()
```

---

## Exemplos Práticos

- **atrasado.csv**: Atraso binário (dist + semáforos)
- **challenger.csv**: Acidente Challenger (temperatura + pressão) + Stepwise
- **dados_fidelidade.csv**: Fidelidade de clientes + dummização
- **atrasado_multinomial.csv**: Atraso multinomial (3 níveis)

---

## Fórmulas-Chave

| Conceito | Fórmula |
|----------|---------|
| Sigmoide | P(Y=1) = 1/(1+e^(-z)) |
| Odds Ratio | OR = e^β |
| Sensitividade | TP/(TP+FN) |
| Especificidade | TN/(TN+FP) |
| Pseudo R² McFadden | 1-(LL_modelo/LL_nulo) |
| Chi² | -2×(LL_nulo-LL_modelo) |
| GINI | 2×AUC-1 |

---

## Interpretação Rápida

- **β > 0**: Aumenta P(Y=1)
- **β < 0**: Diminui P(Y=1)
- **AUC > 0.8**: Excelente discriminação
- **Pseudo R² 0.2-0.4**: Excelente para logística

---

## Erros Comuns

1. Usar regressão linear para Y binária (pode gerar P<0 ou P>1)
2. Interpretar β como efeito direto em P(Y=1) (afeta logito, não probabilidade)
3. Esquecer `sm.add_constant(X)` em MNLogit

---

**Dados**: atrasado.csv, challenger.csv, dados_fidelidade.csv, atrasado_multinomial.csv  
**Referência**: Fávero & Belfiore (2024); Pacote: `statstests`  

**MBA Data Science & Analytics - USP/ESALQ | Módulo 19**
