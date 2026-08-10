# ☁️ Resumo: Cloud Computing

**MBA Data Science e Analytics - USP/ESALQ**

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos de **Cloud Computing** e suas aplicações em Data Science e Analytics. Dominar os principais provedores de nuvem (AWS, Azure, GCP), modelos de serviço (IaaS, PaaS, SaaS), arquitetura de soluções em nuvem, containers (Docker/Kubernetes), serverless computing, armazenamento e processamento distribuído. Aplicar serviços de ML/AI em nuvem para construir pipelines escaláveis e econômicos de Data Science.

---

## 📚 Conteúdo Principal

### 1. **Fundamentos de Cloud Computing**

#### 1.1 Definição e Características

- **Cloud Computing:** entrega de recursos de computação (servidores, armazenamento, bancos de dados, redes, software) via internet com pagamento sob demanda
- **5 Características Essenciais (NIST):**
  1. **On-demand self-service:** provisionar recursos automaticamente sem intervenção humana
  2. **Broad network access:** acesso via rede de qualquer lugar
  3. **Resource pooling:** recursos compartilhados entre múltiplos clientes (multi-tenancy)
  4. **Rapid elasticity:** escala automática (up/down) conforme demanda
  5. **Measured service:** pagamento por uso (pay-as-you-go), monitoramento transparente

#### 1.2 Modelos de Serviço

- **IaaS (Infrastructure as a Service):**
  - Fornece: servidores virtuais, armazenamento, redes
  - Você gerencia: SO, middleware, runtime, dados, aplicações
  - **Exemplos:** AWS EC2, Azure Virtual Machines, Google Compute Engine
  - **Quando usar:** máximo controle e flexibilidade
- **PaaS (Platform as a Service):**
  - Fornece: IaaS + SO + runtime + middleware
  - Você gerencia: aplicações e dados
  - **Exemplos:** AWS Elastic Beanstalk, Azure App Service, Google App Engine, Heroku
  - **Quando usar:** foco em desenvolvimento, não em infraestrutura
- **SaaS (Software as a Service):**
  - Fornece: aplicação completa pronta para uso
  - Você gerencia: configurações e dados
  - **Exemplos:** Salesforce, Office 365, Google Workspace, Tableau Online
  - **Quando usar:** solução end-to-end sem manutenção

#### 1.3 Modelos de Deployment

- **Public Cloud:** infraestrutura compartilhada, disponível publicamente
  - **Pros:** baixo custo, escalabilidade infinita, sem manutenção
  - **Cons:** menos controle, preocupações de segurança
- **Private Cloud:** infraestrutura dedicada a uma organização
  - **Pros:** controle total, segurança customizada, compliance
  - **Cons:** alto custo, manutenção interna
- **Hybrid Cloud:** combinação de public e private
  - **Pros:** flexibilidade, dados sensíveis no private, workloads no public
  - **Exemplo:** dados financeiros on-premise, análises na AWS
- **Multi-Cloud:** uso de múltiplos provedores públicos (AWS + Azure + GCP)
  - **Pros:** evita vendor lock-in, aproveita melhores serviços de cada
  - **Cons:** complexidade de gerenciamento

#### 1.4 Vantagens vs. On-Premise

**Vantagens:**

- **Capex → Opex:** sem investimento inicial em hardware
- **Elasticidade:** escala conforme demanda (não fica ocioso ou sobrecarregado)
- **Velocidade:** provisionar recurso em minutos (não semanas)
- **Global reach:** data centers em várias regiões do mundo
- **Foco no negócio:** provedor cuida de infraestrutura
- **Disaster recovery:** backups automáticos, alta disponibilidade

**Desvantagens:**

- **Custos imprevisíveis:** se mal gerenciado, pode ser caro
- **Dependência de internet:** sem conectividade = sem acesso
- **Vendor lock-in:** migrar entre provedores é complexo
- **Compliance:** dados em servidores de terceiros (questões legais/LGPD)

---

### 2. **Principais Provedores de Cloud**

#### 2.1 AWS (Amazon Web Services)

- **Quota de Mercado:** ~32% (líder global)
- **Fundação:** 2006 (pioneiro)
- **Regiões:** 30+ regiões, 90+ availability zones

**Serviços Principais:**

- **Compute:** EC2 (VMs), Lambda (serverless), ECS/EKS (containers)
- **Storage:** S3 (object storage), EBS (block storage), Glacier (archive)
- **Database:** RDS (relacional), DynamoDB (NoSQL), Redshift (data warehouse)
- **ML/AI:** SageMaker (ML platform), Rekognition (visão), Comprehend (NLP), Forecast
- **Analytics:** Athena (query S3), EMR (Hadoop/Spark), Kinesis (streaming)
- **Networking:** VPC, Route 53 (DNS), CloudFront (CDN)

**Pontos Fortes:**

- Maior ecossistema de serviços (200+)
- Maturidade e documentação extensa
- Marketplace rico

