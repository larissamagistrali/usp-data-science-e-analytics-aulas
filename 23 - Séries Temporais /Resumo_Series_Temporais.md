# 📈 Resumo do Curso: Séries Temporais

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Dominar os fundamentos e as principais técnicas de análise e previsão de **Séries Temporais**, incluindo leitura e plotagem de dados temporais, decomposição clássica (aditiva e multiplicativa), métodos simples de previsão (Naive, Média, Drift, Naive Sazonal), suavização exponencial (SES, Holt, Holt-Winters/ETS), estacionariedade e autocorrelação (ACF/PACF), e a família de modelos **ARIMA/SARIMA** (Box-Jenkins), com diagnóstico de resíduos (Ljung-Box, normalidade, efeitos ARCH) e comparação de modelos por métricas de erro (MAE, RMSE, MAPE, Theil U, AIC, BIC).

---

## 📚 Conteúdo Principal

### 1. CONCEITOS FUNDAMENTAIS DE SÉRIES TEMPORAIS

#### 1.1 Definição

- **Série temporal**: conjunto de observações ordenadas no tempo, onde a ordem importa (existe dependência temporal).
- Se n ≥ 50 observações, a série é chamada de **sucessão cronológica**.
- Notação: Xₜ, t = 1, ..., n → X₁, X₂, ..., Xₙ
- **Exemplos citados nos slides**: Índice IBOVESPA diário, retorno de ações da Petrobras mensal, índices mensais de inflação no Brasil, taxa de câmbio Real/US$ diária, passageiros no transporte aéreo, manchas solares, focos de queimadas (INPE), receita trimestral da AMBEV, casos de COVID-19.

#### 1.2 Univariadas x Multivariadas

- **Univariadas**: apenas uma variável conectada ao tempo.
- **Multivariadas**: duas ou mais variáveis conectadas ao tempo.

#### 1.3 Classificação das Séries Temporais

- **Discretas**: observações feitas em intervalos de tempo fixos.
- **Contínuas**: observações obtidas continuamente ao longo de um intervalo.
- **Determinística**: pode ser descrita por uma função matemática exata.
- **Estocástica**: valores futuros só podem ser estabelecidos em termos probabilísticos (contém termo aleatório).

#### 1.4 Objetivos da Análise de Séries Temporais

- Investigar o mecanismo que gera a série;
- Fazer previsões de valores futuros;
- Descrever o comportamento da série;
- Procurar periodicidades relevantes nos dados.

#### 1.5 Histórico

- **Davenant (Stigler, 1699)**: primeiro esquema empírico de demanda;
- **Rodulfo Enini (1907)**: primeiros estudos;
- **1930**: fundação da Econometric Society;
- **Antes de 1955**: Modelos Clássicos de Decomposição;
- **1957-1962**: Modelos de Alisamento Exponencial (Holt-Winters e Brown);
- **Décadas de 60/70**: Modelos de Box-Jenkins (ARIMA), por **George Box (1919-2013)** e **Gwilym Jenkins (1932-1982)** — "Todos os modelos estão errados, mas alguns são úteis.";
- **Década de 80**: Modelos estruturais clássicos e bayesianos (Filtro de Kalman);
- **Décadas de 80/90**: Cointegração e econometria de séries temporais.

---

### 2. COMPONENTES DE UMA SÉRIE TEMPORAL

#### 2.1 Os Quatro Componentes

- **Tendência (T)**: movimento oculto nos dados, seguindo direção crescente, decrescente ou estacionária.
- **Sazonalidade (S)**: flutuações regulares dentro de um período completo de tempo (dia, semana, mês, ano); representa um padrão que se repete (picos, depressões).
- **Ciclo (C)**: flutuações de longo prazo, similares aos fatores sazonais, mas com padrão que se repete sem período fixo — difíceis de identificar sem uma série longa.
- **Erro/Aleatório (E)**: componente residual/aleatória.

#### 2.2 Modelos de Decomposição

**Aditivo** (variação sazonal constante):

```
Y = T + C + S + E
```

- Y: valor da série no instante t
- T: componente de tendência
- C: componente cíclica
- S: componente sazonal
- E: componente aleatória
- Mais adequado quando as flutuações sazonais permanecem aproximadamente do mesmo tamanho ao longo do tempo.

**Multiplicativo** (variação sazonal cresce/diminui com o nível da série):

```
Y = T * C * S * E
```

- Normalmente aplicado quando o tamanho dos efeitos sazonais aumenta junto com o nível da série.

#### 2.3 Decomposição em Python (statsmodels)

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from statsmodels.tsa.seasonal import seasonal_decompose

# Criar a série temporal
data = pd.date_range(start='2019-01-01', end='2022-12-31', freq='QE')
values = [10, 14, 8, 25, 16, 22, 14, 35, 15, 27, 18, 40, 28, 40, 25, 65]
s = pd.Series(values[:len(data)], index=data)

# Decomposição pelo modelo ADITIVO
decompa = seasonal_decompose(s, model='additive', period=4)
print(decompa.trend)
print(decompa.seasonal)
print(decompa.resid)

# Decomposição pelo modelo MULTIPLICATIVO
decompm = seasonal_decompose(s, model='multiplicative', period=4)

# Reconstrução da série original
# Aditivo: Original = Tendência + Sazonal + Resíduo
reconstruida_add = decompa.trend + decompa.seasonal + decompa.resid
# Multiplicativo: Original = Tendência * Sazonal * Resíduo
reconstruida_mul = decompm.trend * decompm.seasonal * decompm.resid

# Plot dos 4 painéis (Tendência, Sazonal, Resíduo, Original vs Reconstruída)
plt.figure(figsize=(10, 8))
plt.subplot(4, 1, 1); plt.plot(decompa.trend); plt.title('Tendência')
plt.subplot(4, 1, 2); plt.plot(decompa.seasonal); plt.title('Componente Sazonal')
plt.subplot(4, 1, 3); plt.plot(decompa.resid); plt.title('Resíduos')
plt.subplot(4, 1, 4)
plt.plot(s, label='Original')
plt.plot(reconstruida_add, label='Reconstruída')
plt.title('Original vs. Reconstruída'); plt.legend()
plt.tight_layout(); plt.show()
```

Aplicação real ao PIB mensal do Brasil:

```python
pib = pd.read_excel("pib_mensal.xlsx", parse_dates=True, index_col=0)
pib_ts = pd.Series(pib['pib'].values, index=pib.index)

decomp_aditivo = seasonal_decompose(pib_ts, model='additive', period=12)
decomp_aditivo.plot()
plt.suptitle('Decomposição Aditiva do PIB')
plt.show()

decomp_multiplicativo = seasonal_decompose(pib_ts, model='multiplicative', period=12)
decomp_multiplicativo.plot()
plt.suptitle('Decomposição Multiplicativa do PIB')
plt.show()
```

#### 2.4 Médias Móveis e Suavização

```python
# Média móvel de 14 dias (suavização de série diária de COVID-19)
covid['media_movel'] = covid['por_dia'].rolling(window=14).mean()

# Média móvel centralizada
covid['covid_suave'] = covid['por_dia'].rolling(window=14, center=True).mean()

# Box-plot mensal para identificar outliers
import seaborn as sns
sns.boxplot(x=covid['Data'].dt.to_period('M'), y=covid['por_dia'])

