-- ROUND , FLOOR, CEILING

SELECT ROUND(13.14, -1); # �l�̌ܓ�

SELECT FLOOR(3.14) # �؂�̂�

SELECT FLOOR(3.84) # �؂�̂�


SELECT CEILING(3.14) # �؂�グ


SELECT RAND(); # 0 ~ 1
SELECT FLOOR(RAND() * 10) # 0 ~ 9

-- power
SELECT POWER(3, 4);

SELECT weight / POWER(height/100, 2) AS BMI FROM students;


-- COALESCE: NULL�łȂ��ŏ��̒l��Ԃ�
SELECT * FROM tests_score;

SELECT COALESCE(NULL, NULL, NULL, "A", NULL, "B");

SELECT COALESCE(test_score_1, test_score_2, test_score_3), test_score_1, test_score_2, test_score_3 AS score FROM tests_score;
