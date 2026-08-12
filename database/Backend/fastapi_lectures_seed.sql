-- =============================================
-- ReflectAI — FastAPI Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'FastAPI' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to FastAPI
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to FastAPI', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to FastAPI

## What is FastAPI?

### Definition of FastAPI

**FastAPI** is a modern, high-performance Python web framework used for building **Application Programming Interfaces (APIs)** quickly and efficiently. It was created by **Sebastián Ramírez** and was first released in **2018**. FastAPI is designed to help developers build secure, scalable, and fast web applications with minimal code while taking full advantage of Python\'s type hints. Unlike traditional web frameworks that require a significant amount of setup, FastAPI focuses on simplicity and developer productivity. With just a few lines of code, we can create professional APIs that automatically generate interactive documentation, validate data, and return responses in JSON format. In simple terms, FastAPI enables us to build the **backend** of applications that can communicate with websites, mobile applications, desktop software, and other services through APIs.

### Why is FastAPI Called "Fast"?

The name **FastAPI** reflects two important aspects of the framework.

### 1. High Performance

FastAPI is one of the fastest Python web frameworks available. It is built on **Starlette**, a lightweight framework for web applications, and **Pydantic**, a library for data validation and serialization. Together, these technologies provide excellent performance, allowing FastAPI to process many requests efficiently.

### 2. Faster Development

FastAPI reduces repetitive coding by automatically handling many common tasks, including:

- Request validation

- Response formatting

- Data serialization

- Interactive API documentation

- Error handling

As a result, developers spend less time writing boilerplate code and more time building application features.

### What Can We Build with FastAPI?

FastAPI is suitable for developing a wide range of applications, including:

- RESTful APIs

- Backend services for web applications

- Mobile application backends

- Authentication systems

- E-commerce APIs

- Blogging platforms

- Hospital Management Systems

- Learning Management Systems

- Banking applications

- Machine Learning APIs

- AI-powered services

- Microservices

Its flexibility makes it suitable for both small personal projects and large enterprise systems.

## Features of FastAPI

### High Performance

FastAPI delivers outstanding speed by using asynchronous programming and modern Python features. It performs similarly to frameworks written in lower-level languages, making it an excellent choice for applications that require high performance.

### Easy to Learn

If we already know Python, learning FastAPI is straightforward. Its clean syntax and simple structure allow us to build APIs with very little code. Example:

```

from fastapi import FastAPI
app = FastAPI()
def home():
return {"message": "Hello FastAPI"}

```

With just a few lines, we have created our first API endpoint.

### Automatic Data Validation

FastAPI automatically validates incoming data using Python type hints. For example: `age: int` If a user sends a string instead of an integer, FastAPI immediately returns a validation error without requiring additional code. This built-in validation reduces bugs and improves application reliability.

### Automatic API Documentation

One of FastAPI\'s most impressive features is its ability to generate interactive API documentation automatically. After starting the server, documentation is available at: `http://127.0.0.1:8000/docs` This interactive interface allows developers to test API endpoints directly from the browser. FastAPI also provides an alternative documentation interface at: `http://127.0.0.1:8000/redoc` These documentation pages are generated automatically based on the application\'s code.

### Based on Modern Python

FastAPI fully embraces modern Python features, including:

- Type hints

- Async programming

- Dependency injection

- Data models

- Automatic serialization

This results in cleaner, more maintainable code.

## Why Choose FastAPI?

### Reduced Development Time

FastAPI eliminates much of the repetitive code required in traditional frameworks. Features such as validation, serialization, and documentation are handled automatically. This allows developers to build APIs more quickly while maintaining high code quality.

### Excellent Developer Experience

FastAPI improves productivity through:

- Clear error messages

- Automatic documentation

- Strong editor support

- Code completion

- Type checking

Modern code editors can understand FastAPI\'s type hints, making development smoother and reducing errors.

### Scalability

FastAPI is suitable for projects of all sizes. Whether we are building:

- A simple personal project

- A startup application

- A corporate system

- A cloud-based service

FastAPI can scale to meet increasing demands.

### Security

FastAPI includes support for modern authentication methods, including:

- OAuth2

- JWT (JSON Web Tokens)

- API Keys

- Password hashing

These features make it easier to develop secure applications.

## FastAPI Architecture

### How FastAPI Handles Requests

The request-response cycle follows a straightforward process:

```

Client
│
▼
HTTP Request
│
▼
FastAPI Application
│
▼
Path Operation
│
▼
Business Logic
│
▼
JSON Response
│
▼
Client

```

A client sends an HTTP request, FastAPI processes it, executes the appropriate function, and returns a JSON response.

### Path Operations

In FastAPI, each URL endpoint is called a **Path Operation**. Examples include:

```

GET /products
POST /orders
PUT /customers/5
DELETE /flowers/10

```

Each path operation corresponds to a Python function that performs a specific task.

### Request and Response

FastAPI receives requests in formats such as:

- JSON

- Form data

- Query parameters

- Path parameters

After processing the request, it usually returns data in JSON format. Example response:

```

{
"name": "Rose Bouquet",
"price": 25.50
}

```

This standardized communication makes FastAPI ideal for frontend and mobile application development.

## FastAPI vs Other Python Frameworks

### FastAPI vs Django

Feature FastAPI Django Full-Stack Web Purpose API Development Framework Performance Very High High Built-in Admin Panel No Yes ORM Included No Yes No (requires DRF or Automatic API Docs Yes additional tools) Complete Web Best For APIs and Microservices Applications Django is excellent for building full web applications, while FastAPI specializes in creating modern APIs.

### FastAPI vs Flask

Feature FastAPI Flask Performance Higher High Data Validation Built-in Manual Automatic Yes No Documentation Type Hint Support Native Limited Async Support Built-in Limited FastAPI provides many features out of the box that require additional extensions in Flask.

### When Should We Use FastAPI?

FastAPI is an excellent choice when we need:

- REST APIs

- High-performance services

- Mobile backends

- AI and Machine Learning APIs

- Microservices

- Real-time applications

- Cloud-native applications

For applications requiring built-in templates, an admin panel, and a complete web framework, Django may be the more suitable choice.

## Advantages and Limitations of FastAPI

### Advantages

- Extremely fast performance

- Simple and readable syntax

- Automatic request validation

- Interactive API documentation

- Excellent support for asynchronous programming

- Strong type safety

- Easy integration with modern frontend frameworks

- Scalable architecture

- Large and growing community

### Limitations

- Does not include a built-in administrative interface.

- Does not provide a built-in ORM like Django.

- Beginners unfamiliar with APIs or asynchronous programming may face an initial learning curve.

- Some advanced features require additional third-party libraries.

Despite these limitations, FastAPI remains one of the best choices for modern API development.

## Real-World Applications of FastAPI

FastAPI is used in a variety of industries because of its speed and flexibility. Examples include:

- E-commerce product APIs

- Online banking services

- Hospital Management Systems

- Student Management Systems

- Inventory Management Systems

- Hotel Booking Systems

- AI and Machine Learning model deployment

- Recommendation engines

- Chatbot backends

- IoT (Internet of Things) applications

- Food delivery platforms

- Social media APIs

Many organizations choose FastAPI because it can efficiently handle thousands of requests while remaining easy to maintain.

### Conclusion

FastAPI is a modern, powerful, and high-performance Python framework specifically designed for building APIs quickly and efficiently. By combining the speed of **Starlette**, the data validation capabilities of **Pydantic**, and Python\'s modern type hinting system, it enables developers to create secure, scalable, and well-documented APIs with minimal effort. Features such as automatic validation, interactive documentation, asynchronous support, and clean syntax make FastAPI an excellent choice for backend development. Whether we are building a small personal project, a mobile application backend, a machine learning service, or a large-scale microservices architecture, FastAPI provides the tools needed to develop reliable and maintainable applications while significantly improving developer productivity.');

-- Lecture 2: Setting Up FastAPI & Uvicorn
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Setting Up FastAPI & Uvicorn', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Setting Up FastAPI & Uvicorn

## Installing FastAPI and Uvicorn

### What Do We Need Before Starting?

Before building applications with FastAPI, we need to install the required software and libraries. The two main components are:

- **FastAPI** – The Python framework used to build APIs.

- **Uvicorn** – A lightweight ASGI server that runs FastAPI applications.

Think of FastAPI as the **car** and Uvicorn as the **engine** that makes the car move. Without Uvicorn, our FastAPI application cannot receive and respond to HTTP requests.

### Prerequisites

Before installing FastAPI, make sure the following are available:

- Python 3.8 or later

- pip (Python Package Manager)

- A code editor such as Visual Studio Code

- Command Prompt or Terminal

Check the installed Python version: `python --version` or `python3 --version` Example output: `Python 3.12.2`

### Installing FastAPI

Install FastAPI using pip: `pip install fastapi` If multiple Python versions are installed, use: `pip3 install fastapi` FastAPI and its required dependencies will be downloaded and installed automatically.

### Installing Uvicorn

Install Uvicorn separately: `pip install uvicorn` For production-ready features, install the standard package:

```

pip install "uvicorn[standard]"

```

The standard installation includes additional packages that improve performance and enable automatic server reloading during development.

### Verify Installation

Check whether FastAPI is installed: `pip show fastapi` Check Uvicorn: `pip show uvicorn` If installation was successful, package information such as version and installation location will be displayed.

## Creating a FastAPI Project

### Create a Project Folder

Create a new directory for the project. `mkdir flower_cafe_api` Navigate into it: `cd flower_cafe_api` A dedicated project folder keeps files organized and easier to manage.

### Create a Virtual Environment

Using a virtual environment is considered a best practice because it isolates project dependencies. Create a virtual environment: `python -m venv venv` Project structure:

```

flower_cafe_api/
│
└── venv/

```

### Activate the Virtual Environment

### Windows

`venv\\Scripts\\activate`

### macOS / Linux

`source venv/bin/activate` When activated, the terminal usually displays: `(venv)` This indicates that all packages will be installed inside the virtual environment rather than globally.

### Install Packages Inside the Environment

`pip install fastapi uvicorn` All required packages are now isolated within the project.

## Creating the First FastAPI Application

### Create main.py

Inside the project folder, create: `main.py`

### Import FastAPI

```

from fastapi import FastAPI

```

This imports the `FastAPI` class.

### Create an Application Instance

`app = FastAPI()` This object represents the FastAPI application.

### Create the First Route

```

from fastapi import FastAPI
app = FastAPI()
@app.get("/")
def home():
return {
"message": "Welcome to FastAPI!"
}

```

Explanation:

- `@app.get("/")` defines a GET endpoint.

- `/` represents the homepage.

- The function returns a JSON response.

### Expected Response

Open: `http://127.0.0.1:8000/` Response:

```

{
"message": "Welcome to FastAPI!"
}

```

Congratulations! We have created our first FastAPI application.

## Running the FastAPI Application with Uvicorn

### Basic Command

Run the application: `uvicorn main:app` Explanation: `main` The Python file. `app` The FastAPI application object.

### Enable Automatic Reload

During development: `uvicorn main:app --reload` Advantages:

- Automatically restarts after saving changes.

- Eliminates the need to restart the server manually.

- Improves development speed.

### Server Output

Example:

```

INFO:
Uvicorn running on
http://127.0.0.1:8000

```

Open the browser: `http://127.0.0.1:8000` Our API is now running.

### Stopping the Server

Press: `CTRL + C` The server stops immediately.

## Understanding API Documentation

### Automatic Swagger UI

One of FastAPI\'s greatest strengths is its automatically generated interactive documentation. Visit: `http://127.0.0.1:8000/docs` The Swagger UI displays:

- Available endpoints

- Request methods

- Parameters

- Response examples

- "Try it Out" feature

Developers can test the API directly from the browser.

### ReDoc Documentation

FastAPI also provides another documentation interface. Visit: `http://127.0.0.1:8000/redoc` ReDoc offers a cleaner, documentation-focused layout suitable for reading API specifications.

### Why Is Automatic Documentation Useful?

Without FastAPI, developers often create API documentation manually. FastAPI automatically updates the documentation whenever the code changes. Benefits:

- Saves development time

- Reduces documentation errors

- Simplifies API testing

- Improves collaboration between frontend and backend developers

## Understanding the Project Structure

After creating our first application, the project may look like this:

```

flower_cafe_api/
│
├── venv/
│
├── main.py
│
└── __pycache__/

```

As the project grows, we can organize it further:

```

flower_cafe_api/
│
├── app/
│ ├── routers/
│ ├── models/
│ ├── schemas/
│ ├── database/
│ ├── services/
│ └── main.py
│
├── venv/
│
├── requirements.txt
│
└── README.md

```

This modular structure makes larger projects easier to maintain.

## Creating a Requirements File

### Why Use ?

`requirements.txt` A `requirements.txt` file lists all project dependencies. Generate it:

```

pip freeze > requirements.txt

```

Example:

```

fastapi==0.116.1
uvicorn==0.35.0

```

To install the dependencies on another computer:

```

pip install -r requirements.txt

```

This ensures everyone working on the project uses the same package versions.

## Common Errors and Troubleshooting

### Module Not Found

Error: `ModuleNotFoundError` Solution: `pip install fastapi`

### Uvicorn Not Recognized

Error: `\'uvicorn\' is not recognized` Solution:

```

python -m uvicorn main:app --reload

```

or ensure the virtual environment is activated.

### Port Already in Use

Error: `Address already in use` Solution: Run the application on another port.

```

uvicorn main:app --reload --port 8001

```

### Application Not Found

Error: `Error loading ASGI app.` Check:

- File name

- Application variable name

- Spelling of `main:app`

## Best Practices for Setting Up FastAPI

