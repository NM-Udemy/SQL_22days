EXPLAIN ANALYZE SELECT * FROM customers;

/* 
 * -> Table scan on customers  (cost=51750.76 rows=497933) (actual time=0.145..944.587 rows=500000 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE id=1;
/*
-> Rows fetched before execution  (cost=0.00..0.00 rows=1) (actual time=0.000..0.000 rows=1 loops=1)
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE id<10;
/*
 * -> Filter: (customers.id < 10)  (cost=2.47 rows=9) (actual time=0.050..0.091 rows=9 loops=1)
    -> Index range scan on customers using PRIMARY over (id < 10)  (cost=2.47 rows=9) (actual time=0.046..0.085 rows=9 loops=1)
 * 
*/

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name="Olivia";

/*
-> Filter: (customers.first_name = 'Olivia')  (cost=51751.52 rows=49793) (actual time=0.105..1148.354 rows=503 loops=1)
    -> Table scan on customers  (cost=51751.52 rows=497933) (actual time=0.101..959.983 rows=500000 loops=1)
*/

CREATE INDEX idx_customer_first_name ON customers(first_name);

EXPLAIN ANALYZE SELECT * FROM customers WHERE first_name="Olivia";
/*
-> Index lookup on customers using idx_customer_first_name (first_name='Olivia')  (cost=489.44 rows=503) (actual time=16.382..109.392 rows=503 loops=1)
*/


EXPLAIN ANALYZE SELECT * FROM customers WHERE gender="F";

/*
-> Filter: (customers.gender = 'F')  (cost=52098.70 rows=49793) (actual time=0.120..1234.877 rows=250065 loops=1)
    -> Table scan on customers  (cost=52098.70 rows=497933) (actual time=0.115..1054.245 rows=500000 loops=1)
*/

CREATE INDEX idx_customers_gender ON customers(gender);

-- 遅くなる(インデックスをつけると)
EXPLAIN ANALYZE SELECT * FROM customers WHERE gender="F";

/*
-> Index lookup on customers using idx_customers_gender (gender='F'), with index condition: (customers.gender = 'F')  (cost=32348.37 rows=248966) (actual time=1.676..4904.113 rows=250065 loops=1)
*/

-- ヒント句
EXPLAIN ANALYZE SELECT /*+ NO_INDEX(ct) */ * FROM customers AS ct WHERE ct.gender="F";
/*
-> Filter: (ct.gender = 'F')  (cost=51849.52 rows=497933) (actual time=1.581..1480.942 rows=250065 loops=1)
    -> Table scan on ct  (cost=51849.52 rows=497933) (actual time=1.573..1297.933 rows=500000 loops=1)
*/

DROP INDEX idx_customers_gender ON customers;
DROP INDEX idx_customer_first_name  ON customers;
