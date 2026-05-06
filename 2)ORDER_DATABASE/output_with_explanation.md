# Order Database - Output Files With Explanations

## Table Data Outputs

### 1. CUSTOMER Table

**Purpose**: Contains all customer records in the database.

**Table Structure**:
| CUSTID | CNAME | CITY |
|--------|-------|------|
| 1 | TOM | UDUPI |
| 2 | RAM | BNGLR |
| 3 | SEETHA | MNGLR |
| 4 | JIM | HUBLI |
| 5 | JOHN | GADAG |

**Columns**:
- **CUSTID**: Unique identifier for each customer (Primary Key)
- **CNAME**: Customer name
- **CITY**: Customer's city location

**Comments**:
- Total Records: 5 customers
- No duplicate customer IDs
- Customers are located in different cities
- All customers have valid names

---

### 2. C_ORDER Table

**Purpose**: Contains all customer orders with dates and amounts.

**Table Structure**:
| ORDERID | ODATE | CUSTID | ORDAMT |
|---------|-------|--------|--------|
| 101 | 2020-11-10 | 1 | NULL |
| 102 | 2020-12-10 | 1 | NULL |
| 103 | 2004-11-10 | 2 | NULL |
| 104 | 2020-11-10 | 3 | NULL |
| 105 | 2004-11-10 | 4 | NULL |

**Columns**:
- **ORDERID**: Unique order identifier (Primary Key)
- **ODATE**: Order date
- **CUSTID**: Customer ID (Foreign Key → CUSTOMER)
- **ORDAMT**: Order amount (NULL in this dataset)

**Comments**:
- Total Records: 5 orders
- All ORDAMT values are NULL (may represent pending/calculated amounts)
- Customer 1 (TOM) has 2 orders
- Customers 2, 3, 4 have 1 order each
- Customer 5 has no orders
- Dates span from 2004 to 2020

---

### 3. ITEM Table

**Purpose**: Contains all items/products the company produces.

**Table Structure**:
| ITEMID | PRICE |
|--------|-------|
| 21 | 40 |
| 22 | 50 |
| 23 | 60 |
| 24 | 70 |
| 25 | 20 |

**Columns**:
- **ITEMID**: Unique item identifier (Primary Key)
- **PRICE**: Unit price per item

**Comments**:
- Total Records: 5 items
- Price range: $20 to $70
- Item 25 is cheapest ($20)
- Item 24 is most expensive ($70)
- IDs are sequential (21-25)

---

### 4. ORDERITEM Table

**Purpose**: Links orders to items ordered with quantities (order line items).

**Table Structure**:
| ORDERID | ITEMID | QTY |
|---------|--------|-----|
| 101 | 21 | 2 |
| 101 | 22 | 3 |
| 102 | 23 | 2 |
| 102 | 24 | 1 |
| 102 | 25 | 2 |
| 103 | 21 | 2 |
| 105 | 21 | 5 |
| 104 | 25 | 2 |
| 105 | 23 | 2 |

**Columns**:
- **ORDERID**: Order identifier (Primary Key Part 1, Foreign Key → C_ORDER)
- **ITEMID**: Item identifier (Primary Key Part 2, Foreign Key → ITEM)
- **QTY**: Quantity ordered

**Comments**:
- Total Records: 9 order-item combinations
- Order 101 has 2 items (items 21, 22)
- Order 102 has 3 items (items 23, 24, 25)
- Item 21 is ordered 3 times (orders 101, 103, 105)
- Item 25 is ordered 2 times (orders 102, 104)
- Total quantity: 22 items across all orders
- Order 105 has highest qty for single item (5 of item 21)

---

### 5. WAREHOUSE Table

**Purpose**: Contains warehouse locations for order shipments.

**Table Structure**:
| WARID | CITY |
|-------|------|
| 201 | UDUPI |
| 202 | UDUPI2 |
| 203 | UDUPI3 |
| 204 | UDUPI4 |
| 205 | UDUPI5 |

**Columns**:
- **WARID**: Unique warehouse identifier (Primary Key)
- **CITY**: City where warehouse is located

**Comments**:
- Total Records: 5 warehouses
- All warehouses are in UDUPI region (variant names)
- IDs are sequential (201-205)
- Warehouse 204 is referenced in data (shipment for order 102)

---

### 6. SHIPMENT Table

**Purpose**: Records which warehouse shipped each order and shipment date.

**Table Structure**:
| ORDERID | WARID | SHIPDATE |
|---------|-------|----------|
| 101 | 201 | 1090-09-17 |
| 101 | 202 | 1091-09-17 |
| 101 | 203 | 1090-08-17 |
| 103 | 201 | 1090-09-10 |
| 103 | 202 | 1070-09-17 |
| 105 | 201 | 1090-05-17 |
| 102 | 204 | 1098-09-17 |
| 102 | 201 | 1090-09-17 |
| 102 | 201 | 1090-09-17 |
| 104 | 201 | 1090-09-17 |

