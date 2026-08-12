-- =============================================
-- ReflectAI — Redis Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'Redis' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to Redis & In-Memory Databases
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to Redis & In-Memory Databases', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to Redis & In-Memory Databases

Redis is one of the fastest databases available today because it stores data directly in a computer\'s memory (RAM) instead of relying primarily on hard disks. Modern applications such as social media platforms, gaming servers, chat applications, e-commerce websites, and real-time analytics use Redis to provide lightning-fast responses. In these lecture notes, we will understand what Redis is, why in-memory databases are important, how Redis differs from traditional databases, and how to install and use Redis through the Redis Command Line Interface (CLI).

## Introduction to Redis

### What is Redis?

Redis stands for **Remote Dictionary Server**. It is an **open-source, in-memory NoSQL database** that stores data as key-value pairs. Unlike traditional relational databases that organize information into rows and tables, Redis stores data in memory, making data retrieval extremely fast. Redis can be used as:

- A database

- A cache

- A message broker

- A session store

- A real-time analytics engine

Because RAM is much faster than disk storage, Redis can process **millions of operations per second** with very low latency. **Example** Imagine a website that receives thousands of users every second. Without Redis: `User → Database → Response` With Redis:

```

User → Redis Cache → Instant Response
↓
Database (only when needed)

```

The result is a much faster application and reduced load on the main database.

### History of Redis

Redis was created by **Salvatore Sanfilippo** in 2009. The project was designed to solve real-world performance problems where traditional databases became slow under heavy traffic. Over the years, Redis has become one of the most popular databases used by companies like:

- GitHub

- Snapchat

- Pinterest

- Stack Overflow

- Twitter (X)

- Discord

Its popularity comes from its speed, flexibility, and simplicity.

## Understanding In-Memory Databases

### What is an In-Memory Database?

An **in-memory database (IMDB)** stores data primarily inside **RAM (Random Access Memory)** instead of hard drives or SSDs. Since RAM can be accessed almost instantly, reading and writing data becomes significantly faster. Think of RAM like a notebook on your desk.

- Looking at the notebook takes only a second.

- Searching for the same information in a filing cabinet takes much longer.

Traditional databases behave more like filing cabinets, while Redis behaves like the notebook on your desk.

### Disk-Based Database vs In-Memory Database

| Feature | Disk-Based Database | In-Memory Database |
|---|---|---|
| Storage | HDD/SSD | RAM |
| Speed | Slower | Extremely Fast |
| Read Time | Milliseconds | Microseconds |
| Best For | Permanent Storage | Real-Time Processing |
| Examples | MySQL, PostgreSQL | Redis |

### Advantages of In-Memory Databases

**Extremely Fast** Redis performs operations in microseconds because memory access is incredibly quick. **Low Latency** Applications respond almost instantly, improving user experience. **High Throughput** Redis can process millions of requests every second. **Simple Data Structures** Redis supports several built-in data structures without requiring complex schemas. **Excellent for Caching** Frequently accessed information remains in memory, reducing repeated database queries.

### Limitations

Although Redis is very powerful, it also has some limitations. **Memory Cost** RAM is much more expensive than hard drives. **Limited Capacity** Servers generally have less RAM than disk storage. **Data Persistence** If persistence is not configured correctly, data stored only in RAM can be lost after power failure or system restart. Fortunately, Redis supports persistence mechanisms such as snapshots and append-only files to reduce this risk.

## Features and Data Structures of Redis

Redis is much more than a simple key-value store. It supports multiple data structures that make application development easier.

### 1. Strings

The most basic Redis data type. Example: `Name → "Anum"` Used for:

- Usernames

- Tokens

- Counters

- Messages

### 2. Lists

Lists maintain ordered collections. Example:

```

Tasks:
- Study Redis
- Practice Commands
- Complete Assignment

```

Useful for:

- Queues

- Task scheduling

- Recent activities

### 3. Sets

Sets store unique values. Example:

```

Languages:
Python
Java
JavaScript

```

Duplicate values are automatically ignored. Useful for:

- Tags

- Friend lists

- Unique visitors

### 4. Hashes

Hashes store objects using field-value pairs. Example:

```

Student
Name = Anum
Age = 20
Department = AI

```

Useful for storing user profiles.

### 5. Sorted Sets

Sorted sets maintain values according to scores. Example:

```

Ali 98
Sara 90
Hamza 85

```

Useful for:

- Leaderboards

- Rankings

- Gaming applications

### Common Use Cases

Redis is widely used for:

- Website caching

- User session management

- Shopping carts

- Authentication tokens

- Leaderboards

- Chat systems

- Notification systems

- Rate limiting

- Real-time analytics

## Installing Redis

Redis installation depends on the operating system.

### Installing Redis on Windows

Redis is not officially supported natively on Windows, but several options are available. 1. Install WSL. 2. Install Ubuntu from Microsoft Store. 3. Update packages. `sudo apt update` 4. Install Redis.

```

sudo apt install redis-server

```

5. Start Redis.

```

sudo service redis-server start

```

6. Check status. `redis-cli ping` Output: `PONG` This confirms Redis is running successfully.

### Installing Redis on Ubuntu/Linux

Update packages. `sudo apt update` Install Redis.

```

sudo apt install redis-server

```

Start the service.

```

sudo systemctl start redis-server

```

Enable Redis to start automatically.

```

sudo systemctl enable redis-server

```

Check whether Redis is active.

```

sudo systemctl status redis-server

```

### Installing Redis on macOS

Using Homebrew: Install Redis. `brew install redis` Start Redis. `brew services start redis` Verify installation. `redis-cli ping` Output: `PONG`

### Checking Redis Version

To verify installation: `redis-server --version` Example output: `Redis server v=8.x.x`

## Redis CLI (Command Line Interface)

### What is Redis CLI?

Redis CLI is the command-line tool used to communicate with the Redis server. It allows us to:

- Store data

- Retrieve data

- Delete data

- Test Redis commands

- Monitor server activity

Think of Redis CLI as a conversation with the database. We type commands, and Redis immediately responds.

### Starting Redis CLI

Run: `redis-cli` The prompt changes to: `127.0.0.1:6379>` This means we are connected to the Redis server.

### Testing Connection

`PING` Output: `PONG` This is the simplest way to confirm Redis is working.

### Setting Data

Store a value. `SET name "Anum"` Output: `OK`

### Getting Data

Retrieve the stored value. `GET name` Output: `"Anum"`

### Updating Data

`SET name "Saba"` Retrieve again. `GET name` Output: `"Saba"` The previous value is overwritten.

### Deleting Data

`DEL name` Output: `(integer) 1` Check again. `GET name` Output: `(nil)` The key no longer exists.

### Viewing All Keys

`KEYS *` Example:

```

1) "student"
2) "course"
3) "city"

```

**Note:** `KEYS *` is suitable for learning and testing but should be avoided in production environments with large datasets because it can impact performance.

### Checking Key Existence

`EXISTS student` Output: `(integer) 1` Meaning:

- **1** = Key exists

- **0** = Key does not exist

### Removing All Data

Delete the current database. `FLUSHDB` Delete all databases. `FLUSHALL` Use these commands carefully because they permanently remove stored data.

### Exiting Redis CLI

Simply type: `EXIT` or press: `Ctrl + C`

### Key Differences Between Redis and MySQL

| Redis | MySQL |
|---|---|
| NoSQL Database | Relational Database |
| In-Memory Storage | Disk-Based Storage |
| Key-Value Model | Tables and Rows |
| Extremely Fast | Comparatively Slower |
| Best for Caching | Best for Permanent Data |
| Flexible Schema | Fixed Schema |

### Best Practices

- Use Redis for caching frequently accessed data.

- Store temporary or rapidly changing data in Redis.

- Use meaningful key names for easier management.

- Configure persistence if data recovery is important.

- Avoid using `KEYS *` in production on large databases.

- Regularly monitor memory usage to prevent resource exhaustion.

- Combine Redis with databases like MySQL or PostgreSQL instead of treating it as a replacement for all storage needs.

### Conclusion

Redis is a powerful in-memory NoSQL database designed for speed, simplicity, and real-time performance. By storing data in RAM, it delivers responses far faster than traditional disk-based databases, making it ideal for caching, session management, leaderboards, messaging, and many other high-performance applications. Installing Redis is straightforward on Linux, macOS, and Windows through WSL, and the Redis CLI provides an easy way to interact with the server using simple commands like `PING`, `SET`, `GET`, and `DEL`. As we continue learning Redis, we will discover more advanced features such as expiration times, transactions, persistence, pub/sub messaging, and clustering, allowing us to build scalable and highly responsive applications.');

-- Lecture 2: Redis Data Types (Strings, Lists, Sets, Hashes, Sorted Sets)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Redis Data Types (Strings, Lists, Sets, Hashes, Sorted Sets)', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Redis Data Types (Strings, Lists, Sets, Hashes, Sorted Sets)

Redis is a powerful in-memory database that does not store data in traditional tables and rows like relational databases. Instead, Redis uses different **data structures** to organize and manage information efficiently. These structures are called **Redis Data Types**. Understanding Redis data types is important because choosing the correct data type can make applications faster, cleaner, and easier to manage. A database without proper structure is like a messy room: technically everything exists, but finding anything becomes a painful adventure humans somehow repeat forever. Redis provides several built-in data types, but the five most commonly used are: 1. Strings 2. Lists 3. Sets 4. Hashes 5. Sorted Sets In this lecture, we will explore each data type, its commands, and practical use cases.

## Introduction to Redis Data Types

### What Are Redis Data Types?

Redis data types are different ways of storing and organizing data inside Redis. Unlike SQL databases where information is stored in tables:

```

Users Table
ID | Name | Age
1 | Anum | 20

```

Redis stores information using a **key-value approach**:

```

Key → Value
username → "Anum"

```

The key acts like a label, and the value contains the actual data. Example: `user:1:name → "Anum"` Redis allows different types of values, such as:

- Text

- Numbers

- Lists of items

- Unique collections

- Objects

- Ranked data

Each data type has specific commands designed for efficient operations.

## Redis Strings

### What Are Strings?

Strings are the simplest and most commonly used Redis data type. A Redis string stores a sequence of characters, numbers, or binary data. Examples:

```

name → "Anum"
age → "20"
token → "abc123xyz"

```

Strings can store up to **512 MB** of data.

### Creating Strings

The `SET` command is used to store string values. Example: `SET username "Anum"` Output: `OK` Now Redis stores: `username → Anum`

### Retrieving Strings

The `GET` command retrieves stored values. Example: `GET username` Output: `"Anum"`

### Updating Strings

If we store another value with the same key, Redis replaces the old value. Example: `SET username "Saba"` Now: `username → Saba` The previous value is overwritten. Redis does not ask for permission. Databases rarely have manners.

### String Commands

**Set Multiple Values**

```

MSET name "Anum" age "20" city "Sukkur"

```

**Get Multiple Values** `MGET name age city` Output:

```

Anum
20
Sukkur

```

### Increment and Decrement

Strings can also store numbers. Example: `SET views 100` Increase value: `INCR views` Result: `101` Decrease value: `DECR views` Result: `100`

### Uses of Strings

Redis strings are commonly used for:

- User sessions

- Authentication tokens

- Page counters

- Website caching

- Configuration values

- Temporary data

Example: A website can store: `page_views → 5000` Every visitor increases the counter using `INCR`.

## Redis Lists

### What Are Lists?

Redis Lists are ordered collections of strings. A list stores multiple values in a sequence. Example:

```

tasks:
1. Learn Redis
2. Practice Commands
3. Build Project

```

Lists work like a queue where items can be added or removed from both ends.

### Adding Elements to Lists

**Add to the Left Side** Command: `LPUSH tasks "Study"` Result: `Study` **Add to the Right Side** Command: `RPUSH tasks "Assignment"` Result:

```

Study
Assignment

```

### Viewing List Elements

The `LRANGE` command displays list items. Example: `LRANGE tasks 0 -1` Output:

```

1) Study
2) Assignment

```

Here:

- `0` means starting position

- `-1` means ending position

### Removing Elements

Remove from the left: `LPOP tasks` Remove from the right: `RPOP tasks`

### List Use Cases

Redis Lists are useful for: **Message Queues** Example:

```

New Messages:
Message 1
Message 2
Message 3

```

