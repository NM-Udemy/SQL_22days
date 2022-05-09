SHOW DATABASES;

USE day_10_14_db;

SHOW TABLES;

SELECT * FROM employees;

SELECT * FROM departments;


-- 　通常のJOIN
SELECT * FROM employees AS emp
INNER JOIN departments AS dt 
ON emp.department_id = dt.id;


-- 　特定のカラムを取り出す
SELECT emp.id, emp.first_name, emp.last_name, dt.id AS department_id, dt.name AS department_name
FROM employees AS emp
INNER JOIN departments AS dt 
ON emp.department_id = dt.id;


-- 複数のレコードで紐づける
SELECT * FROM students AS std
INNER JOIN 
 users AS usr
ON std.first_name = usr.first_name AND std.last_name = usr.last_name;

-- = 以外で紐づける
SELECT * FROM employees AS emp
INNER JOIN
    students AS std
 ON emp.id < std.id;
 
-- LEFT JOIN
SELECT emp.id, emp.first_name, emp.last_name, COALESCE(dt.id, "該当なし") AS department_id, dt.name AS department_name
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


-- FULL JOIN(両方から取り出して、取得できないものはNULL)
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


-- customers, orders, items, stores を紐づける(INNER JOIN)
-- customers.idで並び替える(ORDER BY)
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

-- customers, orders, items, stores を紐づける(INNER JOIN)
-- customers.idで並び替える(ORDER BY)
-- customers .idが10で、orders.order_dateが 2020-08-01よりあとに絞り込む(WHERE)
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


-- サブクエリ

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


-- GROUP BY の紐づけ
SELECT * FROM customers AS ct
INNER JOIN
     (SELECT customer_id, SUM(order_amount * order_price) AS summary_price
        FROM orders
    GROUP BY customer_id) AS order_summary
ON ct.id = order_summary.customer_id
ORDER BY ct.age
LIMIT 5;


-- SELF JOIN(自己結合)

SELECT
    CONCAT(emp1.last_name, emp1.first_name) AS "部下の名前", 
    emp1.age AS "部下の年齢",
    COALESCE(CONCAT(emp2.last_name, emp2.first_name), "該当なし") AS "上司の名前",
    emp2.age AS "上司の年齢"
FROM employees AS emp1
LEFT JOIN employees AS emp2
ON emp1.manager_id  = emp2.id;



-- CROSS JOIN 
SELECT * FROM employees AS emp1, employees AS emp2
WHERE emp1.id = 1;


SELECT * FROM employees AS emp1
CROSS JOIN employees AS emp2
ON emp1.id < emp2.id;


-- 計算結果とCASEで紐づけ
SELECT
*,
CASE
    WHEN cs.age > summary_customers.avg_age THEN "〇"
    ELSE "×"
END AS "平均年齢よりも年齢が高いか"
FROM customers AS cs
CROSS JOIN(
SELECT AVG(age) AS avg_age FROM customers
) AS summary_customers;


SELECT
emp.id,
AVG(payment),
summary.avg_payment,
CASE
    WHEN AVG(payment) >= summary.avg_payment THEN "〇"
    ELSE "×"
END AS "平均月収以上か"
FROM employees AS emp
INNER JOIN salaries AS sa
ON emp.id = sa.employee_id 
CROSS JOIN
(SELECT AVG(payment) AS avg_payment FROM salaries) AS summary
GROUP BY emp.id, summary.avg_payment;
