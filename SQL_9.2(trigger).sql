/* В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них.
 Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 При попытке присвоить полям NULL-значение необходимо отменить операцию.*/
 
 DELIMITER //
 CREATE TRIGGER validate_name_description_insert BEFORE INSERT ON products
 FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' -- код ошибки
        SET MESSAGE_TEXT = 'Both name and description are NULL'; -- СОобщение об ошибке
	END IF;
END//

INSERT INTO products
	(name, description,price,catalog_id)
VALUES
	(NULL,NULL,9360.00,2)//
    
CREATE TRIGGER validate_name_description_update BEFORE UPDATE ON products
 FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' -- код ошибки
        SET MESSAGE_TEXT = 'Both name and description are NULL'; -- СОобщение об ошибке
	END IF;
END//