### Always Use a Virtual Environment

This keeps project dependencies isolated and prevents version conflicts.

### Use Automatic Reload During Development

Run: `uvicorn main:app --reload` This improves productivity by reloading the server whenever code changes are saved.

### Organize the Project Early

Separate routers, models, schemas, services, and database configurations into dedicated folders as the project grows.

### Keep Dependencies Updated

Regularly update packages and regenerate `requirements.txt` to maintain compatibility and security.

### Test the Documentation

Always verify that:

- `/docs`

- `/redoc`

work correctly after adding new endpoints.

### Use Meaningful File Names

Choose descriptive names such as:

- main.py

- database.py

- models.py

- routers.py

This improves readability and simplifies maintenance.

### Conclusion

Setting up FastAPI with Uvicorn is the first step toward building modern, high-performance APIs. After installing FastAPI and Uvicorn, creating a virtual environment, and setting up a simple main.py file, we can launch our application with just one command and immediately begin serving requests. FastAPI\'s automatic documentation through Swagger UI and ReDoc greatly simplifies API development and testing, while Uvicorn provides a fast and reliable ASGI server for running applications. By following best practices such as using virtual environments, organizing project files, maintaining dependency lists, and enabling automatic reload during development, we establish a strong foundation for creating scalable, maintainable, and production-ready FastAPI applications.');

-- Lecture 3: Path & Query Parameters
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Path & Query Parameters', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Path & Query Parameters

## Understanding Parameters in FastAPI

### What are Parameters?

Parameters are values sent by the client to the server to provide additional information about a request. They allow us to create **dynamic APIs** that can return different results based on the values supplied by the user. Imagine visiting an online flower shop. If you search for **Roses**, the website displays only rose bouquets. If you search for **Tulips**, the results change automatically. This flexibility is possible because the application receives parameters from the user\'s request. FastAPI mainly uses two types of parameters:

- **Path Parameters**

- **Query Parameters**

Both are essential for building dynamic and interactive APIs.

### Why Do We Use Parameters?

Without parameters, every endpoint would return the same data regardless of the user\'s request. Parameters help us:

- Retrieve specific records

- Filter data

- Search information

- Sort results

- Paginate large datasets

- Build flexible REST APIs

For example:

- Get a product by its ID

- Search for flowers by color

- Filter coffee by price

- Display products on a specific page

## Path Parameters

### What are Path Parameters?

A **Path Parameter** is a value included directly in the URL path. It identifies a specific resource that the client wants to access. General syntax:

```

http://example.com/items/{id}

```

Example:

```

http://127.0.0.1:8000/products/5

```

Here: `5` is the path parameter.

### Creating a Path Parameter

Example:

```

from fastapi import FastAPI
app = FastAPI()
@app.get("/flowers/{flower_id}")
def get_flower(flower_id: int):
return {
"Flower ID": flower_id
}

```

### Testing the Endpoint

Visit:

```

http://127.0.0.1:8000/flowers/10

```

Response:

```

{
"Flower ID": 10
}

```

Changing the URL changes the returned value.

### Multiple Path Parameters

FastAPI supports multiple path parameters. Example:

```

@app.get("/orders/{order_id}/items/{item_id}")
def order_item(
order_id: int,
item_id: int
):
return {
"Order": order_id,
"Item": item_id
}

```

Request: `/orders/5/items/8` Response:

```

{
"Order": 5,
"Item": 8
}

```

### Automatic Type Conversion

FastAPI automatically converts values according to their declared type. Example:

```

@app.get("/customers/{customer_id}")
def customer(customer_id: int):
return {
"Customer": customer_id
}

```

If the URL contains: `abc` FastAPI immediately returns a validation error because `"abc"` cannot be converted into an integer.

## Query Parameters

### What are Query Parameters?

A **Query Parameter** is a value sent after the **?** symbol in the URL. General syntax: `/search?keyword=rose` Example:

```

http://127.0.0.1:8000/search?flower=Rose

```

Everything after the **?** is a query parameter.

### Creating a Query Parameter

Example:

```

@app.get("/search")
def search(flower: str):
return {
"Flower": flower
}

```

Request: `/search?flower=Rose` Response:

```

{
"Flower": "Rose"
}

```

### Multiple Query Parameters

Example:

```

@app.get("/menu")
def menu(
category: str,
price: int
):
return {
"Category": category,
"Maximum Price": price
}

```

Request:

```

/menu?category=Coffee&price=500

```

Response:

```

{
"Category": "Coffee",
"Maximum Price": 500
}

```

Multiple query parameters are separated using the **&** symbol.

### Optional Query Parameters

Provide a default value to make a query parameter optional.

```

@app.get("/flowers")
def flowers(
color: str = "Red"
):
return {
"Color": color
}

```

Request: `/flowers` Response:

```

{
"Color": "Red"
}

```

Request: `/flowers?color=Pink` Response:

```

{
"Color": "Pink"
}

```

## Combining Path and Query Parameters

FastAPI allows both parameter types in the same endpoint. Example:

```

@app.get("/products/{product_id}")
def product(
product_id: int,
discount: int = 0
):
return {
"Product": product_id,
"Discount": discount
}

```

Request: `/products/15?discount=20` Response:

```

{
"Product": 15,
"Discount": 20
}

```

The product ID comes from the path, while the discount comes from the query string.

### Real-World Example

Imagine a Flower Café API. `GET /flowers/10?quantity=3` Meaning:

- Flower ID = **10**

- Customer wants **3** bouquets

Response:

```

{
"Flower ID": 10,
"Quantity": 3
}

```

This combination is common in e-commerce and inventory systems.

## Data Types for Parameters

FastAPI supports automatic validation for different data types. Example:

```

@app.get("/user/{id}")
def user(
id: int,
premium: bool = False,
rating: float = 4.5,
name: str = "Guest"
):
return {
"ID": id,
"Premium": premium,
"Rating": rating,
}

```

Supported types include:

- `int`

- `float`

- `str`

- `bool`

- `list`

- `UUID`

- `datetime`

- `Enum`

FastAPI validates each value automatically.

### Boolean Query Parameters

Example:

```

@app.get("/orders")
def orders(
delivered: bool = False
):
return {
"Delivered": delivered
}

```

Request: `/orders?delivered=true` Response:

```

{
"Delivered": true
}

```

FastAPI converts `"true"` into the Boolean value `True`.

## Validation and Error Handling

### Automatic Validation

FastAPI validates incoming parameter values before executing the function. Example:

```

@app.get("/age/{age}")
def check_age(age: int):
return {
"Age": age
}

```

Request: `/age/twenty` Response:

```

{
{
"type": "int_parsing",
"msg": "Input should be a valid integer"
}
]
}

```

The function is not executed because the input is invalid.

### Missing Required Query Parameters

Example:

```

@app.get("/search")
def search(keyword: str):
return {
"Keyword": keyword
}

```

Request: `/search` FastAPI returns an error because `keyword` is required.

## Path Parameters vs Query Parameters

Feature Path Parameter Query Parameter Location Inside the URL path After `?` in the URL Identify a specific Filter, search, or modify Purpose resource results Can be required or Required Usually required optional Example `/flowers/5 /flowers?color=Red` Search, filter, sorting, Common Use Retrieve a single item pagination

### When Should We Use Each?

Use **Path Parameters** when:

- Accessing a specific product

- Viewing a customer profile

- Retrieving an order

- Updating a record

- Deleting a resource

Use **Query Parameters** when:

- Searching by keyword

- Filtering results

- Sorting records

- Setting page numbers

- Applying price ranges

Choosing the correct parameter type makes APIs more intuitive and aligns with RESTful design principles.

## Best Practices

### Use Descriptive Parameter Names

Prefer:

```

/flowers/{flower_id}

```

instead of:

```

/flowers/{id}

```

Clear names improve code readability.

### Use Appropriate Data Types

Declare parameter types correctly to benefit from FastAPI\'s automatic validation. Example: `product_id: int` instead of: `product_id: str` when the value should always be numeric.

### Keep URLs Clean

Avoid unnecessary parameters. Include only those that are relevant to the request.

### Use Query Parameters for Filtering

Example: `/menu?category=Coffee` instead of embedding filter values into the URL path.

### Test Endpoints with Swagger UI

After creating endpoints, visit: `http://127.0.0.1:8000/docs` Use the interactive documentation to test different path and query parameter combinations.

### Conclusion

Path and Query Parameters are fundamental components of FastAPI that enable us to build dynamic, flexible, and user-friendly APIs. Path Parameters identify specific resources by embedding values directly into the URL, while Query Parameters allow users to search, filter, sort, and customize responses without changing the resource itself. FastAPI enhances these features by providing automatic type conversion, built-in validation, clear error messages, and interactive documentation through Swagger UI. By understanding when to use each type of parameter and following best practices such as meaningful naming, appropriate data types, and clean URL design, we can create RESTful APIs that are reliable, easy to maintain, and simple for clients to use.');

-- Lecture 4: Request Body Handling in FastAPI
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Request Body Handling in FastAPI', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Request Body Handling in FastAPI

## Understanding Request Bodies

### What is a Request Body?

A **Request Body** is the data that a client sends to the server as part of an HTTP request. Unlike **Path Parameters** and **Query Parameters**, which are included in the URL, the request body contains the actual information that the server needs to process. For example, when a customer places an order in an online Flower Café, the application must send details such as the customer\'s name, selected items, quantity, and payment method. Instead of placing all this information in the URL, it is sent inside the **request body**. Request bodies are most commonly used with:

- POST requests

- PUT requests

- PATCH requests

These HTTP methods are used to create or update data.

### Why Do We Use Request Bodies?

Imagine adding a new flower to an online flower shop. Instead of sending this information in the URL:

```

/flowers?name=Rose&price=1500&stock=20

```

We send structured JSON data:

```

{
"name": "Rose",
"price": 1500,
"stock": 20
}

```

This approach is:

- Cleaner

- More secure

- Easier to read

- Better suited for large amounts of data

### Request Body vs Query Parameters

Feature Request Body Query Parameter Location Inside the HTTP request After `?` in the URL Send data to create or Filter, search, or Purpose update resources customize results HTTP Methods POST, PUT, PATCH Mostly GET Data Size Large Small

## Creating a Request Body with Pydantic

### Using

`BaseModel` FastAPI uses **Pydantic** models to define the structure of a request body. Example:

```

from pydantic import BaseModel
class Flower(BaseModel):
name: str
price: float
stock: int

```

This model defines the data that the client must send.

### Receiving the Request Body

Example:

```

from fastapi import FastAPI
from pydantic import BaseModel
app = FastAPI()
class Flower(BaseModel):
name: str
price: float
stock: int
@app.post("/flowers")
def create_flower(flower: Flower):
return flower

```

FastAPI automatically:

- Reads the JSON data

- Validates it

- Converts it into a Python object

- Passes it to the function

### Testing the Endpoint

Request:

```

{
"name": "Tulip",
"price": 1200,
"stock": 25
}

```

Response:

```

{
"name": "Tulip",
"price": 1200.0,
"stock": 25
}

```

The response confirms that the request body was successfully processed.

## Working with Request Body Data

### Accessing Individual Fields

Each field can be accessed using dot notation. Example:

```

@app.post("/flowers")
def create_flower(flower: Flower):
return {
"Flower Name": flower.name,
"Price": flower.price,
"Stock": flower.stock
}

```

If the client sends:

```

{
"name": "Sunflower",
"price": 900,
"stock": 40
}

```

The API extracts each field and returns it.

### Performing Calculations

Example:

```

class Product(BaseModel):
name: str
price: float
quantity: int
@app.post("/purchase")
def purchase(product: Product):
total = product.price * product.quantity
return {
"Total": total
}

```

Request:

```

{
"name": "Coffee",
"price": 350,
"quantity": 3
}

```

Response:

```

{
"Total": 1050
}

```

The server performs calculations using the request body data.

## Request Body Validation

### Automatic Validation

FastAPI validates every field before executing the endpoint. Example:

```

class MenuItem(BaseModel):
name: str
price: float

```

Valid request:

```

{
"name": "Latte",
"price": 450
}

```

Invalid request:

```

{
"name": "Latte",
"price": "cheap"
}

```

FastAPI immediately returns a validation error because `"cheap"` is not a valid number.

### Required Fields

Fields without default values are required. Example:

```

class Customer(BaseModel):
name: str
email: str

```

If the client omits the `email` field, FastAPI returns an error indicating that the field is required.

### Optional Fields

Optional fields can be omitted. Example:

```

from typing import Optional
class Flower(BaseModel):
name: str
description: Optional[str] = None

```

The client may include the description or leave it out.

## Combining Request Body with Path and Query Parameters

FastAPI allows us to use request bodies together with path and query parameters. Example:

```

from fastapi import FastAPI
from pydantic import BaseModel
app = FastAPI()
class Product(BaseModel):
name: str
price: float
@app.put("/products/{product_id}")
def update_product(
product_id: int,
product: Product,
discount: int = 0
):
return {
"Product ID": product_id,
"Name": product.name,
"Price": product.price,
"Discount": discount
}

```

Request URL: `/products/10?discount=15` Request Body:

```

{
"name": "Rose Bouquet",
"price": 1800
}

```

Response:

```

{
"Product ID": 10,
"Name": "Rose Bouquet",
"Price": 1800,
"Discount": 15
}

```

This demonstrates how different parameter types can work together in a single endpoint.

## Nested Request Bodies

### Using Multiple Models

Sometimes request bodies contain nested objects. Example:

```

class Customer(BaseModel):
name: str
email: str
class Order(BaseModel):
customer: Customer
total: float

```

Request:

```

{
"customer": {
"name": "Ali",
"email": "ali@example.com"
},
"total": 2500
}

```

