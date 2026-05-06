# Author Database - Query Explanations

## Overview

This document provides comprehensive explanations for all 3 queries in the Author Database system.

---

## Query 1: Author of Book with Maximum Sales

### Purpose
Find the author of the book which has the maximum sales (highest total quantity ordered).

### SQL Query

```sql
SELECT A.AUTHORID, A.ANAME, C.BOOKID, SUM(O.QTY) as Sales
FROM AUTHOR A, CATALOG C, ORDERDETAILS O 
WHERE A.AUTHORID = C.AUTHORID AND C.BOOKID = O.BOOKID 
GROUP BY A.AUTHORID, A.ANAME, C.BOOKID 
HAVING SUM(O.QTY) >= ALL(
    SELECT SUM(QTY) 
    FROM ORDERDETAILS 
    GROUP BY BOOKID
);
```

### Tables Used

| Table | Alias | Purpose |
|-------|-------|---------|
| **AUTHOR** | A | Contains author information and ID |
| **CATALOG** | C | Links authors to books and publisher info |
| **ORDERDETAILS** | O | Contains order quantities for books |

### Why These Tables?
- **AUTHOR table**: Needed to retrieve author details (name) for the book with max sales
- **CATALOG table**: Required to map authors to their books
- **ORDERDETAILS table**: Contains quantity information needed to calculate total sales

### Logic Flow

1. **Join tables**: Connect AUTHOR → CATALOG → ORDERDETAILS through primary/foreign keys
2. **Group by book**: GROUP BY aggregates sales by author and book
3. **Calculate total**: SUM(O.QTY) calculates total quantity for each book
4. **Find maximum**: HAVING SUM(O.QTY) >= ALL() compares each book's total to all others
5. **Output**: Return author ID, name, book ID, and sales quantity

### Expected Output

Single row (or multiple if tie) with columns:
- AUTHORID: Author's unique ID
- ANAME: Author's name
- BOOKID: Book's unique ID
- Sales: Total quantity of that book ordered

### Database Schema Reference

```
AUTHOR (AUTHORID → one-to-many)
  ↓
CATALOG (BOOKID → one-to-many)
  ↓
ORDERDETAILS (contains quantities)
```

### Key Concepts

- **Aggregate function**: SUM(O.QTY) calculates total quantity per book
- **GROUP BY clause**: Aggregates data at book level with author info
- **ALL operator**: >= ALL() identifies maximum value across all groups
- **Multiple table joins**: Connects three tables to relate authors to sales
- **HAVING clause**: Filters grouped results to show only maximum

### Query Behavior Notes

- **Tie handling**: If multiple books have same max sales, all are returned
- **Null handling**: Books with no orders are excluded (INNER JOIN behavior)
- **Aggregation level**: Results grouped by AUTHORID, ANAME, BOOKID combinations

---

## Query 2: Update Book Prices by Publisher

### Purpose
Increase the price of all books published by a specific publisher (e.g., PEGION) by 10%.

### SQL Query

```sql
-- Method 1: Using subquery with publisher name
UPDATE CATALOG 
SET PRICE = 1.1 * PRICE 
WHERE PUBID IN (
    SELECT PUBID 
    FROM PUBLISHER 
    WHERE PNAME = 'PEGION'
);

-- Method 2: Direct publisher ID reference
UPDATE CATALOG 
SET PRICE = 1.1 * PRICE 
WHERE PUBID = '10';
```

### Tables Used

| Table | Alias | Purpose |
|-------|-------|---------|
| **CATALOG** | - | Primary table being updated (prices modified) |
| **PUBLISHER** | - | Referenced to identify which publisher's books to update (Method 1 only) |

### Why These Tables?
- **CATALOG table**: Contains PRICE column that needs to be updated and PUBID to match books
- **PUBLISHER table**: Needed in Method 1 to look up PUBID by publisher name (PNAME='PEGION')

### Logic Flow

**Method 1 (Name-based)**:
1. Find PUBID for publisher named 'PEGION' using subquery
2. Update CATALOG SET PRICE to 110% of current price
3. WHERE clause restricts updates to books matching that PUBID

**Method 2 (ID-based)**:
1. Directly reference PUBID = 10 (known ID for PEGION)
2. Multiply current PRICE by 1.1 (10% increase)
3. Apply update to matching rows

### Expected Result

- **Rows affected**: Number of books published by PEGION (typically small set)
- **Price change**: Original price × 1.1 (e.g., 5000 → 5500)
- **Targeted update**: Only PEGION's books modified, others unchanged

### Database Schema Reference

```
PUBLISHER (contains PUBID, PNAME)
  ↓ (has many)
CATALOG (contains BOOKID, PRICE, PUBID)
```

