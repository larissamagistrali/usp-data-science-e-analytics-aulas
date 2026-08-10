-- =============================================================
--  SQL AVANÇADO - MBA Data Science e Analytics USP/ESALQ
--  Banco de Dados: livraria
-- =============================================================
-- Tópicos cobertos:
--   1. Funções Condicionais (CASE, IF, COALESCE, NULLIF)
--   2. Funções de String Avançadas
--   3. Funções de Data e Hora
--   4. Subqueries Avançadas (correlacionadas, EXISTS, FROM)
--   5. CTEs (Common Table Expressions)
--   6. Window Functions (Funções de Janela)
--   7. Triggers
--   8. Functions (Funções Definidas pelo Usuário)
--   9. Procedures Avançadas (cursores, tratamento de erros)
--  10. JSON no MySQL
--  11. Full-Text Search
--  12. Otimização Avançada (EXPLAIN, índices compostos)
-- =============================================================

use livraria;


-- ================================================================
-- 1. FUNÇÕES CONDICIONAIS
-- ================================================================

-- ---------------------------------------------------------------
-- 1.1  CASE WHEN — lógica condicional inline
-- ---------------------------------------------------------------

-- Classificar livros por faixa de preço
select
    nome,
    vendas,
    case
        when vendas < 30   then 'Barato'
        when vendas < 60   then 'Médio'
        when vendas < 100  then 'Caro'
        else                    'Premium'
    end as faixa_preco
from livros;

-- Rotular idioma em português (CASE com igualdade)
select
    nome,
    case idioma
        when 'Portuguese' then 'Português'
        when 'English'    then 'Inglês'
        when 'Spanish'    then 'Espanhol'
        else idioma
    end as idioma_pt
from livros;

-- Usar CASE dentro de COUNT para pivô simples
select
    count(case when idioma = 'Portuguese' then 1 end) as qtd_portugues,
    count(case when idioma = 'English'    then 1 end) as qtd_ingles,
    count(case when idioma = 'Spanish'    then 1 end) as qtd_espanhol
from livros;

-- ---------------------------------------------------------------
-- 1.2  IF — atalho para condição binária
-- ---------------------------------------------------------------

select
    nome,
    vendas,
    if(vendas > 50, 'Acima de R$50', 'Até R$50') as categoria_preco
from livros;

-- ---------------------------------------------------------------
-- 1.3  COALESCE — retorna o primeiro valor não-NULL
-- ---------------------------------------------------------------

-- Exibir "Sem preço" quando vendas for NULL
select
    nome,
    coalesce(vendas, 0)          as vendas_sem_null,
    coalesce(cast(vendas as char), 'Sem preço') as vendas_texto
from livros;

-- ---------------------------------------------------------------
-- 1.4  NULLIF — retorna NULL se os dois valores forem iguais
--              útil para evitar divisão por zero
-- ---------------------------------------------------------------

-- Evitar divisão por zero ao calcular proporção
select
    idioma,
    count(*) as total,
    sum(vendas) / nullif(count(*), 0) as media_vendas
from livros
group by idioma;


-- ================================================================
-- 2. FUNÇÕES DE STRING AVANÇADAS
-- ================================================================

-- Concatenar nome + sobrenome dos autores com separador
select concat_ws(' ', nome, sobrenome) as autor_completo
from autores;

-- Extrair parte de uma string
select
    nome,
    left(nome, 5)              as primeiros_5,
    right(nome, 5)             as ultimos_5,
    substring(nome, 1, 10)     as trecho,
    length(nome)               as tamanho
from livros;

-- Transformar e limpar strings
select
    upper(nome)   as maiusculo,
    lower(nome)   as minusculo,
    trim(nome)    as sem_espacos
from livros;

-- Substituir texto
select
    nome,
    replace(idioma, 'English', 'Inglês') as idioma_traduzido
from livros;

-- Verificar posição de substring
select
    nome,
    locate('a', nome) as posicao_primeira_letra_a
from livros
where locate('a', nome) > 0;

-- Agrupar múltiplos valores em uma string (GROUP_CONCAT)
select
    a.nome as autor,
    group_concat(l.nome order by l.ano_publicacao separator ' | ') as livros_publicados
from autores a
join livros l on l.autor_id = a.id
group by a.id, a.nome;

-- Filtrar com expressão regular (REGEXP)
select nome
from livros
where nome regexp '^[Oo]';    -- começa com "O" ou "o"

select nome
from livros
where nome regexp '[0-9]';    -- contém algum número


