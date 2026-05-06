# Student Enrollment Database - Output

## Table Outputs

### TABLE 1: STUDENT

| REGNO | NAME | MAJOR | BDATE |
|-------|------|-------|-------|
| 101 | JOHN | ABC | 1990-10-09 |
| 102 | JIM | DBC | 1890-09-08 |
| 103 | JAM | ZBC | 1991-10-08 |
| 104 | JINNY | JBC | 1970-11-07 |
| 105 | JEMS | YBC | 1995-10-17 |

---

### TABLE 2: COURSE

| COURSEID | CNAME | DEPT |
|----------|-------|------|
| 1 | OOP | CS |
| 2 | FEWD | CS |
| 3 | PYTHON | CS |
| 4 | MP | ENC |
| 5 | OS | EEE |

---

### TABLE 3: ENROLL

| REGNO | COURSEID | SEM | MARKS |
|-------|----------|-----|-------|
| 101 | 1 | 3 | 99 |
| 102 | 1 | 4 | 98 |
| 103 | 2 | 5 | 97 |
| 104 | 3 | 2 | 79 |
| 105 | 5 | 7 | 39 |

---

### TABLE 4: TEXT

| BOOKISBN | TITLE | PUBLISHER | AUTHOR |
|----------|-------|-----------|--------|
| 50 | A | TOM | JERRY |
| 51 | C | TOM | MERRY |
| 52 | B | TOM | CHERRY |
| 53 | H | TOM | KHERRY |
| 54 | F | TOM | WHERRY |
| 55 | T | JIM | LHERRY |
| 56 | Z | JAM | QHERRY |

---

### TABLE 5: BOOK_ADAPTION

| COURSEID | SEM | BOOKISBN |
|----------|-----|----------|
| 1 | 2 | 50 |
| 1 | 3 | 51 |
| 1 | 4 | 52 |
| 2 | 5 | 53 |
| 3 | 3 | 54 |
| 4 | 7 | 56 |
| 5 | 7 | 55 |

---

## Query Results

### Query 1 Result: Text Books for CS Department Courses

| COURSE | BOOKISBN | BOOK_TITLE |
|--------|----------|------------|
| 1 | 52 | B |
| 1 | 50 | A |
| 1 | 51 | C |
| 3 | 54 | F |
| 2 | 53 | H |

---

### Query 2 Result: Departments with All Books from Same Publisher

| DEPT |
|------|
| CS |

---

### Query 3 Result: Books for Department with Maximum Students

| BOOKISBN | TITLE |
|----------|-------|
| 50 | A |
| 51 | C |
| 52 | B |

