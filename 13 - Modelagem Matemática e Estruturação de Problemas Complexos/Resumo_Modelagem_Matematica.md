# 🔢 Resumo: Modelagem Matemática e Estruturação de Problemas Complexos

**MBA Data Science e Analytics - USP/ESALQ**
**Professor:** Dr. Marcos dos Santos (Marinha do Brasil | UFF | IME | ITA)
**Aulas:** 28/10/2025 (Aula I) e 04/11/2025 (Aula II)

---

## 🎯 Objetivo do Módulo

Aplicar **Pesquisa Operacional** e **métodos multicritério de apoio à decisão** em problemas complexos de negócio. O foco das aulas é o uso do **Método AHP** (Analytic Hierarchy Process) e do **Método AHP-Gaussiano** para tomada de decisão estruturada, transparente e rastreável em cenários com múltiplos critérios e alternativas.

---

## 📚 Conteúdo das Aulas

---

### AULA I — 28/10/2025: Pesquisa Operacional, Tomada de Decisão e Método AHP

---

### 1. **Pesquisa Operacional (PO)**

> _"Operational Research is a scientific approach to the solution of problems in the management of complex systems that enables decision makers to make better decisions. OR uses advanced analytics, modelling, problem structuring, simulation, optimization and data science to determine the best solution to the problem."_

#### 1.1 O que é Pesquisa Operacional?

- Abordagem **científica** para resolver problemas em sistemas complexos
- Auxilia tomadores de decisão a **tomar melhores decisões**
- Usa: analytics avançado, modelagem, estruturação de problemas, simulação, otimização e ciência de dados

#### 1.2 Áreas da Pesquisa Operacional

| Área                                  | Descrição                                            |
| ------------------------------------- | ---------------------------------------------------- |
| **Apoio Multicritério à Decisão**     | MCDM: AHP, TOPSIS, THOR, SAPEVO, ELECTRE, PROMETHEE  |
| **Análise Envoltória de Dados (DEA)** | Eficiência relativa entre unidades                   |
| **Programação Linear**                | Otimização com função objetivo e restrições lineares |
| **Programação Inteira**               | Variáveis inteiras ou binárias (0-1)                 |
| **Simulação de Eventos Discretos**    | Modelar sistemas com filas e eventos                 |
| **Teoria das Filas**                  | Esperas em sistemas de serviço                       |
| **Teoria dos Grafos**                 | Redes, caminhos, fluxos                              |
| **Ciência de Dados / Estatística**    | Análise de dados e modelagem preditiva               |

#### 1.3 Retorno do Uso da PO

Empresas que aplicam Pesquisa Operacional reportam economias significativas e ganhos em eficiência operacional. Decisões embasadas em modelos são mais transparentes, rastreáveis e defensáveis.

---

### 2. **Tomada de Decisão**

#### 2.1 Conceito

- Uma **decisão** precisa ser tomada sempre que há **mais de uma alternativa** para resolver um problema
- Mesmo quando há apenas uma ação possível, a escolha é entre **tomar ou não tomar** essa ação
- O processo de decisão requer:
  - Um conjunto de **alternativas factíveis**
  - Cada decisão tem associado um **ganho** e uma **perda**

#### 2.2 Quando Usar Métodos Multicritério (MCDM)?

Problemas de **Multi-Criteria Decision Making (MCDM)** são caracterizados por:

- Uma **Matriz de Decisão** com alternativas e critérios
- Critérios com **pesos diferentes** (importâncias distintas)
- Critérios **conflitantes** entre si (ex: custo vs. qualidade)
- Necessidade de selecionar a **melhor alternativa** entre um número finito de opções

#### 2.3 Principais Métodos MCDM