-- ================================================================
-- 3. FUNÇÕES DE DATA E HORA
-- ================================================================

-- (Assumindo coluna data_cadastro datetime em 'livros' para exemplos)
-- Para testar: alter table livros add column data_cadastro datetime default current_timestamp;

-- Data/hora atual
select
    now()           as data_hora_agora,
    curdate()       as data_hoje,
    curtime()       as hora_agora;

-- Extrair partes da data
select
    ano_publicacao,
    year(curdate())  as ano_atual,
    year(curdate()) - ano_publicacao as anos_desde_publicacao
from livros
where ano_publicacao is not null;

-- Formatar data
select
    date_format(now(), '%d/%m/%Y')         as data_br,
    date_format(now(), '%d de %M de %Y')   as data_extenso;

-- Aritmética de datas
select
    date_add(curdate(), interval 30 day)   as daqui_30_dias,
    date_sub(curdate(), interval 1 year)   as ha_um_ano,
    datediff(curdate(), '2020-01-01')      as dias_desde_2020,
    timestampdiff(year, '1990-05-15', curdate()) as idade_exemplo;

-- Agrupar publicações por década
select
    floor(ano_publicacao / 10) * 10 as decada,
    count(*) as quantidade,
    round(avg(vendas), 2) as media_vendas
from livros
where ano_publicacao is not null
group by decada
order by decada;


-- ================================================================
-- 4. SUBQUERIES AVANÇADAS
-- ================================================================

-- ---------------------------------------------------------------
-- 4.1  Subquery no WHERE (escalar)
-- ---------------------------------------------------------------

-- Livros com venda acima da média geral
select nome, vendas
from livros
where vendas > (select avg(vendas) from livros);

-- ---------------------------------------------------------------
-- 4.2  Subquery correlacionada
--      A subquery referencia a tabela da query externa
-- ---------------------------------------------------------------

-- Para cada livro, mostrar quantos livros do mesmo autor existem
select
    l.nome,
    l.autor_id,
    (
        select count(*)
        from livros l2
        where l2.autor_id = l.autor_id
    ) as total_livros_do_autor
from livros l;

-- ---------------------------------------------------------------
-- 4.3  EXISTS / NOT EXISTS
--      Mais eficiente que IN para grandes conjuntos
-- ---------------------------------------------------------------

-- Autores que têm pelo menos um livro na base
select a.nome as autor
from autores a
where exists (
    select 1 from livros l where l.autor_id = a.id
);

-- Autores SEM nenhum livro cadastrado
select a.nome as autor_sem_livro
from autores a
where not exists (
    select 1 from livros l where l.autor_id = a.id
);

-- ---------------------------------------------------------------
-- 4.4  Subquery no FROM (derived table)
-- ---------------------------------------------------------------

-- Média das médias de vendas por idioma
select round(avg(media_idioma), 2) as media_geral_das_medias
from (
    select idioma, avg(vendas) as media_idioma
    from livros
    group by idioma
) as medias_por_idioma;

-- Top-3 livros por idioma (usando derived table + join)
select l.idioma, l.nome, l.vendas
from livros l
join (
    select idioma, max(vendas) as max_vendas
    from livros
    group by idioma
) as max_por_idioma
    on l.idioma = max_por_idioma.idioma
    and l.vendas = max_por_idioma.max_vendas;


-- ================================================================
-- 5. CTEs — COMMON TABLE EXPRESSIONS (WITH)
-- ================================================================
-- Blocos nomeados que tornam queries complexas mais legíveis.
-- Executados uma vez e reutilizados na mesma query.

-- ---------------------------------------------------------------
-- 5.1  CTE simples
-- ---------------------------------------------------------------

with livros_caros as (
    select id, nome, vendas, autor_id
    from livros
    where vendas > 50
)
select
    a.nome as autor,
    count(lc.id) as qtd_livros_caros,
    round(avg(lc.vendas), 2) as media_preco
from livros_caros lc
join autores a on lc.autor_id = a.id
group by a.id, a.nome
order by qtd_livros_caros desc;

-- ---------------------------------------------------------------
-- 5.2  Múltiplas CTEs encadeadas
-- ---------------------------------------------------------------

with
    estatisticas as (
        select
            idioma,
            count(*)         as total,
            avg(vendas)      as media_vendas,
            sum(vendas)      as receita_total
        from livros
        group by idioma
    ),
    top_idiomas as (
        select *
        from estatisticas
        where total >= 5
    )
select
    idioma,
    total,
    round(media_vendas, 2)   as media,
    round(receita_total, 2)  as receita
