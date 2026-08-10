# 📊 Resumo - Analytics e Gestão de Riscos

## MBA em Data Science e Analytics USP/ESALQ

---

## 🎯 Objetivo do Módulo

Aplicar técnicas quantitativas de análise de risco e retorno para gestão de portfólios de investimento, incluindo teoria de Markowitz, otimização de carteiras, simulação de Monte Carlo e análise de sensibilidade para tomada de decisões sob incerteza.

---

## 📚 Conteúdo Principal

### 1. **Fundamentos de Risco e Retorno**

#### 1.1 Conceitos Básicos

- **Retorno**: ganho ou perda percentual de um investimento
- **Risco**: volatilidade ou variabilidade dos retornos (desvio padrão)
- **Retorno Esperado**: média dos retornos históricos ou projetados
- **Taxa Livre de Risco (rf)**: retorno de ativos sem risco (ex: CDI, títulos públicos)
- **Prêmio de Risco**: retorno adicional esperado por assumir risco

#### 1.2 Medidas de Risco

**Volatilidade (σ)**:

- Desvio padrão dos retornos
- Maior volatilidade = maior risco
- Pode ser diária, mensal ou anualizada

**Covariância**:

- Mede como dois ativos se movem juntos
- Positiva: movem-se na mesma direção
- Negativa: movem-se em direções opostas

**Correlação (ρ)**:

- Covariância normalizada (-1 a +1)
- ρ = 1: correlação perfeita positiva
- ρ = -1: correlação perfeita negativa
- ρ = 0: sem correlação linear

#### 1.3 Fórmulas Essenciais

$$
R_t = \frac{P_t - P_{t-1}}{P_{t-1}}
$$

$$
\mathbb{E}[R] = \frac{1}{T}\sum_{t=1}^{T} R_t
$$

$$
\sigma = \sqrt{\frac{1}{T-1}\sum_{t=1}^{T}(R_t-\bar{R})^2}
$$

$$
\mathrm{Cov}(R_i,R_j)=\frac{1}{T-1}\sum_{t=1}^{T}(R_{i,t}-\bar{R}_i)(R_{j,t}-\bar{R}_j)
$$

$$
\rho_{ij}=\frac{\mathrm{Cov}(R_i,R_j)}{\sigma_i\sigma_j}
$$

---

### 2. **Download e Preparação de Dados**

#### 2.1 Yahoo Finance (yfinance)

```python
import yfinance as yf
import datetime as dt

# Definir período
data_final = dt.date.today()
data_inicial = data_final - dt.timedelta(days=120)

# Tickers B3 (adicionar .SA)
tickers = ["PETR4.SA", "VALE3.SA", "EMBR3.SA"]

# Download
precos = yf.download(
    tickers=tickers,
    start=data_inicial,
    end=data_final + dt.timedelta(days=1),
    auto_adjust=True,
    progress=False
)["Close"].dropna(axis=1, how="all")
```

#### 2.2 Leitura de Excel

```python
import pandas as pd

# Ler cotações de Excel
df = pd.read_excel("COTACOES.xlsx", sheet_name=0)

# Processar data
col_data = df.columns[0]
df[col_data] = pd.to_datetime(df[col_data], dayfirst=True, errors="coerce")
df = df.dropna(subset=[col_data]).set_index(col_data).sort_index()

# Filtrar período
precos = df.loc[(df.index.date >= data_inicial) &
                (df.index.date <= data_final), tickers]
```

---

### 3. **Cálculo de Retornos**

#### 3.1 Retornos Diários

$$
r_t = \frac{P_t}{P_{t-1}} - 1
$$

```python
# Retornos percentuais diários
retornos = precos.pct_change().dropna()

# Estatísticas
print("Retornos médios diários:\n", retornos.mean())
print("Desvio padrão diário (risco):\n", retornos.std())
```

#### 3.2 Matrizes de Covariância e Correlação

$$
\Sigma = [\mathrm{Cov}(R_i,R_j)]_{i,j=1}^{n}, \qquad C = [\rho_{ij}]_{i,j=1}^{n}
$$

```python
# Covariância
cov_matrix = retornos.cov()
print("Matriz de Covariância:\n", cov_matrix)

# Correlação
corr_matrix = retornos.corr()
print("Matriz de Correlação (Pearson):\n", corr_matrix)
```

