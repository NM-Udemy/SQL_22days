/* 1. customersテーブルから、ageが28以上40以下でなおかつ、nameの末尾が「子」の人だけに絞り込んでください。
そして、ageで降順に並び替え、検索して先頭の5件の人のnameとageだけを表示してください。 */

SELECT
name, age
FROM customers
WHERE age >= 28 AND age <= 40 AND name LIKE '%子'
ORDER BY age DESC
LIMIT 5;


/* 2. receiptsテーブルに、customer_idが100, store_nameがStore X, priceが10000のレコードを挿入してください。
  */

DESCRIBE receipts ;

SELECT * FROM receipts ORDER BY id DESC LIMIT 10;

INSERT INTO receipts VALUES(301, 100, "Store X", 10000);


/* 3. 2で挿入したレコードを削除してください */
SELECT * FROM receipts ORDER BY id DESC LIMIT 10;

DELETE FROM receipts WHERE id=301;


/* 4. prefecturesテーブルから、nameが空白もしくは、NULLのものを削除してください */
SELECT * FROM prefectures WHERE name="" OR name IS NULL;

DELETE FROM prefectures WHERE name="" OR name IS NULL;


/* 5. customersテーブルのidが20以上50以下の人に対して年齢を+1したデータで更新してください
(ただし、BETWEENを使うこと) */
SELECT *, age+1 FROM customers WHERE id BETWEEN 20 AND 50;

UPDATE customers SET age=age+1 WHERE id BETWEEN 20 AND 50;


/* 6. studentsテーブルのclass_noが6の人すべてに対して、class_noが1～5のランダムな値で更新してください */

SELECT *, CEILING(RAND()*5) FROM students WHERE class_no=6;

UPDATE students SET class_no=CEILING(RAND()*5)  WHERE class_no=6;


SELECT * FROM students;


/* 7. class_noが3または4の人をstudentsテーブルから取り出します。
取り出した人のheightに10を加算して、その加算した全heightよりも、
heightの値が小さくてclass_noが1の人をstudentsテーブルから取り出してください。
(ただし、IN, ALLを使うこと) */

SELECT * FROM students
WHERE height < ALL (SELECT  height+10 FROM students WHERE class_no IN(3, 4))
AND class_no=1;



/* 8. employeesテーブルのdepartmentカラムには、「 営業部 」のような形で部署名の前後に空白が入っています。
 * この空白を除いた形にテーブルを更新してください */

SELECT *, TRIM(department) FROM employees;

UPDATE employees SET department=TRIM(department);




/* 9. employeesテーブルからsalaryが5000000以上の人のsalaryは0.9倍して、5000000未満の人は、1.1倍して下さい。
(ただし、小数点以下は四捨五入します) */

SELECT *, ROUND(salary*0.9) FROM employees WHERE salary >= 5000000;

-- UPDATE employees  SET salary = ROUND(salary*0.9) WHERE salary >= 5000000;
-- UPDATE employees  SET salary = ROUND(salary*1.1) WHERE salary <  5000000;

SELECT *, ROUND(salary*1.1) FROM employees WHERE salary <  5000000;

SELECT *,
CASE
    WHEN salary >= 5000000 THEN ROUND(salary*0.9)
    WHEN salary < 5000000 THEN ROUND(salary*1.1)
END AS new_salary
FROM employees;


UPDATE employees
SET salary=CASE
    WHEN salary >= 5000000 THEN ROUND(salary*0.9)
    WHEN salary < 5000000 THEN ROUND(salary*1.1)
END;


SELECT * FROM employees;


/* 10. customersテーブルにnameが「名無権兵衛」、ageが0、birth_dayが本日日付の人を挿入してください。
（ただし、日付関数を使うこと） */

SELECT *, CURDATE() FROM customers ORDER BY id DESC;

INSERT INTO customers VALUES(101, "名無権兵衛", 0, CURDATE())


/* 11. customersテーブルに新たなカラムとして、「name_length INT」を作成します。
name_lengthカラムをcustomersテーブルの各行の名前の文字数でアップデートしてください */

SELECT * FROM customers;

ALTER TABLE customers ADD name_length INT;


SELECT *, CHAR_LENGTH(name) FROM customers;


UPDATE customers SET name_length=CHAR_LENGTH(name);


/* 12. tests_scoreテーブルに新たなカラムとして、「score INT」を作成します。
scoreカラムに、testsテーブルの各行のtest_score_1, test_score_2, test_score_3から、取り出したNULLでない最初の値で更新します。
ただし、取り出した点数が900以上の人は、1.2倍して、小数点以下を切り捨てて、600以下の人は、0.8倍して、小数点以下を切り上げてください。
*/

SELECT * FROM tests_score;

ALTER TABLE tests_score ADD score INT;


SELECT *, 
CASE
    WHEN COALESCE(test_score_1, test_score_2, test_score_3) >= 900
    THEN FLOOR(COALESCE(test_score_1, test_score_2, test_score_3) * 1.2)
    WHEN COALESCE(test_score_1, test_score_2, test_score_3) <= 600
    THEN CEILING(COALESCE(test_score_1, test_score_2, test_score_3) * 0.8)
    ELSE  COALESCE(test_score_1, test_score_2, test_score_3) 
END AS results
FROM tests_score;


UPDATE tests_score SET
score=CASE
    WHEN COALESCE(test_score_1, test_score_2, test_score_3) >= 900
    THEN FLOOR(COALESCE(test_score_1, test_score_2, test_score_3) * 1.2)
    WHEN COALESCE(test_score_1, test_score_2, test_score_3) <= 600
    THEN CEILING(COALESCE(test_score_1, test_score_2, test_score_3) * 0.8)
    ELSE  COALESCE(test_score_1, test_score_2, test_score_3) 
END;




/*
 * 13. employeesテーブルを、
 *  departmentが、マーケティング部 、研究部、開発部、総務部、営業部、経理部の順になるように並び替えてください。
 * 
 */
SELECT * FROM employees
ORDER BY
CASE department
WHEN "マーケティング部" THEN 1
WHEN "研究部" THEN 2
WHEN "開発部" THEN 3
WHEN "総務部" THEN 4
WHEN "営業部" THEN 5
WHEN "経理部" THEN 6
END
;
