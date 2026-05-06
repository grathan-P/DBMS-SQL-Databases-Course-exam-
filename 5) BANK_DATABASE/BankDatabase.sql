================================================================================
                        BANK DATABASE PROJECT
================================================================================
-- Consider the following database for a banking enterprise.  

-- TABLE SCHEMA:
-- BRANCH (branch-name#: string, branch-city: string, assets: real)  
-- ACCOUNT (accno#: int, branch-name: string, balance: real) 
-- DEPOSITOR (customer-name#: string, accno#: int) 
-- CUSTOMER (customer-name#: string, customer-street: string, customer-city: string)  
-- LOAN (loan-number#: int, branch-name: string, amount: real)  
-- BORROWER (customer-name#: string, loan-number#: int)  

-- QUERIES TO BE EXECUTED:
-- =======================
-- 1. Find all customers who have at least 2 accounts at all branches located in a specific city.  
-- 2. Find all customers who have accounts in at least 1 branch located in all cities.  
-- 3. Find all customers who have accounts in at least 2 branches located in a specific city.  

================================================================================
                           DATABASE SETUP
================================================================================

CREATE DATABASE BANKING_db
USE BANKING_db 

================================================================================
                         TABLE 1: BRANCH
================================================================================

-- BRANCH (branch-name#: string, branch-city: string, assets: real)  

CREATE TABLE BRANCH( 
BNAME VARCHAR(10), 
BCITY VARCHAR(10), 
ASSESTS REAL, 
PRIMARY KEY(BNAME) 
) 

INSERT INTO BRANCH VALUES('SYNDICATE','MANIPAL',2.5) 
INSERT INTO BRANCH VALUES('BHARAT','MANIPAL',2.5) 
INSERT INTO BRANCH VALUES('JANATA','MANIPAL',2.5) 
INSERT INTO BRANCH VALUES('TATA','UDUPI',2.5) 
INSERT INTO BRANCH VALUES('SAI','UDUPI',2.5) 
INSERT INTO BRANCH VALUES('CANARA','KUNDAPURA',2.5) 

SELECT * FROM BRANCH 

================================================================================
                        TABLE 2: ACCOUNT
================================================================================

-- ACCOUNT (accno#: int, branch-name: string, balance: real) 

CREATE TABLE ACCOUNT( 
ACCNO INT, 
BNAME VARCHAR(10), 
BALANCE REAL, 
PRIMARY KEY(ACCNO), 
FOREIGN KEY(BNAME) REFERENCES BRANCH(BNAME) ON DELETE CASCADE ON UPDATE 
CASCADE 
) 

INSERT INTO ACCOUNT VALUES(1,'TATA',2.5) 
INSERT INTO ACCOUNT VALUES(2,'TATA',2.5) 
INSERT INTO ACCOUNT VALUES(3,'SAI',2.5) 
INSERT INTO ACCOUNT VALUES(4,'SAI',2.5) 
INSERT INTO ACCOUNT VALUES(5,'SYNDICATE',2.5) 
INSERT INTO ACCOUNT VALUES(6,'BHARAT',2.5) 
INSERT INTO ACCOUNT VALUES(7,'JANATA',2.5) 
INSERT INTO ACCOUNT VALUES(8,'TATA',2.5) 
INSERT INTO ACCOUNT VALUES(9,'SAI',2.5) 
INSERT INTO ACCOUNT VALUES(10,'CANARA',2.5) 
INSERT INTO ACCOUNT VALUES(11,'SYNDICATE',2.5) 
INSERT INTO ACCOUNT VALUES(12,'CANARA',2.5) 

SELECT * FROM ACCOUNT

================================================================================
                        TABLE 3: CUSTOMER
================================================================================

-- CUSTOMER (customer-name#: string, customer-street: string, customer-city: string)  

CREATE TABLE CUSTOMER( 
CNAME VARCHAR(10), 
CSTREET VARCHAR(10), 
CCITY VARCHAR(10), 
PRIMARY KEY(CNAME) 
) 

INSERT INTO CUSTOMER VALUES('SOHAN','S1','C1') 
INSERT INTO CUSTOMER VALUES('ROHAN','S2','C2') 
INSERT INTO CUSTOMER VALUES('MOHAN','S3','C3') 
INSERT INTO CUSTOMER VALUES('LOHAN','S4','C4') 

SELECT * FROM CUSTOMER 

================================================================================
                    TABLE 4: DEPOSITOR (Junction Table)
================================================================================

-- DEPOSITOR (customer-name#: string, accno#: int) 

CREATE TABLE DEPOSITOR( 
CNAME VARCHAR(10), 
ACCNO INT, 
PRIMARY KEY(CNAME,ACCNO), 
FOREIGN KEY(CNAME) REFERENCES CUSTOMER(CNAME) ON DELETE CASCADE ON UPDATE 
CASCADE, 
FOREIGN KEY(ACCNO) REFERENCES ACCOUNT(ACCNO) ON DELETE CASCADE ON UPDATE 
CASCADE 
) 

INSERT INTO DEPOSITOR VALUES('SOHAN',1) 
INSERT INTO DEPOSITOR VALUES('SOHAN',2) 
INSERT INTO DEPOSITOR VALUES('SOHAN',3) 
INSERT INTO DEPOSITOR VALUES('SOHAN',4)
INSERT INTO DEPOSITOR VALUES('ROHAN',5) 
INSERT INTO DEPOSITOR VALUES('ROHAN',6) 
INSERT INTO DEPOSITOR VALUES('ROHAN',7) 
INSERT INTO DEPOSITOR VALUES('ROHAN',8) 
INSERT INTO DEPOSITOR VALUES('ROHAN',9) 
INSERT INTO DEPOSITOR VALUES('ROHAN',10) 
INSERT INTO DEPOSITOR VALUES('MOHAN',11) 
INSERT INTO DEPOSITOR VALUES('MOHAN',12) 
 
SELECT * FROM DEPOSITOR 

================================================================================
                          TABLE 5: LOAN
================================================================================

-- LOAN (loan-number#: int, branch-name: string, amount: real)  

CREATE TABLE LOAN ( 
LNO INT, 
BNAME VARCHAR(10), 
AMOUNT REAL, 
PRIMARY KEY(LNO), 
FOREIGN KEY(BNAME) REFERENCES BRANCH (BNAME) ON DELETE CASCADE ON UPDATE 
CASCADE 
) 
 
INSERT INTO LOAN VALUES(10,'CANARA',2.3) 
INSERT INTO LOAN VALUES(20,'TATA',2.3) 

SELECT * FROM LOAN 

================================================================================
                    TABLE 6: BORROWER (Junction Table)
================================================================================

-- BORROWER (customer-name#: string, loan-number#: int)    
CREATE TABLE BORROWER( 
CNAME VARCHAR(10), 
LNO INT, 
PRIMARY KEY(CNAME,LNO), 
FOREIGN KEY(CNAME) REFERENCES CUSTOMER(CNAME) ON DELETE CASCADE ON UPDATE 
CASCADE, 
FOREIGN KEY(LNO) REFERENCES LOAN(LNO) ON DELETE CASCADE ON UPDATE CASCADE 
) 
 
INSERT INTO BORROWER VALUES('SOHAN',10) 
INSERT INTO BORROWER VALUES('ROHAN',20) 
 
SELECT * FROM BORROWER 

================================================================================
                          QUERY EXECUTION
================================================================================

select * from BRANCH -- BRANCH (branch-name#: string, branch-city: string, assets: real)  
select * from ACCOUNT -- ACCOUNT (accno#: int, branch-name: string, balance: real) 
select * from DEPOSITOR -- DEPOSITOR (customer-name#: string, accno#: int) 
select * from CUSTOMER -- CUSTOMER (customer-name#: string, customer-street: string, customer-city: string)  
select * from LOAN -- LOAN (loan-number#: int, branch-name: string, amount: real)  
select * from BORROWER -- BORROWER (customer-name#: string, loan-number#: int)  

-- ============================================================================
-- QUERY 1: Customers with at least 2 accounts at all branches in specific city
-- ============================================================================
-- Purpose: Find customers having minimum 2 accounts across all branches in a given city
-- Tables Used: BRANCH, ACCOUNT, DEPOSITOR, CUSTOMER
-- Expected Output: Customer names

select * from BRANCH -- BRANCH (branch-name#: string, branch-city: string, assets: real)  
select * from ACCOUNT -- ACCOUNT (accno#: int, branch-name: string, balance: real) 
select * from DEPOSITOR -- DEPOSITOR (customer-name#: string, accno#: int) 
select * from CUSTOMER -- CUSTOMER (customer-name#: string, customer-street: string, customer-city: string)  

SELECT C.CNAME  
FROM CUSTOMER C 
WHERE NOT EXISTS(SELECT B.BNAME  
                 FROM BRANCH B 
                 WHERE B.BCITY='UDUPI' 
                 AND B.BNAME NOT IN( SELECT A.BNAME 
                                     FROM ACCOUNT A, DEPOSITOR D 
                                     WHERE A.ACCNO=D.ACCNO 
                                     AND A.BNAME=B.BNAME 
                                     AND D.CNAME=C.CNAME 
                                     GROUP BY A.BNAME 
                                     HAVING COUNT(A.BNAME)>=2)) 

-- ============================================================================
-- QUERY 2: Customers with accounts in at least 1 branch in all cities
-- ============================================================================
-- Purpose: Find customers having accounts in branches located in every city
-- Tables Used: BRANCH, ACCOUNT, DEPOSITOR, CUSTOMER
-- Expected Output: Customer names

select * from BRANCH -- BRANCH (branch-name#: string, branch-city: string, assets: real)  
select * from ACCOUNT -- ACCOUNT (accno#: int, branch-name: string, balance: real) 
select * from DEPOSITOR -- DEPOSITOR (customer-name#: string, accno#: int) 
select * from CUSTOMER -- CUSTOMER (customer-name#: string, customer-street: string, customer-city: string)  

SELECT C1.CNAME 
FROM CUSTOMER C1 
WHERE NOT EXISTS( SELECT B1.BCITY 
                   FROM BRANCH B1 
                   WHERE B1.BCITY NOT IN( SELECT B.BCITY 
                                          FROM ACCOUNT A,DEPOSITOR D 
                                          WHERE A.BNAME=B.BNAME 
                                          AND A.ACCNO=D.ACCNO 
                                          AND D.CNAME=C1.CNAME))

-- ============================================================================
-- QUERY 3: Customers with accounts in at least 2 branches in specific city
-- ============================================================================
-- Purpose: Find customers having accounts in minimum 2 branches within a given city
-- Tables Used: BRANCH, ACCOUNT, DEPOSITOR, CUSTOMER
-- Expected Output: Customer names

select * from BRANCH -- BRANCH (branch-name#: string, branch-city: string, assets: real)  
select * from ACCOUNT -- ACCOUNT (accno#: int, branch-name: string, balance: real) 
select * from DEPOSITOR -- DEPOSITOR (customer-name#: string, accno#: int) 
select * from CUSTOMER -- CUSTOMER (customer-name#: string, customer-street: string, customer-city: string)  

SELECT C1.CNAME 
FROM CUSTOMER C1 
WHERE EXISTS( SELECT COUNT(DISTINCT B.BNAME) 
              FROM BRANCH B,ACCOUNT A, DEPOSITOR D 
              WHERE B.BNAME=A.BNAME 
              AND A.ACCNO=D.ACCNO 
              AND D.CNAME=C1.CNAME 
              AND B.BCITY='MANIPAL' 
              GROUP BY B.BCITY 
              HAVING COUNT(DISTINCT B.BNAME)>=2) 

================================================================================
                        CLEANUP SECTION
================================================================================
-- The following statements drop all tables from the database

-- DROP TABLE BORROWER
-- DROP TABLE LOAN
-- DROP TABLE DEPOSITOR
-- DROP TABLE ACCOUNT
-- DROP TABLE CUSTOMER
-- DROP TABLE BRANCH

================================================================================
                          END OF SCRIPT
================================================================================
