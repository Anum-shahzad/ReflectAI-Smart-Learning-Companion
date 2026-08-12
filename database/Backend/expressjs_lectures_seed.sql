-- =============================================
-- ReflectAI — Express.js Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'Express.js' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to Express.js', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to Express.js

As Node.js applications grow larger, building web servers using only the built-in **HTTP module** becomes repetitive and time-consuming. Developers often need features such as routing, middleware, request handling, and response management, which require writing a lot of extra code. To simplify backend development, **Express.js** was created. **Express.js** is a fast, lightweight, and flexible web application framework built on top of Node.js. It provides a simple way to create web servers, APIs, and dynamic web applications with less code and better organization. Think of Node.js as the engine of a car, while Express.js is the complete car. The engine provides power, but the car adds the steering wheel, brakes, and controls that make driving much easier. Similarly, Express.js adds powerful features that simplify Node.js development. Express.js is one of the most popular frameworks for building backend applications and RESTful APIs.

## Why Use Express.js?

### Need for Express.js

Although the Node.js HTTP module is powerful, it requires developers to manually handle routing, request processing, response headers, and many other tasks. Express.js simplifies these operations by providing built-in methods and a clean structure for web development. Some key reasons to use Express.js include:

- Simplifies server creation.

- Makes routing easier.

- Supports middleware.

- Reduces boilerplate code.

- Improves application organization.

Because of these features, Express.js increases developer productivity.

### Features of Express.js

Express.js offers many useful features:

- Fast and lightweight.

- Simple routing system.

- Middleware support.

- Easy request and response handling.

- REST API development.

- Integration with databases.

- Compatible with third-party packages.

These features make Express.js suitable for both small and large applications.

## Creating a Simple Express Application

### Installing Express.js

Install Express using npm: `npm install express` After installation, Express can be imported into the project.

### Creating a Basic Express Server

```

const express = require("express");
const app = express();
app.get("/", (req, res) => {
res.send("Welcome to Express.js!");
});
app.listen(3000, () => {
console.log("Server Running on Port 3000");
});

```

Run the application: `node app.js` Visit: `http://localhost:3000` **Output:** `Welcome to Express.js!` This example creates a simple Express server that responds to requests made to the home page.

## Understanding Express Basics

### Application Object

The `express()` function creates an **application object**, which is used to configure the server, define routes, and handle client requests.

```

const express = require("express");
const app = express();

```

The `app` object is the foundation of every Express application.

### Routes in Express

A **route** defines how the server responds to a specific URL and HTTP method. Example:

```

app.get("/", (req, res) => {
res.send("Home Page");
});
app.get("/about", (req, res) => {
res.send("About Page");
});

```

Here:

- `/` displays the Home Page.

- `/about` displays the About Page.

Routes allow developers to organize application functionality efficiently.

### Request and Response Objects

Every Express route receives two important objects:

- **Request (** `req` **)** – Contains information about the client\'s request.

- **Response (** `res` **)** – Sends data back to the client.

These objects make it easy to process requests and generate responses.

## Best Practices and Applications

### Best Practices

When developing Express.js applications:

- Organize routes into separate files.

- Use meaningful route names.

- Handle errors properly.

- Keep route handlers simple.

- Use middleware for common tasks.

- Structure projects into folders for better maintainability.

Following these practices results in cleaner and more scalable applications.

### Real-World Applications

Express.js is widely used for building:

- REST APIs.

- E-commerce websites.

- Social media applications.

- Authentication systems.

- Content management systems.

- Real-time applications.

- Backend services for mobile and web applications.

Its flexibility makes it one of the most widely used backend frameworks.

### Advantages of Express.js

Using Express.js offers many benefits:

- Reduces development time.

- Simplifies routing.

- Supports middleware.

- Easy integration with databases.

- Lightweight and fast.

- Large community support.

- Ideal for scalable backend development.

These advantages have made Express.js the most popular framework for Node.js.

### Conclusion

**Express.js** is a fast, lightweight, and flexible web framework built on top of Node.js that simplifies backend development. It reduces the complexity of creating web servers by providing features such as routing, middleware, and easy request-response handling. Through the application object, route management, and built-in methods, developers can quickly build web applications and RESTful APIs with clean and organized code. By understanding the basics of Express.js and following best practices, developers can create efficient, scalable, and maintainable backend applications for modern web development.');

-- Lecture 2: Setting Up an Express Server
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Setting Up an Express Server', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Setting Up an Express Server

## Introduction to Setting Up an Express Server

After understanding the basics of Express.js, the next step is learning how to create and configure an **Express Server**. A server acts as a bridge between clients and applications by receiving requests, processing them, and sending appropriate responses. Setting up an Express server involves creating a Node.js project, installing Express.js, importing the framework, creating an application instance, defining routes, and starting the server. Express simplifies the process of building servers by providing a clean structure and powerful tools. Instead of manually handling every HTTP operation, developers can focus on creating application logic. Think of setting up an Express server like preparing a workspace. We first arrange the tools, create the foundation, and then build features on top of it.

## Creating an Express Project

### Initializing a Node.js Project

First, create a new project folder:

```

mkdir express-server
cd express-server

```

Initialize the project using npm: `npm init -y` This creates a `package.json` file that stores project information and dependencies.

### Installing Express.js

Install Express using npm: `npm install express` After installation, Express becomes available inside the project. The `node_modules` folder is created, containing Express and its required dependencies.

## Creating the Express Server

### Importing Express

Create a file named **app.js** and import Express:

```

const express = require("express");

```

This allows the application to use Express features.

### Creating an Express Application

Create an Express application instance:

```

const app = express();

```

The `app` object represents the Express server and provides methods for handling routes, middleware, and server configuration.

### Creating a Basic Route

A route defines how the server responds to client requests.

```

app.get("/", (req, res) => {
res.send("Express Server is Running!");
});

```

In this example:

- `app.get()` handles GET requests.

- `/` represents the home route.

- `res.send()` sends a response to the client.

### Starting the Server

Use the `listen()` method to start the server.

```

app.listen(3000, () => {
console.log("Server running on port 3000");
});

```

The server now listens for requests on port `3000`. Run the server: `node app.js` Open the browser: `http://localhost:3000` Output: `Express Server is Running!`

## Configuring Express Server

### Using Middleware

Middleware functions execute between receiving a request and sending a response. They can modify requests, perform checks, or add additional functionality. Example:

```

app.use(express.json());

```

This middleware allows Express to process JSON data sent by clients. Middleware is commonly used for:

- Authentication.

- Logging.

- Data validation.

- Error handling.

- Request processing.

### Handling Different HTTP Methods

Express supports different HTTP methods:

### GET Request

Used to retrieve data.

```

app.get("/users", (req, res) => {
res.send("Getting Users");
});

```

### POST Request

Used to send new data.

```

app.post("/users", (req, res) => {
res.send("User Created");
});

```

### PUT Request

Used to update existing data.

```

res.send("User Updated");
});

```

### DELETE Request

Used to remove data.

```

app.delete("/users/:id", (req, res) => {
res.send("User Deleted");
});

```

These methods form the foundation of REST API development.

## Best Practices and Server Management

### Best Practices

When setting up an Express server:

- Keep the project structure organized.

- Store configuration values in environment variables.

- Use middleware for reusable functionality.

- Handle errors properly.

- Use meaningful route names.

- Separate routes and business logic as applications grow.

A well-organized server is easier to maintain and expand.

### Using Environment Variables

Instead of writing values like ports directly in code, developers often use environment variables. Example:

```

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
console.log(`Server running on ${PORT}`);
});

```

This makes applications more flexible across different environments.

### Common Server Issues

While setting up Express servers, developers may face problems such as:

- Port already being used.

- Missing dependencies.

- Incorrect routes.

- Server crashes due to errors.

- Invalid request handling.

Proper debugging and error handling help solve these issues quickly.

### Conclusion

Setting up an **Express Server** is an essential step in backend development with Node.js. The process includes creating a Node.js project, installing Express, creating an application instance, defining routes, adding middleware, and starting the server. Express simplifies server development by providing powerful features that reduce complexity and improve code organization. By understanding the basic structure of an Express server and following best practices, developers can build strong foundations for creating REST APIs, web applications, and scalable backend systems.');

-- Lecture 3: Routing in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Routing in Express.js', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Routing in Express.js

## Introduction to Routing

In web development, every application needs a way to decide how to respond when a user visits a specific URL or sends a particular request. This process is called **Routing**. **Routing** defines how an application handles client requests based on the URL path and HTTP method. In Express.js, routing allows developers to create different endpoints that perform specific tasks such as displaying pages, retrieving data, creating users, or updating information. Think of routing like a road map. A city has different roads leading to different destinations. Similarly, an Express application has different routes that direct requests to the correct functionality. Routing is one of the most important concepts in Express.js because it forms the foundation of building web applications and REST APIs.

## Understanding Express Routing

### What is a Route?

A **route** is a combination of:

- An HTTP method.

- A URL path.

- A function that handles the request.

The basic structure of a route is:

```

app.METHOD(PATH, HANDLER);

```

Where:

- `METHOD` represents an HTTP method such as GET or POST.

- `PATH` represents the URL endpoint.

- `HANDLER` is the function executed when the route is accessed.

Example:

```

app.get("/", (req, res) => {
res.send("Home Page");
});

```

When a user visits `/`, Express sends the "Home Page" response.

### HTTP Methods in Routing

Express supports different HTTP methods for different operations.

### GET Route

Used to retrieve data from the server. Example:

```

app.get("/users", (req, res) => {
res.send("List of Users");
});

```

### POST Route

Used to send new data to the server. Example:

```

app.post("/users", (req, res) => {
res.send("User Created");
});

```

### PUT Route

Used to update existing data. Example:

```

app.put("/users/:id", (req, res) => {
res.send("User Updated");
});

```

### DELETE Route

Used to remove data. Example:

```

app.delete("/users/:id", (req, res) => {
res.send("User Deleted");
});

```

These methods allow developers to create complete CRUD operations.

## Route Parameters and Query Parameters

### Route Parameters

Route parameters allow us to capture dynamic values from the URL. Example:

```

app.get("/users/:id", (req, res) => {
res.send(`User ID: ${req.params.id}`);
});

```

URL: `/users/101` Output: `User ID: 101` The `:id` parameter changes depending on the requested URL.

### Query Parameters

Query parameters are additional values sent through the URL after a question mark (`?`). Example:

```

app.get("/search", (req, res) => {
res.send(req.query.name);
});

```

URL: `/search?name=Ali` Output: `Ali` Query parameters are commonly used for:

- Searching data.

- Filtering results.

- Sorting information.

- Pagination.

## Express Router

### What is Express Router?

As applications become larger, placing all routes inside one file becomes difficult to manage. Express provides the **Router** object to organize routes into separate files. The Router helps create modular and maintainable applications.

### Creating a Router

Create a file named **userRoutes.js**:

```

const express = require("express");
const router = express.Router();
router.get("/users", (req, res) => {
res.send("Users Route");
});
module.exports = router;

```

### Using Router in Main File

In `app.js`:

```

const userRoutes = require("./userRoutes");
app.use("/", userRoutes);

```

