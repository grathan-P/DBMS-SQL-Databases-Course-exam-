# Bank Database - Query Explanations

## Overview

This document provides comprehensive explanations for all 3 queries in the Bank Database system.

---

## Query 1: Customers with at least 2 accounts at all branches in specific city

### Purpose
Find all customers who have at least 2 accounts at every branch located in a specific city (UDUPI).

### SQL Query

```sql
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
```

### Tables Used

| Table | Alias | Purpose |
|-------|-------|---------|
| **CUSTOMER** | C | Contains customer names to filter and output |
| **BRANCH** | B | Identifies branches in UDUPI city for comparison |
| **ACCOUNT** | A | Contains account and branch relationship |
| **DEPOSITOR** | D | Links customers to their accounts |

### Why These Tables?
- **CUSTOMER table**: Source for customer names and primary filtering entity
- **BRANCH table**: Required to find all branches in specific city (UDUPI)
- **ACCOUNT table**: Provides account-to-branch mapping
- **DEPOSITOR table**: Links accounts to customers for ownership verification

### Logic Flow

1. **Identify target city branches**: Find all branches where BCITY='UDUPI'
2. **For each customer**: Check their account distribution
3. **NOT EXISTS logic**: Inverse condition - find customers with NO branch gaps
4. **Inner query**: For each UDUPI branch, find if customer has <2 accounts
5. **NOT IN clause**: Exclude branches where customer has <2 accounts
6. **Result**: Customers who have ≥2 accounts at EVERY UDUPI branch

### Expected Output

Customer names that meet the criteria (may be 0, 1, or multiple rows)

### Database Schema Reference

```
CUSTOMER (CNAME)
  ↓
DEPOSITOR (CNAME → ACCNO)
  ↓
ACCOUNT (ACCNO → BNAME)
  ↓
BRANCH (BNAME, BCITY)
```

### Key Concepts

- **NOT EXISTS**: Checks that condition is false (inverse logic)
- **NOT IN operator**: Identifies branches NOT in the subquery result
- **GROUP BY with HAVING**: Counts accounts per branch for each customer
- **Nested subqueries**: Multiple levels of filtering
- **ALL branches requirement**: Customer must meet criteria for ALL branches in city

### Query Behavior Notes

- **Logical negation**: "NOT (exists any branch where customer doesn't have ≥2 accounts)"
- **Universal quantification**: Equivalent to "customer has ≥2 accounts at ALL branches"
- **City-specific**: Easily parameterized to check other cities
- **Minimum account requirement**: Currently hardcoded to 2 accounts

---

## Query 2: Customers with accounts in at least 1 branch in all cities

### Purpose
Find all customers who have accounts in branches located in every city (at least one branch per city).

### SQL Query

```sql
SELECT C1.CNAME 
FROM CUSTOMER C1 
WHERE NOT EXISTS( SELECT DISTINCT B1.BCITY 
                   FROM BRANCH B1 
                   WHERE B1.BCITY NOT IN( SELECT DISTINCT B.BCITY 
                                          FROM BRANCH B, ACCOUNT A, DEPOSITOR D 
                                          WHERE A.BNAME = B.BNAME 
                                          AND A.ACCNO = D.ACCNO 
                                          AND D.CNAME = C1.CNAME))
```

### Tables Used

| Table | Alias | Purpose |
|-------|-------|---------|
| **CUSTOMER** | C1 | Contains customer names to filter and output |
| **BRANCH** | B, B1 | Identifies cities for comparison |
| **ACCOUNT** | A | Contains account and branch relationship |
| **DEPOSITOR** | D | Links customers to their accounts |

### Why These Tables?
- **CUSTOMER table**: Source for customer names and primary entity
- **BRANCH table**: Required to identify all cities and branch-city mapping
- **ACCOUNT table**: Provides account-to-branch mapping
- **DEPOSITOR table**: Links accounts to specific customers

### Logic Flow

1. **Get all cities**: From BRANCH table, find distinct BCITY values
2. **For each customer**: Determine which cities they have accounts in
3. **Inner subquery**: Find cities where customer HAS at least one account
4. **Outer subquery**: Find cities where customer DOESN'T have accounts (NOT IN)
5. **NOT EXISTS**: Check that no cities are missing (result set is empty)
6. **Result**: Customers who have accounts in ALL cities

### Expected Output

Customer names that have accounts spanning all cities (may be 0, 1, or multiple rows)

### Database Schema Reference

```
BRANCH (BNAME, BCITY) - all cities
  ↑
ACCOUNT (BNAME) ← DEPOSITOR (ACCNO) ← CUSTOMER (CNAME)
```

### Key Concepts

- **NOT EXISTS**: Verifies result set is empty (all cities covered)
- **DISTINCT operator**: Removes duplicate cities
- **NOT IN with subquery**: Identifies missing cities
- **Set difference logic**: Cities in BRANCH but not in customer's accounts
- **Universal quantification**: Customer must have accounts in ALL cities

