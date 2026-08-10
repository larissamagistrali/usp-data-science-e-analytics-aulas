# 🎯 Resumo do Curso: Pesquisa Operacional e Modelos de Otimização

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos da **Pesquisa Operacional (P.O.)** como "ciência da tomada de decisão", dominando o processo de **Modelagem Matemática de Otimização**: identificação de variáveis de decisão, formulação da função objetivo e das restrições de um problema real, e classificação dos modelos matemáticos (Programação Linear, Inteira, Inteira Mista e Não Linear). O módulo é essencialmente introdutório e conceitual — a resolução dos modelos formulados (Método Simplex e afins) é o tema da aula seguinte, mencionada nos slides como "Motivação para próxima aula".

---

## 📚 Conteúdo Principal

### 1. FUNDAMENTOS DA PESQUISA OPERACIONAL

#### 1.1 O que é Pesquisa Operacional

- **Pesquisa Operacional (P.O.)**, em inglês *Operations Research*, é definida como a **"ciência da tomada de decisão"**.
- Citação do professor George B. Dantzig (criador do Método Simplex), em entrevista republicada *in memoriam* na revista *OR/MS Today* (jun/2005):

> "Eu a chamo de ciência da tomada de decisão. Ou seja, todas as maneiras de abstrair um problema e colocá-lo em uma forma matemática. Isso engloba desde os matemáticos que estão tentando resolver problemas abstratos até as pessoas que têm um problema real e precisam dar uma resposta ao chefe. Pesquisa Operacional é tudo isso e, dependendo de com quem você conversa, você terá uma visão diferente do que é PO."

#### 1.2 Origens Históricas

- Origem há décadas, ligada à utilização de **métodos científicos na gestão de organizações**.
- **Operações militares na 2ª Guerra Mundial**: cientistas aplicando métodos quantitativos a problemas militares de natureza estratégica e tática.
- Foco original: **alocar recursos escassos de maneira eficiente**.

#### 1.3 Complexidade Combinatória — Por que Precisamos de P.O.

- **Exemplo motivador**: um problema de roteirização com **500 entregas e 25 veículos** gera **1,0439 × 10⁴² combinações possíveis** de agrupamento (sem nem considerar a sequência/rota de entrega dentro de cada veículo).
- Escrito de forma explícita: **1.043.900.000.000.000.000.000.000.000.000.000.000.000.000** combinações.
- **Conclusão**: problemas reais de decisão são combinatoriamente explosivos — testar todas as alternativas manualmente é inviável, o que justifica o uso de modelos matemáticos de otimização.

#### 1.4 Impacto Econômico Real de Aplicações de P.O.

Exemplos citados nos slides de ganhos obtidos com aplicações reais de P.O.:

| **Aplicação**                                          | **Resultado Reportado**        |
| ------------------------------------------------------- | ------------------------------- |
| Transferência e distribuição de cargas                 | Economia de USD 45 milhões/ano  |
| Redes de transporte (malha, frota, tripulação)          | Economia de USD 40 milhões (2001) |
| Operação de terminais (movimentação de veículos/equip.) | Economia de USD 80 milhões/ano  |
| Tabela de horários de transporte de passageiros         | Aumento de lucro de € 60 milhões/ano |
| Reconhecimento de imagens para tratamento médico        | Ganhos qualitativos em diagnóstico |
| Tabela de jogos (esportes)                              | Otimização logística de calendários |

#### 1.5 Definições Fundamentais

- **Modelo**: representação explícita e simplificada de uma realidade, utilizada com o propósito de compreender, modificar, administrar e controlar essa realidade.
- **Modelo Matemático**: representação de uma realidade através de expressões matemáticas.
- **Modelo de Otimização**: modelo matemático para identificar a **melhor solução (ótima) possível** para um problema.

---

### 2. COMPONENTES DE UM MODELO MATEMÁTICO DE OTIMIZAÇÃO

Todo modelo matemático de otimização tem **três componentes principais**:

| **Componente**         | **Pergunta que Responde**                         |
| ----------------------- | --------------------------------------------------- |
| **Variáveis de decisão** | O que se quer decidir?                              |
| **Função Objetivo**      | Qual a meta (maximizar ou minimizar)?               |
| **Restrições**           | Quais condições limitam as variáveis de decisão?    |

#### 2.1 Exemplo Introdutório — Transporte de Caixas

