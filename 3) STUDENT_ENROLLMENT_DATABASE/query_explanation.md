# Student Enrollment Database - Query Explanations

## Overview

This document provides comprehensive explanations for all 3 queries in the Student Enrollment Database system.

---

## Query 1: Text Books for CS Department Courses Using More Than 2 Books

### Purpose
Produce a list of text books (include Course #, Book-ISBN, Book-title) in alphabetical order for courses offered by the 'CS' department that use more than two books.

### SQL Query

```sql
SELECT C.COURSEID AS COURSE, T.BOOKISBN AS BOOKISBN, T.TITLE AS BOOK_TITLE 
FROM COURSE C
JOIN BOOK_ADAPTION B ON C.COURSEID = B.COURSEID
JOIN TEXT T ON T.BOOKISBN = B.BOOKISBN
WHERE C.DEPT = 'CS'
  AND B.COURSEID IN (
        SELECT COURSEID 
        FROM BOOK_ADAPTION 
        GROUP BY COURSEID 
        HAVING COUNT(DISTINCT BOOKISBN) > 2
    )
ORDER BY T.TITLE;
```

### Tables Used

| Table | Alias | Purpose |
|-------|-------|---------|
| **COURSE** | C | Contains course information and department mapping |
| **BOOK_ADAPTION** | B | Links courses to adopted textbooks |
| **TEXT** | T | Contains textbook details (ISBN, title, publisher, author) |

### Why These Tables?
- **COURSE table**: Required to filter by department ('CS') and identify courses
- **BOOK_ADAPTION table**: Required to determine which books are adopted for each course and count adoptions
- **TEXT table**: Required to retrieve book titles and ISBN numbers for output

### Logic Flow

1. **Start with COURSE table**: Identify all courses
2. **Filter by Department**: Keep only courses where DEPT='CS'
3. **Find courses with >2 books**: Use subquery to count distinct books per course
4. **Join with BOOK_ADAPTION**: Link courses to their adopted books
5. **Join with TEXT**: Get book details (ISBN and Title)
6. **Sort alphabetically**: Order results by book title

### Expected Output

Multiple rows with columns:
- COURSE: Course ID
- BOOKISBN: Book ISBN number
- BOOK_TITLE: Book title (alphabetically sorted)

### Database Schema Reference

```
COURSE (COURSEID, CNAME, DEPT)
  ↓ (has many)
BOOK_ADAPTION (COURSEID, SEM, BOOKISBN)
  ↓ (references)
TEXT (BOOKISBN, TITLE, PUBLISHER, AUTHOR)
```

### Key Concepts

- **Subquery**: Used to identify courses with >2 books BEFORE joining
- **COUNT(DISTINCT BOOKISBN)**: Ensures each book is counted only once per course
- **HAVING Clause**: Filters aggregated results (groups with >2 books)
- **Multiple JOINs**: Connects three tables to retrieve complete book information
- **ORDER BY**: Ensures consistent alphabetical output

---

## Query 2: Departments with All Adopted Books from Same Publisher

### Purpose
List any department that has all its adopted books published by a specific publisher.

### SQL Query

```sql
SELECT DISTINCT C.DEPT 
FROM COURSE C 
WHERE NOT EXISTS(
    SELECT B.BOOKISBN 
    FROM BOOK_ADAPTION B, COURSE C1 
    WHERE B.COURSEID = C1.COURSEID 
    AND C.DEPT = C1.DEPT 
    AND B.BOOKISBN NOT IN (
        SELECT B1.BOOKISBN  
        FROM TEXT T, BOOK_ADAPTION B1
        WHERE B1.BOOKISBN = T.BOOKISBN 
        AND T.PUBLISHER = 'TOM'
    )
);
```

### Tables Used

| Table | Alias | Purpose |
|-------|-------|---------|
| **COURSE** | C, C1 | Identifies courses and their departments |
| **BOOK_ADAPTION** | B, B1 | Links courses to adopted textbooks |
| **TEXT** | T | Contains publisher information for books |

### Why These Tables?
- **COURSE table**: Provides department grouping and department filtering
- **BOOK_ADAPTION table**: Shows which books are adopted in each department's courses
- **TEXT table**: Contains publisher information needed to check book publishers

### Logic Flow

1. **Start with COURSE table**: Get all unique departments
2. **NOT EXISTS subquery**: Check if department has ANY book NOT from specific publisher
3. **Inner subquery**: Find all books published by 'TOM' publisher
4. **Filtering**: Keep only departments where ALL books come from the specified publisher
5. **DISTINCT**: Remove duplicate departments from result

### Expected Output

Multiple rows (0 or more departments) with single column:
- DEPT: Department name that meets the criteria

### Database Schema Reference

```
COURSE (COURSEID, CNAME, DEPT)
  ↓ (has many)
BOOK_ADAPTION (COURSEID, SEM, BOOKISBN)
  ↓ (references)
TEXT (BOOKISBN, TITLE, PUBLISHER, AUTHOR)
```

### Key Concepts

- **NOT EXISTS**: Checks for non-existence condition (inverse logic)
- **Subquery nesting**: Multiple levels of subqueries for complex filtering
- **DISTINCT**: Removes duplicate department names
- **Set operations**: Uses NOT IN to exclude books not from specific publisher
- **Logical negation**: "NOT has any books from other publishers" = "ALL books from same publisher"

### Query Behavior Notes

- **Publisher filter**: Currently hardcoded to 'TOM' - can be parameterized
- **Extensible**: Can be modified to check any specific publisher
- **All-or-nothing logic**: Department qualifies only if 100% of books match publisher

---

## Query 3: Books for Department with Maximum Student Enrollment

### Purpose
List the bookISBNs and book titles of the department that has the maximum number of students enrolled.

### SQL Query

```sql
SELECT T.BOOKISBN, T.TITLE 
FROM COURSE C, BOOK_ADAPTION B, TEXT T 
WHERE C.COURSEID = B.COURSEID 
AND B.BOOKISBN = T.BOOKISBN  
AND C.DEPT IN (
    SELECT C.DEPT 
    FROM COURSE C, ENROLL E 
    WHERE C.COURSEID = E.COURSEID 
    GROUP BY C.DEPT 
    HAVING COUNT(E.REGNO) >= ALL (
        SELECT COUNT(E.REGNO) 
        FROM COURSE C, ENROLL E 
        WHERE C.COURSEID = E.COURSEID 
        GROUP BY C.DEPT
    )
);
```

### Tables Used

| Table | Alias | Purpose |
|-------|-------|---------|
| **COURSE** | C | Provides course information and department mapping |
| **ENROLL** | E | Contains student enrollment records |
| **BOOK_ADAPTION** | B | Links courses to adopted textbooks |
| **TEXT** | T | Contains textbook details (ISBN and title) |

### Why These Tables?
- **COURSE table**: Maps courses to departments and provides course-book relationships
- **ENROLL table**: Contains enrollment data needed to count students per department
- **BOOK_ADAPTION table**: Shows which books are adopted in each course
- **TEXT table**: Provides book details for output (ISBN and title)

### Logic Flow

1. **Count students per department**: GROUP BY department and COUNT enrollments
2. **Find maximum**: Use nested subquery to find department with highest count
3. **Use >= ALL**: Identifies department with enrollment count >= all other departments
4. **Get department courses**: Find all courses in that department
5. **Get adopted books**: Retrieve all books adopted by those courses
6. **Output book details**: Select ISBN and title for those books

### Expected Output

Multiple rows with columns:
- BOOKISBN: Book ISBN number
- TITLE: Book title

### Database Schema Reference

```
STUDENT (one-to-many)
  ↓
ENROLL ← joined with → COURSE (has many)
  ↓
  └→ counted by DEPT
  
COURSE (one-to-many)
  ↓
BOOK_ADAPTION (many-to-many) → TEXT
```

### Key Concepts

- **Aggregate function**: COUNT(E.REGNO) counts student enrollments
- **GROUP BY DEPT**: Aggregates data at department level
- **ALL operator**: >= ALL() finds maximum value across groups
- **Subquery**: Multi-level nesting for complex aggregation logic
- **Join conditions**: Multiple joins link enrollment to textbooks through courses

### Expected Result Characteristics

- **Single department result**: Only books from top enrollment department
- **Multiple books possible**: If department courses adopt multiple books
- **Enrollment tie handling**: >= ALL handles ties by returning all tied departments' books
- **Derived information**: Books are indirectly related through enrollment

### Query Optimization Notes

- **Correlated subquery**: Inner queries reference outer query columns
- **Multiple aggregations**: COUNT operations at different levels
- **Join pattern**: Connects enrollment data to textbook data through courses

---

## Summary Comparison

| Aspect | Query 1 | Query 2 | Query 3 |
|--------|---------|---------|---------|
| **Primary Goal** | Find books by criteria | Find departments by constraint | Find books by enrollment metric |
| **Main Filter** | Department='CS' AND >2 books | All books same publisher | Max enrollment department |
| **Complexity** | Medium (1 subquery) | High (nested negation logic) | High (nested aggregation) |
| **Output Type** | Course-specific books | Department list | Department-specific books |
| **Key Technique** | COUNT with HAVING | NOT EXISTS logic | MAX via ALL operator |

