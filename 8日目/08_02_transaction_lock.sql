SHOW DATABASES;
USE day_4_9_db;

START TRANSACTION;

SHOW TABLES;

SELECT * FROM customers;

-- ��L�[��UPDATE(�s���b�N)
UPDATE customers SET age=43 WHERE id=1;

ROLLBACK;


START TRANSACTION;

-- �e�[�u���S�̂̃��b�N
UPDATE customers SET age=42
-- WHERE id=1;
WHERE name="�͖� ���T";

ROLLBACK;

-- DELETE
START TRANSACTION ;

-- �s���b�N
DELETE FROM customers WHERE id=1; 
COMMIT;

-- INSERT
START TRANSACTION;


INSERT INTO customers VALUES(1, "�c�� ��Y", 21, "1999-0-01");
SELECT * FROM customers;


COMMIT;


-- SELECT�̃��b�N
-- FOR SHARE(���L���b�N)
-- FOR UPDATE(�r�����b�N)

START TRANSACTION;
SELECT * FROM customers WHERE id=1 FOR SHARE;

ROLLBACK 


START TRANSACTION;
SELECT * FROM customers WHERE id=1 FOR UPDATE;
ROLLBACK;


-- LOCK TABLE READ
LOCK TABLE customers READ;
SELECT * FROM customers;
UPDATE customers SET age=42 WHERE id=1;

UNLOCK TABLES;

-- LOCK TABLE WRITE
LOCK TABLE customers WRITE;
SELECT * FROM customers;
UPDATE customers SET age=42 WHERE id=1;


-- DEAD LOCK 

START TRANSACTION;
-- customers �� users
UPDATE customers SET age=42 WHERE id=1;

UPDATE users SET age=12 WHERE id=1;