#### 3.3 Anualização

$$
\mu_{anual}=252\,\mu_{diario}, \qquad \Sigma_{anual}=252\,\Sigma_{diaria}, \qquad \sigma_{anual}=\sqrt{252}\,\sigma_{diaria}
$$

```python
# Anualizar retornos e risco (252 pregões/ano)
freq = 252

mu_daily = retornos.mean()  # retorno médio diário
S_daily = retornos.cov()    # covariância diária

# Anualizar
mu = mu_daily * freq              # retorno anual esperado
S = S_daily * freq                # covariância anual
vol_annual = np.sqrt(np.diag(S)) # volatilidade anual por ativo
```

---

### 4. **Teoria Moderna de Portfólios (Markowitz)**

#### 4.1 Conceitos Fundamentais

**Diversificação**:

- Reduz risco sem necessariamente reduzir retorno
- "Não colocar todos os ovos na mesma cesta"
- Funciona melhor com ativos não perfeitamente correlacionados

**Fronteira Eficiente**:

- Conjunto de portfólios ótimos
- Máximo retorno para dado nível de risco
- Mínimo risco para dado nível de retorno

**Índice de Sharpe**:

$$
\mathrm{Sharpe}(w)=\frac{\mu_p-r_f}{\sigma_p}=\frac{w^\top\mu-r_f}{\sqrt{w^\top\Sigma w}}
$$

- Mede retorno excedente por unidade de risco
- Quanto maior, melhor
- Compara eficiência de diferentes portfólios

**Modelo de Markowitz (forma clássica)**:

$$
\min_{w} \; w^\top\Sigma w
\quad \text{sujeito a} \quad
\mathbf{1}^\top w = 1, \; w^\top\mu \geq \mu^*, \; 0 \leq w_i \leq 1
$$

$$
\mu_p = w^\top\mu, \qquad \sigma_p = \sqrt{w^\top\Sigma w}
$$

#### 4.2 Instalação de Bibliotecas

```python
# Instalar no console (sem #)
# pip install yfinance pyportfolioopt cvxpy osqp scs clarabel
```

#### 4.3 Importações

```python
import warnings
warnings.filterwarnings("ignore")

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import cvxpy as cp
from pypfopt import EfficientFrontier, risk_models, expected_returns

# Verificar solvers disponíveis
print("Solvers disponíveis:", cp.installed_solvers())
```

---

### 5. **Otimização de Portfólios**

#### 5.1 Carteira de Mínimo Risco

```python
from pypfopt import EfficientFrontier

# Taxa livre de risco anual (ex: CDI)
rf_annual = 0.145  # 14.5%

# Criar objeto EfficientFrontier
ef_min = EfficientFrontier(mu, S, weight_bounds=(0, 1))

# Minimizar volatilidade
_ = ef_min.min_volatility()
w_min_clean = ef_min.clean_weights()

# Performance
ret_min, vol_min, sharpe_min = ef_min.portfolio_performance(
    risk_free_rate=rf_annual
)

# Organizar pesos
pesos_min = pd.DataFrame.from_dict(w_min_clean, orient="index",
                                   columns=["Peso"])
pesos_min = pesos_min[pesos_min["Peso"] > 0]  # Apenas pesos > 0

print("Carteira de Mínimo Risco:")
print(pesos_min.round(4))
print(f"Retorno Anual: {ret_min:.4f}")
print(f"Volatilidade Anual: {vol_min:.4f}")
print(f"Índice de Sharpe: {sharpe_min:.4f}")
```

**Características**:

- Menor risco possível
- Geralmente menor retorno
- Mais conservadora

#### 5.2 Carteira Tangente (Máximo Sharpe)

