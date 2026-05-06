# DBMS Viva Questions and Answers

## 1. DBMS Basics

### 1. What is normalization?
Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity.

### 2. What are constraints in DBMS?
Constraints are rules applied to table columns to maintain data accuracy and consistency.

### 3. What is a primary key?
A primary key is a column or set of columns that uniquely identifies each row in a table.

### 4. What is a foreign key?
A foreign key is a column that refers to the primary key of another table and establishes a relationship between tables.

### 5. What is a unique constraint?
A unique constraint ensures that all values in a column are different.

### 6. What is a NOT NULL constraint?
A NOT NULL constraint ensures a column cannot contain empty values.

### 7. What is a CHECK constraint?
A CHECK constraint ensures that values in a column satisfy a specific condition.

### 8. What is DBMS?
A DBMS (Database Management System) is software used to define, create, maintain, and manipulate databases efficiently.

### 9. What is a database?
A database is an organized collection of data stored in a way that supports efficient retrieval and manipulation.

### 10. Give examples of DBMS.
MySQL, PostgreSQL, Oracle, SQL Server, and SQLite.

## 2. Normalization

### 11. What is 1NF?
A table is in 1NF if each cell contains only atomic values, each column has a unique name, and there are no repeating groups.

### 12. What is 2NF?
A table is in 2NF if it is in 1NF and every non-key attribute depends on the whole primary key, not just part of it.

### 13. What is 3NF?
A table is in 3NF if it is in 2NF and has no transitive dependency among non-key attributes.

### 14. What is BCNF?
BCNF is a stronger form of 3NF. For every non-trivial functional dependency X -> Y, X must be a superkey.

### 15. What is functional dependency?
Functional dependency means one attribute determines another attribute.

### 16. What is partial dependency?
Partial dependency occurs when a non-key attribute depends on only part of a composite primary key.

### 17. What is transitive dependency?
Transitive dependency occurs when a non-key attribute depends on another non-key attribute.

### 18. What is denormalization?
Denormalization is the process of adding redundancy to a database to improve performance.

## 3. DBMS vs File System

### 19. What are the advantages of DBMS over a file system?
DBMS reduces redundancy, improves consistency, provides security, supports multi-user access, and allows better data management.

### 20. What is data independence?
Data independence is the ability to change the schema at one level without affecting the next higher level.

### 21. What are the types of data independence?
Physical data independence and logical data independence.

### 22. What is metadata?
Metadata is data about data, such as table structure, column names, and data types.

## 4. Schema and Instance

### 23. What is a database schema?
A schema is the logical structure of a database, including tables, relationships, and constraints.

### 24. What is a database instance?
An instance is the actual data stored in the database at a particular time.

### 25. What is the difference between schema and instance?
Schema is the design of the database, while instance is the current data inside it.

## 5. ER Model

### 26. What is the ER model?
The ER (Entity-Relationship) model is a conceptual model used to design databases using entities, attributes, and relationships.

### 27. What is an entity?
An entity is a real-world object that can be uniquely identified.

### 28. What is an entity set?
An entity set is a collection of similar entities.

### 29. What are attributes?
Attributes are properties of an entity, such as name, age, or salary.

### 30. What are the types of attributes?
Simple, composite, derived, and multivalued attributes.

### 31. What is a weak entity?
A weak entity cannot be uniquely identified by its own attributes and depends on another entity.

### 32. What is a strong entity?
A strong entity can be identified independently using its own key.

### 33. What is cardinality in ER model?
Cardinality defines the number of instances of one entity associated with another entity, such as 1:1, 1:N, or M:N.

### 34. What is aggregation?
Aggregation is a way of treating a relationship as an entity for modeling purposes.

## 6. Relational Model

### 35. What is a relation?
A relation is a table in the relational database model.

### 36. What is a tuple?
A tuple is a row in a table.

### 37. What is an attribute?
An attribute is a column in a table.

### 38. What is degree in a relation?
Degree is the number of columns in a table.

### 39. What is cardinality in a relation?
Cardinality is the number of rows in a table.

