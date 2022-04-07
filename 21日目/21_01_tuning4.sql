USE day_19_21_db;

SHOW INDEX FROM customers;

DROP INDEX idx_customers_age ON customers;

SELECT
*
FROM customers
WHERE
prefecture_code IN (SELECT prefecture_code FROM prefectures WHERE name="“Œ‹ž“s")
OR
prefecture_code IN (SELECT prefecture_code FROM prefectures WHERE name="‘åã•{")
;

-- –³‘Ê‚Èˆ—‚ð1‚Â‚É
SELECT
*
FROM customers
WHERE
prefecture_code IN (SELECT prefecture_code FROM prefectures WHERE name IN("“Œ‹ž“s", "‘åã•{"))
;



-- SELECT‚È‚¢•›–â‚¢‡‚í‚¹‚ð‚â‚ß‚é
EXPLAIN ANALYZE 
SELECT
*, (SELECT name FROM prefectures AS pr WHERE pr.prefecture_code = ct.prefecture_code)
FROM customers AS ct
;

/*
-> Table scan on ct  (cost=52313.39 rows=497345) (actual time=0.127..1102.208 rows=500000 loops=1)
-> Select #2 (subquery in projection; dependent)
    -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.35 rows=1) (actual time=0.004..0.004 rows=1 loops=500000)
*/

EXPLAIN ANALYZE 
SELECT
*, pr.name
FROM customers AS ct
LEFT JOIN
prefectures AS pr
ON pr.prefecture_code =ct.prefecture_code 
;

/*
-> Nested loop left join  (cost=225562.15 rows=497345) (actual time=0.189..2640.847 rows=500000 loops=1)
    -> Table scan on ct  (cost=51491.40 rows=497345) (actual time=0.157..1020.031 rows=500000 loops=1)
    -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.25 rows=1) (actual time=0.003..0.003 rows=1 loops=500000)

*/


SHOW TABLES;
-- 2016”N“xA2016”N“x‚Ì“ú‚²‚Æ‚ÌWŒvƒJƒ‰ƒ€‚ð’Ç‰Á
EXPLAIN ANALYZE
SELECT
    sales_history.*, sales_summary.sales_daily_amount
FROM
    sales_history
LEFT JOIN 
(SELECT sales_day,SUM(sales_amount) AS sales_daily_amount
FROM sales_history
WHERE sales_day BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY sales_day) AS sales_summary
ON sales_history.sales_day = sales_summary.sales_day
WHERE sales_history.sales_day BETWEEN '2016-01-01' AND '2016-12-31';

/*
-> Nested loop left join  (cost=854816.65 rows=0) (actual time=6377.812..13408.724 rows=312844 loops=1)
    -> Filter: (sales_history.sales_day between '2016-01-01' and '2016-12-31')  (cost=229325.85 rows=250188) (actual time=0.094..6014.967 rows=312844 loops=1)
        -> Table scan on sales_history  (cost=229325.85 rows=2251920) (actual time=0.087..2440.101 rows=2500000 loops=1)
    -> Index lookup on sales_summary using <auto_key0> (sales_day=sales_history.sales_day)  (actual time=0.002..0.002 rows=1 loops=312844)
        -> Materialize  (cost=0.00..0.00 rows=0) (actual time=7003.030..7177.556 rows=336 loops=1)
            -> Table scan on <temporary>  (actual time=0.002..0.073 rows=336 loops=1)
                -> Aggregate using temporary table  (actual time=6376.969..6377.128 rows=336 loops=1)
                    -> Filter: (sales_history.sales_day between '2016-01-01' and '2016-12-31')  (cost=229325.85 rows=250188) (actual time=0.050..5872.480 rows=312844 loops=1)
                        -> Table scan on sales_history  (cost=229325.85 rows=2251920) (actual time=0.047..2195.150 rows=2500000 loops=1)

*/


EXPLAIN ANALYZE
SELECT
    sh.*, SUM(sh.sales_amount) OVER(PARTITION BY sh.sales_day)
FROM
    sales_history AS sh
WHERE sh.sales_day BETWEEN '2016-01-01' AND '2016-12-31';

/*
-> Window aggregate with buffering: sum(sales_history.sales_amount) OVER (PARTITION BY sh.sales_day )   (actual time=6772.840..7672.922 rows=312844 loops=1)
    -> Sort: sh.sales_day  (cost=229362.90 rows=2251920) (actual time=6769.355..6866.821 rows=312844 loops=1)
        -> Filter: (sh.sales_day between '2016-01-01' and '2016-12-31')  (cost=229362.90 rows=2251920) (actual time=0.087..6401.354 rows=312844 loops=1)
            -> Table scan on sh  (cost=229362.90 rows=2251920) (actual time=0.081..2548.178 rows=2500000 loops=1)
*/