Nested models help organize related data logically.

### Lists in Request Bodies

Example:

```

from typing import List
class Order(BaseModel):
items: List[str]

```

Request:

```

{
"items": [
"Coffee",
"Cheesecake",
"Rose Bouquet"
]
}

```

FastAPI validates every item in the list automatically.

## Request Body in Swagger UI

### Interactive Testing

After running the application, visit: `http://127.0.0.1:8000/docs` Swagger UI automatically generates:

- Input forms

- Example JSON

- Validation messages

- Response previews

Developers can test endpoints directly from the browser without external tools.

### Example Request in Swagger

For the `Flower` model, Swagger automatically displays:

```

{
"name": "string",
"price": 0,
"stock": 0
}

```

Users simply modify the values and click **Execute**.

## Common Validation Errors

### Incorrect Data Type

Request:

```

{
"name": 123,
"price": "cheap"
}

```

FastAPI returns detailed error messages because the data types do not match the model.

### Missing Fields

Request:

```

{
"price": 500
}

```

If the `name` field is required, FastAPI reports that it is missing.

### Extra Fields

Request:

```

{
"name": "Rose",
"price": 1200,
"stock": 15,
"color": "Red"
}

```

By default, Pydantic accepts extra fields in many configurations, but this behavior can be customized to ignore or forbid them depending on the model configuration.

## Best Practices

### Use Pydantic Models

Always define request bodies using `BaseModel` instead of manually processing dictionaries.

### Use Appropriate Data Types

Choose the correct data types such as:

- `str`

- `int`

- `float`

- `bool`

- `date`

- `EmailStr`

This improves validation accuracy.

### Keep Models Focused

Create separate models for different operations. Example:

- `ProductCreate`

- `ProductUpdate`

- `ProductResponse`

This improves maintainability and flexibility.

### Validate Business Rules

Use `Field()` to enforce rules such as positive prices, minimum string lengths, and valid stock quantities.

### Test with Swagger UI

Always test request bodies using: `http://127.0.0.1:8000/docs` This helps verify validation rules and endpoint behavior before integrating with frontend applications.

### Conclusion

Request body handling is a fundamental feature of FastAPI that enables APIs to receive structured data from clients in a clean and efficient manner. By using Pydantic models, FastAPI automatically validates incoming JSON, converts it into Python objects, and provides detailed error messages when validation fails. Request bodies work seamlessly alongside path and query parameters, making it possible to build flexible and well-structured APIs. Features such as nested models, lists, automatic documentation, and built-in validation reduce development effort while improving reliability. By following best practices—such as defining clear Pydantic models, using appropriate data types, validating business rules, and testing endpoints with Swagger UI—we can create secure, maintainable, and production-ready FastAPI applications.');

-- Lecture 5: Pydantic Models & Data Validation
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Pydantic Models & Data Validation', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Pydantic Models & Data Validation

## Introduction to Pydantic Models

### What is Pydantic?

**Pydantic** is a Python library used by FastAPI for **data validation, parsing, and serialization**. It ensures that the data received by an API matches the expected format before the request is processed. Think of Pydantic as a **security guard** standing at the entrance of your application. Before anyone enters, it checks whether they meet the required conditions. If the data is valid, it allows the request to continue. If not, it immediately returns an error. Pydantic is one of the key reasons FastAPI is reliable and developer-friendly.

### Why Do We Need Pydantic?

Without validation, users could send incorrect or incomplete data that might cause errors or corrupt the database. For example, consider a product API:

```

{
"name": "Rose Bouquet",
"price": 1500,
"stock": 25
}

```

This is valid. However, if a user sends:

```

{
"name": "Rose Bouquet",
"price": "expensive",
"stock": "many"
}

```

The values for `price` and `stock` have incorrect data types. Pydantic automatically detects these problems and returns validation errors before the request reaches our application logic.

### Benefits of Pydantic

Using Pydantic provides several advantages:

- Automatic data validation

- Automatic type conversion

- Cleaner and more readable code

- Reduced runtime errors

- Better API documentation

- Improved data consistency

- Easy integration with FastAPI

## Creating Pydantic Models

### Importing BaseModel

All Pydantic models inherit from `BaseModel`. Example:

```

from pydantic import BaseModel

```

### Creating a Simple Model

Example:

```

from pydantic import BaseModel
class Flower(BaseModel):
name: str
price: float
stock: int

```

This model defines three fields:

- `name` → String

- `price` → Decimal number

- `stock` → Integer

Each field includes a type annotation that Pydantic uses for validation.

### Using the Model in FastAPI

```

from fastapi import FastAPI
from pydantic import BaseModel
app = FastAPI()
class Flower(BaseModel):
name: str
price: float
stock: int
@app.post("/flowers")
def create_flower(flower: Flower):
return flower

```

FastAPI automatically validates the incoming JSON request against the `Flower` model.

### Testing the API

Request:

```

{
"name": "Tulip",
"price": 850,
"stock": 30
}

```

Response:

```

{
"name": "Tulip",
"price": 850.0,
"stock": 30
}

```

The data is accepted because it matches the model.

## Data Types in Pydantic

### Common Data Types

Pydantic supports many Python data types. Example:

```

class Customer(BaseModel):
name: str
age: int
premium: bool
balance: float

```

Common types include:

- `str`

- `int`

- `float`

- `bool`

- `list`

- `dict`

- `datetime`

- `date`

- `UUID`

- `EmailStr`

Using the correct type improves validation accuracy.

### Lists

Example:

```

from typing import List
class Order(BaseModel):
items: List[str]

```

Request:

```

{
"items": [
"Coffee",
"Cake",
"Rose Bouquet"
]
}

```

Pydantic ensures every item in the list is a string.

### Nested Models

Models can contain other models. Example:

```

class Customer(BaseModel):
name: str
email: str
class Order(BaseModel):
customer: Customer
total: float

```

Request:

```

{
"customer": {
"name": "Ali",
"email": "ali@example.com"
},
"total": 2400
}

```

Nested models help organize complex data structures.

## Data Validation

### Automatic Validation

Pydantic validates every incoming request. Example:

```

class Product(BaseModel):
price: float

```

Valid request:

```

{
"price": 500
}

```

Invalid request:

```

{
"price": "cheap"
}

```

FastAPI returns a validation error because `"cheap"` is not a valid number.

### Required Fields

Fields without default values are required. Example:

```

class Flower(BaseModel):
name: str
price: float

```

Request:

```

{
"name": "Rose"
}

```

Since `price` is missing, FastAPI returns an error.

### Optional Fields

Use `Optional` for fields that are not mandatory.

```

from typing import Optional
class Flower(BaseModel):
name: str
description: Optional[str] = None

```

Now the description may be omitted.

## Field Validation with

`Field()`

### Using Field Constraints

Pydantic provides the `Field()` function for additional validation. Example:

```

from pydantic import BaseModel, Field
class Product(BaseModel):
name: str
price: float = Field(gt=0)
stock: int = Field(ge=0)

```

Explanation:

- `gt=0` → Greater than 0

- `ge=0` → Greater than or equal to 0

This prevents invalid values such as negative prices or stock quantities.

### String Length Validation

Example:

```

class Flower(BaseModel):
name: str = Field(
min_length=3,
max_length=50
)

```

The flower name must contain between **3 and 50 characters**.

### Default Values

Example:

```

class MenuItem(BaseModel):
available: bool = True

```

If the client does not provide `available`, the value defaults to `True`.

## Specialized Data Types

### Email Validation

Instead of using a plain string, we can validate email addresses. Example:

```

from pydantic import EmailStr
class Customer(BaseModel):
email: EmailStr

```

Valid: `user@example.com` Invalid: `user.com` Invalid email addresses generate validation errors automatically.

### URL Validation

Example:

```

from pydantic import HttpUrl
class Website(BaseModel):
url: HttpUrl

```

Only valid URLs are accepted.

### Date Validation

Example:

```

from datetime import date
class Reservation(BaseModel):
booking_date: date

```

Request:

```

{
"booking_date": "2026-08-10"
}

```

Pydantic converts the string into a Python `date` object.

## Request Body Validation in FastAPI

### Receiving JSON Data

Example:

```

from fastapi import FastAPI
from pydantic import BaseModel
app = FastAPI()
class Coffee(BaseModel):
name: str
price: float
@app.post("/coffee")
def create_coffee(coffee: Coffee):
return coffee

```

The request body is automatically validated before the function executes.

### Automatic Error Responses

Invalid request:

```

{
"name": 123,
"price": "abc"
}

```

FastAPI responds with detailed validation information, making it easier for API users to identify and fix input errors.

## Best Practices for Pydantic Models

### Use Separate Models

Create different models for different operations. Example:

- `UserCreate`

- `UserUpdate`

- `UserResponse`

This improves clarity and security.

### Use Meaningful Field Names

Prefer: `flower_name` instead of: `fn` Descriptive names make code easier to understand.

### Validate Business Rules

Use `Field()` to enforce rules such as positive prices, valid quantities, or minimum text lengths.

### Use Specialized Types

Whenever possible, use types like:

- `EmailStr`

- `HttpUrl`

- `date`

- `datetime`

- `UUID`

These provide stronger validation than plain strings.

### Keep Models Small

Avoid placing unrelated data in the same model. Smaller, focused models are easier to maintain and reuse.

### Test with Swagger UI

Visit: `http://127.0.0.1:8000/docs` Use the interactive interface to test valid and invalid request bodies and observe FastAPI\'s validation behavior.

## Advantages and Limitations

### Advantages

- Automatic request validation

- Cleaner and more maintainable code

- Improved API documentation

- Strong type safety

- Automatic data conversion

- Better error reporting

- Easy integration with FastAPI

### Limitations

- Beginners may need time to understand Python type hints.

- Deeply nested models can become difficult to manage if not organized properly.

Despite these limitations, Pydantic remains one of the most powerful features of FastAPI.

### Conclusion

Pydantic is the foundation of data validation in FastAPI, ensuring that incoming requests are accurate, complete, and consistent before they reach the application\'s business logic. By defining models with `BaseModel`, using Python type hints, applying validation rules through `Field()`, and leveraging specialized data types such as `EmailStr`, `HttpUrl`, and `date`, we can build robust and reliable APIs with minimal effort. FastAPI automatically integrates Pydantic into request handling, error reporting, and API documentation, significantly reducing development time while improving code quality. By following best practices such as creating separate models for different operations, using meaningful field names, and validating business rules, we can develop secure, maintainable, and professional APIs suitable for real-world applications.');

-- Lecture 6: Response Models & Status Codes in FastAPI
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Response Models & Status Codes in FastAPI', 6, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Response Models & Status Codes in FastAPI

## Understanding Responses in FastAPI

### What is a Response?

A **response** is the data that a server sends back to the client after processing an HTTP request. Whenever a client requests information or performs an operation, FastAPI generates a response containing the requested data along with an HTTP status code. Think of a response as a waiter serving your order at a café. You place an order (request), the kitchen prepares it (processing), and the waiter brings your food (response). If something goes wrong, the waiter informs you instead of silently failing. Similarly, FastAPI always returns a response indicating whether the request was successful or if an error occurred.

### Components of a Response

A typical FastAPI response consists of:

- Response Body

- Status Code

- Response Headers

Example response:

```

{
"message": "Flower added successfully."
}

```

Status Code: `201 Created` The response body contains the data, while the status code explains the result of the request.

### Why Are Responses Important?

Well-designed responses help clients:

- Understand whether the request succeeded.

- Receive the requested data.

- Handle errors correctly.

- Build reliable frontend applications.

- Improve communication between systems.

## Response Models

### What is a Response Model?

A **Response Model** is a Pydantic model that defines the structure of the data returned by an API endpoint. Instead of returning random dictionaries, we define exactly what information the client should receive. Benefits include:

- Consistent API responses

- Automatic validation

- Better documentation

- Improved security by hiding unnecessary fields

### Creating a Response Model

Example:

```

from pydantic import BaseModel
class FlowerResponse(BaseModel):
id: int
name: str
price: float

```

This model specifies that every response must contain:

- id

- name

- price

### Using

```

response_model
from fastapi import FastAPI
from pydantic import BaseModel
app = FastAPI()
class FlowerResponse(BaseModel):
id: int
name: str
price: float
@app.get(
"/flowers/{flower_id}",
response_model=FlowerResponse
)
def get_flower(flower_id: int):
return {
"id": flower_id,
"name": "Rose",
"price": 1200
}

```

FastAPI validates the returned data before sending it to the client.

### Response

Request: `GET /flowers/1` Response:

```

{
"id": 1,
"name": "Rose",
"price": 1200
}

```

The response matches the structure defined by `FlowerResponse`.

## Why Use Response Models?

### Data Validation

FastAPI checks that the returned data matches the response model. If a required field is missing or has the wrong type, FastAPI raises an error during development.

### Data Filtering

Suppose our database contains:

```

{
"id": 1,
"name": "Rose",
"price": 1200,
"supplier_cost": 800,
"secret_code": "ABC123"
}

```

The client should not receive confidential information. Response model:

```

class FlowerResponse(BaseModel):
id: int
name: str
price: float

```

Client receives:

```

{
"id": 1,
"name": "Rose",
"price": 1200
}

```

Sensitive fields are automatically excluded.

### Automatic Documentation

The response model appears in Swagger UI. Visit: `http://127.0.0.1:8000/docs` Swagger automatically displays:

- Response schema

- Example values

- Data types

This improves API usability.

## HTTP Status Codes

### What is a Status Code?

An **HTTP Status Code** is a three-digit number indicating the result of an HTTP request. Examples:

```

200 OK
201 Created
404 Not Found

```

