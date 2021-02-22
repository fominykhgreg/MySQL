-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
SELECT * FROM users;
UPDATE users SET created_at =NOW(), updated_at = NOW();



-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(225),
  updated_at VARCHAR(225)
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES -- заполняем данными
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20','03.09.2016 17:05', '03.09.2016 17:05'),
  ('Сергей', '1988-02-14', '02.08.2016 18:10', '02.08.2016 18:10'),
  ('Иван', '1998-01-12', '09.03.2017 11:01', '09.03.2017 11:01'),
  ('Мария', '1992-08-29', '07.01.2017 10:04', '07.01.2017 10:04');

SELECT str_to_date(created_at, '%d.%m.%Y %k:%i') FROM users; -- приводим к нужному формату

UPDATE users SET 
	created_at = str_to_date(created_at, '%d.%m.%Y %k:%i'),
    updated_at = str_to_date(updated_at, '%d.%m.%Y %k:%i');
    
SELECT * FROM users;

 
ALTER TABLE users CHANGE 
	updated_at updated_at DATETIME DEFAULT current_timestamp ON UPDATE current_timestamp; -- меняем тип данных столбцов





-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей
INSERT INTO storehouses_products(storehouse_id, product_id, value)
VALUES
	(1,543,0),
    (1,789,2500),
    (1,3432,0),
    (1,826,30),
    (1,719,500),
    (1,638,1);
    
SELECT * FROM storehouses_products ORDER BY value;
SELECT id, value, IF( value > 0, 0, 1) as sort FROM storehouses_products ORDER BY value;

