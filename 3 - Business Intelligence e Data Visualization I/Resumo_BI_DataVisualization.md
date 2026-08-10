# 📊 Resumo do Curso: Business Intelligence e Data Visualization I

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Dominar os **fundamentos de Business Intelligence** e **técnicas de visualização de dados** para transformar dados brutos em insights acionáveis, incluindo conceitos de dashboards, KPIs, storytelling com dados, design de visualizações eficazes, e uso de ferramentas como Power BI para criação de painéis analíticos interativos.

---

## 📚 Conteúdo Principal

### 1. FUNDAMENTOS DE BUSINESS INTELLIGENCE

#### 1.1 Conceito de Business Intelligence (BI)

- **Definição**: Conjunto de tecnologias, processos e práticas para coletar, integrar, analisar e apresentar informações que apoiam decisões de negócio
- **Objetivo**: Transformar dados em informação, e informação em conhecimento acionável
- **Componentes principais**:
  - Coleta de dados
  - Armazenamento (Data Warehouse/Data Lake)
  - Processamento e análise
  - Visualização e relatórios
  - Distribuição e acesso

#### 1.2 Arquitetura de BI

```
Fontes de Dados
    ↓
ETL (Extract, Transform, Load)
    ↓
Data Warehouse / Data Mart
    ↓
Camada OLAP (Cubos multidimensionais)
    ↓
Ferramentas de BI (Dashboards, Relatórios)
    ↓
Usuários de Negócio (Tomada de Decisão)
```

**Componentes**:

- **Fontes de Dados**: Bancos transacionais, APIs, arquivos, planilhas
- **ETL**: Extração, transformação e carga de dados
- **Data Warehouse**: Repositório central de dados integrados
- **OLAP**: Online Analytical Processing (análise multidimensional)
- **Front-end**: Dashboards, relatórios, autoatendimento

#### 1.3 Tipos de Análise em BI

1. **Análise Descritiva** - "O que aconteceu?"
   - Relatórios históricos
   - Dashboards de KPIs
   - Resumos estatísticos

2. **Análise Diagnóstica** - "Por que aconteceu?"
   - Drill-down e drill-up
   - Análise de causa-raiz
   - Comparações e correlações

3. **Análise Preditiva** - "O que vai acontecer?"
   - Modelos estatísticos
   - Machine Learning
   - Previsões e tendências

4. **Análise Prescritiva** - "O que devemos fazer?"
   - Otimização
   - Simulações
   - Recomendações

---

### 2. DATA WAREHOUSE

#### 2.1 Conceito

- **Definição**: Repositório centralizado de dados integrados de múltiplas fontes, otimizado para análise
- **Características**:
  - **Orientado a assuntos**: Organizado por temas de negócio (vendas, clientes, produtos)
  - **Integrado**: Dados consolidados de diferentes fontes
  - **Não volátil**: Dados históricos preservados
  - **Variante no tempo**: Mantém histórico para análise temporal

#### 2.2 Modelagem Dimensional

**Esquema Estrela (Star Schema)**:

```
        Dim_Tempo
              |
Dim_Produto - Fato_Vendas - Dim_Cliente
              |
        Dim_Localização
```

- **Tabela Fato**: Medidas/métricas (vendas, quantidade, lucro)
- **Tabelas Dimensão**: Contexto (tempo, produto, cliente, local)
- **Chave estrangeira**: Liga fato às dimensões

**Esquema Floco de Neve (Snowflake)**:

- Dimensões normalizadas (subdivisões)
- Mais compacto, mas mais complexo para consultas

#### 2.3 Data Mart

- **Definição**: Subconjunto do Data Warehouse focado em área específica
- **Exemplo**: Data Mart de Vendas, Data Mart de RH
- **Vantagens**: Mais rápido, focado, menor custo

---

### 3. PROCESO ETL

#### 3.1 Extract (Extração)

- **Fontes**: Bancos de dados, APIs, arquivos CSV/Excel, sistemas ERP/CRM
- **Tipos**:
  - **Full extraction**: Extração completa
  - **Incremental extraction**: Apenas novos dados
- **Desafios**: Conectividade, formatos diferentes, volumes grandes

#### 3.2 Transform (Transformação)

- **Limpeza de dados**:
  - Remoção de duplicatas
  - Tratamento de valores ausentes
  - Padronização de formatos
