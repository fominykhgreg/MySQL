-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT
	from_user_id,
	COUNT(*) cnt,
    CONCAT(
		(select firstname from users where id = m.from_user_id), ' ',
        (select lastname from users where id = m.from_user_id)
	) as name
FROM messages m
WHERE to_user_id=1
	AND from_user_id IN(
		select initiator_user_id from friend_requests where (target_user_id=1) and status ='approved'
		union
		select target_user_id from friend_requests where(initiator_user_id=1)and status ='approved'
    )
group by from_user_id
ORDER BY cnt DESC
LIMIT 1;


-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

SELECT count(*) -- количество лайков
from likes
where media_id in(  -- медиазаписи пользователей
	select id
    from media
    where user_id in( -- пользователи меньше 10 лет
		select
			user_id
        from profiles as p
        where TIMESTAMPDIFF(year,birthday,NOW())<10
    )
);

-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT
	gender,
    count(*)
from
	(SELECT
			user_id as user,
			(
				select gender
				from vk.profiles
				where user_id =user
				) as gender
			from likes)as list
group by gender;