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
  - **Gene:** componente da solução (ex: 1 item ou 0 não-item no problema da mochila)
  - **Fitness:** qualidade da solução
  - **Geração:** iteração do algoritmo

#### 1.2 Contexto: Meta-heurísticas

- **Heurística:** procedimento de busca guiado por intuição, visando encontrar boa solução (Ex: Greedy Search)
- **Meta-heurística:** combinação de procedimentos de busca com estratégias de alto nível para intensificação e diversificação, buscando evitar ótimos locais (Ex: **Algoritmos Genéticos**)
- Fonte: Belfiore, Fávero (2013)

#### 1.3 Componentes Fundamentais de um AG

1. **Representação:** como codificar soluções (binária, real, permutação)
2. **Função de Fitness:** avalia qualidade das soluções
3. **Operadores Genéticos:** seleção, crossover, mutação
4. **Critério de Parada:** número de gerações, convergência

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

### 3. **Otimização Multi-Objetivo (Referência)**

- **Material Complementar menciona:** NSGA-II (Deb et al. 2002)
- Para estudo mais profundo, consultar material de referência
- Aplicável quando há múltiplos objetivos conflitantes (ex: maximizar acurácia vs minimizar features)

---

## 💡 Conceitos-Chave para Memorizar

1. **Computação Evolucionária = Algoritmos inspirados na evolução biológica**
   - População de soluções que evolui através de seleção, recombinação e mutação
   
2. **Componentes Fundamentais de um AG:**
   - **Representação:** como codificar solução (binária = Problema da Mochila, real = Problema da Ração, permutação = Caixeiro Viajante)
   - **Fitness:** função que avalia qualidade de solução
   - **Seleção:** escolha de pais (roleta, torneio)
   - **Crossover:** recombinação de pais
   - **Mutação:** variação aleatória (bit-flip para binário)
   - **Elitismo:** preservar top indivíduos
   
3. **Problemas Abordados:**
   - **Problema da Mochila (0/1):** cromossomo binário
   - **Problema da Ração/Mistura:** cromossomo real (proporções)
   - **Caixeiro Viajante (TSP):** cromossomo permutação (ordem de cidades)
   - **Otimização de Função Não-Linear:** cromossomo real
   
4. **Parâmetros Típicos:**
   - População: 50-500 indivíduos
   - Probabilidade de Crossover: 0.6-0.9
   - Probabilidade de Mutação: ~1/L (L = tamanho cromossomo)
   - Elitismo: preservar top 1-5%
   
5. **Operadores de Seleção:**
   - **Torneio (Tournament):** seleciona k indivíduos, escolhe melhor (k=2 típico)
   - **Roleta (Roulette Wheel):** probabilidade proporcional ao fitness
   
6. **Fluxo do Algoritmo Genético:**
   1. Gerar população inicial aleatória
   2. Avaliar fitness
   3. Selecionar pais
   4. Aplicar crossover
   5. Aplicar mutação
   6. Verificar convergência (não → volta ao passo 2)
   
7. **Exploration vs. Exploitation:**
   - **Exploração:** população diversa, busca ampla (maior mutação)
   - **Explotação:** refinamento da região promissora (elitismo, menor mutação)
   - Equilibrar ao longo das gerações
   
8. **Problemas Comuns:**
   - **Convergência prematura:** população perde diversidade rápido → aumentar mutação
   - **Estagnação:** fitness não melhora → aumentar população, aumentar mutação, mais gerações
   - **População pequena:** risco de perder boas soluções
   
9. **Bibliotecas Python Usadas:**
   - **pygad:** Genetic Algorithm (utilizada nos scripts das aulas)
   - **pulp/cvxpy:** para resolver com solveres (comparação com AG)

---

## ⚠️ Erros Comuns a Evitar

1. **❌ Taxa de mutação muito alta**
   - Resultado: busca vira aleatória, perde boas soluções
   - ✅ Usar pm ≈ 1/L (L = tamanho cromossomo), tipicamente 0.01-0.1

2. **❌ População muito pequena**
   - Resultado: convergência prematura, falta diversidade
   - ✅ Mínimo 50-100 indivíduos para problemas médios

3. **❌ Esquecer elitismo**
   - Resultado: melhores soluções podem ser perdidas entre gerações
   - ✅ Sempre preservar top indivíduos automaticamente

4. **❌ Usar AG para problema que tem solução analítica**
   - Resultado: lento e ineficiente
   - ✅ Usar métodos exatos (solver) quando o problema permite

5. **❌ Parar evolução muito cedo**
   - Resultado: não atinge convergência
   - ✅ Executar número suficiente de gerações (50-100 típico, mais se necessário)

6. **❌ Não testar o AG antes em problema conhecido**
   - Resultado: dificuldade em verificar se implementação está correta
   - ✅ Começar com problema simples (ex: função 2D) onde se conhece a solução

---

## 📚 Materiais de Apoio e Referências

