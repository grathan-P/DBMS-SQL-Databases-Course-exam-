### 1. PERSON.csv

| DRIVERID | NAME | ADDRESS |
|----------|------|---------|
| 1 | A | UDUPI |
| 2 | B | KARKALA |
| 3 | JOHN SMITH | KUNDAPURA |
| 4 | D | UDUPI |
| 5 | E | SALVADY |


---

### 2. CAR.csv

| REGNO | MODEL | YEAR |
|-------|-------|------|
| KA-11 | SWIFT | 2004 |
| KA-12 | SANTRO | 1980 |
| KA-13 | RITZ | 1999 |
| KA-14 | BREZZA | 2009 |
| KA-15 | VENUE | 2000 |


---

### 3. ACCIDENT.csv


| REPORTNO | ACCDATE | LOCATION |
|----------|---------|----------|
| 1 | 1989-01-19 | UDUPI |
| 2 | 1999-01-19 | KARKALA |
| 3 | 1979-03-19 | KUNDAPURA |
| 4 | 1989-05-19 | UDUPI |
| 5 | 1989-01-25 | GADAG |

---

### 4. OWNS.csv

| DRIVERID | REGNO |
|----------|-------|
| 1 | KA-11 |
| 1 | KA-13 |
| 2 | KA-12 |
| 3 | KA-12 |
| 4 | KA-15 |

---

### 5. PARTICIPATED.csv

| DRIVERID | REGNO | REPORTNO | DMGAMT |
|----------|-------|----------|--------|
| 1 | KA-11 | 5 | 8000 |
| 1 | KA-12 | 1 | 3000 |
| 2 | KA-11 | 2 | 1000 |
| 3 | KA-12 | 1 | 3000 |
| 3 | KA-14 | 4 | 2000 |

---
---
---

## Query Result Outputs

---
---
---

### QUERY_1.csv

**Query**: Find the total number of people who owned cars that were involved in accidents in 1989.

**Result**:

| car_owner | 
|----------|
| 2 | 

---

### QUERY_2.csv

**Query**: Find the number of accidents in which the cars belonging to "John Smith" were involved.

**Result**:
| number_of_accident | 
|----------|
| 2 |

---

### QUERY_3.csv

**Query**: Update the damage amount for the car with reg number "KA-12" in accident with report number "1" to $3000. Then display updated PARTICIPATED table.

**Result** (Updated PARTICIPATED Table):

| DRIVERID | REGNO | REPORTNO | DMGAMT |
|----------|-------|----------|--------|
| 1 | KA-11 | 5 | 8000 |
| 1 | KA-12 | 1 | 3000 |
| 2 | KA-11 | 2 | 1000 |
| 3 | KA-12 | 1 | 3000 |
| 3 | KA-14 | 4 | 2000 |