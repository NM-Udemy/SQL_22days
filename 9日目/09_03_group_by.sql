-- GROUP BY

SELECT age, COUNT(*), MAX(birth_day), MIN(birth_day) FROM users
WHERE birth_place="���{"
GROUP BY age
ORDER BY COUNT(*) 
;

SELECT department, SUM(salary), FLOOR(AVG(salary)), MIN(salary) FROM employees
WHERE age > 40
GROUP BY department;


SELECT
    CASE
        WHEN birth_place="���{" THEN "���{�l"
        ELSE "���̑�"
    END AS "����",
    COUNT(*),
    MAX(age)
FROM
    users
GROUP BY 
    CASE
        WHEN birth_place="���{" THEN "���{�l"
        ELSE "���̑�"
    END;

   
SELECT 
CASE
    WHEN name IN ("���쌧", "���m��", "���Q��", "������") THEN "�l��"
    ELSE "���̑�"
END AS "�n�於",
COUNT(*)
FROM
    prefectures
GROUP BY
CASE
    WHEN name IN ("���쌧", "���m��", "���Q��", "������") THEN "�l��"
    ELSE "���̑�"
END;


-- CASE
SELECT
   age,
   CASE
    WHEN age < 20 THEN "�����N"
    ELSE "���l"
    END AS "����",
    COUNT(*)
  FROM users
  GROUP BY age