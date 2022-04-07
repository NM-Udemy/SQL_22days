SHOW DATABASES;
USE day_4_9_db;


-- UNION : d•¡‚Ííœ
SELECT * FROM new_students
UNION
SELECT * FROM students;
/*
341|–xì çŒq |   177|    77|       5|
  4|•‘ò Œh³ |   163|    74|       1|
  5|’†’J ƒ“T |   159|    62|       2|
  7|‹gì ˆê÷ |   169|    68|       4|
  8|âV“¡ •Ûs |   181|    81|       3|
*/

SELECT * FROM new_students
UNION
SELECT * FROM students
ORDER BY id;
;

-- UNION ALL: d•¡íœ‚µ‚È‚¢
SELECT * FROM new_students
UNION ALL
SELECT * FROM students;


SELECT * FROM new_students
UNION ALL
SELECT * FROM students
ORDER BY id;



SELECT * FROM students WHERE id < 10
UNION ALL
SELECT * FROM new_students WHERE id>250;

SELECT id, name  FROM students WHERE id<10
UNION
SELECT age, name  FROM users WHERE id<10
ORDER BY id;

SELECT id,name, height FROM students
UNION ALL
SELECT age,name FROM users;




