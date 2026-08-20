# 📊 Resumo - Analytics e Gestão de Riscos

## MBA em Data Science e Analytics USP/ESALQ
**Professor Fabiano Guasti Lima**

---

## 🎯 Objetivo do Módulo

Aplicar Analytics para avaliação de modelos de risco (mercado, crédito e operacional), incluindo teoria de Markowitz, otimização de carteiras, cálculo de risco de crédito (Basileia), risco operacional, análise de fluxos de caixa/VPL com simulação de Monte Carlo e análise de sensibilidade — com scripts em Python e planilhas de apoio.

---

## 📚 Conteúdo Principal

### 1. Risco e Retorno de Ativos Individuais

- **Retorno Discreto:** $R_t = \dfrac{Preço_t}{Preço_{t-1}} - 1 = \dfrac{Preço_t - Preço_{t-1}}{Preço_{t-1}}$
- **Retorno Contínuo:** $R_t = \ln\left(\dfrac{Preço_t}{Preço_{t-1}}\right)$
- Exemplo em aula: comparação de retornos mensais (jan-abr/2025) de PETR4, Ibovespa e Café Arábica (fonte: B3 e CEPEA/Esalq), para ilustrar qual ativo "oscilou mais" (medida de risco = volatilidade).

### 2. Risco e Retorno no Contexto de Carteiras

- **Retorno da carteira (2 ativos):** $R_{cart} = W_a \times R_a + W_b \times R_b$
- **Risco da carteira (2 ativos):** $S_C = \sqrt{W_a^2 S_a^2 + W_b^2 S_b^2 + 2W_aW_b\,corr(R_a,R_b)\,S_aS_b}$ (equivalente usando covariância no lugar de correlação × desvios)
- Exemplo em aula: Ativo A (retorno 8%, risco 5%) e Ativo B (retorno 25%, risco 12%), com R$ 5.000 investidos em cada (50%/50%): retorno da carteira = 16,5%. Ao introduzir correlação negativa entre os ativos (ex.: -0,60), demonstra-se a redução de risco pela diversificação.
- **Harry Markowitz (1927-2023):** artigo seminal "Portfolio Selection" (The Journal of Finance, 1952); Prêmio Nobel de Economia em 1990 (teoria moderna de carteiras).
- **Efeito da correlação (exemplos em aula, dados Economática jan/2010-set/2019):** Ibovespa x Dólar (correlação = -0,627); PETR4 x VALE3 (correlação = 0,532).
- **Carteira com mais de dois ativos:**
$$Ret_{Cart} = \sum_{i=1}^{n} W_i \times Ret\_ativo_i, \qquad Risco_{Cart} = \sqrt{[W_1 \cdots W_n]\begin{bmatrix}cov_{11} & \cdots & cov_{1n}\\ \vdots & \ddots & \vdots \\ cov_{n1} & \cdots & cov_{nn}\end{bmatrix}\begin{bmatrix}W_1\\ \vdots \\ W_n\end{bmatrix}}$$

### 3. Otimização de Carteiras em Python (Fronteira de Markowitz)

#### 3.1 Instalação e Importações

```python
# pip install --upgrade pip setuptools wheel
# pip install yfinance pyportfolioopt cvxpy osqp scs clarabel

import warnings
warnings.filterwarnings("ignore")
import datetime as dt
import numpy as np
import pandas as pd
import yfinance as yf
import matplotlib.pyplot as plt
import cvxpy as cp
from pypfopt import EfficientFrontier, risk_models, expected_returns

print("Solvers disponíveis:", cp.installed_solvers())
```

#### 3.2 Leitura de Dados (Excel ou Yahoo Finance)

```python
# Tickers de exemplo (B3 via Yahoo Finance)
tickers = ["PETR4.SA", "VALE3.SA", "EMBR3.SA"]
rf_annual = 0.145  # Taxa livre de risco anual (ex.: CDI ~14,5%)

# Alternativa 1: ler cotações de um arquivo Excel (COTACOES.xlsx)
df = pd.read_excel("COTACOES.xlsx", sheet_name=0)
col_data = df.columns[0]
df[col_data] = pd.to_datetime(df[col_data], dayfirst=True, errors="coerce")
df = df.dropna(subset=[col_data]).set_index(col_data).sort_index()

# Alternativa 2: baixar direto do Yahoo Finance (não requer o Excel)
precos = yf.download(tickers=tickers, start=data_inicial, end=data_final + dt.timedelta(days=1),
                      auto_adjust=True, progress=False)["Close"].dropna(axis=1, how="all")
```

