# 📖 Dicionário de Data Science — MBA USP/ESALQ

Verbetes de **algoritmos, modelos, testes e conceitos** vistos nas 27 disciplinas do curso.
Cada definição reflete o que foi apresentado em aula (slides, scripts e materiais complementares),
com a indicação do módulo de origem — não é conteúdo genérico da área.

**Fonte:** os arquivos `Resumo_*.md` de cada pasta deste repositório.

> 🗺️ Versão visual: [MAPAS_MERMAID.md](MAPAS_MERMAID.md) — 23 diagramas com os fluxos de decisão
> (qual modelo usar, qual teste aplicar, como diagnosticar, como levar para produção).

## Legenda

| Tag | Significado |
|---|---|
| `ALG` | Algoritmo ou procedimento |
| `MOD` | Modelo / técnica de modelagem |
| `TESTE` | Teste estatístico ou de hipótese |
| `MÉT` | Métrica, critério ou estatística |
| `DIST` | Distribuição de probabilidade |
| `CONC` | Conceito |
| `FERR` | Ferramenta, biblioteca ou tecnologia |
| `M##` | Módulo de origem (pasta do repositório) |

> Ordenação alfabética pelo termo como ele é escrito. Use **Ctrl+F** para busca direta.

---

## Índice por categoria

**Algoritmos e procedimentos** — Algoritmo Genético · AHP · AHP-Gaussiano · Box-Cox · Crossover · Elbow · Encadeamento (single/complete/average) · Elitismo · K-means · Label Propagation · Louvain · MapReduce · Método Simplex · Monte Carlo · Mutação · NSGA-II · OLS · Roleta · Rotação Varimax · Seleção por torneio · Spin Glass · Stepwise · TF-IDF · Walktrap

**Modelos e técnicas de modelagem** — ANACOR · AR · ARIMA · ARMA · Análise de Cluster · Análise Fatorial / PCA · Binomial Negativa (NB2) · DEA · Decomposição de séries temporais · DICE · Drift · ELECTRE · ETS · Growth Model · HLM2 · HLM3 · Holt · Holt-Winters · MA · Markowitz · MCA (ACM) · Mean · Modelo nulo · Naive · Naive Sazonal · PL / PLI / PLIM / PNL · Poisson · PROMETHEE · Regressão linear simples e múltipla · Regressão logística binária · Regressão logística multinomial · SARIMA · SES · THOR · TOPSIS · ZIP · ZINB

**Testes** — ADF (Dickey-Fuller Aumentado) · ANOVA (teste F) · ARCH · Bartlett (esfericidade) · Breusch-Pagan · Cameron e Trivedi (superdispersão) · Jarque-Bera · Kolmogorov-Smirnov · KPSS · Ljung-Box · LR test (razão de verossimilhança) · Phillips-Perron · Qui-quadrado (aderência e associação) · Shapiro-Francia · Shapiro-Wilk · Teste F (variâncias) · Teste t (média, duas amostras, correlação) · Teste Z · Vuong

**Métricas e critérios** — Acurácia · AIC · AIQ · Assimetria · AUC · Betweenness · BIC · Closeness · Coeficiente de clustering · Coeficiente de variação · Correlação de Pearson · Covariância · Critério de Kaiser · CR (Razão de Consistência) · Curtose · Densidade · Desvio padrão · Diâmetro · Erro padrão · Especificidade · Excentricidade · FAC (ACF) · FACP (PACF) · GINI · Grau · ICC · Índice de Basileia · Índice de Sharpe · Log-Likelihood · MAE · MAPE · Matriz de confusão · ME · Média · Mediana · Moda · Modularidade · MPE · Odds Ratio · Percentis e Quartis · Pseudo R² McFadden · R² · R² ajustado · RMSE · Sensitividade · Silhueta · Theil's U · Tolerância · Variância · VaR Operacional · VIF · VPL · WCSS

**Distribuições** — Bernoulli · Binomial · Binomial Negativa · F de Snedecor · Normal · Poisson · Poisson-Gama · Qui-quadrado · t de Student · Triangular · Uniforme discreta

**Ferramentas e tecnologias** — auto_arima · Avro · BeautifulSoup · Databricks · factor_analyzer · Gephi · Hadoop · HDFS · Iceberg · igraph · Kafka · Kubernetes · MLflow · MLlib · MySQL · pandas · Parquet · Power BI · prince · pygad · Spark · Spark SQL · spaCy · statstests · YARN

---

## A

- **ABSA (Aspect-Based Sentiment Analysis)** `CONC` `M26` — Análise de sentimentos no **nível de aspecto**: em vez de um rótulo único para o texto inteiro, identifica os aspectos (características, entidades, tópicos) e atribui uma polaridade a cada um. Exemplo da aula: *"O atendimento foi excelente, mas a comida demorou"* → atendimento = positivo, comida = negativo.
- **ACID** `CONC` `M7` — Garantias de bancos relacionais: **A**tomicidade, **C**onsistência, **I**solamento e **D**urabilidade. Ideal para transações financeiras. Contraponto: modelo BASE dos bancos NoSQL.
- **ACM** → ver **MCA (Análise de Correspondência Múltipla)**.
- **Acurácia** `MÉT` `M19` — (TP+TN)/Total — taxa geral de acertos de um classificador. ⚠️ Pode enganar em classes desbalanceadas.
- **ADF (Teste de Dickey-Fuller Aumentado)** `TESTE` `M23` — Testa estacionariedade. **H₀:** a série **não** é estacionária (possui raiz unitária); **H₁:** é estacionária. Usa-se a versão *aumentada* porque não se sabe a priori quantos termos de diferenças defasadas incluir. Python: `statsmodels.tsa.stattools.adfuller`.
- **AHP (Analytic Hierarchy Process)** `MOD` `M13` — Método multicritério de Saaty (1977) baseado em Matemática e Psicologia: define objetivo → critérios → alternativas, com **comparação par a par** na escala de 1 a 9, gerando um vetor prioridade (pesos). Exige teste de consistência (CR < 10%). Ganhos: transparência, lisura, rastreabilidade e replicabilidade. Limitações: funciona bem até ~7-15 critérios; nº de comparações cresce em n(n−1)/2; desgaste cognitivo do decisor; pesos subjetivos.
- **AHP-Gaussiano** `ALG` `M13` — Variante do AHP (Santos et al., 2021) em que os pesos dos critérios são obtidos **automaticamente da dispersão dos dados**, sem comparação par a par e sem teste de consistência. 8 etapas: matriz de decisão → normalização → transposição → média → desvio padrão → **Fator Gaussiano (CV)** → normalização do FG (peso) → agregação. Critério com maior variação relativa recebe maior peso, pois discrimina melhor as alternativas.
- **AIC (Akaike Information Criterion)** `MÉT` `M18` `M23` — Estima a quantidade relativa de informação perdida por um modelo. **Quanto menor, melhor**; serve apenas para comparação relativa entre modelos. Usado para escolher automaticamente a melhor configuração ETS e ordens ARIMA.
- **AIQ (Amplitude Interquartil)** `MÉT` `M1` — AIQ = Q3 − Q1. Usada para identificar **outliers univariados** (representada no boxplot): valor < Q1 − 1,5·AIQ ou > Q3 + 1,5·AIQ.
- **Algoritmo Genético (AG)** `ALG` `M6` — Meta-heurística inspirada na evolução biológica (seleção natural, herança, variação). Fluxo: população inicial aleatória → avaliar fitness → selecionar pais → crossover → mutação → nova geração → repetir até o critério de parada. Componentes fundamentais: **representação, função de fitness, operadores genéticos e critério de parada**. Parâmetros típicos: população 50-500, crossover 0,6-0,9, mutação ≈ 1/L, 100-10.000 gerações. Biblioteca da aula: `pygad`.
- **Amplitude** `MÉT` `M1` — Diferença entre o valor máximo e o mínimo do conjunto de dados.
- **ANACOR (Análise de Correspondência Simples)** `MOD` `M16` — Técnica não supervisionada para estudar a associação entre **duas variáveis categóricas** e suas categorias. Duas etapas: (1) teste qui-quadrado de significância da associação; (2) elaboração e interpretação do **mapa perceptual**. Python: `prince.CA()`.
- **Análise de Cluster** `MOD` `M14` — Técnica exploratória (não supervisionada) que agrupa **observações** em grupos homogêneos internamente e heterogêneos entre si, com base em **medidas de distância** entre variáveis métricas. Não tem caráter preditivo para fora da amostra; se observações ou variáveis mudarem, o agrupamento deve ser refeito. Muito sensível a outliers. Dois métodos vistos: hierárquico aglomerativo e K-means.
- **Análise de Correspondência** → ver **ANACOR** (simples) e **MCA** (múltipla).
- **Análise de Sensibilidade** `CONC` `M10` — Estuda o efeito que a variação de uma premissa de entrada causa nos resultados. Quando uma pequena variação em um parâmetro altera drasticamente a rentabilidade, o projeto é "muito sensível" àquele parâmetro — indicando onde vale reduzir a incerteza dos dados. Visualização: **diagrama Tornado**.
- **Análise de Sentimentos** `CONC` `M26` — Combina NLP e Aprendizado de Máquina para extrair emoções, atitudes e opiniões em texto. **Não é uma técnica única, mas um processo** com decisões de granularidade, algoritmo (léxico / ML clássico / Deep Learning) e métrica. Princípio central da aula: *"qualidade do dado > qualquer algoritmo de ponta"*.
- **Análise Envoltória de Dados (DEA)** `MOD` `M13` — Área da Pesquisa Operacional voltada à avaliação da **eficiência relativa entre unidades**.
- **Análise Fatorial** `MOD` `M15` — Técnica não supervisionada que agrupa **variáveis métricas** em fatores, a partir das correlações de Pearson entre elas. Finalidades: redução estrutural, análise de construtos, elaboração de rankings e criação de fatores ortogonais para uso posterior em modelos supervisionados. Não tem caráter preditivo fora da amostra.
- **Análise: os quatro tipos** `CONC` `M7` — **Descritiva** ("o que aconteceu?" — agregação, relatórios); **Diagnóstica** ("por que aconteceu?" — detalhamento, correlações, causa raiz); **Preditiva** ("o que vai acontecer?" — modelagem estatística e ML); **Prescritiva** ("o que devemos fazer?" — otimização, simulação, IA).
- **Anonimização** `CONC` `M12` — Um dos direitos do titular na LGPD (Art. 18), ao lado de bloqueio e eliminação dos dados.
- **ANOVA (Teste F de um fator)** `TESTE` `M14` — Usado **após a clusterização** para verificar se a variabilidade entre grupos supera a variabilidade dentro dos grupos. F = variabilidade entre grupos / variabilidade dentro dos grupos; g.l. = K−1 (numerador) e n−K (denominador). **H₀:** a variável tem a mesma média em todos os clusters; **H₁:** média diferente em pelo menos um. A variável mais discriminante é a de **maior estatística F** significante. Python: `pingouin.anova`.
- **ANPD (Autoridade Nacional de Proteção de Dados)** `CONC` `M12` `M3` — Órgão responsável por zelar, implementar e fiscalizar o cumprimento da LGPD no Brasil, por meio de conscientização e fiscalização.
- **APR (Ativo Ponderado pelo Risco)** `CONC` `M10` — Soma dos ativos multiplicados por seus pesos de risco (Basileia 1): 0% para caixa e créditos de bancos centrais, 20% para bancos multilaterais, 50% para crédito com garantia residencial, 100% para empréstimos a empresas. Base do denominador do Índice da Basileia.
- **AR (modelo autorregressivo)** `MOD` `M23` — Componente do ARIMA que avalia a relação entre períodos (lags) — autocorrelação. AR(1) = ARIMA(1,0,0). A ordem **p** é identificada pela **PACF**.
- **ARCH (teste de efeitos)** `TESTE` `M23` — Verifica heterocedasticidade condicional nos resíduos. **H₀:** não existe efeito ARCH; **H₁:** existe. Python: `arch.arch_model(residuals, vol='ARCH', p=1)`.
- **ARIMA(p,d,q)** `MOD` `M23` — Família Box-Jenkins: **AR** (autorregressivo, relação entre lags) + **I** (integrado, diferenciação para tornar a série estacionária) + **MA** (médias móveis, avalia os erros entre períodos). Requer dados estacionários. Filosofia: *"nos modelos ARIMA os dados falam por si mesmo"*. Identificação: **p** ← PACF, **d** ← teste de estacionariedade/`ndiffs`, **q** ← ACF.
- **ARMA(p,q)** `MOD` `M23` — Combinação de autorregressivo e médias móveis, sem diferenciação: ARMA(1,1) = ARIMA(1,0,1). Padrão típico: ACF **e** PACF decaem suavemente.
- **Arquitetura Medalhão (Medallion Architecture)** `CONC` `M22` — Três camadas dentro do Lakehouse: **Bronze** (ingestão bruta e histórico) → **Silver** (dados filtrados, limpos e enriquecidos) → **Gold** (agregações no nível de negócio), sustentadas por uma camada transversal de Data Quality & Governance.
- **Assimetria** `MÉT` `M1` — Medida de forma. Curva simétrica: média = mediana = moda; assimétrica à direita: média > mediana; à esquerda: média < mediana. Coeficiente de Fisher (g₁): g₁ = 0 simetria, g₁ > 0 assimetria positiva, g₁ < 0 negativa.
- **AUC (Area Under the Curve)** `MÉT` `M19` — Área sob a curva ROC, entre 0 e 1. **0,5** = modelo aleatório (linha diagonal); **> 0,8** = excelente discriminação. Python: `sklearn.metrics.auc`.
- **Autovalor (λ)** `CONC` `M15` `M16` — Raízes da equação característica det(ρ − λ·I) = 0 da matriz de correlações. **Mostram o percentual da variância compartilhada** pelas variáveis originais na formação de cada fator — a quantidade de informação explicada por cada fator. Na análise de correspondência, referem-se às **inércias principais parciais**.
- **Autovetor** `CONC` `M15` — Vetor obtido para cada autovalor. Contém as combinações das variáveis originais que expressam os principais **padrões de correlação** nos dados: como as variáveis se comportam juntas e os contrastes entre elas (dimensões latentes).
- **auto_arima** `FERR` `M23` — Função do pacote `pmdarima` que busca automaticamente as ordens (p,d,q) e sazonais (P,D,Q,s) do melhor ARIMA/SARIMA por critério de informação. Também usado `pm.arima.ndiffs()` para descobrir quantas diferenciações são necessárias.
- **Avro** `FERR` `M7` — Formato binário **orientado a linhas**, projetado para minimizar latência de gravação (usado em streaming). Contrapõe-se ao Parquet, colunar e melhor para leitura analítica.

---

## B

