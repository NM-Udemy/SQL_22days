-- IN

SELECT * FROM users WHERE age IN(12, 24, 36);

SELECT * FROM users WHERE birth_place NOT IN("France", "Germany", "Italy");

-- SELECT + IN
SELECT * FROM customers WHERE id  IN (SELECT customer_id FROM receipts);
SELECT * FROM customers WHERE id  NOT IN (SELECT customer_id FROM receipts WHERE id<10);


-- ALL, ANY
SELECT * FROM users WHERE age > ANY(SELECT age FROM employees WHERE salary > 5000000);

SELECT * FROM users WHERE age = ANY(SELECT age FROM employees WHERE salary > 5000000);



-- AND, OR

SELECT * FROM employees;

SELECT * FROM employees WHERE department = " ‰c‹Æ•” " AND name LIKE "%“c%"

SELECT * FROM employees WHERE department = " ‰c‹Æ•” " AND name LIKE "%“c%" AND age < 35

SELECT * FROM employees WHERE department = " ‰c‹Æ•” " AND (name LIKE "%“c%"  OR name LIKE "%¼%")AND age < 35

SELECT * FROM employees WHERE department = " ‰c‹Æ•” " OR department  = " ŠJ”­•” ";

SELECT * FROM employees WHERE department IN (" ‰c‹Æ•” ", " ŠJ”­•” ");

-- NOT(’¼Œã‚Ì”Û’è)
SELECT * FROM employees WHERE NOT department = " ‰c‹Æ•” "