Status codes help clients determine whether a request succeeded or failed.

### Categories of Status Codes

### 1xx – Informational

Indicates that the request has been received. Example: `100 Continue` These codes are rarely used in everyday API development.

### 2xx – Success

The request completed successfully. Common examples:

```

200 OK
201 Created
204 No Content

```

### 3xx – Redirection

The client must perform another action to complete the request. Example: `301 Moved Permanently`

### 4xx – Client Errors

The problem is caused by the client. Examples:

```

400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found

```

### 5xx – Server Errors

The problem occurred on the server. Examples:

```

500 Internal Server Error
503 Service Unavailable

```

## Returning Status Codes in FastAPI

### Default Status Code

A successful GET request returns: `200 OK` Example:

```

@app.get("/hello")
def hello():
return {
"message": "Hello World"
}

```

FastAPI automatically returns **200 OK**.

### Setting a Custom Status Code

```

from fastapi import status
@app.post(
"/flowers",
status_code=status.HTTP_201_CREATED
)
def create_flower():
return {
"message": "Flower created successfully."
}

```

Response: `201 Created`

### Using the Module

`status` FastAPI provides readable constants. Example:

```

status.HTTP_200_OK
status.HTTP_201_CREATED
status.HTTP_204_NO_CONTENT
status.HTTP_400_BAD_REQUEST
status.HTTP_404_NOT_FOUND

```

Using constants improves readability and reduces mistakes.

## Common Status Codes

Status Code Meaning Typical Use **200 OK** Request successful Retrieve data **201 Created** Resource created POST request Success without response **204 No Content** DELETE request body **400 Bad Request** Invalid request Validation errors **401 Unauthorized** Authentication required Login protected APIs **403 Forbidden** Permission denied Insufficient privileges **404 Not Found** Resource does not exist Invalid ID Unexpected application **500 Internal Server Error** Server problem error

## Returning Custom Responses

### Returning a Dictionary

The simplest response:

```

@app.get("/welcome")
def welcome():
return {
"message": "Welcome to Bloom & Brew Café API"
}

```

### Returning Lists

```

@app.get("/flowers")
def flowers():
return [
"Rose",
"Tulip",
"Sunflower"
]

```

Response:

```

[
"Rose",
"Tulip",
"Sunflower"
]

```

### Returning Objects

```

@app.get("/product")
def product():
return {
"id": 1,
"name": "Latte",
"price": 450
}

```

FastAPI automatically converts Python dictionaries into JSON.

## Combining Response Models with Status Codes

Example:

```

from fastapi import FastAPI, status
from pydantic import BaseModel
app = FastAPI()
class MenuItemResponse(BaseModel):
id: int
name: str
price: float
@app.post(
"/menu",
response_model=MenuItemResponse,
status_code=status.HTTP_201_CREATED
)
def create_menu():
return {
"id": 1,
"name": "Cappuccino",
"price": 550
}

```

The endpoint:

- Validates the response

- Returns only the specified fields

- Sends **201 Created**

This is considered a best practice for REST APIs.

## Best Practices

### Always Use Response Models

Avoid returning raw dictionaries for production APIs. Response models provide validation and consistency.

### Return Appropriate Status Codes

Examples:

- GET → 200 OK

- POST → 201 Created

- DELETE → 204 No Content

- Invalid request → 400 Bad Request

- Missing resource → 404 Not Found

Choosing the correct status code makes APIs easier to understand and use.

### Protect Sensitive Data

Never expose:

- Passwords

- Secret keys

- Internal database fields

- API tokens

Use response models to filter unnecessary information.

### Use the Module

`status` Prefer: `status.HTTP_201_CREATED` instead of: `201` Named constants improve readability.

### Test Responses Using Swagger UI

Visit: `http://127.0.0.1:8000/docs` Verify:

- Response format

- Status codes

- Returned fields

- Example responses

Testing through Swagger helps catch mistakes early.

## Common Mistakes

### Returning Sensitive Information

Avoid sending confidential fields such as passwords or internal identifiers. Always define a response model that exposes only the required data.

### Using Incorrect Status Codes

For example, returning **200 OK** after creating a new resource is technically valid but less informative. A **201 Created** status is the recommended choice for successful POST requests that create new resources.

### Skipping Response Models

Returning raw dictionaries everywhere may work, but it can lead to inconsistent responses and accidental exposure of internal data. Using response models makes APIs more predictable and secure.

### Ignoring Validation

Ensure the returned data matches the response model. Validation errors during development help identify mistakes before they reach production.

### Conclusion

Response models and HTTP status codes are essential for building professional APIs in FastAPI. Response models, powered by Pydantic, define the exact structure of the data sent to clients, ensuring consistency, validation, and protection of sensitive information. HTTP status codes clearly communicate the outcome of each request, allowing clients to understand whether an operation was successful or if an error occurred. By combining response models with appropriate status codes, using FastAPI\'s `status` module, and following RESTful best practices, we can create APIs that are secure, predictable, easy to document, and simple for frontend developers and other systems to integrate with.');

-- Lecture 7: Dependency Injection in FastAPI
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Dependency Injection in FastAPI', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Dependency Injection in FastAPI

## Introduction to Dependency Injection

### What is Dependency Injection?

**Dependency Injection (DI)** is a design pattern used to provide the objects, functions, or services that an application needs without creating them directly inside every endpoint. Instead of writing the same code repeatedly, we place common functionality in a separate function called a **dependency**, and FastAPI automatically injects it wherever it is needed. Think of a café kitchen. Every chef needs ingredients like coffee beans, milk, and sugar. Instead of each chef going to the storage room to collect them every time, a kitchen assistant prepares and delivers the ingredients when needed. This saves time, avoids repetition, and keeps the kitchen organized. Similarly, FastAPI provides dependencies to our endpoints automatically.

### Why Do We Need Dependency Injection?

Imagine we are building a Flower Café Management API. Many endpoints require the same tasks:

- Checking if the user is logged in

- Connecting to the database

- Verifying permissions

- Reading request headers

- Logging requests

Without Dependency Injection, we would repeat the same code in every endpoint. Dependency Injection allows us to:

- Reuse code

- Reduce duplication

- Improve readability

- Simplify maintenance

- Separate business logic from common tasks

### Real-World Example

Suppose every customer must log in before placing an order. Without Dependency Injection:

```

Order Endpoint
↓
Check Login
↓
Process Order

```

Reservation Endpoint:

```

Reservation Endpoint
↓
Check Login
↓
Create Reservation

```

The login verification code is repeated. With Dependency Injection:

```

Authentication Dependency
↓
Order Endpoint
↓
Reservation Endpoint
↓
Payment Endpoint

```

One dependency serves multiple endpoints.

## Understanding Dependencies

### What is a Dependency?

A dependency is simply a Python function that FastAPI executes before running the endpoint. Example:

```

def welcome():
return "Welcome!"

```

This function can be injected into any endpoint.

### Using

`Depends` FastAPI provides the `Depends` class to use dependencies. Example:

```

from fastapi import FastAPI, Depends
app = FastAPI()
def welcome():
return "Welcome to Bloom & Brew Café"
@app.get("/")
def home(message: str = Depends(welcome)):
return {
"message": message
}

```

Response:

```

{
"message": "Welcome to Bloom & Brew Café"
}

```

FastAPI automatically calls the `welcome()` function before executing the endpoint.

### How Dependency Injection Works

The execution flow is:

```

Client Request
↓
Dependency Function
↓
↓
Response

```

FastAPI first executes the dependency and then passes its return value into the endpoint.

## Creating Reusable Dependencies

### Reading Query Parameters

Dependencies can process request data. Example:

```

from fastapi import Depends
def get_name(name: str):
return name
@app.get("/hello")
def hello(username: str = Depends(get_name)):
return {
"Hello": username
}

```

Request: `/hello?name=Ali` Response:

```

{
"Hello": "Ali"
}

```

The dependency retrieves the query parameter and provides it to the endpoint.

### Reading Headers

Dependencies can also read HTTP headers. Example:

```

from fastapi import Header, Depends
def get_token(token: str = Header()):
return token
@app.get("/profile")
def profile(user_token: str = Depends(get_token)):
return {
"Token": user_token
}

```

The dependency extracts the header before the endpoint executes.

### Database Connection Example

Although the actual database setup comes later, Dependency Injection is commonly used to provide a database session. Example:

```

def get_db():
db = "Database Connection"
return db
@app.get("/flowers")
def flowers(db = Depends(get_db)):
return {
"Database": db
}

```

Every endpoint needing database access can reuse the same dependency.

## Authentication with Dependency Injection

### Checking User Authentication

Authentication is one of the most common uses of Dependency Injection. Example:

```

from fastapi import Depends
def verify_user():
return True
@app.get("/dashboard")
def dashboard(
authenticated = Depends(verify_user)
):
return {
"Access": authenticated
}

```

Before the dashboard loads, FastAPI checks whether the user is authenticated.

### Verifying API Keys

Example:

```

from fastapi import Header
def verify_api_key(
api_key: str = Header()
):
return api_key

```

This dependency can protect multiple endpoints without repeating verification logic.

### Checking User Roles

Suppose only administrators can manage products. Example:

```

def admin_required():
return "Administrator"

```

Endpoints requiring administrator access simply reuse this dependency.

## Nested Dependencies

### What are Nested Dependencies?

A dependency can use another dependency. Example:

```

def get_database():
return "Database"
def get_user(
db = Depends(get_database)
):
return "Current User"

```

Execution order:

```

Database Dependency
↓
User Dependency
↓
Endpoint

```

FastAPI resolves dependencies automatically.

### Advantages of Nested Dependencies

Nested dependencies help us:

- Separate responsibilities

- Reduce code duplication

- Improve readability

- Build scalable applications

They are especially useful in large projects with authentication, permissions, and database access.

## Dependency Injection in Real Applications

### Database Session

Instead of opening a database connection inside every endpoint:

```

Connect Database
↓
Query Database
↓
Close Database

```

We create one dependency that handles the database session and inject it wherever needed.

### Current Logged-in User

Many endpoints require information about the currently logged-in user. Instead of repeating:

```

Read Token
↓
Validate Token
↓
Load User

```

We create a dependency that performs these steps once and reuse it across the application.

### Logging Requests

Dependencies can record request information before the endpoint runs. Example:

```

Client Request
↓
Log Request
↓
Execute Endpoint
↓
Return Response

```

This keeps logging separate from business logic.

## Advantages of Dependency Injection

### Code Reusability

Write the dependency once and use it in many endpoints. Example:

- Authentication

- Database connections

- Logging

- Permission checks

### Cleaner Code

Endpoints focus only on business logic. Instead of mixing authentication, validation, and processing together, each concern is handled separately.

### Easy Maintenance

If authentication changes, we update one dependency instead of modifying every endpoint.

### Better Testing

Dependencies can be replaced with test versions during unit testing. This makes testing easier because we can isolate application components.

### Scalability

As projects grow, Dependency Injection keeps the code organized and modular. Large applications often have dozens of reusable dependencies.

## Best Practices

### Keep Dependencies Small

Each dependency should perform a single responsibility. Good examples:

- Verify token

- Get database session

- Check permissions

- Read headers

Avoid combining unrelated tasks into one dependency.

### Use Meaningful Names

Prefer: `get_current_user()` instead of: `func1()` Clear names improve readability.

### Avoid Business Logic in Dependencies

Dependencies should prepare data or perform shared tasks. Business logic should remain inside service functions or endpoints.

### Reuse Dependencies

If multiple endpoints require the same functionality, create one dependency and inject it where needed. This reduces duplication and improves consistency.

### Organize Dependencies

As projects grow, place dependencies in a separate file. Example structure:

```

app/
│
├── main.py
├── dependencies.py
├── routers/
├── models/
├── schemas/
└── database/

```

This keeps the project clean and easier to navigate.

## Common Mistakes

### Repeating Code

Avoid writing the same authentication or database code in multiple endpoints. Create a reusable dependency instead.

### Large Dependencies

A dependency that performs many unrelated tasks becomes difficult to understand and maintain. Keep each dependency focused.

### Ignoring

`Depends` Calling dependency functions manually defeats the purpose of Dependency Injection. Let FastAPI manage dependency execution using `Depends()`.

### Poor Organization

As the application grows, storing all dependencies in a single file can become confusing. Organize them into dedicated modules based on their purpose.

## Summary of Dependency Injection

Concept Description **Dependency** A reusable function executed before an endpoint **Depends** FastAPI utility for injecting dependencies **Purpose** Share common functionality across endpoints Authentication, database sessions, headers, logging, **Common Uses** permissions **Main Benefits** Reusability, cleaner code, easier testing, scalability

### Conclusion

Dependency Injection is one of FastAPI\'s most powerful features because it promotes clean, reusable, and maintainable code. By using the `Depends()` function, we can separate common tasks such as authentication, database connections, permission checks, request logging, and header processing from our business logic. This reduces code duplication, improves readability, and makes applications easier to test and maintain. As FastAPI projects grow in size and complexity, Dependency Injection becomes essential for organizing code into reusable components, allowing developers to build scalable, secure, and professional APIs with greater efficiency.');

-- Lecture 8: Middleware & CORS in FastAPI
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Middleware & CORS in FastAPI', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Middleware & CORS in FastAPI

## Understanding Middleware

### What is Middleware?

**Middleware** is a layer of code that runs **before and after** every request is processed by a FastAPI application. It acts as an intermediary between the client and the server, allowing developers to inspect, modify, or perform actions on requests and responses. Think of middleware as the **reception desk** of a hotel. Every guest must first pass through the reception before entering the hotel, and they also pass by the reception when leaving. The receptionist can verify identities, record visits, or provide assistance before allowing access. Similarly, middleware can:

