SHOW DATABASES;

USE day_4_9_db;

SHOW TABLES;

SELECT * FROM users;

-- TRANSACTION�̊J�n
START TRANSACTION;

-- UPDATE����
UPDATE users SET name="���R ����" WHERE id=1;

SELECT * FROM users;

-- ROLLBACK(�g�����U�N�V�����J�n�O�ɖ߂�)
ROLLBACK;

-- COMMIT(�g�����U�N�V������DB�ɔ��f)
COMMIT;


-- ROLLBACK 
ROLLBACK;

SELECT * FROM students;

-- id=300���폜
DELETE FROM students WHERE id=300;

-- AUTOCOMMIT�m�F
SHOW VARIABLES WHERE variable_name="autocommit";

SET AUTOCOMMIT=0;

DELETE FROM students WHERE id=299;

-- SQL�̔��f
COMMIT;

SELECT * FROM students ORDER BY id DESC LIMIT 10;


-- AUTOCOMMIT�����ɖ߂�
SET AUTOCOMMIT = 1;