#### 2.2 Azure (Microsoft)

- **Quota de Mercado:** ~23%
- **Fundação:** 2010
- **Regiões:** 60+ regiões (maior presença geográfica)

**Serviços Principais:**

- **Compute:** Virtual Machines, Azure Functions (serverless), AKS (Kubernetes)
- **Storage:** Blob Storage, Azure Data Lake, Archive Storage
- **Database:** SQL Database, Cosmos DB (NoSQL multi-model), Synapse Analytics (DW)
- **ML/AI:** Azure ML, Cognitive Services (Vision, Speech, Language), OpenAI Service
- **Analytics:** Databricks, HDInsight (Hadoop), Stream Analytics
- **Integration:** forte integração com on-premise (Windows Server, Active Directory)

**Pontos Fortes:**

- Integração com ecossistema Microsoft (Office 365, Power BI, .NET)
- Hybrid cloud robusto (Azure Arc)
- Forte presença enterprise

#### 2.3 GCP (Google Cloud Platform)

- **Quota de Mercado:** ~10%
- **Fundação:** 2008
- **Regiões:** 35+ regiões

**Serviços Principais:**

- **Compute:** Compute Engine (VMs), Cloud Functions (serverless), GKE (Kubernetes - líder)
- **Storage:** Cloud Storage, Persistent Disk, Filestore
- **Database:** Cloud SQL, Firestore/Datastore (NoSQL), BigQuery (DW serverless)
- **ML/AI:** Vertex AI (ML platform), Vision AI, Natural Language AI, AutoML
- **Analytics:** BigQuery (análise de petabytes), Dataflow (Apache Beam), Pub/Sub (messaging)
- **Data Engineering:** Cloud Composer (Airflow), Dataproc (Spark)

**Pontos Fortes:**

- BigQuery (melhor data warehouse serverless)
- Kubernetes (GKE é o mais avançado)
- ML/AI (TensorFlow, TPUs)
- Rede global de alta performance

#### 2.4 Outros Provedores

- **IBM Cloud:** forte em enterprise, híbrido, Red Hat OpenShift
- **Oracle Cloud:** bancos de dados Oracle, aplicações empresariais
- **Alibaba Cloud:** líder na Ásia
- **Digital Ocean, Linode:** foco em desenvolvedores, preços simples

---

### 3. **Compute Services**

#### 3.1 Virtual Machines (IaaS)

- **Conceito:** servidor virtual com SO completo
- **AWS:** EC2 (Elastic Compute Cloud)
- **Azure:** Virtual Machines
- **GCP:** Compute Engine

**Características:**

- Escolha de CPU, RAM, storage, SO (Linux/Windows)
- Tipos de instâncias especializadas:
  - **General Purpose:** balanceado (t3, D-series, n1-standard)
  - **Compute Optimized:** CPU intensivo (c5, F-series, c2)
  - **Memory Optimized:** RAM intensivo (r5, E-series, m2)
  - **GPU Optimized:** deep learning (p3, NC-series, a2)
- **Pricing models:**
  - **On-demand:** paga por hora/segundo (flexível, mais caro)
  - **Reserved:** compromisso 1-3 anos (50-70% desconto)
  - **Spot/Preemptible:** leilão de capacidade ociosa (70-90% desconto, pode ser interrompido)

**Quando usar:**

- Migração lift-and-shift de on-premise
- Controle total sobre SO e stack
- Aplicações legadas que não suportam containers

#### 3.2 Containers

- **Conceito:** empacota aplicação + dependências em unidade portável
- **Docker:** padrão de facto para containers
- **Vantagens vs. VMs:**
  - Mais leve (compartilha kernel do SO)
  - Start rápido (segundos vs. minutos)
  - Portabilidade (mesmo container roda em qualquer lugar)
  - Eficiência de recursos (densidade alta)

**Container Orchestration (Kubernetes):**

- **Função:** gerencia deployment, scaling, networking de containers
- **AWS:** ECS (Elastic Container Service - proprietário), EKS (Elastic Kubernetes Service)
- **Azure:** AKS (Azure Kubernetes Service)
- **GCP:** GKE (Google Kubernetes Engine - mais avançado)

**Conceitos Kubernetes:**

- **Pod:** menor unidade, agrupa 1+ containers
- **Deployment:** define estado desejado (réplicas, versão)
- **Service:** expõe pods na rede (load balancing)
- **Ingress:** roteamento HTTP/HTTPS
- **Auto-scaling:** HPA (Horizontal Pod Autoscaler) ajusta réplicas

**Quando usar containers:**

- Microservices architecture
- CI/CD (deploy rápido e consistente)
- Aplicações cloud-native
- Desenvolvimento local idêntico a produção

#### 3.3 Serverless Computing

- **Conceito:** executa código sem gerenciar servidores (abstração completa de infraestrutura)
- **AWS Lambda, Azure Functions, Google Cloud Functions**

**Características:**

