SHOW DATABASES;

USE day_4_9_db;

SHOW TABLES;

SELECT * FROM users;

-- TRANSACTIONの開始
START TRANSACTION;

-- UPDATE処理
UPDATE users SET name="中山 成美" WHERE id=1;

SELECT * FROM users;

-- ROLLBACK(トランザクション開始前に戻す)
ROLLBACK;

-- COMMIT(トランザクションをDBに反映)
COMMIT;


-- ROLLBACK 
ROLLBACK;

SELECT * FROM students;

-- id=300を削除
DELETE FROM students WHERE id=300;

-- AUTOCOMMIT確認
SHOW VARIABLES WHERE variable_name="autocommit";

SET AUTOCOMMIT=0;

DELETE FROM students WHERE id=299;

-- SQLの反映
COMMIT;

SELECT * FROM students ORDER BY id DESC LIMIT 10;


-- AUTOCOMMITを元に戻す
SET AUTOCOMMIT = 1;