- **Problema**: dois tipos de caixas (A e B) devem ser transportadas em caminhões, mantendo a mesma proporção entre os tipos A e B em cada viagem. Capacidade do caminhão: 4.000 kg. Caixa tipo A = 10 kg; caixa tipo B = 15 kg. Qual o número máximo de caixas por viagem?

```
Variáveis de decisão:
  x_A = quantidade de caixas do tipo A (10 kg)
  x_B = quantidade de caixas do tipo B (15 kg)

Restrição (mesma proporção): x_A = x_B = x

Restrição de capacidade:
  10x_A + 15x_B ≤ 4000
  10x + 15x ≤ 4000
  25x ≤ 4000
  x ≤ 160

Solução:
  x_A = 160, x_B = 160
  Total de caixas = 320
```

- **Função Objetivo**: Maximizar a quantidade de caixas transportadas.
- Esse exemplo ilustra, de forma simples, como os três componentes (variáveis, objetivo, restrições) aparecem juntos em qualquer modelo.

---

### 3. TIPOS DE MODELOS DE PROGRAMAÇÃO MATEMÁTICA

#### 3.1 Programação Linear (PL)

- Modelos matemáticos de otimização em que **todas as equações são no formato linear aditivo**.
- **Variáveis de decisão**: contínuas (domínio dos números Reais, ℝ).
- **Função objetivo e restrições**: expressões lineares do tipo:

```
c₁x₁ + c₂x₂ + ... + cₙxₙ   (para constantes c₁, c₂, ..., cₙ)

Exemplo: 10x₁ + 3x₂ + 2x₃ + 9x₄ + x₅ + 7x₆ + 5x₇
```

#### 3.2 Variantes da Programação Linear

| **Modelo** | **Nome Completo**                          | **Domínio das Variáveis**                        |
| ----------- | -------------------------------------------- | --------------------------------------------------- |
| **PL**      | Programação Linear                          | Contínuas (ℝ)                                       |
| **PLI**     | Programação Linear Inteira                  | Números inteiros (0, 1, 2, ...)                     |
| **PLIM**    | Programação Linear Inteira Mista            | Mistura de contínuas e inteiras (0,73, 0,85, 1...)  |
| **PNL**     | Programação Não Linear                      | Equações não lineares (frações, polinômios, trigonométricas) |

- **Exemplos de termos não lineares (PNL)**:

```
3x₁x₂, x₁²           (multiplicação de variáveis, polinômios)
sen(x), cos(x), tan(x) (funções trigonométricas)
```

---

### 4. METODOLOGIA DE MODELAGEM MATEMÁTICA

#### 4.1 Ciclo Geral da Pesquisa Operacional

| **Etapa**                | **Descrição**                                                                             |
| -------------------------- | -------------------------------------------------------------------------------------------- |
| **Formular o problema**    | Definir claramente o problema.                                                              |
| **Observar o sistema**     | Coletar dados que afetam o problema.                                                         |
| **Modelar**                | Construir um modelo matemático que represente o problema com base nos dados.                |
| **Verificar modelo**       | Verificar se o modelo representa a realidade adequadamente e gera resultados realistas.      |
| **Selecionar alternativa** | Utilizar o modelo para comparar diferentes alternativas e selecionar a mais adequada.        |
| **Apresentar resultado**   | Comunicar os resultados e conclusões.                                                        |
| **Avaliar**                | Auxiliar na implementação e monitoramento contínuo dos resultados, adaptando o modelo quando necessário. |

#### 4.2 Etapas Práticas para Construção do Modelo Matemático

Sequência utilizada em todos os exemplos resolvidos do curso:

```
1. Entender o problema
2. Identificar (em palavras) as respostas que se busca para o problema
3. Identificar as variáveis de decisão
4. Descrever a função objetivo (em palavras)
5. Escrever a equação (linear) da função objetivo em função das variáveis de decisão
6. Descrever cada restrição (em palavras)
7. Escrever a equação (linear) de cada restrição em termos das variáveis de decisão
   → MODELO MATEMÁTICO completo
```

---

### 5. NATUREZA DAS VARIÁVEIS E DAS RESTRIÇÕES

#### 5.1 Tipos de Valores das Variáveis

- **Modelo matemático trata de quantidades mensuráveis**, quantificadas preferencialmente em uma unidade de medida.
- **Valores contínuos ou discretos**:
  - Número total de horas em um processo industrial
  - Número total de trabalhadores por turno de trabalho
  - Número total de toneladas ou m³ produzidos, consumidos e/ou transportados
  - Número de horas trabalhadas