**Task Scheduling** A server can store background jobs:

```

Email Task
Image Processing
Report Generation

```

**Activity Feeds** Social media platforms can store recent activities.

## Redis Sets

### What Are Sets?

Redis Sets are collections of **unique values**. Unlike lists, sets do not maintain order and automatically remove duplicates. Example:

```

Programming Languages:
Python
Java
JavaScript
Python

```

Redis stores:

```

Python
Java
JavaScript

```

The duplicate disappears.

### Adding Values to Sets

Command: `SADD languages "Python"` Add more: `SADD languages "Java" "C++"`

### Viewing Set Members

Command: `SMEMBERS languages` Output:

```

Python
Java
C++

```

### Checking Membership

Command: `SISMEMBER languages "Python"` Output: `1` Meaning the value exists.

### Removing Values

Command: `SREM languages "Java"` Java is removed from the set.

### Set Operations

Redis supports mathematical set operations. **Union** Combines two sets. Example:

```

Set A:
Python
Java
Set B:
JavaScript
Python

```

Union:

```

Python
Java
JavaScript

```

Command: `SUNION A B` **Intersection** Finds common values. Command: `SINTER A B` Result: `Python`

### Set Use Cases

Sets are useful for:

- Unique visitors

- Tags

- User permissions

- Friend relationships

- Product categories

Example: An online store can store:

```

Users who liked product:
User1
User2
User3

```

Each user appears only once.

## Redis Hashes

### What Are Hashes?

Redis Hashes store objects using field-value pairs. They are similar to objects in programming languages. Example: A user object:

```

User:
Name → Anum
Age → 20
City → Sukkur

```

Instead of storing each value separately, we store them together.

### Creating Hashes

Command: `HSET user:1 name "Anum"` Add more fields:

```

HSET user:1 age "20" city "Sukkur"

```

Stored data:

```

user:1
name = Anum
age = 20
city = Sukkur

```

### Retrieving Hash Data

Get one field: `HGET user:1 name` Output: `Anum` Get all fields: `HGETALL user:1` Output:

```

name
Anum
age
20
city
Sukkur

```

### Deleting Hash Fields

Command: `HDEL user:1 age` The age field is removed.

### Hash Use Cases

Hashes are commonly used for:

- User profiles

- Product information

- Employee records

- Application settings

Example:

```

product:101
name → Laptop
price → 90000
brand → Dell

```

## Redis Sorted Sets

### What Are Sorted Sets?

Sorted Sets are similar to normal sets, but every value has a score. Redis automatically sorts members according to their scores. Example:

```

Leaderboard:
Ali 950
Sara 870
Hamza 800

```

### Adding Sorted Set Values

Command: `ZADD leaderboard 950 Ali` Add more:

```

ZADD leaderboard 870 Sara
ZADD leaderboard 800 Hamza

```

Redis automatically sorts them.

### Viewing Rankings

Command:

```

ZRANGE leaderboard 0 -1 WITHSCORES

```

Output:

```

Hamza 800
Sara 870
Ali 950

```

Command:

```

ZREVRANGE leaderboard 0 2 WITHSCORES

```

Output:

```

Ali 950
Sara 870
Hamza 800

```

### Updating Scores

Increase score: `ZINCRBY leaderboard 50 Ali` Ali\'s score becomes: `1000`

### Sorted Set Use Cases

Sorted Sets are perfect for:

- Gaming leaderboards

- Ranking systems

- Priority queues

- Real-time statistics

Example: A game can instantly show:

```

1. Ali - 5000 points
2. Sara - 4500 points
3. Hamza - 4000 points

```

## Comparison of Redis Data Types

| Data Type | Structure | Ordered | Duplicate Allowed | Common Use |
|---|---|---|---|---|
| String | Single value | No | Yes | Cache, Tokens |
| List | Sequence | Yes | Yes | Queues, Feeds |
| Set | Collection | No | No | Unique Data |
| Hash | Object | No | Yes | User Profiles |
| Sorted Set | Ranked Collection | Yes | No | Leaderboards |

## Choosing the Right Redis Data Type

Choosing the correct data type depends on the problem. Use: **Strings when:**

- You need one simple value.

- Example: User token or counter.

**Lists when:**

- Order matters.

- Example: Messages or tasks.

**Sets when:**

- You need unique values.

- Example: Tags or visitors.

**Hashes when:**

- You need to store objects.

- Example: User profiles.

**Sorted Sets when:**

- Ranking is required.

- Example: Game scores.

### Conclusion

Redis data types are the foundation of building fast and efficient applications using Redis. Strings provide simple key-value storage, Lists manage ordered collections, Sets handle unique values, Hashes organize objects, and Sorted Sets provide powerful ranking capabilities. Each data type solves a different problem, allowing developers to choose the best structure for their application needs. Understanding these data types helps us use Redis correctly instead of treating it as just another database. Redis is powerful because it gives developers simple tools that match real-world problems, proving once again that sometimes the simplest structures are the ones that make software run incredibly fast.');

-- Lecture 3: Key Expiration & TTL in Redis
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Key Expiration & TTL in Redis', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Key Expiration & TTL in Redis

Redis is widely known as an in-memory data structure store that delivers exceptional speed for caching, real-time analytics, session management, and message brokering. One of its most powerful features is **key expiration**, which allows data to automatically disappear after a specified period. This feature is controlled through **TTL (Time To Live)**. Rather than manually deleting outdated information, we can instruct Redis to remove it automatically, making our applications faster, cleaner, and more efficient. Imagine placing food in a refrigerator with an expiration date. Once the date passes, the food should no longer be used. Redis works in a similar way. Every key can have an expiration timer, and once that timer reaches zero, Redis automatically removes the key. This simple concept solves many real-world problems, from managing user sessions to caching API responses.

## Understanding Key Expiration

### What Is Key Expiration?

Key expiration is the process of assigning a lifetime to a Redis key. After the specified duration expires, Redis automatically deletes the key without requiring intervention from the application. For example, suppose we store a user\'s login session:

```

Key: session:user123
Value: Logged In

```

If we set this key to expire in **30 minutes**, Redis will automatically remove it after 30 minutes. This prevents old sessions from remaining in memory forever.

### Why Is Key Expiration Important?

Without expiration, Redis would continue storing unnecessary data, eventually consuming available memory. Benefits include:

- Automatic cleanup of outdated data

- Reduced memory usage

- Better cache management

- Improved application performance

- Simplified application logic

Instead of writing code that constantly checks whether data is outdated, Redis handles it automatically.

### Real-Life Example

Suppose an e-commerce website stores a temporary shopping cart. `cart:user45` If the customer leaves the website and never returns, the cart should not stay forever. We can set: `Expiration = 24 hours` After one day, Redis deletes the cart automatically.

## Time To Live (TTL)

### What Is TTL?

TTL stands for **Time To Live**. It represents the remaining time before a key expires. Think of TTL as a countdown timer. For example: `TTL = 60` means the key will exist for another 60 seconds.

### TTL Command

Redis provides the `TTL` command to check how many seconds remain.

```

SET username "Anum"
EXPIRE username 120
TTL username

```

Output: `115` This means the key has **115 seconds left** before deletion.

### Understanding TTL Results

The TTL command can return different values. **Positive Number** `75` The key expires in 75 seconds. **Result = -1** `-1` The key exists but has **no expiration time**. **Result = -2** `-2` The key does not exist. Either:

- it expired

- or it was never created

### PTTL Command

`PTTL` returns the remaining time in **milliseconds**. Example: `PTTL session1` Output: `58250` This means: `58.250 seconds` Milliseconds provide higher precision.

## Setting Expiration

Redis offers several ways to assign expiration times.

### Using EXPIRE

Syntax: `EXPIRE key seconds` Example:

```

SET otp "987654"
EXPIRE otp 120

```

The OTP disappears after **2 minutes**.

### Using PEXPIRE

Instead of seconds, we can use milliseconds. Syntax: `PEXPIRE key milliseconds` Example: `PEXPIRE otp 5000` Expires after: `5 seconds`

### Setting Expiration While Creating the Key

Redis allows expiration during insertion. Example: `SET token "ABC123" EX 60` This creates the key and sets its expiration to **60 seconds** immediately. Milliseconds: `SET token "ABC123" PX 5000` Expires after: `5 seconds` This method is preferred because it is atomic—both operations happen together.

### Expire at a Specific Time

Instead of specifying a duration, we can specify an exact Unix timestamp. Example: `EXPIREAT meeting 1755000000` Redis deletes the key at that exact time. Millisecond precision: `PEXPIREAT`

### Removing Expiration

Sometimes we want a key to become permanent. Redis provides: `PERSIST key` Example: `PERSIST session1` The key remains indefinitely until explicitly deleted.

## Practical Applications of TTL

### 1. User Sessions

One of the most common uses. Example:

```

SET session:123 user_data EX 1800

```

The session expires after: `30 minutes` If the user logs in again, the timer can be refreshed.

### 2. One-Time Passwords (OTP)

Security codes should expire quickly. Example: `SET otp:phone 853241 EX 300` Expires after: `5 minutes` Even if someone discovers the code later, it is useless.

### 3. API Caching

Suppose an API request is expensive. Instead of querying the database repeatedly:

```

Request
↓
Redis Cache
↓
Database

```

Store the response:

```

SET weather:data "{...}" EX 600

```

The cache automatically refreshes every 10 minutes.

### 4. Login Tokens

Authentication tokens often expire. Example:

```

SET auth:user123 token EX 3600

```

After one hour, the user must authenticate again.

### 5. Rate Limiting

Suppose we allow: `100 requests per minute` Redis stores:

```

INCR api:user45
EXPIRE api:user45 60

```

Every minute, Redis resets the counter automatically.

### 6. Temporary File Downloads

Download links should not remain forever. Example:

```

SET download:file1 available EX 900

```

The link works for only: `15 minutes`

### 7. Online Status

Messaging applications often store online users. Example: `SET online:user45 true EX 60` If the user disconnects, Redis removes the key after one minute.

## How Redis Handles Expired Keys

Many beginners wonder: "Does Redis continuously scan every key?" Fortunately, no. Redis uses intelligent strategies.

### Passive Expiration

Whenever someone accesses a key: `GET session1` Redis first checks: Has it expired? If yes:

- Delete it

- Return nothing

This avoids unnecessary work.

### Active Expiration

Some expired keys may never be accessed again. Redis periodically checks random keys with expiration times. Expired keys are removed automatically. This prevents memory from filling with forgotten data.

### Lazy Deletion vs Active Cleanup

Think of a classroom. **Lazy deletion** is like removing a student\'s desk only when someone notices it is empty. **Active cleanup** is like a teacher periodically checking the classroom and removing unused desks. Redis combines both strategies for excellent performance.

### Memory Efficiency

Automatic expiration significantly reduces memory usage. Without TTL:

```

Old Sessions
Old OTPs
Expired Tokens
Unused Cache
Old Shopping Carts

```

would remain forever. With TTL:

```

↓
Redis automatically removes them.

```

Less memory means better speed.

### Performance Considerations

Although expiration is efficient, a few best practices should be followed:

- Set expiration only when needed.

- Avoid assigning identical expiration times to millions of keys, as they may expire simultaneously and create sudden spikes in workload.

- Use `SET EX` instead of `SET` followed by `EXPIRE` whenever possible because it is an atomic operation.

- Use millisecond precision only when the application genuinely requires it.

- Monitor memory usage in production environments.

### Common Redis Commands for TTL

| Command | Description |
|---|---|
| EXPIRE key seconds | Set expiration in seconds |
| PEXPIRE key milliseconds | Set expiration in milliseconds |
| TTL key | View remaining seconds |
| PTTL key | View remaining milliseconds |
| EXPIREAT key timestamp | Expire at a Unix timestamp |
| PEXPIREAT key timestamp | Expire at a millisecond timestamp |
| PERSIST key | Remove expiration |
| SET key value EX seconds | Create key with expiration |
| SET key value PX milliseconds | Create key with millisecond expiration |

### Conclusion

Key expiration and TTL are among Redis\'s most valuable features because they automate the lifecycle of data. Instead of relying on application code to clean up outdated information, Redis efficiently manages temporary data by removing it once its lifetime ends. Whether we are building secure authentication systems, caching expensive API responses, managing shopping carts, implementing rate limiting, or handling temporary download links, TTL helps keep our applications fast, memory-efficient, and easy to maintain. By understanding commands such as `EXPIRE`, `TTL`, `PERSIST`, and their millisecond variants, we can design Redis-powered applications that are both scalable and reliable while minimizing manual maintenance.');

