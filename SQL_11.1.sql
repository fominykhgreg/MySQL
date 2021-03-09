/* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
 идентификатор первичного ключа и содержимое поля name.*/
 DROP TABLE IF EXISTS logs;
 CREATE TABLE logs (
	tablename VARCHAR (255) COMMENT 'НАЗВАНИЕ ТАБЛИЦЫ',
    external_id INT COMMENT  'Первичный ключ',
    name VARCHAR (255) COMMENT 'Поле name таблицы tablename',
    created_at DATETIME DEFAULT current_timestamp
) COMMENT = 'Журнал интернет сагазина' ENGINE = ARCHIVE;

DELIMITER //
CREATE TRIGGER log_after_insert_to_users AFTER INSERT ON users
FOR EACH ROW BEGIN
	INSERT INTO logs (tablename, external_id, name) VALUES ('users', NEW.id, NEW.name);
END//

INSERT INTO users(name,birthday_at) VALUES ('Gennadiy', '1990-10-05');

SELECT * FROM logs //

INSERT INTO catalogs (name) VALUES
	('Оперативная  память '),
    ('Жесткие диски'),
    ('Блоки питания')//
    
SELECT * FROM logs;


