================================================================================
                         INSURANCE DATABASE PROJECT
================================================================================
-- Consider the Insurance database given below.  

-- TABLE SCHEMA:
-- PERSON (driver-id #: String, name: string, address: string)  
-- CAR (regno#: string, model: string, year: int)  
-- ACCIDENT (report-number#: int, accd-date: date, location: string)  
-- OWNS (driver-id #: string, regno#: string)  
-- PARTICIPATED (driver-id#: string, Regno#: string, report-number#: int, damage amount: int)  

-- QUERIES TO BE EXECUTED:
-- ========================
-- 1. Find the total number of people who owned cars that were involved in accidents in 1989.  
-- 2. Find the number of accidents in which the cars belonging to “John Smith” were involved.  
-- 3. Update the damage amount for the car with reg number “KA-12” in the accident with report number “1” to $3000 


================================================================================
                           DATABASE SETUP
================================================================================

CREATE DATABASE INSURANCE;
USE INSURANCE;

================================================================================
                         TABLE 1: PERSON
================================================================================
-- PERSON (driver-id #: String, name: string, address: string)  

CREATE TABLE PERSON( 
DRIVERID VARCHAR(10), 
NAME VARCHAR(10), 
ADDRESS VARCHAR(10), 
PRIMARY KEY(DRIVERID) 
) 

INSERT INTO PERSON VALUES('1','A','UDUPI') 
INSERT INTO PERSON VALUES('2','B','KARKALA') 
INSERT INTO PERSON VALUES('3','JOHN SMITH','KUNDAPURA') 
INSERT INTO PERSON VALUES('4','D','UDUPI') 
INSERT INTO PERSON VALUES('5','E','SALVADY') 

SELECT * FROM PERSON;

================================================================================
                           TABLE 2: CAR
================================================================================
-- CAR (regno#: string, model: string, year: int)

CREATE TABLE CAR( 
REGNO VARCHAR(10), 
MODEL VARCHAR(10), 
YEAR INT, 
PRIMARY KEY(REGNO) 
) 

INSERT INTO CAR VALUES('KA-11','SWIFT',2004) 
INSERT INTO CAR VALUES('KA-12','SANTRO',1980) 
INSERT INTO CAR VALUES('KA-13','RITZ',1999) 
INSERT INTO CAR VALUES('KA-14','BREZZA',2009) 
INSERT INTO CAR VALUES('KA-15','VENUE',2000) 

SELECT * FROM CAR;

================================================================================
                        TABLE 3: ACCIDENT
================================================================================
-- ACCIDENT (report-number#: int, accd-date: date, location: string)

CREATE TABLE ACCIDENT( 
REPORTNO INT, 
ACCDATE DATE, 
LOCATION VARCHAR(10), 
PRIMARY KEY(REPORTNO) 
) 

INSERT INTO ACCIDENT VALUES(1,'1989-01-19','UDUPI') 
INSERT INTO ACCIDENT VALUES(2,'1999-01-19','KARKALA') 
INSERT INTO ACCIDENT VALUES(3,'1979-03-19','KUNDAPURA') 
INSERT INTO ACCIDENT VALUES(4,'1989-05-19','UDUPI') 
INSERT INTO ACCIDENT VALUES(5,'1989-01-25','GADAG') 

SELECT * FROM ACCIDENT;

================================================================================
                    TABLE 4: OWNS (Junction Table)
================================================================================
-- OWNS (driver-id #: string, regno#: string)

CREATE TABLE OWNS( 
DRIVERID VARCHAR(10), 
REGNO VARCHAR(10), 
PRIMARY KEY(DRIVERID,REGNO), 
FOREIGN KEY(DRIVERID) REFERENCES PERSON(DRIVERID) ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY(REGNO) REFERENCES CAR(REGNO) ON DELETE CASCADE ON UPDATE CASCADE 
) 

INSERT INTO OWNS VALUES('1','KA-11') 
INSERT INTO OWNS VALUES('2','KA-12') 
INSERT INTO OWNS VALUES('1','KA-13') 
INSERT INTO OWNS VALUES('3','KA-12') 
INSERT INTO OWNS VALUES('4','KA-15') 

SELECT * FROM OWNS;

================================================================================
              TABLE 5: PARTICIPATED (Junction Table)
================================================================================
-- PARTICIPATED (driver-id#: string, Regno#: string, report-number#: int, damage amount: int)

CREATE TABLE PARTICIPATED( 
DRIVERID VARCHAR(10), 
REGNO VARCHAR(10), 
REPORTNO INT, 
DMGAMT INT, 
PRIMARY KEY(DRIVERID,REGNO,REPORTNO), 
FOREIGN KEY(DRIVERID) REFERENCES PERSON(DRIVERID) ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY(REGNO) REFERENCES CAR(REGNO) ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY(REPORTNO) REFERENCES ACCIDENT(REPORTNO) ON DELETE CASCADE ON UPDATE CASCADE 
) 

INSERT INTO PARTICIPATED VALUES('1','KA-12',1,2000) 
INSERT INTO PARTICIPATED VALUES('2','KA-11',2,1000) 
INSERT INTO PARTICIPATED VALUES('3','KA-12',1,9000) 
INSERT INTO PARTICIPATED VALUES('3','KA-14',4,2000) 
INSERT INTO PARTICIPATED VALUES('1','KA-11',5,8000) 

SELECT * FROM PARTICIPATED;

================================================================================
                          QUERY EXECUTION
================================================================================

-- ============================================================================
-- QUERY 1: Find total number of people who owned cars involved in accidents in 1989
-- ============================================================================
-- Purpose: Count distinct car owners whose vehicles participated in accidents during 1989
-- Tables Used: ACCIDENT, PARTICIPATED
-- Expected Output: Single integer value representing count of distinct drivers

SELECT * FROM PERSON; -- PERSON (driver-id #: String, name: string, address: string)  
SELECT * FROM CAR;    -- CAR (regno#: string, model: string, year: int)  
SELECT * FROM ACCIDENT;  -- ACCIDENT (report-number#: int, accd-date: date, location: string) 
SELECT * FROM OWNS;  -- OWNS (driver-id #: string, regno#: string)  
SELECT * FROM PARTICIPATED;  -- PARTICIPATED (driver-id#: string, Regno#: string, report-number#: int, damage amount: int)  

select count (distinct P.driverid) as car_owner
from ACCIDENT A, PARTICIPATED P 
where A.reportno = P.reportno
and year(A.accdate) = '1989';

-- ============================================================================
-- QUERY 2: Find number of accidents involving cars belonging to "John Smith"
-- ============================================================================
-- Purpose: Count total accident participations for a specific driver (John Smith)
-- Tables Used: PARTICIPATED, PERSON
-- Expected Output: Single integer value representing count of accidents

SELECT * FROM PERSON; -- PERSON (driver-id #: String, name: string, address: string)  
SELECT * FROM CAR;    -- CAR (regno#: string, model: string, year: int)  
SELECT * FROM ACCIDENT;  -- ACCIDENT (report-number#: int, accd-date: date, location: string) 
SELECT * FROM OWNS;  -- OWNS (driver-id #: string, regno#: string)  
SELECT * FROM PARTICIPATED;  -- PARTICIPATED (driver-id#: string, Regno#: string, report-number#: int, damage amount: int)  

select count(P.driverid) as number_of_accident
from PARTICIPATED p, PERSON ps
where ps.driverid=p.driverid and ps.name='john smith';

-- ============================================================================
-- QUERY 3: Update damage amount for car "KA-12" in accident report "1" to $3000
-- ============================================================================
-- Purpose: Update damage claim amount for a specific car-accident combination
-- Table Modified: PARTICIPATED
-- WHERE Condition: REGNO='KA-12' AND REPORTNO=1
-- Action: Set DMGAMT to 3000

SELECT * FROM PERSON; -- PERSON (driver-id #: String, name: string, address: string)  
SELECT * FROM CAR;    -- CAR (regno#: string, model: string, year: int)  
SELECT * FROM ACCIDENT;  -- ACCIDENT (report-number#: int, accd-date: date, location: string) 
SELECT * FROM OWNS;  -- OWNS (driver-id #: string, regno#: string)  
SELECT * FROM PARTICIPATED;  -- PARTICIPATED (driver-id#: string, Regno#: string, report-number#: int, damage amount: int)  

UPDATE PARTICIPATED 
SET DAMAGEAMT=3000 
WHERE REGNO='KA-12' AND REPORTNO=1  

SELECT * FROM PARTICIPATED;

================================================================================
                        CLEANUP SECTION
================================================================================
-- The following statements drop all tables from the database

DROP TABLE PARTICIPATED 
DROP TABLE OWNS 
DROP TABLE ACCIDENT 
DROP TABLE CAR 
DROP TABLE PERSON 

================================================================================
                          END OF SCRIPT
================================================================================
