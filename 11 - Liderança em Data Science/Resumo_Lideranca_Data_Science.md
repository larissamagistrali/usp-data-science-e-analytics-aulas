# 👥 Resumo: Liderança em Data Science

**MBA Data Science e Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Desenvolver competências de **liderança e gestão** específicas para times de Data Science e Analytics. Compreender os desafios únicos de liderar equipes técnicas multidisciplinares, comunicar resultados de dados para stakeholders não-técnicos, construir cultura data-driven, gerenciar projetos de analytics com incerteza inerente e desenvolver soft skills essenciais para cientistas de dados em posições de liderança.

---

## 📚 Conteúdo Principal

### 1. **Perfil do Líder em Data Science**

#### 1.1 Habilidades Técnicas vs. Soft Skills

**Habilidades Técnicas (Technical Skills):**

- Fundamentos de ML, estatística, programação
- **Não precisa ser o melhor técnico do time**
- Conhecimento suficiente para:
  - Avaliar qualidade técnica de propostas
  - Entender trade-offs (accuracy vs. interpretability)
  - Fazer code review em alto nível
  - Questionar suposições de modelos

**Soft Skills (Essenciais para Liderança):**

- **Comunicação:** traduzir técnico para negócio
- **Visão estratégica:** alinhar analytics com objetivos de negócio
- **Gestão de pessoas:** motivar, desenvolver, dar feedback
- **Influência:** convencer stakeholders sem autoridade formal
- **Inteligência emocional:** empatia, autoconhecimento, gestão de conflitos
- **Tomada de decisão:** sob incerteza, com dados incompletos

#### 1.2 Tipos de Papéis de Liderança

- **Tech Lead:** liderança técnica (arquitetura, standards de código, mentoria técnica)
- **People Manager:** gestão de pessoas (carreira, performance, bem-estar)
- **Product Manager (Analytics):** define roadmap, prioriza projetos, interface com negócio
- **Chief Data Officer (CDO):** executivo responsável por estratégia de dados na empresa
- **Líder de CoE (Center of Excellence):** centraliza expertise, dissemina práticas

#### 1.3 Evolução de Carreira

```
Data Analyst → Data Scientist →
  ├─> Senior Data Scientist → Staff/Principal Data Scientist (IC - Individual Contributor)
  └─> Lead Data Scientist → Manager → Director → VP/CDO (Management)
```

**IC Track (Individual Contributor):**

- Foco em profundidade técnica
- Liderança por expertise (não gestão de pessoas)

**Management Track:**

- Foco em estratégia e pessoas
- Menos hands-on em código

---

### 2. **Construção e Gestão de Times de DS**

#### 2.1 Estrutura de Times

**Perfis em Time de DS:**

- **Data Engineers:** pipelines de dados, infraestrutura (Spark, Airflow, cloud)
- **Data Scientists:** modelagem, experimentação, análise
- **ML Engineers:** deploy de modelos, MLOps, produtização
- **Data Analysts:** BI, dashboards, análises exploratórias
- **Analytics Translator:** ponte entre negócio e técnico (Product Owner de analytics)

**Ratio sugerido:** 1 Data Engineer : 2-3 Data Scientists : 0.5 ML Engineer

**Modelos de Organização:**

1. **Centralizado:** time único de DS atende toda empresa
   - **Pros:** expertise concentrada, padronização
   - **Cons:** fila longa, distância do negócio
2. **Descentralizado (Embedded):** cada área de negócio tem seus data scientists
   - **Pros:** proximidade, agilidade
   - **Cons:** duplicação, falta de padrões
3. **Híbrido (Centro de Excelência + Squads):**
   - CoE: standards, ferramentas, infraestrutura, capacitação
   - Squads: DS embarcados em áreas de negócio, seguem padrões do CoE

#### 2.2 Contratação de Talentos

**O que avaliar:**

- **Technical Assessment:** coding (Python/R/SQL), modelagem (case), estatística
- **Portfolio:** projetos anteriores (GitHub, Kaggle)
- **Problem-solving:** raciocínio lógico, estruturação de problemas
- **Communication:** consegue explicar conceitos complexos?
- **Cultural fit:** alinhamento com valores da empresa

**Desafios:**

- **Escassez de talentos:** demanda > oferta (especialmente especialistas)
- **Salários competitivos:** Big Tech paga muito (Google, Meta, Amazon)
- **Expectativas irreais:** "queremos cientista de dados full-stack unicórnio"

**Estratégias:**

- **Contratar potencial:** juniors com vontade de aprender (mais barato, lealdade)
- **Treinamento interno:** upskilling de analysts para DS
- **Remote work:** ampliar pool de candidatos
- **Employer branding:** projetos interessantes atraem talento