from top_idiomas
order by receita desc;

-- ---------------------------------------------------------------
-- 5.3  CTE Recursiva — gerar série numérica
-- ---------------------------------------------------------------

with recursive numeros as (
    select 1 as n           -- caso base
    union all
    select n + 1            -- passo recursivo
    from numeros
    where n < 10
)
select * from numeros;

-- CTE Recursiva — hierarquia de categorias
-- (assumindo tabela: categorias(id, nome, pai_id))
with recursive hierarquia as (
    -- Raiz (categorias sem pai)
    select id, nome, pai_id, 0 as nivel, cast(nome as char(500)) as caminho
    from categorias
    where pai_id is null

    union all

    -- Filhos
    select c.id, c.nome, c.pai_id, h.nivel + 1,
           concat(h.caminho, ' > ', c.nome)
    from categorias c
    join hierarquia h on c.pai_id = h.id
)
select nivel, caminho
from hierarquia
order by caminho;


-- ================================================================
-- 6. WINDOW FUNCTIONS — FUNÇÕES DE JANELA
-- ================================================================
-- Calculam sobre um "conjunto de linhas vizinhas" sem reduzir o resultado.
-- Sintaxe: funcao() OVER (PARTITION BY ... ORDER BY ...)

-- ---------------------------------------------------------------
-- 6.1  Funções de ranking
-- ---------------------------------------------------------------

-- ROW_NUMBER: numeração única (sem empate)
-- RANK: ranking com salto em empate (1, 2, 2, 4)
-- DENSE_RANK: ranking sem salto em empate (1, 2, 2, 3)
select
    nome,
    idioma,
    vendas,
    row_number()  over (partition by idioma order by vendas desc) as num_linha,
    rank()        over (partition by idioma order by vendas desc) as ranking,
    dense_rank()  over (partition by idioma order by vendas desc) as ranking_denso
from livros
where vendas is not null;

-- Top-3 livros mais vendidos por idioma
with ranked as (
    select
        nome,
        idioma,
        vendas,
        rank() over (partition by idioma order by vendas desc) as pos
    from livros
    where vendas is not null
)
select nome, idioma, vendas, pos
from ranked
where pos <= 3
order by idioma, pos;

-- ---------------------------------------------------------------
-- 6.2  NTILE — dividir em N grupos (quartis, decis...)
-- ---------------------------------------------------------------

-- Dividir livros em 4 quartis de preço
select
    nome,
    vendas,
    ntile(4) over (order by vendas) as quartil
from livros
where vendas is not null;

-- ---------------------------------------------------------------
-- 6.3  Funções de deslocamento (LAG / LEAD)
-- ---------------------------------------------------------------

-- Comparar venda de um livro com o livro anterior (por ano)
select
    nome,
    ano_publicacao,
    vendas,
    lag(vendas)  over (order by ano_publicacao) as venda_livro_anterior,
    lead(vendas) over (order by ano_publicacao) as venda_proximo_livro,
    vendas - lag(vendas) over (order by ano_publicacao) as variacao
from livros
where vendas is not null and ano_publicacao is not null;

-- ---------------------------------------------------------------
-- 6.4  FIRST_VALUE / LAST_VALUE — valor na borda da janela
-- ---------------------------------------------------------------

select
    nome,
    idioma,
    vendas,
    first_value(nome) over (
        partition by idioma
        order by vendas desc
        rows between unbounded preceding and unbounded following
    ) as livro_mais_caro_idioma,
    last_value(nome) over (
        partition by idioma
        order by vendas desc
        rows between unbounded preceding and unbounded following
    ) as livro_mais_barato_idioma
from livros
where vendas is not null;

-- ---------------------------------------------------------------
-- 6.5  Agregações com OVER — sem GROUP BY
-- ---------------------------------------------------------------

-- Porcentagem de contribuição de cada livro para a receita total
select
    nome,
    idioma,
    vendas,
    sum(vendas) over ()                              as receita_total,
    round(vendas / sum(vendas) over () * 100, 2)     as pct_total,
    sum(vendas) over (partition by idioma)            as receita_idioma,
    round(vendas / sum(vendas) over (partition by idioma) * 100, 2) as pct_idioma
from livros
where vendas is not null;

-- Média móvel de 3 livros (por ano de publicação)
select
    ano_publicacao,
    nome,
    vendas,
    round(avg(vendas) over (
        order by ano_publicacao
        rows between 1 preceding and 1 following
    ), 2) as media_movel_3