#### 3.3 Retornos, Covariância e Anualização

```python
retornos = precos.pct_change().dropna()

print("Retornos médios diários:\n", retornos.mean())
print("Matriz de covariância amostral:\n", retornos.cov())
print("Matriz de correlação (Pearson):\n", retornos.corr())

# Anualização (252 pregões/ano)
freq = 252
mu = retornos.mean() * freq              # retorno esperado anual
S = retornos.cov() * freq                # covariância anual
vol_annual_assets = np.sqrt(np.diag(S))  # risco (volatilidade) anual por ativo
```

#### 3.4 Carteira de Mínimo Risco e Carteira Tangente (Máx. Sharpe)

```python
# Carteira de Mínimo Risco
ef_min = EfficientFrontier(mu, S, weight_bounds=(0, 1))
_ = ef_min.min_volatility()
w_min_clean = ef_min.clean_weights()
ret_min, vol_min, sharpe_min = ef_min.portfolio_performance(risk_free_rate=rf_annual)

# Carteira Tangente (máximo Índice de Sharpe)
ef_tan = EfficientFrontier(mu, S, weight_bounds=(0, 1))
_ = ef_tan.max_sharpe(risk_free_rate=rf_annual)
w_tan_clean = ef_tan.clean_weights()
ret_tan, vol_tan, sharpe_tan = ef_tan.portfolio_performance(risk_free_rate=rf_annual)
```

#### 3.5 Fronteira Eficiente e Simulação de Monte Carlo de Portfólios

```python
# Fronteira eficiente (varrendo retornos-alvo)
target_rets = np.linspace(mu.min(), mu.max(), 60)
frontier_rets, frontier_vols = [], []
for tr in target_rets:
    ef = EfficientFrontier(mu, S, weight_bounds=(0, 1))
    try:
        ef.efficient_return(target_return=tr)
        r, v, _ = ef.portfolio_performance(risk_free_rate=rf_annual)
        frontier_rets.append(r); frontier_vols.append(v)
    except Exception:
        pass

# Monte Carlo: pesos aleatórios via distribuição Dirichlet (somam 1)
def random_weights(n_assets, n_port=2000):
    return np.random.dirichlet(np.ones(n_assets), size=n_port)

W = random_weights(len(mu), n_port=3000)
rets_mc = W @ mu.values
vols_mc = np.sqrt(np.einsum('ij,jk,ik->i', W, S.values, W))
```

O gráfico final combina: nuvem de portfólios (Monte Carlo), a curva da fronteira eficiente, a carteira de mínimo risco, a carteira tangente, a carteira de pesos iguais e os ativos individuais.

---

### 4. Modelos de Risco de Crédito

- **Definição:** o risco de crédito é o risco de **perda econômica** decorrente do **não cumprimento de obrigações contratuais** por uma contraparte.
- **Regulação (Banco Central):** Resolução CMN 2.682/99 (normativo anterior) → atualmente Resolução CMN 4.966/21 e Resolução BCB 352/23.
- **Perda Incorrida** (evento de crédito já ocorrido ou em vias de ocorrer) x **Perda Esperada** (probabilidade de ocorrer o evento de crédito futuro).
- **Metodologia de provisão para perdas (Resolução 4.966/2021):** classificação das operações de crédito em rating (AA, A, B, C, D, E, F, G, H) e em 3 estágios; **Estágio 3 = Ativo Problemático**.
- **Direcionadores do risco de crédito:**
  - **Inadimplência (default):** contraparte está ou não em default; envolve uma **Probabilidade de Default (PD)**
  - **Exposição a crédito no default (EAD ou EC):** incerteza quanto ao valor da exposição no momento do default
  - **Perda dado o default (LGD/PDF):** incerteza quanto ao valor recuperável após o default; 1 − taxa de recuperação (t)
- **Fórmula da Perda de Crédito:** $\text{Perda de Crédito} = b \times EC \times PD$, ou, considerando a taxa de recuperação: $\text{Perda de Crédito} = b \times EC \times (1-t)$
- **Exemplo em aula:** carteira de R$ 100 mil em 3 créditos (A: EC=R$10 mil, p=0,02; B: EC=R$20 mil, p=0,05; C: EC=R$70 mil, p=0,10; recuperação=0), gerando uma distribuição de perdas com: **Perda Esperada** = R$ 8.200; **Perda Não Esperada** = R$ 61.800; e a partir daí, **Perda Excepcional**.