- **AHP** (Analytic Hierarchy Process) — Saaty (1977)
- **TOPSIS** — Técnica para ordem de preferência por similaridade à solução ideal
- **THOR** — Teoria Híbrida de Ordenação
- **SAPEVO-M** — Sistema de Apoio à Preferência por Eliminação Vetorial com Orientação
- **ELECTRE** — Eliminação e Escolha Traduzindo a Realidade
- **PROMETHEE / PrOPPAGA** — Método de Fluxos de Superação
- **AHP-Gaussiano** — Santos et al. (2021) — variante moderna do AHP

---

### 3. **Método AHP (Analytic Hierarchy Process)**

> _"O AHP é um método de tomada de decisão multicritério simples de usar e flexível."_
> — Saaty T. L. (1977)

#### 3.1 O que é o AHP?

- Desenvolvido pelo Prof. **Thomas Saaty** na Escola Wharton / Universidade da Pensilvânia (anos 1970)
- Baseado em **Matemática e Psicologia** (Escala Psicométrica)
- Permite trabalhar com questões **subjetivas** nas atribuições de desempenho
- Ganhos com o AHP:
  - **Transparência** no processo decisório
  - **Lisura** (imparcialidade)
  - **Rastreabilidade**
  - **Replicabilidade**

#### 3.2 Estrutura Axiomática do AHP

```
1. Definir o OBJETIVO (ex: escolher o melhor smartphone)
         |
2. Definir os CRITÉRIOS (ex: Custo, Câmera, Armazenamento, Bateria)
         |
3. Definir as ALTERNATIVAS (ex: Xiaomi, Samsung, Iphone)
```

#### 3.3 Escala Fundamental de Saaty (Escala Psicométrica)

| Grau de Importância | Relação de Importância       | Recíproca |
| ------------------- | ---------------------------- | --------- |
| 1                   | Igualdade                    | 1         |
| 2                   | Intermediário                | 1/2       |
| 3                   | Importância moderada         | 1/3       |
| 4                   | Intermediário                | 1/4       |
| 5                   | Mais importante              | 1/5       |
| 6                   | Intermediário                | 1/6       |
| 7                   | Muito mais importante        | 1/7       |
| 8                   | Intermediário                | 1/8       |
| 9                   | Extremamente mais importante | 1/9       |

> A avaliação é realizada **par a par** entre as variáveis (critérios/alternativas)

#### 3.4 Processo Geral do Método AHP

**Passo 1 — Definir critérios e alternativas** → Construir a Matriz de Decisão

**Passo 2 — Avaliação dos critérios (comparação par a par)**

Exemplo com 3 critérios A, B, C:

```
      A    B    C
A  [  1    5    7 ]   → A é muito mais importante que B (7)
B  [1/5    1    3 ]   → A é mais importante que B (5)
C  [1/7  1/3    1 ]   → B tem importância moderada sobre C (3)
```

**Passo 3 — Normalização dos julgamentos → Vetor Prioridade (Pesos dos Critérios)**

1. Somar cada coluna da matriz
2. Dividir cada elemento pelo total da coluna
3. Calcular a média de cada linha → **Vetor Prioridade**

$$\text{Vetor} = \frac{\sum a_{ij}}{\text{total por linha}}$$

**Passo 4 — Teste de Consistência (CR)**

A transitividade deve ser satisfeita: se A > B e B > C, então A > C.

**Índice de Consistência (CI):**
$$CI = \frac{\lambda_{máx} - n}{n - 1}$$

**Razão de Consistência (CR):**
$$CR = \frac{CI}{RI}$$

- Se **CR < 10% (0,10)** → atribuições são **consistentes** ✅
- Se **CR ≥ 10%** → revisar as atribuições ❌

**Valores de RI (Índice Aleatório de Saaty):**

| n   | 1   | 2   | 3    | 4    | 5    | 6    | 7    | 8    | 9    | 10   |
| --- | --- | --- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| RI  | 0   | 0   | 0,58 | 0,90 | 1,12 | 1,24 | 1,32 | 1,41 | 1,45 | 1,49 |

**Passo 5 — Avaliação das alternativas em cada critério**