from livros
where vendas is not null and ano_publicacao is not null;

-- ---------------------------------------------------------------
-- 6.6  Soma acumulada (running total)
-- ---------------------------------------------------------------

select
    ano_publicacao,
    nome,
    vendas,
    sum(vendas) over (order by ano_publicacao rows unbounded preceding) as venda_acumulada
from livros
where vendas is not null and ano_publicacao is not null;


-- ================================================================
-- 7. TRIGGERS
-- ================================================================
-- Executam automaticamente em resposta a INSERT / UPDATE / DELETE.
-- Tipos: BEFORE (antes) ou AFTER (depois).

-- Criar tabela de log para auditar alterações de preço
create table if not exists log_preco_livros (
    id            int auto_increment primary key,
    livro_id      int not null,
    preco_antigo  decimal(10,2),
    preco_novo    decimal(10,2),
    alterado_em   datetime default current_timestamp,
    operacao      varchar(10)
);

-- ---------------------------------------------------------------
-- 7.1  BEFORE INSERT — garantir que preço não seja negativo
-- ---------------------------------------------------------------

delimiter //

create trigger tgr_before_insert_livro
before insert on livros
for each row
begin
    if new.vendas < 0 then
        signal sqlstate '45000'
            set message_text = 'Erro: preço não pode ser negativo.';
    end if;
end;
//

delimiter ;

-- ---------------------------------------------------------------
-- 7.2  AFTER UPDATE — registrar histórico de preço
-- ---------------------------------------------------------------

delimiter //

create trigger tgr_after_update_preco
after update on livros
for each row
begin
    -- Só registra se vendas realmente mudou
    if old.vendas <> new.vendas or (old.vendas is null and new.vendas is not null) then
        insert into log_preco_livros (livro_id, preco_antigo, preco_novo, operacao)
        values (new.id, old.vendas, new.vendas, 'UPDATE');
    end if;
end;
//

delimiter ;

-- ---------------------------------------------------------------
-- 7.3  AFTER DELETE — registrar exclusão
-- ---------------------------------------------------------------

delimiter //

create trigger tgr_after_delete_livro
after delete on livros
for each row
begin
    insert into log_preco_livros (livro_id, preco_antigo, preco_novo, operacao)
    values (old.id, old.vendas, null, 'DELETE');
end;
//

delimiter ;

-- Testar triggers
update livros set vendas = 59.90 where id = 1;
select * from log_preco_livros;

-- Listar triggers ativos no banco
show triggers from livraria;

-- Remover trigger
-- drop trigger tgr_after_update_preco;


-- ================================================================
-- 8. FUNCTIONS — FUNÇÕES DEFINIDAS PELO USUÁRIO
-- ================================================================
-- Diferença de Procedure: Function RETORNA um valor e pode ser usada
-- diretamente dentro de SELECT / WHERE.

-- ---------------------------------------------------------------
-- 8.1  Função que classifica livro por faixa de preço
-- ---------------------------------------------------------------

delimiter //

create function classicar_preco(p_preco decimal(10,2))
returns varchar(20)
deterministic
begin
    declare categoria varchar(20);

    if p_preco is null then
        set categoria = 'Sem preço';
    elseif p_preco < 30 then
        set categoria = 'Barato';
    elseif p_preco < 60 then
        set categoria = 'Médio';
    elseif p_preco < 100 then
        set categoria = 'Caro';
    else
        set categoria = 'Premium';
    end if;

    return categoria;
end;
//

delimiter ;

-- Usar a função em SELECT
select nome, vendas, classicar_preco(vendas) as categoria
from livros;

-- ---------------------------------------------------------------
-- 8.2  Função de cálculo: desconto aplicado
-- ---------------------------------------------------------------

delimiter //

create function preco_com_desconto(
    p_preco      decimal(10,2),
    p_desconto   decimal(5,2)   -- percentual: 10 = 10%
)
returns decimal(10,2)
deterministic
begin
    return round(p_preco * (1 - p_desconto / 100), 2);
end;
//

delimiter ;

-- Usar em SELECT
select
    nome,
    vendas                           as preco_original,
    preco_com_desconto(vendas, 10)   as preco_com_10pct_desconto,
    preco_com_desconto(vendas, 20)   as preco_com_20pct_desconto
from livros
where vendas is not null;

-- Remover function
-- drop function classicar_preco;


-- ================================================================
-- 9. PROCEDURES AVANÇADAS
-- ================================================================

-- ---------------------------------------------------------------
-- 9.1  Procedure com parâmetro de saída (OUT)
-- ---------------------------------------------------------------

