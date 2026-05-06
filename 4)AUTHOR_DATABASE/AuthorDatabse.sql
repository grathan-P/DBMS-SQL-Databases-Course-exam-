================================================================================
                     AUTHOR DATABASE PROJECT
================================================================================
-- The following tables are maintained by a book dealer.  

-- TABLE SCHEMA:
-- AUTHOR (author-id#: int, name: string, city: string, country: string)  
-- PUBLISHER (publisher-id#: int, name: string, city: string, country: string)  
-- CATALOG (book-id#: int, title: string, author-id: int, publisher-id: int, category-id: int, year: int, price: int)  
-- CATEGORY (category-id#: int, description: string)  
-- ORDERDETAILS (order-no#: int, book-id#: int, quantity: int)  

-- QUERIES TO BE EXECUTED:
-- =======================
-- 1. Find the author of the book which has maximum sales.  
-- 2. Increase the price of the books published by a specific publisher by 10%.  
-- 3. Find the number of orders for the book that has minimum sales.  

================================================================================
                         TABLE 1: AUTHOR
================================================================================

-- AUTHOR (author-id#: int, name: string, city: string, country: string)  
   
CREATE TABLE AUTHOR( 
AUTHORID INT, 
ANAME VARCHAR(10), 
CITY VARCHAR(10), 
COUNTRY VARCHAR(10), 
PRIMARY KEY(AUTHORID) 
) 
 
INSERT INTO AUTHOR VALUES(1,'RON','ABC','XYZ') 
INSERT INTO AUTHOR VALUES(2,'DON','NBC','QYZ') 
INSERT INTO AUTHOR VALUES(3,'CON','MBC','WYZ') 
INSERT INTO AUTHOR VALUES(4,'AON','TBC','YYZ') 
INSERT INTO AUTHOR VALUES(5,'BON','PBC','MYZ') 
 
SELECT * FROM AUTHOR 

================================================================================
                       TABLE 2: PUBLISHER
================================================================================  

CREATE TABLE PUBLISHER( 
PUBID INT, 
PNAME VARCHAR(10), 
CITY VARCHAR(10), 
COUNTRY VARCHAR(10), 
PRIMARY KEY(PUBID) 
) 

INSERT INTO PUBLISHER VALUES(10,'PEGION','ABC','LYZ') 
INSERT INTO PUBLISHER VALUES(20,'TOM','DBC','XKZ') 
INSERT INTO PUBLISHER VALUES(30,'JERRY','KBC','LYZ') 
INSERT INTO PUBLISHER VALUES(40,'PEACOCK','KBC','XYG') 
INSERT INTO PUBLISHER VALUES(50,'DUCK','AJC','MYZ') 

SELECT * FROM PUBLISHER 

================================================================================
                        TABLE 3: CATEGORY
================================================================================

-- CATEGORY (category-id#: int, description: string)  

CREATE TABLE CATEGORY 
( 
CATID INT, 
DESCR VARCHAR(10), 
PRIMARY KEY(CATID) 
) 

INSERT INTO CATEGORY VALUES(5,'ABC') 
INSERT INTO CATEGORY VALUES(6,'YBC') 
INSERT INTO CATEGORY VALUES(7,'KBC') 

SELECT * FROM CATEGORY 

================================================================================
                        TABLE 4: CATALOG
-- CATALOG (book-id#: int, title: string, author-id: int, publisher-id: int, category-id: int, year: int, price: int)

================================================================================

CREATE TABLE CATALOG( 
BOOKID INT, 
TITLE VARCHAR(10), 
AUTHORID INT, 
PUBID INT, 
CATID INT, 
YEAR INT, 
PRICE INT, 
PRIMARY KEY(BOOKID), 
FOREIGN KEY(AUTHORID) REFERENCES AUTHOR(AUTHORID) ON DELETE CASCADE ON 
UPDATE CASCADE, 
FOREIGN KEY(PUBID) REFERENCES PUBLISHER(PUBID) ON DELETE CASCADE ON UPDATE 
CASCADE, 
FOREIGN KEY(CATID) REFERENCES CATEGORY(CATID) ON DELETE CASCADE ON UPDATE 
CASCADE 
) 

INSERT INTO CATALOG VALUES(101,'JACK',1,10,5,2004,6000) 
INSERT INTO CATALOG VALUES(102,'HORROR',2,30,6,2014,9000) 
INSERT INTO CATALOG VALUES(103,'COMEDY',1,20,7,2008,3000) 
INSERT INTO CATALOG VALUES(104,'DISNEY',4,10,5,2001,5000) 
INSERT INTO CATALOG VALUES(105,'CARTOON',2,30,7,2024,2000) 

SELECT * FROM CATALOG 

================================================================================
                   TABLE 5: ORDERDETAILS (Junction Table)
================================================================================ 

CREATE TABLE ORDERDETAILS( 
ORDERNO INT, 
BOOKID INT, 
QTY INT, 
PRIMARY KEY(ORDERNO,BOOKID), 
FOREIGN KEY(BOOKID) REFERENCES CATALOG(BOOKID) ON DELETE CASCADE ON UPDATE 
CASCADE 
) 

INSERT INTO ORDERDETAILS VALUES(200,101,45) 
INSERT INTO ORDERDETAILS VALUES(201,102,46) 
INSERT INTO ORDERDETAILS VALUES(202,101,10) 
INSERT INTO ORDERDETAILS VALUES(203,104,5) 
INSERT INTO ORDERDETAILS VALUES(204,104,1) 

SELECT * FROM ORDERDETAILS

================================================================================
                          QUERY EXECUTION
================================================================================

select * from AUTHOR;  -- AUTHOR (author-id#: int, name: string, city: string, country: string)  
select * from PUBLISHER;  -- PUBLISHER (publisher-id#: int, name: string, city: string, country: string)  
select * from CATALOG;  -- CATALOG (book-id#: int, title: string, author-id: int, publisher-id: int, category-id: int, year: int, price: int)  
select * from CATEGORY;  -- CATEGORY (category-id#: int, description: string)  
select * from ORDERDETAILS;  -- ORDERDETAILS (order-no#: int, book-id#: int, quantity: int)  

-- ============================================================================
-- QUERY 1: Find the author of the book which has maximum sales.  
-- ============================================================================
-- Purpose: Identify the author of the book with the highest total sales quantity
-- Tables Used: AUTHOR, CATALOG, ORDERDETAILS
-- Expected Output: Author ID, Author Name, Book ID, Total Sales Quantity

select * from AUTHOR;  -- AUTHOR (author-id#: int, name: string, city: string, country: string)  
select * from CATALOG;  -- CATALOG (book-id#: int, title: string, author-id: int, publisher-id: int, category-id: int, year: int, price: int)  
select * from ORDERDETAILS;  -- ORDERDETAILS (order-no#: int, book-id#: int, quantity: int)  

SELECT A.AUTHORID,A.ANAME,C.BOOKID,SUM(O.QTY) as Sales
FROM AUTHOR A,CATALOG C,ORDERDETAILS O 
WHERE A.AUTHORID=C.AUTHORID AND C.BOOKID=O.BOOKID 
GROUP BY A.AUTHORID,A.ANAME,C.BOOKID 
HAVING SUM(O.QTY)>=ALL(
                        SELECT SUM(QTY) 
                        FROM ORDERDETAILS 
                        GROUP BY BOOKID
                        )

-- ============================================================================
-- QUERY 2: Increase the price of the books published by a specific publisher by 10%.  
-- ============================================================================
-- Purpose: Update book prices by 10% for books published by a specific publisher
-- Tables Used: CATALOG, PUBLISHER
-- Action: SET PRICE = 1.1 * PRICE for books where PUBID matches target publisher

select * from CATALOG;  -- CATALOG (book-id#: int, title: string, author-id: int, publisher-id: int, category-id: int, year: int, price: int)  
select * from PUBLISHER;  -- PUBLISHER (publisher-id#: int, name: string, city: string, country: string)  

UPDATE CATALOG 
SET PRICE=1.1*PRICE 
WHERE PUBID IN (
                 SELECT PUBID 
                 FROM PUBLISHER 
                 WHERE PNAME='PEGION'
                 ) 

-- OR

UPDATE CATALOG 
SET PRICE=1.1*PRICE 
WHERE PUBID='10'

SELECT*FROM CATALOG 

-- ============================================================================
-- QUERY 3: Find the number of orders for the book that has minimum sales. 
-- ============================================================================
-- Purpose: Count the number of orders for the book with lowest total sales quantity
-- Tables Used: ORDERDETAILS, CATALOG
-- Expected Output: Book ID, Number of Orders

select * from ORDERDETAILS;  -- ORDERDETAILS (order-no#: int, book-id#: int, quantity: int)  
select * from CATALOG;  -- CATALOG (book-id#: int, title: string, author-id: int, publisher-id: int, category-id: int, year: int, price: int)  

SELECT O.BOOKID,COUNT(*) as number_of_order
FROM ORDERDETAILS O 
GROUP BY O.BOOKID 
HAVING SUM(O.QTY)<=ALL(
                       SELECT SUM(QTY) 
                       FROM ORDERDETAILS 
                       GROUP BY BOOKID
                       ) 

================================================================================
                        CLEANUP SECTION
================================================================================
-- The following statements drop all tables from the database

-- DROP TABLE ORDERDETAILS
-- DROP TABLE CATALOG
-- DROP TABLE CATEGORY
-- DROP TABLE PUBLISHER
-- DROP TABLE AUTHOR

================================================================================
                          END OF SCRIPT
================================================================================ 