#### 2.3 Onboarding

**Primeiros 30-60-90 dias:**

- **30 dias:** setup de ambiente, entender negócio, projetos iniciais simples
- **60 dias:** contribuir em projetos existentes, conhecer stakeholders
- **90 dias:** liderar projeto pequeno, estar produtivo

**Práticas:**

- **Buddy system:** veterano mentora novo
- **Documentação:** confluence, wiki interna
- **Shadow sessions:** acompanhar reuniões com negócio
- **Learning path:** cursos, papers, código legado para estudar

#### 2.4 Desenvolvimento e Retenção

**Plano de Desenvolvimento Individual (PDI):**

- **Metas de curto prazo (3-6 meses):** skill técnico (ex: aprender deep learning)
- **Metas de longo prazo (1-2 anos):** carreira (ex: tornar-se senior)
- **Recursos:** cursos, conferências, mentoria
- **Revisão trimestral:** acompanhar progresso

**Retenção:**

- **Desafios técnicos:** projetos interessantes (não só análise ad-hoc)
- **Autonomia:** confiança para tomar decisões
- **Crescimento:** clareza de carreira
- **Reconhecimento:** feedback positivo, promoções justas
- **Propósito:** impacto visível do trabalho

**Principais causas de turnover:**

- Falta de crescimento (estagnação)
- Trabalho repetitivo, sem desafio
- Gestão ruim (micromanagement, falta de feedback)
- Compensação desalinhada com mercado
- Falta de ferramentas/infraestrutura adequadas

---

### 3. **Comunicação de Resultados de Dados**

#### 3.1 Storytelling com Dados

- **Estrutura narrativa:**
  1. **Contexto:** qual problema de negócio?
  2. **Insight:** o que os dados revelam?
  3. **Ação:** o que fazer com essa informação?
- **Exemplo:**
  - ❌ "O modelo XGBoost teve AUC de 0.87"
  - ✅ "Identificamos que 15% dos clientes têm 80% de chance de cancelar nos próximos 3 meses. Se agirmos agora com campanha de retenção, podemos salvar R$5M em receita."

#### 3.2 Adaptação de Audiência

**Para Executivos (C-level):**

- **Foco:** impacto no negócio (receita, custo, risco)
- **Formato:** executive summary (1 slide), métricas de alto nível
- **Linguagem:** sem jargões técnicos
- **Tempo:** 5-10 minutos

**Para Gestores de Área:**

- **Foco:** insights acionáveis para suas áreas
- **Formato:** apresentação com visualizações, recomendações claras
- **Linguagem:** mínimo de técnico
- **Tempo:** 15-30 minutos

**Para Time Técnico:**

- **Foco:** metodologia, arquitetura, reprodutibilidade
- **Formato:** documentação técnica, notebooks, repositório
- **Linguagem:** técnica (métricas, algoritmos)
- **Tempo:** workshop, code review

#### 3.3 Visualização de Dados

**Princípios:**

- **Simplicidade:** menos é mais (evitar chartjunk)
- **Destaque:** guiar olho para insight principal (cores, anotações)
- **Contexto:** sempre incluir baseline, benchmark
- **Honestidade:** não distorcer escala para manipular percepção

**Tipos de Gráficos:**

- **Comparação:** barras horizontais
- **Evolução temporal:** linhas
- **Distribuição:** histogramas, box plots
- **Correlação:** scatter plots
- **Composição:** pie charts (evitar se >5 categorias), stacked bars

**Ferramentas:**

- **Exploração:** Matplotlib, Seaborn, Plotly (Python)
- **Apresentação:** Power BI, Tableau, Looker
- **Interativas:** Streamlit, Dash, Shiny

#### 3.4 Documentação e Reprodutibilidade

- **README.md:** objetivo do projeto, como rodar, dependências
- **Notebooks:** código limpo e comentado, células organizadas
- **Model Card:** documenta modelo (treino, métricas, limitações, viés)
- **Versionamento:** Git para código, DVC para dados/modelos
- **Environment:** requirements.txt, Docker (garantir reprodutibilidade)

---

### 4. **Cultura Data-Driven**

#### 4.1 O que é Cultura Data-Driven

