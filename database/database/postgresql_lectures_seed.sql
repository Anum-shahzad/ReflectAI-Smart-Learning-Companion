-- =============================================
-- ReflectAI — PostgreSQL Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'PostgreSQL' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to PostgreSQL', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to PostgreSQL

In today\'s digital world, data is often called the **new oil**, and databases are the engines that keep applications running smoothly. Whether we are using social media, shopping online, managing hospital records, or analyzing business reports, databases work quietly behind the scenes. Among the many database management systems available today, **PostgreSQL** has earned a reputation for being one of the most powerful, reliable, and feature-rich open-source relational database management systems (RDBMS). Imagine a well-organized library. Every book has its own place, every shelf is labeled, and the librarian can quickly locate any book you need. PostgreSQL works in a similar way by organizing, storing, and retrieving large amounts of information efficiently. To make managing PostgreSQL easier, developers often use **pgAdmin**, a graphical user interface (GUI) that allows users to interact with databases without relying entirely on command-line instructions. In these lecture notes, we will explore PostgreSQL, understand its architecture and features, learn how to install PostgreSQL and pgAdmin, and discover why PostgreSQL is trusted by organizations worldwide.

## Introduction to PostgreSQL

### What is PostgreSQL?

**PostgreSQL** (commonly pronounced **Post-gres-Q-L**) is a powerful, open-source **Relational Database Management System (RDBMS)** that stores, organizes, and manages structured data using SQL (Structured Query Language). Originally developed from the **POSTGRES** project at the University of California, Berkeley, PostgreSQL has evolved into one of the world\'s most advanced database systems. It is widely used in:

- Web applications

- Banking systems

- Healthcare applications

- E-commerce platforms

- Government databases

- Educational systems

- Data analytics platforms

### Why is PostgreSQL Popular?

PostgreSQL has gained popularity because it offers:

- Open-source and free to use.

- High reliability and stability.

- Excellent performance.

- Advanced SQL support.

- Strong security features.

- ACID-compliant transactions.

- Extensibility through custom functions and data types.

- Cross-platform compatibility.

These features make PostgreSQL suitable for both small applications and enterprise-level systems.

### Key Features of PostgreSQL

Some of PostgreSQL\'s most important features include:

- Relational database support

- Advanced indexing

- Views and materialized views

- Stored procedures

- Triggers

- Foreign keys

- Transactions

- JSON and JSONB support

- Full-text search

- Window functions

- Partitioning

- Replication

These capabilities allow PostgreSQL to handle complex applications with ease.

## Understanding PostgreSQL Architecture

PostgreSQL follows a **client-server architecture**, where multiple users (clients) communicate with a centralized database server.

```

Client Application
│
▼
PostgreSQL Server
│
▼
Databases
│
▼
Tables

```

The server receives SQL queries, processes them, retrieves or modifies data, and returns results to the client.

### Components of PostgreSQL

### Database Server

The PostgreSQL Server is responsible for:

- Managing databases.

- Processing SQL queries.

- Handling transactions.

- Managing security.

- Controlling concurrent users.

### Database

A database is a collection of related tables and other database objects. Examples:

- UniversityDB

- HospitalDB

- BankingDB

- InventoryDB

### Tables

Tables store actual data. Example:

| StudentID | Name | Department |
|---|---|---|
| 1 | Ali | AI |
| 2 | Sara | CS |

Each row represents a record, while each column represents an attribute.

### Schemas

A **Schema** is a logical container inside a database that organizes tables, views, functions, and other objects. Schemas help keep large databases well organized.

## Advantages of PostgreSQL

PostgreSQL provides many benefits.

### 1. Open Source

PostgreSQL is completely free. Developers can:

- Download it.

- Modify it.

- Distribute it.

- Use it commercially.

No licensing fees are required.

### 2. ACID Compliance

PostgreSQL follows the **ACID properties**:

- Atomicity

- Consistency

- Isolation

- Durability

This ensures reliable and secure transactions.

### 3. High Performance

PostgreSQL efficiently handles:

- Large databases

- Complex SQL queries

- Concurrent users

- High-volume transactions

### 4. Security

PostgreSQL includes:

- User authentication

- Role-based access control

- SSL encryption

- Password protection

- Data integrity mechanisms

### 5. Extensibility

Developers can create:

- Custom functions

- Custom operators

- New data types

- Extensions

This flexibility makes PostgreSQL highly adaptable.

## PostgreSQL vs Other Database Systems

| Feature | PostgreSQL | MySQL |
|---|---|---|
| License | Open Source | Open Source |
| ACID Compliance | Full | Full (InnoDB) |
| JSON Support | Excellent (JSON & JSONB) | Good |
| Extensibility | Very High | Moderate |
| Advanced SQL Features | Extensive | Moderate |
| Performance | Excellent for complex queries | Excellent for web applications |
| Community Support | Large | Large |

Both databases are excellent, but PostgreSQL is often preferred for applications requiring advanced SQL functionality and complex data processing.

## What is pgAdmin?

### Introduction

**pgAdmin** is the official graphical administration and development tool for PostgreSQL. Instead of typing every SQL command manually, pgAdmin allows users to manage databases through an intuitive graphical interface. It is especially useful for beginners and database administrators.

### Features of pgAdmin

pgAdmin allows users to:

- Create databases.

- Create tables.

- Execute SQL queries.

- Manage users.

- Backup databases.

- Restore databases.

- Monitor server performance.

- Import and export data.

It combines powerful database management features with an easy-to-use interface.

## System Requirements

Before installing PostgreSQL, ensure your computer meets the basic requirements.

### Operating Systems

PostgreSQL supports:

- Windows

- Linux

- macOS

### Hardware Requirements

Recommended:

- 2 GB RAM or more

- Dual-core processor

- At least 500 MB free disk space

- Stable internet connection for downloading installers

## Installing PostgreSQL

### Step 1: Download PostgreSQL

Visit the official PostgreSQL website and download the installer for your operating system. The installer typically includes:

- PostgreSQL Server

- pgAdmin

- Command-line tools

- Stack Builder (optional)

### Step 2: Run the Installer

Launch the installer. The setup wizard will guide you through the installation process. Click **Next** to continue.

### Step 3: Select Installation Directory

Choose the installation folder. Example:

```

C:\\Program Files\\PostgreSQL\\17

```

The default location is suitable for most users.

### Step 4: Select Components

Choose the components to install. Typically select:

- PostgreSQL Server

- pgAdmin

- Command Line Tools

- Stack Builder (optional)

### Step 5: Set the Data Directory

Choose where PostgreSQL will store database files. Most users can keep the default location.

### Step 6: Create the Superuser Password

Create a strong password for the default PostgreSQL administrator account (**postgres**). Example: `Admin@2026#Secure` Remember this password because it will be required whenever you connect to the server.

### Step 7: Configure the Port

The default PostgreSQL port is: `5432` Unless another application is using this port, keep the default value.

### Step 8: Choose Locale

Select the desired language and regional settings. Most users should keep the default locale.

### Step 9: Install PostgreSQL

Click **Next** and then **Install**. The installation process copies all required files to your computer.

### Step 10: Finish Installation

After installation completes, click **Finish**. PostgreSQL Server is now installed.

## Installing pgAdmin

In many PostgreSQL installers, pgAdmin is installed automatically. If installing separately:

### Step 1

Download pgAdmin.

### Step 2

Run the installer.

### Step 3

Follow the setup wizard.

### Step 4

Choose the installation folder.

### Step 5

Complete the installation. After installation, launch pgAdmin from the Start Menu or Applications folder.

## Connecting pgAdmin to PostgreSQL

When pgAdmin starts: 1. Open pgAdmin. 2. Enter the master password (if prompted). 3. Expand **Servers**. 4. Select the PostgreSQL server. 5. Enter the password created during installation. 6. Click **Save Password** if desired. 7. Connect to the server. You can now manage databases using the graphical interface.

## Verifying the Installation

To ensure PostgreSQL is installed correctly:

### Method 1: Using pgAdmin

If the server opens successfully and displays the available databases, the installation is working correctly.

### Method 2: Using SQL

Open the Query Tool and execute:

```

SELECT version();

```

Example output: `PostgreSQL 17.x` This confirms that PostgreSQL is installed and running.

### Method 3: Using Command Line

Run: `psql --version` If the version number appears, the command-line tools are installed successfully.

## Common Installation Problems

Beginners may encounter several issues.

### Incorrect Password

Cause:

- Forgotten superuser password.

Solution:

- Reset the PostgreSQL password.

### Port Already in Use

Cause:

- Another application is using port **5432**.

Solution:

- Choose another available port during installation.

### Server Not Running

Cause:

- PostgreSQL service is stopped.

Solution:

- Start the PostgreSQL service from the operating system\'s service manager.

### Connection Refused

Cause:

- Incorrect host, port, username, or password.

Solution:

- Verify all connection settings before trying again.

## Best Practices

To ensure a successful PostgreSQL installation and secure environment:

- Download PostgreSQL only from the official website.

- Use a strong password for the `postgres` superuser account.

- Keep PostgreSQL and pgAdmin updated with the latest stable releases.

- Back up databases regularly.

- Do not use the `postgres` account for everyday application development.

- Restrict remote access unless it is required.

- Secure the database server using firewalls and strong authentication.

- Document installation settings for future maintenance.

## Real-World Applications of PostgreSQL

PostgreSQL powers many modern applications.

### Banking Systems

- Secure financial transactions.

- Fraud detection.

### Healthcare

- Electronic medical records.

- Appointment scheduling.

- Laboratory management.

### E-Commerce

- Product catalogs.

- Shopping carts.

- Customer orders.

- Payment processing.

### Education

- Student information systems.

- Learning management systems.

- Examination portals.

- Library management.

These examples demonstrate PostgreSQL\'s versatility and reliability across industries.

### Conclusion

PostgreSQL is one of the most advanced and dependable open-source relational database management systems available today. Its robust feature set, ACID-compliant transactions, advanced SQL capabilities, strong security, and exceptional scalability make it an excellent choice for applications ranging from small personal projects to large enterprise solutions. Combined with **pgAdmin**, which provides an intuitive graphical interface for managing databases, PostgreSQL becomes even more accessible to beginners while remaining powerful enough for experienced developers and database administrators. By understanding PostgreSQL\'s architecture, completing a proper installation, and learning how to manage databases through pgAdmin, we establish a solid foundation for developing secure, efficient, and high-performance database applications.');

-- Lecture 2: Creating Databases & Schemas in PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Creating Databases & Schemas in PostgreSQL', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Creating Databases & Schemas in PostgreSQL

A database is the heart of every data-driven application. Whether we are developing a university management system, an online shopping platform, or a banking application, we need a structured place to store and organize information. PostgreSQL provides two important concepts for organizing data: **Databases** and **Schemas**. While a database serves as the primary storage container, a schema acts as a logical folder that organizes database objects such as tables, views, indexes, functions, and sequences. Imagine a large university campus. The campus itself represents the **database**, while the different departments—such as Computer Science, Mathematics, and Business—represent **schemas**. Each department contains its own classrooms, laboratories, and offices without interfering with others. Similarly, schemas help organize database objects, making databases easier to manage, secure, and maintain. In these lecture notes, we will explore databases and schemas, understand their differences, learn how to create and manage them, examine practical SQL examples, and discover best practices for organizing PostgreSQL databases effectively.

## Understanding Databases

### What is a Database?

A **Database** is a structured collection of related data stored electronically. It acts as the highest-level container in PostgreSQL, holding schemas, tables, views, functions, indexes, and other database objects. A database allows us to:

- Store large amounts of information.

- Retrieve data quickly.

- Maintain relationships between data.

- Enforce data integrity.

- Support multiple users simultaneously.

Each PostgreSQL server can contain multiple independent databases.

### Why Do We Create Multiple Databases?

Organizations often create separate databases for different applications or environments. Examples include:

- UniversityDB

- HospitalDB

- BankingDB

- InventoryDB

- EmployeeDB

Keeping applications in separate databases improves organization, security, and maintenance.

### Database Hierarchy

A PostgreSQL server organizes data in the following hierarchy:

```

PostgreSQL Server
│
▼
Database
│
▼
Schema
│
▼
Table
│
▼
Records

```

This hierarchy helps organize information efficiently.

## Creating and Managing Databases

### Creating a Database

The `CREATE DATABASE` statement creates a new database.

### Syntax

```

CREATE DATABASE database_name;

```

### Example

```

CREATE DATABASE UniversityDB;

```

A new database named **UniversityDB** is created.

### Viewing Existing Databases

To display all databases in PostgreSQL using the command-line interface: `\\l` This command lists all available databases along with their owners and encoding information.

### Connecting to a Database

Before creating tables, we must connect to the desired database. Using the PostgreSQL command-line tool: `\\c UniversityDB` After connecting, all subsequent SQL statements execute within that database.

### Renaming a Database

A database name can be changed using the `ALTER DATABASE` statement.

### Syntax

```

ALTER DATABASE old_database_name
RENAME TO new_database_name;

```

### Example

```

ALTER DATABASE UniversityDB
RENAME TO StudentDB;

```

The database is renamed successfully.

### Deleting a Database

The `DROP DATABASE` statement permanently removes a database.

### Syntax

```

DROP DATABASE database_name;

```

### Example

```

DROP DATABASE StudentDB;

```

**Warning:** This operation permanently deletes the database and all of its contents.

## Understanding Schemas

### What is a Schema?

A **Schema** is a logical namespace inside a PostgreSQL database that groups related database objects. A schema can contain:

- Tables

- Views

- Indexes

- Functions

- Sequences

- Stored procedures

- Data types

Schemas help organize large databases by separating objects into meaningful categories.

### Why Do We Use Schemas?

Schemas provide several benefits:

- Organize database objects.

- Prevent naming conflicts.

- Improve security.

- Simplify administration.

- Support multiple applications within the same database.

- Allow different teams to work independently.

### Default Schema

Every PostgreSQL database automatically includes a schema named:

```

public

```

If no schema is specified while creating an object, PostgreSQL places it in the `public` schema by default.

## Creating and Managing Schemas

### Creating a Schema

The `CREATE SCHEMA` statement creates a new schema.

### Syntax

```

CREATE SCHEMA schema_name;

```

