# 🗺️ Mapas Mermaid — Modelos, Testes, Algoritmos e Conceitos

Esquemas visuais que resumem **quando e como** usar o que está no
[DICIONARIO_DATA_SCIENCE.md](DICIONARIO_DATA_SCIENCE.md).
Cada diagrama indica o módulo de origem (`M##`) e reproduz as regras de decisão apresentadas em aula.

> Os diagramas renderizam automaticamente no GitHub, no VS Code (com extensão Markdown Preview Mermaid)
> e em qualquer visualizador com suporte a Mermaid.

---

## 1. Mapa geral do curso

Como as 27 disciplinas se encadeiam, da base estatística à entrega em produção.

```mermaid
flowchart LR
    subgraph BASE["Fundamentos"]
        M1["M1 · Fundamentos de Estatística"]
        M2["M2 · Programação com Python"]
    end

    subgraph PREP["Obtenção e preparação dos dados"]
        M25["M25 · Crawlers e Web Scraping"]
        M4["M4 · Engenharia de Dados / SQL"]
        M24["M24 · Data Wrangling"]
    end

    subgraph NS["Machine Learning não supervisionado"]
        M14["M14 · Análise de Cluster"]
        M15["M15 · Análise Fatorial e PCA"]
        M16["M16 · ANACOR e MCA"]
        M17["M17 · Exercícios aplicados"]
    end

    subgraph SUP["Machine Learning supervisionado"]
        M18["M18 · Regressão Linear"]
        M19["M19 · Modelos Logísticos"]
        M20["M20 · Dados de Contagem"]
        M21["M21 · Modelagem Multinível"]
    end

    subgraph ESP["Dados com estrutura própria"]
        M23["M23 · Séries Temporais"]
        M26["M26 · Text Mining e NLP"]
        M8["M8 · Social Network Analysis"]
    end

    subgraph DEC["Otimização e apoio à decisão"]
        M27["M27 · Pesquisa Operacional"]
        M6["M6 · Computação Evolucionária"]
        M13["M13 · AHP e AHP-Gaussiano"]
        M10["M10 · Analytics e Gestão de Riscos"]
    end

    subgraph ENT["Entrega e operação"]
        M3["M3 · BI e Data Visualization"]
        M22["M22 · Big Data e Deployment"]
        M7["M7 · Cloud Computing"]
    end

    subgraph GOV["Contexto e governança"]
        M12["M12 · LGPD"]
        M5["M5 · Metodologias Ágeis"]
        M11["M11 · Liderança"]
        M9["M9 · Conjuntura Econômica"]
    end

    BASE --> PREP
    PREP --> NS
    PREP --> SUP
    PREP --> ESP
    NS --> SUP
    NS --> DEC
    SUP --> DEC
    ESP --> DEC
    DEC --> ENT
    SUP --> ENT
    GOV -.->|"atravessa todas as etapas"| PREP
    GOV -.-> ENT
```

---

## 2. Escolha do modelo supervisionado pela natureza de Y

A regra central dos módulos 18 a 21 — todos são **GLM**, o que muda é a variável dependente.

```mermaid
flowchart TD
    START["Qual a natureza da variável dependente Y?"] --> Q1{"Y é quantitativa<br/>contínua?"}

    Q1 -->|Sim| LIN["Regressão Linear OLS · M18"]
    Q1 -->|Não| Q2{"Y é qualitativa?"}

    Q2 -->|"Sim — 2 categorias"| LOGB["Regressão Logística Binária · M19"]
    Q2 -->|"Sim — 3+ categorias"| LOGM["Regressão Logística Multinomial · M19<br/>estima k-1 equações"]
    Q2 -->|Não| Q3{"Y é contagem?<br/>discreta, não negativa,<br/>com exposição definida"}

    Q3 -->|Sim| CONT["Ver esquema 4 ·<br/>Poisson / BNeg / ZIP / ZINB · M20"]
    Q3 -->|Não| REV["Revisar a definição de Y"]

    LIN --> Q4{"As observações estão<br/>aninhadas em grupos?"}
    LOGB --> Q4
    CONT --> Q4

    Q4 -->|Não| FIM["Estimar e diagnosticar<br/>ver esquema 3"]
    Q4 -->|Sim| ML["Modelagem Multinível<br/>HLM2 / HLM3 · M21"]

    ML --> ML2{"Há medidas repetidas<br/>no tempo?"}
    ML2 -->|Não| HLM2["HLM2 — 2 níveis"]
    ML2 -->|Sim| HLM3["HLM3 — 3 níveis<br/>tempo dentro de indivíduo dentro de grupo"]

    style LIN fill:#e3f2fd
    style LOGB fill:#e3f2fd
    style LOGM fill:#e3f2fd
    style CONT fill:#fff3e0
    style HLM2 fill:#f3e5f5
    style HLM3 fill:#f3e5f5
```

---

## 3. Diagnóstico de um modelo de regressão linear

Sequência de testes e correções do módulo 18.

