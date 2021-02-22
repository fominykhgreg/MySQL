-- Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке.

select firstname
from users
group by firstname
order by firstname;




-- Первые пять пользователей пометить как удаленные.

update users
set is_deleted = b'1'
order by id
limit 5;



-- Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней).

delete from messages
where created_at > NOW();



-- Курсовой проект хочу сделать на тему аренды квартир. 
-- Сделать БД, где будут хранится пользователи,сами объявления с фото и текстом,сообщения между пользователями,так же информация о количестве комнат и цене.