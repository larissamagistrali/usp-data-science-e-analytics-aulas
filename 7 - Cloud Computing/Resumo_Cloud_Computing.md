# ☁️ Resumo: Cloud Computing

**MBA Data Science e Analytics - USP/ESALQ**

_Baseado nos slides "Cloud Computing I" (Rodrigo Vale) e "Cloud Computing II" (Rodrigo Vale)_

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos de Cloud Computing (o que é, quais problemas resolve, modelos de serviço e implantação, pilares de infraestrutura), conhecer conceitos de Kubernetes, serverless, bancos de dados gerenciados, segurança/IAM, FinOps e arquiteturas multi-cloud. Na segunda parte do módulo, entender o ciclo de vida da análise de dados em nuvem e as principais tecnologias de dados em larga escala vistas em aula: mensageria/streaming, CDC, Kafka, Hadoop, Apache Spark, formatos de armazenamento (Parquet) e Apache Iceberg.

---

## 📚 Conteúdo Principal

### 1. Fundamentos de Cloud Computing

- **Definição (conforme slide):** entrega de serviços de computação (servidores, armazenamento, software) pela internet, com pagamento sob demanda.
- **Analogia usada em aula:** cloud computing é como a energia elétrica — você não constrói uma usina em casa, apenas se conecta à rede e paga pelo que usa.

**Problemas que a computação em nuvem tenta resolver (conforme aula):**

1. **Alto custo inicial e desperdício de recursos:** modelo tradicional exige CAPEX alto (comprar servidores); a nuvem troca CAPEX por OPEX (paga-se pelo uso).
2. **Dificuldade de escalar:** picos de acesso (ex: Black Friday) são resolvidos com elasticidade — recursos alocados/liberados automaticamente conforme a demanda.
3. **Lentidão e falta de agilidade:** provisionar servidor físico levava semanas/meses; na nuvem, minutos.
4. **Manutenção e gestão complexa da infraestrutura:** o provedor cuida de refrigeração, energia, segurança física, hardware — a equipe foca no negócio.
5. **Baixa confiabilidade e recuperação de desastres:** provedores têm múltiplos data centers, permitindo replicação geográfica fácil.
6. **Acesso limitado e dificuldade de colaboração:** serviços em nuvem são acessados pela internet, permitindo trabalho remoto e ferramentas colaborativas (Google Workspace, Microsoft 365).

**Desvantagens da computação em nuvem (conforme aula):**

1. **Dependência da conexão com a internet.**
2. **Riscos de segurança e privacidade:** a principal causa de vazamentos não são ataques sofisticados, mas configurações incorretas do cliente ("modelo de responsabilidade compartilhada"); preocupação com soberania de dados e ameaças internas.
3. **Vendor lock-in:** dependência de serviços proprietários de um provedor (ex: AWS Lambda, BigQuery, Cosmos DB) dificulta migração.
4. **Custos podem sair do controle ("cloud sprawl"):** custos ocultos (egress, IPs estáticos) e recursos ociosos esquecidos.
5. **Menor controle e flexibilidade** sobre hardware/infraestrutura subjacente.
6. **Problemas de latência:** aplicações de altíssima frequência (mercado financeiro, automação industrial) podem sofrer se o usuário estiver longe do data center.
7. **Complexidade de gerenciamento**, especialmente em ambientes multicloud/híbridos, exigindo habilidades especializadas (ex: FinOps, engenheiros de segurança em nuvem).

**Os "Gigantes da Nuvem" (mencionados em aula, sem dados de market share ou histórico apresentados):**

- **AWS (Amazon Web Services):** a pioneira e líder de mercado.
- **Microsoft Azure:** forte presença no mundo corporativo e integração com produtos Microsoft.
- **Google Cloud Platform (GCP):** destaque em dados, Machine Learning e contêineres.

---

### 2. Modelos de Serviço

