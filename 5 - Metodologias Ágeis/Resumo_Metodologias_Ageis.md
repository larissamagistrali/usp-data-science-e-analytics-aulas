# 🚀 Resumo do Curso: Metodologias Ágeis

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Dominar os **princípios e práticas de Metodologias Ágeis** para gestão eficaz de projetos de Data Science, incluindo Scrum, Kanban, Lean, frameworks ágeis adaptados para analytics, cultura de colaboração, entrega iterativa, e como aplicar agilidade em contextos de análise de dados e machine learning.

---

## 📚 Conteúdo Principal

### 1. FUNDAMENTOS DE AGILIDADE

#### 1.1 Manifesto Ágil (2001)

**4 Valores Fundamentais**:

1. **Indivíduos e interações** > Processos e ferramentas
2. **Software funcionando** > Documentação abrangente
3. **Colaboração com o cliente** > Negociação de contratos
4. **Responder a mudanças** > Seguir um plano

#### 1.2 12 Princípios do Manifesto Ágil

1. Satisfação do cliente através de entregas contínuas e valiosas
2. Mudanças de requisitos são bem-vindas, mesmo tardias
3. Entregar software funcional frequentemente (semanas, não meses)
4. Negócio e desenvolvimento trabalham juntos diariamente
5. Construir projetos ao redor de indivíduos motivados
6. Conversa face a face é a forma mais eficiente de comunicação
7. Software funcionando é a principal medida de progresso
8. Processos ágeis promovem desenvolvimento sustentável
9. Atenção contínua à excelência técnica
10. Simplicidade é essencial
11. Melhores arquiteturas emergem de equipes auto-organizáveis
12. Reflexão regular sobre como se tornar mais eficaz

#### 1.3 Mindset Ágil vs. Tradicional (Cascata)

**Modelo Cascata (Waterfall)**:

```
Requisitos → Design → Implementação → Testes → Implantação → Manutenção
(Sequencial, sem volta, Big Bang delivery)
```

**Problema**: Requisitos mudam, risco alto, feedback tardio, desperdício

**Modelo Ágil**:

```
Sprint 1: Planejar → Desenvolver → Testar → Entregar → Feedback
    ↓
Sprint 2: Planejar → Desenvolver → Testar → Entregar → Feedback
    ↓
Sprint n: ... (Iterativo e incremental)
```

**Vantagens**: Feedback rápido, adaptação, risco reduzido, valor contínuo

#### 1.4 Conceitos-Chave

- **Sprint/Iteração**: Ciclo de desenvolvimento de tempo fixo (1-4 semanas)
- **Incremento**: Versão funcional do produto ao final de cada sprint
- **Product Backlog**: Lista priorizada de funcionalidades/histórias
- **Sprint Backlog**: Itens selecionados para o sprint atual
- **Daily Stand-up**: Reunião diária de 15 min (o que fiz, o que farei, impedimentos)
- **Retrospectiva**: Reflexão sobre o processo para melhoria contínua
- **Definição de Pronto (DoD)**: Critérios que uma história deve atender para ser considerada completa

---

### 2. SCRUM

#### 2.1 Visão Geral

- **Framework ágil mais popular** (~70% das equipes ágeis)
- **Criadores**: Ken Schwaber e Jeff Sutherland (1995)
- **Guia oficial**: Scrum Guide (atualizado regularmente)
- **Foco**: Gestão de produtos complexos

#### 2.2 Papéis (Scrum Roles)

**Product Owner (PO)**:

- **Responsabilidades**:
  - Maximizar valor do produto
  - Gerenciar Product Backlog (priorizar, refinar)
  - Definir visão do produto
  - Aceitar ou rejeitar entregas
- **Habilidades**: Visão de negócio, comunicação, tomada de decisão
- **Em Data Science**: Define problemas de negócio, prioriza modelos/features

**Scrum Master (SM)**:

- **Responsabilidades**:
  - Facilitar processos Scrum
  - Remover impedimentos
  - Proteger equipe de interferências
  - Coach de agilidade
- **Não é**: Gerente de projeto ou chefe
- **Estilo**: Liderança servidora (servant leadership)

**Time de Desenvolvimento (Dev Team)**:

- **Tamanho**: 3-9 pessoas (ideal: 5-7)
- **Características**:
  - Auto-organizado
  - Multifuncional (cross-functional)
  - Sem hierarquia interna
  - Responsabilidade coletiva
- **Em Data Science**: Cientistas de dados, engenheiros ML, analistas

#### 2.3 Eventos Scrum (Cerimônias)

**Sprint**:

- **Duração**: Time-boxed (1-4 semanas, geralmente 2)
- **Objetivo**: Entregar incremento potencialmente utilizável
- **Regras**: Sem mudanças que comprometam meta do sprint

**Sprint Planning**:

- **Quando**: Início do sprint
- **Duração**: Máximo 8h para sprint de 1 mês (proporcional)
- **Participantes**: Todo Scrum Team
- **Agenda**:
  - **Parte 1**: O que será feito? (Selecionar itens do Product Backlog)
  - **Parte 2**: Como será feito? (Planejar tarefas técnicas)
- **Output**: Sprint Goal + Sprint Backlog

**Daily Scrum (Stand-up)**:

- **Quando**: Todo dia, mesmo horário
- **Duração**: Máximo 15 minutos
- **Participantes**: Dev Team (obrigatório), PO e SM (opcional)
- **3 Perguntas**:
  1. O que fiz ontem?
  2. O que farei hoje?
  3. Há algum impedimento?
- **Objetivo**: Sincronização, não reporte

**Sprint Review**:

- **Quando**: Final do sprint
- **Duração**: Máximo 4h para sprint de 1 mês
- **Participantes**: Scrum Team + Stakeholders
- **Agenda**:
  - Demonstrar incremento (demo)
  - Coletar feedback
  - Revisar Product Backlog
  - Discutir próximos passos
- **Não é**: Aprovação formal, é colaboração

**Sprint Retrospective**:

- **Quando**: Após Sprint Review, antes do próximo Planning
- **Duração**: Máximo 3h para sprint de 1 mês
- **Participantes**: Scrum Team (sem stakeholders externos)
- **Objetivo**: Inspecionar como foi o último sprint
- **Framework**:
  - O que foi bem? (Continue doing)
  - O que pode melhorar? (Start doing)
  - O que parar de fazer? (Stop doing)
- **Output**: Plano de melhorias para próximo sprint

**Backlog Refinement** (Grooming):

- **Quando**: Durante o sprint (não no Planning)
- **Duração**: ~10% do sprint
- **Objetivo**: Detalhar histórias futuras, estimar, esclarecer

#### 2.4 Artefatos Scrum

**Product Backlog**:

- Lista ordenada de tudo que pode ser necessário no produto
- **Item**: User Story, Bug, Spike (pesquisa técnica)
- **Priorização**: Valor de negócio, risco, dependências
- **Características**: Dinâmico, nunca completo

**Sprint Backlog**:

- Itens do Product Backlog selecionados para o sprint
- Plano de como entregar o incremento
- Pertence ao Dev Team

**Incremento**:

- Soma de todos os itens completados no sprint
- Deve estar "Pronto" segundo DoD
- Potencialmente utilizável (não necessariamente em produção)

#### 2.5 User Stories

**Formato**:

```
Como [tipo de usuário],
Eu quero [ação/funcionalidade],
Para que [benefício/valor].
```

**Exemplo - Data Science**:

```
Como analista de marketing,
Eu quero um modelo de churn que identifique clientes em risco,
Para que possamos criar campanhas de retenção direcionadas.
```

**Critérios de Aceitação** (Acceptance Criteria):

```
- Dado [contexto]
- Quando [ação]
- Então [resultado esperado]
```

**Exemplo**:

```
- Dado um cliente com histórico de compras
- Quando o modelo faz a predição
- Então deve retornar probabilidade de churn entre 0 e 1
```

**INVEST**:

- **I**ndependent: Independente de outras histórias
- **N**egotiable: Aberta a discussão
- **V**aluable: Valor claro para o usuário
- **E**stimable: Equipe consegue estimar
- **S**mall: Pequena o suficiente para caber em um sprint
- **T**estable: Critérios de aceitação claros

---

### 3. KANBAN

#### 3.1 Visão Geral

