USE day_10_14_db;


SHOW TABLES;

-- VIEW���쐬
CREATE VIEW stores_items_view AS
SELECT st.name AS store_name, it.name AS item_name  FROM stores AS st
INNER JOIN items AS it
ON it.store_id = st.id;


SELECT * FROM stores_items_view;

UPDATE items SET name="new Item �R�c 1" WHERE name="Item �R�c 1";

-- TABLE View�̈ꗗ
SHOW TABLES;

SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA="day_10_14_db";

-- VIEW�̏ڍ�
SHOW CREATE VIEW stores_items_view;

/*
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost
` SQL SECURITY DEFINER VIEW `stores_items_view` AS 
select `st`.`name` AS `store_name`,`it`.`name` AS `item_name`
from (`stores` `st` join `items` `it` on((`it`.`store_id` = `st`.`id`)))
*/

-- �i��
SELECT * FROM stores_items_view WHERE store_name="�R�c���X";

SELECT * FROM stores_items_view ORDER BY store_name;

SELECT store_name, COUNT(*) FROM stores_items_view GROUP BY store_name ORDER BY store_name;

-- View�̍폜
DROP VIEW stores_items_view;


-- View�̒�`�ύX
ALTER VIEW stores_items_view AS
SELECT st.id AS store_id, it.id AS item_id, st.name AS store_name, it.name AS item_name  FROM stores AS st
INNER JOIN items AS it
ON it.store_id = st.id;

SELECT * FROM stores_items_view;

-- VIEW�̖��O�ύX
RENAME TABLE stores_items_view TO new_stores_items_view;

SHOW TABLES;
CREATE VIEW AS
SELECT 
*
FROM new_stores_items_view 
INNER