Now routes are separated and easier to manage.

### Advantages of Express Router

Using routers provides:

- Better project organization.

- Cleaner code structure.

- Easier maintenance.

- Improved scalability.

- Separation of responsibilities.

Large applications commonly use multiple routers for different resources.

## Best Practices and Applications

### Best Practices for Routing

To create effective routes:

- Use clear and meaningful URLs.

- Follow REST API naming conventions.

- Keep route files organized.

- Avoid placing business logic directly inside routes.

- Use middleware for common tasks.

- Handle errors properly.

Good routing makes applications easier to understand and maintain.

### RESTful Routing Example

A common REST API structure: Method Route Purpose GET `/users` Get all users GET `/users/:id` Get single user POST `/users` Create user PUT `/users/:id` Update user DELETE `/users/:id` Delete user This structure provides a predictable way to design APIs.

### Real-World Applications

Routing is used in almost every Express.js application:

- User authentication systems.

- E-commerce websites.

- Social media platforms.

- Blogging applications.

- Mobile application backends.

- REST APIs.

Every feature in a web application usually has one or more routes responsible for handling requests.

### Conclusion

**Routing** is a fundamental concept in Express.js that controls how applications respond to client requests. By connecting HTTP methods with URL paths and handler functions, developers can create organized and efficient web applications. Express provides powerful routing features, including route parameters, query parameters, and the Router system for managing large projects. Understanding routing allows developers to build structured REST APIs and scalable backend systems where every request reaches the correct destination efficiently.');

-- Lecture 4: Request & Response Handling in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Request & Response Handling in Express.js', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Request & Response Handling in Express.js

## Introduction to Request & Response Handling

Every web application works through communication between a **client** and a **server**. When a user opens a website, submits a form, or requests data from an API, the client sends a request to the server. The server processes that request and sends back a response. In Express.js, this communication is managed using two important objects:

- **Request Object (** `req` **)**

- **Response Object (** `res` **)**

The request object contains information sent by the client, while the response object is used by the server to send data back. Think of it like a conversation between two people. One person asks a question, and the other person provides an answer. The request is the question, and the response is the answer. Understanding request and response handling is essential because it allows developers to build interactive web applications and REST APIs.

## Understanding the Request Object (req)

### What is the Request Object?

The **request object (** `req` **)** contains all information about the incoming client request. Express automatically provides this object whenever a route is executed. Example:

```

app.get("/", (req, res) => {
console.log(req);
res.send("Request Received");
});

```

The request object provides details such as:

- URL information.

- HTTP method.

- Request parameters.

- Query data.

- Headers.

- Body data.

### Accessing HTTP Method

The `req.method` property tells us which HTTP method the client used. Example:

```

app.get("/", (req, res) => {
console.log(req.method);
res.send("Method Checked");
});

```

Output: `GET` Common HTTP methods include:

- GET

- POST

- PUT

- DELETE

### Accessing URL Information

The `req.url` property provides the requested URL. Example:

```

app.get("/about", (req, res) => {
console.log(req.url);
res.send("About Page");
});

```

Output: `/about`

## Handling Request Data

### Route Parameters

Route parameters allow us to receive dynamic values from the URL. Example:

```

app.get("/users/:id", (req, res) => {
const userId = req.params.id;
res.send(`User ID: ${userId}`);
});

```

URL: `/users/10` Output: `User ID: 10` Route parameters are commonly used when accessing specific resources.

### Query Parameters

Query parameters are values sent through the URL using `?`. Example:

```

app.get("/search", (req, res) => {
const keyword = req.query.name;
res.send(`Searching for ${keyword}`);
});

```

URL: `/search?name=Ali` Output: `Searching for Ali` Query parameters are useful for searching, filtering, and sorting data.

### Request Body

The request body contains data sent by the client, usually in POST or PUT requests. First, enable JSON parsing:

```

app.use(express.json());

```

Example:

```

app.post("/users", (req, res) => {
console.log(req.body);
res.send("User Data Received");
});

```

The request body is commonly used when submitting forms or sending API data.

## Understanding the Response Object (res)

### What is the Response Object?

The **response object (** `res` **)** allows the server to send data back to the client. Express provides many methods for creating responses.

### Sending Text Response

The `res.send()` method sends data to the client. Example:

```

app.get("/", (req, res) => {
res.send("Hello from Express");
});

```

The client receives the provided message.

### Sending JSON Response

The `res.json()` method sends JSON data. Example:

```

app.get("/user", (req, res) => {
res.json({
name: "Ali",
age: 20
});
});

```

Output:

```

{
"name": "Ali",
"age": 20
}

```

JSON responses are commonly used in REST APIs.

### Sending Status Codes

HTTP status codes describe the result of a request. Example:

```

res.status(200).send("Request Successful");
});

```

Common status codes:

- **200** – Success.

- **201** – Resource Created.

- **400** – Bad Request.

- **401** – Unauthorized.

- **404** – Not Found.

- **500** – Server Error.

### Redirecting Requests

The `res.redirect()` method sends users to another URL. Example:

```

app.get("/old-page", (req, res) => {
res.redirect("/new-page");
});

```

Redirects are useful when URLs change or users need to be moved to another page.

## Best Practices and Applications

### Best Practices

When handling requests and responses:

- Always validate incoming data.

- Send proper HTTP status codes.

- Return meaningful error messages.

- Avoid sending unnecessary data.

- Use JSON format for APIs.

- Keep response structures consistent.

These practices make applications easier to use and maintain.

### Request & Response Handling in REST APIs

Request and response handling is the foundation of REST API development. Example API flow:

```

Client
|
| POST /users
|
↓
Express Server
|
| Process Data
|
↓
Response
{
"message": "User Created"
}

```

The client sends information, the server processes it, and a structured response is returned.

### Real-World Applications

Request and response handling is used in:

- Login systems.

- User registration.

- Online shopping platforms.

- Payment systems.

- Social media applications.

- Mobile application backends.

- Data management systems.

Every modern web application depends on effective request and response communication.

### Conclusion

**Request and Response Handling** is a fundamental concept in Express.js that controls how servers communicate with clients. The request object allows developers to access information sent by users, including parameters, queries, headers, and body data. The response object provides methods for sending messages, JSON data, status codes, and redirects back to clients. By understanding how to properly handle requests and responses, developers can build efficient web applications and REST APIs that communicate smoothly, securely, and reliably.');

-- Lecture 5: Middleware in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Middleware in Express.js', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Middleware in Express.js

## Introduction to Middleware

When building web applications, every request sent by a client usually needs to pass through several steps before receiving a response. For example, an application may need to check authentication, validate data, record request details, or handle errors before completing the request. In Express.js, these intermediate functions are called **Middleware**. **Middleware** is a function that runs between the client request and the final server response. It has access to the request object (`req`), response object (`res`), and a special function called `next()` that passes control to the next middleware function. Think of middleware like a security checkpoint at an airport. Before passengers reach their gate, they pass through different checkpoints for verification and safety checks. Similarly, requests pass through middleware before reaching the final route handler. Middleware is one of the most powerful features of Express.js because it allows developers to add reusable functionality without repeating code.

## Understanding Middleware in Express.js

### What is Middleware?

A middleware function follows this structure:

```

function middleware(req, res, next) {
// Perform an operation
next();
}

```

Where:

- `req` represents the incoming request.

- `res` represents the response sent back to the client.

- `next()` moves execution to the next middleware or route handler.

If `next()` is not called, the request will stop and the client may keep waiting for a response.

### How Middleware Works

The flow of an Express request is:

```

Client Request
|
↓
Middleware 1
|
↓
Middleware 2
|
↓
Route Handler
|
↓
Response

```

Each middleware can:

- Execute code.

- Modify the request or response.

- End the request.

- Pass control to the next function.

This structure makes applications more organized and flexible.

## Types of Middleware

### 1. Application-Level Middleware

Application-level middleware is attached directly to the Express application using `app.use()` or HTTP method functions. Example:

```

const express = require("express");
const app = express();
app.use((req, res, next) => {
console.log("Request Received");
next();
});
app.get("/", (req, res) => {
res.send("Home Page");
});

```

This middleware runs for every request received by the application.

### 2. Router-Level Middleware

Router-level middleware works with Express routers instead of the main application. Example:

```

const router = express.Router();
router.use((req, res, next) => {
console.log("Router Middleware");
next();
});

```

It is useful for applying middleware to specific groups of routes.

### 3. Built-in Middleware

Express provides some built-in middleware functions. Example:

```

app.use(express.json());

```

This middleware allows Express to read JSON data sent in requests. Common built-in middleware:

- `express.json()` – Handles JSON data.

- `express.urlencoded()` – Handles form data.

- `express.static()` – Serves static files.

### 4. Third-Party Middleware

Developers can install middleware created by other developers through npm. Example: Installing logging middleware: `npm install morgan` Using it:

```

const morgan = require("morgan");
app.use(morgan("dev"));

```

Third-party middleware extends Express functionality.

### 5. Error-Handling Middleware

Error-handling middleware manages errors that occur during request processing. Example:

```

app.use((err, req, res, next) => {
res.status(500).send("Something went wrong");
});

```

It ensures errors are handled properly instead of crashing the application.

## Creating Custom Middleware

### Example of Custom Middleware

Developers can create their own middleware functions for specific tasks. Example:

```

function logger(req, res, next) {
console.log(`${req.method} ${req.url}`);
next();
}
app.use(logger);

```

When a request arrives, this middleware displays the HTTP method and URL.

### Authentication Middleware Example

Middleware is commonly used for checking user authentication. Example:

```

function checkAuth(req, res, next) {
const loggedIn = true;
if (loggedIn) {
next();
} else {
res.send("Access Denied");
}
}

```

Only authenticated users can continue to the requested route.

### Common Uses of Middleware

Middleware is used for:

- Authentication and authorization.

- Logging requests.

- Validating user input.

- Handling errors.

- Processing JSON data.

- Managing sessions.

- Adding security features.

Almost every professional Express.js application uses middleware.

## Best Practices and Benefits

### Best Practices

When working with middleware:

- Keep middleware functions small and focused.

- Call `next()` when moving to the next step.

- Handle errors properly.

- Place middleware in the correct order.

- Avoid unnecessary middleware that slows requests.

- Organize reusable middleware separately.

The order of middleware matters because Express executes middleware functions from top to bottom.

### Advantages of Middleware

Middleware provides many benefits:

- Reduces code duplication.

- Improves application organization.

- Makes features reusable.

- Simplifies request processing.

- Enhances security.

- Makes applications easier to maintain.

By separating common tasks into middleware, developers can create cleaner and more scalable applications.

### Middleware Execution Order

Example:

```

app.use(firstMiddleware);
app.use(secondMiddleware);
app.get("/", routeHandler);

```

Execution order:

```

firstMiddleware
↓
secondMiddleware
↓
routeHandler

```

Understanding execution order is important because incorrect ordering can cause unexpected behavior.

### Conclusion

**Middleware** is a core concept in Express.js that allows developers to execute functions between receiving a request and sending a response. It provides a powerful way to handle common tasks such as authentication, logging, validation, and error handling without repeating code. Express supports different types of middleware, including application-level, router-level, built-in, third-party, and error-handling middleware. By understanding how middleware works and following best practices, developers can build cleaner, more secure, and scalable backend applications with Express.js.');

