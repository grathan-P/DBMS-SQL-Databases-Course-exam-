# Bank Database - Output with Explanations

## Table Outputs with Explanations

### TABLE 1: BRANCH

**Purpose**: Stores bank branch information with location and assets

**Columns**:
- **BNAME**: Branch name (Primary Key) - unique identifier for each branch
- **BCITY**: City where branch is located
- **ASSESTS**: Total assets of the branch (in million)

**Data**:

| BNAME | BCITY | ASSESTS |
|-------|-------|---------|
| SYNDICATE | MANIPAL | 2.5 |
| BHARAT | MANIPAL | 2.5 |
| JANATA | MANIPAL | 2.5 |
| TATA | UDUPI | 2.5 |
| SAI | UDUPI | 2.5 |
| CANARA | KUNDAPURA | 2.5 |

**Explanation**:
- 6 branches across 3 cities
- MANIPAL: 3 branches (SYNDICATE, BHARAT, JANATA)
- UDUPI: 2 branches (TATA, SAI)
- KUNDAPURA: 1 branch (CANARA)
- All branches have equal assets of 2.5 million

---

### TABLE 2: ACCOUNT

**Purpose**: Stores customer accounts linked to specific branches

**Columns**:
- **ACCNO**: Account number (Primary Key) - unique identifier for each account
- **BNAME**: Branch name (Foreign Key → BRANCH) - which branch owns the account
- **BALANCE**: Account balance amount

**Data**:

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

**Explanation**:
- 12 total accounts distributed across 6 branches
- TATA: 3 accounts (1, 2, 8)
- SAI: 3 accounts (3, 4, 9)
- SYNDICATE: 2 accounts (5, 11)
- BHARAT: 1 account (6)
- JANATA: 1 account (7)
- CANARA: 2 accounts (10, 12)
- All accounts have balance of 2.5

---

### TABLE 3: CUSTOMER

**Purpose**: Stores customer personal information

**Columns**:
- **CNAME**: Customer name (Primary Key) - unique identifier
- **CSTREET**: Street address of customer
- **CCITY**: City of customer residence

**Data**:

| CNAME | CSTREET | CCITY |
|-------|---------|-------|
| SOHAN | S1 | C1 |
| ROHAN | S2 | C2 |
| MOHAN | S3 | C3 |
| LOHAN | S4 | C4 |

**Explanation**:
- 4 registered customers
- Each customer has unique name, street, and city
- Customers are from different cities (C1, C2, C3, C4)

---

### TABLE 4: DEPOSITOR

**Purpose**: Junction table linking customers to their accounts (many-to-many relationship)

**Columns**:
- **CNAME**: Customer name (Primary Key 1, Foreign Key → CUSTOMER)
- **ACCNO**: Account number (Primary Key 2, Foreign Key → ACCOUNT)

**Data**:

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

**Explanation**:
- 12 depositor relationships (each customer-account pair)
- SOHAN: 4 accounts (1, 2, 3, 4)
- ROHAN: 6 accounts (5, 6, 7, 8, 9, 10) - most accounts
- MOHAN: 2 accounts (11, 12)
- LOHAN: 0 accounts - no depositor records
- Total account holders: 3 customers with 12 accounts

---

### TABLE 5: LOAN

**Purpose**: Stores loan information linked to specific branches

**Columns**:
- **LNO**: Loan number (Primary Key) - unique identifier
- **BNAME**: Branch name (Foreign Key → BRANCH) - which branch issued loan
- **AMOUNT**: Loan amount

**Data**:

| LNO | BNAME | AMOUNT |
|-----|-------|--------|
| 10 | CANARA | 2.3 |
| 20 | TATA | 2.3 |

**Explanation**:
- 2 loans in total
- Loan 10: Issued by CANARA branch, amount 2.3M
- Loan 20: Issued by TATA branch, amount 2.3M
- Both loans have equal amount of 2.3M

---

### TABLE 6: BORROWER

**Purpose**: Junction table linking customers to loans (many-to-many relationship)

**Columns**:
- **CNAME**: Customer name (Primary Key 1, Foreign Key → CUSTOMER)
- **LNO**: Loan number (Primary Key 2, Foreign Key → LOAN)

**Data**:

| CNAME | LNO |
|-------|-----|
| SOHAN | 10 |
| ROHAN | 20 |

