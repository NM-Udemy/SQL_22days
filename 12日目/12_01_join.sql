SHOW DATABASES;

USE day_10_14_db;

SHOW TABLES;

SELECT * FROM employees;

SELECT * FROM departments;


-- �@�ʏ��JOIN
SELECT * FROM employees AS emp
INNER JOIN departments AS dt 
ON emp.department_id = dt.id;


-- �@����̃J���������o��
SELECT emp.id, emp.first_name, emp.last_name, dt.id AS department_id, dt.name AS department_name
FROM employees AS emp
INNER JOIN departments AS dt 
ON emp.department_id = dt.id;


-- �����̃��R�[�h�ŕR�Â���
SELECT * FROM students AS std
INNER JOIN 
 users AS usr
ON std.first_name = usr.first_name AND std.last_name = usr.last_name;

-- = �ȊO�ŕR�Â���
SELECT * FROM employees AS emp
INNER JOIN
    students AS std
 ON emp.id < std.id;
 
-- LEFT JOIN
SELECT emp.id, emp.first_name, emp.last_name, COALESCE(dt.id, "�Y���Ȃ�") AS department_id, dt.name AS department_name
FROM employees AS emp
LEFT JOIN departments AS dt 
ON emp.department_id = dt.id;


SELECT * FROM students AS std
LEFT JOIN enrollments AS enr
ON std.id = enr.student_id
LEFT JOIN 
classes AS cs 
ON enr.class_id = cs.id;


-- RIGHT JOIN

SELECT * FROM students AS std
RIGHT JOIN enrollments AS enr
ON std.id = enr.student_id
RIGHT JOIN 
classes AS cs 
ON enr.class_id = cs.id;


-- FULL JOIN(����������o���āA�擾�ł��Ȃ����̂�NULL)
SELECT * FROM students AS std
LEFT JOIN enrollments AS enr
ON std.id = enr.student_id
LEFT JOIN 
classes AS cs 
ON enr.class_id = cs.id
UNION
SELECT * FROM students AS std
RIGHT JOIN enrollments AS enr
ON std.id = enr.student_id
RIGHT JOIN 
classes AS cs 
ON enr.class_id = cs.id;


-- customers, orders, items, stores ��R�Â���(INNER JOIN)
-- customers.id�ŕ��ёւ���(ORDER BY)
SELECT
   ct.id, ct.last_name, od.item_id, od.order_amount, od.order_price, od.order_date, it.name, st.name
FROM
   customers AS ct
INNER JOIN orders AS od 
ON  od.customer_id = ct.id
INNER JOIN items AS it
ON od.item_id = it.id
INNER JOIN stores AS st
ON it.store_id = st.id
ORDER BY ct.id;

-- customers, orders, items, stores ��R�Â���(INNER JOIN)
-- customers.id�ŕ��ёւ���(ORDER BY)
-- customers .id��10�ŁAorders.order_date�� 2020-08-01��肠�Ƃɍi�荞��(WHERE)
SELECT
   ct.id, ct.last_name, od.item_id, od.order_amount, od.order_price, od.order_date, it.name, st.name
FROM
   customers AS ct
INNER JOIN orders AS od 
ON  od.customer_id = ct.id
INNER JOIN items AS it
ON od.item_id = it.id
INNER JOIN stores AS st
ON it.store_id = st.id
WHERE ct.id = 10 AND od.order_date > "2020-08-01"
ORDER BY ct.id;


-- �T�u�N�G��

SELECT
   ct.id, ct.last_name, od.item_id, od.order_amount, od.order_price, od.order_date, it.name, st.name
FROM
   (SELECT * FROM customers WHERE id=10) AS ct
INNER JOIN (SELECT * FROM orders WHERE order_date > "2020-08-01") AS od 
ON  od.customer_id = ct.id
INNER JOIN items AS it
ON od.item_id = it.id
INNER JOIN stores AS st
ON it.store_id = st.id
ORDER BY ct.id;


-- GROUP BY �̕R�Â�
SELECT * FROM customers AS ct
INNER JOIN
     (SELECT customer_id, SUM(order_amount * order_price) AS summary_price
        FROM orders
    GROUP BY customer_id) AS order_summary
ON ct.id = order_summary.customer_id
ORDER BY ct.age
LIMIT 5;


-- SELF JOIN(���Ȍ���)

SELECT
    CONCAT(emp1.last_name, emp1.first_name) AS "�����̖��O", 
    emp1.age AS "�����̔N��",
    COALESCE(CONCAT(emp2.last_name, emp2.first_name), "�Y���Ȃ�") AS "��i�̖��O",
    emp2.age AS "��i�̔N��"
FROM employees AS emp1
LEFT JOIN employees AS emp2
ON emp1.manager_id  = emp2.id;



-- CROSS JOIN 
SELECT * FROM employees AS emp1, employees AS emp2
WHERE emp1.id = 1;


SELECT * FROM employees AS emp1
CROSS JOIN employees AS emp2
ON emp1.id < emp2.id;


-- �v�Z���ʂ�CASE�ŕR�Â�
SELECT
*,
CASE
    WHEN cs.age > summary_customers.avg_age THEN "�Z"
    ELSE "�~"
END AS "���ϔN������N�������"
FROM customers AS cs
CROSS JOIN(
SELECT AVG(age) AS avg_age FROM customers
) AS summary_customers;


SELECT
emp.id,
AVG(payment),
summary.avg_payment,
CASE
    WHEN AVG(payment) >= summary.avg_payment THEN "�Z"
    ELSE "�~"
END AS "���ό����ȏォ"
FROM employees AS emp
INNER JOIN salaries AS sa
ON emp.id = sa.employee_id 
CROSS JOIN
(SELECT AVG(payment) AS avg_payment FROM salaries) AS summary
GROUP BY emp.id;