- **Bartlett (Teste de Esfericidade)** `TESTE` `M15` — Avalia a **adequação global** da análise fatorial, comparando a matriz de correlações com a matriz identidade de mesma dimensão. **H₀:** ρ = I; **H₁:** ρ ≠ I. Espera-se **rejeitar H₀** para que a análise fatorial seja aplicável. χ² com k(k−1)/2 graus de liberdade. Python: `factor_analyzer.calculate_bartlett_sphericity`.
- **BASE** `CONC` `M7` — Modelo dos bancos NoSQL, que prioriza **disponibilidade e velocidade** sobre consistência imediata (consistência eventual). Contraponto ao ACID dos relacionais.
- **Basileia (Acordos)** `CONC` `M10` — Linha do tempo: **1988** Basileia 1 (capital para risco de crédito) → **1996** (risco de mercado) → **2004** Basileia 2 (risco operacional) → **2007** (PR e PRE) → **2009** Basileia 2,5 (securitizações) → **2010** Basileia 3. Formulados pelo Comitê de Basileia (BCBS), sediado no BIS.
- **BeautifulSoup (bs4)** `FERR` `M25` — Biblioteca Python para analisar e extrair informações de HTML, transformando a página em objetos Python navegáveis por **tags, classes, IDs e conteúdos**. O nome é homenagem a *Alice no País das Maravilhas*.
- **Bernoulli** `DIST` `M1` — Variável com apenas dois resultados possíveis (sucesso x=1, fracasso x=0): P(X = x) = pˣ·(1−p)^(1−x). Compõe os modelos inflacionados de zeros.
- **Betweenness (Intermediação)** `MÉT` `M8` — Número de caminhos curtos que passam por um nó. Mede **controle do fluxo de informação**; nós com alta intermediação são *brokers* / *gatekeepers* que conectam diferentes partes da rede. Python: `g.betweenness()`.
- **BI (Business Intelligence)** `CONC` `M3` — Transformar dados em informações úteis que contribuam com decisões estratégicas. Fases: **ETL → Modelagem de dados → Visualização → Publicação**. Pipeline da aula: Identificação → Coleta → Limpeza → Transformação → Modelagem → Armazenamento → Análise e Visualização.
- **BIC (Bayesian Information Criterion)** `MÉT` `M18` `M23` — Critério de informação para comparar modelos; **menor BIC = melhor ajuste**. Como o AIC, só tem valor comparativo.
- **Big Data** `CONC` `M22` — Conjuntos de dados extremamente grandes e complexos que **não podem ser processados com ferramentas tradicionais**. Escala: 1 exabyte = 1.073.741.824 GB; 1 zettabyte = 1.024 exabytes. Ver **5V's** (Volume, Velocidade, Variedade, Veracidade, Valor).
- **Binomial** `DIST` `M1` — n repetições independentes de Bernoulli com p constante: P(X = k) = C(n,k)·pᵏ·(1−p)^(n−k).
- **Binomial Negativa** `DIST` `MOD` `M1` `M20` — (M1) Quantidade de ensaios necessários até obter k sucessos. (M20) Distribuição **Poisson-Gama**, base do modelo **NB2** para dados de contagem com **superdispersão**: E(Y) = λ, Var(Y) = λ·(1 + α·λ) — a variância cresce com o quadrado da média. Parâmetros: θ (forma) e δ (taxa de decaimento); α (fi) = 1/θ é o parâmetro de superdispersão. Python: `sm.NegativeBinomial.from_formula`.
- **Box-Cox (transformação)** `ALG` `M18` — Transformação de potência em Y para linearizar a relação e normalizar os resíduos: **Y\* = (Y^λ − 1)/λ**. λ=1 sem transformação, λ=0,5 raiz quadrada, λ→0 logaritmo natural, λ=−1 inverso. **Reversão obrigatória nas predições:** Y = (Y\*·λ + 1)^(1/λ). ⚠️ Os coeficientes do modelo Box-Cox **não** são comparáveis aos do modelo linear. Python: `scipy.stats.boxcox`.
- **Box-Jenkins (metodologia)** `CONC` `M23` — Três etapas para modelos ARIMA: **Identificação** (descobrir p e q via correlograma ACF e parcial PACF) → **Estimação** (estimar os parâmetros) → **Checagem** (verificar se os resíduos são ruído branco; se não, reiniciar o processo).
- **Breusch-Pagan (teste)** `TESTE` `M18` — Diagnóstico de heterocedasticidade em regressão. **H₀:** ausência de heterocedasticidade (homocedasticidade); **H₁:** presença. p > 0,05 → OK. Causas comuns de rejeição: omissão de variável relevante (a mais comum), forma funcional incorreta, outliers, erro de especificação.
- **Burt (matriz de)** `CONC` `M16` — B = Z'·Z, onde Z é a matriz binária. Combina em uma única matriz o cruzamento de todos os pares de variáveis/categorias; tratada como tabela de contingência, gera as **coordenadas principais** da MCA.

---

## C

- **Cameron e Trivedi (teste de superdispersão)** `TESTE` `M20` — Verifica se a propriedade média = variância (equidispersão) da Poisson se sustenta. Passos: estimar Poisson → criar Y\*ᵢ = [(Yᵢ − λ̂ᵢ)² − Yᵢ]/λ̂ᵢ → estimar OLS auxiliar `Y* ~ 0 + lambda_poisson` **sem intercepto** → avaliar a significância de β. **p > 0,05** → equidispersão (Poisson adequado); **p ≤ 0,05** → superdispersão (usar Binomial Negativa). Python: `statstests.tests.overdisp`.
- **Cargas fatoriais** `CONC` `M15` — Correlações de Pearson entre os fatores e as variáveis originais. Interpretadas como a importância de cada variável original na constituição do fator: quanto maior a carga, mais o fator é influenciado por aquela variável. Visualização: **loading plot**.
- **Carteira de mínimo risco** `CONC` `M10` — Carteira da fronteira eficiente com a menor volatilidade possível. Python: `EfficientFrontier(...).min_volatility()`.
- **Carteira tangente** `CONC` `M10` — Carteira que **maximiza o Índice de Sharpe**, ou seja, o ponto de tangência entre a fronteira eficiente e a reta que parte da taxa livre de risco. Python: `EfficientFrontier(...).max_sharpe(risk_free_rate=rf)`.
- **Catalyst Optimizer** `FERR` `M22` `M7` — Otimizador automático de consultas do Spark SQL (junto do motor de execução Tungsten).
- **CCPA (California Consumer Privacy Act, 2020)** `CONC` `M12` — Lei estadual de privacidade mais abrangente dos EUA; garante aos residentes da Califórnia o direito de saber quais dados são coletados e de solicitar sua exclusão.
- **CDC (Change Data Capture)** `CONC` `M7` — Captura modificações (INSERT/UPDATE/DELETE) em tempo real e as envia a sistemas posteriores, em vez de copiar periodicamente o dataset inteiro. Métodos: **baseado em log** (lê o log de transações nativo — WAL do PostgreSQL, Binlog do MySQL; baixo impacto), **baseado em gatilhos** (pode gerar sobrecarga) e **baseado em consulta** (pode perder alterações intermediárias e não captura DELETEs).
- **Centroide** `CONC` `M14` — Centro de aglomeração de um cluster no K-means, calculado como a **média** dos pontos do grupo; recalculado iterativamente até não haver mais realocações. Python: `kmeans.cluster_centers_`.
- **Ceteris paribus** `CONC` `M18` — "Mantidas as demais condições constantes". É como se interpreta cada coeficiente de uma regressão múltipla: efeito de X₁ sobre Y mantendo as outras variáveis fixas.
- **Chave primária / Chave estrangeira** `CONC` `M4` — *Primary key*: identificador único da linha (`id int auto_increment primary key`). *Foreign key*: define o relacionamento entre tabelas (`foreign key (autor_id) references autores(id)`).
- **Ciclo (componente de série temporal)** `CONC` `M23` — Flutuações de longo prazo, similares às sazonais, mas com padrão que se repete **sem período fixo** — difíceis de identificar sem uma série longa.
- **Ciclo de vida da análise de dados** `CONC` `M7` — Seis etapas: **Coletar** → **Processar** → **Armazenar** → **Analisar** → **Ativar** (colocar os insights em ação) → **Empoderar** (compartilhar com as partes interessadas).
- **Ciclo de vida de modelos de ML** `CONC` `M22` — Coleta e preparação de dados → treinamento e validação → deploy em produção → monitoramento contínuo → atualização e re-treinamento → **aposentadoria** de modelos desatualizados.
- **CI/CD** `CONC` `M7` — **Integração Contínua**: mesclar as cópias de trabalho dos desenvolvedores em uma linha principal várias vezes ao dia. **Entrega Contínua**: produzir um entregável em ciclos curtos, garantindo que o software possa ser lançado a qualquer momento. Pipeline da aula: merge → build → teste → teste de segurança → verificação de políticas → artifact storage → deployment → monitoramento.
- **Closeness (Proximidade)** `MÉT` `M8` — Inverso da soma das distâncias de um nó a todos os outros. Mede quão rápido a informação chega ao nó; valor alto = nó central. Usar `normalized=True` para comparabilidade entre redes.
- **Cloud Computing** `CONC` `M7` — Entrega de serviços de computação (servidores, armazenamento, software) pela internet, com pagamento sob demanda. Analogia da aula: é como a energia elétrica — você não constrói uma usina, apenas se conecta e paga pelo que usa. Troca **CAPEX por OPEX**.
- **Cluster (de computadores)** `CONC` `M22` — Estrutura com um **Node Master** coordenando múltiplos nós que processam em paralelo. Base de Hadoop e Spark.
- **Coeficiente de Clustering** `MÉT` `M8` — Proporção de conexões existentes entre os vizinhos de um nó (triângulos conectados / triplos conectados). Valor alto = vizinhos bem conectados entre si. Python: `g.transitivity_local_undirected()`.
- **Coeficiente de Variação (CV)** `MÉT` `M1` `M10` `M13` — CV = (S / X̄) × 100. Medida de **dispersão relativa**: quanto menor, mais homogêneos os valores. Reaparece como medida de risco relativo ao retorno (M10) e como o **Fator Gaussiano** do AHP-Gaussiano (M13).
- **Comunalidades** `CONC` `M15` — Variância total compartilhada, **por variável**, em todos os fatores extraídos e selecionados. Permitem avaliar quanta informação de cada variável original foi retida após aplicar o critério de Kaiser. **Não se alteram** com a rotação Varimax.
- **Comunidade (rede)** `CONC` `M8` — Grupo de nós densamente conectados entre si. A qualidade da divisão é medida pela **modularidade**. Algoritmos vistos: Edge Betweenness, Fast Greedy, Walktrap, Louvain (Multilevel), Label Propagation e Spin Glass.
- **Complexity Leadership** `CONC` `M11` — Modelo (Humberto Mariotti) que separa o **lado administrativo** (formal, convencional, produz eficiência, narrativas lineares) do **lado adaptativo** (informal, criativo, produz inovação, **antenarrativas** e histórias organizacionais). Premissa: burocracia em excesso limita a criatividade; criatividade em excesso limita a eficiência.
- **Contêiner** `CONC` `M7` — Forma leve de virtualização que empacota código e dependências, compartilhando o *container runtime* sobre o mesmo SO (Docker), orquestrada pelo Kubernetes.
- **Controlador (LGPD)** `CONC` `M12` — Pessoa ou entidade que toma as **decisões** sobre o tratamento de dados (o quê, por quê, como). Distinto do **Operador**, que trata os dados em nome do controlador seguindo instruções.
- **Correlação de Pearson (r)** `MÉT` `M1` `M15` — Mede a relação **linear** entre duas variáveis métricas: r = cov(X,Y)/(S_X·S_Y), variando de −1 a 1. r = 0 indica ausência de correlação linear. Significância testada por t = r / √[(1−r²)/(n−2)], com n−2 g.l. É o fundamento da Análise Fatorial PCA.
- **Correlograma** `CONC` `M23` — Gráfico da FAC(k) contra k. O correlograma (ACF) e o correlograma parcial (PACF) são as ferramentas de identificação de p e q no Box-Jenkins.
- **Covariância** `MÉT` `M1` — cov(X,Y) = Σ(Xᵢ−X̄)(Yᵢ−Ȳ)/(n−1). Passo inicial do cálculo da correlação de Pearson e base da **matriz de covariância** usada no risco de carteiras.
- **CR (Razão de Consistência)** `MÉT` `M13` — CR = CI/RI, onde CI = (λmáx − n)/(n−1) e RI é o Índice Aleatório de Saaty (n=3 → 0,58; n=4 → 0,90; n=5 → 1,12...). **CR < 10%** → julgamentos consistentes; CR ≥ 10% → revisar as comparações par a par (violação de transitividade).
- **CRISP-DM** `CONC` `M22` `M24` — *Cross-Industry Standard Process for Data Mining*: Entendimento do Negócio ⇄ Entendimento dos Dados → Preparação dos Dados → Modelagem → Avaliação → Deployment, com os dados ao centro. O **Data Wrangling** corresponde às fases de Data Understanding e Data Preparation.
- **Critério de Kaiser (Raiz Latente)** `MÉT` `M15` — Retém apenas os fatores com **autovalor > 1**, pois um autovalor > 1 significa que o fator explica mais variância do que uma variável original isolada. Automatizável: `sum(autovalores > 1)`.
- **Crossover (recombinação)** `ALG` `M6` — Operador genético que combina dois pais. Tipos: **one-point**, **two-point**, **uniform** (cada gene vem de um pai com 50% de chance), **aritmético** (para representação real: filho = α·pai1 + (1−α)·pai2) e **PMX** (para permutações, mantém a ordem relativa e evita duplicatas).
- **CTE (Common Table Expression)** `CONC` `M4` — Bloco nomeado com `WITH` que torna consultas complexas mais legíveis. A **CTE recursiva** (`WITH RECURSIVE`) resolve hierarquias e sequências.
- **Curtose** `MÉT` `M1` — Achatamento da curva em relação à normal: mesocúrtica, platicúrtica ou leptocúrtica. Coeficiente de Fisher (g₂): g₂ = 0 normal, g₂ > 0 alongada, g₂ < 0 achatada.
- **Curva ROC** `MÉT` `M19` — *Receiver Operating Characteristic*: eixo X = 1 − Especificidade (taxa de falsos positivos), eixo Y = Sensitividade (taxa de verdadeiros positivos). A área sob ela é o **AUC**.
- **Cutoff (ponto de corte)** `CONC` `M19` — Limiar de probabilidade que converte o `phat` em classe predita (padrão 0,5). Cutoff **baixo** (0,3) → ↑ sensitividade, ↓ especificidade; cutoff **alto** (0,7) → o inverso.
- **Cynefin** `CONC` `M5` — Framework para classificar contextos organizacionais e determinar a abordagem de gestão adequada a cada um.

---

## D

