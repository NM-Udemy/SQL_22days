SELECT DATABASE();

DESCRIBE customers;

-- IS NULL �łȂ��Ǝ��o���Ȃ�
SELECT * FROM customers WHERE name IS NULL;

SELECT NULL=NULL;
SELECT NULL IS NULL;

-- IS NOT NULL 
SELECT * FROM customers WHERE name IS NOT NULL;


SELECT * FROM prefectures;


SELECT * FROM prefectures WHERE name IS NULL;

SELECT * FROM prefectures WHERE name = '';



-- BETWEEN, NOT BETWEEN
SELECT * FROM users WHERE age NOT BETWEEN 5 AND 10;

-- LIKE, NOT LIKE 

SELECT * FROM users WHERE name LIKE "��%"; -- �O����v

SELECT * FROM users WHERE name LIKE "%�Y"; -- �����v

SELECT * FROM users WHERE name LIKE "%ed%"; -- ���Ԉ�v

SELECT * FROM prefectures WHERE name LIKE "��_%" ORDER BY name; -- _�͔C�ӂ̈ꕶ��

