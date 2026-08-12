-- =============================================
-- ReflectAI — MongoDB Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'MongoDB' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to MongoDB & NoSQL Databases
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to MongoDB & NoSQL Databases', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to MongoDB & NoSQL Databases

## Introduction to NoSQL Databases

For many years, relational databases such as MySQL and PostgreSQL were the standard choice for storing data. They organize information into tables consisting of rows and columns, making them ideal for structured data. However, as modern applications such as social media platforms, online shopping websites, IoT systems, and mobile apps became more complex, developers needed databases that could store large amounts of flexible and rapidly changing data. This led to the rise of **NoSQL databases**. **NoSQL** stands for **"Not Only SQL."** It does not mean SQL is abandoned; instead, it means databases are no longer limited to the traditional relational model. NoSQL databases provide flexible ways to store and manage data, making them suitable for applications that require scalability, speed, and adaptable data structures. Imagine organizing books in a library. A relational database requires every book to follow the same catalog format. A NoSQL database is more like a collection of folders where each folder can contain different types of information depending on its purpose. This flexibility makes NoSQL databases highly practical for modern software development.

### What is a NoSQL Database?

A **NoSQL database** is a non-relational database designed to store and retrieve data efficiently without requiring a fixed table structure. Unlike relational databases, NoSQL databases can handle:

- Structured data

- Semi-structured data

- Unstructured data

Examples include:

- MongoDB

- Cassandra

- Redis

- CouchDB

- Neo4j

### Characteristics of NoSQL Databases

- Flexible schema

- High scalability

- Fast performance

- Easy handling of large datasets

- Distributed architecture

- Suitable for cloud-based applications

### Types of NoSQL Databases

### 1. Document Databases

Store data as JSON-like documents. Example:

- MongoDB

### 2. Key-Value Databases

Store data as key-value pairs. Example:

- Redis

### 3. Column-Family Databases

Store data in columns instead of rows. Example:

- Cassandra

### 4. Graph Databases

Store relationships between data. Example:

- Neo4j

## Introduction to MongoDB

### What is MongoDB?

**MongoDB** is one of the world\'s most popular **NoSQL document databases**. It stores data as flexible **BSON (Binary JSON)** documents instead of tables and rows. Developed by **MongoDB Inc.**, MongoDB is open-source and widely used in web development, cloud computing, data analytics, artificial intelligence, and Internet of Things (IoT) applications. Instead of storing records in tables, MongoDB stores them inside **collections**, where each record is called a **document**.

### Why MongoDB?

MongoDB became popular because it solves many limitations of traditional databases. Its advantages include:

- Flexible document structure

- High performance

- Horizontal scalability

- Easy integration with web applications

- Support for large datasets

- Built-in replication and sharding

### MongoDB Data Structure

MongoDB organizes data using the following hierarchy:

```

Database
│
├── Collection
│ │
│ ├── Document
│ ├── Document
│ └── Document

```

### Database

A container that holds collections. Example: `University`

### Collection

Similar to a table in relational databases. Example: `Students`

### Document

A document is a single record stored in JSON-like format. Example:

```

{
"name": "Anum",
"age": 20,
"department": "Artificial Intelligence"
}

```

Each document may contain different fields.

### MongoDB vs Relational Database

| Relational Database | MongoDB |
|---|---|
| Database | Database |
| Table | Collection |
| Row | Document |
| Column | Field |
| Primary Key | _id |
| Schema Required | Flexible Schema |

## Features of MongoDB

### 1. Document-Oriented Storage

MongoDB stores complete objects as documents. Example:

```

{
"name": "Hamza",
"age": 22,
"skills": [
"Python",
"Java",
"MongoDB"
]
}

```

This allows developers to store related information together.

### 2. Flexible Schema

Unlike relational databases, documents inside the same collection do not need identical fields. Example: Document 1

```

{
"name": "Anum",
"age": 20
}

```

Document 2

```

{
"name": "Saba",
"city": "Karachi",
"email": "saba@email.com"
}

```

Both documents belong to the same collection.

### 3. Scalability

MongoDB supports **horizontal scaling**, allowing data to be distributed across multiple servers using **sharding**.

### 4. High Performance

MongoDB uses indexes to speed up searches and supports efficient read and write operations.

### 5. Replication

MongoDB automatically creates multiple copies of data using **Replica Sets**, ensuring high availability and fault tolerance.

### 6. Aggregation Framework

MongoDB provides powerful aggregation pipelines for data analysis and reporting.

## Installing MongoDB & MongoDB Compass

Before building applications with MongoDB, we must install both the database server and a graphical interface for managing data.

### What is MongoDB Community Server?

The **MongoDB Community Server** is the free edition of MongoDB used for development and learning. It includes:

- MongoDB Server

- MongoDB Shell (`mongosh`)

- Database Engine

### System Requirements

Typical requirements include:

- Windows 10/11, Linux, or macOS

- 64-bit operating system

- At least 4 GB RAM (8 GB recommended)

- Around 2 GB of free disk space

### Installing MongoDB on Windows

### Step 1: Download MongoDB

Visit the official MongoDB website and download the **MongoDB Community Server** installer suitable for your operating system.

### Step 2: Run the Installer

Double-click the downloaded installer and proceed through the installation wizard.

### Step 3: Choose Complete Installation

Select **Complete** installation to install all essential components.

### Step 4: Install MongoDB as a Service

Enable the option: `Install MongoDB as a Service` This allows MongoDB to start automatically whenever Windows starts.

### Step 5: Complete Installation

Finish the installation process.

### Verifying Installation

Open Command Prompt and type: `mongosh` If MongoDB starts successfully, the installation is complete. You can also check the version: `mongod --version`

## Installing MongoDB Compass

### What is MongoDB Compass?

**MongoDB Compass** is the official graphical user interface (GUI) for MongoDB. Instead of typing commands in the terminal, Compass allows us to:

- Create databases

- Insert documents

- Edit records

- Delete documents

- Execute queries

- Build indexes

- Analyze performance

Think of MongoDB Compass as **phpMyAdmin** for MySQL or **pgAdmin** for PostgreSQL.

### Installing MongoDB Compass

### Step 1: Download Compass

Download **MongoDB Compass** from the official MongoDB website.

### Step 2: Install

Run the installer and follow the setup wizard.

### Step 3: Launch Compass

Open MongoDB Compass after installation.

### Connecting to MongoDB

By default, MongoDB runs locally using the following connection string: `mongodb://localhost:27017` Click **Connect**. If the connection is successful, Compass displays the list of databases.

### Creating a Database

1. Click **Create Database**. 2. Enter:

```

Database Name:
University
Collection Name:
Students

```

3. Click **Create Database**. The database is now ready.

### Inserting a Document

Inside the **Students** collection: Click **Insert Document** and enter:

```

{
"name": "Anum",
"age": 20,
"department": "Artificial Intelligence"
}

```

Click **Insert**. The document is stored successfully.

### Viewing Documents

Open the collection. MongoDB Compass displays all documents in a tabular format.

## Advantages and Limitations of MongoDB

### Advantages

### 1. Flexible Schema

Documents can have different fields without changing the database structure.

### 2. Easy Scalability

MongoDB efficiently handles growing datasets through horizontal scaling.

### 3. Fast Development

Developers can modify document structures quickly without redesigning tables.

### 4. High Availability

Replica Sets ensure that data remains available even if one server fails.

### 5. JSON-Like Documents

Data closely resembles objects used in programming languages such as JavaScript and Python, making application development easier.

### Limitations

- Data duplication can occur because normalization is less common.

- Complex joins are not as straightforward as in relational databases.

- Improper document design can reduce performance.

- Transactions across many documents may be more complex than in traditional relational databases.

## Real-World Applications of MongoDB

### E-commerce

- Product catalogs

- Customer reviews

- Shopping carts

### Social Media

- User profiles

- Posts

- Comments

- Messages

### Healthcare

- Electronic medical records

- Appointment scheduling

### Banking

- Customer profiles

- Transaction logs

- Notifications

### Internet of Things (IoT)

- Sensor data

- Device monitoring

- Smart home systems

### Best Practices

- Use meaningful names for databases and collections.

- Design documents according to application requirements rather than copying relational database structures.

- Use indexes on frequently queried fields.

- Validate documents to maintain data consistency.

- Keep documents reasonably sized and avoid excessive nesting.

- Regularly back up MongoDB databases.

- Use MongoDB Compass for easier database visualization and management during development.

### Conclusion

MongoDB is a powerful NoSQL document database designed to handle modern applications that require flexibility, scalability, and high performance. Unlike relational databases, it stores information in **collections** and **JSON-like documents**, allowing developers to work with dynamic and evolving data structures. The installation of the **MongoDB Community Server** provides the database engine, while **MongoDB Compass** offers an intuitive graphical interface for creating databases, managing collections, inserting documents, and running queries. By understanding the fundamentals of NoSQL databases, MongoDB\'s document model, and the installation process, we establish a strong foundation for building efficient, scalable, and data-driven applications using MongoDB.');

-- Lecture 2: Databases, Collections & Documents in MongoDB
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Databases, Collections & Documents in MongoDB', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Databases, Collections & Documents in MongoDB

## Introduction to Databases, Collections & Documents

MongoDB organizes data differently from traditional relational databases. Instead of storing information in tables made up of rows and columns, MongoDB stores data in **documents**, groups those documents into **collections**, and places collections inside a **database**. Think of a university as an example. The university itself is like a **database**. Inside the university are different departments such as Computer Science, Business, and Engineering, which are similar to **collections**. Within each department are student records, which represent **documents**. This hierarchical structure makes MongoDB simple, flexible, and easy to understand. Understanding these three core concepts is essential because every MongoDB application is built using databases, collections, and documents.

## Understanding MongoDB Databases

### What is a Database?

A **Database** is the highest-level container in MongoDB. It stores one or more collections that hold related information. A single MongoDB server can contain multiple databases, each serving a different purpose.

### Examples of Databases

- University

- Hospital

- Banking

- ECommerce

- Library

Each database is independent and contains its own collections.

### Creating a Database

MongoDB creates databases automatically when data is first inserted. Using MongoDB Shell: `use University` If the **University** database does not already exist, MongoDB creates it after the first document is inserted.

### Viewing Databases

Display all databases: `show dbs` Display the currently selected database: `db`

### Switching Between Databases

`use Hospital` Now the active database becomes **Hospital**.

### Dropping (Deleting) a Database

`db.dropDatabase()` This permanently deletes the current database and all of its collections.

## Understanding Collections

### What is a Collection?

A **Collection** is a group of related documents inside a MongoDB database. It is similar to a table in a relational database, but unlike tables, collections do not require a fixed structure. Documents within the same collection can have different fields. For example, a **University** database might contain:

- Students

- Teachers

- Courses

- Departments

Each of these is a separate collection.

### Creating a Collection

Create a collection explicitly:

```

db.createCollection("Students")

```

MongoDB can also create a collection automatically when the first document is inserted.

### Viewing Collections

Display all collections: `show collections` Example output:

```

Students
Teachers
Courses

```

### Dropping a Collection

Delete the **Students** collection: `db.Students.drop()` The collection and all its documents are permanently removed.

### Collection Naming Rules

Collection names:

- Should be meaningful.

- Are case-sensitive.

- Should not contain the null (`\\0`) character.

- Should avoid special characters and unnecessary spaces.

Good examples:

```

Students
Employees
Orders

```

Poor examples:

```

Data123!!
My Collection
Temp$$$

```

## Understanding Documents

### What is a Document?

