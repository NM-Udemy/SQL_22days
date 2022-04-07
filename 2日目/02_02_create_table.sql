USE my_db;

SELECT DATABASE();

# �e�[�u���쐬 
CREATE TABLE users(
    id INT, -- id�J����INT�^
    name VARCHAR(10), -- ���O, �ϒ�������
    age INT,
    phone_number CHAR(13), -- �Œ蒷
    message TEXT
)

# �e�[�u���ꗗ�\��
SHOW TABLES;


# �e�[�u���̒�`�m�F
DESCRIBE users;

# �e�[�u���̍폜
DROP TABLE users;

SHOW TABLES;

# �e�[�u���쐬 (��L�[�t��)
CREATE TABLE users(
    id INT PRIMARY KEY, -- id�J����INT�^
    name VARCHAR(10), -- ���O, �ϒ�������
    age INT,
    phone_number CHAR(13), -- �Œ蒷
    message TEXT
)

DESCRIBE users;
