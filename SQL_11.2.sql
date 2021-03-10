-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.

CREATE TABLE samples (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = "Покупатели";

INSERT INTO samples (name,birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');


SELECT COUNT(*) FROM
	samples AS asd,
    samples AS asdf,
    samples AS asff,
    samples AS qweq,
    samples AS qw,
    samples AS q,
    samples AS qwqw,
    samples AS asdfg,
    samples AS dfgd;
    
INSERT INTO
	users(name,birthday_at)
SELECT
	asd.name,
    asd.birthday_at
FROM
samples AS asd,
    samples AS asdf,
    samples AS asff,
    samples AS qweq,
    samples AS qw,
    samples AS q,
    samples AS qwqw,
    samples AS asdfg,
    samples AS dfgd;
	
    
    

SELECT * FROM users LIMIT 100;
	