```mermaid
flowchart TD
    A["Estimar modelo OLS<br/>com todas as variáveis teoricamente relevantes"] --> B["Analisar summary:<br/>R², R² ajustado, p-valores, AIC/BIC"]

    B --> C{"Teste de Shapiro-Francia<br/>n ≥ 30<br/>H0: resíduos normais"}
    C -->|"p menor que 0,05 — rejeita"| C1["Aplicar Box-Cox em Y<br/>e reestimar"]
    C -->|"p maior que 0,05 — não rejeita"| D
    C1 --> D

    D{"Teste de Breusch-Pagan<br/>H0: homocedasticidade"} -->|"p menor que 0,05 — há heterocedasticidade"| D1["Adicionar variáveis omitidas<br/>ou dummies · Box-Cox<br/>· erros padrão robustos"]
    D -->|"p maior que 0,05 — OK"| E
    D1 --> E

    E{"VIF de cada variável"} -->|"VIF ≥ 10<br/>Tolerância menor que 0,10"| E1["Remover variável, combinar<br/>ou aplicar PCA antes da regressão"]
    E -->|"VIF menor que 5"| F
    E1 --> F

    F["Stepwise<br/>pvalue_limit = 0,05"] --> G["Revalidar pressupostos<br/>no modelo final"]
    G --> H["Predições<br/>⚠️ reverter Box-Cox se aplicado"]

    style C fill:#ffebee
    style D fill:#ffebee
    style E fill:#ffebee
    style H fill:#e8f5e9
```

---

## 4. Modelos para dados de contagem

Fluxo de decisão entre Poisson, Binomial Negativa, ZIP e ZINB (M20).

```mermaid
flowchart TD
    A["Y é contagem<br/>discreta, não negativa, com exposição"] --> B["Estimar modelo Poisson<br/>ln λ = β0 + β1X1 + ... + βkXk"]

    B --> C{"Teste de superdispersão<br/>Cameron e Trivedi 1990<br/>H0: equidispersão"}
    C -->|"p maior que 0,05<br/>equidispersão"| D["Poisson é adequado"]
    C -->|"p ≤ 0,05<br/>superdispersão"| E["Estimar Binomial Negativa NB2<br/>Var Y = λ · 1 + α·λ"]

    D --> F{"Excesso de zeros em Y?<br/>histograma + teste de Vuong<br/>Poisson vs ZIP"}
    E --> G{"Excesso de zeros em Y?<br/>teste de Vuong<br/>BNeg vs ZINB"}

    F -->|"Não há inflação"| R1["POISSON"]
    F -->|"Há inflação"| R2["ZIP<br/>Bernoulli + Poisson"]
    G -->|"Não há inflação"| R3["BINOMIAL NEGATIVA"]
    G -->|"Há inflação"| R4["ZINB<br/>Bernoulli + Poisson-Gama"]

    R1 --> H["Comparar Log-Likelihoods<br/>e usar LR test entre modelos encaixados"]
    R2 --> H
    R3 --> H
    R4 --> H

    style R1 fill:#e8f5e9
    style R2 fill:#fff9c4
    style R3 fill:#ffe0b2
    style R4 fill:#ffccbc
```

> ⚠️ Erros comuns do módulo: usar OLS em variável de contagem (mesmo com Box-Cox, os resíduos continuam não normais);
> assumir equidispersão sem testar; e usar LR test para comparar Poisson × ZIP (modelos **não encaixados** → teste de Vuong).

---

## 5. Modelagem multinível — por que e como

```mermaid
flowchart TD
    A["Dados com estrutura hierárquica<br/>alunos em escolas, empresas em países,<br/>medidas repetidas em indivíduos"] --> B{"OLS único resolve?"}

    B -->|"Não"| B1["Mistura efeitos individuais<br/>e efeitos de grupo<br/>→ estimativas viesadas e resíduos correlacionados"]
    B --> B2{"Dummies de grupo resolvem?"}
    B2 -->|"Não"| B3["Ajustam só o intercepto<br/>não modelam variação de inclinações<br/>nem separam variância intra e entre grupos"]

    B1 --> C["Modelo Nulo<br/>Y = γ00 + ν0j + ε"]
    B3 --> C

    C --> D{"Var ν0j é estatisticamente<br/>diferente de zero?<br/>calcular o ICC"}
    D -->|"Não"| D1["Estrutura de grupo irrelevante<br/>OLS tradicional bastaria"]
    D -->|"Sim"| E["Modelo com interceptos<br/>e inclinações aleatórios<br/>adiciona variável de Nível 1"]

    E --> F["Modelo Final<br/>adiciona variável de Nível 2<br/>e interação cross-level"]
    F --> G{"Há medidas repetidas<br/>no tempo?"}
    G -->|Não| H2["HLM2"]
    G -->|Sim| H3["HLM3<br/>Modelo Nulo → Growth Model → Modelo Final"]

    H2 --> I["Comparar fitted values<br/>OLS × OLS com dummies × HLM<br/>contra a diagonal de 45°"]
    H3 --> I

    style D fill:#ffebee
    style H2 fill:#f3e5f5
    style H3 fill:#f3e5f5
```

---

## 6. Escolha da técnica não supervisionada

```mermaid
flowchart TD
    A["Objetivo exploratório<br/>sem variável dependente Y"] --> B{"O que se quer agrupar<br/>ou associar?"}

    B -->|"Agrupar OBSERVAÇÕES"| C{"Variáveis métricas?"}
    C -->|Sim| D["Análise de Cluster · M14"]
    C -->|Não| E["Categorizar as variáveis<br/>e usar Análise de Correspondência"]

    B -->|"Agrupar VARIÁVEIS em fatores"| F{"Variáveis métricas<br/>e correlacionadas?"}
    F -->|Sim| G["Análise Fatorial PCA · M15"]
    F -->|Não| E

    B -->|"Associação entre variáveis"| H{"Quantas variáveis<br/>categóricas?"}
    H -->|"Duas"| I["ANACOR · M16"]
    H -->|"Três ou mais"| J["MCA / ACM · M16"]

    D --> K["Uso conjunto · M17"]
    G --> K
    I --> K
    J --> K
    K --> L["O output de uma técnica<br/>vira input de outra:<br/>cluster como categoria na MCA ·<br/>coordenadas do mapa perceptual na PCA ·<br/>fator da PCA categorizado e testado por qui-quadrado"]

    style D fill:#e1f5fe
    style G fill:#e1f5fe
    style I fill:#e1f5fe
    style J fill:#e1f5fe
    style L fill:#fff9c4
```