A **Document** is the basic unit of data in MongoDB. Documents are stored in **BSON (Binary JSON)** format but are written using **JSON-like syntax**. Each document contains **field-value pairs**. Example:

```

{
"name": "Anum",
"age": 20,
"department": "Artificial Intelligence"
}

```

This document represents one student.

### Fields

Each piece of information inside a document is called a **field**. Example:

```

{
"name": "Saba",
"city": "Karachi",
"semester": 2
}

```

Fields are:

- name

- city

- semester

Values can be:

- Strings

- Numbers

- Boolean values

- Arrays

- Objects

- Dates

- Null

### The Field

`_id` Every MongoDB document automatically receives a unique `_id` field if one is not provided. Example:

```

{
"_id": ObjectId("66b2d7c4f9d5a123456789ab"),
"name": "Hamza",
"age": 22
}

```

The `_id` field:

- Uniquely identifies each document.

- Acts like a primary key in relational databases.

- Cannot be duplicated within a collection.

### Nested Documents

MongoDB supports nested documents. Example:

```

{
"name": "Anum",
"address": {
"city": "Sukkur",
"country": "Pakistan"
}
}

```

The **address** field is itself another document.

### Arrays in Documents

MongoDB documents can store arrays. Example:

```

{
"name": "Saba",
"skills": [
"Python",
"MongoDB",
"SQL"
]
}

```

Arrays allow multiple related values to be stored within a single document.

## Working with Documents

### Insert One Document

```

db.Students.insertOne({
name: "Anum",
age: 20,
department: "Artificial Intelligence"
})

```

### Insert Multiple Documents

```

db.Students.insertMany([
{
name: "Saba",
age: 21
},
{
name: "Hamza",
age: 22
}
])

```

### View All Documents

`db.Students.find()`

### View Documents in Readable Format

`db.Students.find().pretty()` (In newer versions of `mongosh`, the shell already formats output nicely, so `.pretty()` may not be necessary.)

### Find One Document

`db.Students.findOne()` Returns the first matching document.

### Count Documents

`db.Students.countDocuments()` Example output: `3`

## MongoDB Data Types

MongoDB supports many data types.

| Data Type | Example |
|---|---|
| String | "Anum" |
| Integer | 20 |
| Double | 75.5 |
| Boolean | true |
| Array | ["Python","SQL"] |
| Object | {city:"Sukkur"} |
| Date | ISODate("2026-08-05") |
| Null | null |
| ObjectId | ObjectId("66b2d7c4f9d 5a123456789ab") |

## MongoDB vs Relational Database Structure

| Relational Database | MongoDB |
|---|---|
| Database | Database |
| Table | Collection |
| Row | Document |
| Column | Field |
| Primary Key | _id |
| Fixed Schema | Flexible Schema |

### Example Comparison

### Relational Database

| ID | Name | Age |
|---|---|---|
| 1 | Anum | 20 |

### MongoDB Document

```

{
"name": "Anum",
"age": 20
}

```

## Advantages and Limitations

### Advantages

### 1. Flexible Structure

Documents in the same collection can contain different fields.

### 2. Easy to Understand

JSON-like syntax is simple and closely matches objects used in programming languages.

### 3. Nested Data Support

Complex data can be stored within a single document using nested objects and arrays.

### 4. Faster Development

Schema changes usually do not require altering existing documents.

### 5. Better for Modern Applications

MongoDB is well suited for web, mobile, cloud, and IoT applications where data structures may evolve over time.

### Limitations

- Lack of a fixed schema can lead to inconsistent data if validation is not used.

- Large documents may affect performance.

- Data duplication can occur because related information is often embedded.

- Complex relationships may be easier to model in relational databases.

## Real-World Applications

### University Management

- Student records

- Teacher information

- Course details

### E-commerce

- Product catalogs

- Customer profiles

- Shopping carts

### Healthcare

- Patient records

- Medical histories

- Prescriptions

### Social Media

- User profiles

- Posts

- Comments

- Friend lists

### Online Learning Platforms

- Courses

- Lessons

- Student progress

- Quiz results

### Best Practices

- Use meaningful names for databases and collections.

- Design documents around how the application accesses data.

- Keep related data together using nested documents when appropriate.

- Avoid creating excessively large documents.

- Use the automatic `_id` field unless there is a specific reason to define your own.

- Apply schema validation when consistency is important.

- Regularly back up important databases and collections.

- Use indexes on frequently searched fields to improve performance.

### Conclusion

Databases, collections, and documents form the core structure of MongoDB. A **database** acts as the top-level container, **collections** organize related documents, and **documents** store the actual data using flexible JSON-like structures. This document-oriented approach makes MongoDB highly adaptable for modern applications where data requirements frequently change. Features such as automatic `_id` generation, nested documents, arrays, and flexible schemas simplify development while supporting scalable and high-performance systems. By understanding how databases, collections, and documents work together, we build a solid foundation for designing efficient MongoDB applications in fields such as education, healthcare, e-commerce, banking, and social media.');

-- Lecture 3: BSON & Data Types in MongoDB
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'BSON & Data Types in MongoDB', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# BSON & Data Types in MongoDB

## Introduction to BSON & Data Types

When we store information in MongoDB, the data is written using **JSON-like syntax**. However, MongoDB does not actually store data as plain JSON. Instead, it uses a special binary format called **BSON (Binary JSON)**. BSON is designed to make storing, retrieving, and processing data faster and more efficient. Think of JSON as a neatly written letter that humans can easily read, while BSON is like a compressed digital file that computers can process more quickly. Humans prefer reading JSON, but computers work more efficiently with BSON. Along with BSON, MongoDB supports many built-in **data types** such as strings, numbers, dates, arrays, objects, Boolean values, and ObjectIds. Choosing the correct data type is important because it improves storage efficiency, query performance, and data consistency.

## Understanding BSON

### What is BSON?

**BSON (Binary JavaScript Object Notation)** is the binary-encoded format MongoDB uses to store documents internally. Although developers write documents in JSON format, MongoDB automatically converts them into BSON before saving them to the database.

### Example JSON Document

```

{
"name": "Anum",
"age": 20,
"department": "Artificial Intelligence"
}

```

Internally, MongoDB stores this document in BSON format, which is optimized for speed and efficiency.

### Why Does MongoDB Use BSON?

BSON provides several improvements over plain JSON.

### Advantages of BSON

- Faster data storage

- Faster retrieval

- Efficient indexing

- Supports more data types than JSON

- Better performance for large datasets

- Easier traversal of documents

### JSON vs BSON

| Feature | JSON | BSON |
|---|---|---|
| Format | Text | Binary |
| Human Readable | Yes | No |
| Processing Speed | Slower | Faster |
| Storage | Less efficient | Optimized |
| Supported Data Types | Limited | Many more |
| Used By | Data exchange | MongoDB internal storage |

### How BSON Works

When a document is inserted:

```

{
"name": "Hamza",
"age": 22
}

```

MongoDB performs these steps: 1. Receives the JSON document. 2. Converts it into BSON. 3. Stores the BSON document on disk. 4. Converts BSON back to JSON-like output when displaying data to users. This process happens automatically.

## BSON Data Types

MongoDB supports many BSON data types that allow developers to store different kinds of information efficiently.

### 1. String

Stores text values. Example:

```

{
"name": "Anum"
}

```

Common uses:

- Names

- Email addresses

- Cities

- Product names

### 2. Integer

Stores whole numbers. Example:

```

{
"age": 20
}

```

Uses:

- Age

- Quantity

- Semester

- Marks

### 3. Double

Stores decimal numbers. Example:

```

{
"cgpa": 3.78
}

```

Uses:

- Prices

- GPA

- Measurements

- Ratings

### 4. Boolean

Stores only two values.

```

{
"isActive": true
}

```

Possible values:

- `true`

- `false`

Uses:

- Login status

- Account activation

- Payment confirmation

### 5. Null

Represents an unknown or empty value. Example:

```

{
"phone": null
}

```

### 6. Date

Stores date and time. Example:

```

{
"joiningDate": ISODate("2026-08-05")
}

```

Uses:

- Birth dates

- Registration dates

- Order dates

- Login timestamps

### 7. Array

Stores multiple values inside one field. Example:

```

{
"skills": [
"Python",
"MongoDB",
"SQL"
]
}

```

Arrays are useful for:

- Skills

- Phone numbers

- Subjects

- Product categories

### 8. Embedded Object (Document)

Stores another document inside a document. Example:

```

{
"name": "Saba",
"address": {
"city": "Karachi",
"country": "Pakistan"
}
}

```

Embedded documents organize related information together.

### 9. ObjectId

Every MongoDB document automatically receives an **ObjectId** unless one is explicitly provided. Example:

```

{
"_id": ObjectId("66b2d7c4f9d5a123456789ab")
}

```

The ObjectId:

- Is unique.

- Identifies each document.

- Functions like a primary key.

### 10. Binary Data

Stores binary files. Example:

- Images

- Audio

- Videos

- PDF documents

MongoDB often stores large files using **GridFS** instead of placing them directly inside documents.

## Understanding ObjectId

### What is an ObjectId?

An **ObjectId** is a 12-byte unique identifier automatically generated by MongoDB. Example: `66b2d7c4f9d5a123456789ab`

### Structure of an ObjectId

The ObjectId contains:

- Timestamp

- Machine identifier

- Process identifier

- Counter value

This combination ensures uniqueness across different systems.

### Benefits of ObjectId

- Automatically generated

- Globally unique

- Efficient indexing

- Includes creation time information

- Prevents duplicate primary keys

## Working with BSON Data Types

### Insert Different Data Types

```

db.Students.insertOne({
name: "Anum",
age: 20,
cgpa: 3.80,
isActive: true,
skills: ["Python", "MongoDB"],
address: {
city: "Sukkur",
country: "Pakistan"
},
joiningDate: new Date(),
phone: null
})

```

This single document contains multiple BSON data types.

### Viewing Stored Documents

`db.Students.find()` MongoDB automatically displays BSON documents in a JSON-like format.

### Finding Documents by Data Type

Example: Find students whose age is 20.

```

db.Students.find({
age: 20
})

```

### Working with Arrays

Find students who know MongoDB.

```

db.Students.find({
skills: "MongoDB"
})

```

MongoDB searches within the array automatically.

### Accessing Embedded Documents

Find students living in Sukkur.

```

db.Students.find({
"address.city": "Sukkur"
})

```

Dot notation is used to access nested fields.

## Advantages and Limitations of BSON

### Advantages

### 1. Faster Processing

Binary format allows MongoDB to process documents efficiently.

### 2. More Data Types

Supports dates, ObjectIds, binary data, and additional types beyond standard JSON.

### 3. Efficient Storage

Optimized for indexing and query performance.

### 4. Automatic Conversion

Developers work with JSON-like syntax while MongoDB manages BSON internally.

### 5. Better Performance

BSON is designed for fast reading and writing operations.

### Limitations

- BSON is not human-readable.

- Slightly larger than plain JSON because it stores additional metadata.

- Binary format cannot be edited directly using a text editor.

- Some advanced BSON types are specific to MongoDB and may not be supported by other systems.

## Real-World Applications

### E-commerce

- Product specifications

- Customer profiles

- Shopping cart items

### Healthcare

- Patient information

- Medical histories

- Laboratory reports

### Education

- Student records

- Courses

- Grades

- Attendance

### Banking

- Customer accounts

- Transactions

- Loan details

### Social Media

- User profiles

- Posts

- Comments

- Friend lists

## Best Practices

- Use the appropriate BSON data type for each field.

- Allow MongoDB to generate the `_id` field unless a custom identifier is required.

- Store dates using the BSON `Date` type instead of strings.