# Gráfico sazonal mensal (month plot)
import statsmodels.api as sm
sm.graphics.tsa.month_plot(queimad)
```

---

### 3. LEITURA, TRANSFORMAÇÃO E VISUALIZAÇÃO DE SÉRIES TEMPORAIS EM PYTHON

#### 3.1 Transformar uma coluna em Série Temporal (pandas)

```python
import pandas as pd
import matplotlib.pyplot as plt

# Lendo a base de dados
basepetr4 = pd.read_excel("basepetr4.xlsx")
petr4 = basepetr4['fechamento']

# Definindo petr4 como uma série temporal (índice = datas)
petr4_ts = pd.Series(petr4.values, index=pd.to_datetime(basepetr4['Date']))

# Plotando
plt.figure(figsize=(10, 6))
plt.plot(petr4_ts)
plt.title('Cotação de Fechamento PETR4')
plt.xlabel('Tempo')
plt.ylabel('Fechamento (R$)')
plt.show()
```

#### 3.2 Construção de índice temporal com `date_range` (quando não há coluna de datas)

```python
# Série trimestral (AMBEV) - ATENÇÃO: usar freq='QE' em versões recentes do pandas
receita = pd.Series(ambev.iloc[:, 1].values,
                    index=pd.date_range(start='2000-01-01', periods=len(ambev), freq='QE'))

# Série mensal (manchas solares, desde 1749)
sol = pd.Series(manchas['manchas'].values,
                index=pd.date_range(start='1749-01-01', periods=len(manchas), freq='ME'))

# Selecionar uma janela de tempo
sol1 = sol['1749-01-01':'1990-12-31']
```

#### 3.3 Baixando dados direto de fontes externas

```python
# Yahoo Finance
import yfinance as yf
data = yf.download("PETR4.SA", start="2022-01-01", end="2026-04-10")

# Banco Central do Brasil (SGS)
from bcb import sgs
ipca = sgs.get({'ipca': 433}, start='2000-01-01', end='2024-08-31')
varejo2 = sgs.get({'volume_vendas': 1475}, start='2000-01-01', end='2022-12-31')

# IPEA
import ipeadatapy as ip
ip.list_series()
ip.describe('ELETRO12_CEESE12')
cons_sudeste = ip.timeseries('ELETRO12_CEESE12')
```

#### 3.4 Séries Aleatórias e Passeio Aleatório (Random Walk)

```python
import numpy as np

# Ruído branco (numeros aleatórios com distribuição normal)
aleat = pd.Series(np.random.normal(size=500))

# Passeio aleatório (random walk) = soma cumulativa de ruído branco
passeio = aleat.cumsum()

plt.plot(passeio)
plt.title("Passeio Aleatório")
plt.show()
```

Comparação de uma cotação real (PETR4) com um passeio aleatório simulado — usado nos slides para mostrar visualmente por que testar estacionariedade é importante:

```python
n_pontos = petr4.shape[0]
petropasseio = pd.Series(0.0, index=np.arange(n_pontos))
petropasseio.iloc[0] = petr4.iloc[0]
for i in range(1, n_pontos):
    petropasseio.iloc[i] = petropasseio.iloc[i - 1] + np.random.normal()

plt.plot(petr4, label='Cotação Original', color='blue')
plt.plot(petropasseio, label='Random Walk', linestyle='dashed', color='red')
plt.legend(loc='best')
plt.show()
```

---

### 4. MÉTODOS SIMPLES DE PREVISÃO

#### 4.1 Visão Geral (SIMPLES x CLÁSSICA x OUTRAS)

| Simples | Clássica | Outras |
|---|---|---|
| Naive | Regressão | Suavização Exponencial |
| Mean (Média) | Decomposição | ARIMA |
| Drift | | Redes Neurais |
| Naive Sazonal | | |

- **Naive**: projeta o último valor observado para o futuro.
- **Naive Sazonal**: considera o último valor do mesmo período sazonal (para séries com sazonalidade).
- **Média (Mean)**: usa a média histórica como previsão para o futuro.
- **Drift**: acompanha a tendência da série — equivale a traçar uma reta entre o primeiro e o último ponto.

#### 4.2 Implementação em Python — Naive

```python
import numpy as np
from scipy import stats

def naive_forecast(time_series, h=3, confidence_level=0.95):
    last_observation = time_series[-1]
    forecasts = np.array([last_observation] * h)

    # Erros de previsão (diferenças consecutivas)
    errors = time_series[1:] - time_series[:-1]
    std_error = np.sqrt((errors * errors).mean())

    z_value = stats.norm.ppf((1 + confidence_level) / 2)

    confidence_intervals = [
        (forecast - z_value * std_error * np.sqrt(step + 1),
         forecast + z_value * std_error * np.sqrt(step + 1))
        for step, forecast in enumerate(forecasts)
    ]

    forecast_df = pd.DataFrame({
        "Previsao": forecasts,
        "IC Inferior": [ci[0] for ci in confidence_intervals],
        "IC Superior": [ci[1] for ci in confidence_intervals]
    }, index=[f'T+{i+1}' for i in range(h)])

    return forecast_df, confidence_intervals

serie = np.array([3, 5, 9, 20, 12, 17, 22, 23, 51, 41, 56, 75, 60, 75, 88])
naiveforecast_df, ci = naive_forecast(serie, h=3)
```

#### 4.3 Implementação em Python — Média (Mean)

```python
def forecast_with_mean(time_series, steps_ahead, confidence=0.95):
    mean_series = np.mean(time_series)
    errors = time_series - mean_series
    std_errors = np.std(errors, ddof=1)
    forecast = [mean_series] * steps_ahead

    n = len(time_series)
    alpha = 1 - confidence
    t_value = stats.t.ppf(1 - alpha / 2, df=n - 1)
    margin_of_error = t_value * std_errors * np.sqrt(1 + 1 / len(time_series))

    lower_bound = [mean_series - margin_of_error] * steps_ahead
    upper_bound = [mean_series + margin_of_error] * steps_ahead
    return forecast, lower_bound, upper_bound
```

#### 4.4 Implementação em Python — Drift

```python
def drift_forecast(time_series, steps_ahead, confidence=0.95):
    n = len(time_series)
    drift = (time_series[-1] - time_series[0]) / (n - 1)
    forecast = [time_series[-1] + (i + 1) * drift for i in range(steps_ahead)]

    predicted_values = [time_series[i - 1] + drift for i in range(1, n)]
    errors = time_series[1:] - np.array(predicted_values)
    std_errors = np.sqrt((errors ** 2).mean())

    calc = len(errors)
    z_value = stats.norm.ppf((1 + confidence) / 2)

    lower_bound = [forecast[i] - z_value * std_errors * np.sqrt((i + 1) * (1 + (i + 1) / (calc - 1)))
                   for i in range(steps_ahead)]
    upper_bound = [forecast[i] + z_value * std_errors * np.sqrt((i + 1) * (1 + (i + 1) / (calc - 1)))
                   for i in range(steps_ahead)]
    return forecast, lower_bound, upper_bound