- **Event-driven:** código executado em resposta a eventos (HTTP request, upload no S3, mensagem em fila)
- **Auto-scaling:** de 0 a 1000s de invocações instantaneamente
- **Pricing:** paga por execução (número de invocações + tempo de execução)
- **Stateless:** cada invocação é independente
- **Timeout:** limite de execução (AWS: 15 min, Azure: 10 min, GCP: 9 min)

**Quando usar:**

- APIs leves (REST/GraphQL)
- Processamento assíncrono (processamento de imagens, ETL leve)
- Webhooks e integração de sistemas
- Backend para mobile/web apps
- Workloads intermitentes (não 24/7)

**Limitações:**

- **Cold start:** primeira invocação demora (1-3s)
- **Timeout:** não serve para jobs longos
- **Local state:** não persiste entre invocações

---

### 4. **Storage Services**

#### 4.1 Object Storage

- **AWS S3, Azure Blob Storage, Google Cloud Storage**
- **Conceito:** armazena arquivos como objetos (sem hierarquia de diretórios real)

**Características:**

- Capacidade ilimitada (petabytes)
- Alta durabilidade (99.999999999% - "11 nines")
- Acesso via HTTP/HTTPS (REST API)
- Versionamento de objetos
- Lifecycle policies (mover para storage class mais barato automaticamente)
- Replicação entre regiões

**Storage Classes (AWS S3):**

- **S3 Standard:** acesso frequente, baixa latência
- **S3 Intelligent-Tiering:** move automaticamente entre tiers
- **S3 Standard-IA (Infrequent Access):** acesso esporádico, 50% mais barato
- **S3 Glacier:** archive, retrieve em horas, 10x mais barato
- **S3 Glacier Deep Archive:** retrieve em 12h, mais barato (~$1/TB/mês)

**Quando usar:**

- Data lake (armazenar dados brutos: CSV, Parquet, JSON)
- Backup e archive
- Hosting de sites estáticos
- Armazenar outputs de modelos ML

#### 4.2 Block Storage

- **AWS EBS (Elastic Block Store), Azure Managed Disks, GCP Persistent Disk**
- **Conceito:** volumes de disco anexados a VMs (como HD/SSD)

**Características:**

- Baixa latência (milissegundos)
- Usado como disco de SO ou dados de VM
- Snapshots para backup
- Tipos: SSD (performance), HDD (throughput, mais barato)

**Quando usar:**

- Banco de dados em VM
- Sistema de arquivos de aplicação
- Workloads I/O intensivos

#### 4.3 File Storage

- **AWS EFS (Elastic File System), Azure Files, GCP Filestore**
- **Conceito:** sistema de arquivos compartilhado (NFS/SMB protocol)

**Características:**

- Múltiplas VMs/containers acessam simultaneamente
- Estrutura hierárquica de diretórios
- Ideal para compartilhamento de arquivos

**Quando usar:**

- Shared file system entre servidores
- Migração de aplicações que usam NFS
- Content management systems

---

### 5. **Database Services**

#### 5.1 Relational Databases (SQL)

- **AWS RDS (Relational Database Service):** PostgreSQL, MySQL, SQL Server, Oracle
- **Azure SQL Database:** SQL Server gerenciado
- **GCP Cloud SQL:** PostgreSQL, MySQL

**Características:**

- Banco gerenciado (backups, patches, scaling automático)
- Multi-AZ deployment (alta disponibilidade)
- Read replicas (escala leitura)
- Pay-per-hour ou provisioned capacity

**Quando usar:**

- Aplicações transacionais (OLTP)
- Dados estruturados com relacionamentos
- Necessidade de ACID (atomicidade, consistência, isolamento, durabilidade)

#### 5.2 NoSQL Databases

- **AWS DynamoDB:** key-value, document
- **Azure Cosmos DB:** multi-model (key-value, document, graph, column)
- **GCP Firestore/Datastore:** document database

**Características:**

- Schema-less (flexibilidade)
- Alta escalabilidade horizontal
- Baixa latência (milissegundos)
- Eventual consistency (trade-off CAP theorem)

**Quando usar:**

- Aplicações web/mobile de alta escala
- Session storage
- Real-time analytics
- IoT data

#### 5.3 Data Warehouses

- **AWS Redshift:** columnar storage, baseado em PostgreSQL
- **Azure Synapse Analytics:** integra SQL, Spark, Power BI
- **GCP BigQuery:** serverless, SQL-based, escala automática

**Características:**

- Otimizado para queries analíticas (OLAP)
- Armazena dados em colunas (compressão alta)
- Processamento paralelo massivo (MPP)
- Integração com BI tools

**BigQuery (destaque):**

- **Serverless:** sem gerenciar clusters
- **Escalabilidade:** query em petabytes em segundos
- **Pricing:** paga por dados processados ($5/TB)
- **ML integrado:** BigQuery ML (treinar modelos com SQL)

**Quando usar:**

- Business Intelligence (dashboards, relatórios)
- Análise de grandes volumes históricos
- Agregações complexas