- **Valores binários (0 ou 1)**:
  - Se um armazém é implantado na localidade (sim ou não)
  - Se um cliente é atendido por um armazém (sim ou não)

#### 5.2 Estrutura das Restrições

- Restrição = **comparação entre duas quantidades mensuráveis**, em que pelo menos um dos termos envolve variáveis de decisão.
- Operadores possíveis: **≤** (menor ou igual), **=** (igual), **≥** (maior ou igual).
- Podem também limitar o domínio das variáveis (inteiros, binários).

```
Número total de horas em um processo industrial ≤ 40
Número mínimo de m³ produzidos ≥ 1.000
Se um armazém é implantado na localidade ∈ {0; 1}
```

#### 5.3 Tipos de Restrições

| **Tipo**                    | **Significado**                                             | **Exemplos**                                                            |
| ----------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------- |
| **Limitação de recursos**     | Não pode usar/gastar/ocupar mais do que o total disponível     | Nº de unidades transportadas ≤ Nº disponíveis; Horas gastas ≤ Horas disponíveis; Total produzido ≤ Capacidade |
| **Desempenho mínimo**         | Deve atingir uma meta/quota/número mínimo                      | Nº de unidades produzidas ≥ Nº requerido; Toneladas embarcadas ≥ Mínimo   |
| **Conservação**               | Equilíbrio de entrada e saída                                   | Número de unidades entrando = número de unidades saindo                  |

---

### 6. EXEMPLO RESOLVIDO 1 — Corte de Bobinas de Aço

**Enunciado** (adaptado de Goldbarg & Luna, 2005, p.104): uma metalúrgica corta bobinas de aço em fitas usando duas máquinas. A máquina antiga corta até 4.000 m/dia (lucro de R$0,30/m; consome 3 homens-hora por 1.000 m). A máquina moderna corta até 6.000 m/dia (lucro de R$0,50/m; consome 2 homens-hora por 1.000 m). Disponibilidade de mão de obra: 18 homens-hora/dia. Objetivo: maximizar o lucro total diário.

**Passo a passo de modelagem:**

- **Variáveis de decisão**: `x` = metros de fita cortados na máquina antiga; `y` = metros de fita cortados na máquina moderna.
- **Função objetivo**: maximizar o lucro total diário.
- **Restrições**: capacidade de cada máquina + disponibilidade de mão de obra + domínio não negativo.

```
Maximizar   Z = 0,3x + 0,5y            (Lucro total diário)
sujeito a
    x ≤ 4000                            (Capacidade — Máquina Antiga)
    y ≤ 6000                            (Capacidade — Máquina Moderna)
    3x + 2y ≤ 18000                     (Disponibilidade de Mão de Obra,
                                          derivada de 3x/1000 + 2y/1000 ≤ 18)
    x, y ≥ 0                            (Domínio das Variáveis)
```

---

### 7. EXEMPLO RESOLVIDO 2 — Horas de Estudo

**Enunciado** (Santos, 2000, p.29): um aluno precisa de 20h de estudo intensivo para a disciplina D1 e 25h para D2. Precisa de no mínimo 50 de 100 pontos em cada disciplina. Pesos das disciplinas na média: D1 = 3, D2 = 5. Dispõe de apenas 30h no total. Objetivo: maximizar a média ponderada.

**Passo a passo de modelagem:**

- **Variáveis de decisão**: `H1` = horas dedicadas à disciplina 1; `H2` = horas dedicadas à disciplina 2.
- **Cálculo do rendimento por hora**: D1 → 100/20 = 5 pontos/hora; D2 → 100/25 = 4 pontos/hora.
- **Função objetivo**: maximizar a média ponderada dos pontos obtidos, ponderada pelos pesos 3 e 5.

```
Maximizar   Z = (15·H1 + 20·H2) / 8      (Média Ponderada,
                                           15 = 3×5 e 20 = 5×4, dividido pela soma dos pesos 3+5=8)
sujeito a
    H1 + H2 ≤ 30                         (Tempo Disponível)
    H1 ≥ 10                              (Nota Mínima na Disciplina 1: 5·H1 ≥ 50)
    H2 ≥ 12,5                            (Nota Mínima na Disciplina 2: 4·H2 ≥ 50)
    H1, H2 ≥ 0                           (Domínio das Variáveis)
```

---

### 8. EXEMPLO RESOLVIDO 3 — Venda de Livros

