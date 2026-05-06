# Student Enrollment Database - Output with Explanations

## Table Outputs with Explanations

### TABLE 1: STUDENT

**Purpose**: Stores student information for enrollment tracking

**Columns**:
- **REGNO**: Student registration number (Primary Key) - unique identifier for each student
- **NAME**: Student's full name
- **MAJOR**: Student's major/specialization field
- **BDATE**: Birth date of student

**Data**:

| REGNO | NAME | MAJOR | BDATE |
|-------|------|-------|-------|
| 101 | JOHN | ABC | 1990-10-09 |
| 102 | JIM | DBC | 1890-09-08 |
| 103 | JAM | ZBC | 1991-10-08 |
| 104 | JINNY | JBC | 1970-11-07 |
| 105 | JEMS | YBC | 1995-10-17 |

**Explanation**:
- 5 students are registered in the system
- Students have diverse majors (ABC, DBC, ZBC, JBC, YBC)
- Birth years range from 1890 to 1995
- Each student has a unique REGNO for identification

---

### TABLE 2: COURSE

**Purpose**: Stores course information and department mapping

**Columns**:
- **COURSEID**: Course identifier (Primary Key) - unique for each course
- **CNAME**: Course name (OOP, FEWD, PYTHON, MP, OS)
- **DEPT**: Department offering the course (CS, ENC, EEE)

**Data**:

| COURSEID | CNAME | DEPT |
|----------|-------|------|
| 1 | OOP | CS |
| 2 | FEWD | CS |
| 3 | PYTHON | CS |
| 4 | MP | ENC |
| 5 | OS | EEE |

**Explanation**:
- 5 courses available across 3 departments
- CS (Computer Science) department: 3 courses (OOP, FEWD, PYTHON)
- ENC (Engineering) department: 1 course (MP)
- EEE (Electrical) department: 1 course (OS)
- Courses are primary teaching units across departments

---

### TABLE 3: ENROLL

**Purpose**: Links students to courses with enrollment details and marks

**Columns**:
- **REGNO**: Student registration number (Primary Key 1, Foreign Key → STUDENT)
- **COURSEID**: Course ID (Primary Key 2, Foreign Key → COURSE)
- **SEM**: Semester in which student enrolled
- **MARKS**: Grade/marks obtained in that course

**Data**:

| REGNO | COURSEID | SEM | MARKS |
|-------|----------|-----|-------|
| 101 | 1 | 3 | 99 |
| 102 | 1 | 4 | 98 |
| 103 | 2 | 5 | 97 |
| 104 | 3 | 2 | 79 |
| 105 | 5 | 7 | 39 |

**Explanation**:
- 5 enrollment records capturing student course participation
- Student 101 (JOHN): OOP in Semester 3, scored 99 (excellent)
- Student 102 (JIM): OOP in Semester 4, scored 98 (excellent)
- Student 103 (JAM): FEWD in Semester 5, scored 97 (excellent)
- Student 104 (JINNY): PYTHON in Semester 2, scored 79 (good)
- Student 105 (JEMS): OS in Semester 7, scored 39 (poor)
- Students generally perform well except for Student 105

---

### TABLE 4: TEXT

**Purpose**: Stores textbook information adopted by courses

**Columns**:
- **BOOKISBN**: International Standard Book Number (Primary Key) - unique identifier for books
- **TITLE**: Book title
- **PUBLISHER**: Publishing company (mostly TOM publisher)
- **AUTHOR**: Book author name

**Data**:

| BOOKISBN | TITLE | PUBLISHER | AUTHOR |
|----------|-------|-----------|--------|
| 50 | A | TOM | JERRY |
| 51 | C | TOM | MERRY |
| 52 | B | TOM | CHERRY |
| 53 | H | TOM | KHERRY |
| 54 | F | TOM | WHERRY |
| 55 | T | JIM | LHERRY |
| 56 | Z | JAM | QHERRY |

**Explanation**:
- 7 textbooks in the system
- 6 books published by publisher "TOM" (ISBNs: 50-54, 56)
- 1 book by publisher "JIM" (ISBN 55)
- Different authors for each book
- Books are identified by ISBN for adoption in courses

---

### TABLE 5: BOOK_ADAPTION

**Purpose**: Records which textbooks are adopted for which courses and semesters

**Columns**:
- **COURSEID**: Course ID (Primary Key 1, Foreign Key → COURSE)
- **SEM**: Semester level for the course
- **BOOKISBN**: Book ISBN (Primary Key 2, Foreign Key → TEXT)

