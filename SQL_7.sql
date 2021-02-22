-- 1.Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT id, name, birthday_at FROM users;
SELECT id,user_id, created_at,updated_at FROM orders;
SELECT id, order_id, product_id, total, created_at, updated_at FROM orders_products;

INSERT INTO orders (user_id) SELECT id FROM users WHERE name = 'Геннадий';
INSERT INTO orders_products (order_id, product_id, total) SELECT LASR_INSERT_ID(), id,2 FROM products WHERE name = 'Intel Core i5-7400' ;

INSERT INTO orders (user_id) SELECT id FROM users WHERE name = 'Наталья';
INSERT INTO orders_products (order_id, product_id, total) SELECT LASR_INSERT_ID(), id,1 FROM products WHERE name IN( 'Intel Core i5-7400','Gigabyte H310M S2H');

INSERT INTO orders (user_id) SELECT id FROM users WHERE name = 'Иван';
INSERT INTO orders_products (order_id, product_id, total) SELECT LASR_INSERT_ID(), id,1 FROM products WHERE name IN( 'AMD FX-8320','ASUS ROG MAXIMUS X HERO');

SELECT DISTINCT user_id FROM orders;

SELECT id, name, birthday_at FROM users WHERE id IN (SELECT DISTINCT user_id FROM orders);

-- 2.Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT id, name, price, catalog_id FROM products;
SELECT id, name FROM catalogs;
SELECT id, name, price, (SELECT name FROM catalogs WHERE id = products.catalog_id) AS catalog FROM products;

/*
-- Вариант с JOIN-соединением таблиц
SELECT p.id, p.name , p.price, c.name AS catalog FROM products AS p LEFT JOIN catalogs AS c ON p.catalog_id =c.id;
*/

/* 3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, 
поле name — русское. Выведите список рейсов flights с русскими названиями городов. */

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
    `from` VARCHAR(255) COMMENT 'Город отправления',
    `to` VARCHAR(255) COMMENT 'Город прибытия'
) COMMENT = 'Рейсы';

INSERT INTO flights (`from`,`to`) VALUES
	('moscow','omsk'),
    ('novgorod','kazan'),
    ('irkutsk','moscow'),
    ('omsk','irkutsk'),
    ('moscow','kazan');
    
CREATE TABLE cities(
	id SERIAL PRIMARY KEY,
    label VARCHAR(255) COMMENT 'Код города',
    name VARCHAR(255) COMMENT 'Название города'
    ) COMMENT = 'Словарь городов';

INSERT INTO cities (label, name) VALUES
	('moscow','Москва'),
    ('irkutsk','Иркутск'),
    ('novgorod','Новгород'),
    ('kazan','Казань'),
    ('omsk','Омск');
    
SELECT id, label, name FROM cities;
SELECT id, `from`, `to` FROM flights;

SELECT id, 
	(SELECT name FROM cities WHERE label = flights.from) AS `from`,
    (SELECT name FROM cities WHERE label = flights.to) AS `to`
    FROM flights;

/*
 Вариант с JOIN-соединением таблиц

SELECT 
	f.id,
    cities_from.name AS `from`,
    cities_to.name AS `to`
FROM flights AS f
LEFT JOIN
	cities AS cities_from
ON 
	f.from =cities_from.label
LEFT JOIN
	cities AS cities_to
ON
	f.to = cities_to.label;
    
*/
    