- Use embedded documents for closely related data.

- Keep arrays at a reasonable size to maintain performance.

- Avoid storing excessively large binary files directly in documents; use GridFS when appropriate.

- Maintain consistent data types for the same field across documents.

- Use indexes on frequently queried fields to improve search performance.

## BSON Data Types Summary

| BSON Data Type | Example | Common Use |
|---|---|---|
| String | "Anum" | Names, emails |
| Integer | 20 | Age, quantity |
| Double | 3.80 | GPA, prices |
| Boolean | true | Status, availability |
| Null | null | Missing values |
| Date | ISODate() | Birthdays, orders |
| Array | ["Python","SQL"] | Skills, tags |
| Object | {city:"Sukkur"} | Address, profile |
| ObjectId | ObjectId() | Unique document ID |

### Conclusion

BSON is the foundation of MongoDB\'s storage engine, enabling documents to be stored in an efficient binary format while allowing developers to work with familiar JSON-like syntax. By supporting a rich set of data types such as **String, Integer, Double, Boolean, Date, Array, Embedded Document, ObjectId, and Binary**, BSON provides the flexibility needed for modern applications. Understanding these data types and selecting the appropriate one for each field improves storage efficiency, query performance, and overall application reliability. Mastering BSON and MongoDB data types equips us to design well-structured, scalable databases for real-world systems in education, healthcare, banking, e-commerce, and many other domains.');

-- Lecture 4: CRUD Operations & Query Operators in MongoDB
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'CRUD Operations & Query Operators in MongoDB', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# CRUD Operations & Query Operators in MongoDB

## Introduction to CRUD Operations & Query Operators

Every database application, whether it is an online shopping website, a university management system, or a social media platform, performs four basic tasks: it stores new data, retrieves existing data, updates information, and removes unwanted records. These four fundamental operations are collectively known as **CRUD Operations**. MongoDB provides simple yet powerful commands to perform CRUD operations efficiently. Once data is stored, we often need to search for specific documents instead of retrieving everything. For this purpose, MongoDB provides **Query Operators**, which allow us to filter data based on different conditions. Think of a library. Adding a new book is like **Create**, searching for a book is **Read**, correcting information in a book is **Update**, and removing an old book is **Delete**. Query operators act like the library\'s search system, helping us quickly find the exact books we need. Understanding CRUD operations and query operators is essential because they form the foundation of every MongoDB application.

## CRUD Operations in MongoDB

### What is CRUD?

CRUD stands for:

- **C** – Create

- **R** – Read

- **U** – Update

- **D** – Delete

These operations are performed on **documents** inside a **collection**. Suppose we have a collection named **Students**.

### Create (Insert Documents)

The **Create** operation adds new documents to a collection.

### Insert One Document

```

db.Students.insertOne({
name: "Anum",
age: 20,
department: "Artificial Intelligence"
})

```

If the **Students** collection does not exist, MongoDB creates it automatically.

### Insert Multiple Documents

```

db.Students.insertMany([
{
name: "Saba",
age: 21,
department: "Computer Science"
},
{
name: "Hamza",
age: 22,
department: "Software Engineering"
}
])

```

Multiple documents are inserted with a single command.

### Read (Retrieve Documents)

The **Read** operation retrieves documents from a collection.

### Find All Documents

`db.Students.find()` Displays every document in the collection.

### Find One Document

`db.Students.findOne()` Returns the first matching document.

### Find with Condition

```

db.Students.find({
name: "Anum"
})

```

Returns only documents where the name is **Anum**.

### Update Documents

The **Update** operation modifies existing documents.

### Update One Document

```

db.Students.updateOne(
{ name: "Anum" },
{
$set: {
age: 21
}
}
)

```

Updates only one matching document.

### Update Multiple Documents

```

db.Students.updateMany(
{ department: "Computer Science" },
{
$set: {
semester: 3
}
}
)

```

Updates all matching documents.

### Replace Entire Document

```

db.Students.replaceOne(
{ name: "Hamza" },
{
name: "Hamza",
age: 23,
department: "Cyber Security"
}
)

```

The existing document is completely replaced.

### Delete Documents

The **Delete** operation removes documents.

### Delete One Document

```

db.Students.deleteOne({
name: "Anum"
})

```

### Delete Multiple Documents

```

db.Students.deleteMany({
department: "Computer Science"
})

```

### Delete All Documents

```

db.Students.deleteMany({})

```

This removes every document from the collection but keeps the collection itself.

## Query Operators in MongoDB

### What are Query Operators?

Query operators allow us to retrieve documents based on specific conditions. Instead of retrieving every document, we can filter the results. Example:

```

db.Students.find({
age: 20
})

```

Only students aged 20 are returned.

### Comparison Operators

**Equal (** `$eq` **)**

```

db.Students.find({
age: { $eq: 20 }
})

```

Returns documents where age equals 20. **Not Equal (** `$ne` **)**

```

db.Students.find({
age: { $ne: 20 }
})

```

Returns documents whose age is not 20. **Greater Than (** `$gt` **)**

```

db.Students.find({
age: { $gt: 20 }
})

```

Returns students older than 20. **Greater Than or Equal (** `$gte` **)**

```

db.Students.find({
age: { $gte: 20 }
})

```

Returns students whose age is 20 or more. **Less Than (** `$lt` **)**

```

db.Students.find({
age: { $lt: 22 }
})

```

**Less Than or Equal (** `$lte` **)**

```

db.Students.find({
age: { $lte: 21 }
})

```

**In (** `$in` **)**

```

db.Students.find({
department: {
$in: [
"Artificial Intelligence",
"Computer Science"
]
}
})

```

Matches any value in the list. **Not In (** `$nin` **)**

```

db.Students.find({
age: {
$nin: [20,21]
}
})

```

Returns documents whose age is neither 20 nor 21.

## Logical Query Operators

### AND ( )

`$and` Both conditions must be true.

```

db.Students.find({
$and: [
{ age: 20 },
{ department: "Artificial Intelligence" }
]
})

```

### OR ( )

`$or` At least one condition must be true.

```

db.Students.find({
$or: [
{ age: 20 },
{ age: 22 }
]
})

```

### NOT ( )

`$not` Reverses a condition.

```

db.Students.find({
age: {
$not: {
$gt: 20
}
}
})

```

Returns students whose age is **not greater than 20**.

### NOR ( )

`$nor` Returns documents where none of the conditions are true.

```

db.Students.find({
$nor: [
{ age: 20 },
{ department: "AI" }
]
})

```

## Element and Evaluation Operators

### Exists ( )

`$exists` Checks whether a field exists.

```

db.Students.find({
phone: {
$exists: true
}
})

```

Returns documents containing the **phone** field.

### Type ( )

`$type` Finds documents based on the BSON data type.

```

db.Students.find({
age: {
$type: "int"
}
})

```

### Regular Expression ( )

`$regex` Searches text using patterns.

```

db.Students.find({
name: {
$regex: "^A"
}
})

```

Returns names starting with **A**.

## Array Query Operators

Suppose documents contain:

```

{
"name": "Anum",
"skills": [
"Python",
"MongoDB",
"SQL"
]
}

```

### Search Inside Array

```

db.Students.find({
skills: "MongoDB"
})

```

Returns students who know MongoDB.

### Array Size ( )

```

$size
db.Students.find({
skills: {
$size: 3
}
})

```

Returns students with exactly three skills.

### All ( )

```

$all
db.Students.find({
skills: {
$all: [
"Python",
"MongoDB"
]
}
})

```

Returns students possessing both skills.

## Projection, Sorting & Limiting Results

### Projection

Display only selected fields.

```

db.Students.find(
{},
{
name:1,
age:1,
_id:0
}
)

```

### Sorting

Ascending order:

```

db.Students.find().sort({
age:1
})

```

Descending order:

```

db.Students.find().sort({
age:-1
})

```

### Limit Results

`db.Students.find().limit(5)` Returns only five documents.

### Skip Documents

`db.Students.find().skip(5)` Skips the first five documents.

## Advantages and Limitations

### Advantages

### 1. Simple CRUD Commands

MongoDB provides straightforward commands for inserting, retrieving, updating, and deleting data.

### 2. Powerful Query Operators

Operators allow highly flexible and efficient data filtering.

### 3. Fast Data Retrieval

Indexes combined with query operators improve search performance.

### 4. Flexible Documents

Queries work even when documents have different fields.

### 5. Easy Integration

MongoDB\'s JSON-like syntax closely matches objects in programming languages such as JavaScript and Python.

### Limitations

- Complex queries may require proper indexing for good performance.

- Flexible schemas can lead to inconsistent data if validation is not enforced.

- Querying deeply nested documents can become more complex.

- Incorrect use of update or delete operations may affect multiple documents unintentionally.

## Real-World Applications

### University Management

- Search students by department.

- Update semester information.

- Delete graduated student records.

### E-commerce

- Find products by category.

- Update inventory levels.

- Remove discontinued products.

### Healthcare

- Search patients by blood group.

- Update medical histories.

- Delete duplicate records.

### Banking

- Retrieve transaction histories.

- Update account information.

- Delete inactive accounts.

### Social Media

- Search user profiles.

- Update posts.

- Delete comments.

- Filter content by hashtags.

### Best Practices

- Use `insertOne()` or `insertMany()` based on the number of documents being added.

- Always include appropriate filters in `update` and `delete` operations to avoid unintended changes.

- Create indexes on frequently queried fields to improve performance.

- Use projection to retrieve only the fields required by the application.

- Combine query operators to build precise and efficient searches.

- Validate user input before performing CRUD operations.

- Test update and delete queries carefully, especially in production databases.

- Use meaningful field names and maintain consistent data types across documents.

### Conclusion

CRUD operations and query operators are the foundation of working with MongoDB. CRUD operations enable us to **Create, Read, Update, and Delete** documents, while query operators allow us to retrieve data based on specific conditions using comparison, logical, element, evaluation, and array operators. Features such as projection, sorting, limiting, and skipping results further enhance data retrieval by making queries more efficient and focused. By mastering these operations and following best practices, we can build fast, scalable, and reliable MongoDB applications for real-world domains such as education, healthcare, banking, e-commerce, and social media.');

-- Lecture 5: Schema Design & Data Modeling in MongoDB
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Schema Design & Data Modeling in MongoDB', 5, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Schema Design & Data Modeling in MongoDB

## Introduction to Schema Design & Data Modeling

Every successful database begins with a well-planned design. Even though MongoDB is a **schema-flexible** database, this does not mean we should store data without planning. A good schema makes an application faster, easier to maintain, and more scalable. **Schema Design** is the process of deciding how data should be organized inside collections and documents. **Data Modeling** is the practice of designing the relationships between different pieces of data based on the application\'s requirements. Think of building a house. Before construction begins, an architect creates a blueprint showing where the rooms, doors, and windows will be placed. Without a blueprint, the house may become confusing and difficult to use. Similarly, a well-designed MongoDB schema serves as the blueprint for an efficient database. Good schema design improves performance, reduces unnecessary data duplication, and simplifies application development.

## Understanding Schema Design

### What is a Schema?

A **schema** defines how data is organized inside a database. In MongoDB, the schema describes:

- Fields in a document

- Data types

- Relationships

- Document structure

Unlike relational databases, MongoDB does not require every document in a collection to have the same fields. Example:

```

{
"name": "Anum",
"age": 20
}

```

Another document in the same collection:

```

{
"name": "Saba",
"city": "Karachi",
"email": "saba@email.com"
}

```

Both documents are valid because MongoDB supports a **flexible schema**.

### What is Data Modeling?

