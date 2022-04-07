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

INSERT INTO schools VALUES(1, "�k���Z");

-- school_id�Ɏw�������悪�Ȃ��ƁA�Q�Ɛ������G���[
INSERT INTO students VALUES(1, "Taro", 18, 1);

-- �Q�Ɛ������G���[
UPDATE schools SET id=2;

-- �Q�Ɛ������G���[
DELETE FROM schools;

-- �Q�Ɛ������G���[
UPDATE students SET school_id=3;


DESCRIBE employees;

-- �����̃J�����ɊO���L�[
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

-- ON DELETE, ON UPDATE�ǉ�
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
-- ON DELETE, ON UPDATE�ǉ�(SET NULL)
CREATE TABLE students(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    school_id INT,
    FOREIGN KEY(school_id) REFERENCES schools(id)
    ON DELETE SET NULL ON UPDATE SET NULL
);

INSERT INTO schools VALUES(2, "�썂�Z");
INSERT INTO students VALUES(2, "Taro", 16, 2);

SELECT * FROM students;

UPDATE schools SET id=3 WHERE id=1;

UPDATE students SET school_id=3 WHERE school_id IS NULL;

SELECT * FROM schools;
DELETE FROM schools WHERE id=3;

DROP TABLE students;
-- ON DELETE, ON UPDATE�ǉ�(SET DEFAULT)
CREATE TABLE students(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    school_id INT DEFAULT -1,
    FOREIGN KEY(school_id) REFERENCES schools(id)
    ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);

SELECT * FROM schools;

INSERT INTO schools VALUES(1, "�k���Z");

INSERT INTO students VALUES(1, "Taro", 17, 1);

SELECT * FROM students;


UPDATE schools SET id=3 WHERE id=1;