Repetir o mesmo processo de comparação par a par para as alternativas dentro de cada critério → vetor prioridade por critério.

**Passo 6 — Agregação (Resultado Final)**

Multiplicar os pesos dos critérios pelos valores normalizados das alternativas em cada critério → **ranking final das alternativas**.

#### 3.5 Uso com Dados Quantitativos

Quando já temos dados numéricos das alternativas em cada critério, aplica-se normalização direta:

**Monotônico de custo** (quanto menor, melhor → ex: preço):
$$x_{ij} = \frac{1}{a_{ij}} \quad;\quad \upsilon_{ij} = \frac{x_{ij}}{\sum x_{ij}}$$

**Monotônico de lucro** (quanto maior, melhor → ex: câmera em MP):
$$\upsilon_{ij} = \frac{a_{ij}}{\sum a_{ij}}$$

#### 3.6 Exemplo Prático: Escolha de Smartphone

|         | Custo (R$) | Câmera (MP) | Armazenamento (GB) | Bateria (h) |
| ------- | ---------- | ----------- | ------------------ | ----------- |
| Xiaomi  | 1.500      | 12          | 64                 | 24          |
| Samsung | 1.800      | 12          | 128                | 18          |
| Iphone  | 5.000      | 20          | 128                | 10          |

**Pesos dos critérios (via comparação par a par):**

- Custo: **0,548** | Câmera: **0,283** | Armazenamento: **0,117** | Bateria: **0,052**

**Matriz normalizada das alternativas:**
| | Custo | Câmera | Armaz. | Bateria |
|-----------|-------|--------|--------|---------|
| Xiaomi | 0,468 | 0,273 | 0,200 | 0,462 |
| Samsung | 0,390 | 0,273 | 0,400 | 0,346 |
| Iphone | 0,140 | 0,454 | 0,400 | 0,192 |

**Resultado:**

1. 🥇 Xiaomi
2. 🥈 Samsung
3. 🥉 Iphone

#### 3.7 Ferramentas Computacionais

