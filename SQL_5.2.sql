-- Подсчитайте средний возраст пользователей в таблице users.

SELECT timestampdiff(YEAR,birthday_at,NOW()) as age FROM users;

SELECT AVG(timestampdiff(YEAR,birthday_at,NOW())) as age FROM users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT name ,birthday_at FROM users;
SELECT MONTH(birthday_at),DAY(birthday_at) FROM users;
SELECT YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at) FROM users;
SELECT DATE( CONCAT_WS('_',YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))) as day FROM users;
SELECT DATE_FORMAT(DATE( CONCAT_WS('_',YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))),'%W') as day FROM users;
SELECT DATE_FORMAT(DATE( CONCAT_WS('_',YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))),'%W') as day FROM users GROUP BY day;
SELECT DATE_FORMAT(DATE( CONCAT_WS('_',YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))),'%W') as day, COUNT(*) as total FROM users GROUP BY day ORDER BY total DESC;