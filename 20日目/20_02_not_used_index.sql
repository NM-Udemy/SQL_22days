-- INDEXなし
SELECT * FROM customers WHERE UPPER(first_name) = "JOSEPH";


-- INDEX追加
CREATE INDEX idx_customers_first_name ON customers(first_name);
CREATE INDEX idx_customers_lower_first_name ON customers((UPPER(first_name)))

EXPLAIN ANALYZE SELECT * FROM customers WHERE UPPER(first_name) = "JOSEPH";
/*
-> Filter: (upper(customers.first_name) = 'JOSEPH')  (cost=52307.93 rows=496903) (actual time=0.188..1061.101 rows=4712 loops=1)
    -> Table scan on customers  (cost=52307.93 rows=496903) (actual time=0.179..844.861 rows=500000 loops=1)
-> Index lookup on customers using idx_customers_lower_first_name (upper(first_name)='JOSEPH')  (cost=4571.78 rows=4712) (actual time=9.172..406.523 rows=4712 loops=1)
**/

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name IN("joseph","Joseph", "JOSEPH");

DROP INDEX idx_customers_lower_first_name ON customers;


CREATE INDEX idx_customers_age ON customers(age);

EXPLAIN ANALYZE SELECT * FROM customers WHERE age=25;
/*
-> Index lookup on customers using idx_customers_age (age=25)  (cost=8569.26 rows=10286) (actual time=6.230..493.583 rows=10286 loops=1)
*/
EXPLAIN ANALYZE SELECT * FROM customers WHERE age+2=27;
/*
 * -> Filter: ((customers.age + 2) = 27)  (cost=51385.81 rows=497345) (actual time=0.532..1151.149 rows=10286 loops=1)
       -> Table scan on customers  (cost=51385.81 rows=497345) (actual time=0.459..1056.132 rows=500000 loops=1)
 * 
 */


-- 文字列と数値の比較
CREATE INDEX idx_customers_prefecture_code ON customers(prefecture_code);
EXPLAIN ANALYZE SELECT * FROM customers WHERE prefecture_code=21;
/*
 * -> Filter: (customers.prefecture_code = 21)  (cost=52330.86 rows=49735) (actual time=1.975..1106.451 rows=12192 loops=1)
    -> Table scan on customers  (cost=52330.86 rows=497345) (actual time=1.954..971.185 rows=500000 loops=1)
 * 
*/
DESCRIBE customers;
EXPLAIN ANALYZE SELECT * FROM customers WHERE prefecture_code="21";

/*
-> Index lookup on customers using idx_customers_prefecture_code (prefecture_code='21'), with index condition: (customers.prefecture_code = '21')  (cost=7120.77 rows=21942) (actual time=2.838..432.075 rows=12192 loops=1)
*/


-- 前方一致、中間一致、後方一致
CREATE INDEX idx_customers_first_name ON customers(first_name);
EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name LIKE 'Jo%';
/*
 * -> Index range scan on customers using idx_customers_first_name over ('Jo' <= first_name <= 'Jo??????????????????????????????????????????????????????????????????????????????????????????????????'), with index condition: (customers.first_name like 'Jo%')  (cost=26593.61 rows=52218) (actual time=85.612..890.497 rows=24521 loops=1)
 */

-- 後方一致はフルスキャン
EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name LIKE '%A';

/*
 * -> Filter: (customers.first_name like '%A')  (cost=52186.52 rows=55255) (actual time=1.578..1290.874 rows=92504 loops=1)
    -> Table scan on customers  (cost=52186.52 rows=497345) (actual time=1.572..1050.177 rows=500000 loops=1)
*/
-- 中間一致はフルスキャン

-- first_nameにJoを含む人の最初の50000
EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name LIKE '%Jo%' LIMIT 50000; -- 1156ms

-- customersから50000件取ってきたうち、first_nameにJoを含む人
EXPLAIN ANALYZE SELECT * FROM (SELECT * FROM customers LIMIT 50000) AS tmp WHERE first_name LIKE '%Jo%'; -- 260

SHOW INDEX FROM customers;

DROP INDEX idx_customers_first_name ON customers;
