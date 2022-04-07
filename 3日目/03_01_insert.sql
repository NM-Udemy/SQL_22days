SELECT DATABASE();

USE my_db;

# テーブル作成
CREATE TABLE people(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    birth_day DATE DEFAULT "1990-01-01"
);


# INSERT 1
INSERT INTO people VALUES(1, "Taro", "2001-01-01");


# SELECT
SELECT * FROM people;

# INSERT カラム指定
INSERT INTO people(id, name) VALUES(2, "Jiro");

# シングルクォート
INSERT INTO people(id, name) VALUES(3, 'Saburo');

INSERT INTO people VALUES(4, 'John''s son', '2021-01-01');

INSERT INTO people VALUES(5, 'John"s son', '2021-01-01');

# "の中に"
INSERT INTO people VALUES(6, "John""s son", '2021-01-01');