```python
# Criar objeto
ef_tan = EfficientFrontier(mu, S, weight_bounds=(0, 1))

# Maximizar Sharpe Ratio
_ = ef_tan.max_sharpe(risk_free_rate=rf_annual)
w_tan_clean = ef_tan.clean_weights()

# Performance
ret_tan, vol_tan, sharpe_tan = ef_tan.portfolio_performance(
    risk_free_rate=rf_annual
)

# Organizar pesos
pesos_tan = pd.DataFrame.from_dict(w_tan_clean, orient="index",
                                   columns=["Peso"])
pesos_tan = pesos_tan[pesos_tan["Peso"] > 0]

print("Carteira Tangente (Máx. Sharpe):")
print(pesos_tan.round(4))
print(f"Retorno Anual: {ret_tan:.4f}")
print(f"Volatilidade Anual: {vol_tan:.4f}")
print(f"Índice de Sharpe: {sharpe_tan:.4f}")
```

**Características**:

- Melhor relação risco-retorno
- Tangente à fronteira eficiente
- Portfólio ótimo na teoria

#### 5.3 Carteira com Retorno Alvo

```python
# Definir retorno alvo
target_return = 0.20  # 20% ao ano

ef = EfficientFrontier(mu, S, weight_bounds=(0, 1))
ef.efficient_return(target_return=target_return)

weights = ef.clean_weights()
ret, vol, sharpe = ef.portfolio_performance(risk_free_rate=rf_annual)
```

#### 5.4 Carteira de Pesos Iguais (Benchmark)

```python
# Pesos iguais para todos os ativos
n_assets = len(mu)
weights_equal = np.repeat(1/n_assets, n_assets)

# Retorno e risco
ret_eq = float(weights_equal @ mu.values)
vol_eq = float(np.sqrt(weights_equal @ S.values @ weights_equal))

print(f"Pesos Iguais - Retorno: {ret_eq:.4f}, Risco: {vol_eq:.4f}")
```

---

### 6. **Fronteira Eficiente**

$$
\mathcal{F}=\left\{(\sigma_p,\mu_p):\exists w \text{ com } \mathbf{1}^\top w=1 \text{ e } \sigma_p=\sqrt{w^\top\Sigma w},\, \mu_p=w^\top\mu\right\}
$$

#### 6.1 Calcular Pontos da Fronteira

```python
# Gerar retornos-alvo
target_rets = np.linspace(mu.min(), mu.max(), 60)

frontier_rets, frontier_vols = [], []

for tr in target_rets:
    ef = EfficientFrontier(mu, S, weight_bounds=(0, 1))
    try:
        ef.efficient_return(target_return=tr)
        r, v, _ = ef.portfolio_performance(risk_free_rate=rf_annual)
        frontier_rets.append(r)
        frontier_vols.append(v)
    except Exception:
        pass  # Retorno inatingível

frontier_rets = np.array(frontier_rets)
frontier_vols = np.array(frontier_vols)
```

---

### 7. **Simulação de Monte Carlo**

#### 7.1 Portfólios Aleatórios

$$
w \sim \mathrm{Dirichlet}(\alpha_1,\ldots,\alpha_n), \quad \sum_{i=1}^{n} w_i=1, \; w_i\ge 0
$$

$$
\mu_p=w^\top\mu, \qquad \sigma_p=\sqrt{w^\top\Sigma w}
$$

```python
def random_weights(n_assets, n_port=2000):
    """Gera pesos aleatórios que somam 1 (Dirichlet)"""
    return np.random.dirichlet(np.ones(n_assets), size=n_port)

# Gerar 3000 portfólios aleatórios
W = random_weights(len(mu), n_port=3000)

# Calcular retorno e risco para cada portfólio
rets_mc = W @ mu.values
vols_mc = np.sqrt(np.einsum('ij,jk,ik->i', W, S.values, W))
```

**Objetivo da Simulação**:

- Explorar espaço de possibilidades
- Visualizar região factível
- Comparar com fronteira eficiente
- Mostrar benefício da otimização

---

### 8. **Visualização da Fronteira**

#### 8.1 Gráfico Completo