### Material Complementar (Prof. Renata Onety)

Sugestão de Leitura:
- **Campelo, F.; Aranha, C. 2023.** "Lessons from the Evolutionary Computation Bestiary"
- **Deb, K.; Pratap, A.; Agarwal, S.; Meyarivan, T. 2002.** "A Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II" (para Multi-Objetivo)
- **The Programming Piglet. 2019.** "Genetic algorithms explained in 6 minutes (...and 28 seconds)" (vídeo)

### Documentação de Bibliotecas

- **pygad:** Biblioteca usada nos scripts das aulas
  - Documentação: https://pygad.readthedocs.io/
  - Suporta AG binário, real, permutação

- **pulp / cvxpy:** Para comparação com solvers (Problemas da Ração)

### Benchmark Functions para Testar AG

- **Função Quadrática:** f(x) = x² (fácil, para validação)
- **Rastrigin:** f(x) = 10n + Σ[x²ᵢ - 10cos(2πxᵢ)] (muitos mínimos locais)
- **Rosenbrock:** f(x) = Σ[100(xᵢ₊₁ - xᵢ²)² + (1 - xᵢ)²] (valley)
- **Ackley:** tem forma cônica com platô (teste de diversidade)

---

## ✅ Checklist de Estudo (Módulo 6 - Computação Evolucionária)

### Conceitos Fundamentais
- [ ] Entender contexto: Pesquisa Operacional → Otimização → Meta-heurísticas
- [ ] Diferenciar Heurística vs. Meta-heurística
- [ ] Compreender metáfora biológica: população, gene, cromossomo, fitness, geração
- [ ] Balancear exploration (diversidade) vs. exploitation (refinamento)

### Algoritmos Genéticos (AG) - Conteúdo Principal

**Representação e Problemas:**
- [ ] **Binária:** aplicar ao Problema da Mochila (0/1 knapsack)
- [ ] **Real:** aplicar ao Problema da Ração/Mistura
- [ ] **Permutação:** aplicar ao Caixeiro Viajante (TSP)
- [ ] Entender quando usar cada tipo

**Operadores Genéticos:**
- [ ] **Seleção:** Torneio (tournament) vs. Roleta (roulette)
- [ ] **Crossover:** one-point, two-point (básicos)
- [ ] **Mutação:** bit-flip (binário), gaussiana (real), swap (permutação)
- [ ] **Elitismo:** preservar melhores indivíduos

**Implementação:**
- [ ] Implementar AG do zero OU usar biblioteca pygad
- [ ] Configurar: população (50-500), crossover (0.6-0.9), mutação (~1/L), gerações (50-100+)
- [ ] Testar em exemplo simples (função 2D não-linear) onde se conhece o ótimo
- [ ] Aplicar no Problema da Mochila
- [ ] Aplicar no Problema da Ração
- [ ] Aplicar no Caixeiro Viajante

**Análise:**
- [ ] Plotar evolução: fitness máximo e médio por geração
- [ ] Verificar convergência (fitness melhora ao longo do tempo)
- [ ] Testar múltiplas runs com seeds diferentes
- [ ] Comparar resultados entre diferentes parâmetros

### Problemas Abordados (Aplicação Prática)

1. **Problema da Mochila 0/1:**
   - [ ] Entender restrição de capacidade
   - [ ] Codificar cromossomo binário
   - [ ] Implementar fitness (valor total - penalidade se ultrapassar capacidade)

2. **Problema da Ração/Mistura:**
   - [ ] Entender restrições nutricionais
   - [ ] Codificar cromossomo real (proporções)
   - [ ] Implementar fitness (minimizar custo respeitando restrições)
   - [ ] Comparar AG vs. solver (PuLP, cvxpy)

3. **Problema do Caixeiro Viajante (TSP):**
   - [ ] Entender matriz de distâncias
   - [ ] Codificar cromossomo permutação
   - [ ] Implementar fitness (comprimento total da rota)
   - [ ] Visualizar rotas

4. **Otimização de Função Não-Linear:**
   - [ ] Minimizar f(x) = x² (validação simples)
   - [ ] Testar AG em função 2D com múltiplos mínimos locais
   - [ ] Visualizar população convergindo

### Multi-Objetivo (Referência)
- [ ] Conhecer conceito de Pareto front (trade-offs)
- [ ] Saber que NSGA-II é abordado no material complementar para estudo posterior

---

**🎯 Meta de Aprendizado:**  
Dominar Algoritmos Genéticos para resolver problemas clássicos de otimização (Mochila, Ração, Caixeiro Viajante, função não-linear). Compreender como configurar população, operadores genéticos e critérios de parada. Implementar AG do zero OU usando biblioteca (pygad) e analisar convergência com visualizações.

---

_Documentado para MBA Data Science e Analytics - USP/ESALQ_  
_Versão 1.0 - Computação Evolucionária aplicada a Data Science_
