# Insurance Database - Query Explanations

## Overview
This document explains the three main queries in the Insurance Database project, their purpose, tables used, and the logic behind them.

---

## Query 1: Find Total Number of People Who Owned Cars Involved in Accidents in 1989

### Purpose
To find how many distinct car owners had their vehicles involved in accidents during the year 1989.

### SQL Query
```sql
select count (distinct P.driverid) as car_owner
from ACCIDENT A, PARTICIPATED P 
where A.reportno = P.reportno
and year(A.accdate) = '1989';
```

### Tables Used
| Table Name | Alias | Purpose |
|-----------|-------|---------|
| **ACCIDENT** | A | Contains accident information (report number, date, location) |
| **PARTICIPATED** | P | Links drivers and cars to accidents (driver, car, report number, damage amount) |

### Why These Tables?
- **ACCIDENT table**: Provides the accident date so we can filter for year 1989
- **PARTICIPATED table**: Links drivers to accidents through report numbers, allowing us to identify which drivers' cars were involved

### Logic Flow
1. Join ACCIDENT and PARTICIPATED tables on report number (A.reportno = P.reportno)
2. Filter accidents that occurred in 1989 using `year(A.accdate) = '1989'`
3. Count DISTINCT driver IDs (eliminates duplicate drivers who had multiple cars involved)
4. Result: Total number of unique car owners involved in 1989 accidents

### Expected Output
Single row with one column showing the count of distinct driver IDs.

---

## Query 2: Find Number of Accidents in Which Cars Belonging to "John Smith" Were Involved

### Purpose
To determine how many accidents involved the cars owned by a specific person (John Smith).

### SQL Query
```sql
select count(P.driverid) as number_of_accident
from PARTICIPATED p, PERSON ps
where ps.driverid=p.driverid and ps.name='john smith';
```

### Tables Used
| Table Name | Alias | Purpose |
|-----------|-------|---------|
| **PARTICIPATED** | p | Contains accident participation records (driver, car, report number) |
| **PERSON** | ps | Contains driver information (driver ID, name, address) |

### Why These Tables?
- **PERSON table**: Provides driver names, allowing us to search for "John Smith"
- **PARTICIPATED table**: Lists all accidents each driver participated in

### Logic Flow
1. Join PARTICIPATED and PERSON tables on driver ID (ps.driverid = p.driverid)
2. Filter for records where driver name is 'john smith' (case may vary)
3. Count all participation records for John Smith
4. Result: Total number of accidents John Smith's cars were involved in

### Expected Output
Single row with one column showing the count of accidents.

---

## Query 3: Update Damage Amount for Car "KA-12" in Accident Report "1" to $3000

### Purpose
To update a specific damage amount record in the database for a particular car involved in a particular accident.

### SQL Query
```sql
UPDATE PARTICIPATED 
SET DAMAGEAMT=3000 
WHERE REGNO='KA-12' AND REPORTNO=1;
```

### Tables Used
| Table Name | Purpose |
|-----------|---------|
| **PARTICIPATED** | Contains damage amount data that needs to be updated |

### Why This Table?
- **PARTICIPATED table**: The only table that stores damage amounts for each car-accident combination

### Logic Flow
1. Locate the record in PARTICIPATED where:
   - Car registration number (REGNO) = 'KA-12'
   - Accident report number (REPORTNO) = 1
2. Update the damage amount (DMGAMT) to 3000
3. Result: One or more records updated with the new damage value

### Expected Output
- Number of rows affected (typically 1 if the record exists)
- The PARTICIPATED table now shows DMGAMT = 3000 for this specific incident

---

## Database Schema Reference

### PERSON Table
```
DRIVERID (VARCHAR 10) - Primary Key
NAME (VARCHAR 10)
ADDRESS (VARCHAR 10)
```

### CAR Table
```
REGNO (VARCHAR 10) - Primary Key
MODEL (VARCHAR 10)
YEAR (INT)
```

### ACCIDENT Table
```
REPORTNO (INT) - Primary Key
ACCDATE (DATE)
LOCATION (VARCHAR 10)
```

### OWNS Table
```
DRIVERID (VARCHAR 10) - Primary Key Part 1, Foreign Key → PERSON
REGNO (VARCHAR 10) - Primary Key Part 2, Foreign Key → CAR
```

### PARTICIPATED Table
```
DRIVERID (VARCHAR 10) - Primary Key Part 1, Foreign Key → PERSON
REGNO (VARCHAR 10) - Primary Key Part 2, Foreign Key → CAR
REPORTNO (INT) - Primary Key Part 3, Foreign Key → ACCIDENT
DMGAMT (INT) - Damage Amount
```

---

## Key Concepts

- **JOIN Operation**: Queries 1 and 2 use implicit joins (comma-separated tables with WHERE conditions)
- **DISTINCT**: Query 1 uses DISTINCT to avoid counting the same driver multiple times
- **Date Functions**: Query 1 uses `year()` function to extract year from date
- **UPDATE Statement**: Query 3 demonstrates data modification with specific WHERE clause conditions
