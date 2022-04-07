-- ROUND , FLOOR, CEILING

SELECT ROUND(13.14, -1); # lÌŒÜ“ü

SELECT FLOOR(3.14) # Ø‚èÌ‚Ä

SELECT FLOOR(3.84) # Ø‚èÌ‚Ä


SELECT CEILING(3.14) # Ø‚èã‚°


SELECT RAND(); # 0 ~ 1
SELECT FLOOR(RAND() * 10) # 0 ~ 9

-- power
SELECT POWER(3, 4);

SELECT weight / POWER(height/100, 2) AS BMI FROM students;


-- COALESCE: NULL‚Å‚È‚¢Å‰‚Ì’l‚ğ•Ô‚·
SELECT * FROM tests_score;

SELECT COALESCE(NULL, NULL, NULL, "A", NULL, "B");

SELECT COALESCE(test_score_1, test_score_2, test_score_3), test_score_1, test_score_2, test_score_3 AS score FROM tests_score;
