USE day_19_21_db;

SELECT * FROM customers;

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name="Olivia";
/*
-> Filter: (customers.first_name = 'Olivia')  (cost=51300.58 rows=49690) (actual time=0.161..1253.571 rows=503 loops=1)
    -> Table scan on customers  (cost=51300.58 rows=496903) (actual time=0.155..1096.783 rows=500000 loops=1)
*/

-- first_nameにINDEX追加
CREATE INDEX idx_customers_first_name ON customers(first_name);

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name="Olivia";
/*
 * -> Index lookup on customers using idx_customers_first_name (first_name='Olivia')  (cost=498.03 rows=503) (actual time=19.997..74.879 rows=503 loops=1)
 */

CREATE INDEX idx_customers_age ON customers(age);


EXPLAIN ANALYZE SELECT * FROM customers WHERE age=41;

/*
-> Index lookup on customers using idx_customers_age (age=41)  (cost=8516.47 rows=10100) (actual time=5.474..369.693 rows=10100 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name="Olivia" AND age=42;
/*
-> Filter: ((customers.age = 42) and (customers.first_name = 'Olivia'))  (cost=38.30 rows=10) (actual time=0.836..14.553 rows=10 loops=1)
    -> Intersect rows sorted by row ID  (cost=38.30 rows=10) (actual time=0.827..14.501 rows=10 loops=1)
        -> Index range scan on customers using idx_customers_first_name over (first_name = 'Olivia')  (cost=24.90 rows=503) (actual time=0.075..0.858 rows=503 loops=1)
        -> Index range scan on customers using idx_customers_age over (age = 42)  (cost=7.15 rows=10086) (actual time=0.035..10.811 rows=10082 loops=1)

*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name="Olivia" OR age=42;
/*
-> Filter: ((customers.first_name = 'Olivia') or (customers.age = 42))  (cost=7683.30 rows=10579) (actual time=0.503..737.136 rows=10579 loops=1)
    -> Deduplicate rows sorted by row ID  (cost=7683.30 rows=10579) (actual time=0.497..702.925 rows=10579 loops=1)
        -> Index range scan on customers using idx_customers_first_name over (first_name = 'Olivia')  (cost=75.21 rows=503) (actual time=0.131..2.208 rows=503 loops=1)
        -> Index range scan on customers using idx_customers_age over (age = 42)  (cost=1015.76 rows=10086) (actual time=0.059..31.986 rows=10086 loops=1)
*/

-- 複合インデックス
DROP INDEX idx_customers_first_name ON customers;
DROP INDEX idx_customers_age ON customers;

CREATE INDEX idx_customers_first_name_age ON customers(first_name,age);

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name="Olivia" AND age=42;
/*
-> Index lookup on customers using idx_customers_first_name_age (first_name='Olivia', age=42)  (cost=10.11 rows=10) (actual time=2.219..2.226 rows=10 loops=1)
*/

-- ageだけはFULL SCAN
EXPLAIN ANALYZE SELECT * FROM customers WHERE age=51;
/*
-> Filter: (customers.age = 51)  (cost=52193.98 rows=49690) (actual time=0.143..1047.994 rows=10175 loops=1)
    -> Table scan on customers  (cost=52193.98 rows=496903) (actual time=0.123..971.645 rows=500000 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name="Olivia" OR age=42;
/*
-> Filter: ((customers.first_name = 'Olivia') or (customers.age = 42))  (cost=51397.82 rows=50358) (actual time=0.161..1264.359 rows=10579 loops=1)
    -> Table scan on customers  (cost=51397.82 rows=496903) (actual time=0.155..1057.380 rows=500000 loops=1)
*/

-- ORDER BY, GROUP BY: 処理時間がかかる、実行の前にWHEREで絞り込む
DROP INDEX idx_customers_first_name_age ON customers;

EXPLAIN ANALYZE SELECT * FROM customers ORDER BY first_name;
/*
 * -> Sort: customers.first_name  (cost=51993.42 rows=496903) (actual time=2474.777..2758.999 rows=500000 loops=1)
        -> Table scan on customers  (cost=51993.42 rows=496903) (actual time=2.315..1120.126 rows=500000 loops=1)
 * 
 */