-- Lecture 4: Redis as a Cache
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Redis as a Cache', 4, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Redis as a Cache

Redis is one of the world\'s most popular caching solutions because of its **exceptional speed, simplicity, and efficiency**. Since Redis stores data in memory (RAM) instead of reading it from slower disk storage, it can retrieve information in **microseconds**. This makes it an excellent choice for reducing database load, improving application performance, and delivering a faster user experience. Imagine a librarian who keeps the most frequently requested books on a desk instead of walking to the shelves every time someone asks for one. The desk represents the **cache**, while the shelves represent the **database**. Retrieving books from the desk is much faster, just as retrieving data from Redis is much quicker than querying a database repeatedly.

## Introduction to Caching

### What Is Caching?

Caching is the process of storing frequently accessed data in a temporary storage area so that future requests can be served more quickly. Instead of fetching data from the database every time, the application first checks whether the data is already available in the cache. If it is available:

```

Application
│
▼
Redis Cache
│
▼
Return Data

```

If it is not available:

```

Application
│
▼
Database
│
▼
Store in Redis
│
▼
Return Data

```

This reduces unnecessary database queries and improves response time.

### Why Is Caching Important?

Without caching, every request reaches the database. For example:

```

1000 Users
↓
1000 Database Queries

```

With Redis caching:

```

1000 Users
↓
Redis Cache
↓
Only a Few Database Queries

```

This significantly reduces server workload.

### Benefits of Redis as a Cache

Redis caching offers many advantages:

- Extremely fast data access

- Reduces database load

- Improves application performance

- Handles high traffic efficiently

- Reduces response time

- Simple to implement

- Supports automatic expiration using TTL

## How Redis Caching Works

Redis acts as a middle layer between the application and the database.

### Step 1: User Requests Data

A user requests information, such as a product page.

```

User
↓
Application

```

### Step 2: Check Redis

The application checks Redis first.

```

Application
↓
Redis

```

### Step 3: Cache Hit

If Redis already contains the requested data:

```

Redis
↓
Return Data

```

The database is not accessed.

### Step 4: Cache Miss

If Redis does not contain the data:

```

Application
↓
Database
↓
Redis
↓
User

```

The application retrieves the data from the database, stores it in Redis for future requests, and then sends it to the user.

### Cache Hit vs Cache Miss

### Cache Hit

A **cache hit** occurs when the requested data is found in Redis. Example:

```

GET product:101
↓
Found in Redis

```

Advantages:

- Very fast response

- No database query

- Lower server load

### Cache Miss

A **cache miss** occurs when the requested data is not found. Example:

```

GET product:101
↓
Not Found
↓
Database Query
↓
Store in Redis

```

The first request is slower, but future requests become much faster.

## Redis Commands for Caching

Redis provides simple commands for storing and retrieving cached data.

### SET Command

Stores data in Redis. Syntax: `SET key value` Example:

```

SET product:101 "Wireless Mouse"

```

### GET Command

Retrieves cached data. Syntax: `GET key` Example: `GET product:101` Output: `Wireless Mouse`

### Using Expiration

Most cached data should expire automatically. Example:

```

SET product:101 "Wireless Mouse" EX 600

```

The cached data remains for: `600 seconds (10 minutes)` After that, Redis automatically removes it.

### Deleting Cached Data

Sometimes cached data becomes outdated. Example: `DEL product:101` The next request retrieves fresh data from the database.

## Caching Strategies

Different applications use different caching strategies depending on their needs.

### 1. Cache-Aside (Lazy Loading)

This is the most commonly used caching strategy.

### How It Works

1. Application checks Redis. 2. If data exists, return it. 3. If data does not exist, read from the database. 4. Store the result in Redis. 5. Return the data. Flow:

```

Application
↓
Redis
↓
(Cache Miss)
↓
Database
↓
Redis
↓
User

```

### Advantages

- Simple to implement

- Saves memory

- Only caches requested data

### Disadvantages

- First request is slower due to the cache miss.

### 2. Write-Through Cache

Whenever data is written to the database, it is also written to Redis. Flow:

```

Application
↓
Redis
↓
Database

```

### Advantages

- Cache always contains the latest data.

- Read operations are very fast.

### Disadvantages

- Slightly slower write operations because data is written twice.

### 3. Write-Back (Write-Behind) Cache

Data is first written to Redis and later synchronized with the database. Flow:

```

Application
↓
Redis
↓
Database (Later)

```

### Advantages

- Very fast writes

- Reduces database load

### Disadvantages

- Risk of data loss if Redis fails before synchronization.

### 4. Read-Through Cache

In this strategy, the application requests data only from Redis. If the data is missing, Redis (or an integrated caching layer) retrieves it from the database automatically.

### Advantages

- Simplifies application logic.

- Consistent cache management.

### Disadvantages

- Requires additional infrastructure or caching support.

## Practical Applications of Redis Caching

Redis caching is used in many real-world systems.

### 1. Website Pages

Popular web pages can be cached. Example:

```

Home Page
↓
Redis
↓
Instant Loading

```

This reduces repeated database queries for frequently visited pages.

### 2. User Sessions

User login information can be stored in Redis. Example:

```

SET session:user123 "Logged In" EX 1800

```

The session expires automatically after **30 minutes**.

### 3. Product Information

Online stores cache product details. Example:

```

SET product:205 "{Product Details}" EX 900

```

Customers receive product information much faster.

### 4. API Responses

External APIs can be slow or have usage limits. Instead of calling the API repeatedly:

```

Application
↓
Redis
↓
API (Only When Needed)

```

Example:

```

SET weather:lahore "{Weather Data}" EX 600

```

The weather information is refreshed every 10 minutes.

### 5. Leaderboards

Games frequently display player rankings. Redis stores leaderboard data for instant retrieval, providing smooth user experiences even with thousands of players.

### 6. Frequently Accessed Reports

Business dashboards often request the same reports repeatedly. Caching report results reduces database workload and improves dashboard performance.

## Cache Invalidation

One of the biggest challenges in caching is keeping data up to date. Imagine a product price changes in the database, but Redis still stores the old price. Users would see outdated information. Redis provides several ways to solve this.

### 1. Time-Based Expiration

Assign a TTL to cached data. Example: `SET price:101 "2500" EX 300` The data automatically refreshes after five minutes.

### 2. Manual Deletion

Remove outdated data manually. Example: `DEL price:101` The next request loads fresh data from the database.

### 3. Update Cache After Database Changes

Whenever the database changes, immediately update the Redis cache. This ensures users always receive the latest information.

## Best Practices for Redis Caching

To build an efficient caching system:

- Cache frequently accessed data.

- Set appropriate TTL values for temporary data.

- Avoid caching rarely used information.

- Monitor cache hit and cache miss rates.

- Remove outdated cache entries promptly.

- Use meaningful key names such as `product:101` or `user:45:profile`.

- Prevent storing excessively large objects in the cache.

- Choose the caching strategy that best fits your application\'s read and write patterns.

### Redis Cache vs Database

| Feature | Redis Cache | Database |
|---|---|---|
| Storage | Memory (RAM) | Disk Storage |
| Speed | Extremely Fast | Slower |
| Purpose | Temporary Data | Permanent Data |
| Data Lifetime | Usually Temporary | Permanent |
| Automatic Expiration | Yes | Usually No |
| Best For | Frequently Accessed Data | Long-Term Storage |

### Common Redis Commands Used in Caching

| Command | Description |
|---|---|
| SET key value | Store data in cache |
| GET key | Retrieve cached data |
| DEL key | Remove cached data |
| EXPIRE key seconds | Set expiration time |
| TTL key | Check remaining lifetime |
| SET key value EX seconds | Store data with expiration |
| PERSIST key | Remove expiration from a key |

### Conclusion

Redis is one of the most effective caching solutions available because it stores data in memory, allowing applications to retrieve information almost instantly. By serving frequently accessed data from Redis instead of repeatedly querying the database, applications become faster, more scalable, and capable of handling high traffic with reduced server load. Through strategies such as **Cache-Aside**, **Write-Through**, **Write-Back**, and **Read-Through**, developers can choose the approach that best matches their application\'s requirements. When combined with proper cache invalidation techniques and thoughtful TTL settings, Redis caching significantly improves performance, enhances user experience, and ensures efficient use of system resources in modern web and enterprise applications.');

-- Lecture 5: Building a Caching Layer with Redis
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a Caching Layer with Redis', 5, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a Caching Layer with Redis

Modern applications often receive thousands or even millions of requests every day. If every request directly accesses the database, the database can become slow, overloaded, and unable to handle increasing traffic. To solve this problem, developers build a **caching layer** using Redis. A **caching layer** is an intermediate storage system placed between the application and the database. Instead of repeatedly fetching the same data from the database, the application first checks Redis. If the data exists, Redis returns it immediately. If the data does not exist, the application retrieves it from the database, stores it in Redis, and then returns it to the user. Think of a caching layer as a **reception desk in a hotel**. Instead of asking the hotel manager for guest information every time, the receptionist keeps frequently requested information readily available, allowing guests to be served much faster.

## Understanding a Caching Layer

### What Is a Caching Layer?

A caching layer is a high-speed storage system that sits between the application and the database. Architecture:

```

User
│
▼
Web Application
│
▼
Redis Cache
│ │
(Cache Hit) (Cache Miss)
│ │
▼ ▼
Return Data Database
│
▼
Store in Redis
│
▼
Return Data

```

The goal is to reduce unnecessary database queries and improve application performance.

### Why Build a Caching Layer?

Without caching:

```

User Request
↓
Database
↓
Response

```

Every request reaches the database. With Redis:

```

User Request
↓
Redis
↓
Database (Only If Needed)

```

This significantly reduces database workload.

### Benefits of a Redis Caching Layer

A Redis caching layer offers several advantages:

- Faster response times

- Reduced database load

- Better scalability

- Lower server costs

- Improved user experience

- High availability for frequently accessed data

## How a Redis Caching Layer Works

A caching layer follows a simple workflow.

### Step 1: User Requests Data

Example: `GET Product 101` The request reaches the application.

### Step 2: Check Redis

The application checks Redis first.

```

Application
↓
Redis

```

### Step 3: Cache Hit

If Redis already contains the requested data:

```

Redis
↓
Return Product

```

The database is not accessed.

### Step 4: Cache Miss

If Redis does not contain the data:

```

Application
↓
Database
↓
Redis
↓
User

```

The application: 1. Retrieves data from the database. 2. Stores it in Redis. 3. Returns it to the user. Future requests become much faster.

### Cache Hit vs Cache Miss

### Cache Hit

Requested data exists in Redis. Example: `GET product:101` Output: `Laptop` Advantages:

- Very fast

- No database query

- Lower latency

### Cache Miss

Requested data does not exist. Example: `GET product:101` Output: `(nil)` The application retrieves the data from the database and stores it in Redis.

## Building a Cache-Aside Strategy

The **Cache-Aside Pattern (Lazy Loading)** is the most common caching strategy.

### Workflow

```

User
↓
Application
↓
Redis
↓
(Cache Miss)
↓
Database
↓
Redis
↓
User

```

### Algorithm

1. Receive request. 2. Check Redis. 3. If data exists, return it. 4. If data is missing:

- Read from the database.

- Save to Redis.

- Return data.

### Example in Pseudocode

```

if data exists in Redis
return data
else
read from database
save into Redis
return data

```

This strategy stores only the data that is actually requested.

### Example Using Redis

Store product data:

```

SET product:101 "Laptop" EX 600

```

Retrieve product: `GET product:101` The cached product remains available for **10 minutes**.

## Implementing a Caching Layer in Node.js

The official Redis client makes cache implementation straightforward.

### Connecting to Redis

```

import { createClient } from "redis";
const client = createClient();
await client.connect();

```

### Reading from Cache

```

const cached =
await client.get("product:101");

```

If the result is not `null`, return it immediately.

### Writing to Cache

```

await client.set(
"product:101",
JSON.stringify(product),
{
EX: 600
}
);

```

The product remains cached for **600 seconds**.

