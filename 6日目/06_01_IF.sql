USE day_4_9_db;

SELECT DATABASE();

SHOW TABLES;

-- IF(������, �^�̒l, �U�̒l)
SELECT IF(10 > 20, "A", "B");

SELECT * FROM users;

SELECT *, IF(birth_place="���{", "���{�l", "���̑�") AS "����" FROM users;


SELECT name, age, IF(age < 20, "�����N", "���l") FROM users;

SELECT * FROM students;

SELECT *, IF(class_no=6 AND height > 170, "6�g��170cm�ȏ�̐l", "���̑�") FROM students;

SELECT * FROM users;


SELECT name, IF(name LIKE "%�c%", "���O�ɓc���܂�", "���̑�") AS name_check FROM users;