**Data Modeling** is the process of organizing data according to how the application will use it. Instead of asking, "What tables do we need?" , MongoDB encourages us to ask:

- What information is stored together?

- Which data is accessed most often?

- Which relationships exist?

- Should related data be embedded or referenced?

A well-designed model improves performance and simplifies queries.

### Goals of Good Schema Design

A good schema should:

- Improve query performance.

- Reduce unnecessary duplication.

- Support application growth.

- Be easy to understand.

- Match the application\'s access patterns.

## Embedding and Referencing

MongoDB mainly uses two approaches to model relationships:

- **Embedding**

- **Referencing**

### Embedding (Embedded Documents)

Embedding stores related data inside a single document. Example:

```

{
"name": "Anum",
"department": "Artificial Intelligence",
"address": {
"city": "Sukkur",
"country": "Pakistan"
}
}

```

The address is stored inside the student document.

### Advantages

- Faster queries.

- Fewer database operations.

- Simple document structure.

- Ideal for one-to-one relationships.

### Disadvantages

- Documents become larger.

- Updating repeated embedded data can be difficult.

### Embedding Arrays

Example:

```

{
"name": "Hamza",
"skills": [
"Python",
"MongoDB",
"SQL"
]
}

```

Arrays are useful for storing multiple related values.

### Referencing

Referencing stores related data in separate collections and links them using an identifier. Students collection:

```

{
"_id": 1,
"name": "Anum",
"departmentId": 101
}

```

Departments collection:

```

{
"_id": 101,
"department": "Artificial Intelligence"
}

```

The student references the department through `departmentId`.

### Advantages of Referencing

- Avoids data duplication.

- Easier to update shared information.

- Better for many-to-many relationships.

- Keeps documents smaller.

### Disadvantages

- Requires multiple queries or aggregation (`$lookup`) to combine related data.

- Slightly slower than embedding for some operations.

## Relationship Modeling

### One-to-One Relationship

One document relates to exactly one other document. Example: Student and Passport. Embedded model:

```

{
"name": "Anum",
"passport": {
"passportNumber": "AB123456"
}
}

```

Embedding is usually the preferred approach.

### One-to-Many Relationship

One document is related to many others. Example: Teacher and Courses. Embedded approach:

```

{
"teacher": "Hamza",
"courses": [
"Database",
"Operating Systems",
"Networks"
]
}

```

This works well when the number of related items is relatively small.

### Many-to-Many Relationship

Students can enroll in many courses, and each course can have many students. Students:

```

{
"_id": 1,
"name": "Anum"
}

```

Courses:

```

{
"_id": 201,
"course": "MongoDB"
}

```

Enrollments:

```

{
"studentId": 1,
"courseId": 201
}

```

Referencing is generally preferred for many-to-many relationships.

## Designing Efficient Schemas

### Store Related Data Together

Frequently accessed information should often be stored in the same document. Example:

```

{
"name": "Saba",
"phone": "03001234567",
"email": "saba@email.com"
}

```

Since contact information is usually retrieved with the student record, embedding it is efficient.

### Avoid Excessive Nesting

Bad example:

```

{
"student": {
"personal": {
"address": {
"city": {
"name": "Sukkur"
}
}
}
}
}

```

Too many nested levels make queries more complicated.

### Keep Documents Reasonably Sized

MongoDB has a maximum document size of **16 MB**. Very large documents can reduce performance and become difficult to manage.

### Use Meaningful Field Names

Good:

```

{
"studentName": "Anum"
}

```

Poor:

```

{
"x": "Anum"
}

```

Clear names improve readability and maintenance.

## Schema Validation

MongoDB allows developers to enforce rules using **schema validation**. Example:

```

db.createCollection("Students", {
validator: {
$jsonSchema: {
bsonType: "object",
required: ["name", "age"],
properties: {
name: {
bsonType: "string"
},
age: {
bsonType: "int"
}
}
}
}
})

```

This ensures:

- `name` must be a string.

- `age` must be an integer.

- Both fields are required.

Schema validation helps maintain consistent and reliable data.

## Choosing Between Embedding and Referencing

| Situation | Recommended Approach |
|---|---|
| One-to-One | Embedding |
| One-to-Few | Embedding |
| One-to-Many (small list) | Embedding |
| One-to-Many (large list) | Referencing |
| Many-to-Many | Referencing |
| Frequently Updated Shared Data | Referencing |
| Frequently Read Together | Embedding |

## Advantages and Limitations

### Advantages of Good Schema Design

### 1. Faster Queries

Well-organized documents reduce unnecessary database operations.

### 2. Better Performance

Proper modeling minimizes expensive joins and improves response times.

### 3. Easier Maintenance

A clear schema simplifies development and debugging.

### 4. Improved Scalability

Efficient models support growing datasets and higher user loads.

### 5. Flexible Development

MongoDB allows schemas to evolve as application requirements change.

### Limitations

- Poor design can lead to duplicated or inconsistent data.

- Excessive embedding may create oversized documents.

- Too many references can increase query complexity.

- Changing the schema later may require migrating existing documents.

## Real-World Applications

### University Management

- Students

- Teachers

- Courses

- Enrollments

### E-commerce

- Customers

- Orders

- Products

- Reviews

### Healthcare

- Patients

- Doctors

- Medical Records

- Prescriptions

### Banking

- Customers

- Accounts

- Transactions

- Loans

### Social Media

- Users

- Posts

- Comments

- Friend Connections

## Best Practices

- Design the schema based on how the application accesses data, not just how it is stored.

- Use embedding when related data is usually retrieved together.

- Use referencing for complex or many-to-many relationships.

- Avoid unnecessary duplication of frequently updated information.

- Keep documents well below the 16 MB size limit.

- Use meaningful field names and maintain consistent naming conventions.

- Apply schema validation to enforce required fields and correct data types.

- Test schema performance with realistic data before deploying the application.

- Review and refine the schema as application requirements evolve.

### Conclusion

Schema design and data modeling are critical to building efficient MongoDB applications. Although MongoDB offers a flexible schema, careful planning is essential to ensure high performance, maintainability, and scalability. By understanding when to use **embedding** and **referencing**, modeling relationships appropriately, organizing documents effectively, and applying schema validation, we can create databases that support real-world applications with speed and reliability. A well-designed schema not only simplifies development but also enables MongoDB to deliver excellent performance across domains such as education, healthcare, banking, e-commerce, and social media.');

-- Lecture 6: Relationships (Embedding vs Referencing)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Relationships (Embedding vs Referencing)', 6, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Relationships (Embedding vs Referencing)

## Introduction to Relationships in MongoDB

In every database, information is connected. A student belongs to a department, a customer places orders, a doctor treats patients, and users create posts on social media. These connections between data are called **relationships**. Unlike relational databases, which use **foreign keys** and **joins** to connect tables, MongoDB offers two main ways to represent relationships:

- **Embedding**

- **Referencing**

Choosing the correct relationship model is one of the most important decisions when designing a MongoDB database. A poor choice can slow down an application and make data difficult to maintain, while a good choice improves performance and simplifies development. Imagine a family photo album. One approach is to keep every family member\'s information on the same page as the family photo. This is like **embedding**. Another approach is to keep separate albums for each family member and simply write page references. This is like **referencing**. Both methods work, but the best choice depends on how the information will be used.

## Understanding Relationships

### What is a Relationship?

A **relationship** is a connection between two or more pieces of data. Examples:

- A student belongs to one department.

- A customer places many orders.

- A teacher teaches multiple courses.

- A user writes many posts.

MongoDB models these relationships using embedded documents or references instead of foreign keys.

### Types of Relationships

MongoDB commonly handles three types of relationships:

### 1. One-to-One (1:1)

One document is related to only one other document. Example:

- Student → Passport

- Employee → ID Card

### 2. One-to-Many (1:N)

One document is related to multiple documents. Example:

- Teacher → Courses

- Customer → Orders

- Department → Students

### 3. Many-to-Many (M:N)

Many documents relate to many other documents. Example:

- Students ↔ Courses

- Doctors ↔ Patients

- Authors ↔ Books

## Embedding

### What is Embedding?

**Embedding** means storing related data inside the same document. Instead of placing data in multiple collections, all related information is stored together.

### Example

```

{
"name": "Anum",
"department": "Artificial Intelligence",
"address": {
"city": "Sukkur",
"country": "Pakistan"
}
}

```

The address is embedded inside the student document.

### Embedding Arrays

MongoDB also allows arrays to be embedded. Example:

```

{
"name": "Hamza",
"skills": [
"Python",
"MongoDB",
"SQL"
]
}

```

The `skills` array is stored directly inside the document.

### Advantages of Embedding

### 1. Faster Reads

All related information is retrieved with a single query.

### 2. Fewer Database Operations

No need to combine data from multiple collections.

### 3. Simpler Queries

Applications retrieve complete information quickly.

### 4. Better Performance

Embedding reduces the need for additional lookups.

### Disadvantages of Embedding

- Documents can become very large.

- Updating duplicated embedded information may require multiple changes.

- Not suitable for data shared across many documents.

## Referencing

### What is Referencing?

**Referencing** stores related information in separate collections and links them using an identifier. Instead of storing complete information repeatedly, one document stores the ID of another.

### Example

### Students Collection

```

{
"_id": 1,
"name": "Anum",
"departmentId": 101
}

```

### Departments Collection

```

{
"_id": 101,
"departmentName": "Artificial Intelligence"
}

```

The student document references the department using `departmentId`.

### Using

`$lookup` MongoDB combines referenced documents using the `$lookup` aggregation stage. Example:

```

db.Students.aggregate([
{
$lookup:{
from:"Departments",
localField:"departmentId",
foreignField:"_id",
as:"Department"
}
}
])

```

This retrieves department information together with each student.

### Advantages of Referencing

### 1. Reduces Data Duplication

Shared information is stored only once.

### 2. Easier Updates

Updating the department name automatically benefits all related students.

### 3. Smaller Documents

Documents remain compact and manageable.

### 4. Suitable for Large Relationships

Works well when many documents share the same information.

### Disadvantages of Referencing

- Requires multiple queries or `$lookup`.

- Slightly slower than embedding for read operations.

- More complex queries.

## Embedding vs Referencing Comparison

| Feature | Embedding | Referencing |
|---|---|---|
| Data Storage | Same document | Separate collections |
| Query Speed | Faster | Slightly slower |
| Data Duplication | Higher | Lower |
| Document Size | Larger | Smaller |
| Updates | More difficult if duplicated | Easier |
| Complexity | Simple | More complex |
| Best For | Closely related data | Shared or large datasets |

### Example: Embedding

```

{
"name": "Anum",
"department": {
"departmentName": "Artificial Intelligence"
}
}

```

Everything is stored together.

### Example: Referencing

Student:

```

{
"name": "Anum",
"departmentId": 101
}

```

Department:

```

{
"_id": 101,
"departmentName": "Artificial Intelligence"
}

```

The department information is stored separately.

## Choosing Between Embedding and Referencing

### Use Embedding When

- Related data is always accessed together.

- Relationships are one-to-one or one-to-few.

- Data changes infrequently.

- Documents remain reasonably small.

### Examples

- Student and address

- Product and specifications

- User profile and preferences

### Use Referencing When

- Shared information is used by many documents.

- Relationships are many-to-many.

- Data changes frequently.

- Documents could become too large.

### Examples

- Students and courses

- Customers and orders

- Employees and departments

### Decision Table

| Situation | Recommended Method |
|---|---|
| Student Address | Embedding |
| Customer Orders (few) | Embedding |
| Customer Orders (thousands) | Referencing |
| Student and Department | Referencing |
| User Profile | Embedding |
| Student and Courses | Referencing |