**Data**:

| COURSEID | SEM | BOOKISBN |
|----------|-----|----------|
| 1 | 2 | 50 |
| 1 | 3 | 51 |
| 1 | 4 | 52 |
| 2 | 5 | 53 |
| 3 | 3 | 54 |
| 4 | 7 | 56 |
| 5 | 7 | 55 |

**Explanation**:
- 7 book adoptions across courses
- Course 1 (OOP): 3 adopted books - ISBN 50 (Sem 2), 51 (Sem 3), 52 (Sem 4) - comprehensive textbook adoption pattern
- Course 2 (FEWD): 1 book - ISBN 53 (Sem 5)
- Course 3 (PYTHON): 1 book - ISBN 54 (Sem 3)
- Course 4 (MP): 1 book - ISBN 56 (Sem 7)
- Course 5 (OS): 1 book - ISBN 55 (Sem 7)
- Multiple books per course indicate comprehensive coverage (OOP uses 3 books)

---

## Query Results with Explanations

### Query 1 Result: Text Books for CS Department Courses Using More Than 2 Books

**Query Purpose**: Find books (ISBN, Title) for CS department courses that use more than 2 textbooks, sorted alphabetically

| COURSE | BOOKISBN | BOOK_TITLE |
|--------|----------|------------|
| 1 | 52 | B |
| 1 | 50 | A |
| 1 | 51 | C |
| 3 | 54 | F |
| 2 | 53 | H |

**Result Explanation**:
- **Course 1 (OOP)**: Has 3 books (50=A, 51=C, 52=B), meets >2 requirement ✓
- **Course 3 (PYTHON)**: Has 1 book, doesn't meet >2 requirement ✗
- **Course 2 (FEWD)**: Has 1 book, doesn't meet >2 requirement ✗
- Only **Course 1** qualifies with 3 adopted books
- Books listed in alphabetical order by title: A, B, C
- 3 books for CS department course 1: A (ISBN 50), B (ISBN 52), C (ISBN 51)

---

### Query 2 Result: Departments with All Adopted Books from Same Publisher

**Query Purpose**: List departments where ALL adopted books are published by a specific publisher

| DEPT |
|------|
| CS |

**Result Explanation**:
- **CS Department** all books (6 books: ISBN 50, 51, 52, 53, 54, and 3 other adoptions) published by "TOM" ✓
- Course 1: Books 50, 51, 52 - all from TOM ✓
- Course 2: Book 53 - from TOM ✓
- Course 3: Book 54 - from TOM ✓
- **ENC Department**: 1 book ISBN 56 - publisher "JAM" (not uniform)
- **EEE Department**: 1 book ISBN 55 - publisher "JIM" (different from TOM)
- Result: Only CS department has all adopted books from a single publisher (TOM)

---

### Query 3 Result: Books for Department with Maximum Student Enrollment

**Query Purpose**: List books adopted by the department with the highest number of students enrolled

| BOOKISBN | TITLE |
|----------|-------|
| 50 | A |
| 51 | C |
| 52 | B |

**Result Explanation**:
- **CS Department** has maximum students enrolled (3 students: JOHN, JIM, JAM)
  - JOHN (101): Course 1 (OOP)
  - JIM (102): Course 1 (OOP)
  - JAM (103): Course 2 (FEWD)
- **ENC Department**: 1 student (JINNY/104)
- **EEE Department**: 1 student (JEMS/105)
- Books adopted in CS department: ISBN 50, 51, 52 (all for Course 1 - OOP)
- These are the primary textbooks for the most popular department
- CS leads with highest enrollment count

---

## Data Relationships Summary

**Key Relationships**:
```
STUDENT (one-to-many) → ENROLL (many-to-many) → COURSE
COURSE (one-to-many) → BOOK_ADAPTION (many-to-many) → TEXT
```

**Enrollment Flow**:
- Students enroll in courses through ENROLL table
- Each course has adopted textbooks through BOOK_ADAPTION
- COURSE contains DEPT for departmental organization
- TEXT books are related to COURSE via BOOK_ADAPTION

**Query Insights**:
- CS department is most popular with 3 course adoptions and highest enrollment
- OOP course is most comprehensive with 3 adopted textbooks
- Books are primarily published by "TOM" publisher
- Student performance ranges from excellent (99) to poor (39)