**A Pirâmide de Serviços:** Topo = SaaS (menos controle, mais conveniência); Meio = PaaS; Base = IaaS (mais controle, menos conveniência).

- **IaaS (Infraestrutura como Serviço):** aluga-se a infraestrutura de TI — servidores (VMs), redes e armazenamento. Analogia: alugar o terreno e as ferramentas, você constrói a casa como quiser. Você gerencia SO, aplicações e dados. Exemplos citados: Amazon EC2, Azure VMs, Google Compute Engine.
- **PaaS (Plataforma como Serviço):** plataforma completa para desenvolver e implantar aplicações sem se preocupar com a infraestrutura por baixo. Analogia: alugar uma casa pré-fabricada. Você gerencia apenas aplicações e dados. Exemplos citados: Heroku, Google App Engine, AWS Elastic Beanstalk.
- **SaaS (Software como Serviço):** software completo, pronto para uso, acessado pela internet. Analogia: alugar um apartamento mobiliado. Você não gerencia nada da infraestrutura. Exemplos citados: Gmail, Office 365, Salesforce, Netflix.

**Soluções totalmente gerenciadas:** serviços em que o provedor de nuvem assume a operação/manutenção da infraestrutura subjacente (provisionamento de servidores, patches, escalabilidade, backups, monitoramento). Exemplo detalhado em aula: **Cloud SQL** (banco relacional totalmente gerenciado do GCP) — resolve instalação/configuração, patches de segurança, backups/restauração, escalabilidade e alta disponibilidade (failover automático).

---

### 3. Modelos de Implantação

- **Nuvem Pública:** infraestrutura pertence e é operada pelo provedor (AWS, Azure, GCP), recursos compartilhados entre múltiplos clientes ("multi-tenant"). Vantagens: menor custo, escalabilidade quase infinita, sem manutenção. Ideal para startups, websites, novas aplicações.
- **Nuvem Privada:** infraestrutura de uso exclusivo de uma organização (no data center local ou hospedada por terceiros). Vantagens: máximo controle, segurança e privacidade. Ideal para bancos, governos, empresas com dados muito sensíveis.
- **Nuvem Híbrida:** conecta infraestrutura local (privada) com a nuvem pública. Vantagem: flexibilidade — mantém dados sensíveis localmente e usa a nuvem para escalar processamento ou recuperação de desastres. Exemplo de uso citado: varejista usa servidores locais para as lojas, mas move o processamento do e-commerce para a nuvem pública durante a Black Friday.

---

### 4. Pilares da Infraestrutura

- **Pilar 1 — Computação (Compute):** o "cérebro" da operação.
  - **Máquinas Virtuais (VMs):** computador completo (CPU, memória, disco, rede) rodando em um data center; base da nuvem.
  - **Contêineres:** forma mais leve de virtualização, empacotam código e dependências (menção breve a Docker e Kubernetes como orquestrador).
- **Pilar 2 — Armazenamento (Storage):** onde os dados vivem.
  - **Armazenamento de Objetos:** quase infinito, ideal para arquivos (fotos, vídeos, backups). Exemplo: AWS S3.
  - **Armazenamento de Blocos:** os "discos rígidos" das VMs, rápido e de alto desempenho. Exemplo: AWS EBS.
  - **Armazenamento de Arquivos:** disco de rede compartilhado, acessível por múltiplas VMs. Exemplo: AWS EFS.
- **Pilar 3 — Rede (Networking):** como tudo se conecta de forma segura.
  - **VPC (Virtual Private Cloud):** fatia privada e isolada da nuvem pública.
  - **Sub-redes:** organizam recursos dentro da VPC (ex: sub-rede pública para servidores web, privada para bancos de dados).
  - **Grupos de Segurança:** firewall da VM, define quais portas estão abertas para entrada/saída.

**Demonstração rápida (mostrada em aula):** login no console → escolher serviço de VM → configurar SO e tamanho da instância → configurar rede (grupo de segurança, liberar porta 80) → lançar e conectar via IP público.