**Enunciado**: uma livraria receberá 40 cópias em capa mole e 65 em capa dura, mas precisa de no mínimo 80 cópias de cada versão. Um Centro de Distribuição (CD) pode enviar até 10 caixas: caixas "leves" (6 unidades de capa mole cada) e caixas "mistas" (5 unidades de capa dura + 2 de capa mole cada), havendo apenas 7 caixas mistas disponíveis. Objetivo: maximizar a quantidade de livros entregues.

**Tabela de composição das caixas:**

| **Tipo de Caixa** | **Capa Dura** | **Capa Mole** | **Total** |
| ------------------- | -------------- | -------------- | ----------- |
| Caixa Leve          | 0              | 6              | 6           |
| Caixa Mista         | 5              | 2              | 7           |

**Passo a passo de modelagem:**

- **Variáveis de decisão**: `L` = quantidade de caixas leves; `M` = quantidade de caixas mistas.
- **Função objetivo**: maximizar a quantidade total de livros entregues, `Q = 6L + (5M + 2M) = 6L + 7M`.

```
Maximizar   Q = 6L + 7M                  (Total de Livros Entregues)
sujeito a
    L + M ≤ 10                           (Total de Caixas Enviadas)
    M ≤ 7                                (Caixas Mistas Disponíveis)
    6L + 2M ≥ 40                         (Livros Capa Mole:
                                           6L + 2M + 40 ≥ 80)
    M ≥ 3                                (Livros Capa Dura:
                                           5M + 65 ≥ 80 → M ≥ 3)
    L, M ∈ ℤ⁺                            (Domínio: inteiros não negativos)
```

---

### 9. EXEMPLO RESOLVIDO 4 — Nova Ala de Hospital

**Enunciado**: um hospital planeja construir uma nova ala com área total de até 1.200 m². Serão oferecidos quartos individuais (1 leito, 10 m², receita $7.500/mês), duplos (2 leitos, 15 m², $6.000/mês) e triplos (3 leitos, 18 m², $4.500/mês). No máximo 70 quartos no total, no máximo 30 quartos individuais, e no mínimo 120 leitos. Objetivo: maximizar a receita mensal.

**Passo a passo de modelagem:**

- **Variáveis de decisão**: `q1` = quartos individuais; `q2` = quartos duplos; `q3` = quartos triplos.
- **Função objetivo**: maximizar a receita mensal.

```
Maximizar   R = 7500·q1 + 6000·q2 + 4500·q3   (Receita Mensal)
sujeito a
    10q1 + 15q2 + 18q3 ≤ 1200                 (Área Disponível)
    q1 + q2 + q3 ≤ 70                         (Capacidade Máxima de Quartos)
    q1 ≤ 30                                   (Limite de Quartos Individuais)
    q1 + 2q2 + 3q3 ≥ 120                      (Número Mínimo de Leitos)
    q1, q2, q3 ∈ ℤ⁺                           (Domínio: inteiros não negativos)
```

---

## 🐍 Implementação Python

> **Nota importante**: os slides desta aula tratam exclusivamente da **formulação** dos modelos matemáticos (variáveis, função objetivo, restrições). A **resolução** desses modelos (Método Simplex e derivados) é o assunto anunciado como "Motivação para próxima aula". O código abaixo é uma implementação prática — usando `PuLP` (para PL/PLI, com solução exata) e `scipy.optimize.linprog` (para PL contínua) — dos **quatro modelos exatamente como formulados nos slides**, para permitir explorá-los computacionalmente antes da próxima aula sobre métodos de solução.

### Bibliotecas Essenciais

```python
# Modelagem e resolução de Programação Linear / Inteira
import pulp

# Resolução de Programação Linear contínua (método simplex/interior-point)
from scipy.optimize import linprog

# Manipulação de dados e visualização (para análise de sensibilidade e gráficos)
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
```

### Exemplo 1 — Corte de Bobinas de Aço (PL contínua)

```python
import pulp

# Criação do problema (maximização)
modelo = pulp.LpProblem("Corte_Bobinas_Aco", pulp.LpMaximize)

# Variáveis de decisão (contínuas, não negativas)
x = pulp.LpVariable("x_maquina_antiga", lowBound=0)
y = pulp.LpVariable("y_maquina_moderna", lowBound=0)

# Função objetivo: maximizar o lucro total diário
modelo += 0.3 * x + 0.5 * y, "Lucro_Total"

# Restrições
modelo += x <= 4000, "Capacidade_Maquina_Antiga"
modelo += y <= 6000, "Capacidade_Maquina_Moderna"
modelo += 3 * x + 2 * y <= 18000, "Disponibilidade_Mao_de_Obra"

# Resolver
modelo.solve()

print(f"Status: {pulp.LpStatus[modelo.status]}")
print(f"x (máquina antiga) = {x.varValue:.0f} metros")
print(f"y (máquina moderna) = {y.varValue:.0f} metros")
print(f"Lucro máximo = R$ {pulp.value(modelo.objective):.2f}")
# Solução ótima: x = 2000, y = 6000, Lucro = R$ 3.600,00/dia
```