-- Lecture 6: Serving Static Files in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Serving Static Files in Express.js', 6, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Serving Static Files in Express.js

## Introduction to Serving Static Files in Express.js

When we build a web application, not everything is generated dynamically. Many resources such as HTML pages, CSS files, JavaScript files, images, fonts, videos, and PDFs remain the same unless we manually change them. These resources are called **static files** because they are delivered to users exactly as they are stored on the server. Express.js provides a simple and efficient way to serve these files using its built-in middleware. Instead of writing separate routes for every image or CSS file, Express automatically delivers them whenever the browser requests them. This saves time, reduces code complexity, and improves application performance. Think of static files as books placed on a library shelf. Whenever someone asks for a particular book, the librarian simply hands it over without rewriting it. Express works in a similar way by locating the requested file and sending it directly to the client\'s browser.

## What Are Static Files?

Static files are files whose content does not change before being sent to the client. Unlike dynamic content, which is generated by server-side code, static files remain unchanged.

### Common Types of Static Files

- HTML documents

- CSS stylesheets

- JavaScript files

- Images (PNG, JPG, SVG, GIF)

- Audio files

- Video files

- Fonts

- PDF documents

### Example Folder Structure

```

project/
│
├── public/
│ ├── css/
│ │ └── style.css
│ ├── js/
│ │ └── app.js
│ ├── images/
│ │ └── logo.png
│ └── index.html
│
├── app.js
└── package.json

```

Here, the **public** folder stores all static resources.

## Using express.static() Middleware

Express provides a built-in middleware called **express.static()** for serving static files.

### Basic Syntax

```

const express = require("express");
const app = express();
app.use(express.static("public"));
app.listen(3000);

```

This single line tells Express: "Whenever someone requests a file, first look inside the **public** folder." For example: Requested URL File Served

```

/index.html public/index.html
/css/style.css public/css/style.css
public/images/logo.pn
/images/logo.png
g

```

No route definitions are required.

### How express.static() Works

When the browser sends a request, Express checks the specified directory. If the requested file exists:

- Express sends it immediately.

- No additional code runs.

If the file doesn\'t exist:

- Express moves to the next middleware or route.

- If no matching route is found, a **404 Not Found** error is returned.

This process is fast because Express is optimized for serving static resources efficiently.

### Example

```

const express = require("express");
const app = express();
app.use(express.static("public"));
app.get("/", (req, res) => {
res.send("Welcome to Express");
});
app.listen(3000);

```

If the browser requests:

```

http://localhost:3000/images/logo.png

```

Express automatically sends:

```

public/images/logo.png

```

## Using Virtual Paths

Sometimes we don\'t want users to know the actual folder name. Suppose our folder is: `assets/` Instead of accessing: `/logo.png` We may want: `/static/logo.png` We can create a virtual path.

### Example

```

const express = require("express");
const app = express();
app.use("/static", express.static("assets"));

```

Now: `assets/logo.png` becomes accessible as

```

http://localhost:3000/static/logo.png

```

The user never sees the real folder name. This technique improves organization and allows us to change folder names later without affecting URLs.

### Serving Multiple Static Directories

Large applications often organize files into different folders. Example:

```

app.use(express.static("public"));
app.use(express.static("uploads"));
app.use(express.static("documents"));

```

Now Express searches folders in order: 1. public 2. uploads 3. documents If a requested file is found in the first folder, Express serves it immediately.

### Using Absolute Paths

Using relative paths may cause issues if the application starts from another directory. Instead, Node.js recommends using **path.join()**.

```

const express = require("express");
const path = require("path");
const app = express();
app.use(express.static(path.join(__dirname, "public")));

```

**Why use** `path.join()` **?**

- Platform independent

- Works on Windows, Linux, and macOS

- Avoids path-related errors

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Keep Static Files in One Folder

A dedicated folder such as **public** makes project management easier. Example:

```

public/
css/
js/
images/
fonts/

```

### 2. Use Meaningful Folder Names

Instead of: `folder1/` Use:

```

images/
css/
videos/

```

This improves readability.

### 3. Minify CSS and JavaScript

Compressed files load faster. Example: Instead of: `style.css` Use: `style.min.css` This improves website performance.

### 4. Optimize Images

Large images slow down websites. Use:

- JPEG for photographs

- PNG for transparency

- SVG for icons

- WebP for modern browsers

### 5. Store Sensitive Files Outside Public Folder

Never place:

- Password files

- Database backups

- Configuration files

- Environment files (.env)

inside the public directory. Anything inside the static folder can potentially be accessed by users if they know the file path.

### Advantages of Serving Static Files

### Simple Setup

Only one middleware is needed.

```

app.use(express.static("public"));

```

### Improved Performance

Static files are delivered directly without executing additional server logic.

### Cleaner Code

No need to create routes like:

```

app.get("/logo", ...);

```

for every image.

### Easy Maintenance

All website resources remain organized in one place.

### Browser Caching

Browsers can cache static resources. Benefits include:

- Faster page loading

- Reduced server requests

- Better user experience

### Common Mistakes

### 1. Forgetting Middleware

Without:

```

app.use(express.static("public"));

```

CSS and images won\'t load.

### 2. Incorrect Folder Name

If your folder is named: `Public` but you write:

```

express.static("public")

```

Express won\'t find the files because many operating systems are case-sensitive.

### 3. Wrong File Path

Example: `<img src="/images/logo.png">` If the image is actually located inside:

```

public/img/logo.png

```

the browser will display a broken image.

### 4. Using Relative Paths Incorrectly

Prefer:

```

path.join(__dirname, "public")

```

instead of:

```

express.static("public")

```

for better portability.

### 5. Exposing Private Files

Never place confidential information inside the public directory. Bad example:

```

public/
passwords.txt

```

Anyone could potentially access:

### Conclusion

Serving static files is one of the most essential features of Express.js because every modern web application depends on resources like HTML, CSS, JavaScript, images, and fonts. By using the `express.static()` middleware, we can serve these files efficiently with minimal code while keeping our applications clean, organized, and easy to maintain. Features such as virtual paths, multiple static directories, and absolute paths provide additional flexibility for larger projects. By following best practices—such as organizing files in a dedicated **public** folder, optimizing assets, using `path.join()`, and keeping sensitive files outside the public directory—we can build secure, high-performing, and scalable Express.js applications.');

-- Lecture 7: Working with Forms & JSON in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Working with Forms & JSON in Express.js', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Working with Forms & JSON in Express.js

## Introduction to Working with Forms & JSON

Web applications constantly exchange data between users and servers. Whenever a user logs in, registers, submits feedback, or updates a profile, data is sent to the server. In Express.js, this data commonly comes in two formats: **form data** and **JSON (JavaScript Object Notation)**. Forms are mainly used in traditional websites where users fill out input fields and click a submit button. JSON, on the other hand, is widely used in modern web applications, mobile apps, and APIs because it is lightweight, easy to read, and simple to process. Express.js provides built-in middleware to handle both types of incoming data efficiently. Without this middleware, the server cannot understand the data sent by the client.

## Working with HTML Forms

An HTML form allows users to enter information and send it to the server.

### Basic HTML Form

```

<!DOCTYPE html>
<html>
<head>
<title>Student Form</title>
</head>
<body>
<form action="/submit" method="POST">
<label>Name:</label>
<input type="text" name="name">
<label>Age:</label>
<input type="number" name="age">
<button type="submit">Submit</button>
</form>
</body>
</html>

```

### Explanation

- `action="/submit"` specifies where the data will be sent.

- `method="POST"` sends data securely in the request body.

- `name` attributes become property names in the submitted data.

- The **Submit** button sends the form to the server.

### Handling Form Data in Express

Express uses the **express.urlencoded()** middleware to read form data.

```

const express = require("express");
const app = express();
app.use(express.urlencoded({ extended: true }));
app.post("/submit", (req, res) => {
console.log(req.body);
res.send("Form Submitted Successfully");
});
app.listen(3000);

```

### Output

If the user enters:

- Name: Ali

- Age: 20

Then: `req.body` contains:

```

{
name: "Ali",
age: "20"
}

```

Notice that form values are received as **strings**.

### What is express.urlencoded()?

`express.urlencoded()` is built-in middleware that converts URL-encoded form data into a JavaScript object.

```

app.use(express.urlencoded({ extended: true }));

```

### extended: true

- Supports nested objects.

- Recommended for most applications.

### extended: false

- Supports only simple key-value pairs.

## Working with JSON Data

### What is JSON?

JSON (JavaScript Object Notation) is a lightweight format used for exchanging data between applications. Example:

```

{
"name": "Ali",
"age": 20,
"city": "Lahore"
}

```

JSON is commonly used in:

- REST APIs

- Mobile applications

- React applications

- Vue applications

- Angular applications

### Receiving JSON in Express

To receive JSON data, Express uses **express.json()** middleware.

```

const express = require("express");
const app = express();
app.use(express.json());
app.post("/student", (req, res) => {
console.log(req.body);
res.send("JSON Received");
});
app.listen(3000);

```

### JSON Request Example

Client sends:

```

{
"name": "Sara",
"age": 22,
"department": "Computer Science"
}

```

Server receives:

```

{
name: \'Sara\',
age: 22,
department: \'Computer Science\'
}

```

The data becomes a JavaScript object stored in: `req.body`

### Sending JSON Response

Express can also send JSON back to the client.

```

app.get("/student", (req, res) => {
res.json({
name: "Ali",
age: 20,
course: "Web Development"
});
});

```

### Response

```

{
"name": "Ali",
"age": 20,
"course": "Web Development"
}

```

`res.json()` automatically converts the JavaScript object into JSON format.

## Forms vs JSON

Although both are used to send data, they are designed for different purposes. Feature HTML Forms JSON Data Format URL-Encoded JSON Object Middleware `express.urlencoded() express.json()` Mostly Used In Traditional Websites APIs & Modern Apps Sent Through HTML Form JavaScript/API Requests Stored In `req.body req.body`

### Using Both Together

Many applications support both forms and JSON.

```

const express = require("express");
const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.listen(3000);

```

Now the application can process both HTML form submissions and JSON requests.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Always Use Middleware

```

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

```

Without these, `req.body` will be `undefined`.

### 2. Validate User Input

Always check user input before using it.

```

if (!req.body.name) {
return res.send("Name is required");
}

```

### 3. Use POST for Sensitive Data

Sensitive information like passwords should be sent using the **POST** method because the data is placed in the request body rather than the URL.

### 4. Return Meaningful Responses

Instead of sending plain text:

```

res.send("Success");

```

Return descriptive JSON:

```

res.json({
success: true,
message: "Student Added Successfully"
});

```

### 5. Keep JSON Well Structured

Example:

```

{
"student": {
"name": "Ali",
"age": 20
}
}

```

Structured JSON is easier to read and maintain.

### Advantages

- Easy handling of user input.

- Built-in Express middleware simplifies development.

- JSON is lightweight and fast.

- Works seamlessly with REST APIs.