---

### 5. Serverless Computing

- **A Grande Ideia:** executar código sem gerenciar servidores (o provedor gerencia os servidores por trás).
- **Como funciona:** (1) você escreve uma função para uma tarefa específica; (2) define um gatilho/trigger (clique, novo arquivo, horário); (3) a nuvem aloca recursos instantaneamente quando o gatilho é acionado e depois os libera.
- **Exemplos práticos citados em aula:**
  - Redimensionar imagem automaticamente ao subir um arquivo em um bucket (S3/Cloud Storage).
  - Backend de um formulário "Fale Conosco" acionado por requisição HTTP.
  - Tarefas agendadas (cron) — ex: gerar relatório financeiro diário à meia-noite.
- **Vantagens:** custo-eficiência extrema (paga só pelos milissegundos de execução), escalabilidade automática de zero a milhares de requisições, redução da carga operacional (sem provisionamento/patches manuais).
- **Desvantagens:** cold starts (latência na primeira execução), limitações de tempo de execução (tipicamente 5–15 min) e de memória/tamanho de pacote, maior complexidade de monitoramento/depuração em sistemas distribuídos com muitas funções pequenas, vendor lock-in.

---

### 6. Bancos de Dados como Serviço (DBaaS)

O provedor de nuvem oferece bancos totalmente gerenciados (instalação, patches, backups automáticos, alta disponibilidade e replicação).

- **SQL (Relacional):** dados estruturados em tabelas com schema fixo (definido antes de inserir dados). Linguagem SQL, garantias ACID (Atomicidade, Consistência, Isolamento, Durabilidade) — ideal para transações financeiras. Casos de uso citados: e-commerce, aplicações bancárias, sistemas de RH/ERP. Exemplos: MySQL, PostgreSQL, SQL Server, Oracle, Google Cloud SQL, AWS RDS, Azure SQL. Vantagens: consistência, linguagem madura, ideal para JOINs complexos. Desvantagens: rigidez de schema, escalabilidade horizontal difícil.
- **NoSQL (Não Relacional):** schema flexível, cada registro pode ter atributos diferentes. Prioriza disponibilidade e velocidade sobre consistência imediata (modelo BASE). Tipos e exemplos citados:
  - **Documentos:** MongoDB, Firebase Firestore (perfis de usuário, catálogos).
  - **Chave-Valor:** Redis, Amazon DynamoDB (cache, sessões).
  - **Colunar:** Cassandra, Google Bigtable (telemetria, IoT).
  - **Grafo:** Neo4j, Amazon Neptune (redes sociais, recomendação).
  - Vantagens: flexibilidade máxima, escalabilidade horizontal massiva, alta performance de leitura/escrita. Desvantagens: consistência eventual, sem linguagem de consulta padrão, JOINs pouco suportados.

---

### 7. Kubernetes

- **O que é:** sistema de orquestração de contêineres. Evolução: deployment tradicional → virtualizado (VMs com hypervisor) → contêineres (compartilham o container runtime sobre o mesmo SO).
- **Componentes do cluster (conforme diagrama do slide):** API server, Controller Manager, Cloud Controller Manager (opcional), etcd (armazenamento de persistência), kubelet, kube-proxy, Scheduler — organizados em Control Plane e Nodes.
- **Kubernetes na prática:** Cluster → Painel de Controle → Nodes → Pods → Contêineres, com um Service Mesh coordenando a comunicação entre microsserviços (exemplo do padrão sidecar).

---

### 8. CI/CD

- **Integração Contínua (CI):** prática de mesclar as cópias de trabalho dos desenvolvedores em uma linha principal compartilhada várias vezes ao dia.
- **Entrega Contínua (CD):** prática de produzir um entregável em ciclos curtos, garantindo que o software possa ser lançado com segurança a qualquer momento.
- **Pipeline mostrado em aula:** merge (GitHub) → Build → teste → teste de segurança → verificação de políticas → Artifact storage (com Audit Log e Untrusted Artifact storage) → deployment → monitoramento.
- **Ferramentas citadas no diagrama "CI/CD Multi-Cloud":** Jenkins, Terraform, Chef, Google Cloud Build, Stackdriver, Datadog, Prometheus.

