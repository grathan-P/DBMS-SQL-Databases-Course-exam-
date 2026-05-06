# Author Database - Output with Explanations

## Table Outputs with Explanations

### TABLE 1: AUTHOR

**Purpose**: Stores author information for books in the catalog

**Columns**:
- **AUTHORID**: Author identifier (Primary Key) - unique ID for each author
- **ANAME**: Author's name
- **CITY**: City where author is located
- **COUNTRY**: Country of author

**Data**:

| AUTHORID | ANAME | CITY | COUNTRY |
|----------|-------|------|---------|
| 1 | RON | ABC | XYZ |
| 2 | DON | NBC | QYZ |
| 3 | CON | MBC | WYZ |
| 4 | AON | TBC | YYZ |
| 5 | BON | PBC | MYZ |

**Explanation**:
- 5 authors in the system
- Authors are from different cities and countries
- Each author has unique identification for catalog association
- Multiple books can be written by same author

---

### TABLE 2: PUBLISHER

**Purpose**: Stores publisher information for books

**Columns**:
- **PUBID**: Publisher identifier (Primary Key) - unique ID for each publisher
- **PNAME**: Publisher's name
- **CITY**: City where publisher is based
- **COUNTRY**: Country of publisher

**Data**:

| PUBID | PNAME | CITY | COUNTRY |
|-------|-------|------|---------|
| 10 | PEGION | ABC | LYZ |
| 20 | TOM | DBC | XKZ |
| 30 | JERRY | KBC | LYZ |
| 40 | PEACOCK | KBC | XYG |
| 50 | DUCK | AJC | MYZ |

**Explanation**:
- 5 publishers available
- Publishers span multiple countries (LYZ, XKZ, XYG, MYZ)
- Multiple publishers can be based in same country (JERRY and PEGION both in LYZ)
- Each book is associated with one publisher

---

### TABLE 3: CATEGORY

**Purpose**: Stores book category/genre information

**Columns**:
- **CATID**: Category identifier (Primary Key) - unique ID for each category
- **DESCR**: Description/name of category

**Data**:

| CATID | DESCR |
|-------|-------|
| 5 | ABC |
| 6 | YBC |
| 7 | KBC |

**Explanation**:
- 3 book categories in the system
- Simple category descriptions (ABC, YBC, KBC)
- Each book belongs to one category
- Categories used for book classification

---

### TABLE 4: CATALOG

**Purpose**: Stores comprehensive book information with all relationships

**Columns**:
- **BOOKID**: Book identifier (Primary Key) - unique for each book
- **TITLE**: Book title
- **AUTHORID**: Author ID (Foreign Key → AUTHOR) - who wrote the book
- **PUBID**: Publisher ID (Foreign Key → PUBLISHER) - who published it
- **CATID**: Category ID (Foreign Key → CATEGORY) - book genre/type
- **YEAR**: Publication year
- **PRICE**: Book price

**Data**:

| BOOKID | TITLE | AUTHORID | PUBID | CATID | YEAR | PRICE |
|--------|-------|----------|-------|-------|------|-------|
| 101 | JACK | 1 | 10 | 5 | 2004 | 6000 |
| 102 | HORROR | 2 | 30 | 6 | 2014 | 9000 |
| 103 | COMEDY | 1 | 20 | 7 | 2008 | 3000 |
| 104 | DISNEY | 4 | 10 | 5 | 2001 | 5000 |
| 105 | CARTOON | 2 | 30 | 7 | 2024 | 2000 |

**Explanation**:
- 5 books in the catalog
- Book 101 (JACK): Author 1 (RON), Published by PEGION (10), Category ABC (5), 2004, ₹6000
- Book 102 (HORROR): Author 2 (DON), Published by JERRY (30), Category YBC (6), 2014, ₹9000 - highest priced
- Book 103 (COMEDY): Author 1 (RON), Published by TOM (20), Category KBC (7), 2008, ₹3000 - lowest priced
- Book 104 (DISNEY): Author 4 (AON), Published by PEGION (10), Category ABC (5), 2001, ₹5000
- Book 105 (CARTOON): Author 2 (DON), Published by JERRY (30), Category KBC (7), 2024, ₹2000 - newest
- Author 1 and 2 have multiple books (prolific authors)
- Books published across 2 decades (2001-2024)

---

### TABLE 5: ORDERDETAILS

**Purpose**: Records order/purchase details linking orders to books with quantities

**Columns**:
- **ORDERNO**: Order number (Primary Key 1) - unique order identifier
- **BOOKID**: Book ID (Primary Key 2, Foreign Key → CATALOG) - which book was ordered
- **QTY**: Quantity ordered in that order

**Data**:

| ORDERNO | BOOKID | QTY |
|---------|--------|-----|
| 200 | 101 | 45 |
| 201 | 102 | 46 |
| 202 | 101 | 10 |
| 203 | 104 | 5 |
| 204 | 104 | 1 |

