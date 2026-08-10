# 🧬 Resumo: Computação Evolucionária

**MBA Data Science e Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos da **computação evolucionária** e suas aplicações em problemas de otimização complexos. Dominar algoritmos genéticos, estratégias evolutivas, otimização por enxame de partículas (PSO) e programação genética para resolver problemas onde métodos tradicionais são ineficientes. Aplicar técnicas evolutivas em machine learning, feature selection, hyperparameter tuning e neural architecture search (NAS).

---

## 📚 Conteúdo Principal

### 1. **Fundamentos de Computação Evolucionária**

#### 1.1 Inspiração Biológica

- **Teoria da Evolução (Darwin):**
  - Seleção natural: sobrevivência dos mais aptos
  - Herança genética: transmissão de características
  - Variação: mutação e recombinação
  - Adaptação ao ambiente
- **Analogia Computacional:**
  - **População:** conjunto de soluções candidatas
  - **Indivíduo/Cromossomo:** solução única
  - **Gene:** componente da solução
  - **Fitness:** qualidade da solução
  - **Geração:** iteração do algoritmo

#### 1.2 Características Principais

- **Busca estocástica:** usa aleatoriedade para explorar espaço de soluções
- **Busca populacional:** mantém múltiplas soluções simultaneamente
- **Busca heurística:** não garante ótimo global, mas encontra boas soluções
- **Paralelização natural:** indivíduos podem ser avaliados independentemente
- **Robustez:** funciona bem em espaços de busca complexos (não-lineares, multimodais, descontínuos)

#### 1.3 Componentes Fundamentais

1. **Representação:** como codificar soluções (binária, real, permutação, árvore)
2. **Função de Fitness:** avalia qualidade das soluções
3. **Operadores Genéticos:** mutação, crossover, seleção
4. **Critério de Parada:** número de gerações, convergência, tempo

---

### 2. **Algoritmos Genéticos (AG)**

#### 2.1 Estrutura Básica

```
1. Inicializar população aleatória
2. Avaliar fitness de cada indivíduo
3. Enquanto (critério de parada não atingido):
   a. Selecionar pais (selection)
   b. Aplicar crossover (recombinação)
   c. Aplicar mutação
   d. Avaliar fitness da nova geração
   e. Substituir população (replacement)
4. Retornar melhor solução
```

#### 2.2 Representação (Encoding)

- **Binária:** string de bits (ex: `[1,0,1,1,0,1]`)
  - Clássica, simples, usada em problemas ON/OFF
  - Ex: feature selection (1 = seleciona feature, 0 = descarta)
- **Real:** vetor de números reais (ex: `[3.5, -1.2, 8.9]`)
  - Para problemas de otimização contínua
  - Ex: tuning de hiperparâmetros (learning rate, regularização)
- **Permutação:** ordem de elementos (ex: `[3,1,4,2,5]`)
  - Para problemas combinatoriais
  - Ex: TSP (Traveling Salesman Problem), scheduling
- **Árvore:** estrutura hierárquica
  - Para programação genética
  - Ex: evolução de expressões matemáticas, regras de decisão

#### 2.3 Função de Fitness

- **Maximização vs. Minimização:**
  - Maximização: `fitness = f(x)`
  - Minimização: `fitness = 1/(1 + f(x))` ou `fitness = -f(x)`
- **Características de Boa Função de Fitness:**
  - Computacionalmente eficiente
  - Discriminativa (distingue bem boas/más soluções)
  - Suave (landscape sem muitos mínimos locais)
- **Exemplos:**
  - Otimização de função: `fitness = -f(x1, x2)` (se minimizando f)
  - Feature selection: `fitness = accuracy - penalty*num_features`
  - Portfolio optimization: `fitness = retorno/risco`

#### 2.4 Operadores de Seleção

- **Roleta (Roulette Wheel):**
  - Probabilidade de seleção proporcional ao fitness
  - `P(i) = fitness(i) / sum(fitness)`
  - Problema: convergência prematura se fitness muito desiguais
- **Torneio (Tournament):**
  - Seleciona k indivíduos aleatoriamente, escolhe o melhor
  - `k=2` (torneio binário) é comum
  - Mais robusto que roleta
- **Rank-based:**
  - Ordena por fitness, probabilidade baseada na posição
  - Reduz pressão de seleção
- **Elitismo:**
  - Garante que os n melhores indivíduos passam para próxima geração
  - Acelera convergência, evita perda de boas soluções

