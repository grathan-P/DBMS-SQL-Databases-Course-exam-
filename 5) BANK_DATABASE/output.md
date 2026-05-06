# Bank Database - Output

## Table Outputs

### TABLE 1: BRANCH

| BNAME | BCITY | ASSESTS |
|-------|-------|---------|
| SYNDICATE | MANIPAL | 2.5 |
| BHARAT | MANIPAL | 2.5 |
| JANATA | MANIPAL | 2.5 |
| TATA | UDUPI | 2.5 |
| SAI | UDUPI | 2.5 |
| CANARA | KUNDAPURA | 2.5 |

---

### TABLE 2: ACCOUNT

| ACCNO | BNAME | BALANCE |
|-------|-------|---------|
| 1 | TATA | 2.5 |
| 2 | TATA | 2.5 |
| 3 | SAI | 2.5 |
| 4 | SAI | 2.5 |
| 5 | SYNDICATE | 2.5 |
| 6 | BHARAT | 2.5 |
| 7 | JANATA | 2.5 |
| 8 | TATA | 2.5 |
| 9 | SAI | 2.5 |
| 10 | CANARA | 2.5 |
| 11 | SYNDICATE | 2.5 |
| 12 | CANARA | 2.5 |

---

### TABLE 3: CUSTOMER

| CNAME | CSTREET | CCITY |
|-------|---------|-------|
| SOHAN | S1 | C1 |
| ROHAN | S2 | C2 |
| MOHAN | S3 | C3 |
| LOHAN | S4 | C4 |

---

### TABLE 4: DEPOSITOR

| CNAME | ACCNO |
|-------|-------|
| SOHAN | 1 |
| SOHAN | 2 |
| SOHAN | 3 |
| SOHAN | 4 |
| ROHAN | 5 |
| ROHAN | 6 |
| ROHAN | 7 |
| ROHAN | 8 |
| ROHAN | 9 |
| ROHAN | 10 |
| MOHAN | 11 |
| MOHAN | 12 |

---

### TABLE 5: LOAN

| LNO | BNAME | AMOUNT |
|-----|-------|--------|
| 10 | CANARA | 2.3 |
| 20 | TATA | 2.3 |

---

### TABLE 6: BORROWER

| CNAME | LNO |
|-------|-----|
| SOHAN | 10 |
| ROHAN | 20 |

---

## Query Results

### Query 1 Result: Customers with at least 2 accounts at all branches in UDUPI

| CNAME |
|-------|
| SOHAN |

---

### Query 2 Result: Customers with accounts in at least 1 branch in all cities

| CNAME |
|-------|
| ROHAN |

---

### Query 3 Result: Customers with accounts in at least 2 branches in MANIPAL

| CNAME |
|-------|
| ROHAN |