---

### 6. **Machine Learning e AI em Cloud**

#### 6.1 ML Platforms

- **AWS SageMaker:**
  - End-to-end ML: data prep, training, deployment
  - Notebooks gerenciados (Jupyter)
  - Built-in algorithms (XGBoost, Linear Learner, etc.)
  - AutoML (SageMaker Autopilot)
  - Model hosting com auto-scaling
  - Feature Store, Data Wrangler
- **Azure Machine Learning:**
  - Designer (drag-and-drop)
  - Automated ML
  - MLOps: pipelines, model registry, monitoring
  - Integração com Azure DevOps
  - Compute clusters gerenciados
- **GCP Vertex AI:**
  - Unifica AI Platform + AutoML
  - Vertex AI Workbench (notebooks)
  - Vertex AI Pipelines (Kubeflow)
  - Vertex AI Feature Store
  - Pre-trained models (Vision, NLP)

#### 6.2 Pre-trained AI Services

**Visão Computacional:**

- **AWS Rekognition:** detecção de objetos, reconhecimento facial, OCR
- **Azure Computer Vision:** análise de imagem, OCR, face detection
- **GCP Vision AI:** image labeling, OCR, explicit content detection

**Processamento de Linguagem Natural:**

- **AWS Comprehend:** sentiment analysis, entity extraction, topic modeling
- **Azure Cognitive Services (Language):** sentiment, key phrases, translation
- **GCP Natural Language AI:** sentiment, entity, syntax analysis

**Speech:**

- **AWS Transcribe/Polly:** speech-to-text, text-to-speech
- **Azure Speech Services:** transcrição, síntese, tradução de fala
- **GCP Speech-to-Text/Text-to-Speech**

**Chatbots:**

- **AWS Lex:** framework para chatbots (backend do Alexa)
- **Azure Bot Service:** integrado com LUIS (language understanding)
- **GCP Dialogflow:** NLU para conversational interfaces

#### 6.3 Data Science Workflows em Cloud

**Processo Típico:**

```
1. Data Ingestion:
   - Batch: AWS Glue, Azure Data Factory, GCP Dataflow
   - Streaming: AWS Kinesis, Azure Event Hubs, GCP Pub/Sub

2. Data Storage:
   - Raw: S3, Blob Storage, Cloud Storage
   - Processed: Redshift, Synapse, BigQuery

3. Data Processing:
   - ETL: Spark (EMR, Databricks, Dataproc)
   - SQL: Athena, Synapse, BigQuery

4. Model Training:
   - SageMaker, Azure ML, Vertex AI
   - Notebooks: SageMaker Studio, Azure Notebooks, Vertex Workbench

5. Model Deployment:
   - REST API: SageMaker Endpoints, Azure ML Endpoints, Vertex AI Prediction
   - Batch: SageMaker Batch Transform, Azure ML Batch Endpoints

6. Monitoring:
   - SageMaker Model Monitor, Azure ML Monitoring, Vertex AI Monitoring
   - Drift detection, performance tracking
```

#### 6.4 GPUs e Accelerators

- **AWS:** instâncias P3/P4 (NVIDIA V100/A100), G4 (T4), Inf1 (AWS Inferentia)
- **Azure:** NC-series (V100, A100), ND-series (training)
- **GCP:** A2 (A100), TPU pods (Tensor Processing Units - até 2048 cores)

**Quando usar:**

- **GPUs:** deep learning training, LLM inference
- **TPUs (GCP):** training de redes muito grandes (BERT, GPT), melhor custo-benefício que GPU
- **Inferentia/Inf1:** inferência de modelos (mais barato que GPU)

---

### 7. **Big Data e Analytics**

#### 7.1 Data Lake Architecture

- **Conceito:** repositório centralizado de dados brutos em qualquer formato
- **Storage:** S3 (AWS), ADLS (Azure Data Lake Storage), GCS (GCP)
- **Organização típica:**
  ```
  /raw/             # dados brutos (CSV, JSON, logs)
  /processed/       # dados limpos e transformados (Parquet, ORC)
  /curated/         # dados agregados para BI (otimizado)
  ```
- **Formatos colunares:**
  - **Parquet:** mais usado, compressão eficiente, schema evolution
  - **ORC:** otimizado para Hive, compressão agressiva
  - **Avro:** schema evolution, bom para streaming

#### 7.2 Processamento Distribuído

**Apache Spark:**

- Framework para processamento paralelo de big data
- **AWS EMR (Elastic MapReduce):** cluster Spark gerenciado
- **Azure Databricks:** plataforma Spark otimizada (colaborativa, notebooks)
- **GCP Dataproc:** cluster Spark/Hadoop gerenciado

**Quando usar Spark:**

- Transformações complexas em big data (100s GB - PB)
- Feature engineering em larga escala
- Training de modelos distribuído (MLlib, Spark ML)

**Serverless Spark:**

