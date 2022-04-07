SHOW DATABASES;

USE day_10_14_db;

SELECT * FROM employees;

-- UPDATE 更新したいテーブル SET 更新したい列 = 更新する値
UPDATE employees SET age = age+1 WHERE id=1;

SELECT * FROM employees;


SELECT
    *
FROM
    employees AS emp
WHERE
emp.department_id = (SELECT id FROM departments WHERE name = "営業部");

-- 営業部の人の年齢を+2する
UPDATE
    employees AS emp
SET emp.age = emp.age+2
WHERE
emp.department_id = (SELECT id FROM departments WHERE name = "営業部");


SELECT * FROM employees e ;



-- INNER JOIN
SELECT * FROM employees;


ALTER TABLE employees
ADD department_name VARCHAR(255);


-- LEFT JOIN 
SELECT emp.*, COALESCE(dt.name, "不明") FROM
employees AS emp
LEFT JOIN departments AS dt 
ON emp.department_id  = dt.id;



UPDATE
employees AS emp
LEFT JOIN departments AS dt 
ON emp.department_id  = dt.id
SET emp.department_name = COALESCE(dt.name, "不明")
;

SELECT * FROM employees;


-- WITHを使ったUPDATE

SELECT * FROM stores;

ALTER TABLE stores 
ADD all_sales INT;

SELECT * FROM stores;

SELECT * FROM items;

SELECT * FROM orders;

WITH tmp_sales AS(
    SELECT it.store_id, SUM(od.order_amount * od.order_price) AS summary
    FROM items AS it
    INNER JOIN orders AS od 
    ON it.id = od.item_id
    GROUP BY it.store_id
)
UPDATE stores AS st
INNER JOIN tmp_sales AS ts
ON st.id = ts.store_id
SET st.all_sales = ts.summary;

SELECT * FROM stores;


-- DELETE

DELETE FROM employees
WHERE department_id IN (
    SELECT id FROM departments WHERE name ="開発部"
);

SELECT * FROM employees;


SELECT * FROM customers;

SELECT * FROM orders;

CREATE TABLE customer_orders(
    name VARCHAR(255),
    order_date DATE,
    sales INT,
    total_sales INT
);

INSERT INTO customer_orders
SELECT
    CONCAT(ct.last_name, ct.first_name),
    od.order_date,
    od.order_amount * od.order_price,
    SUM(od.order_amount * od.order_price) OVER(PARTITION BY CONCAT(ct.last_name, ct.first_name) ORDER BY od.order_date )
FROM customers AS ct
INNER JOIN orders AS od
ON ct.id = od.customer_id ;


SELECT * FROM customer_orders;


SELECT COUNT(*) FROM customers;