**Columns**:
- **ORDERID**: Order identifier (Primary Key Part 1, Foreign Key → C_ORDER)
- **WARID**: Warehouse identifier (Primary Key Part 2, Foreign Key → WAREHOUSE)
- **SHIPDATE**: Date order was shipped

**Comments**:
- Total Records: 10 shipment entries
- Order 101 shipped from 3 warehouses (201, 202, 203)
- Order 102 shipped from 2 warehouses (204, 201 twice)
- Order 103 shipped from 2 warehouses (201, 202)
- Order 104 shipped from 1 warehouse (201)
- Order 105 shipped from 1 warehouse (201)
- Note: Date values appear to have data quality issues (year 1090, 1070, 1098)
- Warehouse 201 is primary/most-used warehouse

---

## Query Results

### Query 1 Result: Customer Order Summary

**Query**: Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT

**Result**:
| CUSTNAME | #OFORDERS | AVG_ORDER_AMT |
|----------|-----------|---------------|
| TOM | 2 | NULL |
| RAM | 1 | NULL |
| SEETHA | 1 | NULL |
| JIM | 1 | NULL |

**Explanation**:
- TOM (Customer 1): Placed 2 orders with average amount NULL
- RAM (Customer 2): Placed 1 order with average amount NULL
- SEETHA (Customer 3): Placed 1 order with average amount NULL
- JIM (Customer 4): Placed 1 order with average amount NULL
- JOHN (Customer 5): Not included (no orders placed)
- Note: Average is NULL because ORDAMT column contains all NULL values in source data

---

### Query 2 Result: Items with Multiple Orders and Multi-Warehouse Shipments

**Query**: For each item that has more than two orders, list the item, number of orders shipped from at least two warehouses and total quantity

**Result**:
| ITEMID | num_orders | total_quantity |
|--------|-----------|-----------------|
| 21 | 3 | 9 |

**Explanation**:
- Item 21 appears in 3 orders (101, 103, 105) - meets >2 requirement
- Item 21 is shipped from at least 2 warehouses:
  - Order 101: shipped from warehouses 201, 202, 203
  - Order 103: shipped from warehouses 201, 202
  - Order 105: shipped from warehouse 201
- Total quantity of item 21: 2+2+5 = 9
- Only Item 21 qualifies because:
  - Item 22: only 1 order (not >2)
  - Item 23: 2 orders (not >2)
  - Item 24: only 1 order (not >2)
  - Item 25: 2 orders (not >2)

---

### Query 3 Result: Customers Who Ordered Every Item

**Query**: List the customers who have ordered for every item that the company produces

**Result**:
| CNAME |
|-------|
| TOM |

**Explanation**:
- Total items in system: 5 (items 21, 22, 23, 24, 25)
- Customer 1 (TOM): ordered items 21, 22, 23, 24, 25 = **5/5 items** ✓
- Customer 2 (RAM): ordered item 21 = 1/5 items
- Customer 3 (SEETHA): ordered item 25 = 1/5 items
- Customer 4 (JIM): ordered item 21 = 1/5 items
- Customer 5 (JOHN): ordered items 21, 23 = 2/5 items
- Result: Only TOM (CUSTID 1) has ordered every item produced by the company

---

## Data Relationships Summary

### Key Relationships:
```
CUSTOMER (1) ──→ C_ORDER (Many)
                     ↓
              ORDERITEM (Many)
                     ↑
                  ITEM (1)
```

```
C_ORDER (1) ──→ SHIPMENT (Many) ──→ WAREHOUSE (1)
```

### Sample Analysis:
- **Customer TOM** placed 2 orders with 5 different items
- **Order 101** contained 2 items (qty: 5) and shipped from 3 warehouses
- **Order 102** contained 3 items (qty: 5) and shipped from 2 warehouses
- **Item 21** is the most popular (ordered 3 times, qty: 9 total)
- **Warehouse 201** handled most shipments (8 out of 10 entries)

---

## Data Quality Notes

✓ No duplicate primary keys  
⚠ ORDAMT column contains all NULL values (may need calculation)  
⚠ SHIPDATE values show anomalies (years 1090, 1070, 1098 - likely data entry errors)  
✓ All foreign key relationships properly maintained  
✓ All customer IDs in orders reference valid customers  
✓ All item IDs in order-items reference valid items  
✓ Warehouse references are valid  

---

## Calculations Reference

### Total Quantities by Order:
- Order 101: 2+3 = 5 items
- Order 102: 2+1+2 = 5 items
- Order 103: 2 items
- Order 104: 2 items
- Order 105: 5+2 = 7 items
- **Grand Total: 26 items across all orders**

### Item Order Frequency:
- Item 21: 3 orders (most popular)
- Item 22: 1 order
- Item 23: 2 orders
- Item 24: 1 order
- Item 25: 2 orders

### Warehouse Shipment Frequency:
- Warehouse 201: 8 shipments (most used)
- Warehouse 202: 2 shipments
- Warehouse 203: 1 shipment
- Warehouse 204: 1 shipment
- Warehouse 205: 0 shipments (unused)