## Real-World Examples

### Embedding

```

{
"studentName": "Anum",
"address": {
"city": "Sukkur"
}
}

```

### Referencing

Students:

```

{
"name": "Hamza",
"departmentId": 1
}

```

Departments:

```

{
"_id": 1,
"departmentName": "Computer Science"
}

```

### E-commerce

### Embedding

- Product specifications

- Product dimensions

- Product images

### Referencing

- Customers

- Orders

- Products

- Payments

### Social Media

### Embedding

- User settings

- Profile information

### Referencing

- Friends

- Followers

- Posts

- Comments

### Healthcare

### Embedding

- Patient address

- Emergency contacts

### Referencing

- Doctors

- Appointments

- Medical records

## Advantages and Limitations

### Advantages of Proper Relationship Design

Queries become faster when relationships are modeled correctly.

### 2. Reduced Storage Costs

Proper referencing avoids unnecessary duplication.

### 3. Easier Maintenance

A well-designed database is simpler to update and manage.

### 4. Improved Scalability

The database can grow efficiently as data increases.

### 5. Flexible Design

MongoDB supports both embedding and referencing, allowing developers to choose the best approach for each scenario.

### Limitations

- Choosing the wrong relationship model can reduce performance.

- Excessive embedding may produce oversized documents.

- Excessive referencing may increase query complexity.

- Database redesign can be time-consuming if requirements change significantly.

## Best Practices

- Use **embedding** for data that is frequently read together.

- Use **referencing** for shared or frequently updated data.

- Avoid embedding documents that may grow without limit.

- Keep document sizes well below MongoDB\'s **16 MB** limit.

- Use `$lookup` only when necessary, as it can increase query complexity.

- Design relationships based on application access patterns rather than trying to copy relational database structures.

- Test both approaches with realistic workloads before making final design decisions.

- Review and refine the data model as application requirements evolve.

### Conclusion

Relationships are a fundamental part of database design, and MongoDB provides two primary approaches for modeling them: **Embedding** and **Referencing**. Embedding stores related data within the same document, providing fast read performance and simpler queries, while Referencing stores related data in separate collections, reducing duplication and making shared information easier to maintain. The choice between these approaches depends on factors such as relationship type, data size, update frequency, and application access patterns. By understanding the strengths and limitations of both methods and applying them appropriately, we can design efficient, scalable, and maintainable MongoDB databases for applications in education, healthcare, banking, e-commerce, social media, and many other domains.');

-- Lecture 7: Indexing in MongoDB
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Indexing in MongoDB', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Indexing in MongoDB

## Introduction to Indexing

As a MongoDB database grows, the number of documents stored in collections can increase from hundreds to millions. Searching through every document one by one becomes slow and inefficient. To solve this problem, MongoDB uses **Indexes**. An **index** is a special data structure that helps MongoDB locate documents quickly without scanning the entire collection. Instead of checking every document, MongoDB uses the index to jump directly to the required data. Think of a textbook with 800 pages. If you want to find the topic **"Database"**, you could read every page from beginning to end, or you could use the **index** at the back of the book. The index immediately tells you the page numbers where the topic appears. MongoDB indexes work in the same way, making searches much faster. Indexing is one of the most important techniques for improving database performance and is widely used in modern applications such as e-commerce websites, banking systems, healthcare platforms, and social media.

## Understanding Indexes

### What is an Index?

An **Index** is a data structure that stores the values of one or more fields in sorted order along with references to the corresponding documents. When a query searches an indexed field, MongoDB can quickly locate the required documents instead of performing a full collection scan. Without an index:

```

Query
│
▼
Check Document 1
Check Document 2
Check Document 3
...
Check Document 1,000,000

```

With an index:

```

Query
│
▼
Index
│
▼
Required Document

```

This significantly reduces search time.

### How Indexes Work

Suppose we have the following documents:

```

{
"name": "Anum",
"age": 20
}
{
"name": "Hamza",
"age": 22
}
{
"name": "Saba",
"age": 21
}

```

If an index exists on the **name** field, MongoDB creates a sorted lookup structure similar to:

```

Anum → Document 1
Hamza → Document 2
Saba → Document 3

```

When we search for **Hamza**, MongoDB consults the index instead of reading every document.

### Default Index

Every MongoDB collection automatically includes an index on the `_id` field. Example:

```

{
"_id": ObjectId("66b2d7c4f9d5a123456789ab"),
"name": "Anum"
}

```

The `_id` index:

- Is created automatically.

- Cannot be removed.

- Ensures every document has a unique identifier.

## Creating and Managing Indexes

### Create a Single Field Index

Create an index on the **name** field:

```

db.Students.createIndex({
name: 1
})

```

`1` means **ascending order**.

### Descending Index

```

db.Students.createIndex({
age: -1
})

```

`-1` means **descending order**.

### View Existing Indexes

`db.Students.getIndexes()` MongoDB displays all indexes for the collection. Example output:

```

_id_
name_1
age_-1

```

### Drop an Index

Delete an index:

```

db.Students.dropIndex("name_1")

```

### Drop All Indexes

`db.Students.dropIndexes()` The default `_id` index remains because it cannot be removed.

## Types of Indexes in MongoDB

MongoDB provides several types of indexes for different use cases.

### 1. Single Field Index

Indexes only one field. Example:

```

db.Students.createIndex({
age: 1
})

```

Best for searching by a single attribute.

### 2. Compound Index

Indexes multiple fields together. Example:

```

db.Students.createIndex({
department: 1,
semester: 1
})

```

Useful for queries that filter by both **department** and **semester**.

### 3. Unique Index

Ensures duplicate values are not allowed. Example:

```

db.Users.createIndex(
{
email: 1
},
{
unique: true
}
)

```

If another user tries to register with the same email address, MongoDB rejects the insertion.

### 4. Text Index

Supports full-text searching. Example:

```

db.Articles.createIndex({
title: "text"
})

```

Search example:

```

db.Articles.find({
$text: {
}
})

```

### 5. Multikey Index

Automatically created when indexing an array field. Example document:

```

{
"skills": [
"Python",
"MongoDB",
"SQL"
]
}

```

Create index:

```

db.Students.createIndex({
skills: 1
})

```

MongoDB indexes each element in the array.

### 6. Hashed Index

Stores hashed values instead of actual values. Example:

```

db.Users.createIndex({
userId: "hashed"
})

```

Hashed indexes are commonly used for sharding.

## Query Performance with Indexes

### Without an Index

```

db.Students.find({
name: "Anum"
})

```

MongoDB scans every document. This is called a **Collection Scan (COLLSCAN)**.

### With an Index

The same query:

```

db.Students.find({
name: "Anum"
})

```

MongoDB uses the index. This is called an **Index Scan (IXSCAN)**. Searching becomes much faster.

### Checking Query Performance

Use:

```

db.Students.find({
name: "Anum"
}).explain("executionStats")

```

Important output:

- `COLLSCAN` → Full collection scan.

- `IXSCAN` → Index scan.

- `executionTimeMillis` → Time taken.

- `totalDocsExamined` → Documents checked.

## Advantages and Disadvantages of Indexing

### Advantages

### 1. Faster Searches

Queries execute much more quickly.

### 2. Improved Sorting

Indexes speed up `sort()` operations. Example:

```

db.Students.find().sort({
age: 1
})

```

### 3. Better Query Performance

Filtering millions of documents becomes efficient.

### 4. Faster Data Retrieval

Applications respond more quickly to user requests.

### 5. Supports Unique Values

Unique indexes prevent duplicate records.

### Disadvantages

### 1. Increased Storage

Indexes require additional disk space.

### 2. Slower Inserts

Every insert must update the indexes.

### 3. Slower Updates

Updating indexed fields also updates the index structure.

### 4. Slower Deletes

Deleting documents requires removing index entries.

### 5. Too Many Indexes Reduce Performance

Creating unnecessary indexes increases storage usage and slows write operations.

## Best Practices for Indexing

### Index Frequently Searched Fields

Example:

- Email

- Username

- Student ID

- Product ID

### Avoid Indexing Every Field

Only index fields commonly used in:

- `find()`

- `sort()`

- `update()`

- `delete()`

### Use Compound Indexes Carefully

Create compound indexes only when queries frequently use the same combination of fields. Example:

```

{
department: 1,
semester: 1
}

```

### Monitor Index Usage

Check performance using: `.explain("executionStats")` Remove indexes that are never used.

### Use Unique Indexes for Important Fields

Fields such as:

- Email

- CNIC

- Employee ID

- Roll Number

should generally have unique indexes to prevent duplicate values.

## Real-World Applications

### University Management System

- Search students by roll number.

- Find courses by course code.

### E-commerce

- Search products by name.

- Filter products by category.

- Sort products by price.

### Banking

- Search customers by account number.

- Find transactions quickly.

### Healthcare

- Search patients by patient ID.

- Retrieve medical records efficiently.

### Social Media

- Find users by username.

- Search posts by keywords.

- Retrieve messages quickly.

## Summary of Common Index Types

| Index Type | Purpose | Example |
|---|---|---|
| Single Field | Index one field | {name:1} |
| Compound | Index multiple fields | {department:1, semester:1} |
| Unique | Prevent duplicate values | {email:1} |
| Text | Full-text search | {title:"text"} |
| Multikey | Index array elements | {skills:1} |
| Hashed | Store hashed values | {userId:"hashed"} |

### Best Practices

- Create indexes only on fields that are frequently searched or sorted.

- Keep the number of indexes reasonable to avoid slowing down write operations.

- Use unique indexes for fields that must contain distinct values.

- Analyze query performance using `.explain("executionStats")`.

- Remove unused indexes to save storage and improve performance.

- Design compound indexes based on common query patterns.

- Remember that every collection automatically has an `_id` index.

### Conclusion

Indexes are one of MongoDB\'s most powerful performance optimization features. By storing indexed field values in an organized structure, MongoDB can locate documents quickly without scanning the entire collection. Different index types, including **Single Field, Compound, Unique, Text, Multikey, and Hashed Indexes**, address different application needs. While indexes significantly improve search and sorting performance, they also consume additional storage and slightly slow insert, update, and delete operations. Therefore, indexes should be created thoughtfully and monitored regularly. Mastering indexing enables developers to build fast, scalable, and efficient MongoDB applications capable of handling large volumes of data across domains such as education, healthcare, banking, e-commerce, and social media.');

-- Lecture 8: Aggregation Framework in MongoDB
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Aggregation Framework in MongoDB', 8, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Aggregation Framework in MongoDB

## Introduction to the Aggregation Framework

Modern applications generate enormous amounts of data every day. Simply storing data is not enough; we also need to analyze it to answer important questions. For example:

- How many students are enrolled in each department?

- What is the average salary of employees?

- Which product has the highest sales?

- How many orders were placed this month?

MongoDB provides the **Aggregation Framework** to process and analyze data efficiently. It allows us to perform calculations, group documents, filter records, sort results, transform data, and generate reports. Think of raw data as a basket of mixed fruits. The Aggregation Framework acts like a machine that sorts, counts, groups, and organizes the fruits according to our needs. Instead of looking at every fruit individually, we receive meaningful summaries and insights. The Aggregation Framework is one of MongoDB\'s most powerful features and is widely used for reporting, business intelligence, dashboards, analytics, and data processing.

## Understanding Aggregation

### What is Aggregation?

**Aggregation** is the process of collecting, transforming, and summarizing data from one or more documents to produce meaningful results. Instead of returning every document, aggregation performs calculations such as:

