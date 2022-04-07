SHOW DATABASES;

USE day_19_21_db;

-- レンジパーティション
CREATE TABLE users_partitioned(
    name VARCHAR(50),
    age INT
)
PARTITION BY RANGE(age)(
    PARTITION p0 VALUES LESS THAN(20),
    PARTITION p1 VALUES LESS THAN(40),
    PARTITION p2 VALUES LESS THAN(60)
);



INSERT INTO users_partitioned VALUES("Taro", 18);
INSERT INTO users_partitioned VALUES("Jiro", 28);
INSERT INTO users_partitioned VALUES("Saburo", 38);
INSERT INTO users_partitioned VALUES("Yoshiko", 48);

SELECT * FROM users_partitioned ;
SELECT * FROM users_partitioned PARTITION (p1) ;

EXPLAIN SELECT * FROM users_partitioned ;
EXPLAIN SELECT * FROM users_partitioned WHERE age<20 ;




INSERT INTO users_partitioned VALUES("Yoko", 72);

-- ALTER TABLEでのパーティション変更
ALTER TABLE users_partitioned 
PARTITION BY RANGE(age)(
    PARTITION p0 VALUES LESS THAN(20),
    PARTITION p1 VALUES LESS THAN(40),
    PARTITION p2 VALUES LESS THAN(60),
    PARTITION p_max VALUES LESS THAN(MAXVALUE)
);

SHOW TABLES;

SHOW CREATE TABLE sales_history_partitioned;

/*
CREATE TABLE `sales_history_partitioned` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` mediumint unsigned DEFAULT NULL,
  `product_id` mediumint unsigned DEFAULT NULL,
  `sales_amount` mediumint unsigned DEFAULT NULL,
  `sales_day` date NOT NULL DEFAULT '1970-01-01',
  PRIMARY KEY (`id`,`sales_day`)
) ENGINE=InnoDB AUTO_INCREMENT=2500001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY RANGE (year(`sales_day`))
(PARTITION p0_lt_2016 VALUES LESS THAN (2016) ENGINE = InnoDB,
 PARTITION p1_lt_2017 VALUES LESS THAN (2017) ENGINE = InnoDB,
 PARTITION p2_lt_2018 VALUES LESS THAN (2018) ENGINE = InnoDB,
 PARTITION p3_lt_2019 VALUES LESS THAN (2019) ENGINE = InnoDB,
 PARTITION p4_lt_2020 VALUES LESS THAN (2020) ENGINE = InnoDB,
 PARTITION p5_lt_2021 VALUES LESS THAN (2021) ENGINE = InnoDB,
 PARTITION p6_lt_max VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */
*/

SELECT COUNT(*) FROM sales_history_partitioned; -- パーティション化されている
SELECT COUNT(*) FROM sales_history; -- パーティション化されていない


SELECT COUNT(*) FROM sales_history
WHERE sales_day BETWEEN "2016-01-01" AND "2016-12-31"; -- 4957ms

SELECT COUNT(*) FROM sales_history_partitioned
WHERE sales_day BETWEEN "2016-01-01" AND "2016-12-31"; -- 676ms


-- リストパーティション

CREATE TABLE shops(
    id INT,
    name VARCHAR(50),
    shop_type INT
)
PARTITION BY LIST(shop_type)(
    PARTITION p0 VALUES IN(1,2,3),
    PARTITION p1 VALUES IN(4,5),
    PARTITION p2 VALUES IN(6,7)
);

INSERT INTO shops VALUES
(1, "Shop A", 1),
(2, "Shop B", 2),
(3, "Shop C", 3),
(4, "Shop D", 4),
(5, "Shop E", 5),
(6, "Shop F", 6),
(7, "Shop G", 7);

SELECT * FROM shops PARTITION(p3);

-- パーティション追加
ALTER TABLE shops ADD PARTITION 
(PARTITION p3 VALUES IN(8,9,10));

INSERT INTO shops VALUES(9,"Shop H", 21);


-- ハッシュパーティション
CREATE TABLE h_partition(
    name VARCHAR(50),
    partition_key INT
)
PARTITION BY HASH(partition_key)
PARTITIONS 4;

INSERT INTO h_partition VALUES
("A", 1),
("B", 2),
("C", 3),
("D", 4),
("E", 5),
("F", 6),
("G", 7),
("H", 8);



INSERT INTO h_partition VALUES("J", 8)

SELECT * FROM h_partition PARTITION(p0);


CREATE TABLE k_partition(
    id INT PRIMARY KEY AUTO_INCREMENT ,
    name VARCHAR(59)
)
PARTITION BY KEY()
PARTITIONS 2;

INSERT INTO k_partition(name) VALUES
("A"),
("B"),
("C"),
("D"),
("E"),
("F"),
("G"),
("H"),
("I");

SELECT * FROM k_partition PARTITION(p1);


-- サブパーティション
CREATE TABLE order_history(
    id INT,
    amount INT,
    order_date DATE
)
PARTITION BY RANGE(YEAR(order_date))
SUBPARTITION BY HASH(id)(
     PARTITION p0 VALUES LESS THAN(2010)(
         SUBPARTITION s0,
         SUBPARTITION s1
     ),
     PARTITION p1 VALUES LESS THAN(2015)(
         SUBPARTITION s2,
         SUBPARTITION s3
     ),
     PARTITION p2 VALUES LESS THAN(MAXVALUE)(
         SUBPARTITION s4,
         SUBPARTITION s5
     )
);




INSERT INTO order_history VALUES
(1, 10000, "2008-01-01"),
(2, 10000, "2009-01-01"),
(3, 10000, "2008-11-01"),
(4, 10000, "2009-02-01"),
(5, 10000, "2018-01-01"),
(6, 10000, "2012-01-01");


SELECT * FROM order_history PARTITION(s1);

EXPLAIN SELECT * FROM order_history WHERE order_date < "2009-01-01";

-- 統計情報の更新
ALTER TABLE order_history ANALYZE PARTITION s0;