- Supports communication between frontend and backend.

- `req.body` provides easy access to submitted data.

### Common Mistakes

### 1. Forgetting express.json()

```

app.post("/user", (req, res) => {
console.log(req.body);
});

```

Without:

```

app.use(express.json());

```

`req.body` will be `undefined` for JSON requests.

### 2. Forgetting express.urlencoded()

HTML form data will not be parsed without:

```

app.use(express.urlencoded({ extended: true }));

```

### 3. Using GET Instead of POST

Avoid sending sensitive information like passwords using the **GET** method because the data appears in the URL.

### 4. Not Setting the Correct Content-Type

When sending JSON, the client should use:

```

Content-Type: application/json

```

Otherwise, Express may not parse the data correctly.

### 5. Assuming All Values Have Correct Data Types

Form data is usually received as strings. Example:

```

{
age: "20"
}

```

If a number is required, convert it:

```

const age = Number(req.body.age);

```

### Conclusion

Working with **Forms and JSON** is a fundamental skill in Express.js development. HTML forms are ideal for traditional web applications, while JSON is the preferred format for APIs and modern frontend frameworks. Express simplifies data handling through the built-in `express.urlencoded()` and `express.json()` middleware, making submitted data easily accessible via `req.body`. By validating user input, using the correct middleware, choosing appropriate HTTP methods, and following best practices, we can create secure, efficient, and scalable Express.js applications that communicate effectively with users and other systems.');

-- Lecture 8: RESTful API Design in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'RESTful API Design in Express.js', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# RESTful API Design in Express.js

## Introduction to RESTful API Design in Express.js

In modern web development, applications need a reliable way to communicate with one another. A website may request user information from a server, a mobile app may upload data to a database, or an online store may process customer orders. This communication is commonly handled through **RESTful APIs**. Express.js, a lightweight and powerful Node.js framework, makes it easy to build these APIs using simple routing and middleware. A **RESTful API (Representational State Transfer Application Programming Interface)** is an API that follows REST principles. It uses standard HTTP methods such as **GET**, **POST**, **PUT**, and **DELETE** to perform operations on resources. Rather than creating separate URLs for every action, REST organizes endpoints around resources, making APIs easy to understand, maintain, and scale. Imagine a library. Books are the resources, while the librarian performs actions such as finding, adding, updating, or removing books. In the same way, Express.js uses HTTP methods to interact with resources like users, products, students, or orders.

## Understanding RESTful APIs and Resources

### What is a RESTful API?

A RESTful API is a web service that allows applications to exchange data over HTTP while following REST architectural principles. Its main characteristics include:

- Client-server architecture

- Stateless communication

- Resource-based URLs

- Standard HTTP methods

- JSON data exchange

- Scalability

Because REST is stateless, every request contains all the information needed for the server to process it.

### What is a Resource?

A **resource** is any object or data managed by the application. Examples include:

- Students

- Users

- Products

- Books

- Employees

- Orders

Each resource is identified by a unique URL.

### Example Resource URLs

```

/students
/users
/products
/books

```

To access a specific resource: `/students/5` Here, **5** is the unique ID of the student.

### REST Principles

A good RESTful API should:

- Use meaningful resource names.

- Use HTTP methods correctly.

- Return JSON responses.

- Be stateless.

- Use proper HTTP status codes.

## Creating RESTful APIs in Express.js

### Setting Up Express

First, create a basic Express application.

```

const express = require("express");
const app = express();
app.use(express.json());
app.listen(3000, () => {
console.log("Server Running");
});

```

The `express.json()` middleware allows Express to receive JSON data from clients.

### Creating a GET Route

The **GET** method retrieves data.

```

app.get("/students", (req, res) => {
const students = [
{ id: 1, name: "Ali" },
{ id: 2, name: "Sara" }
];
res.json(students);
});

```

### Request

`GET /students`

### Response

```

[
{
"id": 1,
"name": "Ali"
},
{
"id": 2,
"name": "Sara"
}
]

```

### Creating a POST Route

The **POST** method creates a new resource.

```

app.post("/students", (req, res) => {
const student = req.body;
res.status(201).json(student);
});

```

### Request

```

POST /students
{
"name": "Ahmed",
"age": 21
}

```

### Creating a PUT Route

The **PUT** method updates an existing resource.

```

app.put("/students/:id", (req, res) => {
const id = req.params.id;
const updatedStudent = req.body;
res.json({
id,
...updatedStudent
});
});

```

### Request

`PUT /students/1`

### Creating a DELETE Route

The **DELETE** method removes a resource.

```

app.delete("/students/:id", (req, res) => {
const id = req.params.id;
res.json({
message: `Student ${id} deleted successfully`
});
});

```

### Request

`DELETE /students/1`

### Using Route Parameters

Route parameters help identify specific resources.

```

app.get("/students/:id", (req, res) => {
const id = req.params.id;
res.send(`Student ID: ${id}`);
});

```

If the client requests: The response will be: `Student ID: 10`

## HTTP Methods and Status Codes

### Common HTTP Methods

Method Purpose Example Endpoint GET Retrieve data `/students` POST Create new data `/students` PUT Update existing data `/students/:id` DELETE Delete data `/students/:id`

### Common HTTP Status Codes

Status Code Meaning 200 OK 201 Created 400 Bad Request 401 Unauthorized 403 Forbidden 404 Not Found 500 Internal Server Error

### Example

```

res.status(201).json({
message: "Student Created Successfully"
});

```

### Sending JSON Responses

Express provides the `res.json()` method to send JSON data.

```

res.json({
id: 1,
name: "Ali",
department: "Computer Science"
});

```

The client receives:

```

{
"id": 1,
"name": "Ali",
"department": "Computer Science"
}

```

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Use Resource-Based URLs

Correct:

```

/students
/products
/users

```

Incorrect:

```

/getStudents
/createStudent
/deleteStudent

```

URLs should represent resources, while HTTP methods define the action.

### 2. Use Proper HTTP Methods

Examples:

```

GET /students
POST /students
PUT /students/5
DELETE /students/5

```

Avoid using **GET** to delete or update data.

### 3. Validate Incoming Data

Always verify user input before processing.

```

if (!req.body.name) {
return res.status(400).json({
message: "Student name is required"
});
}

```

### 4. Return Meaningful JSON Responses

Instead of:

```

res.send("Done");

```

Use:

```

res.json({
success: true,
message: "Operation Completed"
});

```

This makes responses easier for clients to understand.

### 5. Handle Errors Properly

Example:

```

res.status(404).json({
message: "Student Not Found"
});

```

Clear error messages improve debugging and user experience.

### Advantages of RESTful APIs in Express.js

- Easy to build with minimal code.

- Uses standard HTTP methods.

- Supports communication between web, mobile, and desktop applications.

- JSON format is lightweight and easy to parse.

- Scalable for large applications.

- Easy to maintain and extend.

- Well-supported by frontend frameworks such as React, Angular, and Vue.

### Common Mistakes

**1. Forgetting** `express.json()` Without:

```

app.use(express.json());

```

JSON request bodies cannot be read, and `req.body` will be `undefined`.

### 2. Using Incorrect Status Codes

Returning `200 OK` for every response is poor practice. Use status codes such as **201**, **400**, or **404** when appropriate.

### 3. Ignoring Route Parameters

Incorrect: `app.get("/students", ...)` Correct:

```

app.get("/students/:id", ...)

```

This allows access to individual resources.

### 4. Using Verbs in URLs

Incorrect:

```

/deleteStudent
/updateStudent

```

Correct:

```

/students
/students/1

```

### 5. Not Validating User Input

Accepting invalid or empty data can cause application errors and security issues. Always validate input before storing or processing it.

### Conclusion

RESTful API Design in Express.js provides a structured and efficient way to build web services using standard HTTP methods and resource-based URLs. By combining Express routing with middleware like `express.json()`, developers can easily create APIs that perform CRUD (Create, Read, Update, Delete) operations. Following REST principles—such as using meaningful endpoints, returning JSON responses, applying correct HTTP status codes, validating input, and handling errors properly—results in APIs that are secure, scalable, easy to maintain, and capable of supporting modern web and mobile applications.');

-- Lecture 9: Connecting to a Database in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Connecting to a Database in Express.js', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Connecting to a Database in Express.js

## Introduction to Connecting to a Database in Express.js

A web application becomes truly useful when it can store and retrieve data permanently. Without a database, information entered by users— such as registration details, login credentials, products, or orders—would disappear every time the server restarts. To solve this problem, Express.js applications connect to a **database**, which acts as a permanent storage system for application data. Express.js itself does not include a database. Instead, it works with database management systems such as **MongoDB**, **MySQL**, **PostgreSQL**, and **SQLite** through external libraries. Once connected, the application can perform operations like creating, reading, updating, and deleting data (CRUD). Think of a database as a digital filing cabinet. Just as documents are organized into folders for easy retrieval, a database stores and organizes information so it can be accessed quickly whenever needed.

## Understanding Databases

### What is a Database?

A **database** is an organized collection of data that allows information to be stored, retrieved, updated, and deleted efficiently. Examples of data stored in databases include:

- User accounts

- Student records

- Product information

- Customer orders

- Employee details

- Blog posts

### Types of Databases

### 1. Relational Databases (SQL)

Relational databases store data in tables consisting of rows and columns. Examples:

- MySQL

- PostgreSQL

- SQLite

- Microsoft SQL Server

Example table: ID Name Age 1 Ali 20 2 Sara 22

### 2. Non-Relational Databases (NoSQL)

NoSQL databases store data in flexible formats such as JSON-like documents. Example:

```

{
"_id": "101",
"name": "Ali",
"age": 20
}

```

Examples:

- MongoDB

- Firebase Firestore

- CouchDB

### Why Connect a Database to Express.js?

Connecting a database allows us to:

- Store user information permanently.

- Retrieve saved records.

- Update existing data.

- Delete unwanted records.

- Build dynamic web applications.

## Connecting Express.js to MongoDB

MongoDB is one of the most popular NoSQL databases used with Express.js.

### Installing Required Packages

First, install Express and Mongoose. `npm install express mongoose` Here:

- **Express** creates the web server.

- **Mongoose** connects Express.js to MongoDB and simplifies database operations.

### Basic Database Connection

```

const express = require("express");
const mongoose = require("mongoose");
const app = express();
mongoose.connect("mongodb://127.0.0.1:27017/studentDB")
.then(() => {
console.log("Database Connected");
})
.catch((err) => {
console.log(err);
});
app.listen(3000, () => {
console.log("Server Running");
});

```

### Explanation

- `mongoose.connect()` establishes the database connection.

- `"studentDB"` is the database name.

- `.then()` runs after a successful connection.

- `.catch()` handles connection errors.

### Creating a Schema

A **schema** defines the structure of documents stored in MongoDB.

```

const mongoose = require("mongoose");
const studentSchema = new mongoose.Schema({
name: String,
age: Number,
department: String
});

```

The schema specifies that every student document contains:

- Name

- Age

- Department

### Creating a Model

A model is created from the schema and is used to interact with the database.

```

const Student = mongoose.model("Student", studentSchema);

```

The `Student` model represents the **students** collection in MongoDB.

