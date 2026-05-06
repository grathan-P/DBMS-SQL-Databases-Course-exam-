# DBMS SQL Course - Database Projects

This repository contains five comprehensive SQL database projects, each demonstrating different concepts and query patterns.

---

## Databases Included

### 1. **INSURANCE_DATABASE**

Consider the Insurance database given below.

**TABLE SCHEMA:**
- PERSON (driver-id #: String, name: string, address: string)
- CAR (regno#: string, model: string, year: int)
- ACCIDENT (report-number#: int, accd-date: date, location: string)
- OWNS (driver-id #: string, regno#: string)
- PARTICIPATED (driver-id#: string, Regno#: string, report-number#: int, damage amount: int)

**QUERIES TO BE EXECUTED:**
1. Find the total number of people who owned cars that were involved in accidents in 1989.
2. Find the number of accidents in which the cars belonging to "John Smith" were involved.
3. Update the damage amount for the car with reg number "KA-12" in the accident with report number "1" to $3000

### 2. **ORDER_DATABASE**

Consider the following relations for an order processing database application in a company.

**TABLE SCHEMA:**
- CUSTOMER (cust #: int, cname: string, city: string)
- ORDER (order #: int, odate: date, cust : int, ord-Amt: int)
- ORDER–ITEM (order #: int, item #: int, qty: int)
- ITEM (item #: int, unit price: int)
- SHIPMENT (order #: int, warehouse#: int, ship-date: date)
- WAREHOUSE (warehouse #: int, city: string)

**QUERIES TO BE EXECUTED:**
1. Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total numbers of orders by the customer and the last column is the average order amount for that customer.
2. For each item that has more than two orders, list the item, number of orders that are shipped from at least two warehouses and total quantity of items shipped.
3. List the customers who have ordered for every item that the company produces 


### 3. **STUDENT_ENROLLMENT_DATABASE**

Consider the following database of student enrollment in courses & books adopted for each course.

**TABLE SCHEMA:**
- STUDENT (regno#: string, name: string, major: string, bdate: date)
- COURSE (course #: int, cname: string, dept: string)
- ENROLL (regno#: string, course#: int, sem#: int marks: int)
- BOOK_ADAPTION (course#: int, sem#: int, book-ISBN#: int)
- TEXT (book-ISBN#: int, book-title: string, publisher: string, author: string)

**QUERIES TO BE EXECUTED:**
1. Produce a list of text books (include Course #, Book-ISBN, Book-title) in the alphabetical order for courses offered by the 'CS' department that use more than two books.
2. List any department that has all its adopted books published by a specific publisher.
3. List the bookISBNs and book titles of the department that has maximum number of students.  


### 4. **AUTHOR_DATABASE**

The following tables are maintained by a book dealer.

**TABLE SCHEMA:**
- AUTHOR (author-id#: int, name: string, city: string, country: string)
- PUBLISHER (publisher-id#: int, name: string, city: string, country: string)
- CATALOG (book-id#: int, title: string, author-id: int, publisher-id: int, category-id: int, year: int, price: int)
- CATEGORY (category-id#: int, description: string)
- ORDERDETAILS (order-no#: int, book-id#: int, quantity: int)

**QUERIES TO BE EXECUTED:**
1. Find the author of the book which has maximum sales.
2. Increase the price of the books published by a specific publisher by 10%.
3. Find the number of orders for the book that has minimum sales.  


### 5. **BANK_DATABASE**

Consider the following database for a banking enterprise.

**TABLE SCHEMA:**
- BRANCH (branch-name#: string, branch-city: string, assets: real)
- ACCOUNT (accno#: int, branch-name: string, balance: real)
- DEPOSITOR (customer-name#: string, accno#: int)
- CUSTOMER (customer-name#: string, customer-street: string, customer-city: string)
- LOAN (loan-number#: int, branch-name: string, amount: real)
- BORROWER (customer-name#: string, loan-number#: int)

**QUERIES TO BE EXECUTED:**
1. Find all customers who have at least 2 accounts at all branches located in a specific city.
2. Find all customers who have accounts in at least 1 branch located in all cities.
3. Find all customers who have accounts in at least 2 branches located in a specific city.  


---

## Project Structure

Each database folder contains:
- `*.sql` - SQL script with database creation and queries
- `output.md` - Query results and table outputs
- `output_with_explanation.md` - Detailed explanations of outputs
- `query_explanation.md` - In-depth query logic and concepts

---

## Key SQL Concepts Covered

- Complex JOIN operations
- Subqueries and nested queries
- Aggregation functions (COUNT, SUM, AVG)
- NOT EXISTS, EXISTS logic
- GROUP BY and HAVING clauses
- Set operations and comparisons
- Foreign key relationships
- Data insertion and retrieval