- **AWS Glue:** ETL serverless com Spark
- **GCP Dataproc Serverless:** sem gerenciar clusters
- **Azure Synapse Spark:** Spark integrado ao Synapse

#### 7.3 Streaming Analytics

**Conceito:** processar dados em tempo real (low latency)

- **AWS Kinesis:**
  - **Kinesis Data Streams:** ingestão de streams (logs, eventos)
  - **Kinesis Data Analytics:** SQL queries em streams
  - **Kinesis Firehose:** entrega contínua para S3/Redshift
- **Azure Event Hubs + Stream Analytics:**
  - Event Hubs: ingestão de milhões de eventos/s
  - Stream Analytics: queries SQL em tempo real
- **GCP Pub/Sub + Dataflow:**
  - Pub/Sub: messaging assíncrono
  - Dataflow: Apache Beam para streaming/batch

**Casos de uso:**

- Detecção de fraude em transações
- Monitoramento de IoT (alertas em tempo real)
- Real-time dashboards
- Recomendações personalizadas

---

### 8. **DevOps e MLOps em Cloud**

#### 8.1 CI/CD (Continuous Integration/Deployment)

- **AWS:** CodePipeline, CodeBuild, CodeDeploy
- **Azure:** Azure DevOps (Pipelines, Repos, Boards)
- **GCP:** Cloud Build, Cloud Deploy
- **Agnóstico:** GitHub Actions, GitLab CI, Jenkins

**Pipeline Típico:**

```
1. Code push (Git)
2. Build (compilar, testes unitários)
3. Test (integration tests)
4. Deploy to staging
5. Approval gate
6. Deploy to production
7. Monitor
```

#### 8.2 Infrastructure as Code (IaC)

- **Terraform:** multi-cloud, declarativo (HCL)
- **AWS CloudFormation:** JSON/YAML, AWS-only
- **Azure Resource Manager (ARM) Templates:** JSON
- **Pulumi:** usa linguagens de programação (Python, TypeScript)

**Vantagens:**

- Reprodutibilidade (mesma infra em dev/prod)
- Versionamento (Git)
- Auditoria (quem mudou o quê)
- Disaster recovery (recriar infra rapidamente)

#### 8.3 MLOps

**Conceito:** DevOps aplicado a Machine Learning

**Componentes:**

- **Versionamento:**
  - Código: Git
  - Dados: DVC (Data Version Control), AWS S3 versioning
  - Modelos: MLflow, SageMaker Model Registry, Vertex AI Model Registry
- **Pipelines:**
  - **Kubeflow:** orquestração de workflows ML em Kubernetes
  - **MLflow:** tracking experiments, packaging, deployment
  - **SageMaker Pipelines, Azure ML Pipelines, Vertex AI Pipelines**
- **Monitoring:**
  - Data drift: distribuição de features mudou
  - Model drift: performance caiu
  - **Tools:** SageMaker Model Monitor, Azure ML Monitoring, Evidently AI

**CI/CD para ML:**

```
1. Data validation (schema, distributions)
2. Model training (automated)
3. Model evaluation (metrics, comparação com baseline)
4. If passed, deploy to staging
5. A/B testing (champion vs. challenger)
6. If challenger wins, promote to production
7. Monitor performance
```

#### 8.4 Containers Registry

- **AWS ECR (Elastic Container Registry):** Docker images
- **Azure Container Registry:** integrado com AKS
- **GCP Artifact Registry:** containers e packages
- **Docker Hub:** registry público/privado

---

### 9. **Security e Compliance**

#### 9.1 Identity and Access Management (IAM)

- **Princípio:** least privilege (acesso mínimo necessário)
- **AWS IAM:** users, groups, roles, policies
- **Azure AD (Active Directory):** RBAC (Role-Based Access Control)
- **GCP IAM:** roles e permissions fine-grained

**Boas Práticas:**

- Usar roles (não chaves hardcoded)
- MFA (multi-factor authentication)
- Rotate credentials regularmente
- Auditar com CloudTrail (AWS), Activity Log (Azure), Cloud Audit Logs (GCP)

#### 9.2 Encryption

- **Data at Rest:** armazenamento criptografado (S3, EBS, databases)
  - **AWS KMS (Key Management Service)**, Azure Key Vault, GCP KMS
- **Data in Transit:** HTTPS, TLS/SSL
  - Certificados gerenciados: AWS Certificate Manager, Azure App Service Certificates

#### 9.3 Compliance e Governança

- **Certificações:** ISO 27001, SOC 2, HIPAA, PCI-DSS, FedRAMP
- **LGPD/GDPR:** data residency (escolher região Brazil/EU), data deletion policies
- **AWS:** GuardDuty (threat detection), Security Hub, Inspector
- **Azure:** Security Center, Sentinel (SIEM)
- **GCP:** Security Command Center

#### 9.4 Network Security