#### 2.5 Operadores de Crossover (Recombinação)

- **One-Point Crossover:**

  ```
  Pai1: [1,1,0,|1,0,1]
  Pai2: [0,1,1,|0,1,0]

  Filho1: [1,1,0,|0,1,0]
  Filho2: [0,1,1,|1,0,1]
  ```

- **Two-Point Crossover:**

  ```
  Pai1: [1,1|0,1,0|1]
  Pai2: [0,1|1,0,1|0]

  Filho1: [1,1|1,0,1|1]
  Filho2: [0,1|0,1,0|0]
  ```

- **Uniform Crossover:**
  - Cada gene vem do Pai1 ou Pai2 com probabilidade 50%
- **Crossover Aritmético (Real):**
  ```
  Filho1 = α*Pai1 + (1-α)*Pai2
  Filho2 = (1-α)*Pai1 + α*Pai2
  onde α ∈ [0,1]
  ```
- **PMX (Partial Mapped Crossover) para Permutações:**
  - Mantém ordem relativa, evita duplicatas

#### 2.6 Operadores de Mutação

- **Bit Flip (Binário):**
  ```
  Original: [1,0,1,1,0]
  Mutado:   [1,0,0,1,0]  (bit 3 invertido)
  ```

  - Probabilidade de mutação: `pm = 1/L` (L = tamanho do cromossomo)
- **Gaussian Mutation (Real):**
  ```
  x_novo = x_velho + N(0, σ²)
  ```

  - σ (desvio padrão) controla intensidade da mutação
- **Swap Mutation (Permutação):**
  ```
  Original: [3,1,4,2,5]
  Mutado:   [3,4,1,2,5]  (posições 2 e 3 trocadas)
  ```
- **Adaptive Mutation:**
  - Taxa de mutação diminui ao longo das gerações
  - `pm(t) = pm_inicial * (1 - t/T)` onde T = total de gerações

#### 2.7 Parâmetros Típicos

- **Tamanho da População:** 50-500 indivíduos
  - Maior população: mais diversidade, mais lento
- **Probabilidade de Crossover:** 0.6-0.9
  - Alta probabilidade: mais exploração
- **Probabilidade de Mutação:** 0.001-0.1
  - Baixa: evita perda de boas soluções
  - Alta: mais exploração, risco de busca aleatória
- **Número de Gerações:** 100-10000
  - Depende da complexidade do problema

---

### 3. **Estratégias Evolutivas (ES)**

#### 3.1 Características

- Desenvolvidas para otimização de parâmetros contínuos
- Ênfase em **mutação** (crossover é secundário)
- **Auto-adaptação:** parâmetros evolutivos também evoluem
- Notação: **(μ, λ)-ES** ou **(μ + λ)-ES**
  - **μ:** número de pais
  - **λ:** número de filhos
  - **vírgula (,):** substitui pais (apenas filhos competem)
  - **mais (+):** pais e filhos competem

#### 3.2 Tipos de Estratégias

- **(1+1)-ES:** um pai, um filho, melhor sobrevive
  - Simples, eficiente para problemas unimodais
- **(μ, λ)-ES:** μ pais geram λ filhos (λ > μ)
  - Maior diversidade
  - Ex: (15, 100)-ES
- **(μ + λ)-ES:** μ pais + λ filhos competem
  - Mais elitista

#### 3.3 Auto-adaptação de σ

- Cada indivíduo carrega seu próprio **step size** (σ)
- σ também sofre mutação:
  ```
  σ'(i) = σ(i) * exp(τ * N(0,1))
  x'(i) = x(i) + σ'(i) * N(0,1)
  ```

  - **τ:** learning rate (tipicamente `1/sqrt(n)` onde n = dimensão)
- Indivíduos com σ bom geram filhos melhores e são selecionados

#### 3.4 CMA-ES (Covariance Matrix Adaptation)

- Estado da arte em otimização de caixa-preta
- Adapta matriz de covariância completa
- Captura dependências entre variáveis
- Muito eficiente em problemas não-separáveis
- Biblioteca Python: `cma` package

---

### 4. **Otimização por Enxame de Partículas (PSO)**

#### 4.1 Inspiração

- Comportamento social de **pássaros em bando** ou **cardumes de peixes**
- Compartilhamento de informação entre indivíduos
- Cada partícula tem:
  - **Posição:** solução candidata
  - **Velocidade:** direção de busca
  - **Memória:** melhor posição que já visitou (pbest)