### Exemplo 2 — Horas de Estudo (PL contínua)

```python
modelo = pulp.LpProblem("Horas_de_Estudo", pulp.LpMaximize)

H1 = pulp.LpVariable("H1_disciplina_1", lowBound=0)
H2 = pulp.LpVariable("H2_disciplina_2", lowBound=0)

# Função objetivo: maximizar a média ponderada
modelo += (15 * H1 + 20 * H2) / 8, "Media_Ponderada"

modelo += H1 + H2 <= 30, "Tempo_Disponivel"
modelo += H1 >= 10, "Nota_Minima_D1"
modelo += H2 >= 12.5, "Nota_Minima_D2"

modelo.solve()

print(f"H1 = {H1.varValue:.2f} horas | H2 = {H2.varValue:.2f} horas")
print(f"Média ponderada máxima = {pulp.value(modelo.objective):.2f} pontos")
# Solução ótima: H1 = 10h, H2 = 20h, Média ponderada = 68,75 pontos
```

### Exemplo 3 — Venda de Livros (PLI — variáveis inteiras)

```python
modelo = pulp.LpProblem("Venda_de_Livros", pulp.LpMaximize)

# Variáveis inteiras não negativas (número de caixas)
L = pulp.LpVariable("L_caixas_leves", lowBound=0, cat="Integer")
M = pulp.LpVariable("M_caixas_mistas", lowBound=0, cat="Integer")

modelo += 6 * L + 7 * M, "Total_Livros_Entregues"

modelo += L + M <= 10, "Total_Caixas"
modelo += M <= 7, "Caixas_Mistas_Disponiveis"
modelo += 6 * L + 2 * M >= 40, "Livros_Capa_Mole"
modelo += M >= 3, "Livros_Capa_Dura"

modelo.solve()

print(f"L (caixas leves) = {L.varValue:.0f} | M (caixas mistas) = {M.varValue:.0f}")
print(f"Total de livros entregues = {pulp.value(modelo.objective):.0f}")
# Solução ótima: L = 5, M = 5, Total = 65 livros
```

### Exemplo 4 — Nova Ala de Hospital (PLI — variáveis inteiras)

```python
modelo = pulp.LpProblem("Nova_Ala_Hospital", pulp.LpMaximize)

q1 = pulp.LpVariable("q1_individuais", lowBound=0, cat="Integer")
q2 = pulp.LpVariable("q2_duplos", lowBound=0, cat="Integer")
q3 = pulp.LpVariable("q3_triplos", lowBound=0, cat="Integer")

modelo += 7500 * q1 + 6000 * q2 + 4500 * q3, "Receita_Mensal"

modelo += 10 * q1 + 15 * q2 + 18 * q3 <= 1200, "Area_Disponivel"
modelo += q1 + q2 + q3 <= 70, "Capacidade_Maxima_Quartos"
modelo += q1 <= 30, "Limite_Quartos_Individuais"
modelo += q1 + 2 * q2 + 3 * q3 >= 120, "Numero_Minimo_Leitos"

modelo.solve()

print(f"q1 = {q1.varValue:.0f} | q2 = {q2.varValue:.0f} | q3 = {q3.varValue:.0f}")
print(f"Receita mensal máxima = $ {pulp.value(modelo.objective):.2f}")
# Solução ótima: q1 = 30, q2 = 30, q3 = 10, Receita = $ 450.000,00/mês
```

### Alternativa com `scipy.optimize.linprog` (PL contínua)

`linprog` resolve por padrão problemas de **minimização**; para maximizar, inverte-se o sinal da função objetivo.

```python
from scipy.optimize import linprog

# Exemplo 1 — Corte de Bobinas de Aço
# Maximizar 0,3x + 0,5y  <=>  Minimizar -0,3x - 0,5y
c = [-0.3, -0.5]

# Restrições no formato A_ub @ [x, y] <= b_ub
A_ub = [
    [1, 0],   # x <= 4000
    [0, 1],   # y <= 6000
    [3, 2],   # 3x + 2y <= 18000
]
b_ub = [4000, 6000, 18000]

resultado = linprog(c, A_ub=A_ub, b_ub=b_ub, bounds=[(0, None), (0, None)], method="highs")

x_opt, y_opt = resultado.x
lucro_max = -resultado.fun
print(f"x = {x_opt:.0f} | y = {y_opt:.0f} | Lucro máximo = R$ {lucro_max:.2f}")
```