- Inspect incoming requests

- Modify request or response data

- Log request information

- Measure processing time

- Add custom headers

- Handle security-related tasks

### How Middleware Works

Every request follows this sequence:

```

Client
↓
Middleware
↓
FastAPI Endpoint
↓
Middleware
↓
Client Response

```

The middleware executes **twice**: 1. Before the endpoint function runs. 2. After the endpoint returns a response.

### Why Do We Use Middleware?

Instead of repeating the same code in every endpoint, middleware performs common tasks once for all requests. Common uses include:

- Logging requests

- Authentication

- Measuring response time

- Adding response headers

- Monitoring performance

- Security checks

Middleware keeps the application clean and avoids code duplication.

## Creating Middleware in FastAPI

### Importing Middleware Components

FastAPI provides middleware support through Starlette. Example:

```

from fastapi import FastAPI, Request
import time
app = FastAPI()

```

The `Request` object provides access to incoming request information.

### Creating Custom Middleware

Example:

```

@app.middleware("http")
async def process_time(
request: Request,
call_next
):
response = await call_next(request)
return response

```

Explanation:

- `request` contains the incoming request.

- `call_next()` forwards the request to the endpoint.

- `response` contains the endpoint\'s output.

Every HTTP request passes through this middleware.

### Middleware Execution Flow

```

Receive Request
↓
Execute Middleware
↓
Run Endpoint
↓
Generate Response
↓
Execute Middleware Again
↓
Return Response

```

This sequence occurs for every request handled by the application.

## Practical Uses of Middleware

### Measuring Request Processing Time

Middleware is commonly used to calculate how long an endpoint takes to execute. Example:

```

@app.middleware("http")
async def add_process_time(
request: Request,
call_next
):
start = time.time()
response = await call_next(request)
end = time.time()
response.headers["X-Process-Time"] = str(end - start)
return response

```

This middleware adds a custom response header containing the processing time. Example response header: `X-Process-Time: 0.023` This information is useful for monitoring application performance.

### Logging Requests

Middleware can log every incoming request. Example:

```

@app.middleware("http")
async def log_requests(
request: Request,
call_next
):
print(request.method)
print(request.url)
response = await call_next(request)
return response

```

Example output:

```

GET
http://127.0.0.1:8000/menu

```

Logging helps developers debug applications and monitor user activity.

### Adding Custom Headers

Middleware can add headers to every response. Example:

```

response.headers["Application"] = "Bloom & Brew API"

```

Response header:

```

Application: Bloom & Brew API

```

Custom headers provide additional information about the API.

### What is CORS?

**CORS (Cross-Origin Resource Sharing)** is a browser security mechanism that controls whether one website is allowed to access resources from another website. A browser considers two URLs to have different origins if they differ in:

- Protocol (HTTP or HTTPS)

- Domain name

- Port number

Example: Frontend: `http://localhost:3000` Backend: `http://localhost:8000` Although both run on the same computer, the different ports make them different origins. Without proper CORS configuration, the browser blocks communication between them.

### Why is CORS Needed?

Suppose our React frontend is running on: `http://localhost:3000` Our FastAPI backend is running on: `http://localhost:8000` When the frontend tries to request data: `GET /flowers` The browser blocks the request unless the backend explicitly allows it. CORS solves this problem by defining which origins are permitted to access the API.

### How CORS Works

```

Browser
↓
Frontend Request
↓
FastAPI Server
↓
Check CORS Rules
↓
Allow or Block Request
↓
Response

```

The browser enforces CORS based on the server\'s configuration.

### Importing CORSMiddleware

FastAPI provides built-in middleware for handling CORS. Example:

```

from fastapi.middleware.cors import CORSMiddleware

```

### Adding CORSMiddleware

Example:

```

app.add_middleware(
CORSMiddleware,
allow_origins=[
"http://localhost:3000"
],
allow_credentials=True,
allow_methods=["*"],
allow_headers=["*"]
)

```

This configuration allows requests from the specified frontend application.

### Explanation of Parameters

### allow_origins

Specifies which websites are allowed to access the API. Example:

```

allow_origins=[
"http://localhost:3000"
]

```

### allow_credentials

`allow_credentials=True` Allows cookies and authentication credentials to be included in requests.

### allow_methods

`allow_methods=["*"]` Allows all HTTP methods:

- GET

- POST

- PUT

- PATCH

- DELETE

### allow_headers

`allow_headers=["*"]` Allows all request headers.

## CORS in Real Applications

### React Frontend

`http://localhost:3000` Communicates with: `http://localhost:8000` The backend must include the frontend origin in `allow_origins`.

### Vue Frontend

`http://localhost:5173` Must also be added if it needs access to the FastAPI backend.

### Production Example

Instead of localhost, production applications use real domains. Example:

```

allow_origins=[
"https://myflowercafe.com"
]

```

Only this domain is allowed to communicate with the API.

## Middleware vs Dependency Injection

Middleware Dependency Injection Runs for every request Runs only where used Executes before and after Executes before the endpoint only endpoints Used for logging, CORS, Used for authentication, database sessions, permissions security headers Applied globally Applied to selected endpoints Both are important but serve different purposes.

## Best Practices

### Keep Middleware Lightweight

Middleware runs for every request. Avoid heavy database operations or complex business logic inside middleware.

### Use Middleware for Global Tasks

Middleware is best suited for:

- Logging

- Performance monitoring

- Security headers

- CORS

- Request timing

Business logic should remain inside endpoints or service functions.

### Limit Allowed Origins

Avoid using: `allow_origins=["*"]` in production because it allows every website to access the API. Instead, specify trusted domains. Example:

```

allow_origins=[
"https://myflowercafe.com"
]

```

### Use HTTPS in Production

Secure communication with HTTPS helps protect authentication tokens and user data during transmission.

### Test CORS Carefully

Always verify that:

- The frontend can access the API.

- Unauthorized domains are blocked.

- Authentication continues to function correctly.

## Common Mistakes

### Allowing Every Origin

Using: `allow_origins=["*"]` may expose your API to unnecessary security risks, especially when credentials are involved.

### Putting Business Logic in Middleware

Middleware should not contain order processing, payment calculations, or database updates. Its purpose is to handle cross-cutting concerns shared across requests.

### Forgetting

`call_next()` If middleware does not call:

```

response = await call_next(request)

```

the request never reaches the endpoint, and no response is generated.

### Ignoring Browser CORS Errors

If a frontend application cannot communicate with the backend, verify that:

- The frontend origin is listed in `allow_origins`.

- The correct HTTP methods are allowed.

- Required headers are permitted.

Most CORS issues are caused by incorrect configuration.

## Summary of Middleware & CORS

Concept Description Code executed before and after every **Middleware** request Logging, timing, security, headers, **Purpose of Middleware** monitoring Browser security mechanism for cross- **CORS** origin requests Built-in FastAPI middleware for **CORSMiddleware** configuring CORS Defines trusted websites that can access **allow_origins** the API **allow_methods** Specifies permitted HTTP methods **allow_headers** Specifies permitted request headers Allows cookies and authentication **allow_credentials** credentials

### Conclusion

Middleware and CORS are essential features for building secure and efficient FastAPI applications. Middleware provides a centralized way to execute common tasks such as logging, performance monitoring, adding response headers, and handling requests before and after endpoint execution. CORS, on the other hand, enables controlled communication between applications hosted on different origins while protecting users through browser-enforced security rules. FastAPI\'s built-in `CORSMiddleware` makes configuring cross-origin access simple and flexible. By keeping middleware lightweight, limiting allowed origins, using HTTPS, and separating business logic from middleware, developers can build scalable, secure, and maintainable APIs that integrate seamlessly with modern frontend frameworks such as React, Vue, and Angular.');

-- Lecture 9: Database Integration (SQLAlchemy)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Database Integration (SQLAlchemy)', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Database Integration (SQLAlchemy)

## Introduction to Database Integration

### What is Database Integration?

A database is the heart of most modern web applications. While FastAPI can receive requests and return responses, it needs a database to **store, retrieve, update, and delete** information permanently. **Database Integration** is the process of connecting a FastAPI application to a database so that it can manage data efficiently. Instead of keeping data only in memory, the application saves it in a database where it remains available even after the server restarts. For example, in our **Bloom & Brew Café Management System**, the database stores:

- Customers

- Flower inventory

- Café menu items

- Orders

- Reservations

- User accounts

Without a database, all this information would be lost whenever the application stops running.

### Why Do We Need SQLAlchemy?

FastAPI itself does not include a built-in **Object Relational Mapper (ORM)** like Django. Instead, we commonly use **SQLAlchemy**, one of the most popular Python libraries for working with relational databases. SQLAlchemy allows us to interact with databases using **Python classes and objects** instead of writing raw SQL queries for every operation. Instead of writing:

```

SELECT * FROM flowers;

```

We can write: `session.query(Flower).all()` This makes the code easier to read, maintain, and reuse.

### Advantages of SQLAlchemy

SQLAlchemy provides many benefits:

- Works with multiple database systems

- Reduces the need to write raw SQL

- Supports Object-Oriented Programming (OOP)

- Improves code readability

- Simplifies database management

- Provides strong security against SQL injection

- Integrates smoothly with FastAPI

## Installing SQLAlchemy

### Required Packages

Before connecting FastAPI to a database, install the required libraries. Install SQLAlchemy: `pip install sqlalchemy` If using SQLite, no additional driver is required because it is included with Python. For MySQL: `pip install pymysql` For PostgreSQL: `pip install psycopg2-binary`

### Project Structure

A well-organized FastAPI project might look like this:

```

app/
│
├── main.py
├── database.py
├── models.py
├── schemas.py
├── crud.py
├── routers/
└── dependencies.py

```

Each file has a specific responsibility, making the project easier to maintain.

## Creating the Database Connection

### Creating database.py

Create a file named: `database.py` This file manages the database connection.

### Database URL

For SQLite:

```

DATABASE_URL = "sqlite:///./cafe.db"

```

Explanation:

- `sqlite` → Database type

- `./cafe.db` → Database file stored in the project folder

### Creating the Engine

```

from sqlalchemy import create_engine
engine = create_engine(DATABASE_URL)

```

The **engine** establishes communication between the application and the database.

### Creating a Session

```

from sqlalchemy.orm import sessionmaker
SessionLocal = sessionmaker(
autocommit=False,
autoflush=False,
bind=engine
)

```

A **session** is used to interact with the database by performing queries and transactions.

### Creating the Base Class

```

from sqlalchemy.orm import declarative_base
Base = declarative_base()

```

All database models will inherit from this base class.

## Creating Database Models

### What is a Model?

A model is a Python class that represents a database table. Each:

- Class → Table

- Attribute → Column

- Object → Row

### Creating a Flower Model

```

from sqlalchemy import Column, Integer, String, Float
from database import Base
class Flower(Base):
__tablename__ = "flowers"
id = Column(Integer, primary_key=True)
name = Column(String)
price = Column(Float)
stock = Column(Integer)

```

This creates a table named **flowers**.

### Creating a Menu Model

```

class MenuItem(Base):
__tablename__ = "menu"
id = Column(Integer, primary_key=True)
name = Column(String)
category = Column(String)
price = Column(Float)

```

Each model represents a different table in the database.

## Creating Database Tables

### Generating Tables

Inside main.py:

```

from database import engine, Base
import models
Base.metadata.create_all(bind=engine)

```

When the application starts, SQLAlchemy creates all tables that do not already exist.

### Database Result

SQLite database: `cafe.db` Tables:

```

flowers
menu

```

The tables are now ready to store data.

## Database Sessions

### What is a Session?

A **database session** is a temporary connection used to perform operations such as:

- Insert

- Select

- Update

- Delete

Think of a session as a conversation between the application and the database.

### Creating a Session Dependency

```

from database import SessionLocal
def get_db():
db = SessionLocal()
try:
yield db
finally:
db.close()

```

This dependency:

- Opens the database session

- Provides it to the endpoint

- Closes it automatically after the request

This is the recommended approach in FastAPI.

## CRUD Operations Using SQLAlchemy

### Creating a Record

```

flower = Flower(
name="Rose",
price=1200,
stock=20
)
db.add(flower)
db.commit()

```

The new flower is saved in the database.

### Reading Records

```

flowers = db.query(Flower).all()

```

Returns every flower. Retrieve one flower:

```

flower = db.query(Flower).filter(
Flower.id == 1
).first()

```

### Updating a Record

```

flower.price = 1500
db.commit()

```

The updated price is stored in the database.

### Deleting a Record

```

db.delete(flower)
db.commit()

```

The selected record is permanently removed.

## Integrating SQLAlchemy with FastAPI

### Using Dependency Injection

```

from fastapi import Depends
from sqlalchemy.orm import Session
@app.get("/flowers")
def get_flowers(
db: Session = Depends(get_db)
):
return db.query(Flower).all()

```

FastAPI automatically injects the database session into the endpoint.

### Creating Data

```

@app.post("/flowers")
def create_flower(
flower: FlowerSchema,
db: Session = Depends(get_db)
):
new_flower = Flower(
name=flower.name,
price=flower.price,
stock=flower.stock
)
db.add(new_flower)
db.commit()
return new_flower

```

The request body is validated by Pydantic, while SQLAlchemy stores the data.

## SQLAlchemy Relationships

### Why Use Relationships?

Many applications contain related data. Example: One customer can place many orders.

```

Customer
↓
Orders

```

Relationships allow SQLAlchemy to connect related tables.

### One-to-Many Relationship

Example:

```

from sqlalchemy.orm import relationship
class Customer(Base):
__tablename__ = "customers"
id = Column(Integer, primary_key=True)
name = Column(String)
orders = relationship(
"Order",
back_populates="customer"
)

```