#### 4.2 Algoritmo PSO

```
Para cada partícula i:
  1. Inicializar posição x_i e velocidade v_i aleatoriamente
  2. pbest_i = x_i  (melhor posição pessoal)

3. gbest = melhor posição global da população

Enquanto (não convergiu):
  Para cada partícula i:
    v_i = w*v_i + c1*r1*(pbest_i - x_i) + c2*r2*(gbest - x_i)
    x_i = x_i + v_i

    Avaliar fitness de x_i
    Se fitness(x_i) > fitness(pbest_i):
      pbest_i = x_i
    Se fitness(x_i) > fitness(gbest):
      gbest = x_i
```

#### 4.3 Parâmetros

- **w (inércia):** 0.4-0.9
  - Alto: exploração (velocidades altas mantidas)
  - Baixo: exploitation (convergência rápida)
  - Comum: decaimento linear `w = 0.9 - 0.5*(t/T)`
- **c1 (coeficiente cognitivo):** ~2.0
  - Atração para melhor posição pessoal
- **c2 (coeficiente social):** ~2.0
  - Atração para melhor posição global
- **r1, r2:** números aleatórios ∈ [0,1]
  - Introduz estocasticidade

#### 4.4 Variantes

- **PSO Local (lbest):**
  - Cada partícula só conhece vizinhos próximos
  - Mais lento, mas menos propenso a mínimos locais
- **Binary PSO:**
  - Para problemas discretos (ex: feature selection)
  - Velocidade interpretada como probabilidade de bit=1
- **Multi-Swarm PSO:**
  - Múltiplos enxames independentes
  - Evita convergência prematura

---

### 5. **Programação Genética (GP)**

#### 5.1 Conceito

- Evolução de **programas de computador** (não apenas parâmetros)
- Representação em **árvores de sintaxe**
- Aplicações:
  - Regressão simbólica (descoberta de fórmulas)
  - Geração de features (automated feature engineering)
  - Evolução de regras de decisão

#### 5.2 Representação em Árvore

```
Expressão: (x + 2) * sin(y)

Árvore:
       *
      / \
     +   sin
    / \   |
   x   2  y
```

- **Nós internos:** operadores (+, -, \*, /, sin, log, etc.)
- **Nós folha (terminais):** variáveis (x, y) ou constantes (2, 3.5)

#### 5.3 Operadores

- **Crossover (Subtree Crossover):**

  ```
  Pai1:     +           Pai2:     *
           / \                   / \
          x   *                 y   2
             / \
            y   3

  Seleciona subárvore aleatória de cada pai e troca

  Filho:    +
           / \
          x   *
             / \
            y   2
  ```

- **Mutação (Subtree Mutation):**
  - Substitui subárvore aleatória por nova árvore gerada aleatoriamente
- **Point Mutation:**
  - Troca nó individual (ex: `+` vira `-`, variável `x` vira `y`)

#### 5.4 Bloat e Controle de Tamanho

- **Bloat:** árvores crescem indefinidamente sem melhorar fitness
- **Soluções:**
  - Profundidade máxima (ex: 10 níveis)
  - Parsimony pressure: `fitness_efetivo = fitness - α*tamanho`
  - Operadores size-fair

#### 5.5 Aplicações em DS

- **Automated Feature Engineering:**
  - Biblioteca: `gplearn` (Python)
  - Evolui features compostas: `log(x1) * sqrt(x2 + x3)`
- **Symbolic Regression:**
  - Descobre fórmula matemática que explica dados
  - Alternativa a modelos black-box
  - Ex: física, química (descoberta de leis)

---

### 6. **Aplicações em Data Science**

#### 6.1 Feature Selection

- **Problema:** selecionar subconjunto ótimo de features
- **Representação:** cromossomo binário
  ```
  [1, 0, 1, 1, 0] → seleciona features 1, 3, 4
  ```
- **Fitness:**
  ```python
  def fitness(features_selected):
      X_subset = X[:, features_selected]
      model.fit(X_subset, y)
      score = cross_val_score(model, X_subset, y, cv=5).mean()
      penalty = 0.01 * sum(features_selected)  # penalizar muitas features
      return score - penalty
  ```
- **Wrapper approach:** avalia subset com modelo real (lento mas preciso)

#### 6.2 Hyperparameter Tuning