- **VPC (Virtual Private Cloud):** rede isolada
- **Subnets:** public (internet-facing) vs. private (internal)
- **Security Groups:** firewall stateful (allow rules)
- **NACLs (Network ACLs):** firewall stateless (allow/deny rules)
- **VPN, Direct Connect/ExpressRoute:** conexão segura com on-premise

---

### 10. **Cost Optimization**

#### 10.1 Pricing Models

- **Compute:**
  - On-demand: flexível, mais caro
  - Reserved (1-3 anos): 30-70% desconto
  - Spot/Preemptible: 70-90% desconto, pode ser interrompido
  - Savings Plans: compromisso de gasto ($/hora), flexibilidade de instâncias
- **Storage:**
  - S3 Standard: $0.023/GB/mês
  - S3 IA: $0.0125/GB/mês
  - Glacier: $0.004/GB/mês
  - **Egress (data transfer out):** pode ser caro ($0.09/GB)
- **Data Warehouse:**
  - Redshift: cluster provisionado ($/hora)
  - BigQuery: $5/TB processado (query) + $0.02/GB armazenado

#### 10.2 Estratégias de Otimização

1. **Right-sizing:** usar instância adequada (não over-provisioned)
2. **Auto-scaling:** ajustar recursos conforme demanda
3. **Spot instances:** para workloads interruptíveis (batch jobs, Spark)
4. **Storage lifecycle:** mover dados antigos para tiers baratos (S3 Glacier)
5. **Reserved capacity:** comprometer workloads previsíveis (RDS, Redshift)
6. **Serverless:** paga só quando executa (Lambda, BigQuery)
7. **Data transfer:** minimizar egress (processar perto dos dados)
8. **Scheduled shutdown:** desligar dev/test VMs fora do horário

#### 10.3 Cost Monitoring

- **AWS Cost Explorer, Budgets, Trusted Advisor**
- **Azure Cost Management + Billing**
- **GCP Cloud Billing, Recommender**
- **Tags/Labels:** associar custos a projetos/equipes
- **Alertas:** notificar quando gasto ultrapassar threshold

**Exemplo de custo típico (ML project):**

- Training (Spark + GPU): $500-$2000/mês
- Storage (data lake): $100-$500/mês
- Inference (API): $200-$1000/mês
- Data transfer: $50-$300/mês
- **Total:** $850-$3800/mês (varia muito com escala)

---

## 💡 Conceitos-Chave para Memorizar

1. **Cloud Computing = Pay-as-you-go + Elasticidade + Abstração de infraestrutura**
   - Economiza capex, acelera time-to-market

2. **Modelos de Serviço:**
   - **IaaS:** máximo controle (EC2, VMs) → para migração lift-and-shift
   - **PaaS:** foco em código (Elastic Beanstalk, App Service) → para developers
   - **SaaS:** solução pronta (Salesforce, Office 365) → para end-users

3. **Principais Provedores:**
   - **AWS:** maior ecossistema, líder de mercado, 200+ serviços
   - **Azure:** integração Microsoft, híbrido forte, enterprise
   - **GCP:** BigQuery (melhor DW), Kubernetes, ML/AI (TPUs)

4. **Compute:**
   - **VMs:** controle total, IaaS clássico
   - **Containers (Docker/K8s):** portabilidade, microservices, cloud-native
   - **Serverless (Lambda/Functions):** zero management, event-driven, pay-per-execution

5. **Storage:**
   - **Object (S3, Blob):** data lake, arquivos grandes, durabilidade 11-nines
   - **Block (EBS):** discos de VMs, baixa latência, I/O intensivo
   - **File (EFS):** compartilhamento NFS entre servidores

6. **Database:**
   - **SQL (RDS, Cloud SQL):** transacional, ACID, relacionamentos
   - **NoSQL (DynamoDB, Cosmos DB):** escala horizontal, schema-less
   - **Data Warehouse (Redshift, BigQuery):** analytics, OLAP, columnar

7. **ML em Cloud:**
   - **Plataformas:** SageMaker, Azure ML, Vertex AI (end-to-end ML lifecycle)
   - **Pre-trained AI:** Rekognition, Computer Vision, Natural Language (APIs prontas)
   - **GPUs/TPUs:** para training de deep learning

8. **Big Data:**
   - **Data Lake:** S3/ADLS/GCS (storage), Parquet (formato)
   - **Spark:** processamento distribuído (EMR, Databricks, Dataproc)
   - **Streaming:** Kinesis, Event Hubs, Pub/Sub (real-time)

9. **MLOps:**
   - **Pipelines:** automatizar training → evaluation → deployment
   - **Model Registry:** versionamento de modelos (MLflow, SageMaker)
   - **Monitoring:** data drift, model drift, performance

10. **Cost Optimization:**
    - **Reserved/Spot instances:** economizar 50-90%
    - **Auto-scaling:** paga só o necessário
    - **Serverless:** sem recursos ociosos
    - **Storage lifecycle:** S3 Glacier para dados antigos
    - **Right-sizing:** não over-provision

---

