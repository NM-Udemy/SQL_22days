USE day_15_18_db;

CREATE TABLE messages (
    name_code CHAR(8),
    name VARCHAR(25),
    message TEXT -- 65535
);

INSERT INTO messages VALUES("00000001", "Yoshida Takeshi", "aaaaba");
INSERT INTO messages VALUES("00000002", "Yoshida Yusaku", "aaaaba");


-- INT系
CREATE TABLE patients(
    id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- 0~65535
    name VARCHAR(50),
    age TINYINT UNSIGNED DEFAULT 0 -- 0 ~ 255
);

INSERT INTO patients(name, age) VALUES("Sachiko", 34);

SELECT * FROM patients;
INSERT INTO patients(name, age) VALUES("Sachiko", 255);

INSERT INTO patients(id, name) VALUES(65536, "Yoshio");

ALTER TABLE patients MODIFY id MEDIUMINT UNSIGNED AUTO_INCREMENT; -- 0~16777215

SHOW FULL COLUMNS FROM patients;

-- heightカラム、weightカラムの追加
ALTER TABLE patients ADD COLUMN(height FLOAT);

ALTER TABLE patients ADD COLUMN(weight FLOAT);

SELECT * FROM patients;

INSERT INTO patients(name, age, height, weight) VALUES("Taro", 44, 175.67891234, 67.893456767);

CREATE TABLE tmp_float(
     num FLOAT
);

INSERT INTO tmp_float VALUES(12345.58);

SELECT * FROM tmp_float ;


CREATE TABLE tmp_double(
    num DOUBLE
);

INSERT INTO tmp_double VALUES(123456789.123456789);

SELECT num+2, num FROM tmp_float;


-- DECIMAL 
ALTER TABLE patients ADD COLUMN score DECIMAL(7, 3); -- 整数部: 4, 小数部: 3

SELECT * FROM patients;

INSERT INTO patients(name, age, score) VALUES ("Jiro", 54, 32.456);


CREATE TABLE tmp_decimal(
     num_float FLOAT,
     num_double DOUBLE,
     num_decimal DECIMAL(20,10)
);

INSERT INTO tmp_decimal VALUES(1111111111.1111111111, 1111111111.1111111111, 1111111111.11111111119);

SELECT num_decimal, (num_decimal*2 + 2 )/ 2 FROM tmp_decimal ;


-- 論理型

CREATE TABLE managers(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    is_superuser BOOLEAN
);

INSERT INTO managers(name, is_superuser) VALUES("Taro", true);

INSERT INTO managers(name, is_superuser) VALUES("Jiro", false);


SELECT * FROM managers WHERE is_superuser=false;







-- DATE TIME

CREATE TABLE alerms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    alarm_day DATE,
    alarm_time TIME,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT CURRENT_TIMESTAMP, NOW(), CURRENT_DATE, CURRENT_TIME;

INSERT INTO alerms(alarm_day, alarm_time) VALUES("2019-01-01", "19:50:21");
INSERT INTO alerms(alarm_day, alarm_time) VALUES("2021/01/15", "195031");

SELECT * FROM alerms;
UPDATE alerms SET alarm_time = CURRENT_TIME WHERE id =1;

SELECT DATE_FORMAT(alarm_day, '%d'), SECOND(alarm_time), alarm_time FROM alerms;

CREATE TABLE tmp_time (
    num TIME(5)
);

INSERT INTO tmp_time VALUES("21:05:21.54321");

SELECT * FROM tmp_time;


-- DATETIME, TIMESTAMP 
CREATE TABLE tmp_datetime_timestamp(
    val_datetime DATETIME,
    val_timestamp TIMESTAMP,
    val_datetime_3 DATETIME(3),
    val_timestamp_3 TIMESTAMP(3)
);

INSERT INTO tmp_datetime_timestamp 
VALUES(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


INSERT INTO tmp_datetime_timestamp 
VALUES("2019/01/01 09:08:07.5432", "2019/01/01 09:08:07.5432", "2019/01/01 09:08:07.6578", "2019/01/01 09:08:07.6578");

SELECT * FROM tmp_datetime_timestamp ;

-- 1969/01/01 00:00:01 古い日付はtimestampには入れられない
INSERT INTO tmp_datetime_timestamp 
VALUES("1969/01/01 00:00:01", "1969/01/01 00:00:01", "1969/01/01 00:00:01", "1969/01/01 00:00:01");


-- 2039/01/01 00:00:01　新しい 古い日付はtimestampには入れられない
INSERT INTO tmp_datetime_timestamp 
VALUES("9999/01/01 00:00:01", "2029/01/01 00:00:01", "2039/01/01 00:00:01", "2029/01/01 00:00:01");



SHOW TABLES;

SELECT * FROM students;

SHOW INDEX FROM students;

CREATE INDEX idx_students_name ON students(name);
EXPLAIN SELECT * FROM students WHERE name="Taro";

-- 関数インデックス
CREATE INDEX idx_students_lower_name ON students((LOWER(name)));

EXPLAIN SELECT * FROM students WHERE LOWER(name) = "taro";


SHOW TABLES;

SELECT * FROM users;

CREATE UNIQUE INDEX idx_users_uniq_first_name ON users(first_name);

INSERT INTO users(id, first_name) VALUES(3, "ABC");