```python
plt.figure(figsize=(10, 6.5))

# Nuvem Monte Carlo
plt.scatter(vols_mc, rets_mc, alpha=0.25, s=8,
            label="Portfólios (Monte Carlo)")

# Fronteira eficiente
plt.plot(frontier_vols, frontier_rets, 'r-', lw=2.2,
         label="Fronteira Eficiente")

# Carteira de mínimo risco
plt.scatter(vol_min, ret_min, marker="*", s=220, c='gold',
            edgecolors='black', label="Mínimo Risco")

# Carteira tangente
plt.scatter(vol_tan, ret_tan, marker="X", s=130, c='lime',
            edgecolors='black', label="Tangente (Máx. Sharpe)")

# Pesos iguais
plt.scatter(vol_eq, ret_eq, marker="o", s=90, c='cyan',
            edgecolors='black', label="Pesos Iguais")

# Ativos individuais
ret_assets = mu.values
vol_assets = np.sqrt(np.diag(S.values))
plt.scatter(vol_assets, ret_assets, marker="D", s=70, c='orange',
            label="Ativos")

# Anotar tickers
for i, ticker in enumerate(tickers):
    plt.annotate(ticker, (vol_assets[i], ret_assets[i]),
                 xytext=(6, 6), textcoords="offset points", fontsize=9)

plt.title("Fronteira Eficiente de Markowitz - B3")
plt.xlabel("Volatilidade Anual (risco)")
plt.ylabel("Retorno Anual Esperado")
plt.grid(True, alpha=0.3)
plt.legend()
plt.tight_layout()
plt.show()
```

---

### 9. **Análise de VPL com Simulação de Monte Carlo**

#### 9.1 Conceitos de VPL

**Valor Presente Líquido (VPL/NPV)**:

$$
\mathrm{VPL}=-I_0+\sum_{t=1}^{T}\frac{FC_t}{(1+r)^t}
$$

$$
\mathrm{EBITDA}_t = \mathrm{Receita}_t - \mathrm{Custos}_t - \mathrm{Desp}_t
$$

$$
\mathrm{EBIT}_t = \mathrm{EBITDA}_t - \mathrm{Dep}_t, \qquad
\mathrm{NOPAT}_t = \mathrm{EBIT}_t - \mathrm{IR}_t, \qquad
FC_t = \mathrm{NOPAT}_t + \mathrm{Dep}_t
$$

- Traz fluxos futuros a valor presente
- VPL > 0: projeto viável
- VPL < 0: projeto inviável
- Considera valor do dinheiro no tempo

**Componentes**:

- **Investimento Inicial**: desembolso no Ano 0
- **Fluxos de Caixa Operacionais (FCO)**: receitas - custos
- **Taxa de Desconto**: custo de oportunidade do capital
- **EBIT**: Earnings Before Interest and Taxes
- **NOPAT**: Net Operating Profit After Tax
- **Depreciação**: investimento / vida útil

#### 9.2 Premissas com Distribuição Triangular

```python
# Premissas (min, mode, max)
premissas = {
    "preco_venda":   {"min": 49.0,  "mode": 51.0,  "max": 55.0},   # R$/unid
    "quantidade":    {"min": 990.0, "mode": 1100.0, "max": 1200.0}, # unid/ano
    "preco_custo":   {"min": 28.0,  "mode": 29.5,  "max": 32.0},   # R$/unid
    "desp_op":       {"min": 5000.0,"mode": 6000.0,"max": 6500.0}, # R$/ano
    "investimento":  {"min": 19000.0,"mode": 20000.0, "max": 20800.0},
    "taxa_desconto": {"min": 0.17,  "mode": 0.18,  "max": 0.19},   # a.a.
}

anos_vida = 4
aliquota_ir = 0.40  # 40%
n_sims = 10000
```

**Distribuição Triangular**:

Para $X \sim \mathrm{Triangular}(a,c,b)$, com $a \le c \le b$:

$$
f_X(x)=
\begin{cases}
\frac{2(x-a)}{(b-a)(c-a)}, & a\le x < c \\
\frac{2(b-x)}{(b-a)(b-c)}, & c\le x \le b \\
0, & \text{caso contrário}
\end{cases}
$$

$$
\mathbb{E}[X]=\frac{a+b+c}{3}
$$

- Define valores pessimista (min), mais provável (mode), otimista (max)
- Forma triangular entre min e max, pico em mode
- Simples e intuitiva para especialistas

#### 9.3 Amostragem Triangular

```python
def amostrar_triangular(p, n):
    """Amostra n valores da triangular (min, mode, max)"""
    a, c, b = p["min"], p["mode"], p["max"]
    return np.random.triangular(a, c, b, size=n)

# Exemplo
precos = amostrar_triangular(premissas["preco_venda"], n_sims)
```