- **DAG (Directed Acyclic Graph)** `CONC` `M22` `M7` — Representação gráfica das operações do Spark: **direcionado** (arestas indicam a sequência) e **acíclico** (dados não voltam ao mesmo ponto). Permite ao Spark otimizar a execução dividindo tarefas em *stages* e paralelizando.
- **Dados de contagem** `CONC` `M20` — Variável dependente **quantitativa, discreta e não negativa**, sempre associada a uma **exposição** (unidade temporal, espacial, social). Exemplos: nº de consultas médicas por ano, nº de IPOs por país em um ano. ⚠️ Usar OLS nesses casos é erro comum.
- **Dados pessoais / sensíveis** `CONC` `M12` — *Pessoais*: qualquer informação referente a pessoa física identificada ou identificável. *Sensíveis*: revelam origem racial ou étnica, convicção religiosa, opinião política, filiação sindical, dados de saúde, biometria ou dados genéticos.
- **Dado, informação e insight** `CONC` `M7` — **Dado**: fatos e números brutos, sem contexto. **Informação**: dados processados e organizados. **Insight**: entendimento que orienta decisões. Daí a metáfora "dados são o novo petróleo" — o valor está no refino.
- **Data as a Product (DaaP)** `CONC` `M7` — Tratar conjuntos de dados como produto: **descobrível, endereçável, confiável (com SLOs claros), compreensível (autodescritivo), seguro e valioso por si só**. Muda o foco de pipelines/tecnologia para valor ao consumidor e de qualidade como reflexão tardia para qualidade como característica principal.
- **Data drift** `CONC` `M22` — Mudança na distribuição dos dados ao longo do tempo, degradando a performance do modelo **em produção** sem que ninguém perceba. Principal justificativa do monitoramento pós-deployment.
- **Data Lake** `CONC` `M22` — Repositório que recebe dados estruturados, semiestruturados e não estruturados, servindo (após ETL) BI, Reports, Data Science e ML.
- **Data Lakehouse** `CONC` `M22` — Unifica Data Warehouse e Data Lake: os três tipos de dados alimentam um Data Lake com **camada de metadados e governança**, servindo diretamente BI, Reports, Data Science e ML — sem duplicação em warehouses separados.
- **Data Warehouse** `CONC` `M22` `M3` — Arquitetura clássica: dados **estruturados** → ETL → Data Warehouse → BI e Reports. Um dos pilares técnicos do Self Service Analytics.
- **Data Wrangling** `CONC` `M24` — Transformar a base de sua estrutura original (dados brutos) para uma estrutura que permita extrair informações. Três atividades comuns: **coleta/importação**, **junção** (via variáveis-chave) e **transformação** (limpeza, criação/alteração de variáveis, seleção, agregação). **Não é atividade padronizada** — depende do contexto. Ocorre antes da EDA e da modelagem.
- **Data Wrangling — as 6 etapas (HBS)** `CONC` `M24` — **Discovery** (familiarizar-se com os dados) → **Structuring** (transformar o bruto em utilizável) → **Cleaning** (remover erros que distorceriam a análise) → **Enriching** (decidir se enriquece/complementa) → **Verifying** (confirmar consistência e qualidade) → **Publishing** (disponibilizar para análise).
- **Databricks** `FERR` `M22` — Plataforma unificada de dados e IA (Lakehouse) onde o MLflow se integra nativamente; um dos destinos de `mlflow deployments` (Databricks Model Serving). Aula prática usou a Free Edition com Unity Catalog (`spark.table(...).toPandas()`).
- **DEA** → ver **Análise Envoltória de Dados**.
- **Debate x Diálogo** `CONC` `M11` — *Debate* tem a raiz de "derrotar", mesma origem de percussão/concussão ("quebrar coisas"). *Diálogo* vem de "dia" + "logos" = **fluxo de significado** (David Bohm). O diálogo não exige concordância: encoraja a construção de significados compartilhados que conduzem a ação alinhada.
- **Decis** `MÉT` `M1` — Dividem a distribuição ordenada em 10 partes iguais.
- **Decomposição de séries temporais** `MOD` `M23` — Separa a série em **Tendência (T)**, **Ciclo (C)**, **Sazonalidade (S)** e **Erro (E)**. Modelo **aditivo** Y = T+C+S+E (variação sazonal constante) e **multiplicativo** Y = T·C·S·E (variação sazonal cresce com o nível da série). Python: `seasonal_decompose(serie, model='additive', period=12)`.
- **Dendrograma** `CONC` `M14` — Gráfico que mostra o esquema de aglomeração hierárquica, do estágio 0 (n clusters) até um único cluster. A escolha do número de clusters observa o **tamanho dos saltos de distância**: saltos elevados indicam a união de observações mais distintas. Difícil de ler com muitas observações — nesse caso, preferir K-means.
- **Densidade (grafo)** `MÉT` `M8` — Nº de arestas existentes / nº máximo possível de arestas (0 a 1). Alta = rede muito conectada; baixa = rede esparsa. Python: `g.density()`.
- **Desemprego (tipos)** `CONC` `M9` — Taxa = nº de desempregados / PEA. **Friccional** (incompatibilidades, assimetria de informação, rotatividade); **Estrutural** (mecanização agrícola, automação, inteligência artificial); **Conjuntural** (crise, sazonalidade, choque externo). Fontes: PNAD Contínua (IBGE) e CAGED. Conceito relacionado: **NAIRU**.
- **Desvio padrão (S)** `MÉT` `M1` — Raiz quadrada da variância: S = √S². Em finanças, é a medida de **volatilidade** (risco) de um ativo.
- **Diagrama Tornado** `CONC` `M10` — Gráfico de barras horizontais ordenado pelo impacto de cada premissa no VPL (calculando o VPL com a variável no mínimo e no máximo, demais no valor mais provável). Variáveis no topo = mais críticas; orienta onde investir em melhores estimativas.
- **Diâmetro (grafo)** `MÉT` `M8` — Maior caminho curto entre quaisquer dois nós — o "tamanho" da rede. Redes *small-world* têm diâmetro pequeno apesar de muitos nós. Python: `g.diameter()`.
- **DICE Framework** `MOD` `M5` — Calcula as chances de sucesso de uma iniciativa a partir de **D**uration (duração), **I**ntegrity (integridade da equipe e liderança), **C**ommitment (comprometimento da gestão sênior e local) e **E**ffort (esforço além das responsabilidades habituais). Score: **7-14** altas chances, **15-17** preocupante, **18-28** alto risco.
- **Diferenciação** `CONC` `M23` — Subtrair a observação atual da anterior para remover tendência e tornar a série estacionária. Feita 1× (1ª ordem) ou, mais raramente, 2× (2ª ordem) — é o **d** do ARIMA. ⚠️ Sempre **reverter** a diferenciação nas previsões (soma cumulativa a partir do último valor original).
- **Direito Digital** `CONC` `M12` — Ramo do direito que regulamenta as questões jurídicas de TI, internet e ambientes digitais. Características: interdisciplinaridade, dinamismo, globalidade/transnacionalidade, proteção de direitos fundamentais e **flexibilidade normativa** (princípios gerais em vez de regras rígidas — abordagem "tecnologicamente neutra").
- **Dissimilaridade** `CONC` `M14` — Medida de **quanto as observações são diferentes** entre si com base nas variáveis escolhidas. É uma das duas escolhas inerentes ao método hierárquico (a outra é o método de encadeamento). Ver **Distância**.
- **Distância de Canberra** `MÉT` `M14` — d = Σ |ZXjp − ZXjq| / (|ZXjp| + |ZXjq|). Python: `pdist(dados, metric='canberra')`.
- **Distância de Chebychev** `MÉT` `M14` — d = máx |ZXjp − ZXjq| (a maior diferença entre as variáveis). Python: `metric='chebyshev'`.
- **Distância de Manhattan (City Block)** `MÉT` `M14` — d = Σ |ZXjp − ZXjq| (soma das diferenças absolutas). Python: `metric='cityblock'`.
- **Distância euclidiana** `MÉT` `M14` — d = √Σ(ZXjp − ZXjq)². Medida de dissimilaridade mais usada na análise de cluster. Python: `metric='euclidean'`.
- **Distância euclidiana quadrática** `MÉT` `M14` — d = Σ(ZXjp − ZXjq)² (sem a raiz). Python: `metric='sqeuclidean'`.
- **DMCA (1998)** `CONC` `M12` — Lei de Direitos Autorais do Milênio Digital (EUA): criminaliza a produção e disseminação de tecnologia, dispositivos ou serviços destinados a contornar medidas de proteção de direitos autorais.
- **Drift (método de previsão)** `MOD` `M23` — Método simples que acompanha a tendência da série — equivale a traçar uma reta entre o primeiro e o último ponto: previsão = último valor + h·[(último − primeiro)/(n−1)].
- **Dummy (variável)** `CONC` `M18` — Variável binária (0/1) que indica presença/ausência de uma categoria. **Regra n−1**: para k categorias, criar k−1 dummies; a omitida é a **categoria de referência** (evita multicolinearidade perfeita). Interpretação: o intercepto representa a média da referência e cada coeficiente, a diferença média em relação a ela. ⚠️ Nunca codificar categorias com números arbitrários (LabelEncoder), pois cria hierarquia inexistente. Python: `pd.get_dummies(df, columns=[...], drop_first=True)`.

---

## E

- **EAD / EC (Exposição a crédito no default)** `CONC` `M10` — Incerteza quanto ao **valor da exposição** no momento do default. Um dos três direcionadores do risco de crédito, junto de PD e LGD.
- **EBITDA → EBIT → NOPAT → FCO** `CONC` `M10` — Cadeia de cálculo da entrada de caixa operacional: Receitas − Despesas Operacionais = **EBITDA**; − Depreciação = **EBIT** (lucro antes do IR); − IR = **NOPAT**; + Depreciação = **Entrada de Caixa Operacional (FCO)**. Base para o cálculo do VPL.
- **Efeitos fixos x Efeitos aleatórios** `CONC` `M21` — **Fixos** (γ, δ): efeito médio das variáveis explicativas, válido para toda a população de grupos. **Aleatórios** (ν, τ): desvio específico de cada grupo em relação à média geral — não são estimados como coeficientes, mas como **componentes de variância**. Se a variância dos efeitos aleatórios não for estatisticamente diferente de zero, o OLS tradicional bastaria.
- **Elbow (Método do Cotovelo)** `ALG` `M14` — Calcula o **WCSS** para vários valores de K e busca no gráfico a "dobra" — o ponto a partir do qual a redução do WCSS deixa de ser expressiva. Python: `kmean.inertia_` para cada K.
- **ELECTRE** `MOD` `M13` — *Elimination Et Choix Traduisant la Réalité* — método multicritério de apoio à decisão (MCDM).
- **Elitismo** `ALG` `M6` — Operador que garante que os n melhores indivíduos passem para a próxima geração. Acelera a convergência e evita a perda de boas soluções (típico: preservar o top 1-5%).
- **Encadeamento (métodos de)** `ALG` `M14` — Regra que define qual distância considerar quando já existem clusters formados. **Único / Single Linkage** (mínimo — recomendado para observações distintas); **Completo / Complete Linkage** (máximo — para observações parecidas); **Médio / Average Linkage** (média — meio-termo). Python: `sch.linkage(dados, method='complete', metric='euclidean')`.
- **Encarregado (DPO)** `CONC` `M12` — Pessoa designada pelo controlador para atuar como **canal de comunicação** entre controlador, titulares e ANPD.
- **Equidispersão** `CONC` `M20` — Propriedade da distribuição Poisson em que **média = variância** (E(Y) = Var(Y) = λ). É a hipótese testada pelo teste de Cameron e Trivedi; sua violação caracteriza **superdispersão**.
- **Erro Padrão** `MÉT` `M1` `M18` — (M1) S_x̄ = S/√n — quanto maior a amostra, menor o erro padrão e mais precisa a média estimada. (M18) Na regressão, mede a precisão da estimativa de cada coeficiente.
- **Erro Tipo I e Tipo II** `CONC` `M1` — **Tipo I (α)**: rejeitar H₀ quando ela é verdadeira. **Tipo II**: não rejeitar H₀ quando ela é falsa.
- **Especificidade** `MÉT` `M19` — TN/(TN+FP) — capacidade do classificador de **evitar falsos alarmes**. Python: `recall_score(y, y_pred, pos_label=0)`.
- **Estacionariedade** `CONC` `M23` — "Um processo estocástico é estacionário se média e variância forem constantes ao longo do tempo e a covariância entre dois períodos depender apenas da defasagem, não do período efetivo" (Enders, 2003). A **tendência** é a causa mais comum de não estacionariedade; detecta-se pelo decaimento lento da ACF. Testes: ADF, KPSS e Phillips-Perron.
- **ETL (Extract, Transform, Load)** `CONC` `M3` — Primeira fase do processo de BI, antes da modelagem de dados, visualização e publicação.
- **ETS (Error, Trend, Seasonal)** `MOD` `M23` — Notação dos modelos de suavização exponencial: **N** nenhum, **A** aditivo, **M** multiplicativo, **Z** automático, **Ad/Md** amortecidos. Ex.: `model="AAA"` = erro, tendência e sazonalidade aditivos. Seleção automática do melhor ETS via **AIC**.
- **Excentricidade** `MÉT` `M8` — Maior distância de um nó a qualquer outro. Valor baixo = nó central; valor alto = nó periférico. O **raio** da rede é a menor excentricidade. Python: `g.eccentricity()`.
- **EXPLAIN** `FERR` `M4` — Comando SQL que mostra o plano de execução de uma consulta, usado para diagnosticar uso de índices e gargalos.
- **Exploration x Exploitation** `CONC` `M6` — **Exploração**: manter população diversa e busca ampla (maior mutação). **Explotação**: refinar a região promissora (elitismo, menor mutação). Equilibrar os dois ao longo das gerações é o cerne do ajuste de um AG.
- **Exposição** `CONC` `M20` — Unidade (temporal, espacial, social) à qual a contagem se refere; precisa ser definida em qualquer modelo de dados de contagem.

---

## F

- **F de Snedecor** `DIST` `M1` — Distribuição que trabalha com **razões entre valores**; a forma depende dos graus de liberdade do numerador e do denominador. Aplicação: comparação de variâncias e ANOVA.
- **FAC / ACF (Função de Autocorrelação)** `MÉT` `M23` — FAC(k) = Σ(xₜ−x̄)(xₜ₊ₖ−x̄) / Σ(xₜ−x̄)². Oscila entre −1 e 1 e é adimensional; a 1ª autocorrelação é sempre 1. Usada para identificar a ordem **q** (MA) e, no diagnóstico, a autocorrelação dos resíduos. Python: `plot_acf`.
- **FACP / PACF (Função de Autocorrelação Parcial)** `MÉT` `M23` — Mede a correlação entre a série e seu lag k **removendo o efeito dos lags intermediários**. Usada para identificar a ordem **p** (AR). Python: `plot_pacf(serie, method='ywm')`.
- **factor_analyzer** `FERR` `M15` — Biblioteca da análise fatorial: `FactorAnalyzer(n_factors=k, method='principal', rotation=None)`, com `get_eigenvalues()`, `loadings_`, `get_communalities()`, `weights_` e `transform()`; e `calculate_bartlett_sphericity` para o teste de esfericidade.
- **Fast Greedy** `ALG` `M8` — Algoritmo guloso hierárquico de detecção de comunidades que maximiza modularidade. Rápido para redes grandes. Python: `rede.community_fastgreedy().as_clustering()`.
- **Fator Gaussiano (FG)** `CONC` `M13` — FGⱼ = desvio padrão / média do critério j (isto é, o **coeficiente de variação**). Normalizado (FGN = FGⱼ/ΣFG), torna-se o **peso do critério** no AHP-Gaussiano — sem subjetividade nem comparação par a par.
- **Fatores ortogonais** `CONC` `M15` — Fatores extraídos por componentes principais são **não correlacionados entre si** (correlação = 0), inclusive após a rotação Varimax. Por isso podem ser usados como inputs em modelos supervisionados sem gerar multicolinearidade.
- **FinOps** `CONC` `M7` — Prática de trazer responsabilidade financeira ao modelo de gastos variáveis da nuvem, unindo Engenharia, Finanças e Negócios. Objetivo: **"gastar melhor", não apenas "gastar menos"**. Ciclo: **Informar** (visibilidade via tags e dashboards) → **Otimizar** (rightsizing, agendamento) → **Operar**. Estratégias: rightsizing, caça a "recursos zumbis", desligar ambientes de dev/teste fora do horário comercial.
- **Fitness (função de)** `CONC` `M6` — Função que avalia a qualidade de cada solução candidata no AG. Boas funções são computacionalmente eficientes, discriminativas e suaves. Para minimização, usa-se fitness = 1/(1+f(x)) ou −f(x).
- **Fitted values (Ŷ)** `CONC` `M18` — Valores preditos pelo modelo. Python: `modelo.fittedvalues`. O gráfico **resíduos vs. fitted** é o diagnóstico visual de heterocedasticidade (padrão desejado: nuvem aleatória em torno de zero).
- **Fronteira eficiente** `CONC` `M10` — Conjunto de carteiras que oferecem o maior retorno esperado para cada nível de risco (Markowitz, 1952). Traçada varrendo retornos-alvo com `EfficientFrontier(...).efficient_return()`; destacam-se nela a carteira de mínimo risco e a carteira tangente.
- **Função objetivo** `CONC` `M27` — Um dos três componentes de todo modelo de otimização: responde "qual a meta?" (maximizar ou minimizar), escrita como expressão das variáveis de decisão. Ex.: `Maximizar Z = 0,3x + 0,5y`.
- **5V's do Big Data** `CONC` `M22` — **Volume** (quantidade massiva), **Velocidade** (rapidez de geração/processamento), **Variedade** (estruturados, semi e não estruturados), **Veracidade** (confiabilidade e qualidade) e **Valor** (capacidade de extrair insights úteis). Frameworks de processamento distribuído (Hadoop, Spark) surgem como resposta a eles.