- Counting documents

- Finding averages

- Calculating totals

- Finding minimum and maximum values

- Grouping similar records

- Filtering and sorting data

### Aggregation Pipeline

MongoDB processes data through an **Aggregation Pipeline**. Each stage performs a specific task and passes its output to the next stage.

```

Documents
│
▼
$match
│
▼
$group
│
▼
$sort
│
▼
Final Result

```

Each stage acts like a filter in an assembly line, gradually shaping the final output.

### Basic Aggregation Syntax

```

db.collection.aggregate([
{ Stage1 },
{ Stage2 },
{ Stage3 }
])

```

Example:

```

db.Students.aggregate([
{
$match: {
age: { $gte: 20 }
}
}
])

```

## Common Aggregation Pipeline Stages

### 1. Stage

`$match` The `$match` stage filters documents before processing them. Example:

```

db.Students.aggregate([
{
$match: {
department: "Artificial Intelligence"
}
}
])

```

Only students from the Artificial Intelligence department are processed.

### 2. Stage

`$project` The `$project` stage selects which fields should appear in the output. Example:

```

db.Students.aggregate([
{
$project: {
name: 1,
age: 1,
_id: 0
}
}
])

```

Output includes only the **name** and **age** fields.

### 3. Stage

`$sort` Sorts documents. Ascending order:

```

db.Students.aggregate([
{
$sort: {
age: 1
}
}
])

```

Descending order:

```

db.Students.aggregate([
{
$sort: {
age: -1
}
}
])

```

### 4. Stage

`$limit` Returns only a specified number of documents.

```

db.Students.aggregate([
{
$limit: 5
}
])

```

Only five documents are returned.

### 5. Stage

`$skip` Skips a specified number of documents.

```

db.Students.aggregate([
{
$skip: 10
}
])

```

The first ten documents are ignored.

## Grouping and Calculation Operators

### The Stage

`$group` The `$group` stage groups documents based on a common field and performs calculations. Example:

```

db.Students.aggregate([
{
$group: {
_id: "$department"
}
}
])

```

Documents are grouped by department.

### Count Documents

Count students in each department.

```

db.Students.aggregate([
{
$group: {
_id: "$department",
totalStudents: {
$sum: 1
}
}
}
])

```

Example output:

```

AI 25
Computer Science 18
Software Engineering 20

```

### Calculate Average

```

db.Students.aggregate([
{
$group: {
_id: "$department",
averageAge: {
$avg: "$age"
}
}
}
])

```

### Find Maximum Value

```

db.Students.aggregate([
{
$group: {
_id: null,
highestAge: {
$max: "$age"
}
}
}
])

```

### Find Minimum Value

```

db.Students.aggregate([
{
$group: {
_id: null,
lowestAge: {
$min: "$age"
}
}
}
])

```

### Calculate Total

```

db.Sales.aggregate([
{
$group: {
_id: null,
totalSales: {
$sum: "$amount"
}
}
}
])

```

## Combining Multiple Pipeline Stages

Suppose we want to: 1. Find AI students. 2. Group them by semester. 3. Count students. 4. Sort the result.

```

db.Students.aggregate([
{
$match:{
department:"Artificial Intelligence"
}
},
{
$group:{
_id:"$semester",
totalStudents:{
$sum:1
}
}
},
{
$sort:{
totalStudents:-1
}
}
])

```

Each stage processes the output from the previous stage.

### Using

`$count` The `$count` stage counts the number of documents.

```

db.Students.aggregate([
{
$count:"TotalStudents"
}
])

```

Example output: `TotalStudents : 120`

### Using

`$unwind` Suppose documents contain:

```

{
"name": "Anum",
"skills": [
"Python",
"MongoDB",
"SQL"
]
}

```

Using:

```

db.Students.aggregate([
{
$unwind:"$skills"
}
])

```

Produces separate documents for each skill.

## Aggregation Expressions

MongoDB provides built-in expressions for calculations. `$sum` Adds values.

```

{
$sum:"$salary"
}
$avg

```

Calculates the average.

```

{
$avg:"$marks"
}
$max

```

Finds the largest value.

```

{
$max:"$salary"
}
$min

```

Finds the smallest value.

```

{
$min:"$salary"
}
$first

```

Returns the first value in each group.

```

{
$first:"$name"
}
$last

```

Returns the last value in each group.

```

{
$last:"$name"
}

```

## Advantages and Limitations

### Advantages

### 1. Powerful Data Analysis

Perform complex calculations directly within MongoDB.

### 2. High Performance

Processes data efficiently without exporting it to another application.

### 3. Flexible Pipelines

Multiple stages can be combined to solve complex problems.

### 4. Easy Reporting

Generate summaries for dashboards and reports.

### 5. Reduces Application Logic

Many calculations can be handled by the database instead of the application.

### Limitations

- Complex pipelines can be difficult to read and maintain.

- Poorly designed pipelines may reduce performance.

- Aggregations on large datasets may require sufficient memory and proper indexing.

- Beginners may find pipeline stages challenging initially.

## Real-World Applications

### University Management

- Count students in each department.

- Calculate average CGPA.

- Generate attendance reports.

### E-commerce

- Calculate total sales.

- Find best-selling products.

- Analyze customer purchases.

### Banking

- Calculate monthly transactions.

- Summarize account balances.

- Generate financial reports.

### Healthcare

- Count patients by department.

- Calculate average treatment costs.

- Analyze appointment statistics.

### Social Media

- Count posts per user.

- Analyze hashtags.

- Generate engagement reports.

## Summary of Common Aggregation Stages

| Stage | Purpose |
|---|---|
| $match | Filter documents |
| $project | Select or reshape fields |
| $group | Group documents and calculate values |
| $sort | Sort documents |
| $limit | Restrict the number of results |
| $skip | Skip documents |
| $count | Count documents |
| $unwind | Split array elements into separate documents |

### Best Practices

- Use `$match` early in the pipeline to reduce the number of documents processed.

- Create indexes on fields frequently used in `$match` and `$sort`.

- Keep pipelines simple and well-organized for easier maintenance.

- Use `$project` to return only the required fields.

- Avoid unnecessary pipeline stages that increase processing time.

- Test aggregation queries on sample data before running them on large collections.

- Monitor query performance using the `explain()` method.

- Use aggregation for reporting and analytics instead of performing calculations entirely in application code.

### Conclusion

The MongoDB Aggregation Framework is a powerful tool for transforming raw data into meaningful information. By using pipeline stages such as `$match`, `$project`, `$group`, `$sort`, `$limit`, `$skip`, `$count`, and `$unwind`, we can filter, organize, summarize, and analyze large collections of documents efficiently. Built-in expressions like `$sum`, `$avg`, `$max`, and `$min` make it easy to generate reports and perform statistical calculations directly within the database. Mastering the Aggregation Framework enables developers to build scalable, high-performance applications capable of delivering valuable insights across industries such as education, healthcare, banking, e-commerce, and social media.');

-- Lecture 9: Transactions in MongoDB
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Transactions in MongoDB', 9, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Transactions in MongoDB

## Introduction to Transactions in MongoDB

In many real-world applications, a single operation often involves multiple database actions. For example, when transferring money from one bank account to another, the system must deduct money from one account and add it to another. If only one of these actions succeeds, the data becomes inconsistent. To solve this problem, MongoDB provides **Transactions**. A transaction groups multiple database operations into a single unit of work. Either **all operations succeed**, or **none of them are applied**. Imagine buying a product online. The system must reduce the product stock, create an order, and process the payment. If the payment fails, the stock should not decrease and the order should not be created. Transactions ensure that these related operations either all happen together or not at all. Transactions are essential in applications such as banking, e-commerce, healthcare, and reservation systems, where maintaining data accuracy is critical.

## Understanding Transactions

### What is a Transaction?

A **transaction** is a sequence of one or more database operations that are executed as a single logical unit. If every operation completes successfully, the transaction is **committed**. If any operation fails, the transaction is **rolled back**, returning the database to its previous state.

### Why Are Transactions Needed?

Without transactions: `Withdraw Money` ✔ `Deposit Money` ✖ Money disappears because only one operation succeeded. With transactions: `Withdraw Money` ✔ `Deposit Money` ✔ `OR Withdraw Money` ✖ `Deposit Money` ✖ The database always remains consistent.

### Example Scenario

Suppose:

- Anum has **Rs. 10,000**

- Hamza has **Rs. 5,000**

Transfer **Rs. 2,000**. Before transaction:

```

Anum = 10000
Hamza = 5000

```

After successful transaction:

```

Anum = 8000
Hamza = 7000

```

If the deposit fails, MongoDB cancels the withdrawal as well.

## ACID Properties

MongoDB transactions follow the **ACID** principles.

### 1. Atomicity

A transaction is treated as a single unit. Either:

- Everything succeeds.

- Everything fails.

### 2. Consistency

Transactions always move the database from one valid state to another. No invalid or incomplete data is stored.

### 3. Isolation

Multiple transactions can execute simultaneously without interfering with one another. Each transaction behaves as if it is running alone.

### 4. Durability

Once a transaction is committed, its changes are permanently stored, even if the server crashes afterward.

### Summary of ACID

| Property | Meaning |
|---|---|
| Atomicity | All operations succeed or all fail |
| Consistency | Database remains valid |
| Isolation | Transactions do not interfere with each other |
| Durability | Committed data is permanently stored |

## Working with Transactions

### Starting a Session

Transactions begin by creating a session.

```

const session = await mongoose.startSession();

```

### Starting a Transaction

```

session.startTransaction();

```

All subsequent database operations belong to this transaction.

### Example Transaction

```

const session = await mongoose.startSession();
try{
session.startTransaction();
await Account.updateOne(
{ name:"Anum" },
{ $inc:{ balance:-2000 } },
{ session }
);
await Account.updateOne(
{ name:"Hamza" },
{ $inc:{ balance:2000 } },
{ session }
);
await session.commitTransaction();
}
catch(error){
await session.abortTransaction();
}
finally{
session.endSession();
}

```

This transaction transfers money safely between two accounts.

### Committing a Transaction

```

await session.commitTransaction();

```

All changes become permanent.

### Aborting a Transaction

```

await session.abortTransaction();

```

All changes are cancelled.

### Ending the Session

```

session.endSession();

```

The session is closed after the transaction completes.

## Transaction Workflow

The basic workflow of a MongoDB transaction is:

```

Start Session
│
▼
Start Transaction
│
▼
Execute Operations
│
▼
Success?
┌───────────────┐
│ │
Yes No
│ │
▼ ▼
Commit Abort
│ │
└──────┬────────┘
▼

```

This process ensures that all related operations are completed safely.

## Transactions with Multiple Collections

Transactions can update multiple collections simultaneously. Example:

```

await Orders.insertOne(
{
customer:"Anum",
total:5000
},
{ session }
);
await Inventory.updateOne(
{
product:"Laptop"
},
{
$inc:{ quantity:-1 }
},
{ session }
);

```

If one operation fails, both changes are rolled back.

### Transactions with Mongoose

Example:

```

const session = await mongoose.startSession();
await session.withTransaction(async()=>{
await Student.create([
{
name:"Saba",
age:21
}
],{ session });
});

```

The `withTransaction()` method simplifies transaction handling by automatically committing successful transactions or aborting them if an error occurs.

## Advantages and Limitations

### Advantages

### 1. Data Consistency

Ensures related operations complete together.

### 2. Error Recovery

Failed transactions automatically roll back.

### 3. Supports Multiple Collections

Changes across multiple collections remain synchronized.

### 4. Reliable Financial Operations

