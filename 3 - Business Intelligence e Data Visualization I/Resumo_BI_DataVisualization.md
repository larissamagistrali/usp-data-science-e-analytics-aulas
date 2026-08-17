# 📊 Resumo do Curso: Business Intelligence e Data Visualization I

**MBA em Data Science & Analytics - USP/ESALQ**
**Professora: Viviane Martins Ferreira**

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos de Business Intelligence e o processo de visualização de dados (#dataviz), incluindo a importação, tratamento, organização e análise de dados, a criação de dashboards no Microsoft Power BI a partir de bases de dados reais, e os cuidados de governança e privacidade de dados envolvidos nesse processo.

---

## 📚 Conteúdo Principal

### 1. BUSINESS INTELLIGENCE

#### 1.1 Conceito

- **Business Intelligence**: transformar dados em informações úteis que podem contribuir com decisões e tomadas estratégicas nas organizações.
- **Fases do processo de BI**: ETL (Extract – Transform – Load), Modelagem de dados, Visualização de Dados, Publicação.
- **Pipeline apresentado em aula**: Identificação → Coleta → Limpeza → Transformação → Modelagem → Armazenamento → Análise e Visualização.

#### 1.2 Áreas de atuação do BI (exemplos dados em aula)

| Área | Foco |
|---|---|
| Financeiro | Controle de custos, análise de lucros, orçamentos, previsões |
| Vendas | Acompanhamento de metas, desempenho de equipes, funil de vendas |
| Marketing | Análise de campanhas, comportamento de clientes, ROI |
| RH | Turnover, absenteísmo, produtividade, clima organizacional |
| Supply Chain | Gestão de estoques, logística, fornecedores, custos operacionais |
| Operações | Otimização de processos, eficiência produtiva, controle de qualidade |
| TI | Monitoramento de sistemas, desempenho, segurança e suporte a dados |

#### 1.3 Self Service Analytics

- **Conceito**: simplifica a análise para usuários que não são da área de tecnologia, oferecendo autonomia para criação de análises, relatórios e dashboards, com suporte de uma base tecnológica estruturada.
- **Pilares Técnicos**: Tecnologia, DW (Data Warehouse), Data Mining.
- **Pilares Humanos e Organizacionais**: Skill (Habilidades), Processos, Recursos.
- **Entregáveis**: Report (Relatórios), Analytics (Análises Avançadas), Data Viz (Visualização de Dados).

#### 1.4 Fatores de Sucesso

- Governança de dados eficiente
- Cultura orientada a dados
- Capacitação dos usuários
- Processos bem definidos
- Suporte tecnológico robusto

**Vantagens do Self Service Analytics**: agilidade na tomada de decisões, independência dos times de TI, redução de custos operacionais, aumento da produtividade, foco em análises estratégicas.

#### 1.5 Premissas de um projeto de BI (fluxo apresentado)

Entenda o contexto → Identifique a fonte → Importação e tentativa → Desenvolvimento de reports → Criação de dashboards

Nas etapas **Coletar** (identificar onde estão os dados; arquivos .txt/.csv/.xlsx; bases de dados como Oracle, SQL Server, MySQL, DB2), **Organizar** (entender e padronizar os dados coletados, definir tipos de campo e formatos de exibição) e **Analisar** (criar relatórios, criar objetos visuais/gráficos, definir um painel de visualização/dashboard).

---

### 2. DATA VISUALIZATION (#DATAVIZ)

#### 2.1 Conceito

- Data Visualization: transformar dados "de incompreensível para compreensível".

#### 2.2 O processo de #DataViz

Sequência apresentada em aula:

1. **Definir o objetivo** — estudo e entendimento do escopo atual, necessidades, onde está e para onde se quer chegar.
2. **Adquirir os dados** — importar os dados relevantes para o projeto.
3. **Formatar os dados** — tratamento e, se necessário, integração dos dados.
4. **Filtrar** — filtrar os dados para incluir na visualização apenas o necessário.
5. **Analisar** — analisar os dados coletados e tratados, usando visões gráficas de apoio.
6. **Representar** — criar painéis gráficos para representar os dados de maneira visual, através de uma ferramenta escolhida.
7. **Refinar e interagir** — refinar a visualização para o público-alvo, publicar e interagir com ele.

#### 2.3 Fluxo de construção da visualização

Planejamento → Entendimento do Business → Narrativa da História → Objetos gráficos e visuais → Ferramentas Analíticas → Ferramentas de Design

#### 2.4 Análise, tratamento e construção

- **Objetividade**: o que eu quero mostrar?
- **Clareza**: como eu quero mostrar?
- **Padronização**: padronizar títulos e objetos (tamanho, posição, cores, fontes).
- **Definição de Layout**: como eu quero mostrar?
- **Contar a história**: refinar a visualização para que fique adequada ao público-alvo; publicar e interagir com o público-alvo.

#### 2.5 O que não fazer (exemplos mostrados em aula)

A partir de exemplos reais de dashboards sobrecarregados (tabelas extensas e muitos gráficos pequenos na mesma tela), a professora destacou:

- Evitar telas com excesso de tabelas e gráficos simultâneos.
- **Nem todos os dados são importantes** — selecionar o que realmente apoia a análise, em vez de exibir tudo que está disponível.

#### 2.6 Ferramentas citadas para apoio ao design

- **Figma**, **Adobe Color**, **Flaticon** — ferramentas de design e banco de imagens.

#### 2.7 Canais para se inspirar (citados em aula)

- Comunidade do Power BI
- Comunidade do Tableau
- Pesquisar modelos em outras ferramentas analíticas

---

### 3. MICROSOFT POWER BI

- **Criado em 2015**; apontado como ferramenta líder de mercado segundo o Gartner.
- **Funções**: Coleta, Tratamento e Análise de informações; visualização de dados de maneira intuitiva.
- **Ecossistema**:
  - **Services**: usuários fazem consumo dos reports.
  - **Desktop**: desenvolvimento de reports e análises.
  - **Mobile**: aplicativo móvel.
  - **Embedded**: embarcar relatório em aplicações de terceiros.
- **Prática em aula**: importação de dados, tratamento de dados, conceitos de métricas e cálculos, criação de objetos gráficos, criação de segmentações (filtros), e criação de painéis visuais a partir de bases de dados reais (planilhas de Vendas, Colaboradores, Chamados, Faturamento, Perdas, dados de supermercado, dados do Spotify), incluindo customização de dashboards em consonância com o manual de marca de uma empresa.

---

### 4. GESTÃO, GOVERNANÇA E PRIVACIDADE DE DADOS

#### 4.1 Gestão e Governança de Dados

- **Pessoas** (Quem?): definir a organização responsável por gerenciar a informação como um ativo da organização.
- **Processos** (Como?): regras, procedimentos, políticas, papéis e responsabilidades sobre o ciclo de vida da informação; garantir qualidade, consistência, completude, disponibilidade e segurança através de métricas e mensuração.
- **Tecnologia** (O quê?): definir a tecnologia para ajudar a suportar a organização de governança de dados.
- Citado em aula: o relatório **Magic Quadrant for Data and Analytics Governance Platforms** (Gartner, 2025), que avalia plataformas de governança e qualidade de dados.

#### 4.2 Missão – Proteção

Pontos de atenção citados: Cyber Attacks, Privacidade, Fraude, **Shadow IT**, Estratégia do Business.

- **Shadow IT**: qualquer sistema, dispositivo ou serviço usado em uma organização sem o conhecimento ou aprovação do departamento de Tecnologia. Riscos associados: conformidade, custos não administrados, regulamentação de dados, segurança.

#### 4.3 Privacidade de Dados

- Visa manter o sigilo e a confidencialidade dos dados — não apenas dados do cliente, mas tudo que envolve a estratégia do negócio.
- **Confidencialidade dos dados** abrange: documentos relacionados ao projeto, dados, e-mails, etapas de negociação.
- **NDA (Non-Disclosure Agreement)** = Acordo de Sigilo de Informações, contrato de confidencialidade legalmente assinado entre as partes.
- **Prevenção** citada em aula: utilizar senhas seguras, não conectar em wifi público, atualizar o antivírus, ter cautela na documentação do cliente.
- **Termos de Adesão (internet)**: Termos de uso, Política de dados e privacidade, Regras da comunidade.
- Exemplo mostrado em aula: tabela "O que as empresas sabem de você" (Google, Facebook, Spotify, Instagram, Twitter, Microsoft, YouTube, WhatsApp, Uber, LinkedIn, Tinder), com base em estudo da revista Dinheiro/PPP Advogados sobre termos de uso de serviços digitais.
- **ANPD (Autoridade/Agência Nacional de Proteção de Dados)**: zela pela proteção dos dados através de conscientização, fiscalização e da LGPD.

---

## 📊 Aplicações Práticas em Negócios

Áreas de atuação de BI apresentadas em aula (ver tabela na seção 1.2): Financeiro, Vendas, Marketing, RH, Supply Chain, Operações e TI.

Prática de sala de aula: construção de dashboards no Power BI a partir de bases reais fornecidas — vendas, colaboradores, chamados, faturamento anual, perdas por tipo/assalto, estoque de supermercado e dados do Spotify — além de painéis pós-aula sobre colaboradores e chamados.

---

## 💡 Conceitos-Chave para Memorizar

- **BI transforma dados em informações úteis** para decisões e tomadas estratégicas.
- **Fases do processo de BI**: ETL → Modelagem → Visualização → Publicação.
- **Self Service Analytics**: autonomia de usuários não-técnicos para análises, apoiada em pilares técnicos (tecnologia, DW, data mining) e humanos/organizacionais (skill, processos, recursos).
- **Processo de #DataViz**: Definir objetivo → Adquirir dados → Formatar → Filtrar → Analisar → Representar → Refinar e interagir.
- **Nem todos os dados são importantes**: dashboards sobrecarregados de tabelas e gráficos dificultam a leitura.
- **Power BI**: criado em 2015, líder de mercado (Gartner); ecossistema Desktop/Services/Mobile/Embedded.
- **Governança de dados**: Pessoas, Processos e Tecnologia.
- **Shadow IT**: uso de sistemas/serviços sem aprovação de TI, gerando riscos de conformidade, custo, regulamentação e segurança.
- **NDA**: contrato de confidencialidade entre as partes.
- **ANPD**: órgão responsável por conscientizar, fiscalizar e aplicar a LGPD.

---

## 🛠️ Materiais de Apoio (citados no material complementar da disciplina)

### Leituras sugeridas pela professora

- International Data Corporation (IDC)
- The Data Warehouse Institute (TDWI)
- Gartner
- Dataviz – Tableau
- Visual Capitalist
- Microsoft. 2025. Power Platform
- Microsoft. 2025. Criar mapas do ArcGIS no Power BI
- Microsoft. 2025. Plano de IA – processo para planejar a adoção da IA
- Plataforma de Power BI – downloads
- Venngage (Gaskin, J., 2021) — Tudo o que você precisa saber sobre gráficos de pizza
- Microsoft. 2025. O que é o Power Query?

### Cases de Cultura Data Driven

- Visual Capitalist. 2017. *Breaking Down How Amazon Makes Money*
- Computer Weekly. Ambasna-Jones, M. 2019. *McLaren COO Jonathan Neale on finding racing margins in IoT sensor data*

### Privacidade, LGPD e KPIs

- BV. *Conheça seus direitos*
- Gov.br – Autoridade Nacional de Proteção de Dados (ANPD)
- IBM Garage — Usabilidade de Indicadores Chave de Performance (KPI)
- The Economist. 2020. *A new global ranking of cyber-power throws up some surprises*

### Livros disponíveis na Biblioteca ABCD_USP

- Foreman, J.W. 2018. *Data Smart: usando Data Science para transformar informação em insight*. Alta Books.
- Kugler, J.L.C. 2013. *Competência Analítica*. Grupo GEN.

### Outros livros indicados na bibliografia complementar

- Fawcett, T.; Provost, F. 2013. *Data Science for Business*
- Granville, V. 2014. *Developing Analytic Talent*
- Lander, J. 2017. *R for Everyone*
- O'Neil, C.; Schutt, R. 2013. *Doing Data Science*
- EMC Education Services. 2015. *Data Science and Big Data Analytics*
- VanderPlas, J. 2017. *Python Data Science Handbook*
- Patil, D.; Mason, H. 2015. *Data Driven*
- White, T. 2015. *Hadoop: The Definitive Guide*
- Peng, R. 2016. *R Programming for Data Science*
- McKinney, W. 2012. *Python for Data Analysis*
- Anderson, C. 2015. *Creating a Data-Driven Organization*
- Marr, B. 2018. *Data-Driven HR*
- Swanson, D.; Dearborn, J. 2017. *The Data Driven Leader*
- Leek, J. 2015. *The Elements of Data Analytic Style*
- Patil, D. 2012. *Data Jujitsu*

### Arquivos de apoio da disciplina (na pasta do módulo)

- Planilhas para prática em Power BI: `Colaboradores.xlsx`, `Vendas_.xlsx`, `Chamados.xlsx`, `Faturamento Ano.xlsx`, `Perdas por Tipo.xlsx`, `Perdas Assalto.xlsx`, `supermarket_inventory.txt`, `spotify.xlsx`.
- Imagens e planos de fundo para customização de dashboards (pasta `Background`) e imagens do case Spotify (pasta `Imagens_Spotify`).
- Painéis Power BI de exemplo/exercício: `Painel Analítico_Glicose.pbix`, `a2_Colaboradores.pbix`, e os arquivos pós-aula `A3_Chamados.pbix`, `a3_Colaboradores.pbix`, `a3_Vendas.pbix`.
- Tutoriais de instalação do Power BI Desktop (Windows, VM Linux e VM macOS) e tutorial de acesso às bibliotecas digitais (ABCD USP, Pecege, Busca Integrada USP/EBSCO para artigos da Harvard Business Review).

---

## ✅ Checklist de Estudo

### Conceitos Fundamentais de BI

- [ ] Entender o conceito de Business Intelligence apresentado em aula
- [ ] Conhecer as fases do processo de BI (ETL, modelagem, visualização, publicação)
- [ ] Compreender o conceito de Self Service Analytics e seus pilares
- [ ] Identificar áreas de negócio onde o BI é aplicado (Financeiro, Vendas, Marketing, RH, Supply Chain, Operações, TI)

### Data Visualization

- [ ] Conhecer as 7 etapas do processo de #DataViz apresentado em aula
- [ ] Aplicar objetividade, clareza, padronização e definição de layout na construção de um painel
- [ ] Reconhecer exemplos de "o que não fazer" (excesso de dados/tabelas em um dashboard)

### Power BI

- [ ] Instalar o Power BI Desktop
- [ ] Importar e tratar dados de planilhas reais (Excel/txt)
- [ ] Criar segmentações (filtros), cálculos rápidos e objetos gráficos
- [ ] Construir e customizar um dashboard seguindo o manual de marca de uma empresa
- [ ] Praticar com os arquivos `.pbix` e planilhas fornecidos no módulo

### Governança e Privacidade de Dados

- [ ] Entender o tripé Pessoas / Processos / Tecnologia na governança de dados
- [ ] Reconhecer riscos de Shadow IT
- [ ] Compreender o conceito de NDA e boas práticas de prevenção (senhas, wifi público, antivírus, cautela documental)
- [ ] Conhecer o papel da ANPD e da LGPD

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_
_Módulo 3 - Business Intelligence e Data Visualization I_
_Conteúdo revisado e restrito ao que foi efetivamente apresentado nos slides, material complementar e arquivos práticos da disciplina._