## Performing CRUD Operations

CRUD stands for **Create, Read, Update, and Delete**, the four basic database operations.

### Create (Insert Data)

```

app.post("/students", async (req, res) => {
const student = new Student({
name: "Ali",
age: 20,
department: "Computer Science"
});
await student.save();
res.send("Student Saved");
});

```

This creates and stores a new student record in the database.

### Read (Retrieve Data)

```

app.get("/students", async (req, res) => {
const students = await Student.find();
res.json(students);
});

```

This retrieves all student records from the database.

### Update Data

```

app.put("/students/:id", async (req, res) => {
await Student.findByIdAndUpdate(
req.params.id,
{
name: "Ahmed"
}
);
res.send("Student Updated");
});

```

This updates the student\'s name.

### Delete Data

```

app.delete("/students/:id", async (req, res) => {
await Student.findByIdAndDelete(req.params.id);
res.send("Student Deleted");
});

```

This removes the selected student from the database.

### Common Mongoose Methods

Method Purpose `save()` Insert a document `find()` Retrieve all documents `findById()` Retrieve one document Retrieve a matching `findOne()` document `findByIdAndUpdate()` Update a document `findByIdAndDelete()` Delete a document

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Store Connection String Securely

Instead of writing the database URL directly in your code, store it in an environment variable (such as a `.env` file). This improves security and makes configuration easier.

### 2. Handle Connection Errors

Always catch database connection errors.

```

mongoose.connect(DB_URL)
.then(() => console.log("Connected"))
.catch(err => console.log(err));

```

This prevents the application from crashing unexpectedly.

### 3. Validate Data

Use schema validation to ensure correct data is stored.

```

const studentSchema = new mongoose.Schema({
name: {
type: String,
required: true
},
age: Number
});

```

Validation helps maintain data quality.

### 4. Use Async/Await

Database operations are asynchronous.

```

const students = await Student.find();

```

Using `async` and `await` makes code easier to read and maintain.

### 5. Organize Database Files

Separate database-related code into dedicated folders. Example:

```

project/
├── models/
│ └── Student.js
├── routes/
│ └── studentRoutes.js
├── app.js

```

This keeps large projects organized.

### Advantages of Connecting a Database

- Stores data permanently.

- Supports CRUD operations.

- Makes applications dynamic.

- Easily manages large amounts of data.

- Allows multiple users to access the same information.

- Works efficiently with Express.js and APIs.

### Common Mistakes

### 1. Forgetting to Connect the Database

If `mongoose.connect()` is not called, database operations will fail because Express has no connection to the database.

### 2. Ignoring Connection Errors

Failing to handle errors can cause unexpected crashes and make debugging difficult. **3. Forgetting** `await` Incorrect:

```

const students = Student.find();

```

Correct:

```

const students = await Student.find();

```

Without `await`, the query may not finish before the response is sent.

### 4. Not Validating Input

Saving incomplete or invalid data can lead to inconsistent database records. Always validate user input before storing it.

### 5. Hardcoding Sensitive Information

Avoid writing usernames, passwords, or database connection strings directly in source code. Store them securely using environment variables.

### Conclusion

Connecting a database to Express.js is an essential step in developing dynamic web applications. Databases allow information to be stored permanently and accessed whenever needed. Express.js works seamlessly with databases like MongoDB through libraries such as Mongoose, making it easy to define schemas, create models, and perform CRUD operations. By following best practices—such as validating data, handling connection errors, using asynchronous operations, organizing project files, and protecting sensitive configuration data—we can build secure, scalable, and efficient Express.js applications that manage data reliably.');

-- Lecture 10: Validation & Error Handling in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Validation & Error Handling in Express.js', 10, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Validation & Error Handling in Express.js

## Introduction to Validation & Error Handling

Every web application receives data from users. This data may come from registration forms, login pages, APIs, or mobile applications. However, users can accidentally—or intentionally—submit invalid, incomplete, or incorrect information. If this data is not checked properly, it can cause application crashes, incorrect database records, or even security vulnerabilities. To prevent these problems, Express.js applications use **Validation** and **Error Handling**. **Validation** ensures that incoming data meets specific rules before it is processed, while **Error Handling** ensures that when something goes wrong, the application responds gracefully instead of crashing. Think of validation as a security guard checking whether visitors have valid ID cards before entering a building. Error handling is like customer support that politely explains what went wrong and how to fix it instead of simply shutting the door.

## Understanding Validation

### What is Validation?

**Validation** is the process of checking whether user input meets the required rules before processing or storing it. Validation helps ensure that data is:

- Complete

- Correct

- Secure

- Properly formatted

### Why is Validation Important?

Validation helps to:

- Prevent invalid data from entering the database.

- Improve application security.

- Reduce application errors.

- Improve user experience.

- Maintain data consistency.

### Examples of Validation Rules

Examples include:

- Name should not be empty.

- Email must follow a valid format.

- Password must contain at least 8 characters.

- Age should be a positive number.

- Phone number should contain valid digits.

### Manual Validation Example

```

app.post("/register", (req, res) => {
const { name, email } = req.body;
if (!name || !email) {
return res.status(400).json({
message: "Name and Email are required"
});
}
res.send("Registration Successful");
});

```

### Explanation

- Checks if `name` exists.

- Checks if `email` exists.

- Returns an error if validation fails.

- Continues only if the input is valid.

## Using Validation Middleware

Instead of writing validation code inside every route, Express applications often use middleware.

### Installing Express Validator

```

npm install express-validator

```

`express-validator` is one of the most popular validation libraries for Express.js.

### Basic Validation Example

```

const { body, validationResult } = require("express-validator");
app.post(
"/register",
body("email").isEmail(),
body("password").isLength({ min: 8 }),
(req, res) => {
const errors = validationResult(req);
if (!errors.isEmpty()) {
return res.status(400).json({
errors: errors.array()
});
}
res.send("Registration Successful");
}
);

```

### Explanation

- `isEmail()` checks email format.

- `isLength()` checks password length.

- `validationResult()` collects validation errors.

- If validation fails, a **400 Bad Request** response is returned.

### Example Validation Response

```

{
"errors": [
{
"msg": "Invalid value",
"param": "email"
}
]
}

```

### Common Validation Methods

Method Purpose `isEmail()` Validates email format `isLength()` Checks string length Ensures a field is not `notEmpty()` empty `isNumeric()` Checks numeric values `isInt()` Validates integers `isMobilePhone()` Validates phone numbers

## Error Handling in Express.js

### What is Error Handling?

**Error Handling** is the process of detecting, managing, and responding to errors without crashing the application. Errors may occur because of:

- Invalid user input

- Database failures

- Missing files

- Invalid routes

- Server problems

### Handling Errors with Try-Catch

When using asynchronous code, `try...catch` is commonly used.

```

app.get("/students", async (req, res) => {
try {
const students = await Student.find();
res.json(students);
}
catch (error) {
res.status(500).json({
message: "Internal Server Error"
});
}
});

```

### Explanation

- `try` executes code that may fail.

- `catch` handles any errors.

- Prevents the server from crashing.

### Global Error Handling Middleware

Express allows centralized error handling using middleware.

```

app.use((err, req, res, next) => {
res.status(500).json({
message: err.message
});
});

```

This middleware catches errors passed using:

```

next(error);

```

### Returning Proper HTTP Status Codes

Status Code Meaning 200 OK 201 Created 400 Bad Request 401 Unauthorized 403 Forbidden 404 Not Found 500 Internal Server Error Example:

```

res.status(404).json({
message: "Student Not Found"
});

```

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Validate All User Input

Never trust data submitted by users. Always validate every input before processing it.

### 2. Return Meaningful Error Messages

Instead of:

```

res.send("Error");

```

Use:

```

res.status(400).json({
message: "Email address is required"
});

```

Clear messages help users understand the problem.

### 3. Use Appropriate HTTP Status Codes

Examples:

- `400` → Invalid input

- `404` → Resource not found

- `500` → Server error

Proper status codes make APIs easier to understand and debug.

### 4. Handle Asynchronous Errors

Always wrap asynchronous database operations in `try...catch` blocks or pass errors to error-handling middleware. Example:

```

try {
const users = await User.find();
}
catch (err) {
next(err);
}

```

### 5. Avoid Exposing Sensitive Information

Do not return database errors, passwords, or server details to users. Incorrect:

```

res.json(error);

```

Correct:

```

res.status(500).json({
message: "Internal Server Error"
});

```

### Advantages of Validation and Error Handling

- Prevents invalid data from entering the database.

- Improves application security.

- Reduces unexpected crashes.

- Provides better user experience.

- Makes debugging easier.

- Keeps code clean and maintainable.

- Produces more reliable APIs.

### Common Mistakes

### 1. Skipping Validation

Accepting user input without validation can lead to incorrect data and security vulnerabilities.

### 2. Using Generic Error Messages

Messages like: `Error` provide little information to users. Instead, return meaningful messages such as: `Email is required.`

### 3. Forgetting Try-Catch

Without proper error handling, asynchronous operations may crash the application. Incorrect:

```

const students = await Student.find();

```

Use:

```

try {
const students = await Student.find();
}
catch (error) {
res.status(500).json({
message: "Internal Server Error"
});
}

```

### 4. Returning Incorrect Status Codes

Avoid returning `200 OK` when an error occurs. Use the appropriate status code such as `400`, `404`, or `500`.

### 5. Exposing Internal Errors

Displaying stack traces or database details to users can reveal sensitive information and create security risks. Always return user-friendly error messages while logging detailed errors internally.

### Conclusion

Validation and Error Handling are essential for building secure, stable, and user-friendly Express.js applications. Validation ensures that user input meets the required rules before it is processed, while error handling enables the application to respond gracefully when something goes wrong. By using tools such as **express-validator**, implementing `try...catch` blocks, creating global error-handling middleware, validating every request, returning meaningful HTTP status codes, and protecting sensitive information, developers can build reliable Express.js applications that are secure, maintainable, and capable of handling real-world scenarios effectively.');

-- Lecture 11: Authentication & Authorization (JWT) in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Authentication & Authorization (JWT) in Express.js', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Authentication & Authorization (JWT) in Express.js

## Introduction to Authentication & Authorization (JWT)

Modern web applications must protect user data and ensure that only authorized users can access certain resources. Whether it is logging into a social media account, accessing online banking, or viewing personal information, security plays a vital role. Two important concepts that help achieve this are **Authentication** and **Authorization**. Although these terms are often used together, they have different meanings. **Authentication** verifies the identity of a user, while **Authorization** determines what an authenticated user is allowed to do. One of the most popular methods for implementing authentication in Express.js applications is **JWT (JSON Web Token)**. JWT allows users to log in once and securely access protected resources without repeatedly entering their credentials. It is lightweight, secure, and widely used in RESTful APIs, mobile applications, and modern web applications. Think of authentication as showing your ID card at the entrance of a building. Once your identity is verified, authorization decides which rooms you are allowed to enter.

## Understanding Authentication, Authorization, and JWT

### What is Authentication?

**Authentication** is the process of verifying a user\'s identity. Examples include:

- Logging in with an email and password.

- Signing in with Google or Facebook.