Ideal for banking and payment systems.

### 5. ACID Compliance

Provides Atomicity, Consistency, Isolation, and Durability.

### Limitations

- Transactions introduce additional processing overhead.

- Long-running transactions may reduce database performance.

- Transactions should be kept as short as possible.

- Complex transactions consume more memory and system resources.

- Poor transaction design can increase contention and reduce throughput.

## Real-World Applications

### Banking

- Money transfers

- Loan processing

- Account updates

### E-commerce

- Order creation

- Payment processing

- Inventory updates

### Healthcare

- Patient admission

- Appointment booking

- Medical billing

### University Management

- Student enrollment

- Fee payment

- Course registration

### Travel Reservation Systems

- Flight booking

- Hotel reservations

- Ticket cancellation

## Best Practices

- Keep transactions short to reduce locking time and improve performance.

- Include only operations that must succeed or fail together.

- Handle errors using `try...catch` blocks.

- Always call `commitTransaction()` after successful operations.

- Always call `abortTransaction()` if an error occurs.

- Close sessions using `endSession()` to release resources.

- Avoid unnecessary reads and writes inside transactions.

- Test transactions thoroughly to ensure rollback behavior works as expected.

## Common Transaction Methods

| Method | Purpose |
|---|---|
| startSession() | Create a session |
| startTransaction() | Begin a transaction |
| commitTransaction() | Save all changes permanently |
| abortTransaction() | Cancel all changes |
| endSession() | Close the session |

### Conclusion

Transactions in MongoDB provide a reliable way to execute multiple database operations as a single unit of work. By following the **ACID** principles, transactions ensure that either all operations succeed or all are rolled back, protecting the database from inconsistent states. Using sessions, transaction methods such as `startTransaction()`, `commitTransaction()`, `abortTransaction()`, and `withTransaction()`, developers can safely manage complex operations involving multiple documents or collections. Although transactions introduce some performance overhead, they are indispensable for applications that require strong data integrity, such as banking, healthcare, e-commerce, education, and reservation systems. Understanding MongoDB transactions is a key step toward building secure, scalable, and dependable database-driven applications.');

-- Lecture 10: Mongoose (ODM) Basics
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Mongoose (ODM) Basics', 10, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Mongoose (ODM) Basics

## Introduction to Mongoose (ODM)

When building a Node.js application with MongoDB, developers can interact with the database directly using the MongoDB Driver. However, writing database queries manually for every operation can become repetitive and difficult to manage as applications grow. To simplify database development, we use **Mongoose**, an **Object Data Modeling (ODM)** library for **MongoDB and Node.js**. Mongoose provides an organized way to define data structures, validate data, and perform database operations using JavaScript objects. Think of MongoDB as a large warehouse and Mongoose as a well-organized warehouse manager. The warehouse stores everything, but the manager ensures items are placed correctly, labeled properly, and easy to find. Likewise, Mongoose helps organize and manage data before it is stored in MongoDB. Mongoose is one of the most widely used libraries for MongoDB because it makes application development cleaner, safer, and easier to maintain.

## Understanding Mongoose and ODM

### What is Mongoose?

**Mongoose** is an **Object Data Modeling (ODM)** library that provides a higher-level interface for working with MongoDB in Node.js applications. It allows developers to:

- Connect to MongoDB.

- Define schemas.

- Create models.

- Validate data.

- Perform CRUD operations.

- Manage relationships between documents.

### What is ODM?

**ODM (Object Data Modeling)** is a technique that maps JavaScript objects to MongoDB documents. Instead of writing raw database commands, developers work with JavaScript objects. Without Mongoose:

```

db.collection.insertOne({
name: "Anum"
})

```

With Mongoose:

```

const student = new Student({
name: "Anum"
});
student.save();

```

The code becomes easier to read and maintain.

### Why Use Mongoose?

Mongoose provides many useful features:

- Schema definition

- Data validation

- Middleware (Hooks)

- Built-in CRUD methods

- Population of referenced documents

- Query helpers

- Cleaner application structure

## Installing and Connecting Mongoose

### Install Mongoose

Install using npm: `npm install mongoose` This installs the Mongoose package into the Node.js project.

### Import Mongoose

```

const mongoose = require("mongoose");

```

For ES Modules:

```

import mongoose from "mongoose";

```

### Connect to MongoDB

```

const mongoose = require("mongoose");
mongoose.connect("mongodb://127.0.0.1:27017/UniversityDB")
.then(() => {
console.log("Connected Successfully");
})
.catch((err) => {
console.log(err);
});

```

The `connect()` method establishes a connection between the application and MongoDB.

### Connection Flow

```

Node.js Application
│
▼
Mongoose
│
▼
MongoDB Server
│
▼
Database

```

Mongoose acts as a bridge between the application and the database.

## Schemas and Models

### What is a Schema?

A **Schema** defines the structure of documents in a collection. Example:

```

const mongoose = require("mongoose");
const studentSchema = new mongoose.Schema({
name: String,
age: Number,
department: String
});

```

This schema defines three fields:

- `name`

- `age`

- `department`

### Schema with Validation

```

const studentSchema = new mongoose.Schema({
name:{
type:String,
required:true
},
age:{
type:Number,
min:18
}
});

```

Validation ensures that only valid data is stored.

### What is a Model?

A **Model** is created from a schema and represents a MongoDB collection.

```

const Student = mongoose.model(
"Student",
studentSchema
);

```

The model allows us to interact with the **Students** collection.

### Relationship Between Schema and Model

```

Schema
│
▼
Model
│
▼
Collection
│
▼
Documents

```

## CRUD Operations Using Mongoose

### Create a Document

```

const student = new Student({
name:"Anum",
age:20,
department:"Artificial Intelligence"
});
student.save();

```

The `save()` method stores the document.

### Read Documents

Retrieve all documents:

```

Student.find()
.then(data => console.log(data));

```

Retrieve one document:

```

Student.findOne({
name:"Anum"
});

```

Retrieve by ID:

```

Student.findById(id);

```

### Update Documents

Update one document:

```

Student.updateOne(
{ name:"Anum" },
{
age:21
}
);

```

Find and update:

```

Student.findOneAndUpdate(
{ name:"Anum" },
{
age:22
}
);

```

### Delete Documents

Delete one document:

```

Student.deleteOne({
name:"Anum"
});

```

Delete many:

```

Student.deleteMany({
});

```

## Schema Validation

Mongoose automatically validates data before saving. Example:

```

const studentSchema = new mongoose.Schema({
name:{
type:String,
required:true
},
age:{
type:Number,
min:18,
max:40
}
});

```

Possible validation rules:

- `required`

- `min`

- `max`

- `default`

- `unique`

- `enum`

- `match`

### Default Values

```

status:{
type:String,
default:"Active"
}

```

If no value is provided, `"Active"` is stored automatically.

### Unique Values

```

email:{
type:String,
unique:true
}

```

Duplicate email addresses are not allowed.

## Advantages and Limitations

### Advantages

### 1. Easy Database Management

Schemas and models simplify database operations.

### 2. Automatic Validation

Invalid data is rejected before reaching MongoDB.

### 3. Cleaner Code

Applications become easier to read and maintain.

### 4. Object-Oriented Development

Developers work with JavaScript objects instead of raw database commands.

### 5. Built-in Features

Includes middleware, validation, virtuals, and population.

### Limitations

- Adds a small performance overhead compared to using the native MongoDB driver.

- Requires learning additional concepts such as schemas and models.

- Flexible MongoDB features may be restricted by strict schema definitions if not designed carefully.

- Not always necessary for very small or simple projects.

## Real-World Applications

### University Management System

- Student registration

- Faculty management

- Course records

### E-commerce

- Product management

- Customer accounts

- Order processing

### Healthcare

- Patient records

- Appointment scheduling

- Doctor information

### Banking

- Customer profiles

- Transactions

- Loan management

### Social Media

- User accounts

- Posts

- Comments

- Friend relationships

## Common Mongoose Methods

| Method | Purpose |
|---|---|
| mongoose.connect() | Connect to MongoDB |
| Schema() | Define document structure |
| model() | Create a model |
| save() | Insert a document |
| find() | Retrieve multiple documents |
| findOne() | Retrieve one document |
| findById() | Find a document by ID |
| updateOne() | Update one document |
| findOneAndUpdate() | Find and update a document |
| deleteOne() | Delete one document |
| deleteMany() | Delete multiple documents |

## Best Practices

- Define schemas before creating models.

- Use validation rules to maintain consistent and reliable data.

- Store database connection strings in environment variables instead of hardcoding them.

- Handle connection errors using `try...catch` or `.catch()`.

- Use asynchronous operations with `async/await` for cleaner code.

- Validate user input before saving data to the database.

- Organize schemas and models into separate files for better project structure.

- Close database connections properly when the application shuts down.

### Conclusion

Mongoose is a powerful **Object Data Modeling (ODM)** library that simplifies working with MongoDB in Node.js applications. By providing schemas, models, validation, and built-in CRUD methods, it enables developers to write cleaner, safer, and more maintainable code. Features such as automatic validation, object-oriented data handling, and easy database connectivity make Mongoose an excellent choice for modern web applications. Understanding the basics of Mongoose equips developers with the skills to build scalable and efficient applications for education, healthcare, banking, e-commerce, social media, and many other real-world domains.');

-- Lecture 11: Connecting MongoDB with an Application
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Connecting MongoDB with an Application', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Connecting MongoDB with an Application

## Introduction to Connecting MongoDB with an Application

A database is useful only when an application can communicate with it. Whether we build a student management system, an online shopping website, a banking application, or a social media platform, the application must be able to store, retrieve, update, and delete data from the database. MongoDB allows applications to communicate with the database using programming languages such as **JavaScript (Node.js)**, **Python**, **Java**, **C#**, and **PHP**. In the Node.js ecosystem, developers commonly use either the **MongoDB Node.js Driver** or **Mongoose (ODM)** to establish this connection. Think of the application as a customer placing an order in a restaurant and MongoDB as the kitchen preparing the food. The connection between them acts like the waiter, carrying requests to the kitchen and bringing the results back to the customer. Without this connection, the application cannot interact with the database. Establishing a secure and reliable connection is the first step in building any MongoDB-powered application.

## Understanding Database Connections

### What is a Database Connection?

A **database connection** is a communication link between an application and the MongoDB server. Through this connection, the application can:

- Insert new documents.

- Retrieve existing data.

- Update documents.

- Delete documents.

- Execute queries and aggregations.

### Application Architecture

```

User
│
▼
Frontend
(HTML/CSS/React)
│
▼
Backend
(Node.js/Express)
│
▼
MongoDB Driver / Mongoose
│
▼
MongoDB Database

```

The backend acts as the bridge between the frontend and the database.

### Connection String

MongoDB uses a **connection string** (also called a URI) to locate the database. Example for a local database:

```

mongodb://127.0.0.1:27017/UniversityDB

```

Components:

- `mongodb://` → Protocol

- 127.0.0.1 → Local server address

- `27017` → Default MongoDB port

- `UniversityDB` → Database name

## Connecting with the MongoDB Driver

### Install the MongoDB Driver

Use npm to install the official MongoDB Node.js Driver. `npm install mongodb`

### Import the Driver

```

const { MongoClient } = require("mongodb");

```

### Create a Connection

```

const { MongoClient } = require("mongodb");
const url = "mongodb://127.0.0.1:27017";
const client = new MongoClient(url);
async function connectDB(){
await client.connect();
console.log("Connected Successfully");
}
connectDB();

```

The `connect()` method establishes communication with the MongoDB server.

### Access a Database

