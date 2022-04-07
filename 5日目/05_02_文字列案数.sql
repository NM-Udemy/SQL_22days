-- LENGTH, CHAR_LENGTH
SELECT LENGTH("ABC");
SELECT LENGTH("������")�G-- 9 �o�C�g��

SELECT name, LENGTH(name) FROM users;


SELECT CHAR_LENGTH("ABC");
SELECT CHAR_LENGTH("������") AS length�G-- 3 ������

SELECT name, CHAR_LENGTH(name) FROM users;


-- TRIM, LTRIM, RTRIM �󔒍폜
SELECT LTRIM("   ABC   ");
SELECT RTRIM("   ABC   ") AS a;
SELECT TRIM("   ABC   ") AS a;

SELECT name, CHAR_LENGTH(name) AS name_length
FROM employees
WHERE CHAR_LENGTH(name) <> CHAR_LENGTH(TRIM(name));

-- UPDATE���ċ󔒂��폜�������̂ɂ���
UPDATE employees 
SET name=TRIM(name)
WHERE CHAR_LENGTH(name) <> CHAR_LENGTH(TRIM(name));


-- REPLACE: �u��
SELECT REPLACE("I like an apple", "apple", "lemon");


SELECT REPLACE(name, "Mrs", "Ms") FROM users WHERE name LIKE 'Mrs%';


UPDATE users SET name = REPLACE(name, "Mrs", "Ms")  WHERE name LIKE 'Mrs%';

SELECT * FROM users;



-- UPPER LOWER(�啶���A������)

SELECT UPPER("apple");
SELECT LOWER("APPLE");


SELECT name, UPPER(name), LOWER(name) FROM users;


-- SUBSTRING �ꕔ���o��
SELECT SUBSTRING(name, 2, 3), name FROM employees ;

SELECT * FROM employees WHERE SUBSTR(name, 2, 1) = "�c";



-- REVERSE: �t��
SELECT REVERSE(name), name FROM employees;