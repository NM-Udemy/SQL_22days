SELECT * FROM customers WHERE name IS NULL;

-- COUNT
SELECT COUNT(*) FROM customers; -- ���s�f�[�^�������Ă��邩
SELECT COUNT(name) FROM customers; -- ��w��(���̗�ɉ��s�����Ă��邩(NULL�̓J�E���g���Ȃ�))

SELECT COUNT(name) FROM customers WHERE id>80;

SELECT * FROM customers;

-- MAX: �ő�, MIN: �ŏ�
SELECT MAX(age), MIN(age) FROM users WHERE birth_place="���{";

SELECT MAX(birth_day), MIN(birth_day) FROM users;

-- SUM: ���v�l
SELECT SUM(salary) FROM employees;

SELECT * FROM employees;
SELECT AVG(salary) FROM employees;


-- AVG: NULL�̏ꍇ���ʓ|
CREATE TABLE tmp_count(
   num INT
);

SHOW TABLES;

INSERT INTO tmp_count VALUES(1);
INSERT INTO tmp_count VALUES(2);
INSERT INTO tmp_count VALUES(3);
INSERT INTO tmp_count VALUES(NULL);

SELECT * FROM tmp_count;

SELECT AVG(COALESCE(num, 0)) FROM tmp_count;

-- (1 + 2 + 3 + 0) / 4 = 1.5