---

### 9. Segurança

- **Modelo de Responsabilidade Compartilhada:** o provedor é responsável pela segurança **da** nuvem (hardware, data centers); o cliente é responsável pela segurança **na** nuvem (dados, configuração de rede/firewall, senhas, permissões de acesso). Em IaaS o usuário controla mais camadas; em SaaS, o provedor controla quase tudo.
- **IAM (Gestão de Identidade e Acesso):** garante que as identidades certas tenham o acesso certo aos recursos certos, no momento certo.
  - **3 elementos:** Identidade (quem pede acesso — usuário, grupo ou serviço), Permissão (o que pode fazer), Recurso (em que objeto).
  - **Princípio do Menor Privilégio (PoLP):** conceder apenas as permissões mínimas necessárias.
  - **3 pilares:** Autenticação ("você é quem diz ser" — senha, MFA, biometria), Autorização ("o que você pode fazer" — políticas e papéis/roles), Auditoria ("quem fez o quê, onde e quando" — importante para investigações e conformidade com LGPD).
  - **Cenários práticos citados:** (1) aplicação em VM deve acessar bucket privado — solução correta é criar um Papel/Role com política de leitura, não colocar chaves no código; (2) novo analista de dados deve ter acesso apenas de leitura — solução correta é usar Grupos com política de Consulta, não conceder acesso de administrador "para garantir".

---

### 10. FinOps (Gestão de Custos na Nuvem)

- **Mudança de paradigma:** de CAPEX (compra de ativos, custo fixo) para OPEX (pagamento por uso, custo variável que pode crescer sem controle).
- **FinOps:** prática de trazer responsabilidade financeira ao modelo de gastos variáveis da nuvem; cultura que une Engenharia, Finanças e Negócios; objetivo é "gastar melhor", não apenas "gastar menos".
- **Tags (etiquetas):** rótulos chave-valor (ex: projeto, ambiente, centro de custo) que permitem filtrar e alocar custos.
- **Ferramentas citadas:** dashboards nativos (AWS Cost Explorer, Azure Cost Management) e alertas de orçamento.
- **Estratégias de otimização citadas:** Rightsizing (redimensionar VMs superdimensionadas), caça a "recursos zumbis" (discos não anexados, IPs não utilizados), agendamento de ligar/desligar ambientes de dev/teste fora do horário comercial.
- **Ciclo contínuo do FinOps:** Informar (visibilidade via tags/dashboards) → Otimizar (rightsizing, agendamento) → Operar (automatizar e escalar boas práticas).

---

### 11. Arquiteturas Comuns

- **Balanceamento de carga:** exemplo do Google Global Load Balancing distribuindo usuários de diferentes regiões (Califórnia, Nova York, Singapura) para a instância mais próxima via Cloud DNS.
- **Dimensionamento automático de VM:** grupos de instâncias com autoscaler distribuídos por região, atrás de um Cloud Load Balancing.
- **Escalando banco de dados:** réplicas primária/standby entre zonas (com IP compartilhado para failover) e balanceamento de carga somente leitura com réplicas de leitura (exemplo Cloud SQL + HAProxy).

---

### 12. Multi-Cloud

