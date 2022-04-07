USE my_db;

SELECT DATABASE();

# テーブル作成 
CREATE TABLE users(
    id INT, -- idカラムINT型
    name VARCHAR(10), -- 名前, 可変長文字列
    age INT,
    phone_number CHAR(13), -- 固定長
    message TEXT
)

# テーブル一覧表示
SHOW TABLES;


# テーブルの定義確認
DESCRIBE users;

# テーブルの削除
DROP TABLE users;

SHOW TABLES;

# テーブル作成 (主キー付き)
CREATE TABLE users(
    id INT PRIMARY KEY, -- idカラムINT型
    name VARCHAR(10), -- 名前, 可変長文字列
    age INT,
    phone_number CHAR(13), -- 固定長
    message TEXT
)

DESCRIBE users;