---

## 📊 Exemplos Práticos do Curso

### Exemplo 1: Corte de Bobinas de Aço (PL Contínua)

- **Fonte**: Goldbarg, M.C. & Luna, H.P.L. (2005), *Otimização Combinatória e Programação Linear*, p.104.
- **Contexto**: metalúrgica que corta bobinas de aço em fitas usando duas máquinas com capacidades e produtividades diferentes.
- **Variáveis**: `x` (metros na máquina antiga), `y` (metros na máquina moderna).
- **Restrições-chave**: capacidade de corte de cada máquina + disponibilidade de mão de obra.
- **Resultado (via solver)**: x = 2.000 m, y = 6.000 m, lucro máximo = R$ 3.600,00/dia.

### Exemplo 2: Horas de Estudo (PL Contínua)

- **Fonte**: Santos, M. P. (2000), *Programação Linear*, UERJ, p.29.
- **Contexto**: aluno decidindo como distribuir 30h de estudo entre duas disciplinas com pesos diferentes na média.
- **Variáveis**: `H1`, `H2` (horas dedicadas a cada disciplina).
- **Restrições-chave**: tempo total disponível + nota mínima em cada disciplina.
- **Resultado (via solver)**: H1 = 10h, H2 = 20h, média ponderada máxima = 68,75 pontos.

### Exemplo 3: Venda de Livros (Programação Linear Inteira)

- **Contexto**: Centro de Distribuição decidindo quantas caixas leves e mistas enviar a uma livraria para maximizar o número de livros entregues, respeitando limites de estoque mínimo por versão.
- **Variáveis**: `L` (caixas leves), `M` (caixas mistas) — ambas inteiras.
- **Restrições-chave**: total de caixas, disponibilidade de caixas mistas, estoque mínimo de capa mole e capa dura.
- **Resultado (via solver)**: L = 5, M = 5, total de 65 livros entregues.

### Exemplo 4: Nova Ala de Hospital (Programação Linear Inteira)

- **Contexto**: diretor de hospital decidindo a composição de quartos (individuais, duplos, triplos) de uma nova ala para maximizar a receita mensal.
- **Variáveis**: `q1`, `q2`, `q3` (quantidade de cada tipo de quarto) — todas inteiras.
- **Restrições-chave**: área construída, número total de quartos, limite de quartos individuais, número mínimo de leitos.
- **Resultado (via solver)**: q1 = 30, q2 = 30, q3 = 10, receita máxima = $ 450.000,00/mês.

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Os Três Componentes de Todo Modelo de Otimização

| **Componente**      | **O que representa**                          | **Exemplo (Corte de Bobinas)**          |
| --------------------- | ------------------------------------------------ | ------------------------------------------ |
| **Variáveis de decisão** | O que se quer decidir                          | `x` (metros na máquina antiga), `y` (metros na máquina moderna) |
| **Função Objetivo**      | A meta a maximizar ou minimizar                | Maximizar Z = 0,3x + 0,5y                 |
| **Restrições**           | Condições que limitam as variáveis             | x ≤ 4000; y ≤ 6000; 3x + 2y ≤ 18000       |

### 🎯 Classificação dos Modelos de Programação Matemática

| **Sigla** | **Nome**                             | **Característica das Variáveis**   |
| ---------- | -------------------------------------- | ------------------------------------- |
| **PL**     | Programação Linear                     | Contínuas (ℝ)                          |
| **PLI**    | Programação Linear Inteira             | Inteiras (0, 1, 2, ...)                |
| **PLIM**   | Programação Linear Inteira Mista       | Contínuas e inteiras combinadas       |
| **PNL**    | Programação Não Linear                 | Funções não lineares (produtos, potências, trigonométricas) |

### 📐 Fórmulas e Estruturas Essenciais