```

#### 4.5 Implementação em Python — Naive Sazonal

```python
def seasonal_naive_forecast(time_series, season_length, steps_ahead, confidence=0.95):
    forecast = [time_series.iloc[-season_length + i] for i in range(steps_ahead)]
    predicted_values = [time_series.iloc[i - season_length]
                        for i in range(season_length, len(time_series))]
    residuals = time_series.iloc[season_length:] - np.array(predicted_values)
    std_residuals = np.sqrt((residuals ** 2).mean())

    z_value = stats.norm.ppf((1 + confidence) / 2)
    margin_of_error = z_value * std_residuals

    lower_bound = [forecast[i] - margin_of_error * np.sqrt((i // season_length) + 1)
                   for i in range(steps_ahead)]
    upper_bound = [forecast[i] + margin_of_error * np.sqrt((i // season_length) + 1)
                   for i in range(steps_ahead)]
    return forecast, lower_bound, upper_bound

# Aplicado à série de passageiros de transporte aéreo (airpassengers.xlsx)
forecast, lower_bound, upper_bound = seasonal_naive_forecast(airpas, season_length=12, steps_ahead=12)
```

---

### 5. ESTATÍSTICAS DE ERRO DAS PREVISÕES

- **ME (Mean Error)**: média da diferença entre realizado e previsto.

```
erro_t = X̂_t - X_t
ME = (Σ erro_t) / h
```

- **MAE (Mean Absolute Error)**: média da diferença absoluta.

```
MAE = (Σ |erro_t|) / h
```

- **RMSE (Root Mean Square Error)**: desvio-padrão total da diferença entre previsto e realizado.

```
RMSE = √[(Σ erro_t²) / h]
```

- **MPE (Mean Percentage Error)**: diferença percentual do erro.

```
MPE = [(Σ (erro_t / X_t)) / h] × 100%
```

- **MAPE (Mean Absolute Percentage Error)**: diferença absoluta percentual do erro (muito usada em finanças).

```
MAPE = [(Σ |erro_t / X_t|) / h] × 100%
```

- **TIC / Theil's U (Theil Inequality Coefficient)**: grau de ajuste da previsão; quanto menor, melhor (zero é o ideal). U < 1 indica previsão melhor que um passeio aleatório.

```
Theil's U = √[Σ((X̂ₜ₊₁-Xₜ₊₁)/Xₜ)²] / √[Σ((Xₜ₊₁-Xₜ)/Xₜ)²]
```

- **ACF1**: autocorrelação de primeira ordem dos resíduos.

```
ACF_k = cov(R_it, R_i,t-k) / var(R_it)
```

#### Implementação em Python

```python
from sklearn.metrics import mean_absolute_error, mean_squared_error
from sklearn.metrics import root_mean_squared_error, mean_absolute_percentage_error
import numpy as np

reais = np.array([1, 2, 3, 5, 6, 8, 9])
previstos = np.array([1, 3, 3, 4, 6, 7, 9])

erro = reais - previstos
merror = np.mean(erro)                                   # ME (viés/bias)
mae = mean_absolute_error(reais, previstos)               # MAE
mse = mean_squared_error(reais, previstos)                 # MSE
rmse = root_mean_squared_error(reais, previstos)           # RMSE
mpe = np.mean((reais - previstos) / reais) * 100           # MPE
mape = mean_absolute_percentage_error(reais, previstos) * 100  # MAPE

print(f"ME: {merror:.4f} | MAE: {mae:.4f} | RMSE: {rmse:.4f}")
print(f"MPE: {mpe:.4f}% | MAPE: {mape:.4f}%")

# Coeficiente U de Theil (implementação manual)
def computeTheilU2(y_true, y_pred):
    N = len(y_true)
    num = np.sqrt(np.mean(((y_pred[1:] - y_true[1:]) / y_true[:-1]) ** 2))
    den = np.sqrt(np.mean(((y_true[1:] - y_true[:-1]) / y_true[:-1]) ** 2))
    return num / den

theil = computeTheilU2(reais, previstos)
```

---

### 6. SUAVIZAÇÃO EXPONENCIAL (EXPONENTIAL SMOOTHING)

#### 6.1 Quando Usar Cada Modelo

- **SES (Suavização Exponencial Simples)**: série sem tendência e sem sazonalidade.
- **SEH (Suavização Exponencial de Holt)**: série com tendência, mas sem sazonalidade.
- **Holt-Winters (HW)**: série com tendência **e** sazonalidade.
- Dá pesos maiores às observações mais recentes, captando melhor as mudanças de comportamento. A previsão é igual ao último valor exponencial suavizado.

#### 6.2 Fórmulas

**SES – erro de previsão para h passos:**

```
SEₕ = SE × √[1 + (h-1).α²]
```

**Holt-Winters Aditivo:**

```
X̂ₜ = L̂ₜ₋₁ + T̂ₜ₋₁ + Ŝₜ₋c
L̂ₜ = α(Xₜ - Ŝₜ₋c) + (1-α)(L̂ₜ₋₁ + T̂ₜ₋₁)
T̂ₜ = β(L̂ₜ - L̂ₜ₋₁) + (1-β)T̂ₜ₋₁
Ŝₜ = γ(Xₜ - L̂ₜ) + (1-γ)Ŝₜ₋c
Previsão: X̂ₜ₊ₕ = L̂ₜ + h.T̂ₜ + Ŝₜ₊ₕ₋c.ĥ'
onde: 0 ≤ α,β,γ ≤ 1
```

**Holt-Winters Multiplicativo:**

```
X̂ₜ = (L̂ₜ₋₁ + T̂ₜ₋₁).Ŝₜ₋c
L̂ₜ = α(Xₜ/Ŝₜ₋c) + (1-α)(L̂ₜ₋₁ + T̂ₜ₋₁)
T̂ₜ = β(L̂ₜ - L̂ₜ₋₁) + (1-β)T̂ₜ₋₁
Ŝₜ = γ(Xₜ/L̂ₜ) + (1-γ)Ŝₜ₋c
Previsão: X̂ₜ₊ₕ = (L̂ₜ + h.T̂ₜ).Ŝₜ₊ₕ₋c.ĥ'
```

#### 6.3 Notação ETS (Error, Trend, Seasonal)

| Letra | Tendência/Sazonalidade | Erro |
|---|---|---|
| N | Nenhum | — |
| A | Aditivo | Aditivo |
| M | Multiplicativo | Multiplicativo |
| Z | Automático (selecionado pelo algoritmo) | Automático |
| Ad | Aditivo Amortecido | — |
| Md | Multiplicativo Amortecido | — |

Exemplo de notação: `model = "AAA"` (Erro Aditivo, Tendência Aditiva, Sazonalidade Aditiva).

#### 6.4 Implementação em Python

```python
from statsmodels.tsa.holtwinters import ExponentialSmoothing
from statsmodels.tsa.api import SimpleExpSmoothing, Holt
from statsmodels.tsa.holtwinters import ExponentialSmoothing as HW

base = pd.Series([3, 5, 9, 20, 12, 17, 22, 23, 51, 41, 56, 75, 60, 75, 88])

# --- SES: sem tendência/sazonalidade ---
ses_model = SimpleExpSmoothing(base).fit()
ses_forecast = ses_model.forecast(3)

# --- Holt: com tendência ---
holt_model = Holt(base).fit()
holt_forecast = holt_model.forecast(3)

# --- Holt-Winters com tendência, sem sazonalidade ---
ajuste2 = HW(base, trend='add', seasonal=None).fit()
prevajuste2 = ajuste2.forecast(5)

# --- Holt-Winters Aditivo (com sazonalidade) ---
base2 = pd.Series([10, 14, 8, 25, 16, 22, 14, 35, 15, 27, 18, 40, 28, 40, 25, 65],
                  index=pd.date_range(start='2019-01-01', periods=16, freq='QE'))
ajuste4 = HW(base2, trend='add', seasonal='add', seasonal_periods=4).fit()
prevajuste4 = ajuste4.forecast(4)

# --- Holt-Winters Multiplicativo ---
ajuste5 = HW(base2, trend='add', seasonal='mul', seasonal_periods=4).fit()
prevajuste5 = ajuste5.forecast(4)
```

#### 6.5 Seleção Automática do Melhor ETS via AIC

```python
configs = [
    {'trend': None, 'seasonal': None},
    {'trend': 'add', 'seasonal': None},
    {'trend': None, 'seasonal': 'add'},
    {'trend': 'add', 'seasonal': 'add'}
]

best_aic = float('inf')
best_config = None
best_model = None

for config in configs:
    try:
        model = ExponentialSmoothing(bambev, seasonal_periods=4,
                                     trend=config['trend'], seasonal=config['seasonal']).fit()
        if model.aic < best_aic:
            best_aic = model.aic
            best_config = config
            best_model = model
    except Exception:
        pass

print(f"Melhor configuração: {best_config} com AIC = {best_aic}")
best_forecasts = best_model.forecast(steps=9)
```

#### 6.6 Diagnóstico dos Resíduos do Modelo ETS

```python
from statsmodels.stats.diagnostic import acorr_ljungbox

residuals = best_model.resid
ljung_box_result = acorr_ljungbox(residuals, lags=[30], return_df=True)

if ljung_box_result['lb_pvalue'].values[0] > 0.05:
    print("Aceitamos H0: resíduos independentes (iid). Modelo bem ajustado.")
else:
    print("Rejeitamos H0: resíduos não são iid. Modelo apresenta falhas de ajuste.")

sm.graphics.tsa.plot_acf(residuals)
plt.show()
```

---

### 7. ESTACIONARIEDADE

#### 7.1 Definição

> "[...] um processo estocástico é estacionário se suas média e variância forem constantes ao longo do tempo e o valor da covariância entre dois períodos de tempo depender apenas da distância ou defasagem entre os dois períodos, e não do período de tempo efetivo em que a covariância é calculada" (ENDERS, 2003).

- Série com tendência é o motivo mais comum de não estacionariedade.
- Detecta-se pelo gráfico ACF: processos não estacionários apresentam decaimento lento da autocorrelação.

#### 7.2 Modelos e Estacionariedade

| Série Estacionária | Série Não-Estacionária |
|---|---|
| Média móvel | Tendência linear |
| Média móvel ponderada | Método de Holt |
| Alisamento exponencial | |

#### 7.3 Testes de Estacionariedade

- **Teste KPSS (Kwiatkowski-Phillips-Schmidt-Shin)**
  - H₀: a série é estacionária (não apresenta raiz unitária)
  - H₁: a série não é estacionária (possui raiz unitária)

- **Teste de Dickey-Fuller (Aumentado - ADF)**
  - H₀: a série não é estacionária (possui raiz unitária)
  - H₁: a série é estacionária (não possui raiz unitária)
  - Usa-se a versão *aumentada* pois não se sabe, a priori, quantos termos de diferenças defasadas incluir (determinado empiricamente).

- **Teste PP (Phillips-Perron)**
  - H₀: a série não é estacionária (apresenta raiz unitária)
  - H₁: a série é estacionária (sem raiz unitária)

#### 7.4 Implementação em Python (ADF)

```python
from statsmodels.tsa.stattools import adfuller, kpss

def dickey_fuller_test(series, title=''):
    result = adfuller(series)
    print(f'Teste de Dickey-Fuller para {title}')
    print(f'Estatística: {result[0]}')
    print(f'p-valor: {result[1]}')
    for key, value in result[4].items():
        print(f'{key}: {value}')
    print('Conclusão:', 'Estacionária' if result[1] < 0.01 else 'Não Estacionária')

dickey_fuller_test(serie_ar, 'AR(1)')
dickey_fuller_test(serie_arima_nao_estacionaria, 'ARIMA(1,1,1)')
```

#### 7.5 Verificando Quantas Diferenciações são Necessárias

```python
import pmdarima as pm

def verificar_differenciacao(serie, nome):
    d = pm.arima.ndiffs(serie, test='adf')
    print(f"A série {nome} precisa de {d} diferenciação(ões) para ser estacionária.")
    return d

verificar_differenciacao(varejotreino, "Varejo - Treinamento")
varejotreino_diff = varejotreino.diff().dropna()
```

---

### 8. AUTOCORRELAÇÃO E CORRELOGRAMAS

#### 8.1 Autocorrelação (defasagem 1)

```
        Σ(xₜ - x̄₁)(xₜ₊₁ - x̄₂)
r₁ = ─────────────────────────────
      √[Σ(xₜ-x̄₁)² · Σ(xₜ₊₁-x̄₂)²]
```

#### 8.2 Função de Autocorrelação — FAC(k) / ACF(k)

```
             Σ(xₜ - x̄)(xₜ₊ₖ - x̄)
FAC(k) = ────────────────────────────
                Σ(xₜ - x̄)²
```

- Oscila entre -1 e 1; não tem unidade (mesma unidade em covariância e variância).
- O gráfico de FAC(k) contra k é o **correlograma amostral**.

#### 8.3 ACF x PACF

- **FAC (ACF) - Função de Autocorrelação**: mostra as autocorrelações em uma série temporal; a 1ª autocorrelação é sempre igual a 1; linhas no gráfico indicam intervalo de confiança/significância.
- **FACP (PACF) - Função de Autocorrelação Parcial**: mede a correlação entre a série e seu lag k, removendo o efeito dos lags intermediários (mede não entre lags, mas entre diferentes intervalos).

#### 8.4 Padrões Típicos de FAC e FACP (identificação de p e q)

| Modelo | Padrão típico da FAC | Padrão típico da FACP |
|---|---|---|
| AR(p) | Decai exponencialmente para zero (ou padrão senoidal amortecido) | Valores significativos até a defasagem p, depois nulos |
| MA(q) | Valores significativos até a defasagem q, depois nulos | Decai exponencialmente para zero |
| ARMA(p,q) | Decai exponencialmente para zero | Decai exponencialmente para zero |

#### 8.5 Implementação em Python

```python
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf

def plot_acf_pacf(series, lags=20, title=''):
    fig, ax = plt.subplots(1, 2, figsize=(12, 5))
    plot_acf(series, lags=lags, ax=ax[0], title=f'ACF {title}')
    plot_pacf(series, lags=lags, ax=ax[1], title=f'PACF {title}', method='ywm')
    plt.show()

plot_acf_pacf(serie_ar, title='AR(1)')
plot_acf_pacf(serie_arma, title='ARMA(1,1)')
```

---

### 9. MODELOS ARIMA (BOX-JENKINS)

#### 9.1 Filosofia

> "Nos modelos ARIMA os dados falam por si mesmo."

- É **robusto**: pode ser aplicado em praticamente qualquer tipo de série temporal.
- Funciona melhor com dados estáveis e poucos outliers (pode-se limpá-los com `tsclean`).
- **Requer dados estacionários.**
- A **diferenciação** remove tendências: subtrai a observação atual da anterior; pode ser feita 1x (1ª ordem) ou, mais raramente, 2x (2ª ordem).

#### 9.2 Componentes ARIMA(p,d,q)

- **AR (autorregressivo)**: avalia a relação entre períodos (lags) — autocorrelação.
- **I (Integrado)**: aplica diferenciação, quando necessário, para tornar a série estacionária.
- **MA (Médias Móveis)**: avalia os erros entre períodos.
- Combinações: **ARMA** (autorregressivo + médias móveis), **ARIMA** (autorregressivo integrado + médias móveis).

```
ARIMA(p, d, q)

p: ordem da parte autorregressiva  → identificada pela PACF
d: grau de diferenciação           → identificado por teste de estacionariedade (ADF/KPSS)
q: ordem da média móvel            → identificada pela ACF
```

- **p=1**: a observação é explicada pela observação anterior + erro. **p=2**: explicada pelas duas observações anteriores + erro.
- **d=0**: sem diferenciação. **d=1**: diferenciação de 1ª ordem. **d=2**: diferenciação de 2ª ordem.
- **q=1**: a observação é explicada pelo erro da observação anterior. **q=2**: pelo erro de duas observações anteriores.

#### 9.3 Casos Particulares

| Notação | Nome |
|---|---|
| AR(1) = ARIMA(1,0,0) | Apenas elemento autorregressivo de 1ª ordem |
| AR(2) = ARIMA(2,0,0) | Apenas elemento autorregressivo de 2ª ordem |
| MA(1) = ARIMA(0,0,1) | Apenas média móvel |
| ARMA(1,1) = ARIMA(1,0,1) | Autorregressão e média móvel de 1ª ordem |

#### 9.4 Formalização

```
Yₜ = φ₁Yₜ₋₁ + φ₂Yₜ₋₂ + ... + φₚYₜ₋ₚ + uₜ - θ₁uₜ₋₁ - ... - θ_q uₜ₋q
```

- **Hiperparâmetro p**: defasagem máxima de Y presente na equação.
- **Hiperparâmetro q**: defasagem máxima de u (erro) presente na equação.
- **Hiperparâmetro d**: ordem de integração, quando o processo não é estacionário.

**Ruído Branco** — uma sequência eₜ é ruído branco se, para qualquer t:
1. E(eₜ) = 0 → média constante e nula
2. Var(eₜ) = E(eₜ²) = σ² → variância constante
3. Cov(eₜ, eₜ₋₁) = E(eₜeₜ₋₁) = 0 → ausência de autocorrelação

Se eₜ ~ N, então é **Ruído Branco Gaussiano**.

#### 9.5 Critérios de Escolha do Modelo

- **AIC (Akaike Information Criterion)**: estima a quantidade relativa de informação perdida por um modelo; menor AIC → melhor modelo.
- **BIC (Bayesian Information Criterion)**: menor BIC → melhor ajuste.

#### 9.6 Modelos SARIMA (ARIMA Sazonal)

```
SARIMA(p, d, q)(P, D, Q)ₛ
```

- **P**: número de termos autorregressivos sazonais
- **D**: número de diferenças sazonais
- **Q**: número de médias móveis sazonais
- **s**: ciclo sazonal (ex.: 12 para dados mensais)

Exemplos de notação:

```
SARIMA(0,0,0)(1,0,0)₁₂:  Yₜ = a + Φ₁Yₜ₋₁₂ + eₜ
SARIMA(0,0,0)(0,0,1)₁₂:  Yₜ = a + eₜ + Θ₁eₜ₋₁₂
```

#### 9.7 Metodologia de Box-Jenkins (Etapas)

| Etapa | Processo |
|---|---|
| **Identificação** | Descobrir os valores apropriados de p e q usando o correlograma (ACF) e correlograma parcial (PACF), identificando em que defasagens há maior correlação. |
| **Estimação** | Estimar os parâmetros dos termos autorregressivo e de médias móveis do modelo. |
| **Checagem** | Verificar se os resíduos estimados são ruído branco. Se sim, aceita-se o ajuste; se não, reinicia-se o processo. |

#### 9.8 Simulação de Processos ARIMA em Python

```python
import numpy as np
from statsmodels.tsa.arima_process import ArmaProcess
from statsmodels.tsa.arima.model import ARIMA

# Simulação de um AR(1): X(t) = 0.8*X(t-1) + erro
ar = np.array([1, -0.8])
ma = np.array([1])
ar_process = ArmaProcess(ar, ma)
serie_ar = ar_process.generate_sample(nsample=500)

# Simulação de um MA(1): X(t) = -0.3*erro(t-1) + erro(t)
ma = np.array([1, -0.3])
ar = np.array([1])
ma_process = ArmaProcess(ar, ma)
serie_ma = ma_process.generate_sample(nsample=500)

# Simulação de ARMA(1,1)
ar = np.array([1, -0.8])
ma = np.array([1, -0.3])
arma_process = ArmaProcess(ar, ma)
serie_arma = arma_process.generate_sample(nsample=500)

# ARIMA(1,1,1) não estacionária = integração (cumsum) de um ARMA(1,1) estacionário
serie_arima_nao_estacionaria = pd.Series(np.cumsum(serie_arma))
```

#### 9.9 Estimação Manual e Automática

```python
# Estimação manual (ordem já definida)
modelo_ar2 = ARIMA(serie_ar2, order=(2, 0, 0)).fit()
print(modelo_ar2.summary())

# Estimação automática com pmdarima
from pmdarima import auto_arima

auto_arima_model = auto_arima(serie_ar, trace=True, seasonal=False, stepwise=True)
print(auto_arima_model.summary())

# ARIMA com sazonalidade explícita
mod = ARIMA(sipca, order=(1, 0, 0), seasonal_order=(0, 0, 1, 12)).fit()

# auto_arima sazonal
arimavarejo = auto_arima(varejotreino_diff, seasonal=True, m=12,
                          trace=True, stepwise=True)
```

#### 9.10 Previsão e Reversão da Diferenciação

```python
n_periods = 24
previsoes_diff = arimavarejo.predict(n_periods=n_periods)

# Reverter a diferenciação (voltar ao nível original)
ultimo_valor_original = varejotreino.iloc[-1]
previsoes_nivel_original = [ultimo_valor_original]
for previsao in previsoes_diff:
    previsoes_nivel_original.append(previsoes_nivel_original[-1] + previsao)
previsoes_nivel_original = previsoes_nivel_original[1:]
```

#### 9.11 Diagnóstico de Resíduos do Modelo ARIMA

```python
from statsmodels.stats.diagnostic import acorr_ljungbox
from scipy.stats import kstest
from arch import arch_model

residuals = mod.resid

# 1. Teste de Ljung-Box (autocorrelação dos resíduos)
# H0: resíduos não correlacionados (independência)
# H1: resíduos correlacionados (modelo não capturou toda a estrutura)
ljung_box = acorr_ljungbox(residuals, lags=[12], return_df=True)

# 2. Teste de Normalidade (Kolmogorov-Smirnov)
# H0: resíduos normais / H1: resíduos não normais
ks_stat, ks_p_value = kstest(residuals, 'norm', args=(np.mean(residuals), np.std(residuals)))

# 3. Teste de efeitos ARCH (heterocedasticidade condicional)
# H0: não existe efeito ARCH / H1: existe efeito ARCH
arch_test = arch_model(residuals, vol='ARCH', p=1).fit(disp='off')
print(arch_test.summary())
```

---

### 10. TESTE DE NORMALIDADE (Assimetria, Curtose e Jarque-Bera)

```
Assimetria: A(X) = E[(X-μ)³] / σ³
Curtose:    K(X) = E[(X-μ)⁴] / σ⁴

Normal: A = 0 e K = 3

Teste de Jarque-Bera (1981):
JB = (n/6)·A² + (n/24)·(K-3)²

H0: a série é normal
JB ~ χ²(2)
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

# Fontes de dados
import yfinance as yf          # Yahoo Finance
from bcb import sgs            # Banco Central do Brasil
import ipeadatapy as ip        # IPEA

# Decomposição e suavização
from statsmodels.tsa.seasonal import seasonal_decompose
from statsmodels.tsa.holtwinters import ExponentialSmoothing
from statsmodels.tsa.api import SimpleExpSmoothing, Holt

# Estacionariedade e ACF/PACF
from statsmodels.tsa.stattools import adfuller, kpss
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf
import statsmodels.api as sm

# ARIMA/SARIMA
from statsmodels.tsa.arima.model import ARIMA
from statsmodels.tsa.arima_process import ArmaProcess
from pmdarima import auto_arima
import pmdarima as pm

# Diagnóstico de resíduos
from statsmodels.stats.diagnostic import acorr_ljungbox
from scipy.stats import kstest, shapiro
from arch import arch_model

# Métricas de erro
from sklearn.metrics import (mean_absolute_error, mean_squared_error,
                             root_mean_squared_error,
                             mean_absolute_percentage_error)
from scipy import stats

import warnings
warnings.filterwarnings('ignore')
```

### Pipeline Completo — Da Leitura à Previsão ARIMA

```python
# 1. LEITURA E CONSTRUÇÃO DA SÉRIE TEMPORAL
df = pd.read_excel("dados.xlsx")
serie = pd.Series(df.iloc[:, 1].values,
                  index=pd.date_range(start='2000-01-01', periods=len(df), freq='ME'))

# 2. ANÁLISE EXPLORATÓRIA
plt.plot(serie); plt.title("Série Temporal"); plt.grid(True); plt.show()
print(serie.describe())

# 3. SEPARAÇÃO TREINO/TESTE
treino = serie[:-12]
teste = serie[-12:]

# 4. DECOMPOSIÇÃO
decomp = seasonal_decompose(treino, model='additive', period=12)
decomp.plot(); plt.show()

# 5. TESTE DE ESTACIONARIEDADE (ADF)
resultado = adfuller(treino.dropna())
print(f'p-valor ADF: {resultado[1]}')
d = pm.arima.ndiffs(treino, test='adf')
print(f'Diferenciações necessárias: {d}')

# 6. ACF/PACF (identificação de p e q)
fig, axes = plt.subplots(1, 2, figsize=(16, 4))
plot_acf(treino, lags=24, ax=axes[0])
plot_pacf(treino, lags=24, ax=axes[1], method='ywm')
plt.show()

# 7. AJUSTE DO MODELO (manual ou automático)
modelo_arima = auto_arima(treino, seasonal=True, m=12, stepwise=True, trace=True)
print(modelo_arima.summary())

# 8. PREVISÃO
previsao = modelo_arima.predict(n_periods=len(teste))

# 9. AVALIAÇÃO
mape_valor = mean_absolute_percentage_error(teste, previsao) * 100
print(f'MAPE: {mape_valor:.2f}%')

# 10. DIAGNÓSTICO DE RESÍDUOS
residuos = modelo_arima.resid()
ljung_box = acorr_ljungbox(residuos, lags=[10], return_df=True)
print(ljung_box)

if ljung_box['lb_pvalue'].values[0] > 0.05:
    print("Resíduos são ruído branco: modelo bem ajustado.")
else:
    print("Resíduos correlacionados: revisar especificação do modelo.")
```

### Comparação de Todos os Modelos por MAPE

```python
from sklearn.metrics import mean_absolute_percentage_error as mape

modelos, mapes, previsoes = [], [], {}

# Naive
naive_fc = pd.Series([treino.iloc[-1]] * len(teste), index=teste.index)
modelos.append("Naive"); mapes.append(mape(teste, naive_fc) * 100)

# Mean
mean_fc = pd.Series(treino.mean(), index=teste.index)
modelos.append("Mean"); mapes.append(mape(teste, mean_fc) * 100)

# Drift
n = len(treino)
slope = (treino.iloc[-1] - treino.iloc[0]) / (n - 1)
drift_fc = pd.Series(treino.iloc[-1] + slope * np.arange(1, len(teste) + 1), index=teste.index)
modelos.append("Drift"); mapes.append(mape(teste, drift_fc) * 100)

# SES, Holt, Holt-Winters, ARIMA/SARIMA (seguem o mesmo padrão)
# ...

comparacao = pd.DataFrame({'Modelo': modelos, 'MAPE': mapes}).sort_values('MAPE')
plt.barh(comparacao['Modelo'], comparacao['MAPE'], color='skyblue')
plt.xlabel("MAPE"); plt.title("Comparação de Modelos"); plt.show()
```

---

## 📊 Exemplos Práticos do Curso

### Exemplo 1: Cotações da PETR4 (Univariada + Passeio Aleatório)

- **Dataset**: basepetr4.xlsx (também disponível via `yfinance`, ticker "PETR4.SA")
- **Variáveis**: fechamento, abertura, mínimo, volume financeiro negociado
- **Objetivo**: Visualizar a série de fechamento diário e comparar visualmente com um passeio aleatório (random walk) simulado — introdução ao conceito de estacionariedade.

### Exemplo 2: Passageiros do Transporte Aéreo (Naive Sazonal)

- **Dataset**: passageiros.xlsx / airpassengers.xlsx
- **Período**: jan/2007 a dez/2018 (série mensal)
- **Objetivo**: Aplicar o modelo Naive Sazonal com sazonalidade de 12 meses e gerar previsão de 12 passos à frente com intervalo de confiança.

### Exemplo 3: Receita Trimestral da AMBEV (ETS e Comparação de Modelos)

- **Dataset**: ambev.xlsx (frequência trimestral, `freq='QE'`)
- **Objetivo**: Separar em treino/teste (últimos 9 trimestres como teste), ajustar Naive, Mean, Drift, Naive Sazonal, SES, Holt, Holt-Winters Aditivo e Multiplicativo, e comparar todos pelo MAPE. Escolha automática do melhor modelo ETS via AIC, seguida de diagnóstico com teste de Ljung-Box.

### Exemplo 4: Manchas Solares e Focos de Queimadas (Decomposição/Visualização)

- **Datasets**: manchas.xlsx (desde 1749, fonte SILSO) e queimadas.xlsx (fonte INPE, desde 1999)
- **Objetivo**: Construir séries temporais mensais longas, plotar estatísticas descritivas e usar `month_plot` para visualizar sazonalidade dentro do ano.

### Exemplo 5: COVID-19 Brasil (Médias Móveis)

- **Dataset**: covid.xlsx (fonte: covid.saude.gov.br)
- **Objetivo**: Calcular médias móveis de 14 dias (centralizadas e não centralizadas) para suavizar a série diária de casos e identificar outliers via box-plot mensal.

### Exemplo 6: PIB Mensal do Brasil (Decomposição Aditiva e Multiplicativa)

- **Dataset**: pib_mensal.xlsx (jan/2004 a fev/2026)
- **Objetivo**: Decompor a série em tendência, sazonalidade e resíduo pelos dois modelos (aditivo e multiplicativo), comparando os resultados com paleta de cores viridis.

### Exemplo 7: Consumo de Energia Elétrica no Sudeste (Comparação Completa + ARIMA)

- **Dataset**: energia.xlsx (também disponível via `ipeadatapy`, código `ELETRO12_CEESE12`)
- **Período**: jan/1979 a jan/2026 (treino até 2024-01, teste 2024-02 a 2026-01)
- **Objetivo**: Rodar e comparar TODOS os modelos estudados (Naive, Mean, Drift, Naive Sazonal, SES, Holt-Winters Aditivo/Multiplicativo com Box-Cox, e ARIMA/SARIMA via `auto_arima`) pelo MAPE; validar o melhor modelo com testes de Shapiro-Wilk (normalidade) e Ljung-Box (autocorrelação dos resíduos).

### Exemplo 8: Índice de Volume de Vendas de SP — Varejo (ARIMA/SARIMA Completo)

- **Dataset**: obtido via `bcb.sgs` (código 1475, Banco Central)
- **Objetivo**: Pipeline completo de Box-Jenkins — plot ACF/PACF, teste ADF, diferenciação, `auto_arima` sazonal (m=12), diagnóstico com Ljung-Box, Kolmogorov-Smirnov e teste ARCH, previsão de 24 passos com reversão da diferenciação para o nível original, e comparação com um modelo ETS (Holt-Winters).

### Exemplo 9: IPCA — Inflação Brasileira (ARIMA Sazonal x Auto ARIMA)

- **Dataset**: obtido via `bcb.sgs` (código 433, Banco Central), jan/2000 a ago/2024
- **Objetivo**: Visualizar distribuição mensal do IPCA com violin plot, ajustar manualmente um `ARIMA(1,0,0)(0,0,1)[12]` e comparar com o resultado do `auto_arima`, avaliando ambos pelo MAPE e validando resíduos (Ljung-Box, Kolmogorov-Smirnov, teste ARCH).

### Exemplo 10: Séries Simuladas AR, MA, ARMA e ARIMA

- **Objetivo didático**: Gerar séries sintéticas com `ArmaProcess` (AR(1), AR(2), AR(3), MA(1), ARMA(1,1), ARMA(2,2), ARIMA(1,1,1) via integração/cumsum) para observar visualmente o comportamento teórico de cada família de modelo e validar a leitura correta dos gráficos ACF/PACF e do teste de Dickey-Fuller.

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Componentes da Decomposição

| Componente | Símbolo | Descrição |
|---|---|---|
| Tendência | T | Direção de longo prazo (cresce, decresce ou estável) |
| Ciclo | C | Flutuação de longo prazo sem período fixo |
| Sazonalidade | S | Padrão que se repete em período fixo (dia/semana/mês/ano) |
| Erro/Resíduo | E | Componente aleatória |

```
Modelo Aditivo:        Y = T + C + S + E
Modelo Multiplicativo: Y = T * C * S * E
```

### 🎯 Fórmulas Essenciais

```
1. Erro de Previsão:
   erro_t = X̂_t - X_t

2. ME (Mean Error):
   ME = Σ(erro_t) / h

3. MAE (Mean Absolute Error):
   MAE = Σ|erro_t| / h

4. RMSE (Root Mean Square Error):
   RMSE = √[Σ(erro_t²)/h]

5. MAPE (Mean Absolute Percentage Error):
   MAPE = [Σ|erro_t/X_t| / h] × 100%

6. Theil's U:
   U = √[Σ((X̂ₜ₊₁-Xₜ₊₁)/Xₜ)²] / √[Σ((Xₜ₊₁-Xₜ)/Xₜ)²]
   U < 1 → previsão melhor que passeio aleatório

7. Função de Autocorrelação:
   FAC(k) = Σ(xₜ-x̄)(xₜ₊ₖ-x̄) / Σ(xₜ-x̄)²

8. Modelo AR(p):
   Yₜ = φ₁Yₜ₋₁ + φ₂Yₜ₋₂ + ... + φₚYₜ₋ₚ + uₜ

9. Modelo ARIMA(p,d,q):
   Yₜ = φ₁Yₜ₋₁ + ... + φₚYₜ₋ₚ + uₜ - θ₁uₜ₋₁ - ... - θ_quₜ₋q

10. Teste de Jarque-Bera:
    JB = (n/6)A² + (n/24)(K-3)²  ~ χ²(2)
```

### 📐 Interpretações Importantes

**Identificação de ARIMA(p,d,q):**

- **p** ← olhe a **PACF** (quantos lags são significativos antes de zerar)
- **d** ← teste de **estacionariedade** (ADF/KPSS) e/ou `ndiffs`
- **q** ← olhe a **ACF** (quantos lags são significativos antes de zerar)

**Padrões de ACF/PACF:**

- AR(p): ACF decai suavemente; PACF corta abruptamente após o lag p.
- MA(q): ACF corta abruptamente após o lag q; PACF decai suavemente.
- ARMA(p,q): ambos decaem suavemente.

**Testes de hipótese usados na validação de modelos:**

| Teste | H₀ | Uso |
|---|---|---|
| ADF (Dickey-Fuller) | Série NÃO é estacionária | Verificar necessidade de diferenciação |
| KPSS | Série é estacionária | Confirmar/contrastar com ADF |
| Ljung-Box | Resíduos NÃO autocorrelacionados | Validar se o modelo capturou toda a estrutura |
| Shapiro-Wilk / Kolmogorov-Smirnov | Resíduos são normais | Validar distribuição dos resíduos |
| Teste ARCH | NÃO há efeito ARCH (heterocedasticidade) | Validar variância constante dos resíduos |
| Jarque-Bera | Série é normal | Testar normalidade via assimetria/curtose |

**Critérios de seleção de modelo:**

- AIC e BIC: quanto **menor**, melhor o modelo.
- MAPE: quanto **menor**, melhor a acurácia da previsão fora da amostra.

---

## ⚠️ Erros Comuns a Evitar

1. **Aplicar ARIMA em série não estacionária sem diferenciar**: viola premissa fundamental do modelo.
2. **Confundir ACF com PACF na identificação de p e q**: p vem da PACF, q vem da ACF.
3. **Esquecer de definir a frequência (`freq`) correta ao criar o índice temporal**: gera datas erradas e sazonalidade mal capturada.
4. **Usar `freq='Q'` em versões recentes do pandas**: pode ser necessário `freq='QE'` (quarter end) — atenção à versão da biblioteca.
5. **Ignorar outliers antes de ajustar ARIMA**: o modelo funciona melhor com dados estáveis (considerar `tsclean`).
6. **Não comparar modelo aditivo x multiplicativo**: escolher com base em como a amplitude sazonal varia com o nível da série.
7. **Interpretar AIC/BIC como valor absoluto**: eles só servem para comparação relativa entre modelos.
8. **Não validar os resíduos do modelo final**: pular os testes de Ljung-Box, normalidade e ARCH pode mascarar um modelo mal ajustado.
9. **Esquecer de reverter a diferenciação** ao prever com uma série diferenciada (usar `cumsum` a partir do último valor original).
10. **Avaliar o modelo só pelo ajuste dentro da amostra (fitted values)**: sempre usar divisão treino/teste e métricas fora da amostra (MAPE, RMSE) para comparação justa.
11. **Confundir Theil's U com R²**: valores de Theil's U próximos de 0 indicam boa previsão; próximos ou acima de 1 indicam previsão ruim (pior ou igual a um passeio aleatório).

---

## 📚 Materiais de Apoio

### Datasets Utilizados (arquivos .xlsx do script)

- **basepetr4.xlsx**: cotações diárias da PETR4 (abertura, mínima, fechamento, volume)
- **passageiros.xlsx / airpassengers.xlsx**: total de passageiros no transporte aéreo BR
- **ambev.xlsx**: receita trimestral acumulada da AMBEV
- **manchas.xlsx**: número médio mensal de manchas solares (desde 1749)
- **queimadas.xlsx**: focos de queimadas mensais (INPE, desde 1999)
- **covid.xlsx**: casos diários de COVID-19 no Brasil
- **pib_mensal.xlsx**: PIB mensal do Brasil (jan/2004 a fev/2026)
- **energia.xlsx**: consumo de energia elétrica na região Sudeste (GWh, desde 1979)
- **consumo_brasil.xlsx**: base adicional de consumo

### Fontes de Dados Externas Utilizadas

- **Yahoo Finance** (`yfinance`): cotações de ações (ex.: PETR4.SA)
- **Banco Central do Brasil - SGS** (`bcb.sgs`): IPCA (código 433), Volume de Vendas SP (código 1475)
- **IPEA** (`ipeadatapy`): consumo de energia elétrica (`ELETRO12_CEESE12`)
- **ANAC**: dados estatísticos de transporte aéreo
- **CVM**: dados de mercado de capitais
- **B3**: Índice IBOVESPA
- **INPE (Programa Queimadas)**: focos de queimadas
- **SILSO**: número de manchas solares
- **gov.br/saude (covid.saude.gov.br)**: dados de COVID-19

### Arquivos Excel do Curso

- **Aula 3 ST Modelos ARIMA - corrigido_MCxlsx**: exercícios resolvidos de modelos ARIMA
- **Modelos Simples de Previsao de ST 2026 Resolvido_MCxlsx**: exercícios resolvidos de métodos simples (Naive, Média, Drift, Naive Sazonal)
- **Modelos de Decomposicao ST 2026_MCxlsx** e **Solucao Modelos de Decomposicao ST 2026_MCxlsx**: exercícios de decomposição aditiva/multiplicativa

### Bibliotecas Python Utilizadas

- **statsmodels**: `seasonal_decompose`, `ExponentialSmoothing`, `SimpleExpSmoothing`, `Holt`, `ARIMA`, `ArmaProcess`, `adfuller`, `kpss`, `plot_acf`/`plot_pacf`, `acorr_ljungbox`
- **pmdarima**: `auto_arima`, `ndiffs`
- **arch**: `arch_model` (teste de efeitos ARCH)
- **bcb**: `sgs.get` (Banco Central)
- **ipeadatapy**: `timeseries`, `describe`, `list_series`
- **yfinance**: `download`
- **sklearn.metrics**: `mean_absolute_error`, `mean_squared_error`, `root_mean_squared_error`, `mean_absolute_percentage_error`
- **scipy.stats**: `norm`, `t`, `kstest`, `shapiro`

---

## 📖 Referências Recomendadas

### Livros e Materiais

1. **Hyndman, R. J. & Athanasopoulos, G.** "Forecasting: Principles and Practice" — https://otexts.com/fpp3/ (referência principal indicada nos slides)
2. **Box, G. E. P. & Jenkins, G. M.** "Time Series Analysis: Forecasting and Control" (metodologia Box-Jenkins)
3. **Enders, W. (2003).** "Applied Econometric Time Series" (definição de estacionariedade citada nos slides)

### Recursos Online

- **statsmodels** — documentação de `seasonal_decompose`, `ExponentialSmoothing`, `ARIMA`, testes de diagnóstico
- **pmdarima** — documentação do `auto_arima`
- **Banco Central do Brasil (SGS)** — https://www3.bcb.gov.br/sgspub/localizarseries/localizarSeries.do
- **IPEA Data** — http://ipeadata.gov.br
- **INPE Queimadas** — https://terrabrasilis.dpi.inpe.br/queimadas/
- **SILSO (manchas solares)** — http://sidc.be/silso/infosnmtot

---

## ✅ Checklist de Estudo

### Conceitos Teóricos

- [ ] Entender o que é uma série temporal e a importância da ordem/dependência temporal
- [ ] Diferenciar séries univariadas x multivariadas e discretas x contínuas
- [ ] Diferenciar séries determinísticas x estocásticas
- [ ] Identificar os quatro componentes de uma série (tendência, ciclo, sazonalidade, erro)
- [ ] Diferenciar decomposição aditiva x multiplicativa

### Métodos Simples de Previsão

- [ ] Implementar e interpretar Naive, Naive Sazonal, Média e Drift
- [ ] Calcular intervalos de confiança das previsões
- [ ] Calcular e interpretar ME, MAE, RMSE, MPE, MAPE e Theil's U

### Suavização Exponencial

- [ ] Diferenciar SES, Holt (com tendência) e Holt-Winters (com tendência e sazonalidade)
- [ ] Entender a notação ETS (Error, Trend, Seasonal)
- [ ] Selecionar automaticamente o melhor modelo ETS via AIC

### Estacionariedade e Autocorrelação

- [ ] Entender a definição formal de estacionariedade (média, variância e covariância constantes)
- [ ] Aplicar e interpretar os testes ADF, KPSS e PP
- [ ] Determinar o número de diferenciações necessárias (`ndiffs`)
- [ ] Ler corretamente gráficos ACF e PACF para identificar p e q

### Modelos ARIMA/SARIMA

- [ ] Entender os componentes p, d, q do ARIMA
- [ ] Aplicar a metodologia de Box-Jenkins (Identificação, Estimação, Checagem)
- [ ] Simular processos AR, MA, ARMA e ARIMA com `ArmaProcess`
- [ ] Estimar modelos manualmente (`ARIMA`) e automaticamente (`auto_arima`)
- [ ] Trabalhar com sazonalidade via SARIMA (parâmetros P, D, Q, s)
- [ ] Reverter a diferenciação para obter previsões no nível original

### Diagnóstico de Resíduos

- [ ] Aplicar e interpretar o teste de Ljung-Box (autocorrelação)
- [ ] Aplicar e interpretar testes de normalidade (Shapiro-Wilk, Kolmogorov-Smirnov, Jarque-Bera)
- [ ] Aplicar e interpretar o teste de efeitos ARCH

### Casos Práticos

- [ ] Reproduzir a análise da PETR4 (leitura, plotagem, passeio aleatório)
- [ ] Reproduzir a decomposição do PIB mensal (aditiva e multiplicativa)
- [ ] Reproduzir a comparação de modelos para a série da AMBEV (MAPE)
- [ ] Reproduzir o pipeline ARIMA/SARIMA completo (varejo SP ou IPCA)
- [ ] Aplicar o pipeline completo em uma série própria (ex.: dados do BCB/IPEA)

### Projeto Final

- [ ] Carregar e transformar a base em série temporal com índice de datas correto
- [ ] Analisar componentes via decomposição
- [ ] Testar estacionariedade e aplicar diferenciação se necessário
- [ ] Identificar p, d, q via ACF/PACF e confirmar com `auto_arima`
- [ ] Comparar múltiplos modelos (Naive, ETS, ARIMA) por MAPE em conjunto de teste
- [ ] Validar resíduos do modelo final (Ljung-Box, normalidade, ARCH)
- [ ] Apresentar previsões com intervalos de confiança e visualizações

---

**📌 Nota Final:** Séries Temporais são a base de qualquer projeto de forecasting em finanças, economia, operações e ciências ambientais. Do método Naive mais simples até modelos SARIMA sofisticados, a escolha do modelo certo depende sempre de entender a estrutura de tendência, sazonalidade e estacionariedade dos dados — e de validar os resíduos do modelo final antes de confiar nas previsões.

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_  
_Módulo 23 - Séries Temporais_
