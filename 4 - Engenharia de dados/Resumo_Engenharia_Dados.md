# 🗄️ Resumo - Engenharia de Dados

## MBA em Data Science e Analytics USP/ESALQ

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos de engenharia de dados, incluindo modelagem de bancos de dados relacionais, linguagem SQL, manipulação de dados, otimização de consultas e boas práticas para estruturação e gerenciamento de dados em projetos de Data Science.

---

## 📚 Conteúdo Principal

### 1. **Fundamentos de Bancos de Dados**

#### 1.1 Conceitos Básicos

- **Banco de Dados**: coleção organizada de dados estruturados
- **SGBD (Sistema Gerenciador de Banco de Dados)**: software que gerencia BD
- **Tabela**: estrutura que armazena dados em linhas e colunas
- **Linha (Registro/Tupla)**: conjunto de valores relacionados
- **Coluna (Campo/Atributo)**: cada variável de uma tabela
- **Schema**: estrutura lógica do banco de dados

#### 1.2 Tipos de Bancos de Dados

**Relacionais (SQL)**:

- MySQL, PostgreSQL, SQL Server, Oracle
- Dados estruturados em tabelas
- Relacionamentos definidos por chaves
- ACID (Atomicity, Consistency, Isolation, Durability)

**Não Relacionais (NoSQL)**:

- MongoDB, Cassandra, Redis
- Flexibilidade de schema
- Escalabilidade horizontal
- Diferentes modelos: documento, chave-valor, colunar, grafo

#### 1.3 MySQL - Sistema Utilizado

- **Open source**: gratuito
- **Amplamente adotado**: indústria e academia
- **Performance**: rápido para leitura
- **Compatibilidade**: Windows, macOS, Linux
- **Ferramentas**: MySQL Workbench (interface gráfica)

---

### 2. **Modelagem de Dados**

#### 2.1 Modelo Entidade-Relacionamento (ER)

**Entidades**:

- Objetos do mundo real (Cliente, Produto, Pedido)
- Representadas como tabelas no banco

**Atributos**:

- Características das entidades
- Colunas das tabelas

**Relacionamentos**:

- Associações entre entidades
- 1:1 (um-para-um)
- 1:N (um-para-muitos)
- N:M (muitos-para-muitos)

#### 2.2 Chaves

**Chave Primária (Primary Key - PK)**:

```sql
create table cliente(
    id_cliente int auto_increment primary key,
    nome varchar(100) not null,
    email varchar(100) not null
);
```

- Identifica unicamente cada registro
- Não pode ser NULL
- `auto_increment`: incrementa automaticamente

**Chave Estrangeira (Foreign Key - FK)**:

```sql
create table livros(
    id int primary key,
    nome varchar(200),
    autor_id int,
    genero_id int,
    foreign key (autor_id) references autores(id),
    foreign key (genero_id) references generos(id)
);
```

- Referencia chave primária de outra tabela
- Define relacionamentos
- Mantém integridade referencial

#### 2.3 Normalização

**Objetivos**:

- Eliminar redundância
- Evitar anomalias de inserção, atualização e exclusão
- Facilitar manutenção

**Formas Normais**:

- **1FN**: atributos atômicos (sem listas)
- **2FN**: sem dependências parciais
- **3FN**: sem dependências transitivas
- **BCNF**: forma normal de Boyce-Codd

---

### 3. **SQL - Structured Query Language**

#### 3.1 DDL - Data Definition Language

**Criar Banco de Dados**:

```sql
create database livraria;
use livraria;
```

**Criar Tabela**:

```sql
create table livros(
    id int auto_increment primary key,
    nome varchar(200) not null,
    idioma varchar(50),
    ano_publicacao int,
    vendas decimal(10,2),
    autor_id int,
    genero_id int,
    foreign key (autor_id) references autores(id),
    foreign key (genero_id) references generos(id)
);
```

**Alterar Tabela**:

```sql
-- Adicionar coluna
alter table livros add column editora varchar(100);

-- Modificar coluna
alter table livros modify column vendas decimal(12,2);

-- Remover coluna
alter table livros drop column editora;
```