> Característica comum às quatro: são **exploratórias**, avaliam interdependência,
> **não servem para inferência** fora da amostra e devem ser **refeitas** se observações ou variáveis mudarem.

---

## 7. Análise de Cluster — fluxo completo

```mermaid
flowchart TD
    A["Variáveis métricas selecionadas"] --> B{"Estão na mesma<br/>unidade/escala?"}
    B -->|Não| C["Padronizar por Z-Score<br/>média 0, desvio 1"]
    B -->|"Sim — ex.: notas de 0 a 10"| D
    C --> D["Escolher a medida de dissimilaridade"]

    D --> D1["Euclidiana · Euclidiana quadrática<br/>Manhattan · Chebychev · Canberra"]

    D1 --> E{"Método"}

    E -->|"Hierárquico aglomerativo"| F["Escolher o encadeamento:<br/>Único mínimo · Completo máximo · Médio"]
    F --> G["Dendrograma"]
    G --> H["Definir K observando<br/>os saltos de distância<br/>e comparando encadeamentos"]

    E -->|"Não hierárquico K-means"| I["Definir K a priori"]
    I --> J["Método de Elbow<br/>menor WCSS marginal"]
    I --> K["Método da Silhueta<br/>maior valor médio, próximo de 1"]
    J --> L["Rodar K-means<br/>centroides recalculados até estabilizar"]
    K --> L

    H --> M["Validar com ANOVA / Teste F<br/>H0: mesma média em todos os clusters<br/>maior F significante = variável mais discriminante"]
    L --> M
    M --> N["Interpretar centroides<br/>e médias por cluster"]

    style C fill:#fff3e0
    style M fill:#ffebee
    style N fill:#e8f5e9
```

> O output do método hierárquico pode servir de **input** para o K-means (definição inicial de K).
> A técnica é **muito sensível a outliers** e o dendrograma fica ilegível com muitas observações — nesse caso, K-means.

---

## 8. Análise Fatorial PCA — fluxo completo

```mermaid
flowchart TD
    A["Variáveis métricas"] --> B["Matriz de correlações de Pearson<br/>heatmap + p-valores"]
    B --> C{"Teste de Esfericidade de Bartlett<br/>H0: ρ = I"}
    C -->|"Não rejeita H0"| C1["Correlações próximas de zero<br/>→ análise fatorial NÃO é aplicável"]
    C -->|"Rejeita H0 — p muito baixo"| D["Extrair todos os fatores possíveis<br/>n_factors = nº de variáveis"]

    D --> E["Autovalores λ<br/>= variância compartilhada por fator"]
    E --> F{"Critério de Kaiser<br/>raiz latente"}
    F --> G["Reter apenas fatores<br/>com autovalor maior que 1"]
    G --> H["Reestimar com o nº de fatores retido"]

    H --> I["Cargas fatoriais<br/>correlação fator × variável original"]
    H --> J["Comunalidades<br/>variância retida por variável"]
    H --> K["Scores fatoriais<br/>pesos das variáveis padronizadas"]

    I --> L{"Loading plot ajuda<br/>a interpretar?"}
    L -->|Não| M["Rotação Varimax<br/>ortogonal — redistribui cargas<br/>comunalidades não mudam"]
    L -->|Sim| N
    M --> N["Extrair os fatores para as observações<br/>fatores são ortogonais entre si"]

    N --> O1["Redução estrutural"]
    N --> O2["Análise de construtos"]
    N --> O3["Ranking<br/>soma ponderada pela variância de cada fator"]
    N --> O4["Fatores ortogonais como input<br/>em modelos supervisionados"]

    style C fill:#ffebee
    style F fill:#fff3e0
    style O3 fill:#e8f5e9
    style O4 fill:#e8f5e9
```

---

## 9. Análise de Correspondência — ANACOR e MCA

```mermaid
flowchart TD
    A["Variáveis categóricas<br/>métricas devem ser categorizadas antes — pd.qcut"] --> B{"Quantas variáveis?"}

    B -->|"Duas"| C["ANACOR"]
    B -->|"Três ou mais"| D["MCA / ACM"]

    C --> C1["Tabela de contingência<br/>frequências observadas"]
    C1 --> C2["Frequências esperadas<br/>ΣL · ΣC / N"]
    C2 --> C3["Resíduos = observada - esperada"]
    C3 --> C4{"Teste qui-quadrado<br/>H0: associação aleatória<br/>gl = I-1 · J-1"}
    C4 -->|"Não rejeita"| C5["Sem associação significativa<br/>→ não faz sentido o mapa"]
    C4 -->|"Rejeita"| C6["Resíduos padronizados ajustados<br/>⚠️ valor absoluto maior que 1,96<br/>= associação significativa na célula"]
    C6 --> C7["Autovalores = inércias parciais<br/>inércia total = χ² / N"]
    C7 --> C8["Massas · autovetores · coordenadas"]
    C8 --> C9["MAPA PERCEPTUAL<br/>interpretar pela proximidade"]

    D --> D1["Teste qui-quadrado par a par<br/>excluir variáveis sem associação<br/>com nenhuma outra"]
    D1 --> D2{"Método de obtenção"}
    D2 -->|"Matriz binária Z"| D3["Coordenadas-padrão<br/>dimensões = J - Q"]
    D2 -->|"Matriz de Burt B = Z'Z"| D4["Coordenadas principais"]
    D3 --> D5["Reter dimensões acima<br/>da inércia média"]
    D4 --> D5
    D5 --> C9

    style C4 fill:#ffebee
    style C6 fill:#fff3e0
    style C9 fill:#e8f5e9
```

