-- IN + NULL
SELECT * FROM customers WHERE name IS NULL;
SELECT * FROM customers WHERE name IN ("�͖� ���T", "��c �G�Y") OR name IS NULL;


-- NOT IN

SELECT * FROM customers WHERE name NOT IN ("�͖� ���T", "��c �G�Y", NULL);

SELECT * FROM customers WHERE name NOT IN ("�͖� ���T", "��c �G�Y") AND name IS NOT NULL;


-- NOT IN �� name != "�͖� ���T" name != "��c �G�Y" name != NULL

-- ALL
-- customers�e�[�u������id<10�̐l�̒a���������Â��a�����̐l��users������o��SQL
SELECT * FROM users WHERE birth_day <= ALL(SELECT birth_day FROM customers WHERE id < 10 AND birth_day IS NOT NULL)

-- ALL, IN�̏ꍇ��NULL�ɂ͋C��t���܂��傤