**Remover Tabela**:

```sql
drop table nome_tabela;
```

#### 3.2 DML - Data Manipulation Language

**Inserir Dados**:

```sql
insert into livros (nome, idioma, ano_publicacao, vendas, autor_id, genero_id)
values ('1984', 'English', 1949, 45.90, 1, 2);

-- Múltiplas inserções
insert into livros (nome, idioma, autor_id, genero_id) values
    ('Dom Casmurro', 'Portuguese', 2, 1),
    ('Memórias Póstumas', 'Portuguese', 2, 1);
```

**Atualizar Dados**:

```sql
update livros
set vendas = 49.90
where id = 42;

-- Múltiplos campos
update livros
set vendas = vendas * 1.10,
    ano_publicacao = 1950
where idioma = 'English';
```

**Deletar Dados**:

```sql
delete from livros
where id = 42;

-- Deletar com condição
delete from livros
where vendas < 10.00;

-- Deletar todos (cuidado!)
delete from livros;
```

#### 3.3 DQL - Data Query Language

**Select Básico**:

```sql
-- Selecionar todas as colunas
select * from livros;

-- Selecionar colunas específicas
select nome, idioma, ano_publicacao from livros;

-- Com alias
select nome as titulo, vendas as preco from livros;
```

**Filtros (WHERE)**:

```sql
-- Condição simples
select * from livros
where idioma = 'Portuguese';

-- Múltiplas condições (AND)
select * from livros
where idioma = 'English' and ano_publicacao > 1950;

-- Múltiplas condições (OR)
select * from livros
where idioma = 'English' or idioma = 'Portuguese';

-- IN
select * from livros
where idioma in ('English', 'Portuguese', 'Spanish');

-- BETWEEN
select * from livros
where ano_publicacao between 1940 and 1960;

-- LIKE (padrões)
select * from livros
where nome like '%Guerra%';  -- qualquer posição
-- 'Guerra%': começa com Guerra
-- '%Guerra': termina com Guerra
-- '_uerra': um caractere antes de "uerra"

-- IS NULL / IS NOT NULL
select * from livros
where vendas is null;
```

**Ordenação (ORDER BY)**:

```sql
-- Crescente (padrão)
select * from livros
order by vendas;

-- Decrescente
select * from livros
order by vendas desc;

-- Múltiplas colunas
select * from livros
order by idioma, ano_publicacao desc;
```

**Limitação (LIMIT)**:

```sql
-- Primeiros 10 registros
select * from livros
limit 10;

-- Com offset (pula os primeiros 5)
select * from livros
limit 10 offset 5;
```

**Agrupamento (GROUP BY)**:

```sql
-- Contar livros por idioma
select
    idioma,
    count(*) as quantidade_livros
from livros
group by idioma;

-- Média de vendas por idioma
select
    idioma,
    avg(vendas) as media_vendas,
    count(*) as quantidade
from livros
group by idioma;

-- Com filtro (HAVING)
select
    idioma,
    count(*) as quantidade
from livros
group by idioma
having count(*) > 10;
```

**Funções de Agregação**:

```sql
-- COUNT: contagem
select count(*) from livros;
select count(distinct idioma) from livros;

-- SUM: soma
select sum(vendas) from livros;

-- AVG: média
select avg(vendas) from livros;

-- MIN e MAX: mínimo e máximo
select min(vendas), max(vendas) from livros;

-- Combinadas
select
    count(*) as total,
    sum(vendas) as vendas_total,
    avg(vendas) as media_vendas,
    min(vendas) as menor_preco,
    max(vendas) as maior_preco
from livros;
```

---

### 4. **Joins - Relacionando Tabelas**

#### 4.1 INNER JOIN

```sql
-- Livros com seus autores
select
    l.nome as livro,
    a.nome as autor
from livros l
inner join autores a on l.autor_id = a.id;

-- Múltiplos joins
select
    l.nome as livro,
    a.nome as autor,
    g.nome as genero
from livros l
inner join autores a on l.autor_id = a.id
inner join generos g on l.genero_id = g.id;
```