## ⚠️ Erros Comuns a Evitar

1. **❌ Deixar recursos rodando 24/7 sem necessidade**
   - Resultado: custos altos desnecessários
   - ✅ Implementar auto-scaling, desligar dev/test fora do horário

2. **❌ Não usar IAM roles (hardcoded keys no código)**
   - Problema: risco de segurança (chaves vazadas)
   - ✅ Usar roles EC2, Lambda execution roles, service accounts

3. **❌ Armazenar tudo em storage class caro (S3 Standard)**
   - Resultado: custo 10x maior que Glacier
   - ✅ Lifecycle policies (mover dados antigos automaticamente)

4. **❌ Over-provisioning de instâncias (usar m5.4xlarge para workload pequeno)**
   - Resultado: desperdício de $$$
   - ✅ Começar pequeno, monitorar CPU/RAM, escalar só se necessário

5. **❌ Não implementar backups e disaster recovery**
   - Problema: perda de dados catastrófica
   - ✅ Snapshots automáticos, replicação cross-region, testar restore

6. **❌ Não taggar recursos (VMs, volumes, buckets)**
   - Resultado: impossível rastrear custos por projeto/equipe
   - ✅ Tags: Project, Environment, Owner, CostCenter

7. **❌ Não usar VPC e security groups corretamente**
   - Problema: recursos expostos publicamente (banco de dados na internet)
   - ✅ Databases em subnet privada, só web tier em subnet pública

8. **❌ Não monitorar custos (surpreendido com fatura)**
   - Resultado: gastos descontrolados
   - ✅ Configurar alertas de budget (AWS Budgets, Azure Cost Alerts)

9. **❌ Vendor lock-in total (usar serviços proprietários demais)**
   - Problema: difícil migrar para outro provider
   - ✅ Balancear serviços gerenciados com open-source (Kubernetes, Terraform, Spark)

10. **❌ Não implementar CI/CD e IaC**
    - Resultado: deploys manuais, inconsistências, lentidão
    - ✅ Terraform/CloudFormation, pipelines automatizados

---

## 📚 Materiais de Apoio e Referências

### Documentação Oficial

- **AWS:** https://docs.aws.amazon.com/
  - Well-Architected Framework (boas práticas de arquitetura)
  - Workshops hands-on: https://workshops.aws/
- **Azure:** https://docs.microsoft.com/azure/
  - Azure Architecture Center
  - Microsoft Learn (tutoriais gratuitos)
- **GCP:** https://cloud.google.com/docs
  - Codelabs (tutoriais práticos)
  - Architecture Framework

### Certificações

📜 **AWS:**

- **Cloud Practitioner:** fundamentos (nível entry)
- **Solutions Architect Associate:** design de arquiteturas
- **Machine Learning Specialty:** ML/AI no AWS

📜 **Azure:**

- **Azure Fundamentals (AZ-900):** conceitos básicos
- **Azure Data Scientist Associate (DP-100):** ML no Azure

📜 **GCP:**

- **Associate Cloud Engineer:** operações básicas
- **Professional Data Engineer:** big data e ML no GCP

### Cursos Online

- **A Cloud Guru / Pluralsight:** cursos para certificações
- **Coursera:** Google Cloud, AWS specializations
- **Udemy:** cursos práticos (hands-on)
- **AWS Training, Azure Learn, GCP Training:** gratuitos dos provedores

### Livros

📖 **"Cloud Computing: Concepts, Technology & Architecture" - Erl et al.**

- Fundamentos independentes de provedor

📖 **"Google BigQuery: The Definitive Guide" - Lakshmanan & Tigani**

- Deep dive em BigQuery para analytics

📖 **"Data Science on AWS" - Fregly & Barth**

- End-to-end ML workflows no AWS

### Ferramentas de Prática

- **Free Tiers:** AWS, Azure, GCP oferecem recursos gratuitos (12 meses ou sempre gratuito)
- **Qwiklabs / A Cloud Guru:** labs práticos guiados
- **LocalStack:** emulador AWS local (testar sem custo)

### Comunidades

- **Reddit:** r/aws, r/AZURE, r/googlecloud
- **Stack Overflow:** perguntas técnicas
- **AWS re:Invent, Google Cloud Next, Microsoft Ignite:** conferências anuais (vídeos no YouTube)

---

## ✅ Checklist de Estudo

### Fundamentos

- [ ] Compreender 5 características de cloud (on-demand, elasticity, etc.)
- [ ] Diferenciar IaaS vs. PaaS vs. SaaS (exemplos e quando usar)
- [ ] Conhecer modelos de deployment: public, private, hybrid, multi-cloud
- [ ] Comparar vantagens cloud vs. on-premise (capex/opex, time-to-market)

### Provedores

- [ ] Conhecer quota de mercado: AWS (~32%), Azure (~23%), GCP (~10%)
- [ ] Listar 5 serviços principais de cada provedor (compute, storage, database)
- [ ] Entender pontos fortes: AWS (ecossistema), Azure (híbrido), GCP (BigQuery/K8s)