- **Enriquecimento**:
  - Cálculos e derivações
  - Agregações
  - Conversão de tipos
- **Integração**:
  - Junção de múltiplas fontes
  - Resolução de conflitos
  - Padronização de nomes/códigos

#### 3.3 Load (Carga)

- **Tipos**:
  - **Full load**: Carga completa
  - **Incremental load**: Apenas novos/alterados
- **Estratégias**:
  - **Batch processing**: Processamento em lote (diário, semanal)
  - **Real-time**: Streaming de dados contínuo
- **Validação**: Verificar integridade após carga

---

### 4. KPIs E MÉTRICAS

#### 4.1 Conceito de KPI (Key Performance Indicator)

- **Definição**: Indicador quantificável que mede o desempenho em relação a objetivos estratégicos
- **Características de um bom KPI**:
  - **S**pecific: Específico e claro
  - **M**easurable: Mensurável quantitativamente
  - **A**chievable: Atingível e realista
  - **R**elevant: Relevante para o negócio
  - **T**ime-bound: Com prazo definido

#### 4.2 Tipos de KPIs

**KPIs Estratégicos**:

- ROI (Return on Investment)
- Market Share
- Customer Lifetime Value (CLV)
- Net Promoter Score (NPS)

**KPIs Operacionais**:

- Taxa de conversão
- Tempo médio de atendimento
- Taxa de defeitos
- Produtividade por funcionário

**KPIs Financeiros**:

- Receita
- Lucro líquido
- Margem de lucro
- EBITDA

**KPIs de Marketing**:

- CAC (Customer Acquisition Cost)
- Taxa de abertura de e-mails
- Engajamento em redes sociais
- Tráfego no site

#### 4.3 Métricas vs. Dimensões

- **Métrica**: Valor quantitativo (vendas, quantidade, lucro)
- **Dimensão**: Atributo qualitativo (tempo, produto, região)
- **Exemplo**: "Vendas (métrica) por Região (dimensão) em 2024 (dimensão)"

---

### 5. PRINCÍPIOS DE VISUALIZAÇÃO DE DADOS

#### 5.1 Por Que Visualizar Dados?

- **Cognição visual**: Humanos processam imagens 60.000x mais rápido que texto
- **Identificação de padrões**: Facilita detecção de tendências e outliers
- **Comunicação**: Transmite insights complexos rapidamente
- **Tomada de decisão**: Suporta decisões baseadas em dados

#### 5.2 Pirâmide da Informação

```
        Ação/Decisão
             ↑
         Insight
             ↑
        Informação
             ↑
           Dados
```

#### 5.3 Atributos Visuais (Visual Encoding)

**Atributos Quantitativos** (ordem de eficácia):

1. **Posição** (mais eficaz)
2. **Comprimento**
3. **Ângulo**
4. **Inclinação**
5. **Área**
6. **Volume**
7. **Saturação de cor** (menos eficaz)

**Atributos Qualitativos**:

- **Cor** (matiz)
- **Forma**
- **Textura**

**Regra de Ouro**: Use posição para dados mais importantes

---

### 6. TIPOS DE GRÁFICOS E SEUS USOS

#### 6.1 Comparação

**Gráfico de Barras** (Bar Chart):

- **Uso**: Comparar categorias
- **Exemplo**: Vendas por produto
- **Orientação**: Horizontal para nomes longos, Vertical para séries temporais curtas
- **Boas práticas**:
  - Sempre começar eixo em zero
  - Ordenar barras (maior → menor ou alfabético)
  - Máximo 10-12 categorias

**Gráfico de Colunas** (Column Chart):

- **Uso**: Similar ao de barras, mas com orientação vertical
- **Exemplo**: Vendas mensais no ano

**Gráfico de Barras Empilhadas** (Stacked Bar):

- **Uso**: Mostrar composição e comparação simultâneas
- **Exemplo**: Vendas por produto e por região
- **⚠️ Cuidado**: Dificulta comparação de categorias internas

#### 6.2 Composição (Parte do Todo)

**Gráfico de Pizza** (Pie Chart):

- **Uso**: Mostrar proporções de um todo
- **Boas práticas**:
  - Máximo 5-7 fatias
  - Começar às 12h (topo) com maior fatia
  - Usar apenas se soma = 100%
- **⚠️ Limitações**: Dificulta comparação de fatias similares
- **Alternativa**: Gráfico de barras 100% empilhadas

