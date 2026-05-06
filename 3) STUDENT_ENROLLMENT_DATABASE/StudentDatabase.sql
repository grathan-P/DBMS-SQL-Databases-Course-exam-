-- Consider the following database of student enrollment in courses & books adopted for each course: 

-- STUDENT (regno#: string, name: string, major: string, bdate: date)  
-- COURSE (course #: int, cname: string, dept: string)  
-- ENROLL (regno#: string, course#: int, sem#: int marks: int)  
-- BOOK _ ADOPTION (course#: int, sem#: int, book-ISBN#: int)  
-- TEXT (book-ISBN#: int, book-title: string, publisher: string, author: string)  


------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE STUDENT_DB 
USE STUDENT_DB
------------------------------------------------------------------------------------------------------------------------

-- STUDENT (regno#: string, name: string, major: string, bdate: date)  
CREATE TABLE STUDENT( 
REGNO VARCHAR(10), 
NAME VARCHAR(10), 
MAJOR VARCHAR(10), 
BDATE DATE, 
PRIMARY KEY(REGNO) 
) 

INSERT INTO STUDENT VALUES('101','JOHN','ABC','1990-10-09') 
INSERT INTO STUDENT VALUES('102','JIM','DBC','1890-09-08') 
INSERT INTO STUDENT VALUES('103','JAM','ZBC','1991-10-08') 
INSERT INTO STUDENT VALUES('104','JINNY','JBC','1970-11-07') 
INSERT INTO STUDENT VALUES('105','JEMS','YBC','1995-10-17') 

SELECT * FROM STUDENT 
------------------------------------------------------------------------------------------------------------------------

-- COURSE (course #: int, cname: string, dept: string)  

CREATE TABLE COURSE( 
COURSEID INT, 
CNAME VARCHAR(10), 
DEPT VARCHAR(10), 
PRIMARY KEY(COURSEID) 
) 

INSERT INTO COURSE VALUES(1,'OOP','CS') 
INSERT INTO COURSE VALUES(2,'FEWD','CS') 
INSERT INTO COURSE VALUES(3,'PYTHON','CS') 
INSERT INTO COURSE VALUES(4,'MP','ENC') 
INSERT INTO COURSE VALUES(5,'OS','EEE') 

SELECT * FROM COURSE 
------------------------------------------------------------------------------------------------------------------------

-- ENROLL (regno#: string, course#: int, sem#: int marks: int)  

CREATE TABLE ENROLL( 
REGNO VARCHAR(10), 
COURSEID INT, 
SEM INT, 
MARKS INT, 
PRIMARY KEY(REGNO,COURSEID), 
FOREIGN KEY(REGNO) REFERENCES STUDENT(REGNO) ON DELETE CASCADE ON UPDATE 
CASCADE, 
FOREIGN KEY(COURSEID) REFERENCES COURSE(COURSEID) ON DELETE CASCADE ON 
UPDATE CASCADE 
) 

INSERT INTO ENROLL VALUES('101',1,3,99) 
INSERT INTO ENROLL VALUES('102',1,4,98) 
INSERT INTO ENROLL VALUES('103',2,5,97) 
INSERT INTO ENROLL VALUES('104',3,2,79) 
INSERT INTO ENROLL VALUES('105',5,7,39) 

SELECT * FROM ENROLL
------------------------------------------------------------------------------------------------------------------------

-- TEXT (book-ISBN#: int, book-title: string, publisher: string, author: string) 

CREATE TABLE TEXT( 
BOOKISBN INT, 
TITLE VARCHAR(10), 
PUBLISHER VARCHAR(10), 
AUTHOR VARCHAR(10), 
PRIMARY KEY(BOOKISBN) 
)

INSERT INTO TEXT VALUES(50,'A','TOM','JERRY') 
INSERT INTO TEXT VALUES(51,'C','TOM','MERRY') 
INSERT INTO TEXT VALUES(52,'B','TOM','CHERRY') 
INSERT INTO TEXT VALUES(53,'H','TOM','KHERRY') 
INSERT INTO TEXT VALUES(54,'F','TOM','WHERRY') 
INSERT INTO TEXT VALUES(55,'T','JIM','LHERRY') 
INSERT INTO TEXT VALUES(56,'Z','JAM','QHERRY') 

SELECT * FROM TEXT 
 ------------------------------------------------------------------------------------------------------------------------

-- BOOK _ ADOPTION (course#: int, sem#: int, book-ISBN#: int)  
CREATE TABLE BOOK_ADAPTION( 
COURSEID INT, 
SEM INT, 
BOOKISBN INT, 
PRIMARY KEY(COURSEID,BOOKISBN), 
FOREIGN KEY(COURSEID) REFERENCES COURSE(COURSEID) ON DELETE CASCADE ON 
UPDATE CASCADE, 
FOREIGN KEY(BOOKISBN) REFERENCES TEXT(BOOKISBN) ON DELETE CASCADE ON UPDATE 
CASCADE
) 
 
INSERT INTO BOOK_ADAPTION VALUES(1,2,50) 
INSERT INTO BOOK_ADAPTION VALUES(1,3,51) 
INSERT INTO BOOK_ADAPTION VALUES(1,4,52) 
INSERT INTO BOOK_ADAPTION VALUES(2,5,53) 
INSERT INTO BOOK_ADAPTION VALUES(3,3,54) 
INSERT INTO BOOK_ADAPTION VALUES(4,7,56) 
INSERT INTO BOOK_ADAPTION VALUES(5,7,55) 
 
SELECT * FROM BOOK_ADAPTION 
------------------------------------------------------------------------------------------------------------------------

SELECT * FROM STUDENT  -- STUDENT (regno#: string, name: string, major: string, bdate: date)  
SELECT * FROM COURSE   -- COURSE (course #: int, cname: string, dept: string)  
SELECT * FROM ENROLL  -- ENROLL (regno#: string, course#: int, sem#: int marks: int)  
SELECT * FROM BOOK_ADAPTION  -- BOOK _ ADOPTION (course#: int, sem#: int, book-ISBN#: int)  
SELECT * FROM TEXT  -- TEXT (book-ISBN#: int, book-title: string, publisher: string, author: string) 
 ------------------------------------------------------------------------------------------------------------------------

-- 1. Produce a list of text books (include Course #, Book-ISBN,Book-title) in the alphabetical order for courses offered by the ‘CS’ department that use more than two books.  

SELECT * FROM STUDENT  -- STUDENT (regno#: string, name: string, major: string, bdate: date)  
SELECT * FROM COURSE   -- COURSE (course #: int, cname: string, dept: string)  
SELECT * FROM ENROLL  -- ENROLL (regno#: string, course#: int, sem#: int marks: int)  
SELECT * FROM BOOK_ADAPTION  -- BOOK _ ADOPTION (course#: int, sem#: int, book-ISBN#: int)  
SELECT * FROM TEXT  -- TEXT (book-ISBN#: int, book-title: string, publisher: string, author: string) 

SELECT C.COURSEID AS COURSE,T.BOOKISBN AS BOOKISBN,T.TITLE AS BOOK_TITLE 
FROM COURSE C
JOIN BOOK_ADAPTION B ON C.COURSEID=B.COURSEID
JOIN TEXT T ON T.BOOKISBN=B.BOOKISBN
WHERE C.DEPT='CS'
  AND B.COURSEID IN (
        SELECT COURSEID 
        FROM BOOK_ADAPTION 
        GROUP BY COURSEID 
        HAVING COUNT(distinct BOOKISBN) > 2
    )
ORDER BY T.TITLE 

-- OR

SELECT C.COURSEID AS COURSE,T.BOOKISBN AS BOOKISBN,T.TITLE AS BOOK_TITLE 
FROM COURSE C,BOOK_ADAPTION B,TEXT T 
WHERE C.COURSEID=B.COURSEID AND C.DEPT='CS' AND 
B.COURSEID IN (SELECT COURSEID 
                FROM BOOK_ADAPTION 
                GROUP BY COURSEID 
                HAVING COUNT(BOOKISBN)>2) 
AND B.BOOKISBN=T.BOOKISBN 
ORDER BY T.TITLE 
------------------------------------------------------------------------------------------------------------------------

-- 2. List any department that has all its adopted books published by a specific publisher.  

SELECT * FROM STUDENT  -- STUDENT (regno#: string, name: string, major: string, bdate: date)  
SELECT * FROM COURSE   -- COURSE (course #: int, cname: string, dept: string)  
SELECT * FROM ENROLL  -- ENROLL (regno#: string, course#: int, sem#: int marks: int)  
SELECT * FROM BOOK_ADAPTION  -- BOOK _ ADOPTION (course#: int, sem#: int, book-ISBN#: int)  
SELECT * FROM TEXT  -- TEXT (book-ISBN#: int, book-title: string, publisher: string, author: string) 

SELECT DISTINCT C.DEPT 
FROM COURSE C 
WHERE NOT EXISTS(SELECT B.BOOKISBN 
                 FROM BOOK_ADAPTION B,COURSE C1 
                 WHERE B.COURSEID=C1.COURSEID AND C.DEPT=C1.DEPT 
                 AND B.BOOKISBN NOT IN(SELECT B1.BOOKISBN  
                                        FROM TEXT T,BOOK_ADAPTION B1
                                        WHERE B1.BOOKISBN=T.BOOKISBN AND T.PUBLISHER='TOM')) 
 ------------------------------------------------------------------------------------------------------------------------

-- 3. List the bookISBNs and book titles of the department that has maximum number of students. 

SELECT * FROM STUDENT  -- STUDENT (regno#: string, name: string, major: string, bdate: date)  
SELECT * FROM COURSE   -- COURSE (course #: int, cname: string, dept: string)  
SELECT * FROM ENROLL  -- ENROLL (regno#: string, course#: int, sem#: int marks: int)  
SELECT * FROM BOOK_ADAPTION  -- BOOK _ ADOPTION (course#: int, sem#: int, book-ISBN#: int)  
SELECT * FROM TEXT  -- TEXT (book-ISBN#: int, book-title: string, publisher: string, author: string) 

SELECT T.BOOKISBN,T.TITLE 
FROM COURSE C,BOOK_ADAPTION B,TEXT T 
WHERE C.COURSEID=B.COURSEID AND B.BOOKISBN=T.BOOKISBN  
AND C.DEPT IN(SELECT C.DEPT 
              FROM COURSE C,ENROLL E 
              WHERE C.COURSEID=E.COURSEID 
              GROUP BY C.DEPT 
              HAVING COUNT(E.REGNO)>=ALL(SELECT COUNT(E.REGNO) 
                                       FROM COURSE C,ENROLL E 
                                       WHERE C.COURSEID=E.COURSEID 
                                       GROUP BY C.DEPT))
------------------------------------------------------------------------------------------------------------------------
 
 --Drop tables
DROP TABLE BOOK_ADAPTION 
DROP TABLE TEXT 
DROP TABLE ENROLL 
DROP TABLE COURSE 
DROP TABLE STUDENT
------------------------------------------------------------------------------------------------------------------------
