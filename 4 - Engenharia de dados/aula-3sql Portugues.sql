use livraria;

select 
    idioma,
    count(*) as quantidade_livros
from livros
group by idioma;

-- view
-- lista a quantidade de livros por idioma.
create view livros_por_idioma as
select 
    idioma,
    count(*) as quantidade_livros
from livros
group by idioma;

select * from livros;

select * from livros
where idioma = 'Portuguese';

-- visualização dos livros com seus respectivos autores e gêneros
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

-- quantos comentários cada livro recebeu.
create view comentarios_por_livro as
select 
    l.nome as nome_livro,
    count(c.id) as quantidade_comentarios
from livros l
left join comentarios c on l.id = c.livro_id
group by l.id, l.nome;

select * from comentarios_por_livro;

-- ordenado pela quantidade
select * from comentarios_por_livro
order by quantidade_comentarios desc;




create view todos_comentarios as 
select * from comentarios;

select * from todos_comentarios;

create view livros_ingles as
select * from livros
where idioma = 'English';

select * from livros_ingles;

create view livro_autor as
select l.nome as livro, a.nome as autor
from livros l
join autores a on autor_id = a.id;

select * from livro_autor;

-- drop view livro_autor;

-- atualizar as vendas de um livro
select id, nome, vendas from livros where id = 42;


-- Procedures
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

call atualizar_vendas_livro(42, 39.01);

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

call inserir_comentario_livro(42, 'julio', 'alcantara', 'ótimo livro, recomendo!');

select * from comentarios order by id desc;


-- drop procedure nome_procedure;