### 5. Gestão de Riscos — Basileia

- **Comitê de Basileia:** localizado na cidade de Basileia (Suíça), formado por membros de Bancos Centrais de países desenvolvidos, que debatem e formalizam estudos e documentos (Comitê da Basileia sobre Supervisão Bancária — BCBS).
- **BIS (Bank for International Settlements / Banco de Compensação Internacional):** fundado em 1930; promove a cooperação entre bancos centrais e demais agências na busca da estabilidade monetária e financeira; sediado em Basileia, reúne 55 bancos centrais.
- **Linha do tempo dos Acordos da Basileia:**
  - 1988: Basileia 1 — requerimento de capital para **risco de crédito**
  - 1996: requerimento de capital para **risco de mercado**
  - 2004: Basileia 2 — requerimento de capital para **risco operacional**
  - 2007: Patrimônio de Referência (PR) e Patrimônio de Referência Exigido (PRE)
  - 2009: Basileia 2,5 — securitizações
  - 2010: Basileia 3
- **Índice da Basileia:** $\dfrac{\text{Capital}}{\text{Risco de Mercado + Risco de Crédito}} \geq 8\%$
- **Critério de ponderação de risco (Basileia 1)** por tipo de exposição: 0% (caixa, créditos de países/bancos centrais); 0/20/50% (setor público não-federal, a critério do BC local); 20% (bancos multilaterais de desenvolvimento); 50% (créditos garantidos por propriedade residencial); 100% (créditos a bancos, a empresas e demais ativos).
- **Exemplo em aula (Ativo Ponderado pelo Risco - APR):** Caixa R$1.000 (peso 0% → APR 0), Aplicações R$50.000 (peso 20% → APR 10.000), Financiamento Imobiliário R$200.000 (peso 50% → APR 100.000), Empréstimos R$300.000 (peso 100% → APR 300.000); Total APR = R$ 410.000.
- **Patrimônio de Referência (PR):** Nível 1 (Capital Social + Reservas de Capital + Reservas de Lucros +/- Lucros/Prejuízos Acumulados + Participações) + Nível 2 (Reservas de Reavaliação + Reservas de Contingência + Dívidas Subordinadas + Instrumentos Híbridos de Capital). Exemplo: Nível 1 = R$40.000, Nível 2 = R$30.000, PR Total = R$70.000.
- **Índice da Basileia calculado:** PR/APR = 70.000/410.000 = **17,1%** → acima dos 8% mínimos → instituição adequada.

### 6. Modelos de Risco Operacional

- **Mensuração baseada na distribuição de perdas** (frequência e severidade), a partir de: dados históricos de frequência e valores de perdas operacionais; estimativas subjetivas de probabilidades/valores; e/ou distribuições teóricas.
- Definições: **n** = número de eventos de risco operacional em um intervalo de tempo (ex.: 1 ano); **S** = severidade (magnitude) de cada perda, dado que ela ocorreu. Consideram-se as probabilidades associadas a cada valor de n e S, tabulando-se uma distribuição empírica das combinações.
- **Exemplo em aula:**
  - Número de perdas: nenhuma (70%), 1 (20%), 2 (10%)
  - Magnitude da perda: R$ 500 (60%), R$ 10.000 (30%), R$ 50.000 (10%)
  - Combinando as possibilidades, gera-se uma distribuição empírica de perdas potenciais operacionais.
- **VaR Operacional:** calcula o Valor em Risco para o nível de confiança desejado. **VaR Operacional = Pior Perda − Perda Esperada Média.**
- **Exemplo complementar (planilha "Exemplo Prob"):** número de fraudes em agência bancária nos últimos 252 dias (415 fraudes, média = 1,65/dia), modelado por **distribuição de Poisson** para estimar a probabilidade (e probabilidade acumulada) de 0, 1, 2... fraudes.

### 7. Fluxos de Caixa e Análise de Investimentos