### Complete Flow

```

Request
↓
Redis
↓
Found?
↓
Yes → Return Data
↓
No
↓
Database
↓
Save to Redis
↓
Return Data

```

## Implementing a Caching Layer in Python

Python applications commonly use the **redis-py** library.

### Connecting

```

import redis
r = redis.Redis(
host="localhost",
port=6379,
decode_responses=True
)

```

### Reading Cache

```

product = r.get("product:101")

```

If `product` exists: `return product`

### Writing Cache

```

r.set(
"product:101",
product_data,
ex=600
)

```

The cache expires after **10 minutes**.

## Cache Invalidation

One of the biggest challenges in caching is keeping cached data synchronized with the database. Imagine a product price changes: Database:

```

Laptop
Rs. 95,000

```

Redis:

```

Laptop
Rs. 90,000

```

Users now see outdated information.

### Methods of Cache Invalidation

### 1. Time-Based Expiration

Redis automatically removes data after a specified time. Example:

```

SET product:101 "Laptop" EX 300

```

The cache expires after **5 minutes**.

### 2. Manual Deletion

Delete outdated data immediately after updating the database. Example: `DEL product:101` The next request loads fresh data from the database.

### 3. Update the Cache

Instead of deleting the cache, immediately update it. Example:

```

SET product:101 "Updated Product"

```

This ensures Redis always contains the latest information.

## Real-World Applications

Redis caching layers are widely used across industries.

### 1. E-Commerce Websites

Cache:

- Product details

- Categories

- Prices

- Recommendations

### 2. Social Media

Cache:

- User profiles

- Friend lists

- Posts

- Trending topics

### 3. News Websites

Frequently accessed articles remain cached for faster page loading.

### 4. Weather Applications

Weather APIs are expensive and frequently queried. Redis caches responses for several minutes. Example:

```

SET weather:lahore "{Weather Data}" EX 600

```

### 5. Online Learning Platforms

Cache:

- Course details

- Student profiles

- Frequently accessed lessons

### 6. Banking Dashboards

Redis caches account summaries and dashboards while sensitive transactional data continues to be retrieved securely from the primary database.

## Monitoring Cache Performance

Developers should monitor cache effectiveness. Important metrics include:

### Cache Hit Rate

Percentage of requests served directly from Redis. Example:

```

100 Requests
↓
90 Cache Hits
↓
10 Cache Misses
↓
Hit Rate = 90%

```

Higher hit rates generally indicate a more effective cache.

### Cache Miss Rate

Percentage of requests that require database access. Lower miss rates reduce database workload.

### Memory Usage

Monitor Redis memory to prevent running out of available RAM.

### TTL Monitoring

Regularly check expiration values: `TTL product:101`

## Best Practices

To build an efficient caching layer:

- Cache frequently requested data.

- Set appropriate TTL values based on how often data changes.

- Use meaningful key names such as `product:101`, `user:25`, or `session:abc123`.

- Remove or refresh cache entries when database records change.

- Avoid caching highly dynamic data unless necessary.

- Compress or optimize large objects before caching if appropriate.

- Monitor cache hit ratios and memory usage regularly.

- Use Redis persistence (RDB or AOF) only if cached data needs to survive server restarts.

### Common Redis Commands for Caching

| Command | Description |
|---|---|
| SET key value | Store data in cache |
| GET key | Retrieve cached data |
| DEL key | Delete cached data |
| EXPIRE key seconds | Set expiration time |
| TTL key | Check remaining lifetime |
| SET key value EX seconds | Store data with expiration |
| FLUSHDB | Remove all keys from the current database (use with caution) |

### Advantages vs Challenges

| Advantages | Challenges |
|---|---|
| Faster application performance | Cache invalidation complexity |
| Reduced database load | Additional memory usage |
| Better scalability | Risk of stale data |
| Lower response times | Requires monitoring and tuning |
| Improved user experience | Proper TTL selection is important |

### Conclusion

Building a caching layer with Redis is one of the most effective ways to improve the performance, scalability, and responsiveness of modern applications. By placing Redis between the application and the database, frequently requested data can be served almost instantly, reducing database load and delivering a better user experience. Strategies such as the **Cache-Aside pattern**, proper cache invalidation, and appropriate TTL settings help ensure that cached data remains both efficient and up to date. When combined with regular monitoring and best practices, a Redis caching layer enables developers to build fast, reliable, and highly scalable systems capable of handling heavy traffic with ease.');

-- Lecture 6: Redis for Session Storage
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Redis for Session Storage', 6, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Redis for Session Storage

Modern web applications need a way to remember users after they log in. Imagine logging into an online shopping website and being asked to log in again every time you visit a new page. That would create a poor user experience. This is where **session storage** becomes essential. Redis is one of the most popular technologies for storing user sessions because it is **extremely fast, scalable, and supports automatic expiration**. Since Redis stores data in memory (RAM), session information can be retrieved in microseconds, making it ideal for high-performance web applications. Think of a hotel receptionist. When a guest checks in, the receptionist assigns them a room number and keeps their information at the front desk. Whenever the guest requests a service, the receptionist quickly identifies them using their room number. Similarly, Redis stores session information using a **unique session ID**, allowing the application to identify users quickly without requiring them to log in repeatedly.

## Understanding Session Storage

### What Is a Session?

A **session** is a temporary storage mechanism that keeps track of a user\'s interaction with an application after they successfully log in. A session may store information such as:

- User ID

- Username

- Login status

- User role

- Shopping cart

- Preferences

- Authentication token

Example:

```

Session ID:
abc123xyz
↓
User ID:
101
↓
Username:
Anum
↓
Role:
Student

```

Whenever the user makes another request, the application retrieves this session information instead of asking the user to log in again.

### Why Do We Need Sessions?

HTTP is a **stateless protocol**, meaning each request is independent. Example:

```

Request 1
↓
Server
↓
Request 2
↓
Server

```

The server does not automatically remember previous requests. Sessions solve this problem by maintaining user information between requests.

### What Is Session Storage?

Session storage is the process of saving user session data after authentication. Instead of storing session data in application memory, files, or databases, we store it in Redis. Flow:

```

User Login
↓
Application
↓
Redis Session
↓
Future Requests

```

## Why Use Redis for Session Storage?

Redis has become the preferred session store for modern applications.

### 1. Extremely Fast

Redis stores sessions in RAM. Session retrieval takes only microseconds.

```

Application
↓
Redis
↓
Session Retrieved

```

### 2. Automatic Expiration

Redis supports **TTL (Time To Live)**. Example:

```

SET session:abc123 "{user data}" EX 1800

```

The session automatically expires after:

```

1800 seconds
↓
30 minutes

```

No manual cleanup is required.

### 3. Reduced Database Load

Without Redis:

```

Every Request
↓
Database

```

With Redis:

```

Every Request
↓
Redis
↓
Database (Only When Needed)

```

This significantly improves application performance.

### 4. Scalability

Redis supports millions of sessions simultaneously. It works well for:

- Social media platforms

- E-commerce websites

- Banking systems

- Online learning platforms

### 5. Shared Session Storage

In distributed systems, multiple application servers can access the same Redis server.

```

Server A
↓
Redis
↑
Server B
↑
Server C

```

Users remain logged in regardless of which server handles their request.

## How Redis Session Storage Works

Redis stores sessions using a unique key. Example: `session:abc123` Value:

```

User ID: 101
Username: Anum
Role: Student

```

### Session Workflow

### Step 1: User Logs In

The user enters:

- Username

- Password

The application verifies the credentials.

### Step 2: Create Session

Redis stores:

```

SET session:abc123 "{user data}" EX 1800

```

The application sends the session ID to the user\'s browser, often through a secure cookie.

### Step 3: User Makes Another Request

Browser sends: `Session ID` The application retrieves: `GET session:abc123` Redis returns: `User Data` The user remains authenticated.

### Step 4: Session Expires

After the TTL reaches zero:

```

Redis
↓
Delete Session

```

The user must log in again.

## Redis Commands for Session Storage

Redis provides several commands for managing sessions.

### Creating a Session

Example:

```

SET session:12345 "User101" EX 1800

```

This stores the session for **30 minutes**.

### Retrieving a Session

`GET session:12345` Output:

### Checking Remaining Time

`TTL session:12345` Output: `1200` Meaning: `1200 seconds remaining`

### Refreshing a Session

When a user remains active, we can extend the session. `EXPIRE session:12345 1800` The countdown starts again from **30 minutes**.

### Deleting a Session

When the user logs out: `DEL session:12345` The session is removed immediately.

## Practical Applications

Redis session storage is widely used in real-world systems.

### 1. User Authentication

After login:

```

User
↓
Redis Session
↓
Authenticated Requests

```

The application verifies the session instead of checking the password repeatedly.

### 2. Shopping Carts

Online stores often store shopping cart data inside the user\'s session. Example:

```

Cart
↓
Laptop
Phone
Headphones

```

Redis allows instant retrieval of cart contents.

### 3. Banking Applications

Banks use sessions to securely maintain authenticated users during online banking. Each request verifies the session before processing transactions.

### 4. Social Media Platforms

Redis stores:

- User login status

- Notifications

- User preferences

- Temporary activity data

### 5. Online Learning Platforms

Educational websites store:

- Student login

- Active course

- Quiz progress

- Language preference

### 6. Multiplayer Games

Game servers store:

- Player session

- Current level

- Match status

- Temporary statistics

## Redis Session Storage in Node.js and Python

### Node.js Example

Using the `redis` client:

```

await client.set(
"session:123",
"User101",
{
EX: 1800
}
);

```

Retrieve the session:

```

const session =
await client.get("session:123");

```

### Python Example

Using `redis-py`:

```

r.set(
"session:123",
"User101",
ex=1800
)

```

Retrieve the session:

```

session = r.get("session:123")

```

Both examples automatically expire after **30 minutes**.

## Best Practices for Session Storage

To build secure and efficient session management:

- Set appropriate TTL values for all sessions.

- Delete sessions immediately when users log out.

- Store only necessary session information.

- Use random, difficult-to-guess session IDs.

- Enable authentication and encryption for Redis in production.

- Avoid storing sensitive information such as passwords in session data.

- Refresh session expiration for active users if your application\'s security policy allows it.

- Monitor Redis memory usage when handling large numbers of active sessions.

### Advantages of Redis Session Storage

Redis offers several advantages:

- Extremely fast access

- Automatic session expiration

- Reduces database queries

- Supports high scalability

- Easy integration with most web frameworks

- Centralized session management

- Ideal for distributed applications

### Limitations

Redis session storage also has some limitations.

### 1. Memory Usage

Sessions are stored in RAM, so a large number of active sessions consumes memory.

### 2. Volatile Storage

Without persistence (RDB or AOF), sessions are lost if the Redis server restarts.

### 3. Requires Proper Security

Redis should be protected using:

- Authentication

- Network restrictions

- Encryption (where appropriate)

to prevent unauthorized access.

### Redis Session Storage vs Database Session Storage

| Feature | Redis | Database |
|---|---|---|
| Speed | Extremely Fast | Slower |
| Storage | Memory (RAM) | Disk |
| Automatic Expiration | Yes | Usually Manual |
| Scalability | Excellent | Moderate |
| Database Load | Very Low | Higher |
| Best For | Active Sessions | Long-Term Records |

### Common Redis Commands for Session Storage

| Command | Description |
|---|---|
| SET key value EX seconds | Create a session with expiration |
| GET key | Retrieve session data |
| DEL key | Delete a session |
| TTL key | Check remaining session lifetime |
| EXPIRE key seconds | Extend or modify session lifetime |
| PERSIST key | Remove expiration from a session |

### Conclusion

Redis is one of the best solutions for **session storage** because it combines exceptional speed, automatic expiration, and high scalability. By storing session data in memory, Redis enables applications to authenticate users quickly, reduce database load, and provide a seamless browsing experience. Features such as **TTL**, fast key retrieval, and centralized session management make Redis particularly valuable for web applications, e-commerce platforms, banking systems, online learning platforms, and multiplayer games. When combined with strong security practices, proper expiration policies, and persistence when needed, Redis provides a reliable and efficient foundation for managing user sessions in modern, high-performance applications.');

-- Lecture 7: PubSub Messaging in Redis
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'PubSub Messaging in Redis', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Pub/Sub Messaging in Redis

