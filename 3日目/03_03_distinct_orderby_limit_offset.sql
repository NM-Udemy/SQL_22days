SHOW TABLES;

DESCRIBE people;

ALTER TABLE people ADD age INT AFTER name;

INSERT INTO people VALUES(1, "John", 18,  "2001-01-01");
INSERT INTO people VALUES(2, "Alice", 15,  "2003-01-01");
INSERT INTO people VALUES(3, "Paul", 19,  "2000-01-01");
INSERT INTO people VALUES(4, "Chris", 17,  "2001-01-01");
INSERT INTO people VALUES(5, "Vette", 20,  "2001-01-01");
INSERT INTO people VALUES(6, "Tsuyoshi", 21,  "2001-01-01");

SELECT * FROM people;

# ageで昇順
SELECT * FROM people ORDER BY age ASC;

# ageで降順
SELECT * FROM people ORDER BY age DESC;

# name
SELECT * FROM people ORDER BY name DESC;

# 2つカラム
SELECT * FROM people ORDER BY birth_day DESC, name DESC, age ASC;

# ASC: 昇順
# DESC: 降順

# DISNTICT
SELECT DISTINCT birth_day FROM people ORDER BY birth_day;

SELECT DISTINCT name, birth_day FROM people;


# LIMITは最初の行だけ表示
SELECT id, name, age FROM people LIMIT 3;

# 飛ばして表示(3飛ばし2表示)
SELECT * FROM people LIMIT 3, 2;
SELECT * FROM people LIMIT 4 OFFSET 2;