---

## G

- **GDPR (2018)** `CONC` `M12` — Regulamento Geral sobre a Proteção de Dados da UE. Impõe regras estritas ao tratamento de dados pessoais, concede direitos significativos aos indivíduos e tem **alcance global** (afeta empresas fora da UE que tratam dados de cidadãos europeus). Inspirou a LGPD.
- **Gene, cromossomo, população e geração** `CONC` `M6` — Analogia biológica do AG: **população** = conjunto de soluções candidatas; **indivíduo/cromossomo** = uma solução; **gene** = componente da solução (ex.: 1 = item na mochila, 0 = fora); **fitness** = qualidade da solução; **geração** = iteração do algoritmo.
- **Gephi** `FERR` `M8` — Software standalone para visualização avançada de redes (com tutorial de instalação no módulo), complementar ao `igraph`.
- **GINI (coeficiente de desigualdade)** `MÉT` `M9` — Indicador de distribuição de renda, usado ao lado do IDH e do IPQV para mostrar que **crescimento econômico ≠ desenvolvimento**.
- **GINI (métrica de classificação)** `MÉT` `M19` — Normalização do AUC entre −1 e 1: **GINI = 2×AUC − 1** (equivalente a (AUC − 0,5)/0,5).
- **GLM (Modelos Lineares Generalizados)** `CONC` `M18` — Família que engloba a Regressão Linear, a Logística Binária e Multinomial, a Poisson e a Binomial Negativa — os modelos supervisionados dos módulos 18 a 20.
- **Governança de dados** `CONC` `M3` — Tripé **Pessoas** (quem gerencia a informação como ativo), **Processos** (regras, políticas, papéis e responsabilidades sobre o ciclo de vida da informação; garantir qualidade, consistência, completude, disponibilidade e segurança via métricas) e **Tecnologia** (o que suporta a organização de governança).
- **Grafo** `CONC` `M8` — Estrutura matemática para modelar relações: **nós/vértices** (entidades) e **arestas** (conexões), que podem ter **peso** (intensidade). **Não direcionado** para relações simétricas (amizade); **direcionado** para assimétricas (seguir no Twitter). ⚠️ No `igraph`, os vértices são indexados de 0 a n−1.
- **Grau (Degree)** `MÉT` `M8` — Número de arestas conectadas a um nó — mede popularidade/conectividade. Nó com grau muito alto é um **hub**; a **distribuição de grau** caracteriza o tipo de rede. Python: `g.degree()`.
- **Graus de liberdade** `CONC` `M1` — Quantidade de observações da amostra que pode variar de forma independente e ainda permitir obter o valor em análise. Cada teste tem um cálculo específico (não há padrão único), normalmente considerando o tamanho da amostra e o número de parâmetros estimados; influenciam o valor crítico da distribuição.
- **Growth Model (modelo de tendência linear)** `MOD` `M21` — Especificação HLM3 que modela a tendência de crescimento/queda ao longo do tempo com interceptos e inclinações aleatórios: desempenho_tjk = δ000 + δ100·mes + ν0jk + τ00k + τ10k·mes + ε_tjk.

---

## H

- **Hadoop** `FERR` `M22` `M7` — Framework open source em Java para armazenamento e processamento distribuídos. Componentes: **HDFS** (armazenamento), **MapReduce** (processamento), **YARN** (agendamento de jobs / gerenciador de recursos) e **Hadoop Common** (bibliotecas). Escalável **horizontalmente**; grava em **disco** entre as etapas (mais lento que o Spark).
- **HDFS (Hadoop Distributed File System)** `FERR` `M22` `M7` — Sistema de arquivos distribuído do Hadoop: um **NameNode** coordena vários **DataNodes** com discos locais.
- **Heterocedasticidade** `CONC` `M18` — Variância dos resíduos **não constante** (problema). Consequências: erros padrão incorretos, testes de hipótese inválidos, ICs imprecisos. Detecção: gráfico resíduos vs. fitted (forma de cone/funil) e **teste de Breusch-Pagan**. Soluções: adicionar variáveis omitidas (inclusive dummies), transformar com Box-Cox, erros padrão robustos, WLS.
- **Heurística x Meta-heurística** `CONC` `M6` — *Heurística*: procedimento de busca guiado por intuição, visando uma boa solução (ex.: Greedy Search). *Meta-heurística*: combina procedimentos de busca com estratégias de alto nível de **intensificação e diversificação** para evitar ótimos locais (ex.: Algoritmos Genéticos).
- **Hipótese nula (H₀) e alternativa (H₁)** `CONC` `M1` — Par de afirmações mutuamente exclusivas testado estatisticamente. Decisão pelo **p-valor**: p < α → rejeita-se H₀; p > α → não se rejeita H₀.
- **HLM2** `MOD` `M21` — Modelo multinível de 2 níveis. **Nível 1** (dentro do grupo): Y_ij = β0j + β1j·X_ij + ε_ij. **Nível 2** (entre grupos): β0j = γ00 + γ01·Wj + ν0j e β1j = γ10 + γ11·Wj + ν1j. Combinado: Y_ij = γ00 + γ10·X_ij + γ01·Wj + **γ11·Wj·X_ij** + ν0j + ν1j·X_ij + ε_ij. Sequência de especificação: modelo nulo → interceptos e inclinações aleatórios → modelo final com variável de nível 2. Python: `smf.mixedlm("Y ~ X + W + X:W", groups=df["grupo"], re_formula="~X")`.
- **HLM3** `MOD` `M21` — Modelo multinível de 3 níveis, típico de dados em painel/longitudinais: **Nível 1** = períodos de tempo (medidas repetidas), **Nível 2** = indivíduo, **Nível 3** = grupo. Modelo nulo decompõe a variância em τ00k (entre grupos), ν0jk (entre indivíduos do grupo) e ε_tjk (dentro do indivíduo ao longo do tempo). Python: `smf.mixedlm(..., groups=grupo, vc_formula={"individuo": "0 + C(individuo)"})`.
- **Holt (Suavização Exponencial de Holt)** `MOD` `M23` — Suavização para séries **com tendência e sem sazonalidade**. Python: `statsmodels.tsa.api.Holt`.
- **Holt-Winters** `MOD` `M23` — Suavização exponencial para séries **com tendência e sazonalidade**, nas versões **aditiva** e **multiplicativa**, com parâmetros α (nível), β (tendência) e γ (sazonalidade), todos entre 0 e 1. Python: `ExponentialSmoothing(serie, trend='add', seasonal='add', seasonal_periods=4)`.
- **Homocedasticidade** `CONC` `M18` — Variância dos resíduos **constante** — situação ideal e pressuposto da regressão. É a H₀ do teste de Breusch-Pagan.
- **HTTP / Modelo cliente-servidor** `CONC` `M25` — Protocolo que define as regras de comunicação: o **cliente** (seu script) faz a requisição, o **servidor** responde com o HTML. Componentes inspecionáveis nas DevTools: **Request URL**, **Request Method** (GET, POST) e **Status Code** (200, 403, 404, 429...).
- **Hub** `CONC` `M8` — Nó com grau muito alto (muitas conexões). Distinto do **bridge**, que tem alta intermediação e conecta grupos. Redes *scale-free* têm poucos hubs e são robustas a remoção aleatória, mas vulneráveis a ataque dirigido a eles.

---

## I

- **IaaS / PaaS / SaaS** `CONC` `M7` — Pirâmide de serviços de nuvem. **IaaS** (infraestrutura — VMs, redes, storage; você gerencia SO, apps e dados; ex.: EC2, Azure VMs, Compute Engine); **PaaS** (plataforma para desenvolver e implantar; você gerencia apps e dados; ex.: Heroku, App Engine, Elastic Beanstalk); **SaaS** (software pronto; você não gerencia infraestrutura; ex.: Gmail, Office 365, Salesforce). Analogias da aula: alugar o terreno / a casa pré-fabricada / o apartamento mobiliado.
- **IAM (Gestão de Identidade e Acesso)** `CONC` `M7` — Garante que as identidades certas tenham o acesso certo, aos recursos certos, no momento certo. Três elementos: **Identidade**, **Permissão** e **Recurso**. Três pilares: **Autenticação** ("você é quem diz ser" — senha, MFA, biometria), **Autorização** ("o que pode fazer" — políticas e roles) e **Auditoria** ("quem fez o quê, onde e quando" — relevante para conformidade com a LGPD). Regra-mestra: **Princípio do Menor Privilégio (PoLP)**.
- **ICC (Coeficiente de Correlação Intraclasse)** `MÉT` `M21` — Calculado a partir do modelo nulo: ICC = Var(ν0j) / [Var(ν0j) + Var(ε_ij)]. Mede a proporção da variância total explicada pela **estrutura de grupo**. Próximo de 0 → pouca dependência intragrupo (OLS quase adequado); próximo de 1 → multinível é essencial.
- **Iceberg (Apache)** `FERR` `M7` — **Formato de tabela** open source para data lakes: camada de metadados sobre arquivos Parquet/ORC. Recursos: transações ACID, evolução de esquema sem reescrever arquivos, particionamento oculto, **viagem no tempo** (snapshots), otimização por estatísticas e interoperabilidade entre motores (evita catálogos fragmentados por engine). Arquitetura em 3 camadas: catálogo → metadados (manifest list e manifest files) → dados.
- **IDH** `MÉT` `M9` — Índice de Desenvolvimento Humano (PNUD), usado com o IPQV/IBGE e o Índice de Gini para medir desenvolvimento, qualidade de vida e distribuição de renda — dimensões que o PIB não captura.
- **igraph** `FERR` `M8` — Biblioteca Python usada em aula para análise de redes: criação de grafos (`Graph.DataFrame`), métricas (`degree`, `closeness`, `betweenness`, `articulation_points`), detecção de comunidades (`community_*`) e visualização (`plot`, com `pycairo`).
- **Índice (banco de dados)** `CONC` `M4` — Estrutura que acelera consultas. **Simples** (`create index idx_idioma on livros(idioma)`) ou **composto** (várias colunas na ordem de filtragem). Verificar o efeito com `EXPLAIN`.
- **Índice da Basileia** `MÉT` `M10` — Capital / (Risco de Mercado + Risco de Crédito) ≥ **8%**. Na prática, PR/APR — no exemplo da aula, 70.000/410.000 = 17,1%, acima do mínimo.
- **Índice de Sharpe** `MÉT` `M10` — (μ_p − r_f)/σ_p — retorno excedente por unidade de risco. Sua maximização define a **carteira tangente**.
- **Inércia principal total** `CONC` `M16` — Soma dos autovalores da análise de correspondência, igual a **χ²/N**. Quanto maior a inércia principal total (e o χ²), mais forte é a associação entre as variáveis. Na MCA pelo método da matriz binária, inércia total = (J−Q)/Q.
- **Inflação** `CONC` `M9` — Aumento do nível de preços. Três tipos: **de demanda** (salários, crédito, meios de pagamento), **de oferta** (choque negativo, preços administrados, custos) e **inercial** (memória inflacionária + expectativas + indexação → espiral). Índices no Brasil: **IPCA** (IBGE, meta), **IGP-M** (FGV, contratos), IPC (FIPE), ICV (DIEESE).
- **Inteligência Emocional (domínios)** `CONC` `M11` — Goleman, Boyatzis e McKee: **Autoconsciência** (autoconsciência emocional, autoavaliação precisa, autoconfiança), **Autogestão** (autocontrole, transparência, adaptabilidade, superação, iniciativa, otimismo), **Consciência Social** (empatia, consciência organizacional e de serviço) e **Administração Relacional** (liderança inspiradora, influência, desenvolvimento dos demais, catalisação de mudanças, gestão de conflitos, colaboração).
- **Interação cross-level** `CONC` `M21` — Termo de interação entre uma variável de nível superior e uma de nível 1 (ex.: γ11·Wj·X_ij), que permite a uma característica do grupo modular o efeito da variável individual. Esquecê-la é erro comum na modelagem multinível.
- **Intervalo de Confiança (IC)** `CONC` `M1` `M18` — Faixa de valores possíveis para o parâmetro populacional a um dado nível de confiança. Grandes amostras / variância conhecida: X̄ ± Z·σ/√n. Pequenas amostras / variância desconhecida: X̄ ± t·s/√n, com n−1 g.l. (valores bicaudais). Python (regressão): `modelo.conf_int(alpha=0.05)`.

---

## J

- **Jarque-Bera (teste)** `TESTE` `M23` — Testa normalidade a partir de assimetria e curtose: JB = (n/6)·A² + (n/24)·(K−3)², distribuído como χ²(2). **H₀:** a série é normal (na normal, A = 0 e K = 3).
- **JOIN** `CONC` `M4` — Operação SQL que relaciona tabelas por suas chaves. O **INNER JOIN** retorna apenas os registros com correspondência nas duas tabelas. Reescrever um `IN` com subconsulta como JOIN é uma otimização recomendada para grandes bases.

---

## K

- **Kafka (Apache)** `FERR` `M7` — Plataforma distribuída de streaming (origem no LinkedIn) para publicar, assinar, armazenar e processar fluxos de registros em tempo real. Arquitetura: **tópicos** divididos em **partições** distribuídas entre **brokers**, com réplicas e *consumer groups*. **Kafka Connect** ingere/entrega dados de/para sistemas externos; **Kafka Streams** processa eventos (agregação por janela, joins, detecção de anomalias) com state store (RocksDB).
- **Kaiser** → ver **Critério de Kaiser**.
- **Kanban** `CONC` `M5` — Sistema visual de **fluxo contínuo** (não baseado em sprints como o Scrum). Elementos: quadro com colunas por estado de trabalho, **WIP limits** (limite de itens em cada coluna) e movimento constante dos itens.
- **K-means** `ALG` `M14` — Método não hierárquico em que **K é definido a priori**. Centroides iniciais aleatórios → alocação de cada observação ao centroide mais próximo → recálculo dos centroides como média do grupo → repetição até não haver mais realocações. Minimiza o **WCSS**. Aplicável a amostras maiores que o método hierárquico. Python: `KMeans(n_clusters=3, init='random', random_state=100)`.
- **Kolmogorov-Smirnov (teste)** `TESTE` `M23` — Teste de normalidade dos resíduos usado no diagnóstico ARIMA. **H₀:** resíduos normais. Python: `scipy.stats.kstest(residuals, 'norm', args=(media, desvio))`.
- **KPSS (teste)** `TESTE` `M23` — Teste de estacionariedade com hipóteses **invertidas** em relação ao ADF. **H₀:** a série **é** estacionária (não apresenta raiz unitária); **H₁:** não é estacionária. Usado para confirmar/contrastar o resultado do ADF.
- **Kubernetes** `FERR` `M7` — Sistema de orquestração de contêineres. Componentes do cluster: API server, Controller Manager, Cloud Controller Manager, **etcd** (persistência), kubelet, kube-proxy e Scheduler, organizados em **Control Plane** e **Nodes**. Hierarquia prática: Cluster → Painel de Controle → Nodes → **Pods** → Contêineres, com Service Mesh coordenando microsserviços (padrão sidecar).