delimiter //

create procedure estatisticas_vendas(
    in  p_idioma    varchar(50),
    out p_total     int,
    out p_media     decimal(10,2),
    out p_receita   decimal(10,2)
)
begin
    select
        count(*),
        avg(vendas),
        sum(vendas)
    into p_total, p_media, p_receita
    from livros
    where idioma = p_idioma;
end;
//

delimiter ;

-- Chamar com variáveis de saída
call estatisticas_vendas('Portuguese', @total, @media, @receita);
select @total as total, round(@media, 2) as media, round(@receita, 2) as receita;

-- ---------------------------------------------------------------
-- 9.2  Procedure com cursor — iterar linha a linha
-- ---------------------------------------------------------------

delimiter //

create procedure aplicar_reajuste_por_idioma(
    in p_idioma     varchar(50),
    in p_percentual decimal(5,2)
)
begin
    declare v_done        int default 0;
    declare v_id          int;
    declare v_preco       decimal(10,2);
    declare v_novo_preco  decimal(10,2);

    -- Declarar cursor
    declare cur_livros cursor for
        select id, vendas
        from livros
        where idioma = p_idioma and vendas is not null;

    -- Handler para fim do cursor
    declare continue handler for not found set v_done = 1;

    open cur_livros;

    loop_livros: loop
        fetch cur_livros into v_id, v_preco;

        if v_done = 1 then
            leave loop_livros;
        end if;

        set v_novo_preco = round(v_preco * (1 + p_percentual / 100), 2);

        update livros
        set vendas = v_novo_preco
        where id = v_id;

    end loop;

    close cur_livros;
end;
//

delimiter ;

-- Chamar: reajustar livros em inglês em 5%
-- call aplicar_reajuste_por_idioma('English', 5);

-- ---------------------------------------------------------------
-- 9.3  Procedure com tratamento de erros (HANDLER)
-- ---------------------------------------------------------------

delimiter //

create procedure inserir_livro_seguro(
    in p_nome      varchar(200),
    in p_idioma    varchar(50),
    in p_autor_id  int,
    in p_genero_id int,
    in p_vendas    decimal(10,2)
)
begin
    declare v_erro int default 0;
    declare v_msg  varchar(500);

    -- Captura qualquer erro SQL
    declare exit handler for sqlexception
    begin
        get diagnostics condition 1 v_msg = message_text;
        set v_erro = 1;
        select concat('Erro ao inserir: ', v_msg) as resultado;
        rollback;
    end;

    start transaction;

    insert into livros (nome, idioma, autor_id, genero_id, vendas)
    values (p_nome, p_idioma, p_autor_id, p_genero_id, p_vendas);

    commit;

    if v_erro = 0 then
        select concat('Livro "', p_nome, '" inserido com sucesso!') as resultado;
    end if;
end;
//

delimiter ;

-- Testar (autor/gênero inexistente vai disparar FK error)
call inserir_livro_seguro('Novo Livro', 'Portuguese', 999, 1, 45.00);


-- ================================================================
-- 10. JSON NO MYSQL (v5.7+)
-- ================================================================
-- Útil para armazenar atributos variáveis (metadados, tags, etc.)

-- Adicionar coluna JSON (exemplo)
-- alter table livros add column metadados json;

-- Inserir dado JSON
-- update livros set metadados = '{"premiado": true, "edicoes": 3, "tags": ["classico","literatura"]}' where id = 1;

-- Extrair campo do JSON
select
    nome,
    metadados->>'$.premiado'          as premiado,
    metadados->>'$.edicoes'           as edicoes,
    json_extract(metadados, '$.tags') as tags
from livros
where metadados is not null;

-- Filtrar por campo JSON
select nome
from livros
where metadados->>'$.premiado' = 'true';

-- Verificar se campo existe
select nome
from livros
where json_contains_path(metadados, 'one', '$.tags');

-- Atualizar campo específico sem sobrescrever o JSON inteiro
update livros
set metadados = json_set(metadados, '$.edicoes', 4)
where id = 1;

-- Remover campo
update livros
set metadados = json_remove(metadados, '$.premiado')
where id = 1;

-- Agregar JSONs em array
select json_arrayagg(nome) as lista_livros
from livros
where idioma = 'Portuguese';

-- Agregar em objeto
select json_objectagg(id, nome) as mapa_livros
from livros
limit 5;