**Gráfico de Rosca** (Donut Chart):

- Variação do pizza com centro vazio
- Centro pode mostrar total

**Gráfico de Treemap**:

- **Uso**: Hierarquias e proporções complexas
- **Exemplo**: Vendas por categoria > subcategoria
- **Vantagem**: Mostra muitas categorias em espaço reduzido

#### 6.3 Distribuição

**Histograma**:

- **Uso**: Distribuição de frequência de variável contínua
- **Exemplo**: Distribuição de idades dos clientes
- **Bins**: Intervalos que agrupam dados

**Box Plot** (Diagrama de Caixa):

- **Uso**: Resumo estatístico (mediana, quartis, outliers)
- **Elementos**:
  - Caixa: Q1 a Q3 (IQR)
  - Linha: Mediana
  - Whiskers: Min/Max (excluindo outliers)
  - Pontos: Outliers

**Gráfico de Densidade** (Density Plot):

- Versão suavizada do histograma
- Mostra probabilidade da variável

#### 6.4 Tendência Temporal

**Gráfico de Linhas** (Line Chart):

- **Uso**: Mostrar tendência ao longo do tempo
- **Exemplo**: Evolução de vendas mês a mês
- **Boas práticas**:
  - Máximo 5-7 linhas
  - Tempo sempre no eixo X
  - Destacar linha principal

**Gráfico de Área** (Area Chart):

- Variação do gráfico de linhas com área preenchida
- **Uso**: Enfatizar magnitude da mudança

**Gráfico de Área Empilhada**:

- Mostra composição ao longo do tempo
- Soma das áreas = total

#### 6.5 Relacionamento/Correlação

**Gráfico de Dispersão** (Scatter Plot):

- **Uso**: Mostrar relação entre duas variáveis quantitativas
- **Exemplo**: Preço vs. Vendas
- **Elementos**:
  - Cada ponto = observação
  - Padrão indica correlação
  - Linha de tendência opcional

**Gráfico de Bolhas** (Bubble Chart):

- Scatter plot com terceira dimensão (tamanho da bolha)
- **Exemplo**: Preço (X) vs. Vendas (Y) vs. Lucro (tamanho)

**Heatmap** (Mapa de Calor):

- **Uso**: Matriz de valores com cores
- **Exemplo**: Correlações entre variáveis, Vendas por mês+região

#### 6.6 Geoespacial

**Mapas Coroplléticos** (Choropleth Maps):

- Regiões coloridas por intensidade de métrica
- **Exemplo**: Vendas por estado

**Mapas de Símbolos**:

- Pontos/símbolos em localizações geográficas
- Tamanho indica magnitude

---

### 7. DESIGN DE DASHBOARDS

#### 7.1 Princípios de Design

**Lei de Fitts**:

- Elementos importantes devem ser grandes e próximos
- Reduz tempo de movimento do olhar

**Lei de Hick**:

- Tempo de decisão aumenta com número de opções
- Simplifique: menos é mais

**Gestalt - Princípios de Agrupamento**:

- **Proximidade**: Elementos próximos são percebidos como grupo
- **Similaridade**: Elementos similares (cor, forma) são agrupados
- **Fechamento**: Mente completa formas incompletas
- **Continuidade**: Olhos seguem linhas contínuas

#### 7.2 Hierarquia Visual

```
1. TÍTULO PRINCIPAL (Maior, mais escuro)
   ↓
2. KPIs Principais (Destaque, acima da dobra)
   ↓
3. Gráficos de Apoio (Contexto adicional)
   ↓
4. Filtros e Controles (Sidebar ou topo)
   ↓
5. Notas e Rodapé (Menor, discreto)
```

#### 7.3 Estrutura de Dashboard

**Tipos de Dashboard**:

1. **Estratégico**:
   - Audiência: C-level, diretores
   - Foco: KPIs de alto nível
   - Atualização: Semanal/mensal
   - Visual: Simples, resumido

2. **Tático**:
   - Audiência: Gerentes
   - Foco: Performance departamental
   - Atualização: Diária
   - Visual: Gráficos comparativos

3. **Operacional**:
   - Audiência: Analistas, operadores
   - Foco: Métricas em tempo real
   - Atualização: Tempo real/horária
   - Visual: Detalhado, muitos dados

#### 7.4 Layout e Composição

