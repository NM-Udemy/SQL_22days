SELECT DATABASE();

# STUDENTS�e�[�u���̍쐬
CREATE TABLE students(
    id INT PRIMARY KEY,
    name CHAR(10)
);

# CHAR�^�͖����̃X�y�[�X���폜�����
INSERT INTO students VALUES(1, "ABCDEF    ")

SELECT * FROM students;

# CHAR => VARCHAR
ALTER TABLE students MODIFY name VARCHAR(10);

INSERT INTO students VALUES(2, "ABCDEF  ");

SELECT * FROM students;

# name, name�̕����̐���\��
SELECT name, CHAR_LENGTH(name) FROM students;