**Explanation**:
- 5 order records representing sales transactions
- Order 200: 45 copies of JACK (Book 101) - highest single order quantity
- Order 201: 46 copies of HORROR (Book 102) - bulk purchase
- Order 202: 10 additional copies of JACK (Book 101) - repeat customer/restock
- Order 203: 5 copies of DISNEY (Book 104) - small order
- Order 204: 1 copy of DISNEY (Book 104) - single copy order
- Book 101 appears in 2 orders (most popular, total: 55 units)
- Book 104 appears in 2 orders (total: 6 units)
- Total sales quantity across all orders: 107 books
- HORROR has highest per-order quantity (46)

---

## Query Results with Explanations

### Query 1 Result: Author of Book with Maximum Sales

**Query Purpose**: Identify which author wrote the book that had the highest total sales quantity

| AUTHORID | ANAME | BOOKID | Sales |
|----------|-------|--------|-------|
| 1 | RON | 101 | 55 |

**Result Explanation**:
- **Author**: RON (AUTHORID = 1)
- **Book**: JACK (BOOKID = 101)
- **Sales**: 55 copies
- **Why**: Book 101 (JACK) has the highest total sales quantity
- Sales by book:
  - Book 101: 45 + 10 = 55 total ✓ (MAXIMUM)
  - Book 102: 46 total
  - Book 104: 5 + 1 = 6 total
  - Books 103, 105: Not in any orders
- Author 1 (RON) has the top-selling book JACK

---

### Query 2 Result: Updated Book Prices After 10% Increase

**Query Purpose**: Update prices by 10% for books published by specific publisher (PEGION - ID 10)

| BOOKID | TITLE | AUTHORID | PUBID | CATID | YEAR | PRICE |
|--------|-------|----------|-------|-------|------|-------|
| 101 | JACK | 1 | 10 | 5 | 2004 | 6600 |
| 102 | HORROR | 2 | 30 | 6 | 2014 | 9000 |
| 103 | COMEDY | 1 | 20 | 7 | 2008 | 3000 |
| 104 | DISNEY | 4 | 10 | 5 | 2001 | 5500 |
| 105 | CARTOON | 2 | 30 | 7 | 2024 | 2000 |

**Price Changes**:
- **Book 101 (JACK)**: PEGION publisher → 6000 × 1.1 = **6600** ✓ (price increased)
- **Book 104 (DISNEY)**: PEGION publisher → 5000 × 1.1 = **5500** ✓ (price increased)
- **Book 102 (HORROR)**: JERRY publisher (30) → 9000 (unchanged)
- **Book 103 (COMEDY)**: TOM publisher (20) → 3000 (unchanged)
- **Book 105 (CARTOON)**: JERRY publisher (30) → 2000 (unchanged)

**Result Explanation**:
- 2 books affected (Books 101 and 104 published by PEGION)
- 3 books unchanged (different publishers)
- Total price increase: (6600-6000) + (5500-5000) = 600 + 500 = ₹1100 additional revenue potential
- PEGION books now 10% more expensive

---

### Query 3 Result: Number of Orders for Book with Minimum Sales

**Query Purpose**: Find how many separate orders were placed for the book with lowest total sales quantity

| BOOKID | number_of_order |
|--------|-----------------|
| 104 | 2 |

**Result Explanation**:
- **Book with Minimum Sales**: DISNEY (BOOKID = 104)
- **Total Quantity Sold**: 6 copies (Orders 203 and 204)
- **Number of Orders**: 2 separate orders contain this book
- **Sales Analysis**:
  - Book 104 (DISNEY): 6 copies total, 2 orders ✓ (MINIMUM)
  - Book 105 (CARTOON): 0 copies total, 0 orders
  - Book 102 (HORROR): 46 copies total, 1 order
  - Book 101 (JACK): 55 copies total, 2 orders
  - Book 103 (COMEDY): 0 copies, 0 orders
- Book 103 (COMEDY) and Book 105 (CARTOON) have zero sales and don't appear in the result
- Book 104 (DISNEY) is the least-selling book among ordered titles
- May need promotional strategy for low-selling titles

---

## Data Relationships Summary

**Key Relationships**:
```
AUTHOR (one-to-many)
  ↓
CATALOG (references) ← PUBLISHER
  ↓ (one-to-many)
  ├→ CATEGORY
  └→ ORDERDETAILS
```

**Business Insights**:
- Best selling book: HORROR (46 units) by DON from JERRY publishers
- Least popular book: CARTOON (1 unit) by DON from JERRY publishers
- Most prolific authors: RON and DON (2 books each)
- PEGION publisher has 2 books (just received 10% price increase)
- Total inventory in orders: 107 books across 5 orders
- Books need promotion strategy especially COMEDY and CARTOON titles