Each customer may have multiple orders.

### Foreign Keys

Example:

```

from sqlalchemy import ForeignKey
customer_id = Column(
Integer,
ForeignKey("customers.id")
)

```

A foreign key links one table to another.

## Best Practices

### Separate Models and Schemas

Keep SQLAlchemy models and Pydantic schemas in different files. Example:

```

models.py
schemas.py

```

Models manage the database, while schemas validate API data.

### Use Dependency Injection

Always create database sessions using `Depends(get_db)` instead of creating sessions manually in every endpoint.

### Commit Only When Necessary

Call: `db.commit()` only after successful changes. Avoid unnecessary commits.

### Close Sessions

Always close database sessions after use. The `yield` pattern in `get_db()` handles this automatically.

### Use Relationships

Instead of manually joining related data, define relationships between tables to simplify queries.

## Common Mistakes

### Forgetting to Commit

Calling `db.add()` without `db.commit()` means the data will not be saved permanently.

### Leaving Sessions Open

Failing to close sessions can lead to resource leaks and unnecessary database connections.

### Mixing Models and Schemas

Do not use SQLAlchemy models for request validation. Use Pydantic schemas for API requests and responses.

### Ignoring Relationships

Manually managing related data can make code repetitive and harder to maintain. Use SQLAlchemy relationships whenever appropriate.

## SQLAlchemy Workflow

```

Client Request
↓
FastAPI Endpoint
↓
Pydantic Validation
↓
Database Session
↓
SQLAlchemy Model
↓
Database
↓
Response

```

This workflow shows how FastAPI, Pydantic, and SQLAlchemy work together to process requests and manage persistent data.

### Conclusion

SQLAlchemy is a powerful Object Relational Mapper (ORM) that enables FastAPI applications to interact with relational databases using Python objects instead of raw SQL queries. By creating database models, establishing database connections, managing sessions, and performing CRUD operations, we can build applications that store and retrieve data efficiently. SQLAlchemy integrates seamlessly with FastAPI through Dependency Injection, allowing database sessions to be managed safely and automatically. Features such as relationships, foreign keys, and object-oriented models simplify complex database operations while improving code readability and maintainability. By following best practices—such as separating models from schemas, using reusable session dependencies, managing transactions carefully, and organizing project files—we can build scalable, secure, and production-ready FastAPI applications that effectively handle real-world data.');

-- Lecture 10: Authentication (OAuth2 & JWT) in FastAPI
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Authentication (OAuth2 & JWT) in FastAPI', 10, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Authentication (OAuth2 & JWT) in FastAPI

## Introduction to Authentication

### What is Authentication?

**Authentication** is the process of verifying the identity of a user before allowing access to an application or its resources. It answers the question: **"Who are you?"** When a user enters their username and password into an application, the system checks whether the provided credentials are correct. If they are valid, the user is authenticated and granted access. For example, in our **Bloom & Brew Café Management System**, only registered users should be able to:

- Place orders

- Reserve tables

- Manage flower inventory

- View customer information

- Access the admin dashboard

Authentication ensures that only authorized users can perform these actions.

### Authentication vs Authorization

These two concepts are often confused, but they have different purposes.

### Authentication

Authentication verifies the user\'s identity. Example:

- Logging in with an email and password.

- Signing in using a Google account.

Question answered: **Who are you?**

### Authorization

Authorization determines what an authenticated user is allowed to do. Example:

- An administrator can add menu items.

- A customer can place orders but cannot delete products.

Question answered: **What are you allowed to do?** Authentication always comes before authorization.

### Why is Authentication Important?

Authentication provides several benefits:

- Protects sensitive information.

- Prevents unauthorized access.

- Secures user accounts.

- Supports personalized user experiences.

- Builds trust between users and the application.

Without authentication, anyone could access or modify private data.

## Understanding OAuth2

### What is OAuth2?

**OAuth 2.0 (OAuth2)** is an industry-standard framework for handling secure authentication and authorization. It allows applications to verify users and grant controlled access to protected resources without exposing passwords. FastAPI provides built-in support for OAuth2, making it easier to implement secure login systems.

### How OAuth2 Works

The basic authentication flow is:

```

User
↓
Login Request
↓
FastAPI Server
↓
Verify Username & Password
↓
Generate Access Token
↓
Return Token
↓
Client Stores Token
↓
Client Sends Token with Future Requests
↓
Protected Endpoint
↓
Access Granted

```

Instead of sending a username and password with every request, the client sends an **access token**.

### Advantages of OAuth2

- Secure authentication

- Widely adopted industry standard

- Reduces password exposure

- Supports token-based authentication

- Works well with web and mobile applications

- Easily integrates with FastAPI

## Understanding JWT (JSON Web Token)

### What is JWT?

A **JSON Web Token (JWT)** is a secure token used to exchange user information between the client and the server. After successful login, the server generates a JWT and sends it to the client. The client stores this token and includes it in future requests to access protected endpoints. A JWT is digitally signed, making it difficult to modify without detection.

### Structure of a JWT

A JWT consists of three parts:

```

Header
↓
Payload
↓
Signature

```

Example: `xxxxx.yyyyy.zzzzz` Each section is separated by a period (`.`).

### 1. Header

The header contains information about the token. Example:

```

{
"alg": "HS256",
"typ": "JWT"
}

```

### 2. Payload

The payload stores user information, known as **claims**. Example:

```

{
"sub": "anum@example.com",
"role": "customer"
}

```

The payload should never contain sensitive information such as passwords.

### 3. Signature

The signature ensures that the token has not been modified. It is generated using:

- Header

- Payload

- Secret Key

If someone changes the payload, the signature becomes invalid, and the server rejects the token.

## Setting Up OAuth2 and JWT in FastAPI

### Required Packages

Install the required libraries:

```

pip install python-jose
pip install passlib[bcrypt]

```

These packages are used for:

- Creating JWT tokens

- Verifying JWT tokens

- Hashing passwords

### Import Required Modules

```

from fastapi import FastAPI, Depends
from fastapi.security import OAuth2PasswordBearer
from jose import jwt

```

These modules provide authentication functionality.

### Creating an OAuth2 Scheme

```

oauth2_scheme = OAuth2PasswordBearer(
tokenUrl="token"
)

```

Explanation:

- `OAuth2PasswordBearer` extracts the token from incoming requests.

- `tokenUrl` specifies the endpoint where users obtain access tokens.

## Password Hashing

### Why Hash Passwords?

Passwords should **never** be stored in plain text. Instead of storing: `mypassword123` We store a hashed version: `$2b$12$A9Jm...` Even if the database is compromised, attackers cannot easily recover the original password.

### Hashing Passwords

Example:

```

from passlib.context import CryptContext
pwd_context = CryptContext(
schemes=["bcrypt"],
deprecated="auto"
)

```

Hash a password:

```

hashed_password = pwd_context.hash(
"mypassword123"
)

```

Verify a password:

```

pwd_context.verify(
"mypassword123",
hashed_password
)

```

### Benefits of Password Hashing

- Protects user credentials.

- Prevents password theft.

- Improves application security.

- Follows industry best practices.

## Creating and Verifying JWT Tokens

### Creating an Access Token

Example:

```

from jose import jwt
SECRET_KEY = "mysecretkey"
ALGORITHM = "HS256"
data = {
"sub": "anum@example.com"
}
token = jwt.encode(
data,
SECRET_KEY,
algorithm=ALGORITHM
)

```

The encoded token is returned to the client after successful login.

### Decoding a Token

Example:

```

payload = jwt.decode(
token,
SECRET_KEY,
algorithms=[ALGORITHM]
)

```

If the token is valid, the payload is returned. If the token is invalid or expired, FastAPI rejects the request.

## Protecting Endpoints

### Using

`Depends()` Protected endpoints require a valid access token. Example:

```

@app.get("/profile")
def profile(
token: str = Depends(oauth2_scheme)
):
return {
"Token": token
}

```

FastAPI automatically extracts the token from the request.

### Authorization Header

Clients send the token using the HTTP Authorization header. Example:

```

Authorization: Bearer eyJhbGciOiJIUzI1Ni...

```

The word **Bearer** tells the server that the following value is an access token.

### Protected Workflow

```

Login
↓
Generate JWT
↓
Client Stores Token
↓
Client Sends Token
↓
FastAPI Validates Token
↓
Protected Endpoint
↓
Response

```

Only authenticated users can access protected resources.

## Token Expiration

### Why Should Tokens Expire?

Permanent tokens create security risks. If an attacker steals a token, they could access the application indefinitely. Adding an expiration time limits this risk.

### Example

A token may expire after:

- 15 minutes

- 30 minutes

- 1 hour

After expiration, the user must log in again to obtain a new token.

### Advantages of Expiration

- Improves security.

- Limits damage if a token is stolen.

- Encourages periodic re-authentication.

## Authentication Flow in FastAPI

```

User
↓
Enter Username & Password
↓
FastAPI Validates Credentials
↓
Generate JWT Token
↓
Return Token
↓
Client Stores Token
↓
Future Requests
↓
Authorization Header
↓
FastAPI Verifies Token
↓
Access Granted

```

This token-based approach eliminates the need to send usernames and passwords with every request.

## Best Practices

### Always Hash Passwords

Never store plain-text passwords. Always use secure hashing algorithms such as **bcrypt**.

### Keep the Secret Key Safe

The `SECRET_KEY` should never be shared or hard-coded in production applications. Store it securely using environment variables or configuration files.

### Use HTTPS

Transmit tokens only over HTTPS to prevent interception during network communication.

### Set Token Expiration

Always include an expiration time for access tokens. Short-lived tokens reduce security risks.

### Protect Sensitive Endpoints

Require authentication for endpoints such as:

- Dashboard

- Orders

- Payments

- User Profiles

- Inventory Management

Public endpoints, such as viewing the café menu, may remain accessible without authentication.

## Common Mistakes

### Storing Plain-Text Passwords

Never save passwords directly in the database. Always hash them before storage.

### Using Weak Secret Keys

A weak or predictable secret key makes JWT tokens vulnerable to attacks. Use a long, random, and securely stored key.

### Ignoring Token Expiration

Tokens without expiration remain valid indefinitely, increasing security risks if compromised.

### Exposing Sensitive Data in JWT

Do not store passwords, payment details, or other confidential information inside the JWT payload. The payload can be decoded by anyone who possesses the token.

### Skipping Authentication on Protected Routes

Always secure endpoints that expose sensitive data or modify application resources.

## Summary of OAuth2 and JWT

Concept Description **Authentication** Verifies the identity of a user **Authorization** Determines what an authenticated user can access Standard framework for secure authentication and **OAuth2** authorization **JWT** Digitally signed token used for secure user authentication **Password Hashing** Protects stored passwords using algorithms like bcrypt **Bearer Token** Token sent in the `Authorization` header **Token Expiration** Limits the lifetime of access tokens for better security

### Conclusion

Authentication is a critical aspect of modern web application security, ensuring that only verified users can access protected resources. FastAPI simplifies authentication by providing built-in support for OAuth2 and seamless integration with JWT for token-based authentication. By hashing passwords with **bcrypt**, generating secure JWT access tokens, verifying those tokens on protected routes, and implementing token expiration, developers can create robust and secure authentication systems. Combining OAuth2 with JWT not only improves security but also enhances scalability, making it suitable for web applications, mobile apps, and RESTful APIs. By following best practices—such as protecting secret keys, using HTTPS, securing sensitive endpoints, and never exposing confidential information in tokens —we can build authentication systems that are reliable, maintainable, and production-ready.');

-- Lecture 11: Background Tasks in FastAPI
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Background Tasks in FastAPI', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Background Tasks in FastAPI

## Introduction to Background Tasks

### What are Background Tasks?

A **Background Task** is a task that runs **after the server has already sent a response to the client**. Instead of making the user wait until every operation is complete, FastAPI immediately returns the response while the remaining work continues in the background. Think of a café where a customer places an order. The cashier immediately gives the customer a receipt and confirms that the order has been received. Meanwhile, the kitchen starts preparing the coffee and flowers behind the scenes. The customer doesn\'t have to stand at the counter waiting for every step to finish. Similarly, FastAPI allows us to perform certain operations **after** responding to the client.

### Why Do We Need Background Tasks?

Some operations take extra time but are **not required before sending a response**. Examples include:

- Sending confirmation emails

- Writing logs to a file

- Sending notifications

- Generating reports

- Saving analytics

- Uploading files

- Processing images

Instead of making users wait, these tasks run in the background.

### Advantages of Background Tasks

Using background tasks provides several benefits:

- Faster response time

- Better user experience

- Improved application performance

- Cleaner code organization

- Reduced waiting time for users

## Understanding Background Tasks in FastAPI

### How Background Tasks Work

The execution flow is:

```

Client Request
↓
FastAPI Endpoint
↓
Return Response
↓
Execute Background Task
↓
Task Completed

```

Notice that the response is sent **before** the background task starts.

### When Should We Use Background Tasks?

Background tasks are suitable for operations that:

- Are not immediately required.

- Can safely execute after the response.

- Do not affect the current response.

For example: Customer places an order. Instead of waiting for an email confirmation:

```

Receive Order
↓
Return Success Response
↓
Send Confirmation Email

```

The customer receives a quick response while the email is sent afterward.

### When Should We NOT Use Background Tasks?

Avoid using background tasks for operations that must finish before the response. Examples:

- User authentication

- Payment processing

- Database validation

- Inventory checks before purchase

These tasks should complete before the response is returned.

## Creating Background Tasks

### Importing BackgroundTasks