- **Problema:** encontrar hiperparâmetros ótimos de modelo
- **Representação:** cromossomo real ou misto
  ```
  [learning_rate, max_depth, min_samples_split, n_estimators]
  [0.05, 8, 4, 150]
  ```
- **Fitness:**
  ```python
  def fitness(params):
      model = RandomForestClassifier(
          max_depth=params[1],
          min_samples_split=params[2],
          n_estimators=params[3]
      )
      return cross_val_score(model, X, y, cv=3).mean()
  ```
- **Vantagem sobre Grid Search:**
  - Mais eficiente em espaços de busca contínuos e de alta dimensão
  - Explora regiões promissoras

#### 6.3 Neural Architecture Search (NAS)

- **Problema:** encontrar arquitetura ótima de rede neural
- **Representação:**
  - Cromossomo codifica: número de camadas, unidades por camada, funções de ativação, skip connections
  - Ex: `[128, 64, 32] → 3 camadas densas com essas unidades`
- **Fitness:**
  ```python
  def fitness(architecture):
      model = build_model(architecture)
      model.fit(X_train, y_train, epochs=10)
      return model.evaluate(X_val, y_val)[1]  # accuracy
  ```
- **Desafios:**
  - Muito caro computacionalmente (treinar rede por indivíduo)
  - Soluções: early stopping, proxies (treinar menos épocas), weight inheritance

#### 6.4 Ensemble Learning

- **Problema:** selecionar e pesar modelos em ensemble
- **Representação:** pesos de cada modelo base
  ```
  [0.3, 0.5, 0.0, 0.2] → modelo 3 não usado
  ```
- **Fitness:**
  ```python
  def fitness(weights):
      predictions = sum(w * model_pred for w, model_pred in zip(weights, base_predictions))
      return accuracy(y_true, predictions)
  ```

#### 6.5 Clustering Optimization

- **Problema:** encontrar melhor número de clusters e centróides iniciais
- **Representação:** posições de k centróides
- **Fitness:** silhouette score, Davies-Bouldin index

---

### 7. **Implementação Prática em Python**

#### 7.1 Bibliotecas

- **DEAP (Distributed Evolutionary Algorithms in Python):**
  - Framework completo e flexível
  - Suporta AG, GP, ES, PSO
  - Paralelização built-in
- **Pygmo/Pagmo:**
  - Otimização multi-objetivo
  - Algoritmos state-of-the-art (CMA-ES, PSO variants)
- **gplearn:**
  - Programação genética para symbolic regression e feature engineering
- **scikit-optimize (skopt):**
  - Bayesian optimization (alternativa a GA para hyperparameter tuning)

#### 7.2 Exemplo: AG Simples com DEAP

```python
from deap import base, creator, tools, algorithms
import numpy as np

# Definir problema (maximização)
creator.create("FitnessMax", base.Fitness, weights=(1.0,))
creator.create("Individual", list, fitness=creator.FitnessMax)

# Função de fitness
def evalOneMax(individual):
    return sum(individual),  # retorna tupla

# Configurar toolbox
toolbox = base.Toolbox()
toolbox.register("attr_bool", np.random.randint, 0, 2)
toolbox.register("individual", tools.initRepeat, creator.Individual,
                 toolbox.attr_bool, n=100)
toolbox.register("population", tools.initRepeat, list, toolbox.individual)

toolbox.register("evaluate", evalOneMax)
toolbox.register("mate", tools.cxTwoPoint)
toolbox.register("mutate", tools.mutFlipBit, indpb=0.05)
toolbox.register("select", tools.selTournament, tournsize=3)

# Executar GA
pop = toolbox.population(n=300)
hof = tools.HallOfFame(1)  # guardar melhor

pop, log = algorithms.eaSimple(pop, toolbox,
                                cxpb=0.7, mutpb=0.2,
                                ngen=50,
                                halloffame=hof,
                                verbose=True)

print("Melhor indivíduo:", hof[0])
print("Fitness:", hof[0].fitness.values[0])
```

#### 7.3 Exemplo: Feature Selection com GA