#### 9.4 Fluxo de Caixa Determinístico (Base)

```python
def fluxo_base_por_moda(prem):
    """Calcula fluxo usando valores da moda (mais prováveis)"""
    preco = prem["preco_venda"]["mode"]
    qtd = prem["quantidade"]["mode"]
    custo = prem["preco_custo"]["mode"]
    desp = prem["desp_op"]["mode"]
    inv = prem["investimento"]["mode"]
    r = prem["taxa_desconto"]["mode"]

    dep_anual = inv / anos_vida

    # Ano típico
    receita = preco * qtd
    custos = custo * qtd
    ebitda = receita - custos - desp
    ebit = ebitda - dep_anual
    ir = max(0.0, aliquota_ir * ebit)
    nopat = ebit - ir
    fco = nopat + dep_anual

    # VPL
    vpl = -inv + sum(fco / (1 + r) ** t for t in range(1, anos_vida + 1))
    return vpl

vpl_base = fluxo_base_por_moda(premissas)
print(f"VPL Base: R$ {vpl_base:,.2f}")
```

#### 9.5 Simulação de Monte Carlo do VPL

```python
def simular_vpl(prem, n_sims=10000):
    """Simula VPLs variando todas as premissas simultaneamente"""
    # Amostrar cada variável
    preco = amostrar_triangular(prem["preco_venda"], n_sims)
    qtd = amostrar_triangular(prem["quantidade"], n_sims)
    custo = amostrar_triangular(prem["preco_custo"], n_sims)
    desp = amostrar_triangular(prem["desp_op"], n_sims)
    inv = amostrar_triangular(prem["investimento"], n_sims)
    r = amostrar_triangular(prem["taxa_desconto"], n_sims)

    dep = inv / anos_vida

    # Calcular para cada simulação
    receita = preco * qtd
    custos = custo * qtd
    ebitda = receita - custos - desp
    ebit = ebitda - dep
    ir = np.where(ebit > 0, aliquota_ir * ebit, 0.0)
    nopat = ebit - ir
    fco = nopat + dep

    # VPL para cada simulação
    descontos = np.vstack([(1.0 / (1.0 + r) ** t)
                           for t in range(1, anos_vida + 1)])
    vpl = -inv + (fco * descontos).sum(axis=0)

    return pd.Series(vpl, name="VPL")

# Executar simulação
vpls = simular_vpl(premissas, n_sims=10000)
```

#### 9.6 Estatísticas do VPL

```python
# Estatísticas descritivas
mean_vpl = vpls.mean()
std_vpl = vpls.std(ddof=1)
q05, q50, q95 = vpls.quantile([0.05, 0.50, 0.95])
p_pos = (vpls > 0).mean()

print(f"Média: R$ {mean_vpl:,.2f}")
print(f"Mediana (P50): R$ {q50:,.2f}")
print(f"Desvio-padrão: R$ {std_vpl:,.2f}")
print(f"P5: R$ {q05:,.2f}")
print(f"P95: R$ {q95:,.2f}")
print(f"P(VPL > 0): {100*p_pos:.2f}%")
```

**Interpretação dos Percentis**:

- **P5**: 5% dos cenários têm VPL abaixo deste valor (cenário pessimista)
- **P50 (Mediana)**: metade dos cenários têm VPL acima/abaixo
- **P95**: 95% dos cenários têm VPL abaixo deste valor (cenário otimista)
- **P(VPL > 0)**: probabilidade do projeto ser viável

#### 9.7 Visualização do VPL

```python
fig, ax = plt.subplots(figsize=(9.5, 5.6))

# Histograma
ax.hist(vpls, bins=40, edgecolor="black", alpha=0.85)

# Linhas verticais (P5, P95, VPL=0)
ax.axvline(q05, linestyle="--", linewidth=1.25, label="P5 / P95")
ax.axvline(q95, linestyle="--", linewidth=1.25)
ax.axvline(0, linestyle=":", linewidth=1.0, label="VPL = 0")

ax.set_title("VPL - Distribuição Monte Carlo")
ax.set_xlabel("VPL (R$)")
ax.set_ylabel("Frequência")
ax.grid(True, alpha=0.25)

# Caixa de estatísticas
text_stats = (
    f"Média: R$ {mean_vpl:,.2f}\n"
    f"Mediana: R$ {q50:,.2f}\n"
    f"P5: R$ {q05:,.2f} | P95: R$ {q95:,.2f}\n"
    f"P(VPL>0): {100*p_pos:.2f}%"
)
ax.text(0.98, 0.97, text_stats, transform=ax.transAxes,
        va="top", ha="right",
        bbox=dict(boxstyle="round", facecolor="white", alpha=0.85))

ax.legend(loc="upper left")
plt.tight_layout()
plt.show()
```