- **Decisões baseadas em dados:** não em intuição ou HiPPO (Highest Paid Person's Opinion)
- **Experimentação:** testar hipóteses com A/B tests
- **Transparência:** dados acessíveis, democratização
- **Curiosidade:** questionar suposições, explorar

#### 4.2 Construindo Cultura Data-Driven

**Estratégias:**

1. **Exemplo vindo de cima:** líderes seniores usam dados em decisões
2. **Acesso a dados:** self-service BI (dashboards, SQL access)
3. **Letramento de dados (Data Literacy):** treinar organização
   - O que é uma média? Mediana? Correlação?
   - Como interpretar p-value?
4. **Celebrar casos de sucesso:** storytelling de projetos que geraram valor
5. **Infraestrutura:** data warehouse, ferramentas de BI, pipelines confiáveis
6. **Governança:** dados corretos, qualidade, documentação

**Barreiras:**

- **Resistência cultural:** "sempre fizemos assim"
- **Falta de confiança nos dados:** dados ruins ou contraditórios
- **Siloing:** dados fragmentados em sistemas isolados
- **Medo:** decisão errada baseada em dados = culpa

#### 4.3 Métricas de Sucesso (OKRs para DS)

**OKR = Objectives and Key Results**

**Exemplo:**

- **Objective:** Reduzir churn de clientes
- **Key Results:**
  1. Aumentar retenção de 80% para 85% em Q3
  2. Identificar 70% dos churners com 60 dias de antecedência
  3. Implementar modelo de propensão ao churn em produção

**Boas práticas:**

- **Métricas de negócio > métricas técnicas** (receita > AUC)
- **Métricas leading** (antecedentes) **vs. lagging** (resultado final)
- **Dashboards de acompanhamento:** monitorar KPIs em tempo real

---

### 5. **Gestão de Projetos de Data Science**

#### 5.1 Desafios Únicos

- **Incerteza:** não sabemos se modelo vai funcionar até experimentar
- **Exploração vs. Entrega:** balancear pesquisa e produtização
- **Dependências de dados:** qualidade ruim, falta de dados
- **Iterativo:** raramente acertamos na primeira tentativa
- **Expectations management:** stakeholders esperam "resolver tudo com AI"

#### 5.2 Metodologia CRISP-DM

**Cross-Industry Standard Process for Data Mining:**

1. **Business Understanding:**
   - Qual problema de negócio?
   - Critérios de sucesso (KPIs)
   - Restrições (tempo, budget, dados disponíveis)
2. **Data Understanding:**
   - Explorar dados disponíveis
   - Verificar qualidade (missing, outliers)
   - Estatísticas descritivas, visualizações
3. **Data Preparation:**
   - Limpeza (tratar missing, duplicatas)
   - Feature engineering
   - Transformações (scaling, encoding)
4. **Modeling:**
   - Selecionar algoritmos
   - Treinar modelos
   - Hyperparameter tuning
5. **Evaluation:**
   - Avaliar métricas (accuracy, precision, recall, AUC)
   - Validar com stakeholders
   - Revisitar business understanding (atendeu?)
6. **Deployment:**
   - Colocar modelo em produção
   - Monitorar performance
   - Manutenção e retreinamento

**Ciclo iterativo:** voltar para etapas anteriores conforme aprende

#### 5.3 Gestão de Expectativas

**Problema:** stakeholders esperam modelo perfeito rapidamente

**Estratégias:**

- **Prova de conceito (PoC):** versão simplificada primeiro (2-4 semanas)
- **MVP (Minimum Viable Product):** modelo básico em produção rápido, iterar depois
- **Comunicação de riscos:** "pode não funcionar", "precisamos de X dados"
- **Trade-offs:** explicar accuracy vs. interpretability vs. latency
- **Transparência:** compartilhar progresso, bloqueios, learnings

**Exemplo de cronograma:**

- **Semana 1-2:** EDA, entender problema
- **Semana 3-4:** baseline model, avaliar viabilidade
- **Semana 5-8:** iterar para melhorar model
- **Semana 9-10:** preparar deployment, documentação
- **Semana 11-12:** deploy, monitorar

#### 5.4 Priorização de Projetos

**Framework: Impacto vs. Esforço**

|                   | Baixo Esforço                    | Alto Esforço                  |
| ----------------- | -------------------------------- | ----------------------------- |
| **Alto Impacto**  | **Quick Wins** (fazer primeiro!) | **Major Projects** (planejar) |
| **Baixo Impacto** | **Fill-ins** (se sobrar tempo)   | **Avoid** (não fazer)         |

**Critérios de Impacto:**

- Receita gerada (ou custo economizado)
- Alinhamento estratégico
- Número de usuários impactados

**Critérios de Esforço:**

- Tempo de desenvolvimento
- Disponibilidade de dados
- Complexidade técnica
- Dependências externas

**Método ICE Score:**

- **I (Impact):** 1-10
- **C (Confidence):** 0-1 (quão confiante que dará certo)
- **E (Ease):** 1-10
- **Score = I × C / E**

---

### 6. **Gestão de Conflitos e Feedback**

#### 6.1 Tipos de Conflitos

- **Técnico:** qual algoritmo usar, arquitetura de sistema
- **Alocação de recursos:** priorização de projetos, orçamento
- **Interpessoal:** personalidades, estilos de trabalho
- **Organizacional:** DS quer experimentar, negócio quer resultados rápidos

#### 6.2 Resolução de Conflitos

**Abordagens:**

1. **Colaboração:** buscar solução win-win (ideal)
2. **Compromisso:** ambos cedem um pouco
3. **Competição:** impor solução (usar raramente, apenas se urgente)
4. **Acomodação:** ceder (se não for crítico)
5. **Evitação:** postponer (se for se resolver sozinho)

**Processo:**

- **Ouvir ativamente:** entender perspectiva do outro
- **Empatia:** validar sentimentos
- **Foco no problema, não na pessoa:** "processo errado" vs. "você errou"
- **Buscar interesses comuns:** ambos querem projeto de sucesso
- **Propor soluções criativas:** brainstorming colaborativo

#### 6.3 Cultura de Feedback

**Feedback Eficaz:**

- **SBI Model (Situation-Behavior-Impact):**
  ```
  "Na reunião de ontem (situation), quando você cortou a fala do João (behavior),
  ele ficou desmotivado e não contribuiu mais (impact)."
  ```
- **Feedback positivo:** tão importante quanto crítico
  - **Específico:** não "bom trabalho", mas "sua análise de churn identificou X, que salvou Y receita"
- **Feedback construtivo:**
  - **Privado:** nunca criticar em público
  - **Oportuno:** logo após comportamento (não esperar 6 meses)
  - **Acionável:** "fazer X da próxima vez" vs. "seja melhor"

**1-1s (One-on-ones):**

- **Frequência:** semanal ou quinzenal (30-60 min)
- **Pauta:** carreira, desafios, feedback mútuo (não status de projeto)
- **Responsabilidade:** do liderado (não do líder)
- **Confidencialidade:** espaço seguro

#### 6.4 Gestão de Performance

**Avaliação de Performance:**

- **Frequência:** anual ou semestral
- **Critérios:**
  - **Entrega técnica:** qualidade de código, modelos, análises
  - **Colaboração:** trabalho em equipe, conhecimento compartilhado
  - **Impacto no negócio:** projetos geraram valor?
  - **Crescimento:** aprendizado, novas skills

**Rating:**

- **Exceeds expectations:** promovido, bônus alto
- **Meets expectations:** maioria (60-70%)
- **Needs improvement:** plano de ação, acompanhamento próximo
- **Does not meet:** PIP (Performance Improvement Plan) ou desligamento

**Armadilha:** "Brilliant Jerk" (tecnicamente excelente mas tóxico)

- **Decisão:** não tolerar (destrói cultura do time)

---

### 7. **Liderança Remota e Híbrida**

#### 7.1 Desafios

- **Comunicação assíncrona:** menos interações casuais (watercooler moments)
- **Onboarding:** mais difícil integrar novos remotamente
- **Alinhamento:** garantir que todos entendem prioridades
- **Engajamento:** evitar sensação de isolamento
- **Produtividade:** balancear autonomia e accountability

#### 7.2 Práticas para Times Remotos

**Comunicação:**

- **Documentação escrita:** decisões, arquitetura, processos
- **Ferramentas assíncronas:** Slack, Notion, Confluence
- **Daily standups assíncronos:** cada um posta update (não reunião)
- **All-hands semanais/mensais:** sincronizar time inteiro

**Rituais:**

- **Coffee chats virtuais:** 15 min para conversar de vida (não trabalho)
- **Pair programming remoto:** screen share, colaboração
- **Show & tell:** apresentar projetos para time

**Ferramentas:**

- **Comunicação:** Slack, Microsoft Teams
- **Vídeo:** Zoom, Google Meet
- **Colaboração:** Miro, Mural (whiteboards virtuais)
- **Código:** GitHub, GitLab (code review, issues)
- **Gestão:** Jira, Trello, Asana

**Expectativas:**

- **Core hours:** horário mínimo de overlap (ex: 10am-2pm)
- **Response time:** não espera resposta imediata (assíncrono)
- **Disponibilidade:** marcar em calendário quando indisponível

#### 7.3 Modelo Híbrido

- **Dias no escritório:** para colaboração intensa, workshops, 1-1s
- **Dias remotos:** para deep work (modelagem, código)
- **Evitar:** parte do time presencial, parte remota na mesma reunião (ruim para remotos)
- **All-remote ou all-in-person:** quando possível

---

### 8. **Ética e Responsabilidade em Data Science**

#### 8.1 Viés e Fairness

**Viés em Modelos:**

- **Viés histórico:** dados refletem discriminação passada (ex: menos mulheres em cargos seniores → modelo prevê homens para promoção)
- **Viés de amostragem:** dados não representam população real
- **Viés de confirmação:** buscar dados que confirmam hipótese prévia

**Fairness:**

- **Demographic parity:** taxa de aprovação igual entre grupos (gênero, raça)
- **Equalized odds:** taxa de erro igual entre grupos
- **Trade-off:** fairness vs. accuracy (nem sempre compatíveis)

**Práticas:**

- **Audit de modelos:** testar em subgrupos (gênero, idade, raça)
- **Diverse teams:** perspectivas variadas identificam vieses
- **Transparência:** explicar como modelo decide

#### 8.2 Privacidade e LGPD

- **Minimização de dados:** coletar só o necessário
- **Anonimização:** remover identificadores (PII - Personally Identifiable Information)
- **Consentimento:** usuário precisa autorizar uso de dados
- **Direito ao esquecimento:** poder deletar dados sob solicitação

#### 8.3 Explicabilidade

- **Black-box models (deep learning):** difícil explicar
- **Necessidade de explicação:** saúde (diagnósticos), finanças (crédito), jurídico
- **Técnicas:**
  - **SHAP, LIME:** explicabilidade post-hoc
  - **Feature importance:** quais variáveis mais influenciam
  - **Modelos interpretáveis:** árvores de decisão, regressões lineares

#### 8.4 Responsabilidade do Líder

- **Questions to ask:**
  - Este modelo pode causar dano?
  - Alguém será injustiçado?
  - Estamos transparentes sobre limitações?
  - Quem é responsável se algo der errado?
- **Estabelecer guidelines:** política de ética de dados na empresa
- **Comitê de ética:** revisar projetos sensíveis

---

### 9. **Influência sem Autoridade Formal**

#### 9.1 Desafio

- **Data Scientists muitas vezes não têm:**
  - Autoridade hierárquica sobre stakeholders
  - Orçamento próprio
  - Poder de decisão final
- **Mas precisam influenciar:**
  - Adoção de recomendações
  - Priorização de projetos
  - Mudanças em processos

#### 9.2 Estratégias de Influência

1. **Construir relacionamento:**
   - **Networking interno:** conhecer stakeholders, entender dores
   - **Trust:** cumprir prazos, entregar qualidade
2. **Falar a língua do negócio:**
   - Traduzir insights técnicos para impacto (receita, custo, risco)
   - Exemplo: "modelo reduzirá churn em 5%, salvando R$2M/ano"
3. **Data storytelling:**
   - Narrativa convincente com dados
   - Visualizações impactantes
4. **Quick wins:**
   - Entregar valor rápido (análise simples que gera insight)
   - Constrói credibilidade para projetos maiores
5. **Alinhamento estratégico:**
   - Conectar projetos de DS com OKRs da empresa
   - "Este projeto ajuda a atingir meta de crescimento de 20%"
6. **Coalizões:**
   - Encontrar aliados (outros líderes que se beneficiam)
   - Apoio de múltiplas áreas aumenta influência

#### 9.3 Lidar com Resistência

**Tipos de resistência:**

- **Racional:** "não temos orçamento", "não temos dados"
- **Emocional:** medo de mudança, perda de controle
- **Política:** ameaça a poder estabelecido

**Táticas:**

- **Ouvir objeções:** entender raiz da resistência
- **Empatia:** validar preocupações
- **Pilotos:** testar em pequena escala ("se funcionar, expandimos")
- **Co-criação:** envolver stakeholder na solução (ownership)

---

### 10. **Desenvolvimento de Liderança**

#### 10.1 Autoconhecimento

- **Estilos de liderança:**
  - **Autocrático:** decide sozinho (rápido, mas low morale)
  - **Democrático:** decide com time (engajamento alto, mais lento)
  - **Delegativo (Laissez-faire):** time decide (autonomia, pode gerar desalinhamento)
- **Qual seu estilo natural?** Adaptar conforme contexto (situational leadership)

**Ferramentas:**

- **Myers-Briggs (MBTI):** identificar tipo de personalidade
- **StrengthsFinder:** focar em strengths vs. corrigir weaknesses
- **360° feedback:** feedback de pares, subordinados, superiores

#### 10.2 Inteligência Emocional (EQ)

**5 Componentes (Daniel Goleman):**

1. **Autoconhecimento:** reconhecer próprias emoções
2. **Autorregulação:** controlar impulsos
3. **Motivação intrínseca:** drive interno (não só $$$)
4. **Empatia:** entender emoções dos outros
5. **Habilidades sociais:** influência, networking, gestão de conflitos

**Por que importa:**

- **EQ > IQ para liderança:** Harvard Business Review
- **Preditor de sucesso:** líderes com alto EQ têm times mais performáticos

#### 10.3 Continuous Learning

- **Leitura:** livros de liderança, management, psicologia
- **Cursos:** MBAs, executivos, workshops
- **Mentoria:** buscar mentor sênior
- **Reverse mentoring:** aprender com júniores (novas tecnologias)
- **Conferências:** networking, tendências
- **Experimentação:** testar novas práticas com time

#### 10.4 Work-Life Balance e Burnout

**Sinais de burnout:**

- Exaustão crônica
- Cinismo, distanciamento emocional
- Queda de produtividade

**Prevenção:**

- **Boundaries:** separar trabalho e vida pessoal (não responder email à noite)
- **Férias:** tirar férias completas (desconectar)
- **Delegação:** não fazer tudo sozinho
- **Exercício, sono, alimentação:** fundação de saúde mental
- **Terapia/coaching:** suporte profissional

**Responsabilidade do líder:**

- Modelar comportamento saudável (não glorificar overwork)
- Respeitar boundaries do time
- Encorajar férias

---

## 💡 Conceitos-Chave para Memorizar

1. **Líder de DS = Soft Skills > Technical Skills**
   - Não precisa ser o melhor técnico, mas precisa comunicar, influenciar, desenvolver pessoas

2. **Estrutura de Times:**
   - **Híbrida (CoE + Squads):** melhor dos dois mundos (padrões + proximidade de negócio)
   - **Ratio:** 1 Engineer : 2-3 Scientists : 0.5 ML Engineer

3. **Comunicação:**
   - **Storytelling:** Contexto → Insight → Ação
   - **Adaptar audiência:** C-level (impacto), gestores (acionável), técnico (metodologia)

4. **Cultura Data-Driven:**
   - **Decisões baseadas em dados** (não HiPPO)
   - **Construir:** exemplo de cima, acesso a dados, letramento, celebrar sucessos

5. **CRISP-DM:** Business Understanding → Data Understanding → Data Preparation → Modeling → Evaluation → Deployment (ciclo iterativo)

6. **Gestão de Expectativas:**
   - **PoC → MVP → Iteração** (não prometer milagres)
   - **Comunicar riscos e trade-offs**

7. **Priorização:**
   - **Impacto vs. Esforço:** focar em Quick Wins primeiro
   - **ICE Score:** Impact × Confidence / Ease

8. **Feedback:**
   - **SBI Model:** Situation-Behavior-Impact
   - **1-1s:** semanal/quinzenal, pauta do liderado, confidencial

9. **Ética:**
   - **Viés em modelos:** auditar subgrupos, diverse teams
   - **Fairness vs. Accuracy:** trade-off inevitável
   - **Explicabilidade:** SHAP, LIME para black-box models

10. **Influência sem Autoridade:**
    - **Construir relacionamento + Falar linguagem de negócio + Quick wins + Alinhamento estratégico**

---

## ⚠️ Erros Comuns a Evitar

1. **❌ Micromanagement (controlar cada detalhe do trabalho do time)**
   - Resultado: desmotivação, falta de autonomia, turnover
   - ✅ Delegar com clareza de objetivos, confiar no time

2. **❌ Não adaptar comunicação para audiência**
   - Problema: falar de AUC e overfitting para CEO
   - ✅ Traduzir para impacto no negócio (receita, custo, risco)

3. **❌ Priorizar apenas projetos tecnicamente interessantes**
   - Problema: impacto zero no negócio
   - ✅ Balancear: impacto no negócio > curiosidade técnica

4. **❌ Não gerenciar expectativas (prometer mais do que pode entregar)**
   - Resultado: descrédito, frustração de stakeholders
   - ✅ Comunicar riscos, incertezas, trade-offs desde o início

5. **❌ Evitar conflitos (deixar problemas interpessoais sem resolver)**
   - Resultado: conflito escala, ambiente tóxico
   - ✅ Endereçar cedo, com empatia, foco no problema

6. **❌ Não dar feedback (assumir que pessoa sabe que está errando)**
   - Resultado: comportamento ruim persiste
   - ✅ Feedback oportuno, específico, acionável

7. **❌ Contratar "unicórnios" (perfil impossível: expert em tudo)**
   - Resultado: não achar ninguém ou pagar demais
   - ✅ Contratar potencial, desenvolver internamente, time complementar

8. **❌ Não documentar decisões e processos**
   - Problema: conhecimento na cabeça de uma pessoa (bus factor)
   - ✅ Documentação em wiki, README, design docs

9. **❌ Tolerar "Brilliant Jerk" (tecnicamente ótimo mas tóxico)**
   - Resultado: time desmotivado, turnover
   - ✅ Valores > Skills: desligar se não mudar comportamento

10. **❌ Não investir em cultura (focar só em entregas)**
    - Resultado: burnout, desengajamento, silos
    - ✅ Rituais de time (retrospectivas, celebrações), psicological safety

---

## 📚 Materiais de Apoio e Referências

### Livros de Liderança

📖 **"The Manager's Path" - Camille Fournier**

- Carreira em tech: de IC a CTO

📖 **"Radical Candor" - Kim Scott**

- Como dar feedback eficaz (cuidar pessoalmente + desafiar diretamente)

📖 **"Crucial Conversations" - Patterson et al.**

- Como ter conversas difíceis

📖 **"Turn the Ship Around!" - L. David Marquet**

- Liderança distribuída (leader-leader vs. leader-follower)

📖 **"High Output Management" - Andy Grove (Intel)**

- Gestão de times de alta performance

### Livros de Data Science Leadership

📖 **"Building Data Science Teams" - DJ Patil**

- Como estruturar e liderar times de DS

📖 **"The Data Warehouse Toolkit" - Ralph Kimball**

- Infraestrutura de dados (contexto para líderes)

📖 **"Storytelling with Data" - Cole Nussbaumer Knaflic**

- Visualização e comunicação de dados

### Livros de Cultura e Organização

📖 **"Measure What Matters" - John Doerr**

- OKRs (Google, Intel)

📖 **"The Phoenix Project" - Gene Kim**

- DevOps e transformação organizacional (roman-chave)

📖 **"Team Topologies" - Skelton & Pais**

- Como estruturar times de tecnologia

### Artigos e Papers

📄 **"Data Science for Business" - Provost & Fawcett**

- Pensar analytics com lente de negócio

📄 **Harvard Business Review - "Data Scientist: The Sexiest Job of the 21st Century"**

- Perfil e desafios da profissão

📄 **"Building the AI-Powered Organization" (HBR)**

- Transformação organizacional com IA

### Cursos e Comunidades

🎓 **Coursera:** "Leading People and Teams" (University of Michigan)
🎓 **LinkedIn Learning:** cursos de management
🎓 **Reboot.io:** coaching para líderes de tech
🎓 **Rands Leadership Slack:** comunidade de engineering managers

### Podcasts

🎙️ **"Manager Tools":** práticas de gestão
🎙️ **"Radical Candor":** feedback e cultura
🎙️ **"DataFramed" (DataCamp):** liderança em DS
🎙️ **"The Data Chief":** CDOs e estratégia de dados

---

## ✅ Checklist de Estudo

### Fundamentos de Liderança

- [ ] Listar diferença entre technical lead vs. people manager
- [ ] Conhecer evolução de carreira: IC track vs. management track
- [ ] Entender quando soft skills > technical skills

### Gestão de Times

- [ ] Descrever perfis em time DS: Engineer, Scientist, ML Engineer, Analyst
- [ ] Conhecer modelos de organização: centralizado, descentralizado, híbrido (CoE)
- [ ] Saber ratio sugerido: 1:2-3:0.5 (Engineer:Scientist:ML Engineer)
- [ ] Listar 3 estratégias de retenção de talentos
- [ ] Saber principais causas de turnover

### Comunicação

- [ ] Aplicar estrutura de storytelling: Contexto → Insight → Ação
- [ ] Adaptar apresentação para 3 audiências: C-level, gestores, técnico
- [ ] Listar 3 princípios de visualização de dados (simplicidade, destaque, contexto)
- [ ] Escolher gráfico adequado: barras (comparação), linhas (tempo), scatter (correlação)

### Cultura Data-Driven

- [ ] Definir cultura data-driven (decisões baseadas em dados, não HiPPO)
- [ ] Listar 5 estratégias para construir: exemplo de cima, acesso, letramento, celebrar, infraestrutura
- [ ] Criar OKR para projeto de DS (Objective + 3 Key Results mensuráveis)

### Gestão de Projetos

- [ ] Desenhar ciclo CRISP-DM (6 etapas)
- [ ] Aplicar framework Impacto vs. Esforço para priorizar projetos
- [ ] Calcular ICE Score: Impact × Confidence / Ease
- [ ] Criar cronograma típico de projeto DS (12 semanas)
- [ ] Listar 3 estratégias de gestão de expectativas (PoC, MVP, comunicar riscos)

### Feedback e Performance

- [ ] Aplicar SBI Model: Situation-Behavior-Impact
- [ ] Estruturar 1-1 eficaz (frequência, pauta, responsabilidade)
- [ ] Criar PDI (Plano de Desenvolvimento Individual) com metas 3-6 meses e 1-2 anos
- [ ] Listar critérios de avaliação de performance (entrega, colaboração, impacto, crescimento)

### Conflitos

- [ ] Identificar 4 tipos de conflitos (técnico, recursos, interpessoal, organizacional)
- [ ] Aplicar 5 abordagens de resolução (colaboração, compromisso, competição, acomodação, evitação)
- [ ] Saber quando usar cada abordagem

### Liderança Remota

- [ ] Listar 5 desafios de times remotos
- [ ] Conhecer 5 práticas: documentação, assíncrono, rituais, ferramentas, expectativas
- [ ] Definir core hours e response time para time remoto
- [ ] Comparar modelo híbrido: quando presencial, quando remoto

### Ética

- [ ] Definir 3 tipos de viés: histórico, amostragem, confirmação
- [ ] Explicar trade-off fairness vs. accuracy
- [ ] Listar técnicas de explicabilidade: SHAP, LIME, feature importance
- [ ] Fazer checklist de ética: dano possível? injustiça? transparência? responsabilidade?

### Influência

- [ ] Listar 6 estratégias de influência sem autoridade (relacionamento, linguagem de negócio, storytelling, quick wins, alinhamento, coalizões)
- [ ] Saber lidar com 3 tipos de resistência: racional, emocional, política

### Desenvolvimento Pessoal

- [ ] Identificar 3 estilos de liderança: autocrático, democrático, delegativo
- [ ] Conhecer 5 componentes de EQ (Goleman): autoconhecimento, autorregulação, motivação, empatia, habilidades sociais
- [ ] Listar 5 práticas de continuous learning (leitura, cursos, mentoria, conferências, experimentação)
- [ ] Reconhecer 3 sinais de burnout (exaustão, cinismo, queda produtividade)
- [ ] Aplicar 5 práticas de prevenção (boundaries, férias, delegação, saúde, terapia)

### Projeto Prático: Plano de Liderança

- [ ] **Cenário:** você é novo lead de time de DS (5 pessoas: 2 scientists, 1 engineer, 1 analyst, 1 junior)
- [ ] **Tarefa 1 - Primeiros 90 dias:**
  - Conhecer cada pessoa: 1-1s individuais, entender motivações/desafios
  - Avaliar projetos em andamento: priorizar, cancelar low-impact
  - Alinhar com stakeholders: expectativas, OKRs
  - Estabelecer rituais: daily standup, weekly 1-1s, retros quinzenais
- [ ] **Tarefa 2 - Priorização:**
  - Receber 5 solicitações de projetos
  - Aplicar ICE Score para ranquear
  - Apresentar recomendação para stakeholders
- [ ] **Tarefa 3 - Comunicação:**
  - Resultado de projeto: modelo de churn com 75% recall
  - Criar 3 versões de apresentação: para CEO, para head de marketing, para time técnico
- [ ] **Tarefa 4 - Feedback:**
  - Um cientista entregou análise com código desorganizado e sem documentação
  - Preparar feedback usando SBI Model
- [ ] **Tarefa 5 - Conflito:**
  - Engineer quer refatorar pipeline (1 mês), Scientists querem features novas
  - Mediar conflito, buscar compromisso
- [ ] **Tarefa 6 - PDI:**
  - Criar PDI para junior scientist: metas técnicas e soft skills para 6 meses

---

**🎯 Meta de Aprendizado:**  
Desenvolver plano completo de liderança para time de Data Science, incluindo: estrutura organizacional, rituais de comunicação, estratégia de priorização (ICE Score), cultura de feedback (1-1s, SBI), gestão de projetos (CRISP-DM), comunicação com stakeholders (storytelling), e desenvolvimento de pessoas (PDIs). Demonstrar capacidade de balancear entrega técnica com desenvolvimento de equipe.

**💪 Desafio Avançado:**  
Liderar transformação data-driven em empresa tradicional (não-tech): (1) Diagnosticar maturidade de dados (infraestrutura, cultura, skills), (2) Desenhar roadmap de 12 meses (quick wins → projetos estruturantes), (3) Construir business case para investimento (ROI projetado), (4) Planejar change management (treinamentos, champions, comunicação), (5) Definir métricas de sucesso (OKRs organizacionais e de DS), (6) Apresentar para board (C-level pitch: problema, solução, investimento, retorno).

---

_Documentado para MBA Data Science e Analytics - USP/ESALQ_  
_Versão 1.0 - Liderança em Data Science e Analytics_