- **3DM** (Three Decision Methods) — desenvolvida no IME, gratuita para uso pessoal e acadêmico
  - Disponível em: [www.3decisionmethods.com](http://www.3decisionmethods.com)

---

### AULA II — 04/11/2025: Limitações do AHP e Método AHP-Gaussiano

---

### 4. **Limitações do Método AHP**

Apesar de amplamente utilizado, o AHP possui restrições práticas:

1. Funciona bem para até **7 a 15 critérios**
2. O número de comparações par a par cresce muito rapidamente: $\frac{n(n-1)}{2}$
3. **Desgaste cognitivo** do tomador de decisão
4. Dificuldade de obter **CR < 10%** em problemas grandes
5. Exige muito tempo do decisor
6. A atribuição dos **pesos é subjetiva** — pode gerar questionamentos sobre viés

---

### 5. **Método AHP-Gaussiano**

> _"O Método AHP-Gaussiano apresenta uma nova abordagem ao método original, baseada em uma análise de sensibilidade proveniente do fator gaussiano."_
> — Santos et al. (2020)

#### 5.1 Origem e Publicações

| Ano  | Evento/Publicação                                               |
| ---- | --------------------------------------------------------------- |
| 2016 | Apresentado no **SBPO** (Simpósio Brasileiro de PO), Vitória/ES |
| 2020 | Apresentado na **Universidade da Pensilvânia**                  |
| 2021 | Publicado no **IJAHP** (International Journal of the AHP)       |
| 2025 | Publicado na revista **Nature**                                 |

> Desenvolvido pelo próprio **Prof. Dr. Marcos dos Santos** e seu grupo de pesquisa (IME/UFF).

#### 5.2 O que há de diferente no AHP-Gaussiano?

| AHP Clássico                                           | AHP-Gaussiano                                                             |
| ------------------------------------------------------ | ------------------------------------------------------------------------- |
| Pesos obtidos via comparação **par a par** (subjetiva) | Pesos obtidos **automaticamente** a partir dos dados da matriz de decisão |
| Esforço cognitivo alto do decisor                      | **Menor esforço cognitivo** — o decisor só preenche a Matriz de Decisão   |
| Risco de inconsistência (RC ≥ 10%)                     | **Sem teste de consistência** necessário                                  |
| Limitado a ~15 critérios                               | Funciona com **muitos critérios e alternativas**                          |
| Subjetividade nos pesos                                | **Transparência** e imparcialidade nos pesos                              |

> **Ideia central:** os pesos dos critérios são derivados da **dispersão** (variabilidade) dos dados de cada critério — critérios com maior dispersão relativa recebem maior peso, pois discriminam melhor as alternativas.

#### 5.3 As 8 Etapas do AHP-Gaussiano

**Passo 1 — Construção da Matriz de Decisão**

Definir alternativas e critérios com os dados quantitativos correspondentes.

|         | Custo (R$) | Câmera (MP) | Armaz. (GB) | Bateria (h) |
| ------- | ---------- | ----------- | ----------- | ----------- |
| Xiaomi  | 1.500      | 12          | 64          | 24          |
| Samsung | 1.800      | 12          | 128         | 18          |
| Iphone  | 5.000      | 20          | 128         | 10          |

---

**Passo 2 — Normalização da Matriz de Decisão**

Tornar todos os critérios **adimensionais** e comparáveis:

- **Monotônico de custo** (menor = melhor): $x_{ij} = \frac{1}{a_{ij}}$, depois normalizar pela soma
- **Monotônico de lucro** (maior = melhor): $\upsilon_{ij} = \frac{a_{ij}}{\sum a_{ij}}$

Resultado da normalização:

|         | Custo | Câmera | Armaz. | Bateria |
| ------- | ----- | ------ | ------ | ------- |
| Xiaomi  | 0,468 | 0,273  | 0,200  | 0,462   |
| Samsung | 0,390 | 0,273  | 0,400  | 0,346   |
| Iphone  | 0,140 | 0,454  | 0,400  | 0,192   |

---

**Passo 3 — Transpor a Matriz e Calcular a Média por Critério**

A média de cada critério é sempre igual a $\frac{1}{n}$ (neste caso: $\frac{1}{3} = 0{,}3333$).

---

**Passo 4 — Calcular o Desvio Padrão por Critério**

| Critério      | Média  | Desvio Padrão |
| ------------- | ------ | ------------- |
| Custo         | 0,3333 | 0,1714        |
| Câmera        | 0,3333 | 0,1045        |
| Armazenamento | 0,3333 | 0,1155        |
| Bateria       | 0,3333 | 0,1354        |

---

**Passo 5 — Calcular o Fator Gaussiano (Coeficiente de Variação)**

$$FG_j = \frac{\text{Desvio Padrão}_j}{\text{Média}_j} = CV_j$$

| Critério      | Fator Gaussiano |
| ------------- | --------------- |
| Custo         | 0,5142          |
| Câmera        | 0,3135          |
| Armazenamento | 0,3465          |
| Bateria       | 0,4062          |

---

**Passo 6 — Normalizar o Fator Gaussiano (Peso de cada Critério)**

$$FGN_j = \frac{FG_j}{\sum FG_j}$$

| Critério      | Fator Gaussiano Normalizado (Peso) |
| ------------- | ---------------------------------- |
| Custo         | **0,3254**                         |
| Câmera        | **0,1984**                         |
| Armazenamento | **0,2192**                         |
| Bateria       | **0,2570**                         |

> Note: o critério **Custo** recebe maior peso porque é o critério com maior variação relativa entre as alternativas → portanto, discrimina mais.

---

**Passo 7 — Agregar: Multiplicar Alternativas Normalizadas pelos Pesos Gaussianos**

$$Score_i = \sum_{j} \upsilon_{ij} \times FGN_j$$

---

**Passo 8 — Ranking Final**

| Alternativa | Score AHP-Gaussiano | Ranking |
| ----------- | ------------------- | ------- |
| Xiaomi      | 0,369               | 🥇 1º   |
| Samsung     | 0,358               | 🥈 2º   |
| Iphone      | 0,273               | 🥉 3º   |

> O mesmo resultado do AHP clássico, mas com **pesos obtidos objetivamente**, sem comparações par a par e sem risco de inconsistência!

#### 5.4 Pontos Fortes do AHP-Gaussiano

1. **Método novo** — publicado em 2021 (estado da arte)
2. **Conceito intuitivo** — baseado em dispersão (coeficiente de variação)
3. **Fácil de usar** — basta preencher a Matriz de Decisão
4. **Escalável** — funciona com muitas alternativas e muitos critérios
5. **Menor esforço cognitivo** — não há comparações par a par
6. **Ferramentas gratuitas** — R, Python, Excel, Julia
7. **Ampla aplicabilidade** — de problemas simples do cotidiano a decisões militares e governamentais de alto nível

#### 5.5 Exemplo de Aplicação Militar

**Critérios:** Custo, Alcance, Mísseis, Velocidade máxima, Transporte de tropa
**Alternativas:** Apache, Katran, Viper

O método estrutura a decisão de seleção de helicóptero com critérios quantitativos, gerando um ranking transparente e defensável.

#### 5.6 Ferramenta Computacional

- **AHP-Gaussiano online (R/Shiny):** https://decision-making.shinyapps.io/gaussian_ahp/
- **YouTube:** https://www.youtube.com/watch?v=nsW3O7nNuHM
- **Canal da PO:** https://www.youtube.com/@CasadaPesquisaOperacional

---

### 6. **Comparativo AHP vs. AHP-Gaussiano**

| Característica      | AHP Clássico (Saaty, 1977)                                | AHP-Gaussiano (Santos, 2021)                  |
| ------------------- | --------------------------------------------------------- | --------------------------------------------- |
| Pesos dos critérios | Comparação par a par (subjetiva)                          | Fator Gaussiano (objetivo, baseado nos dados) |
| Esforço do decisor  | Alto (matriz de julgamentos)                              | Baixo (apenas Matriz de Decisão)              |
| Consistência        | Deve ser verificada (CR < 10%)                            | Não requer verificação                        |
| Número de critérios | Até ~7-15                                                 | Ilimitado                                     |
| Transparência       | Moderada                                                  | Alta                                          |
| Quando usar         | Quando critérios são subjetivos e difíceis de quantificar | Quando há dados quantitativos disponíveis     |

---

### 7. **Material Complementar Pós-Aula**

**Leitura indicada:**

> Santos, M.; Batista, C.P.; Violante, A.R.; Reis, M.F.; Walker, R.A. (2018). _Análise multicritério utilizando os métodos Borda e AHP no provimento de viaturas blindadas para a PMERJ._

---

## 💡 Conceitos-Chave para Memorizar

1. **Pesquisa Operacional (PO):**
   - Abordagem científica para apoio à decisão em sistemas complexos
   - Áreas: MCDM, PL, PI, Simulação, Teoria dos Grafos, Teoria das Filas

2. **Tomada de Decisão Multicritério (MCDM):**
   - Caracterizada por: Matriz de Decisão + critérios ponderados + alternativas finitas
   - Métodos: AHP, TOPSIS, THOR, SAPEVO, ELECTRE, PROMETHEE

3. **Método AHP (Saaty, 1977):**
   - Comparação par a par usando Escala de 1 a 9
   - Consistência verificada com CR = CI/RI < 10%
   - Permite dados qualitativos e quantitativos

4. **Escala de Saaty:**
   - 1 = igual | 3 = importância moderada | 5 = mais importante | 7 = muito mais | 9 = extremamente mais
   - Valores pares (2, 4, 6, 8) são intermediários

5. **Teste de Consistência do AHP:**
   - $\lambda_{máx}$ → $CI = \frac{\lambda_{máx}-n}{n-1}$ → $CR = \frac{CI}{RI}$
   - CR < 0,10 → atribuições consistentes ✅

6. **Normalização da Matriz:**
   - **Custo** (menor = melhor): $x = \frac{1}{a_{ij}}$, normalizar
   - **Lucro** (maior = melhor): $\upsilon = \frac{a_{ij}}{\sum a_{ij}}$

7. **AHP-Gaussiano (Santos, 2021):**
   - Pesos derivados do **Coeficiente de Variação** (CV = DP/Média) de cada critério
   - Critério com maior dispersão relativa = maior importância discriminativa
   - 8 passos: Matriz → Normaliza → Transpõe → Média → DP → FG → FGN → Agrega

8. **Fator Gaussiano:**
   - Baseado no Coeficiente de Variação (CV)
   - Mede o quanto cada critério **dispersa as alternativas**
   - Normalizado → peso de cada critério (sem subjetividade)

---

## ⚠️ Erros Comuns a Evitar

1. **❌ CR ≥ 10% no AHP**
   - Problema: atribuições inconsistentes (viola transitividade)
   - ✅ Revisar as comparações par a par antes de prosseguir

2. **❌ Confundir Monotônico de Custo com Monotônico de Lucro**
   - Custo (menor = melhor): usar $x = 1/a_{ij}$ antes de normalizar
   - Lucro (maior = melhor): normalizar diretamente por $a_{ij}/\sum a_{ij}$

3. **❌ Não justificar os pesos dos critérios**
   - No AHP clássico, os pesos são subjetivos — é essencial documentar o raciocínio
   - ✅ AHP-Gaussiano resolve isso: pesos derivados objetivamente dos dados

4. **❌ Comparar alternativas em escalas diferentes sem normalizar**
   - Custo em R$ vs. câmera em MP vs. bateria em horas → escalas incomparáveis
   - ✅ Sempre normalizar a Matriz de Decisão antes de agregar

5. **❌ Ignorar a estrutura do problema (alternativas e critérios)**
   - Escolher critérios não-discriminatórios (todos iguais em uma coluna) → peso baixo no AHP-G
   - ✅ Bons critérios são aqueles que **diferenciam** as alternativas

---

## 📚 Referências Bibliográficas

- **Saaty, T. L.** (1977). A scaling method for priorities in hierarchical structures. _J Math Psychol_, 15:234–281.
- **Dos Santos, M.; Costa, I.; Gomes, C.F.S.** (2021). Multicriteria Decision-Making In The Selection Of Warships: A New Approach To The AHP Method. _International Journal of the Analytic Hierarchy Process_.
- **Felgas, C.G.; Moreira, M.A.L.; Fávero, L.P.; Santos, M.** (2025). Ranking of Brazilian States for Investment in Education: An Analysis from the Perspective of the AHP-Gaussian Method. _Procedia Computer Science_, 266, 94–101.
- **Santos, M.; Gomes, C.F.S.; Moreira, M.A.L.; Costa, I.P.A.** (2023). _Ferramentas Computacionais de Apoio à Tomada de Decisão_. 1ª Edição.
- **Emrouznejad, A. & Marra, M.** (2017). The state of the art development of AHP (1979–2017): a literature review with a social network analysis. _International Journal of Production Research_.

---

## 🔗 Ferramentas e Recursos

| Ferramenta                     | Link                                               |
| ------------------------------ | -------------------------------------------------- |
| 3DM (Three Decision Methods)   | www.3decisionmethods.com                           |
| AHP-Gaussiano online (Shiny/R) | https://decision-making.shinyapps.io/gaussian_ahp/ |
| Vídeo AHP-Gaussiano (YouTube)  | https://www.youtube.com/watch?v=nsW3O7nNuHM        |
| Canal da Pesquisa Operacional  | https://www.youtube.com/@CasadaPesquisaOperacional |
