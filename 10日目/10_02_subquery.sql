SHOW TABLES;

SELECT * FROM employees;


-- �����ꗗ
SELECT * FROM departments ;

-- IN �ōi�荞��
SELECT * FROM employees WHERE department_id IN(1, 2);

-- ���₢���킹���g��
SELECT id FROM departments WHERE name IN ("�o�c��敔", "�c�ƕ�");

SELECT * FROM employees WHERE department_id  NOT IN
    (SELECT id FROM departments WHERE name IN ("�o�c��敔", "�c�ƕ�")
)


SELECT * FROM students;
SELECT * FROM users;


-- �����J������IN(���₢���킹)
SELECT * FROM students
WHERE (first_name, last_name) NOT IN (
     SELECT first_name, last_name FROM users
);


-- ���₢���킹3: �W�v�Ǝg��
SELECT MAX(age) FROM employees;

SELECT * FROM employees WHERE age < (SELECT AVG(age) FROM employees);



-- ���₢���킹4: FROM�ŗp����
SELECT
MAX(avg_age) AS "�������Ƃ̕��ϔN��̍ő�",
MIN(avg_age)
FROM
(SELECT department_id, AVG(age) AS avg_age FROM employees GROUP BY department_id ) AS tmp_emp;


-- �N��̏W�v
SELECT
    MAX(age_count), MIN(age_count)
FROM
(SELECT FLOOR(age/10) * 10 , COUNT(*) AS age_count FROM employees
GROUP BY FLOOR(age/10)) AS age_summary;


-- ���₢���킹5: SELECT�̒��ɏ���
SELECT * FROM customers;

SELECT * FROM orders;


SELECT
cs.id,
cs.first_name,
cs.last_name,
(
    SELECT MAX(order_date) FROM orders AS order_max WHERE cs.id = order_max.customer_id
) AS "�ŋ߂̒�����",
(
    SELECT MIN(order_date) FROM orders AS order_max WHERE cs.id = order_max.customer_id
) AS "�Â��̒�����",
(
SELECT SUM(order_amount * order_price) FROM orders AS tmp_order WHERE cs.id = tmp_order.customer_id
	) AS "�S�x�������z"
	FROM customers AS cs
WHERE
   cs.id < 10;

  SELECT MAX(order_date) FROM orders AS order_max WHERE 1 = order_max.customer_id
  
  
  SELECT * FROM orders;
  
 
SELECT order_amount * order_price FROM orders;


-- ���₢���킹6: CASE�Ǝg��
SELECT
    emp.*,
    CASE
       WHEN emp.department_id = (SELECT id FROM departments WHERE name="�o�c��敔")
    THEN "�o�c�w"
    ELSE "���̑�"
    END AS "����"
FROM
 employees AS emp;


SELECT
   emp.*,
   CASE
       WHEN emp.id IN(
            SELECT DISTINCT employee_id FROM salaries WHERE payment > (SELECT AVG(payment) FROM salaries)
        ) THEN "�Z"
        ELSE "�~"
    END AS "���������ς�荂����"
FROM
employees emp;