---

### 10. **Análise de Sensibilidade - Diagrama Tornado**

#### 10.1 Conceito

**Diagrama Tornado**:

$$
\Delta_i^{\text{Low}} = \mathrm{VPL}(x_i=\min_i)-\mathrm{VPL}_{base}, \qquad
\Delta_i^{\text{High}} = \mathrm{VPL}(x_i=\max_i)-\mathrm{VPL}_{base}
$$

$$
\mathrm{Impacto}_i = \left|\mathrm{VPL}(x_i=\max_i)-\mathrm{VPL}(x_i=\min_i)\right|
$$

- Identifica quais variáveis têm maior impacto no VPL
- Varia uma variável por vez (mantendo outras constantes)
- Ordena variáveis por impacto (maior impacto no topo)
- Formato de tornado (barras horizontais decrescentes)

#### 10.2 Implementação

```python
def vpl_deterministico(preco, qtd, custo, desp, inv, r):
    """Calcula VPL dado valores determinísticos"""
    dep = inv / anos_vida
    receita = preco * qtd
    custos = custo * qtd
    ebitda = receita - custos - desp
    ebit = ebitda - dep
    ir = aliquota_ir * ebit if ebit > 0 else 0.0
    nopat = ebit - ir
    fco = nopat + dep
    pv = sum(fco / (1 + r) ** t for t in range(1, anos_vida + 1))
    return -inv + pv

# VPL baseline (valores "mode")
base = {k: v["mode"] for k, v in premissas.items()}
baseline = vpl_deterministico(**base)

# Para cada variável, calcular VPL com min e max
rows = []
for var in premissas.keys():
    # VPL com input no mínimo
    low_vals = base.copy()
    low_vals[var] = premissas[var]["min"]
    vpl_low = vpl_deterministico(**low_vals)

    # VPL com input no máximo
    high_vals = base.copy()
    high_vals[var] = premissas[var]["max"]
    vpl_high = vpl_deterministico(**high_vals)

    # Deltas em relação ao baseline
    d_low = vpl_low - baseline
    d_high = vpl_high - baseline
    impacto = abs(vpl_high - vpl_low)

    rows.append([var, d_low, d_high, impacto, vpl_low, vpl_high])

df = pd.DataFrame(rows, columns=["Variável","ΔLow","ΔHigh",
                                 "Impacto","VPL Low","VPL High"])
# Ordenar por impacto (menor → maior)
df = df.sort_values("Impacto", ascending=True).reset_index(drop=True)
```

#### 10.3 Plotar Tornado

```python
y = np.arange(len(df))
h = 0.38

fig, ax = plt.subplots(figsize=(11, 6))

# Linha do baseline
ax.axvline(baseline, linestyle=":", linewidth=1.2, color="k",
           label=f"Baseline = R$ {baseline:,.0f}")

# Barras horizontais (lado a lado)
ax.barh(y, df["ΔHigh"], left=baseline, height=h,
        label="Input High", color="#1f4acc")
ax.barh(y, df["ΔLow"], left=baseline, height=h,
        label="Input Low", color="#b22222", alpha=0.85)

# Rótulos
ax.set_yticks(y)
ax.set_yticklabels(df["Variável"])
ax.set_title("Gráfico Tornado — ΔVPL vs Baseline")
ax.grid(True, axis="x", alpha=0.25)
ax.legend()

plt.tight_layout()
plt.show()
```

**Interpretação**:

- **Variáveis no topo**: maior impacto no VPL (críticas)
- **Variáveis na base**: menor impacto
- **Barras largas**: alta sensibilidade
- **Barras estreitas**: baixa sensibilidade
- Priorizar controle/estimativa das variáveis mais impactantes