- **Definição:** uso de vários serviços de computação em nuvem e armazenamento em uma única arquitetura heterogênea; pode hospedar IaaS, PaaS, FaaS e SaaS.
- **Entendimento mais amplo (categorias citadas no slide):** Cloud Bursting, execução em múltiplos ambientes, Edge Computing/IoT, jurisdição/soberania de dados, requisitar serviços em nuvem, requisitar dependências legadas, desenvolvimento multi-cloud, backup e recuperação de desastres, execução em múltiplos data centers.
- **Razões para adotar multi-cloud (conforme slide):** ROI otimizado, segurança superior, baixa latência, autonomia, menos sujeito a desastres, agilidade no lançamento de novos produtos. Também citados: estratégia "best-of-breed" (nenhum provedor domina todo o "supply chain"), evitar vendor lock-in, exigência de clientes (ex.: Walmart não usa SaaS hospedado na AWS).
- **Razões para não adotar (conforme slide):** custo de egress, garantia de governança/conformidade, ferramentas de fornecedores em silos, falta de gerenciamento de aplicativos, escassez de pessoal qualificado.
- **Padrões de multi-cloud:** Hybrid Cloud (public + private), Multi-Cloud (public↔public), Multi-Cloud com ambiente privado compartilhado.
- **Cloud Bursting:** réplica, mestre compartilhado ou particionamento de dados entre nuvem e ambiente on-prem.
- **Estudos de caso apresentados em aula:**
  - **Caso 1:** evolução de um data center on-prem (aplicações monolíticas, CI/CD, SQL, file system) para uma arquitetura multi-cloud com micro serviços, autenticação, NoSQL/SQL/objetos, Direct Connect entre data center e Cloud Provider 1, um segundo Cloud Provider para AI/ML e um SaaS para Data Catalog conectados via VPN.
  - **Caso 2:** arquitetura com múltiplos Cloud Providers, cada um com aplicação de micro serviços, EDGE ETL, EDGE Data, AI/ML, CI/CD e ambiente de Data Analytics, conectados via VPN.

---

### 13. Dados: do Dado ao Insight

- **O que são dados:** fatos e números brutos, desorganizados, sem contexto (ex: lista de temperaturas, cliques em um site).
- **Jornada dado → informação → insight:** dado bruto (ex: contagem de itens vendidos por cor) → informação (dados processados/organizados, ex: "itens vermelhos foram os mais vendidos") → insight (entendimento que orienta decisões, ex: aplicar estratégia semelhante para outras cores).
- **"Dados são o novo petróleo":** dados brutos têm potencial não refinado; o processo de análise "refina" os dados em informações e insights valiosos.
- **Os quatro tipos de análise:**
  - **Descritiva:** "o que aconteceu?" — agregação de dados, mineração, relatórios (ex: revisão de vendas do trimestre).
  - **Diagnóstica:** "por que aconteceu?" — detalhamento, correlações, causa raiz (ex: identificar região de baixo desempenho).
  - **Preditiva:** "o que vai acontecer?" — modelagem estatística e aprendizado de máquina (ex: prever demanda futura).
  - **Prescritiva:** "o que devemos fazer?" — algoritmos de otimização, simulação, IA (ex: recomendar estratégia de marketing).
- **Dados como um Produto (DaaP):** mudança de mentalidade de "dados são subproduto" para "dados são ativo essencial", de "foco em pipelines/tecnologia" para "foco no valor ao consumidor", de "qualidade como reflexão tardia" para "qualidade como característica principal". Um conjunto de dados vira "produto" quando é: descobrível, endereçável, confiável (com SLOs claros), compreensível (autodescritivo), seguro e valioso por si só. Benefícios citados: maior ROI, maior agilidade, melhoria na qualidade/confiança/decisões, redução de custos, novos fluxos de receita.
- **Ciclo de vida da análise de dados (6 etapas mostradas em aula):**
  1. **Coletar:** obter dados brutos de fontes diversas (pesquisas, sensores, mídias sociais, APIs, web scraping).
  2. **Processar:** limpar e transformar dados brutos em formato utilizável (tratar valores ausentes, corrigir erros, remover duplicatas).
  3. **Armazenar:** armazenamento seguro em bancos (SQL/NoSQL), data warehouses ou data lakes.
  4. **Analisar:** examinar, modelar e interpretar os dados (estatística, aprendizado de máquina, visualização).
  5. **Ativar:** colocar os insights em ação (decisões, mudanças de processo, novos produtos, personalização).
  6. **Empoderar:** compartilhar resultados com as partes interessadas (painéis, relatórios, apresentações).

