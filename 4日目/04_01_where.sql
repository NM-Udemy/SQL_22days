-- CREATE DATABASE day_4_9_db;


SHOW DATABASES;

USE day_4_9_db;


SHOW TABLES;

-- users�̒�`
DESCRIBE users;


SELECT * FROM users LIMIT 10;

-- = �ōi�荞��
SELECT * FROM users WHERE name = "���� ����";

SELECT * FROM users WHERE birth_place="���{";

-- FROM �� WHERE �� ORDER BY �� LIMIT
SELECT * FROM users WHERE birth_place<>"���{" ORDER BY age LIMIT 10;

-- <, >, <=, >=, <>
SELECT * FROM users WHERE age<=50 LIMIT 10

DESCRIBE users;

-- ���t�̎��o��
SELECT * FROM users WHERE birth_day < "2011-04-03";

-- tinyint 1 or 0
SELECT * FROM users WHERE is_admin=0;


-- UPDATE
UPDATE users SET name="���R ����" WHERE id=1;

SELECT * FROM users WHERE id=1;


-- DELETE

SELECT * FROM users ORDER BY id DESC LIMIT 1;

DELETE FROM users WHERE id>190;