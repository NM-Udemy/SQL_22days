USE day_19_21_db;

SELECT COUNT(*) FROM prefectures;

SELECT COUNT(*) FROM customers;

CREATE INDEX idx_customers_prefecture_code ON customers(prefecture_code);

-- prefectures < customers
-- EXISTS
EXPLAIN ANALYZE
SELECT * FROM prefectures AS pr
WHERE EXISTS (SELECT 1 FROM customers AS ct WHERE pr.prefecture_code = ct.prefecture_code);

/*
-> Nested loop semijoin  (cost=60866.63 rows=599364) (actual time=2.052..10.833 rows=41 loops=1)
    -> Table scan on pr  (cost=5.70 rows=47) (actual time=1.936..2.000 rows=47 loops=1)
    -> Covering index lookup on ct using idx_customers_prefecture_code (prefecture_code=pr.prefecture_code)  (cost=596846.96 rows=12752) (actual time=0.187..0.187 rows=1 loops=47)
*/

-- IN
EXPLAIN ANALYZE
SELECT * FROM prefectures AS pr
WHERE prefecture_code IN (SELECT prefecture_code  FROM customers);

/*
-> Nested loop semijoin  (cost=60865.88 rows=599364) (actual time=0.106..1.796 rows=41 loops=1)
    -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.042..0.070 rows=47 loops=1)
    -> Covering index lookup on customers using idx_customers_prefecture_code (prefecture_code=pr.prefecture_code)  (cost=596846.96 rows=12752) (actual time=0.036..0.036 rows=1 loops=47)
*/