```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import cross_val_score

def evalFeatures(individual):
    # Converter cromossomo binário em índices
    features = [i for i, bit in enumerate(individual) if bit == 1]

    if len(features) == 0:  # nenhuma feature selecionada
        return 0.0,

    X_subset = X[:, features]
    clf = RandomForestClassifier(n_estimators=50, random_state=42)
    score = cross_val_score(clf, X_subset, y, cv=3).mean()

    # Penalizar muitas features
    penalty = 0.001 * len(features)
    return score - penalty,

# Configurar (similar ao exemplo anterior, ajustar função de fitness)
toolbox.register("evaluate", evalFeatures)

# Executar
pop = toolbox.population(n=50)
pop, log = algorithms.eaSimple(pop, toolbox, cxpb=0.6, mutpb=0.1, ngen=30)
```

#### 7.4 Exemplo: PSO para Otimização Contínua

```python
import pyswarm

# Função a minimizar
def rosenbrock(x):
    return sum(100*(x[1:]-x[:-1]**2)**2 + (1-x[:-1])**2)

# Bounds
lb = [-5, -5, -5]  # lower bounds
ub = [5, 5, 5]     # upper bounds

# Executar PSO
xopt, fopt = pyswarm.pso(rosenbrock, lb, ub)
print("Ótimo:", xopt)
print("f(ótimo):", fopt)
```

---

### 8. **Algoritmos Multi-Objetivo**

#### 8.1 Problema de Otimização Multi-Objetivo

- **Múltiplos objetivos conflitantes:**
  - Ex: maximizar acurácia **e** minimizar complexidade
  - Ex: minimizar custo **e** maximizar receita
- **Frente de Pareto:**
  - Conjunto de soluções não-dominadas
  - Solução A domina B se: A é melhor em todos os objetivos ou melhor em alguns e igual nos outros

#### 8.2 NSGA-II (Non-dominated Sorting Genetic Algorithm)

- **Passos:**
  1. **Classificação por dominância:** organiza população em fronts (F1, F2, ...)
  2. **Crowding distance:** mede "espaçamento" entre soluções no mesmo front
  3. **Seleção:** prefere soluções em fronts menores; dentro do mesmo front, prefere maior crowding distance (mais isoladas)
- **Vantagens:**
  - Mantém diversidade
  - Retorna conjunto de soluções (Pareto front)
  - Usuário escolhe trade-off depois

#### 8.3 Aplicação: Model Selection Multi-Objetivo

```python
from deap import algorithms

# Dois objetivos: accuracy e número de features
creator.create("FitnessMulti", base.Fitness, weights=(1.0, -1.0))  # max accuracy, min features

def evalMulti(individual):
    features = [i for i, bit in enumerate(individual) if bit == 1]
    if len(features) == 0:
        return 0.0, 100.0

    X_subset = X[:, features]
    score = cross_val_score(clf, X_subset, y, cv=3).mean()
    return score, len(features)

toolbox.register("evaluate", evalMulti)
toolbox.register("select", tools.selNSGA2)

pop = toolbox.population(n=100)
pop = algorithms.eaSimple(pop, toolbox, cxpb=0.7, mutpb=0.2, ngen=50)

# Extrair Pareto front
pareto_front = tools.sortNondominated(pop, len(pop), first_front_only=True)[0]
```

---

### 9. **Análise de Desempenho e Convergência**

#### 9.1 Métricas de Avaliação

- **Best Fitness:** melhor fitness encontrado até geração t
- **Average Fitness:** fitness médio da população
- **Diversity:** variância genética (σ² dos genes)
  - Alta: exploração
  - Baixa: convergência (risco de estagnação)

#### 9.2 Curva de Convergência

```python
import matplotlib.pyplot as plt

# Coletar estatísticas durante evolução
stats = tools.Statistics(lambda ind: ind.fitness.values)
stats.register("avg", np.mean)
stats.register("std", np.std)
stats.register("min", np.min)
stats.register("max", np.max)

pop, log = algorithms.eaSimple(pop, toolbox, cxpb=0.7, mutpb=0.2,
                                ngen=100, stats=stats, verbose=False)

# Plotar
gen = log.select("gen")
fit_maxs = log.select("max")
fit_avgs = log.select("avg")

plt.plot(gen, fit_maxs, label="Max Fitness")
plt.plot(gen, fit_avgs, label="Avg Fitness")
plt.xlabel("Geração")
plt.ylabel("Fitness")
plt.legend()
plt.show()
```

#### 9.3 Problemas Comuns

- **Convergência Prematura:**
  - População perde diversidade cedo
  - Soluções: aumentar mutação, usar niching, aumentar tamanho populacional
- **Estagnação:**
  - Fitness não melhora por muitas gerações
  - Soluções: adaptive mutation, restart population, usar algoritmo diferente (CMA-ES)
