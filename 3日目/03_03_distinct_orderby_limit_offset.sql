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

# ageΕΈ
SELECT * FROM people ORDER BY age ASC;

# ageΕ~
SELECT * FROM people ORDER BY age DESC;

# name
SELECT * FROM people ORDER BY name DESC;

# 2ΒJ
SELECT * FROM people ORDER BY birth_day DESC, name DESC, age ASC;

# ASC: Έ
# DESC: ~

# DISNTICT
SELECT DISTINCT birth_day FROM people ORDER BY birth_day;

SELECT DISTINCT name, birth_day FROM people;


# LIMITΝΕΜsΎ―\¦
SELECT id, name, age FROM people LIMIT 3;

# ςΞ΅Δ\¦(3ςΞ΅2\¦)
SELECT * FROM people LIMIT 3, 2;
SELECT * FROM people LIMIT 4 OFFSET 2;

