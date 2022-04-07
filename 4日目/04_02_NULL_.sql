SELECT DATABASE();

DESCRIBE customers;

-- IS NULL ‚Å‚È‚¢‚Ææ‚èo‚¹‚È‚¢
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

SELECT * FROM users WHERE name LIKE "‘º%"; -- ‘O•ûˆê’v

SELECT * FROM users WHERE name LIKE "%˜Y"; -- Œã•ûˆê’v

SELECT * FROM users WHERE name LIKE "%ed%"; -- ’†ŠÔˆê’v

SELECT * FROM prefectures WHERE name LIKE "•Ÿ_%" ORDER BY name; -- _‚Í”CˆÓ‚Ìˆê•¶š

