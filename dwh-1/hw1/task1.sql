CREATE TABLE studios (
    studio_id        integer,
    studio_name       varchar(400),    
    CONSTRAINT studios_pkey PRIMARY KEY (studio_id),
    CONSTRAINT studios_ukey UNIQUE(studio_name)
);

CREATE TABLE studios_film (
    studios_film_id        integer,
    studio_id       integer,    
    film_id       integer,    
    CONSTRAINT studios_film_pkey PRIMARY KEY (studios_film_id),
    CONSTRAINT studios_film_ukey UNIQUE(studio_id,film_id)
);


CREATE TABLE ages (
    age_id        integer,
     age_name       varchar(400),    
    CONSTRAINT ages_pkey PRIMARY KEY (age_id),
    CONSTRAINT ages_ukey UNIQUE(age_name)
);


CREATE TABLE genres (
    genre_id        integer,
    genre_name       varchar(400),    
    CONSTRAINT genres_pkey PRIMARY KEY (genre_id),
    CONSTRAINT genres_ukey UNIQUE(genre_name)
);


CREATE TABLE countries (
    country_id        integer,
    country_name       varchar(400),    
    CONSTRAINT countries_pkey PRIMARY KEY (country_id),
    CONSTRAINT countries_ukey UNIQUE(country_name)
);

CREATE TABLE countries_film (
    countries_film_id        integer,
    country_id       integer,    
    film_id       integer,    
    CONSTRAINT countries_film_pkey PRIMARY KEY (countries_film_id),
    CONSTRAINT countries_film_ukey UNIQUE(country_id,film_id)
);


CREATE TABLE categories (
    category_id        integer,
    category_name       varchar(400),    
    CONSTRAINT categories_pkey PRIMARY KEY (category_id),
    CONSTRAINT categories_ukey UNIQUE(category_name)
);

CREATE TABLE statuses (
    status_id        integer,
    status_name       varchar(10),    
    CONSTRAINT statuses_pkey PRIMARY KEY (status_id),
    CONSTRAINT statuses_ukey UNIQUE(status_name)
);



CREATE TABLE films (
    id        integer,
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



