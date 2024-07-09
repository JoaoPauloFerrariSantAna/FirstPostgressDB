-- DDL
create table alunos_tbl(
	id_aluno 	integer not null primary key,
	nome		varchar(100),
	email		varchar(200),
	data_nasc	date
);

create table curso_tbl(
	id_curso	integer not null primary key default nextval('curso_seq'),
	nome_curso	varchar(50),
	desc_curso	text,
	nivel		integer not null,
	duracao		integer not null
);

create table inscricao_tbl(
	id_incricao	integer not null primary key default nextval('inscricao_seq'),
	id_aluno	integer,
	id_curso	integer,
	data_inscr	timestamp default now()
);

create sequence alunos_seq;
create sequence curso_seq;
create sequence inscricao_seq;

drop table alunos_tbl;

alter table alunos_tbl alter column id_aluno set default nextval('alunos_seq');

alter table inscricao_tbl 
add constraint fk_id_aluno foreign key (id_aluno) references alunos_tbl(id_aluno);

alter table inscricao_tbl
add constraint fk_id_curso foreign key (id_curso) references curso_tbl(id_curso)

-- DML

select id_aluno, nome, email, data_nasc from alunos_tbl;

select id_aluno, id_curso, data_inscr from inscricao_tbl;

select nome, data_nasc, email from alunos 
where email like '%.com' order by data_nasc desc,
id_aluno asc limit 2;

select nome, data_nasc, email from alunos 
where email ilike '%.com' order by data_nasc desc, id_aluno desc
offset 2 limit 2;

select nome, email from alunos
where data_nasc < '2000-01-01';

select id_curso, nome_curso, desc_curso, nivel, duracao from curso_tbl;

-- Joins em postgres
select A.nome , C.nome_curso, C.id_curso
from inscricao_tbl I
right join alunos_tbl A on I.id_aluno = A.id_aluno
left join curso_tbl C on C.id_curso = I.id_curso;

insert into alunos_tbl(nome, email, data_nasc) VALUES(
	'Rose', 'lalondeRose@gmail.com', '2001-09-11'
);

update alunos
set nome = 'Beren', email = 'Beren@gmail.com'
where id_aluno = 2;

delete from alunos
where id_aluno = 3;

insert into curso_tbl(nome_curso, desc_curso, nivel, duracao)
values('HTML+CSS+JS', 'Curso basico de HTML, CSS e JS', 0, 40);

insert into curso_tbl(nome_curso, desc_curso, nivel, duracao)
values('Assembly', 'Curso avancado de ASM', 10, 120);

insert into curso_tbl(nome_curso, desc_curso, nivel, duracao)
values('CPP', 'Curso intermediario de C++', 7, 75);

insert into curso_tbl(nome_curso, desc_curso, nivel, duracao)
values('Elixir', 'Curso intermediario de Elixir', 7, 100);

insert into inscricao_tbl(id_aluno, id_curso) values(7, 2);