```
1. Expressão Linear Genérica:
   c₁x₁ + c₂x₂ + ... + cₙxₙ    (constantes c₁,...,cₙ; variáveis contínuas x₁,...,xₙ)

2. Estrutura Geral de um Modelo de PL:
   Maximizar (ou Minimizar)  Z = c₁x₁ + c₂x₂ + ... + cₙxₙ
   sujeito a
       a₁₁x₁ + a₁₂x₂ + ... + a₁ₙxₙ  {≤, =, ≥}  b₁
       a₂₁x₁ + a₂₂x₂ + ... + a₂ₙxₙ  {≤, =, ≥}  b₂
       ...
       xᵢ ≥ 0  (domínio das variáveis)

3. Restrição de Limitação de Recursos:
   Uso do recurso ≤ Disponibilidade do recurso

4. Restrição de Desempenho Mínimo:
   Quantidade produzida/entregue ≥ Meta mínima

5. Restrição de Conservação:
   Unidades entrando = Unidades saindo

6. Combinações possíveis (ilustração de complexidade combinatória):
   500 entregas / 25 veículos → 1,0439 × 10⁴² combinações
```

### 🗂️ Tipos de Valores das Variáveis

| **Tipo**       | **Domínio**            | **Exemplo**                                          |
| --------------- | ------------------------ | ------------------------------------------------------- |
| **Contínuo**    | ℝ (números reais)        | Toneladas produzidas, horas trabalhadas                |
| **Discreto**    | ℤ (números inteiros)     | Número de trabalhadores, número de caixas              |
| **Binário**     | {0, 1}                   | Se um armazém é implantado (sim/não)                    |

### 🧭 As Etapas de Modelagem (Resumo Mnemônico)

```
ENTENDER → IDENTIFICAR RESPOSTAS → IDENTIFICAR VARIÁVEIS →
DESCREVER OBJETIVO → ESCREVER EQUAÇÃO DO OBJETIVO →
DESCREVER RESTRIÇÕES → ESCREVER EQUAÇÕES DAS RESTRIÇÕES →
MODELO MATEMÁTICO COMPLETO
```

---

## ⚠️ Erros Comuns a Evitar

1. **Confundir Modelo Matemático com Modelo de Otimização**: todo modelo de otimização é matemático, mas nem todo modelo matemático busca uma solução ótima.
2. **Esquecer a restrição de domínio das variáveis** (`x, y ≥ 0` ou `∈ ℤ⁺`): sem ela, o modelo pode admitir soluções sem sentido prático (ex.: quantidades negativas).
3. **Usar variáveis contínuas quando o problema exige valores inteiros** (ex.: número de caixas, quartos, aviões) — nesses casos o modelo é PLI ou PLIM, não PL.
4. **Não distinguir restrições de "limitação de recursos" das de "desempenho mínimo"**: a direção da desigualdade (≤ vs. ≥) muda completamente o significado da restrição.
5. **Formular a função objetivo antes de identificar corretamente as variáveis de decisão**: a sequência correta é sempre variáveis → objetivo → restrições.
6. **Ignorar unidades de medida ao converter enunciados em equações** (ex.: "3 homens-hora por 1.000 metros" precisa ser convertido corretamente antes de somar com outras restrições, como em 3x/1000 + 2y/1000 ≤ 18 → 3x + 2y ≤ 18000).
7. **Confundir uma restrição linear com uma não linear**: termos como `x²`, `x₁·x₂`, `sen(x)` tornam o modelo PNL, exigindo métodos de resolução diferentes dos usados em PL/PLI.
8. **Tentar resolver mentalmente/por tentativa e erro problemas combinatoriamente grandes**: como demonstrado no exemplo das 500 entregas/25 veículos (10⁴² combinações), é inviável enumerar soluções manualmente — por isso a P.O. existe.
9. **Achar que a modelagem é a etapa final**: o ciclo completo de P.O. inclui também verificar o modelo, selecionar a alternativa, apresentar resultados e avaliar continuamente — a formulação matemática é apenas uma etapa do processo.

---

## 📚 Materiais de Apoio

### Arquivo Principal

- **Pesquisa Operacional 040826_SLpdf Portugues.pdf**: slides completos da aula (77 páginas), incluindo fundamentos teóricos e quatro exemplos completos de modelagem passo a passo.

### Exemplos/Problemas Trabalhados na Aula

- **Transporte de caixas (introdutório)**: proporção de caixas A/B em caminhões com limite de peso.
- **Corte de bobinas de aço**: alocação de produção entre duas máquinas (Goldbarg & Luna, 2005).
- **Horas de estudo**: distribuição de tempo de estudo entre duas disciplinas (Santos, 2000).
- **Venda de livros**: alocação de caixas de livros entre um CD e uma livraria.
- **Nova ala de hospital**: definição da composição de tipos de quartos em uma nova construção hospitalar.

