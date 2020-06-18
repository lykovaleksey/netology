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
    price integer,
    status_id        integer,
    olddate date,
    CONSTRAINT films_pkey PRIMARY KEY (id),   
    CONSTRAINT films_ukey UNIQUE(film_key)
);



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

--





1942,1943,1948,1954-1956,1958,1960,1963,1964,1966,1969,1972,1976
2009-2010,2012-2014

select * from films_raw
where "year"  like '%,%' and "year"  like '%-%'