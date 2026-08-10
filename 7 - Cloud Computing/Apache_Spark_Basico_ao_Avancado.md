# ⚡ Apache Spark — Do Básico ao Avançado

**MBA Data Science e Analytics - USP/ESALQ**

---

## 🎯 Objetivo

Dominar o Apache Spark como principal framework de processamento distribuído de dados em larga escala, desde os conceitos fundamentais até técnicas avançadas de otimização, machine learning e streaming, com foco em aplicações práticas de Data Science.

---

## 📚 Índice

1. [Fundamentos e Arquitetura](#1-fundamentos-e-arquitetura)
2. [Configuração do Ambiente](#2-configuração-do-ambiente)
3. [RDD — Resilient Distributed Dataset](#3-rdd--resilient-distributed-dataset)
4. [DataFrames e Datasets](#4-dataframes-e-datasets)
5. [Spark SQL](#5-spark-sql)
6. [Transformações e Ações](#6-transformações-e-ações)
7. [Leitura e Escrita de Dados](#7-leitura-e-escrita-de-dados)
8. [Manipulação Avançada de Dados](#8-manipulação-avançada-de-dados)
9. [MLlib — Machine Learning Distribuído](#9-mllib--machine-learning-distribuído)
10. [Spark Streaming e Structured Streaming](#10-spark-streaming-e-structured-streaming)
11. [GraphX — Processamento de Grafos](#11-graphx--processamento-de-grafos)
12. [Otimização e Tuning](#12-otimização-e-tuning)
13. [Spark no Ambiente Cloud](#13-spark-no-ambiente-cloud)
14. [Boas Práticas e Padrões de Projeto](#14-boas-práticas-e-padrões-de-projeto)

---

## 1. Fundamentos e Arquitetura

### 1.1 O que é Apache Spark?

- Framework de **processamento distribuído** open source, criado na UC Berkeley (2009)
- Mantido pela Apache Software Foundation
- Processa dados **em memória** (RAM) — até 100× mais rápido que Hadoop MapReduce em disco
- Suporta múltiplas APIs: **Scala** (nativa), **Python (PySpark)**, **Java**, **R (SparkR)**
- Unifica processamento: **batch**, **streaming**, **SQL**, **ML** e **grafos** em um único framework

### 1.2 Por que Spark? — Comparativo

| Característica      | Hadoop MapReduce  | Apache Spark           |
| ------------------- | ----------------- | ---------------------- |
| Processamento       | Disco (HDFS)      | Memória (RAM)          |
| Velocidade          | Lento             | Até 100× mais rápido   |
| Facilidade de uso   | Verbose (Java)    | APIs de alto nível     |
| Streaming           | Não nativo        | Nativo                 |
| ML                  | Mahout (limitado) | MLlib (rico)           |
| Linguagens          | Java              | Python, Scala, R, Java |
| Tolerância a falhas | Sim               | Sim (lineage)          |

### 1.3 Casos de Uso

- ETL e pipelines de dados em escala (terabytes a petabytes)
- Análise exploratória sobre grandes datasets
- Machine learning distribuído
- Processamento de logs em tempo real (streaming)
- Sistemas de recomendação (Netflix, Spotify)
- Análise de grafos (redes sociais)
- Data Warehousing com Spark SQL / Delta Lake

### 1.4 Arquitetura do Spark

```
┌─────────────────────────────────────────────────────┐
│                  DRIVER PROGRAM                     │
│  SparkContext / SparkSession                        │
│  DAG Scheduler → Task Scheduler                     │
└───────────────────────┬─────────────────────────────┘
                        │  submete tarefas
           ┌────────────▼────────────┐
           │    CLUSTER MANAGER      │
           │  (YARN / Mesos /        │
           │   Kubernetes / Standalone)│
           └──┬──────────┬───────────┘
              │          │
    ┌─────────▼──┐  ┌────▼────────┐
    │  WORKER 1  │  │  WORKER 2   │  ...
    │ ┌────────┐ │  │ ┌─────────┐ │
    │ │Executor│ │  │ │Executor │ │
    │ │ Task1  │ │  │ │ Task2   │ │
    │ │ Task2  │ │  │ │ Task3   │ │
    │ └────────┘ │  │ └─────────┘ │
    └────────────┘  └─────────────┘
```

**Componentes:**

| Componente          | Função                                                            |
| ------------------- | ----------------------------------------------------------------- |
| **Driver**          | Coordena a aplicação; mantém SparkContext; constrói o DAG         |
| **Cluster Manager** | Aloca recursos nos workers (YARN, Kubernetes, Standalone)         |
| **Worker Node**     | Máquina física/virtual do cluster                                 |
| **Executor**        | Processo JVM no worker; executa tarefas e armazena dados em cache |
| **Task**            | Menor unidade de trabalho; processa uma partição                  |
| **Job**             | Conjunto de stages disparado por uma ação                         |
| **Stage**           | Conjunto de tasks sem shuffle entre elas                          |
| **DAG**             | Directed Acyclic Graph do plano de execução lógico                |

### 1.5 Modo de Execução

```
Lazy Evaluation (Avaliação Preguiçosa):
  Transformações → constroem o DAG (não executam nada)
  Ações          → disparam a execução real do DAG

Exemplo:
  df.filter(...).groupBy(...).agg(...)   ← só monta o plano
  df.filter(...).groupBy(...).agg(...).show()  ← executa tudo
```

**Vantagem:** o Catalyst Optimizer analisa o DAG inteiro antes de executar e escolhe o plano mais eficiente.

---

## 2. Configuração do Ambiente

### 2.1 Instalação Local (PySpark)

```bash
# Pré-requisito: Java 8 ou 11
java -version

# Instalar via pip
pip install pyspark

# Instalar com dependências de ML e SQL
pip install pyspark[sql,ml,pandas_on_spark]

# Verificar versão
python -c "import pyspark; print(pyspark.__version__)"
```

### 2.2 Iniciar SparkSession

```python
from pyspark.sql import SparkSession

# Criar sessão (ponto de entrada único no Spark 2+)
spark = SparkSession.builder \
    .appName("MeuProjetoSpark") \
    .config("spark.executor.memory", "4g") \
    .config("spark.executor.cores", "2") \
    .config("spark.sql.shuffle.partitions", "200") \
    .getOrCreate()

# Acessar o SparkContext (nível mais baixo)
sc = spark.sparkContext

# Versão do Spark
print(spark.version)

# Encerrar sessão
spark.stop()
```

### 2.3 Configuração para Cluster

```python
# Submit para cluster YARN
# spark-submit --master yarn \
#              --deploy-mode cluster \
#              --executor-memory 8g \
#              --num-executors 10 \
#              --executor-cores 4 \
#              meu_script.py

spark = SparkSession.builder \
    .appName("ProducaoETL") \
    .master("yarn") \
    .config("spark.dynamicAllocation.enabled", "true") \
    .config("spark.dynamicAllocation.minExecutors", "2") \
    .config("spark.dynamicAllocation.maxExecutors", "50") \
    .getOrCreate()
```

### 2.4 Ambientes Cloud

```python
# Databricks (Azure / AWS / GCP)
# SparkSession já disponível como 'spark' — sem necessidade de criar

# AWS EMR
spark = SparkSession.builder \
    .appName("EMRJob") \
    .config("spark.hadoop.fs.s3a.impl",
            "org.apache.hadoop.fs.s3a.S3AFileSystem") \
    .getOrCreate()

# Google Dataproc
# GCS disponível automaticamente via gs://
```

---

## 3. RDD — Resilient Distributed Dataset

### 3.1 Conceito

- **Abstração de baixo nível** do Spark (versão 1.x)
- Coleção imutável e distribuída de objetos
- **Resiliente:** reconstrói partições perdidas via lineage (DAG de transformações)
- Particionado automaticamente pelos workers
- Tipagem via Python/Scala (sem schema)

> **Nota:** Para analytics moderno, prefira DataFrames/Datasets (muito mais otimizados). RDD é útil para transformações não-estruturadas ou controle fino de baixo nível.

### 3.2 Criar RDD

```python
# A partir de coleção Python
rdd = sc.parallelize([1, 2, 3, 4, 5], numSlices=4)

# A partir de arquivo texto
rdd_txt = sc.textFile("dados/livros.txt")

# A partir de arquivo no S3
rdd_s3 = sc.textFile("s3a://meu-bucket/dados/")

# A partir de lista de tuplas
rdd_pares = sc.parallelize([("Python", 3), ("Scala", 5), ("Java", 2)])

# Verificar número de partições
print(rdd.getNumPartitions())
```

### 3.3 Transformações em RDD

```python
# map — transforma cada elemento (1 para 1)
rdd_dobro = rdd.map(lambda x: x * 2)

# filter — filtra elementos
rdd_pares_num = rdd.filter(lambda x: x % 2 == 0)

# flatMap — transforma e "achata" listas (1 para N)
rdd_palavras = sc.textFile("texto.txt") \
                 .flatMap(lambda linha: linha.split(" "))

# distinct — valores únicos
rdd_unicos = rdd.distinct()

# reduceByKey — agrupa e reduz por chave
rdd_soma = rdd_pares.reduceByKey(lambda a, b: a + b)

# groupByKey — agrupa por chave (menos eficiente que reduceByKey)
rdd_grupo = rdd_pares.groupByKey()

# sortByKey — ordenar por chave
rdd_ord = rdd_pares.sortByKey(ascending=False)

# join — juntar dois RDDs pelo par (chave, valor)
rdd_precos  = sc.parallelize([("Python", 89.90), ("Scala", 75.00)])
rdd_estoque = sc.parallelize([("Python", 100), ("Scala", 50)])
rdd_join = rdd_precos.join(rdd_estoque)
# Resultado: [("Python", (89.90, 100)), ("Scala", (75.00, 50))]

# mapPartitions — processa partição inteira (eficiente para I/O)
def processar_particao(iter):
    for x in iter:
        yield x * 10

rdd_part = rdd.mapPartitions(processar_particao)
```

### 3.4 Ações em RDD

```python
# collect — trazer todos os dados para o Driver (cuidado com datasets grandes!)
dados = rdd.collect()

# count — contar elementos
total = rdd.count()

# take — primeiros N elementos
primeiros = rdd.take(5)

# first — primeiro elemento
primeiro = rdd.first()

# reduce — reduzir a um único valor
soma_total = rdd.reduce(lambda a, b: a + b)

# countByKey — contagem por chave (retorna dicionário Python)
contagem = rdd_pares.countByKey()

# saveAsTextFile — salvar em disco/HDFS/S3
rdd.saveAsTextFile("saida/resultado")

# foreach — executar função em cada elemento (side effects)
rdd.foreach(lambda x: print(x))
```

### 3.5 Cache e Persistência

```python
from pyspark import StorageLevel

# Cache em memória (padrão)
rdd.cache()

# Persistência com nível específico
rdd.persist(StorageLevel.MEMORY_AND_DISK)
# Níveis: MEMORY_ONLY, MEMORY_AND_DISK, DISK_ONLY, OFF_HEAP

# Liberar do cache
rdd.unpersist()
```

---

## 4. DataFrames e Datasets

### 4.1 DataFrame — API Principal

- Tabela distribuída com **schema definido** (colunas com tipos)
- API similar a Pandas, SQL e R data.frames
- Otimizado pelo **Catalyst Optimizer** e **Tungsten Engine**
- Muito mais performático que RDD para dados estruturados

```python
from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql.functions import *

spark = SparkSession.builder.appName("DataFrames").getOrCreate()
```

### 4.2 Criar DataFrame

```python
# A partir de lista Python
dados = [
    (1, "Dom Casmurro", "Portuguese", 1899, 45.90),
    (2, "1984",         "English",    1949, 59.90),
    (3, "Cem Anos",     "Spanish",    1967, 55.00),
]
colunas = ["id", "titulo", "idioma", "ano", "preco"]

df = spark.createDataFrame(dados, colunas)

# Schema explícito
schema = StructType([
    StructField("id",     IntegerType(), nullable=False),
    StructField("titulo", StringType(),  nullable=False),
    StructField("idioma", StringType(),  nullable=True),
    StructField("ano",    IntegerType(), nullable=True),
    StructField("preco",  DoubleType(),  nullable=True),
])

df = spark.createDataFrame(dados, schema)

# A partir de Pandas DataFrame
import pandas as pd
pdf = pd.DataFrame({"nome": ["Ana", "Bruno"], "nota": [9.5, 8.0]})
df_spark = spark.createDataFrame(pdf)

# A partir de RDD
df_from_rdd = rdd_pares.toDF(["palavra", "contagem"])
```

### 4.3 Inspecionar DataFrame

```python
# Ver schema (tipos de dados)
df.printSchema()

# Primeiras N linhas
df.show(5)
df.show(5, truncate=False)  # sem truncar strings

# Contar linhas
df.count()

# Estatísticas descritivas
df.describe().show()
df.describe("preco", "ano").show()

# Colunas e tipos
print(df.columns)
print(df.dtypes)

# Shape (linhas, colunas)
print((df.count(), len(df.columns)))
```

---

## 5. Spark SQL

### 5.1 Consultas SQL sobre DataFrames

```python
# Registrar DataFrame como tabela temporária
df.createOrReplaceTempView("livros")

# Consulta SQL pura
resultado = spark.sql("""
    SELECT idioma,
           COUNT(*)           AS quantidade,
           ROUND(AVG(preco), 2) AS media_preco,
           SUM(preco)         AS receita_total
    FROM livros
    GROUP BY idioma
    ORDER BY receita_total DESC
""")
resultado.show()

# Query com subquery
spark.sql("""
    SELECT titulo, preco
    FROM livros
    WHERE preco > (SELECT AVG(preco) FROM livros)
    ORDER BY preco DESC
""").show()

# CTE no Spark SQL
spark.sql("""
    WITH livros_caros AS (
        SELECT * FROM livros WHERE preco > 50
    ),
    por_idioma AS (
        SELECT idioma, COUNT(*) AS qtd
        FROM livros_caros
        GROUP BY idioma
    )
    SELECT * FROM por_idioma ORDER BY qtd DESC
""").show()
```

### 5.2 Tabelas Globais e Catálogo

```python
# Tabela global (persiste entre sessões — se usar Hive Metastore)
df.write.saveAsTable("livros_global")

# Tabela temporária global (visível em todas as sessões)
df.createOrReplaceGlobalTempView("livros_global_temp")
spark.sql("SELECT * FROM global_temp.livros_global_temp").show()

# Listar tabelas disponíveis
spark.catalog.listTables()

# Verificar se tabela existe
spark.catalog.tableExists("livros")

# Cache de tabela SQL
spark.catalog.cacheTable("livros")
spark.catalog.uncacheTable("livros")
```

### 5.3 Funções SQL Embutidas

```python
# Via API de DataFrame (equivalente ao SQL)
from pyspark.sql.functions import (
    col, lit, expr,
    upper, lower, trim, length, substring, split, regexp_replace,
    year, month, dayofweek, date_format, datediff, to_date,
    round, abs, sqrt, log, pow,
    sum, avg, count, min, max, countDistinct,
    when, coalesce, isnull, isnan,
    concat, concat_ws, format_string,
    rank, dense_rank, row_number, ntile, lag, lead,
    window, explode, posexplode, collect_list, collect_set,
    struct, array, map_keys, map_values
)

# Equivalência SQL vs API
spark.sql("SELECT upper(titulo) FROM livros")
df.select(upper(col("titulo")))

spark.sql("SELECT * FROM livros WHERE preco > 50")
df.filter(col("preco") > 50)
```

---

## 6. Transformações e Ações

### 6.1 Seleção e Projeção

```python
# Selecionar colunas
df.select("titulo", "preco").show()
df.select(col("titulo"), col("preco") * 1.1).show()

# Renomear coluna
df.withColumnRenamed("titulo", "nome_livro").show()

# Adicionar coluna calculada
df_novo = df.withColumn("preco_com_iva", col("preco") * 1.12)
df_novo = df.withColumn("decada", (col("ano") / 10).cast("int") * 10)

# Remover colunas
df.drop("id", "ano").show()

# Selecionar com expressão
df.selectExpr("titulo", "preco * 1.1 AS preco_reajustado").show()

# Alias
df.select(col("titulo").alias("nome")).show()
```

### 6.2 Filtros

```python
# Filtrar com col()
df.filter(col("preco") > 50).show()

# Filtrar com string SQL
df.filter("preco > 50").show()

# where (alias de filter)
df.where(col("idioma") == "Portuguese").show()

# Múltiplas condições
df.filter((col("idioma") == "English") & (col("ano") > 1950)).show()
df.filter((col("idioma") == "Portuguese") | (col("preco") < 40)).show()

# IN
df.filter(col("idioma").isin("English", "Portuguese")).show()

# NOT
df.filter(~col("idioma").isin("Spanish")).show()

# NULL
df.filter(col("preco").isNull()).show()
df.filter(col("preco").isNotNull()).show()

# LIKE
df.filter(col("titulo").like("%Dom%")).show()

# BETWEEN
df.filter(col("ano").between(1900, 1950)).show()

# REGEXP
df.filter(col("titulo").rlike("^[A-Z]")).show()
```

### 6.3 Agregações

```python
# Agregar o DataFrame inteiro
df.agg(
    count("*").alias("total"),
    avg("preco").alias("media_preco"),
    sum("preco").alias("receita"),
    min("preco").alias("menor_preco"),
    max("preco").alias("maior_preco"),
    countDistinct("idioma").alias("qtd_idiomas")
).show()

# GroupBy + Agg
df.groupBy("idioma").agg(
    count("*").alias("quantidade"),
    round(avg("preco"), 2).alias("media"),
    sum("preco").alias("receita")
).orderBy(col("receita").desc()).show()

# Pivot — crosstab
df.groupBy("idioma").pivot("decada").agg(count("*")).show()

# collect_list / collect_set
df.groupBy("idioma") \
  .agg(collect_list("titulo").alias("titulos")) \
  .show(truncate=False)
```

### 6.4 Joins

```python
# Criar segundo DataFrame de autores
autores = spark.createDataFrame([
    (1, "Machado de Assis", "Brasileiro"),
    (2, "George Orwell",    "Inglês"),
    (3, "Gabriel García Márquez", "Colombiano"),
], ["autor_id", "nome_autor", "nacionalidade"])

livros = spark.createDataFrame([
    (1, "Dom Casmurro", 1, 45.90),
    (2, "1984",         2, 59.90),
    (3, "Cem Anos",     3, 55.00),
    (4, "Sem Autor",    None, 20.00),
], ["id", "titulo", "autor_id", "preco"])

# INNER JOIN (padrão)
livros.join(autores, "autor_id").show()

# Evitar ambiguidade de nomes: broadcast ou condição explícita
from pyspark.sql.functions import broadcast

livros.join(broadcast(autores), livros.autor_id == autores.autor_id, "inner") \
      .select(livros.titulo, autores.nome_autor) \
      .show()

# LEFT JOIN — todos os livros, mesmo sem autor
livros.join(autores, livros.autor_id == autores.autor_id, "left") \
      .show()

# RIGHT JOIN
livros.join(autores, livros.autor_id == autores.autor_id, "right").show()

# FULL OUTER JOIN
livros.join(autores, livros.autor_id == autores.autor_id, "outer").show()

# CROSS JOIN
livros.crossJoin(autores).show()

# SEMI JOIN — filtra livros que TÊM autor (sem trazer colunas do autor)
livros.join(autores, livros.autor_id == autores.autor_id, "leftsemi").show()

# ANTI JOIN — livros que NÃO têm autor
livros.join(autores, livros.autor_id == autores.autor_id, "leftanti").show()
```

### 6.5 Ordenação, Deduplicação e Sampling

```python
# Ordenar
df.orderBy("preco").show()
df.orderBy(col("preco").desc()).show()
df.orderBy(col("idioma"), col("preco").desc()).show()

# Remover duplicatas
df.distinct().show()
df.dropDuplicates(["titulo", "idioma"]).show()

# Valores nulos
df.dropna().show()                          # remove qualquer linha com null
df.dropna(subset=["preco"]).show()          # apenas na coluna preco
df.fillna(0, subset=["preco"]).show()       # preenche null com 0
df.fillna({"preco": 0.0, "ano": 2000}).show()

# Amostragem
df.sample(fraction=0.1, seed=42).show()                  # 10% aleatório
df.sample(withReplacement=False, fraction=0.2).show()

# Dividir em treino/teste (ML)
treino, teste = df.randomSplit([0.8, 0.2], seed=42)
```

### 6.6 UNION e Set Operations

```python
df1 = spark.createDataFrame([(1, "A"), (2, "B")], ["id", "val"])
df2 = spark.createDataFrame([(2, "B"), (3, "C")], ["id", "val"])

# Union (preserva duplicatas — como UNION ALL em SQL)
df1.union(df2).show()

# Union sem duplicatas
df1.union(df2).distinct().show()

# unionByName (alinha por nome de coluna, não posição)
df1.unionByName(df2).show()

# Intersect
df1.intersect(df2).show()

# Except (diferença)
df1.exceptAll(df2).show()
```

---

## 7. Leitura e Escrita de Dados

### 7.1 Formatos de Leitura

```python
# CSV
df_csv = spark.read \
    .option("header", "true") \
    .option("inferSchema", "true") \
    .option("delimiter", ";") \
    .option("encoding", "UTF-8") \
    .csv("dados/livros.csv")

# CSV com schema explícito (mais performático — evita inferência)
schema = StructType([
    StructField("id",    IntegerType(), True),
    StructField("nome",  StringType(),  True),
    StructField("preco", DoubleType(),  True),
])
df_csv = spark.read.schema(schema).csv("dados/livros.csv")

# JSON
df_json = spark.read.option("multiline", "true").json("dados/livros.json")

# Parquet (formato colunar — recomendado para Spark)
df_parquet = spark.read.parquet("dados/livros.parquet")

# ORC (alternativa ao Parquet, nativo do Hive)
df_orc = spark.read.orc("dados/livros.orc")

# Avro
df_avro = spark.read.format("avro").load("dados/livros.avro")

# Delta Lake (formato transacional — Databricks/OSS)
df_delta = spark.read.format("delta").load("dados/livros_delta")

# JDBC (banco relacional)
df_mysql = spark.read \
    .format("jdbc") \
    .option("url", "jdbc:mysql://localhost:3306/livraria") \
    .option("dbtable", "livros") \
    .option("user", "root") \
    .option("password", "senha") \
    .option("driver", "com.mysql.cj.jdbc.Driver") \
    .load()

# Leitura particionada (Hive-style partitioning)
df_part = spark.read.parquet("dados/vendas/ano=2024/mes=01/")

# Leitura de múltiplos arquivos
df_multi = spark.read.csv("dados/mes_*.csv", header=True, inferSchema=True)
```

### 7.2 Escrita de Dados

```python
# CSV
df.write \
  .mode("overwrite") \
  .option("header", "true") \
  .csv("saida/livros_csv")

# Parquet (compressão Snappy por padrão)
df.write.mode("overwrite").parquet("saida/livros.parquet")

# Parquet com particionamento
df.write \
  .mode("overwrite") \
  .partitionBy("idioma", "decada") \
  .parquet("saida/livros_particionado")

# JSON
df.write.mode("append").json("saida/livros_json")

# Delta Lake
df.write.format("delta").mode("overwrite").save("saida/livros_delta")

# JDBC
df.write \
  .format("jdbc") \
  .option("url", "jdbc:postgresql://host:5432/db") \
  .option("dbtable", "livros_processados") \
  .option("user", "user") \
  .option("password", "pass") \
  .mode("append") \
  .save()

# Modos de escrita
# overwrite  — substitui tudo
# append     — adiciona aos dados existentes
# ignore     — não faz nada se já existir
# error      — lança erro se já existir (padrão)

# Coalescer antes de escrever (controlar número de arquivos)
df.coalesce(1).write.mode("overwrite").parquet("saida/arquivo_unico")
df.repartition(10).write.mode("overwrite").parquet("saida/10_arquivos")
```

### 7.3 Leitura na Cloud

```python
# AWS S3
df_s3 = spark.read.parquet("s3a://meu-bucket/dados/livros/")

# Google Cloud Storage
df_gcs = spark.read.csv("gs://meu-bucket/dados/livros.csv", header=True)

# Azure Blob Storage
spark.conf.set("fs.azure.account.key.<conta>.blob.core.windows.net", "<chave>")
df_azure = spark.read.parquet("wasbs://<container>@<conta>.blob.core.windows.net/dados/")

# Azure Data Lake Gen2
spark.conf.set("fs.azure.account.auth.type.<conta>.dfs.core.windows.net", "OAuth")
df_adls = spark.read.parquet("abfss://<container>@<conta>.dfs.core.windows.net/dados/")
```

---

## 8. Manipulação Avançada de Dados

### 8.1 Window Functions

```python
from pyspark.sql.window import Window
from pyspark.sql.functions import rank, dense_rank, row_number, lag, lead, \
                                   sum as spark_sum, avg as spark_avg, \
                                   first, last, ntile, percent_rank, cume_dist

# Definir janela: particionada por idioma, ordenada por preço decrescente
janela_idioma = Window.partitionBy("idioma").orderBy(col("preco").desc())

# Ranking por idioma
df_ranked = df.withColumn("rank",       rank()       .over(janela_idioma)) \
              .withColumn("dense_rank", dense_rank() .over(janela_idioma)) \
              .withColumn("row_number", row_number() .over(janela_idioma))

df_ranked.show()

# Top-3 por idioma
df_ranked.filter(col("rank") <= 3).show()

# Comparar com linha anterior (LAG) e próxima (LEAD)
janela_ano = Window.orderBy("ano")

df.withColumn("preco_anterior",  lag("preco",  1).over(janela_ano)) \
  .withColumn("preco_proximo",   lead("preco", 1).over(janela_ano)) \
  .withColumn("variacao",
              col("preco") - lag("preco", 1).over(janela_ano)) \
  .show()

# Soma acumulada
janela_acum = Window.orderBy("ano").rowsBetween(Window.unboundedPreceding, Window.currentRow)
df.withColumn("preco_acumulado", spark_sum("preco").over(janela_acum)).show()

# Média móvel de 3 registros
janela_movel = Window.orderBy("ano").rowsBetween(-1, 1)
df.withColumn("media_movel_3", spark_avg("preco").over(janela_movel)).show()

# Percentil de cada livro dentro do idioma
janela_pct = Window.partitionBy("idioma").orderBy("preco")
df.withColumn("percentil", percent_rank().over(janela_pct)).show()

# Quartis
df.withColumn("quartil", ntile(4).over(Window.orderBy("preco"))).show()
```

### 8.2 Funções de Array e Struct

```python
# Explodir array em múltiplas linhas
df_tags = spark.createDataFrame([
    (1, "Dom Casmurro", ["romance", "classico", "brasileiro"]),
    (2, "1984",         ["distopia", "politica"]),
], ["id", "titulo", "tags"])

df_tags.select("titulo", explode("tags").alias("tag")).show()

# posexplode — retorna posição + valor
df_tags.select("titulo", posexplode("tags").alias("pos", "tag")).show()

# array_contains
from pyspark.sql.functions import array_contains, array_size, array_distinct, \
                                   array_sort, arrays_zip, flatten, sequence

df_tags.filter(array_contains(col("tags"), "classico")).show()
df_tags.withColumn("qtd_tags", array_size(col("tags"))).show()

# Criar array a partir de colunas
df.withColumn("info",
    array(col("titulo"), col("idioma"))).show()

# Struct (registro aninhado)
df.withColumn("metadados",
    struct(col("ano"), col("preco"))).show()

# Mapear com transform (Spark 3.1+)
from pyspark.sql.functions import transform, filter as arr_filter, forall

df_tags.withColumn("tags_upper",
    transform(col("tags"), lambda x: upper(x))).show()
```

### 8.3 Funções de Datas

```python
from pyspark.sql.functions import (
    current_date, current_timestamp,
    year, month, dayofmonth, hour, minute, second,
    date_add, date_sub, add_months, months_between, datediff,
    date_format, to_date, to_timestamp,
    last_day, next_day, trunc, date_trunc
)

df.withColumn("hoje",         current_date()) \
  .withColumn("ano_pub",      year(col("data_publicacao"))) \
  .withColumn("mes_pub",      month(col("data_publicacao"))) \
  .withColumn("daqui_30d",    date_add(current_date(), 30)) \
  .withColumn("ha_1_ano",     date_sub(current_date(), 365)) \
  .withColumn("dias_passados", datediff(current_date(), col("data_publicacao"))) \
  .withColumn("data_fmt",     date_format(col("data_publicacao"), "dd/MM/yyyy")) \
  .withColumn("data_br",      to_date(lit("21/04/2026"), "dd/MM/yyyy")) \
  .show()
```

### 8.4 UDFs — User Defined Functions

```python
from pyspark.sql.functions import udf
from pyspark.sql.types import StringType, DoubleType

# UDF Python simples
def classificar_preco(preco):
    if preco is None:
        return "Sem preço"
    elif preco < 30:
        return "Barato"
    elif preco < 60:
        return "Médio"
    elif preco < 100:
        return "Caro"
    else:
        return "Premium"

# Registrar UDF
classificar_preco_udf = udf(classificar_preco, StringType())

# Usar em select
df.withColumn("categoria", classificar_preco_udf(col("preco"))).show()

# Registrar para uso em SQL
spark.udf.register("classificar_preco", classificar_preco, StringType())
spark.sql("SELECT titulo, classificar_preco(preco) AS categoria FROM livros").show()

# Pandas UDF (Vectorized UDF) — muito mais performático
from pyspark.sql.functions import pandas_udf
import pandas as pd

@pandas_udf(DoubleType())
def preco_com_desconto(preco: pd.Series) -> pd.Series:
    return (preco * 0.9).round(2)

df.withColumn("preco_desconto", preco_com_desconto(col("preco"))).show()

# AVISO: UDFs Python quebram a otimização do Catalyst!
# Sempre prefira funções nativas (pyspark.sql.functions) quando disponíveis.
```

---

## 9. MLlib — Machine Learning Distribuído

### 9.1 Conceitos do Pipeline de ML

```python
# MLlib usa o conceito de Pipeline similar ao scikit-learn
# Etapas: Transformer (transforma dados) e Estimator (treina modelo)

from pyspark.ml import Pipeline
from pyspark.ml.feature import (
    StringIndexer, OneHotEncoder, VectorAssembler, StandardScaler,
    PCA, Word2Vec, IDF, Tokenizer, StopWordsRemover, HashingTF,
    MinMaxScaler, Bucketizer, QuantileDiscretizer, Imputer
)
from pyspark.ml.classification import (
    LogisticRegression, RandomForestClassifier,
    GBTClassifier, DecisionTreeClassifier, NaiveBayes
)
from pyspark.ml.regression import (
    LinearRegression, RandomForestRegressor,
    GBTRegressor, DecisionTreeRegressor
)
from pyspark.ml.clustering import KMeans, BisectingKMeans, GaussianMixture
from pyspark.ml.evaluation import (
    BinaryClassificationEvaluator, MulticlassClassificationEvaluator,
    RegressionEvaluator, ClusteringEvaluator
)
from pyspark.ml.tuning import ParamGridBuilder, CrossValidator, TrainValidationSplit
```

### 9.2 Pré-processamento de Features

```python
# Dataset de exemplo
dados_ml = spark.createDataFrame([
    (1, "Portuguese", 1899, 45.90, 1),
    (2, "English",    1949, 59.90, 1),
    (3, "Spanish",    1967, 55.00, 0),
    (4, "English",    1960, 30.00, 0),
    (5, "Portuguese", 2000, 80.00, 1),
], ["id", "idioma", "ano", "preco", "label"])

# StringIndexer — codificar categórico em numérico
indexer = StringIndexer(inputCol="idioma", outputCol="idioma_idx")

# OneHotEncoder — criar variáveis dummy
encoder = OneHotEncoder(inputCol="idioma_idx", outputCol="idioma_ohe")

# Imputer — preencher valores nulos
imputer = Imputer(inputCols=["preco", "ano"], outputCols=["preco_imp", "ano_imp"])

# VectorAssembler — combinar features em vetor único (obrigatório no MLlib)
assembler = VectorAssembler(
    inputCols=["idioma_ohe", "ano_imp", "preco_imp"],
    outputCol="features"
)

# StandardScaler — normalizar features
scaler = StandardScaler(inputCol="features", outputCol="features_scaled",
                        withMean=True, withStd=True)

# Pipeline de pré-processamento
prep_pipeline = Pipeline(stages=[indexer, encoder, imputer, assembler, scaler])
prep_model = prep_pipeline.fit(dados_ml)
df_prep = prep_model.transform(dados_ml)
df_prep.select("features_scaled", "label").show(truncate=False)
```

### 9.3 Classificação

```python
# Divisão treino/teste
treino, teste = dados_ml.randomSplit([0.8, 0.2], seed=42)

# Pipeline completo: pré-processamento + modelo
lr = LogisticRegression(
    featuresCol="features_scaled",
    labelCol="label",
    maxIter=100,
    regParam=0.01
)

pipeline_completo = Pipeline(stages=[indexer, encoder, imputer, assembler, scaler, lr])
modelo = pipeline_completo.fit(treino)
predicoes = modelo.transform(teste)

predicoes.select("titulo", "label", "prediction", "probability").show()

# Avaliar modelo
avaliador = BinaryClassificationEvaluator(labelCol="label")
auc = avaliador.evaluate(predicoes)
print(f"AUC-ROC: {auc:.4f}")

avaliador_mc = MulticlassClassificationEvaluator(labelCol="label", metricName="accuracy")
acc = avaliador_mc.evaluate(predicoes)
print(f"Acurácia: {acc:.4f}")

# Random Forest
rf = RandomForestClassifier(
    featuresCol="features_scaled",
    labelCol="label",
    numTrees=100,
    maxDepth=5,
    seed=42
)

# GBT (Gradient Boosted Trees)
gbt = GBTClassifier(featuresCol="features_scaled", labelCol="label", maxIter=50)
```

### 9.4 Regressão

```python
lr_reg = LinearRegression(
    featuresCol="features_scaled",
    labelCol="preco",
    maxIter=100,
    regParam=0.01,
    elasticNetParam=0.5  # 0 = Ridge, 1 = Lasso
)

modelo_reg = lr_reg.fit(treino)

# Coeficientes
print("Coeficientes:", modelo_reg.coefficients)
print("Intercepto:", modelo_reg.intercept)
print("R²:", modelo_reg.summary.r2)
print("RMSE:", modelo_reg.summary.rootMeanSquaredError)

# Avaliar
avaliador_reg = RegressionEvaluator(labelCol="preco", metricName="rmse")
rmse = avaliador_reg.evaluate(modelo_reg.transform(teste))
print(f"RMSE: {rmse:.2f}")
```

### 9.5 Clustering

```python
from pyspark.ml.clustering import KMeans

kmeans = KMeans(featuresCol="features_scaled", k=3, seed=42, maxIter=20)
modelo_km = kmeans.fit(df_prep)

# Centróides
print("Centróides:", modelo_km.clusterCenters())

# Adicionar cluster ao DataFrame
df_clusters = modelo_km.transform(df_prep)
df_clusters.select("titulo", "prediction").show()

# Silhueta (qualidade do clustering)
from pyspark.ml.evaluation import ClusteringEvaluator
avaliador_cl = ClusteringEvaluator()
silhueta = avaliador_cl.evaluate(df_clusters)
print(f"Silhueta: {silhueta:.4f}")

# Encontrar K ótimo (elbow method)
custos = []
for k in range(2, 10):
    km_k = KMeans(featuresCol="features_scaled", k=k, seed=42)
    m = km_k.fit(df_prep)
    custos.append((k, m.summary.trainingCost))
```

### 9.6 Hyperparameter Tuning

```python
# Grid Search com Cross-Validation
lr_tuning = LogisticRegression(featuresCol="features_scaled", labelCol="label")

param_grid = ParamGridBuilder() \
    .addGrid(lr_tuning.regParam,       [0.001, 0.01, 0.1]) \
    .addGrid(lr_tuning.elasticNetParam, [0.0, 0.5, 1.0]) \
    .addGrid(lr_tuning.maxIter,        [50, 100]) \
    .build()

avaliador = BinaryClassificationEvaluator(labelCol="label")

cv = CrossValidator(
    estimator=lr_tuning,
    estimatorParamMaps=param_grid,
    evaluator=avaliador,
    numFolds=5,
    seed=42
)

cv_model = cv.fit(treino)
print("Melhores parâmetros:", cv_model.bestModel.extractParamMap())
print("AUC melhor modelo:", avaliador.evaluate(cv_model.transform(teste)))

# Salvar e carregar modelo
cv_model.bestModel.save("modelos/melhor_lr")
from pyspark.ml.classification import LogisticRegressionModel
modelo_carregado = LogisticRegressionModel.load("modelos/melhor_lr")
```

---

## 10. Spark Streaming e Structured Streaming

### 10.1 Structured Streaming — Conceitos

- Processa streams como **tabelas que crescem continuamente**
- API idêntica ao DataFrame batch — unificação total
- Suporte a **event time**, **watermarks** e **late data**
- Fontes: Kafka, socket, arquivos, Rate (teste), Delta Lake

```
Microbatch Model:
  ┌──────────┐   trigger   ┌────────────────────────┐
  │  Source  │ ──────────► │  SparkSession (driver) │
  │ (Kafka)  │             │  Incremental DAG       │
  └──────────┘             └────────────┬───────────┘
                                        │ processa
                              ┌─────────▼──────────┐
                              │   Sink (destino)   │
                              │ (console/Parquet/  │
                              │  Kafka/Delta)      │
                              └────────────────────┘
```

### 10.2 Leitura de Stream

```python
# Fonte: diretório de arquivos (lê arquivos novos conforme chegam)
df_stream = spark.readStream \
    .option("maxFilesPerTrigger", 1) \
    .schema(schema) \
    .csv("entrada/stream/")

# Fonte: Kafka
df_kafka = spark.readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", "localhost:9092") \
    .option("subscribe", "topico_livros") \
    .option("startingOffsets", "earliest") \
    .load()

# Deserializar JSON do Kafka
from pyspark.sql.functions import from_json

schema_evento = StructType([
    StructField("id",    IntegerType(), True),
    StructField("preco", DoubleType(),  True),
    StructField("ts",    TimestampType(), True),
])

df_kafka_parsed = df_kafka \
    .select(from_json(col("value").cast("string"), schema_evento).alias("data")) \
    .select("data.*")

# Fonte: Rate (gerador para testes)
df_rate = spark.readStream.format("rate").option("rowsPerSecond", 100).load()
```

### 10.3 Transformações de Stream

```python
# Transformações idênticas ao batch!
df_processado = df_kafka_parsed \
    .filter(col("preco") > 0) \
    .withColumn("categoria", classificar_preco_udf(col("preco"))) \
    .withColumn("ts_processado", current_timestamp())

# Agregação com Watermark (tolera dados atrasados até 10 minutos)
from pyspark.sql.functions import window

df_agg = df_kafka_parsed \
    .withWatermark("ts", "10 minutes") \
    .groupBy(
        window(col("ts"), "5 minutes", "1 minute"),   # janela de 5min, slide 1min
        col("categoria")
    ) \
    .agg(
        count("*").alias("total"),
        avg("preco").alias("media_preco")
    )
```

### 10.4 Escrita de Stream (Sinks)

```python
# Console (debug)
query_console = df_processado \
    .writeStream \
    .format("console") \
    .outputMode("append") \
    .trigger(processingTime="30 seconds") \
    .start()

# Parquet (append)
query_parquet = df_processado \
    .writeStream \
    .format("parquet") \
    .option("checkpointLocation", "checkpoints/parquet") \
    .option("path", "saida/stream/") \
    .outputMode("append") \
    .trigger(processingTime="1 minute") \
    .start()

# Delta Lake (recomendado — suporta upsert em stream)
query_delta = df_processado \
    .writeStream \
    .format("delta") \
    .option("checkpointLocation", "checkpoints/delta") \
    .outputMode("append") \
    .start("saida/delta_stream")

# Kafka como sink
query_kafka = df_processado \
    .selectExpr("CAST(id AS STRING) AS key",
                "to_json(struct(*)) AS value") \
    .writeStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", "localhost:9092") \
    .option("topic", "topico_saida") \
    .option("checkpointLocation", "checkpoints/kafka") \
    .start()

# Output modes:
# "append"  — apenas linhas novas (padrão para sem-aggregate)
# "update"  — apenas linhas alteradas
# "complete"— toda a tabela a cada microbatch (para aggregations)

# Aguardar término (produção)
query_console.awaitTermination()

# Parar query
query_console.stop()
```

### 10.5 Foreach e ForeachBatch

```python
# foreachBatch — executar código customizado a cada microbatch
def processar_batch(df_batch, epoch_id):
    # Pode usar qualquer operação batch aqui!
    df_batch.write \
        .mode("append") \
        .parquet(f"saida/batch_{epoch_id}")
    df_batch.createOrReplaceTempView("batch_atual")
    spark.sql("INSERT INTO historico SELECT * FROM batch_atual")

query = df_stream.writeStream \
    .foreachBatch(processar_batch) \
    .start()
```

---

## 11. GraphX — Processamento de Grafos

### 11.1 Conceito

- API do Spark para processar **grafos distribuídos**
- Disponível nativamente em Scala; em Python usa-se **GraphFrames** (library externa)
- Casos de uso: redes sociais, recomendação, detecção de comunidades, rotas

```python
# Instalar GraphFrames
# pip install graphframes
# spark-submit --packages graphframes:graphframes:0.8.3-spark3.5-s_2.12 script.py

from graphframes import GraphFrame

# Vértices (nós)
vertices = spark.createDataFrame([
    ("a", "Alice",  34),
    ("b", "Bob",    36),
    ("c", "Carlos", 30),
    ("d", "Diana",  29),
], ["id", "nome", "idade"])

# Arestas (relacionamentos)
arestas = spark.createDataFrame([
    ("a", "b", "amigo"),
    ("b", "c", "colega"),
    ("c", "d", "amigo"),
    ("a", "d", "familiar"),
], ["src", "dst", "relacionamento"])

g = GraphFrame(vertices, arestas)

# Consultas básicas
g.vertices.show()
g.edges.show()
g.degrees.show()           # grau de cada vértice
g.inDegrees.show()         # grau de entrada
g.outDegrees.show()        # grau de saída

# Filtrar subgrafo
g_amigos = g.filterEdges(col("relacionamento") == "amigo")

# PageRank
resultados_pr = g.pageRank(resetProbability=0.15, maxIter=10)
resultados_pr.vertices.select("id", "nome", "pagerank").orderBy("pagerank", ascending=False).show()

# Detecção de componentes conectados
g.connectedComponents().show()

# Detecção de comunidades (Label Propagation)
g.labelPropagation(maxIter=5).show()

# Busca por padrão (motif finding)
# Encontrar triângulos: a → b → c ← a
g.find("(a)-[e1]->(b); (b)-[e2]->(c); (a)-[e3]->(c)") \
 .filter("e1.relacionamento = 'amigo' AND e3.relacionamento = 'amigo'") \
 .show()
```

---

## 12. Otimização e Tuning

### 12.1 Catalyst Optimizer e Tungsten Engine

```
Pergunta SQL/DataFrame
        │
        ▼
┌─────────────────────┐
│   Unresolved Plan   │ — parse da query
└──────────┬──────────┘
           │ Analysis (resolve nomes de tabelas/colunas)
┌──────────▼──────────┐
│   Analyzed Plan     │
└──────────┬──────────┘
           │ Optimization (push down, predicate pushdown, constant folding...)
┌──────────▼──────────┐
│  Optimized Plan     │
└──────────┬──────────┘
           │ Physical Planning (escolhe join strategy, etc.)
┌──────────▼──────────┐
│   Physical Plan     │ — RDDs e bytecode Tungsten
└─────────────────────┘
```

```python
# Ver plano de execução
df.explain()                    # plano físico simplificado
df.explain(True)                # todos os planos (logical + physical)
df.explain("formatted")        # formato legível (Spark 3+)
df.explain("cost")             # com estimativas de custo
```

### 12.2 Particionamento

```python
# Verificar número de partições
print(df.rdd.getNumPartitions())

# Repartition — redistribui dados com shuffle (mais custoso, balanceado)
df_part = df.repartition(200)
df_part_col = df.repartition(200, col("idioma"))  # por coluna (co-localização)

# Coalesce — reduz partições SEM shuffle (mais barato, pode gerar skew)
df_coalesc = df.coalesce(10)

# Regra geral:
# - Use repartition para aumentar partições ou redistribuir
# - Use coalesce para reduzir (antes de salvar um arquivo)
# - Alvo: ~128-256 MB por partição; 2-4× nº de cores disponíveis

# Configurar partições de shuffle (padrão: 200)
spark.conf.set("spark.sql.shuffle.partitions", "400")

# Spark 3+: AQE (Adaptive Query Execution) ajusta automaticamente
spark.conf.set("spark.sql.adaptive.enabled", "true")
spark.conf.set("spark.sql.adaptive.coalescePartitions.enabled", "true")
```

### 12.3 Broadcast Join

```python
from pyspark.sql.functions import broadcast

# Forçar broadcast de tabela pequena (evita shuffle)
# Padrão: tabelas menores que spark.sql.autoBroadcastJoinThreshold (10MB)
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", 50 * 1024 * 1024)  # 50MB

# Join com broadcast explícito
resultado = livros_grande.join(
    broadcast(tabela_pequena_generos),
    "genero_id"
)

# Broadcast de variável para RDD
lookup_dict = {"Portuguese": "Português", "English": "Inglês"}
broadcast_var = sc.broadcast(lookup_dict)

rdd.map(lambda row: broadcast_var.value.get(row["idioma"], row["idioma"]))
```

### 12.4 Cache e Persitência Estratégica

```python
from pyspark import StorageLevel

# Quando usar cache:
# - DataFrame usado múltiplas vezes no mesmo job
# - Resultado de join/aggregation caro reusado
# - Treino de ML (dados processados usados em loop)

df_base = df.filter(...).join(...).cache()       # MEMORY_AND_DISK por padrão
df_base.count()  # materializa o cache

# Nível explícito
df.persist(StorageLevel.MEMORY_ONLY)             # só RAM — rápido
df.persist(StorageLevel.MEMORY_AND_DISK)         # RAM + disco se precisar
df.persist(StorageLevel.DISK_ONLY)               # só disco
df.persist(StorageLevel.MEMORY_AND_DISK_SER)     # serializado (menos RAM)
df.persist(StorageLevel.OFF_HEAP)                # fora do heap JVM (Tungsten allocator)

# Liberar cache ao terminar
df_base.unpersist()

# Verificar storage no UI do Spark (http://localhost:4040 → Storage)
```

### 12.5 Evitar Data Skew

```python
# Data Skew: uma partição tem muito mais dados que as outras → bottleneck

# Detectar skew via explain e métricas
df.groupBy("chave_skewed").count().orderBy(col("count").desc()).show()

# Solução 1: Salting — adicionar ruído aleatório à chave
import random
from pyspark.sql.functions import concat, lit

NUM_SALT = 10

df_salted = df.withColumn("chave_salt",
    concat(col("chave_skewed"), lit("_"), (col("id") % NUM_SALT).cast("string")))

# Solução 2: AQE (Spark 3+) — Skew Join automático
spark.conf.set("spark.sql.adaptive.skewJoin.enabled", "true")
spark.conf.set("spark.sql.adaptive.skewJoin.skewedPartitionFactor", "5")

# Solução 3: Repartition por hash de chave antes do join
df_repart = df.repartition(400, col("chave_skewed"))
```

### 12.6 Configurações de Performance

```python
# Configurações essenciais de produção
spark = SparkSession.builder \
    .appName("ETL_Producao") \
    # Memória
    .config("spark.executor.memory",         "8g") \
    .config("spark.executor.memoryFraction", "0.8") \
    .config("spark.driver.memory",           "4g") \
    # Núcleos
    .config("spark.executor.cores",          "4") \
    .config("spark.task.cpus",               "1") \
    # Shuffle
    .config("spark.sql.shuffle.partitions",  "400") \
    .config("spark.shuffle.compress",        "true") \
    .config("spark.shuffle.spill.compress",  "true") \
    # AQE (Spark 3+)
    .config("spark.sql.adaptive.enabled",                      "true") \
    .config("spark.sql.adaptive.coalescePartitions.enabled",   "true") \
    .config("spark.sql.adaptive.skewJoin.enabled",             "true") \
    # Serialização
    .config("spark.serializer", "org.apache.spark.serializer.KryoSerializer") \
    .config("spark.kryoserializer.buffer.max", "2047m") \
    # Broadcast
    .config("spark.sql.autoBroadcastJoinThreshold", str(50 * 1024 * 1024)) \
    .getOrCreate()
```

### 12.7 Monitoramento — Spark UI

```
Spark UI (http://driver-host:4040):

├── Jobs        — lista de jobs com status e duração
├── Stages      — detalhes de cada stage, tasks, shuffle I/O
├── Storage     — tabelas/RDDs em cache com uso de memória
├── Environment — configurações ativas da sessão
├── Executors   — status de cada executor, GC, shuffle
└── SQL         — planos de execução de queries SQL/DataFrame
```

---

## 13. Spark no Ambiente Cloud

### 13.1 AWS EMR (Elastic MapReduce)

```bash
# Criar cluster EMR com Spark via AWS CLI
aws emr create-cluster \
  --name "Spark-MBA" \
  --release-label emr-7.0.0 \
  --applications Name=Spark Name=Hadoop \
  --ec2-attributes KeyName=minha-chave \
  --instance-type m5.xlarge \
  --instance-count 3 \
  --use-default-roles

# Submeter job Spark
aws emr add-steps \
  --cluster-id j-XXXXXXXX \
  --steps Type=Spark,Name="MeuJob",\
          Args=[--deploy-mode,cluster,s3://meu-bucket/scripts/etl.py]
```

```python
# Leitura/escrita no S3 via EMR
df = spark.read.parquet("s3://meu-bucket/dados/livros/")
df.write.mode("overwrite").parquet("s3://meu-bucket/saida/resultado/")
```

### 13.2 Azure Databricks / HDInsight

```python
# Databricks — SparkSession disponível como 'spark' automaticamente
# Montar Azure Data Lake
configs = {
    "fs.azure.account.auth.type": "OAuth",
    "fs.azure.account.oauth.provider.type":
        "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
    "fs.azure.account.oauth2.client.id": "<client_id>",
    "fs.azure.account.oauth2.client.secret": "<secret>",
    "fs.azure.account.oauth2.client.endpoint":
        "https://login.microsoftonline.com/<tenant_id>/oauth2/token",
}

dbutils.fs.mount(
    source="abfss://container@conta.dfs.core.windows.net/",
    mount_point="/mnt/datalake",
    extra_configs=configs
)

# Ler dados montados
df = spark.read.parquet("/mnt/datalake/dados/livros/")

# Delta Lake (nativo no Databricks)
df.write.format("delta").mode("overwrite").save("/mnt/datalake/delta/livros")
spark.sql("OPTIMIZE delta.`/mnt/datalake/delta/livros`")
spark.sql("VACUUM delta.`/mnt/datalake/delta/livros` RETAIN 168 HOURS")
```

### 13.3 Google Dataproc

```bash
# Criar cluster Dataproc
gcloud dataproc clusters create meu-cluster \
  --region us-central1 \
  --num-workers 3 \
  --worker-machine-type n1-standard-4 \
  --image-version 2.1-debian11

# Submeter job
gcloud dataproc jobs submit pyspark \
  --cluster meu-cluster \
  --region us-central1 \
  gs://meu-bucket/scripts/etl.py
```

```python
# Ler do GCS dentro do job Dataproc
df = spark.read.parquet("gs://meu-bucket/dados/livros/")
df_resultado.write.mode("overwrite").parquet("gs://meu-bucket/saida/")
```

### 13.4 Delta Lake

```python
# Delta Lake: formato de storage com ACID, versionamento e time travel
# pip install delta-spark

from delta.tables import DeltaTable

# Criar tabela Delta
df.write.format("delta").mode("overwrite").save("/delta/livros")

# Time travel — ler versão anterior
df_v0 = spark.read.format("delta").option("versionAsOf", 0).load("/delta/livros")
df_ontem = spark.read.format("delta").option("timestampAsOf", "2026-04-20").load("/delta/livros")

# UPSERT (MERGE)
delta_table = DeltaTable.forPath(spark, "/delta/livros")

novos_dados = spark.createDataFrame([(2, "1984 Updated", "English", 1949, 69.90)], colunas)

delta_table.alias("alvo").merge(
    novos_dados.alias("fonte"),
    "alvo.id = fonte.id"
).whenMatchedUpdateAll() \
 .whenNotMatchedInsertAll() \
 .execute()

# Histórico de versões
delta_table.history().show()

# Otimizar (compactação de arquivos pequenos)
delta_table.optimize().executeCompaction()

# VACUUM (remover arquivos antigos)
delta_table.vacuum(retentionHours=168)
```

---

## 14. Boas Práticas e Padrões de Projeto

### 14.1 Princípios Gerais

| Prática               | Recomendação                                                              |
| --------------------- | ------------------------------------------------------------------------- |
| **Schema**            | Sempre definir schema explícito; evitar `inferSchema` em produção         |
| **Formato**           | Preferir Parquet ou Delta Lake; evitar CSV para dados grandes             |
| **Particionamento**   | Particionar por colunas de filtro (data, região, categoria)               |
| **Cache**             | Cache apenas quando dado é reutilizado ≥2 vezes; libere após uso          |
| **UDF**               | Evitar UDFs Python; usar funções nativas `pyspark.sql.functions`          |
| **SELECT**            | Nunca usar `select("*")` em produção; projetar apenas colunas necessárias |
| **Shuffle**           | Minimizar operações que causam shuffle (groupBy, join, distinct)          |
| **Pequenos arquivos** | Usar `coalesce` antes de salvar; otimizar com Delta `OPTIMIZE`            |
| **Checkpoint**        | Sempre definir `checkpointLocation` em Structured Streaming               |
| **AQE**               | Manter `spark.sql.adaptive.enabled=true` em Spark 3+                      |

### 14.2 Estrutura Recomendada de Pipeline

```python
# etl_livros.py

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, upper, current_timestamp

def criar_spark_session(app_name: str) -> SparkSession:
    return SparkSession.builder \
        .appName(app_name) \
        .config("spark.sql.adaptive.enabled", "true") \
        .config("spark.sql.shuffle.partitions", "200") \
        .getOrCreate()

def ler_dados(spark: SparkSession, caminho: str):
    schema = "id INT, titulo STRING, idioma STRING, ano INT, preco DOUBLE"
    return spark.read.schema(schema).parquet(caminho)

def transformar(df):
    return df \
        .filter(col("preco") > 0) \
        .withColumn("idioma_upper", upper(col("idioma"))) \
        .withColumn("processado_em", current_timestamp()) \
        .dropDuplicates(["id"])

def salvar(df, caminho: str):
    df.write \
      .mode("overwrite") \
      .partitionBy("idioma") \
      .parquet(caminho)

def main():
    spark = criar_spark_session("ETL_Livros")
    try:
        df_raw = ler_dados(spark, "s3://bucket/raw/livros/")
        df_proc = transformar(df_raw)
        salvar(df_proc, "s3://bucket/processed/livros/")
        print(f"Pipeline concluído. Registros: {df_proc.count()}")
    finally:
        spark.stop()

if __name__ == "__main__":
    main()
```

### 14.3 Teste de Pipelines Spark

```python
# pytest com PySpark
import pytest
from pyspark.sql import SparkSession
from meu_etl import transformar

@pytest.fixture(scope="session")
def spark():
    return SparkSession.builder \
        .master("local[2]") \
        .appName("Testes") \
        .getOrCreate()

def test_transformar_filtra_preco_negativo(spark):
    dados = spark.createDataFrame([
        (1, "A", "Portuguese", 2000, 45.0),
        (2, "B", "English",    1990, -5.0),  # deve ser filtrado
    ], ["id", "titulo", "idioma", "ano", "preco"])

    resultado = transformar(dados)
    assert resultado.count() == 1
    assert resultado.first()["id"] == 1

def test_transformar_idioma_em_maiusculo(spark):
    dados = spark.createDataFrame(
        [(1, "A", "english", 2000, 30.0)],
        ["id", "titulo", "idioma", "ano", "preco"]
    )
    resultado = transformar(dados)
    assert resultado.first()["idioma_upper"] == "ENGLISH"
```

### 14.4 Debugging Eficiente

```python
# Verificar plano de execução antes de rodar em produção
df_pipeline.explain("formatted")

# Contar partições e registros por partição
from pyspark.sql.functions import spark_partition_id
df.withColumn("part", spark_partition_id()) \
  .groupBy("part") \
  .count() \
  .orderBy("part") \
  .show()

# Rodar localmente em amostra antes de escalar
df_amostra = spark.read.parquet("s3://bucket/dados/") \
                 .limit(10000) \
                 .cache()
# Desenvolva e teste com df_amostra, depois troque pelo df completo

# Logs de Spark (ajustar nível)
import logging
logging.getLogger("py4j").setLevel(logging.ERROR)
spark.sparkContext.setLogLevel("WARN")  # DEBUG, INFO, WARN, ERROR
```

---

## 🗂️ Referências e Links Úteis

| Recurso                      | URL                                                                |
| ---------------------------- | ------------------------------------------------------------------ |
| Documentação oficial PySpark | https://spark.apache.org/docs/latest/api/python/                   |
| Spark SQL Functions          | https://spark.apache.org/docs/latest/api/sql/                      |
| Delta Lake                   | https://delta.io/learn/                                            |
| GraphFrames                  | https://graphframes.github.io/graphframes/                         |
| Databricks Academy           | https://www.databricks.com/learn/training                          |
| AWS EMR Spark                | https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-spark.html |
| Google Dataproc              | https://cloud.google.com/dataproc/docs                             |
| Spark Performance Tuning     | https://spark.apache.org/docs/latest/tuning.html                   |

---

_MBA Data Science e Analytics — USP/ESALQ | Apache Spark v3.x | PySpark_
