create database loja;
use loja;

create table cliente(
id_cliente int auto_increment primary key,
nome varchar(100) not null,
email varchar(100) not null
);