- Using biometric authentication such as fingerprints or facial recognition.

If the provided credentials are correct, the user is successfully authenticated.

### What is Authorization?

**Authorization** determines what an authenticated user is allowed to access or perform. Examples:

- A student can view their profile but cannot edit another student\'s data.

- An administrator can manage all users.

- A customer can view their own orders only.

Authentication always happens before authorization.

### What is JWT (JSON Web Token)?

A **JSON Web Token (JWT)** is a secure token used to exchange user information between the client and the server. After successful login: 1. The user submits login credentials. 2. The server verifies them. 3. The server generates a JWT. 4. The client stores the token. 5. The token is sent with future requests. 6. The server verifies the token before allowing access. JWT enables **stateless authentication**, meaning the server does not need to store user sessions.

### Structure of a JWT

A JWT consists of three parts separated by dots (`.`): `Header.Payload.Signature`

### Header

Contains information about the token type and signing algorithm. Example:

```

{
"alg": "HS256",
"typ": "JWT"
}

```

### Payload

Contains user information (claims). Example:

```

{
"id": 1,
"name": "Ali",
"role": "Admin"
}

```

### Signature

Ensures the token has not been modified and verifies its authenticity.

## Implementing JWT Authentication in Express.js

### Installing Required Packages

Install the necessary packages:

```

npm install express jsonwebtoken bcryptjs

```

Package purposes:

- **express** – Creates the web server.

- **jsonwebtoken** – Generates and verifies JWTs.

- **bcryptjs** – Hashes passwords securely.

### Basic Express Setup

```

const express = require("express");
const jwt = require("jsonwebtoken");
const app = express();
app.use(express.json());
app.listen(3000);

```

### Generating a JWT

After verifying the user\'s credentials, create a token.

```

const jwt = require("jsonwebtoken");
const user = {
id: 1,
name: "Ali"
};
const token = jwt.sign(user, "mySecretKey", {
expiresIn: "1h"
});
console.log(token);

```

### Explanation

- `jwt.sign()` creates a JWT.

- `"mySecretKey"` signs the token.

- `expiresIn` defines the token\'s validity period.

### User Login Example

```

app.post("/login", (req, res) => {
const user = {
id: 1,
name: "Ali"
};
const token = jwt.sign(user, "mySecretKey", {
expiresIn: "1h"
});
res.json({
token
});
});

```

After login, the client receives:

```

{
"token": "eyJhbGciOiJIUzI1NiIs..."
}

```

### Sending the Token

The client includes the token in future requests using the **Authorization** header.

```

Authorization: Bearer eyJhbGciOiJIUzI1NiIs...

```

## Verifying JWT and Protecting Routes

### Creating Authentication Middleware

Middleware verifies the token before allowing access.

```

function authenticateToken(req, res, next) {
const authHeader = req.headers["authorization"];
const token = authHeader && authHeader.split(" ")[1];
if (!token) {
return res.sendStatus(401);
}
jwt.verify(token, "mySecretKey", (err, user) => {
if (err) {
return res.sendStatus(403);
}
req.user = user;
next();
});
}

```

### Explanation

- Reads the Authorization header.

- Extracts the token.

- Verifies the token.

- If valid, continues to the next middleware.

- If invalid, returns an error.

### Protecting Routes

```

app.get("/profile", authenticateToken, (req, res) => {
res.json({
message: "Welcome",
user: req.user
});
});

```

Only users with a valid JWT can access this route.

### Authentication Flow

1. User submits login credentials. 2. Server validates the credentials. 3. Server generates a JWT. 4. Client stores the JWT. 5. Client sends the JWT with each request. 6. Server verifies the JWT. 7. If valid, access is granted.

### HTTP Status Codes Used

Status Code Meaning 200 OK 201 Created 401 Unauthorized (No Token) 403 Forbidden (Invalid Token) 500 Internal Server Error

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Hash Passwords

Never store plain-text passwords. Example:

```

const bcrypt = require("bcryptjs");
const hashedPassword = bcrypt.hashSync("password123", 10);

```

Hashing protects passwords even if the database is compromised.

### 2. Store Secret Keys Securely

Keep JWT secret keys in environment variables (such as a `.env` file) instead of hardcoding them into source code.

### 3. Set Token Expiration

Always define an expiration time. `expiresIn: "1h"` Expired tokens reduce the risk of misuse.

### 4. Use HTTPS

Always transmit JWTs over HTTPS to prevent interception during network communication.

### 5. Protect Sensitive Routes

Apply authentication middleware only to routes that require user verification. Example:

```

app.get("/dashboard", authenticateToken, handler);

```

### Advantages of JWT Authentication

- Stateless authentication.

- Easy to use with REST APIs.

- Lightweight and fast.

- Works across web and mobile applications.

- Reduces server-side session storage.

- Scalable for distributed systems.

### Common Mistakes

### 1. Hardcoding Secret Keys

Incorrect:

```

jwt.sign(user, "secret123");

```

Store secret keys securely using environment variables.

### 2. Not Setting Token Expiration

Tokens that never expire can become a security risk if they are stolen.

### 3. Storing Plain Passwords

Always hash passwords using `bcryptjs` before saving them to the database.

### 4. Forgetting to Verify the Token

Generating a JWT alone is not enough. Every protected route must verify the token using `jwt.verify()`.

### 5. Exposing Sensitive Data in the Payload

Avoid storing confidential information such as passwords or credit card details inside the JWT payload, because its contents can be decoded even though the signature prevents tampering.

### Conclusion

Authentication and Authorization are essential components of secure Express.js applications. Authentication verifies a user\'s identity, while Authorization controls what that user is permitted to access. JWT (JSON Web Token) provides a secure, lightweight, and stateless approach to authentication by allowing clients to send a signed token with each request. Combined with password hashing using `bcryptjs`, proper middleware for token verification, secure secret key management, HTTPS communication, and token expiration, JWT enables developers to build reliable, scalable, and secure APIs that protect user data and restrict access to authorized resources only.');

-- Lecture 12: CORS & Security Basics in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'CORS & Security Basics in Express.js', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# CORS & Security Basics in Express.js

## Introduction to CORS & Security Basics

When developing web applications, security is one of the most important aspects to consider. Applications often communicate with different websites, mobile apps, and APIs, making it essential to protect user data from unauthorized access. Two important concepts that help achieve this are **CORS (Cross-Origin Resource Sharing)** and **basic security practices**. By default, browsers block requests from one website to another for security reasons. CORS provides a controlled way to allow trusted websites to access server resources. Along with CORS, Express.js offers several techniques and middleware to protect applications from common attacks such as unauthorized access, data theft, and malicious requests. Think of your web server as a secure building. CORS acts as the security guard deciding who can enter, while other security measures such as authentication, HTTPS, and input validation act as locks, cameras, and alarms that keep the building safe.

## Understanding CORS (Cross-Origin Resource Sharing)

### What is CORS?

**CORS (Cross-Origin Resource Sharing)** is a browser security mechanism that controls whether a web application from one origin can access resources from another origin. An **origin** is made up of:

- Protocol (HTTP or HTTPS)

- Domain (example.com)

- Port number (3000, 5000, etc.)

If any one of these is different, it is considered a different origin. Example: `http://localhost:3000` and `http://localhost:5000` have different ports, so they are different origins.

### Why is CORS Needed?

Browsers enforce the **Same-Origin Policy**, which prevents websites from making requests to different origins without permission. CORS allows developers to specify which origins are permitted to access server resources. Without CORS:

- Browsers block cross-origin requests.

- APIs cannot be accessed from different websites.

### Installing the CORS Package

Install the official middleware: `npm install cors`

### Enabling CORS

```

const express = require("express");
const cors = require("cors");
const app = express();
app.use(cors());
app.listen(3000);

```

This allows requests from all origins.

### Allowing Specific Origins

Instead of allowing everyone, specify trusted websites.

```

app.use(cors({
origin: "http://localhost:3000"
}));

```

Only this origin can access the API.

### Allowing Multiple Origins

```

app.use(cors({
origin: [
"http://localhost:3000",
"https://example.com"
]
}));

```

This is more secure than allowing all origins.

## Security Basics in Express.js

### Why Security Matters

Without proper security, applications become vulnerable to attacks such as:

- Unauthorized access

- Data theft

- Password leakage

- Cross-Site Scripting (XSS)

- Cross-Site Request Forgery (CSRF)

- SQL Injection

- Denial-of-Service (DoS)

### Use HTTPS

Always use HTTPS instead of HTTP in production. HTTPS:

- Encrypts data.

- Protects login credentials.

- Prevents data interception.

Example: `https://example.com` is more secure than: `http://example.com`

### Use Helmet Middleware

Helmet adds security-related HTTP headers automatically. Install Helmet: `npm install helmet` Use Helmet:

```

const helmet = require("helmet");
app.use(helmet());

```

Helmet helps protect against several common web vulnerabilities by setting secure HTTP headers.

### Validate User Input

Never trust user input. Example:

```

if (!req.body.email) {
return res.status(400).json({
message: "Email is required"
});
}

```

Input validation prevents invalid or malicious data from entering the application.

### Store Passwords Securely

Never store passwords as plain text. Use **bcryptjs**.

```

const bcrypt = require("bcryptjs");
const hashedPassword = bcrypt.hashSync("mypassword", 10);

```

Hashing makes passwords much more secure.

## Common Security Practices

### Use Environment Variables

Never hardcode:

- Database passwords

- JWT secret keys

- API keys

Instead, store them in a `.env` file. Example:

```

DB_PASSWORD=yourPassword
JWT_SECRET=mySecretKey

```

Access them using: `process.env.JWT_SECRET`

### Limit Request Size

Prevent users from sending excessively large request bodies.

```

app.use(express.json({
limit: "1mb"
}));

```

This reduces the risk of certain denial-of-service attacks.

### Rate Limiting

Rate limiting restricts how many requests a client can make within a certain time. Install:

```

npm install express-rate-limit

```

Example:

```

const rateLimit = require("express-rate-limit");
const limiter = rateLimit({
windowMs: 15 * 60 * 1000,
max: 100
});
app.use(limiter);

```

This limits each client to **100 requests every 15 minutes**.

### Use Authentication

Protect private routes using JWT. Example:

```

app.get("/profile", authenticateToken, (req, res) => {
res.send("Protected Route");
});

```

Only authenticated users can access protected resources.

### Keep Dependencies Updated

Regularly update packages. `npm update` Updated packages often include important security fixes.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Allow Only Trusted Origins

Instead of:

```

app.use(cors());

```

Prefer:

```

app.use(cors({
origin: "https://example.com"
}));

```

This reduces unauthorized access.

### 2. Use Helmet

Always include: Helmet improves security with minimal effort.

### 3. Validate Every Request

Always check:

- Required fields

- Data types

- Input format

Validation reduces errors and protects against malicious input.

### 4. Use HTTPS in Production

Encrypt all communication between clients and the server to protect sensitive data.

### 5. Protect Sensitive Routes

Use JWT authentication for:

- Dashboard

- User profile

- Admin panel

- Payment pages

This ensures only authorized users can access critical resources.

### Advantages of CORS and Security Practices

- Protects user data.

