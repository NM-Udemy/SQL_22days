SHOW TABLES;

# �S���R�[�h�A�S�J����
SELECT * FROM people;

# �J�����ꕔ
SELECT name, id, birth_day, name FROM people;

SELECT id AS "�ԍ�", name AS "���O" FROM people;

# WHERE��
SELECT * FROM people WHERE name="Jiro";


# UPDATE��
UPDATE people SET birth_day="1900-01-01", name="";

SELECT * FROM people;

# UPDATE where 
UPDATE people SET name="Taro", birth_day="2000-01-01" WHERE id=3;

UPDATE people SET name="Jiro", birth_day="2000-01-01" WHERE id>4;


# DELETE: ���R�[�h�폜
DELETE FROM people WHERE id>4;


DELETE FROM people;

