
-- WITH

WITH tmp_departments AS(
    SELECT * FROM departments WHERE name="営業部"
)
SELECT * FROM employees AS e
INNER JOIN tmp_departments 
ON e.department_id = tmp_departments.id;


-- storesテーブルからid 1, 2, 3のものを取り出す。(WHERE )
-- itemsテーブルと紐づけ、itemsテーブルとordersテーブルを紐づける。(INNER JOIN)
-- ordersテーブルのorder_amount*order_priceの合計値をstoresテーブルのstore_name毎に集計する(GROUP BY SUM)
WITH tmp_stores AS(
    SELECT * FROM stores WHERE id IN(1,2,3)
), tmp_items_orders AS(
    SELECT
        items.id AS item_id,
        tmp_stores.id AS store_id,
        orders.id AS order_id,
        orders.order_amount  AS order_amount,
        orders.order_price AS order_price,
        tmp_stores.name AS store_name
    FROM tmp_stores 
    INNER JOIN items
    ON tmp_stores.id = items.store_id 
    INNER JOIN orders
    ON items.id = orders.item_id
)
SELECT store_name, SUM(order_amount * order_price) FROM tmp_items_orders
GROUP BY store_name;