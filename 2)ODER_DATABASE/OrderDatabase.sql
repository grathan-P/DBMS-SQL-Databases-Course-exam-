================================================================================
                     ORDER DATABASE PROJECT
================================================================================
-- Consider the following relations for an order processing database application in a company.  

-- TABLE SCHEMA:
-- CUSTOMER (cust #: int, cname: string, city: string) 
-- ORDER (order #: int, odate: date, cust : int, ord-Amt: int) 
-- ORDER–ITEM (order #: int, item #: int, qty: int) 
-- ITEM (item #: int, unit price: int)  
-- SHIPMENT (order #: int, warehouse#: int, ship-date: date)  
-- WAREHOUSE (warehouse #: int, city: string)  

-- QUERIES TO BE EXECUTED:
-- =======================
-- 1. Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total numbers of orders by the customer and the last column is the average order amount for that customer.
-- 2. For each item that has more than two orders, list the item, number of orders that are shipped from at least two warehouses and total quantity of items shipped. 
-- 3. List the customers who have ordered for every item that the company produces 

================================================================================
                           DATABASE SETUP
================================================================================

-- create database
create database order_db

-- use dtatabase
use order_db

================================================================================
                         TABLE 1: CUSTOMER
================================================================================

-- CUSTOMER (cust #: int, cname: string, city: string) 
CREATE TABLE CUSTOMER( 
CUSTID INT, 
CNAME VARCHAR(10), 
CITY VARCHAR(10), 
PRIMARY KEY(CUSTID) 
)

INSERT INTO CUSTOMER VALUES (1,'TOM','UDUPI') 
INSERT INTO CUSTOMER VALUES (2,'RAM','BNGLR') 
INSERT INTO CUSTOMER VALUES (3,'SEETHA','MNGLR') 
INSERT INTO CUSTOMER VALUES (4,'JIM','HUBLI') 
INSERT INTO CUSTOMER VALUES (5,'JOHN','GADAG') 

SELECT * FROM CUSTOMER 

================================================================================
                         TABLE 2: C_ORDER
================================================================================

-- ORDER (order #: int, odate: date, cust : int, ord-Amt: int) 

CREATE TABLE C_ORDER( 
ORDERID INT, 
ODATE DATE, 
CUSTID INT, 
ORDAMT INT, 
PRIMARY KEY(ORDERID), 
FOREIGN KEY(CUSTID) REFERENCES CUSTOMER(CUSTID) ON DELETE CASCADE ON UPDATE 
CASCADE 
) 

INSERT INTO C_ORDER VALUES(101,'2020-11-10',1,NULL) 
INSERT INTO C_ORDER VALUES(102,'2020-12-10',1,NULL) 
INSERT INTO C_ORDER VALUES(103,'2004-11-10',2,NULL) 
INSERT INTO C_ORDER VALUES(104,'2020-11-10',3,NULL) 
INSERT INTO C_ORDER VALUES(105,'2004-11-10',4,NULL) 

SELECT*FROM C_ORDER 

================================================================================
                           TABLE 3: ITEM
================================================================================

-- ITEM (item #: int, unit price: int)

CREATE TABLE ITEM( 
ITEMID INT, 
PRICE INT, 
PRIMARY KEY(ITEMID) 
) 

INSERT INTO ITEM VALUES(21,40) 
INSERT INTO ITEM VALUES(22,50) 
INSERT INTO ITEM VALUES(23,60) 
INSERT INTO ITEM VALUES(24,70) 
INSERT INTO ITEM VALUES(25,20) 

SELECT*FROM ITEM 

================================================================================
              TABLE 4: ORDERITEM (Junction Table)
================================================================================

--  ORDER–ITEM (order #: int, item #: int, qty: int) 
CREATE TABLE ORDERITEM( 
ORDERID INT, 
ITEMID INT, 
QTY INT, 
PRIMARY KEY(ORDERID,ITEMID), 
FOREIGN KEY(ORDERID) REFERENCES C_ORDER(ORDERID) ON DELETE CASCADE ON UPDATE 
CASCADE, 
FOREIGN KEY(ITEMID) REFERENCES ITEM(ITEMID) ON DELETE CASCADE ON UPDATE 
CASCADE 
) 

INSERT INTO ORDERITEM VALUES(101,21,2) 
INSERT INTO ORDERITEM VALUES(101,22,3) 
INSERT INTO ORDERITEM VALUES(102,23,2) 
INSERT INTO ORDERITEM VALUES(102,24,1) 
INSERT INTO ORDERITEM VALUES(102,25,2) 
INSERT INTO ORDERITEM VALUES(103,21,2) 
INSERT INTO ORDERITEM VALUES(105,21,5) 
INSERT INTO ORDERITEM VALUES(104,25,2) 
INSERT INTO ORDERITEM VALUES(105,23,2) 

SELECT * FROM ORDERITEM 

================================================================================
                         TABLE 5: WAREHOUSE
================================================================================

-- WAREHOUSE (warehouse #: int, city: string) 
CREATE TABLE WAREHOUSE( 
WARID INT, 
CITY VARCHAR(10), 
PRIMARY KEY(WARID) 
) 

INSERT INTO WAREHOUSE VALUES(201,'UDUPI') 
INSERT INTO WAREHOUSE VALUES(202,'UDUPI2') 
INSERT INTO WAREHOUSE VALUES(203,'UDUPI3') 
INSERT INTO WAREHOUSE VALUES(204,'UDUPI4') 
INSERT INTO WAREHOUSE VALUES(205,'UDUPI5') 

SELECT * FROM WAREHOUSE 

================================================================================
                       TABLE 6: SHIPMENT
================================================================================

-- SHIPMENT (order #: int, warehouse#: int, ship-date: date)  
CREATE TABLE SHIPMENT( 
ORDERID INT, 
WARID INT, 
SHIPDATE DATE, 
PRIMARY KEY(ORDERID,WARID), 
FOREIGN KEY(ORDERID) REFERENCES C_ORDER(ORDERID) ON DELETE CASCADE ON UPDATE 
CASCADE, 
FOREIGN KEY(WARID) REFERENCES WAREHOUSE(WARID) ON DELETE CASCADE ON UPDATE 
CASCADE 
) 

INSERT INTO SHIPMENT VALUES(101,201,'1090-09-17') 
INSERT INTO SHIPMENT VALUES(101,202,'1091-09-17') 
INSERT INTO SHIPMENT VALUES(101,203,'1090-08-17') 
INSERT INTO SHIPMENT VALUES(103,201,'1090-09-10') 
INSERT INTO SHIPMENT VALUES(103,202,'1070-09-17') 
INSERT INTO SHIPMENT VALUES(105,201,'1090-05-17') 
INSERT INTO SHIPMENT VALUES(102,204,'1098-09-17') 
INSERT INTO SHIPMENT VALUES(102,201,'1090-09-17') 
INSERT INTO SHIPMENT VALUES(102,201,'1090-09-17') 
INSERT INTO SHIPMENT VALUES(104,201,'1090-09-17') 

SELECT*FROM SHIPMENT 

================================================================================
                          QUERY EXECUTION
================================================================================

-- display tables
select * from CUSTOMER;  -- CUSTOMER (cust #: int, cname: string, city: string) 
select * from C_ORDER;  -- ORDER (order #: int, odate: date, cust : int, ord-Amt: int) 
select * from ORDERITEM;  -- ORDER–ITEM (order #: int, item #: int, qty: int) 
select * from ITEM;  -- ITEM (item #: int, unit price: int)  
select * from SHIPMENT;  -- SHIPMENT (order #: int, warehouse#: int, ship-date: date)  
select * from WAREHOUSE;  -- WAREHOUSE (warehouse #: int, city: string)  


-- ============================================================================
-- QUERY 1: Produce customer listing with order count and average order amount
-- ============================================================================
-- Purpose: Generate report showing customer name, total orders, and average order amount
-- Tables Used: CUSTOMER, C_ORDER
-- Expected Output: Customer name, number of orders, average order amount

-- 1. Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total numbers of orders by the customer and the last column is the average order amount for that customer.

select c.CNAME , COUNT(distinct o.ORDERID) as num_of_order , AVG(o.ORDAMT) as avg_order_amt 
from CUSTOMER c
JOIN C_ORDER o
ON c.CUSTID = o.CUSTID
GROUP BY c.CNAME;

-- ============================================================================
-- QUERY 2: Items with multiple orders and multi-warehouse shipments
-- ============================================================================
-- Purpose: For each item ordered more than twice, show number of orders and total quantity
-- Tables Used: ORDERITEM, SHIPMENT
-- Expected Output: Item ID, number of orders, total quantity

-- 2. For each item that has more than two orders , list the item, number of orders that are shipped from atleast two warehouses and total quantity of items shipped. 
  

SELECT oi.ITEMID,COUNT(DISTINCT oi.ORDERID) AS num_orders,SUM(oi.qty) AS total_quantity
FROM ORDERITEM oi
JOIN SHIPMENT s
ON s.ORDERID=oi.ORDERID
GROUP BY oi.ITEMID
HAVING COUNT(DISTINCT oi.ORDERID) > 2 and COUNT(DISTINCT s.WARID)>=2;


-- ============================================================================
-- QUERY 3: Customers who ordered every item produced by company
-- ============================================================================
-- Purpose: Identify customers with complete item coverage (ordered all items)
-- Tables Used: CUSTOMER, C_ORDER, ORDERITEM, ITEM
-- Expected Output: Customer names

-- 3. List the customers who have ordered for every item that the company produces 

SELECT c.CUSTID, c.CNAME
FROM CUSTOMER c
JOIN C_ORDER o ON c.CUSTID = o.CUSTID
JOIN ORDERITEM oi ON o.ORDERID = oi.ORDERID
GROUP BY c.CUSTID, c.CNAME
HAVING COUNT(DISTINCT oi.ITEMID) = (
    SELECT COUNT(*) FROM ITEM
);


================================================================================
                        CLEANUP SECTION
================================================================================

-- drop the tables
drop table CUSTOMER;
drop table ORDERS;
drop table ITEM;
drop TABLE ORDER_ITEM;  
drop table SHIPMENT;
drop table WAREHOUSE;

================================================================================
                          END OF SCRIPT
================================================================================