- **Cálculo das entradas de caixa operacionais:** Receitas − Despesas Operacionais = EBITDA; EBITDA − Depreciação = EBIT (Lucro antes do IR); EBIT − IR = NOPAT (Lucro após IR); NOPAT + Depreciação = Entrada de Caixa Operacional.
- **Exemplo determinístico em aula:** Investimento R$ 200 mil; Receitas e Despesas Operacionais projetadas para 4 anos; Depreciação Anual R$ 50 mil; Alíquota de IR 40%; Taxa de Retorno Esperada 14% a.a. — usados para montar o fluxo de caixa e calcular o VPL.
- **Análise de Sensibilidade:** estuda o efeito que a variação de um dado de entrada (premissa) pode ocasionar nos resultados. Quando uma pequena variação em um parâmetro altera drasticamente a rentabilidade do projeto, diz-se que o projeto é muito sensível a esse parâmetro — sinalizando onde vale a pena reduzir a incerteza dos dados.
- **Simulação de Monte Carlo:** simula variáveis selecionadas do projeto considerando suas distribuições de probabilidade ao longo da vida útil do projeto, para obter uma medida de variabilidade dos resultados (risco) e a sensibilidade do VPL em relação, por exemplo, à taxa de desconto dos fluxos de caixa.
- **Perguntas de análise de risco do projeto (discutidas em aula):** Como o VPL se comporta se a economia apresentar declínio/crescimento? Os preços serão influenciados por isso? A empresa consegue manter os parâmetros do projeto? Há risco de entrada de novos concorrentes? Prazos e custos de implantação serão cumpridos? Os preços de custo sofrerão mudanças relevantes? A empresa atingirá a eficiência desejada?
- **Distribuições de probabilidade usadas em simulações de projeto:** Triangular (parâmetros a=mínimo, b=máximo, m=moda/mais provável), PERT (m=mais provável, o=otimista, p=pessimista) e Normal (μ=média, σ=desvio padrão).

#### 7.1 Distribuição Triangular e Simulação Monte Carlo do VPL (Python)

```python
# Premissas: min (pessimista), mode (mais provável), max (otimista)
premissas = {
    "preco_venda":   {"min": 49.0,    "mode": 51.0,   "max": 55.0},
    "quantidade":    {"min": 990.0,   "mode": 1100.0, "max": 1200.0},
    "preco_custo":   {"min": 28.0,    "mode": 29.5,   "max": 32.0},
    "desp_op":       {"min": 5000.0,  "mode": 6000.0, "max": 6500.0},
    "investimento":  {"min": 19000.0, "mode": 20000.0,"max": 20800.0},
    "taxa_desconto": {"min": 0.17,    "mode": 0.18,   "max": 0.19},
}
anos_vida, aliquota_ir, n_sims = 4, 0.40, 10000

def amostrar_triangular(p, n):
    a, c, b = p["min"], p["mode"], p["max"]
    return np.random.triangular(a, c, b, size=n)

def simular_vpl(prem):
    preco = amostrar_triangular(prem["preco_venda"], n_sims)
    qtd   = amostrar_triangular(prem["quantidade"], n_sims)
    custo = amostrar_triangular(prem["preco_custo"], n_sims)
    desp  = amostrar_triangular(prem["desp_op"], n_sims)
    inv   = amostrar_triangular(prem["investimento"], n_sims)
    r     = amostrar_triangular(prem["taxa_desconto"], n_sims)
    dep = inv / anos_vida
    receita, custos = preco * qtd, custo * qtd
    ebitda = receita - custos - desp
    ebit = ebitda - dep
    ir = np.where(ebit > 0, aliquota_ir * ebit, 0.0)
    nopat = ebit - ir
    fco = nopat + dep
    descontos = np.vstack([(1.0 / (1.0 + r) ** t) for t in range(1, anos_vida + 1)])
    vpl = -inv + (fco * descontos).sum(axis=0)
    return pd.Series(vpl, name="VPL")

vpls = simular_vpl(premissas)
q05, q50, q95 = vpls.quantile([0.05, 0.50, 0.95])
p_pos = (vpls > 0).mean()
```

- **Interpretação dos percentis:** P5 = 5% dos cenários com VPL abaixo desse valor; P50 = mediana; P95 = 95% dos cenários com VPL abaixo desse valor; P(VPL>0) = probabilidade do projeto ser viável.
- **Gráfico de distribuição do VPL:** histograma com linhas de P5, P95 e VPL=0. Em um cenário mais pessimista de premissas, é possível colorir a área de VPL negativo e calcular também P(VPL<0), além de plotar a CDF (função de distribuição acumulada) do VPL.

#### 7.2 Análise de Cenários (Excel — planilha "Resumo do cenário")