**Regra dos Terços**:

- Divida tela em grade 3x3
- Posicione elementos importantes nas interseções

**Padrão Z** (leitura ocidental):

- Canto superior esquerdo → superior direito
- Diagonal → inferior esquerdo
- Inferior esquerdo → inferior direito

**Padrão F** (páginas web):

- Barra horizontal no topo
- Vertical à esquerda
- Segunda horizontal mais curta

**Whitespace (Espaço em Branco)**:

- Não tenha medo do vazio
- Respiro visual melhora compreensão
- Agrupa elementos relacionados

#### 7.5 Cores em Dashboards

**Paletas de Cores**:

1. **Sequencial**: Variação de intensidade de uma cor
   - Uso: Dados ordenados (baixo → alto)
   - Exemplo: Vendas (claro = baixo, escuro = alto)

2. **Divergente**: Duas cores com ponto neutro central
   - Uso: Desvio de referência (positivo/negativo)
   - Exemplo: Variação vs. meta (vermelho - neutro - verde)

3. **Categórica**: Cores distintas
   - Uso: Categorias não ordenadas
   - Exemplo: Produtos, regiões
   - **Regra**: Máximo 7-10 cores

**Boas Práticas de Cor**:

- **Evite arco-íris**: Dificulta percepção de ordem
- **Considere daltonismo**: ~8% da população (use azul/laranja, evite verde/vermelho sozinhos)
- **Destaque com parcimônia**: Apenas 1-2 cores de destaque
- **Consistência**: Mesma cor = mesmo significado em todo dashboard
- **Contraste**: Cores de fundo vs. texto (WCAG 2.0: mínimo 4.5:1)

---

### 8. STORYTELLING COM DADOS

#### 8.1 Estrutura de uma História com Dados

**Framework Clássico**:

1. **Contexto**: Estabelecer cenário
2. **Conflito/Problema**: Apresentar desafio
3. **Resolução**: Mostrar insights e recomendações

**Estrutura de Apresentação**:

```
Introdução
  ↓
Situação Atual (Dados descritivos)
  ↓
Problema Identificado (Análise diagnóstica)
  ↓
Solução Proposta (Insights)
  ↓
Próximos Passos (Call to action)
```

#### 8.2 Técnicas de Storytelling

**Anotações**:

- Destaque pontos específicos em gráficos
- Use setas, caixas de texto, cores
- Explique o "porquê" de picos/quedas

**Comparações Temporais**:

- "vs. ano anterior"
- "vs. média histórica"
- "vs. meta"

**Benchmarking**:

- Compare com concorrentes
- Compare com melhores práticas
- Compare entre departamentos

**Jornada do Cliente**:

- Mapeie touchpoints
- Identifique gargalos
- Mostre oportunidades

#### 8.3 Psicologia da Apresentação

**Primacy e Recency**:

- Audiência lembra mais do início e do fim
- Coloque insights mais importantes nesses momentos

**Repetição**:

- Reforce mensagem-chave 3x
- Diferentes formatos (visual, verbal, texto)

**Emoção**:

- Histórias ressoam mais que números
- Use casos reais, testimoniais

---

### 9. POWER BI - FERRAMENTA DE BI

#### 9.1 Arquitetura do Power BI

**Ecossistema**:

- **Power BI Desktop**: Aplicativo para criar relatórios (Windows/Mac/Linux via VM)
- **Power BI Service**: Plataforma cloud para compartilhar e colaborar
- **Power BI Mobile**: Aplicativo mobile para visualização
- **Power BI Gateway**: Conexão entre on-premise e cloud

#### 9.2 Componentes Principais

**Power Query**:

- Ferramenta de ETL visual
- Conectar a fontes de dados
- Transformar e limpar dados
- M language (linguagem de transformação)

**Power Pivot**:

- Modelo de dados in-memory
- Relacionamentos entre tabelas
- DAX (Data Analysis Expressions)

**Power View**:

- Canvas para criar visualizações
- Arrastar e soltar
- Formatação visual

#### 9.3 Modelagem de Dados no Power BI

**Relacionamentos**:

- **1:N (Um para Muitos)**: Mais comum (Dimensão → Fato)
- **1:1 (Um para Um)**: Raro, tabelas relacionadas
- **N:N (Muitos para Muitos)**: Evitar, usar tabela ponte

