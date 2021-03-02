-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

SELECT id, name, birthday_at, created_at, updated_at FROM shop.users;
SELECT id, name, birthday_at, created_at, updated_at FROM sample.users;
START TRANSACTION;
INSERT INTO sample.users SELECT id, name, birthday_at, created_at, updated_at FROM shop.users WHERE id = 1;

DELETE FROM shop.users WHERE id = 1 LIMIT 1;
COMMIT;

-- Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

SELECT 
	p.name,
    c.name
FROM
	products AS p
JOIN
	catalogs AS c
ON
	p.catalog_id =c.id;
    
CREATE OR REPLACE VIEW products_catalogs AS
SELECT
	p.name AS product,
    c.name AS catalog
FROM 
	products AS p 
JOIN 
	catalogs AS c 
ON 
	p.catalog_id=c.id;

SELECT product,catalog FROM products_catalogs;

/* Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года 
'2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
 если дата присутствует в исходном таблице и 0, если она отсутствует. */
 
 CREATE TABLE IF NOT EXISTS posts;
 CREATE TABLE posts(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATE NOT NULL
    );

INSERT INTO posts VALUES
	(NULL, 'Первая запись','2018-08-01'),
	(NULL, 'Вторая запись','2018-08-04'),
    (NULL, 'Третья запись','2018-08-16'),
    (NULL, 'Четвертая запись','2018-08-17');
    
SELECT * FROM posts;

CREATE TEMPORARY TABLE last_days(
day INT
);

INSERT INTO last_days VALUES
(0),(1),(2),(3),(4),(5),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30);

SELECT 	
	DATE(DATE('2018-08-31') - INTERVAL l.day DAY) AS day
FROM
	last_days AS l;
    
SELECT
	DATE (DATE('2018-08-31') - INTERVAL l.day DAY) AS day,
    NOT ISNULL(p.name) AS order_exist
FROM 
	last_days AS l
LEFT JOIN
	posts AS p
ON
	DATE(DATE('2018-08-31') -INTERVAL l.day DAY) = p.created_at
ORDER BY
	day;


-- Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

DROP TABLE IF EXISTS posts;
CREATE TABLE posts(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATE NOT NULL
    );
    
INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-11-01'),
    (NULL, 'Вторая запись', '2018-11-02'),
    (NULL, 'Третья запись', '2018-11-03'),
    (NULL, '4 запись', '2018-11-04'),
    (NULL, '5 запись', '2018-11-05'),
    (NULL, '6 запись', '2018-11-06'),
    (NULL, '7 запись', '2018-11-07'),
    (NULL, '8 запись', '2018-11-08'),
    (NULL, '9 запись', '2018-11-09'),
    (NULL, '10 запись', '2018-11-10');
    

SELECT id,name ,created_at FROM posts;

START transaction;
SELECT COUNT(*) FROM posts;
SELECT 10-5;

DELETE FROM posts ORDER BY created_at LIMIT 5;
COMMIT;

SELECT * FROM posts;

-- вычисление количества записей в таблице с помощью динамического запроса
TRUNCATE posts;
INSERT INTO posts VALUES
	(NULL, 'Первая запись', '2018-11-01'),
    (NULL, 'Вторая запись', '2018-11-02'),
    (NULL, 'Третья запись', '2018-11-03'),
    (NULL, '4 запись', '2018-11-04'),
    (NULL, '5 запись', '2018-11-05'),
    (NULL, '6 запись', '2018-11-06'),
    (NULL, '7 запись', '2018-11-07'),
    (NULL, '8 запись', '2018-11-08'),
    (NULL, '9 запись', '2018-11-09'),
    (NULL, '10 запись', '2018-11-10');
    
SELECT * FROM posts;

START TRANSACTION;
PREPARE postdel FROM 'DELETE FROM posts ORDER by CREATED_at LIMIT ?';
SET @total = (SELECT COUNT(*) - 5 FROM posts);
EXECUTE postdel USING @total;
COMMIT;

SELECT * FROM posts;