- Ferramenta de Cenários do Excel comparando **Otimista**, **Mais Provável** e **Pessimista** para as premissas (preço de venda, quantidade vendida, custo, despesas operacionais, investimento, depreciação, taxa mínima de atratividade), com o VPL e a TIR resultantes de cada cenário.
- **Atribuindo probabilidades aos cenários** (ex.: Otimista 30%, Mais Provável 50%, Pessimista 20%), calcula-se:
  - **VPL Esperado** = Σ (probabilidade × VPL de cada cenário)
  - **Risco** = variância do VPL ponderada pelas probabilidades
  - **CV (Coeficiente de Variação)** = desvio-padrão do VPL / VPL Esperado — medida de risco relativo ao retorno esperado.

#### 7.3 Diagrama Tornado (Análise de Sensibilidade, Python)

```python
def vpl_deterministico(preco, qtd, custo, desp, inv, r):
    dep = inv / anos_vida
    receita, custos = preco * qtd, custo * qtd
    ebitda = receita - custos - desp
    ebit = ebitda - dep
    ir = aliquota_ir * ebit if ebit > 0 else 0.0
    nopat = ebit - ir
    fco = nopat + dep
    return -inv + sum(fco / (1 + r) ** t for t in range(1, anos_vida + 1))

# Para cada variável, calcula-se o VPL fixando-a no mínimo e no máximo (demais no "mode")
# e mede-se o impacto |VPL_high - VPL_low| em relação ao VPL baseline.
# As variáveis são ordenadas por impacto, gerando o formato de "tornado" no gráfico de barras horizontais.
```

- Variáveis no topo do tornado = maior impacto no VPL (mais críticas); variáveis na base = menor impacto — orientando onde vale a pena investir em melhores estimativas.

### 8. Exemplo Aplicado: Retorno de Campanha de Marketing (planilha "Campanha Marketing")

Exemplo de funil de métricas de uma campanha de e-mail marketing, encadeado até o retorno financeiro:

- **Métricas do funil:** Emails Enviados (1.000) → Total de Erros (32, taxa de erro 3,2%) → Emails Efetivamente Enviados (968) → Cliques/Leads (890, CTR ≈ 91,9%) → Compras Efetivas (500, Taxa de Conversão ≈ 56,2%); Custo por Lead ≈ R$ 2,25; Leads por Venda (LPV) ≈ 1,78; Custo por Venda = R$ 4,00.
- **Resultado financeiro:** Receita de Vendas (Compras × Ticket Médio R$20) = R$10.000; Lucro Bruto (25% de margem) = R$2.500; (–) Custo da Campanha R$2.000 = EBIT R$500; (–) IR 20% = R$100; NOPAT = R$400; **Retorno da Campanha = 20%.**

---

## 🛠️ Ferramentas e Bibliotecas

```python
# pip install yfinance            # Download de cotações
# pip install pyportfolioopt      # Otimização de portfólios
# pip install cvxpy osqp scs clarabel  # Solvers de otimização
# pip install openpyxl            # Leitura de Excel
```

- **Yahoo Finance (yfinance):** dados históricos de ações
- **CVXPY / PyPortfolioOpt:** otimização de carteiras (fronteira de Markowitz)
- **Excel:** planilhas de apoio com exemplos de risco de mercado, correlação, Markowitz, risco de crédito, risco operacional, fluxos de caixa e riscos, análise de sensibilidade e cenários

---

## 📊 Dataset e Arquivos Utilizados em Aula

- **COTACOES.xlsx:** cotações de ativos B3 (coluna 1 = data; demais colunas = preços de fechamento), usado pelo script Python de Markowitz.
- **AULA ANALYTICS PARA GESTAO DE RISCOS (e sua versão "Solução"):** planilhas com abas: Risco e Volatilidade, Correlação, Markowitz, Cotações-Carteira, Risco Crédito, Risco Operacional, Fluxos de Caixa e Riscos, Análise Sensibilidade, Resumo do cenário, Exemplo Prob (Poisson) e Campanha Marketing.
- **Script Python:** `Aula Analytics e Gestao de Riscos 2025.py` — Markowitz/fronteira eficiente, simulação Monte Carlo de portfólios e do VPL, e diagrama Tornado.

---

## 💡 Conceitos-Chave para Memorizar

