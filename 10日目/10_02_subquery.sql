SHOW TABLES;

SELECT * FROM employees;


-- 部署一覧
SELECT * FROM departments ;

-- IN で絞り込む
SELECT * FROM employees WHERE department_id IN(1, 2);

-- 副問い合わせを使う
SELECT id FROM departments WHERE name IN ("経営企画部", "営業部");

SELECT * FROM employees WHERE department_id  NOT IN
    (SELECT id FROM departments WHERE name IN ("経営企画部", "営業部")
)


SELECT * FROM students;
SELECT * FROM users;


-- 複数カラムのIN(副問い合わせ)
SELECT * FROM students
WHERE (first_name, last_name) NOT IN (
     SELECT first_name, last_name FROM users
);


-- 副問い合わせ3: 集計と使う
SELECT MAX(age) FROM employees;

SELECT * FROM employees WHERE age < (SELECT AVG(age) FROM employees);



-- 副問い合わせ4: FROMで用いる
SELECT
MAX(avg_age) AS "部署ごとの平均年齢の最大",
MIN(avg_age)
FROM
(SELECT department_id, AVG(age) AS avg_age FROM employees GROUP BY department_id ) AS tmp_emp;


-- 年代の集計
SELECT
    MAX(age_count), MIN(age_count)
FROM
(SELECT FLOOR(age/10) * 10 , COUNT(*) AS age_count FROM employees
GROUP BY FLOOR(age/10)) AS age_summary;


-- 副問い合わせ5: SELECTの中に書く
SELECT * FROM customers;

SELECT * FROM orders;


SELECT
cs.id,
cs.first_name,
cs.last_name,
(
    SELECT MAX(order_date) FROM orders AS order_max WHERE cs.id = order_max.customer_id
) AS "最近の注文日",
(
    SELECT MIN(order_date) FROM orders AS order_max WHERE cs.id = order_max.customer_id
) AS "古いの注文日",
(
SELECT SUM(order_amount * order_price) FROM orders AS tmp_order WHERE cs.id = tmp_order.customer_id
	) AS "全支払い金額"
	FROM customers AS cs
WHERE
   cs.id < 10;

  SELECT MAX(order_date) FROM orders AS order_max WHERE 1 = order_max.customer_id
  
  
  SELECT * FROM orders;
  
 
SELECT order_amount * order_price FROM orders;


-- 副問い合わせ6: CASEと使う
SELECT
    emp.*,
    CASE
       WHEN emp.department_id = (SELECT id FROM departments WHERE name="経営企画部")
    THEN "経営層"
    ELSE "その他"
    END AS "役割"
FROM
 employees AS emp;


SELECT
   emp.*,
   CASE
       WHEN emp.id IN(
            SELECT DISTINCT employee_id FROM salaries WHERE payment > (SELECT AVG(payment) FROM salaries)
        ) THEN "〇"
        ELSE "×"
    END AS "給料が平均より高いか"
FROM
employees emp;