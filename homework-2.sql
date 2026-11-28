--- Задача 1. У меня БД - категория 3
select title, views from posts where published = true and category_id = 3 order by views desc;

---Задача 2. Лимит сделала 2, а не 3
select title from posts where published = false order by created_at desc limit 2;

---Задача 3. 
insert into authors (username, email, is_active) 
values ('Petr', 'petr@mail.ru', true)
RETURNING id;
insert into posts (author_id, category_id, title, body, views) 
values (6, 1, 'Заголовок статьи Петра', 'Текст статьи Петра', 14);
update posts 
set views = views+1 
where author_id = 6
returning views;
delete from posts
where id = 12
returning id, title;

---Задача 4.
SELECT DISTINCT author_id, category_id 
from posts p 
order by author_id, category_id;

---Задача 5.
ALTER TABLE authors ADD CONSTRAINT unique_email UNIQUE (email);
INSERT INTO authors (username, email) 
VALUES ('Иван', 'ivan@example.com') 
ON CONFLICT (email) --- если обнаружит ошибку по емайлу, то не сломается и пойдет дальше
DO UPDATE SET username = EXCLUDED.username ---обновляет, EXCLUDED - то имя, которое я пытаюсь вставить.
RETURNING id, username;

--- Задача 6.
select title, published, views, category_id from posts
where (published = true and views > 100) or (published = true and category_id is null); --- условия с and  выполняется в первую очередь, поэтому мы их заключаем в скобки