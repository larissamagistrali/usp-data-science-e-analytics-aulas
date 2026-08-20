# 🗄️ Resumo - Engenharia de Dados

## MBA em Data Science e Analytics USP/ESALQ

---

## 🎯 Objetivo do Módulo

Compreender os fundamentos de engenharia de dados vistos em aula: modelagem de bancos de dados relacionais, linguagem SQL (DDL/DML/DQL), views, stored procedures e otimização de consultas no MySQL.

---

## 📚 Conteúdo Principal

### 1. **Fundamentos de Bancos de Dados**

#### 1.1 Banco de Dados Relacional

- São sistemas de armazenamento de dados onde as informações ficam organizadas em **tabelas** (linhas e colunas) que se relacionam entre si — por isso o nome "relacionais".
- SGBDs relacionais citados em aula: Oracle, SQL Server, IBM DB2, PostgreSQL, SQLite e **MySQL**.

#### 1.2 MySQL — Sistema Utilizado no Curso

- Arquitetura cliente-servidor:
  - **Cliente**: MySQL Workbench ou MySQL command line client
  - **Servidor**: MySQL Community Server
- Tutoriais de instalação fornecidos para Windows, macOS e Linux.

---

### 2. **Modelagem de Dados (MER)**

#### 2.1 Entidades e Atributos

- **Entidade**: qualquer elemento ou objeto do mundo real que pode ser identificado e possui relevância para o sistema, como um cliente ou um produto.
- **Atributo**: característica ou propriedade que descreve uma entidade, como o nome de um cliente ou o preço de um produto.
- Antes de relacionar tabelas, é preciso identificar as chaves primárias.

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

- Referencia a chave primária de outra tabela e define o relacionamento entre elas

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

---

### 5. **Views - Visualizações**

#### 5.1 Conceito

- **View**: uma consulta salva (tabela virtual) que exibe dados de uma ou mais tabelas com colunas e filtros definidos
- Não armazena dados fisicamente — não pode alterar os dados
- Simplifica consultas complexas

**Quando criar uma view**:

1. Reutilizar consultas complexas
2. Facilitar relatórios e análises
3. Simular uma tabela personalizada

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

---

### 6. **Stored Procedures - Procedimentos Armazenados**

#### 6.1 Conceito

- Uma **procedure** (ou stored procedure) funciona como uma função pré-programada, usada para automatizar tarefas repetitivas, como relatórios, cálculos, inserções, atualizações ou retificações.

**Vantagens** (vs. Views):

1. Segurança e controle
2. Organização do banco
3. Reutilização de código

View não pode alterar os dados; Procedure pode alterar os dados e aceitar parâmetros de entrada e saída.

#### 6.2 Sintaxe Básica

```sql
delimiter //

create procedure nome_da_procedure(
    [parametros de entrada e/ou saida]
)
begin
    -- comandos SQL
end;
//

delimiter ;
```

**Delimiter**:

- Muda o delimitador temporariamente (de `;` para `//`)
- Permite usar `;` dentro do procedure
- Restaura o delimiter depois

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

#### 6.5 Remover Procedure

```sql
drop procedure nome_procedure;
```

---

### 7. **Otimização de Consultas** (SQL Avançado)

#### 7.1 Índices

**Criar Índice**:

```sql
-- Índice simples
create index idx_idioma on livros(idioma);

-- Índice composto (ordem importa!)
create index idx_idioma_ano_vendas on livros(idioma, ano_publicacao, vendas);

-- Índice único
create unique index idx_email on cliente(email);
```

**Índice de cobertura (Covering Index)**: quando todas as colunas necessárias estão no índice, o MySQL não precisa acessar a tabela principal.

```sql
create index idx_cobertura on livros(idioma, nome, vendas);

select nome, vendas
from livros
where idioma = 'Spanish';   -- lê apenas o índice
```

#### 7.2 EXPLAIN

```sql
-- Analisar plano de execução
explain select * from livros
where idioma = 'English' and ano_publicacao > 1950;

-- Formato JSON (MySQL 8+)
explain format=json
select * from livros where idioma = 'English' and vendas > 40;
```

- Mostra como o MySQL executará a query

#### 7.3 Reescrever IN com JOIN

```sql
-- Versão lenta para grandes subqueries
select * from livros
where autor_id in (select id from autores where pais = 'Brasil');

-- Versão otimizada com JOIN
select l.*
from livros l
join autores a on l.autor_id = a.id
where a.pais = 'Brasil';
```

#### 7.4 Estatísticas de Tabela e Índices

