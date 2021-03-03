/* Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать
 фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". */

 
DELIMITER //
SELECT NOW(), HOUR(NOW())//

CREATE FUNCTION get_hour()
RETURNS INT NOT DETERMINISTIC
BEGIN
	RETURN HOUR(NOW());
END//

SELECT get_hour()//

CREATE FUNCTION hello()
RETURNS TINYTEXT NOT DETERMINISTIC
BEGIN
	DECLARE hour INT;
    SET hour = HOUR(NOW());
    CASE
		WHEN hour BETWEEN 0 AND 5 THEN
			RETURN "ДОБРОЙ НОЧИ";
		WHEN hour BETWEEN 6 AND 11 THEN
			RETURN "ДОБРОЕ УТРО";
		WHEN hour BETWEEN 12 AND 17 THEN
			RETURN "ДОБРЫЙ ДЕНЬ";
		WHEN hour BETWEEN 18 AND 23 THEN
			RETURN "ДОБРЫЙ ВЕЧЕР";
	END CASE;
END//

SELECT NOW(),hello()//



