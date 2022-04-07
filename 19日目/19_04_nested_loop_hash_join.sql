EXPLAIN ANALYZE SELECT
   *
FROM customers AS ct
INNER JOIN prefectures AS pr
ON ct.prefecture_code = pr.prefecture_code ;

/*
-> Nested loop inner join  (cost=225800.92 rows=497933) (actual time=0.133..3406.701 rows=500000 loops=1)
    -> Filter: (ct.prefecture_code is not null)  (cost=51524.37 rows=497933) (actual time=0.111..1452.833 rows=500000 loops=1)
        -> Table scan on ct  (cost=51524.37 rows=497933) (actual time=0.110..1332.315 rows=500000 loops=1)
    -> Single-row index lookup on pr using PRIMARY (prefecture_code=ct.prefecture_code)  (cost=0.25 rows=1) (actual time=0.003..0.003 rows=1 loops=500000)
*/



EXPLAIN ANALYZE SELECT /*+ NO_INDEX(pr) */
   *
FROM customers AS ct
INNER JOIN prefectures AS pr
ON ct.prefecture_code = pr.prefecture_code ;
/*
-> Inner hash join (ct.prefecture_code = pr.prefecture_code)  (cost=2342032.81 rows=2340285) (actual time=0.181..1548.315 rows=500000 loops=1)
    -> Table scan on ct  (cost=143.02 rows=497933) (actual time=0.071..1133.592 rows=500000 loops=1)
    -> Hash
        -> Table scan on pr  (cost=4.95 rows=47) (actual time=0.043..0.057 rows=47 loops=1)
*/