---

### 14. Mensageria e Streaming de Dados

- **Streaming de eventos vs. fila de mensagens (tabela comparada em aula):** plataformas de streaming focam em processamento contínuo em tempo real, suportam modelo publicação-assinatura (múltiplos consumidores no mesmo fluxo); filas de mensagens focam em entrega confiável ponto a ponto, geralmente removendo a mensagem após consumo por um único destinatário.
- **Fila de mensagens (Message Queue):** Producers → Message Queue → Consumer. Benefícios: maior confiabilidade/tolerância a falhas (evita efeito cascata em sistemas fortemente acoplados), escalabilidade (balanceamento de carga entre consumidores, absorve picos de tráfego como buffer).
- **CDC (Change Data Capture):** captura modificações de dados (INSERIR, ATUALIZAÇÃO, DELETE) em tempo real e as envia a sistemas posteriores, em vez de copiar periodicamente o conjunto de dados inteiro. Métodos: baseado em log (lê o log de transações nativo, ex: WAL do PostgreSQL/Binlog do MySQL — baixo impacto), baseado em gatilhos (pode gerar sobrecarga), baseado em consulta (pode perder alterações intermediárias e não captura DELETEs sem lógica extra).
- **Apache Kafka:** plataforma de streaming distribuída (originalmente do LinkedIn, mantida pela Apache) para publicar, assinar, armazenar e processar fluxos de registros em tempo real. Por que usar: escalabilidade, durabilidade (dados persistidos em disco), alto rendimento, desacoplamento de sistemas. Casos de uso citados: pipelines de dados em tempo real, arquitetura orientada a eventos, agregação de logs, processamento de fluxo. Arquitetura: tópicos divididos em partições distribuídas entre brokers, com réplicas e consumer groups. **Kafka Connect** ingere dados de sistemas de origem (bancos, filas, apps) e envia a destinos (data warehouses, buscadores, etc.). **Kafka Streams** processa eventos (agregação por janela, joins de streams, detecção de anomalias) usando um state store (RocksDB).
- **Processamento em Lote (Batch) vs. Tempo Real:** Batch processa grandes volumes coletados/armazenados e processados de uma vez, com latência elevada (minutos a horas), agendado em períodos de baixa atividade — exemplos: folha de pagamento, faturamento, ETL noturno. Tempo Real processa dados continuamente com latência mínima (segundos/milissegundos) — exemplos: detecção de fraude em cartões, monitoramento de redes sociais, recomendações de e-commerce, monitoramento de pacientes.

---

### 15. Hadoop

- **O que é:** framework de código aberto baseado em Java que gerencia armazenamento e processamento de grandes volumes de dados via armazenamento distribuído e processamento paralelo, dividindo cargas de trabalho em partes menores.
- **Componentes (conforme diagrama):** HDFS (armazenamento distribuído), MapReduce (processamento distribuído), YARN (agendamento de jobs/gerenciador de recursos), Hadoop Common (bibliotecas Java).
- **HDFS:** um NameNode coordena vários DataNodes, cada um com discos locais.
- **Exemplo MapReduce (word count) mostrado em aula:** Input → Splitting → Mapping → Shuffling → Reducing → resultado final, com pseudocódigo Java (`WordCountReducer extends Reducer`).

---

### 16. Apache Spark