---

## 10. Testes estatísticos por finalidade

Todos os testes do dicionário, organizados pela pergunta que respondem.

```mermaid
flowchart LR
    T["Testes estatísticos<br/>do curso"]

    T --> A["Comparar médias<br/>e variâncias · M1"]
    A --> A1["Teste Z — σ conhecido"]
    A --> A2["Teste t — σ desconhecido"]
    A --> A3["Teste t — duas amostras independentes"]
    A --> A4["Teste F — comparação de variâncias"]
    A --> A5["ANOVA / Teste F de um fator · M14<br/>valida clusters"]

    T --> B["Associação entre<br/>variáveis"]
    B --> B1["Qui-quadrado de associação · M1/M16"]
    B --> B2["Teste t da correlação de Pearson · M1"]
    B --> B3["Qui-quadrado de aderência<br/>uma amostra · M1"]

    T --> C["Adequação de<br/>técnica multivariada"]
    C --> C1["Bartlett — esfericidade · M15<br/>H0: ρ = I"]

    T --> D["Pressupostos da<br/>regressão · M18"]
    D --> D1["Shapiro-Francia — normalidade n≥30"]
    D --> D2["Shapiro-Wilk — normalidade n menor que 30"]
    D --> D3["Breusch-Pagan — heterocedasticidade"]

    T --> E["Seleção entre<br/>modelos"]
    E --> E1["LR test — modelos encaixados · M19/M20"]
    E --> E2["Vuong — não encaixados / inflação de zeros · M20"]
    E --> E3["Cameron e Trivedi — superdispersão · M20"]

    T --> F["Séries temporais · M23"]
    F --> F1["ADF — H0: NÃO estacionária"]
    F --> F2["KPSS — H0: É estacionária"]
    F --> F3["Phillips-Perron — raiz unitária"]
    F --> F4["Ljung-Box — autocorrelação dos resíduos"]
    F --> F5["Kolmogorov-Smirnov — normalidade"]
    F --> F6["Jarque-Bera — normalidade por assimetria e curtose"]
    F --> F7["Teste ARCH — heterocedasticidade condicional"]

    style A fill:#e3f2fd
    style B fill:#e8f5e9
    style C fill:#fff3e0
    style D fill:#ffebee
    style E fill:#f3e5f5
    style F fill:#e0f7fa
```

> ⚠️ Atenção às hipóteses invertidas: no **ADF**, H0 é "não estacionária"; no **KPSS**, H0 é "estacionária".
> No **Ljung-Box**, o resultado desejado é **não rejeitar** H0 (resíduos independentes).

---

## 11. Séries temporais — pipeline completo

```mermaid
flowchart TD
    A["Ler a base e criar o índice de datas<br/>pd.Series com date_range · freq correta"] --> B["Análise exploratória<br/>plot, descritivas, boxplot mensal, month plot"]
    B --> C["Decomposição<br/>Tendência · Ciclo · Sazonalidade · Erro"]
    C --> C1{"Amplitude sazonal<br/>cresce com o nível?"}
    C1 -->|Não| C2["Modelo ADITIVO<br/>Y = T + C + S + E"]
    C1 -->|Sim| C3["Modelo MULTIPLICATIVO<br/>Y = T · C · S · E"]

    C2 --> D["Separar treino e teste"]
    C3 --> D

    D --> E{"Qual família de modelo?"}

    E -->|"Métodos simples"| F["Naive · Naive Sazonal<br/>Mean · Drift"]

    E -->|"Suavização exponencial"| G{"A série tem..."}
    G -->|"nem tendência nem sazonalidade"| G1["SES"]
    G -->|"tendência, sem sazonalidade"| G2["Holt"]
    G -->|"tendência e sazonalidade"| G3["Holt-Winters<br/>aditivo ou multiplicativo"]
    G1 --> G4["Seleção automática do ETS por AIC"]
    G2 --> G4
    G3 --> G4

    E -->|"Box-Jenkins"| H["Testar estacionariedade<br/>ADF / KPSS · ndiffs"]
    H --> H1{"Série estacionária?"}
    H1 -->|Não| H2["Diferenciar → define d"]
    H1 -->|Sim| H3
    H2 --> H3["Ler ACF e PACF"]
    H3 --> H4["p ← PACF · q ← ACF"]
    H4 --> H5{"Há sazonalidade?"}
    H5 -->|Não| H6["ARIMA p,d,q"]
    H5 -->|Sim| H7["SARIMA p,d,q · P,D,Q,s"]
    H6 --> H8["Estimar manualmente<br/>ou via auto_arima"]
    H7 --> H8

    F --> I["Prever no conjunto de teste"]
    G4 --> I
    H8 --> I

    I --> J["Comparar todos por MAPE<br/>também ME, MAE, RMSE, MPE, Theil's U"]
    J --> K["Diagnóstico dos resíduos do vencedor:<br/>Ljung-Box · normalidade KS/Shapiro/Jarque-Bera · teste ARCH"]
    K --> L{"Resíduos são<br/>ruído branco?"}
    L -->|Não| H3
    L -->|Sim| M["⚠️ Reverter a diferenciação<br/>e apresentar previsões com IC"]

    style H1 fill:#ffebee
    style L fill:#ffebee
    style M fill:#e8f5e9
```