- Prevents unauthorized access.

- Reduces common web attacks.

- Improves application reliability.

- Secures communication between client and server.

- Builds user trust.

- Supports safe API integration across applications.

### Common Mistakes

### 1. Allowing All Origins in Production

Incorrect:

```

app.use(cors());

```

This may expose your API to untrusted websites.

### 2. Hardcoding Secret Keys

Incorrect:

```

const secret = "mySecret123";

```

Store secrets in environment variables instead.

### 3. Storing Plain Passwords

Always hash passwords before saving them to the database. Plain-text passwords create a serious security risk.

### 4. Ignoring Input Validation

Accepting unchecked user input can lead to vulnerabilities such as SQL Injection or Cross-Site Scripting (XSS).

### 5. Forgetting Security Middleware

Not using middleware like **Helmet**, **CORS**, or **rate limiting** leaves the application more vulnerable to attacks and reduces overall security.

### Conclusion

CORS and security basics are fundamental to building secure Express.js applications. CORS enables controlled communication between different origins while respecting browser security rules, and middleware such as **cors** and **helmet** simplify secure configuration. By validating user input, hashing passwords, using HTTPS, storing secrets in environment variables, applying rate limiting, and protecting sensitive routes with authentication, developers can greatly reduce security risks. Following these best practices results in Express.js applications that are more secure, reliable, scalable, and capable of protecting both user data and server resources from common web threats.');

-- Lecture 13: Testing Express APIs
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Testing Express APIs', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Testing Express APIs

## Introduction to Testing Express APIs

Developing an API is only the first step in building a reliable web application. Before an API is used by websites, mobile applications, or other services, it must be thoroughly tested to ensure it works correctly. **API testing** verifies that endpoints return the correct responses, handle errors properly, and perform expected operations under different conditions. In Express.js, API testing helps developers identify bugs early, improve application reliability, and ensure that future updates do not break existing functionality. Testing can be performed manually using tools such as **Postman** or automatically using testing frameworks like **Jest** and **Supertest**. Think of API testing like inspecting a newly built bridge before allowing vehicles to cross it. Even if the bridge looks complete, testing ensures it is safe, stable, and ready for real-world use.

## Understanding API Testing

### What is API Testing?

**API Testing** is the process of sending requests to an API and verifying that the responses match the expected results. Testing checks whether:

- Endpoints are working correctly.

- Data is returned accurately.

- Status codes are correct.

- Errors are handled properly.

- Security rules are enforced.

### Why is API Testing Important?

API testing helps to:

- Detect bugs early.

- Improve software quality.

- Ensure APIs behave as expected.

- Prevent future code changes from breaking existing features.

- Save development and debugging time.

### Types of API Testing

### 1. Functional Testing

Verifies that API endpoints perform the intended operations. Example: `GET /students` Expected result:

- Status Code: **200**

- Returns a list of students.

### 2. Validation Testing

Checks whether the API correctly validates user input. Example:

```

{
"email": ""
}

```

Expected result:

- Status Code: **400**

- Error message indicating that the email is required.

### 3. Security Testing

Ensures protected routes cannot be accessed without proper authentication. Example: `GET /profile` Without a valid JWT:

- Status Code: **401 Unauthorized**

## Manual API Testing Using Postman

### What is Postman?

**Postman** is a popular tool for testing APIs by sending HTTP requests and viewing responses. It supports:

- GET requests

- POST requests

- PUT requests

- DELETE requests

- Authentication testing

- Header management

- JSON request bodies

### Testing a GET Request

Suppose the API endpoint is:

```

GET http://localhost:3000/students

```

Expected Response:

```

[
{
"id": 1,
"name": "Ali"
},
{
"id": 2,
"name": "Sara"
}
]

```

Status Code: `200 OK`

### Testing a POST Request

Request:

```

POST http://localhost:3000/students

```

Request Body:

```

{
"name": "Ahmed",
"age": 21
}

```

Expected Response:

```

{
"id": 3,
"name": "Ahmed",
"age": 21
}
201 Created

```

### Testing Authentication

For protected routes, include the JWT in the request header.

```

Authorization: Bearer eyJhbGciOiJIUzI1NiIs...

```

If the token is valid: `200 OK` If the token is missing or invalid: `401 Unauthorized`

## Automated API Testing with Jest and Supertest

### Installing Testing Packages

Install the required packages:

```

npm install --save-dev jest supertest

```

### Purpose

- **Jest** – JavaScript testing framework.

- **Supertest** – Sends HTTP requests to Express applications during testing.

### Basic Test Example

```

const request = require("supertest");
const app = require("./app");
describe("GET /students", () => {
test("should return all students", async () => {
const response = await request(app).get("/students");
expect(response.statusCode).toBe(200);
});
});

```

### Explanation

- `request(app)` sends a request to the Express application.

- `.get("/students")` tests the GET endpoint.

- `expect()` verifies the expected result.

### Testing POST Requests

```

test("should create a student", async () => {
const response = await request(app)
.post("/students")
.send({
name: "Ali",
age: 20
});
expect(response.statusCode).toBe(201);
});

```

### Testing Invalid Data

```

test("should reject empty name", async () => {
const response = await request(app)
.post("/students")
.send({
name: ""
});
expect(response.statusCode).toBe(400);
});

```

This confirms that validation is working correctly.

### Running Tests

Execute: `npm test` If all tests pass: `PASS` Otherwise: `FAIL` The test report identifies which test failed.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Test Every Endpoint

Test all HTTP methods:

- GET

- POST

- PUT

- DELETE

Every API endpoint should have corresponding test cases.

### 2. Test Both Success and Failure Cases

Example: Success: Expected: `200 OK` Failure: `GET /students/999` Expected: `404 Not Found` Testing both scenarios ensures reliability.

### 3. Verify Status Codes

Always check that the API returns the correct HTTP status codes. Examples:

- 200

- 201

- 400

- 401

- 404

- 500

### 4. Test Input Validation

Verify that invalid data is rejected. Example:

```

{
"email": ""
}

```

Expected: `400 Bad Request`

### 5. Automate Repeated Tests

Use Jest and Supertest to automate testing so it can be run whenever the application changes.

### Advantages of API Testing

- Detects bugs early.

- Improves software quality.

- Saves debugging time.

- Ensures APIs remain reliable after updates.

- Verifies security and authentication.

- Increases confidence before deployment.

- Supports continuous integration and deployment (CI/CD).

### Common Mistakes

### 1. Testing Only Successful Requests

Many developers test only valid inputs and ignore invalid or unexpected cases. Always test both.

### 2. Ignoring Status Codes

Do not verify only the response body. Always confirm that the correct HTTP status code is returned.

### 3. Not Testing Authentication

Protected routes should be tested with:

- Valid JWT

- Invalid JWT

- Missing JWT

This ensures authentication works correctly.

### 4. Using Real Production Data

Avoid testing against production databases. Use separate development or test databases to prevent accidental data loss or modification.

### 5. Skipping Automated Tests

Manual testing alone is not enough. Automated tests help detect regressions quickly whenever code changes.

### Conclusion

Testing Express APIs is an essential part of building reliable and secure web applications. Manual testing with tools like **Postman** allows developers to verify API behavior interactively, while automated testing with **Jest** and **Supertest** ensures consistent and repeatable verification of endpoints. By testing all HTTP methods, validating both successful and failure scenarios, checking authentication, verifying HTTP status codes, and automating test execution, developers can create Express.js APIs that are stable, secure, maintainable, and ready for deployment in real-world environments.');

-- Lecture 14: Building a REST API Project in Express.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a REST API Project in Express.js', 14, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a REST API Project in Express.js

## Introduction to Building a REST API Project

After learning the fundamentals of Express.js, routing, middleware, databases, authentication, and testing, the next step is to combine these concepts into a complete **REST API Project**. A REST API enables applications such as websites, mobile apps, and desktop software to communicate with a server using standard HTTP methods. In this lecture, we will build a simple **Student Management REST API** using Express.js. The API will perform CRUD (Create, Read, Update, Delete) operations, connect to a database, validate user input, secure endpoints, and return JSON responses. Think of a REST API project as constructing a house. Each concept—routing, middleware, authentication, validation, and database connectivity—is like a building block. When combined correctly, they create a complete and functional application.

## Project Planning and Setup

### Project Objective

The goal is to build a Student Management API that can:

- Add a student.

- View all students.

- View a single student.

- Update student details.

- Delete a student.

- Secure protected routes using JWT.

- Validate incoming data.

### Required Packages

Install the required packages:

```

npm init -y
npm install express mongoose dotenv jsonwebtoken bcryptjs express-validator cors helmet

```

### Package Purpose

Package Purpose Express Web framework Mongoose MongoDB connection Dotenv Environment variables JSON Web Token Authentication bcryptjs Password hashing express-validator Input validation CORS Cross-Origin Resource Sharing Helmet Security headers

### Recommended Project Structure

```

student-api/
│── app.js
│── package.json
│── .env
├── config/
│ database.js
├── models/
│ Student.js
├── routes/
│ studentRoutes.js
├── controllers/
│ studentController.js
├── middleware/
│ auth.js
└── validators/
studentValidator.js

```

This structure keeps the project organized and easier to maintain.

## Building the REST API

### Step 1: Create Express Server

```

const express = require("express");
const app = express();
app.use(express.json());
app.listen(3000, () => {
console.log("Server Running");
});

```

### Step 2: Connect to MongoDB

```

const mongoose = require("mongoose");
mongoose.connect("mongodb://127.0.0.1:27017/studentDB")
.then(() => {
console.log("Database Connected");
})
.catch(err => console.log(err));

```

This establishes the database connection.

### Step 3: Create Student Schema

```

const mongoose = require("mongoose");
const studentSchema = new mongoose.Schema({
name: String,
age: Number,
department: String
});
module.exports = mongoose.model("Student", studentSchema);

```

The schema defines how student data is stored.

### Step 4: Create API Routes

### GET All Students

```

app.get("/students", async (req, res) => {
const students = await Student.find();
res.json(students);
});

```

### GET Student by ID

```

app.get("/students/:id", async (req, res) => {
const student = await Student.findById(req.params.id);
res.json(student);
});

```

### POST New Student

```

app.post("/students", async (req, res) => {
const student = new Student(req.body);
await student.save();
res.status(201).json(student);
});

```

### PUT Update Student

```

app.put("/students/:id", async (req, res) => {
const student = await Student.findByIdAndUpdate(
req.params.id,
req.body,
{ new: true }
);
res.json(student);
});

```

### DELETE Student

```

app.delete("/students/:id", async (req, res) => {
await Student.findByIdAndDelete(req.params.id);
res.json({
message: "Student Deleted Successfully"
});
});

```

### Testing the API

Method Endpoint Purpose GET `/students` Retrieve all students GET `/students/:id` Retrieve one student POST `/students` Add a new student PUT `/students/:id` Update a student DELETE `/students/:id` Delete a student

## Adding Security and Validation

### Input Validation

Install Express Validator:

```

npm install express-validator

```

Example validation:

```

const { body } = require("express-validator");
body("name").notEmpty();
body("age").isNumeric();

```

This prevents invalid data from entering the database.

