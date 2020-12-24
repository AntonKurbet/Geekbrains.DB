-- 1. Создайте запрос, который выведет информацию:
--  id пользователя;
-- имя;
-- лайков получено;
-- лайков поставлено;
-- взаимные лайки.

SELECT DISTINCT
    q1.id_who, q1.name, q1.likes_times, q2.liked_times
FROM
    (SELECT 
        id_who, name, COUNT(*) likes_times
    FROM
        likes l
    JOIN users u ON u.id = l.id_who
    GROUP BY id_who) q1
        left JOIN
    (SELECT 
        id_whom, name, COUNT(*) liked_times
    FROM
        likes l
    JOIN users u ON u.id = l.id_whom
    GROUP BY id_whom) q2
    on q1.id_who = q2.id_whom;

-- Не понял про взаимные лайки, как это вообще должно выглядеть?
-- Дальше не УСПЕЛ , но должно быть все просто 2 разными типами JOIN

-- 2. Для структуры из задачи 1 выведите список всех пользователей, 
-- которые поставили лайк пользователям A и B (id задайте произвольно), 
-- но при этом не поставили лайк пользователю C.

select q1.id_who from 
(SELECT DISTINCT
    id_who
FROM
    likes
WHERE
    id_whom = 1) q1
    JOIN
(SELECT DISTINCT
    id_who
FROM
    likes
WHERE
    id_whom = 2) q2
    on q1.id_who = q2.id_who
    