### Identificação de p e q pelos correlogramas

```mermaid
flowchart LR
    A["Padrão observado"] --> B{"FAC / ACF"}
    B -->|"Decai exponencialmente"| C{"FACP / PACF"}
    B -->|"Corta abruptamente<br/>após a defasagem q"| D["MA q<br/>PACF decai suavemente"]
    C -->|"Corta abruptamente<br/>após a defasagem p"| E["AR p"]
    C -->|"Também decai"| F["ARMA p,q"]

    style D fill:#e3f2fd
    style E fill:#e8f5e9
    style F fill:#fff3e0
```

---

## 12. Métricas de avaliação por tipo de problema

```mermaid
flowchart TD
    M["Como avaliar o modelo?"]

    M --> A["REGRESSÃO · M18"]
    A --> A1["R² · R² ajustado"]
    A --> A2["AIC · BIC — menor é melhor"]
    A --> A3["Erro padrão e p-valor dos coeficientes"]

    M --> B["CLASSIFICAÇÃO · M19"]
    B --> B1["Matriz de confusão<br/>TP · TN · FP · FN"]
    B1 --> B2["Sensitividade = TP/TP+FN"]
    B1 --> B3["Especificidade = TN/TN+FP"]
    B1 --> B4["Acurácia — ⚠️ engana em classes desbalanceadas"]
    B --> B5["Curva ROC → AUC<br/>0,5 aleatório · maior que 0,8 excelente"]
    B5 --> B6["GINI = 2·AUC - 1"]
    B --> B7["Pseudo R² McFadden<br/>0,2-0,4 excelente"]
    B --> B8["Log-Likelihood e LR test"]

    M --> C["CONTAGEM · M20"]
    C --> C1["Log-Likelihood — menos negativo é melhor"]
    C --> C2["LR test e teste de Vuong"]

    M --> D["PREVISÃO / SÉRIES · M23"]
    D --> D1["ME e MPE — medem viés"]
    D --> D2["MAE · RMSE — medem magnitude"]
    D --> D3["MAPE — comparação padrão fora da amostra"]
    D --> D4["Theil's U — menor que 1 melhor que passeio aleatório"]

    M --> E["CLUSTER · M14"]
    E --> E1["WCSS — método de Elbow"]
    E --> E2["Silhueta — próximo de 1"]
    E --> E3["Estatística F da ANOVA por variável"]

    M --> F["REDES · M8"]
    F --> F1["Modularidade — maior que 0,3 significativa"]

    style B fill:#e3f2fd
    style D fill:#e0f7fa
    style E fill:#e1f5fe
```

---

## 13. Algoritmo Genético — ciclo e operadores

```mermaid
flowchart TD
    A["Problema de otimização<br/>sem solução analítica viável"] --> B["Escolher a REPRESENTAÇÃO"]

    B --> B1["Binária → Problema da Mochila 0/1"]
    B --> B2["Real → Problema da Ração / Mistura"]
    B --> B3["Permutação → Caixeiro Viajante TSP"]
    B --> B4["Árvore → Programação Genética"]

    B1 --> C["Definir a função de FITNESS"]
    B2 --> C
    B3 --> C
    B4 --> C

    C --> D["Gerar população inicial aleatória<br/>50 a 500 indivíduos"]
    D --> E["Avaliar o fitness de cada indivíduo"]
    E --> F["SELEÇÃO dos pais<br/>Roleta · Torneio k=2 · Rank-based"]
    F --> G["CROSSOVER — prob. 0,6 a 0,9<br/>one-point · two-point · uniform<br/>aritmético · PMX"]
    G --> H["MUTAÇÃO — prob. ≈ 1/L<br/>bit flip · gaussiana · swap · adaptativa"]
    H --> I["ELITISMO<br/>preservar o top 1-5%"]
    I --> J{"Critério de parada?<br/>nº de gerações ou convergência"}
    J -->|Não| E
    J -->|Sim| K["Melhor solução encontrada"]

    K --> L["Plotar fitness máximo e médio por geração<br/>e testar múltiplas seeds"]

    style F fill:#fff3e0
    style G fill:#fff3e0
    style H fill:#fff3e0
    style I fill:#fff3e0
    style K fill:#e8f5e9
```

### Equilíbrio exploration × exploitation

```mermaid
flowchart LR
    A["Convergência prematura<br/>população perde diversidade"] -->|"aumentar mutação<br/>aumentar população"| B["EQUILÍBRIO"]
    C["Busca vira aleatória<br/>perde boas soluções"] -->|"reduzir mutação<br/>usar elitismo"| B
    B --> D["Exploração = diversidade<br/>Explotação = refinamento"]

    style B fill:#e8f5e9
```

---

## 14. Pesquisa Operacional e apoio multicritério