- Retorna apenas registros com correspondência em **ambas** as tabelas

#### 4.2 LEFT JOIN (LEFT OUTER JOIN)

```sql
-- Todos os livros, mesmo sem comentários
select
    l.nome as livro,
    count(c.id) as quantidade_comentarios
from livros l
left join comentarios c on l.id = c.livro_id
group by l.id, l.nome;
```

- Retorna **todos** os registros da tabela esquerda
- NULL para registros sem correspondência à direita

#### 4.3 RIGHT JOIN (RIGHT OUTER JOIN)

```sql
-- Todos os autores, mesmo sem livros publicados
select
    a.nome as autor,
    count(l.id) as quantidade_livros
from livros l
right join autores a on l.autor_id = a.id
group by a.id, a.nome;
```

- Retorna **todos** os registros da tabela direita
- NULL para registros sem correspondência à esquerda

#### 4.4 FULL OUTER JOIN

```sql
-- MySQL não suporta diretamente, usar UNION
select * from livros l
left join autores a on l.autor_id = a.id
union
select * from livros l
right join autores a on l.autor_id = a.id;
```

- Retorna **todos** os registros de ambas as tabelas

#### 4.5 CROSS JOIN

```sql
-- Produto cartesiano (todas as combinações)
select *
from livros
cross join autores;
```

- Raramente usado em produção

---

### 5. **Views - Visualizações**

#### 5.1 Conceito

- **View**: consulta armazenada (tabela virtual)
- Não armazena dados fisicamente
- Simplifica consultas complexas
- Controle de acesso (segurança)
- Abstração de complexidade

#### 5.2 Criar View

```sql
-- View simples
create view livros_por_idioma as
select
    idioma,
    count(*) as quantidade_livros
from livros
group by idioma;

-- Usar view
select * from livros_por_idioma;
```

#### 5.3 Views Complexas

```sql
-- View com joins
create view livros_detalhados as
select
    l.id as livro_id,
    l.nome as nome_livro,
    l.idioma,
    l.ano_publicacao,
    l.vendas,
    a.nome as nome_autor,
    g.nome as nome_genero
from livros l
join autores a on l.autor_id = a.id
join generos g on l.genero_id = g.id;

select * from livros_detalhados;
```

```sql
-- View com agregação
create view comentarios_por_livro as
select
    l.nome as nome_livro,
    count(c.id) as quantidade_comentarios
from livros l
left join comentarios c on l.id = c.livro_id
group by l.id, l.nome;

-- Consultar e ordenar
select * from comentarios_por_livro
order by quantidade_comentarios desc;
```

#### 5.4 View com Filtro

```sql
-- Apenas livros em inglês
create view livros_ingles as
select * from livros
where idioma = 'English';

select * from livros_ingles;
```

#### 5.5 Remover View

```sql
drop view nome_view;
```

**Vantagens das Views**:

- Simplificação de consultas repetidas
- Segurança (ocultar colunas sensíveis)
- Independência lógica (mudanças na estrutura não afetam aplicações)
- Facilita análise de dados

---

### 6. **Stored Procedures - Procedimentos Armazenados**

#### 6.1 Conceito

- **Procedure**: conjunto de comandos SQL armazenados no banco
- Executados como uma unidade
- Podem receber parâmetros
- Permitem lógica (IF, WHILE, etc.)
- Reduzem tráfego de rede
- Centralizam lógica de negócio

#### 6.2 Sintaxe Básica

```sql
delimiter //

create procedure nome_procedure(
    in parametro_entrada tipo,
    out parametro_saida tipo
)
begin
    -- comandos SQL
end;
//

delimiter ;
```

**Delimiter**:

- Muda delimitador temporariamente (de `;` para `//`)
- Permite usar `;` dentro do procedure
- Restaura delimiter depois

#### 6.3 Procedure para UPDATE

```sql
delimiter //

create procedure atualizar_vendas_livro(
    in p_livro_id int,
    in p_nova_venda decimal(10,2)
)
begin
    update livros
    set vendas = p_nova_venda
    where id = p_livro_id;
end;
//

delimiter ;

-- Chamar procedure
call atualizar_vendas_livro(42, 39.01);

-- Verificar
select id, nome, vendas from livros where id = 42;
```

