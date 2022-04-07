USE day_10_14_db;


-- employees�e�[�u����customers�e�[�u���̗�������A���ꂼ��id��10��菬�������R�[�h�����o���܂��B
-- ���e�[�u����first_name, last_name, age�J���������o���A�s�����ɘA�����܂��B
-- �A���̍ۂ́A�d�����폜����悤�ɂ��Ă��������B


SELECT first_name, last_name, age FROM employees WHERE id < 10
UNION
SELECT first_name, last_name, age FROM customers WHERE id < 10;




-- departments�e�[�u����name�J�������c�ƕ��̐l�́A�����̍ő�l�A�ŏ��l�A���ϒl�A���v�l���v�Z���Ă��������B
-- employees�e�[�u����department_id��departments�e�[�u����id���R�Â����
-- salaries�e�[�u����employee_id��employees�e�[�u����id���R�Â����܂��B
-- ������salaries�e�[�u����payment�J�����Ɋi�[����Ă��܂�

SELECT MAX(payment), MIN(payment), AVG(payment), SUM(payment)
FROM salaries AS sa
INNER JOIN employees AS emp
ON sa.employee_id = emp.id
INNER JOIN departments AS dt
ON emp.department_id  = dt.id
WHERE dt.name = "�c�ƕ�";



-- classes�e�[�u����id���A5�������������R�[�h�Ƃ���ȊO�̃��R�[�h�𗚏C���Ă��鐶�k�̐����v�Z���Ă��������B
-- classes�e�[�u����id��enrollments�e�[�u����class_id�Aenrollments�e�[�u����student_id��students.id���R�Â�
-- classes�ɂ̓N���X�����i�[����Ă��āAstudents�Ƒ��Α��Ō��������


SELECT
CASE
    WHEN cls.id < 5 THEN "�N���X1"
    ELSE "�N���X2"
END AS "�N���X����",
COUNT(std.id)
FROM classes AS cls
INNER JOIN enrollments AS enr
ON cls.id = enr.class_id
INNER JOIN students AS std 
ON enr.student_id = std.id
GROUP BY
CASE
    WHEN cls.id < 5 THEN "�N���X1"
    ELSE "�N���X2"
END;


-- age��40��菬�����S�]�ƈ��Ō����̕��ϒl��7,000,000�����傫���l�́A�����̍��v�l�ƕ��ϒl���v�Z���Ă��������B
-- employees�e�[�u����id��salaries�e�[�u����employee_id���R�Â��ł��Asalaries�e�[�u����payment�Ɍ������i�[����Ă��܂�

SELECT emp.id, SUM(sa.payment), AVG(sa.payment)
FROM employees AS emp
  INNER JOIN salaries AS sa
  ON emp.id = sa.employee_id 
WHERE emp.age < 40
GROUP BY emp.id
HAVING AVG(sa.payment) > 7000000;


-- customer���ɁAorder_amount�̍��v�l���v�Z���Ă��������B
-- customers�e�[�u����orders�e�[�u���́Aid�J������customer_id�J�����ŕR�Â����ł�
-- orders�e�[�u����order_amount�̍��v�l���擾���܂��B
-- SELECT�̑ΏۃJ�����ɕ��₢���킹��p���Ēl���擾���Ă��������B
SELECT
*,
(SELECT SUM(order_amount) FROM orders AS od
WHERE od.customer_id = cst.id) AS sum_order_amount
FROM customers AS cst;


-- customers�e�[�u������last_name�ɓc�������R�[�h�A
-- orders�e�[�u������order_date��2020-12-01�ȏ�̃��R�[�h�A
-- stores�e�[�u������name���R�c���X�̃��R�[�h���m��A�����܂�
-- customers��orders, orders��items, items��stores���R�Â��܂��B
-- first_name��last_name�̒l��A��(CONCAT)���ďW�v(GROUP BY)���A���̃��R�[�h����COUNT���Ă��������B

SELECT
   CONCAT(customers.last_name, customers.first_name), COUNT(*)
FROM
   (SELECT * FROM customers WHERE last_name LIKE "%�c%") AS customers
   INNER JOIN (SELECT * FROM orders WHERE order_date >= "2020-12-01") AS orders 
   ON customers.id = orders.customer_id 
  INNER JOIN items 
  ON orders.item_id = items.id
   INNER JOIN (SELECT * FROM stores WHERE name="�R�c���X") AS stores 
   ON stores.id = items.store_id
   GROUP BY CONCAT(customers.last_name, customers.first_name)
   
   

   
-- salaries��payment��9,000,000�����傫�����̂����݂��郌�R�[�h���Aemployees�e�[�u��������o���Ă��������B
-- employees�e�[�u����salaries�e�[�u����R�Â��܂��B
-- EXISTS��IN��INNER JOIN�A���ꂼ��̕��@�ŋL�ڂ��Ă�������
SELECT * FROM employees
  WHERE id IN(SELECT employee_id FROM salaries WHERE payment > 9000000);

SELECT DISTINCT emp.* FROM employees AS emp
INNER JOIN salaries AS sa
ON emp.id = sa.employee_id
WHERE sa.payment > 9000000;


SELECT * FROM employees AS emp
WHERE
    EXISTS(
         SELECT
             1
         FROM
             salaries AS sa
         WHERE emp.id =sa.employee_id  AND sa.payment > 9000000
    );
    
   
-- employees�e�[�u������Asalaries�e�[�u���ƕR�Â��̂ł��Ȃ����R�[�h�����o���Ă��������B
-- EXISTS��IN��LEFT JOIN�A���ꂼ��̕��@�ŋL�ڂ��Ă�������
   
SELECT *
FROM employees
WHERE id NOT IN(SELECT employee_id FROM salaries);


SELECT * FROM employees AS emp
LEFT JOIN salaries AS sa
ON emp.id = sa.employee_id
WHERE sa.id IS NULL;


SELECT * FROM employees AS emp
WHERE
    NOT EXISTS(
        SELECT
            1
        FROM 
            salaries AS sa
        WHERE sa.employee_id = emp.id
    );

   
-- employees�e�[�u����customers�e�[�u����age���m���r���܂�
-- customers�e�[�u���̍ŏ�age, ����age, �ő�age��employees�e�[�u����age���r���āA
-- employees�e�[�u����age���A�ŏ�age�����̂��͍̂ŏ������A�ŏ�age�ȏ�ŕ���age�����̂��͕̂��ϖ����A
-- ����age�ȏ�ōő�age�����̂��͍̂ő喢���A����ȊO�͂��̑��ƕ\�����܂�
-- WITH���p���ċL�q���܂�
WITH customers_age AS(
    SELECT MAX(age) AS max_age, MIN(age) AS min_age, AVG(age) AS avg_age
    FROM customers
)
SELECT
    *,
    CASE
        WHEN emp.age < ca.min_age THEN "�ŏ�����"
        WHEN emp.age < ca.avg_age THEN "���ϖ���"
        WHEN emp.age < ca.max_age THEN "�ő喢��"
        ELSE "���̑�"
    END AS "customers�Ƃ̔�r"
FROM 
    employees AS emp
CROSS JOIN customers_age AS ca; 



-- customers�e�[�u������age��50�����傫�����R�[�h�����o���āAorders�e�[�u���ƘA�����܂��B
-- customers�e�[�u����id�ɑ΂��āAorders�e�[�u����order_amount*order_price��order_date���̍��v�l�B
-- ���v�l��7���ԕ��ϒl�A���v�l��15�����ϒl�A���v�l��30�����ϒl���v�Z���܂��B
-- 7���ԕ��ρA15�����ϒl�A30�����ϒl���v�Z�ł��Ȃ����(�Ώۂ����O�̓��t�̃f�[�^���\���ɂȂ����)�́A�󔒂�\�����Ă��������B

WITH tmp_customers AS(
    SELECT
        *
    FROM
        customers
    WHERE
        age > 50
), tmp_customers_orders AS(
     SELECT 
          tc.id, od.order_date, SUM(od.order_amount * od.order_price) AS payment,
          ROW_NUMBER() OVER(PARTITION BY tc.id ORDER BY od.order_date) AS row_num
     FROM tmp_customers AS tc
     INNER JOIN orders AS od
     ON tc.id = od.customer_id
     GROUP BY tc.id, od.order_date
)
SELECT id, order_date, payment, 
CASE 
   WHEN row_num < 7 THEN ""
   ELSE AVG(payment) OVER(PARTITION BY id ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
END AS "7���ԕ���",
CASE
    WHEN row_num < 15 THEN ""
    ELSE AVG(payment) OVER(PARTITION BY id ORDER BY order_date ROWS BETWEEN 14 PRECEDING AND CURRENT ROW)
END AS "15���ԕ���",
CASE
    WHEN row_num < 30 THEN ""
    ELSE AVG(payment) OVER(PARTITION BY id ORDER BY order_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW)
END AS "30���ԕ���"
FROM tmp_customers_orders ;



