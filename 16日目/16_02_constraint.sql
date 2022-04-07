SHOW DATABASES;

USE day_15_18_db;

SHOW TABLES;

SELECT * FROM employees;

UPDATE employees SET name="Jiro" WHERE employee_code ="00000002";

DESCRIBE employees;

-- unique�̒ǉ�
ALTER TABLE employees ADD CONSTRAINT uniq_employees_name UNIQUE(name);

-- ����ꗗ
SELECT 
*
FROM information_schema.key_column_usage
WHERE
    table_name="employees";

-- ����̍폜
ALTER TABLE employees DROP CONSTRAINT uniq_employees_name;


-- unique�̒ǉ�
ALTER TABLE employees ADD CONSTRAINT uniq_employees_name_age UNIQUE(name, age);

SELECT * FROM employees;

INSERT INTO employees VALUES(2, "00000003", "Taro", 19);

-- CREATE�����m�F
SHOW CREATE TABLE employees;


-- DEFAULT�ǉ�
SELECT * FROM customers;

SHOW CREATE TABLE customers;
-- CHECK����폜
ALTER TABLE customers DROP CONSTRAINT customers_chk_1;

DESCRIBE customers;

ALTER TABLE customers
ALTER age SET DEFAULT 20;

INSERT INTO customers(id, name) VALUES(2, "Jiro");

SELECT * FROM customers;

-- NOT NULL�̒ǉ�
ALTER TABLE customers MODIFY name VARCHAR(255) NOT NULL;

INSERT INTO customers(id, name) VALUES(3, NULL);

-- CHECK ����̒ǉ�
ALTER TABLE customers ADD CONSTRAINT check_age CHECK(age >= 20);


DESCRIBE customers;

ALTER TABLE customers DROP PRIMARY KEY;

-- ��L�[��ǉ�

ALTER TABLE customers 
ADD CONSTRAINT pk_customers PRIMARY KEY(id);

-- �O���L�[
DESCRIBE students;

SHOW CREATE TABLE students;

ALTER TABLE students DROP CONSTRAINT students_ibfk_1;


ALTER TABLE students
ADD CONSTRAINT fk_schools_students
FOREIGN KEY(school_id) REFERENCES schools(id);

-- AUTO_INCREMENT
CREATE TABLE animals(
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '��L�[��ID(INT�^)�ł�',
    name VARCHAR(50) NOT NULL COMMENT '�����̖��O�ł�'
);

-- COMMENT�̊m�F
SHOW FULL COLUMNS FROM animals;

INSERT INTO animals VALUES(NULL, "Dog");

SELECT * FROM animals;

INSERT INTO animals(name) VALUES("Cat");

-- �����̒l
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