### Example

```

CREATE SCHEMA academics;

```

A new schema named **academics** is created inside the current database.

### Viewing Schemas

Using the PostgreSQL command-line interface: `\\dn` This displays all schemas available in the connected database.

### Creating a Table Inside a Schema

Example:

```

CREATE TABLE academics.students (
student_id SERIAL PRIMARY KEY,
name VARCHAR(100),
department VARCHAR(50)
);

```

The `students` table is created inside the **academics** schema.

### Accessing Objects in a Schema

Objects are referenced using the following format: `schema_name.object_name` Example:

```

SELECT *
FROM academics.students;

```

This query retrieves records from the `students` table within the `academics` schema.

### Renaming a Schema

Syntax:

```

ALTER SCHEMA academics
RENAME TO education;

```

The schema name changes while preserving its objects.

### Deleting a Schema

Syntax:

```

DROP SCHEMA schema_name;

```

Example:

```

DROP SCHEMA education;

```

To remove the schema along with all its objects:

```

DROP SCHEMA education CASCADE;

```

Use `CASCADE` carefully because it permanently removes all dependent objects.

## Database vs. Schema

Although databases and schemas both organize data, they serve different purposes.

| Feature | Database | Schema |
|---|---|---|
| Purpose | Stores an entire collection of data | Organizes objects within a database |
| Scope | Highest organizational level | Exists inside a database |
| Contains | Schemas and database objects | Tables, views, functions, indexes, and more |
| Isolation | Separate from other databases | Shares the same database resources |
| Security | Separate users and permissions | Fine-grained object organization and access control |

A helpful way to think about it is:

- **Database = Building**

- **Schema = Rooms inside the building**

## Using Multiple Schemas

Large organizations often divide applications into multiple schemas. Example:

```

UniversityDB
│
├── academics
├── admissions
├── finance
├── library
└── hostel

```

Each department manages its own tables without interfering with others. This approach improves organization and reduces naming conflicts.

## Search Path in PostgreSQL

PostgreSQL uses a **search path** to determine where to look for database objects. To display the current search path:

```

SHOW search_path;

```

Example output:

```

"$user", public

```

To change the search path:

```

SET search_path TO academics;

```

Now tables inside the `academics` schema can be referenced without writing the schema name every time.

## Best Practices for Databases and Schemas

To design well-organized PostgreSQL systems:

- Use meaningful database names.

- Group related objects into separate schemas.

- Avoid placing every table in the `public` schema.

- Follow consistent naming conventions.

- Assign appropriate permissions to each schema.

- Keep development, testing, and production databases separate.

- Document the database structure for future maintenance.

- Use schemas to organize large applications by modules or departments.

## Common Mistakes to Avoid

Beginners often make these mistakes:

- Creating too many databases when schemas would be sufficient.

- Storing all objects in the `public` schema without organization.

- Using unclear or inconsistent naming conventions.

- Forgetting to specify the schema when required.

- Deleting schemas without understanding the impact of `CASCADE`.

- Mixing unrelated application data within the same schema.

- Ignoring user permissions on schemas.

Avoiding these mistakes results in cleaner and more maintainable databases.

## Real-World Applications

Creating databases and schemas is essential across many industries.

### University Management System

Database:

- UniversityDB

Schemas:

- academics

- admissions

- examinations

- library

### Hospital Management System

Database:

- HospitalDB

Schemas:

- patients

- doctors

- pharmacy

- billing

### E-Commerce Platform

Database:

- EcommerceDB

Schemas:

- products

- orders

- customers

- payments

- inventory

### Banking System

Database:

- BankingDB

Schemas:

- accounts

- loans

- transactions

- customers

Using schemas in this way keeps each functional area organized while allowing all modules to share the same database.

## Advantages and Limitations

### Advantages

- Organizes database objects efficiently.

- Prevents naming conflicts.

- Simplifies security management.

- Improves maintainability.

- Supports modular application development.

- Enables multiple teams to work within the same database.

### Limitations

- Poor schema design can create unnecessary complexity.

- Incorrect permission settings may restrict legitimate access.

- Managing many schemas requires careful documentation.

- Developers must understand schema-qualified object names to avoid confusion.

Understanding these considerations helps create scalable and well-structured database systems.

### Conclusion

Creating databases and schemas is one of the first and most important steps in designing a PostgreSQL application. A database serves as the primary container for storing application data, while schemas provide a logical structure for organizing tables, views, functions, and other database objects. By using commands such as `CREATE DATABASE`, `CREATE SCHEMA`, `ALTER`, and `DROP`, we can efficiently manage database environments of any size. Combining well-planned database architecture with meaningful schema organization improves security, reduces naming conflicts, enhances maintainability, and supports the development of scalable, enterprise-quality applications. Mastering databases and schemas provides a strong foundation for working effectively with PostgreSQL in both academic projects and real-world software development.');

-- Lecture 3: PostgreSQL Data Types
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'PostgreSQL Data Types', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# PostgreSQL Data Types

Every piece of information stored in a database has a specific nature. A student\'s age is a number, a person\'s name is text, a salary may contain decimal values, and a birth date follows a calendar format. If we stored every type of information as plain text, the database would struggle to perform calculations, comparisons, sorting, and validations correctly. This is where **Data Types** become essential. Think of data types as different storage containers in a kitchen. Flour goes into one container, sugar into another, and spices into separate jars. Although all are ingredients, each requires an appropriate container to remain organized and useful. Similarly, PostgreSQL assigns each piece of data a suitable data type to ensure efficient storage, accurate processing, and improved performance. In these lecture notes, we will explore PostgreSQL data types, understand their categories, learn when to use each type, examine practical examples, and discover best practices for selecting the most appropriate data type for different applications.

## Introduction to Data Types

### What is a Data Type?

A **Data Type** defines the kind of value that can be stored in a database column. It tells PostgreSQL:

- What type of data can be stored.

- How much storage is required.

- What operations can be performed.

- How the data should be validated.

Choosing the correct data type improves performance, saves storage space, and maintains data integrity.

### Why Are Data Types Important?

Data types help us:

- Store information efficiently.

- Prevent invalid data entry.

- Improve query performance.

- Support calculations and comparisons.

- Enforce consistency across the database.

- Reduce storage requirements.

Without proper data types, databases become difficult to manage and more prone to errors.

### Example

Consider a student table.

| Column | Data Type |
|---|---|
| StudentID | INTEGER |
| Name | VARCHAR(100) |
| Age | INTEGER |
| GPA | NUMERIC(3,2) |
| DateOfBirth | DATE |

Each column stores a different kind of information, so each requires an appropriate data type.

## Categories of PostgreSQL Data Types

PostgreSQL provides many built-in data types that can be grouped into several major categories:

- Numeric Data Types

- Character Data Types

- Boolean Data Types

- Date and Time Data Types

- Binary Data Types

- JSON Data Types

- UUID Data Types

- Array Data Types

- Enumerated (ENUM) Types

- Network Address Types

- Geometric Types

Each category is designed for specific kinds of information.

## Numeric Data Types

Numeric data types store numbers.

### 1. SMALLINT

Stores small whole numbers. Range: `-32,768 to 32,767` Example: `Age SMALLINT` Suitable for:

- Ages

- Ratings

- Small counters

### 2. INTEGER (INT)

Stores standard whole numbers. Range:

```

-2,147,483,648
to
2,147,483,647

```

Example: `StudentID INTEGER` Used for:

- IDs

- Quantities

- Population counts

### 3. BIGINT

Stores very large whole numbers. Example: `TransactionID BIGINT` Commonly used in:

- Banking systems

- Large enterprise applications

- Big data systems

### 4. NUMERIC (DECIMAL)

Stores exact decimal values. Example: `Salary NUMERIC(10,2)` Meaning:

- Maximum 10 digits.

- 2 digits after the decimal point.

Suitable for:

- Financial data

- Prices

- Tax calculations

### 5. REAL

Stores single-precision floating-point numbers. Example: `Temperature REAL` Useful when slight rounding differences are acceptable.

### 6. DOUBLE PRECISION

Stores double-precision floating-point numbers. Example:

```

ScientificValue DOUBLE PRECISION

```

Provides greater precision than `REAL`.

## Character Data Types

Character data types store text.

### 1. CHAR(n)

Stores fixed-length strings. Example: `Gender CHAR(1)` Possible values:

```

M
F

```

If fewer characters are stored, PostgreSQL pads the remaining space.

### 2. VARCHAR(n)

Stores variable-length strings. Example: `Name VARCHAR(100)` Only the required storage is used. Common uses:

- Names

- Email addresses

- Phone numbers

### 3. TEXT

Stores unlimited-length text. Example: `Description TEXT` Suitable for:

- Articles

- Blog posts

- Product descriptions

- User comments

## Boolean Data Type

The `BOOLEAN` type stores logical values. Possible values:

```

TRUE
FALSE
NULL

```

Example: `IsActive BOOLEAN` Applications:

- User status

- Email verification

- Product availability

- Payment confirmation

## Date and Time Data Types

These types store calendar and time-related information.

### DATE

Stores only the date. Example: `DateOfBirth DATE` Example value: `2005-05-05`

### TIME

Stores only the time. Example: `LectureTime TIME` Example: `09:30:00`

### TIMESTAMP

Stores both date and time. Example: `CreatedAt TIMESTAMP` Example value: `2026-08-05 10:15:30` Stores a timestamp with time zone information. Example: `LoginTime TIMESTAMPTZ` Useful for global applications where users are located in different time zones.

### INTERVAL

Stores a duration of time. Example: `Duration INTERVAL` Example value: `3 days`

## Binary Data Type

### BYTEA

Stores binary data. Example: `FileData BYTEA` Applications:

- Images

- Documents

- Audio files

- Digital signatures

## JSON Data Types

PostgreSQL provides excellent support for JSON.

### JSON

Stores JSON exactly as entered. Example: `StudentInfo JSON` Example value:

```

{
"name": "Ali",
"age": 20
}

```

### JSONB

Stores JSON in a binary format optimized for indexing and searching. Advantages:

- Faster queries.

- Better indexing.

- Efficient storage.

Most modern PostgreSQL applications prefer `JSONB`.

## UUID Data Type

A **UUID (Universally Unique Identifier)** uniquely identifies records across systems. Example: `UserID UUID` Example value:

```

550e8400-e29b-41d4-a716-446655440000

```

Common uses:

- Distributed systems

- APIs

- Microservices

## Array Data Type

Unlike many relational databases, PostgreSQL supports arrays. Example: `PhoneNumbers TEXT[]` Example value:

```

{
"123456789",
"987654321"
}

```

Arrays store multiple values in a single column, though they should be used thoughtfully to maintain a well-designed schema.

## Enumerated (ENUM) Types

An **ENUM** restricts a column to predefined values. Create an ENUM type:

```

CREATE TYPE grade AS ENUM (
\'A\',
\'B\',
\'C\',
\'D\',
\'F\'
);

```

Use it: `Grade grade` ENUMs improve data consistency by preventing invalid values.

## Network Address Types

PostgreSQL includes built-in support for network information. Common types:

- `INET`

- `CIDR`

- `MACADDR`

Example: `IPAddress INET` Useful for:

- Network management systems

- Security applications

- Server monitoring

## Geometric Data Types

PostgreSQL supports geometric objects. Examples include:

- POINT

- LINE

- CIRCLE

- BOX

- POLYGON

Example: `Location POINT` Applications:

- GIS systems

- Mapping software

- Engineering applications

## Choosing the Right Data Type

Selecting appropriate data types improves performance and storage efficiency.

| Requirement | Recommended Data Type |
|---|---|
| Student ID | INTEGER |
| Name | VARCHAR(100) |
| Description | TEXT |
| Price | NUMERIC(10,2) |
| Date of Birth | DATE |
| Login Time | TIMESTAMP |
| Active Status | BOOLEAN |
| Profile Image | BYTEA |
| Product Details | JSONB |
| User Identifier | UUID |

Choosing the smallest suitable data type often improves efficiency.

## Best Practices

To use PostgreSQL data types effectively:

- Choose the smallest appropriate numeric type.

- Use `NUMERIC` for financial calculations requiring exact precision.

- Use `VARCHAR` for most text fields with reasonable length limits.

- Use `TEXT` for long-form content.

- Prefer `TIMESTAMPTZ` for applications used across multiple time zones.

- Use `JSONB` instead of `JSON` when efficient querying and indexing are important.

- Use `UUID` when globally unique identifiers are required.

- Avoid storing numbers as text unless absolutely necessary.

- Apply constraints such as `NOT NULL`, `UNIQUE`, and `CHECK` alongside data types to strengthen data integrity.

## Common Mistakes to Avoid

Beginners frequently make these mistakes:

- Using `TEXT` for every column regardless of the data.

- Storing dates as strings.

- Using floating-point types (`REAL` or `DOUBLE PRECISION`) for financial data instead of `NUMERIC`.

- Choosing overly large data types without need.

- Ignoring length limits where appropriate.

- Storing Boolean values as text such as `"Yes"` or `"No"` instead of using `BOOLEAN`.

- Using arrays where normalized relational tables would be more appropriate.

Avoiding these mistakes results in better database performance and maintainability.

## Real-World Applications

PostgreSQL data types are used across many industries.

### Banking Systems

- Account numbers → `BIGINT`

- Account balances → `NUMERIC`

- Transaction dates → `TIMESTAMP`

- Customer IDs → `UUID`

### Hospital Management

- Patient names → `VARCHAR`

- Medical history → `TEXT`

- Appointment dates → `TIMESTAMP`

- Medical images → `BYTEA`

### E-Commerce

- Product names → `VARCHAR`

- Prices → `NUMERIC`

- Product descriptions → `TEXT`

- Product specifications → `JSONB`

### University Management

- Student IDs → `INTEGER`

- Student names → `VARCHAR`

- Grades → `ENUM`

- Enrollment dates → `DATE`

These examples illustrate how selecting appropriate data types contributes to efficient, secure, and scalable database systems.

### Conclusion

PostgreSQL offers a rich collection of data types that allow developers to store information accurately, efficiently, and securely. From numeric and character types to advanced options such as `JSONB`, `UUID`, arrays, and network address types, PostgreSQL provides specialized solutions for a wide variety of application requirements. Choosing the correct data type is essential for maintaining data integrity, improving query performance, reducing storage consumption, and simplifying application development. By understanding the strengths of each data type and following best practices, we can design robust databases that are scalable, maintainable, and well-suited for modern software applications across industries.');