Redis is much more than a fast key-value database. It also provides a powerful **Publish/Subscribe (Pub/Sub)** messaging system that enables applications to communicate with each other in real time. Instead of constantly asking a server if new information is available, applications can subscribe to updates and receive messages instantly whenever something new happens. Think of Pub/Sub like a **radio station**. The radio station broadcasts music on a specific frequency. Anyone who tunes into that frequency can hear the broadcast, while those tuned elsewhere hear nothing. Similarly, in Redis, a **publisher** sends messages to a **channel**, and every **subscriber** listening to that channel immediately receives the message. Pub/Sub is widely used in chat applications, live notifications, multiplayer games, stock market updates, IoT systems, and many other real-time applications.

## Understanding Pub/Sub Messaging

### What Is Pub/Sub?

**Publish/Subscribe (Pub/Sub)** is a messaging pattern where senders (publishers) do not communicate directly with receivers (subscribers). Instead, messages are sent to a **channel**, and Redis delivers them to all clients subscribed to that channel. This approach creates **loose coupling**, meaning publishers and subscribers do not need to know about each other. The communication flow is:

```

Publisher
│
▼
Redis Channel
│
┌───┼───┐
▼ ▼ ▼
Subscriber A
Subscriber B
Subscriber C

```

Every subscriber connected to the channel receives the same message.

### Why Use Pub/Sub?

Pub/Sub provides several important benefits:

- Real-time communication

- Fast message delivery

- Simple architecture

- Loose coupling between applications

- Supports multiple subscribers

- Easy to implement

Instead of continuously checking for updates (polling), applications simply wait for Redis to deliver messages instantly.

### Real-Life Example

Imagine a university announcement system. Instead of informing every student individually, the university posts announcements on a notice board. Anyone interested simply checks that notice board. In Redis:

- Notice board = Channel

- University = Publisher

- Students = Subscribers

- Announcement = Message

## Core Components of Redis Pub/Sub

Redis Pub/Sub consists of three basic components.

### 1. Publisher

A **publisher** sends messages. Example: `Weather Service` It publishes: `"Temperature is 32°C"` The publisher does not know who receives the message.

### 2. Subscriber

A subscriber listens to one or more channels. Example: `Mobile App` Whenever a new weather update arrives, it immediately displays the information. Multiple subscribers can listen to the same channel simultaneously.

### 3. Channel

A channel is simply a named communication path. Examples:

```

news
sports
weather
chatroom
notifications
orders

```

Messages sent to a channel are immediately delivered to all subscribers of that channel.

## Redis Pub/Sub Commands

Redis provides several commands to implement Pub/Sub messaging.

### SUBSCRIBE

The `SUBSCRIBE` command allows a client to listen to one or more channels. Syntax: `SUBSCRIBE channel_name` Example: `SUBSCRIBE news` Output: `Subscribed to channel "news"` The client now waits for incoming messages.

### PUBLISH

The `PUBLISH` command sends a message to a channel. Syntax:

```

PUBLISH channel_name "message"

```

Example:

```

PUBLISH news "New Redis version released!"

```

Every subscriber of the **news** channel instantly receives the message.

### UNSUBSCRIBE

To stop receiving messages: `UNSUBSCRIBE news` The client no longer listens to the channel.

### PSUBSCRIBE

Redis supports **pattern-based subscriptions**. Example: `PSUBSCRIBE news:*` This subscribes to channels such as:

```

news:sports
news:weather
news:technology
news:business

```

One command can monitor multiple related channels.

### PUNSUBSCRIBE

To stop listening to pattern subscriptions: `PUNSUBSCRIBE news:*`

### PUBSUB CHANNELS

Lists active channels. Example: `PUBSUB CHANNELS` Possible output:

```

news
sports
weather
chat

```

## How Pub/Sub Works

Consider a chat application. **Step 1: User A subscribes** `SUBSCRIBE chatroom` **Step 2: User B subscribes** `SUBSCRIBE chatroom` **Step 3: Another client publishes**

```

PUBLISH chatroom "Hello everyone!"

```

**Step 4: Redis broadcasts** Both User A and User B receive: `Hello everyone!` The publisher does not send messages separately to each subscriber. Redis handles the broadcasting automatically.

### Message Flow

```

Publisher
│
PUBLISH
│
Redis Channel
│
───────────────
│ │ │
▼ ▼ ▼
User A User B User C

```

Every subscriber receives the message almost instantly.

## Practical Applications of Redis Pub/Sub

Redis Pub/Sub is used in many real-world systems.

### 1. Chat Applications

When one user sends: `Hello!` Redis publishes: `PUBLISH chatroom "Hello!"` Every connected user immediately receives the message. Examples include:

- Team chat applications

- Customer support chats

- Group messaging

### 2. Live Notifications

Suppose an e-commerce website wants to notify users. Example: `Order Shipped` Redis:

```

PUBLISH notifications "Your order has been shipped."

```

The mobile application immediately displays the notification.

### 3. Multiplayer Games

Games constantly update player actions. For example:

```

Player moved
Player attacked
Player scored

```

Instead of querying the server repeatedly, Redis broadcasts updates in real time.

### 4. Stock Market Updates

Financial applications receive continuous updates. Publisher: `AAPL = $210` Redis: `PUBLISH stocks "AAPL 210"` All trading dashboards update immediately.

### 5. IoT Devices

Smart devices communicate efficiently. Examples:

- Temperature sensors

- Smart lights

- Security cameras

- Smart homes

When a sensor detects movement:

```

PUBLISH security "Motion detected"

```

Every subscribed device reacts instantly.

### 6. Microservices Communication

Modern applications often consist of many services. For example:

```

Payment Service
↓
Order Service
↓
Notification Service

```

After successful payment:

```

PUBLISH orders "Payment Successful"

```

Other services respond automatically.

### Advantages of Redis Pub/Sub

Redis Pub/Sub offers several strengths:

- Extremely fast message delivery

- Easy to implement

- Supports many subscribers

- Low latency

- Ideal for real-time systems

- Lightweight architecture

- Reduces unnecessary network requests

### Limitations of Redis Pub/Sub

Despite its advantages, Pub/Sub has some limitations.

### 1. No Message Persistence

Messages are **not stored**. If no subscribers are listening, the message is lost. Example:

```

Publisher
↓
Redis
↓
(No Subscribers)
↓
Message Lost

```

### 2. No Delivery Guarantee

Redis does not guarantee that every subscriber receives every message. If a subscriber disconnects, it misses messages sent during the disconnection.

### 3. No Message History

New subscribers only receive future messages. They cannot retrieve messages published before they subscribed.

### 4. Limited Reliability

Pub/Sub is designed for **live communication**, not for reliable message processing or task queues. For applications requiring persistent messaging, Redis **Streams** are often a better choice.

### Pub/Sub vs Traditional Request-Response

| Feature | Pub/Sub | Request-Response |
|---|---|---|
| Communication | One-to-many | One-to-one |
| Real-time | Yes | Usually No |
| Sender knows receiver | No | Yes |
| Message Storage | No | Depends on application |
| Best Use | Notifications, chats, live updates | APIs, web requests |

### Best Practices

To build efficient Pub/Sub systems:

- Use meaningful channel names such as `orders`, `notifications`, or `chat:general`.

- Keep messages small to reduce network overhead.

- Handle subscriber disconnections gracefully in your application.

- Use Redis Streams instead of Pub/Sub if messages must be stored or replayed.

- Organize channels logically for easier maintenance and scalability.

- Monitor active channels and subscribers in production environments.

### Conclusion

Redis Pub/Sub provides a simple yet highly effective mechanism for building real-time communication between applications. By separating publishers from subscribers through channels, it enables fast, scalable, and loosely coupled messaging. Whether we are creating chat applications, live notification systems, multiplayer games, IoT solutions, or microservices, Pub/Sub allows information to flow instantly with minimal overhead. However, because messages are not stored and delivery is not guaranteed, Pub/Sub is best suited for live events rather than reliable message processing. Understanding its commands, architecture, strengths, and limitations helps us choose the right messaging approach for modern, high-performance applications.');

-- Lecture 8: Redis Streams
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Redis Streams', 8, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Redis Streams

Redis Streams is a powerful **append-only data structure** introduced in **Redis 5.0** for handling **real-time event streaming and message processing**. Unlike Redis Pub/Sub, where messages disappear after they are delivered, Redis Streams **stores messages permanently (until deleted or trimmed)**, allowing consumers to read them later. This makes Streams an excellent choice for applications that require reliable messaging, event logging, task queues, and data pipelines. Imagine a **company\'s daily logbook**. Every employee writes new events at the end of the book, and managers can review the entries at any time—even if they were not present when the events occurred. Redis Streams works in a similar way by storing every message in sequence, allowing consumers to process them whenever they are ready.

## Introduction to Redis Streams

### What Are Redis Streams?

A Redis Stream is an ordered sequence of messages where each message has:

- A unique ID

- One or more field-value pairs

- A chronological order

Each new message is added to the **end of the stream**. Example:

```

Orders Stream
↓
Message 1
↓
Message 2
↓
Message 3
↓
Message 4

```

Applications can continuously append new messages without modifying previous ones.

### Why Were Redis Streams Introduced?

Redis Pub/Sub is excellent for live communication, but it has limitations:

- Messages are not stored.

- Offline subscribers miss messages.

- No message history.

- No acknowledgment mechanism.

Redis Streams solve these problems by providing persistent, ordered message storage.

### Benefits of Redis Streams

Redis Streams provide:

- Persistent message storage

- Reliable message delivery

- Consumer groups

- Message acknowledgment

- Ordered event processing

- High performance

- Scalability

- Event replay capability

## Stream Structure

Each message in a Redis Stream consists of:

- A unique message ID

- Field-value pairs

Example:

```

ID: 1711111111111-0
user : Ali
action : Login

```

Another message:

```

ID: 1711111112222-0
user : Sara
action : Logout

```

Each message receives a unique identifier automatically.

### Message IDs

Redis automatically generates IDs. Format: `milliseconds-sequence` Example:

```

1689123456789-0
1689123456790-0
1689123456790-1

```

The first part represents the Unix timestamp in milliseconds. The second part distinguishes messages created within the same millisecond.

### Field-Value Pairs

Each stream entry stores structured information. Example:

```

temperature : 30
city : Lahore

```

Or:

```

product : Laptop
price : 85000
quantity : 2

```

## Basic Redis Stream Commands

Redis provides several commands to create and manage streams.

### 1. XADD

The `XADD` command adds a message to a stream. Syntax:

```

XADD stream_name * field value

```

Example:

```

XADD orders * customer "Anum" product "Laptop"

```

Output: `1711111111111-0` Redis automatically generates the message ID.

### 2. XRANGE

Retrieves messages within a specified range. Syntax: `XRANGE stream start end` Example: `XRANGE orders - +` Explanation:

- `-` = beginning of the stream

- `+` = end of the stream

This returns all messages.

### 3. XREVRANGE

Reads messages in reverse order. Example: `XREVRANGE orders + -` The newest messages appear first.

### 4. XLEN

Returns the total number of messages. Example: `XLEN orders` Output: `150`

### 5. XDEL

Deletes specific messages. Example: `XDEL orders 1711111111111-0`

### 6. XTRIM

Limits the stream size. Example: `XTRIM orders MAXLEN 1000` Only the latest **1000 messages** remain. Older messages are removed automatically.

## Reading Data from Streams

Redis allows different ways to read stream data.

### Reading Existing Messages

Example: `XRANGE orders - +` Flow:

```

Stream
↓
Read Messages
↓
Application

```

### Reading New Messages

Applications often wait for newly arriving data. Example: `XREAD STREAMS orders $` The `$` symbol means: `Read only new messages` This is useful for real-time event processing.

### Blocking Reads

Applications can wait until new messages arrive. Example:

```

XREAD BLOCK 5000 STREAMS orders $

```

Redis waits:

```

5000 milliseconds
↓
New Message Arrives
↓
Return Data

```

This avoids constant polling. One of the most powerful features of Redis Streams is **Consumer Groups**.

### What Are Consumer Groups?

A consumer group allows multiple consumers to share the workload. Instead of every consumer receiving every message:

```

Producer
↓
Stream
↓
Consumer Group
↓
Consumer A
Consumer B
Consumer C

```

