# Order Database - Query Explanations

## Overview
This document explains the three main queries in the Order Database project, their purpose, tables used, and the logic behind them.

---

## Query 1: Produce Customer Listing with Order Count and Average Order Amount

### Purpose
To generate a report showing each customer's name, total number of orders placed, and the average order amount for that customer.

### SQL Query
```sql
-- Version 1: Using implicit JOIN with GROUP BY
SELECT C.CNAME AS CUSTNAME,COUNT(DISTINCT O.ORDERID) AS #OFORDERS,AVG(O.ORDAMT) AS AVG_ORDER_AMT  
FROM CUSTOMER C,C_ORDER O 
WHERE C.CUSTID=O.CUSTID 
GROUP BY O.CUSTID,C.CNAME 

-- OR Version 2: Using explicit JOIN
select c.CNAME , COUNT(distinct o.ORDERID) as num_of_order , AVG(o.ORDAMT) as avg_order_amt 
from CUSTOMER c
JOIN C_ORDER o
ON c.CUSTID = o.CUSTID
GROUP BY c.CNAME;
```

### Tables Used
| Table Name | Alias | Purpose |
|-----------|-------|---------|
| **CUSTOMER** | C | Contains customer information (ID, name, city) |
| **C_ORDER** | O | Contains order information (order ID, date, customer ID, order amount) |

### Why These Tables?
- **CUSTOMER table**: Provides customer names and IDs
- **C_ORDER table**: Contains order amounts and customer references for aggregation

### Logic Flow
1. Join CUSTOMER and C_ORDER tables on CUSTID
2. Count DISTINCT order IDs per customer (eliminates duplicates)
3. Calculate AVG of order amounts per customer
4. Group results by CUSTID and CNAME
5. Result: List of customers with order statistics

### Expected Output
Multiple rows with columns: CUSTNAME, #OFORDERS, AVG_ORDER_AMT
- Each row represents one customer
- Shows how many orders each customer placed
- Shows average value of their orders

---

## Query 2: Items with Multiple Orders and Multi-Warehouse Shipments

### Purpose
For each item ordered more than twice, identify how many orders shipped from at least 2 different warehouses and the total quantity shipped.

### SQL Query
```sql
SELECT oi.ITEMID,COUNT(DISTINCT oi.ORDERID) AS num_orders,SUM(oi.qty) AS total_quantity
FROM ORDERITEM oi
JOIN SHIPMENT s
ON s.ORDERID=oi.ORDERID
GROUP BY oi.ITEMID
HAVING COUNT(DISTINCT oi.ORDERID) > 2 and COUNT(DISTINCT s.WARID)>=2;
```

### Tables Used
| Table Name | Alias | Purpose |
|-----------|-------|---------|
| **ORDERITEM** | oi | Links orders to items with quantities |
| **SHIPMENT** | s | Records which warehouse shipped each order |

### Why These Tables?
- **ORDERITEM table**: Lists items in each order and quantities ordered
- **SHIPMENT table**: Shows which warehouses shipped orders (needed to check multi-warehouse shipments)

### Logic Flow
1. Join ORDERITEM and SHIPMENT on order ID
2. Group by ITEMID
3. Count DISTINCT orders per item
4. Count DISTINCT warehouses that shipped the item
5. Filter with HAVING clause:
   - Items must have more than 2 orders
   - Items must be shipped from at least 2 warehouses
6. Sum total quantities
7. Result: Items meeting criteria with order and quantity statistics

### Expected Output
Multiple rows with columns: ITEMID, num_orders, total_quantity
- Only items with >2 orders and ≥2 warehouses appear
- Shows total number of orders for that item
- Shows combined quantity shipped across all orders

---

## Query 3: Customers Who Ordered Every Item Produced

### Purpose
Identify customers who have placed orders containing every item that the company produces (complete item coverage).

### SQL Query
```sql
-- Version 1: Using double negation (NOT EXISTS)
SELECT C.CNAME 
FROM CUSTOMER C 
WHERE NOT EXISTS(SELECT I.ITEMID 
                 FROM ITEM I 
                 WHERE NOT EXISTS(SELECT O.ORDERID  
                 FROM ORDERITEM O,C_ORDER C1 
                 WHERE C.CUSTID=C1.CUSTID AND I.ITEMID=O.ITEMID   
                 AND O.ORDERID=C1.ORDERID)) 

-- OR Version 2: Using GROUP BY and COUNT
SELECT c.CUSTID, c.CNAME
FROM CUSTOMER c
JOIN C_ORDER o ON c.CUSTID = o.CUSTID
JOIN ORDERITEM oi ON o.ORDERID = oi.ORDERID
GROUP BY c.CUSTID, c.CNAME
HAVING COUNT(DISTINCT oi.ITEMID) = (
    SELECT COUNT(*) FROM ITEM
);
```

### Tables Used
| Table Name | Purpose |
|-----------|---------|
| **CUSTOMER** | Contains customer information |
| **C_ORDER** | Links customers to their orders |
| **ORDERITEM** | Links orders to items |
| **ITEM** | Contains all items the company produces |

### Why These Tables?
- **CUSTOMER table**: To identify which customers to check
- **C_ORDER table**: To find orders placed by each customer
- **ORDERITEM table**: To see which items are in those orders
- **ITEM table**: To get the total count of items produced by company

### Logic Flow (Version 1 - Double Negation)
1. For each CUSTOMER (C)
2. Check if there EXISTS an ITEM (I) such that
3. That ITEM does NOT EXIST in any order by this customer
4. Return customers where NO such item exists (all items found)

### Logic Flow (Version 2 - COUNT Comparison)
1. Join customer → orders → items
2. Count DISTINCT items per customer
3. Compare against total item count in ITEM table
4. Return customers where counts are equal
5. Result: Customers who ordered all items

### Expected Output
Single or multiple rows with column: CNAME
- Lists customer names only
- Each customer has ordered at least one of every item the company produces
- Empty result if no customers meet the criteria

---

## Database Schema Reference

### CUSTOMER Table
```
CUSTID (INT) - Primary Key
CNAME (VARCHAR 10)
CITY (VARCHAR 10)
```

### C_ORDER Table
```
ORDERID (INT) - Primary Key
ODATE (DATE)
CUSTID (INT) - Foreign Key → CUSTOMER
ORDAMT (INT) - Order Amount
```

### ITEM Table
```
ITEMID (INT) - Primary Key
PRICE (INT) - Unit Price
```

### ORDERITEM Table (Junction)
```
ORDERID (INT) - Primary Key Part 1, Foreign Key → C_ORDER
ITEMID (INT) - Primary Key Part 2, Foreign Key → ITEM
QTY (INT) - Quantity
```

### WAREHOUSE Table
```
WARID (INT) - Primary Key
CITY (VARCHAR 10)
```

### SHIPMENT Table (Junction)
```
ORDERID (INT) - Primary Key Part 1, Foreign Key → C_ORDER
WARID (INT) - Primary Key Part 2, Foreign Key → WAREHOUSE
SHIPDATE (DATE)
```

---

## Key Concepts

- **Aggregation Functions**: Query 1 uses COUNT and AVG for statistics
- **Multiple Joins**: Queries 2 and 3 join multiple tables to correlate data
- **HAVING Clause**: Query 2 uses HAVING to filter grouped results
- **Subqueries**: Query 3 uses nested NOT EXISTS (relational division pattern)
- **Distinct Counting**: Multiple queries use COUNT(DISTINCT) to avoid duplicates
- **Set Operations**: Query 3 verifies complete coverage of items
