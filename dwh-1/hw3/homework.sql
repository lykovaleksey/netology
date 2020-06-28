DROP TABLE IF EXISTS public.films_from_csv;
CREATE TABLE public.films_from_csv(
    id int not null primary key,   
    name varchar(400) not null,
    studio varchar(400),
    cYEAR int ,
    genre varchar(400) ,
    country  varchar(400) ,
    category  varchar(400) ,
    price  float ,
    cost  float ,
    status  varchar(10) ,
    cdate  date 
);


select count(1) from  public.films_from_csv
-- 9106