SELECT DATABASE();

SELECT * FROM users;


SELECT
    *,
    CASE birth_place
       WHEN "���{" THEN "���{�l"
       WHEN "Iraq" THEN "�C���N�l"
       ElSE "�O���l"
    END AS "����"
FROM 
    users
WHERE id>30;


SELECT * FROM prefectures;

SELECT
    name,
    CASE
        WHEN name IN("���쌧", "���Q��", "������", "���m��") THEN "�l��"
        WHEN name IN("���Ɍ�", "���{", "���s�{", "���ꌧ", "�ޗǌ�", "�O�d��", "�a�̎R��") THEN "�ߋE"
        ELSE "���̑�"
    END AS "�n�於"
FROM 
    prefectures;
    
   
-- �v�Z(���邤�N�A4�̗]��==0, 100�̗]��!= 0)
SELECT
   name,
   birth_day,
   CASE
        WHEN DATE_FORMAT(birth_day, "%Y") % 4 = 0 AND DATE_FORMAT(birth_day, "%Y") % 100 <> 0  THEN "���邤�N"
        ELSE "���邤�N�łȂ�"
    END AS "���邤�N��"
FROM users;


SELECT 
  *,
   CASE
       WHEN student_id % 3 = 0 THEN test_score_1
       WHEN student_id % 3 = 1 THEN test_score_2
       WHEN student_id % 3 = 2 THEN test_score_3
    END AS score
FROM tests_score;


-- ORDER BY ��CASE
SELECT *,
CASE
    WHEN name IN("���쌧", "���Q��", "������", "���m��") THEN "�l��"
    WHEN name IN("���Ɍ�", "���{", "���s�{", "���ꌧ", "�ޗǌ�", "�O�d��", "�a�̎R��") THEN "�ߋE"
    ELSE "���̑�" END AS "�n�於"
FROM prefectures
ORDER BY 
CASE
    WHEN name IN("���쌧", "���Q��", "������", "���m��") THEN 0
    WHEN name IN("���Ɍ�", "���{", "���s�{", "���ꌧ", "�ޗǌ�", "�O�d��", "�a�̎R��") THEN 1
    ELSE 2
END;

-- UPDATE + CASE
SELECT * FROM users;

ALTER TABLE users ADD birth_era VARCHAR(2) AFTER birth_day;

UPDATE users
SET birth_era = CASE
    WHEN birth_day < "1989-01-07" THEN "���a"
    WHEN birth_day < "2019-05-01" THEN "����"
    WHEN birth_day >= "2019-05-01" THEN "�ߘa"
    ELSE "�s��"
    END;

   
   SELECT * FROM users;
   

  -- NULL���g���ꍇ
SELECT *,
CASE 
    WHEN name IS NULL THEN "�s��"
    WHEN name IS NOT NULL THEN "NULL�ȊO"
    ElSE ""
    END AS "NULL CHECK"
FROM customers;
  
  
  