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