-- EXISTS(NULLÇÃë∂ç›Ç∑ÇÈèÍçá)
SELECT * FROM customers AS c1
WHERE EXISTS
(SELECT * FROM customers_2 AS c2
WHERE c1.first_name = c2.first_name AND c1.last_name = c2.last_name AND
(c1.phone_number = c2.phone_number OR (c1.phone_number IS NULL AND c2.phone_number IS NULL )  ));

-- NOT EXISTS
SELECT * FROM customers AS c1
WHERE NOT EXISTS
(SELECT * FROM customers_2 AS c2
WHERE c1.first_name = c2.first_name AND c1.last_name = c2.last_name AND c1.phone_number = c2.phone_number);


-- NOT IN ÇÃèÍçá
-- first_name != customers_2.first_name OR last_name != customers_2.last_name OR phone_number != customers_2 .phone_number

-- NOT EXISTS ÇÃèÍçá
-- EXISTSÇ≈ïRÇ√Ç©Ç»Ç©Ç¡ÇΩÉåÉRÅ[Éh

SELECT * FROM customers AS c1
WHERE (first_name, last_name, phone_number) NOT IN
(SELECT first_name, last_name, phone_number FROM customers_2);

-- EXISTSÇINÇ≈èëÇ≠
SELECT * FROM customers AS c1
WHERE (first_name, last_name, phone_number) IN
(SELECT first_name, last_name, phone_number FROM customers_2);