### JWT Authentication

Generate a token after login.

```

const token = jwt.sign(
{
id: user.id
},
process.env.JWT_SECRET,
{
expiresIn: "1h"
}
);

```

### Protect Routes

```

app.get(
"/profile",
authenticateToken,
(req, res) => {
res.send("Protected Route");
}
);

```

Only authenticated users can access protected resources.

### Error Handling

```

app.use((err, req, res, next) => {
res.status(500).json({
message: err.message
});
});

```

Global error handling improves application stability.

### Security Middleware

```

const helmet = require("helmet");
const cors = require("cors");
app.use(helmet());
app.use(cors());

```

Helmet adds secure HTTP headers, while CORS controls cross-origin requests.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Follow MVC Architecture

Separate:

- Models

- Views (if applicable)

- Controllers

- Routes

This improves readability and maintainability.

### 2. Use Environment Variables

Store sensitive information such as:

- Database URL

- JWT Secret

- API Keys

inside the `.env` file instead of hardcoding them.

### 3. Validate Every Request

Always validate:

- Required fields

- Email format

- Numeric values

- Password length

before processing data.

### 4. Handle Errors Properly

Return meaningful responses. Example:

```

res.status(404).json({
message: "Student Not Found"
});

```

### 5. Test Every Endpoint

Use tools like:

- Postman

- Jest

- Supertest

to verify API functionality before deployment.

### Advantages of Building a REST API

- Supports web, mobile, and desktop applications.

- Uses standard HTTP methods.

- Easy to maintain and extend.

- Supports secure authentication.

- Works efficiently with databases.

- Enables scalable application development.

- Encourages modular and reusable code.

### Common Mistakes

### 1. Mixing Business Logic with Routes

Avoid writing all application logic inside route files. Keep logic in controllers for better organization.

### 2. Skipping Validation

Never trust user input. Invalid data can cause errors and security vulnerabilities.

### 3. Hardcoding Secrets

Avoid writing passwords, API keys, or JWT secrets directly in source code. Use environment variables instead.

### 4. Ignoring Error Handling

Failing to handle exceptions can cause server crashes and make debugging difficult.

### 5. Not Securing Protected Routes

Always verify JWT tokens before allowing access to sensitive endpoints such as user profiles, dashboards, or administrative functions.

### Conclusion

Building a REST API project in Express.js combines multiple concepts—including routing, middleware, database connectivity, CRUD operations, authentication, validation, security, and testing—into a complete application. By organizing the project with a clear folder structure, connecting to a database, implementing RESTful endpoints, validating user input, securing routes with JWT, handling errors effectively, and following best practices, developers can create scalable, maintainable, and secure APIs. These skills form the foundation for developing real-world backend applications that can serve websites, mobile apps, and other client systems efficiently.

### Building a Complete REST API Project in Express.js (Student Management

### System)

**Project Goal:** By the end of these notes, we will have a fully functional Student Management REST API with:

- Express.js

- MongoDB

- Mongoose

- CRUD Operations

- Validation

- JWT Authentication

- Protected Routes

- Error Handling

- Testing using Postman

## Step 1 – Create the Project

### Create Project Folder

`mkdir StudentAPI` Move inside the folder. `cd StudentAPI` Initialize Node.js. `npm init -y`

### Install Required Packages

```

npm install express mongoose dotenv jsonwebtoken bcryptjs express-validator cors helmet

```

For development:

```

npm install --save-dev nodemon

```

### Folder Structure

```

StudentAPI/
│── node_modules/
│── config/
│ database.js
│── controllers/
│ studentController.js
│ authController.js
│── middleware/
│ auth.js
│── models/
│ Student.js
│ User.js
│── routes/
│ studentRoutes.js
│ authRoutes.js
│── .env
│── app.js
│── package.json

```

## Step 2 – Configure Environment Variables

Create a **.env** file.

```

PORT=3000
DB_URL=mongodb://127.0.0.1:27017/studentDB
JWT_SECRET=mySecretKey

```

### Install dotenv

Inside **app.js**

```

require("dotenv").config();

```

## Step 3 – Create Express Server

**app.js**

```

require("dotenv").config();
const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const app = express();
app.use(express.json());
app.use(cors());
app.use(helmet());
app.listen(process.env.PORT, () => {
console.log("Server Running");
});

```

Run server `node app.js` or `npx nodemon app.js`

## Step 4 – Connect MongoDB

Create

```

config/database.js
const mongoose = require("mongoose");
mongoose.connect(process.env.DB_URL)
.then(() => {
console.log("Database Connected");
})
.catch(err => {
console.log(err);
});

```

Import it inside app.js

```

require("./config/database");

```

## Step 5 – Create Student Model

Create

```

models/Student.js
const mongoose = require("mongoose");
const studentSchema = new mongoose.Schema({
name:{
type:String,
required:true
},
age:Number,
department:String
});
module.exports = mongoose.model("Student",studentSchema);

```

## Step 6 – Create Student Routes

Create

```

routes/studentRoutes.js
const express=require("express");
const router=express.Router();
router.get("/");
router.get("/:id");
router.post("/");
router.put("/:id");
router.delete("/:id");
module.exports=router;

```

Import routes inside app.js

```

const studentRoutes=require("./routes/studentRoutes");
app.use("/students",studentRoutes);

```

## Step 7 – Create Controller

Create

```

controllers/studentController.js

```

Import model

```

const Student=require("../models/Student");

```

### GET All Students

```

exports.getStudents=async(req,res)=>{
const students=await Student.find();
res.json(students);
}

```

### GET Student By ID

```

exports.getStudent=async(req,res)=>{
const student=await Student.findById(req.params.id);
res.json(student);
}

```

### POST Student

```

exports.createStudent=async(req,res)=>{
const student=new Student(req.body);
await student.save();
res.status(201).json(student);
}

```

### PUT Student

```

exports.updateStudent=async(req,res)=>{
const student=await Student.findByIdAndUpdate(
req.params.id,
req.body,
{new:true}
);
res.json(student);
}

```

### DELETE Student

```

exports.deleteStudent=async(req,res)=>{
await Student.findByIdAndDelete(req.params.id);
res.json({
message:"Student Deleted"
});
}

```

### Connect Controller with Routes

```

const express=require("express");
const router=express.Router();
const student=require("../controllers/studentController");
router.get("/",student.getStudents);
router.get("/:id",student.getStudent);
router.post("/",student.createStudent);
router.put("/:id",student.updateStudent);
router.delete("/:id",student.deleteStudent);
module.exports=router;

```

## Step 8 – Create User Model

Create

```

models/User.js
const mongoose=require("mongoose");
const userSchema=new mongoose.Schema({
username:String,
email:String,
password:String
});
module.exports=mongoose.model("User",userSchema);

```

## Step 9 – Register User

Create

```

controllers/authController.js
const User=require("../models/User");
const bcrypt=require("bcryptjs");

```

Register

```

exports.register=async(req,res)=>{
const hash=await bcrypt.hash(req.body.password,10);
const user=new User({
username:req.body.username,
email:req.body.email,
password:hash
});
await user.save();
res.json({
message:"Registration Successful"
});
}

```

## Step 10 – Login User

Import JWT

```

const jwt=require("jsonwebtoken");

```

Login

```

exports.login=async(req,res)=>{
const user=await User.findOne({
email:req.body.email
});
if(!user)
return res.status(404).json({
message:"User Not Found"
});
const check=await bcrypt.compare(
req.body.password,
user.password
);
if(!check)
return res.status(401).json({
message:"Wrong Password"
});
const token=jwt.sign(
{
id:user._id
},
process.env.JWT_SECRET,
{
expiresIn:"1h"
}
);
res.json({
token
});
}

```

## Step 11 – Authentication Middleware

Create

```

middleware/auth.js
const jwt=require("jsonwebtoken");
module.exports=(req,res,next)=>{
const auth=req.headers.authorization;
const token=auth&&auth.split(" ")[1];
if(!token)
return res.sendStatus(401);
jwt.verify(
token,
process.env.JWT_SECRET,
(err,user)=>{
if(err)
return res.sendStatus(403);
req.user=user;
next();
}
);
}

```

## Step 12 – Protect Routes

```

const auth=require("../middleware/auth");
router.post("/",auth,student.createStudent);
router.put("/:id",auth,student.updateStudent);
router.delete("/:id",auth,student.deleteStudent);

```

Now only logged-in users can:

- Add Students

- Update Students

- Delete Students

## Step 13 – Input Validation

Install

```

npm install express-validator

```

Example

```

const {body,validationResult}=require("express-validator");
router.post(
"/",
body("name").notEmpty(),
body("age").isNumeric(),
(req,res,next)=>{
const errors=validationResult(req);
if(!errors.isEmpty()){
return res.status(400).json({
errors:errors.array()
});
}
next();
},
student.createStudent
);

```

## Step 14 – Global Error Handling

Inside app.js

```

app.use((err,req,res,next)=>{
res.status(500).json({
message:err.message
});
});

```

## Step 15 – Testing Using Postman

### Register User

```

POST
http://localhost:3000/register

```

Body

```

{
"username":"Ali",
"email":"ali@gmail.com",
"password":"123456"
}

```

### Login

```

POST
http://localhost:3000/login

```

Response

```

{
"token":"eyJhbGc..."
}

```

Copy this token.

### Create Student

```

POST
http://localhost:3000/students

```

Header

```

Authorization
Bearer eyJhbGc...

```

Body

```

{
"name":"Ahmed",
"department":"Computer Science"
}

```

### Get All Students

```

GET
http://localhost:3000/students

```

### Update Student

```

PUT
http://localhost:3000/students/<student-id>

```

Body

```

{
"department":"Software Engineering"
}

```

### Delete Student

```

DELETE
http://localhost:3000/students/<student-id>

```

## Final Project Structure

```

StudentAPI/
│── app.js
│── package.json
│── .env
├── config/
│ database.js
├── controllers/
│ authController.js
│ studentController.js
├── middleware/
│ auth.js
├── models/
│ Student.js
│ User.js
├── routes/
│ authRoutes.js
│ studentRoutes.js
└── node_modules/

```

## Final Features of the Project

- ✅ Express.js Server

- ✅ MongoDB Connection

- ✅ Mongoose Models

- ✅ RESTful CRUD API

- ✅ Express Router

- ✅ MVC Folder Structure

- ✅ Environment Variables (.env)

- ✅ JWT Authentication

- ✅ Password Hashing (bcryptjs)

- ✅ Protected Routes

- ✅ Input Validation (express-validator)

- ✅ CORS Enabled

- ✅ Helmet Security

- ✅ Global Error Handling

- ✅ Tested with Postman

### Conclusion

By following these steps, we have built a complete **Student Management REST API** in Express.js from scratch. The project includes a professional MVC folder structure, MongoDB integration with Mongoose, full CRUD functionality, user registration and login, secure JWT-based authentication, password hashing with `bcryptjs`, protected routes, input validation using `express-validator`, security enhancements with CORS and Helmet, centralized error handling, and API testing with Postman. This project reflects the architecture used in many real-world backend applications and provides a solid foundation for developing scalable, secure, and maintainable REST APIs.');
