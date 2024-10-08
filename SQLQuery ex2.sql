drop database ex2
use master

create database ex2
go
use ex2
go
create table livro (
codigo		int				not null		identity(100001, 100),
nome		varchar(200)	not null,
lingua		varchar(10)		not null		default('PT-BR'),
ano			int				not null		check(ano >= 1990)

primary key(codigo)
)
go
create table autor (
id			int				not null		identity(2351, 1),
nome		varchar(100)	not null		unique,
data_nasc	date			not null,
pais_nasc	varchar(50)		not null
	check(pais_nasc = 'Brasil' or pais_nasc = 'Estados Unidos'
	or pais_nasc = 'Inglaterra' or pais_nasc = 'Alemanha'),
biografia	varchar(255)	not null

primary key(id)
)
go
create table livro_autor (
livroCodigo		int				not null,
autorId			int				not null

primary key (livroCodigo, autorId)
foreign key (livroCodigo) references livro(codigo),
foreign key (autorId) references autor(id)
)
go
create table edicao (
isbn			char(13)		not null	check(len(isbn) = 13),
preco			decimal(4,2)	not null	check(preco > 0),
ano				int				not null	check(ano >= 1993),
numero_paginas	int				not null	check(numero_paginas >= 15),
qtd_estoque		int				not null

primary key(isbn)
)
go
create table editora (
id				int				not null	identity(491, 16),
nome			varchar(70)		not null	unique,
telefone		varchar(11)		not null	check(len(telefone) = 11),
log_end			varchar(200)	not null,
num_end			int				not null	check(num_end >= 0),
cep_end			char(8)			not null	check(len(cep_end) = 8),
comp_end		varchar(255)	not null

primary key(id)
)
go
create table editora_edicao_livro (
editoraId		int			not null,
edicaoIsbn		char(13)	not null,
livroCodigo		int			not null

primary key(editoraId, edicaoIsbn, livroCodigo)
foreign key(editoraId) references editora(id),
foreign key (edicaoIsbn) references edicao(isbn),
foreign key (livroCodigo) references livro(codigo)
)
----------------------------------------------------
select * from livro
select * from edicao
select * from autor
select * from editora
select * from livro_autor
select * from editora_edicao_livro
----------------------------------------------------
insert into livro (nome, lingua, ano) values
('Duna 1', 'EN-US', 1990)
insert into livro (nome, lingua, ano) values
('Duna 2', 'EN-US', 1989)
insert into livro (nome, ano) values
('Duna 3', 1993)

insert into autor (nome, data_nasc, pais_nasc, biografia) values
('Frank', '1960-03-21', 'Estados Unidos', 'Lisan al Gaib')
insert into autor (nome, data_nasc, pais_nasc, biografia) values
('Frank', '1972-04-19', 'Estados Unidos', 'Esse aqui nao entra')
insert into autor (nome, data_nasc, pais_nasc, biografia) values
('Herbert', '1980-05-12', 'Alemanha', 'Hello World')
insert into autor (nome, data_nasc, pais_nasc, biografia) values
('Lucas', '1992-03-17', 'Japao', 'Esse tamb�m nao rola')

insert into livro_autor values
(100001, 2353)

insert into edicao values
('1234567891234', 1, 1993, 15, 0)
insert into edicao values --len(isbn) != 13
('1234', 50, 1994, 500, 10)
insert into edicao values --preco < 0
('1234567891235', -5, 1993, 15, 0)
insert into edicao values --ano < 1993
('1234567891235', 30, 1992, 15, 0)
insert into edicao values --numero_paginas < 15
('1234567891235', 30, 1993, 10, 0)
insert into edicao values
('1234567891235', 30, 2015, 470, 1042)

insert into editora (nome, telefone, log_end, num_end, cep_end, comp_end) values
('Astro', '11912345678', 'Rua Avenida 2', 1560, '01234567', 'Bairro Vila')
insert into editora (nome, telefone, log_end, num_end, cep_end, comp_end) values --nome duplicado
('Astro', '11912345678', 'Rua Avenida 2', 1560, '01234567', 'Bairro Vila')
insert into editora (nome, telefone, log_end, num_end, cep_end, comp_end) values --len(telefone) != 11
('Cometa', '119123', 'Estrada Incrivel', 12, '23456789', 'Casa')
insert into editora (nome, telefone, log_end, num_end, cep_end, comp_end) values --num_end < 0
('Cometa', '11934567890', 'Estrada Incrivel', -14, '01234567', 'Bairro Vila')
insert into editora (nome, telefone, log_end, num_end, cep_end, comp_end) values --len(cep) != 8
('Cometa', '11934567890', 'Estrada Incrivel', 15, '01234', 'Bairro Vila')
insert into editora (nome, telefone, log_end, num_end, cep_end, comp_end) values
('Omega', '11945450909', 'Av Aguia de Haia', 2633, '03344556', 'Fatec')

insert into editora_edicao_livro values 
(603, 1234567891235, 100201)