- **O que é:** mecanismo de análise unificado de código aberto para processamento de dados em larga escala, com modelo de programação para ETL, consultas interativas, aprendizado de máquina e streaming.
- **Processamento em memória:** carrega dados na RAM, reduzindo tempo de leitura/gravação em disco (mencionado como significativamente mais rápido que abordagens baseadas em disco). Modelo baseado em RDDs (Resilient Distributed Datasets) — coleções imutáveis e tolerantes a falhas processadas em paralelo.
- **Exemplo de word count em PySpark (pseudocódigo mostrado em aula):** `SparkContext`, `textFile`, `flatMap`, `map`, `reduceByKey`, `collect` — Spark representado como um grafo direcionado e acíclico de operações paralelas (ex: contagem de palavras e contagem de linhas convergindo em um `join`).
- **Spark Architecture:** Driver Program (com SparkContext) se comunica com o Cluster Manager, que distribui tarefas para Worker Nodes (cada um com Executor, Cache e Tasks).
- **Windowing:** mecanismo que agrupa fluxos de dados contínuos em blocos finitos.
  - **Fixed/Tumbling Windows:** janelas de tamanho fixo sem sobreposição.
  - **Hopping Windows:** janelas de tamanho fixo que se sobrepõem (definidas por window size + window period).
  - **Session Windows:** agrupam eventos por proximidade no tempo, separados por um "gap duration" mínimo.
  - **Dados atrasados e marca d'água (watermark):** existe atraso entre o "tempo do evento" e o "tempo de processamento"; o "late threshold" define até quando dados atrasados ainda são incluídos em uma janela já fechada.

---

### 17. Armazenamento e Formatos de Dados

- **Tipos de armazenamento:** File Store (hierarquia de pastas), Block Store (blocos organizados, tipo disco), Object Store (objeto + metadados + ID).
- **Armazenamento em linha vs. colunar:** RDBMS tradicional armazena registros em linha; ferramentas como BigQuery usam armazenamento colunar, guardando valores da mesma coluna juntos.
- **Apache Parquet:** formato de arquivo de código aberto que armazena dados em formato colunar.
  - **Vantagens:** alto desempenho (consultas analíticas leem só as colunas necessárias; arquivos guardam estatísticas como mín/máx por coluna), compressão eficiente (colunas semelhantes compactam melhor), é o padrão colunar da indústria (interoperável com diversos mecanismos).
  - **Desvantagens:** é um formato binário (não legível por humanos em editor de texto, precisa de ferramentas como parquet-tools), tempos de gravação mais lentos que formatos em linha.
  - **Parquet vs. Avro:** Avro é um formato binário orientado a linhas, projetado para minimizar latência de gravação (usado em streaming); Parquet tem as vantagens do Avro/CSV para análises, com melhor desempenho de leitura.
- **Apache Iceberg:** formato de tabela de código aberto para conjuntos de dados analíticos de grande escala em data lakes, atuando como camada de metadados sobre arquivos (Parquet/ORC).
  - **Recursos citados:** transações ACID, evolução de esquema sem reescrever arquivos, particionamento oculto (gerenciado automaticamente), viagem no tempo/retrocesso (snapshots históricos), otimização de desempenho via metadados/estatísticas por arquivo, interoperabilidade (arquitetura "lakehouse").
  - **Conceito de "formato de tabela":** combinação de arquivos Parquet + um arquivo manifesto com metadados sobre esses arquivos, resolvendo problemas de eficiência (evitar recriar arquivos a cada mudança) e consistência.
  - **Arquitetura (3 camadas):** Catálogo Iceberg (aponta para o metadado atual) → Camada de Metadados (arquivos de metadados, listas de manifesto, arquivos de manifesto) → Camada de Dados (arquivos físicos).
  - **Problema que resolve:** evitar catálogos fragmentados por motor de consulta (ex: um formato rápido só para BigQuery e outro só para Databricks); com Iceberg, um único catálogo/tabela é compartilhado entre motores.

---

### 18. Apache Spark SQL