---

## L

- **Label Propagation** `ALG` `M8` — Detecção de comunidades em que cada nó adota o rótulo mais comum entre seus vizinhos. Muito rápido, porém **não determinístico**. Python: `rede.community_label_propagation()`.
- **Lematização (Lemmatization)** `CONC` `M26` — Reduz a palavra à sua **forma canônica** (lema, forma de dicionário), preservando o sentido gramatical. Mais lenta e mais precisa que o stemming, sempre retorna palavra válida: "Amasse" → "amar"; "correu" → "correr". Python: `spacy.load("pt_core_news_sm")` e `token.lemma_`.
- **Lean Thinking** `CONC` `M5` — Filosofia de **eliminar desperdício e maximizar valor**, com visualização do fluxo de trabalho e limite de WIP para otimizar o *throughput*.
- **LGD (Loss Given Default)** `CONC` `M10` — Perda dado o default: incerteza quanto ao valor recuperável após o default; equivale a 1 − taxa de recuperação. Terceiro direcionador do risco de crédito, com PD e EAD.
- **LGPD (Lei nº 13.709/2018)** `CONC` `M12` — Regula o tratamento de dados pessoais por pessoa física ou jurídica, pública ou privada, **em qualquer meio**, para proteger os direitos fundamentais de liberdade, privacidade e livre desenvolvimento da personalidade. Estruturada em 10 princípios (Art. 6º), bases legais (Art. 7º), definições (Art. 5º) e direitos do titular (Art. 18).
- **Likert (escala)** `CONC` `M16` — Escala ordinal de concordância (concordo plenamente → discordo plenamente). Na análise de correspondência, **cada ponto da escala é uma categoria**, o que evita o problema da ponderação arbitrária de variáveis qualitativas.
- **Ljung-Box (teste)** `TESTE` `M23` — Testa autocorrelação nos resíduos. **H₀:** resíduos **não** autocorrelacionados (independentes, iid) → modelo bem ajustado; **H₁:** resíduos correlacionados → o modelo não capturou toda a estrutura. Python: `acorr_ljungbox(residuals, lags=[12], return_df=True)`.
- **LLM (Large Language Model)** `CONC` `M26` — Modelos de IA treinados em grandes volumes de texto para gerar e compreender linguagem natural. Área correlata a NLP, Análise de Sentimento e Text Mining.
- **Loading plot** `CONC` `M15` — Gráfico de dispersão das cargas fatoriais (Fator 1 × Fator 2) que mostra quais variáveis mais se associam a cada fator. É o gráfico usado para avaliar se a **rotação Varimax** melhora a interpretação.
- **Log-Likelihood (LL / llf)** `MÉT` `M19` `M20` — Logaritmo da verossimilhança do modelo; sempre negativo. Quanto **mais próximo de zero (menos negativo)**, melhor o ajuste. Base do LR test (modelos encaixados) e do teste de Vuong (não encaixados).
- **Logito** `CONC` `M19` — Combinação linear z = β₀ + β₁X₁ + ... + βₖXₖ que alimenta a função sigmoide. ⚠️ Os coeficientes β afetam o **logito**, não diretamente a probabilidade P(Y=1).
- **Louvain (Multilevel)** `ALG` `M8` — Um dos algoritmos mais populares de detecção de comunidades: otimização de modularidade em múltiplos níveis, eficiente e eficaz. Python: `rede.community_multilevel()`.
- **LR Test (Teste de Razão de Verossimilhança)** `TESTE` `M19` `M20` — Compara modelos **encaixados**: LR = −2·(LL_modelo_1 − LL_modelo_2), com distribuição χ² e g.l. igual à diferença de parâmetros. Em M19 compara o modelo com o modelo nulo (só intercepto); em M20 compara Poisson x Binomial Negativa. p ≤ 0,05 → modelos diferentes, favorecendo o de maior Log-Likelihood. ⚠️ Não usar para modelos **não** encaixados (Poisson vs. ZIP) — nesse caso, teste de Vuong.

---

## M

- **MA (Médias Móveis — componente ARIMA)** `MOD` `M23` — Componente que avalia os **erros entre períodos**. MA(1) = ARIMA(0,0,1): a observação é explicada pelo erro da observação anterior. A ordem **q** é identificada pela **ACF**.
- **MAE (Mean Absolute Error)** `MÉT` `M23` — Média das diferenças absolutas entre previsto e realizado: MAE = Σ|erroₜ|/h. Python: `sklearn.metrics.mean_absolute_error`.
- **Manifesto Ágil** `CONC` `M5` — Quatro valores: **indivíduos e interações** > processos e ferramentas; **software funcionando** > documentação abrangente; **colaboração com o cliente** > negociação de contratos; **responder a mudanças** > seguir um plano.
- **MAPE (Mean Absolute Percentage Error)** `MÉT` `M23` — Diferença absoluta percentual média: MAPE = [Σ|erroₜ/Xₜ|/h]×100%. Muito usada em finanças e a métrica padrão de comparação **fora da amostra** entre todos os modelos de previsão do módulo.
- **Mapa perceptual** `CONC` `M16` — Gráfico bidimensional (ou 3D) com as coordenadas das categorias na análise de correspondência. A interpretação é pela **proximidade** entre categorias: no exemplo da aula, "Agressivo" fica próximo de "Ações" e "Conservador" de "Poupança".
- **MapReduce** `ALG` `M22` `M7` — Modelo de programação do Hadoop que paraleliza o processamento dividindo tarefas entre os nós. Etapas do exemplo de *word count*: **Splitting → Mapping → Shuffling → Reducing → resultado final**.
- **Marco Civil da Internet (Lei nº 12.965/2014)** `CONC` `M12` — A "Constituição da Internet" no Brasil. Princípios: **neutralidade da rede**, privacidade e proteção de dados, liberdade de expressão, **guarda de registros** (logs de conexão por 1 ano; de acesso a aplicações por 6 meses) e responsabilidade dos provedores (distinguindo conexão de aplicação).
- **Markowitz (Teoria Moderna de Carteiras)** `MOD` `M10` — Harry Markowitz, "Portfolio Selection" (1952), Nobel de Economia em 1990. Formaliza que o risco da carteira depende das **correlações** entre ativos: correlação negativa reduz o risco total (diversificação). Risco de 2 ativos: S_C = √(W²ₐS²ₐ + W²_bS²_b + 2WₐW_b·corr·SₐS_b).
- **Massas (ANACOR)** `CONC` `M16` — Influência de cada categoria sobre as demais de sua variável: Massa Linha = ΣL/N e Massa Coluna = ΣC/N. Entram no cálculo das coordenadas do mapa perceptual. Python: `ca.row_masses_`, `ca.col_masses_`.
- **Matriz binária (Z)** `CONC` `M16` — Transformação das variáveis qualitativas em binárias (0/1 = ausência/presença do atributo). Tratada como tabela de contingência, gera as **coordenadas-padrão** da MCA. Nº de dimensões = J − Q (J = total de categorias, Q = nº de variáveis).
- **Matriz de confusão** `MÉT` `M19` — Cruzamento entre classes reais e preditas, gerando TP, TN, FP e FN — base da sensitividade, especificidade e acurácia. Python: `sklearn.metrics.confusion_matrix`.
- **Matriz de decisão** `CONC` `M13` — Tabela alternativas × critérios que inicia qualquer método MCDM. Problemas MCDM se caracterizam por critérios com **pesos diferentes**, **conflitantes** entre si, e um número finito de alternativas.
- **Máxima Verossimilhança (MLE)** `CONC` `M19` `M20` — Método de estimação dos modelos logísticos, Poisson, Binomial Negativo, ZIP e ZINB (em contraste com o OLS da regressão linear). Nas aulas, foi também calculada manualmente em planilhas Excel.
- **MCA / ACM (Análise de Correspondência Múltipla)** `MOD` `M16` — Analisa a associação entre **mais de duas** variáveis categóricas. Só participam variáveis com associação significativa (χ²) com **pelo menos uma outra**. Dois métodos: matriz binária Z (coordenadas-padrão) e **matriz de Burt** B = Z'Z (coordenadas principais). Python: `prince.MCA(n_components=2)`.
- **MCDM (Multi-Criteria Decision Making)** `CONC` `M13` — Família de métodos de apoio multicritério à decisão: AHP, AHP-Gaussiano, TOPSIS, THOR, SAPEVO-M, ELECTRE, PROMETHEE.
- **ME (Mean Error)** `MÉT` `M23` — Média simples dos erros de previsão (Σerroₜ/h). Mede **viés** (bias), não magnitude — erros positivos e negativos se cancelam.
- **Média** `MÉT` `M1` — Soma dos valores dividida pelo número de observações. Medida de posição sensível a outliers.
- **Média móvel (suavização)** `CONC` `M23` — Média dos últimos k períodos, usada para suavizar séries ruidosas. Pode ser **centralizada** (`rolling(window=14, center=True)`) ou não. Aplicada na aula à série diária de COVID-19.
- **Mean (método de previsão)** `MOD` `M23` — Método simples que usa a **média histórica** como previsão para todos os períodos futuros.
- **Mediana** `MÉT` `M1` — Elemento central da distribuição ordenada (equivale ao Q2 / percentil 50). Robusta a outliers.
- **Método Simplex** `ALG` `M27` — Algoritmo de George B. Dantzig para resolver modelos de Programação Linear. No módulo 27 é apenas anunciado ("motivação para a próxima aula") — a aula trata da **formulação** dos modelos, não da resolução.
- **MLflow** `FERR` `M22` — Ferramenta open source para o ciclo de vida completo de ML. Componentes: **Tracking** (experimentos, métricas, artefatos), **Projects** (padroniza o código para reprodutibilidade), **Models** (formato unificado de empacotamento) e **Registry** (versões e estágios: Staging → Produção → Arquivado). Comandos: `mlflow deployments` (empacota em Docker para SageMaker/Kubernetes/Azure ML/Databricks Model Serving) e `mlflow models serve` (servidor Flask local ou batch).
- **MLlib** `FERR` `M22` — Biblioteca de Machine Learning integrada ao Apache Spark, para aplicar algoritmos em grandes conjuntos de dados.
- **MLOps** `CONC` `M22` — Combina práticas de **DevOps** com Machine Learning para automatizar o ciclo de vida completo dos modelos (treinamento → validação → deployment → monitoramento), garantindo eficiência, reprodutibilidade e rastreabilidade. Workflow de 0 a 6: Data Preparation → EDA → Feature Engineering → Model Training → Model Validation → Deployment → Monitoring (retorna a 0). Frameworks: MLflow, Weights & Biases, Neptune.ai, Seldon, Kubeflow, Polyaxon.
- **Moda** `MÉT` `M1` — Valor que ocorre com maior frequência na distribuição.
- **Modelo, Modelo Matemático e Modelo de Otimização** `CONC` `M27` — **Modelo**: representação explícita e simplificada de uma realidade, para compreendê-la, modificá-la, administrá-la e controlá-la. **Modelo matemático**: representação por expressões matemáticas. **Modelo de otimização**: modelo matemático que busca identificar a **melhor solução (ótima)** possível. ⚠️ Todo modelo de otimização é matemático, mas não o contrário.
- **Modelo nulo (multinível)** `MOD` `M21` — Especificação apenas com intercepto (Y_ij = γ00 + ν0j + ε_ij), sem variáveis explicativas. Serve de **baseline** para verificar se há variabilidade entre grupos que justifique a abordagem multinível, decompondo a variância total em entre grupos e dentro dos grupos (base do ICC).
- **Modularidade** `MÉT` `M8` — Mede a qualidade da divisão de uma rede em comunidades, entre −0,5 e 1. **> 0,3** indica estrutura de comunidade significativa; **> 0,7** estrutura forte. Não é valor absoluto — serve para comparar métodos na mesma rede.
- **Monte Carlo (simulação de)** `ALG` `M10` — Simula variáveis do projeto considerando suas distribuições de probabilidade, gerando uma **distribuição de resultados** (ex.: 10.000 VPLs) em vez de um valor único. Permite calcular P5, P50, P95 e **P(VPL > 0)**. Também usada para gerar milhares de carteiras aleatórias (pesos via distribuição de Dirichlet) na visualização da fronteira eficiente.
- **MPE (Mean Percentage Error)** `MÉT` `M23` — Erro percentual médio: [Σ(erroₜ/Xₜ)/h]×100%. Como o ME, mede viés.
- **Multicolinearidade** `CONC` `M18` — Correlação alta entre variáveis **explicativas**. Consequências: coeficientes instáveis e imprecisos, erros padrão inflados, dificuldade de identificar efeitos individuais. Diagnóstico: **VIF** e **Tolerância**. Soluções: remover uma das variáveis, combinar variáveis, aumentar a amostra, Ridge ou **PCA antes da regressão**.
- **Multi-cloud** `CONC` `M7` — Uso de vários provedores de nuvem em uma única arquitetura heterogênea. Razões a favor: ROI otimizado, segurança, baixa latência, autonomia, resiliência a desastres, estratégia *best-of-breed* e evitar **vendor lock-in**. Contra: custo de *egress*, governança/conformidade, ferramentas em silos, escassez de pessoal qualificado. Padrões: Hybrid Cloud, Multi-Cloud (public↔public) e Cloud Bursting.
- **Mutação** `ALG` `M6` — Operador de variação aleatória. **Bit flip** (binário — probabilidade típica pm = 1/L), **Gaussiana** (real — x_novo = x + N(0,σ²)), **Swap** (permutação — troca duas posições) e **Adaptativa** (taxa decresce ao longo das gerações). ⚠️ Taxa alta demais transforma a busca em aleatória.
- **MySQL** `FERR` `M4` — SGBD relacional usado no módulo, via **MySQL Workbench**, para praticar DDL/DML/DQL, views, procedures, triggers, functions, CTEs, window functions e otimização.

---

## N