```mermaid
flowchart TD
    A["Problema de decisão"] --> B{"Existe uma função objetivo<br/>única a otimizar?"}

    B -->|Sim| C["MODELAGEM DE OTIMIZAÇÃO · M27"]
    C --> C1["1. Variáveis de decisão — o que decidir"]
    C1 --> C2["2. Função objetivo — maximizar ou minimizar"]
    C2 --> C3["3. Restrições — limitação de recursos ·<br/>desempenho mínimo · conservação"]
    C3 --> C4{"Natureza das variáveis<br/>e das equações"}
    C4 -->|"Contínuas, tudo linear"| P1["PL"]
    C4 -->|"Inteiras"| P2["PLI"]
    C4 -->|"Contínuas + inteiras"| P3["PLIM"]
    C4 -->|"Termos não lineares<br/>x², x1·x2, sen x"| P4["PNL"]
    P1 --> S["Resolver: Método Simplex ·<br/>PuLP · scipy.optimize.linprog"]
    P2 --> S
    P3 --> S
    P4 --> S2["Meta-heurísticas · M6<br/>Algoritmos Genéticos"]

    B -->|"Não — múltiplos critérios conflitantes"| D["MCDM · M13"]
    D --> D1["Montar a Matriz de Decisão<br/>alternativas × critérios"]
    D1 --> D2{"Como obter os pesos<br/>dos critérios?"}
    D2 -->|"Julgamento do decisor"| E["AHP clássico"]
    D2 -->|"A partir dos dados"| F["AHP-Gaussiano"]

    E --> E1["Comparação par a par<br/>escala de Saaty 1 a 9"]
    E1 --> E2["Vetor prioridade"]
    E2 --> E3{"CR = CI/RI menor que 10%?"}
    E3 -->|Não| E4["Revisar julgamentos<br/>violação de transitividade"]
    E4 --> E1
    E3 -->|Sim| G

    F --> F1["Normalizar<br/>custo: 1/aij · lucro: aij/Σaij"]
    F1 --> F2["Fator Gaussiano por critério<br/>FG = desvio padrão / média = CV"]
    F2 --> F3["Normalizar FG → peso<br/>sem teste de consistência"]
    F3 --> G["Agregar: Σ valor normalizado × peso"]

    G --> H["RANKING FINAL das alternativas"]

    style C fill:#e3f2fd
    style D fill:#f3e5f5
    style H fill:#e8f5e9
```

---

## 15. Text Mining, NLP e Análise de Sentimentos

```mermaid
flowchart TD
    A["01 · COLETA<br/>APIs, reviews, logs, web scraping"] --> B["02 · PRÉ-PROCESSAMENTO"]

    B --> B1["Lowercasing"]
    B1 --> B2["Remoção de pontuação"]
    B2 --> B3["Tokenização"]
    B3 --> B4["Remoção de stopwords<br/>⚠️ cuidado com negações"]
    B4 --> B5{"Reduzir palavras<br/>à forma base?"}
    B5 -->|"Rápido e bruto"| B6["Stemming — RSLPStemmer<br/>amasse → am"]
    B5 -->|"Preciso, palavra válida"| B7["Lematização — spaCy<br/>amasse → amar"]

    B6 --> C["03 · EXTRAÇÃO DE CARACTERÍSTICAS<br/>TF-IDF · CountVectorizer · Word Embeddings"]
    B7 --> C

    C --> D{"04 · GRANULARIDADE<br/>definir ANTES da arquitetura"}
    D -->|"Texto inteiro"| D1["Nível de Documento<br/>baixo detalhamento"]
    D -->|"Cada sentença"| D2["Nível de Frase<br/>subjetiva/objetiva → polaridade"]
    D -->|"Características específicas"| D3["Nível de Aspecto — ABSA<br/>múltiplos sentimentos no mesmo texto"]

    D1 --> E["05 · CLASSIFICAÇÃO<br/>léxico · ML clássico · Deep Learning"]
    D2 --> E
    D3 --> E

    E --> F["Polaridade<br/>+2 muito positivo a -2 muito negativo"]
    F --> G["Avaliação<br/>classification_report · matriz de confusão"]

    G --> H["Desafios em aberto:<br/>sarcasmo · ironia · emojis<br/>viés de fonte · ambiguidade<br/>→ multimodalidade texto+voz+imagem"]

    style B fill:#fff3e0
    style D fill:#e3f2fd
    style H fill:#ffebee
```

> Princípio central do módulo: **"qualidade do dado > qualquer algoritmo de ponta"**.
> O pré-processamento impacta diretamente a acurácia final.

---

## 16. Social Network Analysis — métricas e comunidades

```mermaid
flowchart TD
    A["Grafo<br/>nós · arestas · pesos · direção"] --> B["MÉTRICAS GLOBAIS<br/>caracterizam a rede"]
    A --> C["MÉTRICAS LOCAIS<br/>caracterizam cada nó"]
    A --> D["DETECÇÃO DE COMUNIDADES"]

    B --> B1["Densidade — quão conectada"]
    B --> B2["Diâmetro — maior caminho curto"]
    B --> B3["Raio — menor excentricidade"]
    B --> B4["Comprimento médio do caminho"]

    C --> C1["Grau — popularidade → HUB"]
    C --> C2["Closeness — rapidez de alcance"]
    C --> C3["Betweenness — controle de fluxo → BROKER"]
    C --> C4["Coef. de clustering — vizinhos conectados"]
    C --> C5["Excentricidade — periferia"]
    C --> C6["Ponto de articulação — BRIDGE<br/>sua remoção fragmenta a rede"]

    D --> D1["Edge Betweenness"]
    D --> D2["Fast Greedy — rápido, redes grandes"]
    D --> D3["Walktrap — random walks"]
    D --> D4["Louvain / Multilevel"]
    D --> D5["Label Propagation — rápido, não determinístico"]
    D --> D6["Spin Glass — redes pequenas/médias"]

    D1 --> E{"Comparar pela MODULARIDADE<br/>maior que 0,3 significativa<br/>maior que 0,7 forte"}
    D2 --> E
    D3 --> E
    D4 --> E
    D5 --> E
    D6 --> E

    E --> F["Recalcular as métricas locais<br/>DENTRO de cada comunidade<br/>e comparar com as métricas gerais"]

    B1 --> G["Tipos de rede:<br/>Small-world — alto clustering, caminho curto<br/>Scale-free — poucos hubs, lei de potência"]
    C1 --> G

    style E fill:#fff3e0
    style G fill:#e1f5fe
```

