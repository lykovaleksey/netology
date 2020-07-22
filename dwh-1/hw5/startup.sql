-- ������� � �������� 
CREATE TABLE stage.films(
    film_id int not null primary key,   
    name varchar(400) not null,
    studio varchar(400),
    year varchar(400),
    producer varchar(400),
    screenwriter  varchar(400),
    operator  varchar(400),
    age varchar(400),
    genre varchar(400),
    country varchar(400),
    category varchar(400),
    price float,
    cost float,
    status varchar(400),
    date varchar(20)
);

-- ����� � ������� ����������
create schema metadata;
create table metadata.csv (
	filename varchar(256) not null,
	schema_name varchar(256) not null,
	table_name varchar(256) not null,
	source_field varchar(256) not null,
	source_field_type varchar(256) not null default 'String',
	target_field varchar(256),
	target_field_type varchar(256),
	ord smallint,   
	primary key (filename, schema_name, table_name, source_field)
);
-- ������ �� ���������� �� �������
insert into metadata.csv (filename, schema_name, table_name, source_field, source_field_type, target_field,
target_field_type, ord)
values
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', 'ID', 'Number', 'film_id', 'int', 1),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '��������', 'String', 'name', 'varchar(100)', 2),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '������', 'String', 'studio', 'varchar(100)', 3),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '��� ������������', 'String', 'year', 'varchar(200)', 4),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '�����Ѩ�', 'String', 'producer', 'varchar(100)', 5),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '���������', 'String', 'screenwriter', 'varchar(100)', 6),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '��������', 'String', 'operator', 'varchar(100)', 7),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '���������� ���������', 'String', 'age', 'varchar(100)', 8),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '����', 'String', 'genre', 'varchar(100)', 9),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '������', 'String', 'country', 'varchar(100)', 10),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '���������', 'String', 'category', 'varchar(100)', 11),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '����', 'Number', 'price', 'double precision', 12),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '�������������', 'Number', 'cost', 'double precision', 13),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '������', 'String', 'status', 'char(1)', 14),
('d:\netology\dwh-1\hw5\films.csv', 'stage', 'films', '����', 'String', 'date', 'varchar(20)', 15);


/*
select * from stage.films
select * from metadata.csv

SELECT * 
FROM metadata.csv 
WHERE filename = 'd:\netology\dwh-1\hw5\films.csv'
order by filename, ord
*/




