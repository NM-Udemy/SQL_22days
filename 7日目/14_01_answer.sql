/* 1. customers�e�[�u������Aage��28�ȏ�40�ȉ��łȂ����Aname�̖������u�q�v�̐l�����ɍi�荞��ł��������B
�����āAage�ō~���ɕ��ёւ��A�������Đ擪��5���̐l��name��age������\�����Ă��������B */

SELECT
name, age
FROM customers
WHERE age >= 28 AND age <= 40 AND name LIKE '%�q'
ORDER BY age DESC
LIMIT 5;


/* 2. receipts�e�[�u���ɁAcustomer_id��100, store_name��Store X, price��10000�̃��R�[�h��}�����Ă��������B
  */

DESCRIBE receipts ;

SELECT * FROM receipts ORDER BY id DESC LIMIT 10;

INSERT INTO receipts VALUES(301, 100, "Store X", 10000);


/* 3. 2�ő}���������R�[�h���폜���Ă������� */
SELECT * FROM receipts ORDER BY id DESC LIMIT 10;

DELETE FROM receipts WHERE id=301;


/* 4. prefectures�e�[�u������Aname���󔒂������́ANULL�̂��̂��폜���Ă������� */
SELECT * FROM prefectures WHERE name="" OR name IS NULL;

DELETE FROM prefectures WHERE name="" OR name IS NULL;


/* 5. customers�e�[�u����id��20�ȏ�50�ȉ��̐l�ɑ΂��ĔN���+1�����f�[�^�ōX�V���Ă�������
(�������ABETWEEN���g������) */
SELECT *, age+1 FROM customers WHERE id BETWEEN 20 AND 50;

UPDATE customers SET age=age+1 WHERE id BETWEEN 20 AND 50;


/* 6. students�e�[�u����class_no��6�̐l���ׂĂɑ΂��āAclass_no��1�`5�̃����_���Ȓl�ōX�V���Ă������� */

SELECT *, CEILING(RAND()*5) FROM students WHERE class_no=6;

UPDATE students SET class_no=CEILING(RAND()*5)  WHERE class_no=6;


SELECT * FROM students;


/* 7. class_no��3�܂���4�̐l��students�e�[�u��������o���܂��B
���o�����l��height��10�����Z���āA���̉��Z�����Sheight�����A
height�̒l����������class_no��1�̐l��students�e�[�u��������o���Ă��������B
(�������AIN, ALL���g������) */

SELECT * FROM students
WHERE height < ALL (SELECT  height+10 FROM students WHERE class_no IN(3, 4))
AND class_no=1;



/* 8. employees�e�[�u����department�J�����ɂ́A�u �c�ƕ� �v�̂悤�Ȍ`�ŕ������̑O��ɋ󔒂������Ă��܂��B
 * ���̋󔒂��������`�Ƀe�[�u�����X�V���Ă������� */

SELECT *, TRIM(department) FROM employees;

UPDATE employees SET department=TRIM(department);




/* 9. employees�e�[�u������salary��5000000�ȏ�̐l��salary��0.9�{���āA5000000�����̐l�́A1.1�{���ĉ������B
(�������A�����_�ȉ��͎l�̌ܓ����܂�) */

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


/* 10. customers�e�[�u����name���u���������q�v�Aage��0�Abirth_day���{�����t�̐l��}�����Ă��������B
�i�������A���t�֐����g�����Ɓj */

SELECT *, CURDATE() FROM customers ORDER BY id DESC;

INSERT INTO customers VALUES(101, "���������q", 0, CURDATE())


/* 11. customers�e�[�u���ɐV���ȃJ�����Ƃ��āA�uname_length INT�v���쐬���܂��B
name_length�J������customers�e�[�u���̊e�s�̖��O�̕������ŃA�b�v�f�[�g���Ă������� */

SELECT * FROM customers;

ALTER TABLE customers ADD name_length INT;


SELECT *, CHAR_LENGTH(name) FROM customers;


UPDATE customers SET name_length=CHAR_LENGTH(name);


/* 12. tests_score�e�[�u���ɐV���ȃJ�����Ƃ��āA�uscore INT�v���쐬���܂��B
score�J�����ɁAtests�e�[�u���̊e�s��test_score_1, test_score_2, test_score_3����A���o����NULL�łȂ��ŏ��̒l�ōX�V���܂��B
�������A���o�����_����900�ȏ�̐l�́A1.2�{���āA�����_�ȉ���؂�̂ĂāA600�ȉ��̐l�́A0.8�{���āA�����_�ȉ���؂�グ�Ă��������B
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
 * 13. employees�e�[�u�����A
 *  department���A�}�[�P�e�B���O�� �A�������A�J�����A�������A�c�ƕ��A�o�����̏��ɂȂ�悤�ɕ��ёւ��Ă��������B
 * 
 */
SELECT * FROM employees
ORDER BY
CASE department
WHEN "�}�[�P�e�B���O��" THEN 1
WHEN "������" THEN 2
WHEN "�J����" THEN 3
WHEN "������" THEN 4
WHEN "�c�ƕ�" THEN 5
WHEN "�o����" THEN 6
END
;