---

## 17. Analytics e Gestão de Riscos

```mermaid
flowchart TD
    R["Gestão de Riscos · M10"]

    R --> A["RISCO DE MERCADO"]
    A --> A1["Retorno discreto Pt/Pt-1 - 1<br/>ou contínuo ln Pt/Pt-1"]
    A1 --> A2["Risco = volatilidade = desvio padrão"]
    A2 --> A3["Carteira: risco depende da CORRELAÇÃO<br/>correlação negativa → diversificação"]
    A3 --> A4["Fronteira Eficiente de Markowitz"]
    A4 --> A5["Carteira de mínimo risco"]
    A4 --> A6["Carteira tangente<br/>máximo Índice de Sharpe"]

    R --> B["RISCO DE CRÉDITO"]
    B --> B1["PD — probabilidade de default"]
    B --> B2["EAD/EC — exposição no default"]
    B --> B3["LGD — perda dado o default = 1 - recuperação"]
    B1 --> B4["Perda de Crédito = b × EC × PD"]
    B2 --> B4
    B3 --> B4
    B4 --> B5["Perda Esperada · Não Esperada · Excepcional"]

    R --> C["RISCO OPERACIONAL"]
    C --> C1["Frequência n × Severidade S<br/>distribuição empírica de perdas"]
    C1 --> C2["VaR Operacional =<br/>Pior Perda - Perda Esperada Média"]

    A5 --> D["BASILEIA<br/>Índice = PR / APR ≥ 8%"]
    B5 --> D
    C2 --> D

    R --> E["RISCO DE PROJETO"]
    E --> E1["Fluxo de caixa<br/>EBITDA → EBIT → NOPAT → FCO"]
    E1 --> E2["VPL determinístico"]
    E2 --> E3["Análise de Sensibilidade<br/>→ Diagrama Tornado"]
    E2 --> E4["Simulação de Monte Carlo<br/>Triangular · PERT · Normal"]
    E4 --> E5["P5 · P50 · P95 · P VPL maior que 0"]
    E2 --> E6["Cenários com probabilidades<br/>VPL Esperado · Risco · CV"]

    style A fill:#e3f2fd
    style B fill:#fff3e0
    style C fill:#ffebee
    style E fill:#e8f5e9
```

---

## 18. Do dado ao modelo em produção — CRISP-DM e MLOps

```mermaid
flowchart LR
    subgraph CRISP["CRISP-DM · M22 e M24"]
        A["Entendimento<br/>do Negócio"] <--> B["Entendimento<br/>dos Dados"]
        B --> C["Preparação dos Dados<br/>= Data Wrangling"]
        C --> D["Modelagem"]
        D --> E["Avaliação"]
        E --> F["Deployment"]
        E -.->|"não atingiu o objetivo"| A
    end

    subgraph WRANG["6 etapas do Data Wrangling · M24"]
        W1["Discovery"] --> W2["Structuring"] --> W3["Cleaning"] --> W4["Enriching"] --> W5["Verifying"] --> W6["Publishing"]
    end

    subgraph MLOPS["Workflow de MLOps · M22"]
        P0["0 · Data Preparation"] --> P1["1 · EDA"] --> P2["2 · Feature Engineering"] --> P3["3 · Model Training"] --> P4["4 · Model Validation"] --> P5["5 · Deployment"] --> P6["6 · Monitoring"]
        P6 -.->|"data drift · re-treinamento"| P0
    end

    C -.-> WRANG
    F -.-> MLOPS

    style CRISP fill:#e3f2fd
    style WRANG fill:#fff3e0
    style MLOPS fill:#e8f5e9
```

### Versionamento e serving com MLflow

```mermaid
flowchart LR
    A["Treinar modelo<br/>mlflow.start_run"] --> B["MLflow Tracking<br/>params · metrics · artifacts · signature"]
    B --> C["MLflow Model Registry"]
    C --> D["Staging"]
    D --> E["Produção"]
    E --> F["Arquivado"]

    E --> G{"Como servir?"}
    G -->|"mlflow deployments"| H["Container Docker →<br/>Databricks Model Serving · SageMaker ·<br/>Kubernetes · Azure ML"]
    G -->|"mlflow models serve"| I["Flask local<br/>ou batch prediction"]

    H --> J["Proxy reverso NGINX<br/>balanceia entre múltiplas versões"]
    I --> J
    J --> K["Monitoramento<br/>⚠️ data drift"]
    K -.->|"re-treinar"| A

    style C fill:#fff3e0
    style E fill:#e8f5e9
    style K fill:#ffebee
```