---

## 🛠️ Ferramentas e Bibliotecas

### Bibliotecas Python

```python
# Instalação
# pip install yfinance            # Download de cotações
# pip install pyportfolioopt      # Otimização de portfólios
# pip install cvxpy osqp scs clarabel  # Solvers de otimização
# pip install openpyxl            # Leitura de Excel

# Importação
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import yfinance as yf
import cvxpy as cp
from pypfopt import EfficientFrontier, risk_models, expected_returns
```

### Ferramentas

- **Yahoo Finance**: dados históricos gratuitos de ações
- **CVXPY**: otimização convexa
- **PyPortfolioOpt**: otimização de portfólios simplificada
- **Excel**: armazenamento de cotações e premissas

---

## 📊 Dataset Utilizado

### COTACOES.xlsx

**Conteúdo**:

- **Coluna 1**: Data (formato dd/mm/yyyy)
- **Demais colunas**: Preços de fechamento ajustados de cada ativo
- **Período**: mínimo 120 dias corridos
- **Tickers B3**: formato XXXX#.SA (ex: PETR4.SA, VALE3.SA)

**Ativos comuns B3**:

- PETR4.SA: Petrobras PN
- VALE3.SA: Vale ON
- ITUB4.SA: Itaú PN
- BBDC4.SA: Bradesco PN
- EMBR3.SA: Embraer ON

---

## 📊 Aplicações Práticas em Finanças

### 1. Gestão de Portfólios

- **Asset Management**: construção de fundos de investimento
- **Wealth Management**: portfólios personalizados para clientes
- **Previdência**: fundos de pensão e PGBL/VGBL
- **Rebalanceamento**: ajuste periódico de pesos

### 2. Análise de Projetos

- **Viabilidade econômica**: decisão de investir ou não
- **Projetos industriais**: novas fábricas, equipamentos
- **Startups**: avaliação de novos negócios
- **M&A**: fusões e aquisições

### 3. Gestão de Riscos

- **Identificação**: quais variáveis críticas (tornado)
- **Quantificação**: probabilidades e impactos
- **Mitigação**: estratégias para reduzir exposição
- **Hedging**: proteção contra movimentos adversos

### 4. Planejamento Estratégico

- **Cenários**: pessimista, base, otimista
- **Sensibilidade**: como mudanças afetam resultados
- **Trade-offs**: risco vs retorno
- **Comunicação**: apresentação de incertezas para stakeholders

---

## 💡 Conceitos-Chave para Gestão de Riscos

### Diversificação Funciona

- **Não** elimina risco completamente
- Reduz **risco não sistemático** (específico da empresa)
- **Risco sistemático** (mercado) permanece
- Efeito maior com ativos de baixa correlação

### Não Existe Almoço Grátis

- Maior retorno esperado → maior risco
- Fronteira eficiente: relação ótima risco-retorno
- Portfólios abaixo da fronteira são subótimos

### Índice de Sharpe é Rei

- Melhor métrica para comparar portfólios
- Considera retorno **e** risco
- Independente de escala
- Tangente tem maior Sharpe

### P5 e P95 são Cruciais

- Mostram extremos prováveis (não impossíveis)
- P5: prepare-se para cenário ruim
- P95: não conte com cenário muito bom
- Intervalos de confiança mais informativos que médias

### Tornado Direciona Atenção

- Foque nas variáveis críticas (topo do tornado)
- Invista em melhores estimativas dessas variáveis
- Controle ou hedge das mais impactantes
- Variáveis na base podem ser aproximadas

### Simulação > Análise Determinística

- Captura incerteza de múltiplas variáveis
- Fornece distribuição completa de resultados
- Permite calcular probabilidades
- Mais realista que cenários discretos

### Taxa de Desconto é Subjetiva

- Reflete custo de oportunidade do investidor
- Maior taxa → VPL menor (mais conservador)
- Varia entre investidores e projetos
- Importante testar sensibilidade a essa taxa

---

## 📚 Materiais de Apoio

### Arquivos da Disciplina

