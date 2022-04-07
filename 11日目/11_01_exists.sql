USE day_10_14_db;

SELECT * FROM departments;

SELECT * FROM employees;

-- EXISTS
SELECT * FROM employees AS em
WHERE EXISTS(
    SELECT 1 FROM departments AS dt WHERE em.department_id  = dt. id
);


-- IN
SELECT * FROM employees AS em
WHERE em.department_id IN (SELECT id FROM departments);


SELECT * FROM employees AS em
WHERE EXISTS (
   SELECT 1 FROM departments AS dt WHERE dt.name IN ("‰c‹Æ•”", "ŠJ”­•”") AND em.department_id = dt.id
);


SELECT * FROM customers AS ct
WHERE NOT EXISTS (SELECT * FROM orders AS od WHERE ct.id = od.customer_id AND od.order_date = "2020-12-31");


SELECT * FROM employees AS em1
WHERE EXISTS(SELECT 1 FROM employees em2 WHERE em2.manager_id = em1.id);
;