-- Lecture 4: CRUD Operations in PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'CRUD Operations in PostgreSQL', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# CRUD Operations in PostgreSQL

Every database-driven application revolves around one essential concept: managing data. Whether we are registering a new student, displaying customer information, updating an employee\'s salary, or removing outdated records, we are constantly performing four fundamental operations. These operations are collectively known as **CRUD**, which stands for **Create, Read, Update, and Delete**. Imagine a notebook where you maintain your daily tasks. Whenever you write a new task, you are creating data. When you check your list, you are reading data. If you change the deadline of a task, you are updating data. Finally, when a task is completed and removed from the notebook, you are deleting data. PostgreSQL performs these same actions on database records using SQL statements. In these lecture notes, we will explore CRUD operations in PostgreSQL, understand the SQL commands involved, examine practical examples, and learn best practices for safely managing data in real-world applications.

## Introduction to CRUD Operations

### What is CRUD?

**CRUD** is an acronym representing the four basic operations performed on data in a database.

| Letter | Meaning | SQL Command |
|---|---|---|
| C | Create | INSERT |
| R | Read | SELECT |
| U | Update | UPDATE |
| D | Delete | DELETE |

These operations form the foundation of almost every database application.

### Why Are CRUD Operations Important?

CRUD operations allow us to:

- Store new information.

- Retrieve existing records.

- Modify outdated data.

- Remove unnecessary information.

- Maintain accurate and organized databases.

Without CRUD operations, a database would simply be a storage container with no practical way to interact with its data.

### Sample Table

Throughout these lecture notes, we will use the following table:

```

CREATE TABLE Students (
StudentID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Age INTEGER,
Department VARCHAR(50)
);

```

This table stores information about students.

## Create Operation (INSERT)

### What is the Create Operation?

The **Create** operation adds new records to a table. PostgreSQL uses the `INSERT INTO` statement for this purpose.

### Basic Syntax

```

INSERT INTO table_name(column1, column2, ...)
VALUES(value1, value2, ...);

```

### Example: Insert One Record

```

INSERT INTO Students
(Name, Age, Department)
VALUES
(\'Ali\', 20, \'Artificial Intelligence\');

```

A new student record is inserted into the table.

### Inserting Multiple Records

PostgreSQL allows multiple rows to be inserted with a single statement.

```

INSERT INTO Students
(Name, Age, Department)
VALUES
(\'Sara\', 21, \'Computer Science\'),
(\'Ahmed\', 22, \'Software Engineering\'),
(\'Fatima\', 20, \'Information Technology\');

```

This approach is more efficient than inserting each record individually.

### Using DEFAULT Values

If a column has a default value, PostgreSQL automatically assigns it when no value is provided. Example:

```

INSERT INTO Students
(Name)
VALUES
(\'Hassan\');

```

Columns with default values or nullable columns are handled automatically.

## Read Operation (SELECT)

### What is the Read Operation?

The **Read** operation retrieves data from one or more tables. PostgreSQL uses the `SELECT` statement.

### Selecting All Records

```

SELECT *
FROM Students;

```

This returns every column and every record.

### Selecting Specific Columns

```

SELECT
Name,
Department
FROM Students;

```

Only the selected columns are displayed.

### Filtering Records with WHERE

Retrieve students from the Artificial Intelligence department:

```

SELECT *
FROM Students
WHERE Department = \'Artificial Intelligence\';

```

### Sorting Results

Sort students alphabetically:

```

SELECT *
FROM Students
ORDER BY Name ASC;

```

Sort by age in descending order:

```

SELECT *
FROM Students
ORDER BY Age DESC;

```

Sorting improves data readability.

### Limiting the Number of Records

Display only the first five students:

```

SELECT *
FROM Students
LIMIT 5;

```

This is useful when working with large datasets.

## Update Operation (UPDATE)

### What is the Update Operation?

The **Update** operation modifies existing records. The `UPDATE` statement changes one or more column values.

### Basic Syntax

```

UPDATE table_name
SET column = value
WHERE condition;

```

### Example: Update One Record

```

UPDATE Students
SET Age = 21
WHERE StudentID = 1;

```

Only the student with ID 1 is updated.

### Updating Multiple Columns

```

UPDATE Students
SET
Department = \'Computer Science\',
Age = 22
WHERE StudentID = 2;

```

Multiple values can be changed with one statement.

### Updating Multiple Records

```

UPDATE Students
SET Department = \'Engineering\'
WHERE Department = \'Software Engineering\';

```

Every matching record is updated.

## Delete Operation (DELETE)

### What is the Delete Operation?

The **Delete** operation removes records from a table. PostgreSQL uses the `DELETE` statement.

### Basic Syntax

```

DELETE FROM table_name
WHERE condition;

```

### Deleting One Record

```

DELETE FROM Students
WHERE StudentID = 3;

```

Only the selected record is deleted.

### Deleting Multiple Records

```

DELETE FROM Students
WHERE Department = \'Engineering\';

```

All students in the Engineering department are removed.

### Deleting All Records

```

DELETE FROM Students;

```

This removes every row while keeping the table structure intact.

### Using TRUNCATE

To remove all rows quickly:

```

TRUNCATE TABLE Students;

```

`TRUNCATE` is generally faster than `DELETE` because it removes all rows without processing each row individually.

## Using the RETURNING Clause

PostgreSQL provides a powerful feature called `RETURNING`. It returns affected rows immediately after an `INSERT`, `UPDATE`, or `DELETE`.

### INSERT with RETURNING

```

INSERT INTO Students
(Name, Age, Department)
VALUES
(\'Bilal\', 20, \'AI\')
RETURNING *;

```

The newly inserted record is displayed instantly.

### UPDATE with RETURNING

```

UPDATE Students
SET Age = 23
WHERE StudentID = 2
RETURNING *;

```

The updated record is returned after modification.

### DELETE with RETURNING

```

DELETE FROM Students
WHERE StudentID = 4
RETURNING *;

```

The deleted record is displayed before it is permanently removed.

## CRUD Workflow

The complete CRUD cycle can be represented as follows:

```

Create (INSERT)
│
▼
Store Data
│
▼
Read (SELECT)
│
▼
Display Data
│
▼
Update (UPDATE)
│
▼
Modify Data
│
▼
Delete (DELETE)

```

This workflow forms the core of almost every database-driven application.

## CRUD in Real Applications

Almost every modern application performs CRUD operations.

### University Management System

- Register students → `INSERT`

- View student details → `SELECT`

- Update student information → `UPDATE`

- Remove graduated students → `DELETE`

### Hospital Management System

- Add patient records

- Retrieve medical history

- Update treatment information

- Delete duplicate records

### E-Commerce Website

- Add products

- Display product catalog

- Update product prices

- Remove discontinued products

### Banking System

- Create customer accounts

- Retrieve account balances

- Update customer information

- Remove inactive records when appropriate

These examples show how CRUD operations support everyday business processes.

## Best Practices for CRUD Operations

To maintain a reliable PostgreSQL database:

- Always use the `WHERE` clause when updating or deleting specific records.

- Validate user input before executing SQL statements.

- Use prepared statements in applications to prevent SQL injection.

- Test `SELECT` queries before running `UPDATE` or `DELETE` statements.

- Back up important data before performing bulk modifications.

- Use transactions when multiple related operations must succeed together.

- Grant users only the permissions necessary for their roles.

- Review affected rows before committing large updates or deletions.

## Common Mistakes to Avoid

Beginners often encounter the following problems:

- Forgetting the `WHERE` clause in `UPDATE` or `DELETE`, causing every record to be modified or removed.

- Inserting incorrect data types into columns.

- Ignoring database constraints such as `NOT NULL` or `UNIQUE`.

- Using `SELECT *` when only a few columns are needed.

- Failing to test SQL statements before running them on production databases.

- Deleting data without maintaining recent backups.

- Overlooking transaction management during complex operations.

Avoiding these mistakes helps maintain data accuracy and system reliability.

## Advantages and Limitations

### Advantages

- Simplifies database management.

- Supports efficient data manipulation.

- Enables dynamic applications.

- Maintains organized and up-to-date records.

- Integrates easily with programming languages and frameworks.

- Forms the foundation of nearly all database-driven systems.

### Limitations

- Incorrect queries can lead to data loss.

- Large update or delete operations may impact performance.

- Poor input validation can compromise data quality.

- Without transactions, partial updates may leave the database in an inconsistent state.

Understanding these limitations helps developers design safer and more dependable applications.

### Conclusion

CRUD operations are the foundation of every PostgreSQL application. Using the `INSERT`, `SELECT`, `UPDATE`, and `DELETE` statements, we can create new records, retrieve valuable information, modify existing data, and remove unnecessary entries with confidence. PostgreSQL enhances these operations with powerful features such as the `RETURNING` clause, efficient bulk inserts, and fast table truncation. By following best practices—including validating input, using transactions, writing precise `WHERE` clauses, and maintaining regular backups—we can build secure, reliable, and high-performance database applications. Mastering CRUD operations is an essential step toward becoming a skilled PostgreSQL developer and designing robust real-world software solutions.');

-- Lecture 5: Constraints & Indexes in PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Constraints & Indexes in PostgreSQL', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Constraints & Indexes in PostgreSQL

A database is only as reliable as the quality of the data it stores. Imagine a university where students could have duplicate ID numbers, negative ages, or enroll in courses that do not exist. Such inconsistencies would quickly create confusion and make the system unreliable. To prevent these problems, PostgreSQL provides **Constraints**, which enforce rules on the data, and **Indexes**, which improve the speed of data retrieval. Think of a library. The library has rules such as "every book must have a unique ISBN" and "every borrowed book must belong to the library." These rules are like **constraints** because they ensure accuracy and consistency. At the same time, the library maintains a catalog that helps librarians locate books quickly. This catalog acts like an **index**, allowing information to be found efficiently without searching every shelf. In these lecture notes, we will explore PostgreSQL constraints and indexes, understand their types, examine practical SQL examples, and learn how they improve both data integrity and database performance.

## Introduction to Constraints

### What are Constraints?

A **Constraint** is a rule applied to one or more table columns that restricts the type of data that can be stored. Constraints help ensure that only valid and consistent data enters the database. They provide:

- Data integrity

- Data accuracy

- Data consistency

- Relationship enforcement

- Error prevention

Without constraints, databases become vulnerable to invalid and duplicate data.

### Why Are Constraints Important?

Constraints help us:

- Prevent duplicate records.

- Ensure mandatory information is provided.

- Maintain relationships between tables.

- Restrict invalid values.

- Improve database reliability.

- Support business rules automatically.

### Example Table

```

CREATE TABLE Students (
StudentID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Age INTEGER,
Email VARCHAR(100)
);

```

Different constraints can be applied to each column depending on the requirements.

## Types of Constraints

PostgreSQL supports several commonly used constraints:

- NOT NULL

- UNIQUE

- PRIMARY KEY

- FOREIGN KEY

- CHECK

- DEFAULT

- EXCLUSION (advanced)

Each serves a different purpose.

## NOT NULL Constraint

### What is NOT NULL?

The `NOT NULL` constraint ensures that a column cannot contain `NULL` values.

### Syntax

`Name VARCHAR(100) NOT NULL`

### Example

```

CREATE TABLE Students (
StudentID SERIAL PRIMARY KEY,
Name VARCHAR(100) NOT NULL
);

```

Now every student must have a name.

### Benefits

- Prevents missing required information.

- Improves data quality.

- Ensures essential fields are always completed.

## UNIQUE Constraint

### What is UNIQUE?

The `UNIQUE` constraint prevents duplicate values in a column.

### Example

`Email VARCHAR(100) UNIQUE` Now every email address must be different.

### Sample Data

| Email | Allowed? |
|---|---|
| ali@email.com | ✔ |
| sara@email.com | ✔ |
| ali@email.com | ✘ Duplicate |

This is commonly used for usernames, email addresses, and employee numbers.

## PRIMARY KEY Constraint

### What is a Primary Key?

A **Primary Key** uniquely identifies every row in a table. Characteristics:

- Unique

- Cannot contain NULL

- Only one primary key per table

- May consist of one or multiple columns

### Example

`StudentID SERIAL PRIMARY KEY` Each student receives a unique identifier automatically.

### Composite Primary Key

A primary key can consist of multiple columns. Example:

```

PRIMARY KEY
(StudentID, CourseID)

```

Useful for junction tables such as enrollments.

## FOREIGN KEY Constraint

### What is a Foreign Key?

A **Foreign Key** creates a relationship between two tables. It ensures that referenced data already exists.

### Example

```

CREATE TABLE Enrollments (
EnrollmentID SERIAL PRIMARY KEY,
StudentID INTEGER,
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)
);

```

A student must exist before an enrollment record can reference them.

### Benefits

- Prevents orphan records.

- Maintains referential integrity.

- Enforces relationships automatically.

## CHECK Constraint

### What is a CHECK Constraint?

The `CHECK` constraint ensures that data satisfies a specified condition.

### Example

```

Age INTEGER
CHECK (Age >= 18)

```

Now PostgreSQL rejects ages below 18.

### Another Example

```

Salary NUMERIC
CHECK (Salary > 0)

```

Negative salaries cannot be stored.

## DEFAULT Constraint

### What is DEFAULT?

The `DEFAULT` constraint assigns a value automatically when none is provided.

### Example

```

Status VARCHAR(20)
DEFAULT \'Active\'

```

If no status is specified during insertion, PostgreSQL stores `"Active"` automatically.

### Using Current Date

```

CreatedDate DATE
DEFAULT CURRENT_DATE

```

The current date is inserted automatically for new records.

## Exclusion Constraint (Advanced)

PostgreSQL offers **Exclusion Constraints**, which prevent overlapping values according to specified rules.

### Example Use Cases

- Prevent overlapping hotel bookings.

- Prevent overlapping meeting room reservations.

- Prevent scheduling conflicts.

Although more advanced than other constraints, exclusion constraints are extremely useful in specialized applications.

## Introduction to Indexes

### What is an Index?

