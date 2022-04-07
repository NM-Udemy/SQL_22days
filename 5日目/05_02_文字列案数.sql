-- LENGTH, CHAR_LENGTH
SELECT LENGTH("ABC");
SELECT LENGTH("あいう")；-- 9 バイト数

SELECT name, LENGTH(name) FROM users;


SELECT CHAR_LENGTH("ABC");
SELECT CHAR_LENGTH("あいう") AS length；-- 3 文字数

SELECT name, CHAR_LENGTH(name) FROM users;


-- TRIM, LTRIM, RTRIM 空白削除
SELECT LTRIM("   ABC   ");
SELECT RTRIM("   ABC   ") AS a;
SELECT TRIM("   ABC   ") AS a;

SELECT name, CHAR_LENGTH(name) AS name_length
FROM employees
WHERE CHAR_LENGTH(name) <> CHAR_LENGTH(TRIM(name));

-- UPDATEして空白を削除したものにする
UPDATE employees 
SET name=TRIM(name)
WHERE CHAR_LENGTH(name) <> CHAR_LENGTH(TRIM(name));


-- REPLACE: 置換
SELECT REPLACE("I like an apple", "apple", "lemon");


SELECT REPLACE(name, "Mrs", "Ms") FROM users WHERE name LIKE 'Mrs%';


UPDATE users SET name = REPLACE(name, "Mrs", "Ms")  WHERE name LIKE 'Mrs%';

SELECT * FROM users;



-- UPPER LOWER(大文字、小文字)

SELECT UPPER("apple");
SELECT LOWER("APPLE");


SELECT name, UPPER(name), LOWER(name) FROM users;


-- SUBSTRING 一部取り出し
SELECT SUBSTRING(name, 2, 3), name FROM employees ;

SELECT * FROM employees WHERE SUBSTR(name, 2, 1) = "田";



-- REVERSE: 逆順
SELECT REVERSE(name), name FROM employees;