### Compute

- [ ] **VMs:** criar EC2/Azure VM/Compute Engine, conectar via SSH
- [ ] Escolher tipo de instância apropriado (general, compute-optimized, GPU)
- [ ] Comparar pricing: on-demand vs. reserved vs. spot
- [ ] **Containers:** criar Dockerfile, build imagem, rodar container
- [ ] Deploy aplicação em Kubernetes (EKS/AKS/GKE)
- [ ] **Serverless:** criar Lambda/Function, configurar trigger (HTTP, S3 event)
- [ ] Entender limitações serverless (timeout, cold start)

### Storage

- [ ] Criar bucket S3/Blob/GCS, fazer upload de arquivo via CLI
- [ ] Configurar lifecycle policy (mover para storage class mais barato)
- [ ] Diferenciar object vs. block vs. file storage (casos de uso)
- [ ] Usar S3 como data lake (organizar em raw/processed/curated)

### Database

- [ ] **SQL:** criar RDS/Cloud SQL, conectar via cliente SQL
- [ ] **NoSQL:** criar tabela DynamoDB/Cosmos DB, fazer queries
- [ ] **Data Warehouse:** criar banco Redshift/BigQuery, executar queries analíticas
- [ ] Comparar quando usar SQL vs. NoSQL vs. DW

### Machine Learning

- [ ] **SageMaker/Azure ML/Vertex AI:** criar notebook gerenciado
- [ ] Treinar modelo scikit-learn/XGBoost usando SDK
- [ ] Deploy modelo como REST API
- [ ] Testar endpoint com request HTTP
- [ ] **Pre-trained AI:** usar Rekognition/Vision API para detectar objetos em imagem
- [ ] Usar Comprehend/Natural Language API para sentiment analysis

### Big Data

- [ ] **Spark:** criar cluster EMR/Databricks/Dataproc
- [ ] Executar job Spark (PySpark) para transformação de dados
- [ ] **BigQuery:** query em dataset público (Github, Stack Overflow)
- [ ] Entender diferença batch vs. streaming
- [ ] Configurar pipeline streaming básico (Kinesis/Pub/Sub → Lambda/Function)

### DevOps/MLOps

- [ ] **IaC:** escrever template Terraform/CloudFormation para provisionar VM + S3
- [ ] Aplicar Terraform (terraform plan, apply, destroy)
- [ ] **CI/CD:** criar pipeline básico (GitHub Actions ou CodePipeline)
- [ ] Configurar deploy automático de aplicação
- [ ] **MLOps:** versionar modelo com MLflow ou SageMaker Model Registry
- [ ] Configurar monitoring de model drift

### Security

- [ ] Criar IAM role, anexar policy, assumir role
- [ ] Configurar MFA em conta root
- [ ] Criar VPC com subnet pública e privada
- [ ] Configurar security group (allow HTTP 80, SSH apenas do meu IP)
- [ ] Habilitar encryption at rest (S3, EBS, RDS)

### Cost Optimization

- [ ] Analisar custos com Cost Explorer/Cost Management
- [ ] Configurar alerta de budget (notificar se > $100/mês)
- [ ] Identificar recursos não-utilizados (VMs desligadas mas EBS anexado)
- [ ] Implementar auto-scaling em aplicação
- [ ] Usar spot instances para job batch

### Projeto Prático Completo

- [ ] **Definir projeto:** ex: pipeline ML para predição de churn
- [ ] **Arquitetura:**
  - Data lake (S3/Blob) com dados raw
  - ETL com Spark (EMR/Databricks) → Parquet
  - Feature store (S3 processed)
  - Training com SageMaker/Azure ML
  - Deploy modelo como API (SageMaker Endpoint)
  - Monitoring (CloudWatch/Application Insights)
  - CI/CD (pipeline automático)
- [ ] **Implementar infraestrutura com Terraform**
- [ ] **Executar pipeline end-to-end**
- [ ] **Monitorar custos e otimizar**
- [ ] **Documentar arquitetura (diagrama + decisões)**

---

**🎯 Meta de Aprendizado:**  
Projetar e implementar arquitetura de Data Science completa em cloud (AWS, Azure ou GCP), incluindo data lake, processamento distribuído (Spark), training de modelo (SageMaker/Vertex AI), deployment como API e monitoramento. Demonstrar domínio de IaC (Terraform) e princípios de custo-eficiência e segurança.

**💪 Desafio Avançado:**  
Implementar pipeline MLOps completo com CI/CD: código no GitHub → trigger automático → treinar modelo → avaliar métricas → se passou threshold, deploy para staging → A/B test (champion vs. challenger) → promover para produção → monitorar drift. Usar Kubernetes (EKS/AKS/GKE) para orquestração.

---

_Documentado para MBA Data Science e Analytics - USP/ESALQ_  
_Versão 1.0 - Cloud Computing para Data Science_