-- ================================================================
-- 11. FULL-TEXT SEARCH
-- ================================================================
-- Busca textual muito mais eficiente que LIKE para grandes volumes.
-- Requer índice FULLTEXT.

-- Criar índice full-text (ex.: coluna nome)
-- alter table livros add fulltext idx_ft_nome (nome);
-- Para busca em múltiplas colunas:
-- alter table livros add fulltext idx_ft_nome_desc (nome, descricao);

-- Modo NATURAL LANGUAGE (padrão): relevância automática
select
    nome,
    match(nome) against ('guerra paz aventura' in natural language mode) as relevancia
from livros
where match(nome) against ('guerra paz aventura' in natural language mode)
order by relevancia desc;

-- Modo BOOLEAN: operadores explícitos
-- +palavra  = obrigatório
-- -palavra  = excluído
-- "frase"   = frase exata
-- *         = curinga de prefixo
select nome
from livros
where match(nome) against ('+Dom -Pedro*' in boolean mode);

-- Modo WITH QUERY EXPANSION: amplia busca com termos relacionados
select nome
from livros
where match(nome) against ('romance' with query expansion);


-- ================================================================
-- 12. OTIMIZAÇÃO AVANÇADA
-- ================================================================

-- ---------------------------------------------------------------
-- 12.1  EXPLAIN / EXPLAIN ANALYZE
-- ---------------------------------------------------------------

-- Ver plano de execução
explain
select l.nome, a.nome as autor
from livros l
join autores a on l.autor_id = a.id
where l.idioma = 'Portuguese';

-- EXPLAIN com formato tabular detalhado (MySQL 8+)
explain format=json
select * from livros where idioma = 'English' and vendas > 40;

-- ---------------------------------------------------------------
-- 12.2  Índices compostos — ordem importa!
-- ---------------------------------------------------------------

-- Para queries que filtram por (idioma, ano_publicacao) E ordenam por vendas:
create index idx_idioma_ano_vendas on livros(idioma, ano_publicacao, vendas);

-- A query abaixo usará o índice composto:
select nome, vendas
from livros
where idioma = 'English' and ano_publicacao > 1950
order by vendas desc;

-- ---------------------------------------------------------------
-- 12.3  Índice de cobertura (Covering Index)
-- ---------------------------------------------------------------
-- Quando todas as colunas necessárias estão no índice,
-- o MySQL não precisa acessar a tabela principal (rows = 0 no EXPLAIN).

create index idx_cobertura on livros(idioma, nome, vendas);

select nome, vendas
from livros
where idioma = 'Spanish';   -- lê apenas o índice, sem acesso à tabela

-- ---------------------------------------------------------------
-- 12.4  Reescrever IN com JOIN (mais performático em grandes bases)
-- ---------------------------------------------------------------

-- Versão lenta para grandes subqueries
select * from livros
where autor_id in (select id from autores where pais = 'Brasil');

-- Versão otimizada com JOIN
select l.*
from livros l
join autores a on l.autor_id = a.id
where a.pais = 'Brasil';

-- ---------------------------------------------------------------
-- 12.5  Estatísticas de tabela
-- ---------------------------------------------------------------

-- Ver tamanho e linhas estimadas de cada tabela
select
    table_name,
    table_rows,
    round((data_length + index_length) / 1024 / 1024, 2) as tamanho_mb
from information_schema.tables
where table_schema = 'livraria'
order by tamanho_mb desc;

-- Listar todos os índices do banco
select
    table_name,
    index_name,
    column_name,
    non_unique
from information_schema.statistics
where table_schema = 'livraria'
order by table_name, index_name;

-- ---------------------------------------------------------------
-- 12.6  Análise de duplicatas (padrão útil em ETL)
-- ---------------------------------------------------------------

-- Encontrar nomes de livros duplicados
select nome, count(*) as ocorrencias
from livros
group by nome
having count(*) > 1;

-- Manter apenas o registro com menor id, deletar duplicatas
delete l1
from livros l1
join livros l2
    on l1.nome = l2.nome
    and l1.id > l2.id;   --  mantém o de menor id

-- ---------------------------------------------------------------
-- 12.7  UPSERT — insert ou update em uma operação só
-- ---------------------------------------------------------------

insert into livros (id, nome, idioma, vendas)
values (999, 'Livro Teste', 'Portuguese', 39.90)
on duplicate key update
    nome   = values(nome),
    vendas = values(vendas);


-- ================================================================
-- FIM DO ARQUIVO — SQL AVANÇADO
-- Banco: livraria | MBA USP/ESALQ Data Science e Analytics
-- ================================================================