```sql
-- Tamanho e linhas estimadas de cada tabela
select
    table_name,
    table_rows,
    round((data_length + index_length) / 1024 / 1024, 2) as tamanho_mb
from information_schema.tables
where table_schema = 'livraria'
order by tamanho_mb desc;
```

#### 7.5 UPSERT

```sql
insert into livros (id, nome, idioma, vendas)
values (999, 'Livro Teste', 'Portuguese', 39.90)
on duplicate key update
    nome   = values(nome),
    vendas = values(vendas);
```

---

### 8. **Transações**

```sql
-- Iniciar transação
start transaction;

-- Executar operações
insert into livros (nome, idioma, autor_id, genero_id, vendas)
values ('Novo Livro', 'Portuguese', 1, 1, 45.00);

-- Confirmar (gravar permanentemente)
commit;

-- Reverter (cancelar mudanças)
rollback;
```

---

## 🛠️ Ferramentas

### MySQL Workbench

- Interface gráfica oficial para MySQL (cliente que se conecta ao MySQL Community Server)

### Google Colab

- Usado nas atividades práticas para tratar dados de arquivos CSV e de uma API (JSON), com pandas, gerando os scripts de `INSERT` em SQL utilizados para popular o banco `livraria`

---

## 📊 Dataset Utilizado

### Banco "livraria"

**Tabelas**:

- **livros**: id, nome, idioma, ano_publicacao, vendas, autor_id, genero_id
- **autores**: id, nome
- **generos**: id, nome
- **comentarios**: id, livro_id, nome, sobrenome, comentario

**Relacionamentos**:

- livros.autor_id → autores.id
- livros.genero_id → generos.id
- comentarios.livro_id → livros.id

### Banco "loja"

**Tabela**:

- **cliente**: id_cliente, nome, email

---

## 📚 Materiais de Apoio

### Arquivos da Disciplina

- **PDF**: Engenharia de Dados 24062025pdf Portugues.pdf (Aula I)
- **PDF**: Engenharia de Dados II 01072025_SLpdf Portugues.pdf (Aula II)
- **PDF**: Engenharia de Dados III 15072025_SLpdf Portugues.pdf (Aula III)
- **Tutorial**: Tutorial Instalacao MySQL Windows/MacOS/Linux.pdf
- **Tutorial**: Tutorial Acesso Google Colab.pdf

### Scripts SQL

- **aula-3sql Portugues.sql**: views e procedures sobre o banco livraria
- **sql_avancado.sql**: índices, EXPLAIN, IN vs JOIN, estatísticas de tabela, UPSERT
- **usp-loja.sql**: criação do banco loja (tabela cliente)
- **aula2-eng_dadoszip / aula3-engDzip**: notebooks Colab (pandas) + scripts SQL gerados (autores.sql, generos.sql, livros.sql, comentarios.sql) e dataset livros.csv
- **banco-1-sqlzip**: script de criação do banco livraria (autores, generos, livros, comentarios) e consultas de exemplo

---

## 🎯 Pontos Importantes para Memorizar

1. **Sempre use WHERE antes de DELETE/UPDATE**
   - DELETE sem WHERE apaga TUDO

2. **Primary Key identifica unicamente cada registro**
   - Geralmente INT AUTO_INCREMENT

3. **LEFT JOIN ≠ INNER JOIN**
   - INNER: apenas com correspondência
   - LEFT: todos da esquerda, NULL à direita sem correspondência

4. **Views não armazenam dados**
   - São consultas salvas (tabelas virtuais)
   - Não podem alterar os dados

5. **Procedures podem alterar dados e centralizam lógica**
   - Aceitam parâmetros de entrada e saída
   - Vantagens: segurança e controle, organização do banco, reutilização de código

6. **Índices aceleram a leitura**
   - Use `EXPLAIN` para analisar o plano de execução da consulta

---

## ✅ Checklist de Estudo

- [ ] Instalar MySQL Server e MySQL Workbench
- [ ] Criar banco de dados e tabelas
- [ ] Definir chaves primárias e estrangeiras
- [ ] Inserir, atualizar e deletar dados
- [ ] Realizar consultas com SELECT, WHERE, ORDER BY
- [ ] Usar funções de agregação (COUNT, SUM, AVG, MIN, MAX)
- [ ] Agrupar dados com GROUP BY e HAVING
- [ ] Realizar joins (INNER, LEFT)
- [ ] Criar e utilizar views
- [ ] Criar e chamar stored procedures
- [ ] Criar índices e usar EXPLAIN para otimização
- [ ] Implementar transações com START TRANSACTION, COMMIT, ROLLBACK
- [ ] Modelar banco completo para um projeto próprio

---

**Curso**: MBA em Data Science e Analytics - USP/ESALQ
**Módulo**: 4 - Engenharia de Dados