Each message is delivered to only one consumer within the group.

### Creating a Consumer Group

Example:

```

XGROUP CREATE orders workers 0

```

Here:

- Stream = `orders`

- Group = `workers`

### Reading as a Consumer

Example:

```

XREADGROUP GROUP workers worker1 STREAMS orders >

```

The `>` symbol means: `Deliver only new messages`

### Message Acknowledgment

After processing a message:

```

XACK orders workers 1711111111111-0

```

Redis marks it as successfully processed.

### Pending Messages

If a consumer crashes before acknowledging a message:

```

Message
↓
Delivered
↓
Not Acknowledged
↓
Pending List

```

Another consumer can later claim and process the pending message.

## Practical Applications of Redis Streams

Redis Streams are used in many modern systems.

### 1. Order Processing

Online stores process orders using streams. Flow:

```

Customer Places Order
↓
Orders Stream
↓
Payment Service
↓
Inventory Service
↓
Shipping Service

```

Each service processes the order independently.

### 2. Event Logging

Applications generate many events. Examples:

- User login

- Password changes

- File uploads

- Purchases

Streams provide a reliable event log.

### 3. IoT Data Collection

Sensors continuously send readings. Example:

```

Temperature
↓
Humidity
↓
Pressure
↓
Redis Stream

```

Applications process the data later.

### 4. Chat Applications

Messages can be stored as stream entries. Advantages:

- Message history

- Offline delivery

- Reliable storage

### 5. Task Queues

Background jobs can be stored in streams. Workers consume tasks one at a time. Example tasks:

- Image processing

- Email sending

- Report generation

### 6. Financial Transactions

Banks often process events in order. Streams preserve chronological order while ensuring reliable processing.

## Redis Streams vs Pub/Sub

| Feature | Redis Streams | Redis Pub/Sub |
|---|---|---|
| Message Storage | Yes | No |
| Message History | Yes | No |
| Offline Consumers | Supported | Not Supported |
| Consumer Groups | Yes | No |
| Message Acknowledgment | Yes | No |
| Replay Messages | Yes | No |
| Best For | Reliable messaging | Live notifications |

### Advantages of Redis Streams

Redis Streams offer several benefits:

- Persistent messages

- Reliable delivery

- Consumer groups

- Ordered processing

- High throughput

- Event replay

- Message acknowledgment

- Fault tolerance

### Limitations of Redis Streams

Although powerful, Streams have some limitations.

### 1. Higher Memory Usage

Stored messages consume memory until removed or trimmed.

### 2. More Complex

Streams require additional concepts such as:

- Consumer groups

- Acknowledgments

- Pending messages

### 3. Maintenance Required

Applications should periodically trim old messages to prevent streams from growing indefinitely.

## Best Practices

To use Redis Streams efficiently:

- Use meaningful stream names such as `orders`, `payments`, or `notifications`.

- Create consumer groups for scalable processing.

- Acknowledge processed messages using `XACK`.

- Monitor pending messages to detect failed consumers.

- Trim old messages using `XTRIM` to control memory usage.

- Use blocking reads (`XREAD BLOCK`) to reduce unnecessary polling.

- Design consumers to handle duplicate processing if a message is re-delivered.

### Common Redis Stream Commands

| Command | Description |
|---|---|
| XADD | Add a message to a stream |
| XRANGE | Read messages in a range |
| XREVRANGE | Read messages in reverse order |
| XREAD | Read stream messages |
| XREADGROUP | Read messages using a consumer group |
| XGROUP CREATE | Create a consumer group |
| XACK | Acknowledge a processed message |
| XPENDING | View pending messages |
| XDEL | Delete a message |
| XTRIM | Trim old messages |
| XLEN | Count messages in a stream |

### Conclusion

Redis Streams is a robust and reliable data structure designed for **event streaming, message queues, and real-time data processing**. Unlike Redis Pub/Sub, Streams persist messages, support consumer groups, provide message acknowledgments, and allow offline consumers to process missed events. These features make Redis Streams ideal for applications such as order processing, event logging, IoT systems, background task queues, chat services, and financial transaction processing. By understanding commands like `XADD`, `XREAD`, `XGROUP`, `XACK`, and `XTRIM`, developers can build scalable, fault-tolerant, and high-performance messaging systems that ensure reliable data delivery and efficient workload distribution.');

-- Lecture 9: Transactions in Redis
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Transactions in Redis', 9, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Transactions in Redis

Redis is designed for high-speed data processing and supports **transactions**, allowing multiple commands to be grouped and executed as a single unit. Transactions ensure that a sequence of commands is executed **in order** without interruption from other clients. This is particularly useful when several related operations must be performed together to maintain data consistency. Imagine withdrawing money from an ATM. The system must first check your balance, deduct the amount, and then update your account. If these steps were interrupted halfway, your account could become inconsistent. Redis transactions help prevent such situations by executing grouped commands sequentially. Unlike traditional relational databases, Redis transactions do **not** support full ACID (Atomicity, Consistency, Isolation, Durability) properties. However, they provide an efficient way to execute multiple commands together while maintaining command order and preventing interleaving from other clients.

## Understanding Redis Transactions

### What Is a Transaction?

A transaction is a group of commands that Redis executes together. Instead of sending commands individually:

```

SET balance 5000
DECRBY balance 1000
INCR withdrawals

```

We group them into one transaction. This ensures that all commands execute consecutively without another client\'s commands being inserted between them.

### Why Use Transactions?

Transactions are useful when multiple commands are logically connected. Benefits include:

- Execute multiple commands together

- Prevent command interleaving

- Improve data consistency

- Simplify application logic

- Support optimistic locking with `WATCH`

### Real-Life Example

Consider an online bookstore. When a customer purchases a book: 1. Reduce the inventory. 2. Increase the total sales. 3. Record the purchase. These actions should happen together to keep the system consistent.

## Redis Transaction Commands

Redis transactions are built using four primary commands:

- `MULTI`

- `EXEC`

- `DISCARD`

- `WATCH`

### 1. MULTI

The `MULTI` command starts a transaction. Syntax: `MULTI` After calling `MULTI`, Redis does **not** execute commands immediately. Instead, it places them in a queue. Example:

```

MULTI
SET name "Anum"
SET city "Sukkur"
INCR visitors

```

Output:

```

QUEUED
QUEUED
QUEUED

```

No command has executed yet.

### 2. EXEC

`EXEC` executes all queued commands. Example: `EXEC` Redis processes every queued command in order. Result:

```

OK
OK
1

```

After execution, the transaction ends automatically.

### 3. DISCARD

Sometimes we decide not to execute the transaction. Example:

```

MULTI
SET age 21
SET city "Karachi"
DISCARD

```

The queued commands are removed. Nothing is written to Redis.

### 4. WATCH

`WATCH` provides **optimistic locking**. It monitors one or more keys before the transaction begins. If another client changes a watched key before `EXEC`, Redis cancels the transaction. Example:

```

WATCH balance
MULTI
EXEC

```

If another client modifies `balance` before `EXEC`, the transaction fails.

## How Redis Transactions Work

Redis transactions follow a simple sequence.

### Step 1: Begin Transaction

`MULTI` Redis enters transaction mode.

### Step 2: Queue Commands

Example:

```

SET user "Ali"
INCR visits
SET city "Lahore"

```

Redis responds:

```

QUEUED
QUEUED
QUEUED

```

Commands are stored but not executed.

### Step 3: Execute

`EXEC` Redis executes every queued command. Flow:

```

Client
↓
MULTI
↓
Queue Commands
↓
EXEC
↓
Redis Executes Everything

```

### Transaction Execution Example

```

MULTI
SET product "Laptop"
SET price 80000
INCR products
EXEC

```

Output:

```

OK
OK
1

```

All commands execute together.

## Optimistic Locking with WATCH

One challenge in multi-user systems is preventing conflicting updates. Redis solves this using **optimistic locking**.

### What Is Optimistic Locking?

Optimistic locking assumes conflicts are rare. Instead of locking the data immediately, Redis checks whether the watched key has changed before executing the transaction.

### Example

Suppose two users try to update the same bank balance. Current balance: `5000` **Client A**

```

WATCH balance
MULTI
DECRBY balance 1000
EXEC

```

**Client B** Before Client A executes: `SET balance 3000` Now Client A executes: `EXEC` Output: `(nil)` The transaction is cancelled because the watched key changed.

### Why WATCH Is Useful

It helps prevent problems such as:

- Double spending

- Lost updates

- Conflicting modifications

- Data inconsistency

## Practical Applications of Redis Transactions

Redis transactions are useful in many real-world applications.

### 1. Banking Systems

Money transfers involve multiple operations. Example:

```

Deduct Money
↓
Add Money
↓
Save Transaction

```

These operations should be grouped together.

### 2. E-Commerce Orders

When a customer buys a product:

- Reduce stock

- Increase sales count

- Save the order

Transaction example:

```

MULTI
DECR stock
INCR sales
SET order:100 "Completed"
EXEC

```

### 3. User Registration

Registering a user may involve:

- Saving user details

- Creating a profile

- Initializing settings

These actions can be grouped in a transaction.

### 4. Gaming Applications

When a player wins:

- Increase score

- Award coins

- Unlock achievements

Executing these together ensures consistent game data.

### 5. Inventory Management

Warehouses frequently update stock. Transactions ensure inventory counts remain consistent during multiple updates.

## Error Handling in Transactions

Redis handles errors differently from traditional databases.

### Syntax Errors

If Redis detects a syntax error before `EXEC`, the transaction will not execute. Example:

```

MULTI
SET
INCR counter
EXEC

```

Redis reports the invalid command, and the transaction is rejected.

### Runtime Errors

If one command fails during execution:

```

MULTI
SET age "Twenty"
INCR age
SET city "Lahore"
EXEC

```

Output:

```

OK
(error)
OK

```

Redis continues executing the remaining commands. Unlike many SQL databases, Redis does **not** automatically roll back previously executed commands.

## Redis Transactions vs SQL Transactions

| Feature | Redis Transactions | SQL Transactions |
|---|---|---|
| Command Grouping | Yes | Yes |
| Rollback Support | No | Yes |
| Command Order Guaranteed | Yes | Yes |
| Optimistic Locking | Yes ( WATCH) | Depends on DBMS |
| ACID Compliance | Partial | Full (typically) |
| Performance | Very Fast | Slower |

### Advantages of Redis Transactions

Redis transactions provide several benefits:

- Fast execution

- Simple implementation

- Prevent command interleaving

- Support optimistic locking

- Suitable for many real-time applications

- Minimal overhead

### Limitations of Redis Transactions

Redis transactions also have limitations.

### 1. No Automatic Rollback

Executed commands are not reversed if a later command fails.

### 2. Limited ACID Support

Redis does not provide full transactional guarantees like traditional relational databases.

### 3. Runtime Errors Continue

A runtime error in one command does not stop the remaining queued commands from executing.

### Best Practices

To use Redis transactions effectively:

- Use `MULTI` and `EXEC` to group related operations.

- Use `WATCH` when multiple clients may modify the same data.

- Validate input before starting a transaction to reduce runtime errors.

- Keep transactions short for better performance.

- Handle failed `WATCH` transactions by retrying them in the application.

- Use Lua scripts when multiple operations must execute atomically with more complex logic.

### Common Redis Transaction Commands

| Command | Description |
|---|---|
| MULTI | Starts a transaction |
| EXEC | Executes all queued commands |
| DISCARD | Cancels the transaction |
| WATCH key | Monitors keys for changes |
| UNWATCH | Stops monitoring watched keys |

### Conclusion

Redis transactions provide an efficient way to execute multiple related commands as a single logical unit while ensuring that no other client\'s commands are interleaved during execution. Using commands such as `MULTI`, `EXEC`, `DISCARD`, and `WATCH`, developers can build reliable applications that maintain data consistency in scenarios like banking, e-commerce, gaming, and inventory management. Although Redis transactions do not support automatic rollback or full ACID compliance like traditional relational databases, they offer excellent performance and, when combined with optimistic locking through `WATCH`, provide a practical solution for managing concurrent updates in high-speed, real-time systems.');

-- Lecture 10: Redis Persistence (RDB & AOF)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Redis Persistence (RDB & AOF)', 10, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Redis Persistence (RDB & AOF)