**Direção do Filtro**:

- **Single**: Filtro em uma direção
- **Both**: Filtro bidirecional (usar com cuidado)

**Cardinalidade**:

- Define quantos registros se relacionam

#### 9.4 DAX (Data Analysis Expressions)

**Conceitos Básicos**:

- Linguagem de fórmulas para cálculos
- Similar ao Excel, mas mais poderoso

**Tipos de Cálculos**:

1. **Colunas Calculadas**:

```dax
Lucro = [Receita] - [Custo]
```

- Calculado linha a linha
- Armazenado no modelo
- Usa memória

2. **Medidas** (Measures):

```dax
Total Vendas = SUM(Vendas[Valor])
Vendas Média = AVERAGE(Vendas[Valor])
```

- Calculado em tempo de consulta
- Não armazenado
- Mais eficiente

3. **Tabelas Calculadas**:

```dax
Calendario = CALENDAR(DATE(2020,1,1), DATE(2025,12,31))
```

**Contexto em DAX**:

- **Contexto de Linha**: Avalia cada linha individualmente
- **Contexto de Filtro**: Aplica filtros de slicers e filtros visuais

**Funções Comuns**:

**Agregação**:

```dax
SUM(Vendas[Valor])
AVERAGE(Vendas[Valor])
COUNT(Vendas[ID])
MIN(), MAX()
```

**Filtro**:

```dax
CALCULATE(
    SUM(Vendas[Valor]),
    Produto[Categoria] = "Eletrônicos"
)

FILTER(
    Vendas,
    Vendas[Valor] > 1000
)

ALL(Tabela)  // Remove todos os filtros
ALLEXCEPT(Tabela, Coluna)  // Remove filtros exceto coluna
```

**Tempo** (Time Intelligence):

```dax
Vendas YTD = TOTALYTD(SUM(Vendas[Valor]), Calendario[Data])

Vendas Ano Anterior = CALCULATE(
    SUM(Vendas[Valor]),
    SAMEPERIODLASTYEAR(Calendario[Data])
)

Crescimento % =
    DIVIDE(
        [Total Vendas] - [Vendas Ano Anterior],
        [Vendas Ano Anterior]
    )
```

**Iteração**:

```dax
SUMX(
    Vendas,
    Vendas[Quantidade] * Vendas[Preco]
)

AVERAGEX(Clientes, [Total Vendas Cliente])
```

---

### 10. BOAS PRÁTICAS EM BI

#### 10.1 Governança de Dados

- **Qualidade**: Dados limpos, consistentes, completos
- **Segurança**: Controle de acesso, RLS (Row-Level Security)
- **Metadados**: Documentação de fontes, transformações, definições
- **Auditoria**: Rastreabilidade de mudanças

#### 10.2 Performance

- **Modelo de dados**:
  - Star schema > Snowflake schema
  - Remover colunas desnecessárias
  - Tipos de dados apropriados
- **DAX**:
  - Medidas > Colunas calculadas
  - Evitar iteradores quando possível
  - Usar variáveis (VAR)
- **Visuais**:
  - Limitar visuais por página (máximo 10-15)
  - Evitar visuais customizados lentos

#### 10.3 Manutenibilidade

- **Nomenclatura**:
  - Nomes descritivos
  - Padrão consistente
  - Prefixos (m: measure, c: calculated column)
- **Organização**:
  - Pastas de exibição
  - Ocultar tabelas técnicas
  - Separar fatos e dimensões
- **Documentação**:
  - Descrições de medidas
  - Comentários em DAX
  - Documentação externa

#### 10.4 UX (User Experience)

- **Simplicidade**: Não sobrecarregar com informação
- **Consistência**: Layout, cores, terminologia
- **Responsividade**: Funcionar em diferentes dispositivos
- **Interatividade**: Drill-down, filtros, tooltips
- **Feedback**: Indicar carregamento, filtros aplicados

---

## 📊 Aplicações Práticas em Negócios

### 1. Vendas e Marketing

- **Dashboards de vendas**: Receita, pipeline, conversão
- **Análise de campanhas**: ROI de marketing, CAC
- **Segmentação de clientes**: RFM, CLV
- **Análise de funil**: Taxa de conversão por etapa

### 2. Finanças

- **Análise de P&L**: Receita, custos, lucro por centro de custo
- **Budget vs. Real**: Desvios orçamentários
- **Cashflow**: Projeções de fluxo de caixa
- **KPIs financeiros**: ROA, ROE, ROIC

