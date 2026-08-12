-- =============================================
-- ReflectAI — SQL Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'SQL' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to SQL & Relational Databases
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to SQL & Relational Databases', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to SQL & Relational Databases

## Introduction to SQL and Relational Databases

Every modern application stores data. Whether it is a social media platform, an online shopping website, a banking system, or a university management system, data is the foundation of everything. However, storing data is only half the job. We also need an efficient way to organize, retrieve, update, and secure that data. This is where **Relational Databases** and **SQL (Structured Query Language)** come into play. Think of a relational database as a digital filing cabinet. Instead of keeping information scattered across different files, it organizes data into structured tables. SQL acts as the language that allows us to communicate with the database. Just as we use English to communicate with people, we use SQL to communicate with databases. Today, SQL is one of the most important skills for software developers, data analysts, database administrators, and AI engineers because almost every organization relies on databases to manage information.

## Understanding Relational Databases

### What is a Database?

A **database** is an organized collection of related data that can be easily stored, managed, and retrieved electronically. **Example** A university database may contain information about:

- Students

- Teachers

- Courses

- Departments

- Results

Instead of storing everything in one huge file, databases organize information into multiple tables.

### What is a Relational Database?

A **Relational Database** stores data in the form of **tables** (also called relations). Each table contains:

- **Rows (Records):** Individual pieces of information.

- **Columns (Fields):** Categories or attributes describing the information.

**Example: Student Table**

| StudentID | Name | Department | Age |
|---|---|---|---|
| 101 | Ali | AI | 20 |
| 102 | Sara | CS | 21 |
| 103 | Ahmed | SE | 22 |

In this table:

- Each row represents one student.

- Each column represents one characteristic of the student.

This simple structure makes data easy to understand and manage. Humans love organizing things into neat boxes. Databases politely indulge that habit.

### Characteristics of Relational Databases

A relational database:

- Stores data in tables.

- Uses rows and columns.

- Maintains relationships between tables.

- Reduces duplicate data.

- Ensures consistency and accuracy.

- Supports fast searching and reporting.

Popular relational database systems include:

- MySQL

- MariaDB

- PostgreSQL

- Oracle Database

- Microsoft SQL Server

- SQLite

## Introduction to SQL

### What is SQL?

**SQL (Structured Query Language)** is the standard language used to interact with relational databases. Using SQL, we can:

- Create databases

- Create tables

- Insert data

- Update data

- Delete data

- Retrieve data

- Control user permissions

SQL is declarative, meaning we tell the database **what** we want rather than **how** to do it. The database engine figures out the most efficient way to execute the request.

### Why Do We Need SQL?

Imagine a university with 20,000 students. Suppose the principal asks: "Show all students from the AI department." Without SQL, someone might search thousands of records manually. With SQL, a single query retrieves the result in seconds. Example:

```

SELECT * FROM Students
WHERE Department = \'AI\';

```

This command tells the database:

- Look inside the **Students** table.

- Find students whose department is **AI**.

- Display their records.

### Features of SQL

SQL is popular because it is:

- Easy to learn

- Powerful

- Standardized

- Fast

- Flexible

- Portable across different database systems

Although database systems have slight differences, the core SQL syntax remains largely the same.

## Components of a Relational Database

### 1. Tables

Tables store related data. Example: **Students**

| StudentID | Name | Semester |
|---|---|---|
| 101 | Ali | 2 |
| 102 | Sara | 4 |

### 2. Rows (Records)

Each row represents one complete record. Example: |101|Ali|2| This row contains all information about one student.

### 3. Columns (Fields)

Columns define the type of information stored. Example:

- StudentID

- Name

- Semester

Every row contains values for these columns.

### 4. Primary Key

A **Primary Key** uniquely identifies every record in a table. Example: StudentID No two students can have the same StudentID. Example:

| StudentID | Name |
|---|---|
| 101 | Ali |
| 102 | Sara |

StudentID is unique.

### 5. Foreign Key

A **Foreign Key** connects one table to another. Example: **Students**

| StudentID | Name | DepartmentID |
|---|---|---|
| 101 | Ali | 1 |
| 102 | Sara | 2 |

**Departments**

| DepartmentID | DepartmentName |
|---|---|
| 1 | AI |
| 2 | CS |

DepartmentID links both tables together.

### Relationships Between Tables

There are three common relationships: **One-to-One (1:1)** One record is related to exactly one record. Example: One student has one library card. **One-to-Many (1:M)** One record relates to many others. Example: One teacher teaches many students. **Many-to-Many (M:N)** Many records relate to many others. Example: Students enroll in multiple courses, and each course has multiple students. This relationship is usually implemented using a junction table. SQL commands are generally divided into categories.

### 1. DDL (Data Definition Language)

Used to define database structure. **CREATE** Creates a new table.

```

CREATE TABLE Students (
StudentID INT,
Name VARCHAR(50),
Age INT
);

```

**ALTER** Modifies an existing table.

```

ALTER TABLE Students
ADD Email VARCHAR(100);

```

**DROP** Deletes a table permanently.

```

DROP TABLE Students;

```

**TRUNCATE** Deletes all rows from a table but keeps the table structure.

```

TRUNCATE TABLE Students;

```

### 2. DML (Data Manipulation Language)

Used to work with data inside tables. **INSERT** Adds new records.

```

INSERT INTO Students
VALUES (101,\'Ali\',20);

```

**UPDATE** Modifies existing records.

```

UPDATE Students
SET Age = 21
WHERE StudentID = 101;

```

**DELETE** Removes records.

```

DELETE FROM Students
WHERE StudentID = 101;

```

### 3. DQL (Data Query Language)

Used to retrieve data. **SELECT** Displays data.

```

SELECT * FROM Students;

```

Retrieve only specific columns:

```

SELECT Name, Age
FROM Students;

```

### 4. DCL (Data Control Language)

Controls user permissions. Examples:

- `GRANT`

- `REVOKE`

These commands manage who can access or modify database objects.

### 5. TCL (Transaction Control Language)

Manages transactions. Commands include:

- COMMIT

- ROLLBACK

- SAVEPOINT

These ensure data remains consistent, especially when multiple operations are performed together.

## Common SQL Queries

### Filtering Data

```

SELECT *
FROM Students
WHERE Age > 20;

```

Returns students older than 20.

### Sorting Data

```

SELECT *
FROM Students
ORDER BY Name;

```

Sorts students alphabetically.

### Limiting Results

```

SELECT *
FROM Students
LIMIT 5;

```

Displays only the first five records. (In SQL Server, `TOP` is commonly used instead.)

### Counting Records

```

FROM Students;

```

Counts the total number of students.

### Finding Maximum Value

```

SELECT MAX(Age)
FROM Students;

```

Finds the oldest student\'s age.

### Finding Minimum Value

```

SELECT MIN(Age)
FROM Students;

```

Finds the youngest student\'s age.

### Calculating Average

```

SELECT AVG(Age)
FROM Students;

```

Calculates the average age of students.

## Advantages of Relational Databases

Relational databases provide many benefits:

- Organized data storage

- Reduced redundancy through normalization

- High data integrity

- Easy data retrieval

- Secure access control

- Support for multiple users simultaneously

- Reliable backup and recovery

- Scalability for growing applications

These advantages explain why relational databases remain a core technology despite the rise of newer database models.

## Real-World Applications

Relational databases are used in nearly every industry. **Banking**

- Customer accounts

- Transactions

- Loan records

**Hospitals**

- Patient records

- Doctors

- Appointments

- Prescriptions

**Universities**

- Student registration

- Courses

- Attendance

- Grades

**E-Commerce**

- Products

- Customers

- Orders

- Payments

**Social Media**

- User profiles

- Posts

- Comments

- Friend connections

Behind every click, purchase, or login, there is usually a database quietly doing its job. It rarely gets applause. Storage systems have accepted that they are the stage crew of computing.

## Best Practices When Working with SQL Databases

To build efficient and reliable databases, we should:

- Choose meaningful table and column names.

- Define primary keys for every table.

- Use foreign keys to maintain relationships.

- Avoid storing duplicate data.

- Validate data before inserting it.

- Create backups regularly.

- Restrict database access to authorized users.

- Write clear and readable SQL queries.

- Optimize queries for better performance as data grows.

Following these practices makes databases easier to maintain and reduces the chances of errors.

### Conclusion

SQL and relational databases form the backbone of modern information systems. A relational database organizes data into tables with clearly defined relationships, making information easy to store, retrieve, and manage. SQL provides a simple yet powerful language to create database structures, manipulate records, retrieve information, and control access. Understanding concepts such as tables, rows, columns, primary keys, foreign keys, relationships, and basic SQL commands is essential for anyone entering software development, data analysis, artificial intelligence, or database administration. Mastering these fundamentals provides a strong foundation for more advanced topics such as joins, normalization, indexing, stored procedures, and database optimization.');

-- Lecture 2: Data Types in SQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Data Types in SQL', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Data Types in SQL

## Introduction to Data Types

A **data type** specifies the kind of value that can be stored in a table column. When creating a table, we assign a data type to each column so the database knows what type of information it should accept. Think of a data type as a **container label**. You would not pour water into a box labeled "books," and similarly, you should not store text in a column meant for numbers. Choosing the correct data type helps maintain data accuracy, saves storage space, and improves query performance. **Why Are Data Types Important?**

- Ensure only valid data is stored.

- Improve database performance.

- Reduce storage requirements.

- Prevent data entry errors.

- Maintain data consistency.

## Categories of SQL Data Types

SQL data types are generally divided into the following categories:

- Numeric Data Types

- String (Character) Data Types

- Date and Time Data Types

- Boolean Data Type

- Binary Data Types (Advanced)

## Numeric Data Types

Numeric data types are used to store numbers.

### 1. INT (Integer)

Stores whole numbers without decimal points. **Range** Typically: **-2,147,483,648 to 2,147,483,647** (4 bytes) **Example** `Age INT` Valid values:

- 18

- 25

- 100

Invalid:

- 18.5

**Uses**

- Student ID

- Age

- Quantity

- Roll Number

### 2. SMALLINT

Stores smaller whole numbers than `INT`. **Example** `Semester SMALLINT` Used when the values are small, such as semester numbers (1–8).

### 3. BIGINT

Stores very large whole numbers. **Example** `Population BIGINT` Used for:

- Population

- Large transaction IDs

- Social media post IDs

### 4. FLOAT

Stores decimal (approximate) numbers. **Example** `Height FLOAT` Valid values:

- 5.8

- 72.45

- 99.99

**Uses**

- Height

- Weight

- Temperature

### 5. DOUBLE

Stores larger decimal numbers with greater precision than `FLOAT` in many database systems. **Example** `Salary DOUBLE`

### 6. DECIMAL (or NUMERIC)

Stores **exact decimal values**, making it ideal for financial calculations. **Syntax**

```

DECIMAL(total_digits, decimal_places)

```

**Example** `Salary DECIMAL(10,2)` Valid values:

- 15000.50

- 8500.75

**Why Use DECIMAL Instead of FLOAT?** `DECIMAL` stores values exactly, while `FLOAT` may introduce small rounding errors. Therefore, use **DECIMAL** for money and financial records.

## String (Character) Data Types

Character data types store letters, words, and symbols.

### 1. CHAR(n)

Stores **fixed-length** strings. **Example** `Gender CHAR(1)` Possible values:

- M

- F

If `CHAR(10)` stores `"Ali"`, the remaining characters are filled with spaces. **Best For**

- Gender

- Country Codes

- Status Codes

### 2. VARCHAR(n)

Stores **variable-length** strings. **Example** `Name VARCHAR(50)` If the name is `"Sara"`, only four characters are stored. **Uses**

- Names

- Addresses

- Email addresses

- Departments

**Difference Between CHAR and VARCHAR**

| CHAR | VARCHAR |
|---|---|
| Fixed length | Variable length |
| Faster for fixed-size values | Saves storage space |
| Pads extra spaces | Stores only entered characters |

### 3. TEXT

Stores very long text. **Example** `Description TEXT` Used for:

- Comments

- Articles

- Product descriptions

- Notes

## Date and Time Data Types

These data types store dates and times.

### 1. DATE

Stores only the date. **Format** `YYYY-MM-DD` **Example** `DOB DATE` Stored value: `2005-09-15`

### 2. TIME

Stores only time. **Format** `HH:MM:SS` **Example** `LoginTime TIME` Stored value: `10:30:45`

### 3. DATETIME

Stores both date and time. **Example** `CreatedAt DATETIME` Stored value: `2026-08-03 10:30:45` **Uses**

- Login records

- Orders

- Transactions

- Attendance

### 4. TIMESTAMP

Stores date and time and is often used to automatically record when a row is created or updated (behavior depends on the DBMS). **Example** `CreatedAt TIMESTAMP`

## Boolean Data Type

### BOOLEAN / BOOL

Stores logical values. Possible values:

- TRUE

- FALSE

Some database systems internally store these as:

- 1 = TRUE

- 0 = FALSE

**Example** `IsActive BOOLEAN` Uses:

- User status

- Availability

- Verification status

## Binary Data Types (Advanced)

Binary data types store raw binary data instead of text. Common types include:

- BINARY

- VARBINARY

- BLOB (Binary Large Object)

**Uses**

- Images

- Audio files

- Videos

- PDF documents

In practice, many modern applications store large files outside the database and save only the file path or URL in the database for better performance.

## Choosing the Correct Data Type

Selecting the right data type is important for efficiency and accuracy.

| Data | Recommended Data Type |
|---|---|
| Student ID | INT |
| Name | VARCHAR(50) |
| Gender | CHAR(1) |
| Age | INT |
| Salary | DECIMAL(10,2) |
| Height | FLOAT |
| Date of Birth | DATE |
| Login Time | TIME |
| Registration Date | DATETIME |
| Active Status | BOOLEAN |
| Description | TEXT |

## Example: Creating a Table Using Different Data Types

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Gender CHAR(1),
Age INT,
GPA DECIMAL(3,2),
Height FLOAT,
Email VARCHAR(100),
DateOfBirth DATE,
RegistrationDate DATETIME,
IsActive BOOLEAN
);

