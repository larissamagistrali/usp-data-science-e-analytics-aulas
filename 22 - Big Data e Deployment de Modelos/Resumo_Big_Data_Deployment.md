# 🎲 Resumo do Curso: Big Data e Deployment de Modelos

**MBA em Data Science & Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos de **Big Data** (conceito, escala e os 5V's), conhecer os principais **frameworks de processamento distribuído** (Hadoop MapReduce e Apache Spark), entender a evolução das **arquiteturas de dados** (Data Warehouse → Data Lake → Data Lakehouse e Arquitetura Medalhão), e dominar o **ciclo de vida de deployment de modelos de Machine Learning em produção** com foco em **MLOps** e na ferramenta **MLflow**, incluindo prática em ambiente **Databricks**.

---

## 📚 Conteúdo Principal

### 1. O QUE É BIG DATA

#### 1.1 Definição

- **Big Data**: conjuntos de dados extremamente **grandes e complexos** que não podem ser facilmente processados ou gerenciados **com ferramentas de processamento de dados tradicionais**.

#### 1.2 Entendendo a Escala dos Dados

- **1 exabyte** equivale a **1.073.741.824 Gigabyte**
- **1 zettabyte (ZB)** equivale a **1.024 exabytes** (padrão binário)
- **Explosão de dados no mundo**: a *Global Datasphere* (fonte: Data Age 2025, Seagate/IDC) projetava crescimento exponencial de dados, de poucos ZB em 2010 até **175 ZB em 2025**.

#### 1.3 A Explosão de Dados na Era da Inteligência Artificial

- **O motor do crescimento**: o boom da Inteligência Artificial Generativa (LLMs) acelerou a criação de **dados não estruturados** e de **dados sintéticos** (dados gerados por IA para treinar outras IAs).
- **Custo de armazenamento**: embora o volume cresça exponencialmente, o custo de armazenamento em nuvem (**S3, Azure Blob, GCS**) tornou viável guardar históricos infinitos.
- Estatísticas ilustrativas de "cada minuto do dia" (fonte: domo.com/data-never-sleeps): volume de buscas no Google, mensagens de texto, e-mails, prompts em ChatGPT, uso de IA generativa, etc., evidenciando a escala e a velocidade da geração de dados.

#### 1.4 Como Lidar com Dados

- Fluxo geral: dados brutos (arquivos, servidores, bancos de dados) → **processamento** → geração de **insights** (dashboards, séries temporais, gráficos analíticos).

---

### 2. OS 5V's DO BIG DATA

| **V**          | **Definição**                                                                              |
| --------------- | ------------------------------------------------------------------------------------------- |
| **Volume**      | Quantidade massiva de dados gerada continuamente.                                            |
| **Velocidade**  | Rapidez com que os dados são gerados, processados e disponibilizados para análise.           |
| **Variedade**   | Diversidade de tipos de dados: estruturados, não estruturados e semiestruturados.            |
| **Veracidade**  | Confiabilidade e qualidade dos dados.                                                        |
| **Valor**       | Capacidade de extrair informações úteis e insights significativos a partir dos dados.        |

- **Como começamos a lidar com os 5V's?**: através de frameworks de processamento distribuído, como **Hadoop MapReduce** e **Apache Spark**.

---

### 3. FRAMEWORKS DE BIG DATA: HADOOP E APACHE SPARK

#### 3.1 Visão Geral

- **Hadoop MapReduce** e **Apache Spark** são duas tecnologias amplamente utilizadas no ecossistema de Big Data, cada uma desempenhando um papel específico para **lidar com os desafios associados aos 5V's** do Big Data.
- Ambos são projetados para funcionar em **ambientes distribuídos**, onde **clusters de computadores** são utilizados para processar grandes volumes de dados.

#### 3.2 Cluster de Computadores

- Estrutura típica: um **Node Master** coordena múltiplos **Nodes** (Node 1, Node 2, ..., Node N) que executam o processamento em paralelo.

#### 3.3 Hadoop MapReduce

- **Armazenamento Distribuído**: o **HDFS** (Hadoop Distributed File System) permite armazenar grandes volumes de dados de maneira distribuída em clusters de servidores.
- **Processamento Distribuído**: o **MapReduce**, modelo de programação do Hadoop, facilita o processamento paralelo de grandes conjuntos de dados, dividindo tarefas em diferentes nós do cluster.
- **Escalabilidade**: Hadoop é escalável **horizontalmente** — é possível adicionar mais servidores conforme a necessidade para lidar com o aumento de volume de dados.
- **Processamento em Disco**: o Hadoop grava dados no disco entre as etapas do processamento (mais lento que o Spark).

##### Exemplo do processo MapReduce (contagem de palavras)

```
Input:
Deer Bear River
Car Car River
Deer Car Bear

Splitting → Mapping → Shuffling → Reducing → Final result

"Deer Bear River" → Deer,1 / Bear,1 / River,1  →
"Car Car River"   → Car,1 / Car,1 / River,1    → Shuffle por chave → Reduce
"Deer Car Bear"   → Deer,1 / Car,1 / Bear,1    →

Resultado final: Bear,2 | Car,3 | Deer,2 | River,2
```

#### 3.4 Apache Spark

##### Arquitetura

- **Driver Program**: contém o **SparkContext**, que coordena a execução.
- **Cluster Manager**: gerencia a alocação de recursos entre os nós.
- **Nodes (Node 1, Node 2, ..., Node N)**: cada um com um **Executor**, contendo **Cache** e múltiplas **Tasks**.

##### Componentes do Apache Spark

- **DAG (Directed Acyclic Graph)**: representação gráfica das operações que serão realizadas no Spark, descrevendo o fluxo de dados através de um conjunto de operações.
  - **Direcionado**: as arestas têm direção, indicando a sequência de operações.
  - **Acíclico**: não há ciclos; uma vez que os dados são processados, não voltam ao mesmo ponto.
  - **Função**: o DAG permite que o Spark otimize a execução das operações, dividindo tarefas em estágios (*stages*) e permitindo o paralelismo (ex.: `Stage 5`, `Stage 6` ... `WholeStageCodegen`, `ShuffleQueryStage`, `Exchange`).

- **RDD (Resilient Distributed Dataset)**: estrutura de dados fundamental do Spark, representando uma coleção distribuída de objetos imutáveis.
  - **Resiliente**: pode se recuperar de falhas, recomputando dados a partir de suas operações originais.
  - **Distribuído**: os dados são armazenados em diferentes nós de um cluster, permitindo processamento paralelo.
  - **Imutável**: uma vez criado, não pode ser alterado; novas transformações geram novos RDDs.
  - **Operações**:
    - **Transformações**: operações que produzem um novo RDD (ex.: `map`, `filter`).
    - **Ações**: operações que retornam um valor ao driver (ex.: `count`, `collect`).

##### Características do Apache Spark

- **Processamento In-Memory**: ao contrário do Hadoop, que grava dados no disco entre as etapas do processamento, o Spark realiza processamento **em memória**, o que acelera significativamente a execução de tarefas.
- **Suporte a Diversos Tipos de Dados**: eficaz no processamento de dados em diferentes formatos, como **parquet, avro, orc, json, csv**, entre outros.
- **Pipelines de Dados Complexas**: Spark oferece **APIs** para construir pipelines de dados complexos, permitindo realizar tarefas sequenciais de transformação e análise de dados.
- **DataFrames e Spark SQL**: Spark utiliza **DataFrames** como principal estrutura de dados, organizados em formato tabular (linhas e colunas).
  - Permite operações de alto nível (`select`, `filter`, `groupBy`).
  - Integra com **Spark SQL** para consultas declarativas.
  - Usa o **Catalyst Optimizer** para otimização automática.
- **Machine Learning Integrado**: possui a biblioteca **MLlib** integrada, facilitando a implementação de algoritmos de aprendizado de máquina em grandes conjuntos de dados.
- **Streaming**: **Spark Streaming** permite processamento em tempo real, útil para lidar com a velocidade dos dados.

#### 3.5 Principais Tecnologias de Big Data (Panorama do Ecossistema)

| **Categoria**                 | **Tecnologias**                                                    |
| ------------------------------ | ------------------------------------------------------------------- |
| Processamento                  | Apache Spark, Hadoop MapReduce, Apache Flink, Apache Storm, Apache Drill, Apache Tez |
| Armazenamento Distribuído      | HDFS, Amazon S3, Azure Data Lake Storage, Google Cloud Storage, Ceph |
| Bancos de Dados / Data Warehouse | Apache HBase, Apache Hive, Apache Kudu, Cassandra, Apache Phoenix, Presto |
| Ingestão de Dados              | Apache Kafka, Apache NiFi, Logstash, Beats                          |
| Orquestração / Workflow        | Apache Airflow, Apache Oozie, Luigi                                  |
| Streaming / Tempo Real         | Apache Kafka, Apache Flink, Apache Storm, ksqlDB                     |
| Linguagens                     | Scala, Python, R, SQL                                                |
| Machine Learning               | Spark MLlib, TensorFlow, H2O.ai, Mahout, MLflow                      |
| Governança / Catálogo de Dados | Apache Atlas, Apache Ranger, Glue Data Catalog, Apache Hive Metastore |
| Mensageria                     | Apache Kafka, RabbitMQ, Apache ActiveMQ                              |
| Busca / Indexação              | Elasticsearch, Apache Solr, OpenSearch                                |
| Visualização / BI              | Apache Superset, Grafana, Kibana, Tableau                             |
| Cloud Platforms                | AWS, Microsoft Azure, Google Cloud                                    |

---

### 4. ARQUITETURAS DE BIG DATA

#### 4.1 A Jornada do Data Warehouse ao Data Lakehouse

- **Data Warehouse**: dados estruturados → ETL → Data Warehouses → BI e Reports.
- **Data Lake**: dados estruturados, semiestruturados e não estruturados → Data Lake → ETL → Data Warehouses → BI, Reports, Data Science e Machine Learning.
- **Data Lakehouse**: unifica os dois modelos anteriores. Dados estruturados, semiestruturados e não estruturados alimentam um **Data Lake** com uma camada de **Metadata and Governance Layer**, servindo diretamente a BI, Reports, Data Science e Machine Learning, sem duplicação em Data Warehouses separados.

#### 4.2 Arquitetura Medalhão (Medallion Architecture)

- Estrutura em três camadas dentro do Lakehouse, alimentadas por fontes como **Kafka, Kinesis, arquivos CSV/JSON/TXT, Data Lake, Spark e provedores cloud (AWS/Azure)**:

| **Camada**  | **Função**                                        |
| ----------- | -------------------------------------------------- |
| **Bronze**  | Raw ingestion and history (ingestão bruta e histórico) |
| **Silver**  | Filtered, cleaned, augmented (dados filtrados, limpos e enriquecidos) |
| **Gold**    | Business-level aggregates (agregações no nível de negócio) |

- Toda a arquitetura é sustentada por uma camada transversal de **Data Quality & Governance**.
- As camadas alimentam consumidores finais: **Streaming Analytics, BI & Reporting, Data Science & ML, Data Sharing**.

#### 4.3 Estratégia de Compressão de Dados

- Conversão de formatos "crus" (ex.: **CSV**) para formatos colunares otimizados: **Parquet, Apache ORC, Avro**.
- Ganhos reportados:
  - Até **87%** de redução de tamanho.
  - Até **34x** mais rápido para carregar os dados.
  - Até **99%** de redução de custos.

#### 4.4 Estratégias de Particionamento dos Dados

- Organização de "Dados brutos" em partições hierárquicas ao longo do **tempo de consulta**, por exemplo: `ano=2022`, `ano=2023`, `ano=2024` → subparticionado por `semestre=1`, `semestre=2`, `semestre=3`, `semestre=4`.
- Objetivo: acelerar consultas que filtram por período, evitando a leitura de dados irrelevantes (*partition pruning*).

---

### 5. O CICLO DE VIDA DE MODELOS E DEPLOYMENT

#### 5.1 Revisão do Processo de Mineração de Dados (CRISP-DM)

- Fluxo cíclico: **Entendimento do negócio** ↔ **Entendimento dos dados** → **Preparação dos dados** → **Modelagem** → **Avaliação** → **Deployment**, tudo girando em torno da base central de **Dados**.

#### 5.2 O Modelo em Desenvolvimento vs. em Produção

- **Modelo em desenvolvimento**: análogo a um avião ainda no pátio/aeroporto — em preparação, ainda não operando de fato.
- **Modelo em produção**: análogo a um avião em voo — já entregando valor real, servindo usuários/sistemas continuamente.

#### 5.3 O Ciclo de Vida de Modelos

- **Coleta e preparação de dados.**
- **Treinamento e validação** do modelo.
- **Deploy** do modelo em produção.
- **Monitoramento** contínuo.
- **Atualização e re-treinamento** do modelo.
- **Aposentadoria** de modelos desatualizados.

#### 5.4 Desafios Comuns no Deployment de Modelos

- **Data drift**: mudanças nos dados afetam a performance.
- **Diferença** entre ambientes de **desenvolvimento** e **produção**.
- **Monitoramento** de performance após o deployment.
- Gerenciamento de **múltiplas versões** de modelos.
- **Implementação** e **funcionamento** adequado de processos de **MLOps**.

---

### 6. MLOPS: AUTOMAÇÃO E ESCALABILIDADE

#### 6.1 Conceito

- **MLOps** combina práticas de **DevOps** com **Machine Learning** para otimizar o desenvolvimento e deployment de modelos.
- **Automatiza o ciclo de vida** completo dos modelos: desde o treinamento, validação até o deployment e monitoramento.
- Utiliza **ferramentas especializadas** para garantir eficiência, reprodutibilidade e rastreabilidade dos experimentos.
- Facilita a **colaboração entre cientistas de dados e engenheiros**, acelerando a entrega de soluções escaláveis.

#### 6.2 Papel da Equipe no Workflow de ML

- **Papéis envolvidos**:
  - **Data Governance Officer**: supervisiona todo o processo.
  - **Data Engineer** e **Data Scientist**: atuam principalmente nas etapas iniciais (preparação e modelagem).
  - **ML Engineer**: foco em treinamento, validação e deployment.
  - **Business Stakeholder**: acompanha deployment e monitoramento (etapas finais, orientadas a valor de negócio).

- **Workflow de ML (etapas numeradas 0 a 6)**:

```
0. Data Preparation
1. Exploratory Data Analysis
2. Feature Engineering
3. Model Training
4. Model Validation
5. Deployment
6. Monitoring  ──► (retorna a 0, ciclo contínuo)
```

#### 6.3 Frameworks de MLOps

- **Weights & Biases**
- **Neptune.ai**
- **Seldon**
- **Kubeflow**
- **Polyaxon**
- **MLflow** (foco do módulo)

---

### 7. MLFLOW

#### 7.1 Visão Geral

- Ferramenta *open source* para gerenciar o ciclo de vida completo de Machine Learning.
- **Principais componentes**:
  - **MLflow Tracking**: gerencia experimentos, rastreando métricas e resultados.
  - **MLflow Projects**: padroniza o código para reprodutibilidade.
  - **MLflow Models**: formato unificado para salvar e implantar modelos.
  - **MLflow Registry**: controle de versões e gerenciamento de modelos.
- **Documentação oficial**: https://mlflow.org/docs

#### 7.2 Integração com Diversas Bibliotecas

- O MLflow se integra com um vasto ecossistema, incluindo: **scikit-learn, XGBoost, Apache Spark, LightGBM, CatBoost, statsmodels, Prophet, OpenAI, Keras, LlamaIndex, TensorFlow, spaCy, PyTorch, LangChain, Hugging Face, SBERT.net, fast.ai**.

#### 7.3 Componentes Principais (Arquitetura)

- Fontes de entrada: **Notebooks** (Python, Java, ou REST API), **Local apps**, **Cloud jobs**.
- Núcleo: **MLflow Tracking Server**, que registra **Parameters, Metrics, Artifacts, Metadata, Models**.
- Saídas: **UI**, **API**, **Spark data source**.
- Fonte: https://www.cloudskillsboost.google

#### 7.4 MLflow Tracking

- Cada **experimento (MLflow experiment)** contém múltiplas **runs (MLflow run)**.
- Cada run registra: **Model(s), Metadata, Signature, Dependencies, Examples, metrics, params, tags**.
- A interface web do MLflow (versão 2.9) permite listar e comparar *runs* de diferentes experimentos (ex.: "Google Agent", "Cooking Assistant", "Legal RAG", "Default"), exibindo colunas como Created, Duration, Experiment Name, User, Source, Models.
- Fonte: https://mlflow.org/docs

#### 7.5 Versionamento de Modelos no MLflow

- Modelos (Modelo 1, Modelo 2, Modelo 3) possuem **versões** que transitam entre estágios (*stages*):

```
Modelo → Estágio: Staging → Estágio: Produção → Estágio: Arquivado
```

- Exemplo prático: um modelo pode ter a **Versão 18, 2, 3** em Staging; a **Versão 17 e 2** em Produção; e as **Versões 16, 1, 1** Arquivadas — permitindo rastrear e promover/retirar versões de forma controlada.

#### 7.6 Benefícios do MLflow

- **Rastreabilidade** e **controle** de versões automatizados.
- Integração com múltiplos **frameworks** e **linguagens**.
- **Simplificação do deploy** e monitoramento de modelos em produção.
- Facilitação do re-treinamento e **atualização contínua**.

#### 7.7 Arquiteturas Comuns de Setup do MLflow

1. **Localhost (default)**: código ML → `mlflow Tracking APIs` → grava Artifacts e Metadata em **Local File**.
2. **Localhost w/ various data stores**: código ML → `mlflow Tracking APIs` → Artifacts em **Local File** e Metadata em **Database**.
3. **Remote Tracking w/ Tracking Server**: código ML (local) → `mlflow Tracking APIs` → **mlflow Tracking Server** remoto, compartilhado por um **Team**, que grava Artifacts em **Cloud Storage** e Metadata em **Database**.

#### 7.8 Deployment de Modelos com MLflow

- Fluxo entre **Dev Environment** e **Production Environment**:

```
Dev Environment:
  Training Model → mlflow Tracking (Model + Environment) → mlflow Model Registry

Deployment (dois comandos principais):
  $ mlflow deployments   → gera um Docker Container → destinos: Databricks Model Serving,
                                                         Amazon SageMaker, Kubernetes Cluster,
                                                         Azure Machine Learning
  $ mlflow models serve  → Local Inference: Flask (Local Server) / Batch Prediction
```

#### 7.9 Estrutura de uma API REST (conceito de suporte ao serving)

- **Client** → requisição via **HTTP** (métodos: `GET`, `POST`, `DELETE`, `PUT`) → **URL** (ex.: `/surveys`, `/surveys/123`, `/surveys/123/resp...`) → **Server**.
- Resposta trafegada em formato **JSON**, por exemplo:

```json
{
  survey_id: 123,
  score: 9,
  message: "amaze...",
  response_id: 4
}
```

- Fonte: https://mannhowie.com/rest-api

#### 7.10 Servindo Modelos para o Mundo

- Arquitetura de serving em produção:

```
Usuário → (requisição/resposta) → Domínio (ex.: www.minha-aplicação.com/consumir/{modelo_id})
       → Balanceamento de carga e Proxy Reverso (NGINX)
       → distribui para múltiplas APIs de modelo:
            http://{localhost:5200}/invocations  → API + mlflow → Modelo 1  → {"predict":[10]}
            http://{localhost:5300}/invocations  → API + mlflow → Modelo 2  → {"predict":[23]}
```

- Esse padrão permite **múltiplas versões/modelos servidos simultaneamente**, com balanceamento de carga e roteamento por proxy reverso.

---

### 8. DATABRICKS

#### 8.1 Relação MLflow ↔ Databricks

- O **Databricks** é a plataforma unificada de dados e IA (Lakehouse) onde o **MLflow** se integra nativamente para rastreamento de experimentos e deployment de modelos (ex.: **Databricks Model Serving**, um dos destinos de `mlflow deployments`).

#### 8.2 Tutorial de Cadastro no Databricks (Free Edition)

Passo a passo para criar uma conta gratuita e utilizá-la nas aulas práticas:

1. Acessar o site: https://www.databricks.com/learn/free-edition
2. Clicar em **"Sign up for Free Edition"**.
3. Escolher a forma de cadastro: **Continue with Google**, **Continue with Microsoft** ou por **e-mail**.
4. Preencher o formulário **"Set up your account"**: nome da conta e localização (ex.: Brazil) → clicar em **Continue**.
5. Resolver o desafio de verificação de conta ("Proteger a sua conta").
6. Responder ao questionário **"Tell us about yourself"**:
   - Selecionar a opção **"Learn data and AI"** (alinhada ao objetivo do curso).
   - Selecionar até 3 tópicos de interesse (ex.: **Data Science**).
   - Clicar em **Continue**.
7. A conta é criada e o usuário é direcionado à tela **"Welcome to Databricks"**, com acesso a Workspace, Compute, Jobs & Pipelines, SQL Editor, Catalog, entre outros recursos, já disponível para uso em aula.

---

## 🐍 Implementação Python (Script da Aula Prática — Databricks + MLflow)

O material complementar `aula-1_MCzip` traz um notebook (`Script - Aula Deployment De Modelos.ipynb`) executado no Databricks Community Edition, usando os datasets `tempodist.csv` e `estudante_escola.csv` carregados via Unity Catalog. Trechos principais:

### Importações e leitura de dados via Unity Catalog

```python
import pandas as pd
import mlflow
import statsmodels.api as sm
import json
import requests
import matplotlib.pyplot as plt
from mlflow.models.signature import infer_signature

# Lendo a tabela do catálogo padrão do Databricks (Spark → Pandas)
df_tempodist = spark.table("tempodist").toPandas()
```

### Rastreamento de um modelo (regressão OLS) com MLflow Tracking

```python
mlflow.set_experiment(experiment_name="/Shared/Regressão Linear Simples - tempodist")

with mlflow.start_run(run_name="Modelo Final") as run_final:
    mlflow.set_tag("Fase", "Final")
    mlflow.set_tag("Algoritmo", "OLS")

    mlflow.log_input(mlflow.data.from_pandas(df_tempodist), context="training")
    mlflow.log_param("Fórmula", "tempo ~ distancia")

    modelo_final = sm.OLS.from_formula(formula="tempo ~ distancia", data=df_tempodist).fit()

    mlflow.log_metric("Estatística F", modelo_final.fvalue)
    mlflow.log_metric("R2", modelo_final.rsquared)

    assinatura = infer_signature(df_tempodist[["distancia"]], modelo_final.fittedvalues)
    mlflow.statsmodels.log_model(modelo_final, "modelo-final", signature=assinatura)
```

### Carregando modelos por estágio (Model Registry / aliases)

```python
# Carrega o modelo pelo alias de estágio (staging ou production)
modelo_em_producao = mlflow.statsmodels.load_model(
    "models:/workspace.default.tempo-distancia@production"
)
previsao = modelo_em_producao.predict(pd.DataFrame({"distancia": [20]}))
```

### Modelos Mistos (HLM2) com Autolog do MLflow

```python
mlflow.statsmodels.autolog(log_models=False, log_datasets=True, disable=False)

with mlflow.start_run(run_name="Modelo com Interceptos e Inclinações Aleatórios HLM2"):
    modelo_hlm2 = sm.MixedLM.from_formula(
        formula="desempenho ~ horas",
        groups="escola",
        re_formula="horas",
        data=df_estudante_escola,
    ).fit()
```

### Consumo de API externa (GET) e simulação de serving via MLflow

```python
# Consumindo uma API externa
resposta = requests.get("https://dogapi.dog/api/v2/facts",
                         headers={"Content-Type": "application/json"}).json()

# Simulando o payload que seria enviado a um endpoint MLflow (POST)
df_novos_dados = pd.DataFrame({"distancia": [20]})
dados_transformados = json.dumps({"dataframe_records": df_novos_dados.to_dict(orient="records")})
```

### Observabilidade com MLflow Tracing

```python
import time

@mlflow.trace(name="Inferencia_Componente_Fixo")
def calcular_previsao(df_input, modelo):
    time.sleep(0.2)
    return modelo.predict(df_input)
```

### Comandos de Deployment (linha de comando)

```bash
# Empacota o modelo em um container Docker e envia para destinos
# como Databricks Model Serving, Amazon SageMaker, Kubernetes ou Azure ML
mlflow deployments

# Serve o modelo localmente (servidor Flask) para inferência local
# ou predição em lote (batch prediction)
mlflow models serve -m models:/tempo-distancia@production -p 5200 --no-conda
```

---

## 📊 Exemplos Práticos do Curso

### Exemplo 1: O Modelo em Desenvolvimento vs. Produção (Analogia)

- **Contexto**: analogia visual com aviões — um modelo "em desenvolvimento" é como um avião ainda no pátio do aeroporto, e um modelo "em produção" é como um avião já em voo, entregando valor real.
- **Objetivo didático**: ilustrar a diferença entre construir um modelo e efetivamente colocá-lo para funcionar (deployment).

### Exemplo 2: Workflow de ML com Papéis da Equipe

- **Contexto**: diagrama com as etapas numeradas de 0 a 6 (Data Preparation, Exploratory Data Analysis, Feature Engineering, Model Training, Model Validation, Deployment, Monitoring), sobrepostas pelas responsabilidades de **Data Governance Officer, Data Engineer, Data Scientist, ML Engineer e Business Stakeholder**.
- **Resultado**: evidencia que o deployment de modelos não é tarefa isolada do cientista de dados, mas um processo colaborativo entre múltiplos papéis.

### Exemplo 3: Versionamento de Modelos no MLflow

- **Contexto**: cenário com 3 modelos e múltiplas versões distribuídas entre os estágios **Staging, Produção e Arquivado** (ex.: Versão 18 em Staging, Versão 17 em Produção, Versão 16 Arquivada).
- **Resultado**: demonstra como o **MLflow Registry** permite promover e revogar versões de modelos de forma controlada, sem perder o histórico.

### Exemplo 4: Servindo Múltiplos Modelos com Balanceamento de Carga

- **Contexto**: arquitetura com um usuário fazendo requisição a um domínio, que passa por um **proxy reverso (NGINX)** e distribui o tráfego entre duas APIs (Modelo 1 e Modelo 2), cada uma servida via MLflow, retornando predições em JSON (`{"predict":[10]}`, `{"predict":[23]}`).
- **Resultado**: ilustra na prática como múltiplos modelos/versões podem coexistir em produção com roteamento e balanceamento de carga.

### Exemplo 5: Arquitetura Medalhão com Fontes de Streaming

- **Contexto**: pipeline alimentado por Kafka, Kinesis, arquivos CSV/JSON/TXT, Data Lake e Spark, passando pelas camadas **Bronze → Silver → Gold**, sob governança de dados.
- **Resultado**: mostra a jornada do dado bruto até agregações de nível de negócio, prontas para consumo por Streaming Analytics, BI, Data Science/ML e Data Sharing.

### Exemplo 6: Tutorial Prático de Cadastro no Databricks

- **Contexto**: material complementar pré-aula guiando o cadastro na **Databricks Free Edition**, preparando o ambiente que seria usado para a prática de MLflow em aula ("Mãos à obra": MLflow ↔ Databricks).
- **Resultado**: ambiente Databricks disponível com Workspace, Compute, Jobs & Pipelines, SQL Editor, Catalog, etc.

### Exemplo 7: Prática Completa no Notebook (Databricks + MLflow)

- **Contexto**: script da aula (`aula-1_MCzip`) usando os datasets `tempodist.csv` e `estudante_escola.csv`, carregados via Unity Catalog (`spark.table(...).toPandas()`).
- **Passos realizados**: treino de um "Modelo Nulo" e um "Modelo Final" de regressão OLS (`tempo ~ distancia`) com `statsmodels`, rastreados via `mlflow.start_run` (tags, `log_param`, `log_metric`, `log_figure`, `log_text`, `infer_signature`, `log_model`); carregamento do modelo por alias de estágio (`models:/tempo-distancia@staging` / `@production`); busca programática de runs com `mlflow.search_runs`; treino de modelos mistos HLM2 (`sm.MixedLM`) para o dataset de desempenho de estudantes, com **Autolog** do MLflow; consumo de uma API externa (dogapi.dog) para ilustrar `GET`/JSON; simulação de um payload de requisição `POST` para um endpoint MLflow; e uso do decorador `@mlflow.trace` para observabilidade (MLflow Tracing) de um pipeline de inferência.
- **Resultado**: percurso completo do ciclo "treinar → rastrear → versionar/promover → servir → observar" aplicado tanto a um modelo de regressão simples quanto a um modelo hierárquico (HLM2).

---

## 💡 Conceitos-Chave para Memorizar

### 🔑 Os 5V's do Big Data

| **V**          | **Significado**                                             |
| --------------- | ------------------------------------------------------------- |
| **Volume**      | Quantidade massiva de dados                                   |
| **Velocidade**  | Rapidez de geração/processamento/disponibilização             |
| **Variedade**   | Diversidade de tipos de dados                                 |
| **Veracidade**  | Confiabilidade e qualidade dos dados                           |
| **Valor**       | Capacidade de gerar insights úteis                            |

### 🔑 Hadoop vs. Apache Spark

| **Aspecto**              | **Hadoop MapReduce**            | **Apache Spark**                          |
| -------------------------- | -------------------------------- | ------------------------------------------ |
| **Processamento**          | Em disco (mais lento)            | In-memory (mais rápido)                    |
| **Armazenamento**          | HDFS (distribuído)               | Integra com diversos storages              |
| **Estrutura de dados**     | Blocos/arquivos                  | RDD e DataFrame                            |
| **Modelo de execução**     | Map → Shuffle → Reduce           | DAG (Directed Acyclic Graph)               |
| **Machine Learning**       | Não nativo                       | MLlib integrado                            |
| **Streaming**              | Não nativo                       | Spark Streaming                            |
| **Escalabilidade**         | Horizontal                       | Horizontal                                 |

### 🔑 Evolução das Arquiteturas de Dados

| **Arquitetura**    | **Tipo de Dados**                              | **Consumidores**                          |
| -------------------- | ------------------------------------------------ | ------------------------------------------- |
| **Data Warehouse**  | Estruturados                                     | BI, Reports                                |
| **Data Lake**       | Estruturados, semiestruturados, não estruturados | BI, Reports, Data Science, Machine Learning |
| **Data Lakehouse**  | Estruturados, semiestruturados, não estruturados + camada de Metadata/Governança | BI, Reports, Data Science, Machine Learning (unificado) |

### 🔑 Arquitetura Medalhão

```
BRONZE (raw ingestion and history)
   ↓
SILVER (filtered, cleaned, augmented)
   ↓
GOLD (business-level aggregates)

→ sustentada por Data Quality & Governance
→ alimenta: Streaming Analytics | BI & Reporting | Data Science & ML | Data Sharing
```

### 🔑 Ciclo de Vida de um Modelo de ML

```
Coleta e preparação de dados
   → Treinamento e validação
   → Deploy em produção
   → Monitoramento contínuo
   → Atualização e re-treinamento
   → Aposentadoria de modelos desatualizados
```

### 🔑 Componentes do MLflow

| **Componente**        | **Função**                                             |
| ------------------------ | --------------------------------------------------------- |
| **MLflow Tracking**    | Gerencia experimentos, rastreando métricas e resultados     |
| **MLflow Projects**    | Padroniza o código para reprodutibilidade                  |
| **MLflow Models**      | Formato unificado para salvar e implantar modelos          |
| **MLflow Registry**    | Controle de versões e gerenciamento de modelos              |

### 🔑 Comandos MLflow Essenciais

```
mlflow deployments    → empacota o modelo em Docker e envia para
                         Databricks Model Serving, SageMaker,
                         Kubernetes Cluster ou Azure ML
mlflow models serve   → serve o modelo localmente
                         (Flask - Local Server / Batch Prediction)
```

---

## ⚠️ Erros Comuns a Evitar

1. **Confundir "modelo treinado" com "modelo em produção"**: um modelo só entrega valor real após o deployment (analogia do avião em voo vs. no pátio).
2. **Ignorar o data drift**: mudanças na distribuição dos dados ao longo do tempo degradam a performance do modelo em produção sem que ninguém perceba.
3. **Não versionar modelos**: sem controle de versões (ex.: MLflow Registry), fica impossível saber qual modelo está em produção ou reverter para uma versão anterior.
4. **Desconsiderar a diferença entre ambientes de desenvolvimento e produção**: o que funciona no notebook local pode falhar no ambiente de produção (dependências, dados, infraestrutura).
5. **Escolher Hadoop quando o caso de uso pede Spark (ou vice-versa)**: Hadoop é mais adequado a processamento em lote tolerante a I/O em disco; Spark é preferível quando velocidade e processamento in-memory são críticos.
6. **Armazenar dados em formatos não otimizados (ex.: apenas CSV) em grande escala**: perde-se até 87% de redução de tamanho e até 34x de velocidade de carregamento disponíveis com Parquet/ORC/Avro.
7. **Não particionar dados de grandes volumes**: consultas ficam lentas por escanear dados irrelevantes; particionar por tempo (ano/semestre) acelera drasticamente.
8. **Negligenciar o monitoramento pós-deployment**: sem monitoramento contínuo, problemas de performance e drift só são percebidos quando já causaram impacto no negócio.
9. **Tratar MLOps como tarefa exclusiva do Data Scientist**: o workflow de ML exige colaboração entre Data Governance Officer, Data Engineer, ML Engineer e Business Stakeholder.
10. **Servir um único modelo sem balanceamento de carga/versionamento**: dificulta testes A/B, rollback e escalabilidade em produção.

---

## 📚 Materiais de Apoio

### PDFs de Slides (SL)

- **Big Data e Deployment de Modelos I** (24/04/2026, 23 páginas): Ciclo de vida de modelos, desafios de deployment, MLOps, MLflow (componentes, tracking, versionamento, deployment), estrutura de API REST, serving de modelos.
- **Big Data e Deployment de Modelos II** (28/04/2026, 32 páginas): O que é Big Data, escala dos dados, os 5V's, Hadoop MapReduce e Apache Spark, principais tecnologias de Big Data, arquiteturas (Data Warehouse/Lake/Lakehouse), Arquitetura Medalhão, compressão e particionamento de dados.

### Material Complementar (MC)

- **Tutorial Cadastro Databricks** (4 páginas): passo a passo para criação de conta gratuita na Databricks Free Edition, usada na prática de "Mãos à obra" (MLflow ↔ Databricks).
- **aula-1_MCzip**: contém o notebook `Script - Aula Deployment De Modelos.ipynb` e os datasets `tempodist.csv` e `estudante_escola.csv`, usados na prática de regressão OLS/HLM2 com MLflow (ver seção de Implementação Python e Exemplo 7).
- **aula-2_MCzip**: arquivo não pôde ser aberto (apenas um ponteiro Git LFS não baixado); conteúdo não explorado neste resumo.

### Ferramenta Central

- **MLflow**: https://mlflow.org/docs

---

## 📖 Referências Recomendadas

### Livros

1. **CHAMBERS, B.; ZAHARIA, M.** "Spark: The Definitive Guide." O'Reilly Media, Inc., 2018.
2. **WHITE, T.** "Hadoop: The Definitive Guide." O'Reilly Media, Inc., 2015.
3. **TREVEIL, M. et al.** "Introducing MLOps." O'Reilly Media, Inc., 2020.
4. **DATABRICKS.** "The Big Book of MLOps" (Databricks, v6, 2022).

### Artigos

- **Armbrust, M.; Xin, R. S.; Lian, C.; Huai, Y.; Liu, D.; Bradley, J. K.; Meng, X.; Kaftan, T.; Franklin, M. J.; Ghodsi, A.; et al. (2015).** "Spark SQL: Relational data processing in Spark." In *Proceedings of the 2015 ACM SIGMOD International Conference on Management of Data*, p. 1383–1394.

### Documentação Oficial

- **Apache Spark**: https://spark.apache.org/documentation.html
- **Apache Hadoop 3.2.2**: https://hadoop.apache.org/docs/stable/
- **MLflow**: https://mlflow.org
- **Databricks**: https://www.databricks.com

### Recursos Online

- **Databricks Free Edition (cadastro)**: https://www.databricks.com/learn/free-edition
- **Estrutura de API REST**: https://mannhowie.com/rest-api
- **Estatísticas "Every Minute of the Day"**: https://www.domo.com/data-never-sleeps
- **Diagrama de componentes MLflow**: https://www.cloudskillsboost.google

---

## ✅ Checklist de Estudo

### Conceitos Teóricos

- [ ] Definir Big Data e entender por que ferramentas tradicionais não são suficientes
- [ ] Compreender a escala de dados (exabyte, zettabyte) e o crescimento exponencial da Global Datasphere
- [ ] Relacionar o boom de IA generativa com a explosão de dados sintéticos e não estruturados
- [ ] Memorizar e explicar cada um dos 5V's do Big Data

### Frameworks de Processamento

- [ ] Diferenciar Hadoop MapReduce de Apache Spark
- [ ] Entender o processo MapReduce (Splitting, Mapping, Shuffling, Reducing)
- [ ] Compreender a arquitetura do Spark (Driver Program, SparkContext, Cluster Manager, Nodes/Executors)
- [ ] Explicar o conceito de DAG (Directed Acyclic Graph)
- [ ] Explicar o conceito de RDD (Resilient Distributed Dataset) e suas propriedades
- [ ] Reconhecer DataFrames, Spark SQL e o Catalyst Optimizer
- [ ] Reconhecer a MLlib e o Spark Streaming

### Arquiteturas de Dados

- [ ] Diferenciar Data Warehouse, Data Lake e Data Lakehouse
- [ ] Explicar a Arquitetura Medalhão (Bronze, Silver, Gold)
- [ ] Entender os benefícios de formatos colunares (Parquet, ORC, Avro) frente ao CSV
- [ ] Compreender estratégias de particionamento de dados por tempo

### Deployment e MLOps

- [ ] Diferenciar modelo em desenvolvimento vs. modelo em produção
- [ ] Listar as etapas do ciclo de vida de um modelo de ML
- [ ] Identificar os desafios comuns de deployment (data drift, diferença dev/prod, versionamento)
- [ ] Explicar o conceito de MLOps e sua relação com DevOps
- [ ] Descrever o workflow de ML (0 a 6) e os papéis da equipe envolvida
- [ ] Conhecer frameworks de MLOps (Weights & Biases, Neptune.ai, Seldon, Kubeflow, Polyaxon, MLflow)

### MLflow

- [ ] Descrever os quatro componentes do MLflow (Tracking, Projects, Models, Registry)
- [ ] Explicar o funcionamento do MLflow Tracking (experiments, runs, metrics, params, artifacts)
- [ ] Entender o versionamento de modelos (Staging, Produção, Arquivado)
- [ ] Conhecer as três arquiteturas comuns de setup do MLflow (localhost, localhost com data stores, tracking server remoto)
- [ ] Diferenciar `mlflow deployments` de `mlflow models serve`
- [ ] Entender a estrutura de uma API REST (client, HTTP, URL, server, JSON)
- [ ] Compreender o serving de múltiplos modelos com balanceamento de carga/proxy reverso

### Prática

- [ ] Criar conta gratuita no Databricks (Free Edition)
- [ ] Explorar o Workspace do Databricks (Compute, Jobs & Pipelines, SQL Editor, Catalog)
- [ ] Reproduzir um fluxo básico de tracking de experimento com MLflow
- [ ] Simular deployment local de um modelo com `mlflow models serve`

---

**📌 Nota Final:** Big Data e Deployment de Modelos representam o elo entre a ciência de dados exploratória e o valor de negócio real. Dominar os frameworks de processamento distribuído (Hadoop, Spark), as arquiteturas modernas de dados (Lakehouse, Medalhão) e as práticas de MLOps com MLflow é essencial para qualquer cientista de dados que deseja levar seus modelos além do notebook e colocá-los, de fato, "em voo".

---

_Resumo elaborado para o MBA em Data Science & Analytics da USP/ESALQ_  
_Módulo 22 - Big Data e Deployment de Modelos_
