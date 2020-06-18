-- Создаём справочники 
CREATE TABLE studios (
    studio_id        SERIAL,
    studio_name       varchar(400),    
    CONSTRAINT studios_pkey PRIMARY KEY (studio_id),
    CONSTRAINT studios_ukey UNIQUE(studio_name)
);

CREATE TABLE studios_film (
    studios_film_id        SERIAL,
    studio_id       integer,    
    film_id       integer,    
    CONSTRAINT studios_film_pkey PRIMARY KEY (studios_film_id),
    CONSTRAINT studios_film_ukey UNIQUE(studio_id,film_id)
);


CREATE TABLE ages (
    age_id        SERIAL,
     age_name       varchar(400),    
    CONSTRAINT ages_pkey PRIMARY KEY (age_id),
    CONSTRAINT ages_ukey UNIQUE(age_name)
);


CREATE TABLE genres (
    genre_id        SERIAL,
    genre_name       varchar(400),    
    CONSTRAINT genres_pkey PRIMARY KEY (genre_id),
    CONSTRAINT genres_ukey UNIQUE(genre_name)
);


CREATE TABLE countries (
    country_id        SERIAL,
    country_name       varchar(400),    
    CONSTRAINT countries_pkey PRIMARY KEY (country_id),
    CONSTRAINT countries_ukey UNIQUE(country_name)
);

CREATE TABLE countries_film (
    countries_film_id        SERIAL,
    country_id       integer,    
    film_id       integer,    
    CONSTRAINT countries_film_pkey PRIMARY KEY (countries_film_id),
    CONSTRAINT countries_film_ukey UNIQUE(country_id,film_id)
);


CREATE TABLE categories (
    category_id        SERIAL,
    category_name       varchar(400),    
    CONSTRAINT categories_pkey PRIMARY KEY (category_id),
    CONSTRAINT categories_ukey UNIQUE(category_name)
);

CREATE TABLE statuses (
    status_id        SERIAL,
    status_name       varchar(10),    
    CONSTRAINT statuses_pkey PRIMARY KEY (status_id),
    CONSTRAINT statuses_ukey UNIQUE(status_name)
);

CREATE TABLE years_film (
    year        integer,
    film_id       varchar(10),
      CONSTRAINT years_film_ukey UNIQUE(year,film_id)
);

CREATE TABLE directors (
    director_id        SERIAL,
    director_name       varchar(400),    
    CONSTRAINT directors_pkey PRIMARY KEY (director_id),
    CONSTRAINT directors_ukey UNIQUE(director_name)
);

CREATE TABLE directors_film (
    directors_film_id        SERIAL,
    director_id       integer,    
    film_id       integer,    
    CONSTRAINT directors_film_pkey PRIMARY KEY (directors_film_id),
    CONSTRAINT directors_film_ukey UNIQUE(director_id,film_id)
);


CREATE TABLE authors (
    author_id        SERIAL,
    author_name       varchar(400),    
    CONSTRAINT authors_pkey PRIMARY KEY (author_id),
    CONSTRAINT authors_ukey UNIQUE(author_name)
);

CREATE TABLE authors_film (
    authors_film_id        SERIAL,
    author_id       integer,    
    film_id       integer,    
    CONSTRAINT authors_film_pkey PRIMARY KEY (authors_film_id),
    CONSTRAINT authors_film_ukey UNIQUE(author_id,film_id)
);

CREATE TABLE cameramans (
    cameraman_id        SERIAL,
    cameraman_name       varchar(400),    
    CONSTRAINT cameramans_pkey PRIMARY KEY (cameraman_id),
    CONSTRAINT cameramans_ukey UNIQUE(cameraman_name)
);

CREATE TABLE cameramans_film (
    cameramans_film_id        SERIAL,
    cameraman_id       integer,    
    film_id       integer,    
    CONSTRAINT cameramans_film_pkey PRIMARY KEY (cameramans_film_id),
    CONSTRAINT cameramans_film_ukey UNIQUE(cameraman_id,film_id)
);

-- Создаём основную таблицу 
CREATE TABLE films (
    id        SERIAL,
    film_key integer, 
    start_ts date default '1900-01-01',
    end_ts date default '2999-12-31',
    is_current integer default 0,
    create_ts date default  now(),
    update_ts date default  now(),
    title       varchar(400), 
    age_id integer,
    genre_id integer,
    category_id integer,
    price float,
    cost float,
    status_id        integer,
    CONSTRAINT films_pkey PRIMARY KEY (id)
   
);