### 3. Operações

- **Monitoramento de produção**: OEE, downtime, qualidade
- **Supply chain**: Lead time, stock-out, giro de estoque
- **Gestão de projetos**: Burndown, milestones, recursos

### 4. RH

- **People analytics**: Headcount, turnover, absenteísmo
- **Recrutamento**: Time-to-hire, cost-per-hire
- **Performance**: Avaliações, competências
- **Diversidade & Inclusão**: Métricas demográficas

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Fundamentos de BI

- **BI transforma dados em decisões**: Coleta → Armazena → Analisa → Visualiza → Age
- **Data Warehouse ≠ Banco de Dados**: DW é otimizado para análise (OLAP), BD para transações (OLTP)
- **Star Schema**: Fatos no centro, dimensões ao redor
- **ETL**: Extract → Transform → Load (preparação de dados)

### 📊 KPIs e Métricas

- **KPI é SMART**: Specific, Measurable, Achievable, Relevant, Time-bound
- **Leading vs. Lagging**: Leading indica futuro (pipeline), Lagging mostra passado (vendas efetivadas)
- **Vanity metrics**: Métricas que parecem boas mas não ajudam decisões (ex: total pageviews sem contexto)

### 🎨 Visualização de Dados

- **Posição > Comprimento > Ângulo > Área > Cor**: Ordem de eficácia para comparação
- **Pizza limita-se a 5-7 fatias**: Mais que isso, use barras
- **Tempo sempre no eixo X**: Convenção universal
- **Começar eixo Y em zero**: Evitar distorção em gráfico de barras/colunas

### 🖼️ Design de Dashboards

- **Above the fold**: KPIs principais no topo, visíveis sem scroll
- **Whitespace é seu amigo**: Espaço vazio melhora legibilidade
- **3-5-7 regra**: 3 cores principais, máximo 5-7 visuais importantes, máximo 7 categorias em gráfico
- **Mobile-first**: Crescente visualização em dispositivos móveis

### 📖 Storytelling

- **Contexto → Conflito → Resolução**: Estrutura narrativa clássica
- **So what?**: Todo insight deve responder "e daí?" - qual é a ação?
- **Anotações guiam o olhar**: Use anotações para destacar o importante

### ⚡ Power BI

- **Medidas > Colunas calculadas**: Medidas são mais eficientes
- **Relacionamentos 1:N**: Padrão ideal, sempre da dimensão para o fato
- **CALCULATE é rei**: Função mais poderosa do DAX, altera contexto de filtro
- **Time Intelligence requer tabela calendário**: Funções temporais precisam de dimensão de tempo contínua

---

## ⚠️ Erros Comuns a Evitar

### Design e UX

1. **Dashboard sobrecarregado**: Muita informação confunde
2. **3D em gráficos**: Distorce percepção, evitar sempre
3. **Gráfico de pizza com muitas fatias**: Dificulta comparação
4. **Fontes pequenas**: Texto <10pt é ilegível em projetor
5. **Cores inconsistentes**: Mesma cor para significados diferentes
6. **Eixos duplos Y**: Confunde escala
7. **Falta de título/legendas**: Contexto é essencial

### Dados e Análise

8. **Correlação ≠ Causação**: Não infira causalidade sem evidência
9. **Cherry-picking**: Selecionar dados que apoiam conclusão pré-determinada
10. **Não validar fontes**: Dados ruins = insights ruins
11. **Ignorar outliers**: Podem ser bugs ou insights valiosos
12. **Métricas desatualizadas**: Dashboard deve refletir situação atual
13. **Não documentar transformações**: Perde-se rastreabilidade

### Power BI Específico

14. **Importar todas as colunas**: Carrega modelo desnecessariamente
15. **Relacionamentos N:N**: Causa problemas de performance e ambiguidade
16. **Colunas calculadas em vez de medidas**: Usa mais memória e é menos flexível
17. **Não usar variáveis em DAX**: Repete cálculos, dificulta manutenção
18. **DirectQuery sem otimização**: Consultas lentas afetam UX

---

## 🛠️ Ferramentas e Recursos

### Ferramentas de BI