### 40. What are keys in DBMS?
Keys are attributes used to uniquely identify records or establish relationships.

### 41. What is a candidate key?
A candidate key is a set of attributes that can uniquely identify a row and may become the primary key.

### 42. What is a super key?
A super key is a set of attributes that uniquely identifies a row.

### 43. What is the difference between primary key and unique key?
A primary key does not allow NULL values and only one primary key exists per table. A unique key allows NULL values and multiple unique keys can exist.

### 44. What is referential integrity?
Referential integrity ensures that foreign key values must match valid primary key values in the referenced table.

## 7. SQL Basics

### 45. What is SQL?
SQL (Structured Query Language) is used to communicate with relational databases.

### 46. What are the types of SQL commands?
DDL, DML, DQL, TCL, and DCL.

### 47. What is DDL?
DDL (Data Definition Language) is used to define and modify database structure.

### 48. What are DDL commands?
CREATE, ALTER, DROP, TRUNCATE, and RENAME.

### 49. What is DML?
DML (Data Manipulation Language) is used to insert, update, and delete data.

### 50. What are DML commands?
INSERT, UPDATE, and DELETE.

### 51. What is DQL?
DQL (Data Query Language) is used to retrieve data from a database.

### 52. What is the main DQL command?
SELECT.

### 53. What is TCL?
TCL (Transaction Control Language) manages transactions in a database.

### 54. What are TCL commands?
COMMIT, ROLLBACK, and SAVEPOINT.

### 55. What is DCL?
DCL (Data Control Language) is used to control access to data.

### 56. What are DCL commands?
GRANT and REVOKE.

### 57. What is the command to create a database?
CREATE DATABASE database_name;

### 58. What is the command to display all records from a table?
SELECT * FROM table_name;

### 59. What is the purpose of DISTINCT?
DISTINCT is used to return only unique values.

### 60. Which clause is used to filter records?
WHERE is used to filter rows based on a condition.

### 61. What is the difference between WHERE and HAVING?
WHERE filters rows before grouping, while HAVING filters groups after grouping.

### 62. What is a subquery?
A subquery is a query inside another query.

### 63. What is a view?
A view is a virtual table based on the result of a query.

### 64. What is GROUP BY used for?
GROUP BY is used to group rows that have the same values.

## 8. Table Operations

### 65. What does DELETE do?
DELETE removes selected rows from a table.

### 66. What does TRUNCATE do?
TRUNCATE removes all rows from a table quickly.

### 67. What does DROP do?
DROP removes the table or database structure completely.

### 68. What is the difference between DELETE and TRUNCATE?
DELETE removes selected rows and can be rolled back in many systems. TRUNCATE removes all rows quickly and is generally treated as a DDL operation.

### 69. What is the purpose of ALTER TABLE?
ALTER TABLE is used to modify the structure of an existing table.

### 70. How do you add a new column?
Use ALTER TABLE table_name ADD column_name data_type;

### 71. How do you remove a column?
Use ALTER TABLE table_name DROP COLUMN column_name;

### 72. How do you update a row?
Use UPDATE table_name SET column_name = value WHERE condition;

## 9. Example SQL Operations

### 73. How do you delete a row?
DELETE FROM employees WHERE id = 2;

### 74. How do you modify a row?
UPDATE employees SET age = 40 WHERE id = 1;

### 75. How do you add a salary column?
ALTER TABLE employees ADD COLUMN salary DECIMAL(10,2);

### 76. How do you remove the age column?
ALTER TABLE employees DROP COLUMN age;

## 10. Joins and Relationships

### 77. What is a JOIN?
A JOIN combines rows from two or more tables based on related columns.

### 78. What are the types of JOINs?
INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN.

## 11. Transactions and Concurrency

### 79. What is a transaction?
A transaction is a set of operations executed as a single unit of work.

### 80. What are the ACID properties?
ACID stands for Atomicity, Consistency, Isolation, and Durability.

### 81. What is concurrency control?
Concurrency control manages simultaneous access to the database by multiple users.

### 82. What is a deadlock?
A deadlock occurs when two or more transactions wait for each other indefinitely.

### 83. What is locking?
Locking is a mechanism used to control concurrent access to database objects.

### 84. What is two-phase locking (2PL)?
Two-phase locking is a protocol that divides transaction locking into a growing phase and a shrinking phase.

## 12. Indexing

### 85. What is indexing?
Indexing is a technique used to improve the speed of data retrieval.

### 86. What are the types of indexing?
Primary, secondary, clustered, and non-clustered indexing.

### 87. What is the difference between clustered and non-clustered index?
A clustered index stores data physically in sorted order, while a non-clustered index stores a separate structure that points to the data.

### 88. What are B-tree and B+ tree?
B-tree and B+ tree are balanced tree structures used for indexing.

## 13. Database Applications

### 89. Where are databases used?
Databases are used in e-commerce, banking, healthcare, social media, online shopping, and many other fields.

### 90. Where is DBMS used?
DBMS is used in finance, retail, telecom, web applications, mobile apps, analytics, and data security systems.

## 14. Types of Databases

### 91. What are the types of databases?
Hierarchical, network, relational, and NoSQL databases.

### 92. What is NoSQL?
NoSQL refers to non-relational databases designed for flexible data storage.

## 15. Advanced Topics

### 93. What is the CAP theorem?
The CAP theorem states that a distributed system can provide only two of the three guarantees at the same time: Consistency, Availability, and Partition Tolerance.

### 94. What is data warehousing?
Data warehousing is a system used to store and analyze historical data from multiple sources.

### 95. What is OLTP?
OLTP (Online Transaction Processing) supports day-to-day transactional operations.

### 96. What is OLAP?
OLAP (Online Analytical Processing) is used for analysis and decision-making.

### 97. What is sharding?
Sharding is the process of splitting a database into smaller parts across multiple servers.

### 98. What is replication?
Replication is the process of copying data across multiple systems for availability and reliability.

## 16. Quick One-Mark Answers

### 99. What is normalization?
Organizing data to reduce redundancy.

### 100. What is a foreign key?
A field that refers to the primary key of another table.

### 101. What is the purpose of GROUP BY?
To group rows with similar values.

### 102. What is the difference between schema and instance?
Schema is structure; instance is current data.

### 103. What is the purpose of DISTINCT?
To return unique values.

### 104. What is the purpose of WHERE?
To filter records based on a condition.

### 105. What is a primary key?
A unique identifier for each record in a table.

### 106. What is DBMS?
Software used to store, manage, and retrieve data efficiently.

## 17. Short Revision Points

### 107. What is the order of normal forms?
1NF, 2NF, 3NF, BCNF.

### 108. What is the meaning of 1NF?
No repeating groups and all attributes are atomic.

### 109. What is the meaning of 2NF?
No partial dependency.

### 110. What is the meaning of 3NF?
No transitive dependency.

### 111. What is the meaning of BCNF?
Every determinant is a candidate key.

### 112. What is the difference between row and column?
A row is a tuple, and a column is an attribute.

### 113. What is the difference between primary key and candidate key?
A candidate key is any key that can uniquely identify a row; the primary key is the selected candidate key.

### 114. What is the difference between DELETE, TRUNCATE, and DROP?
DELETE removes selected rows, TRUNCATE removes all rows quickly, and DROP removes the table itself.

### 115. What is the command to create a table?
CREATE TABLE table_name (...);

### 116. What is the command to modify a table?
ALTER TABLE table_name ...;

### 117. What is the command to remove a table?
DROP TABLE table_name;

### 118. What is the command to insert data?
INSERT INTO table_name VALUES (...);

### 119. What is the command to change data?
UPDATE table_name SET ... WHERE ...;

### 120. What is the command to remove data?
DELETE FROM table_name WHERE ...;

---

## Final Summary
These questions cover DBMS basics, normalization, constraints, ER model, relational model, SQL, transactions, indexing, and advanced database concepts for viva preparation.