Redis is primarily an **in-memory database**, meaning it stores data in **RAM (Random Access Memory)**. While this makes Redis incredibly fast, it also creates a challenge: **What happens if the server crashes or loses power?** Since RAM is volatile memory, all stored data would normally disappear. To solve this problem, Redis provides **Persistence**, a mechanism that saves data to disk so it can be recovered after a restart. Redis offers two main persistence methods:

- **RDB (Redis Database Backup)**

- **AOF (Append Only File)**

These methods help ensure that important data is not permanently lost. Developers can use either one individually or combine both for better reliability.

## Understanding Redis Persistence

### What Is Persistence?

Persistence is the process of saving in-memory data to permanent storage (disk). Without persistence:

```

Application
↓
Redis (RAM)
↓
Power Failure
↓
All Data Lost

```

With persistence:

```

Application
↓
Redis (RAM)
↓
Disk Storage
↓
Restart
↓
Data Restored

```

Persistence allows Redis to recover previously stored data after a server restart.

### Why Is Persistence Important?

Many applications cannot afford to lose their data. Examples include:

- User sessions

- Shopping carts

- Banking information

- Product inventory

- Game progress

- Analytics data

Persistence provides:

- Data recovery after crashes

- Backup creation

- Disaster recovery

- Improved reliability

- Better fault tolerance

### Types of Persistence

Redis supports two primary persistence methods:

| Method | Description |
|---|---|
| RDB | Saves snapshots of the entire dataset at specific intervals. |
| AOF | Records every write operation in a log file. |

Developers may use:

- Only RDB

- Only AOF

- Both RDB and AOF together

## Redis Database Backup (RDB)

### What Is RDB?

RDB (**Redis Database Backup**) creates a **snapshot** of the entire Redis dataset at a particular point in time. Think of it as taking a photograph. Imagine photographing your room every evening. If something is lost the next day, you can restore the room to how it looked when the photo was taken. Similarly, Redis saves the complete database into a binary file called: `dump.rdb`

### How RDB Works

The process is simple:

```

Redis Memory
↓
Take Snapshot
↓
Save dump.rdb
↓
Disk

```

If Redis restarts, it loads the latest snapshot from the disk.

### Automatic Snapshots

Redis can automatically create snapshots after certain conditions are met. Example configuration:

```

save 900 1
save 300 10
save 60 10000

```

Meaning:

| Configuration | Meaning |
|---|---|
| save 900 1 | Save if at least 1 key changes in 900 seconds (15 minutes). |
| save 300 10 | Save if 10 keys change within 300 seconds (5 minutes). |
| save 60 10000 | Save if 10,000 keys change within 60 seconds. |

These rules are defined in the Redis configuration file.

### Manual Snapshot

A snapshot can also be created manually. Command: `SAVE` This blocks Redis until the snapshot is completed. A better alternative is: `BGSAVE BGSAVE` creates the snapshot in the background without blocking client requests.

### Advantages of RDB

- Very fast recovery

- Small backup files

- Efficient storage

- Excellent for backups

- Suitable for disaster recovery

- Minimal impact on read performance

### Disadvantages of RDB

- Possible data loss between snapshots

- Less suitable for applications requiring every write to be preserved

- Snapshot creation can consume CPU and disk resources

For example:

```

Snapshot Taken
↓
10 Minutes Pass
↓
Server Crash
↓
Recent Changes Lost

```

Any changes made after the last snapshot are not recovered.

## Append Only File (AOF)

### What Is AOF?

AOF (**Append Only File**) records **every write operation** executed on Redis. Instead of saving the whole database occasionally, Redis logs each command that changes data. Example:

```

SET user "Ali"
SET age "22"
DEL age

```

All these commands are stored in the AOF file.

### How AOF Works

Flow:

```

Redis
↓
Write Command
↓
Append to AOF File
↓
Disk

```

When Redis restarts, it replays these commands one by one to rebuild the dataset.

### Example AOF File

```

SET name "Anum"
SET city "Sukkur"
SET age "21"
DEL age

```

Redis executes these commands during startup to restore the previous state.

### AOF Synchronization Policies

Redis provides different options for writing AOF data to disk.

### Always

`appendfsync always` Every write is immediately saved. **Advantages**

- Maximum durability

- Minimal data loss

**Disadvantages**

- Slowest performance

### Every Second (Recommended)

`appendfsync everysec` Redis writes data to disk once every second. **Advantages**

- Good balance between speed and safety

- Very common production setting

**Disadvantages**

- Up to one second of data may be lost during a crash

### No

`appendfsync no` The operating system decides when to write data. **Advantages**

- Highest write performance

**Disadvantages**

- Greater risk of data loss

### AOF Rewrite

Over time, the AOF file can become very large because every write operation is recorded. Redis solves this using **AOF Rewrite**. Example: Instead of storing:

```

SET count 1
SET count 2
SET count 3
SET count 4
SET count 5

```

Redis rewrites it as: `SET count 5` The rewritten file represents the current database state while removing unnecessary historical commands.

### Advantages of AOF

- Better durability

- Lower risk of data loss

- Human-readable file format

- Supports AOF Rewrite

- Suitable for applications requiring reliable recovery

### Disadvantages of AOF

- Larger file sizes than RDB

- Slower write performance

- Recovery may take longer because commands must be replayed

## RDB vs AOF

Both persistence methods have different strengths.

| Feature | RDB | AOF |
|---|---|---|
| Storage Method | Snapshot | Command Log |
| File Size | Smaller | Larger |
| Recovery Speed | Faster | Slower |
| Data Safety | Moderate | Higher |
| Performance | Faster | Slightly Slower |
| Human Readable | No | Yes |
| Backup Suitability | Excellent | Good |
| Risk of Data Loss | Higher | Lower |

### When Should You Use RDB?

Choose RDB when:

- Fast backups are needed

- Quick recovery is important

- Small backup files are preferred

- Some data loss is acceptable

Examples:

- Analytics data

- Temporary cache

- Periodic backups

- Test environments

### When Should You Use AOF?

Choose AOF when:

- Data durability is critical

- Every write operation matters

- Data loss must be minimized

Examples:

- Financial systems

- User account information

- Online orders

- Inventory management

### Using Both RDB and AOF

Many production systems enable both persistence methods. Flow:

```

Redis
↓
RDB Snapshot
+
AOF Logging
↓
Disk

```

Benefits include:

- Fast recovery using RDB

- Increased reliability

- Additional backup protection

If both files exist, Redis typically uses the **AOF file** because it usually contains the most recent data.

## Best Practices for Redis Persistence

To ensure reliable and efficient persistence:

- Use **BGSAVE** instead of **SAVE** to avoid blocking client requests.

- Use **appendfsync everysec** for a balance between performance and durability.

- Enable **AOF Rewrite** to keep AOF files compact.

- Regularly back up persistence files to another server or cloud storage.

- Monitor disk space, as persistence files can grow over time.

- Test backup and recovery procedures before deploying to production.

- Use both **RDB and AOF** together for critical applications whenever possible.

### Common Persistence Commands

| Command | Description |
|---|---|
| SAVE | Creates an RDB snapshot (blocks Redis) |
| BGSAVE | Creates an RDB snapshot in the background |
| LASTSAVE | Returns the timestamp of the last successful snapshot |
| BGREWRITEAOF | Rewrites the AOF file in the background |

### Real-World Applications

Redis persistence is commonly used in:

### 1. E-Commerce Websites

Stores shopping carts, orders, and inventory safely.

### 2. Banking Systems

Protects account balances and transaction data.

### 3. Online Gaming

Preserves player progress, scores, and achievements.

### 4. Social Media Platforms

Retains user sessions, posts, and notifications.

### 5. Analytics Platforms

Maintains event logs and usage statistics across server restarts.

### Conclusion

Redis persistence ensures that valuable in-memory data is not lost during server crashes, power failures, or restarts. **RDB** provides fast, compact snapshots that are ideal for backups and quick recovery, while **AOF** offers greater durability by recording every write operation, making it suitable for applications where minimizing data loss is essential. By understanding the strengths and trade-offs of each method, developers can choose the persistence strategy that best fits their application\'s requirements. In many production environments, enabling both **RDB and AOF** provides an excellent balance of performance, reliability, and data protection, ensuring that Redis remains both fast and dependable.');

-- Lecture 11: Redis Replication & Clustering Basics
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Redis Replication & Clustering Basics', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Redis Replication & Clustering Basics

As applications grow, a single Redis server may no longer be enough to handle increasing traffic, large amounts of data, or unexpected server failures. Imagine an online shopping website during a major sale. Millions of users may be browsing products, adding items to their carts, and completing purchases simultaneously. If all requests are handled by one Redis server, it can become overloaded or even fail. To solve these challenges, Redis provides **Replication** and **Clustering**. **Replication** creates copies of data across multiple servers to improve availability and reliability, while **Clustering** distributes data across multiple Redis servers to increase storage capacity and performance. Think of a large library. Instead of keeping all books in one room, the library creates multiple branches. Some branches keep copies of popular books (Replication), while different branches specialize in storing different categories of books (Clustering). This improves both reliability and efficiency.

## Understanding Redis Replication

### What Is Replication?

Replication is the process of copying data from one Redis server to one or more additional Redis servers. The primary server is called the **Master** (or **Primary**), and the copied servers are called **Replicas** (or **Replicas/Secondary nodes**). Basic architecture:

```

Master
│
┌─────────┴─────────┐
│ │
Replica 1 Replica 2

```

Whenever data changes on the master, Redis automatically sends those updates to all replicas.

### Why Use Replication?

Replication provides several important benefits:

- High availability

- Data redundancy

- Faster read performance

- Backup servers

- Disaster recovery

- Improved fault tolerance

Without replication:

```

Application
↓
Single Redis Server
↓
Server Failure
↓
Application Stops

```

With replication:

```

Application
↓
Master
↓
Replicas
↓
Application Continues

```

### How Replication Works

When a replica connects: 1. It copies the entire dataset from the master. 2. The master continues sending every new write operation. 3. The replica stays synchronized. Flow:

```

Client
↓
Master
↓
Replica 1
↓
Replica 2

```

All write operations occur on the master.

## Master and Replica Architecture

### Master Node

The master server accepts:

- Read operations

- Write operations

Example: `SET product:101 "Laptop"` The master stores the value and sends the update to every replica.

### Replica Node

Replicas mainly serve:

- Read operations

- Backup purposes

- High availability

Example: `GET product:101` Clients can retrieve data from replicas without increasing the master\'s workload.

### Replication Example

Suppose the master contains:

```

User: Ali
Balance: 5000

```

Master executes: `SET balance 6000` Redis automatically updates:

```

Master
↓
Replica 1
↓
Replica 2

```

All servers now contain: `Balance: 6000`

## Configuring Replication

Redis replication is simple to configure.

### Creating a Replica

A Redis server can become a replica using: `REPLICAOF 192.168.1.10 6379` Meaning:

```

Replica
↓
Connect
↓
Master
↓
Copy Data

```

The replica begins synchronizing automatically.

### Checking Replication Status

Command: `INFO replication` Example output:

```

role:master
connected_slaves:2

```

Or on a replica:

```

role:slave
master_host:192.168.1.10

```

This helps administrators monitor the replication setup.

### Read and Write Behavior

| Operation | Master | Replica |
|---|---|---|
| Read | Yes | Yes |
| Write | Yes | No |

Replicas are generally **read-only** to maintain consistency.

## Failover and High Availability

### What Is Failover?

Failover means automatically replacing a failed master with a healthy replica. Example:

```

Master
↓
Crash
↓
Replica Promoted
↓
New Master

```

Applications continue working with minimal interruption.

### Redis Sentinel

Redis provides **Redis Sentinel** to monitor servers and perform automatic failover. Responsibilities of Sentinel:

- Monitor Redis instances

- Detect failures

- Promote a replica to master

- Notify applications

- Manage configuration updates

Architecture:

```

Sentinel
│
┌──────┴──────┐
Master Replica
│
Replica

```

Sentinel continuously checks server health.

### Advantages of Replication

Replication offers:

- Backup copies

- High availability

- Improved read performance

- Fault tolerance

- Better reliability

### Limitations of Replication

Some limitations include:

- Replication delay (replicas may briefly lag behind the master)

- Increased memory usage

- Extra network traffic

- Writes still go only to the master