- **NAIRU** `CONC` `M9` — *Non-Accelerating Inflation Rate of Unemployment*: nível de desemprego que mantém a taxa de inflação estável.
- **Naive** `MOD` `M23` — Método de previsão mais simples: projeta o **último valor observado** para todos os períodos futuros. Serve de baseline para comparação (MAPE).
- **Naive Sazonal** `MOD` `M23` — Projeta o último valor observado **do mesmo período sazonal** (ex.: previsão de janeiro = último janeiro). Aplicado na aula à série de passageiros aéreos com `season_length=12`.
- **NDA (Non-Disclosure Agreement)** `CONC` `M3` — Acordo de sigilo de informações, contrato de confidencialidade legalmente assinado entre as partes. Cobre documentos do projeto, dados, e-mails e etapas de negociação.
- **NLP (Processamento de Linguagem Natural)** `CONC` `M26` — Processa e entende a linguagem humana por meio de algoritmos. Premissa da aula: **computadores não sentem emoções, identificam padrões na linguagem**. Diferente de uma linguagem de programação (sintaxe rígida), a linguagem natural é ambígua, contextual e cheia de exceções.
- **NoSQL** `CONC` `M7` — Bancos não relacionais com **schema flexível**, priorizando disponibilidade e velocidade (modelo BASE). Quatro tipos: **documentos** (MongoDB, Firestore), **chave-valor** (Redis, DynamoDB), **colunar** (Cassandra, Bigtable) e **grafo** (Neo4j, Neptune — usados em redes sociais e recomendação). Vantagens: flexibilidade e escalabilidade horizontal massiva. Desvantagens: consistência eventual, sem linguagem padrão, JOINs pouco suportados.
- **Normal (Gaussiana)** `DIST` `M1` — Curva em sino, simétrica em torno da média, com parâmetros μ e σ. **68,26%** dos dados em μ±1σ, **95,44%** em μ±2σ, **99,74%** em μ±3σ.
- **Normal Padrão** `CONC` `M1` — Normal transformada por **Z-score**: Z = (X − μ)/σ, resultando em média 0 e desvio padrão 1. O valor crítico 1,96 (bicaudal, 5%) é o mesmo usado como referência nos resíduos padronizados ajustados da ANACOR.
- **NSGA-II** `ALG` `M6` — Algoritmo genético multiobjetivo elitista (Deb et al., 2002), citado no material complementar para problemas com objetivos conflitantes (ex.: maximizar acurácia × minimizar nº de features). Relacionado ao conceito de **fronteira de Pareto**.

---

## O

- **Odds Ratio (OR)** `MÉT` `M19` — **OR = e^β** — multiplicador de chance. OR = 1,21 → aumenta as chances em 21%; OR = 0,61 → reduz em 39%. β > 0 aumenta P(Y=1); β < 0 diminui.
- **OLS (Mínimos Quadrados Ordinários)** `ALG` `M18` — Método de estimação que **minimiza a soma dos quadrados dos resíduos**. Python: `sm.OLS.from_formula('Y ~ X1 + X2', df).fit()`. ⚠️ Não remover o intercepto quando ele é significante (gera viés); ⚠️ inadequado para variáveis dependentes binárias, de contagem ou dados hierárquicos.
- **Operador (LGPD)** `CONC` `M12` — Pessoa ou entidade que realiza o tratamento de dados **em nome do controlador**, seguindo suas instruções.
- **Outlier** `CONC` `M1` `M14` — Valor atípico. Regra do boxplot: valor < Q1 − 1,5·AIQ ou > Q3 + 1,5·AIQ. ⚠️ A análise de cluster é **bastante sensível** a outliers e o ARIMA funciona melhor com dados estáveis.

---

## P

- **PACF** → ver **FACP / PACF**.
- **pandas** `FERR` `M2` `M24` — Biblioteca central de manipulação de dados em Python e ferramenta principal do módulo de Data Wrangling. Estruturas: `Series` e `DataFrame`. Operações vistas: leitura/escrita (`read_csv`, `read_excel`, `to_csv`), seleção (`iloc`, `loc`), limpeza (`dropna`, `to_numeric(errors='coerce')`), agrupamento (`groupby`), ordenação (`sort_values`), frequências (`value_counts`), descritivas (`describe`), dummies (`get_dummies`), tabelas cruzadas (`crosstab`) e discretização (`qcut`).
- **Parquet (Apache)** `FERR` `M7` `M22` — Formato de arquivo open source **colunar**. Vantagens: alto desempenho analítico (lê só as colunas necessárias, guarda estatísticas mín/máx por coluna), compressão eficiente e padrão de indústria. Desvantagens: binário (não legível em editor de texto) e gravação mais lenta que formatos em linha. Ganhos reportados na conversão de CSV: até **87% de redução de tamanho, 34× mais rápido para carregar e 99% de redução de custos**.
- **Particionamento** `CONC` `M22` — Organização dos dados em partições hierárquicas (ex.: `ano=2024/semestre=1`) para que consultas filtradas por período não leiam dados irrelevantes (**partition pruning**).
- **Passeio Aleatório (Random Walk)** `CONC` `M23` — Soma cumulativa de ruído branco (`aleat.cumsum()`). Série **não estacionária** por construção; usada em aula para comparar visualmente com a cotação da PETR4 e motivar os testes de estacionariedade. Também é o benchmark do **Theil's U**.
- **PCA (Análise de Componentes Principais)** `MOD` `M15` — Método de determinação dos fatores que cria fatores **não correlacionados** a partir da combinação linear das variáveis originais. Fluxo completo: matriz de correlações → teste de Bartlett → autovalores/autovetores → scores fatoriais → **critério de Kaiser** → cargas fatoriais e loading plot → comunalidades → (opcional) rotação Varimax → extração dos fatores → ranking.
- **PD (Probabilidade de Default)** `CONC` `M10` — Probabilidade de a contraparte entrar em inadimplência. Componente da fórmula **Perda de Crédito = b × EC × PD** (ou × (1−t), sendo t a taxa de recuperação).
- **Percentis e Quartis** `MÉT` `M1` — **Percentis** dividem a distribuição em 100 partes iguais; **Quartis** em 4: Q1 (25%), Q2 (50%, mediana) e Q3 (75%).
- **Perda Esperada, Não Esperada e Excepcional** `CONC` `M10` — Decomposição da distribuição de perdas de uma carteira de crédito. No exemplo da aula (R$ 100 mil em 3 créditos): perda esperada R$ 8.200 e perda não esperada R$ 61.800. Distingue-se ainda **Perda Incorrida** (evento já ocorrido) de **Perda Esperada** (probabilidade de evento futuro).
- **PESTEL** `CONC` `M9` — Dimensões do macroambiente: **P**olítico, **E**conômico, **S**ocial, **T**ecnológico, **E**cológico e **L**egal. O macroambiente engloba o ambiente setorial, que engloba a organização.
- **Pesquisa Operacional (P.O.)** `CONC` `M13` `M27` — A "**ciência da tomada de decisão**" (Dantzig): abordagem científica para resolver problemas em sistemas complexos, usando analytics avançado, modelagem, estruturação de problemas, simulação, otimização e ciência de dados. Origem nas operações militares da 2ª Guerra. Áreas: apoio multicritério (MCDM), DEA, Programação Linear e Inteira, simulação de eventos discretos, teoria das filas, teoria dos grafos e estatística. Motivação: **explosão combinatória** (500 entregas / 25 veículos → 1,0439 × 10⁴² combinações).
- **Phillips-Perron (teste PP)** `TESTE` `M23` — Teste de raiz unitária. **H₀:** a série não é estacionária (apresenta raiz unitária); **H₁:** é estacionária.
- **PIB** `CONC` `M9` — Valor monetário do total de bens e serviços **finais** produzidos em um território, em um período; indicador de **fluxo**, não de estoque de riqueza. Ótica do dispêndio: **PIB = C + I + G + (Ex − Im)**. Existem também as óticas da oferta e da renda, que resultam no mesmo valor. ⚠️ Crescimento ≠ desenvolvimento (ver IDH e Gini).
- **PL / PLI / PLIM / PNL** `MOD` `M27` — Classificação dos modelos de programação matemática pelo domínio das variáveis e forma das equações: **PL** Programação Linear (variáveis contínuas, ℝ); **PLI** Inteira (0, 1, 2...); **PLIM** Inteira Mista (contínuas + inteiras); **PNL** Não Linear (produtos de variáveis, potências, funções trigonométricas). Estrutura geral: `Max/Min Z = Σcᵢxᵢ` sujeito a restrições `Σaᵢⱼxⱼ {≤,=,≥} bᵢ` e `xᵢ ≥ 0`.
- **Poisson (distribuição)** `DIST` `M1` `M20` — Número de sucessos k em uma **exposição contínua** (tempo ou área): P(X=k) = e^(−λ)·λᵏ/k!. Propriedade fundamental: **E(Y) = Var(Y) = λ** (equidispersão). Aplicada em aula também ao número de fraudes diárias em uma agência bancária (M10).
- **Poisson (modelo de regressão)** `MOD` `M20` — Modelo log-linear para dados de contagem: **ln(λ̂ᵢ) = β₀ + β₁X₁ᵢ + ... + βₖXₖᵢ**, com função de ligação logarítmica e estimação por máxima verossimilhança. Python: `sm.Poisson.from_formula(...)`. ⚠️ Só é adequado se confirmada a equidispersão (teste de Cameron e Trivedi).
- **Poisson-Gama** `DIST` `M20` — Distribuição subjacente ao modelo Binomial Negativo: p(Y=m) = [δ^θ·m^(θ−1)·e^(−m·δ)]/(θ−1)!, com θ (forma) e δ (taxa de decaimento).
- **Ponte / Ponto de Articulação (Bridge)** `CONC` `M8` — Nó cuja remoção **desconecta a rede**. Identifica pontos críticos de conectividade e vulnerabilidades estruturais; conecta diferentes comunidades. Python: `g.articulation_points()` (retorna índices, não nomes).
- **Power BI** `FERR` `M3` — Ferramenta de BI da Microsoft criada em **2015**, líder de mercado segundo o Gartner. Ecossistema: **Desktop** (desenvolvimento), **Services** (consumo dos reports), **Mobile** e **Embedded** (embarcar em aplicações de terceiros).
- **Princípio do Menor Privilégio (PoLP)** `CONC` `M7` — Conceder apenas as permissões mínimas necessárias. Nos cenários da aula: usar um **Role** com política de leitura em vez de colocar chaves no código; usar **Grupos** com política de consulta em vez de dar acesso de administrador "para garantir".
- **Princípios da LGPD (Art. 6º)** `CONC` `M12` — Dez princípios com a **boa-fé** como conceito transversal: Finalidade, Adequação, Necessidade (minimização de dados), Não discriminação, Livre acesso, Transparência, Segurança, Prevenção, Qualidade e **Responsabilização (accountability)**.
- **prince** `FERR` `M16` `M17` — Biblioteca Python de análise fatorial de dados categóricos: `prince.CA()` (ANACOR) e `prince.MCA(n_components=k)`, com `eigenvalues_summary`, `total_inertia_`, `row_masses_`, `col_masses_`, `row_coordinates()` e `column_coordinates()`.
- **Problem Map (Mapa do Problema)** `CONC` `M5` — Ferramenta visual em dois blocos: **Consistência** (contexto do problema, causas identificadas, pessoas impactadas, consequências conhecidas) e **Relevância** (importância estratégica, lacuna realidade × ideal). Deve ser aplicada **antes** de escolher qualquer metodologia.
- **Problema da Mochila (0/1)** `CONC` `M6` — Problema clássico resolvido por AG com **cromossomo binário** (1 = item entra, 0 = fica fora), com fitness = valor total − penalidade se ultrapassar a capacidade.
- **Problema da Ração / Mistura** `CONC` `M6` — Problema de otimização com **cromossomo real** (proporções), minimizando custo sujeito a restrições nutricionais. Usado em aula para comparar AG × solver exato (PuLP/cvxpy).
- **Problema do Caixeiro Viajante (TSP)** `CONC` `M6` — Problema combinatorial resolvido por AG com **cromossomo de permutação** (ordem das cidades) e fitness = comprimento total da rota.
- **Problema simples x complexo** `CONC` `M11` — **Simples**: independentes, previsíveis, contexto conhecido, isoláveis, resolvidos tendem a desaparecer, há uma resposta certa (cabem a pessoas operacionais). **Complexo**: contexto desconhecido, características interdependentes, variáveis oscilam, planos raramente funcionam, exigem experimentação, não têm ponto final — **não são solucionáveis, devem ser gerenciados** (cabem aos líderes). Paralelo com M5: problemas conhecidos → preditivo; conhecíveis/incognoscíveis → ágil.
- **PROMETHEE** `MOD` `M13` — Método multicritério baseado em **fluxos de superação** (citado junto do PrOPPAGA).
- **Pseudo R² de McFadden** `MÉT` `M19` — 1 − (LL_modelo / LL_nulo). Referência da aula: **0,2-0,4 é excelente** para logística; > 0,4 excepcional.
- **p-valor** `CONC` `M1` — Probabilidade associada ao valor da estatística de teste calculada. Se p < α, rejeita-se H₀; se p > α, não se rejeita. Níveis usuais de α: 1%, 5% e 10%.
- **pygad** `FERR` `M6` — Biblioteca Python de algoritmos genéticos usada nos scripts das aulas; suporta representação binária, real e por permutação.

---

## Q

- **Q-Q plot** `CONC` `M18` — Gráfico quantil-quantil para inspecionar visualmente a normalidade dos resíduos, complementando os testes de Shapiro-Francia/Wilk e o histograma com curva normal teórica.
- **Qui-quadrado (distribuição χ²)** `DIST` `M1` — Forma influenciada pelos graus de liberdade: assimétrica e positiva para poucos g.l., aproximando-se da normal conforme aumentam. Aplicação principal: teste de associação entre variáveis categóricas.
- **Qui-quadrado (teste de aderência, uma amostra)** `TESTE` `M1` — Verifica se há diferença entre frequências observadas (O) e esperadas (E): χ² = Σ(Oᵢ − Eᵢ)²/Eᵢ, com k−1 graus de liberdade.
- **Qui-quadrado (teste de associação)** `TESTE` `M1` `M16` — Parte de uma **tabela de contingência**; calcula as frequências esperadas [(ΣL·ΣC)/N], os **resíduos** (observada − esperada) e o χ² de cada célula (resíduo²/esperada), somados no χ² total. **H₀:** as variáveis se associam de forma aleatória (independentes); **H₁:** a associação não é aleatória. Valor crítico com **(I−1)·(J−1)** graus de liberdade. Python: `scipy.stats.chi2_contingency(pd.crosstab(...))`.

---

## R