- **Slow Convergence:**
  - Muito lento para atingir ótimo
  - Soluções: aumentar pressão de seleção (elitismo), tuning de parâmetros

---

### 10. **Comparação com Outras Técnicas de Otimização**

| Técnica                   | Tipo           | Gradiente | Pros                             | Cons                                          | Quando Usar                            |
| ------------------------- | -------------- | --------- | -------------------------------- | --------------------------------------------- | -------------------------------------- |
| **Gradient Descent**      | Determinístico | Sim       | Rápido, convergência teórica     | Preso em mínimos locais, precisa de derivadas | Funções diferenciáveis, convexas       |
| **Grid Search**           | Exaustivo      | Não       | Simples, completo                | Exponencialmente caro                         | Poucos hiperparâmetros                 |
| **Random Search**         | Estocástico    | Não       | Mais eficiente que grid          | Sem coordenação                               | Espaços de busca grandes               |
| **Bayesian Optimization** | Estocástico    | Não       | Sample-efficient                 | Setup complexo                                | Avaliações custosas (poucas iterações) |
| **AG/PSO/ES**             | Estocástico    | Não       | Robusto, paralelo, sem derivadas | Muitas avaliações, tuning difícil             | Não-linear, não-convexo, caixa-preta   |
| **Simulated Annealing**   | Estocástico    | Não       | Simples, evita mínimos locais    | Busca single-point (lento)                    | Problemas combinatoriais               |

**Quando usar Algoritmos Evolucionários:**

- Função objetivo **não-diferenciável** ou **descontínua**
- Espaço de busca **multimodal** (muitos mínimos locais)
- **Alta dimensionalidade** (100s de variáveis)
- **Problemas combinatoriais** (permutações, grafos)
- Avaliação paralela possível (fitness independentes)
- Otimização **multi-objetivo**

---

## 💡 Conceitos-Chave para Memorizar

1. **Computação Evolucionária = Algoritmos inspirados na evolução biológica**
   - População de soluções que evolui através de seleção, recombinação e mutação
2. **Componentes Fundamentais:**
   - **Representação:** como codificar solução (binária, real, permutação, árvore)
   - **Fitness:** função que avalia qualidade de solução
   - **Seleção:** escolha de pais (roleta, torneio, rank)
   - **Crossover:** recombinação de pais (one-point, uniform, aritmético)
   - **Mutação:** variação aleatória (bit-flip, gaussian, swap)
3. **Algoritmos Principais:**
   - **AG (Genetic Algorithms):** clássico, enfatiza crossover, uso geral
   - **ES (Evolution Strategies):** para contínuos, enfatiza mutação, auto-adaptação de σ
   - **PSO (Particle Swarm):** inspirado em enxames, velocidade + posição, social
   - **GP (Genetic Programming):** evolui programas/expressões (árvores)
4. **Parâmetros Típicos:**
   - População: 50-500
   - Crossover: 0.6-0.9
   - Mutação: 0.001-0.1
   - Elitismo: preservar top 1-5%
5. **Aplicações em DS:**
   - Feature selection (cromossomo binário)
   - Hyperparameter tuning (cromossomo real)
   - Neural Architecture Search (cromossomo estrutural)
   - Automated feature engineering (programação genética)
   - Ensemble optimization (pesos de modelos)
6. **NSGA-II para Multi-Objetivo:**
   - Retorna Pareto front (soluções não-dominadas)
   - Ex: maximizar acurácia + minimizar features
7. **Exploration vs. Exploitation:**
   - **Exploration:** busca em novas regiões (alta mutação, baixa seleção)
   - **Exploitation:** refinamento em região promissora (elitismo, baixa mutação)
   - Balancear ao longo das gerações
8. **Problemas Comuns:**
   - **Convergência prematura:** perda de diversidade cedo → aumentar mutação
   - **Estagnação:** sem melhoria → adaptive operators, restart
   - **Bloat (GP):** árvores crescem sem melhorar → parsimony pressure
9. **CMA-ES = Estado da arte para otimização contínua de caixa-preta**
   - Adapta matriz de covariância completa
   - Muito eficiente em problemas não-separáveis
10. **Bibliotecas Python:**
    - **DEAP:** framework completo e flexível (AG, GP, ES, PSO)
    - **Pygmo:** algoritmos avançados, multi-objetivo
    - **gplearn:** programação genética (symbolic regression, feature engineering)
    - **pyswarm:** PSO
    - **cma:** CMA-ES