#### 6.4 Procedure para INSERT

```sql
delimiter //

create procedure inserir_comentario_livro(
    in p_livro_id int,
    in p_nome varchar(100),
    in p_sobrenome varchar(100),
    in p_comentario text
)
begin
    insert into comentarios (livro_id, nome, sobrenome, comentario)
    values (p_livro_id, p_nome, p_sobrenome, p_comentario);
end;
//

delimiter ;

-- Chamar
call inserir_comentario_livro(42, 'julio', 'alcantara',
                               'ótimo livro, recomendo!');

-- Verificar
select * from comentarios order by id desc;
```

#### 6.5 Procedure com Lógica

```sql
delimiter //

create procedure calcular_desconto(
    in p_livro_id int,
    in p_percentual decimal(5,2)
)
begin
    declare preco_atual decimal(10,2);
    declare novo_preco decimal(10,2);

    -- Buscar preço atual
    select vendas into preco_atual
    from livros
    where id = p_livro_id;

    -- Calcular novo preço
    set novo_preco = preco_atual * (1 - p_percentual/100);

    -- Atualizar
    update livros
    set vendas = novo_preco
    where id = p_livro_id;

    -- Mensagem
    select concat('Desconto aplicado! Novo preço: R$ ', novo_preco) as resultado;
end;
//

delimiter ;

call calcular_desconto(42, 10);  -- 10% de desconto
```

#### 6.6 Remover Procedure

```sql
drop procedure nome_procedure;
```

**Vantagens dos Procedures**:

- Performance (pré-compilados)
- Segurança (controle de acesso)
- Manutenibilidade (lógica centralizada)
- Redução de código repetitivo
- Transações complexas

---

### 7. **Otimização de Consultas**

#### 7.1 Índices

**Criar Índice**:

```sql
-- Índice simples
create index idx_idioma on livros(idioma);

-- Índice composto
create index idx_idioma_ano on livros(idioma, ano_publicacao);

-- Índice único
create unique index idx_email on cliente(email);
```

**Remover Índice**:

```sql
drop index idx_idioma on livros;
```

**Quando usar**:

- Colunas frequentemente usadas em WHERE, JOIN, ORDER BY
- Colunas com alta cardinalidade (muitos valores distintos)
- Trade-off: acelera leitura, desacelera escrita

#### 7.2 EXPLAIN

```sql
-- Analisar plano de execução
explain select * from livros
where idioma = 'English' and ano_publicacao > 1950;
```

- Mostra como MySQL executará a query
- Identifica full table scans
- Verifica uso de índices

#### 7.3 Boas Práticas

- **Evitar SELECT \***: selecione apenas colunas necessárias
- **Usar WHERE**: filtre antes de processar
- **Limitar resultados**: use LIMIT quando apropriado
- **Índices apropriados**: colunas de filtro e join
- **Evitar funções em WHERE**: impede uso de índice

  ```sql
  -- Ruim
  where year(data) = 2023

  -- Bom
  where data >= '2023-01-01' and data < '2024-01-01'
  ```

- **Prefer EXISTS a IN**: para subqueries grandes

---

### 8. **Transações e ACID**

#### 8.1 Conceito de Transação

- **Transação**: sequência de operações tratadas como unidade
- Tudo sucede ou tudo falha (atomicidade)

#### 8.2 Comandos

```sql
-- Iniciar transação
start transaction;
-- ou
begin;

-- Executar operações
update contas set saldo = saldo - 100 where id = 1;
update contas set saldo = saldo + 100 where id = 2;

-- Confirmar (gravar permanentemente)
commit;

-- Reverter (cancelar mudanças)
rollback;
```

#### 8.3 Propriedades ACID

**Atomicity (Atomicidade)**:

- Tudo ou nada
- Não há "meio termo"

**Consistency (Consistência)**:

- Banco vai de um estado válido para outro estado válido
- Restrições são respeitadas

**Isolation (Isolamento)**:

- Transações concorrentes não interferem entre si
- Diferentes níveis: READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, SERIALIZABLE

**Durability (Durabilidade)**:

- Após COMMIT, dados persistem mesmo com falhas

---

### 9. **Backup e Restauração**

#### 9.1 Exportar Banco (mysqldump)

```bash
# Terminal/Prompt
mysqldump -u usuario -p nome_banco > backup.sql

# Exportar estrutura e dados
mysqldump -u root -p livraria > livraria_backup.sql

# Apenas estrutura
mysqldump -u root -p --no-data livraria > estrutura.sql

# Apenas dados
mysqldump -u root -p --no-create-info livraria > dados.sql
```

#### 9.2 Importar Banco

```bash
# Terminal/Prompt
mysql -u usuario -p nome_banco < backup.sql

# Exemplo
mysql -u root -p livraria < livraria_backup.sql
```

#### 9.3 Dentro do MySQL

```sql
-- Importar arquivo SQL
source /caminho/para/arquivo.sql;
```

---

## 🛠️ Ferramentas

### MySQL Workbench

- Interface gráfica oficial para MySQL
- Modelagem visual de bancos (diagrama ER)
- Editor de SQL com syntax highlighting
- Administração de usuários e permissões
- Monitoramento de performance

### Ferramentas Alternativas

- **phpMyAdmin**: interface web
- **DBeaver**: multi-plataforma, suporta vários SGBDs
- **HeidiSQL**: Windows, leve e rápido
- **TablePlus**: macOS, interface moderna
- **DataGrip** (JetBrains): IDE completa (pago)

### Google Colab

- Jupyter Notebook na nuvem
- Pode conectar a bancos de dados remotos
- Gratuito com Python pré-instalado

---

## 📊 Dataset Utilizado

### Banco "livraria"

**Tabelas**:

- **livros**: id, nome, idioma, ano_publicacao, vendas, autor_id, genero_id
- **autores**: id, nome
- **generos**: id, nome
- **comentarios**: id, livro_id, nome, sobrenome, comentario

**Relacionamentos**:

- livros.autor_id → autores.id (N:1)
- livros.genero_id → generos.id (N:1)
- comentarios.livro_id → livros.id (N:1)

### Banco "loja"

**Tabela**:

- **cliente**: id_cliente, nome, email

---

## 📊 Aplicações Práticas em Data Science

### 1. Armazenamento de Dados

- **Data Warehouses**: armazéns de dados para análise
- **Data Lakes**: repositórios de dados brutos
- **ETL Pipelines**: Extract, Transform, Load

### 2. Análise de Dados

- **Consultas analíticas**: agregações, joins complexos
- **Geração de relatórios**: dashboards e BI
- **Machine Learning**: preparação de dados para modelos

### 3. Aplicações Web

- **Backend**: APIs que acessam banco de dados
- **CRUD**: Create, Read, Update, Delete
- **Autenticação/Autorização**: gerenciamento de usuários

### 4. Big Data

- **Bases relacionais**: ainda fundamentais para dados estruturados
- **Integração**: SQL em Spark, Hive, Presto
- **Hybrid architectures**: SQL + NoSQL

---

## 💡 Conceitos-Chave para Data Engineers

### Normalização vs Denormalização

- Normalização: reduz redundância, múltiplas tabelas, mais joins
- Denormalização: otimiza leitura, dados duplicados, menos joins
- Data Warehouse: tipicamente denormalizado (star schema, snowflake schema)

### OLTP vs OLAP

- **OLTP** (Online Transaction Processing): operações diárias, muitas escritas, normalizado
- **OLAP** (Online Analytical Processing): análises, muitas leituras, denormalizado

### Chaves Compostas

```sql
create table pedido_item(
    pedido_id int,
    produto_id int,
    quantidade int,
    primary key (pedido_id, produto_id)
);
```

### NULL é Especial

- NULL não é zero,não é string vazia
- NULL = NULL resulta em NULL (não TRUE)
- Use `IS NULL` ou `IS NOT NULL`

### Integridade Referencial