```

const db = client.db("UniversityDB");

```

This selects the **UniversityDB** database.

### Access a Collection

```

const students = db.collection("Students");

```

The application can now perform CRUD operations on the **Students** collection.

## Connecting with Mongoose

### Install Mongoose

`npm install mongoose`

### Import Mongoose

```

const mongoose = require("mongoose");

```

### Connect to MongoDB

```

mongoose.connect("mongodb://127.0.0.1:27017/UniversityDB")
console.log("Database Connected");
})
.catch((err) => {
console.log(err);
});

```

Mongoose automatically manages the database connection.

### Connection Flow Using Mongoose

```

Application
│
▼
Mongoose
│
▼
MongoDB

```

Mongoose simplifies database interactions by providing schemas, models, and validation.

## Performing Database Operations

### Insert Data

Using the MongoDB Driver:

```

await students.insertOne({
name:"Anum",
age:20,
department:"Artificial Intelligence"
});

```

### Retrieve Data

```

const data = await students.find().toArray();
console.log(data);

```

### Update Data

```

await students.updateOne(
{ name:"Anum" },
{
$set:{
age:21
}
}
);

```

### Delete Data

```

await students.deleteOne({
name:"Anum"
});

```

These operations allow the application to manage database records efficiently.

## Error Handling and Connection Management

### Using Try-Catch

```

async function connectDB(){
try{
await client.connect();
console.log("Connected");
}
catch(error){
console.log(error);
}
}

```

Error handling prevents the application from crashing if the connection fails.

### Closing the Connection

```

await client.close();

```

Closing unused connections releases system resources.

### Using Environment Variables

Instead of hardcoding the connection string:

```

const url = process.env.MONGO_URI;

```

Store the URI in a `.env` file. Example:

```

MONGO_URI=mongodb://127.0.0.1:27017/UniversityDB

```

This improves security and makes configuration easier.

## Advantages and Limitations

### Advantages

### 1. Real-Time Database Access

Applications can interact with the database instantly.

### 2. Easy CRUD Operations

Developers can easily create, read, update, and delete data.

### 3. Flexible Integration

MongoDB supports many programming languages and frameworks. Applications can handle increasing amounts of data and users.

### 5. Secure Connections

Authentication and environment variables help protect database credentials.

### Limitations

- Poor connection management can lead to resource leaks.

- Network failures may interrupt database communication.

- Hardcoding connection strings creates security risks.

- Improper error handling can cause application crashes.

## Real-World Applications

### University Management System

- Student registration

- Course management

- Attendance records

### E-commerce

- Product catalog

- Customer accounts

- Shopping carts

- Orders

### Healthcare

- Patient records

- Doctor information

- Appointment scheduling

### Banking

- Customer accounts

- Transactions

- Loan processing

### Social Media

- User profiles

- Posts

- Comments

- Messages

## Best Practices

- Store database credentials in environment variables instead of hardcoding them.

- Use `async/await` for cleaner and more readable asynchronous code.

- Handle connection errors with `try...catch`.

- Reuse database connections instead of opening a new connection for every request.

- Close database connections properly when the application shuts down.

- Validate user input before performing database operations.

- Use Mongoose for projects that benefit from schemas, validation, and models.

- Monitor database connections to identify performance or connectivity issues.

## Common Methods for Database Connections

| Method | Purpose |
|---|---|
| MongoClient() | Create a MongoDB client |
| connect() | Connect to the MongoDB server |
| db() | Select a database |
| collection() | Access a collection |
| insertOne() | Insert one document |
| find() | Retrieve documents |
| updateOne() | Update one document |
| deleteOne() | Delete one document |
| close() | Close the database connection |
| mongoose.connect() | Connect using Mongoose |

### Conclusion

Connecting MongoDB with an application is a fundamental step in developing modern database-driven systems. By establishing a connection through the **MongoDB Node.js Driver** or **Mongoose**, applications can efficiently perform CRUD operations, execute queries, and manage data securely. Proper connection management, error handling, and the use of environment variables ensure that applications remain secure, reliable, and scalable. Mastering database connectivity enables developers to build robust applications for education, healthcare, banking, e-commerce, social media, and many other real-world domains.');

-- Lecture 12: Building a MongoDB-Backed Application
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a MongoDB-Backed Application', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a MongoDB-Backed Application

## Introduction to Building a MongoDB-Backed Application

A database alone cannot solve real-world problems. It becomes useful only when it is connected to an application that allows users to interact with the stored data. A **MongoDB-backed application** is an application that uses MongoDB as its database to store, retrieve, update, and manage information. Examples include:

- Student Management Systems

- E-commerce Websites

- Banking Applications

- Hospital Management Systems

- Social Media Platforms

In these applications, users interact with the frontend, the backend processes requests, and MongoDB stores the data permanently. Think of a restaurant. Customers place orders through a waiter, the kitchen prepares the food, and the pantry stores all the ingredients. Similarly, the **frontend** collects user input, the **backend** processes requests, and **MongoDB** stores the application\'s data. Building a MongoDB-backed application requires combining several technologies into one complete system.

## Architecture of a MongoDB-Backed Application

A typical MongoDB application follows a **three-tier architecture**.

```

User
│
▼
Frontend
(HTML, CSS, JavaScript, React)
│
▼
Backend
(Node.js, Express.js)
│
▼
Mongoose / MongoDB Driver
│
▼
MongoDB Database

```

### Frontend

The frontend provides the user interface where users can:

- Register

- Log in

- Submit forms

- View information

Common technologies:

- HTML

- CSS

- JavaScript

- React

- Vue

- Angular

### Backend

The backend handles:

- Business logic

- Authentication

- Validation

- Database communication

- API requests

Common technologies:

- Node.js

- Express.js

### Database

MongoDB stores:

- Users

- Products

- Orders

- Students

- Employees

- Reports

## Steps to Build a MongoDB-Backed Application

### Step 1: Install Required Software

Install:

- Node.js

- MongoDB Community Server

- MongoDB Compass

- Visual Studio Code

### Step 2: Create Project Folder

```

mkdir StudentApp
cd StudentApp

```

### Step 3: Initialize Node.js

`npm init -y` This creates the `package.json` file.

### Step 4: Install Required Packages

```

npm install express mongoose dotenv

```

Package purposes:

- **Express** → Web framework

- **Mongoose** → MongoDB ODM

- **dotenv** → Environment variable management

### Step 5: Create Project Structure

Example folder structure:

```

StudentApp/
│
├── models/
├── routes/
├── controllers/
├── config/
├── app.js
├── package.json

```

Organizing files improves readability and maintainability.

## Connecting MongoDB

### Environment Variables

Create a `.env` file.

```

MONGO_URI=mongodb://127.0.0.1:27017/UniversityDB
PORT=3000

```

### Connect Using Mongoose

```

const mongoose = require("mongoose");
mongoose.connect(process.env.MONGO_URI)
.then(() => {
console.log("Database Connected");
})
.catch((err) => {
console.log(err);
});

```

### Create a Schema

```

const mongoose = require("mongoose");
const studentSchema = new mongoose.Schema({
name:String,
age:Number,
department:String
});

```

### Create a Model

```

const Student = mongoose.model(
"Student",
studentSchema
);

```

The model represents the Students collection.

## Building CRUD APIs

### Create Student

```

app.post("/students", async(req,res)=>{
const student = new Student(req.body);
await student.save();
res.send(student);
});

```

### Read Students

```

app.get("/students", async(req,res)=>{
const students = await Student.find();
res.send(students);
});

```

### Update Student

```

app.put("/students/:id", async(req,res)=>{
await Student.findByIdAndUpdate(
req.params.id,
req.body
);
res.send("Updated");
});

```

### Delete Student

```

app.delete("/students/:id", async(req,res)=>{
await Student.findByIdAndDelete(
req.params.id
);
res.send("Deleted");
});

```

These REST APIs allow complete management of student records.

## Testing the Application

Applications should always be tested before deployment. Common testing tools:

- Postman

- Thunder Client

- Insomnia

Example request: `POST /students` Request body:

```

{
"name":"Anum",
"age":20,
"department":"Artificial Intelligence"
}

```

Expected response:

```

{
"_id":"66b2...",
"name":"Anum",
"age":20,
"department":"Artificial Intelligence"
}

```

Testing ensures the APIs work correctly.

## Security and Error Handling

### Input Validation

Never trust user input. Example:

```

if(!req.body.name){
return res.status(400).send("Name Required");
}

```

Validation prevents invalid or malicious data from entering the database.

### Use Try-Catch

```

try{
const students = await Student.find();
res.send(students);
}
catch(error){
res.status(500).send(error);
}

```

This prevents the application from crashing due to unexpected errors.

### Use Environment Variables

Never hardcode passwords. Correct approach: `process.env.MONGO_URI` This keeps sensitive information secure.

## Deployment Considerations

After development, applications can be deployed online. Common deployment platforms:

- Render

- Railway

- Vercel (Frontend)

- Netlify (Frontend)

Cloud databases:

- MongoDB Atlas

Deployment steps generally include: 1. Upload code to GitHub. 2. Connect the repository to the hosting platform. 3. Configure environment variables. 4. Connect to MongoDB Atlas. 5. Deploy the application.

## Advantages and Limitations

### Advantages

### 1. Flexible Data Storage

MongoDB stores documents with flexible schemas.

### 2. High Scalability

Applications can grow as data and users increase.

### 3. Fast Development

JavaScript can be used across both the frontend and backend.

### 4. Easy Integration

MongoDB integrates seamlessly with Node.js and Express.

### 5. Rich Ecosystem

Large community support and numerous development tools are available.

### Limitations

- Poor schema design can reduce performance.

- Incorrect indexing may slow queries.

- Security vulnerabilities can arise if authentication and validation are ignored.

- Improper error handling can affect application reliability.

## Real-World Applications

### University Management

- Student registration

- Attendance

- Results

- Course enrollment

### E-commerce

- Product management

- Shopping carts

- Orders

- Payments

### Healthcare

- Patient records

- Doctor schedules

- Appointments

### Banking

- Customer accounts

- Transactions

- Loan management

### Social Media

- User profiles

- Posts

- Comments

- Messaging

## Best Practices

- Plan the database schema before writing application code.

- Organize the project into folders such as **models**, **routes**, **controllers**, and **config**.

- Use Mongoose schemas for validation and consistency.

- Store configuration values and credentials in environment variables.

- Validate all user input before interacting with the database.

- Handle errors using `try...catch` blocks and return meaningful HTTP status codes.

- Create indexes for frequently queried fields to improve performance.

- Test APIs thoroughly using tools like Postman before deployment.

- Keep code modular and reusable to simplify maintenance and future enhancements.

- Monitor application performance and database queries after deployment.

## Complete Application Workflow

```

User
│
▼
Frontend Form
│
▼
Express Route
│
▼
Controller
│
▼
Mongoose Model
│
▼
MongoDB Database
│
▼
Response Sent Back
│
▼
User

```

This workflow shows how a request travels through the entire application, from the user\'s action to the database and back.

### Conclusion

Building a MongoDB-backed application involves integrating a **frontend**, a **Node.js/Express backend**, and a **MongoDB database** into a complete system. Using **Mongoose**, developers can define schemas, validate data, and perform CRUD operations efficiently. By following a structured development process, organizing the project properly, implementing secure database connections, validating user input, handling errors gracefully, and testing APIs thoroughly, we can create reliable, scalable, and maintainable applications. Whether developing systems for education, healthcare, banking, e-commerce, or social media, mastering the process of building a MongoDB-backed application provides the foundation for creating modern, data-driven software solutions.');
