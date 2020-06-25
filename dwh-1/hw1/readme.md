# Задание 
Перед началом работы
Склонировать репозиторий: https://github.com/Siao-pin/data-engineer
Загрузить таблицу с фильмами в БД. Для этого необходимо выполнить скрипт lecture1/films_raw.sql

Задание
Необходимо нормализовать таблицу films_raw (загруженную на предыдущем шаге). Сделать из неё таблицу films таким образом, чтобы вся избыточная информация была разложена по соответствующим таблицам.

Пример: значения из колонки category сложить в таблицу film_category. В таблице films текстовую колонку category заменить на ссылку category_id на таблицу film_category.

Колонки year и status заменять не надо. Обработка year будет в рамках Задачи со звёздочкой. status же имеет всего 3 значения и создание для него отдельной таблицы не имеет смысла (в виде упражнения можно сделать поле типом enum).

Помимо внешних ключей к новым таблицам, которые вы создадите в таблице должны присутствовать поля:

id - уникальный суррогатный ключ
film_key - натуральный ключ, поле id из таблицы films_raw
start_ts - момент во времени, когда данная запись стала актуальна. Значение по умолчанию - 1900-01-01
end_ts - момент во времени, когда данная запись перестала быть актуальной. Значение по умолчанию - 2999-12-31
is_current - флаг, показывающий, является ли данная строка текущим действующим значением (1 - да, 0 - нет)
create_ts - дата и время добавления записи
update_ts - дата и время обновления записи

Указания к выполнению:

Для загрузки файла sql удобно использовать консольную утилиту psql
Для выполнения задания потребуется работа с массивами https://www.postgresql.org/docs/9.6/functions-array.html

Задание со звёздочкой
Создать таблицу film_years для связи натурального ID фильма с годом его выпуска. Важно помнить, что года выпуска могу идти через запятую. В этом случае, необходимо добавить каждый год. Также года могут разделяться знаком тире. Это означает, что необходимо внести в таблицу диапазон лет, началом и концом которого являются соответственно левый и правый год.

Пример: для значения year = ‘2008,2010,2012-2015’в таблицу будут записаны года: 2008, 2010, 2012, 2013, 2014, 2015.