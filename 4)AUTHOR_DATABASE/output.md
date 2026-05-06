# Author Database - Output

## Table Outputs

### TABLE 1: AUTHOR

| AUTHORID | ANAME | CITY | COUNTRY |
|----------|-------|------|---------|
| 1 | RON | ABC | XYZ |
| 2 | DON | NBC | QYZ |
| 3 | CON | MBC | WYZ |
| 4 | AON | TBC | YYZ |
| 5 | BON | PBC | MYZ |

---

### TABLE 2: PUBLISHER

| PUBID | PNAME | CITY | COUNTRY |
|-------|-------|------|---------|
| 10 | PEGION | ABC | LYZ |
| 20 | TOM | DBC | XKZ |
| 30 | JERRY | KBC | LYZ |
| 40 | PEACOCK | KBC | XYG |
| 50 | DUCK | AJC | MYZ |

---

### TABLE 3: CATEGORY

| CATID | DESCR |
|-------|-------|
| 5 | ABC |
| 6 | YBC |
| 7 | KBC |

---

### TABLE 4: CATALOG

| BOOKID | TITLE | AUTHORID | PUBID | CATID | YEAR | PRICE |
|--------|-------|----------|-------|-------|------|-------|
| 101 | JACK | 1 | 10 | 5 | 2004 | 6000 |
| 102 | HORROR | 2 | 30 | 6 | 2014 | 9000 |
| 103 | COMEDY | 1 | 20 | 7 | 2008 | 3000 |
| 104 | DISNEY | 4 | 10 | 5 | 2001 | 5000 |
| 105 | CARTOON | 2 | 30 | 7 | 2024 | 2000 |

---

### TABLE 5: ORDERDETAILS

| ORDERNO | BOOKID | QTY |
|---------|--------|-----|
| 200 | 101 | 45 |
| 201 | 102 | 46 |
| 202 | 101 | 10 |
| 203 | 104 | 5 |
| 204 | 104 | 1 |

---

## Query Results

### Query 1 Result: Author of Book with Maximum Sales

| AUTHORID | ANAME | BOOKID | Sales |
|----------|-------|--------|-------|
| 1 | RON | 101 | 55 |

---

### Query 2 Result: Updated Prices After 10% Increase

| BOOKID | TITLE | AUTHORID | PUBID | CATID | YEAR | PRICE |
|--------|-------|----------|-------|-------|------|-------|
| 101 | JACK | 1 | 10 | 5 | 2004 | 6600 |
| 102 | HORROR | 2 | 30 | 6 | 2014 | 9000 |
| 103 | COMEDY | 1 | 20 | 7 | 2008 | 3000 |
| 104 | DISNEY | 4 | 10 | 5 | 2001 | 5500 |
| 105 | CARTOON | 2 | 30 | 7 | 2024 | 2000 |

---

### Query 3 Result: Number of Orders for Book with Minimum Sales

| BOOKID | number_of_order |
|--------|-----------------|
| 104 | 2 |