1. **Retorno discreto x contínuo:** $R_t = P_t/P_{t-1} - 1$ x $R_t = \ln(P_t/P_{t-1})$.
2. **Risco de carteira depende da correlação:** correlação negativa entre ativos reduz o risco da carteira (diversificação); Markowitz (1952) formalizou essa lógica na Teoria Moderna de Carteiras.
3. **Índice de Sharpe:** $\text{Sharpe} = (\mu_p - r_f)/\sigma_p$ — usado para achar a carteira tangente (máximo Sharpe) na fronteira eficiente.
4. **Risco de Crédito = b × EC × PD** (ou × (1−t)); componentes: PD (probabilidade de default), EAD/EC (exposição no default) e LGD (perda dado o default).
5. **Basileia:** Basileia 1 (1988, risco de crédito) → risco de mercado (1996) → Basileia 2 (2004, risco operacional) → PR/PRE (2007) → Basileia 2,5 (2009) → Basileia 3 (2010). Índice = Capital/(Risco Mercado + Risco Crédito) ≥ 8%.
6. **Risco Operacional:** baseado em frequência × severidade das perdas; VaR Operacional = Pior Perda − Perda Esperada Média.
7. **VPL determinístico via EBITDA → EBIT → NOPAT → FCO**, descontado pela taxa de retorno esperada/custo de oportunidade.
8. **Análise de sensibilidade e Tornado:** identificam quais premissas mais impactam o VPL.
9. **Simulação de Monte Carlo (Triangular/PERT/Normal):** gera distribuição de VPLs, permitindo calcular P5, P50, P95 e P(VPL>0 ou <0).
10. **Cenários com probabilidades (Excel):** permitem calcular VPL Esperado, Risco (variância) e CV (coeficiente de variação).

---

## 📚 Materiais de Apoio e Referências Bibliográficas (indicadas em aula)

- FÁVERO, Luiz Paulo; BELFIORE, Patrícia. **Análise de dados: estatística e modelagem multivariada com Excel, SPSS, Stata, R e Python.** 2. ed. Gen, LTC, 2024.
- LIMA, Fabiano Guasti. **Análise de Riscos.** 3. ed. São Paulo: Atlas, 2023.
- MARKOWITZ, Harry. **Portfolio Selection.** The Journal of Finance, v. 7, n. 1, p. 77-91, mar. 1952.

### Vídeos indicados em aula

- "Hear What Dr. Harry Markowitz, A Superhero Of Modern Economics, Has To Say About Investing" — entrevista de 21/03/2019.
- "IFA.com with Mark Hebner - An Hour with Harry Markowitz, Father of Modern Portfolio Theory" — entrevista de 19/06/2020.

### Fonte de dados citada em aula

- BCB — Relatório de Estabilidade Financeira (REF), Nov/24 (gráficos de probabilidade de default do estoque de crédito por porte de empresa e por modalidade).
- Economática (cotações jan/2010-set/2019, usadas nos exemplos de correlação Ibovespa x Dólar e PETR4 x VALE3).

---

## ✅ Checklist de Estudo

- [ ] Calcular retorno discreto e contínuo de um ativo
- [ ] Calcular retorno e risco de uma carteira de 2 ativos (fórmula com correlação/covariância)
- [ ] Explicar o efeito da correlação negativa na redução do risco de carteira
- [ ] Montar a fronteira eficiente de Markowitz em Python (mínimo risco e carteira tangente)
- [ ] Rodar simulação Monte Carlo de portfólios (pesos aleatórios via Dirichlet)
- [ ] Definir PD, EAD/EC e LGD e calcular a Perda de Crédito (b × EC × PD)
- [ ] Diferenciar Perda Esperada, Perda Não Esperada e Perda Excepcional
- [ ] Listar a linha do tempo dos Acordos de Basileia (I, mercado, II, PR/PRE, 2,5, III)
- [ ] Calcular o Índice da Basileia (PR/APR) a partir de ativos ponderados pelo risco
- [ ] Explicar risco operacional via distribuição de frequência × severidade e VaR Operacional
- [ ] Montar um fluxo de caixa determinístico (EBITDA → EBIT → NOPAT → FCO) e calcular o VPL
- [ ] Rodar simulação de Monte Carlo do VPL com distribuição triangular e interpretar P5/P50/P95
- [ ] Construir um diagrama Tornado para identificar variáveis críticas
- [ ] Calcular VPL Esperado, Risco (variância) e CV a partir de cenários com probabilidades

---

**Curso:** MBA em Data Science e Analytics - USP/ESALQ
**Módulo:** 10 - Analytics e Gestão de Riscos
**Professor:** Prof. Fabiano Guasti Lima
