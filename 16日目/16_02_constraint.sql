SHOW DATABASES;

USE day_15_18_db;

SHOW TABLES;

SELECT * FROM employees;

UPDATE employees SET name="Jiro" WHERE employee_code ="00000002";

DESCRIBE employees;

-- uniqueの追加
ALTER TABLE employees ADD CONSTRAINT uniq_employees_name UNIQUE(name);

-- 制約一覧
SELECT 
*
FROM information_schema.key_column_usage
WHERE
    table_name="employees";

-- 制約の削除
ALTER TABLE employees DROP CONSTRAINT uniq_employees_name;


-- uniqueの追加
ALTER TABLE employees ADD CONSTRAINT uniq_employees_name_age UNIQUE(name, age);

SELECT * FROM employees;

INSERT INTO employees VALUES(2, "00000003", "Taro", 19);

-- CREATE文を確認
SHOW CREATE TABLE employees;


-- DEFAULT追加
SELECT * FROM customers;

SHOW CREATE TABLE customers;
-- CHECK制約削除
ALTER TABLE customers DROP CONSTRAINT customers_chk_1;

DESCRIBE customers;

ALTER TABLE customers
ALTER age SET DEFAULT 20;

INSERT INTO customers(id, name) VALUES(2, "Jiro");

SELECT * FROM customers;

-- NOT NULLの追加
ALTER TABLE customers MODIFY name VARCHAR(255) NOT NULL;

INSERT INTO customers(id, name) VALUES(3, NULL);

-- CHECK 制約の追加
ALTER TABLE customers ADD CONSTRAINT check_age CHECK(age >= 20);


DESCRIBE customers;

ALTER TABLE customers DROP PRIMARY KEY;

-- 主キーを追加

ALTER TABLE customers 
ADD CONSTRAINT pk_customers PRIMARY KEY(id);

-- 外部キー
DESCRIBE students;

SHOW CREATE TABLE students;

ALTER TABLE students DROP CONSTRAINT students_ibfk_1;


ALTER TABLE students
ADD CONSTRAINT fk_schools_students
FOREIGN KEY(school_id) REFERENCES schools(id);

-- AUTO_INCREMENT
CREATE TABLE animals(
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主キーのID(INT型)です',
    name VARCHAR(50) NOT NULL COMMENT '動物の名前です'
);

-- COMMENTの確認
SHOW FULL COLUMNS FROM animals;

INSERT INTO animals VALUES(NULL, "Dog");

SELECT * FROM animals;

INSERT INTO animals(name) VALUES("Cat");

-- 自動の値
SELECT AUTO_INCREMENT FROM information_schema.tables WHERE TABLE_NAME="animals";

INSERT INTO animals VALUES(4, "Panda");

INSERT INTO animals VALUES(NULL, "Fish");


ALTER TABLE animals AUTO_INCREMENT = 100;

INSERT INTO animals VALUES(NULL, "Bird");

SELECT * FROM animals;


INSERT INTO animals(name)
SELECT "Snake"
UNION ALL
SELECT "Dino"
UNION ALL
SELECT "Gibra";

INSERT INTO animals(name)
SELECT name FROM animals;

SELECT * FROM animals;


