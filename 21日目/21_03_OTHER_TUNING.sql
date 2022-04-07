USE day_19_21_db;

CREATE TABLE tmp(
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- マルチインサート
INSERT INTO tmp VALUES
(1, "A"),
(2, "B"),
(3, "C");

SELECT * FROM tmp;

CREATE TABLE customer_summary AS
SELECT ct.id, SUM(sh.sales_amount) FROM customers AS ct
INNER JOIN sales_history AS sh
ON ct.id = sh.customer_id
GROUP BY ct.id;