- **R² (Coeficiente de Determinação)** `MÉT` `M18` — Proporção da variância de Y explicada pelo modelo (0 a 1). Em regressão simples, R² = (correlação)². ⚠️ Sempre aumenta ao adicionar variáveis, mesmo irrelevantes — daí o R² ajustado.
- **R² Ajustado** `MÉT` `M18` — R²_adj = 1 − [(1−R²)(n−1)/(n−k−1)]. Penaliza o número de variáveis explicativas; é a métrica correta para **comparar modelos com quantidades diferentes de variáveis**.
- **Raio (grafo)** `MÉT` `M8` — Menor excentricidade entre todos os nós — a distância do(s) nó(s) mais central(is). Python: `g.radius()`.
- **RDD (Resilient Distributed Dataset)** `CONC` `M22` `M7` — Estrutura de dados fundamental do Spark: coleção distribuída de objetos **imutáveis**. **Resiliente** (recomputa a partir das operações originais em caso de falha), **distribuído** (dados em vários nós) e **imutável** (transformações geram novos RDDs). Operações: **transformações** (`map`, `filter` — geram novo RDD) e **ações** (`count`, `collect` — retornam valor ao driver).
- **Regressão Linear Simples** `MOD` `M18` — Y = β₀ + β₁X + ε, estimada por OLS. β₀ = intercepto (valor de Y quando X=0); β₁ = coeficiente angular (variação em Y por unidade de X).
- **Regressão Linear Múltipla** `MOD` `M18` — Y = β₀ + β₁X₁ + ... + βₖXₖ + ε. Vantagem: controla os efeitos de múltiplas variáveis simultaneamente (**ceteris paribus**). Pressupostos verificados no módulo: linearidade, normalidade dos resíduos, homocedasticidade e ausência de multicolinearidade.
- **Regressão Logística Binária** `MOD` `M19` — Modelo de classificação para Y binária, estimado por **máxima verossimilhança**: P(Y=1) = 1/(1 + e^(−z)), com z = logito. Avaliação: matriz de confusão, sensitividade, especificidade, acurácia, curva ROC/AUC, GINI, LR test e pseudo R² de McFadden. Python: `sm.Logit.from_formula('Y ~ X1 + X2', df).fit()`.
- **Regressão Logística Multinomial** `MOD` `M19` — Para Y com **3+ categorias**. Estima **k−1 equações**, cada uma comparando uma categoria com a de referência: log[P(Y=1)/P(Y=0)] = β₁₀ + β₁₁X₁ + ... A predição é a classe de maior probabilidade (`phats.idxmax(axis=1)`). Python: `MNLogit(endog=y, exog=sm.add_constant(X)).fit()` — ⚠️ não esquecer o `add_constant`.
- **Resíduo** `CONC` `M18` — Diferença entre o valor observado e o predito: e = Y − Ŷ. Python: `modelo.resid`.
- **Resíduo padronizado e padronizado ajustado** `CONC` `M16` — Aprofundam **como** as categorias se relacionam (o χ² só diz **se** há dependência). Padronizado = resíduo/√(freq. esperada); **ajustado** divide ainda por √[(1−ΣC/N)(1−ΣL/N)]. Regra de leitura: **|valor| > 1,96** indica associação estatisticamente significativa (5%) entre as duas categorias daquela célula. Python: `sm.stats.Table(tabela).standardized_resids`.
- **Responsabilidade Compartilhada (modelo de)** `CONC` `M7` — O provedor é responsável pela segurança **da** nuvem (hardware, data centers); o cliente pela segurança **na** nuvem (dados, configuração de rede/firewall, senhas, permissões). A principal causa de vazamentos não são ataques sofisticados, mas **configurações incorretas do cliente**.
- **Restrições** `CONC` `M27` — Comparações entre quantidades mensuráveis (com ≤, = ou ≥) que limitam as variáveis de decisão. Três tipos: **limitação de recursos** (uso ≤ disponibilidade), **desempenho mínimo** (produção ≥ meta) e **conservação** (entradas = saídas). ⚠️ Nunca esquecer a restrição de **domínio** (x ≥ 0, inteiro ou binário).
- **Retorno discreto x contínuo** `CONC` `M10` — **Discreto**: Rₜ = Pₜ/Pₜ₋₁ − 1. **Contínuo**: Rₜ = ln(Pₜ/Pₜ₋₁). Base do cálculo de retorno e volatilidade de ativos.
- **RI (Índice Aleatório de Saaty)** `CONC` `M13` — Constante tabelada usada no denominador da Razão de Consistência: n=3 → 0,58; n=4 → 0,90; n=5 → 1,12; n=6 → 1,24; n=7 → 1,32; n=8 → 1,41; n=9 → 1,45; n=10 → 1,49.
- **Risco de Crédito** `CONC` `M10` — Risco de perda econômica pelo não cumprimento de obrigações contratuais por uma contraparte. Direcionadores: **PD**, **EAD/EC** e **LGD**. Fórmula: Perda de Crédito = b × EC × PD. Regulação: Resoluções CMN 4.966/21 e BCB 352/23, com classificação em ratings (AA a H) e **3 estágios** (Estágio 3 = ativo problemático).
- **Risco Operacional** `CONC` `M10` — Mensurado pela **distribuição de perdas** combinando **frequência** (n = nº de eventos em um intervalo) e **severidade** (S = magnitude de cada perda), a partir de dados históricos, estimativas subjetivas e/ou distribuições teóricas.
- **RMSE (Root Mean Square Error)** `MÉT` `M23` — √[Σ(erroₜ²)/h] — desvio-padrão total da diferença entre previsto e realizado. Penaliza mais os erros grandes que o MAE.
- **Rotação Varimax** `ALG` `M15` — Rotação **ortogonal** dos fatores que aumenta a carga fatorial em um fator e a diminui em outro, melhorando a interpretação. Redistribui a variância entre os fatores (o total permanece igual); **altera cargas e scores fatoriais**, mas **não altera as comunalidades**, e os fatores permanecem ortogonais. Python: `FactorAnalyzer(..., rotation='varimax')`.
- **Roleta (Roulette Wheel)** `ALG` `M6` — Operador de seleção com probabilidade proporcional ao fitness: P(i) = fitness(i)/Σfitness. Problema: convergência prematura quando os fitness são muito desiguais.
- **Ruído Branco** `CONC` `M23` — Sequência eₜ com E(eₜ) = 0, Var(eₜ) = σ² constante e Cov(eₜ, eₜ₋₁) = 0 (ausência de autocorrelação). Se eₜ ~ N, é **ruído branco gaussiano**. O objetivo do diagnóstico Box-Jenkins é que os resíduos sejam ruído branco.

---

## S

- **SARIMA(p,d,q)(P,D,Q)ₛ** `MOD` `M23` — ARIMA com componente **sazonal**: **P** termos autorregressivos sazonais, **D** diferenças sazonais, **Q** médias móveis sazonais e **s** o ciclo sazonal (12 para dados mensais). Python: `ARIMA(serie, order=(1,0,0), seasonal_order=(0,0,1,12))` ou `auto_arima(serie, seasonal=True, m=12)`.
- **SAPEVO-M** `MOD` `M13` — Sistema de Apoio à Preferência por Eliminação Vetorial com Orientação — método multicritério (MCDM).
- **Scale-free (rede)** `CONC` `M8` — Rede cuja distribuição de grau segue uma **lei de potência**: poucos hubs e a maioria dos nós com poucas conexões. Robusta à remoção aleatória, **vulnerável a ataque dirigido aos hubs**.
- **Scores fatoriais** `CONC` `M15` — Parâmetros que relacionam o fator com as variáveis originais em um modelo linear: sₖ = vₖ/√λₖ. O valor do fator para cada observação é obtido a partir das variáveis padronizadas por Z-Score. Python: `fa.weights_`.
- **Scrum** `CONC` `M5` — Framework ágil com **papéis** (Product Owner define visão e prioridades; Scrum Master facilita e remove impedimentos; Time de Desenvolvimento auto-organizado), **eventos** (Sprint Planning, Daily Scrum de 15 min, Sprint Review, Sprint Retrospective) e artefatos. Baseado em sprints time-boxed — em contraste com o fluxo contínuo do Kanban.
- **Selic** `CONC` `M9` — Taxa básica de juros definida pelo **Copom** (Comitê de Política Monetária do BC), considerando conjuntura nacional e panorama externo. Instrumentos clássicos de política monetária: **open market**, **recolhimento compulsório** e **redesconto**.
- **Seleção por Torneio (Tournament)** `ALG` `M6` — Sorteia k indivíduos e escolhe o melhor (k=2 é comum). Mais robusto que a roleta.
- **Self Service Analytics** `CONC` `M3` — Simplifica a análise para usuários não técnicos, dando autonomia para criar análises, relatórios e dashboards sobre uma base tecnológica estruturada. Pilares técnicos: tecnologia, DW e Data Mining. Pilares humanos/organizacionais: skill, processos e recursos. Entregáveis: Report, Analytics e Data Viz.
- **Sensitividade (Recall)** `MÉT` `M19` — TP/(TP+FN) — capacidade de **detectar os casos positivos reais**. Python: `recall_score(y, y_pred, pos_label=1)`.
- **Serverless** `CONC` `M7` — Executar código sem gerenciar servidores: escreve-se uma função, define-se um **gatilho** (clique, novo arquivo, horário) e a nuvem aloca recursos instantaneamente, liberando-os depois. Vantagens: paga-se só pelos milissegundos de execução, escalabilidade automática de zero a milhares de requisições. Desvantagens: **cold starts**, limites de tempo (5-15 min) e memória, complexidade de monitoramento, vendor lock-in.
- **SES (Suavização Exponencial Simples)** `MOD` `M23` — Para séries **sem tendência e sem sazonalidade**. Dá pesos maiores às observações mais recentes; a previsão é o último valor exponencialmente suavizado. Python: `SimpleExpSmoothing(serie).fit()`.
- **Shadow IT** `CONC` `M3` — Qualquer sistema, dispositivo ou serviço usado na organização **sem conhecimento ou aprovação da área de TI**. Riscos: conformidade, custos não administrados, regulamentação de dados e segurança.
- **Shapiro-Francia (teste)** `TESTE` `M18` — Teste de normalidade dos resíduos para **n ≥ 30**. **H₀:** distribuição aderente à normalidade (p > 0,05 → OK). Se rejeitado, aplicar Box-Cox. Python: `statstests.tests.shapiro_francia`.
- **Shapiro-Wilk (teste)** `TESTE` `M18` `M23` — Teste de normalidade para **n < 30** (e usado também na validação de resíduos de séries temporais). Python: `scipy.stats.shapiro`.
- **Sigmoide** `CONC` `M19` — Função que transforma o logito em probabilidade [0,1]: P(Y=1) = 1/(1 + e^(−z)). z = 0 → P = 0,5; z → +∞ → P → 1; z → −∞ → P → 0. Visualização correta: `sns.regplot(..., logistic=True)`.
- **Silhueta (Método da)** `MÉT` `M14` — Para cada observação: (a) distância média dentro do próprio cluster e (b) distância média ao cluster mais próximo → silhueta = (b−a)/máx(a,b). Próximo de **1** = boa clusterização; próximo de **−1** = ruim. Escolhe-se o K de maior silhueta média. Python: `sklearn.metrics.silhouette_score`.
- **Small-world (rede)** `CONC` `M8` — Rede com **alto coeficiente de clustering** e **baixo comprimento médio de caminho** — o fenômeno dos "6 graus de separação". Exemplos: redes sociais, internet, redes neurais.
- **spaCy** `FERR` `M26` — Biblioteca de NLP usada para **lematização** e análise sintática/POS em português (`pt_core_news_sm`).
- **Spark (Apache)** `FERR` `M22` `M7` — Motor unificado de análise para processamento em larga escala, com **processamento in-memory** (mais rápido que o Hadoop, que grava em disco entre etapas). Arquitetura: **Driver Program** (com SparkContext) → **Cluster Manager** → **Nodes** com Executor, Cache e Tasks. Estruturas: RDD e DataFrame. Módulos: **Spark SQL**, **MLlib**, **Spark Streaming**. Formatos suportados: parquet, avro, orc, json, csv.
- **Spark SQL** `FERR` `M7` — Módulo do Spark para dados estruturados, com acesso unificado a JSON, Hive, Parquet e JDBC, consultas SQL padrão e API DataFrame/Dataset. `df.filter(df['age'] > 21)` equivale a `spark.sql("SELECT * FROM t WHERE age > 21")`. Otimização pelo **Catalyst** + motor **Tungsten**. Toda consulta passa por um **plano lógico** ("o quê") e um **plano físico** ("como").
- **Spin Glass** `ALG` `M8` — Algoritmo de detecção de comunidades baseado em física estatística; bom para redes pequenas a médias. Python: `rede.community_spinglass()`.
- **statstests** `FERR` `M18` `M20` — Pacote Python de Luiz Paulo Fávero e Helder Prado Santos (stats-tests.github.io/statstests) com `shapiro_francia()` (normalidade n≥30), `stepwise()` (seleção de variáveis) e `overdisp()` (superdispersão de Cameron e Trivedi).
- **Stemming** `CONC` `M26` — Reduz a palavra à sua **raiz**, cortando sufixos por regras — mais rápido e mais bruto que a lematização, podendo gerar radicais inválidos: "Amasse" → "am"; "linguagem" → "linguag". Python: `nltk.stem.RSLPStemmer` (português).
- **Stepwise** `ALG` `M18` `M19` — Procedimento de seleção automática de variáveis por significância estatística. **Forward** (adiciona uma a uma, da mais significante), **Backward** (remove a menos significante) e **Stepwise** (combinação). Python: `statstests.process.stepwise(modelo, pvalue_limit=0.05)`. ⚠️ Limitações: não garante o melhor modelo teórico, pode excluir variáveis teoricamente importantes e é sensível a multicolinearidade — deve ser combinado com conhecimento do domínio.
- **Stopwords** `CONC` `M26` — Palavras comuns sem carga semântica relevante (artigos, preposições, conjunções: "a", "o", "e", "de", "que", "em"), removidas no pré-processamento. ⚠️ Cuidado com negações ("não gostei") — remover pode inverter o sentido. Python: `nltk.corpus.stopwords.words('portuguese')`.
- **Stored Procedure** `CONC` `M4` — Rotina SQL armazenada que automatiza tarefas e aceita parâmetros de entrada/saída — diferente das **Views**, que são apenas consultas salvas. Criada com `create procedure ... begin ... end` e chamada com `call`.
- **Suavização Exponencial** `MOD` `M23` — Família de modelos que dá pesos maiores às observações mais recentes: **SES** (sem tendência nem sazonalidade), **Holt** (com tendência) e **Holt-Winters** (tendência + sazonalidade), sistematizados pela notação **ETS**.
- **Superdispersão** `CONC` `M20` — Situação em que a variância dos dados de contagem **excede a média**, violando a equidispersão da Poisson. Detectada pelo teste de Cameron e Trivedi (ou por α significativamente diferente de zero no modelo NB/ZINB) e tratada com o modelo **Binomial Negativo**. ⚠️ Sem superdispersão, Poisson e Binomial Negativa são estatisticamente equivalentes.
- **Swarm Intelligence (Inteligência de Enxame)** `CONC` `M11` — Auto-organização de grupos em que as soluções emergem das **interações**, não de um comando central. Exemplo da aula: as formigas-de-fogo que se empilham formando uma balsa flutuante durante a tempestade Harvey. Implicação para liderança: o líder integra e empodera, fomentando inteligência distribuída e co-criada.
- **SQL (DDL / DML / DQL)** `CONC` `M4` — Subconjuntos da linguagem: **DDL** define estruturas (`create table`, chaves primárias e estrangeiras), **DML** manipula dados (`insert`, `update`, `delete`) e **DQL** consulta (`select`, `where`, `group by`, `join`).

---

## T