- **Power BI**: Microsoft (foco deste curso)
- **Tableau**: Forte em visualizações e exploração
- **Qlik Sense**: Associações automáticas
- **Looker**: Forte em modelagem (agora Google Cloud)
- **Metabase**: Open-source, simples
- **Google Data Studio**: Integração com Google ecosystem

### Paletas de Cores

- **ColorBrewer**: Paletas scientificamente testadas
- **Adobe Color**: Criação de paletas harmoniosas
- **Viz Palette**: Testes de acessibilidade

### Inspiração de Design

- **Information is Beautiful**: David McCandless
- **Flowing Data**: Nathan Yau
- **Storytelling with Data**: Cole Nussbaumer Knaflic
- **Power BI Community**: Galeria de relatórios

### Conjuntos de Dados Abertos

- **Dados.gov.br**: Dados do governo brasileiro
- **Kaggle Datasets**: Dados para aprendizado
- **World Bank Open Data**: Dados econômicos mundiais
- **Our World in Data**: Dados sobre temas globais

---

## 📚 Materiais de Apoio

### Livros Fundamentais

1. **"Storytelling with Data"** - Cole Nussbaumer Knaflic
   - Bíblia da visualização eficaz de dados
2. **"The Visual Display of Quantitative Information"** - Edward Tufte
   - Clássico do design de informação
3. **"Information Dashboard Design"** - Stephen Few
   - Design de dashboards eficazes
4. **"The Truthful Art"** - Alberto Cairo
   - Visualização de dados com integridade
5. **"The Big Book of Dashboards"** - Steve Wexler, Jeffrey Shaffer, Andy Cotgreave
   - 28 exemplos práticos de dashboards

### Livros Power BI

1. **"The Definitive Guide to DAX"** - Marco Russo & Alberto Ferrari
2. **"M is for (Data) Monkey"** - Ken Puls & Miguel Escobar
3. **"Power BI Cookbook"** - Brett Powell

### Blogs e Sites

- **SQLBI.com**: Melhores práticos de DAX e modelagem
- **PowerBI.tips**: Tutoriais e dicas práticas
- **ExcelIsFun**: YouTube channel com tutoriais
- **Dashboard Design Best Practices**: Stephen Few's articles

### Certificações

- **PL-300**: Microsoft Power BI Data Analyst Associate
- **DA-100**: (antiga) Microsoft Certified: Data Analyst Associate

---

## 🎯 Pontos Importantes para Reter

### Workflow de Projeto de BI

1. **Descoberta**: Entender problema de negócio, definir KPIs
2. **Coleta**: Identificar e acessar fontes de dados
3. **Modelagem**: Criar modelo dimensional (star schema)
4. **ETL**: Extrair, transformar e carregar dados
5. **Cálculos**: Criar medidas DAX necessárias
6. **Visualização**: Desenhar dashboards seguindo princípios de design
7. **Validação**: Testar com usuários, validar números
8. **Publicação**: Disponibilizar no Power BI Service
9. **Manutenção**: Atualização de dados, ajustes com feedback

### Checklist de um Bom Dashboard

✅ **Objetivo claro**: Dashboard responde perguntas específicas de negócio  
✅ **KPIs no topo**: Métricas principais visíveis imediatamente  
✅ **Hierarquia visual**: Tamanho e posição refletem importância  
✅ **Gráficos apropriados**: Tipo de gráfico adequado ao tipo de dado  
✅ **Cores com propósito**: Cores comunicam significado, não apenas decoram  
✅ **Contexto temporal**: Comparações (vs. período anterior, vs. meta)  
✅ **Interatividade**: Filtros e drill-down permitem exploração  
✅ **Performance**: Carrega rápido (<5 segundos)  
✅ **Mobile-friendly**: Funciona bem em tablets/celulares  
✅ **Documentado**: Usuários entendem o que estão vendo

### Perguntas para Avaliar um Visual

- **Clareza**: Mensagem é imediatamente óbvia?
- **Precisão**: Representa dados fielmente sem distorção?
- **Eficiência**: Usa espaço de forma otimizada?
- **Estética**: Aparência é profissional e agradável?
- **Relevância**: Suporta decisão de negócio?

---

## 📖 Referências Recomendadas

### Artigos Clássicos

- **Tufte, E.** "Visual Explanations: Images and Quantities, Evidence and Narrative"
- **Few, S.** "Dashboard Confusion" - Perceptual Edge
- **Cairo, A.** "The Chartjunk Debate" - IEEE Computer Graphics and Applications

