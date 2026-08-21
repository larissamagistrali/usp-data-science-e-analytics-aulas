# Resumo - Engenharia de Dados

## MBA em Data Science e Analytics USP/ESALQ

---

## Objetivo do Módulo

Fundamentos de engenharia de dados aplicados: modelagem relacional, SQL (DDL/DML/DQL), views, procedures, triggers, window functions, CTEs e otimização no MySQL.

---

## Conteúdo da Aula

### 1. **Modelagem e Criação de Bancos de Dados**

**Chave Primária (Primary Key)**:
```sql
create table livros(
    id int auto_increment primary key,
    nome varchar(200) not null
);
```

**Chave Estrangeira (Foreign Key)** — define relacionamento entre tabelas:
```sql
create table livros(
    id int primary key auto_increment,
    autor_id int,
    genero_id int,
    foreign key (autor_id) references autores(id),
    foreign key (genero_id) references generos(id)
);
```

---

### 2. **DML e DQL — Inserção e Consultas**

**Filtros com WHERE**:
```sql
select * from livros where ano_publicacao > 2010;
select nome, vendas from livros where vendas > 100;
```

**Agrupamento com GROUP BY e agregações**:
```sql
select idioma, count(*) as qtd, avg(vendas) as media
from livros
group by idioma;
```

**Joins** — relacionar tabelas:
```sql
-- INNER JOIN: apenas registros com correspondência
select l.nome as livro, a.nome as autor, g.nome as genero
from livros l
join autores a on l.autor_id = a.id
join generos g on l.genero_id = g.id;
```

---

### 3. **Views — Consultas Salvas**

**View com JOIN**:
```sql
create view livros_detalhados as
select l.id, l.nome, l.idioma, a.nome as autor, g.nome as genero
from livros l
join autores a on l.autor_id = a.id
join generos g on l.genero_id = g.id;

select * from livros_detalhados;
```

---

### 4. **Stored Procedures**

Automatizam tarefas e aceitam parâmetros de entrada/saída (diferente de Views que são apenas consultas salvas).

**Para UPDATE**:
```sql
delimiter //
create procedure atualizar_vendas_livro(in p_livro_id int, in p_nova_venda decimal(10,2))
begin
    update livros set vendas = p_nova_venda where id = p_livro_id;
end;
//
delimiter ;

call atualizar_vendas_livro(42, 39.01);
```

**Para INSERT**:
```sql
delimiter //
create procedure inserir_comentario_livro(in p_livro_id int, in p_nome varchar(100), in p_comentario text)
begin
    insert into comentarios (livro_id, nome, comentario) values (p_livro_id, p_nome, p_comentario);
end;
//
delimiter ;

call inserir_comentario_livro(42, 'julio', 'ótimo livro!');
```

---

### 5. **Triggers — Execução Automática**

Executam automaticamente em resposta a INSERT, UPDATE ou DELETE.

```sql
-- Log de alterações de preço
create table log_preco (id int auto_increment primary key, livro_id int, preco_antigo decimal(10,2), preco_novo decimal(10,2));

delimiter //
create trigger tgr_after_update_preco after update on livros
for each row
begin
    if old.vendas <> new.vendas then
        insert into log_preco (livro_id, preco_antigo, preco_novo) values (new.id, old.vendas, new.vendas);
    end if;
end;
//
delimiter ;
```

---

### 6. **Functions — Funções Definidas pelo Usuário**

Retornam um valor e podem ser usadas em SELECT/WHERE.

```sql
delimiter //
create function classificar_preco(p_preco decimal(10,2)) returns varchar(20)
deterministic
begin
    if p_preco < 30 then return 'Barato';
    elseif p_preco < 60 then return 'Médio';
    else return 'Caro';
    end if;
end;
//
delimiter ;

select nome, vendas, classificar_preco(vendas) as categoria from livros;
```

---

### 7. **CTEs — Common Table Expressions (WITH)**

Blocos nomeados que tornam queries complexas mais legíveis.

```sql
with livros_caros as (
    select id, nome, vendas, autor_id from livros where vendas > 50
)
select a.nome as autor, count(lc.id) as qtd, round(avg(lc.vendas), 2) as media
from livros_caros lc
join autores a on lc.autor_id = a.id
group by a.id, a.nome
order by qtd desc;
```

**CTE Recursiva** — hierarquias:
```sql
with recursive numeros as (
    select 1 as n
    union all
    select n + 1 from numeros where n < 10
)
select * from numeros;
```

---

### 8. **Window Functions — Funções de Janela**

Calculam sobre conjuntos de linhas vizinhas sem reduzir resultado.

```sql
-- Ranking por idioma
select nome, idioma, vendas,
    row_number() over (partition by idioma order by vendas desc) as ranking
from livros;

-- Top-3 por idioma
with ranked as (
    select nome, idioma, vendas, rank() over (partition by idioma order by vendas desc) as pos
    from livros
)
select * from ranked where pos <= 3;
```

**Deslocamento (LAG/LEAD)**:
```sql
select nome, ano_publicacao, vendas,
    lag(vendas) over (order by ano_publicacao) as venda_anterior
from livros;
```

**Agregação com OVER**:
```sql
select nome, vendas,
    sum(vendas) over () as receita_total,
    round(vendas / sum(vendas) over () * 100, 2) as pct_total
from livros;
```

---

### 9. **Otimização de Consultas**

**Índices simples e compostos**:
```sql
create index idx_idioma on livros(idioma);
create index idx_idioma_ano_vendas on livros(idioma, ano_publicacao, vendas);
```

**EXPLAIN — analisar execução**:
```sql
explain select * from livros where idioma = 'English' and ano_publicacao > 1950;
```

**Reescrever IN com JOIN** (mais performático para grandes bases):
```sql
-- Lento
select * from livros where autor_id in (select id from autores where pais = 'Brasil');

-- Otimizado
select l.* from livros l join autores a on l.autor_id = a.id where a.pais = 'Brasil';
```

**UPSERT** — insert ou update em uma operação:
```sql
insert into livros (id, nome, vendas) values (999, 'Livro', 39.90)
on duplicate key update nome = values(nome), vendas = values(vendas);
```

---

## Dataset: Banco "livraria"

**Tabelas**: livros (id, nome, idioma, ano_publicacao, vendas, autor_id, genero_id), autores, generos, comentarios

**Relacionamentos**: livros.autor_id → autores.id | livros.genero_id → generos.id | comentarios.livro_id → livros.id

---

## Arquivos Reais

**Aula I-III**: Engenharia de Dados I/II/III PDFs  
**Scripts**: aula-3sql (views/procedures) | sql_avancado.sql (triggers, functions, CTEs, window functions, JSON, full-text search) | aula2-eng_dados.zip + aula3-engD.zip (notebooks Colab + dados)  
**Ferramentas**: MySQL Workbench | Google Colab (pandas para preparar dados)

---

**MBA Data Science e Analytics - USP/ESALQ | Módulo 4**