---

## 19. Arquitetura de dados e Big Data

```mermaid
flowchart TD
    A["Os 5V's do Big Data<br/>Volume · Velocidade · Variedade · Veracidade · Valor"] --> B{"Como processar?"}

    B -->|"Lote, tolerante a I/O em disco"| C["Hadoop<br/>HDFS + MapReduce + YARN"]
    B -->|"Velocidade, in-memory"| D["Apache Spark<br/>RDD · DataFrame · DAG"]
    D --> D1["Spark SQL — Catalyst + Tungsten"]
    D --> D2["MLlib — machine learning"]
    D --> D3["Spark Streaming — tempo real"]

    B -->|"Fluxo contínuo de eventos"| E["Kafka<br/>tópicos · partições · brokers<br/>Connect e Streams"]
    E --> E1["Windowing<br/>Tumbling · Hopping · Session<br/>+ watermark para dados atrasados"]
    E --> E2["CDC — Change Data Capture<br/>baseado em log, gatilho ou consulta"]

    C --> F["EVOLUÇÃO DAS ARQUITETURAS"]
    D --> F
    E --> F

    F --> F1["Data Warehouse<br/>só estruturados → BI"]
    F1 --> F2["Data Lake<br/>todos os formatos → BI + DS/ML"]
    F2 --> F3["Data Lakehouse<br/>unificado com camada de<br/>metadados e governança"]

    F3 --> G["Arquitetura Medalhão"]
    G --> G1["BRONZE — ingestão bruta e histórico"]
    G1 --> G2["SILVER — filtrado, limpo, enriquecido"]
    G2 --> G3["GOLD — agregações de negócio"]
    G3 --> H["Streaming Analytics · BI · DS/ML · Data Sharing"]

    G -.->|"sustentada por"| I["Data Quality e Governança"]

    F3 --> J["Otimizações"]
    J --> J1["Formatos colunares<br/>Parquet · ORC — até 87% menor, 34× mais rápido"]
    J --> J2["Particionamento por tempo<br/>partition pruning"]
    J --> J3["Apache Iceberg — formato de tabela<br/>ACID · evolução de esquema · time travel"]

    style A fill:#e3f2fd
    style G fill:#fff3e0
    style H fill:#e8f5e9
```

---

## 20. Governança, ética e conformidade

Conceitos que atravessam todo o ciclo de dados (M3, M7, M12, M25).

```mermaid
flowchart TD
    A["Dado pessoal em qualquer etapa do ciclo"] --> B["LGPD · Lei 13.709/2018 · M12"]

    B --> C["Agentes<br/>Titular · Controlador · Operador ·<br/>Encarregado DPO · ANPD"]
    B --> D["10 Princípios Art. 6º<br/>finalidade · adequação · necessidade ·<br/>não discriminação · livre acesso · transparência ·<br/>segurança · prevenção · qualidade · responsabilização"]
    B --> E["Bases legais Art. 7º<br/>consentimento · legítimo interesse ·<br/>obrigação legal · execução de contrato ·<br/>pesquisa · proteção à vida · tutela da saúde"]
    B --> F["Direitos do titular Art. 18<br/>acesso · correção · anonimização ·<br/>portabilidade · revogação ·<br/>revisão de decisão automatizada"]

    A --> G["Coleta na web · M25"]
    G --> G1{"Três critérios antes<br/>de qualquer scraping"}
    G1 --> G2["Consentimento — Termos de Serviço"]
    G1 --> G3["Problemas físicos — não sobrecarregar"]
    G1 --> G4["Intencionalidade — o que se faz com os dados"]
    G1 -.->|"Art. 7º §3º"| G5["Dados públicos: avaliar<br/>finalidade, boa-fé e interesse público"]

    A --> H["Governança de Dados · M3"]
    H --> H1["Pessoas · Processos · Tecnologia"]
    H --> H2["Riscos: Shadow IT · vazamentos ·<br/>fraude · cyber attacks"]
    H --> H3["NDA — acordo de confidencialidade"]

    A --> I["Segurança na nuvem · M7"]
    I --> I1["Modelo de Responsabilidade Compartilhada<br/>provedor: segurança DA nuvem<br/>cliente: segurança NA nuvem"]
    I --> I2["IAM: Autenticação · Autorização · Auditoria"]
    I2 --> I3["Princípio do Menor Privilégio"]

    style B fill:#ffebee
    style G1 fill:#fff3e0
    style I3 fill:#e8f5e9
```

---

## Como navegar

| Se a pergunta é… | Vá para o esquema |
|---|---|
| Qual modelo usar para meu Y? | 2 · 4 · 5 |
| Meu modelo de regressão é válido? | 3 |
| Quero explorar dados sem variável resposta | 6 · 7 · 8 · 9 |
| Que teste aplicar aqui? | 10 |
| Como prever uma série no tempo? | 11 |
| Como avaliar o resultado? | 12 |
| Como otimizar ou decidir entre alternativas? | 13 · 14 |
| Como tratar texto ou redes? | 15 · 16 |
| Como medir risco financeiro? | 17 |
| Como levar o modelo para produção? | 18 · 19 |
| O que preciso respeitar juridicamente? | 20 |

---

_Esquemas derivados do [DICIONARIO_DATA_SCIENCE.md](DICIONARIO_DATA_SCIENCE.md) e dos resumos das 27 disciplinas — MBA em Data Science e Analytics, USP/ESALQ._