---

## ⚠️ Erros Comuns a Evitar

1. **❌ Taxa de mutação muito alta**
   - Resultado: busca vira aleatória, perde boas soluções
   - ✅ Usar pm ≈ 1/L (L = tamanho cromossomo), máximo ~0.1
2. **❌ População muito pequena**
   - Resultado: convergência prematura, falta diversidade
   - ✅ Mínimo 30-50 indivíduos, ideal 100-300
3. **❌ Fitness mal projetada**
   - Problema: não discrimina bem soluções ou landscape muito rugoso
   - ✅ Testar função de fitness em casos conhecidos, adicionar regularização
4. **❌ Esquecer elitismo**
   - Resultado: melhores soluções podem ser perdidas
   - ✅ Preservar top 1-5% da população automaticamente
5. **❌ Não normalizar fitness quando multi-objetivo**
   - Problema: um objetivo domina outros por escala
   - ✅ Normalizar cada objetivo para [0,1] ou z-score
6. **❌ Usar AG para problema convexo/diferenciável**
   - Resultado: lento e ineficiente
   - ✅ Usar gradient descent ou métodos analíticos nesses casos
7. **❌ Não verificar validade de soluções**
   - Problema: operadores podem gerar soluções inválidas (ex: divisão por zero)
   - ✅ Validar soluções após operadores genéticos, atribuir fitness baixo se inválido
8. **❌ Avaliar fitness repetidamente para mesma solução**
   - Resultado: desperdício computacional
   - ✅ Cachear fitness com hash de indivíduos
9. **❌ Não usar validação cruzada em problemas de ML**
   - Problema: overfitting, fitness não generaliza
   - ✅ Sempre usar CV (mesmo que 3-fold) para avaliar features/hiperparâmetros
10. **❌ Parar evolução muito cedo**
    - Resultado: não atinge boas soluções
    - ✅ Usar critério de convergência (fitness não melhora por N gerações) ou número generoso de gerações

---

## 📚 Materiais de Apoio e Referências

### Artigos e Papers Clássicos

- **Holland (1975):** "Adaptation in Natural and Artificial Systems" (fundamentos de AG)
- **Schwefel (1977):** Evolution Strategies (ES originais)
- **Koza (1992):** "Genetic Programming" (GP seminal)
- **Kennedy & Eberhart (1995):** "Particle Swarm Optimization" (PSO original)
- **Deb et al. (2002):** "A Fast Elitist Multi-Objective Genetic Algorithm: NSGA-II"
- **Hansen (2016):** "The CMA Evolution Strategy: A Tutorial"

### Livros Recomendados

📖 **"Introduction to Evolutionary Computing" - Eiben & Smith**

- Texto didático completo sobre EC

📖 **"Genetic Algorithms in Search, Optimization, and Machine Learning" - Goldberg**

- Clássico sobre AG

📖 **"Genetic Programming: An Introduction" - Koza**

- Fundamentos de GP

📖 **"Evolutionary Computation for Modeling and Optimization" - Ashlock**

- Aplicações práticas

### Tutoriais e Documentação

- **DEAP Documentation:** https://deap.readthedocs.io/
  - Tutoriais completos, exemplos de código
- **Pygmo/Pagmo:** https://esa.github.io/pygmo2/
  - Algoritmos avançados, documentação detalhada
- **gplearn:** https://gplearn.readthedocs.io/
  - Symbolic regression e feature engineering

### Datasets para Prática

- **UCI ML Repository:** problemas clássicos de otimização
- **Kaggle:** feature selection e hyperparameter tuning em competições
- **Benchmark Functions:** Rastrigin, Rosenbrock, Ackley (teste de algoritmos)

### Ferramentas Online

- **Genetic Algorithm Simulator:** visualização interativa de AG
- **PSO Visualization:** animação de partículas convergindo
- **CMA-ES Tutorial:** https://arxiv.org/abs/1604.00772

---

## ✅ Checklist de Estudo

### Conceitos Fundamentais

- [ ] Entender metáfora biológica: população, gene, cromossomo, fitness, geração
- [ ] Diferenciar exploration vs. exploitation
- [ ] Conhecer tipos de representação: binária, real, permutação, árvore
- [ ] Compreender operadores: seleção, crossover, mutação
- [ ] Saber quando usar EA vs. gradient descent vs. Bayesian optimization