---

## 📖 Referências Recomendadas

### Leitura Recomendada (indicada nos slides)

1. **Santos, M. P. (2000).** *Programação Linear*. Universidade do Estado do Rio de Janeiro. Disponível em: https://www.mpsantos.com.br/Plinear.pdf (Capítulo 1, pág. 16–23).
2. **Goldbarg, M.C. & Luna, H.P.L. (2005).** *Otimização Combinatória e Programação Linear: Modelos e Algoritmos*. 2ª ed. Rio de Janeiro: Elsevier. (Capítulo 1, pág. 1–16; Capítulo 2, pág. 25–38).

### Bibliografia (indicada nos slides)

3. **Bradley, S. P.; Hax, A. C.; & Magnanti, T. L. (1977).** *Applied Mathematical Programming*. Addison-Wesley Pub. Co. Reading, Mass. Disponível em: http://web.mit.edu/15.053/www/AMP.htm
4. **Arenales, M. N.; Armentano, V. A.; Morabito Neto, R.; & Yanasse, H. H. (2007).** *Pesquisa Operacional*. Elsevier, 1ª edição.
5. **Winston, W. L. (2004).** *Operations Research: Applications and Algorithms*. Thomson Learning, Inc. (indicado também como *An Introduction to Model Building*).

### Recursos Online

- **PuLP (documentação oficial)**: biblioteca Python para modelagem e resolução de PL/PLI.
- **SciPy `optimize.linprog`**: solver de Programação Linear contínua em Python.
- **Artigo motivador**: "Why Operations Research is Awesome — An Introduction", disponível em towardsdatascience.com.

---

## ✅ Checklist de Estudo

### Conceitos Teóricos

- [ ] Entender a definição de Pesquisa Operacional como "ciência da tomada de decisão"
- [ ] Conhecer a origem histórica da P.O. (2ª Guerra Mundial)
- [ ] Compreender por que problemas reais são combinatoriamente complexos (exemplo das 500 entregas/25 veículos)
- [ ] Diferenciar Modelo, Modelo Matemático e Modelo de Otimização
- [ ] Reconhecer exemplos reais de impacto econômico de aplicações de P.O.

### Componentes do Modelo

- [ ] Identificar variáveis de decisão em um enunciado de problema
- [ ] Formular a função objetivo (maximizar ou minimizar) em palavras e depois em equação
- [ ] Formular restrições em palavras e depois em equação matemática
- [ ] Incluir corretamente a restrição de domínio das variáveis (≥ 0, inteiros, binários)

### Classificação de Modelos

- [ ] Diferenciar PL, PLI, PLIM e PNL
- [ ] Reconhecer quando uma variável deve ser contínua, discreta ou binária
- [ ] Identificar termos que tornam um modelo não linear (produtos de variáveis, potências, funções trigonométricas)

### Metodologia de Modelagem

- [ ] Aplicar as sete etapas de construção de um modelo matemático (entender → identificar respostas → variáveis → objetivo → equação do objetivo → restrições → equações das restrições)
- [ ] Compreender o ciclo completo de P.O. (formular, observar, modelar, verificar, selecionar, apresentar, avaliar)
- [ ] Classificar restrições em limitação de recursos, desempenho mínimo ou conservação

### Implementação Python

- [ ] Formular e resolver um modelo de PL contínua com PuLP
- [ ] Formular e resolver um modelo de PLI (variáveis inteiras) com PuLP
- [ ] Resolver um modelo de PL contínua com `scipy.optimize.linprog`
- [ ] Interpretar o status e o valor da função objetivo retornados pelo solver

### Casos Práticos

- [ ] Reproduzir o Exemplo Introdutório (transporte de caixas)
- [ ] Reproduzir o Exemplo 1 (Corte de bobinas de aço)
- [ ] Reproduzir o Exemplo 2 (Horas de estudo)
- [ ] Reproduzir o Exemplo 3 (Venda de livros — PLI)
- [ ] Reproduzir o Exemplo 4 (Nova ala de hospital — PLI)
- [ ] Formular um modelo de otimização a partir de um problema real próprio

### Preparação para a Próxima Aula

- [ ] Revisar os quatro modelos formulados nesta aula (serão usados como ponto de partida)
- [ ] Estudar o conceito de Método Simplex (mencionado como próximo passo para "obter a solução ótima")

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_
_Módulo 27 - Pesquisa Operacional e Modelos de Otimização_