## Understanding Redis Clustering

### What Is Redis Cluster?

Redis Cluster distributes data across multiple Redis servers. Instead of storing everything on one server:

```

Server 1
↓
Everything

```

The data is divided among multiple servers:

```

Server 1
↓
Keys A–M
Server 2
↓
Keys N–Z

```

This increases both storage capacity and performance.

### Why Use Clustering?

Clustering helps when:

- Data no longer fits on one server

- Traffic becomes extremely high

- Applications require horizontal scaling

- Better fault tolerance is needed

### Horizontal Scaling

Redis Cluster scales horizontally. Instead of upgrading one server: `Bigger Server` We add more servers:

```

Server A
Server B
Server C
Server D

```

Each server stores part of the dataset.

## Hash Slots in Redis Cluster

Redis Cluster divides all keys into **16,384 hash slots**. Each server is responsible for a range of slots. Example:

```

Server A
Slots 0–5460
Server B
Slots 5461–10922
Server C
Slots 10923–16383

```

When a key is stored:

```

User:100
↓
Hash Function
↓
Slot Number
↓
Correct Server

```

Redis automatically routes the request.

### Example

Key: `user:101` Hash function:

```

Hash
↓
Slot 7400

```

Redis stores it on the server responsible for slot **7400**.

## Replication Inside a Cluster

Clusters usually combine **clustering** and **replication**. Example:

```

Master A
↓
Replica A
Master B
↓
Replica B
Master C
↓
Replica C

```

Benefits:

- Data distribution

- Automatic backups

- High availability

- Fault tolerance

If one master fails:

```

Master B
↓
Crash
↓
Replica B
↓
New Master

```

The cluster continues serving requests.

## Practical Applications

Redis Replication and Clustering are widely used in modern systems.

### 1. E-Commerce Platforms

Large online stores use clusters for:

- Product catalogs

- Shopping carts

- Session storage

### 2. Social Media

Millions of users generate:

- Posts

- Likes

- Comments

- Notifications

Clusters distribute this workload efficiently.

### 3. Online Gaming

Games store:

- Leaderboards

- Player sessions

- Matchmaking information

Replication ensures availability if a server fails.

### 4. Banking Systems

Financial applications require:

- High availability

- Fast data access

- Reliable backups

Replication supports continuous operation.

### 5. Streaming Services

Platforms serving videos or music use Redis for:

- User sessions

- Recommendations

- Caching

Clusters manage large volumes of requests.

## Best Practices

To build a reliable Redis deployment:

- Use replication for high availability.

- Use Redis Cluster for large datasets and horizontal scaling.

- Monitor replication lag regularly.

- Deploy Redis Sentinel for automatic failover in non-clustered environments.

- Distribute traffic across replicas for read-heavy applications.

- Back up Redis data even when replication is enabled.

- Secure communication between Redis nodes.

- Continuously monitor memory, CPU, and network usage.

### Replication vs Clustering

| Feature | Replication | Clustering |
|---|---|---|
| Purpose | High Availability | Horizontal Scaling |
| Data Storage | Same data on all replicas | Data divided across nodes |
| Read Scaling | Yes | Yes |
| Write Scaling | No | Yes (distributed across masters) |
| Fault Tolerance | Yes | Yes |
| Storage Capacity | Unchanged | Increased |
| Best For | Reliability | Large datasets and high traffic |

### Common Commands

| Command | Description |
|---|---|
| INFO replication | Display replication information |
| REPLICAOF host port | Configure a replica |
| ROLE | Show the current server role |
| CLUSTER INFO | Display cluster status |
| CLUSTER NODES | List all nodes in the cluster |
| CLUSTER SLOTS | Show hash slot assignments |

### Conclusion

Redis **Replication** and **Clustering** are essential technologies for building scalable, reliable, and high-performance Redis deployments. Replication improves **availability, fault tolerance, and read performance** by maintaining synchronized copies of data across multiple servers, while Clustering enables **horizontal scaling** by distributing data across several nodes using hash slots. Together, these features allow Redis to support applications with millions of users, large datasets, and demanding performance requirements. By combining replication, clustering, and tools such as **Redis Sentinel** for automatic failover, developers can create resilient systems capable of handling failures gracefully while delivering fast and reliable access to data.');

-- Lecture 12: Redis with Node.js/Python (Client Libraries)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Redis with Node.js/Python (Client Libraries)', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Redis with Node.js/Python (Client Libraries)

Redis is a standalone database server, but applications communicate with it through **client libraries**. These libraries act as a bridge between the programming language and the Redis server, allowing developers to execute Redis commands directly from their code. Whether we are building web applications, REST APIs, chat systems, or caching services, Redis client libraries make it simple to store, retrieve, and manage data. For **Node.js**, the most commonly used client library is `redis`, while for **Python**, the standard library is `redis-py`. Both libraries provide simple APIs for interacting with Redis and support advanced features such as transactions, Pub/Sub, Streams, pipelines, and caching. Think of Redis as a **warehouse** full of valuable information. The client library is like a **delivery truck** that carries requests from your application to the warehouse and brings the results back.

## Introduction to Redis Client Libraries

### What Is a Redis Client Library?

A Redis client library is a software package that enables an application to communicate with a Redis server. Instead of typing Redis commands in the terminal: `SET username "Anum"` We can write code like: **Node.js**

```

await client.set("username", "Anum");

```

**Python** `r.set("username", "Anum")` The client library converts these programming statements into Redis commands.

### Why Use Client Libraries?

Client libraries simplify Redis integration. Benefits include:

- Easy connection to Redis

- Execute Redis commands through code

- Support asynchronous programming

- Built-in error handling

- Cross-platform compatibility

- Access to advanced Redis features

### Popular Redis Client Libraries

| Programming Language | Popular Client Library |
|---|---|
| Node.js | redis |
| Python | redis-py |
| Java | Jedis, Lettuce |
| PHP | Predis |
| Go | go-redis |
| C# | StackExchange.Redis |

This lecture focuses on **Node.js** and **Python**.

## Using Redis with Node.js

### Installing the Redis Client

Install the official Redis package using npm: `npm install redis` This downloads and installs the Redis client library.

### Importing the Library

```

import { createClient } from "redis";

```

Or using CommonJS:

```

const { createClient } = require("redis");

```

### Creating a Client

```

const client = createClient();

```

### Connecting to Redis

```

await client.connect();

```

After connecting, the application can execute Redis commands.

### Basic Example

```

import { createClient } from "redis";
const client = createClient();
await client.connect();
await client.set("name", "Anum");
const value = await client.get("name");
console.log(value);
await client.quit();

```

Output: `Anum`

### Storing Data

```

await client.set("city", "Lahore");

```

### Retrieving Data

```

const city = await client.get("city");

```

### Deleting Data

```

await client.del("city");

```

### Setting Expiration

```

await client.set("otp", "123456", {
EX: 300
});

```

The OTP expires after five minutes.

## Using Redis with Python

### Installing redis-py

Install using pip: `pip install redis`

### Importing the Library

```

import redis

```

### Creating a Connection

```

r = redis.Redis(
host="localhost",
port=6379,
decode_responses=True
)

```

`decode_responses=True` automatically converts Redis responses into Python strings.

### Basic Example

```

import redis
r = redis.Redis(
host="localhost",
port=6379,
decode_responses=True
)
r.set("name", "Anum")
print(r.get("name"))

```

Output: `Anum`

### Deleting Keys

`r.delete("name")`

### Setting Expiration

```

r.set("session", "active", ex=1800)

```

The key expires after **30 minutes**.

### Checking TTL

`print(r.ttl("session"))` Output: `1750` Meaning the key has **1750 seconds** remaining.

## Common Redis Operations Using Client Libraries

Both Node.js and Python support almost every Redis command.

### Strings

### Node.js

```

await client.set("language", "JavaScript");
console.log(await client.get("language"));

```

### Python

```

r.set("language", "Python")
print(r.get("language"))

```

### Lists

### Node.js

```

await client.lPush("tasks", "Study Redis");

```

### Python

```

r.lpush("tasks", "Study Redis")

```

### Hashes

### Node.js

```

await client.hSet("user:1", {
name: "Ali",
age: 22
});

```

### Python

```

r.hset(
"user:1",
mapping={
"name": "Ali",
"age": 22
}
)

```

### Sets

### Node.js

```

await client.sAdd("students", "Ahmed");

```

### Python

`r.sadd("students", "Ahmed")`

### Sorted Sets

### Node.js

```

await client.zAdd("scores", [
{
score: 95,
value: "Ali"
}
]);

```

### Python

```

r.zadd(
"scores",
{"Ali": 95}
)

```

## Advanced Features

Redis client libraries support advanced functionality.

### Transactions

### Node.js

```

const multi = client.multi();
multi.set("x", 10);
multi.set("y", 20);
await multi.exec();

```

### Python

```

pipe = r.pipeline()
pipe.set("x", 10)
pipe.set("y", 20)
pipe.execute()

```

### Pub/Sub

### Node.js Publisher

```

await client.publish(
"news",
"Redis is fast!"
);

```

### Python Publisher

```

r.publish(
"news",
"Redis is fast!"
)

```

Subscribers receive the message immediately.

### Pipelines

Pipelines improve performance by sending multiple commands together.

### Node.js

```

const pipeline = client.multi();
pipeline.set("a", 1);
pipeline.set("b", 2);
await pipeline.exec();

```

### Python

```

pipe = r.pipeline()
pipe.set("a", 1)
pipe.set("b", 2)
pipe.execute()

```

This reduces network round trips between the application and Redis.

### Connection Closing

Always close the connection after completing operations.

### Node.js

```

await client.quit();

```

### Python

`r.close()` Closing connections releases system resources.

## Practical Applications

Redis client libraries are used in many real-world applications.

### 1. Session Management

Store user sessions. Example:

```

User Login
↓
Redis
↓
Session Stored

```

### 2. API Caching

Cache expensive API responses. Example:

```

Application
↓
Redis Cache
↓
Database/API

```

Repeated requests are served much faster.

### 3. Authentication

Store temporary authentication tokens. Example:

```

r.set("token", "ABC123", ex=3600)

```

### 4. Shopping Cart

Store temporary shopping carts. Example:

```

await client.hSet(
"cart:user45",
{
product: "Laptop",
quantity: 2
}
);

```

### 5. Leaderboards

Games use Redis Sorted Sets to manage rankings efficiently.

### 6. Background Jobs

Applications use Redis queues or Streams to process background tasks such as:

- Sending emails

- Image processing

- Report generation

- Notifications

## Best Practices

To use Redis client libraries effectively:

- Reuse a single Redis connection whenever possible instead of creating a new connection for every request.

- Handle connection errors gracefully.

- Use asynchronous operations in Node.js with `async/await`.

- Set TTL values for temporary data such as sessions and cache entries.

- Close connections properly when the application shuts down.

- Use pipelines for bulk operations to improve performance.

- Avoid storing extremely large objects in Redis.

- Use meaningful key names such as `user:101`, `cart:45`, or `session:abc123`.

### Node.js vs Python Redis Client

| Feature | Node.js ( redis) | Python ( redis-py) |
|---|---|---|
| Installation | npm install redis | pip install redis |
| Async Support | Native ( async/await) | Synchronous by default (async version also available) |
| Official Client | Yes | Yes |
| Transactions | Supported | Supported |
| Pub/Sub | Supported | Supported |
| Streams | Supported | Supported |
| Pipelines | Supported | Supported |

### Common Methods

| Operation | Node.js | Python |
|---|---|---|
| Connect | connect() | Redis() |
| Set Value | set() | set() |
| Get Value | get() | get() |
| Delete | del() | delete() |
| Set TTL | set(..., EX) | set(..., ex=) |
| Publish | publish() | publish() |
| Close Connection | quit() | close() |

### Conclusion

Redis client libraries make it easy for applications to communicate with a Redis server using familiar programming languages. The official `redis` library for Node.js and `redis-py` for Python provide simple, efficient, and feature-rich APIs for executing Redis commands, managing data structures, handling transactions, implementing Pub/Sub messaging, working with Streams, and improving application performance through caching. By following best practices such as reusing connections, using pipelines, handling errors properly, and setting appropriate expiration times, developers can build scalable, high-performance applications that take full advantage of Redis\'s speed and flexibility.');