FastAPI provides the `BackgroundTasks` class. Example:

```

from fastapi import FastAPI, BackgroundTasks
app = FastAPI()

```

### Creating a Background Function

Example:

```

def write_log():
print("Request completed.")

```

This function will run in the background.

### Adding the Task

Example:

```

@app.post("/orders")
def create_order(
background_tasks: BackgroundTasks
):
background_tasks.add_task(
write_log
)
return {
"message": "Order received successfully."
}

```

FastAPI: 1. Returns the response. 2. Executes `write_log()` afterward.

## Passing Parameters to Background Tasks

### Background Function with Parameters

Background tasks can receive arguments. Example:

```

def send_email(
email: str
):
print(
f"Sending email to {email}"
)

```

### Passing Values

Example:

```

@app.post("/register")
def register(
background_tasks: BackgroundTasks
):
background_tasks.add_task(
send_email,
"customer@example.com"
)
return {
"message": "Registration successful."
}

```

Response:

```

{
"message": "Registration successful."
}

```

Background task:

```

Sending email to customer@example.com

```

The client receives the response immediately while the email is processed afterward.

## Real-World Examples

### Sending Confirmation Emails

A common use case is sending confirmation emails after registration. Workflow:

```

User Registers
↓
Save User
↓
Return Success Response
↓
Send Welcome Email

```

The user doesn\'t have to wait for the email to be delivered.

### Writing Logs

Applications often record activity. Example:

```

Customer Places Order
↓
Return Response
↓
Save Activity Log

```

Logging occurs after the response is sent.

### Generating Reports

Suppose a manager requests a sales report. Workflow:

```

Manager Requests Report
↓
Return "Report Started"
↓
Generate Report
↓
Save Report

```

Generating reports may take several minutes, making them ideal background tasks.

### Processing Uploaded Images

Example:

```

Upload Flower Image
↓
Return Upload Success
↓
Resize Image
↓
Generate Thumbnail
↓
Store Image

```

The upload appears instant to the user while image processing continues in the background.

## Background Tasks with File Operations

### Writing to a File

Example:

```

def save_log(
message: str
):
with open(
"log.txt",
"a"
) as file:
file.write(
message + "\\n"
)

```

### Using the Task

```

@app.post("/flowers")
def add_flower(
background_tasks: BackgroundTasks
):
background_tasks.add_task(
save_log,
"New flower added."
)
return {
"message": "Flower added."
}

```

The log is written after the response is returned.

## Background Tasks vs Celery

### BackgroundTasks

Suitable for:

- Simple tasks

- Small applications

- Lightweight processing

- Short-running operations

Examples:

- Logging

- Sending emails

- Notifications

- File updates

### Celery

Celery is a separate task queue used for more complex background processing. Suitable for:

- Heavy computations

- Long-running tasks

- Scheduled jobs

- Distributed processing

- Multiple worker machines

Examples:

- Video conversion

- Large report generation

- Machine learning tasks

- Bulk email campaigns

FastAPI\'s built-in `BackgroundTasks` is not intended to replace Celery for large-scale asynchronous workloads.

## Best Practices

### Keep Tasks Short

Background tasks should complete quickly. Avoid operations that run for several minutes.

### Use Celery for Heavy Jobs

If tasks involve:

- Large datasets

- Video rendering

- AI processing

- Extensive file operations

Use Celery instead of `BackgroundTasks`.

### Avoid Critical Business Logic

Do not place essential operations in background tasks. Examples to avoid:

- Charging credit cards

- Confirming payments

- Updating inventory before checkout

These tasks must finish before responding.

### Handle Errors Properly

Background functions should include error handling. Example:

```

try:
send_email()
except Exception:
print("Email failed.")

```

Proper error handling prevents unexpected failures.

### Keep Background Functions Independent

A background function should focus on one responsibility. Examples:

- Send email

- Save log

- Resize image

- Generate invoice

Avoid combining many unrelated tasks into one function.

## Common Mistakes

### Using Background Tasks for Long Operations

Operations that take several minutes can delay server resources. Use Celery for these workloads.

### Expecting Immediate Results

Since background tasks execute after the response, clients should not expect their results immediately.

### Ignoring Error Handling

If a background task fails silently, developers may never know the problem occurred. Always log or handle exceptions.

### Running Business-Critical Logic

Never move authentication, payment processing, or essential database validation into background tasks. These operations must complete before the client receives a response.

## Summary of Background Tasks

Concept Description A task executed after **Background Task** sending the response Improve response speed **Purpose** by delaying non-critical work **FastAPI Class** `BackgroundTasks` Emails, logging, **Common Uses** notifications, image processing Use Celery instead of **Heavy Workloads** `BackgroundTasks` Better user experience **Main Benefit** through faster responses

### Conclusion

Background Tasks in FastAPI provide an efficient way to execute non-critical operations after a response has been sent to the client. By using the `BackgroundTasks` class, developers can improve application responsiveness while handling activities such as sending emails, writing logs, generating reports, and processing uploaded files in the background. This approach enhances user experience by reducing waiting times and keeping endpoint logic clean. However, background tasks are intended for lightweight and short-lived operations. For complex, long-running, or distributed workloads, tools such as Celery are a more appropriate choice. By following best practices—keeping tasks independent, handling errors properly, avoiding critical business logic, and selecting the right tool for the workload—we can build FastAPI applications that are efficient, scalable, and production-ready.');

-- Lecture 12: WebSockets in FastAPI
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'WebSockets in FastAPI', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# WebSockets in FastAPI

## Introduction to WebSockets

### What are WebSockets?

**WebSockets** are a communication protocol that enables **real-time, two-way (bidirectional) communication** between a client and a server over a single, persistent connection. Unlike traditional HTTP requests, where the client must repeatedly request updates from the server, WebSockets keep the connection open, allowing both the client and the server to send data at any time. Think of HTTP as sending letters through the mail. Every time you need information, you write a new letter and wait for a reply. WebSockets, on the other hand, are like having a live phone call where both people can speak instantly without reconnecting. FastAPI provides built-in support for WebSockets, making it easy to develop real-time applications.

### Why Do We Need WebSockets?

Traditional HTTP follows a **request-response** model. Example:

```

Client
↓
Request
↓
Server
↓
Response
↓
Connection Closed

```

If the client wants new data, it must send another request. WebSockets solve this limitation by maintaining a continuous connection. `Client` ⇄ `Persistent Connection` ⇄ `Server` Both the client and server can exchange data instantly.

### Advantages of WebSockets

WebSockets offer several benefits:

- Real-time communication

- Persistent connection

- Lower network overhead

- Faster data exchange

- Reduced latency

- Better user experience

- Supports bidirectional communication

## HTTP vs WebSockets

HTTP is suitable for:

- Viewing web pages

- Downloading files

- REST APIs

- Request-response applications

Workflow:

```

Client
↓
HTTP Request
↓
Server
↓
HTTP Response
↓
Connection Closed

```

Every request creates a new connection.

### WebSocket Communication

Workflow:

```

Client
↓
Open Connection

```

⇅ `Exchange Messages` ⇅ `Exchange Messages` ⇅ `Close Connection` The same connection remains open until either side closes it.

### Comparison

HTTP WebSockets Request-response model Two-way communication Connection closes after each request Persistent connection Higher overhead Lower overhead Client initiates every request Client and server can both send data Best for REST APIs Best for real-time applications

## Creating WebSockets in FastAPI

### Importing WebSocket

Example:

```

from fastapi import FastAPI, WebSocket
app = FastAPI()

```

The `WebSocket` class is used to create WebSocket endpoints.

### Creating a WebSocket Endpoint

Example:

```

@app.websocket("/ws")
async def websocket_endpoint(
websocket: WebSocket
):
await websocket.accept()
await websocket.send_text(
"Welcome to Bloom & Brew Café!"
)
await websocket.close()

```

Explanation:

- `accept()` establishes the WebSocket connection.

- `send_text()` sends a message to the client.

- `close()` closes the connection.

### WebSocket URL

Unlike HTTP endpoints, WebSockets use: `ws://localhost:8000/ws` For secure connections: `wss://example.com/ws wss://` is the secure version of WebSockets, similar to HTTPS.

## Sending and Receiving Messages

### Receiving Messages

Example:

```

@app.websocket("/chat")
async def chat(
websocket: WebSocket
):
await websocket.accept()
message = await websocket.receive_text()
print(message)

```

The server waits until the client sends a message.

### Sending Messages

Example:

```

await websocket.send_text(
"Order received successfully."
)

```

The server immediately sends the message to the client.

### Echo Example

Example:

```

@app.websocket("/echo")
async def echo(
websocket: WebSocket
):
await websocket.accept()
while True:
message = await websocket.receive_text()
await websocket.send_text(
f"You said: {message}"
)

```

If the client sends: `Hello` The server responds: `You said: Hello` This creates a simple echo server.

## Real-Time Applications

### Chat Application

One of the most common uses of WebSockets is live chat. Workflow:

```

User A
↓
Server
↓
User B

```

Messages are delivered instantly without refreshing the page.

### Live Order Tracking

In our **Bloom & Brew Café Management System**, WebSockets can update customers about their orders. Example:

```

Order Received
↓
Preparing Coffee
↓
Preparing Flowers
↓
Out for Delivery
↓
Delivered

```

The customer sees updates in real time.

### Stock Updates

Suppose flower inventory changes frequently.

```

Inventory Updated
↓
Server
↓
Connected Users

```

All users receive updated stock information immediately.

### Live Notifications

WebSockets are ideal for notifications. Examples:

- New order received

- Reservation confirmed

- Product back in stock

- Promotional offers

- New customer message

Notifications appear instantly.

## Connection Management

### Accepting Connections

Every WebSocket connection must be accepted. Example: `await websocket.accept()` Without this, communication cannot begin.

### Closing Connections

Example: `await websocket.close()` Connections should be closed when communication is complete or when an error occurs.

### Handling Multiple Messages

Example:

```

while True:
message = await websocket.receive_text()
await websocket.send_text(
message
)

```

The loop keeps the connection active, allowing multiple messages to be exchanged.

## Broadcasting Messages

### What is Broadcasting?

Broadcasting means sending the same message to multiple connected clients. Example:

```

Server
↓
Client A
↓
Client B
↓
Client C

```

Every connected client receives the same update.

### Real-Life Example

Suppose a café announces: "Today\'s flower arrangements are 20% off." Instead of notifying each customer individually, the server broadcasts the announcement to all connected users simultaneously. Broadcasting is commonly used in:

- Chat rooms

- Live sports updates

- Stock market applications

- Online games

- Notification systems

## WebSockets vs REST APIs

REST API WebSocket Client sends request Client and server both send messages Short-lived connection Persistent connection Suitable for CRUD Suitable for live updates operations Uses HTTP Uses WebSocket protocol Higher latency for Very low latency repeated requests REST APIs and WebSockets often work together in the same application. For example:

- REST API → Create an order.

- WebSocket → Receive live order updates.

## Best Practices

### Close Unused Connections

Always close inactive connections to free server resources.

### Validate Incoming Messages

Never trust data sent by clients. Validate:

- Message format

- User permissions

- Input length

This improves application security.

### Handle Exceptions

Network interruptions can disconnect clients unexpectedly. Always include error handling to prevent server crashes.

### Use Secure WebSockets

In production, use: `wss://` instead of: `ws://` Secure WebSockets encrypt transmitted data.

### Use WebSockets Only When Necessary

Not every application needs WebSockets. Use them only when real-time communication is required. For standard CRUD operations, REST APIs are usually simpler and more appropriate.

## Common Mistakes

### Using WebSockets for Everything

WebSockets are powerful but should not replace REST APIs for ordinary data retrieval or updates.

### Forgetting to Accept Connections

If `accept()` is not called, the client cannot communicate with the server.

### Ignoring Disconnections

Clients may disconnect unexpectedly. Applications should handle these situations gracefully to prevent errors.

### Leaving Connections Open Forever

Unused WebSocket connections consume server resources. Close them when they are no longer needed.

## Summary of WebSockets

Concept Description **WebSocket** Protocol for real-time bidirectional communication **Connection** Persistent until closed **Main Feature** Client and server can both send messages **FastAPI Class** `WebSocket` **Common Uses** Chat, notifications, live tracking, online games **Secure Protocol** `wss://` **Best Companion** REST APIs for CRUD operations

### Conclusion

WebSockets enable real-time, bidirectional communication between clients and servers through a persistent connection, making them an essential technology for applications that require instant updates. FastAPI provides built-in support for WebSockets, allowing developers to build interactive features such as live chat systems, order tracking, inventory updates, notifications, dashboards, and collaborative applications with minimal effort. Unlike traditional HTTP, which follows a request-response model, WebSockets allow both the client and server to exchange messages whenever needed, resulting in lower latency and a smoother user experience. By following best practices— such as validating incoming data, managing connections properly, using secure `wss://` connections, handling disconnections gracefully, and combining WebSockets with REST APIs where appropriate—we can build scalable, secure, and highly responsive real-time FastAPI applications.');

-- Lecture 13: Testing FastAPI Applications
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Testing FastAPI Applications', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Testing FastAPI Applications

## Introduction to Testing in FastAPI

### What is Testing?

Testing is the process of verifying that an application works as intended. Instead of manually opening a browser and clicking buttons after every code change, we write automated tests that execute instantly and repeatedly. Testing helps us answer important questions:

- Does the API return the correct response?

- Are invalid requests handled properly?

- Does authentication work correctly?

- Have new code changes broken existing features?

Think of automated testing as having a dedicated quality assurance engineer who never gets tired and checks every feature whenever we update our application.

### Why Testing Matters

Testing provides several important advantages:

- Detects bugs early.