CREATE INDEX idx_customers_first_name ON customers(first_name);

-- INDEX あり
EXPLAIN ANALYZE SELECT /*+ INDEX(customers) */* FROM customers ORDER BY first_name;
/*
 * -> Sort: customers.first_name  (cost=52332.24 rows=496903) (actual time=2320.457..2631.628 rows=500000 loops=1)
        -> Table scan on customers  (cost=52332.24 rows=496903) (actual time=2.272..1023.399 rows=500000 loops=1)
 * 
-> Index scan on customers using idx_customers_first_name  (cost=367475.78 rows=496903) (actual time=13.906..43703.141 rows=500000 loops=1)
*/


EXPLAIN ANALYZE SELECT * FROM customers ORDER BY id;
/*
-> Index scan on customers using PRIMARY  (cost=51369.72 rows=496903) (actual time=1.661..1055.161 rows=500000 loops=1)
*/

-- GROUP BY
EXPLAIN ANALYZE SELECT first_name,COUNT(*) FROM customers GROUP BY first_name ;
/*
-> Group aggregate: count(0)  (cost=101068.37 rows=496903) (actual time=1.249..571.792 rows=690 loops=1)
    -> Covering index scan on customers using idx_customers_first_name  (cost=51378.07 rows=496903) (actual time=0.081..404.140 rows=500000 loops=1)
*/

CREATE INDEX idx_customers_age ON customers(age);
EXPLAIN ANALYZE SELECT age,COUNT(*) FROM customers GROUP BY age;

/*
 * -> Group aggregate: count(0)  (cost=102100.79 rows=496903) (actual time=10.523..417.621 rows=49 loops=1)
    -> Covering index scan on customers using idx_customers_age  (cost=52410.49 rows=496903) (actual time=2.020..347.422 rows=500000 loops=1)
 * 
*/
DROP INDEX idx_customers_first_name ON customers;

DROP INDEX idx_customers_age ON customers;


-- 複数のGROUP BY 
CREATE INDEX idx_customers_first_name_age ON customers(first_name, age);
EXPLAIN ANALYZE SELECT first_name, age,COUNT(*) FROM customers GROUP BY first_name, age;

/*
-> Group aggregate: count(0)  (cost=102258.80 rows=496903) (actual time=0.131..650.829 rows=32369 loops=1)
    -> Covering index scan on customers using idx_customers_first_name_age  (cost=52568.50 rows=496903) (actual time=0.089..439.995 rows=500000 loops=1)
*/
DROP INDEX idx_customers_first_name_age ON customers;


-- 外部キーにインデックス
EXPLAIN ANALYZE SELECT * FROM prefectures AS pr
INNER JOIN customers AS ct
ON pr.prefecture_code  = ct.prefecture_code AND pr.name="北海道";

/*
-> Nested loop inner join  (cost=225863.13 rows=49690) (actual time=0.206..3618.377 rows=12321 loops=1)
    -> Filter: (ct.prefecture_code is not null)  (cost=51947.08 rows=496903) (actual time=0.127..1458.420 rows=500000 loops=1)
        -> Table scan on ct  (cost=51947.08 rows=496903) (actual time=0.126..1315.786 rows=500000 loops=1)
    -> Filter: (pr.`name` = '北海道')  (cost=0.25 rows=0) (actual time=0.004..0.004 rows=0 loops=500000)
        -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.25 rows=1) (actual time=0.003..0.003 rows=1 loops=500000)
*/

CREATE INDEX idx_customers_prefecture_code ON customers(prefecture_code);

/*
-> Nested loop inner join  (cost=41392.26 rows=59883) (actual time=8.388..335.034 rows=12321 loops=1)
    -> Filter: (pr.`name` = '北海道')  (cost=5.70 rows=5) (actual time=1.821..2.069 rows=1 loops=1)
        -> Table scan on pr  (cost=5.70 rows=47) (actual time=1.815..2.052 rows=47 loops=1)
    -> Index lookup on ct using idx_customers_prefecture_code (prefecture_code=pr.prefecture_code)  (cost=7802.63 rows=12741) (actual time=6.564..330.477 rows=12321 loops=1)
*/
DROP INDEX idx_customers_prefecture_code ON customers;

