-- HAVING
SELECT department, AVG(salary) FROM employees
GROUP BY department 
HAVING AVG(salary) > 3980000;

SELECT birth_place, age, COUNT(*) FROM users
GROUP BY birth_place, age
HAVING COUNT(*)>1
ORDER BY COUNT(*);


-- HAVING�̂�
SELECT
  "�d���Ȃ�"
FROM
   users
HAVING
   COUNT(DISTINCT name) = COUNT(name);

  
SELECT
  "�d���Ȃ�" AS "check"
FROM
   users
HAVING
   COUNT(DISTINCT age) = COUNT(age)
   
