SHOW DATABASES;

CREATE DATABASE day_19_21_db;

USE day_19_21_db;
SHOW TABLES;

-- ���v���̊m�F
SELECT * FROM mysql.innodb_table_stats WHERE database_name="day_19_21_db";

SELECT * FROM prefectures;

INSERT INTO prefectures VALUES("48", "�s��");

DELETE FROM prefectures WHERE prefecture_code ="48" AND name="�s��";

-- ���v���̎蓮�X�V
ANALYZE TABLE prefectures;

-- SQL�����s�����Ɏ��s�v�悾���\��
EXPLAIN SELECT * FROM customers;


-- SQL�����s���āA���s�v���\��
EXPLAIN ANALYZE SELECT * FROM customers;

/*
-> Table scan on customers  (cost=52312.63 rows=497345) (actual time=4.300..1112.843 rows=500000 loops=1)
*/

