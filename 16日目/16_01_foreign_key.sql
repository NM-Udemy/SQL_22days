SHOW DATABASES;

USE day_15_18_db;


SHOW TABLES;

DROP TABLE students;

CREATE TABLE schools(
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE students(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    school_id INT,
    FOREIGN KEY(school_id) REFERENCES schools(id)
);

INSERT INTO schools VALUES(1, "北高校");

-- school_idに指し示す先がないと、参照整合性エラー
INSERT INTO students VALUES(1, "Taro", 18, 1);

-- 参照整合性エラー
UPDATE schools SET id=2;

-- 参照整合性エラー
DELETE FROM schools;

-- 参照整合性エラー
UPDATE students SET school_id=3;


DESCRIBE employees;

-- 複数のカラムに外部キー
CREATE TABLE salaries(
    id INT PRIMARY KEY,
    company_id INT,
    employee_code CHAR(8),
    payment INT,
    paid_date DATE,
    FOREIGN KEY (company_id, employee_code) REFERENCES employees(company_id, employee_code)
);

SELECT * FROM employees;

INSERT INTO salaries VALUES(1, 1, "00000001", 1000, "2020-01-01");


DESCRIBE students;

DROP TABLE students;

-- ON DELETE, ON UPDATE追加
CREATE TABLE students(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    school_id INT,
    FOREIGN KEY(school_id) REFERENCES schools(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO students VALUES(1, "Taro", 18, 1);

SELECT * FROM students;

SELECT * FROM schools;
UPDATE schools SET id=3 WHERE id=1;


DELETE FROM schools;

DROP TABLE students;
-- ON DELETE, ON UPDATE追加(SET NULL)
CREATE TABLE students(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    school_id INT,
    FOREIGN KEY(school_id) REFERENCES schools(id)
    ON DELETE SET NULL ON UPDATE SET NULL
);

INSERT INTO schools VALUES(2, "南高校");
INSERT INTO students VALUES(2, "Taro", 16, 2);

SELECT * FROM students;

UPDATE schools SET id=3 WHERE id=1;

UPDATE students SET school_id=3 WHERE school_id IS NULL;

SELECT * FROM schools;
DELETE FROM schools WHERE id=3;

DROP TABLE students;
-- ON DELETE, ON UPDATE追加(SET DEFAULT)
CREATE TABLE students(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    school_id INT DEFAULT -1,
    FOREIGN KEY(school_id) REFERENCES schools(id)
    ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);

SELECT * FROM schools;

INSERT INTO schools VALUES(1, "北高校");

INSERT INTO students VALUES(1, "Taro", 17, 1);

SELECT * FROM students;


UPDATE schools SET id=3 WHERE id=1;