- Foreign keys garantem consistência
- `ON DELETE CASCADE`: deleta registros relacionados
- `ON DELETE SET NULL`: define FK como NULL
- `ON UPDATE CASCADE`: atualiza FKs automaticamente

### Performance é Crítica

- Índices são fundamentais
- Evite queries N+1 (loop de queries)
- Use EXPLAIN para otimizar
- Cache quando possível

---

## 📚 Materiais de Apoio

### Arquivos da Disciplina

- **PDF**: Engenharia de Dados 24062025pdf Portugues.pdf
- **PDF**: Engenharia de Dados II 01072025_SLpdf Portugues.pdf
- **PDF**: Engenharia de Dados III 15072025_SLpdf Portugues.pdf
- **Tutorial**: Tutorial Instalacao MySQL Windows/MacOS/Linux.pdf
- **Tutorial**: Tutorial Acesso Google Colab.pdf

### Scripts SQL

- **aula-3sql Portugues.sql**: views e procedures
- **usp-loja.sql**: criação de banco loja

---

## 🎯 Pontos Importantes para Memorizar

1. **Sempre use WHERE antes de DELETE/UPDATE**
   - DELETE sem WHERE apaga TUDO
   - Faça SELECT primeiro para testar filtro

2. **Primary Key é obrigatória**
   - Identifica unicamente cada registro
   - Geralmente INT AUTO_INCREMENT

3. **Normalize para transacional, denormalize para analítico**
   - Bancos OLTP: normalizado
   - Data Warehouses: denormalizado

4. **LEFT JOIN ≠ INNER JOIN**
   - INNER: apenas com correspondência
   - LEFT: todos da esquerda, NULL à direita sem correspondência

5. **Views não armazenam dados**
   - São queries salvas
   - Sempre buscam dados das tabelas base

6. **Procedures centralizam lógica**
   - Facilita manutenção
   - Melhor performance (pré-compilado)

7. **Índices aceleram leitura, desaceleram escrita**
   - Use em colunas de filtro/join
   - Não crie índices desnecessários

8. **Backup é essencial**
   - Automatize backups regulares
   - Teste restauração periodicamente

---

## 📖 Referências Recomendadas

### Livros

- Elmasri, R. & Navathe, S. (2015). Fundamentals of Database Systems, 7th Edition.
- Date, C. J. (2003). An Introduction to Database Systems, 8th Edition.
- Beaulieu, A. (2020). Learning SQL, 3rd Edition. O'Reilly.

### Documentação Oficial

- MySQL Documentation: https://dev.mysql.com/doc/
- PostgreSQL Documentation: https://www.postgresql.org/docs/
- SQL ISO Standard: https://www.iso.org/standard/63555.html

### Online

- W3Schools SQL: https://www.w3schools.com/sql/
- SQLZoo: https://sqlzoo.net/ (tutoriais interativos)
- Mode Analytics SQL Tutorial: https://mode.com/sql-tutorial/
- LeetCode Database Problems: https://leetcode.com/problem-list/database/

---

## ✅ Checklist de Estudo

- [ ] Instalar MySQL Server e MySQL Workbench
- [ ] Criar banco de dados e tabelas
- [ ] Definir chaves primárias e estrangeiras
- [ ] Inserir, atualizar e deletar dados
- [ ] Realizar consultas com SELECT, WHERE, ORDER BY
- [ ] Usar funções de agregação (COUNT, SUM, AVG, MIN, MAX)
- [ ] Agrupar dados com GROUP BY e HAVING
- [ ] Realizar joins (INNER, LEFT, RIGHT)
- [ ] Criar e utilizar views
- [ ] Criar e chamar stored procedures
- [ ] Criar índices e usar EXPLAIN para otimização
- [ ] Implementar transações com BEGIN, COMMIT, ROLLBACK
- [ ] Realizar backup com mysqldump
- [ ] Restaurar banco de dados
- [ ] Modelar banco completo para um projeto próprio

---

**Última atualização**: Março 2026  
**Curso**: MBA em Data Science e Analytics - USP/ESALQ  
**Módulo**: 4 - Engenharia de Dados
