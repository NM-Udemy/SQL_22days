-- CREATE SELECT INSERT
SHOW TABLES;

CREATE TABLE tmp_students
SELECT * FROM students;

SELECT * FROM tmp_students;

DESCRIBE tmp_students;

DESCRIBE students;

DROP TABLE tmp_students;

CREATE TABLE tmp_students 
SELECT * FROM students WHERE id < 10;

SELECT * FROM tmp_students;

INSERT INTO tmp_students 
SELECT id+9 AS id, first_name, last_name, 2 AS grade FROM users ;


CREATE TABLE names 
SELECT first_name, last_name FROM students
UNION
SELECT first_name, last_name FROM employees
UNION
SELECT first_name, last_name FROM customers;

SELECT * FROM names;