- **t de Student** `DIST` `M1` — Parecida com a normal padrão, mas com **caudas mais longas** (permite valores mais extremos); aproxima-se da normal conforme os graus de liberdade aumentam. Aplicação: testes de médias, útil para **amostras pequenas**.
- **Tabela de contingência (cross-tabulation)** `CONC` `M1` `M16` — Tabela com as frequências absolutas observadas para cada par de categorias de duas variáveis qualitativas. Ponto de partida do teste qui-quadrado de associação e da ANACOR. Python: `pd.crosstab(df['A'], df['B'])`.
- **Tabela de frequências** `CONC` `M1` — Apresenta frequência absoluta, relativa, absoluta acumulada e relativa acumulada. É a forma de análise descritiva de **variáveis qualitativas**, que não permitem medidas de posição e dispersão.
- **Tags (FinOps)** `CONC` `M7` — Rótulos chave-valor (projeto, ambiente, centro de custo) que permitem filtrar e **alocar custos** na nuvem. Base da etapa "Informar" do ciclo FinOps.
- **Tendência** `CONC` `M23` — Movimento oculto nos dados seguindo direção crescente, decrescente ou estacionária. É a causa mais comum de **não estacionariedade** e o motivo da diferenciação no ARIMA.
- **Teste F para comparação de variâncias** `TESTE` `M1` — F = S²maior/S²menor, com distribuição F de Snedecor. Aplicado **antes** do teste t para duas amostras independentes, para saber se as variâncias populacionais são homogêneas — o que muda o cálculo da estatística T e dos graus de liberdade.
- **Teste t para a média (uma amostra)** `TESTE` `M1` — Aplicado quando o desvio padrão populacional é **desconhecido**: T = (X̄ − μ₀)/(S/√n), com t de Student e n−1 graus de liberdade.
- **Teste t para duas amostras independentes** `TESTE` `M1` — Compara as médias de dois grupos. Exige verificar previamente (ex.: pelo teste F) se as variâncias populacionais são homogêneas ou diferentes.
- **Teste t para significância da correlação** `TESTE` `M1` — t = r / √[(1−r²)/(n−2)], com t de Student e n−2 graus de liberdade. Testa se o coeficiente de Pearson é estatisticamente diferente de zero.
- **Teste Z para a média** `TESTE` `M1` — Aplicado quando o desvio padrão populacional é **conhecido**: Z = (X̄ − μ₀)/(σ/√n), com distribuição normal padrão.
- **Text Mining** `CONC` `M26` — Processo de descobrir padrões, informações úteis e conhecimento em grandes volumes de dados **textuais e não estruturados** — "garimpar ouro em meio a um rio de texto". Pipeline: Coleta → Pré-processamento → Modelagem e Análise → Avaliação e Interpretação → Insights. Aplicações: análise de sentimentos, extração de informação, sumarização, classificação, modelagem de tópicos e detecção de fraudes/spam.
- **TF-IDF** `ALG` `M26` — Técnica de **extração de características** que transforma texto em vetores numéricos, etapa 03 do pipeline de Sentiment Analysis (antes da classificação). Python: `sklearn.feature_extraction.text.TfidfVectorizer` (alternativa: `CountVectorizer`).
- **Theil's U (TIC)** `MÉT` `M23` — Coeficiente de desigualdade de Theil: razão entre o erro do modelo e o erro de um passeio aleatório. Quanto **menor, melhor** (zero é o ideal); **U < 1** indica previsão melhor que um passeio aleatório. ⚠️ Não confundir com R².
- **THOR** `MOD` `M13` — Teoria Híbrida de Ordenação — método multicritério de apoio à decisão.
- **Titular (LGPD)** `CONC` `M12` — Pessoa **natural** (física) a quem os dados pessoais pertencem. Direitos (Art. 18): confirmação de tratamento, acesso, correção, anonimização/bloqueio/eliminação, portabilidade, informação sobre compartilhamento, revogação do consentimento, peticionamento, oposição, **revisão de decisão automatizada** e informações sobre seus critérios.
- **Tokenização** `CONC` `M26` — Divide o texto em unidades menores (**tokens**), geralmente palavras: "Eu amo MBA!" → ["Eu", "amo", "MBA", "!"]. Python: `nltk.tokenize.word_tokenize(texto, language='portuguese')`.
- **Tolerância** `MÉT` `M18` — Inverso do VIF (1/VIF). **> 0,20** aceitável; **< 0,10** indica multicolinearidade severa.
- **TOPSIS** `MOD` `M13` — Técnica para ordem de preferência por **similaridade à solução ideal** — método multicritério (MCDM).
- **Tratamento (LGPD)** `CONC` `M12` — Qualquer operação com dados pessoais: coleta, avaliação, classificação, acesso, controle e armazenamento. Todo tratamento deve estar enquadrado em uma **base legal** do Art. 7º (consentimento, legítimo interesse, cumprimento de obrigação legal, execução de contrato, políticas públicas, estudos por órgão de pesquisa, proteção à vida, tutela da saúde, exercício regular de direitos).
- **Triangular** `DIST` `M10` — Distribuição definida por três parâmetros: a (mínimo/pessimista), m (moda/mais provável) e b (máximo/otimista). Muito usada em simulações de Monte Carlo de projetos, ao lado da **PERT** (otimista, mais provável, pessimista) e da **Normal**. Python: `np.random.triangular(a, m, b, size=n)`.
- **Trigger** `CONC` `M4` — Rotina SQL executada **automaticamente** em resposta a INSERT, UPDATE ou DELETE. Exemplo da aula: gravar em `log_preco` toda alteração de valor (`after update on livros ... if old.vendas <> new.vendas`).
- **Tripé Macroeconômico** `CONC` `M9` — Responsabilidade Fiscal (meta de resultado primário) + Metas de Inflação (política monetária) + Câmbio Flutuante (política cambial).

---

## U

- **Uniforme discreta** `DIST` `M1` — Todos os resultados têm a mesma probabilidade: P(X = xᵢ) = 1/n.
- **UPSERT** `CONC` `M4` — Insere ou atualiza em uma única operação: `insert into ... on duplicate key update ...`.

---

## V

- **Variáveis de decisão** `CONC` `M27` — Um dos três componentes de todo modelo de otimização: respondem "o que se quer decidir?". Podem ser **contínuas** (toneladas, horas), **discretas/inteiras** (nº de caixas, trabalhadores) ou **binárias** (implantar ou não um armazém). ⚠️ A sequência correta de modelagem é sempre variáveis → objetivo → restrições.
- **Variáveis qualitativas x quantitativas** `CONC` `M1` — **Qualitativas** (não métricas): atribuem categorias ou classificações (faixa de renda, estado civil, escalas Likert); analisadas por tabelas de frequência e gráficos. **Quantitativas** (métricas): atribuem contagem ou mensuração (idade, renda, retorno de ações), podendo ser discretas ou contínuas. Essa distinção determina qual técnica é aplicável (cluster/PCA para métricas; correspondência para categóricas).
- **Variância (S²)** `MÉT` `M1` — S² = Σ(Xᵢ − X̄)²/(n − 1) na versão amostral. Base do desvio padrão e das decomposições de variância na ANOVA e nos modelos multinível.
- **Varimax** → ver **Rotação Varimax**.
- **VaR Operacional** `MÉT` `M10` — Valor em Risco operacional para um nível de confiança desejado: **VaR Operacional = Pior Perda − Perda Esperada Média**.
- **Vendor lock-in** `CONC` `M7` — Dependência de serviços proprietários de um provedor (AWS Lambda, BigQuery, Cosmos DB) que dificulta a migração. Uma das desvantagens da nuvem e um dos motivos para adotar multi-cloud.
- **Vetor Prioridade** `CONC` `M13` — Vetor de pesos dos critérios no AHP, obtido pela normalização dos julgamentos: somar cada coluna da matriz de comparação → dividir cada elemento pelo total da coluna → calcular a média de cada linha.
- **View** `CONC` `M4` — Consulta SQL salva e reutilizável (`create view ... as select ...`), útil para encapsular JOINs recorrentes.
- **VIF (Variance Inflation Factor)** `MÉT` `M18` — Mede quanto a variância de um coeficiente é inflada pela multicolinearidade: VIF = 1/(1 − R²ⱼ), onde R²ⱼ é o R² da regressão de Xⱼ sobre as demais explicativas. **VIF < 5** aceitável; **5-10** moderada; **≥ 10** severa. Python: `statsmodels.stats.outliers_influence.variance_inflation_factor`.
- **VPC (Virtual Private Cloud)** `CONC` `M7` — Fatia privada e isolada da nuvem pública. Organizada em **sub-redes** (pública para servidores web, privada para bancos) e protegida por **grupos de segurança** (firewall da VM, define portas abertas).
- **VPL (Valor Presente Líquido)** `MÉT` `M10` — Soma dos fluxos de caixa descontados menos o investimento inicial. Calculado a partir da cadeia EBITDA → EBIT → NOPAT → FCO, descontada pela taxa de retorno esperada (TMA). Avaliado por análise de sensibilidade, cenários probabilísticos (VPL Esperado, risco, CV) e simulação de Monte Carlo (P5, P50, P95, P(VPL>0)).
- **Vuong (teste de)** `TESTE` `M20` — Define se existe **inflação de zeros** na variável dependente, comparando um modelo "puro" com sua versão inflacionada (Poisson × ZIP, BNeg × ZINB). v = Σ(ln p₂ᵢ − ln p₁ᵢ)/(desvio-padrão·√n). **p ≤ 0,05 → há inflação de zeros** (preferir ZIP/ZINB). É o teste correto para modelos **não encaixados**, onde o LR test não se aplica.

---

## W

- **Walktrap** `ALG` `M8` — Detecção de comunidades baseada em **random walks**: nós da mesma comunidade têm caminhadas aleatórias curtas entre si. Parâmetro `steps` define o comprimento da caminhada. Python: `rede.community_walktrap(steps=4).as_clustering()`.
- **Watermark (marca d'água)** `CONC` `M7` — Mecanismo de streaming que trata o atraso entre o "tempo do evento" e o "tempo de processamento": o *late threshold* define até quando dados atrasados ainda são incluídos em uma janela já fechada.
- **WCSS (Within-Cluster Sum of Squares)** `MÉT` `M14` — Soma dos quadrados das distâncias de cada ponto ao centroide de seu cluster: Σₖ Σ_{xᵢ∈Cₖ} ‖xᵢ − μₖ‖². O K-means minimiza o WCSS, e o **Método de Elbow** o usa para escolher K. Python: `kmeans.inertia_`.
- **Web Scraping** `CONC` `M25` — Extração automatizada de informações: o programa **assume o papel de um navegador**, acessando e interpretando sites. Usado principalmente quando **não há API ou acesso direto** aos dados. Fluxo: CÓDIGO → SITE → HTML → extração. **Scraping ≠ hacking**: é legal desde que ético e sobre dados públicos. Três critérios a atender: **consentimento** (Termos de Serviço), **problemas físicos** (não sobrecarregar/derrubar o servidor) e **intencionalidade** (o que se faz com os dados). Base legal: LGPD Art. 7º, §3º — finalidade, boa-fé e interesse público. Caso emblemático: Pete Warden × Facebook (2010, ~200 milhões de perfis públicos).
- **Window Function (função de janela)** `CONC` `M4` — Função SQL que calcula sobre um conjunto de linhas vizinhas **sem reduzir o resultado**. Exemplos: `row_number() over (partition by idioma order by vendas desc)`, `rank()`, `lag()`/`lead()` (deslocamento) e agregações com `over ()` para calcular percentuais do total.
- **Windowing (streaming)** `CONC` `M7` — Agrupa fluxos contínuos em blocos finitos: **Fixed/Tumbling** (tamanho fixo, sem sobreposição), **Hopping** (tamanho fixo com sobreposição — window size + window period) e **Session** (agrupa eventos por proximidade temporal, separados por um *gap duration* mínimo).
- **WIP Limit (Work in Progress)** `CONC` `M5` — Limite máximo de itens simultâneos em cada coluna do quadro Kanban, para otimizar o *throughput* e evidenciar gargalos.

---

## Y

- **YARN** `FERR` `M7` — Componente do Hadoop responsável pelo **agendamento de jobs e gerenciamento de recursos** do cluster, ao lado do HDFS (armazenamento) e do MapReduce (processamento).

---

## Z

- **Zeros estruturais x amostrais** `CONC` `M20` — Os modelos inflacionados de zeros têm **dois processos geradores de zeros**: os **estruturais**, gerados pela distribuição binária (componente logit/`exog_infl`), e os **amostrais**, gerados pela distribuição de contagem (Poisson ou Poisson-Gama). ⚠️ Confundir o componente de contagem com o componente inflate é erro comum.
- **ZINB (Zero-Inflated Negative Binomial)** `MOD` `M20` — Combinação de uma distribuição **Bernoulli** com uma **Poisson-Gama**, para contagens com **superdispersão E inflação de zeros**. p(Y=0) = plogit + (1−plogit)·[1/(1+αλ)]^(1/α). O parâmetro α (fi), inverso de θ, confirma superdispersão quando é estatisticamente diferente de zero. Python: `sm.ZeroInflatedNegativeBinomialP(y, X1, exog_infl=X2, inflation='logit')`.
- **ZIP (Zero-Inflated Poisson)** `MOD` `M20` — Combinação de uma distribuição **Bernoulli** com uma **Poisson** (Lambert, 1992), para contagens com excesso de zeros mas sem superdispersão. p(Y=0) = plogit + (1−plogit)·e^(−λ); p(Y=m) = (1−plogit)·(e^(−λ)λᵐ/m!) para m ≥ 1. Python: `sm.ZeroInflatedPoisson(y, X1, exog_infl=X2, inflation='logit')`.
- **Z-Score (padronização)** `CONC` `M1` `M14` `M15` — ZXⱼᵢ = (Xⱼᵢ − X̄ⱼ)/sⱼ, resultando em média 0 e desvio padrão 1. **Obrigatório antes da análise de cluster e do cálculo dos fatores quando as variáveis estão em escalas/unidades distintas**; dispensável quando já estão na mesma escala (ex.: notas de 0 a 10). Python: `dados.apply(scipy.stats.zscore, ddof=1)`.

---

## Fluxos de decisão que atravessam o curso

**Escolha do modelo GLM conforme a variável dependente** (M18-M21)

| Variável dependente Y | Modelo |
|---|---|
| Quantitativa contínua | Regressão linear (OLS); Box-Cox se resíduos não normais |
| Binária (0/1) | Regressão logística binária |
| Qualitativa com 3+ categorias | Regressão logística multinomial |
| Contagem, sem superdispersão nem excesso de zeros | Poisson |
| Contagem, com superdispersão | Binomial Negativa (NB2) |
| Contagem, com excesso de zeros | ZIP |
| Contagem, com superdispersão e excesso de zeros | ZINB |
| Qualquer uma acima, em dados aninhados/hierárquicos | Modelagem multinível (HLM2/HLM3) |

**Escolha da técnica não supervisionada** (M14-M17)

| Objetivo | Natureza das variáveis | Técnica |
|---|---|---|
| Agrupar **observações** | Métricas | Análise de Cluster (hierárquica / K-means) |
| Agrupar **variáveis** em fatores | Métricas | Análise Fatorial PCA |
| Associação entre 2 variáveis | Categóricas | ANACOR |
| Associação entre 3+ variáveis | Categóricas | MCA (ACM) |

> As técnicas podem ser **combinadas**: o output de uma serve de input em outra (M17) — cluster como categoria em uma MCA; coordenadas de um mapa perceptual como variáveis em uma PCA; fator da PCA categorizado e testado por qui-quadrado.

**Diagnóstico de um modelo de regressão** (M18)

| Problema | Diagnóstico | Solução |
|---|---|---|
| Relação não linear | R² baixo, resíduos com padrão | Box-Cox, termos quadráticos |
| Resíduos não normais | Shapiro-Francia p < 0,05 | Box-Cox |
| Heterocedasticidade | Breusch-Pagan p < 0,05 | Adicionar variáveis/dummies, Box-Cox |
| Multicolinearidade | VIF > 10 | Remover variável, combinar, PCA |
| Variáveis categóricas | — | n−1 dummies |
| Muitas variáveis | Interpretação difícil | Stepwise + critério teórico |

**Pipeline de séries temporais** (M23)

Leitura e índice de datas → decomposição → separação treino/teste → teste de estacionariedade (ADF/KPSS, `ndiffs`) → diferenciação → identificação de p e q (PACF e ACF) → estimação (manual ou `auto_arima`) → previsão → avaliação fora da amostra (MAPE) → **diagnóstico de resíduos (Ljung-Box, normalidade, ARCH)**.

---

_Dicionário compilado a partir dos resumos das 27 disciplinas deste repositório — MBA em Data Science e Analytics, USP/ESALQ._