An **Index** is a special database object that improves the speed of data retrieval. Instead of scanning every row in a table, PostgreSQL uses the index to locate matching data quickly. Imagine looking for a topic in a textbook. Rather than reading every page, you check the index at the back of the book. PostgreSQL indexes work in much the same way.

### Why Are Indexes Important?

Indexes help:

- Speed up `SELECT` queries.

- Improve sorting performance.

- Accelerate joins.

- Optimize filtering with `WHERE`.

- Enhance overall database performance.

## Creating Indexes

### Basic Syntax

```

CREATE INDEX
index_name
ON table_name(column_name);

```

### Example

```

CREATE INDEX
idx_student_name
ON Students(Name);

```

Searching students by name becomes significantly faster.

## Types of Indexes

### 1. Single-Column Index

Indexes one column.

```

CREATE INDEX
idx_email
ON Students(Email);

```

### 2. Composite Index

Indexes multiple columns.

```

CREATE INDEX
idx_name_department
ON Students(Name, Department);

```

Useful when queries frequently search using both columns together.

### 3. Unique Index

Automatically prevents duplicate values.

```

CREATE UNIQUE INDEX
idx_unique_email
ON Students(Email);

```

### 4. Partial Index

Indexes only rows that satisfy a condition.

```

CREATE INDEX
idx_active_students
ON Students(Name)
WHERE Status = \'Active\';

```

This reduces index size and improves performance for targeted queries.

## Viewing and Removing Indexes

### View Indexes

Using the PostgreSQL command-line interface: `\\d Students` This displays the table structure along with associated indexes.

### Drop an Index

```

DROP INDEX idx_student_name;

```

The specified index is permanently removed.

## How Indexes Improve Performance

Without an index:

```

Search Every Row
──────────────►

```

With an index:

```

Use Index
│
▼
Locate Matching Rows

```

Indexes reduce the amount of data PostgreSQL must scan, resulting in much faster query execution for many read operations.

## Constraints vs. Indexes

| Feature | Constraints | Indexes |
|---|---|---|
| Purpose | Ensure data validity | Improve query performance |
| Prevent invalid data | Yes | No |
| Improve search speed | No | Yes |
| Enforce uniqueness | Yes ( UNIQUE, PRIMARY KEY) | Yes (Unique Index) |
| Maintain relationships | Yes ( FOREIGN KEY) | No |

Although they often work together, constraints and indexes solve different problems. To build reliable and high-performing PostgreSQL databases:

- Use primary keys for every table.

- Apply foreign keys to maintain relationships.

- Use `NOT NULL` for mandatory fields.

- Validate business rules with `CHECK` constraints.

- Create indexes on frequently searched columns.

- Avoid creating unnecessary indexes because they increase storage usage and slow insert, update, and delete operations.

- Review query execution plans to identify where indexes provide the greatest benefit.

- Use meaningful names for constraints and indexes to simplify maintenance.

## Common Mistakes to Avoid

Beginners often make these mistakes:

- Forgetting to define primary keys.

- Creating duplicate indexes on the same columns.

- Overusing indexes on small tables where they offer little benefit.

- Ignoring foreign key relationships.

- Using `NULL` values in required fields instead of `NOT NULL`.

- Creating indexes on columns that are rarely searched.

- Assuming indexes improve every operation; while they speed up many queries, they can slow down write operations because indexes

must also be updated. Avoiding these mistakes results in better database performance and stronger data integrity.

## Real-World Applications

### University Management System

- Student ID → `PRIMARY KEY`

- Email → `UNIQUE`

- Department ID → `FOREIGN KEY`

- Student Name → Indexed for faster searching

### Hospital Management System

- Patient ID → `PRIMARY KEY`

- Blood Group → `CHECK`

- Doctor ID → `FOREIGN KEY`

- Appointment Date → Indexed for quick scheduling queries

### E-Commerce Platform

- Product ID → `PRIMARY KEY`

- SKU → `UNIQUE`

- Price → `CHECK`

- Product Name → Indexed for product searches

### Banking System

- Account Number → `UNIQUE`

- Customer ID → `FOREIGN KEY`

- Balance → `CHECK`

- Transaction Date → Indexed for reporting and account history

These examples show how constraints protect data while indexes improve application responsiveness.

### Conclusion

Constraints and indexes are two of the most important features of PostgreSQL. Constraints such as `NOT NULL`, `UNIQUE`, `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, and `DEFAULT` ensure that the database stores only accurate, valid, and consistent information. Indexes, on the other hand, significantly improve query performance by allowing PostgreSQL to locate data efficiently without scanning entire tables. By combining well-designed constraints with carefully planned indexes, we can build databases that are both reliable and high-performing. Mastering these concepts enables developers and database administrators to create scalable, secure, and efficient PostgreSQL applications capable of supporting real-world business requirements.');

-- Lecture 6: Joins & Subqueries in PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Joins & Subqueries in PostgreSQL', 6, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Joins & Subqueries in PostgreSQL

Databases often store information in multiple related tables instead of placing everything into one large table. For example, a university database may have separate tables for **Students**, **Courses**, **Teachers**, and **Enrollments**. While this design reduces redundancy and improves organization, it also creates the need to combine or compare information across different tables. This is where **Joins** and **Subqueries** become essential. Imagine a detective solving a mystery. The detective gathers clues from different sources—witnesses, security cameras, and documents—to build a complete picture. Similarly, **Joins** combine data from multiple tables, while **Subqueries** retrieve information by using the result of one query inside another. Together, they enable us to answer complex questions and generate meaningful insights from relational databases. In these lecture notes, we will explore Joins and Subqueries in PostgreSQL, understand their types, examine practical SQL examples, compare their use cases, and learn best practices for writing efficient queries.

## Introduction to Joins

### What is a Join?

A **Join** is an SQL operation that combines rows from two or more tables based on a related column. Joins allow us to:

- Retrieve related data from multiple tables.

- Reduce data duplication.

- Build meaningful reports.

- Maintain normalized database structures.

- Answer complex business questions.

Without joins, developers would need to execute multiple queries and combine the results manually.

### Why Are Joins Important?

Consider the following tables.

### Students

| StudentID | Name |
|---|---|
| 1 | Ali |
| 2 | Sara |
| 3 | Ahmed |

### Enrollments

| StudentID | Course |
|---|---|
| 1 | Database Systems |
| 2 | Artificial Intelligence |

To display each student\'s name along with their enrolled course, we must combine both tables using a join.

### Basic Join Syntax

```

SELECT columns
FROM table1
JOIN table2
ON table1.column = table2.column;

```

The `ON` clause specifies how the two tables are related.

## Types of Joins

PostgreSQL supports several types of joins.

- INNER JOIN

- LEFT JOIN

- RIGHT JOIN

- CROSS JOIN

- SELF JOIN

Each serves a different purpose.

## INNER JOIN

### What is an INNER JOIN?

An **INNER JOIN** returns only the rows that have matching values in both tables.

### Example Tables

**Students**

| StudentID | Name |
|---|---|
| 1 | Ali |
| 2 | Sara |
| 3 | Ahmed |

**Enrollments**

| StudentID | Course |
|---|---|
| 1 | Database Systems |
| 2 | Artificial Intelligence |

### Example

```

SELECT
Students.Name,
Enrollments.Course
FROM Students
INNER JOIN Enrollments
ON Students.StudentID = Enrollments.StudentID;

```

### Result

| Name | Course |
|---|---|
| Ali | Database Systems |
| Sara | Artificial Intelligence |

Ahmed is not included because there is no matching enrollment record.

## LEFT JOIN

### What is a LEFT JOIN?

A **LEFT JOIN** returns all records from the left table and matching records from the right table. If no match exists, PostgreSQL returns `NULL` for the missing values.

### Example

```

SELECT
Students.Name,
Enrollments.Course
FROM Students
LEFT JOIN Enrollments
ON Students.StudentID = Enrollments.StudentID;

```

### Result

| Name | Course |
|---|---|
| Ali | Database Systems |
| Sara | Artificial Intelligence |
| Ahmed | NULL |

This is useful when we want every student listed, even if they are not enrolled in a course.

## RIGHT JOIN

### What is a RIGHT JOIN?

A **RIGHT JOIN** returns all records from the right table and matching records from the left table.

### Example

```

SELECT
Students.Name,
Enrollments.Course
FROM Students
RIGHT JOIN Enrollments
ON Students.StudentID = Enrollments.StudentID;

```

Every enrollment is displayed, even if a matching student record does not exist.

## FULL OUTER JOIN

### What is a FULL OUTER JOIN?

A **FULL OUTER JOIN** returns:

- All matching rows.

- All rows from the left table.

- All rows from the right table.

Unmatched values are filled with `NULL`.

### Example

```

SELECT
Students.Name,
Enrollments.Course
FROM Students
FULL OUTER JOIN Enrollments
ON Students.StudentID = Enrollments.StudentID;

```

This join is useful for identifying missing relationships between tables.

## CROSS JOIN

### What is a CROSS JOIN?

A **CROSS JOIN** returns every possible combination of rows from both tables.

### Example

```

SELECT
Students.Name,
Courses.CourseName
FROM Students
CROSS JOIN Courses;

```

If there are:

- 3 students

- 4 courses

The result contains: `3 × 4 = 12 rows` CROSS JOINs are commonly used for generating combinations or testing scenarios.

## SELF JOIN

### What is a SELF JOIN?

A **SELF JOIN** joins a table with itself. Example: An Employees table stores both employees and managers.

```

SELECT
E.EmployeeName,
M.EmployeeName AS Manager
FROM Employees E
JOIN Employees M
ON E.ManagerID = M.EmployeeID;

```

This query displays each employee along with their manager.

## Understanding Subqueries

### What is a Subquery?

A **Subquery** is a query placed inside another SQL query. It is enclosed in parentheses and its result is used by the outer query. Subqueries can appear in:

- `SELECT`

- `FROM`

- `WHERE`

- `HAVING`

- `INSERT`

- `UPDATE`

- `DELETE`

### Basic Syntax

```

SELECT columns
FROM table
WHERE column =
(
SELECT value
FROM another_table
);

```

The inner query executes first, and its result is passed to the outer query.

## Types of Subqueries

### Single-Row Subquery

Returns one value.

### Example

Find the student with the highest GPA.

```

SELECT *
FROM Students
WHERE GPA =
(
SELECT MAX(GPA)
FROM Students
);

```

The inner query returns the highest GPA, and the outer query retrieves the corresponding student.

### Multiple-Row Subquery

Returns multiple values.

### Example

```

SELECT *
FROM Students
WHERE DepartmentID IN
(
SELECT DepartmentID
FROM Departments
WHERE Building = \'Engineering\'
);

```

The `IN` operator compares multiple values returned by the subquery.

### Correlated Subquery

A correlated subquery depends on the outer query and executes once for each row processed.

### Example

```

SELECT
S.Name
FROM Students S
WHERE EXISTS
(
SELECT 1
FROM Enrollments E
WHERE E.StudentID = S.StudentID
);

```

This query returns students who have at least one enrollment record.

## Joins vs Subqueries

Although joins and subqueries can often solve similar problems, they have different strengths.

| Feature | Joins | Subqueries |
|---|---|---|
| Purpose | Combine tables | Use one query inside another |
| Performance | Often faster for combining related tables | May be slower in some cases, especially correlated subqueries |
| Readability | Clear for relationships | Useful for complex filtering or calculations |
| Flexibility | Excellent for retrieving related data | Excellent for nested logic and conditional queries |

Choosing between them depends on the problem being solved and the desired query structure.

## Practical Examples

### University Management System

Retrieve student names with course titles:

```

SELECT
S.Name,
C.CourseName
FROM Students S
INNER JOIN Enrollments E
ON S.StudentID = E.StudentID
INNER JOIN Courses C
ON E.CourseID = C.CourseID;

```

### Hospital Management System

Find doctors who have appointments:

```

SELECT DoctorName
FROM Doctors
WHERE DoctorID IN
(
SELECT DoctorID
FROM Appointments
);

```

### E-Commerce System

Display customer names and order details:

```

SELECT
Customers.CustomerName,
Orders.OrderDate
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

```

These examples demonstrate how joins and subqueries simplify real-world data retrieval.

## Best Practices

To write efficient join and subquery queries:

- Define primary and foreign keys correctly.

- Join tables only when necessary.

- Use meaningful table aliases to improve readability.

- Create indexes on frequently joined columns.

- Prefer `INNER JOIN` when unmatched rows are not needed.

- Use `EXISTS` instead of `IN` for certain large datasets when checking for the existence of related rows.

- Avoid unnecessary nested subqueries.

- Analyze query execution plans when optimizing complex queries.

## Common Mistakes to Avoid

Beginners often make these mistakes:

- Forgetting the `ON` clause in joins, leading to unintended results.

- Joining unrelated tables without proper conditions.

- Returning unnecessary columns with `SELECT *`.

- Using correlated subqueries when a join would be simpler and more efficient.

- Ignoring `NULL` values in outer joins.

- Writing ambiguous column names without table aliases.

- Overusing nested subqueries, making queries difficult to read and maintain.

Avoiding these mistakes leads to cleaner, faster, and more reliable SQL queries.

## Advantages and Limitations

### Advantages

- Retrieve related information from multiple tables.

- Support complex reporting and analytics.

- Reduce data duplication through normalized database design.

- Improve flexibility when querying relational data.

- Enable sophisticated filtering and conditional logic.

### Limitations

- Complex joins can become difficult to understand and maintain.

- Poorly optimized joins may reduce query performance.

- Correlated subqueries can be slower on large datasets.

- Incorrect join conditions may produce duplicate or incomplete results.

Understanding these trade-offs helps developers choose the most appropriate querying technique.

### Conclusion

Joins and Subqueries are among the most powerful features of PostgreSQL, enabling developers to retrieve meaningful information from related tables and solve complex data retrieval challenges. Joins efficiently combine data from multiple tables, while subqueries allow one query to build upon the results of another. By understanding the different join types, using subqueries appropriately, and following best practices such as indexing, proper table relationships, and clear query structure, we can write efficient, readable, and scalable SQL statements. Mastering joins and subqueries is an essential milestone in becoming proficient with PostgreSQL and building robust, real-world database applications.');

-- Lecture 7: Views & Materialized Views in PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Views & Materialized Views in PostgreSQL', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Views & Materialized Views in PostgreSQL

## Introduction to Views and Materialized Views

When working with databases, we often deal with large amounts of data stored across multiple tables. Writing the same complex SQL query repeatedly is inefficient and increases the chances of making mistakes. PostgreSQL solves this problem by providing **Views** and **Materialized Views**. Think of a **View** as a window into the database. It does not store data itself but displays data retrieved from one or more tables whenever it is queried. A **Materialized View**, on the other hand, is more like taking a photograph of the data. Instead of running the query every time, PostgreSQL stores the query result physically. This makes data retrieval much faster but requires refreshing to stay up to date. Both features simplify database management, improve security, and enhance performance when used correctly.

## Understanding Views

### What is a View?

A **View** is a virtual table created from the result of an SQL query. It behaves like a regular table, but it does **not** store any data permanently. Whenever we query a view, PostgreSQL executes the underlying SQL statement and returns the latest data from the original tables.

### Syntax

```

CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;

```

### Example

Suppose we have an **employees** table.

```

CREATE TABLE employees (
emp_id SERIAL PRIMARY KEY,
name VARCHAR(50),
department VARCHAR(30),
salary NUMERIC(10,2)
);

```

Insert data:

```

INSERT INTO employees(name, department, salary)
VALUES
(\'Anum\',\'HR\',45000),
(\'Saba\',\'IT\',60000),
(\'Hamza\',\'Finance\',55000);

```

Create a view:

```

CREATE VIEW employee_details AS
SELECT name, department
FROM employees;

```

Query the view:

```

SELECT * FROM employee_details;

```

**Output**

| Name | Department |
|---|---|
| Anum | HR |
| Saba | IT |
| Hamza | Finance |

Notice that the salary column is hidden. This is one reason why views are useful.

### Characteristics of Views

- Views do not store data.

- They always display the latest information.

- They simplify complex SQL queries.

- They can improve security by hiding sensitive columns.

- They can join multiple tables into one virtual table.

### Updating a View

Some views allow updates if they meet certain conditions. Example:

```

UPDATE employee_details
SET department = \'Marketing\'
WHERE name = \'Anum\';

```

This updates the original **employees** table because the view is based on a single table. However, views containing joins, GROUP BY, DISTINCT, or aggregate functions are generally **not updatable**.

### Replacing a View

If we need to modify an existing view:

```

CREATE OR REPLACE VIEW employee_details AS
SELECT name, department, salary
FROM employees;

```

The old definition is replaced without deleting the view.

### Deleting a View

```

DROP VIEW employee_details;

```

Or

```

DROP VIEW IF EXISTS employee_details;

```

## Advantages and Limitations of Views

### Advantages

### 1. Simplicity

Complex SQL queries can be hidden behind a simple view. Instead of writing:

```

SELECT e.name, d.department_name
FROM employees e
JOIN departments d
ON e.department = d.department_id;

```

We can simply write:

### 2. Security

Views hide confidential information. Example:

```

CREATE VIEW public_employee_info AS
SELECT name, department
FROM employees;

```

Users cannot directly see salaries.

### 3. Reusability

The same SQL query can be reused many times without rewriting it.

### 4. Data Consistency

If multiple users need the same data format, everyone queries the same view.

### Limitations

- Views do not improve query speed.

- Complex views may actually slow performance.

- Some views cannot be updated.

- Every query executes the original SQL again.

## Understanding Materialized Views

### What is a Materialized View?

A **Materialized View** stores the result of a query physically inside the database. Unlike a normal view, PostgreSQL does not execute the query every time. Imagine calculating a student\'s GPA every second. Instead of recalculating every time someone asks, we calculate it once and store the result. That stored result is similar to a materialized view.

### Syntax

```

CREATE MATERIALIZED VIEW view_name AS
SELECT ...
WITH DATA;

```

### Example

```

CREATE MATERIALIZED VIEW high_salary_employees AS
SELECT name, salary
FROM employees
WHERE salary > 50000;

```

Retrieve data:

```

SELECT * FROM high_salary_employees;

```

Output:

| Name | Salary |
|---|---|
| Saba | 60000 |
| Hamza | 55000 |

### Stored Data

Suppose we insert another employee:

```

INSERT INTO employees(name, department, salary)
VALUES(\'Ali\',\'IT\',70000);

```

Now check:

```

SELECT * FROM high_salary_employees;

```

Ali will **not** appear because the materialized view stores old data.

### Refreshing Materialized Views

To update stored data:

```

REFRESH MATERIALIZED VIEW high_salary_employees;

```

Now:

```

SELECT * FROM high_salary_employees;

```

Output:

| Name | Salary |
|---|---|
| Saba | 60000 |
| Hamza | 55000 |
| Ali | 70000 |

### Creating Without Data

```

CREATE MATERIALIZED VIEW high_salary_employees AS
SELECT *
FROM employees
WITH NO DATA;

```

The structure is created, but no data is stored. Load data later:

```

REFRESH MATERIALIZED VIEW high_salary_employees;

```

### Deleting a Materialized View

```

DROP MATERIALIZED VIEW high_salary_employees;

```

## Views vs Materialized Views

| Feature | View | Materialized View |
|---|---|---|
| Stores Data | No | Yes |
| Query Speed | Slower for complex queries | Faster |
| Always Up-to-Date | Yes | No |
| Needs Refresh | No | Yes |
| Storage Space | Very little | Uses disk space |
| Best For | Frequently changing data | Reporting and analytics |

### When Should We Use a View?

Use a **View** when:

- Data changes frequently.

- We always need the latest information.

- Security is important.

- We want to simplify SQL queries.

Example: Employee records that change daily.

### When Should We Use a Materialized View?

Use a **Materialized View** when:

- Queries are complex.

- Data changes infrequently.

- Fast reporting is required.

- Large datasets are involved.

Example: Monthly sales reports, yearly financial summaries, business dashboards, or analytical reports.

### Refreshing Materialized Views Concurrently

Normally, refreshing a materialized view locks it while updating. PostgreSQL also supports:

```

REFRESH MATERIALIZED VIEW CONCURRENTLY high_salary_employees;

```

Advantages:

- Users can continue reading the materialized view during refresh.

- Reduces downtime for applications.

Requirements:

- The materialized view must have at least one **UNIQUE index**.

Example:

```

CREATE UNIQUE INDEX idx_high_salary
ON high_salary_employees(name);

```

Then:

```

REFRESH MATERIALIZED VIEW CONCURRENTLY high_salary_employees;

```

### Real-World Examples

### Views

- Banking applications hide customer balances from certain employees.

- School systems display only student names and grades.

- Hospital systems show doctors only patient information they are authorized to access.

### Materialized Views

- Sales dashboards showing monthly revenue.

- Data warehouses storing summarized reports.

- Business intelligence systems generating daily analytics.

- E-commerce websites displaying best-selling products.

- Financial reporting systems with aggregated transaction data.

### Best Practices

- Use **Views** for frequently changing operational data.

- Use **Materialized Views** for read-heavy analytical workloads.

- Refresh materialized views regularly if fresh data is required.

- Create indexes on materialized views to improve query performance.

- Avoid unnecessary nested views, as they can make queries difficult to understand and maintain.

- Clearly document the purpose of each view so other developers know when and how to use it.

### Conclusion

Views and Materialized Views are powerful PostgreSQL features that help us organize, secure, and optimize data access. A **View** is a virtual table that always reflects the latest data because it runs its underlying query whenever it is accessed. It is ideal for simplifying complex queries and restricting access to sensitive information. A **Materialized View** stores the query results physically, offering much faster read performance for large or complex datasets, but it must be refreshed to reflect changes in the underlying tables. By understanding the strengths and trade-offs of each, we can choose the right solution for operational systems, reporting, and analytics, ultimately building PostgreSQL databases that are efficient, maintainable, and scalable.');

-- Lecture 8: Functions & Stored Procedures in PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Functions & Stored Procedures in PostgreSQL', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Functions & Stored Procedures in PostgreSQL

## Introduction to Functions and Stored Procedures

As databases grow larger, writing the same SQL statements repeatedly becomes inefficient and difficult to maintain. PostgreSQL provides **Functions** and **Stored Procedures** to solve this problem. Think of them like appliances in a kitchen. Instead of cooking the same meal from scratch every day, we prepare a recipe once and reuse it whenever needed. Functions and stored procedures work in the same way by storing SQL logic inside the database. Although they seem similar, they serve different purposes:

- A **Function** performs a task and **must return a value**.

- A **Stored Procedure** performs one or more operations and **does not have to return a value**.

Both help reduce code duplication, improve performance, simplify maintenance, and centralize business logic.

## PostgreSQL Functions

### What is a Function?

A **Function** is a reusable block of SQL or PL/pgSQL code that accepts input parameters, performs a task, and returns a value. Functions can be called inside SQL statements such as `SELECT`, `WHERE`, and `ORDER BY`.

### Syntax

```

CREATE FUNCTION function_name(parameters)
RETURNS return_type
LANGUAGE plpgsql
AS $$
BEGIN
-- SQL statements
RETURN value;
END;
$$;

```

### Example 1: Function Without Parameters

Create a function that returns a greeting.

```

CREATE FUNCTION greeting()
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
RETURN \'Welcome to PostgreSQL!\';
END;
$$;

```

Call the function:

```

SELECT greeting();

```

**Output**

| greeting |
|---|
| Welcome to PostgreSQL! |

### Example 2: Function With Parameters

Create a function to add two numbers.

```

CREATE FUNCTION add_numbers(num1 INT, num2 INT)
RETURNS INT
AS $$
BEGIN
RETURN num1 + num2;
END;
$$;

```

Execute:

```

SELECT add_numbers(15,10);

```

**Output**

| add_numbers |
|---|
| 25 |

### Example 3: Function Using a Table

Create an employee table.

```

CREATE TABLE employees (
emp_id SERIAL PRIMARY KEY,
name VARCHAR(50),
salary NUMERIC(10,2)
);

```

Insert records.

```

INSERT INTO employees(name, salary)
VALUES
(\'Anum\',45000),
(\'Saba\',60000),
(\'Hamza\',55000);

```

Function to return salary.

```

CREATE FUNCTION get_salary(emp_name VARCHAR)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
emp_salary NUMERIC;
BEGIN
SELECT salary
INTO emp_salary
FROM employees
WHERE name = emp_name;
RETURN emp_salary;
END;
$$;

```

Execute:

```

SELECT get_salary(\'Saba\');

```

**Output**

| get_salary |
|---|
| 60000 |

### Types of Functions

### 1. Scalar Function

Returns a single value. Example:

```

SELECT add_numbers(8,12);

```

### 2. Table-Valued Function

Returns multiple rows. Example:

```

CREATE FUNCTION employee_list()
RETURNS TABLE(name VARCHAR, salary NUMERIC)
LANGUAGE SQL
AS $$
SELECT name, salary
FROM employees;
$$;

```

Execute:

```

SELECT * FROM employee_list();

```

### 3. Aggregate Functions

Built-in PostgreSQL functions. Examples:

```

SELECT COUNT(*) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT SUM(salary) FROM employees;

```

### Advantages of Functions

- Reusable code

- Reduces repetition

- Easier maintenance

- Can return values

- Can be used inside SQL queries

- Improves readability

## PostgreSQL Stored Procedures

### What is a Stored Procedure?

A **Stored Procedure** is a reusable block of SQL code that performs one or more operations inside the database. Unlike functions, procedures:

- Do not have to return a value.

- Are executed using the `CALL` statement.

- Can manage transactions (`COMMIT`, `ROLLBACK`) within the procedure.

Stored procedures were introduced in **PostgreSQL 11**.

### Syntax

```

CREATE PROCEDURE procedure_name(parameters)
LANGUAGE plpgsql
AS $$
BEGIN
-- SQL statements
END;
$$;

```

### Example 1: Procedure to Insert Data

```

CREATE PROCEDURE add_employee(
emp_name VARCHAR,
emp_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
INSERT INTO employees(name, salary)
VALUES(emp_name, emp_salary);
END;
$$;

```

Execute:

```

CALL add_employee(\'Ali\',70000);

```

Verify:

```

SELECT * FROM employees;

```

### Example 2: Procedure to Update Salary

```

CREATE PROCEDURE update_salary(
emp_name VARCHAR,
new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
UPDATE employees
SET salary = new_salary
WHERE name = emp_name;
END;
$$;

```

Execute:

```

CALL update_salary(\'Anum\',50000);

```

Check:

```

SELECT * FROM employees;

```

### Example 3: Procedure to Delete Employee

```

CREATE PROCEDURE delete_employee(
emp_name VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
DELETE FROM employees
WHERE name = emp_name;
END;
$$;

```

Execute:

```

CALL delete_employee(\'Hamza\');

```

### Dropping a Procedure

```

DROP PROCEDURE delete_employee;

```

## Functions vs Stored Procedures

| Feature | Function | Stored Procedure |
|---|---|---|
| Returns Value | Yes (Required) | Optional |
| Called Using | SELECT | CALL |
| Can Be Used Inside SQL Queries | Yes | No |
| Transaction Control | Limited | Supports COMMIT and ROLLBACK |
| Primary Purpose | Calculate and return values | Perform database operations |
| Can Return Table | Yes | Usually No |

### Example Comparison

### Function

```

SELECT add_numbers(10,20);

```

Returns: `30`

### Procedure

Inserts a new employee but does not return a value.

## Practical Applications and Best Practices

### When Should We Use Functions?

Use functions when:

- Performing calculations

- Returning a value

- Retrieving specific information

- Using logic inside SQL queries

- Creating reusable formulas

**Examples**

- Calculate tax

- Find employee salary

- Calculate GPA

- Compute discounts

- Return customer age

### When Should We Use Stored Procedures?

Use stored procedures when:

- Inserting records

- Updating records

- Deleting records

- Processing multiple SQL statements

- Managing transactions

**Examples**

- Payroll processing

- Student registration

- Bank transactions

- Inventory updates

- Order processing

### Best Practices

### 1. Use Meaningful Names

Good: `calculate_bonus()` Poor: `func1()`

### 2. Keep Functions Small

Each function should perform one specific task.

### 3. Handle Errors

Example:

```

BEGIN
-- SQL statements
EXCEPTION
WHEN OTHERS THEN
RAISE NOTICE \'An error occurred.\';
END;

```

### 4. Avoid Repeating Code

Instead of copying SQL statements into multiple applications, place them inside a function or procedure.

### 5. Add Comments

```

-- Returns employee salary
CREATE FUNCTION get_salary(...)

```

This improves readability and maintenance.

### Real-World Examples

### Functions

- Calculate employee bonuses.

- Compute student CGPA.

- Calculate product discounts.

- Determine customer age.

- Validate email addresses.

### Stored Procedures

- Process online orders.

- Transfer money between bank accounts.

- Update inventory after purchases.

- Generate monthly payroll.

- Archive old records automatically.

### Conclusion

Functions and Stored Procedures are essential tools in PostgreSQL for writing reusable, organized, and efficient database code. A **Function** is best suited for calculations and operations that return a value, making it ideal for use within SQL queries. A **Stored Procedure** is designed to perform database operations such as inserting, updating, deleting, and managing transactions, and it is executed using the `CALL` statement. By choosing the right one for the task, we can reduce code duplication, improve performance, simplify maintenance, and build database applications that are reliable, scalable, and easier to manage.');

-- Lecture 9: Triggers in PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Triggers in PostgreSQL', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Triggers in PostgreSQL

## Introduction to Triggers

In a database, certain actions should happen automatically whenever data is inserted, updated, or deleted. For example, imagine a bank where every transaction must be recorded in an audit log, or a school where a student\'s record should automatically update when new marks are entered. Instead of relying on users to perform these extra tasks manually, PostgreSQL provides **Triggers**. A **Trigger** is a special database object that automatically executes a function when a specified event occurs on a table or view. These events include **INSERT**, **UPDATE**, **DELETE**, and **TRUNCATE**. Think of a trigger like a motion sensor light. The light remains off until someone enters the room. Similarly, a trigger waits for a specific database event and then automatically performs the required action. Triggers improve automation, enforce business rules, maintain data integrity, and keep audit records without requiring additional application code.

## Understanding Triggers

### What is a Trigger?

A **Trigger** is an automatic response to a database event. It is always attached to a table or view and executes a **trigger function** whenever the specified event occurs. In PostgreSQL:

- A **Trigger Function** contains the logic.

- A **Trigger** defines **when** that function should execute.

### How a Trigger Works

The basic workflow is: 1. A user performs an operation (`INSERT`, `UPDATE`, `DELETE`, or `TRUNCATE`). 2. PostgreSQL detects the event. 3. The associated trigger is activated. 4. The trigger function executes automatically. 5. The database completes the operation. This entire process happens automatically and requires no manual intervention.

### Syntax of a Trigger Function

A trigger function must return the `TRIGGER` data type.

```

CREATE FUNCTION function_name()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
-- Trigger logic
RETURN NEW;
END;
$$;

```

### Syntax of a Trigger

```

CREATE TRIGGER trigger_name
BEFORE INSERT
ON table_name
FOR EACH ROW
EXECUTE FUNCTION function_name();

```

## Creating Triggers in PostgreSQL

### Example Table

Create an employee table.

```

CREATE TABLE employees (
emp_id SERIAL PRIMARY KEY,
name VARCHAR(50),
salary NUMERIC(10,2)
);

```

Create an audit table.

```

CREATE TABLE employee_audit (
audit_id SERIAL PRIMARY KEY,
employee_name VARCHAR(50),
action_time TIMESTAMP
);

```

### Example 1: Trigger After INSERT

### Step 1: Create Trigger Function

```

CREATE FUNCTION log_employee_insert()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
INSERT INTO employee_audit(employee_name, action_time)
VALUES(NEW.name, CURRENT_TIMESTAMP);
RETURN NEW;
END;
$$;

```

### Step 2: Create Trigger

```

CREATE TRIGGER employee_insert_trigger
AFTER INSERT
ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_insert();

```

### Step 3: Test the Trigger

Insert data.

```

INSERT INTO employees(name, salary)
VALUES(\'Anum\',50000);

```

Check the audit table.

```

SELECT * FROM employee_audit;

```

**Output**

| Audit ID | Employee Name | Action Time |
|---|---|---|
| 1 | Anum | 2026-08-05 10:15:00 |

The audit record was created automatically.

### Example 2: Trigger Before UPDATE

Suppose we do not want employees to have a negative salary.

### Trigger Function

```

CREATE FUNCTION check_salary()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
IF NEW.salary < 0 THEN
RAISE EXCEPTION \'Salary cannot be negative.\';
END IF;
RETURN NEW;
END;
$$;

```

### Create Trigger

```

CREATE TRIGGER salary_validation
BEFORE UPDATE
ON employees
FOR EACH ROW
EXECUTE FUNCTION check_salary();

```

### Testing

```

UPDATE employees
SET salary = -5000
WHERE name = \'Anum\';

```

**Output**

```

ERROR: Salary cannot be negative.

```

The update is rejected before it reaches the table.

### Example 3: Trigger After DELETE

Create another audit table.

```

CREATE TABLE deleted_employees (
name VARCHAR(50),
deleted_at TIMESTAMP
);

```

Trigger function.

```

CREATE FUNCTION log_delete()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
INSERT INTO deleted_employees
VALUES(OLD.name, CURRENT_TIMESTAMP);
RETURN OLD;
END;
$$;

```

Create trigger.

```

CREATE TRIGGER employee_delete_trigger
AFTER DELETE
ON employees
FOR EACH ROW
EXECUTE FUNCTION log_delete();

```

Delete an employee.

```

DELETE FROM employees
WHERE name = \'Hamza\';

```

The deleted employee\'s name is automatically stored in the audit table.

## Types of Triggers

### 1. BEFORE Trigger

Runs **before** the database operation. Example: `BEFORE INSERT` Uses:

- Validate data

- Prevent invalid entries

- Modify incoming values

### 2. AFTER Trigger

Runs **after** the database operation completes. Example: `AFTER UPDATE` Uses:

- Logging

- Auditing

- Notifications

- Reporting

### 3. INSTEAD OF Trigger

Used mainly on **Views**. Instead of performing the default action, PostgreSQL executes the trigger function. Example: `INSTEAD OF INSERT` This allows updates or inserts through complex views.

### 4. Row-Level Trigger

Executes once for every affected row. Example: `FOR EACH ROW` If five rows are updated, the trigger runs five times.

### 5. Statement-Level Trigger

Executes once per SQL statement, regardless of the number of affected rows. Example: If 1,000 rows are updated by one SQL statement, the trigger runs only once.

## Special Trigger Variables

PostgreSQL provides special variables inside trigger functions.

| Variable | Description |
|---|---|
| NEW | Contains the new row after INSERT or UPDATE |
| OLD | Contains the old row before UPDATE or DELETE |
| TG_NAME | Trigger name |
| TG_OP | Operation ( INSERT, UPDATE, DELETE) |
| TG_TABLE_NAME | Table on which the trigger fired |

### Example Using OLD and NEW

```

IF NEW.salary > OLD.salary THEN
RAISE NOTICE \'Salary increased.\';
END IF;

```

This compares the previous salary with the updated salary.

## Managing Triggers

### View Existing Triggers

```

SELECT trigger_name
FROM information_schema.triggers;

```

### Disable a Trigger

```

ALTER TABLE employees
DISABLE TRIGGER employee_insert_trigger;

```

The trigger remains in the database but does not execute.

### Enable a Trigger

```

ALTER TABLE employees
ENABLE TRIGGER employee_insert_trigger;

```

### Delete a Trigger

```

DROP TRIGGER employee_insert_trigger
ON employees;

```

### Delete a Trigger Function

```

DROP FUNCTION log_employee_insert();

```

## Advantages and Limitations of Triggers

### Advantages

### 1. Automatic Execution

No manual intervention is required.

### 2. Data Integrity

Ensures only valid data is stored.

### 3. Audit Logging

Tracks inserts, updates, and deletions automatically.

### 4. Centralized Business Logic

Rules are stored inside the database rather than scattered across application code.

### 5. Security

Triggers can prevent unauthorized or invalid operations.

### Limitations

- Too many triggers can reduce database performance.

- Debugging becomes more difficult because triggers execute automatically.

- Complex trigger chains can make applications harder to understand.

- Improper trigger design may cause unexpected behavior or recursion.

## Real-World Applications of Triggers

Triggers are widely used in modern database systems.

### Banking Systems

- Record every financial transaction.

- Prevent invalid account balances.

### Hospital Management

- Log changes to patient records.

- Track prescription updates.

### School Management

- Automatically update attendance records.

- Record grade changes.

### E-commerce

- Reduce inventory after a purchase.

- Log customer orders.

### Payroll Systems

- Record salary changes.

- Maintain employee history.

### Best Practices

- Use triggers only when automation is truly needed.

- Keep trigger functions simple and efficient.

- Avoid creating multiple triggers that perform overlapping tasks.

- Test triggers thoroughly before deploying them.

- Document the purpose of every trigger for easier maintenance.

- Use `BEFORE` triggers for validation and `AFTER` triggers for logging or auditing.

### Conclusion

Triggers are powerful automation tools in PostgreSQL that execute automatically in response to database events such as **INSERT**, **UPDATE**, **DELETE**, and **TRUNCATE**. By combining triggers with trigger functions, we can enforce business rules, validate data, maintain audit logs, and ensure data integrity without relying on application code. Understanding the different types of triggers, the use of special variables like `NEW` and `OLD`, and following best practices allows us to build reliable, secure, and maintainable database applications. When used thoughtfully, triggers reduce manual effort and help databases respond intelligently to changes.');

-- Lecture 10: JSON & JSONB Support in PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'JSON & JSONB Support in PostgreSQL', 10, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# JSON & JSONB Support in PostgreSQL

## Introduction to JSON & JSONB

Modern applications often work with data that does not fit neatly into rows and columns. For example, an online shopping website may store different product specifications for each item. A smartphone might have a battery, RAM, and camera details, while a laptop has a processor, storage, and screen size. Creating separate columns for every possible attribute would be difficult and inefficient. To solve this problem, PostgreSQL provides **JSON** and **JSONB** data types, allowing us to store and work with semi-structured data directly inside the database. Think of **JSON** as a digital notebook where information is stored in key-value pairs. **JSONB** is like an organized filing cabinet. It stores the same information but in a binary format that is optimized for faster searching, indexing, and processing. JSON and JSONB make PostgreSQL flexible enough to handle structured, semi-structured, and even some unstructured data without sacrificing the power of SQL.

## Understanding JSON and JSONB

### What is JSON?

**JSON (JavaScript Object Notation)** is a lightweight data format used to exchange information between applications. A JSON object contains:

- Key-value pairs

- Arrays

- Nested objects

- Strings

- Numbers

- Boolean values

- Null values

### Example of JSON

```

{
"name": "Anum",
"age": 20,
"department": "AI",
"skills": ["Python", "SQL", "PostgreSQL"]
}

```

### What is JSONB?

**JSONB (JSON Binary)** is PostgreSQL\'s binary representation of JSON. Instead of storing the text exactly as written, PostgreSQL converts it into a binary format for efficient storage and querying.

### Benefits of JSONB

- Faster searches

- Faster queries

- Supports indexing

- Removes unnecessary whitespace

- Stores keys in an optimized format

For most PostgreSQL applications, **JSONB is the recommended choice** because of its better performance.

### Difference Between JSON and JSONB

| Feature | JSON | JSONB |
|---|---|---|
| Storage | Plain text | Binary format |
| Read Speed | Slower | Faster |
| Insert Speed | Slightly faster | Slightly slower (conversion required) |
| Supports Indexes | No | Yes |
| Duplicate Keys | Preserved | Last key is kept |
| Whitespace | Preserved | Removed |
| Best Use | Simple storage | Querying and indexing |

## Creating Tables with JSON and JSONB

### Using JSON

Create a table.

```

CREATE TABLE students (
student_id SERIAL PRIMARY KEY,
details JSON
);

```

Insert JSON data.

```

INSERT INTO students(details)
VALUES
(\'{
"name":"Anum",
"age":20,
"city":"Sukkur"
}\');

```

Retrieve data.

```

SELECT * FROM students;

```

### Using JSONB

Create a table.

```

CREATE TABLE products (
product_id SERIAL PRIMARY KEY,
product_info JSONB
);

```

Insert data.

```

INSERT INTO products(product_info)
VALUES
(\'{
"name":"Laptop",
"brand":"Dell",
"price":85000,
"stock":15
}\');

```

Display records.

```

SELECT * FROM products;

```

### Storing Nested JSON

JSON supports nested objects.

```

INSERT INTO students(details)
VALUES
(\'{
"name":"Saba",
"address":{
"city":"Karachi",
"country":"Pakistan"
}
}\');

```

Nested data allows us to organize related information logically.

## Querying JSON and JSONB Data

PostgreSQL provides special operators to retrieve JSON values.

### The Operator

`->` Returns a JSON object. Example:

```

SELECT product_info -> \'brand\'
FROM products;

```

**Output** `"Dell"`

### The Operator

`->>` Returns a value as plain text. Example:

```

SELECT product_info ->> \'brand\'
FROM products;

```

**Output** `Dell`

### Access Nested Objects

Suppose the JSON contains:

```

{
"address":{
"city":"Karachi"
}
}

```

Retrieve city.

```

SELECT details -> \'address\' ->> \'city\'
FROM students;

```

**Output** `Karachi`

### Retrieve Array Elements

Example JSON:

```

{
"skills":["Python","SQL","Java"]
}

```

Retrieve first skill.

```

SELECT details -> \'skills\' ->> 0
FROM students;

```

**Output** `Python`

### Filter Records

Find Dell products.

```

SELECT *
FROM products
WHERE product_info ->> \'brand\' = \'Dell\';

```

## Updating and Modifying JSONB Data

Unlike JSON, **JSONB** provides functions for modifying data efficiently.

### Update JSONB Value

```

UPDATE products
SET product_info =
jsonb_set(
product_info,
\'{price}\',
\'90000\'
);

```

The product price changes from **85000** to **90000**.

### Add New Key

```

UPDATE products
SET product_info =
product_info ||
\'{"color":"Black"}\';

```

Updated JSON:

```

{
"name":"Laptop",
"brand":"Dell",
"price":90000,
"stock":15,
"color":"Black"
}

```

### Remove a Key

```

UPDATE products
SET product_info =
product_info - \'stock\';

```

The `stock` key is removed.

### Check Updated Data

```

SELECT * FROM products;

```

## Indexing JSONB

One of JSONB\'s biggest advantages is indexing.

### Create a GIN Index

```

CREATE INDEX idx_product_info
ON products
USING GIN(product_info);

```

A **GIN (Generalized Inverted Index)** speeds up searches inside JSONB documents. Without an index, PostgreSQL scans every row. With a GIN index, PostgreSQL quickly locates matching JSON values.

### Example Search

```

SELECT *
FROM products
WHERE product_info @> \'{"brand":"Dell"}\';

```

The `@>` operator checks whether the JSONB document contains the specified key-value pair.

## Useful JSON & JSONB Functions

### Convert Row to JSON

```

SELECT row_to_json(products)
FROM products;

```

Converts an SQL row into JSON format.

### Convert JSON to Record

```

SELECT *
FROM json_to_record(
\'{"name":"Hamza","age":22}\'
)
AS x(name TEXT, age INT);

```

**Output**

| Name | Age |
|---|---|
| Hamza | 22 |

### Pretty Print JSON

```

SELECT jsonb_pretty(product_info)
FROM products;

```

Displays JSONB in a well-formatted, readable structure.

### Find JSON Type

```

SELECT jsonb_typeof(product_info)
FROM products;

```

Possible results:

- object

- array

- string

- number

- boolean

- null

## Advantages and Limitations

### Advantages

### 1. Flexible Data Storage

Different records can have different attributes without changing the table structure.

### 2. Easy Integration

JSON is widely used in REST APIs, web applications, and mobile apps.

### 3. Powerful Querying

PostgreSQL provides many operators and functions to retrieve and manipulate JSON data.

### 4. High Performance with JSONB

JSONB supports indexing, making searches much faster.

### 5. Reduced Schema Changes

Applications can store additional fields without altering the database schema.

### Limitations

- JSON data may be harder to validate than regular table columns.

- Complex JSON structures can make queries difficult to read.

- JSONB requires slightly more processing during inserts because data is converted to binary.

- Overusing JSON instead of proper relational tables can reduce database normalization and maintainability.

## Real-World Applications

### E-commerce

- Product specifications

- Customer preferences

- Shopping cart details

### Social Media

- User profiles

- Posts

- Comments

- Reactions

### Healthcare

- Medical records

- Patient histories

- Test results

### Banking

- Transaction metadata

- Customer settings

- Account preferences

### IoT (Internet of Things)

- Sensor readings

- Device configurations

- Smart home data

### Best Practices

- Prefer **JSONB** over JSON for most applications because of its indexing and query performance.

- Store highly structured data in regular table columns and use JSONB only for flexible or optional attributes.

- Create GIN indexes on frequently searched JSONB columns.

- Avoid storing your entire database inside one large JSON document.

- Keep JSON structures simple and consistent across records.

- Validate JSON data before inserting it into the database.

- Use PostgreSQL\'s built-in JSON operators and functions instead of processing JSON in application code whenever possible.

### Conclusion

JSON and JSONB are powerful PostgreSQL features that allow us to store and manage semi-structured data efficiently. While **JSON** stores data as plain text and is useful for preserving the original format, **JSONB** stores data in a binary format that supports indexing, faster searches, and efficient updates. PostgreSQL provides a rich set of operators and functions for querying, modifying, and indexing JSONB documents, making it an excellent choice for modern applications such as e-commerce platforms, APIs, IoT systems, healthcare solutions, and social media services. By combining the flexibility of JSONB with the reliability of relational tables, we can design databases that are both scalable and high-performing.');

-- Lecture 11: Transactions & Concurrency Control in PostgreSQL
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Transactions & Concurrency Control in PostgreSQL', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Transactions & Concurrency Control in PostgreSQL

## Introduction to Transactions and Concurrency Control

Imagine you are transferring **Rs. 5,000** from one bank account to another. The system must first deduct the money from your account and then add it to the recipient\'s account. But what if the power goes out after the deduction and before the deposit? The money would disappear, creating an inconsistent database. To prevent such situations, PostgreSQL uses **Transactions**. A **Transaction** is a sequence of one or more SQL statements treated as a single unit of work. Either **all operations succeed**, or **none of them are applied**. Now imagine hundreds of users accessing the database at the same time. Without proper control, two users might try to update the same record simultaneously, leading to incorrect or conflicting data. PostgreSQL solves this problem through **Concurrency Control**. Together, transactions and concurrency control ensure that databases remain **accurate, reliable, and consistent**, even when many users are working simultaneously.

## Understanding Transactions

### What is a Transaction?

A **Transaction** is a logical group of SQL operations executed together. If every statement succeeds, PostgreSQL permanently saves the changes. If any statement fails, PostgreSQL restores the database to its previous state. Think of a transaction as a contract. Either every condition is fulfilled, or the entire agreement is canceled.

### Transaction Lifecycle

A transaction follows these steps: 1. Transaction begins. 2. SQL statements execute. 3. If successful → **COMMIT**. 4. If an error occurs → **ROLLBACK**.

### Basic Transaction Syntax

```

BEGIN;
-- SQL statements
COMMIT;

```

If an error occurs:

```

BEGIN;
-- SQL statements
ROLLBACK;

```

### Example: Successful Transaction

Create an accounts table.

```

CREATE TABLE accounts (
account_id SERIAL PRIMARY KEY,
customer_name VARCHAR(50),
balance NUMERIC(10,2)
);

```

Insert records.

```

INSERT INTO accounts(customer_name, balance)
VALUES
(\'Anum\',10000),
(\'Saba\',8000);

```

Transfer Rs. 2,000.

```

BEGIN;
UPDATE accounts
SET balance = balance - 2000
WHERE customer_name = \'Anum\';
UPDATE accounts
SET balance = balance + 2000
WHERE customer_name = \'Saba\';
COMMIT;

```

Both updates become permanent.

### Example: Failed Transaction

```

BEGIN;
UPDATE accounts
SET balance = balance - 2000
WHERE customer_name = \'Anum\';
-- Error occurs here
ROLLBACK;

```

Since the transaction is rolled back, Anum\'s balance remains unchanged.

## ACID Properties of Transactions

Every PostgreSQL transaction follows the **ACID** properties.

### 1. Atomicity

Atomicity means **all or nothing**. Either every statement succeeds, or every statement is canceled. **Example** A money transfer consists of:

- Deduct money.

- Deposit money.

If one operation fails, neither operation is saved.

### 2. Consistency

A transaction must move the database from one valid state to another. Example: Before transfer:

```

Anum = 10000
Saba = 8000
Total = 18000

```

After transfer:

```

Anum = 8000
Saba = 10000
Total = 18000

```

The total balance remains consistent.

### 3. Isolation

Transactions should not interfere with each other. If two users update the same account simultaneously, PostgreSQL ensures that one transaction completes safely before conflicting changes are applied.

### 4. Durability

Once a transaction is committed, the changes are permanent. Even if the server crashes immediately afterward, PostgreSQL recovers the committed data.

## Transaction Control Commands

### BEGIN

Starts a transaction.

```

BEGIN;

```

### COMMIT

Permanently saves all changes.

```

COMMIT;

```

### ROLLBACK

Cancels all changes since the transaction began.

```

ROLLBACK;

```

### SAVEPOINT

Creates a checkpoint inside a transaction.

```

BEGIN;
SAVEPOINT sp1;

```

### ROLLBACK TO SAVEPOINT

Undo changes only up to a specific savepoint.

```

ROLLBACK TO SAVEPOINT sp1;

```

### RELEASE SAVEPOINT

Removes a savepoint.

```

RELEASE SAVEPOINT sp1;

```

### Example Using SAVEPOINT

```

BEGIN;
UPDATE accounts
SET balance = balance - 1000
WHERE customer_name = \'Anum\';
SAVEPOINT transfer_step;
UPDATE accounts
SET balance = balance + 1000
WHERE customer_name = \'Saba\';
ROLLBACK TO SAVEPOINT transfer_step;
COMMIT;

```

Only the second update is undone, while the first update remains.

## Understanding Concurrency Control

### What is Concurrency?

**Concurrency** means multiple users accessing the database at the same time. Example:

- User A updates salary.

- User B reads salary.

- User C deletes employee data.

PostgreSQL allows all these operations while maintaining data integrity.

### Why is Concurrency Control Needed?

Without concurrency control, databases may suffer from data inconsistencies. Common problems include:

- Dirty Reads

- Non-Repeatable Reads

- Phantom Reads

- Lost Updates

### 1. Dirty Read

A transaction reads data that has not yet been committed. Example: Transaction A changes salary. Before committing, Transaction B reads the new salary. If Transaction A rolls back, Transaction B has read invalid data. PostgreSQL prevents dirty reads under its default isolation level.

### 2. Non-Repeatable Read

A transaction reads the same row twice but gets different values because another transaction modified and committed the row in between. Example: First read: `Salary = 50000` Another transaction updates salary. Second read: `Salary = 55000` The same query returns different results.

### 3. Phantom Read

A transaction executes the same query twice and gets additional rows because another transaction inserted new records. Example: First query: `10 employees` Another transaction inserts a new employee. Second query: `11 employees` The new row is called a **phantom row**.

### 4. Lost Update

Two transactions update the same row simultaneously. Example: Current balance: `10000` Transaction A deducts 1000. Transaction B deducts 2000. If both overwrite each other\'s work, one update is lost. PostgreSQL uses locking and **MVCC** to prevent such conflicts.

## Isolation Levels

PostgreSQL provides different isolation levels to balance consistency and performance.

### 1. Read Uncommitted

Lowest isolation level. In PostgreSQL, it behaves like **Read Committed**, so dirty reads are still prevented.

### 2. Read Committed (Default)

Each query sees only committed data. Prevents:

- Dirty Reads

Allows:

- Non-Repeatable Reads

- Phantom Reads

Example:

```

BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

```

### 3. Repeatable Read

Ensures rows read during a transaction remain unchanged. Prevents:

- Dirty Reads

- Non-Repeatable Reads

May still encounter serialization conflicts in rare cases.

```

BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

```

### 4. Serializable

Highest isolation level. Transactions execute as if they were running one after another. Prevents:

- Dirty Reads

- Phantom Reads

- Lost Updates

```

BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

```

This level provides maximum consistency but may reduce performance because PostgreSQL may abort and require retrying conflicting transactions.

## MVCC (Multi-Version Concurrency Control)

One of PostgreSQL\'s strongest features is **MVCC**. Instead of locking every row for readers, PostgreSQL creates **multiple versions** of rows. This allows:

- Readers to continue reading.

- Writers to continue updating.

- Minimal blocking.

Think of it like editing a shared document. Rather than stopping everyone while one person edits, PostgreSQL lets readers continue viewing a stable version while updates are being prepared.

### Advantages of MVCC

- High performance

- Better concurrency

- Fewer locks

- Faster read operations

- Reduced waiting time

## Best Practices for Transactions

- Keep transactions as short as possible.

- Commit changes immediately after successful execution.

- Roll back transactions when errors occur.

- Use `SAVEPOINT` for large transactions.

- Choose the appropriate isolation level for your application.

- Avoid leaving transactions open unnecessarily.

- Test concurrent operations to identify possible conflicts.

- Use indexes wisely to improve transaction performance.

## Real-World Applications

### Banking Systems

- Money transfers

- ATM withdrawals

- Online payments

### E-commerce

- Order placement

- Inventory updates

- Payment processing

### Hospital Management

- Patient admissions

- Billing

- Appointment scheduling

### University Systems

- Student registration

- Fee payment

- Result management

### Airline Reservation Systems

- Seat booking

- Ticket cancellation

- Flight scheduling

### Conclusion

Transactions and Concurrency Control are fundamental features of PostgreSQL that ensure databases remain accurate, reliable, and consistent even when many users access them simultaneously. Transactions guarantee that a group of SQL statements either succeeds completely or fails entirely through the **ACID** properties: **Atomicity, Consistency, Isolation, and Durability**. Concurrency control, supported by PostgreSQL\'s powerful **MVCC (Multi-Version Concurrency Control)** and isolation levels, allows multiple users to work efficiently without compromising data integrity. By understanding transaction commands, isolation levels, concurrency issues, and following best practices, we can build robust database applications capable of handling real-world workloads safely and efficiently.');

-- Lecture 12: Connecting PostgreSQL with an Application
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Connecting PostgreSQL with an Application', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Connecting PostgreSQL with an Application

## Introduction to Connecting PostgreSQL with an Application

A database is useful only when an application can communicate with it. Whether we are building a website, mobile application, desktop software, or an enterprise system, the application needs a way to store, retrieve, update, and delete data from the database. PostgreSQL provides reliable and secure ways for applications to interact with databases using **database drivers**, **connection libraries**, and **Application Programming Interfaces (APIs)**. Think of PostgreSQL as a library full of books and the application as a reader. The reader cannot simply walk into the library and grab information without following the proper process. A database connection acts like a library card, allowing the application to request information and receive results safely. Connecting PostgreSQL with an application is a fundamental skill because it enables developers to build dynamic systems such as online shopping websites, banking applications, hospital management systems, social media platforms, and student information systems.

## Understanding Database Connectivity

### What is Database Connectivity?

**Database connectivity** is the process of establishing communication between an application and a PostgreSQL database. Once connected, the application can:

- Retrieve data (`SELECT`)

- Insert new records (`INSERT`)

- Update existing records (`UPDATE`)

- Delete records (`DELETE`)

- Execute stored procedures and functions

- Manage transactions

The communication is usually established through a **database driver** or **client library**.

### Components of a Database Connection

Every PostgreSQL connection requires the following information:

| Component | Description |
|---|---|
| Host | Address of the PostgreSQL server |
| Port | Communication port (Default: 5432) |
| Database Name | Name of the database |
| Username | Database user account |
| Password | User authentication password |

Example connection details:

```

Host: localhost
Port: 5432
Database: university
Username: postgres
Password: mypassword

```

### Connection Workflow

The connection process follows these steps: 1. Application starts. 2. Database driver loads. 3. Connection request is sent. 4. PostgreSQL verifies the username and password. 5. Connection is established. 6. SQL queries are executed. 7. Results are returned. 8. Connection is closed.

## Connecting PostgreSQL Using Different Programming Languages

PostgreSQL supports almost every modern programming language through dedicated drivers.

### Connecting with Python

Python uses the **psycopg2** library.

### Install Library

`pip install psycopg2`

### Example Connection

```

import psycopg2
connection = psycopg2.connect(
host="localhost",
database="university",
user="postgres",
password="mypassword",
port="5432"
)
print("Connected Successfully!")
connection.close()

```

### Connecting with Java

Java commonly uses the PostgreSQL JDBC Driver.

### Example

```

import java.sql.Connection;
import java.sql.DriverManager;
public class Main {
public static void main(String[] args) throws Exception {
Connection con = DriverManager.getConnection(
"jdbc:postgresql://localhost:5432/university",
"postgres",
"mypassword"
);
System.out.println("Connected Successfully!");
con.close();
}
}

```

### Connecting with Node.js

Node.js commonly uses the **pg** package.

### Install

`npm install pg`

### Example

```

const { Client } = require(\'pg\');
const client = new Client({
host: \'localhost\',
user: \'postgres\',
password: \'mypassword\',
database: \'university\',
port: 5432
});
client.connect();
console.log("Connected Successfully!");
client.end();

```

### Connecting with PHP

PHP uses the PostgreSQL extension.

```

<?php
$conn = pg_connect(
"host=localhost
dbname=university
user=postgres
password=mypassword"
);
echo "Connected Successfully!";
pg_close($conn);
?>

```

## Performing Database Operations

Once connected, the application can execute SQL queries.

### Reading Data (SELECT)

Python Example:

```

import psycopg2
connection = psycopg2.connect(
host="localhost",
database="university",
user="postgres",
password="mypassword"
)
cursor = connection.cursor()
cursor.execute("SELECT * FROM students")
rows = cursor.fetchall()
for row in rows:
print(row)
connection.close()

```

### Inserting Data

```

cursor.execute(
"INSERT INTO students(name, age)
VALUES(\'Anum\',20)"
)
connection.commit()

```

`commit()` permanently saves the changes.

### Updating Data

```

cursor.execute(
"UPDATE students
SET age=21
WHERE name=\'Anum\'"
)
connection.commit()

```

### Deleting Data

```

cursor.execute(
"DELETE FROM students
WHERE name=\'Anum\'"
)
connection.commit()

```

## Using Prepared Statements

Instead of writing SQL queries by directly inserting user input, we should use **Prepared Statements**. Prepared statements separate SQL code from user data, improving both security and performance.

### Unsafe Method

```

query = "SELECT * FROM students WHERE name=\'" + name + "\'"

```

This is vulnerable to SQL Injection attacks.

### Safe Method

```

cursor.execute(
"SELECT * FROM students WHERE name=%s",
(name,)
)

```

The database safely handles user input.

### Benefits of Prepared Statements

- Prevent SQL Injection

- Improve query performance

- Simplify code

- Handle special characters correctly

## Managing Transactions

Applications often execute multiple SQL statements together. Example:

```

connection.autocommit = False
try:
cursor.execute(...)
cursor.execute(...)
connection.commit()
except:
connection.rollback()

```

If an error occurs, all changes are canceled using `rollback()`. This maintains database consistency.

## Connection Pooling

Opening a new database connection for every request is expensive. Instead, applications use **Connection Pooling**. A connection pool maintains several open database connections that applications can reuse. Instead of:

```

Connect
Disconnect
Connect
Disconnect

```

The application reuses existing connections.

### Advantages

- Faster performance

- Reduced server load

- Better scalability

- Efficient resource management

Popular connection pool libraries include:

- Python: `psycopg2.pool`

- Java: HikariCP

- Node.js: `pg.Pool`

## Security Best Practices

Connecting securely to PostgreSQL is essential.

### 1. Never Hard-Code Passwords

Bad example: `password = "mypassword"` Instead, use environment variables.

```

import os
password = os.getenv("DB_PASSWORD")

```

### 2. Use SSL Connections

Encrypt communication between the application and PostgreSQL. Example: `sslmode=require` SSL protects sensitive information from being intercepted during transmission.

### 3. Use Strong Authentication

- Strong passwords

- Limited database permissions

- Separate users for development and production

### 4. Close Connections

Always close:

- Cursor

- Connection

Example:

```

cursor.close()
connection.close()

```

This prevents resource leaks.

## Common Connection Errors

### Authentication Failed

```

FATAL:
password authentication failed

```

Cause:

- Incorrect username or password

Solution:

- Verify login credentials.

### Database Does Not Exist

```

FATAL:
database does not exist

```

Solution:

- Check the database name.

### Connection Refused

`could not connect to server` Possible causes:

- PostgreSQL service is not running.

- Incorrect host or port.

- Firewall restrictions.

### Too Many Connections

Occurs when the maximum connection limit is exceeded. Solution:

- Use connection pooling.

- Close unused connections promptly.

## Real-World Applications

- Customer registration

- Product catalog

- Shopping cart

- Online payments

### Banking

- Account management

- Money transfers

- Transaction history

### Hospital Management

- Patient records

- Appointment scheduling

- Billing

### University Management

- Student registration

- Course enrollment

- Examination results

### Social Media

- User profiles

- Posts

- Comments

- Messaging

### Best Practices

- Always use prepared statements to prevent SQL injection.

- Store database credentials securely using environment variables or configuration files.

- Close database connections and cursors after use.

- Use connection pooling for applications with many users.

- Handle exceptions properly and roll back failed transactions.

- Encrypt connections with SSL when accessing remote databases.

- Grant users only the permissions they need.

- Test database connections before deploying the application.

### Conclusion

Connecting PostgreSQL with an application is a fundamental step in developing modern software. By using appropriate database drivers such as **psycopg2** for Python, **JDBC** for Java, **pg** for Node.js, or the PostgreSQL extension for PHP, applications can communicate efficiently with the database to perform CRUD operations, execute transactions, and retrieve data. Following best practices such as using prepared statements, managing transactions, implementing connection pooling, securing credentials, and handling errors properly ensures that applications remain secure, scalable, and reliable. Mastering database connectivity enables developers to build powerful, data-driven applications capable of supporting real-world business needs.');

-- Lecture 13: Building a PostgreSQL-Backed Application
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a PostgreSQL-Backed Application', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a PostgreSQL-Backed Application

## Introduction to Building a PostgreSQL-Backed Application

Modern applications rely on databases to store and manage information. Whether we are creating an online shopping website, a university management system, a banking application, or a social media platform, the database serves as the backbone of the entire system. A **PostgreSQL-backed application** is an application that uses **PostgreSQL** as its primary database for storing, retrieving, updating, and managing data. PostgreSQL handles the data, while the application provides the interface through which users interact with that data. Think of a restaurant. Customers place orders through the waiter, the kitchen prepares the food, and the storage room keeps all the ingredients. In the same way, the **user interface** collects user input, the **application logic** processes requests, and **PostgreSQL** securely stores the information. Building such an application requires careful planning, proper database design, secure connectivity, and efficient SQL queries to ensure reliability, scalability, and performance.

## Architecture of a PostgreSQL-Backed Application

A PostgreSQL-backed application generally follows a **three-tier architecture**.

### 1. Presentation Layer (Frontend)

This is the part users interact with. Examples include:

- Website

- Mobile application

- Desktop application

Responsibilities:

- Display information

- Collect user input

- Send requests to the backend

Examples of frontend technologies:

- HTML

- CSS

- JavaScript

- React

- Angular

- Vue.js

- Flutter

### 2. Application Layer (Backend)

The backend acts as the bridge between the frontend and PostgreSQL. Responsibilities:

- Process user requests

- Validate input

- Execute business logic

- Communicate with PostgreSQL

- Return results

Popular backend technologies:

- Python (Django, Flask)

- Node.js (Express)

- Java (Spring Boot)

- PHP (Laravel)

- C# (.NET)

### 3. Database Layer

This layer consists of PostgreSQL. Responsibilities:

- Store data

- Execute SQL queries

- Manage transactions

- Maintain data integrity

- Provide security and backup

### Architecture Diagram

```

+----------------------+
| Frontend |
| (HTML, React, etc.) |
+----------+-----------+
|
|
v
+----------------------+
| Backend |
| (Python, Java, etc.) |
+----------+-----------+
|
|
v
+----------------------+
| PostgreSQL |
| Database |
+----------------------+

```

## Steps to Build a PostgreSQL-Backed Application

### Step 1: Define Requirements

Before writing code, identify:

- What problem is the application solving?

- Who will use it?

- What information needs to be stored?

Example: Student Management System Required features:

- Student registration

- Login

- Course enrollment

- Grade management

### Step 2: Design the Database

Create tables with appropriate relationships. Example:

```

CREATE TABLE students (
student_id SERIAL PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(100)
);

```

Courses table:

```

CREATE TABLE courses (
course_id SERIAL PRIMARY KEY,
course_name VARCHAR(50)
);

```

Enrollment table:

```

CREATE TABLE enrollments (
student_id INT REFERENCES students(student_id),
course_id INT REFERENCES courses(course_id)
);

```

### Step 3: Connect the Application

Python example:

```

import psycopg2
connection = psycopg2.connect(
host="localhost",
database="university",
user="postgres",
password="mypassword"
)

```

Once connected, the application can execute SQL queries.

### Step 4: Build CRUD Operations

### Create

```

INSERT INTO students(name,email)
VALUES(\'Anum\',\'anum@email.com\');

```

### Read

```

SELECT *
FROM students;

```

### Update

```

UPDATE students
SET email=\'anum123@email.com\'
WHERE student_id=1;

```

### Delete

```

DELETE FROM students
WHERE student_id=1;

```

CRUD operations form the foundation of nearly every database-driven application.

## Building Application Features

### User Authentication

Applications often require users to log in. Typical process: 1. User enters username and password. 2. Backend validates credentials. 3. PostgreSQL checks stored records. 4. Access is granted if valid. Example table:

```

CREATE TABLE users (
user_id SERIAL PRIMARY KEY,
username VARCHAR(50),
password_hash TEXT
);

```

**Important:** Passwords should never be stored as plain text. Always store **hashed passwords** using secure algorithms such as **bcrypt** or **Argon2**.

### Search Functionality

Example:

```

SELECT *
FROM students
WHERE name LIKE \'%Anum%\';

```

### Filtering

Example:

```

SELECT *
FROM students
WHERE department=\'AI\';

```

### Sorting

```

SELECT *
FROM students
ORDER BY name;

```

### Pagination

Retrieve only ten students.

```

SELECT *
FROM students
LIMIT 10
OFFSET 0;

```

Pagination improves performance for large datasets.

## Transactions and Error Handling

Applications should protect data from partial updates. Example:

```

try:
cursor.execute(...)
cursor.execute(...)
connection.commit()
except:
connection.rollback()

```

If one query fails, every operation is canceled.

### Input Validation

Never trust user input. Incorrect: Correct:

```

if age > 0:
Save record

```

Validation protects data quality.

### Exception Handling

Example:

```

try:
connection = ...
except Exception as error:
print(error)

```

Proper error handling prevents application crashes.

## Performance Optimization

### Use Indexes

Example:

```

CREATE INDEX idx_student_name
ON students(name);

```

Indexes improve search speed.

### Use Prepared Statements

Unsafe:

```

query = "SELECT * FROM users WHERE name=\'" + name + "\'"

```

Safe:

```

cursor.execute(
"SELECT * FROM users WHERE name=%s",
(name,)
)

```

Prepared statements prevent SQL Injection.

### Connection Pooling

Instead of repeatedly opening and closing connections, reuse them. Benefits:

- Faster response time

- Lower server load

- Better scalability

### Optimize Queries

Instead of:

```

SELECT *
FROM students;

```

Use: `SELECT name,email` Retrieve only the columns that are needed.

## Testing the Application

Before deployment, every feature should be tested.

### Functional Testing

Verify that:

- Login works

- Registration works

- CRUD operations work

### Performance Testing

Check:

- Query execution time

- Response time

- Large dataset performance

### Security Testing

Ensure:

- SQL Injection protection

- Authentication works correctly

- User permissions are enforced

- Sensitive data is protected

## Deployment

After development and testing, deploy the application. Typical deployment steps: 1. Create the PostgreSQL database. 2. Import the schema. 3. Configure environment variables. 4. Start the backend server. 5. Launch the frontend. 6. Test the production environment. Popular hosting platforms:

- AWS

- Microsoft Azure

- Google Cloud Platform (GCP)

- DigitalOcean

- Render

- Railway

## Real-World Applications

### University Management System

- Student registration

- Course enrollment

- Grade management

### Banking System

- Account management

- Transactions

- Loan processing

### Hospital Management

- Patient records

- Doctor scheduling

- Billing

### E-commerce Platform

- Products

- Orders

- Payments

- Inventory

### Social Media Platform

- User accounts

- Posts

- Comments

- Messaging

### Best Practices

- Design a normalized database before development.

- Use primary keys, foreign keys, and constraints to maintain data integrity.

- Always use prepared statements or parameterized queries to prevent SQL injection.

- Store passwords securely using hashing algorithms like bcrypt or Argon2.

- Use transactions for operations involving multiple related queries.

- Create indexes on frequently searched columns.

- Use connection pooling to improve performance in high-traffic applications.

- Store database credentials in environment variables instead of hard-coding them.

- Regularly back up the PostgreSQL database.

- Monitor query performance and optimize slow queries as the application grows.

### Conclusion

Building a PostgreSQL-backed application involves much more than simply connecting a database to a program. It requires careful planning, a well-designed database schema, secure application architecture, efficient CRUD operations, transaction management, input validation, performance optimization, and thorough testing. PostgreSQL provides powerful features such as transactions, indexing, prepared statements, and robust security, making it an excellent choice for modern applications. By following best practices and designing each layer of the application thoughtfully, we can develop secure, scalable, high-performance systems capable of supporting real-world business requirements across industries such as education, healthcare, banking, e-commerce, and social media.');