### Algoritmos Genéticos (AG)

- [ ] Implementar AG básico do zero (Python)
- [ ] Configurar parâmetros: tamanho população, pcrossover, pmutação, gerações
- [ ] Aplicar AG em feature selection (problema real)
- [ ] Aplicar AG em hyperparameter tuning (comparar com grid/random search)
- [ ] Usar biblioteca DEAP para AG complexo

### Estratégias Evolutivas (ES)

- [ ] Entender notação (μ, λ)-ES vs. (μ + λ)-ES
- [ ] Compreender auto-adaptação de σ (step size)
- [ ] Usar CMA-ES (biblioteca cma) em otimização contínua
- [ ] Comparar ES vs. AG em problema numérico

### PSO (Particle Swarm Optimization)

- [ ] Entender conceito de velocidade e posição de partícula
- [ ] Implementar PSO básico (equações de atualização)
- [ ] Configurar parâmetros: w, c1, c2
- [ ] Aplicar PSO em otimização de função (ex: Rosenbrock)
- [ ] Testar variante Binary PSO em problema discreto

### Programação Genética (GP)

- [ ] Representar expressão matemática como árvore
- [ ] Entender operadores: subtree crossover, point mutation
- [ ] Usar gplearn para symbolic regression
- [ ] Aplicar GP em automated feature engineering
- [ ] Controlar bloat (profundidade máxima, parsimony pressure)

### Multi-Objetivo

- [ ] Compreender conceito de dominância de Pareto
- [ ] Interpretar Pareto front (conjunto de soluções não-dominadas)
- [ ] Implementar NSGA-II (ou usar DEAP)
- [ ] Aplicar em problema real: accuracy vs. complexity
- [ ] Escolher solução no Pareto front (trade-off)

### Aplicações em Data Science

- [ ] **Feature Selection:** implementar wrapper GA com CV
- [ ] **Hyperparameter Tuning:** comparar GA vs. GridSearch vs. RandomSearch vs. Bayesian
- [ ] **Neural Architecture Search:** codificar arquitetura de rede em cromossomo
- [ ] **Ensemble Optimization:** evoluir pesos de modelos base
- [ ] **Automated Feature Engineering:** usar GP para criar features compostas

### Análise e Debugging

- [ ] Plotar curva de convergência (max fitness, avg fitness, diversity)
- [ ] Identificar convergência prematura (diversidade cai muito rápido)
- [ ] Identificar estagnação (fitness não melhora)
- [ ] Ajustar parâmetros para balancear exploration/exploitation
- [ ] Comparar desempenho de diferentes operadores (crossover, seleção)

### Projeto Prático

- [ ] **Definir problema real:** ex: otimizar pipeline de ML
- [ ] **Escolher representação:** binária (features), real (hiperparâmetros), árvore (features compostas)
- [ ] **Definir função de fitness:** accuracy + penalty de complexidade
- [ ] **Configurar EA:** escolher AG/PSO/GP e parâmetros
- [ ] **Executar múltiplas runs:** avaliar robustez (média e desvio padrão de resultados)
- [ ] **Comparar com baseline:** grid search ou método atual
- [ ] **Documentar:** justificar escolhas, interpretar resultados
- [ ] **Validar em test set:** garantir que solução generaliza

### Referências e Teoria

- [ ] Ler paper clássico: Holland (AG) ou Kennedy&Eberhart (PSO) ou Deb (NSGA-II)
- [ ] Estudar benchmark functions: Rastrigin, Ackley, Rosenbrock
- [ ] Conhecer no free lunch theorem: nenhum algoritmo é melhor em todos os problemas
- [ ] Entender quando EA NÃO é adequado (problemas convexos, poucos parâmetros)

---

**🎯 Meta de Aprendizado:**  
Implementar pipeline completo de otimização evolutiva aplicada em problema real de Data Science (ex: feature selection + hyperparameter tuning simultâneos para modelo de classificação), comparar com métodos tradicionais e interpretar resultados em termos de trade-offs exploração/explotação.

**💪 Desafio Avançado:**  
Implementar NAS (Neural Architecture Search) com AG para descobrir arquitetura de rede neural otimizada para dataset específico, limitando espaço de busca (profundidade, largura) e usando técnicas de early stopping para viabilizar computacionalmente.

---

_Documentado para MBA Data Science e Analytics - USP/ESALQ_  
_Versão 1.0 - Computação Evolucionária aplicada a Data Science_