### Key Concepts

- **UPDATE statement**: Modifies existing data in table
- **SET clause**: Specifies which columns to modify and new values
- **WHERE clause**: Filters rows to update (only PEGION books)
- **Arithmetic expression**: 1.1 * PRICE calculates 10% increase
- **Subquery**: Method 1 uses nested SELECT to find publisher ID by name
- **IN operator**: Matches PUBID to subquery result set

### Query Behavior Notes

- **Non-destructive**: Only modifies price, other columns untouched
- **Reversible**: Could undo with UPDATE ... SET PRICE = PRICE / 1.1
- **Percentage calculation**: 1.1 multiplier represents 10% increase (110% of original)
- **Atomic operation**: All matching rows updated together

### Potential Improvements

```sql
-- Store new price in variable for audit trail
DECLARE @oldPrice DECIMAL;
SELECT @oldPrice = PRICE FROM CATALOG WHERE BOOKID = 101;
UPDATE CATALOG SET PRICE = 1.1 * PRICE WHERE PUBID = 10;
-- Log change: oldPrice, newPrice, timestamp, reason
```

---

## Query 3: Number of Orders for Book with Minimum Sales

### Purpose
Find how many separate orders were placed for the book that has minimum total sales quantity.

### SQL Query

```sql
SELECT O.BOOKID, COUNT(*) as number_of_order
FROM ORDERDETAILS O 
GROUP BY O.BOOKID 
HAVING SUM(O.QTY) <= ALL(
    SELECT SUM(QTY) 
    FROM ORDERDETAILS 
    GROUP BY BOOKID
);
```

### Tables Used

| Table | Alias | Purpose |
|-------|-------|---------|
| **ORDERDETAILS** | O | Contains all order records with quantities |

### Why This Table?
- **ORDERDETAILS table**: Only table needed as it contains both BOOKID (to group by) and QTY (to calculate totals and find minimum)

### Logic Flow

1. **Group by BOOKID**: GROUP BY aggregates orders by book
2. **Count orders**: COUNT(*) counts how many order records per book
3. **Calculate totals**: SUM(O.QTY) calculates total quantity per book
4. **Find minimum**: HAVING SUM(O.QTY) <= ALL() identifies books with lowest total quantity
5. **Output**: Return book ID and count of orders for that book

### Expected Output

Single row (or multiple if tie) with columns:
- BOOKID: Book's unique ID
- number_of_order: Count of separate orders containing that book

### Database Schema Reference

```
ORDERDETAILS (BOOKID, QTY)
  ↑ (many orders per book)
CATALOG (BOOKID) 
  ↑ (references back)
```

### Key Concepts

- **Aggregate function**: 
  - COUNT(*) counts number of order rows
  - SUM(O.QTY) sums total quantity
- **GROUP BY clause**: Aggregates at BOOKID level
- **ALL operator**: <= ALL() identifies minimum value across groups
- **HAVING clause**: Filters grouped results to show only minimum
- **Comparison**: <= ALL() compares each group to all other groups' totals

### Query Behavior Notes

- **Multiple row output**: If multiple books tied for minimum, all are returned
- **Books with zero orders**: Excluded (don't appear in ORDERDETAILS table)
- **Order counting**: Counts individual order records, not total quantity
- **Aggregation level**: Results show per-book metrics

### Example Walkthrough

**Sample Data**:
- Book 101: Orders (200, 202) with quantities (45, 10) → Total: 55, Orders: 2
- Book 102: Order (201) with quantity (46) → Total: 46, Orders: 1
- Book 104: Orders (203, 204) with quantities (5, 1) → Total: 6, Orders: 2
- Book 105: Order (204) with quantity (1) → Total: 1, Orders: 1 ✓ **MINIMUM**
- Book 103: No orders → Not in result

**Query Result**: Book 105 with 1 order (minimum sales of 1 unit)

---

## Summary Comparison

| Aspect | Query 1 | Query 2 | Query 3 |
|--------|---------|---------|---------|
| **Type** | SELECT (Read) | UPDATE (Write) | SELECT (Read) |
| **Main Goal** | Find best selling book's author | Adjust pricing | Find least popular book orders |
| **Key Operation** | Aggregation with ALL() | Price calculation | Counting with ALL() |
| **Tables Used** | 3 (AUTHOR, CATALOG, ORDERDETAILS) | 1-2 (CATALOG, PUBLISHER) | 1 (ORDERDETAILS) |
| **Complexity** | Medium (joins + aggregation) | Low (simple update) | Medium (aggregation + ALL) |
| **Data Modified** | None | PRICE column | None |
| **Output** | Author info + sales qty | Affected row count | Book ID + order count |