-- заполнение справочников
insert into studios (studio_name )
select distinct trim(s.token)
FROM   films_raw t, unnest(string_to_array(t.studio, ',')) s(token)
where   trim(s.token) != '';

insert into public.studios_film (film_id , studio_id )
select distinct id, st.studio_id from  films_raw t, unnest(string_to_array(t.studio, ',')) s(token)
inner join studios st on st.studio_name  = trim(s.token)
where   trim(s.token) != ''

--- Years
WITH RECURSIVE r AS (
	select t.id , t.dyear, min(s.token) minyear , max(cast( s.token as integer)) maxyear, min(cast(s.token as integer))  currentyear 
	from (
	select  distinct t.id , trim(s.token) dyear
	from films_raw t,  unnest(string_to_array(t.year, ',')) s(token)
	-- where id in (2160478, 2166535)
	) t,  unnest(string_to_array(t.dyear, '-')) s(token)
	group by t.id ,t.dyear 	
	union 	
	select  r.id as id,  r.dyear as dyear,   r. minyear  as minyear,  r.maxyear as maxyear, currentyear + 1 as currentyear
	from r 
	where currentyear < r.maxyear
)
insert into years_film (film_id , year)
select id as film_id, currentyear as year from r
order by r.id, r.currentyear;

-- directors 

insert into directors(director_name)
select distinct trim(s.token) 
from films_raw t,  unnest(string_to_array(t.director , ',')) s(token);


insert into  public.directors_film (film_id ,director_id  )
select distinct t.id, d.director_id 
from films_raw t,  unnest(string_to_array(t.director , ',')) s(token)
inner join directors d on d.director_name  =  trim(s.token) ;

-- script_author 
insert into authors(author_name)
select distinct trim(s.token) 
from films_raw t,  unnest(string_to_array(t.script_author , ',')) s(token);


insert into  public.authors_film (film_id ,author_id  )
select distinct t.id, d.author_id 
from films_raw t,  unnest(string_to_array(t.script_author , ',')) s(token)
inner join authors d on d.author_name  =  trim(s.token) ;

-- cameramans 
insert into cameramans(cameraman_name)
select distinct trim(s.token) 
from films_raw t,  unnest(string_to_array(t.cameraman , ',')) s(token);


insert into  cameramans_film (film_id ,cameraman_id  )
select distinct t.id, d.cameraman_id 
from films_raw t,  unnest(string_to_array(t.cameraman , ',')) s(token)
inner join cameramans d on d.cameraman_name  =  trim(s.token) ;

------------------ countries

insert into countries (country_name)
select distinct trim( replace (s.token, E'\n','') )
from films_raw t,  unnest(string_to_array(t.country , '|')) s(token)

insert into countries_film (film_id ,country_id  )
select distinct t.id, d.country_id 
from films_raw t,  unnest(string_to_array(t.country , '|')) s(token)
inner join countries d on d.country_name  =  trim( replace (s.token, E'\n','') ) ;
-----------------------

insert into statuses (status_name )
select distinct status from films_raw

insert into ages (age_name )
select distinct age from films_raw

insert into genres (genre_name )
select distinct genre from films_raw

insert into categories (category_name )
select distinct category from films_raw

-- Основная таблица Films 
insert into films (film_key,
start_ts,
end_ts,
is_current,
create_ts,
update_ts,
title,
age_id,
genre_id,
category_id,
price,
cost,
status_id) 
select fr.id
	,to_date(fr.date, 'YYYY-MM-DD' )  start_ts
	, COALESCE (LEAD(to_date(fr.date, 'YYYY-MM-DD' )) OVER (partition by fr.id  ORDER BY to_date(fr.date, 'YYYY-MM-DD' )  ), '2999-12-31' )  end_ts
	, CASE WHEN LEAD(to_date(fr.date, 'YYYY-MM-DD' )) OVER (partition by fr.id  ORDER BY to_date(fr.date, 'YYYY-MM-DD' ) ) is null THEN 1  ELSE 0 END  is_current
	, now() create_ts
	, now() update_ts
	, fr.title, age_id
	, g.genre_id
	, c.category_id
	, cast (fr.price  as float)
	,  cast (fr.cost  as float) 
	,s.status_id
from  films_raw fr
inner join statuses s on s.status_name = fr.status 
inner join ages a on a.age_name = fr.age 
inner join genres g on g.genre_name = fr.genre 
inner join categories c on c.category_name = fr.category 

-- //TODO constraints
-- //TODO indexes




 
 
 