**Explanation**:
- 2 borrower relationships
- SOHAN: Borrowed Loan 10 (2.3M from CANARA)
- ROHAN: Borrowed Loan 20 (2.3M from TATA)
- MOHAN and LOHAN: No loans
- Total borrowers: 2 customers with 2 loans

---

## Query Results with Explanations

### Query 1 Result: Customers with at least 2 accounts at all branches in UDUPI

**Query Purpose**: Find customers who have minimum 2 accounts at each/all branches located in UDUPI city

| CNAME |
|-------|
| SOHAN |

**Result Explanation**:
- **UDUPI branches**: TATA and SAI (2 branches in UDUPI city)
- **SOHAN**: 
  - TATA branch: 2 accounts (1, 2) ✓
  - SAI branch: 2 accounts (3, 4) ✓
  - Meets the requirement at every UDUPI branch
- **ROHAN**: 
  - TATA branch: 1 account (8) ✗ (needs ≥2)
  - SAI branch: 1 account (9) ✗ (needs ≥2)
- **MOHAN**: No accounts in UDUPI branches
- **LOHAN**: No accounts anywhere

Query logic: Find customers with NOT EXISTS (any branch in UDUPI where customer doesn't have ≥2 accounts)

Only SOHAN satisfies the condition.

---

### Query 2 Result: Customers with accounts in at least 1 branch in all cities

**Query Purpose**: Find customers who have accounts in every city (at least one branch in each city)

| CNAME |
|-------|
| ROHAN |

**Result Explanation**:
- **All cities**: MANIPAL (3 branches), UDUPI (2 branches), KUNDAPURA (1 branch)
- **ROHAN's accounts by city**:
  - MANIPAL: Branch JANATA (account 7) ✓
  - UDUPI: Branches TATA (account 8), SAI (account 9), CANARA (account 10) ✓
  - KUNDAPURA: Branch CANARA (account 10) ✓
  - Has accounts in ALL 3 cities ✓ RESULT
- **SOHAN's accounts by city**:
  - MANIPAL: Branch SYNDICATE (account 5) ✓
  - UDUPI: Branches TATA (accounts 1, 2), SAI (accounts 3, 4) ✓
  - KUNDAPURA: None ✗ (missing)
- **MOHAN's accounts by city**:
  - MANIPAL: None ✗ (missing)
  - UDUPI: None ✗ (missing)
  - KUNDAPURA: Branch CANARA (account 12) ✓ (but missing others)

Only ROHAN has accounts spanning all 3 cities

---

### Query 3 Result: Customers with accounts in at least 2 branches in MANIPAL

**Query Purpose**: Find customers having accounts in minimum 2 different branches located in MANIPAL city

| CNAME |
|-------|
| ROHAN |

**Result Explanation**:
- **MANIPAL branches**: SYNDICATE, BHARAT, JANATA (3 branches in MANIPAL city)
- **ROHAN's MANIPAL accounts**:
  - SYNDICATE: Account 5 ✓
  - BHARAT: Account 6 ✓
  - JANATA: Account 7 ✓
  - Has accounts in 3 different MANIPAL branches, so meets the ≥2 condition
- **SOHAN**: No MANIPAL branch accounts
- **MOHAN**: No MANIPAL branch accounts

Query logic: Count distinct MANIPAL branches per customer and return those with at least 2.

Only ROHAN satisfies the condition.

---

## Data Relationships Summary

**Key Relationships**:
```
BRANCH (one-to-many)
  ↓
ACCOUNT (many-to-many) ← DEPOSITOR → CUSTOMER
  ↓
  └→ LOAN (one-to-many)
       ↓
       └→ BORROWER → CUSTOMER
```

**Customer Account Distribution**:
- SOHAN: 4 accounts (most accounts)
- ROHAN: 6 accounts (highest diversity across cities)
- MOHAN: 2 accounts
- LOHAN: 0 accounts (no banking activity)

**Branch Account Distribution**:
- TATA: 3 accounts (busiest branch)
- SAI: 3 accounts
- CANARA: 2 accounts
- SYNDICATE: 2 accounts
- BHARAT: 1 account
- JANATA: 1 account

**Loan Borrowers**:
- Total loans: 2
- Borrowers: 2 customers (SOHAN, ROHAN)
- Non-borrowers: 2 customers (MOHAN, LOHAN)

