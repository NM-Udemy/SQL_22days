USE day_19_21_db;

SHOW tables;

-- バインド変数
SET @customer_id=7;
SELECT * FROM customers WHERE id = @customer_id;

SELECT * FROM customers;