```

**Explanation**

| Column | Data Type | Purpose |
|---|---|---|
| StudentID | INT | Unique student ID |
| Name | VARCHAR(50) | Student name |
| Gender | CHAR(1) | M/F |
| Age | INT | Student age |
| GPA | DECIMAL(3,2) | Grade Point Average |
| Height | FLOAT | Student height |
| Email | VARCHAR(100) | Email address |
| DateOfBirth | DATE | Birth date |
| RegistrationDate | DATETIME | Registration date and time |
| IsActive | BOOLEAN | Active/Inactive status |

## Best Practices for Using Data Types

- Choose the smallest suitable numeric type to save storage.

- Use `VARCHAR` instead of `CHAR` for variable-length text.

- Use `CHAR` only for fixed-length values such as gender or country codes.

- Use `DECIMAL` for currency and financial calculations.

- Use `DATE`, `TIME`, or `DATETIME` instead of storing dates as text.

- Avoid using `TEXT` unless long content is necessary.

- Select appropriate data types during database design. Changing them later can be difficult if the table already contains large amounts of

data. Databases, much like humans, are not fond of major identity changes halfway through their lives.

### Conclusion

Data types are a fundamental part of SQL because they define the kind of information each column can store. Choosing the correct data type improves data integrity, reduces storage usage, prevents invalid entries, and enhances query performance. By understanding numeric, character, date/time, Boolean, and binary data types, we can design efficient and reliable databases that support real-world applications such as banking systems, universities, hospitals, and e-commerce platforms.');

-- Lecture 3: Database & Table Creation (DDL)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Database & Table Creation (DDL)', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Database & Table Creation (DDL)

## Introduction to DDL

**DDL (Data Definition Language)** is a category of SQL commands used to **create, modify, and delete** database objects such as databases and tables. Think of DDL as the **architect** of a building. Before people can live in a house, someone must design and construct it. Similarly, before storing data, we must create the database and its tables. **Common DDL Commands:**

- `CREATE`

- `ALTER`

- `DROP`

- `TRUNCATE`

- `RENAME` (supported in some DBMSs)

## Creating a Database

A **database** is a collection of related tables used to store and organize data. **Syntax**

```

CREATE DATABASE database_name;

```

**Example**

```

CREATE DATABASE UniversityDB;

```

This command creates a new database named **UniversityDB**. **Selecting the Database** Before creating tables, select the database.

```

USE UniversityDB;

```

Now, all tables created will be stored in **UniversityDB**.

## Creating a Table

A **table** is the basic storage structure in a relational database. It consists of **rows (records)** and **columns (fields)**. **Syntax**

```

CREATE TABLE table_name (
column1 datatype,
column2 datatype,
column3 datatype
);

```

**Example**

```

CREATE TABLE Students (
StudentID INT,
Name VARCHAR(50),
Age INT,
Department VARCHAR(30)
);

```

This creates a **Students** table with four columns.

| Column | Data Type | Purpose |
|---|---|---|
| StudentID | INT | Student ID |
| Name | VARCHAR(50) | Student Name |
| Age | INT | Student Age |
| Department | VARCHAR(30) | Department Name |

### Data Types

Data types define the kind of data a column can store.

| Data Type | Description | Example |
|---|---|---|
| INT | Integer numbers | 25 |
| FLOAT | Decimal numbers | 85.5 |
| VARCHAR(n) | Variable-length text | "Ali" |
| CHAR(n) | Fixed-length text | \'A\' |
| DATE | Stores dates | 2026-08-03 |
| TIME | Stores time | 10:30:00 |
| DATETIME | Stores date and time | 2026-08-03 10:30:00 |
| BOOLEAN | True or False | TRUE |

## Table Constraints

Constraints are rules applied to columns to ensure data accuracy and integrity.

### 1. PRIMARY KEY

A **Primary Key** uniquely identifies each record in a table.

- Cannot contain duplicate values.

- Cannot contain NULL values.

- Only one primary key is allowed per table.

**Example**

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT
);

```

### 2. NOT NULL

Ensures that a column must always have a value. **Example**

```

CREATE TABLE Students (
StudentID INT,
Name VARCHAR(50) NOT NULL
);

```

The **Name** column cannot be left empty.

### 3. UNIQUE

Ensures all values in a column are different. **Example**

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Email VARCHAR(100) UNIQUE
);

```

Two students cannot have the same email address.

### 4. DEFAULT

Assigns a default value if none is provided. **Example**

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Department VARCHAR(30) DEFAULT \'AI\'
);

```

If no department is entered, **AI** is stored automatically.

### 5. CHECK

Restricts the values that can be entered into a column. **Example**

```

CREATE TABLE Students (
StudentID INT,
Age INT CHECK (Age >= 18)
);

```

Only students aged **18 or above** can be added.

### 6. FOREIGN KEY

A **Foreign Key** creates a relationship between two tables. **Departments Table**

```

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(30)
);

```

**Students Table**

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
DepartmentID INT,
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
);

```

This ensures every `DepartmentID` in the **Students** table exists in the **Departments** table.

## Modifying Tables (ALTER TABLE)

The `ALTER TABLE` command is used to modify an existing table.

### Add a Column

```

ALTER TABLE Students
ADD Email VARCHAR(100);

```

Adds a new **Email** column.

### Modify a Column

```

ALTER TABLE Students
MODIFY Name VARCHAR(100);

```

Changes the size of the **Name** column.

### Drop a Column

```

ALTER TABLE Students
DROP COLUMN Email;

```

Removes the **Email** column. **Rename a Table (syntax varies by DBMS)**

```

RENAME TABLE Students TO StudentInfo;

```

Changes the table name from **Students** to **StudentInfo**.

## Deleting Database Objects

### DROP DATABASE

Deletes an entire database permanently.

```

DROP DATABASE UniversityDB;

```

**Warning:** All tables and data inside the database are permanently deleted.

### DROP TABLE

Deletes a table and all its data.

```

DROP TABLE Students;

```

The table structure and records are removed permanently.

### TRUNCATE TABLE

Deletes all records but keeps the table structure.

```

TRUNCATE TABLE Students;

```

**Difference Between** `DELETE` **,** `TRUNCATE` **, and** `DROP`

| Command | Removes Data | Removes Structure |
|---|---|---|
| DELETE | ✔ Yes | ✘ No |
| TRUNCATE | ✔ Yes | ✘ No |
| DROP | ✔ Yes | ✔ Yes |

## Best Practices for Database & Table Creation

When designing databases:

- Use meaningful database and table names.

- Define a **Primary Key** for every table.

- Use appropriate data types.

- Avoid storing duplicate data.

- Use **NOT NULL** where values are mandatory.

- Apply **FOREIGN KEY** constraints to maintain relationships.

- Keep table names consistent (e.g., `Students`, `Departments`, `Courses`).

- Design tables carefully before inserting data. Changing structures later is possible, but it is like renovating a house after moving in. It

works, but everyone involved quietly wishes it had been planned earlier.

### Conclusion

**Data Definition Language (DDL)** provides the commands needed to create and manage the structure of a relational database. Using commands like `CREATE`, `ALTER`, `DROP`, and `TRUNCATE`, we can build databases, define tables, enforce data integrity with constraints, and modify database structures as requirements evolve. A well-designed database with appropriate data types and constraints ensures accuracy, consistency, and efficient data management, making it the foundation of any reliable database application.');

-- Lecture 4: SQL Constraints
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'SQL Constraints', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# SQL Constraints

## Introduction to SQL Constraints

**Constraints** are rules applied to table columns that control the type of data that can be stored in a database. Their main purpose is to **maintain data accuracy, consistency, and integrity**. Without constraints, users could enter duplicate, invalid, or incorrect data, leading to unreliable information. Think of constraints as the **rules of a classroom**. Students must follow attendance rules, examination rules, and discipline policies. Similarly, data in a database must follow certain rules before it can be stored.

## Why Do We Need Constraints?

Constraints help to:

- Ensure data accuracy.

- Prevent duplicate records.

- Maintain relationships between tables.

- Avoid invalid data entry.

- Improve database reliability.

- Enforce business rules automatically.

**Example** Without constraints, a database might allow:

- Two students with the same Student ID.

- A student\'s age to be **-5**.

- A student assigned to a department that does not exist.

Constraints prevent such errors automatically.

## Types of SQL Constraints

The most commonly used SQL constraints are:

- **PRIMARY KEY**

- **FOREIGN KEY**

- **UNIQUE**

- **CHECK**

- **NOT NULL**

- **DEFAULT**

In these notes, we will focus on the first four constraints.

## PRIMARY KEY Constraint

A **PRIMARY KEY** uniquely identifies every record in a table. Each table should have **one primary key**, although it may consist of multiple columns (called a composite primary key).

### Characteristics

- Values must be **unique**.

- Cannot contain **NULL** values.

- Identifies each row uniquely.

- Only one primary key is allowed per table.

### Syntax

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT
);

```

### Example

**Students Table**

| StudentID | Name | Age |
|---|---|---|
| 101 | Anum | 20 |
| 102 | Saba | 21 |
| 103 | Hamza | 22 |

Here, **StudentID** is the Primary Key. The following is **not allowed**:

```

INSERT INTO Students
VALUES (101, \'Ali\', 19);

```

**Reason:** StudentID **101** already exists.

### Advantages of Primary Key

- Prevents duplicate records.

- Makes searching faster.

- Ensures every row has a unique identity.

- Supports relationships between tables.

## FOREIGN KEY Constraint

A **FOREIGN KEY** creates a relationship between two tables. It ensures that values in one table must already exist in another table.

### Example Tables

**Departments Table**

| DepartmentID | DepartmentName |
|---|---|
| 1 | Artificial Intelligence |
| 2 | Computer Science |
| 3 | Software Engineering |

**Students Table**

| StudentID | Name | DepartmentID |
|---|---|---|
| 101 | Anum | 1 |
| 102 | Saba | 2 |
| 103 | Hamza | 1 |

The **DepartmentID** in the **Students** table is a **Foreign Key** because it refers to the **DepartmentID** in the **Departments** table.

### Syntax

```

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50)
);
CREATE TABLE Students (
StudentID INT PRIMARY KEY,
DepartmentID INT,
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
);

```

### Example

The following statement is **valid**:

```

INSERT INTO Students
VALUES (104, \'Ali\', 2);

```

Department **2** exists. The following statement is **invalid**:

```

INSERT INTO Students
VALUES (105, \'Ahmed\', 10);

```

**Reason:** Department **10** does not exist in the **Departments** table.

### Advantages of Foreign Key

- Maintains relationships between tables.

- Prevents invalid references.

- Improves data consistency.

- Supports relational database design.

## UNIQUE Constraint

The **UNIQUE** constraint ensures that all values in a column are different. Unlike a Primary Key:

- Multiple UNIQUE constraints can exist in one table.

- In many database systems, a UNIQUE column can allow one or more `NULL` values (behavior may vary by DBMS).

### Syntax

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Email VARCHAR(100) UNIQUE
);

```

### Example

**Valid Records**

| StudentID | Email |
|---|---|
| 101 | anum@email.com |
| 102 | saba@email.com |
| 103 | hamza@email.com |

**Invalid Record**

```

INSERT INTO Students
VALUES (104, \'anum@email.com\');

```

**Reason:** The email address already exists.

### Uses of UNIQUE

- Email addresses

- CNIC numbers

- Passport numbers

- Employee IDs

- Username fields

## CHECK Constraint

The **CHECK** constraint restricts the values that can be entered into a column. It ensures that data satisfies a specified condition.

### Syntax

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Age INT CHECK (Age >= 18)
);

```

### Example

**Valid Record**

```

INSERT INTO Students
VALUES (101, 20);

```

**Invalid Record**

```

INSERT INTO Students
VALUES (102, 15);

```

**Reason:** Age is less than **18**.

### More Examples

**GPA Between 0 and 4**

```

CREATE TABLE Students (
GPA DECIMAL(3,2)
CHECK (GPA >= 0 AND GPA <= 4)
);

```

**Salary Must Be Positive**

```

CREATE TABLE Employees (
Salary DECIMAL(10,2)
CHECK (Salary > 0)
);

```

**Gender Restriction**

```

CREATE TABLE Students (
Gender CHAR(1)
CHECK (Gender IN (\'M\', \'F\'))
);

```

### Advantages of CHECK

- Prevents invalid data.

- Enforces business rules.

- Improves data quality.

- Reduces input errors.

## Combining Multiple Constraints

A table can have multiple constraints. **Example**

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE,
Age INT CHECK (Age >= 18),
DepartmentID INT,
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
);

```

This table includes:

- Primary Key

- Not Null

- Unique

- Check

- Foreign Key

## Difference Between PRIMARY KEY and UNIQUE

| PRIMARY KEY | UNIQUE |
|---|---|
| Uniquely identifies each row | Ensures unique values in a column |
| Cannot contain NULL values | May allow NULL values (DBMS dependent) |
| Only one per table | Multiple UNIQUE constraints allowed |
| Used for table identification | Used to prevent duplicate values |

## Difference Between PRIMARY KEY and FOREIGN KEY

| PRIMARY KEY | FOREIGN KEY |
|---|---|
| Uniquely identifies records | Creates relationships between tables |
| Must contain unique values | Values may repeat |
| Cannot be NULL | Can be NULL (unless restricted) |
| Exists in the parent table | References the parent table\'s Primary Key |

## Complete Example

**Departments Table**

```

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50)
);

```

**Students Table**

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE,
Age INT CHECK (Age >= 18),
DepartmentID INT,
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
);

```

**Valid Insert**

```

INSERT INTO Students
VALUES
(101, \'Anum\', \'anum@email.com\', 20, 1);

```

**Invalid Inserts** Duplicate Primary Key:

```

INSERT INTO Students
VALUES
(101, \'Saba\', \'saba@email.com\', 21, 2);

```

Duplicate Email:

```

INSERT INTO Students
VALUES
(102, \'Hamza\', \'anum@email.com\', 22, 1);

```