### Recursos Online

- **Power BI Documentation**: https://docs.microsoft.com/power-bi/
- **DAX Guide**: https://dax.guide/
- **SQLBI**: https://www.sqlbi.com/
- **Data Visualization Catalogue**: https://datavizcatalogue.com/
- **From Data to Viz**: https://www.data-to-viz.com/

### Comunidades

- **Power BI Community**: https://community.powerbi.com/
- **Reddit r/PowerBI**: Discussões e dúvidas
- **LinkedIn Power BI User Group**: Networking e cases
- **Power BI User Groups**: Meetups locais

---

## ✅ Checklist de Estudo

### Conceitos Fundamentais

- [ ] Entender diferença entre OLTP e OLAP
- [ ] Conhecer arquitetura de BI (fontes → DW → dashboards)
- [ ] Compreender processo ETL
- [ ] Diferenciar Data Warehouse e Data Mart
- [ ] Conhecer modelagem dimensional (star e snowflake)

### KPIs e Métricas

- [ ] Definir KPIs relevantes para um caso de negócio
- [ ] Diferenciar vanity metrics de actionable metrics
- [ ] Entender diferença entre leading e lagging indicators
- [ ] Aplicar critérios SMART para KPIs

### Visualização de Dados

- [ ] Conhecer atributos visuais e sua eficácia
- [ ] Escolher tipo de gráfico apropriado para cada situação
- [ ] Aplicar princípios de Gestalt em layouts
- [ ] Usar cores de forma eficaz e acessível
- [ ] Evitar chartjunk e distorções

### Design de Dashboards

- [ ] Aplicar hierarquia visual
- [ ] Usar whitespace de forma efetiva
- [ ] Posicionar KPIs estrategicamente
- [ ] Criar dashboards para diferentes audiências (estratégico/tático/operacional)
- [ ] Testar em diferentes dispositivos

### Storytelling

- [ ] Estruturar apresentação com dados (contexto-conflito-resolução)
- [ ] Usar anotações para guiar atenção
- [ ] Responder "So what?" para cada insight
- [ ] Apresentar dados de forma persuasiva

### Power BI - Básico

- [ ] Instalar Power BI Desktop
- [ ] Conectar a diferentes fontes de dados
- [ ] Usar Power Query para transformações
- [ ] Criar relacionamentos entre tabelas
- [ ] Diferenciar coluna calculada de medida

### Power BI - DAX

- [ ] Criar medidas básicas (SUM, AVERAGE, COUNT)
- [ ] Usar CALCULATE para alterar contexto
- [ ] Aplicar funções de filtro (FILTER, ALL, ALLEXCEPT)
- [ ] Implementar Time Intelligence (YTD, SAMEPERIODLASTYEAR)
- [ ] Usar variáveis (VAR) para otimizar DAX
- [ ] Debugar DAX com testes iterativos

### Power BI - Visualizações

- [ ] Criar diferentes tipos de visuais
- [ ] Customizar formatação (cores, fontes, títulos)
- [ ] Configurar interações entre visuais
- [ ] Criar tooltips customizados
- [ ] Implementar drill-down e drill-through
- [ ] Usar bookmarks e buttons para navegação

### Power BI - Publicação

- [ ] Publicar relatório no Power BI Service
- [ ] Configurar refresh automático
- [ ] Criar e compartilhar workspaces
- [ ] Implementar RLS (Row-Level Security)
- [ ] Criar apps para distribuição

### Projeto Prático

- [ ] Definir caso de negócio
- [ ] Coletar e preparar dados
- [ ] Modelar dados em star schema
- [ ] Criar 10+ medidas DAX relevantes
- [ ] Desenhar 3 páginas de dashboard (overview, detalhe, análise)
- [ ] Aplicar boas práticas de design
- [ ] Publicar e compartilhar
- [ ] Documentar todo o processo

---

**📌 Nota Final:** Business Intelligence e Data Visualization são competências essenciais para qualquer profissional de dados. A capacidade de transformar dados complexos em insights visuais e acionáveis diferencia análises acadêmicas de soluções de negócio reais. Power BI é uma das ferramentas mais demandadas no mercado, mas os princípios de visualização e design se aplicam a qualquer ferramenta.

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_  
_Módulo 3 - Business Intelligence e Data Visualization I_
