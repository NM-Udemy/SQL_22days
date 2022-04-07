SELECT DATABASE();

# �e�[�u���ꗗ
SHOW TABLES;

# �e�[�u�����ύX(RENAME TO)
ALTER TABLE users RENAME TO users_table;

DESCRIBE users_table;
# �J�����̍폜(DROP COLUMN)
ALTER TABLE users_table DROP COLUMN message;

# �J�����̒ǉ�(ADD)
ALTER TABLE users_table 
ADD post_code CHAR(8);

ALTER TABLE users_table 
ADD gender CHAR(1) AFTER age;

# ��ԍŏ��̃J����
ALTER TABLE users_table 
ADD new_id INT FIRST;

ALTER TABLE users_table DROP COLUMN new_id;

# �J�����̒�`�ύX
ALTER TABLE users_table MODIFY name VARCHAR(50);

# �J�������̕ύX
ALTER TABLE users_table CHANGE COLUMN name ���O VARCHAR(50);

ALTER TABLE users_table CHANGE COLUMN gender gender CHAR(1) AFTER post_code;

DESCRIBE users_table;

# ��L�[�폜
ALTER TABLE users_table DROP PRIMARY KEY;