Age Below 18:

```

INSERT INTO Students
VALUES
(103, \'Ali\', \'ali@email.com\', 16, 1);

```

Invalid Department:

```

INSERT INTO Students
VALUES
(104, \'Ahmed\', \'ahmed@email.com\', 20, 10);

```

Each of these statements violates a different constraint, so the database rejects them.

## Best Practices

- Define a **Primary Key** for every table.

- Use **Foreign Keys** to maintain relationships between related tables.

- Apply **UNIQUE** to fields such as email addresses and usernames.

- Use **CHECK** to enforce business rules like age, GPA, or salary limits.

- Choose meaningful column names to make constraints easier to understand.

- Test constraint behavior before deploying a database to production.

- Keep constraint rules simple and clear to improve maintenance.

- Let the database enforce important rules instead of relying only on application code. Humans forget; databases are stubborn in exactly

the way you want.

## Summary

| Constraint | Purpose | Example |
|---|---|---|
| PRIMARY KEY | Uniquely identifies each record | StudentID INT PRIMARY KEY |
| FOREIGN KEY | Creates relationships between tables | FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) |
| UNIQUE | Prevents duplicate values | Email VARCHAR(100) UNIQUE |
| CHECK | Restricts values based on a condition | CHECK (Age >= 18) |

### Conclusion

SQL constraints are essential for maintaining the integrity, accuracy, and consistency of data in relational databases. The **PRIMARY KEY** uniquely identifies each record, the **FOREIGN KEY** establishes relationships between tables, the **UNIQUE** constraint prevents duplicate values, and the **CHECK** constraint ensures that only valid data is stored. By applying these constraints during database design, we create secure, reliable, and well-structured databases that minimize errors and support efficient data management.');

-- Lecture 5: Inserting, Updating & Deleting Data (DML)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Inserting, Updating & Deleting Data (DML)', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Inserting, Updating & Deleting Data (DML)

## Introduction to DML (Data Manipulation Language)

**DML (Data Manipulation Language)** is a category of SQL commands used to **insert, update, delete, and manage data** stored inside database tables. Think of a database table as a notebook. Creating the notebook is done using **DDL**, but writing, correcting, or erasing information inside it is done using **DML**. The three main DML commands are:

- `INSERT` – Add new records.

- `UPDATE` – Modify existing records.

- `DELETE` – Remove records.

Unlike DDL, DML works with the **data**, not the table structure.

## INSERT Statement

The `INSERT` statement is used to **add new records** to a table.

### Syntax (Insert All Columns)

```

INSERT INTO table_name
VALUES (value1, value2, value3, ...);

```

**Example** Suppose we have the following table: **Students**

| StudentID | Name | Age | Department |
|---|---|---|---|

Insert a new student:

```

INSERT INTO Students
VALUES (101, \'Ali\', 20, \'AI\');

```

The table becomes:

| StudentID | Name | Age | Department |
|---|---|---|---|
| 101 | Ali | 20 | AI |

### Inserting Data into Specific Columns

Sometimes we do not want to insert values into every column. **Syntax**

```

INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);

```

**Example**

```

INSERT INTO Students (StudentID, Name, Department)
VALUES (102, \'Sara\', \'CS\');

```

If the `Age` column allows `NULL` or has a default value, it will be filled automatically.

### Inserting Multiple Records

We can insert several rows with one statement. **Example**

```

INSERT INTO Students
VALUES
(103, \'Ahmed\', 21, \'SE\'),
(104, \'Fatima\', 19, \'AI\'),
(105, \'Ayesha\', 20, \'CS\');

```

This saves time and reduces the number of SQL statements.

## UPDATE Statement

The `UPDATE` statement is used to **modify existing records** in a table.

### Syntax

```

UPDATE table_name
SET column_name = value
WHERE condition;

```

**Example** Current Table:

| StudentID | Name | Age |
|---|---|---|
| 101 | Ali | 20 |

Suppose Ali\'s age changes from **20** to **21**.

```

UPDATE Students
SET Age = 21
WHERE StudentID = 101;

```

Updated Table:

| StudentID | Name | Age |
|---|---|---|
| 101 | Ali | 21 |

### Updating Multiple Columns

We can update more than one column at the same time. **Example**

```

UPDATE Students
SET
Name = \'Ali Hassan\',
Department = \'Computer Science\'
WHERE StudentID = 101;

```

### Updating Multiple Records

The `WHERE` condition can affect multiple rows. **Example**

```

UPDATE Students
SET Department = \'Artificial Intelligence\'
WHERE Department = \'AI\';

```

Every student whose department is **AI** will now have **Artificial Intelligence** stored instead.

## Importance of the WHERE Clause

The `WHERE` clause specifies **which records** should be updated or deleted. Without it, SQL affects **every row** in the table. **Correct Example**

```

UPDATE Students
SET Age = 22
WHERE StudentID = 101;

```

Only one student\'s age is updated. **Dangerous Example**

```

UPDATE Students
SET Age = 22;

```

Every student\'s age becomes **22**. Sometimes beginners discover this the hard way. The database does exactly what you ask, not what you meant.

## DELETE Statement

The `DELETE` statement removes records from a table.

### Syntax

```

DELETE FROM table_name
WHERE condition;

```

**Example** Delete student with ID 101:

```

DELETE FROM Students
WHERE StudentID = 101;

```

The selected record is permanently removed.

### Deleting Multiple Records

Example:

```

DELETE FROM Students
WHERE Department = \'AI\';

```

All students belonging to the AI department are deleted.

### Deleting All Records

```

DELETE FROM Students;

```

This removes **all rows** from the table. The table structure remains intact.

## Difference Between DELETE, TRUNCATE, and DROP

These commands are often confused.

| Command | Removes Data | Removes Table Structure | WHERE Clause |
|---|---|---|---|
| DELETE | Yes | No | Yes |
| TRUNCATE | Yes | No | No |
| DROP | Yes | Yes | No |

**Example**

```

DELETE FROM Students;

```

Deletes all records one by one.

```

TRUNCATE TABLE Students;

```

Deletes all records quickly while keeping the table.

```

DROP TABLE Students;

```

Deletes the entire table along with its structure.

## Complete DML Example

**Step 1: Create Table**

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT,
Department VARCHAR(30)
);

```

**Step 2: Insert Records**

```