- **PDF**: Analytics e Gestao de Riscos 07102025_SLpdf Portugues.pdf
- **PDF**: Analytics e Gestao de Riscos 3009 e 07102025_SLpdf Portugues.pdf
- **Excel**: AULA ANALYTICS - Solucao07102025_MCxlsx Portugues.xlsx
- **Excel**: AULA ANALYTICS PARA GESTAO DE RISCOS_MCxlsx Portugues.xlsx

### Scripts Python

- **Aula Analytics e Gestao de Riscos 2025.py**: script completo da aula
- **COTACOES.xlsx**: dados de preços de ativos B3

---

## 🎯 Pontos Importantes para Memorizar

1. **Anualização de Retornos**
   - Diário → Anual: multiplicar por 252 (retorno)
   - Diário → Anual: multiplicar por 252 (variância), depois √ para volatilidade

2. **Weight Bounds em Otimização**
   - `(0, 1)`: sem venda a descoberto (long only)
   - `(-1, 1)`: permite short
   - Pode definir limites específicos por ativo

3. **Carteira Tangente ≠ Mínimo Risco**
   - Tangente: melhor Sharpe (eficiência)
   - Mínimo risco: menor volatilidade (conservador)
   - Tangente geralmente tem mais risco e retorno

4. **Correlação é Chave**
   - Correlação < 1: diversificação reduz risco
   - Correlação = 1: diversificação inútil
   - Correlação negativa: forte redução de risco

5. **Solvers Importam**
   - Diferentes solvers (OSQP, SCS, CLARABEL, ECOS)
   - Se um falha, tente outro
   - Instale múltiplos: `pip install osqp scs clarabel`

6. **VPL vs TIR**
   - VPL: valor absoluto em R$ (preferível)
   - TIR: taxa de retorno (pode enganar com múltiplas raízes)
   - Para comparação, use VPL

7. **Monte Carlo Requer Seed**
   - `np.random.seed(42)`: reprodutibilidade
   - Mesmos resultados em diferentes execuções
   - Importante para validação e depuração

8. **Triangular é Simples e Útil**
   - 3 parâmetros: min, mode (mais provável), max
   - Fácil obter de especialistas
   - Alternativas: Normal, Lognormal, Uniforme

---

## 📖 Referências Recomendadas

### Livros

- Markowitz, H. (1952). Portfolio Selection. Journal of Finance.
- Damodaran, A. (2012). Investment Valuation, 3rd Edition. Wiley.
- Hull, J. (2017). Options, Futures, and Other Derivatives, 10th Edition.
- Copeland, T., et al. (2005). Financial Theory and Corporate Policy.

### Online

- Yahoo Finance: https://finance.yahoo.com/
- PyPortfolioOpt Docs: https://pyportfolioopt.readthedocs.io/
- CVXPY Docs: https://www.cvxpy.org/
- Investopedia: https://www.investopedia.com/ (conceitos)

### Artigos Clássicos

- Sharpe, W. (1964). Capital Asset Pricing Model. Journal of Finance.
- Markowitz, H. (1959). Portfolio Selection: Efficient Diversification of Investments.

---

## ✅ Checklist de Estudo

- [ ] Instalar bibliotecas: yfinance, pyportfolioopt, cvxpy, solvers
- [ ] Baixar cotações históricas de ativos B3
- [ ] Calcular retornos diários e anualizados
- [ ] Calcular matrizes de covariância e correlação
- [ ] Construir carteira de mínimo risco
- [ ] Construir carteira tangente (máx. Sharpe)
- [ ] Calcular fronteira eficiente
- [ ] Realizar simulação Monte Carlo de portfólios
- [ ] Plotar gráfico completo com fronteira e pontos especiais
- [ ] Interpretar Índice de Sharpe
- [ ] Definir premissas com distribuição triangular
- [ ] Calcular VPL determinístico (baseline)
- [ ] Simular VPL com Monte Carlo
- [ ] Analisar estatísticas (P5, P50, P95, P(VPL>0))
- [ ] Criar diagrama Tornado para análise de sensibilidade
- [ ] Interpretar variáveis críticas no Tornado

---

**Última atualização**: Março 2026  
**Curso**: MBA em Data Science e Analytics - USP/ESALQ  
**Módulo**: 10 - Analytics e Gestão de Riscos  
**Professor**: Prof. Fabiano