- Improves software quality.

- Simplifies maintenance.

- Supports continuous integration (CI/CD).

- Gives developers confidence when modifying code.

Without testing, developers often spend more time fixing unexpected issues than building new features.

### Types of Tests

### 1. Unit Testing

Unit testing verifies individual functions independently. Example:

```

def add(a, b):
return a + b

```

Test:

```

def test_add():
assert add(2, 3) == 5

```

### 2. Integration Testing

Integration testing checks whether multiple components work together. Example:

- API endpoint

- Database

- Authentication

- Business logic

All these are tested together.

### 3. End-to-End Testing

End-to-end testing simulates actual user behavior. For example:

- User logs in.

- Creates an account.

- Retrieves data.

- Logs out.

Everything is tested as one complete workflow.

## Setting Up FastAPI Testing Environment

### Installing Required Packages

The primary testing framework is **pytest**. Install it using: `pip install pytest` FastAPI also provides a testing client: `pip install httpx` Most FastAPI projects already include: `pip install fastapi uvicorn`

### Project Structure

A well-organized project may look like this:

```

project/
│
├── app/
│ ├── main.py
│ ├── models.py
│ ├── routes.py
│ └── database.py
│
├── tests/
│ ├── test_main.py
│ ├── test_users.py
│ └── test_items.py
│
└── requirements.txt

```

Keeping tests inside a dedicated **tests** folder makes the project cleaner and easier to maintain.

### Creating a Simple FastAPI Application

Example:

```

from fastapi import FastAPI
app = FastAPI()
@app.get("/")
def home():
return {"message": "Hello FastAPI"}

```

This will be our sample application for testing.

## Using TestClient in FastAPI

### What is TestClient?

FastAPI provides **TestClient**, which allows us to simulate HTTP requests without starting an actual server. Instead of running: `localhost:8000` the tests communicate directly with the application.

### Creating a Test Client

Example:

```

from fastapi.testclient import TestClient
client = TestClient(app)

```

Now the client can send requests just like a browser.

### Testing GET Requests

Example endpoint:

```

@app.get("/")
def home():
return {"message": "Hello FastAPI"}

```

Test:

```

def test_home():
response = client.get("/")
assert response.status_code == 200
assert response.json() == {
"message": "Hello FastAPI"
}

```

The test verifies:

- Status code

- JSON response

### Testing POST Requests

Suppose we have:

```

@app.post("/items")
def create_item(item: dict):
return item

```

Test:

```

def test_create_item():
data = {
"name": "Laptop",
"price": 900
}
response = client.post(
"/items",
json=data
)
assert response.status_code == 200
assert response.json() == data

```

The JSON body is automatically converted into the request payload.

### Testing Query Parameters

Endpoint:

```

@app.get("/search")
def search(name: str):
return {"name": name}

```

Test:

```

def test_search():
response = client.get(
"/search?name=John"
)
assert response.json() == {
"name": "John"
}

```

### Testing Path Parameters

Endpoint:

```

@app.get("/users/{id}")
def get_user(id: int):
return {"id": id}

```

Test:

```

def test_user():
response = client.get("/users/10")
assert response.json() == {
"id": 10
}

```

## Advanced FastAPI Testing Techniques

### Testing Error Responses

Applications must correctly handle invalid requests. Example:

```

@app.get("/users/{id}")
def user(id: int):
return {"id": id}

```

Invalid request: `/users/abc` Test:

```

def test_invalid_user():
response = client.get(
"/users/abc"
)
assert response.status_code == 422

```

FastAPI automatically validates input types.

### Testing Authentication

Many APIs require login credentials. Example:

```

headers = {
"Authorization":
"Bearer mytoken"
}
response = client.get(
"/profile",
headers=headers
)

```

Assertions:

```

assert response.status_code == 200

```

We can also verify unauthorized access:

```

response = client.get("/profile")
assert response.status_code == 401

```

### Testing Database Operations

Instead of connecting to the production database, we typically use:

- SQLite in-memory database

- Test database

- Mock database

Benefits include:

- Faster execution

- Safer testing

- No production data modification

A typical workflow is: 1. Create test database. 2. Run test. 3. Delete test database. This keeps tests isolated and repeatable.

### Testing Dependency Overrides

FastAPI allows dependencies to be overridden during testing. Example:

```

app.dependency_overrides[
get_db
] = override_db

```

This lets us replace:

- Database connections

- Authentication

- External APIs

without changing the application code.

### Testing Asynchronous Endpoints

FastAPI supports asynchronous programming. Example endpoint:

```

@app.get("/async")
async def async_route():
return {"status": "ok"}

```

With asynchronous testing:

```

import pytest
@pytest.mark.asyncio
pass

```

Async tests are especially useful when working with databases, external APIs, or background tasks.

## Best Practices for Testing FastAPI Applications

### Write Small Tests

Each test should verify one specific behavior. Good example:

```

def test_login_success():
...

```

Instead of combining many unrelated checks into one large test.

### Keep Tests Independent

Every test should work independently. Avoid relying on:

- Previous tests

- Shared variables

- Fixed execution order

Independent tests are easier to debug and maintain.

### Use Fixtures

Pytest fixtures reduce duplicated setup code. Example:

```

import pytest
@pytest.fixture
def client():
return TestClient(app)

```

Now every test can reuse the same client:

```

def test_home(client):
response = client.get("/")

```

Fixtures improve readability and consistency.

### Test Both Success and Failure Cases

For every endpoint, test:

- Valid input

- Invalid input

- Missing data

- Unauthorized access

- Incorrect parameters

Robust testing ensures the API behaves predictably in real-world scenarios.

### Use Meaningful Test Names

Good examples:

```

test_create_user()
test_delete_item()
test_login_invalid_password()

```

Avoid vague names like:

```

test1()
test_example()

```

Descriptive names make failures easier to understand.

### Run Tests Frequently

Developers should execute tests:

- Before every commit

- Before deployment

- After adding new features

- After fixing bugs

Frequent testing catches regressions early and reduces debugging time.

### Conclusion

Testing FastAPI applications is an essential practice for building reliable, maintainable, and production-ready APIs. By combining **pytest**, **TestClient**, fixtures, dependency overrides, and asynchronous testing, we can verify every layer of an application—from simple endpoints to authentication, validation, and database interactions. A strong testing strategy not only detects bugs early but also gives us the confidence to refactor code, add new features, and deploy updates without fear of introducing unexpected issues. Ultimately, well-tested FastAPI applications are more stable, easier to maintain, and better equipped to deliver a consistent experience for users.');

-- Lecture 14: Building a FastAPI Project
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a FastAPI Project', 14, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a FastAPI Project

## Introduction to FastAPI Projects

### What is a FastAPI Project?

A FastAPI project is a structured application built using the FastAPI framework. It contains multiple files and folders that separate different responsibilities such as routing, business logic, database management, models, and configuration. Unlike small practice programs where everything exists inside one file, real-world applications require organization. As projects grow, proper structure becomes essential for readability, collaboration, debugging, and scalability. FastAPI is built on top of **Starlette** for web functionality and **Pydantic** for data validation. This combination allows us to create APIs that are both fast and reliable. **Benefits of Building Structured Projects**

- Easy to maintain

- Better code organization

- Faster debugging

- Improved teamwork

- Scalable architecture

- Automatic API documentation

- Strong input validation

## Creating the Project Structure

### Recommended Folder Layout

A professional FastAPI project usually follows a modular structure.

```

fastapi_project/
│
├── app/
│ ├── main.py
│ ├── routers/
│ ├── models/
│ ├── schemas/
│ ├── database/
│ ├── services/
│ ├── utils/
│ └── config.py
│
├── tests/
├── requirements.txt
├── .env
└── README.md

```

Each folder has a specific responsibility, making the project easier to understand.

### Understanding Each Folder

### app/

The main application directory.

### main.py

The entry point of the application where the FastAPI object is created. Example:

```

from fastapi import FastAPI
app = FastAPI()
@app.get("/")
def home():
return {"message": "Welcome to FastAPI"}

```

### routers/

Contains API endpoints. Instead of putting every route inside one file, we divide them into logical groups. Example:

```

users.py
products.py
orders.py

```

Each router handles a specific resource.

### models/

Contains database models. Models define how data is stored inside the database. Example:

```

class User:
id
name
email

```

### schemas/

Contains Pydantic models. Schemas validate incoming requests and outgoing responses. Example:

```

class UserCreate(BaseModel):
name: str
email: str

```

### database/

Responsible for database connections. It usually includes:

- Database engine

- Session creation

- Base model

### services/

Contains business logic. Instead of writing calculations inside API routes, we place them here. Example: Instead of `@app.post("/calculate")` the route simply calls `calculate_total()` This keeps routes clean.

### utils/

Stores helper functions. Examples include:

- Password hashing

- JWT token generation

- Email sending

- File handling

### config.py

Stores application configuration. Instead of hardcoding values, configuration is centralized. Example:

```

DATABASE_URL
SECRET_KEY
DEBUG

```

## Installing Dependencies

### Creating a Virtual Environment

Before starting development, we isolate project dependencies. Windows `python -m venv venv` Activate `venv\\Scripts\\activate` Linux/macOS `source venv/bin/activate`

### Installing FastAPI

`pip install fastapi`

### Installing Uvicorn

Uvicorn is the ASGI server used to run FastAPI. `pip install uvicorn` Run the application

```

uvicorn app.main:app --reload

```

The `--reload` option automatically restarts the server whenever code changes.

### Installing Additional Packages

Many projects also require: `pip install sqlalchemy` Database ORM. `pip install pydantic` Data validation. `pip install python-dotenv` Environment variables. `pip install alembic` Database migrations.

### Managing Requirements

Generate a dependency list.

```

pip freeze > requirements.txt

```

Install dependencies later.

```

pip install -r requirements.txt

```

## Building Application Components

### Creating API Routes

Routes define application endpoints. Example:

```

from fastapi import APIRouter
router = APIRouter()
@router.get("/users")
def get_users():
return ["Ali", "Sara"]

```

Later, include the router. `app.include_router(router)`

### Using Request Validation

Pydantic automatically validates incoming data. Example

```

from pydantic import BaseModel
class Student(BaseModel):
name: str
age: int

```

POST request

```

@app.post("/students")
def create(student: Student):
return student

```

If incorrect data is sent, FastAPI immediately returns a validation error.

### Response Models

We can also control returned data.

```

@app.get("/student", response_model=Student)

```

This improves security by hiding unnecessary information.

### Connecting to a Database

FastAPI commonly uses SQLAlchemy. Typical flow: 1. Connect database 2. Create session 3. Execute query 4. Return results Example workflow

```

Client
↓
API Route
↓
Service
↓
Database
↓
Response

```

Keeping these layers separate improves maintainability.

### Dependency Injection

FastAPI supports dependency injection through `Depends`. Example

```

from fastapi import Depends

```

Benefits include:

- Cleaner code

- Reusable functions

- Better testing

- Reduced duplication

## Running, Testing, and Deploying the Project

### Running the Server

Launch the application.

```

uvicorn app.main:app --reload

```

Server `http://127.0.0.1:8000`

### Automatic API Documentation

One of FastAPI\'s strongest features is automatic documentation. Swagger UI `/docs` ReDoc Developers can test every endpoint directly from the browser without external software.

### Error Handling

Errors should provide meaningful responses. Example:

```

from fastapi import HTTPException
raise HTTPException(
status_code=404,
detail="User not found"
)

```

Clear error messages help both developers and API users quickly identify problems.

### Testing the API

Testing ensures our application behaves correctly. Common testing framework: `pytest` FastAPI provides `TestClient`. Example

```

from fastapi.testclient import TestClient

```

Benefits:

- Detects bugs early

- Improves reliability

- Supports continuous integration

- Simplifies future updates

### Environment Variables

Sensitive information should never be hardcoded. Store values inside: `.env` Example

```

DATABASE_URL=...
SECRET_KEY=...

```

This improves security and allows different configurations for development and production environments.

### Deployment

After development, the project can be deployed to cloud platforms or virtual servers. General deployment process: 1. Complete development. 2. Test all endpoints. 3. Configure environment variables. 4. Install dependencies. 5. Run the application using an ASGI server. 6. Configure a reverse proxy if needed. 7. Monitor logs and performance. Production deployments often use process managers and HTTPS to ensure reliability and security.

## Best Practices for FastAPI Projects

Routes should only receive requests and return responses. Business logic belongs in service functions.

### Use Modular Design

Separate routers, models, schemas, services, and utilities into different files to improve readability and maintainability.

### Validate All Input

Always use Pydantic models instead of accepting raw request data. Validation prevents invalid data from entering the application.

### Write Meaningful Names

Choose descriptive names such as:

- `create_user()`

- `update_product()`

- `delete_order()`

Avoid vague names like:

- `data()`

- `temp()`

- `test()`

### Handle Exceptions Properly

Never expose internal server details to users. Return clear and user-friendly error messages while logging technical details for debugging.

### Document the API

Leverage FastAPI’s automatic documentation and enrich it with endpoint descriptions, request examples, and response models. Well-documented APIs are easier to use and maintain.

### Secure Sensitive Data

Protect secrets such as API keys, database credentials, and authentication tokens by storing them in environment variables instead of source code.

### Conclusion

Building a FastAPI project is much more than creating a few API endpoints—it is about designing a clean, scalable, and maintainable application. By organizing the project into dedicated folders, validating data with Pydantic, separating business logic into services, managing configuration securely, and following best practices, we create applications that are easier to develop, test, and expand. FastAPI’s high performance, automatic documentation, and developer-friendly features make it an excellent choice for modern backend development, whether we are building a small prototype or a large enterprise-level API.');