- **Origem**: Toyota Production System (1950s)
- **Criador no software**: David Anderson (2007)
- **Filosofia**: Fluxo contínuo, visualização, limite de WIP
- **Diferença do Scrum**: Não há sprints, roles fixos, ou cerimônias obrigatórias

#### 3.2 Princípios do Kanban

1. **Visualize o fluxo de trabalho**: Kanban board
2. **Limite WIP** (Work in Progress): Evitar multitasking
3. **Gerencie o fluxo**: Otimizar throughput
4. **Torne políticas explícitas**: Critérios claros
5. **Implemente loops de feedback**: Reuniões regulares
6. **Melhore colaborativamente**: Kaizen (melhoria contínua)

#### 3.3 Kanban Board

**Estrutura Básica**:

```
| Backlog | To Do | In Progress | In Review | Done |
|---------|-------|-------------|-----------|------|
| Story A | Story | Story D     | Story E   | Story|
| Story B | Story |             |           | Story|
| Story C | Story | (WIP: 2)    | (WIP: 1)  |      |
```

**Colunas comuns em Data Science**:

```
| Backlog | Analysis | Modeling | Validation | Deployment | Done |
```

**WIP Limits**:

- Número máximo de itens em cada coluna
- Exemplo: "In Progress: máximo 3"
- **Benefício**: Foca conclusão antes de iniciar novos itens

#### 3.4 Métricas Kanban

**Lead Time**:

- Tempo total desde requisição até entrega
- Do ponto de vista do cliente

**Cycle Time**:

- Tempo desde início do trabalho até conclusão
- Do ponto de vista da equipe
- **Exemplo**: Do "In Progress" ao "Done"

**Throughput**:

- Número de itens entregues por período
- Exemplo: 15 histórias/mês

**Cumulative Flow Diagram (CFD)**:

- Gráfico que mostra fluxo de itens ao longo do tempo
- Detecta gargalos visualmente

---

### 4. OUTRAS METODOLOGIAS ÁGEIS

#### 4.1 Extreme Programming (XP)

**Práticas Técnicas**:

- **Pair Programming**: Dois desenvolvedores, um computador
- **Test-Driven Development (TDD)**: Escrever teste antes do código
- **Continuous Integration**: Integrar código frequentemente
- **Refactoring**: Melhorar código sem mudar comportamento
- **Simple Design**: YAGNI (You Aren't Gonna Need It)

**Valores**:

- Comunicação, Simplicidade, Feedback, Coragem, Respeito

#### 4.2 Lean Software Development

**Origem**: Lean Manufacturing (Toyota)

**7 Princípios**:

1. **Eliminar desperdício**: Qualquer coisa que não gera valor
2. **Amplificar aprendizado**: Experimentação rápida
3. **Decidir o mais tarde possível**: Com mais informação
4. **Entregar o mais rápido possível**: Reduzir time-to-market
5. **Empoderar o time**: Auto-organização
6. **Construir qualidade desde o início**: Não adicionar depois
7. **Ver o todo**: Otimização sistêmica, não local

**Tipos de Desperdício (Muda)**:

- Trabalho parcialmente feito
- Features extras (over-engineering)
- Re-aprendizado (falta de documentação)
- Hand-offs (transferências)
- Atrasos (espera por aprovações)
- Task switching (multitasking)
- Defeitos

#### 4.3 CRISP-DM (Data Science)

**Cross-Industry Standard Process for Data Mining**

**6 Fases** (cíclico):

1. **Business Understanding**: Objetivos, KPIs
2. **Data Understanding**: Explorar dados disponíveis
3. **Data Preparation**: Limpeza, transformação
4. **Modeling**: Construir modelos
5. **Evaluation**: Avaliar performance
6. **Deployment**: Colocar em produção

**Ágil + CRISP-DM**:

- Cada sprint cobre mini-ciclo CRISP-DM
- MVP: Modelo simples inicial, iterar
- Feedback de stakeholders em cada sprint

---

### 5. AGILIDADE EM DATA SCIENCE

#### 5.1 Desafios Únicos

**Incerteza**:

- Não se sabe se modelo funcionará até tentar
- Dados podem não ter padrões utilizáveis

**Experimentação**:

- Muito trabalho exploratório
- Múltiplas abordagens simultâneas

**Dependências Técnicas**:

- Dados, infraestrutura, APIs
- Nem sempre controladas pela equipe

**Entrega Contínua**:

- Modelos em produção requerem monitoramento
- Re-treino periódico

#### 5.2 Adaptações do Scrum para DS

**User Stories para Data Science**:

```
Como [stakeholder],
Eu quero [insight/modelo/análise],
Para que [decisão de negócio].
```

**Exemplo**:

```
Como gerente de vendas,
Eu quero identificar top 10 clientes com maior probabilidade de upgrade,
Para que a equipe priorize contatos com ROI alto.
```

**Definição de Pronto (DoD) em DS**:

- [ ] Dados coletados e validados
- [ ] EDA documentada
- [ ] Modelo treinado e versionado
- [ ] Métricas de performance atingem threshold
- [ ] Código com testes unitários
- [ ] Modelo deployado em staging
- [ ] Documentação técnica completa
- [ ] Apresentação de resultados para stakeholders

**Sprint em DS**:

- **Sprint 0**: Setup de infraestrutura, exploração inicial
- **Sprints subsequentes**: Iterações em modelo, features, performance

#### 5.3 Kanban para Data Science

**Board Adaptado**:

```
| Backlog | EDA | Feature Eng | Modeling | Validation | Deploy | Monitor |
```

**WIP Limits por fase**:

- EDA: 1-2 (foco profundo)
- Modeling: 2-3 (experimentação paralela)
- Validation: 1 (rigor)

#### 5.4 Práticas Recomendadas

**Spike Stories**:

- Histórias de pesquisa técnica
- Time-boxed (ex: 2 dias)
- **Output**: Relatório de viabilidade, não código produção

**Proof of Concept (POC)**:

- MVP de modelo
- Validar abordagem antes de investir

**Notebook-Driven Development**:

- Jupyter notebooks para exploração
- Refatorar para scripts/módulos quando estabilizado

**MLOps**:

- CI/CD para modelos (treino, testes, deploy)
- Monitoramento de drift
- Versionamento de dados e modelos (DVC, MLflow)

**Pair Programming em DS**:

- Revisão de notebooks
- Discussão de features
- Debug conjunto

---

### 6. ESTIMATIVAS EM PROJETOS ÁGEIS

#### 6.1 Story Points

**Conceito**:

- Medida relativa de esforço, complexidade e incerteza
- Não é tempo (horas/dias)
- Fibonacci: 1, 2, 3, 5, 8, 13, 21 (crescimento exponencial reflete incerteza)

**Estimativa por Comparação**:

- História A = 3 pontos (baseline)
- História B é 2x mais complexa → 5 ou 8 pontos

**Planning Poker**:

1. PO apresenta história
2. Dev Team discute brevemente
3. Cada membro escolhe carta (Fibonacci)
4. Todos revelam simultaneamente
5. Discutem discrepâncias (maior e menor explicam)
6. Novo round até consenso

#### 6.2 Velocidade (Velocity)

**Definição**: Média de story points completados por sprint

**Cálculo**:

```
Velocidade = Soma de story points de histórias "Done" / Número de sprints
```

**Exemplo**:

- Sprint 1: 21 pontos
- Sprint 2: 18 pontos
- Sprint 3: 24 pontos
- **Velocidade**: (21+18+24)/3 = 21 pontos/sprint

**Uso**:

- Prever quantos sprints para Product Backlog
- Planejar releases
- **Não use para**: Comparar equipes, avaliar indivíduos

#### 6.3 Estimativas em Data Science

**Cone de Incerteza**:

- Início do projeto: ±4x variação de estimativa
- Durante: Refinamento contínuo
- Final: ±1.25x

**T-Shirt Sizing**:

- XS, S, M, L, XL
- Útil para itens distantes (ainda não detalhados)

**Monte Carlo Simulation**:

- Usar histórico de velocidade
- Simular 1000 cenários
- Probabilidade de entregar em X sprints

---

### 7. GESTÃO DE PRODUTO ÁGIL

#### 7.1 Product Vision

**Template**:

```
Para [cliente/usuário]
Que [necessidade/problema]
O [nome do produto]
É um [categoria]
Que [principal benefício]
Diferente de [alternativas]
Nosso produto [diferencial-chave]
```

#### 7.2 Roadmap de Produto

**Roadmap Ágil**:

- **Horizonte curto (3-6 meses)**: Detalhado
- **Horizonte médio (6-12 meses)**: Temas/Epics
- **Horizonte longo (12+ meses)**: Visão estratégica

**Não é**: Compromisso de datas rígidas, é intenção

**Exemplo - Produto de Analytics**:

```
Q1: MVP Dashboard Vendas (Histórico)
Q2: Modelo Preditivo Churn
Q3: Recomendações Personalizadas
Q4: Mobile App
```

#### 7.3 Priorização

**MoSCoW**:

- **Must have**: Essencial, sem isso não lança
- **Should have**: Importante, mas não crítico
- **Could have**: Desejável, se der tempo
- **Won't have**: Fora de escopo (por agora)

**RICE Score**:

```
RICE = (Reach × Impact × Confidence) / Effort
```

- **Reach**: Quantas pessoas impactadas?
- **Impact**: Tamanho do impacto (Massive/High/Medium/Low/Minimal = 3/2/1/0.5/0.25)
- **Confidence**: Certeza da estimativa (High/Medium/Low = 100%/80%/50%)
- **Effort**: Person-months

**Exemplo**:

```
Feature A: (500 × 2 × 80%) / 2 = 400
Feature B: (100 × 3 × 100%) / 1 = 300
→ Prioridade: Feature A > Feature B
```

**Value vs. Effort Matrix**:

```
    Alto |  Quick Wins  |  Major Projects
Valor   |  (Priorizar) |  (Planejar)
        |--------------|------------------
    Baixo|  Fill-ins    |  Time Sinks
         |  (Depois)    |  (Evitar)
         +-------------------------------
           Baixo    Esforço    Alto
```

---

### 8. CULTURA ÁGIL

#### 8.1 Valores e Princípios

**Transparência**:

- Informações visíveis a todos
- Radiador de informação (big visible charts)
- Kanban boards físicos ou digitais

**Inspeção**:

- Revisar frequentemente artefatos e progresso
- Cerimônias de Scrum facilitam inspeção

**Adaptação**:

- Ajustar processo baseado na inspeção
- Retrospectivas geram mudanças

#### 8.2 Liderança Servidora (Servant Leadership)

**Papel do Scrum Master**:

- Servir a equipe (não mandar)
- Remover impedimentos
- Facilitar, não controlar

**Características**:

- Empatia
- Escuta ativa
- Empoderamento
- Construir comunidade

#### 8.3 Equipes Auto-Organizáveis

**Autonomia**:

- Time decide "como" fazer
- Não há microgerenciamento

**Responsabilidade Coletiva**:

- Sucesso e falha são da equipe
- Não apontar dedos

**Cross-Functionality**:

- Equipe tem todas as skills necessárias
- Não dependências externas críticas

#### 8.4 Fail Fast, Learn Fast

**Cultura de Experimentação**:

- Falhas são aprendizados
- Testar hipóteses rapidamente
- Pivot quando necessário

**Feedback Loops**:

- Retrospectivas (time)
- Sprint Reviews (stakeholders)
- Dados de produção (usuários)

---

### 9. FERRAMENTAS ÁGEIS

#### 9.1 Gestão de Projeto

**Jira**:

- Líder de mercado
- Scrum e Kanban boards
- Relatórios (burndown, velocity)
- Integrações extensas

**Trello**:

- Simples, visual
- Kanban puro
- Gratuito para pequenos times

**Azure DevOps** (antigo VSTS):

- Microsoft
- Integração com código (Git)
- CI/CD embutido

**Asana**:

- Gestão de tarefas genérica
- Múltiplas visualizações (lista, board, timeline)

**Monday.com**:

- Altamente customizável
- Visual atraente

#### 9.2 Comunicação

**Slack/Microsoft Teams**:

- Chat em tempo real
- Canais por tópico
- Integrações com ferramentas

**Zoom/Google Meet**:

- Videochamadas
- Daily stand-ups remotos

**Miro/Mural**:

- Whiteboard digital
- Retrospectivas remotas
- Brainstorming

#### 9.3 Documentação

**Confluence**:

- Wiki corporativa
- Integração com Jira

**Notion**:

- All-in-one workspace
- Docs, wikis, databases

**GitBook/Docusaurus**:

- Documentação técnica
- Versionamento

#### 9.4 Versionamento (Data Science)

**Git/GitHub/GitLab**:

- Código
- Notebooks (cuidado com diffs)

**DVC (Data Version Control)**:

- Versionamento de dados grandes
- Versionamento de modelos

**MLflow**:

- Tracking de experimentos
- Model registry

**Weights & Biases (W&B)**:

- Experimentos ML
- Visualizações

---

### 10. MÉTRICAS E MELHORIA CONTÍNUA

#### 10.1 Métricas de Equipe

**Velocity**:

- Story points por sprint
- Estabilidade indica maturidade

**Burndown Chart**:

- Trabalho restante vs. tempo
- Detecta se sprint está no caminho

**Burnup Chart**:

- Trabalho completado vs. scope
- Mostra mudanças de escopo

**Cumulative Flow Diagram**:

- Fluxo de itens por status
- Identifica gargalos

**Lead Time / Cycle Time**:

- Tempo para entregar valor
- Mais baixo = mais ágil

#### 10.2 Métricas de Qualidade

**Escaped Defects**:

- Bugs encontrados em produção
- Meta: diminuir

**Technical Debt**:

- Atalhos técnicos acumulados
- Medir com SonarQube, Code Climate

**Test Coverage**:

- % código coberto por testes
- Meta: >80% para código crítico

#### 10.3 Kaizen (Melhoria Contínua)

**Ciclo PDCA**:

1. **Plan**: Identificar melhoria
2. **Do**: Implementar em pequena escala
3. **Check**: Verificar resultados
4. **Act**: Padronizar ou ajustar

**Retrospectivas Eficazes**:

- Ambiente seguro (sem punições)
- Foco em processo, não pessoas
- Ações concretas e mensuráveis
- Acompanhar ações do sprint anterior

**Formatos de Retrospectiva**:

- **Start/Stop/Continue**
- **Glad/Sad/Mad**
- **4Ls**: Liked, Learned, Lacked, Longed for
- **Sailboat**: Vento (ajuda), Âncora (atrasa), Rochas (riscos), Sol (objetivos)

---

## 📊 Aplicações em Data Science

### 1. Projetos de Analytics

- Sprints focados em dashboards iterativos
- Feedback de usuários a cada 2 semanas
- Ajuste de métricas conforme uso

### 2. Desenvolvimento de Modelos ML

- Sprint 1: Baseline model (modelo simples)
- Sprint 2: Feature engineering
- Sprint 3: Modelos complexos
- Sprint 4: Tuning e deployment

### 3. Pesquisa e Inovação

- Spikes de 1-2 sprints para validar viabilidade
- Go/No-go decisions baseadas em POCs
- Portfolio de experimentos paralelos (Kanban)

### 4. Data Engineering

- Pipeline de dados em sprints
- CI/CD para ETLs
- Incrementos testáveis (dados fluem)

### 5. MLOps

- Automação de deploy (cada sprint)
- Monitoramento de modelos
- Re-treino agendado ou trigger-based

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Valores Ágeis

- **Pessoas > Processos**: Ferramentas servem pessoas, não o contrário
- **Funcionalidade > Documentação**: Software funcionando é a medida de progresso
- **Colaboração > Contrato**: Win-win, não adversarial
- **Mudança > Plano**: Adaptação é vantagem competitiva

### 📊 Scrum Essencial

- **3 Papéis**: Product Owner, Scrum Master, Dev Team
- **5 Eventos**: Sprint, Planning, Daily, Review, Retrospective
- **3 Artefatos**: Product Backlog, Sprint Backlog, Incremento
- **Sprint**: Time-boxed, 1-4 semanas, entrega valor

### 🎯 Kanban Essencial

- **Visualizar fluxo**: Board com colunas de estado
- **Limitar WIP**: Foco em conclusão, não início
- **Gerenciar fluxo**: Otimizar throughput
- **Melhoria contínua**: Kaizen

### 📏 Estimativas

- **Story Points**: Relativo, não absoluto (Fibonacci)
- **Velocidade**: Média de pontos por sprint
- **Não comparar equipes**: Contextos diferentes
- **Planning Poker**: Estimativa colaborativa

### 🚀 Data Science Ágil

- **MVP de modelo**: Baseline simples, iterar
- **Spike**: Time-boxed research
- **DoD customizado**: Inclui deployment, documentação, apresentação
- **MLOps**: CI/CD para modelos

---

## ⚠️ Erros Comuns a Evitar

### Mindset

1. **"Ágil = Sem planejamento"**: Errado! Há planejamento contínuo
2. **"Ágil = Sem documentação"**: Errado! Documentação suficiente, não excessiva
3. **"Ágil = Mais rápido"**: Não necessariamente; é mais adaptativo
4. **"Sprints = Mini-cascatas"**: Sprints são iterativos, não sequenciais dentro

### Scrum

5. **Daily > 15 min**: Vira reunião de reporte, não sincronização
6. **Pular Retrospectivas**: Perde oportunidade de melhoria
7. **SM como gerente de projeto**: SM facilita, não manda
8. **Mudanças no meio do sprint**: Instabilidade, quebra compromisso

### Kanban

9. **Sem limites de WIP**: Vira lista de tarefas, não Kanban
10. **Colunas demais**: Complexidade desnecessária
11. **Não medir fluxo**: Perde benefício de otimização

### Estimativas

12. **Story points = horas**: Confunde medidas
13. **Usar velocidade para avaliar indivíduos**: Métrica de time, não pessoal
14. **Estimativas precisas cedo**: Cone de incerteza é real

### Data Science

15. **Sprints muito longos**: Feedback tardio, dificulta adaptação
16. **Não versionar experimentos**: Perde rastreabilidade
17. **Deploy apenas no final**: Risco alto, feedback zero
18. **Ignorar technical debt**: Slows down progressivamente

---

## 🎯 Pontos Importantes para Reter

### Transformação Ágil

- **Não é apenas ferramentas**: É mudança de cultura
- **Começa pelo topo**: Liderança deve suportar
- **Gradual**: Não big bang, experimente e adapte
- **Contexto importa**: Ágil não é receita de bolo

### Ágil em Escala

- **SAFe** (Scaled Agile Framework): Framework corporativo
- **LeSS** (Large-Scale Scrum): Scrum escalado
- **Spotify Model**: Squads, Tribes, Chapters, Guilds
- **Nexus**: Framework oficial Scrum.org para escala

### Ágil vs. Tradicional - Quando Usar

**Use Ágil quando**:

- Requisitos mudam frequentemente
- Feedback rápido é crítico
- Projeto complexo e inovador
- Time co-localizado ou com boa comunicação
- Stakeholders disponíveis

**Use Tradicional (Cascata) quando**:

- Requisitos fixos e bem conhecidos
- Regulamentação rígida (ex: aeroespacial)
- Equipe distribuída sem comunicação eficaz
- Cliente quer preço fixo com escopo fechado

### Checklist de uma Equipe Ágil Saudável

✅ **Entrega valor a cada sprint**  
✅ **Retrospectivas geram mudanças reais**  
✅ **Dev Team se auto-organiza** (PO não distribui tarefas)  
✅ **Comunicação frequente** (Daily funciona, não é pesado)  
✅ **Stakeholders engajados** (participam de Reviews)  
✅ **Impedimentos removidos rapidamente**  
✅ **Velocidade estável** (após 3-4 sprints)  
✅ **Qualidade não sacrificada por velocidade**  
✅ **Débito técnico gerenciado**, não ignorado  
✅ **Aprendizado contínuo** (experimentos, falhas aceitas)

---

## 📚 Materiais de Apoio

### Livros Fundamentais

1. **"Scrum: A Arte de Fazer o Dobro do Trabalho na Metade do Tempo"** - Jeff Sutherland
2. **"The Lean Startup"** - Eric Ries
3. **"User Story Mapping"** - Jeff Patton
4. **"Kanban: Successful Evolutionary Change for Your Technology Business"** - David Anderson
5. **"Agile Estimating and Planning"** - Mike Cohn
6. **"The Phoenix Project"** - Gene Kim (DevOps novel)
7. **"Scrum Guide"** - Ken Schwaber & Jeff Sutherland (oficial, gratuito)

### Certificações

- **Certified ScrumMaster (CSM)** - Scrum Alliance
- **Professional Scrum Master (PSM)** - Scrum.org
- **Kanban Management Professional (KMP)** - Lean Kanban University
- **SAFe Agilist (SA)** - Scaled Agile
- **PMI-ACP** (Agile Certified Practitioner) - PMI

### Recursos Online

- **Scrum.org**: Guias oficiais, artigos, fóruns
- **Mountain Goat Software**: Mike Cohn's blog
- **AgileAlliance.org**: Recursos, glossário, eventos
- **InfoQ**: Notícias e artigos sobre agilidade

### Comunidades

- **Agile Brazil**: Conferência anual
- **Meetups locais**: Scrum User Groups
- **Slack/Discord**: Comunidades ágeis
- **LinkedIn**: Grupos de discussão

---

## 📖 Referências Recomendadas

### Manifesto e Guias Oficiais

- **Manifesto Ágil**: https://agilemanifesto.org/
- **12 Princípios**: https://agilemanifesto.org/principles.html
- **Scrum Guide**: https://scrumguides.org/
- **Kanban Guide**: https://kanbanguides.org/

### Frameworks e Metodologias

- **SAFe**: https://www.scaledagileframework.com/
- **LeSS**: https://less.works/
- **Nexus**: https://www.scrum.org/resources/nexus-guide
- **XP**: http://www.extremeprogramming.org/

### Ferramentas

- **Jira**: https://www.atlassian.com/software/jira
- **Trello**: https://trello.com/
- **Azure DevOps**: https://azure.microsoft.com/services/devops/
- **MLflow**: https://mlflow.org/

---

## ✅ Checklist de Estudo

### Fundamentos

- [ ] Entender 4 valores e 12 princípios do Manifesto Ágil
- [ ] Diferenciar Ágil de Cascata
- [ ] Conhecer benefícios e limitações de agilidade

### Scrum

- [ ] Memorizar 3 papéis e suas responsabilidades
- [ ] Conhecer 5 eventos e suas durações/objetivos
- [ ] Entender 3 artefatos
- [ ] Escrever User Stories no formato correto
- [ ] Praticar Planning Poker

### Kanban

- [ ] Criar Kanban board
- [ ] Definir WIP limits apropriados
- [ ] Calcular Lead Time e Cycle Time
- [ ] Interpretar Cumulative Flow Diagram

### Estimativas

- [ ] Usar Fibonacci para story points
- [ ] Calcular velocidade de equipe
- [ ] Entender cone de incerteza
- [ ] Não confundir story points com horas

### Data Science Ágil

- [ ] Adaptar Scrum para projetos de DS
- [ ] Criar DoD específico para ML
- [ ] Planejar MVP de modelo
- [ ] Implementar MLOps básico

### Ferramentas

- [ ] Configurar board em Jira ou Trello
- [ ] Criar repositório Git com branches
- [ ] Usar DVC ou MLflow para experimentos

### Cultura

- [ ] Facilitar retrospectiva com time
- [ ] Praticar liderança servidora
- [ ] Promover auto-organização
- [ ] Aceitar falhas como aprendizado

### Projeto Prático

- [ ] Definir Product Vision
- [ ] Criar Product Backlog com 10+ histórias
- [ ] Priorizar com MoSCoW ou RICE
- [ ] Executar 3 sprints completos
- [ ] Medir velocidade
- [ ] Conduzir retrospectivas
- [ ] Documentar lições aprendidas

---

**📌 Nota Final:** Metodologias Ágeis não são apenas sobre processos e ferramentas, mas sobre **mindset** e **cultura**. Em Data Science, onde incerteza e experimentação são inerentes, a abordagem ágil de entrega iterativa, feedback contínuo e adaptação rápida é ainda mais valiosa. O sucesso não vem de seguir Scrum ou Kanban ao pé da letra, mas de absorver os princípios ágeis e adaptá-los ao contexto único de cada equipe e projeto.

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_  
_Módulo 5 - Metodologias Ágeis_