### Query Behavior Notes

- **City coverage check**: Validates that customer spans all cities
- **At least one branch per city**: Customer needs minimum 1 account per city
- **Extensible design**: Automatically adapts to new cities added to BRANCH table
- **Multi-level nesting**: Three levels of subqueries

---

## Query 3: Customers with accounts in at least 2 branches in specific city

### Purpose
Find all customers who have accounts in at least 2 different branches located in a specific city (MANIPAL).

### SQL Query

```sql
SELECT C1.CNAME 
FROM CUSTOMER C1 
WHERE EXISTS( SELECT COUNT(DISTINCT B.BNAME) 
              FROM BRANCH B, ACCOUNT A, DEPOSITOR D 
              WHERE B.BNAME = A.BNAME 
              AND A.ACCNO = D.ACCNO 
              AND D.CNAME = C1.CNAME 
              AND B.BCITY = 'MANIPAL' 
              GROUP BY B.BCITY 
              HAVING COUNT(DISTINCT B.BNAME) >= 2)
```

### Tables Used

| Table | Alias | Purpose |
|-------|-------|---------|
| **CUSTOMER** | C1 | Contains customer names to filter and output |
| **BRANCH** | B | Identifies branches and city filter (MANIPAL) |
| **ACCOUNT** | A | Contains account and branch relationship |
| **DEPOSITOR** | D | Links customers to their accounts |

### Why These Tables?
- **CUSTOMER table**: Source for customer names and primary entity
- **BRANCH table**: Required to identify branches in MANIPAL and verify city
- **ACCOUNT table**: Provides account-to-branch mapping
- **DEPOSITOR table**: Links accounts to specific customers

### Logic Flow

1. **Filter by city**: WHERE B.BCITY = 'MANIPAL' - focus on MANIPAL branches only
2. **Join tables**: Connect customer → accounts → branches
3. **Count distinct branches**: COUNT(DISTINCT B.BNAME) - count unique branches per customer
4. **Group by city**: GROUP BY B.BCITY groups results by city
5. **HAVING clause**: Filter groups with ≥2 branches
6. **EXISTS**: Return customer if result set is non-empty

### Expected Output

Customer names that have accounts in at least 2 different MANIPAL branches

### Database Schema Reference

```
CUSTOMER (CNAME)
  ↓
DEPOSITOR (CNAME → ACCNO)
  ↓
ACCOUNT (ACCNO → BNAME)
  ↓
BRANCH (BNAME, BCITY='MANIPAL')
```

### Key Concepts

- **EXISTS operator**: Returns true if subquery produces any rows
- **COUNT(DISTINCT B.BNAME)**: Counts unique branches (not accounts)
- **GROUP BY B.BCITY**: Aggregates by city to group accounts by branch
- **HAVING clause**: Filters aggregated results to >=2 branches
- **City-specific filtering**: WHERE B.BCITY = 'MANIPAL'

### Query Behavior Notes

- **Branch diversity**: Counts different branches, not account count
- **City-specific**: Can be modified to check any city (UDUPI, KUNDAPURA, etc.)
- **Minimum threshold**: Currently set to >=2 branches (easily adjustable)
- **Distinct branch counting**: Ensures multiple accounts at same branch count as one branch

### Example Walkthrough

**Sample customer ROHAN with MANIPAL branches**:
- Account 5 → SYNDICATE (MANIPAL)
- Account 6 → BHARAT (MANIPAL)
- Account 7 → JANATA (MANIPAL)
- Account 8 → TATA (UDUPI) - filtered out by city condition
- Total MANIPAL branches: 3 unique branches >=2 ✓ Returns ROHAN

---

## Summary Comparison

| Aspect | Query 1 | Query 2 | Query 3 |
|--------|---------|---------|---------|
| **Goal** | Customers with ≥2 accounts at ALL branches in city | Customers with accounts in ALL cities | Customers with ≥2 different branches in city |
| **City scope** | Single city (UDUPI) | All cities (universal) | Single city (MANIPAL) |
| **Branch requirement** | ≥2 accounts at EACH branch | ≥1 account per city | ≥2 distinct branches |
| **Logic type** | NOT EXISTS (inverse) | NOT EXISTS (inverse) | EXISTS (direct) |
| **Aggregation** | COUNT branches per customer | COUNT cities per customer | COUNT distinct branches per customer |
| **Complexity** | High (multiple negations) | High (nested NOT EXISTS) | Medium (grouped aggregation) |
| **Output type** | Customer names | Customer names | Customer names |
| **Typical results** | Few (stricter criteria) | Few (hardest criteria) | More (easier to achieve) |

**Key Differences**:
- **Query 1**: Universal quantification per branch ∀ branches in city: customer has ≥2 accounts
- **Query 2**: Universal quantification per city ∀ cities: customer has ≥1 branch account
- **Query 3**: Existential quantification ∃ at least 2 branches in city: customer has accounts