INSERT INTO Students
VALUES
(101, \'Ali\', 20, \'AI\'),
(102, \'Sara\', 21, \'CS\'),
(103, \'Ahmed\', 22, \'SE\');

```

Current Table:

| StudentID | Name | Age | Department |
|---|---|---|---|
| 101 | Ali | 20 | AI |
| 102 | Sara | 21 | CS |
| 103 | Ahmed | 22 | SE |

**Step 3: Update Record**

```

UPDATE Students
SET Age = 23
WHERE StudentID = 103;

```

Table:

| StudentID | Name | Age | Department |
|---|---|---|---|
| 101 | Ali | 20 | AI |
| 102 | Sara | 21 | CS |
| 103 | Ahmed | 23 | SE |

**Step 4: Delete Record**

```

DELETE FROM Students
WHERE StudentID = 102;

```

Final Table:

| StudentID | Name | Age | Department |
|---|---|---|---|
| 101 | Ali | 20 | AI |
| 103 | Ahmed | 23 | SE |

## Best Practices for Using DML

- Always use the `WHERE` clause with `UPDATE` and `DELETE` unless you intentionally want to affect all records.

- Verify the data before running an `UPDATE` or `DELETE` statement.

- Use meaningful conditions to avoid accidental data loss.

- Back up important data before making large changes.

- Use transactions (`COMMIT` and `ROLLBACK`) when performing multiple related operations.

- Insert data that matches the column\'s data type.

- Test queries on a small dataset before running them on a production database.

## Summary of DML Commands

| Command | Purpose | Example |
|---|---|---|
| INSERT | Adds new records | INSERT INTO Students VALUES (101, \'Ali\', 20, \'AI\'); |
| UPDATE | Modifies existing records | UPDATE Students SET Age = 21 WHERE StudentID = 101; |
| DELETE | Removes records | DELETE FROM Students WHERE StudentID = 101; |

### Conclusion

**Data Manipulation Language (DML)** enables us to manage the information stored in database tables. Using the `INSERT` command, we can add new records; with `UPDATE`, we can modify existing records; and with `DELETE`, we can remove unwanted data. The `WHERE` clause is especially important because it ensures that only the intended records are affected. By understanding and carefully using DML commands, we can efficiently maintain accurate, organized, and reliable data in relational databases.');

-- Lecture 6: SELECT Statements & Filtering (WHERE)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'SELECT Statements & Filtering (WHERE)', 6, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# SELECT Statements & Filtering (WHERE)

## Introduction to the SELECT Statement

The **SELECT** statement is one of the most frequently used SQL commands. It is used to **retrieve (fetch) data** from one or more tables in a database. Think of a database as a large library. Instead of reading every book to find one piece of information, the `SELECT` statement allows us to ask the database exactly what we need. The database quickly returns the requested records. The `SELECT` statement belongs to **DQL (Data Query Language)** because it is used to query data without changing it.

## Basic SELECT Statement

### Syntax

```

SELECT column_name
FROM table_name;

```

**Example** Suppose we have the following **Students** table:

| StudentID | Name | Age | Department |
|---|---|---|---|
| 101 | Anum | 20 | AI |
| 102 | Sara | 21 | CS |
| 103 | Ahmed | 22 | SE |

Retrieve only student names:

```

SELECT Name
FROM Students;

```

**Output**

| Name |
|---|
| Anum |
| Sara |
| Ahmed |

### Selecting Multiple Columns

We can retrieve more than one column.

```

SELECT Name, Age
FROM Students;

```

**Output**

| Name | Age |
|---|---|
| Anum | 20 |
| Sara | 21 |
| Ahmed | 22 |

### Selecting All Columns

The asterisk (`*`) represents **all columns**.

```

SELECT *
FROM Students;

```

**Output**

| StudentID | Name | Age | Department |
|---|---|---|---|
| 101 | Anum | 20 | AI |
| 102 | Sara | 21 | CS |
| 103 | Ahmed | 22 | SE |

Use `SELECT *` for learning or quick testing. In real applications, selecting only the required columns is usually more efficient.

## The WHERE Clause

The **WHERE** clause is used to **filter records** based on a specified condition. Instead of displaying every row, it returns only the rows that satisfy the given condition.

### Syntax

```

SELECT column_name
FROM table_name
WHERE condition;

```

**Example** Retrieve students from the AI department.

```

SELECT *
FROM Students
WHERE Department = \'AI\';

```

**Output**

| StudentID | Name | Age | Department |
|---|---|---|---|
| 101 | Anum | 20 | AI |

## Comparison Operators in WHERE Clause

Comparison operators are used to compare values.

| Operator | Meaning | Example |
|---|---|---|
| = | Equal to | Age = 20 |
| != or <> | Not equal to | Department <> \'AI\' |
| > | Greater than | Age > 20 |
| < | Less than | Age < 20 |
| >= | Greater than or equal to | Age >= 21 |
| <= | Less than or equal to | Age <= 18 |

### Equal To (=)

```

FROM Students
WHERE Age = 20;

```

Displays students whose age is exactly 20.

### Greater Than (>)

```

SELECT *
FROM Students
WHERE Age > 20;

```

Displays students older than 20.

### Less Than (<)

```

SELECT *
FROM Students
WHERE Age < 21;

```

Displays students younger than 21.

### Not Equal To (<> or !=)

```

SELECT *
FROM Students
WHERE Department <> \'AI\';

```

Displays students who are **not** in the AI department.

## Logical Operators

Logical operators allow multiple conditions to be combined.

### 1. AND

Returns records only if **all conditions** are true. **Example**

```

SELECT *
FROM Students
WHERE Department = \'AI\'
AND Age > 19;

```

Only students who belong to the AI department **and** are older than 19 are displayed.

### 2. OR

Returns records if **at least one condition** is true. **Example**

```

SELECT *
FROM Students
WHERE Department = \'AI\'
OR Department = \'CS\';

```

Displays students from either AI or CS.

### 3. NOT

Reverses a condition. **Example**

```

SELECT *
FROM Students
WHERE NOT Department = \'SE\';

```

Displays all students except those in the SE department.

## BETWEEN Operator

The `BETWEEN` operator selects values within a specified range.

### Syntax

```

SELECT *
FROM table_name
WHERE column_name BETWEEN value1 AND value2;

```

**Example**

```

SELECT *
FROM Students
WHERE Age BETWEEN 20 AND 22;

```

Displays students whose age is between 20 and 22 (inclusive).

## IN Operator

The `IN` operator checks whether a value matches any value in a given list. **Example**

```

SELECT *
FROM Students
WHERE Department IN (\'AI\', \'CS\');

```

Instead of writing multiple `OR` conditions, `IN` provides a shorter and cleaner solution.

## LIKE Operator

The `LIKE` operator searches for patterns in text. **Wildcards**

| Wildcard | Meaning |
|---|---|
| % | Any number of characters |
| _ | Exactly one character |

### Starts With

```

SELECT *
FROM Students
WHERE Name LIKE \'A%\';

```

Displays names starting with **A**. Examples:

- Anum

- Ahmed

- Ayesha

### Ends With

```

SELECT *
FROM Students
WHERE Name LIKE \'%a\';

```

Displays names ending with **a**. Example:

- Sara

### Contains

```

SELECT *
FROM Students
WHERE Name LIKE \'%li%\';

```

Displays names containing **li**. Example:

- Anum

### Single Character Wildcard

```

SELECT *
FROM Students
WHERE Name LIKE \'_li\';

```

Matches names where the first character can be anything, followed by **li**. Example:

- Anum

## IS NULL and IS NOT NULL

`NULL` represents a missing or unknown value.

### Find NULL Values

```

SELECT *
FROM Students
WHERE Email IS NULL;

```

Displays students who have no email address stored.

### Find Non-NULL Values

```

SELECT *
FROM Students
WHERE Email IS NOT NULL;

```

Displays students whose email addresses are available.

## ORDER BY Clause

The `ORDER BY` clause sorts the result set.

### Ascending Order (Default)

```

SELECT *
FROM Students
ORDER BY Name ASC;

```

Sorts names from A to Z.

### Descending Order

```

SELECT *
FROM Students
ORDER BY Age DESC;

```

Displays students from oldest to youngest. `DISTINCT` removes duplicate values from the result. **Example**

```

SELECT DISTINCT Department
FROM Students;

```

If multiple students belong to the same department, each department appears only once.

## LIMIT Clause

The `LIMIT` clause restricts the number of rows returned. **Example (MySQL/MariaDB)**

```

SELECT *
FROM Students
LIMIT 5;

```

Displays only the first five records. **Note:** SQL Server commonly uses `TOP`, while MySQL, MariaDB, PostgreSQL, and SQLite use `LIMIT`.

## Complete Example

Suppose the **Students** table contains:

| StudentID | Name | Age | Department |
|---|---|---|---|
| 101 | Anum | 20 | AI |
| 102 | Sara | 21 | CS |
| 103 | Ahmed | 22 | SE |
| 104 | Ayesha | 20 | AI |
| 105 | Hamza | 23 | CS |

**Retrieve all students**

```

SELECT *
FROM Students;

```

**Retrieve only names**

```

SELECT Name
FROM Students;

```

**Students older than 20**

```

SELECT *
FROM Students
WHERE Age > 20;

```

**Students from AI department**

```

SELECT *
FROM Students
WHERE Department = \'AI\';

```

**Students from AI or CS**

```

SELECT *
FROM Students
WHERE Department IN (\'AI\', \'CS\');

```

**Students whose names start with "A"**

```

SELECT *
FROM Students
WHERE Name LIKE \'A%\';

```

**Sort by age**

```

SELECT *
FROM Students
ORDER BY Age ASC;

```

## Best Practices for SELECT Queries

- Select only the columns you need instead of using `SELECT *` in production applications.

- Always use the `WHERE` clause to retrieve relevant records when possible.

- Use `ORDER BY` to present data in a meaningful order.

- Use `DISTINCT` only when duplicate values should be removed.

- Use `IN` instead of multiple `OR` conditions for better readability.

- Use `LIKE` for pattern matching in text fields.

- Be careful with `NULL` values and use `IS NULL` or `IS NOT NULL` instead of `=` or `!=`.

- Write readable queries using proper indentation. Future you will appreciate it. Future teammates might even stop glaring at your SQL.

### Conclusion

The `SELECT` statement is the foundation of data retrieval in SQL. Combined with the `WHERE` clause, it allows us to filter records based on specific conditions, making it easy to retrieve exactly the information we need. By understanding comparison operators, logical operators, pattern matching, sorting, duplicate removal, and result limiting, we can write efficient and accurate SQL queries. These skills form the basis for more advanced SQL topics such as joins, grouping, aggregate functions, and subqueries.');

-- Lecture 7: Sorting & Limiting Results in SQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Sorting & Limiting Results in SQL', 7, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Sorting & Limiting Results in SQL

## Introduction to Sorting & Limiting Results

When a database contains hundreds or even millions of records, displaying all of them at once is neither practical nor useful. SQL provides powerful clauses to **sort** data in a meaningful order and **limit** the number of records returned. Think of an online shopping website. You might want to see:

- Products sorted by **lowest price**.

- Students sorted by **highest GPA**.

- The **latest five orders**.

- The **top ten highest-paid employees**.

SQL makes these tasks simple using the **ORDER BY** and **LIMIT** clauses.

## ORDER BY Clause

The **ORDER BY** clause is used to **sort the result set** based on one or more columns.

### Syntax

```

SELECT column_name
FROM table_name
ORDER BY column_name;

```

By default, SQL sorts data in **ascending (ASC)** order.

### Example Table: Students

| StudentID | Name | Age | GPA |
|---|---|---|---|
| 101 | Ali | 20 | 3.40 |
| 102 | Sara | 21 | 3.90 |
| 103 | Ahmed | 19 | 3.20 |
| 104 | Ayesha | 22 | 3.80 |
| 105 | Hamza | 20 | 3.50 |

## Sorting in Ascending Order (ASC)

Ascending order arranges data from:

- A → Z (Text)

- Smallest → Largest (Numbers)

- Oldest → Newest (Dates)

`ASC` is the default sorting order.

### Syntax

```

SELECT *
FROM Students
ORDER BY Name ASC;

```

**Output**

| StudentID | Name |
|---|---|
| 103 | Ahmed |
| 101 | Ali |
| 104 | Ayesha |
| 105 | Hamza |
| 102 | Sara |

**Sorting by Age**

```

SELECT *
FROM Students
ORDER BY Age ASC;

```

**Output**

| Name | Age |
|---|---|
| Ahmed | 19 |
| Ali | 20 |
| Hamza | 20 |
| Sara | 21 |
| Ayesha | 22 |

## Sorting in Descending Order (DESC)

Descending order arranges data from:

- Z → A (Text)

- Largest → Smallest (Numbers)

- Newest → Oldest (Dates)

### Syntax

```

SELECT *
FROM Students
ORDER BY GPA DESC;

```

**Output**

| Name | GPA |
|---|---|
| Sara | 3.90 |
| Ayesha | 3.80 |
| Hamza | 3.50 |
| Ali | 3.40 |
| Ahmed | 3.20 |

This is useful when finding the highest values, such as top students, highest salaries, or best-selling products.

## Sorting by Multiple Columns

### Syntax

```

SELECT *
FROM table_name
ORDER BY column1, column2;

```

**Example**

```

SELECT *
FROM Students
ORDER BY Age ASC, Name ASC;

```

The database first sorts by **Age**. If two students have the same age, it then sorts them alphabetically by **Name**. **Output**

| Name | Age |
|---|---|
| Ahmed | 19 |
| Ali | 20 |
| Hamza | 20 |
| Sara | 21 |
| Ayesha | 22 |

**Mixed Sorting** Different columns can have different sorting orders.

```

SELECT *
FROM Students
ORDER BY Department ASC, GPA DESC;

```

This sorts departments alphabetically while displaying the highest GPA first within each department.

## LIMIT Clause

The **LIMIT** clause restricts the number of rows returned by a query. Instead of displaying every record, we can request only the required number.

### Syntax

```

SELECT *
FROM table_name
LIMIT number;

```

**Example**

```

SELECT *
FROM Students
LIMIT 3;

```

**Output** Only the first **3 records** are displayed.

### Top Students Example

```

SELECT *
FROM Students
ORDER BY GPA DESC
LIMIT 3;

```

**Output**

| Name | GPA |
|---|---|
| Sara | 3.90 |
| Ayesha | 3.80 |
| Hamza | 3.50 |

This query returns the **top three students** with the highest GPAs.

## OFFSET with LIMIT

`OFFSET` allows us to skip a specified number of records before displaying the remaining rows.

### Syntax

```

SELECT *
FROM table_name
LIMIT number
OFFSET number;

```

**Example**

```

SELECT *
FROM Students
LIMIT 2
OFFSET 3;

```

The database:

- Skips the first **3 records**.

- Displays the next **2 records**.

This is commonly used for **pagination** in websites.

### Pagination Example

Suppose each page shows **10 students**. **Page 1**

```

SELECT *
FROM Students
LIMIT 10 OFFSET 0;

```

**Page 2**

```

SELECT *
FROM Students
LIMIT 10 OFFSET 10;

```

**Page 3**

```

SELECT *
FROM Students
LIMIT 10 OFFSET 20;

```

Most websites use this technique to display search results page by page instead of loading thousands of records at once.

## TOP Clause (SQL Server)

Unlike MySQL and MariaDB, **SQL Server** uses the `TOP` keyword instead of `LIMIT`.

### Syntax

```

SELECT TOP 5 *
FROM Students;

```

This displays the first five records.

### Top Highest GPAs

```

SELECT TOP 3 *
FROM Students
ORDER BY GPA DESC;

```

Returns the three highest GPAs. **Note:** MySQL, MariaDB, PostgreSQL, and SQLite use `LIMIT`, while SQL Server uses `TOP`.

## Practical Examples

### Display Students Alphabetically

```

SELECT *
FROM Students
ORDER BY Name;

```

### Display Oldest Student First

```

SELECT *
FROM Students
ORDER BY Age DESC;

```

### Display Top Five Students

```

SELECT *
FROM Students
ORDER BY GPA DESC
LIMIT 5;

```

### Display Youngest Three Students

```

SELECT *
FROM Students
ORDER BY Age ASC
LIMIT 3;

```

### Display Students by Department Then Name

```

SELECT *
FROM Students
ORDER BY Department ASC, Name ASC;

```

## Difference Between ORDER BY and LIMIT

| Feature | ORDER BY | LIMIT |
|---|---|---|
| Purpose | Sorts records | Restricts number of records |
| Changes Order | ✔ Yes | ✘ No |
| Reduces Rows | ✘ No | ✔ Yes |
| Can Be Used Together | ✔ Yes | ✔ Yes |

**Example**

```

SELECT *
FROM Students
ORDER BY GPA DESC
LIMIT 5;

```

The database: 1. Sorts students by GPA (highest to lowest). 2. Returns only the first five rows.

## Best Practices

- Use `ORDER BY` whenever the order of results matters.

- Specify `ASC` or `DESC` explicitly to improve readability, even though `ASC` is the default.

- Apply `LIMIT` to avoid retrieving unnecessary records.

- Combine `ORDER BY` and `LIMIT` to retrieve top or bottom results efficiently.

- Use `OFFSET` for pagination in applications.

- Sort only by the columns that are necessary to improve query performance.

- For large databases, consider indexing frequently sorted columns to speed up queries. Databases enjoy finding things quickly almost as

much as humans enjoy pretending slow websites are someone else\'s fault.

## Summary

| Clause | Purpose | Example |
|---|---|---|
| ORDER BY ... ASC | Sorts data in ascending order | ORDER BY Name ASC |
| ORDER BY ... DESC | Sorts data in descending order | ORDER BY GPA DESC |
| LIMIT | Limits returned rows | LIMIT 5 |
| OFFSET | Skips rows before returning results | LIMIT 10 OFFSET 20 |
| TOP (SQL Server) | Returns first n rows | TOP 5 |

### Conclusion

The `ORDER BY` and `LIMIT` clauses are essential tools for organizing and controlling query results in SQL. `ORDER BY` allows us to arrange records in ascending or descending order based on one or more columns, while `LIMIT` restricts the number of rows returned, making queries more efficient and user-friendly. Together with `OFFSET`, these clauses support features such as ranking, pagination, and displaying top or bottom records. Mastering sorting and limiting techniques enables us to retrieve data in a clear, organized, and efficient manner, which is especially important when working with large databases.');

-- Lecture 8: Aggregate Functions in SQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Aggregate Functions in SQL', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Aggregate Functions in SQL

## Introduction to Aggregate Functions

**Aggregate Functions** are special SQL functions used to **perform calculations on multiple rows** and return a **single result**. Instead of displaying every record individually, aggregate functions summarize the data. For example:

- How many students are enrolled?

- What is the average GPA?

- What is the total salary of employees?

- Who has the highest marks?

- What is the lowest product price?

Rather than calculating these manually, SQL provides built-in aggregate functions to perform these tasks quickly and accurately.

## What Are Aggregate Functions?

An **aggregate function** takes values from multiple rows and produces **one summarized value**. **Common Aggregate Functions**

| Function | Purpose |
|---|---|
| COUNT() | Counts rows or values |
| SUM() | Adds numeric values |
| AVG() | Calculates the average |
| MIN() | Finds the smallest value |
| MAX() | Finds the largest value |

These functions are mainly used with numeric data, except `COUNT()`, which can count both numeric and non-numeric values.

## COUNT() Function

The `COUNT()` function counts the number of rows or non-NULL values.

### Syntax

```

SELECT COUNT(column_name)
FROM table_name;

```

### COUNT(*)

`COUNT(*)` counts **all rows**, including rows that contain `NULL` values in some columns. **Example** Suppose the **Students** table contains:

| StudentID | Name | Age |
|---|---|---|
| 101 | Ali | 20 |
| 102 | Sara | 21 |
| 103 | Ahmed | 22 |
| 104 | Ayesha | 20 |
| 105 | Hamza | 23 |

```

SELECT COUNT(*)
FROM Students;

```

**Output** `5` There are **5 students** in the table.

### COUNT(Column Name)

Counts only **non-NULL values** in a specific column.

```

SELECT COUNT(Email)
FROM Students;

```

If some students have no email address (`NULL`), they are **not counted**.

## SUM() Function

The `SUM()` function calculates the **total** of numeric values in a column.

### Syntax

```

SELECT SUM(column_name)
FROM table_name;

```

**Example** Suppose the **Employees** table contains:

| Employee | Salary |
|---|---|
| Ali | 50000 |
| Sara | 60000 |
| Ahmed | 45000 |

```

SELECT SUM(Salary)
FROM Employees;

```

**Output** `155000` The total salary of all employees is **155,000**.

### Using SUM with WHERE

We can calculate totals for specific records.

```

SELECT SUM(Salary)
FROM Employees
WHERE Department = \'IT\';

```

Only IT department salaries are added.

## AVG() Function

The `AVG()` function calculates the **average (mean)** value.

### Syntax

```

SELECT AVG(column_name)
FROM table_name;

```

**Example**

```

SELECT AVG(Age)
FROM Students;

```

Suppose ages are: 20, 21, 22, 20, 23 Calculation:

```

(20 + 21 + 22 + 20 + 23) ÷ 5 = 21.2

```

**Output** `21.2` The average age is **21.2 years**.

### Average Salary

```

SELECT AVG(Salary)
FROM Employees;

```

Returns the average employee salary.

## MIN() Function

The `MIN()` function returns the **smallest value** in a column.

### Syntax

```

SELECT MIN(column_name)
FROM table_name;

```

**Example**

```

SELECT MIN(Age)
FROM Students;

```

**Output** `20` The youngest student is **20 years old**.

### Finding the Lowest Price

```

SELECT MIN(Price)
FROM Products;

```

Returns the lowest product price.

## MAX() Function

The `MAX()` function returns the **largest value** in a column.

### Syntax

```

SELECT MAX(column_name)
FROM table_name;

```

**Example**

```

SELECT MAX(Age)
FROM Students;

```

**Output** `23` The oldest student is **23 years old**.

### Finding Highest Salary

```

SELECT MAX(Salary)
FROM Employees;

```

Returns the highest salary.

## Using Aggregate Functions with WHERE

Aggregate functions can work together with the `WHERE` clause. **Count AI Students**

```

SELECT COUNT(*)
FROM Students
WHERE Department = \'AI\';

```

Counts only students in the AI department. **Average GPA**

```

SELECT AVG(GPA)
FROM Students
WHERE Department = \'CS\';

```

Calculates the average GPA of Computer Science students. **Highest Salary in HR**

```

SELECT MAX(Salary)
FROM Employees
WHERE Department = \'HR\';

```

Displays the highest salary in the HR department.

## Aggregate Functions with GROUP BY

The `GROUP BY` clause groups rows with the same values, allowing aggregate functions to calculate results for each group.

### Example Table

| Student | Department | GPA |
|---|---|---|
| Ali | AI | 3.5 |
| Sara | CS | 3.8 |
| Ahmed | AI | 3.7 |
| Hamza | CS | 3.6 |
| Ayesha | SE | 3.9 |

### Count Students by Department

```

SELECT Department,
FROM Students
GROUP BY Department;

```

**Output**

| Department | TotalStudents |
|---|---|
| AI | 2 |
| CS | 2 |
| SE | 1 |

### Average GPA by Department

```

SELECT Department,
AVG(GPA) AS AverageGPA
FROM Students
GROUP BY Department;

```

**Output**

| Department | AverageGPA |
|---|---|
| AI | 3.60 |
| CS | 3.70 |
| SE | 3.90 |

`GROUP BY` is discussed in more detail in advanced SQL topics, but it is commonly used with aggregate functions.

## Aggregate Functions with Aliases

Aliases make result headings more meaningful.

### Syntax

```

SELECT COUNT(*) AS TotalStudents
FROM Students;

```

**Example**

```

SELECT AVG(Salary) AS AverageSalary
FROM Employees;

```

Instead of displaying: | AVG(Salary) | The output becomes: | AverageSalary | Aliases improve readability.

## Difference Between COUNT(*) and COUNT(Column)

| COUNT(*) | COUNT(Column) |
|---|---|
| Counts all rows | Counts only non-NULL values |
| Includes rows even if some columns contain NULL | Ignores NULL values in the specified column |

**Example**

| Student | Email |
|---|---|
| Ali | ali@email.com |
| Sara | NULL |
| Ahmed | ahmed@email.com |

```

SELECT COUNT(*)
FROM Students;

```

Output:

```

3
SELECT COUNT(Email)
FROM Students;

```

Output: `2`

## Complete Example

Suppose the **Students** table contains:

| StudentID | Name | Department | GPA |
|---|---|---|---|
| 101 | Ali | AI | 3.5 |
| 102 | Sara | CS | 3.8 |
| 103 | Ahmed | AI | 3.7 |
| 104 | Ayesha | SE | 3.9 |
| 105 | Hamza | CS | 3.6 |

**Count Students**

```

SELECT COUNT(*)
FROM Students;

```

**Average GPA**

```

SELECT AVG(GPA)
FROM Students;

```

**Highest GPA**

```

SELECT MAX(GPA)
FROM Students;

```

**Lowest GPA**

```

SELECT MIN(GPA)
FROM Students;

```

**Count Students by Department**

```

SELECT Department,
COUNT(*) AS TotalStudents
FROM Students
GROUP BY Department;

```

## Best Practices

- Use `COUNT(*)` to count all rows.

- Use `COUNT(column_name)` when you want to ignore `NULL` values.

- Apply aggregate functions only to appropriate data types.

- Combine aggregate functions with `WHERE` to filter records before calculation.

- Use `GROUP BY` when you need separate summaries for different categories.

- Use aliases (`AS`) to make output easier to understand.

- Remember that aggregate functions return a single summarized value unless they are used with `GROUP BY`. They are excellent at

summarizing crowds, but remarkably uninterested in individual drama.

## Summary

| Function | Purpose | Example |
|---|---|---|
| COUNT() | Counts rows or values | SELECT COUNT(*) FROM Students; |
| SUM() | Adds numeric values | SELECT SUM(Salary) FROM Employees; |
| AVG() | Calculates average | SELECT AVG(GPA) FROM Students; |
| MIN() | Finds smallest value | SELECT MIN(Age) FROM Students; |
| MAX() | Finds largest value | SELECT MAX(Salary) FROM Employees; |

### Conclusion

Aggregate functions are powerful SQL tools used to summarize and analyze data. Functions such as `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()` allow us to perform calculations across multiple rows and return meaningful results with minimal effort. When combined with clauses like `WHERE` and `GROUP BY`, aggregate functions become even more useful for generating reports, analyzing trends, and making informed decisions. Mastering these functions is essential for effective database querying and data analysis.');

-- Lecture 9: GROUP BY & HAVING in SQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'GROUP BY & HAVING in SQL', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# GROUP BY & HAVING in SQL

## Introduction to GROUP BY & HAVING

In SQL, we often need to analyze data instead of simply displaying it. For example, we may want to answer questions like:

- How many students are there in each department?

- What is the average salary in each department?

- Which departments have more than 10 employees?

- Which product categories generate the highest sales?

To perform such analysis, SQL provides two important clauses:

- **GROUP BY** – Groups rows that have the same values.

- **HAVING** – Filters grouped data after aggregation.

Think of a classroom where students are first divided into groups based on their departments. Once the groups are formed, we can calculate the number of students, average GPA, or total marks for each group. This is exactly how `GROUP BY` works.

## GROUP BY Clause

The **GROUP BY** clause groups rows that have the same values in one or more columns. It is usually used with **aggregate functions** such as:

- `COUNT()`

- `SUM()`

- `AVG()`

- `MIN()`

- `MAX()`

### Syntax

```

SELECT column_name, aggregate_function(column_name)
FROM table_name
GROUP BY column_name;

```

### Example Table: Students

| StudentID | Name | Department | GPA |
|---|---|---|---|
| 101 | Anum | AI | 3.8 |
| 102 | Saba | CS | 3.5 |
| 103 | Ahmed | AI | 3.7 |
| 104 | Ayesha | SE | 3.9 |
| 105 | Hamza | CS | 3.9 |

## Using GROUP BY with COUNT()

Suppose we want to know how many students belong to each department.

```

SELECT Department,
COUNT(*) AS TotalStudents
FROM Students
GROUP BY Department;

```

**Output**

| Department | TotalStudents |
|---|---|
| AI | 2 |
| CS | 2 |
| SE | 1 |

**Explanation**

- Students are grouped by **Department**.

- `COUNT(*)` counts the students in each department.

- One row is returned for each department.

## Using GROUP BY with SUM()

Suppose we have the following **Employees** table.

| Employee | Department | Salary |
|---|---|---|
| Anum | IT | 50000 |
| Saba | IT | 60000 |
| Afsha | HR | 45000 |
| Hamza | HR | 55000 |

Calculate the total salary for each department.

```

SELECT Department,
SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department;

```

**Output**

| Department | TotalSalary |
|---|---|
| HR | 100000 |
| IT | 110000 |

## Using GROUP BY with AVG()

Calculate the average GPA of each department.

```

SELECT Department,
AVG(GPA) AS AverageGPA
FROM Students
GROUP BY Department;

```

**Output**

| Department | AverageGPA |
|---|---|
| AI | 3.60 |
| CS | 3.70 |
| SE | 3.90 |

This helps compare academic performance across departments.

## Using GROUP BY with MIN() and MAX()

**Highest GPA in Each Department**

```

SELECT Department,
MAX(GPA) AS HighestGPA
FROM Students
GROUP BY Department;

```

**Output**

| Department | HighestGPA |
|---|---|
| AI | 3.7 |
| CS | 3.8 |
| SE | 3.9 |

**Lowest GPA in Each Department**

```

SELECT Department,
MIN(GPA) AS LowestGPA
FROM Students
GROUP BY Department;

```

## GROUP BY with Multiple Columns

We can group data using more than one column.

### Syntax

```

SELECT column1, column2,
COUNT(*)
FROM table_name
GROUP BY column1, column2;

```

**Example** Suppose the table contains:

| Department | Semester | Students |
|---|---|---|
| AI | 1 | 20 |
| AI | 2 | 25 |
| CS | 1 | 30 |
| CS | 2 | 28 |

```

SELECT Department,
Semester,
COUNT(*) AS TotalRecords
FROM Students
GROUP BY Department, Semester;

```

The database creates separate groups for every **Department-Semester** combination.

## HAVING Clause

It works similarly to the `WHERE` clause, but there is one important difference.

- **WHERE** filters individual rows **before** grouping.

- **HAVING** filters grouped results **after** grouping.

### Syntax

```

SELECT column_name,
aggregate_function(column_name)
FROM table_name
GROUP BY column_name
HAVING condition;

```

## Using HAVING with COUNT()

Display only departments with more than one student.

```

SELECT Department,
COUNT(*) AS TotalStudents
FROM Students
GROUP BY Department
HAVING COUNT(*) > 1;

```

**Output**

| Department | TotalStudents |
|---|---|
| AI | 2 |
| CS | 2 |

The SE department is not displayed because it has only one student.

## Using HAVING with AVG()

Display departments whose average GPA is greater than 3.6.

```

SELECT Department,
AVG(GPA) AS AverageGPA
FROM Students
GROUP BY Department
HAVING AVG(GPA) > 3.6;

```

**Output**

| Department | AverageGPA |
|---|---|
| CS | 3.70 |
| SE | 3.90 |

## Difference Between WHERE and HAVING

| WHERE | HAVING |
|---|---|
| Filters individual rows | Filters grouped results |
| Used before GROUP BY | Used after GROUP BY |
| Cannot use aggregate functions directly | Can use aggregate functions |
| Reduces rows before grouping | Reduces groups after grouping |

**Example Using WHERE**

```

SELECT *
FROM Students
WHERE GPA > 3.5;

```

Filters students **before** any grouping. **Example Using HAVING**

```

SELECT Department,
AVG(GPA)
FROM Students
GROUP BY Department
HAVING AVG(GPA) > 3.5;

```

Filters departments **after** calculating the average GPA.

## Combining WHERE and HAVING

Both clauses can be used together in the same query. **Example**

```

SELECT Department,
COUNT(*) AS TotalStudents
FROM Students
WHERE Age >= 20
GROUP BY Department
HAVING COUNT(*) > 1;

```

**Execution Order** 1. `WHERE` filters students aged 20 or above. 2. `GROUP BY` creates department groups. 3. `COUNT()` calculates the number of students in each group. 4. `HAVING` displays only departments with more than one student.

## Complete Example

Suppose the **Employees** table contains:

| Employee | Department | Salary |
|---|---|---|
| Anum | IT | 70000 |
| Saba | IT | 80000 |
| Ahmed | HR | 45000 |
| Fatima | HR | 55000 |
| Hamza | Sales | 70000 |

**Count Employees**

```

SELECT Department,
COUNT(*) AS Employees
FROM Employees
GROUP BY Department;

```

**Average Salary**

```

SELECT Department,
AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department;

```

**Departments with Average Salary Above 50,000**

```

SELECT Department,
AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department
HAVING AVG(Salary) > 50000;

```

**Total Salary by Department**

```

SELECT Department,
SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department;

```

## Best Practices

- Use `GROUP BY` whenever you need summary information for categories.

- Use aggregate functions with `GROUP BY` to calculate totals, averages, minimums, and maximums.

- Use `WHERE` to filter rows before grouping.

- Use `HAVING` to filter grouped results after aggregation.

- Give aggregate columns meaningful aliases using `AS`.

- Group only by the columns that are necessary to avoid unnecessary complexity.

- Remember the order of execution: `WHERE` comes before `GROUP BY`, and `HAVING` comes after. SQL follows instructions with remarkable

discipline, unlike the average group project.

## Summary

| Clause | Purpose | Example |
|---|---|---|
| GROUP BY | Groups rows with the same values | GROUP BY Department |
| HAVING | Filters grouped results | HAVING COUNT(*) > 2 |
| WHERE | Filters rows before grouping | WHERE GPA > 3.5 |

**Common Examples**

| Query | SQL Statement |
|---|---|
| Count students by department | SELECT Department, COUNT(*) FROM Students GROUP BY Department; |
| Average GPA by department | SELECT Department, AVG(GPA) FROM Students GROUP BY Department; |
| Departments with more than 2 students | SELECT Department, COUNT(*) FROM Students GROUP BY Department HAVING COUNT(*) > 2; |
| Total salary by department | SELECT Department, SUM(Salary) FROM Employees GROUP BY Department; |

### Conclusion

The `GROUP BY` and `HAVING` clauses are essential tools for summarizing and analyzing data in SQL. `GROUP BY` organizes rows into meaningful groups based on common values, while aggregate functions calculate summaries such as totals, averages, minimums, and maximums for each group. The `HAVING` clause then filters these grouped results based on aggregate conditions. Together with the `WHERE` clause, they provide a powerful way to generate reports, analyze trends, and extract valuable insights from large datasets, making them indispensable for database management and data analysis.');

-- Lecture 10: SQL Joins (INNER, LEFT, RIGHT, FULL)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'SQL Joins (INNER, LEFT, RIGHT, FULL)', 10, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# SQL Joins (INNER, LEFT, RIGHT, FULL)

## Introduction to SQL Joins

In a relational database, data is usually stored in **multiple related tables** instead of one large table. This reduces data duplication and improves organization. However, there are many situations where we need information from more than one table. SQL solves this problem using **Joins**. A **JOIN** combines rows from two or more tables based on a related column, usually a **Primary Key** and a **Foreign Key**. Think of two puzzle pieces. Individually, they show only part of the picture. When joined together, they reveal the complete image. SQL joins work in a similar way by combining related information from different tables.

## Why Do We Need Joins?

Suppose a university stores data in two separate tables.

### Students Table

| StudentID | Name | DepartmentID |
|---|---|---|
| 101 | Anum | 1 |
| 102 | Saba | 2 |
| 103 | Hamza | 1 |
| 104 | Ayesha | 3 |

### Departments Table

| DepartmentID | DepartmentName |
|---|---|
| 1 | Artificial Intelligence |
| 2 | Computer Science |
| 3 | Software Engineering |

The **Students** table contains only the `DepartmentID`, not the department name. If we want to display:

- Student Name

- Department Name

We must combine both tables using a **JOIN**.

## Types of SQL Joins

The four main types of SQL joins are:

- **INNER JOIN**

- **LEFT JOIN (LEFT OUTER JOIN)**

- **RIGHT JOIN (RIGHT OUTER JOIN)**

- **FULL JOIN (FULL OUTER JOIN)**

Each join returns different results depending on which matching records exist.

## INNER JOIN

An **INNER JOIN** returns **only the rows that have matching values in both tables**. If a record has no matching value in the other table, it is **not included**.

### Syntax

```

SELECT columns
FROM table1
INNER JOIN table2
ON table1.column = table2.column;

```

### Example

```

SELECT Students.StudentID,
Students.Name,
Departments.DepartmentName
FROM Students
INNER JOIN Departments
ON Students.DepartmentID = Departments.DepartmentID;

```

### Output

| StudentID | Name | DepartmentName |
|---|---|---|
| 101 | Anum | Artificial Intelligence |
| 102 | Saba | Computer Science |
| 103 | Hamza | Artificial Intelligence |
| 104 | Ayesha | Software Engineering |

Only matching records appear in the result.

### When to Use INNER JOIN

Use `INNER JOIN` when you want only records that exist in **both** tables. Examples:

- Students with registered departments.

- Customers who have placed orders.

- Employees assigned to departments.

## LEFT JOIN (LEFT OUTER JOIN)

A **LEFT JOIN** returns:

- **All records from the left table**

- Matching records from the right table

If there is no match, SQL returns **NULL** for the columns of the right table.

### Syntax

```

SELECT columns
FROM table1
LEFT JOIN table2
ON table1.column = table2.column;

```

### Example

Suppose the Students table contains:

| StudentID | Name | DepartmentID |
|---|---|---|
| 101 | Anum | 1 |
| 102 | Saba | 2 |
| 103 | Hamza | 5 |

There is no department with ID **5**.

```

SELECT Students.Name,
Departments.DepartmentName
FROM Students
LEFT JOIN Departments
ON Students.DepartmentID = Departments.DepartmentID;

```

### Output

| Name | DepartmentName |
|---|---|
| Anum | Artificial Intelligence |
| Saba | Computer Science |
| Ahmed | NULL |

Ahmed still appears because all records from the **left table** are returned.

### When to Use LEFT JOIN

Use `LEFT JOIN` when every record from the left table is important, even if related data does not exist. Examples:

- All students, including those without departments.

- All customers, including those who never placed an order.

- All employees, including those without managers.

## RIGHT JOIN (RIGHT OUTER JOIN)

A **RIGHT JOIN** returns:

- **All records from the right table**

- Matching records from the left table

If no match exists, SQL returns **NULL** for the columns from the left table.

### Syntax

```

SELECT columns
FROM table1
RIGHT JOIN table2
ON table1.column = table2.column;

```

### Example

Suppose the Departments table contains:

| DepartmentID | DepartmentName |
|---|---|
| 1 | Artificial Intelligence |
| 2 | Computer Science |
| 3 | Software Engineering |
| 4 | Cyber Security |

No student belongs to Department **4**.

```

SELECT Students.Name,
Departments.DepartmentName
FROM Students
RIGHT JOIN Departments
ON Students.DepartmentID = Departments.DepartmentID;

```

### Output

| Name | DepartmentName |
|---|---|
| Anum | Artificial Intelligence |
| Saba | Computer Science |
| Ayesha | Software Engineering |
| NULL | Cyber Security |

The Cyber Security department appears even though no students belong to it.

### When to Use RIGHT JOIN

Use `RIGHT JOIN` when every record from the **right table** must appear. Examples:

- All departments, including those without students.

- All products, including those never ordered.

- All courses, including those with no enrolled students.

**Note:** Some database systems and developers rarely use `RIGHT JOIN`. Instead, they swap the table order and use `LEFT JOIN` because it is generally easier to read.

## FULL JOIN (FULL OUTER JOIN)

A **FULL JOIN** returns:

- All matching records.

- All non-matching rows from the left table.

- All non-matching rows from the right table.

If there is no match, SQL fills missing values with **NULL**.

### Syntax

```

SELECT columns
FROM table1
FULL OUTER JOIN table2
ON table1.column = table2.column;

```

### Example

**Students**

| Student | DepartmentID |
|---|---|
| Anum | 1 |
| Saba | 2 |
| Ahmed | 5 |

**Departments**

| DepartmentID | DepartmentName |
|---|---|
| 1 | AI |
| 2 | CS |
| 3 | SE |

```

SELECT Students.Name,
Departments.DepartmentName
FROM Students
FULL OUTER JOIN Departments
ON Students.DepartmentID = Departments.DepartmentID;

```

### Output

| Name | DepartmentName |
|---|---|
| Anum | AI |
| Saba | CS |
| Ahmed | NULL |
| NULL | SE |

The result contains:

- Matching rows

- Unmatched students

- Unmatched departments

### Database Support

- **PostgreSQL**, **SQL Server**, and **Oracle** support `FULL OUTER JOIN`.

- **MySQL** and **MariaDB** do **not** support `FULL OUTER JOIN` directly. It is usually simulated by combining a `LEFT JOIN` and a `RIGHT JOIN`

with `UNION`.

## Visual Understanding of Joins

Suppose:

- **Table A** = Students

- **Table B** = Departments

| Join Type | Records Returned |
|---|---|
| INNER JOIN | Only matching records from both tables |
| LEFT JOIN | All records from Table A + matching records from Table B |
| RIGHT JOIN | All records from Table B + matching records from Table A |
| FULL JOIN | All records from both tables, whether matched or not |

## Comparison of Join Types

| Join Type | Left Table | Right Table | Matching Records |
|---|---|---|---|
| INNER JOIN | Unmatched excluded | Unmatched excluded | Yes |
| LEFT JOIN | All records | Matching only | Yes |
| RIGHT JOIN | Matching only | All records | Yes |
| FULL JOIN | All records | All records | Yes |

## Practical Examples

### Students with Their Departments

```

SELECT Students.Name,
Departments.DepartmentName
FROM Students
INNER JOIN Departments
ON Students.DepartmentID = Departments.DepartmentID;

```

### All Students Including Those Without Departments

```

SELECT Students.Name,
Departments.DepartmentName
FROM Students
LEFT JOIN Departments
ON Students.DepartmentID = Departments.DepartmentID;

```

### All Departments Including Empty Departments

```

SELECT Students.Name,
Departments.DepartmentName
FROM Students
RIGHT JOIN Departments
ON Students.DepartmentID = Departments.DepartmentID;

```

### All Students and All Departments

```

SELECT Students.Name,
Departments.DepartmentName
FROM Students
FULL OUTER JOIN Departments
ON Students.DepartmentID = Departments.DepartmentID;

```

## Best Practices

- Always join tables using related columns such as **Primary Keys** and **Foreign Keys**.

- Use meaningful table aliases to make queries easier to read.

- Choose the appropriate join type based on the required result.

- Use `INNER JOIN` when only matching data is needed.

- Use `LEFT JOIN` when all records from the first table must appear.

- Remember that `RIGHT JOIN` can usually be replaced with `LEFT JOIN` by reversing the table order.

- Be aware that `FULL OUTER JOIN` is not directly supported in MySQL and MariaDB.

- Avoid joining unnecessary tables, as this can reduce query performance. Databases are happy to connect tables, but they are less

enthusiastic when asked to perform unnecessary social networking.

## Summary

| Join | Description | Example Use |
|---|---|---|
| INNER JOIN | Returns only matching rows | Students with valid departments |
| LEFT JOIN | Returns all rows from the left table and matching rows from the right | All students, even without departments |
| RIGHT JOIN | Returns all rows from the right table and matching rows from the left | All departments, even without students |
| FULL OUTER JOIN | Returns all rows from both tables | Complete list of students and departments |

### Conclusion

SQL joins are one of the most powerful features of relational databases because they allow data from multiple tables to be combined into a single result. `INNER JOIN` returns only matching records, `LEFT JOIN` includes all records from the left table, `RIGHT JOIN` includes all records from the right table, and `FULL OUTER JOIN` includes every record from both tables, regardless of whether a match exists. Understanding these join types is essential for retrieving meaningful information from related tables and forms the foundation for advanced database querying and reporting.');

-- Lecture 11: SQL Subqueries
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'SQL Subqueries', 11, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# SQL Subqueries

## Introduction to Subqueries

A **Subquery** is a query written **inside another SQL query**. It is also called an **Inner Query** or **Nested Query**. The subquery executes **first**, and its result is then used by the **main query (Outer Query)**. Think of a subquery as asking a helper to find some information before you make your final decision. For example: "Find the average GPA first, then show all students whose GPA is above that average." Instead of doing two separate queries, SQL allows us to combine them into one using a **subquery**.

## Why Do We Use Subqueries?

Subqueries are useful when:

- We need data from another query.

- We want to compare values with calculated results.

- We need to filter records dynamically.

- We want to avoid writing multiple separate queries.

**Example Questions**

- Which student has the highest GPA?

- Which students scored above the average GPA?

- Which employees earn more than the average salary?

- Which students belong to the department with ID 2?

All of these can be solved using subqueries.

## Basic Syntax of a Subquery

```

SELECT column_name
FROM table_name
WHERE column_name operator (
SELECT column_name
FROM table_name
);

```

The **inner query** runs first. The **outer query** uses the result returned by the inner query.

## Example Table

**Students**

| StudentID | Name | GPA | DepartmentID |
|---|---|---|---|
| 101 | Anum | 3.80 | 1 |
| 102 | Saba | 3.40 | 2 |
| 103 | Hamza | 3.90 | 1 |
| 104 | Ali | 3.20 | 3 |
| 105 | Ahmed | 3.60 | 2 |

**Departments**

| DepartmentID | DepartmentName |
|---|---|
| 1 | Artificial Intelligence |
| 2 | Computer Science |

## Subquery with Comparison Operators

### Example 1: Students with GPA Above Average

First, calculate the average GPA.

```

SELECT AVG(GPA)
FROM Students;

```

Suppose the average GPA is **3.58**. Instead of running two separate queries, use a subquery.

```

SELECT Name, GPA
FROM Students
WHERE GPA >
(
SELECT AVG(GPA)
FROM Students
);

```

**Output**

| Name | GPA |
|---|---|
| Anum | 3.80 |
| Hamza | 3.90 |
| Ahmed | 3.60 |

The inner query calculates the average GPA, and the outer query displays students whose GPA is higher than that average.

### Example 2: Student with Highest GPA

```

SELECT Name, GPA
FROM Students
WHERE GPA =
(
SELECT MAX(GPA)
FROM Students
);

```

**Output**

| Name | GPA |
|---|---|
| Hamza | 3.90 |

The subquery finds the highest GPA, and the outer query displays the student who achieved it.

## Subquery with IN Operator

The `IN` operator checks whether a value exists in a list returned by a subquery.

### Example

Display students who belong to the **Computer Science** department.

```

SELECT Name
FROM Students
WHERE DepartmentID IN
(
SELECT DepartmentID
FROM Departments
WHERE DepartmentName = \'Computer Science\'

```

**Output**

| Name |
|---|
| Saba |
| Ahmed |

The inner query finds the DepartmentID for Computer Science, and the outer query displays students in that department.

## Subquery with EXISTS

The `EXISTS` operator checks whether the subquery returns at least one row. If the subquery returns data, the condition is **TRUE**.

### Syntax

```

SELECT column_name
FROM table_name
WHERE EXISTS
(
SELECT *
FROM another_table
WHERE condition
);

```

### Example

Display departments that have at least one student.

```

SELECT DepartmentName
FROM Departments D
WHERE EXISTS
(
SELECT *
FROM Students S
WHERE S.DepartmentID = D.DepartmentID
);

```

**Output**

| DepartmentName |
|---|
| Artificial Intelligence |
| Computer Science |
| Software Engineering |

Every listed department has at least one student.

## Subquery with NOT IN

`NOT IN` returns rows whose values are **not** in the result of the subquery.

### Example

Display departments that have **no students**. Suppose a new department exists:

| DepartmentID | DepartmentName |
|---|---|
| 4 | Cyber Security |

```

SELECT DepartmentName
FROM Departments
WHERE DepartmentID NOT IN
(
SELECT DepartmentID
FROM Students
);

```

**Output**

| DepartmentName |
|---|
| Cyber Security |

## Subquery in the SELECT Statement

A subquery can also appear inside the `SELECT` clause.

### Example

Display each student\'s name along with the average GPA of all students.

```

SELECT Name,
(
SELECT AVG(GPA)
FROM Students
) AS AverageGPA
FROM Students;

```

**Output**

| Name | AverageGPA |
|---|---|
| Anum | 3.58 |
| Saba | 3.58 |
| Hamza | 3.58 |
| Ali | 3.58 |
| Ahmed | 3.58 |

The average GPA is displayed for every row.

## Subquery in the FROM Clause

A subquery can be treated like a temporary table.

### Example

```

SELECT *
FROM
(
SELECT Name, GPA
FROM Students
WHERE GPA > 3.50
) AS TopStudents;

```

**Output**

| Name | GPA |
|---|---|
| Anum | 3.80 |
| Hamza | 3.90 |
| Ahmed | 3.60 |

The subquery creates a temporary table called **TopStudents**, and the outer query retrieves its data.

## Nested Subqueries

A subquery can contain another subquery.

### Example

Display students from the department named **Artificial Intelligence**.

```

SELECT Name
FROM Students
WHERE DepartmentID =
(
SELECT DepartmentID
FROM Departments
WHERE DepartmentName =
(
SELECT \'Artificial Intelligence\'
)
);

```

**Output**

| Name |
|---|
| Anum |
| Hamza |

Although this example is simple, nested subqueries are useful in complex database applications.

## Subqueries vs Joins

Both subqueries and joins retrieve related data, but they are used differently.

| Subqueries | Joins |
|---|---|
| Query inside another query | Combines multiple tables directly |
| Easier for some logical conditions | Usually faster for related- table retrieval |
| Good for comparisons and calculations | Best for displaying data from multiple tables |
| Can become slower if deeply nested | Often more efficient for large datasets |

## Complete Example

**Students Table**

| StudentID | Name | GPA | DepartmentID |
|---|---|---|---|
| 101 | Anum | 3.80 | 1 |
| 102 | Saba | 3.40 | 2 |
| 103 | Hamza | 3.90 | 1 |
| 104 | Ali | 3.20 | 3 |
| 105 | Ahmed | 3.60 | 2 |

**Display Students Above Average GPA**

```

SELECT Name
FROM Students
WHERE GPA >
(
SELECT AVG(GPA)
FROM Students
);

```

**Output**

| Name |
|---|
| Anum |
| Hamza |
| Ahmed |

**Display Student with Highest GPA**

```

SELECT Name
FROM Students
WHERE GPA =
(
SELECT MAX(GPA)
FROM Students
);

```

**Output**

| Name |
|---|
| Hamza |

**Display Students in Computer Science**

```

SELECT Name
FROM Students
WHERE DepartmentID IN
(
SELECT DepartmentID
FROM Departments
WHERE DepartmentName = \'Computer Science\'
);

```

**Output**

| Name |
|---|
| Saba |
| Ahmed |

## Best Practices

- Use subqueries when the result of one query is required by another query.

- Ensure that the subquery returns the correct number of values.

- Use `=` when the subquery returns a single value.

- Use `IN` when the subquery returns multiple values.

- Use `EXISTS` to check whether related records exist.

- Avoid unnecessary deep nesting, as it can reduce readability and performance.

- Consider using `JOIN` instead of a subquery when retrieving related data from multiple tables, especially for large databases.

- Format subqueries with proper indentation to improve readability. Future you will thank present you, which is one of the few reliable

gratitude loops in programming.

## Summary

| Subquery Type | Purpose | Example |
|---|---|---|
| Comparison ( =, >, <) | Compare values with calculated results | WHERE GPA > (SELECT AVG(GPA) FROM Students) |
| IN | Match multiple values | WHERE DepartmentID IN (...) |
| NOT IN | Exclude values returned by subquery | WHERE DepartmentID NOT IN (...) |
| EXISTS | Check if matching rows exist | WHERE EXISTS (...) |
| SELECT Clause | Return calculated values | SELECT Name, (SELECT AVG(GPA)...) |
| FROM Clause | Use subquery as a temporary table | FROM (SELECT ...) AS TopStudents |

### Conclusion

A **subquery** is a powerful SQL feature that allows one query to be embedded inside another. It helps perform complex operations such as comparisons, filtering, calculations, and existence checks without requiring multiple separate queries. Subqueries can be used with comparison operators, `IN`, `NOT IN`, `EXISTS`, and within the `SELECT` or `FROM` clauses. Understanding subqueries enables us to write flexible and efficient SQL statements, making them an essential skill for solving real-world database problems.');

-- Lecture 12: Indexes in SQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Indexes in SQL', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Indexes in SQL

## Introduction to Indexes

An **Index** in SQL is a database object that **improves the speed of data retrieval** from a table. When a database contains thousands or even millions of records, searching for specific data can become slow. An index helps the database locate the required records much faster without scanning every row. Think of an index in a database like the **index of a textbook**. Instead of reading every page to find the topic "SQL Joins," you simply check the index, find the page number, and go directly to that page. Similarly, a database uses indexes to quickly locate data.

## Why Do We Need Indexes?

Without an index, the database performs a **Full Table Scan**, meaning it checks every row until it finds the required data. Imagine a **Students** table with **1,000,000 records**. Suppose we execute:

```

SELECT *
FROM Students
WHERE StudentID = 500000;

```

Without an index, the database may need to search through a large portion of the table before finding the correct record. With an index on `StudentID`, the database can locate the record much faster.

### Advantages of Indexes

- Faster data retrieval.

- Improves `SELECT` query performance.

- Speeds up searching, sorting, and filtering.

- Improves performance of `JOIN` operations.

- Reduces query execution time.

## How Indexes Work

An index stores:

- Indexed column values.

- A reference (pointer) to the corresponding row in the table.

Instead of searching every row, SQL first searches the index and then jumps directly to the required record. **Without Index**

```

Row 1
Row 2
Row 3
...
Row 999999
Row 1000000

```

The database checks rows one by one. **With Index**

```

Index
↓
Required Row

```

The database reaches the required row much more quickly.

## Types of Indexes

The most common types of indexes are:

- Primary Index

- Unique Index

- Single-Column Index

- Composite (Multi-Column) Index

Some database systems also support advanced indexes such as Full-Text, Spatial, and Clustered/Non-Clustered indexes.

## Primary Index

A **Primary Index** is automatically created when a **PRIMARY KEY** is defined. **Example**

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT
);

```

Since `StudentID` is the Primary Key, the database automatically creates an index for it. **Benefits**

- Faster searches using the primary key.

- Ensures unique values.

- Improves overall query performance.

## Unique Index

A **Unique Index** ensures that all indexed values are unique. **Syntax**

```

CREATE UNIQUE INDEX idx_email
ON Students (Email);

```

**Example**

```

CREATE UNIQUE INDEX idx_cnic
ON Students (CNIC);

```

Now, duplicate CNIC numbers cannot be inserted.

## Single-Column Index

A **Single-Column Index** is created on one column. **Syntax**

```

CREATE INDEX index_name
ON table_name (column_name);

```

**Example**

```

CREATE INDEX idx_name
ON Students (Name);

```

Searching by name becomes faster. **Example Query**

```

SELECT *
FROM Students
WHERE Name = \'Anum\';

```

The database uses the index to find the record quickly.

## Composite (Multi-Column) Index

A **Composite Index** is created using two or more columns. **Syntax**

```

CREATE INDEX index_name
ON table_name (column1, column2);

```

**Example**

```

CREATE INDEX idx_dept_age
ON Students (DepartmentID, Age);

```

This index is useful for queries like:

```

SELECT *
FROM Students
WHERE DepartmentID = 1
AND Age = 20;

```

Instead of searching every row, SQL uses the composite index.

## Creating an Index

**Syntax**

```

CREATE INDEX index_name
ON table_name (column_name);

```

**Example**

```

CREATE INDEX idx_department
ON Students (DepartmentID);

```

The `DepartmentID` column is now indexed.

## Viewing Existing Indexes

The command to view indexes depends on the database system. **MySQL / MariaDB**

```

SHOW INDEX FROM Students;

```

This displays:

- Index name

- Indexed column

- Index type

- Uniqueness

## Dropping an Index

If an index is no longer needed, it can be removed. **MySQL / MariaDB**

```

DROP INDEX idx_department
ON Students;

```

**SQL Server**

```

DROP INDEX Students.idx_department;

```

The syntax varies slightly between database systems.

## When Should We Create Indexes?

Indexes are recommended for columns that are:

- Frequently searched.

- Frequently used in the `WHERE` clause.

- Frequently used in `JOIN` conditions.

- Frequently sorted using `ORDER BY`.

- Frequently grouped using `GROUP BY`.

- StudentID

- Email

- CNIC

- DepartmentID

- EmployeeID

- OrderID

## When Should We Avoid Indexes?

Indexes are not always beneficial. Avoid creating indexes on:

- Very small tables.

- Columns that change frequently.

- Columns with very few unique values (such as Gender).

- Tables with many `INSERT`, `UPDATE`, or `DELETE` operations if the index provides little benefit.

Every time data changes, the database must also update the index, which adds some overhead.

## Advantages of Indexes

- Faster searching.

- Faster filtering.

- Faster sorting.

- Faster joins.

- Improved query performance.

- Reduced execution time.

- Better user experience in large databases.

## Disadvantages of Indexes

- Require additional storage space.

- Slow down `INSERT`, `UPDATE`, and `DELETE` operations because indexes must also be updated.

- Too many indexes can reduce overall database performance.

- Require maintenance in very large databases.

## Complete Example

**Create Table**

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(100),
DepartmentID INT
);

```

**Create Index on Name**

```

CREATE INDEX idx_name
ON Students (Name);

```

**Create Unique Index on Email**

```

CREATE UNIQUE INDEX idx_email
ON Students (Email);

```

**Create Composite Index**

```

CREATE INDEX idx_department_name
ON Students (DepartmentID, Name);

```

**Search Query**

```

SELECT *
FROM Students
WHERE Name = \'Hamza\';

```

The database uses the `idx_name` index to locate Hamza\'s record efficiently. **Join Query**

```

SELECT Students.Name,
Departments.DepartmentName
FROM Students
INNER JOIN Departments
ON Students.DepartmentID = Departments.DepartmentID;

```

If `DepartmentID` is indexed, this join executes faster, especially on large tables.

## Best Practices

- Create indexes only on columns that are frequently searched.

- Avoid creating unnecessary indexes.

- Use **PRIMARY KEY** and **UNIQUE** constraints whenever appropriate, as they automatically create indexes in most database systems.

- Regularly review unused indexes.

- Use composite indexes when multiple columns are commonly searched together.

- Do not index columns with very few distinct values unless there is a specific reason.

- Test query performance before and after adding indexes.

- Remember that indexes improve read performance but can slow write operations. Like a library catalog, they make finding books much

faster, but someone has to keep the catalog updated every time a new book arrives.

## Summary

| Index Type | Purpose | Example |
|---|---|---|
| Primary Index | Automatically created for Primary Key | StudentID PRIMARY KEY |
| Unique Index | Prevents duplicate values | CREATE UNIQUE INDEX idx_email ON Students(Email); |
| Single-Column Index | Improves searches on one column | CREATE INDEX idx_name ON Students(Name); |
| Composite Index | Improves searches using multiple columns | CREATE INDEX idx_dept_age ON Students(DepartmentID, Age); |

**Common Index Commands**

| Command | Purpose |
|---|---|
| CREATE INDEX | Creates an index |
| CREATE UNIQUE INDEX | Creates a unique index |
| SHOW INDEX | Displays indexes (MySQL/MariaDB) |
| DROP INDEX | Removes an index |

### Conclusion

Indexes are one of the most important performance optimization features in SQL databases. They allow the database to locate records quickly, significantly improving the speed of `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, and `JOIN` operations. However, indexes also consume storage space and can slow down data modification operations because they must be updated whenever records change. Therefore, indexes should be created thoughtfully on frequently searched columns to achieve the best balance between query performance and database maintenance.');

-- Lecture 13: Views & Transactions in SQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Views & Transactions in SQL', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Views & Transactions in SQL

## Introduction to Views and Transactions

In SQL, **Views** and **Transactions** are two important concepts that help us manage and work with data more efficiently.

- A **View** is a **virtual table** created from one or more existing tables. It does not usually store data itself; instead, it displays data retrieved

from other tables.

- A **Transaction** is a sequence of SQL statements executed as a single unit of work. It ensures that database operations are completed

successfully or not performed at all. Think of a **View** as looking through a window. You can see the information outside without changing the actual environment. A **Transaction** is like transferring money between two bank accounts. Either both the withdrawal and deposit happen successfully, or neither happens. Partial completion would lead to incorrect data.

## What is a View?

A **View** is a virtual table created using a `SELECT` statement. Instead of storing data separately, it displays data from one or more existing tables whenever it is queried.

### Advantages of Views

- Simplifies complex queries.

- Improves data security.

- Hides unnecessary columns.

- Makes frequently used queries reusable.

- Presents data in a customized format.

### Syntax

```

CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;

```

## Creating a View

Suppose we have the following **Students** table.

| StudentID | Name | GPA | Department |
|---|---|---|---|
| 101 | Anum | 3.8 | AI |
| 102 | Saba | 3.4 | CS |
| 103 | Hamza | 3.9 | AI |
| 104 | Ali | 3.2 | SE |

Create a view to display only student names and GPAs.

```

CREATE VIEW StudentGPA AS
SELECT Name, GPA
FROM Students;

```

The view is now created.

## Retrieving Data from a View

Once the view exists, we can query it like a normal table.

```

SELECT *
FROM StudentGPA;

```

**Output**

| Name | GPA |
|---|---|
| Anum | 3.8 |
| Saba | 3.4 |
| Hamza | 3.9 |
| Ali | 3.2 |

Notice that the original table remains unchanged.

## Creating a View with a Condition

Views can also include filtering conditions. **Example** Display only students whose GPA is greater than **3.5**.

```

CREATE VIEW TopStudents AS
SELECT Name, GPA
FROM Students
WHERE GPA > 3.5;

```

Retrieve the data:

```

SELECT *
FROM TopStudents;

```

**Output**

| Name | GPA |
|---|---|
| Anum | 3.8 |
| Hamza | 3.9 |

The view automatically applies the condition every time it is used.

## Creating a View Using Multiple Tables

Views can combine data from multiple tables. **Students Table**

| StudentID | Name | DepartmentID |
|---|---|---|
| 101 | Anum | 1 |
| 102 | Saba | 2 |
| 103 | Hamza | 1 |

**Departments Table**

| DepartmentID | DepartmentName |
|---|---|
| 1 | Artificial Intelligence |
| 2 | Computer Science |

Create a view using an `INNER JOIN`.

```

CREATE VIEW StudentDepartments AS
SELECT Students.Name,
Departments.DepartmentName
FROM Students
ON Students.DepartmentID = Departments.DepartmentID;

```

Retrieve the data.

```

SELECT *
FROM StudentDepartments;

```

**Output**

| Name | DepartmentName |
|---|---|
| Anum | Artificial Intelligence |
| Saba | Computer Science |
| Hamza | Artificial Intelligence |

## Updating a View

Some views can be updated if they are based on a single table and do not contain complex operations such as `GROUP BY`, aggregate functions, or joins. **Example**

```

UPDATE StudentGPA
SET GPA = 3.9
WHERE Name = \'Saba\';

```

This updates the **Students** table because the view is based on that table. **Note:** Not all views are updatable. Complex views containing joins, aggregate functions, or grouping are often read-only.

## Dropping a View

If a view is no longer needed, it can be removed.

### Syntax

```

DROP VIEW view_name;

```

**Example**

```

DROP VIEW StudentGPA;

```

Only the view is deleted. The original table remains unchanged.

## What is a Transaction?

A **Transaction** is a group of one or more SQL statements that are executed together as a single unit. If every statement succeeds, the transaction is **committed**. If any statement fails, the transaction is **rolled back**, restoring the database to its previous state.

### Why Are Transactions Important?

Transactions ensure:

- Data consistency.

- Data accuracy.

- Data reliability.

- Prevention of incomplete updates.

### Example

A bank transfers **Rs. 5,000** from Account A to Account B. Steps: 1. Deduct Rs. 5,000 from Account A. 2. Add Rs. 5,000 to Account B. If the system crashes after Step 1, the money disappears. Transactions prevent this by ensuring that **both operations succeed together or neither happens**.

## Transaction Commands

The main transaction commands are:

- `START TRANSACTION` (or `BEGIN`)

- `COMMIT`

- `ROLLBACK`

- `SAVEPOINT`

### START TRANSACTION

Begins a new transaction.

```

START TRANSACTION;

```

or

```

BEGIN;

```

### COMMIT

The `COMMIT` command permanently saves all changes.

```

COMMIT;

```

Once committed, the changes cannot be rolled back.

### ROLLBACK

The `ROLLBACK` command cancels all changes made during the current transaction.

```

ROLLBACK;

```

The database returns to its previous state.

### SAVEPOINT

A `SAVEPOINT` creates a checkpoint within a transaction.

```

SAVEPOINT Save1;

```

If needed, we can roll back to that checkpoint instead of canceling the entire transaction.

```

ROLLBACK TO Save1;

```

## Example of a Transaction

Suppose the **Accounts** table contains:

| Account | Balance |
|---|---|
| Anum | 10000 |
| Hamza | 5000 |

Transfer **Rs. 2,000** from Anum to Hamza.

```

START TRANSACTION;

```

Withdraw money:

```

UPDATE Accounts
SET Balance = Balance - 2000
WHERE Account = \'Anum\';

```

Deposit money:

```

UPDATE Accounts
SET Balance = Balance + 2000
WHERE Account = \'Hamza\';

```

Save the changes:

```

COMMIT;

```

If any error occurs before the `COMMIT`, execute:

```

ROLLBACK;

```

Both updates are canceled.

## ACID Properties of Transactions

Every transaction follows the **ACID** properties.

### 1. Atomicity

A transaction is completed entirely or not at all. **Example:** Money transfer either completes fully or is canceled.

### 2. Consistency

The database remains valid before and after the transaction. Example:

- Total money before transfer = Total money after transfer.

### 3. Isolation

Multiple transactions do not interfere with one another. Each transaction executes independently.

### 4. Durability

Once a transaction is committed, the changes are permanent, even if the system crashes.

## Difference Between Views and Transactions

| Views | Transactions |
|---|---|
| Virtual tables | Group of SQL operations |
| Display data | Modify data safely |
| Created using CREATE VIEW | Started using START TRANSACTION or BEGIN |
| Simplify data access | Maintain data integrity |
| Improve security and reusability | Ensure reliable updates |

## Complete Example

```

CREATE VIEW TopStudents AS
SELECT Name, GPA
FROM Students
WHERE GPA > 3.5;

```

Display the view.

```

SELECT *
FROM TopStudents;

```

**Transaction Example**

```

START TRANSACTION;
UPDATE Accounts
SET Balance = Balance - 1000
WHERE Account = \'Anum\';
UPDATE Accounts
SET Balance = Balance + 1000
WHERE Account = \'Saba\';
COMMIT;

```

If an error occurs:

```

ROLLBACK;

```

## Best Practices

- Use views to simplify complex queries and hide sensitive data.

- Create views for frequently used reports.

- Avoid creating unnecessary views that are rarely used.

- Use transactions whenever multiple related operations must succeed together.

- Always use `COMMIT` only after verifying that all operations completed successfully.

- Use `ROLLBACK` to recover from errors and prevent inconsistent data.

- Use `SAVEPOINT` for long transactions where partial recovery may be needed.

- Keep transactions as short as possible to reduce locking and improve database performance. Databases appreciate decisiveness far

more than endless hesitation.

## Summary

| Feature | Purpose | Example |
|---|---|---|
| CREATE VIEW | Creates a virtual table | CREATE VIEW StudentGPA AS SELECT Name, GPA FROM Students; |
| SELECT | Retrieves data from a view | SELECT * FROM StudentGPA; |
| DROP VIEW | Deletes a view | DROP VIEW StudentGPA; |
| START TRANSACTION | Begins a transaction | START TRANSACTION; |
| COMMIT | Saves all changes permanently | COMMIT; |
| ROLLBACK | Cancels all changes | ROLLBACK; |
| SAVEPOINT | Creates a checkpoint | SAVEPOINT Save1; |

### Conclusion

Views and transactions are essential features of SQL that improve both efficiency and reliability. **Views** simplify complex queries, enhance security by restricting access to selected data, and provide reusable virtual tables. **Transactions** ensure that multiple database operations are executed safely as a single unit, protecting data from inconsistencies through commands such as `COMMIT`, `ROLLBACK`, and `SAVEPOINT`. Together, these features help build secure, organized, and dependable database systems capable of handling real-world applications effectively.');

-- Lecture 14: Building a Database Schema for a Project
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a Database Schema for a Project', 14, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a Database Schema for a Project

## Introduction to Database Schema

A **Database Schema** is the **blueprint or structure** of a database. It defines how data is organized, what tables exist, the columns in each table, the relationships between tables, and the rules that maintain data integrity. Before writing SQL queries or creating tables, a database designer first creates a schema. A well-designed schema makes the database easier to manage, faster to query, and less likely to contain duplicate or inconsistent data. Think of a database schema as the architectural plan of a house. Before construction begins, the architect designs the rooms, doors, and connections. Similarly, a schema defines how different tables connect and interact.

## Why Do We Need a Database Schema?

A database schema helps us:

- Organize data efficiently.

- Reduce data duplication.

- Maintain relationships between tables.

- Improve query performance.

- Ensure data consistency and integrity.

- Make future modifications easier.

Without a proper schema, databases become difficult to maintain and often contain repeated or inconsistent information.

## Steps to Build a Database Schema

Building a database schema usually follows these steps: 1. Understand the project requirements. 2. Identify the entities. 3. Define table attributes. 4. Select Primary Keys. 5. Create relationships between tables. 6. Apply Foreign Keys. 7. Add constraints. 8. Normalize the database. 9. Create the tables.

## Example Project: Student Management System

Suppose a university wants a database to manage:

- Students

- Departments

- Courses

- Teachers

- Enrollments

From these requirements, we identify the main **entities**. **Entities**

- Students

- Departments

- Courses

- Teachers

- Enrollments

Each entity becomes a separate table.

## Designing the Tables

### 1. Students Table

| Column | Data Type | Constraint |
|---|---|---|
| StudentID | INT | PRIMARY KEY |
| Name | VARCHAR(50) | NOT NULL |
| Email | VARCHAR(100) | UNIQUE |
| Age | INT | CHECK (Age >= 18) |
| DepartmentID | INT | FOREIGN KEY |

### SQL

```

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE,
Age INT CHECK (Age >= 18),
DepartmentID INT
);

```

### 2. Departments Table

| Column | Data Type | Constraint |
|---|---|---|
| DepartmentID | INT | PRIMARY KEY |
| DepartmentName | VARCHAR(50) | UNIQUE |

```

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50) UNIQUE
);

```

### 3. Teachers Table

| Column | Data Type | Constraint |
|---|---|---|
| TeacherID | INT | PRIMARY KEY |
| TeacherName | VARCHAR(50) | NOT NULL |
| DepartmentID | INT | FOREIGN KEY |

```

CREATE TABLE Teachers (
TeacherID INT PRIMARY KEY,
TeacherName VARCHAR(50),
DepartmentID INT
);

```

| Column | Data Type | Constraint |
|---|---|---|
| CourseID | INT | PRIMARY KEY |
| CourseName | VARCHAR(100) | NOT NULL |
| DepartmentID | INT | FOREIGN KEY |
| TeacherID | INT | FOREIGN KEY |

```

CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
CourseName VARCHAR(100),
DepartmentID INT,
TeacherID INT
);

```

### 5. Enrollments Table

This table connects students and courses.

| Column | Data Type | Constraint |
|---|---|---|
| EnrollmentID | INT | PRIMARY KEY |
| StudentID | INT | FOREIGN KEY |
| CourseID | INT | FOREIGN KEY |
| Semester | VARCHAR(20) | NOT NULL |

```

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
Semester VARCHAR(20)
);

```

## Establishing Relationships

Relationships connect tables together. **One-to-Many Relationship** One department can have many students.

```

Departments
│
│
├────────► Students

```

Relationship:

```

One Department → Many Students

```

Another example:

```

Departments
│
├────────► Teachers

```

One department can have many teachers.

## Many-to-Many Relationship

Students can enroll in many courses. Courses can have many students. This creates a **Many-to-Many Relationship**, which is solved using a junction table.

```

Students
│
▼
Enrollments
▲
│
Courses

```

The **Enrollments** table stores the relationship.

## Adding Foreign Keys

Now we connect the tables. **Students Table**

```

ALTER TABLE Students
ADD CONSTRAINT FK_Department
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID);

```

**Teachers Table**

```

ALTER TABLE Teachers
ADD CONSTRAINT FK_TeacherDepartment
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID);

```

**Courses Table**

```

ALTER TABLE Courses
ADD CONSTRAINT FK_CourseDepartment
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID);
ALTER TABLE Courses
ADD CONSTRAINT FK_CourseTeacher
FOREIGN KEY (TeacherID)
REFERENCES Teachers(TeacherID);

```

**Enrollments Table**

```

ALTER TABLE Enrollments
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID);
ALTER TABLE Enrollments
ADD CONSTRAINT FK_Course
FOREIGN KEY (CourseID)
REFERENCES Courses(CourseID);

```

## Entity Relationship (ER) Diagram

A simple ER diagram for this project looks like this.

```

Departments
------------------
DepartmentID (PK)
DepartmentName
│
│
┌──────┴─────────┐
│ │
▼ ▼
Students Teachers
--------- ----------
StudentID TeacherID
Name TeacherName
DepartmentID DepartmentID
│
│
▼
Enrollments
--------------
EnrollmentID
StudentID
CourseID
Semester
▲
│
│
Courses
------------
CourseID
CourseName
DepartmentID
TeacherID

```

This diagram clearly shows how each table is related.

## Normalization in Schema Design

Normalization reduces duplicate data and improves consistency. **First Normal Form (1NF)**

- No repeating groups.

- Atomic values only.

**Second Normal Form (2NF)**

- Remove partial dependency.

- Every non-key column depends on the entire Primary Key.

**Third Normal Form (3NF)**

- Remove transitive dependency.

- Non-key columns depend only on the Primary Key.

A properly normalized database is easier to maintain and minimizes redundancy.

## Naming Conventions

Good naming conventions improve readability. **Table Names** Use meaningful names. Good examples:

- Students

- Departments

- Courses

- Teachers

- Enrollments

Avoid names like:

- Table1

- Data

- Info

**Column Names** Use descriptive names. Good examples:

- StudentID

- CourseName

- DepartmentName

- EnrollmentDate

Avoid unclear names like:

- ID1

- Name1

- Temp

## Best Practices for Schema Design

- Understand the project requirements before designing the database.

- Create separate tables for separate entities.

- Choose appropriate data types.

- Define a Primary Key for every table.

- Use Foreign Keys to create relationships.

- Normalize the database to reduce redundancy.

- Apply constraints such as `NOT NULL`, `UNIQUE`, and `CHECK`.

- Create indexes on frequently searched columns.

- Use meaningful table and column names.

- Document the schema with an ER diagram.

- Plan for future scalability by designing tables that can accommodate new features without major restructuring. Changing a schema after

thousands of records exist is possible, but it is about as relaxing as renovating a house while people are still living in it.

## Complete Project Schema

| Table | Primary Key | Foreign Keys |
|---|---|---|
| Departments | DepartmentID | — |
| Students | StudentID | DepartmentID |
| Teachers | TeacherID | DepartmentID |
| Courses | CourseID | DepartmentID, TeacherID |
| Enrollments | EnrollmentID | StudentID, CourseID |

## Summary

| Step | Description |
|---|---|
| Identify Requirements | Understand project needs |
| Identify Entities | Determine main objects (Students, Courses, etc.) |
| Create Tables | One table per entity |
| Define Primary Keys | Uniquely identify each record |
| Create Relationships | Connect related tables |
| Apply Foreign Keys | Maintain referential integrity |
| Normalize Data | Remove redundancy |
| Add Constraints | Ensure valid data |
| Create ER Diagram | Visualize the database structure |

### Conclusion

Building a database schema is the foundation of every successful database project. A well-designed schema organizes data into meaningful tables, establishes relationships using primary and foreign keys, enforces data integrity through constraints, and minimizes redundancy through normalization. By carefully analyzing project requirements, defining entities, creating relationships, and following best practices, we can develop scalable, efficient, and reliable database systems that support both current needs and future growth.');