- **O que é:** módulo do Spark para processamento de dados estruturados, com acesso unificado a diversos formatos (JSON, Hive, Parquet, JDBC), suporte a consultas SQL padrão e API DataFrame/Dataset (Python, Java, Scala, R).
- **Por que usar:** escalabilidade (de kilobytes a petabytes em cluster), alto desempenho (otimizador Catalyst + motor de execução Tungsten), API unificada (SQL e DataFrame são equivalentes — ex: `df.filter(df['age'] > 21)` equivale a `spark.sql("SELECT * FROM table WHERE age > 21")`), conectividade com diversas fontes de dados.
- **Exemplo prático mostrado em aula:** criação de uma `SparkSession` configurada com extensões Iceberg, criação de namespace e tabela Iceberg particionada, inserção de dados via `INSERT INTO` e consulta via `SELECT`.
- **Plano de execução de consulta:** toda consulta passa por um **plano lógico** ("o quê" da consulta) e um **plano físico** ("como" o Spark executará, com estágios de filtro, agregação parcial, shuffle e agregação final) — ilustrado com um plano de execução distribuído do BigQuery (Coordinator → Workers em estágios) e com a saída de um `EXPLAIN` no Spark (HashAggregate, Exchange/hashpartitioning, LocalTableScan).

---

## ✅ Checklist de Estudo

- [ ] Explicar a analogia da nuvem com a energia elétrica e os problemas que ela resolve (CAPEX→OPEX, elasticidade, agilidade, manutenção, HA/DR, acesso remoto)
- [ ] Listar as desvantagens da nuvem (dependência de internet, segurança/configuração incorreta, vendor lock-in, custos, latência, complexidade)
- [ ] Diferenciar IaaS, PaaS e SaaS com as analogias e exemplos usados em aula
- [ ] Diferenciar nuvem pública, privada e híbrida
- [ ] Explicar os 3 pilares de infraestrutura (compute, storage, network) e seus componentes básicos
- [ ] Explicar o que é serverless, como funciona e suas vantagens/limitações
- [ ] Diferenciar bancos SQL e NoSQL (schema fixo vs. flexível, ACID vs. BASE) e os 4 tipos de NoSQL
- [ ] Descrever os componentes principais do Kubernetes
- [ ] Explicar CI/CD e o pipeline mostrado em aula
- [ ] Explicar o modelo de responsabilidade compartilhada e os 3 pilares do IAM (autenticação, autorização, auditoria)
- [ ] Explicar FinOps, tags e estratégias de otimização de custos (rightsizing, recursos zumbis, agendamento)
- [ ] Explicar o conceito de multi-cloud, motivos a favor/contra e os padrões (hybrid vs. multi-cloud)
- [ ] Diferenciar dado, informação e insight, e os 4 tipos de análise (descritiva, diagnóstica, preditiva, prescritiva)
- [ ] Descrever as 6 etapas do ciclo de vida da análise de dados (Coletar, Processar, Armazenar, Analisar, Ativar, Empoderar)
- [ ] Diferenciar fila de mensagens e streaming de eventos; explicar CDC e seus métodos
- [ ] Explicar o que é Kafka e seus principais componentes (tópicos, partições, Connect, Streams)
- [ ] Diferenciar processamento batch e tempo real, com exemplos
- [ ] Explicar os componentes do Hadoop (HDFS, MapReduce, YARN) e o exemplo de word count
- [ ] Explicar o que é Apache Spark, RDDs e a arquitetura Driver/Cluster Manager/Worker
- [ ] Explicar windowing (tumbling, hopping, session) e o problema de dados atrasados/watermark
- [ ] Explicar armazenamento colunar vs. em linha, e as vantagens/desvantagens do Parquet
- [ ] Explicar o que é o Apache Iceberg e o problema que resolve (formato de tabela sobre um data lake)
- [ ] Explicar o Spark SQL e a diferença entre plano lógico e plano físico

---

_Documentado para MBA Data Science e Analytics - USP/ESALQ_
_Revisado para refletir apenas o conteúdo apresentado nos slides "Cloud Computing I" e "Cloud Computing II"_
