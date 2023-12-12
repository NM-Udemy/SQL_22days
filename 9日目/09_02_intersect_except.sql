USE day_4_9_db;

-- INTERSECT: 重複を表示
SELECT * FROM new_students
INTERSECT
SELECT * FROM students
;
/*
1	今野 耕介	170	66	6
2	根本 仁美	154	71	1
3	伊東 元久	150	78	2
6	荒井 鋭充	153	81	6
9	金田 美津江	150	77	6
10	藤井 志奈	167	74	6
20	大久保 武士	170	66	6
21	金城 兵吉	176	79	3
*/

-- EXCEPT: new_studentsに存在して、studentsに存在しない
SELECT * FROM new_students
EXCEPT
SELECT * FROM students;


-- EXCEPT: studentsに存在して、new_studentsに存在しない
SELECT * FROM students
EXCEPT
SELECT * FROM new_students;

-- どちらに存在
(SELECT * FROM new_students
EXCEPT
SELECT * FROM students)
UNION ALL
(SELECT * FROM students
EXCEPT
SELECT * FROM new_students)
ORDER BY id;

SELECT id,name FROM students WHERE id<10
INTERSECT
SELECT id,name FROM new_students WHERE id<10;
