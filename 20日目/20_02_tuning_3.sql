-- 無駄なGROUP BY

EXPLAIN ANALYZE SELECT
age, COUNT(*)
FROM customers
GROUP BY age
HAVING age<30;
/*
-> Filter: (customers.age < 30)  (actual time=888.197..888.216 rows=8 loops=1)
    -> Table scan on <temporary>  (actual time=0.002..0.008 rows=49 loops=1)
        -> Aggregate using temporary table  (actual time=888.191..888.205 rows=49 loops=1)
            -> Table scan on customers  (cost=51440.50 rows=497345) (actual time=0.051..609.094 rows=500000 loops=1)
*/
CREATE INDEX idx_customers_age ON customers(age);
EXPLAIN ANALYZE SELECT
age, COUNT(*)
FROM customers
WHERE age<30
GROUP BY age;
/*
-> Table scan on <temporary>  (actual time=0.002..0.004 rows=8 loops=1)
    -> Aggregate using temporary table  (actual time=761.143..761.147 rows=8 loops=1)
        -> Filter: (customers.age < 30)  (cost=51440.50 rows=165765) (actual time=0.121..703.226 rows=82096 loops=1)
            -> Table scan on customers  (cost=51440.50 rows=497345) (actual time=0.112..620.701 rows=500000 loops=1)

-> Group aggregate: count(0)  (cost=48687.22 rows=161958) (actual time=18.575..140.436 rows=8 loops=1)
    -> Filter: (customers.age < 30)  (cost=32491.42 rows=161958) (actual time=0.057..123.777 rows=82096 loops=1)
        -> Covering index range scan on customers using idx_customers_age over (NULL < age < 30)  (cost=32491.42 rows=161958) (actual time=0.055..96.549 rows=82096 loops=1)

*/

-- MAX, MINはインデックスを利用する

EXPLAIN ANALYZE SELECT MAX(age), MIN(age), AVG(age), SUM(age) FROM customers;
/*
-> Aggregate: avg(customers.age)  (cost=101967.36 rows=497345) (actual time=594.309..594.310 rows=1 loops=1)
    -> Covering index scan on customers using idx_customers_age  (cost=52232.86 rows=497345) (actual time=0.044..442.095 rows=500000 loops=1)
*/

-- DISTINCTの代わりにEXISTS
EXPLAIN ANALYZE SELECT DISTINCT pr.name FROM prefectures AS pr
INNER JOIN customers AS ct 
ON pr.prefecture_code  = ct.prefecture_code ;
/*
-> Table scan on <temporary>  (cost=0.01..6219.31 rows=497345) (actual time=0.002..0.006 rows=41 loops=1)
    -> Temporary table with deduplication  (cost=275466.08..281685.38 rows=497345) (actual time=3176.003..3176.014 rows=41 loops=1)
        -> Nested loop inner join  (cost=225731.56 rows=497345) (actual time=0.112..2623.291 rows=500000 loops=1)
            -> Filter: (ct.prefecture_code is not null)  (cost=51660.81 rows=497345) (actual time=0.092..954.664 rows=500000 loops=1)
                -> Table scan on ct  (cost=51660.81 rows=497345) (actual time=0.091..837.076 rows=500000 loops=1)
            -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.25 rows=1) (actual time=0.003..0.003 rows=1 loops=500000)
*/

SELECT DISTINCT pr.name FROM prefectures AS pr
INNER JOIN customers AS ct 
ON pr.prefecture_code  = ct.prefecture_code ;


-- EXISTS
EXPLAIN ANALYZE SELECT name FROM prefectures AS pr
WHERE EXISTS(
    SELECT 1 FROM customers AS ct WHERE ct.prefecture_code = pr.prefecture_code 
);
/*
-> Nested loop inner join  (cost=2337531.15 rows=23375215) (actual time=1181.983..1182.111 rows=41 loops=1)
    -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.031..0.060 rows=47 loops=1)
    -> Single-row index lookup on <subquery2> using <auto_distinct_key> (prefecture_code=pr.prefecture_code)  (actual time=0.001..0.001 rows=1 loops=47)
        -> Materialize with deduplication  (cost=101395.31..101395.31 rows=497345) (actual time=1182.008..1182.021 rows=41 loops=1)
            -> Filter: (ct.prefecture_code is not null)  (cost=51660.81 rows=497345) (actual time=0.032..936.339 rows=500000 loops=1)
                -> Table scan on ct  (cost=51660.81 rows=497345) (actual time=0.031..830.122 rows=500000 loops=1)
*/

-- UNION　→ UNION ALL
EXPLAIN ANALYZE
SELECT * FROM customers WHERE age<30
UNION ALL
SELECT * FROM customers WHERE age>50;
/*
 * -> Table scan on <union temporary>  (cost=0.01..5135.36 rows=410630) (actual time=0.549..1188.430 rows=286055 loops=1)
    -> Union materialize with deduplication  (cost=156914.07..162049.42 rows=410630) (actual time=11346.605..12601.335 rows=286055 loops=1)
        -> Index range scan on customers using idx_customers_age over (NULL < age < 30), with index condition: (customers.age < 30)  (cost=63642.51 rows=161958) (actual time=205.247..4195.637 rows=82096 loops=1)
        -> Filter: (customers.age > 50)  (cost=52208.55 rows=248672) (actual time=0.085..1933.114 rows=203959 loops=1)
            -> Table scan on customers  (cost=52208.55 rows=497345) (actual time=0.080..1810.222 rows=500000 loops=1)

 * 
/

/*
-> Append  (actual time=287.254..5464.927 rows=286055 loops=1)
    -> Stream results  (cost=67140.67 rows=161958) (actual time=287.252..3699.711 rows=82096 loops=1)
        -> Index range scan on customers using idx_customers_age over (NULL < age < 30), with index condition: (customers.age < 30)  (cost=67140.67 rows=161958) (actual time=287.242..3574.234 rows=82096 loops=1)
    -> Stream results  (cost=52713.74 rows=248672) (actual time=0.143..1705.600 rows=203959 loops=1)
        -> Filter: (customers.age > 50)  (cost=52713.74 rows=248672) (actual time=0.137..1436.959 rows=203959 loops=1)
            -> Table scan on customers  (cost=52713.74 rows=497345) (actual time=0.132..1329.776 rows=500000 loops=1)

*/