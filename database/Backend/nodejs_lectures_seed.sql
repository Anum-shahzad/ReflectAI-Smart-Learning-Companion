-- =============================================
-- ReflectAI — Node.js Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'Node.js' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to Node.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to Node.js', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to Node.js

When we first learn JavaScript, we usually use it inside a web browser to make websites interactive. We use it to validate forms, create animations, update content dynamically, and respond to user actions. But have you ever wondered, **"Can JavaScript be used outside the browser?"** The answer is **yes**, and that is exactly where **Node.js** comes into the picture. **Node.js** is an **open-source, cross-platform JavaScript runtime environment** that allows developers to run JavaScript code outside a web browser. It enables JavaScript to be used for building server-side applications, command-line tools, APIs, desktop applications, and even Internet of Things (IoT) solutions. Think of JavaScript as a talented chef who has always worked inside a restaurant (the browser). Node.js is like opening the restaurant doors and allowing the chef to cook anywhere—in homes, hotels, or food trucks. Similarly, Node.js frees JavaScript from the browser and allows it to run directly on the operating system. Today, Node.js powers thousands of popular applications because it is fast, lightweight, scalable, and efficient.

## Understanding Node.js

### What is Node.js?

Node.js is a runtime environment built on **Google Chrome\'s V8 JavaScript Engine**. It executes JavaScript code directly on a computer without requiring a browser. Unlike traditional server-side languages such as PHP or Java, Node.js uses JavaScript on both the client side and the server side. This means developers can use a single programming language throughout an entire web application.

### Key Characteristics of Node.js

- Open-source

- Cross-platform (Windows, Linux, macOS)

- Built on the V8 JavaScript Engine

- Uses an event-driven architecture

- Employs non-blocking I/O operations

- Supports asynchronous programming

- Lightweight and highly scalable

### How Node.js Works

Traditional web servers create a separate thread for every client request. As the number of users increases, more system resources are consumed. Node.js takes a different approach by using a **single-threaded event loop**. Instead of waiting for one task to finish before starting another, Node.js handles multiple requests asynchronously. When an operation such as reading a file or querying a database takes time, Node.js continues processing other tasks instead of remaining idle. Imagine a waiter in a busy restaurant. Rather than standing beside one customer until the meal is ready, the waiter takes multiple orders, serves different tables, and returns when each meal is prepared. Similarly, Node.js efficiently manages many client requests without creating unnecessary threads.

## Why Learn Node.js?

Learning Node.js provides several advantages:

- Use JavaScript for both frontend and backend development.

- Build fast and scalable web applications.

- Develop RESTful APIs and web services.

- Create real-time applications such as chat systems.

- Access a vast ecosystem of open-source packages through npm.

- Improve career opportunities in full-stack development.

Node.js is widely used by startups, enterprises, and technology companies because of its speed and flexibility.

## Advantages and Limitations of Node.js

### Advantages of Node.js

Node.js offers numerous benefits:

- High performance due to the V8 engine.

- Fast execution of JavaScript code.

- Efficient handling of multiple client requests.

- Large and active developer community.

- Extensive collection of npm packages.

- Easy to learn for JavaScript developers.

- Ideal for real-time and data-intensive applications.

- Supports full-stack JavaScript development.

### Limitations of Node.js

Despite its strengths, Node.js has some limitations:

- Single-threaded architecture is less suitable for CPU-intensive tasks.

- Callback-based programming can become complex if not managed properly.

- Rapid changes in packages may create compatibility issues.

- Some npm packages may have security vulnerabilities if not maintained.

Understanding these limitations helps developers choose the right technology for each project.

## Real-World Applications of Node.js

Node.js is used in a wide variety of industries and applications:

- **Web Servers:** Powers backend servers for websites and web applications.

- **REST APIs:** Creates APIs that allow applications to exchange data.

- **Real-Time Applications:** Used in chat platforms, messaging systems, and collaborative tools.

- **Streaming Applications:** Supports video, music, and live streaming services.

- **Internet of Things (IoT):** Communicates with sensors and smart devices.

- **Command-Line Tools:** Used to build automation and development utilities.

### Conclusion

Node.js is a powerful, open-source JavaScript runtime environment that enables developers to build fast, scalable, and efficient server-side applications using JavaScript outside the browser. Its event-driven, non-blocking architecture allows it to handle many simultaneous connections while consuming relatively few system resources. By understanding what Node.js is, how it works, its advantages, limitations, and real-world applications, we build a strong foundation for learning backend development. Mastering these introductory concepts prepares us to explore more advanced topics such as modules, npm, Express.js, APIs, and full-stack web development.');

-- Lecture 2: Node.js Installation & Environment Setup
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Node.js Installation & Environment Setup', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Node.js Installation & Environment Setup

## Introduction to Node.js Installation

Before we can build applications with Node.js, we must install it and set up a proper development environment. Installing Node.js is the first step toward backend development because it provides everything needed to execute JavaScript outside the browser. A proper environment setup ensures that our projects run smoothly, dependencies are managed correctly, and development becomes more efficient. Once Node.js is installed, we also get **npm (Node Package Manager)**, which allows us to install and manage thousands of JavaScript libraries.

## Installing Node.js

### Step 1: Download Node.js

Visit the official Node.js website and download the **LTS (Long-Term Support)** version. The LTS version is recommended because it is stable, reliable, and widely used for production applications. Choose the installer according to your operating system:

- Windows

- macOS

- Linux

### Step 2: Run the Installer

After downloading: 1. Open the installer. 2. Accept the license agreement. 3. Keep the default installation settings. 4. Ensure that **Node.js** and **npm** are selected. 5. Click **Install**. 6. Finish the installation process. The installer automatically configures most settings required to begin development.

### Step 3: Verify the Installation

Open **Command Prompt**, **PowerShell**, or the **Terminal** and run: `node -v` Example Output: `v22.5.0` This command displays the installed version of Node.js. Next, verify npm: `npm -v` Example Output: `10.8.2` If both commands return version numbers, the installation was successful.

## Setting Up the Development Environment

### Choosing a Code Editor

Although Node.js code can be written in any text editor, modern code editors make development easier by providing features such as syntax highlighting, auto-completion, debugging, and extensions. Popular editors include:

- Visual Studio Code (VS Code)

- WebStorm

- Sublime Text

- Atom

Among these, **Visual Studio Code** is the most popular choice because it is lightweight, free, and has excellent support for JavaScript and Node.js.

### Creating Your First Project Folder

Create a new folder for your project. Example: `MyNodeProject/` Open this folder in your preferred code editor. Keeping each project in its own folder helps organize files and makes project management easier.

### Creating Your First JavaScript File

Inside the project folder, create a file named: `app.js` This file will contain the main code for your Node.js application.

## Running Your First Node.js Program

Open `app.js` and write:

```

console.log("Hello, Node.js!");

```

Save the file and open the terminal inside the project folder. Run the program using: `node app.js` Output: `Hello, Node.js!` Unlike browser-based JavaScript, the output appears directly in the terminal because Node.js executes JavaScript outside the browser.

### Understanding the Node.js REPL

Node.js provides an interactive environment called the **REPL (Read-Evaluate-Print Loop)**. It allows us to execute JavaScript commands without creating a file. Start the REPL by typing: `node` Example:

```

> 5 + 10
15
> "Node.js".toUpperCase()
\'NODE.JS\'

```

The REPL is useful for testing small code snippets and learning JavaScript interactively.

## Best Practices for Environment Setup

To create a productive Node.js development environment, follow these best practices:

- Use the **LTS version** of Node.js for stability.

- Keep Node.js and npm updated.

- Create a separate folder for every project.

- Use a modern code editor such as VS Code.

- Save your work frequently before running programs.

- Verify installations using `node -v` and `npm -v`.

- Organize project files clearly from the beginning.

Following these practices makes development smoother and reduces common setup issues.

### Conclusion

Installing Node.js and setting up the development environment is the foundation of backend JavaScript development. By downloading the LTS version, verifying the installation, choosing a suitable code editor, creating a project folder, and running the first Node.js program, we establish everything needed to begin building applications. A well-configured environment not only improves productivity but also ensures that future projects can be developed, tested, and maintained efficiently. Once this setup is complete, we are ready to explore more advanced Node.js concepts such as modules, npm, Express.js, file handling, and backend application development.');

-- Lecture 3: Modules (CommonJS & ES Modules)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Modules (CommonJS & ES Modules)', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Modules (CommonJS & ES Modules)

## Introduction to Modules

As applications become larger and more complex, writing all the code in a single file becomes difficult to manage. Imagine writing an entire book without chapters—it would quickly become confusing and hard to maintain. Similarly, software projects need a way to organize code into smaller, reusable sections. This is where **modules** come into play. A **module** is a separate JavaScript file that contains related code such as variables, functions, classes, or objects. Instead of rewriting the same code in multiple places, we can create a module once and reuse it wherever needed. Node.js supports two module systems:

- **CommonJS (CJS)** – The traditional module system used in Node.js.

- **ES Modules (ESM)** – The modern JavaScript module system introduced as part of the ECMAScript standard.

Both systems help organize code, improve readability, and promote code reuse.

## Understanding CommonJS Modules

### What is CommonJS?

**CommonJS** is the default module system used in Node.js. It allows developers to export code from one file and import it into another using the `module.exports` and `require()` syntax. This approach keeps programs modular by separating different functionalities into individual files.

### Exporting a Module

Create a file named **math.js**:

```

function add(a, b) {
return a + b;
}
function subtract(a, b) {
return a - b;
}
module.exports = {
add,
subtract
};

```

The `module.exports` object makes the functions available to other files.

### Importing a Module

Create another file named **app.js**:

```

const math = require("./math");
console.log(math.add(10, 5));
console.log(math.subtract(10, 5));

```

Output:

```

15
5

```

The `require()` function loads the exported module so its functions can be used.

### Advantages of CommonJS

- Simple and easy to understand.

- Default module system in Node.js.

- Well-supported by older Node.js projects.

- Suitable for backend applications.

## Understanding ES Modules (ESM)

### What are ES Modules?

**ES Modules (ESM)** are the official JavaScript module system introduced in modern JavaScript. They use the `export` and `import` keywords and are supported by modern browsers and recent versions of Node.js. ES Modules provide a cleaner and more standardized way of organizing JavaScript code.

### Exporting Functions

Create **math.js**:

```

export function add(a, b) {
return a + b;
}
export function subtract(a, b) {
return a - b;
}

```

Here, each function is exported using the `export` keyword.

### Importing Functions

Create **app.js**:

```

import { add, subtract } from "./math.js";
console.log(add(20, 8));
console.log(subtract(20, 8));

```

Output:

```

28
12

```

The `import` statement allows us to use only the functions we need.

### Default Export

Sometimes a module exports only one value. In that case, we can use a **default export**. Example:

```

export default function greet() {
console.log("Welcome!");
}

```

Import it:

```

import greet from "./greet.js";
greet();

```

Default exports simplify importing when a module contains a single main feature.

## CommonJS vs ES Modules

### Key Differences

Feature CommonJS ES Modules Import Keyword `require() import` Export Keyword `module.exports export` Loading Synchronous Static and asynchronous Standard Node.js JavaScript (ECMAScript) Browser Support No Yes Modern JavaScript Modern Usage Older Node.js projects projects Both systems achieve the same goal of organizing code, but ES Modules are now the preferred choice for modern JavaScript development.

### When Should We Use Each?

**Use CommonJS when:**

- Working with older Node.js projects.

- Maintaining legacy applications.

- Using packages that rely on CommonJS.

**Use ES Modules when:**

- Starting new Node.js projects.

- Building modern JavaScript applications.

- Developing applications that share code between the browser and Node.js.

Understanding both systems is important because many existing projects still use CommonJS, while newer projects increasingly adopt ES Modules.

## Best Practices and Benefits of Modules

### Best Practices

To write clean and maintainable code using modules:

- Keep each module focused on a single responsibility.

- Use meaningful file names.

- Avoid placing all code in one file.

- Export only what is necessary.

- Organize related modules into folders.

- Maintain a clear project structure.

- Choose one module system consistently within a project whenever possible.

These practices improve readability and make applications easier to maintain.

### Advantages of Using Modules

Modules provide many important benefits:

- Improve code organization.

- Encourage code reuse.

- Reduce duplication.

- Simplify debugging.

- Make maintenance easier.

- Support teamwork by allowing developers to work on different modules.

- Increase scalability as projects grow.

Because of these advantages, modules are a fundamental part of professional JavaScript and Node.js development.

### Common Challenges

While modules make development easier, developers may encounter some challenges:

- Incorrect import paths can cause module errors.

- Mixing CommonJS and ES Modules may create compatibility issues.

- Circular dependencies can make code difficult to manage.

- Forgetting to export a function or class can lead to runtime errors.

Understanding the module system and following good coding practices helps avoid these problems.

### Conclusion

Modules are one of the most important concepts in Node.js because they allow us to organize applications into smaller, reusable, and manageable files. Node.js supports two module systems: **CommonJS**, which uses `require()` and `module.exports`, and **ES Modules**, which use the modern `import` and `export` syntax. While CommonJS remains common in older projects, ES Modules have become the standard for modern JavaScript development due to their cleaner syntax and wider compatibility. By understanding both module systems and applying best practices, we can build applications that are easier to maintain, extend, and collaborate on, making modules an essential foundation for every Node.js developer.');

-- Lecture 4: Core Modules (fs, path, os, process)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Core Modules (fs, path, os, process)', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Core Modules (fs, path, os, process)

## Introduction to Core Modules

When building Node.js applications, developers frequently need to work with files, folders, operating system information, and the running application itself. Instead of writing these functionalities from scratch, Node.js provides a collection of **built-in modules**, known as **Core Modules**. Core modules come pre-installed with Node.js, so there is no need to install them using npm. We simply import them into our project and start using them. Some of the most commonly used core modules are:

- **fs** – File System Module

- **path** – Path Module

- **os** – Operating System Module

- **process** – Process Module

These modules provide essential functionality for developing efficient and scalable Node.js applications.

## File System Module (fs)

### What is the fs Module?

The **fs (File System)** module allows Node.js applications to interact with files and directories. It enables developers to create, read, update, delete, copy, and rename files. Import the module:

```

const fs = require("fs");

```

### Reading a File

```

const fs = require("fs");
fs.readFile("data.txt", "utf8", (err, data) => {
if (err) throw err;
console.log(data);
});

```

This reads the contents of `data.txt` and displays them in the console.

### Writing to a File

```

const fs = require("fs");
fs.writeFile("data.txt", "Hello Node.js!", (err) => {
if (err) throw err;
console.log("File Created Successfully");
});

```

If the file does not exist, Node.js creates it automatically.

### Common Uses of fs

- Read files

- Write files

- Create files

- Delete files

- Rename files

- Manage directories

The `fs` module is one of the most frequently used modules in Node.js applications.

## Path Module (path)

### What is the path Module?

The **path** module helps developers work with file and directory paths in a safe and platform-independent way. Import the module:

```

const path = require("path");

```

Instead of manually creating file paths, the `path` module ensures they work correctly on Windows, macOS, and Linux.

### Joining Paths

```

const path = require("path");
const filePath = path.join("folder", "images", "photo.jpg");
console.log(filePath);

```

This combines multiple path segments into a single valid path.

### Getting File Extension

```

const path = require("path");
console.log(path.extname("app.js"));

```

Output: `.js`

### Common Uses of path

- Join file paths

- Find file extensions

- Get file names

- Create absolute paths

- Work across different operating systems

Using the `path` module helps avoid errors caused by different path formats.

## Operating System Module (os)

### What is the os Module?

The **os** module provides information about the computer\'s operating system. It allows developers to access system details such as memory, CPU architecture, platform, and user information. Import the module:

```

const os = require("os");

```

### Getting Operating System Information

```

const os = require("os");
console.log(os.platform());

```

Example Output: `win32`

### Getting System Memory

```

const os = require("os");
console.log(os.totalmem());

```

This returns the total amount of system memory in bytes.

### Common Uses of os

- Detect operating system

- Check available memory

- Get CPU information

- Retrieve system architecture

- Access user information

The `os` module is useful when applications need system-specific information.

## Process Module

### What is the process Module?

The **process** module provides information about the currently running Node.js application. It allows developers to access command-line arguments, environment variables, and control the application\'s execution. Unlike other modules, `process` is available globally and does not need to be imported.

### Getting Command-Line Arguments

```

console.log(process.argv);

```

This displays the arguments passed when running the application.

### Getting Environment Information

```

console.log(process.env);

```

This displays the environment variables available to the application.

### Exiting the Program

```

console.log("Program Started");
process.exit();
console.log("Program Ended");

```

After `process.exit()` is executed, the program terminates immediately.

### Common Uses of process

- Access command-line arguments

- Read environment variables

- Exit the application

- Get the current working directory

- Monitor the running process

The `process` module gives developers greater control over how Node.js applications run.

### Advantages of Core Modules

Using Node.js core modules offers several benefits:

- Built into Node.js (no installation required).

- Fast and efficient.

- Reliable and well-tested.

- Simplify common programming tasks.

- Improve application performance.

- Reduce development time.

Core modules are designed to handle essential operations efficiently, making them indispensable in Node.js development.

### Best Practices

To use core modules effectively:

- Import only the modules you need.

- Handle file operation errors using proper error handling.

- Use the `path` module instead of manually writing file paths.

- Protect sensitive information stored in environment variables.

- Avoid unnecessary file operations to improve performance.

Following these practices results in cleaner, safer, and more maintainable applications.

### Conclusion

Core modules are fundamental components of Node.js that provide essential functionality without requiring additional installation. The **fs** module manages files and directories, the **path** module handles file paths across different operating systems, the **os** module retrieves system information, and the **process** module provides control over the running application. Together, these built-in modules simplify development, improve efficiency, and form the foundation of many real-world Node.js applications. Understanding how and when to use these core modules is an important step toward becoming a proficient Node.js developer.');

-- Lecture 5: Node Package Manager (npm) & package.json
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Node Package Manager (npm) & package.json', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Node Package Manager (npm) & package.json

## Introduction to npm and package.json

As software projects grow larger, developers often need additional functionality such as web frameworks, database drivers, authentication tools, and testing libraries. Writing all of these features from scratch would be time-consuming and inefficient. This is where **Node Package Manager (npm)** comes into play. **npm (Node Package Manager)** is the default package manager for Node.js. It allows developers to install, update, remove, and manage thousands of open-source packages that can be easily integrated into Node.js applications. Whenever we create a Node.js project, we also create a **package.json** file. This file acts as the blueprint of the project by storing important information such as the project name, version, dependencies, scripts, and other configuration details. Together, **npm** and **package.json** simplify project management, dependency handling, and collaboration among developers.

## Understanding npm

### What is npm?

npm is a command-line tool that comes automatically with Node.js. It connects developers to a large online registry containing millions of reusable JavaScript packages. Using npm, we can:

- Install external libraries.

- Update existing packages.

- Remove unnecessary packages.

- Manage project dependencies.

- Run project scripts.

- Publish our own packages for others to use.

npm saves development time by allowing developers to reuse reliable, community-built solutions instead of creating everything from scratch.

### Common npm Commands

### Check npm Version

`npm -v` Displays the installed npm version.

### Initialize a New Project

`npm init` This command starts an interactive setup and creates a `package.json` file. To skip the questions and use default values: `npm init -y`

### Install a Package

`npm install express` or `npm i express` This downloads the package and adds it to the project.

### Install Multiple Packages

```

npm install express mongoose dotenv

```

Multiple packages can be installed with a single command.

### Remove a Package

`npm uninstall express` This removes the package from the project and updates `package.json`.

### Update Packages

`npm update` Updates installed packages according to the version rules in `package.json`.

## Understanding package.json

### What is package.json?

The **package.json** file is automatically created when we run: `npm init` It stores essential information about the project and helps npm manage dependencies and project settings. A simple example:

```

{
"name": "student-management-system",
"version": "1.0.0",
"description": "A simple Node.js project",
"main": "app.js",
"scripts": {
"start": "node app.js"
},
"author": "John Doe",
"license": "ISC"
}

```

### Important Fields in package.json

Field Purpose `name` Project name `version` Current version of the project `description` Brief description `main` Entry point of the application `scripts` Commands that can be executed using npm `author` Developer or organization name `license` Project license `dependencies` Required packages for the application These fields help organize and manage a Node.js project effectively.

### Understanding Dependencies

When a package is installed using: `npm install express` npm automatically adds it to the `dependencies` section. Example:

```

"dependencies": {
"express": "^5.0.0"
}

```

Dependencies ensure that anyone working on the project can install the required packages easily.

### The node_modules Folder

Whenever packages are installed, npm creates a folder named: `node_modules/` This folder contains all installed packages and their related files. Because it can become very large, it is usually **not uploaded to GitHub**. Instead, other developers can recreate it by running: `npm install` npm reads the `package.json` file and installs all required dependencies automatically.

## Working with npm Scripts

### What are npm Scripts?

npm scripts are custom commands stored inside the `scripts` section of `package.json`. Example:

```

"scripts": {
"start": "node app.js"
}

```

Instead of typing: `node app.js` We can simply run: `npm start` Scripts make repetitive tasks easier and improve project consistency.

### Common npm Scripts

```

"scripts": {
"start": "node app.js",
"dev": "node app.js",
"test": "echo \\"No tests yet\\""
}

```

Run them using:

```

npm start
npm run dev
npm test

```

Using scripts saves time and standardizes project workflows.

## Best Practices and Advantages

### Best Practices

To manage Node.js projects effectively:

- Always initialize projects using `npm init`.

- Use meaningful project names.

- Keep dependencies updated.

- Remove unused packages.

- Avoid modifying files inside the `node_modules` folder.

- Use `npm install` to restore dependencies instead of copying `node_modules`.

- Keep the `package.json` file organized and up to date.

Following these practices makes projects easier to maintain and collaborate on.

### Advantages of npm and package.json

Using npm and `package.json` provides many benefits:

- Simplifies dependency management.

- Speeds up development with reusable packages.

- Makes collaboration easier.

- Automatically tracks installed libraries.

- Supports custom project scripts.

- Allows easy project setup on different computers.

- Helps maintain consistent project configurations.

These features have made npm one of the largest and most widely used package managers in software development.

### Common Challenges

Although npm is powerful, developers may encounter some challenges:

- Dependency conflicts between packages.

- Large `node_modules` folders consuming disk space.

- Outdated or unsupported packages.

- Security risks from untrusted packages.

These issues can be minimized by using trusted libraries, updating dependencies regularly, and following good project management practices.

### Conclusion

The **Node Package Manager (npm)** is an essential tool in Node.js development, providing access to a vast ecosystem of reusable packages that significantly reduce development time. Alongside npm, the **package.json** file serves as the central configuration file for every Node.js project, storing important information such as project details, dependencies, and scripts. By understanding how to initialize projects, install and manage packages, use npm scripts, and maintain dependencies, we establish a strong foundation for professional Node.js development. Mastering npm and `package.json` enables us to build organized, scalable, and maintainable applications while collaborating efficiently with other developers.');

-- Lecture 6: Building an HTTP Server in Node.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building an HTTP Server in Node.js', 6, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building an HTTP Server in Node.js

## Introduction to HTTP Server

One of the most important uses of Node.js is building **HTTP servers**. Whenever we visit a website, send a request to an API, or load a web page, a server processes the request and sends back a response. Node.js makes it easy to create fast and efficient web servers using its built-in **HTTP module**. An **HTTP (HyperText Transfer Protocol) Server** is a program that listens for client requests, processes them, and returns the appropriate response. Since the HTTP module is a built-in Node.js module, it does not require installation through npm. Think of a restaurant where customers place orders with a waiter. The customer represents the **client**, the waiter represents the **HTTP request**, the kitchen represents the **server**, and the prepared meal represents the **HTTP response**. Similarly, an HTTP server receives requests from clients and returns the requested information.

## Understanding the HTTP Module

### What is the HTTP Module?

The **HTTP module** is a built-in Node.js module used to create web servers and handle HTTP requests and responses. Import the module:

```

const http = require("http");

```

Once imported, we can create a server that listens for incoming client requests.

### Creating a Simple HTTP Server

A basic HTTP server can be created using the `createServer()` method.

```

const http = require("http");
const server = http.createServer((req, res) => {
res.write("Welcome to Node.js!");
res.end();
});
server.listen(3000);

```

After running the program, open a browser and visit: `http://localhost:3000` **Output:** `Welcome to Node.js!` The server listens on **port 3000** and responds whenever a client sends a request.

### Understanding Request and Response Objects

The `createServer()` method provides two important objects:

- **Request (** `req` **)** – Contains information about the client\'s request.

- **Response (** `res` **)** – Used to send data back to the client.

These objects allow the server to receive information and generate appropriate responses.

## Handling Client Requests

### Sending Different Responses

The response object can send different messages to the client.

```

const http = require("http");
res.write("Hello, Student!");
res.end();
});
server.listen(3000);

```

Whenever a client visits the server, the message is displayed in the browser.

### Setting Response Headers

Response headers provide additional information about the data being sent.

```

const http = require("http");
const server = http.createServer((req, res) => {
res.writeHead(200, {
"Content-Type": "text/plain"
});
res.end("Server Running Successfully");
});
server.listen(3000);

```

Here:

- **200** represents a successful HTTP status code.

- **Content-Type** tells the browser the type of data being returned.

### Handling Different URLs

The request object contains the URL requested by the client.

```

const http = require("http");
const server = http.createServer((req, res) => {
if (req.url === "/") {
res.end("Home Page");
} else if (req.url === "/about") {
res.end("About Page");
} else {
res.end("Page Not Found");
}
});
server.listen(3000);

```

This allows a single server to return different responses for different routes.

## Running and Managing the Server

### Starting the Server

The server begins listening using the `listen()` method.

```

server.listen(3000, () => {
console.log("Server Running on Port 3000");
});

```

The callback function executes after the server starts successfully.

### Stopping the Server

The server continues running until it is stopped manually. In the terminal:

- Press **Ctrl + C** to stop the server.

This terminates the running Node.js process.

### Advantages of the HTTP Module

The HTTP module offers several benefits:

- Built into Node.js.

- No external installation required.

- Fast and lightweight.

- Supports asynchronous request handling.

- Suitable for building APIs and web servers.

- Easy to integrate with other Node.js modules.

These advantages make it an excellent choice for backend development.

## Best Practices and Applications

### Best Practices

To build efficient HTTP servers:

- Always send an appropriate HTTP status code.

- Set correct response headers.

- Handle unknown routes gracefully.

- Keep request-handling logic simple.

- Handle server errors properly.

- Organize routes as applications grow.

Following these practices improves application reliability and maintainability.

### Real-World Applications

HTTP servers are widely used in:

- Web applications.

- REST APIs.

- Authentication systems.

- E-commerce websites.

- Content management systems.

- Online banking applications.

- Cloud-based services.

Nearly every modern web application relies on an HTTP server to communicate with clients.

### Common Challenges

While building HTTP servers, developers may face several challenges:

- Handling multiple client requests efficiently.

- Managing routing in large applications.

- Implementing proper error handling.

- Ensuring application security.

- Optimizing server performance.

As applications become larger, frameworks such as **Express.js** are commonly used to simplify server development.

### Conclusion

The **HTTP module** is one of the most important built-in modules in Node.js, enabling developers to create fast and efficient web servers without requiring additional packages. By using methods such as `createServer()` and `listen()`, handling request and response objects, setting response headers, and managing different routes, developers can build the foundation of modern web applications and APIs. Understanding how to build an HTTP server is an essential step in learning backend development and prepares us for more advanced topics such as **Express.js**, routing, middleware, and RESTful API development.');

-- Lecture 7: Callbacks & Callback Hell
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Callbacks & Callback Hell', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Callbacks & Callback Hell

## Introduction to Callbacks

Node.js is designed to perform many tasks at the same time without blocking the execution of a program. To achieve this, it relies heavily on **asynchronous programming**, and one of the earliest techniques used for handling asynchronous operations is the **callback**. A **callback** is a function that is passed as an argument to another function and is executed after a specific task has been completed. Instead of waiting for an operation to finish, Node.js continues executing other code and calls the callback function when the operation is complete. Think of ordering food at a restaurant. After placing your order, you don\'t stand at the counter waiting. Instead, you sit down, and when your food is ready, your name is called. The callback works in the same way—it is executed only after the task is finished. Callbacks are commonly used in file handling, database operations, network requests, and API calls.

## Understanding Callbacks

### What is a Callback Function?

A callback function is simply a function passed as a parameter to another function. Example:

```

function greet(name, callback) {
console.log("Hello " + name);
callback();
}
function goodbye() {
console.log("Goodbye!");
}
greet("Ali", goodbye);

```

**Output:**

```

Hello Ali
Goodbye!

```

In this example, the `goodbye()` function is executed only after the `greet()` function finishes.

### Callbacks in Asynchronous Operations

Callbacks are widely used in Node.js for operations that take time to complete, such as reading files. Example:

```

const fs = require("fs");
fs.readFile("data.txt", "utf8", (err, data) => {
if (err) {
console.log(err);
return;
}
console.log(data);
});

```

Here, the callback function runs only after the file has been successfully read.

## Advantages and Disadvantages of Callbacks

### Advantages of Callbacks

Callbacks offer several benefits:

- Enable asynchronous programming.

- Prevent the application from blocking while waiting for tasks to complete.

- Improve application performance.

- Simple to use for small programs.

- Widely supported in Node.js APIs.

Callbacks make Node.js efficient by allowing multiple operations to run without stopping the entire application.

### Disadvantages of Callbacks

Although useful, callbacks have some drawbacks:

- Difficult to manage in large applications.

- Reduce code readability when deeply nested.

- Error handling becomes complicated.

- Debugging nested callbacks can be challenging.

- Maintenance becomes harder as projects grow.

These limitations led to the introduction of Promises and Async/Await in modern JavaScript.

## Callback Hell

### What is Callback Hell?

**Callback Hell** occurs when multiple callbacks are nested inside one another, creating deeply indented and difficult-to-read code. As more asynchronous operations depend on previous ones, the code becomes harder to understand, debug, and maintain. This nested structure is often called the **"Pyramid of Doom"** because the code visually forms a pyramid shape.

### Example of Callback Hell

```

const fs = require("fs");
fs.readFile("file1.txt", "utf8", (err, data1) => {
if (err) throw err;
fs.readFile("file2.txt", "utf8", (err, data2) => {
if (err) throw err;
fs.readFile("file3.txt", "utf8", (err, data3) => {
if (err) throw err;
console.log(data1);
console.log(data2);
console.log(data3);
});
});
});

```

In this example, each file is read only after the previous one has finished, resulting in multiple levels of nested callbacks.

### Problems with Callback Hell

Callback Hell creates several challenges:

- Excessive code nesting.

- Poor readability.

- Difficult debugging.

- Complicated error handling.

- Reduced maintainability.

- Harder collaboration in team projects.

As applications become larger, Callback Hell becomes increasingly difficult to manage.

## Avoiding Callback Hell

### Using Named Functions

Instead of nesting anonymous callback functions, we can define separate functions. Example:

```

function readFileData(err, data) {
if (err) throw err;
console.log(data);
}
fs.readFile("data.txt", "utf8", readFileData);

```

This approach improves readability and makes the code easier to maintain.

### Using Promises and Async/Await

Modern JavaScript provides **Promises** and **Async/Await** to replace deeply nested callbacks. These approaches make asynchronous code cleaner, more readable, and easier to debug. Although callbacks remain an important concept, Promises and Async/Await are preferred for developing modern Node.js applications.

### Best Practices

To work effectively with callbacks:

- Keep callback functions small and focused.

- Avoid unnecessary nesting.

- Use meaningful function names.

- Handle errors properly.

- Use Promises or Async/Await for complex asynchronous tasks.

- Write modular and organized code.

Following these practices improves code quality and simplifies maintenance.

### Advantages of Understanding Callbacks

Learning callbacks helps developers:

- Understand asynchronous programming.

- Work with built-in Node.js APIs.

- Read and maintain older Node.js projects.

- Build efficient non-blocking applications.

- Transition more easily to Promises and Async/Await.

Callbacks remain a fundamental concept because many existing libraries and applications still use them.

### Conclusion

Callbacks are a fundamental part of asynchronous programming in Node.js, allowing functions to execute after a task has completed without blocking the application. They improve performance and enable efficient handling of operations such as file access, database queries, and network requests. However, excessive nesting of callbacks can lead to **Callback Hell**, making code difficult to read, debug, and maintain. By organizing callback functions properly and adopting modern approaches such as **Promises** and **Async/Await**, developers can write cleaner, more maintainable, and scalable Node.js applications while still understanding the important role callbacks play in asynchronous programming.');

-- Lecture 8: Promises in Node.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Promises in Node.js', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Promises in Node.js

## Introduction to Promises

As Node.js applications perform many tasks asynchronously, managing multiple callbacks can quickly become difficult. Deeply nested callbacks often lead to **Callback Hell**, making code harder to read, debug, and maintain. To solve this problem, JavaScript introduced **Promises**. A **Promise** is an object that represents the eventual completion or failure of an asynchronous operation. Instead of executing a callback immediately, a Promise allows us to handle the result once the operation has either completed successfully or failed. Think of a Promise like ordering a product online. After placing the order, you receive a confirmation that the package will either be delivered or the order will be cancelled. You do not know the result immediately, but you are guaranteed that one of these outcomes will occur. Similarly, a Promise represents a future result. Promises make asynchronous code cleaner, more organized, and easier to understand.

## Understanding Promises

### What is a Promise?

A Promise is a JavaScript object that manages asynchronous operations and eventually returns either a successful result or an error. A Promise has **three possible states**:

- **Pending** – The operation is still in progress.

- **Fulfilled** – The operation completed successfully.

- **Rejected** – The operation failed.

A Promise can only change from **Pending** to either **Fulfilled** or **Rejected**, and once settled, its state cannot change again.

### Creating a Promise

A Promise is created using the `Promise` constructor.

```

const myPromise = new Promise((resolve, reject) => {
let success = true;
if (success) {
resolve("Operation Successful");
} else {
reject("Operation Failed");
}
});

```

Here:

- `resolve()` is called when the operation succeeds.

- `reject()` is called when the operation fails.

## Working with Promises

### Using

`.then()` The `.then()` method is used to handle a successful Promise.

```

myPromise.then((result) => {
console.log(result);
});

```

**Output:** `Operation Successful` The value passed to `resolve()` becomes available inside the `.then()` method.

### Using

`.catch()` The `.catch()` method handles errors when a Promise is rejected.

```

.then((result) => {
console.log(result);
})
.catch((error) => {
console.log(error);
});

```

If the Promise fails, the error is handled by `.catch()`.

### Using

`.finally()` The `.finally()` method executes regardless of whether the Promise is fulfilled or rejected.

```

myPromise
.finally(() => {
console.log("Operation Completed");
});

```

This method is commonly used for cleanup tasks such as closing files or hiding loading indicators.

## Promises in Node.js

### Promises with File System Operations

Modern Node.js provides Promise-based versions of many asynchronous operations.

```

const fs = require("fs").promises;
fs.readFile("data.txt", "utf8")
.then((data) => {
console.log(data);
})
.catch((err) => {
console.log(err);
});

```

This approach is much cleaner than using nested callbacks.

### Promise Chaining

Promises can be connected together using multiple `.then()` methods.

```

myPromise
.then((result) => {
console.log(result);
return "Next Step";
})
.then((message) => {
console.log(message);
})
.catch((error) => {
console.log(error);
});

```

Promise chaining allows multiple asynchronous operations to execute in sequence without creating deeply nested code.

### Advantages Over Callbacks

Compared to callbacks, Promises provide several improvements:

- Cleaner and more readable code.

- Reduced callback nesting.

- Easier error handling.

- Better code organization.

- Improved maintainability.

Because of these benefits, Promises are widely used in modern Node.js development.

## Best Practices and Applications

### Best Practices

To use Promises effectively:

- Always handle errors using `.catch()`.

- Use Promise chaining instead of nested callbacks.

- Keep Promise functions simple and focused.

- Return Promises when chaining multiple operations.

- Use `finally()` for cleanup tasks.

- Prefer Async/Await for complex asynchronous workflows.

These practices result in cleaner and more reliable applications.

### Real-World Applications

Promises are commonly used in:

- Reading and writing files.

- Database operations.

- API requests.

- User authentication.

- Network communication.

- Cloud services.

- Payment processing systems.

Almost every modern Node.js application uses Promises to manage asynchronous operations.

### Advantages of Promises

Using Promises offers many benefits:

- Improve code readability.

- Eliminate Callback Hell.

- Simplify asynchronous programming.

- Provide structured error handling.

- Support chaining of asynchronous operations.

- Form the foundation for Async/Await.

These advantages make Promises an essential feature of modern JavaScript and Node.js.

### Conclusion

Promises provide a modern and efficient way to manage asynchronous operations in Node.js. By representing the future result of an operation, they eliminate many of the problems associated with traditional callbacks, particularly **Callback Hell**. Through methods such as `.then()`, `.catch()`, and `.finally()`, developers can write cleaner, more organized, and easier-to-maintain code while handling both successful and failed operations effectively. Understanding Promises is essential because they serve as the foundation for **Async/Await**, making them one of the most important concepts in modern Node.js development.');

-- Lecture 9: AsyncAwait in Node.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'AsyncAwait in Node.js', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Async/Await in Node.js

## Introduction to Async/Await

As Node.js applications became more complex, developers needed a simpler way to manage asynchronous operations. Although **Promises** solved many problems caused by Callback Hell, long chains of `.then()` and `.catch()` could still make code difficult to read. To make asynchronous programming even more readable and maintainable, JavaScript introduced **Async/Await**. **Async/Await** is a modern syntax built on top of Promises that allows asynchronous code to be written in a way that looks and behaves like synchronous code. It makes programs easier to understand while still taking advantage of Node.js\'s non-blocking architecture. Think of Async/Await as reading a well-organized story instead of following a complex flowchart. The steps are written in a clear, top-to-bottom order, making the code much easier to follow.

## Understanding Async and Await

### What is ?

`async` The `async` keyword is used to declare an asynchronous function. An `async` function always returns a Promise, even if it returns a simple value. Example:

```

async function greet() {
return "Welcome to Node.js!";
}
greet().then((message) => {
console.log(message);
});

```

**Output:** `Welcome to Node.js!` The returned value is automatically wrapped inside a Promise.

### What is ?

`await` The `await` keyword is used inside an `async` function to pause execution until a Promise is completed. Example:

```

function fetchData() {
return Promise.resolve("Data Loaded");
}
async function displayData() {
const result = await fetchData();
console.log(result);
}
displayData();

```

**Output:** `Data Loaded` The `await` keyword makes asynchronous code appear sequential and easier to understand.

## Using Async/Await in Node.js

### Reading a File Using Async/Await

The Promise-based File System module can be used with Async/Await.

```

const fs = require("fs").promises;
async function readFile() {
const data = await fs.readFile("data.txt", "utf8");
console.log(data);
}
readFile();

```

This code performs the same task as a Promise chain but with cleaner and more readable syntax.

### Handling Errors with try...catch

Since asynchronous operations can fail, we use `try...catch` to handle errors.

```

const fs = require("fs").promises;
async function readFile() {
try {
const data = await fs.readFile("data.txt", "utf8");
console.log(data);
} catch (err) {
console.log(err.message);
}
}
readFile();

```

Using `try...catch` makes error handling simple and keeps the program from crashing unexpectedly.

## Advantages of Async/Await

### Benefits of Async/Await

Async/Await offers several advantages over callbacks and Promise chains:

- Cleaner and more readable code.

- Eliminates Callback Hell.

- Reduces long `.then()` chains.

- Simplifies error handling with `try...catch`.

- Makes asynchronous code easier to debug.

- Improves code maintainability.

Because of these benefits, Async/Await has become the preferred approach for handling asynchronous operations in modern Node.js applications.

### Async/Await vs Promises

Feature Promises Async/Await Syntax `.then()` and `.catch() async` and `await` Readability Good Excellent Error Handling `.catch() try...catch` Code Structure Chain-based Sequential Ease of Maintenance Moderate High Both approaches are powerful, but Async/Await provides a cleaner and more natural coding style.

## Best Practices and Applications

To use Async/Await effectively:

- Use `await` only inside `async` functions.

- Always handle errors using `try...catch`.

- Keep asynchronous functions focused on a single task.

- Avoid unnecessary `await` statements.

- Use meaningful function names.

- Write clean and modular code.

Following these practices improves application quality and maintainability.

### Real-World Applications

Async/Await is widely used in modern Node.js applications for:

- Reading and writing files.

- Database operations.

- REST API requests.

- User authentication.

- Cloud services.

- Payment processing.

- Data processing and automation.

It is one of the most commonly used features in backend development because it makes asynchronous programming simple and efficient.

### Advantages of Learning Async/Await

Understanding Async/Await helps developers:

- Write cleaner and more readable code.

- Build scalable Node.js applications.

- Handle asynchronous operations efficiently.

- Debug applications more easily.

- Work effectively with modern JavaScript frameworks and libraries.

Mastering Async/Await is an important step toward becoming a professional Node.js developer.

### Conclusion

**Async/Await** is a modern feature in JavaScript that simplifies asynchronous programming by allowing developers to write asynchronous code in a clear and sequential manner. Built on top of Promises, it improves readability, reduces Callback Hell, and provides straightforward error handling through `try...catch`. Throughout these notes, we explored the concepts of `async` and `await`, learned how to perform asynchronous file operations, compared Async/Await with Promises, and discussed its advantages and best practices. By mastering Async/Await, developers can build cleaner, more maintainable, and efficient Node.js applications, making it an essential concept in modern backend development.');

-- Lecture 10: Event Loop & Event-Driven Programming in Node.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Event Loop & Event-Driven Programming in Node.js', 10, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Event Loop & Event-Driven Programming in Node.js

## Introduction to Event Loop & Event-Driven Programming

One of the main reasons behind the speed and efficiency of Node.js is its **Event Loop** and **Event-Driven Programming** model. Unlike traditional server-side technologies that create multiple threads for handling requests, Node.js uses a **single-threaded, non-blocking architecture** to process many tasks simultaneously. The **Event Loop** is the mechanism that allows Node.js to perform asynchronous operations without blocking the execution of the program. It continuously checks whether completed tasks are ready to be processed and executes their associated callback functions. **Event-Driven Programming** is a programming style in which the flow of a program is controlled by events such as user actions, file operations, timers, or network requests. Instead of executing tasks one after another, the application responds whenever an event occurs. Think of a restaurant where one waiter serves many tables. Rather than waiting beside one customer until the food is ready, the waiter takes several orders and returns whenever each meal is prepared. Similarly, Node.js efficiently manages multiple operations through its event-driven architecture.

## Understanding the Event Loop

### What is the Event Loop?

The **Event Loop** is the core mechanism of Node.js that manages asynchronous operations. It continuously monitors the **Callback Queue** and moves completed tasks to the **Call Stack** when it becomes available. This allows Node.js to execute multiple operations efficiently without creating a separate thread for every request. The basic workflow is: 1. Execute synchronous code. 2. Send asynchronous tasks to the system. 3. Continue executing other code. 4. Place completed tasks in the Callback Queue. 5. The Event Loop moves callbacks to the Call Stack for execution. This process repeats continuously while the application is running.

### How the Event Loop Works

Consider the following example:

```

console.log("Start");
setTimeout(() => {
console.log("Inside Timer");
}, 2000);
console.log("End");

```

**Output:**

```

Start
End
Inside Timer

```

Although the `setTimeout()` function appears before the last `console.log()`, Node.js does not wait for the timer to finish. Instead, it continues executing the remaining synchronous code, and the callback runs later when the timer expires. This demonstrates the non-blocking nature of the Event Loop.

## Understanding Event-Driven Programming

### What is Event-Driven Programming?

**Event-Driven Programming** is a programming paradigm in which the execution of code depends on events. Whenever an event occurs, a corresponding function, known as an **event handler** or **listener**, is executed. Common events include:

- File operations

- HTTP requests

- User input

- Timers

- Database operations

- Network communication

This approach enables applications to remain responsive while handling multiple operations.

### The EventEmitter Class

Node.js provides the **EventEmitter** class through the `events` module to create and manage custom events. Example:

```

const EventEmitter = require("events");
const eventEmitter = new EventEmitter();
eventEmitter.on("greet", () => {
console.log("Welcome to Node.js!");
});
eventEmitter.emit("greet");

```

**Output:** `Welcome to Node.js!` In this example:

- `on()` registers an event listener.

- `emit()` triggers the event.

### Passing Data with Events

Events can also pass data to listeners.

```

const EventEmitter = require("events");
const eventEmitter = new EventEmitter();
eventEmitter.on("student", (name) => {
console.log("Welcome", name);
});
eventEmitter.emit("student", "Ali");

```

**Output:** `Welcome Ali` Passing data makes events more flexible and useful in real-world applications.

## Advantages of Event-Driven Programming

### Benefits of the Event Loop

The Event Loop offers several advantages:

- Supports non-blocking execution.

- Handles multiple requests efficiently.

- Improves application performance.

- Uses fewer system resources.

- Provides high scalability.

These advantages make Node.js suitable for applications with many simultaneous users.

### Benefits of Event-Driven Programming

Event-Driven Programming provides many benefits:

- Improves responsiveness.

- Simplifies asynchronous programming.

- Encourages modular code.

- Makes applications more scalable.

- Enables efficient handling of multiple events.

Because of these benefits, many Node.js applications rely heavily on events.

### Real-World Applications

The Event Loop and Event-Driven Programming are commonly used in:

- Web servers.

- Chat applications.

- Real-time messaging systems.

- Online gaming.

- Streaming services.

- File upload systems.

- API servers.

These applications require fast responses and efficient handling of multiple users.

## Best Practices and Common Challenges

### Best Practices

To use the Event Loop and Event-Driven Programming effectively:

- Avoid blocking the Event Loop with CPU-intensive tasks.

- Keep event handlers short and efficient.

- Handle errors properly within event listeners.

- Use meaningful event names.

- Remove unused event listeners to prevent memory leaks.

- Organize events logically for better maintainability.

Following these practices helps build reliable and scalable applications.

### Common Challenges

Although powerful, developers may encounter some challenges:

- Blocking the Event Loop with long-running tasks.

- Memory leaks caused by unused event listeners.

- Debugging asynchronous code.

- Managing many events in large applications.

Understanding these challenges helps developers write more efficient Node.js programs.

### Conclusion

The **Event Loop** and **Event-Driven Programming** are fundamental concepts that make Node.js fast, efficient, and scalable. The Event Loop allows asynchronous operations to execute without blocking the application, while Event-Driven Programming enables applications to respond to events such as file operations, timers, network requests, and user interactions. By understanding how the Event Loop works, using the **EventEmitter** class, and following best practices, developers can build responsive, high-performance Node.js applications capable of handling many concurrent operations with minimal resource usage.');

-- Lecture 11: File System Operations in Node.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'File System Operations in Node.js', 11, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# File System Operations in Node.js

## Introduction to File System Operations

Almost every application works with files in some way. A banking application stores customer records, a social media platform saves user information, and a blog website manages articles and images. To perform these tasks, Node.js provides the **File System (fs) module**. The **File System (fs)** module is a built-in Node.js module that allows developers to create, read, update, delete, copy, rename, and manage files and directories. Since it is a core module, it comes pre-installed with Node.js and does not require installation through npm. File system operations are essential because they enable applications to store, retrieve, and manage data efficiently.

## Understanding the File System (fs) Module

### What is the fs Module?

The **fs (File System)** module provides methods for interacting with the file system of the operating system. It supports both **asynchronous** and **synchronous** operations. Import the module:

```

const fs = require("fs");

```

Once imported, we can perform various file and directory operations.

### Asynchronous vs Synchronous Operations

Node.js provides two ways to perform file operations.

### Asynchronous Operations

These operations execute without blocking the program. While a file operation is being completed, Node.js can continue executing other tasks. Example:

```

const fs = require("fs");
fs.readFile("data.txt", "utf8", (err, data) => {
if (err) throw err;
console.log(data);
});

```

Asynchronous methods are recommended because they improve application performance.

### Synchronous Operations

These operations block the program until the task is completed. Example:

```

const fs = require("fs");
const data = fs.readFileSync("data.txt", "utf8");
console.log(data);

```

Synchronous methods are mainly used in small scripts or when blocking behavior is acceptable.

## Common File Operations

### Reading a File

The `readFile()` method reads the contents of a file.

```

const fs = require("fs");
fs.readFile("data.txt", "utf8", (err, data) => {
if (err) throw err;
console.log(data);
});

```

This method is commonly used to retrieve stored information from files.

### Writing to a File

The `writeFile()` method creates a new file or overwrites an existing one.

```

const fs = require("fs");
fs.writeFile("data.txt", "Welcome to Node.js!", (err) => {
if (err) throw err;
console.log("File Written Successfully");
});

```

If the file does not exist, it is created automatically.

### Appending Data to a File

The `appendFile()` method adds new content without removing the existing data.

```

const fs = require("fs");
fs.appendFile("data.txt", "\\nLearning Node.js", (err) => {
if (err) throw err;
console.log("Data Appended");
});

```

This is useful for logs, reports, and records that grow over time.

### Deleting a File

The `unlink()` method removes a file.

```

const fs = require("fs");
fs.unlink("data.txt", (err) => {
if (err) throw err;
console.log("File Deleted");
});

```

Deleting unnecessary files helps keep the file system organized.

### Renaming a File

The `rename()` method changes the name of a file.

```

const fs = require("fs");
fs.rename("old.txt", "new.txt", (err) => {
if (err) throw err;
console.log("File Renamed");
});

```

Renaming files is useful for organizing and managing project resources.

## Directory Operations

### Creating a Directory

The `mkdir()` method creates a new folder.

```

const fs = require("fs");
fs.mkdir("Projects", (err) => {
if (err) throw err;
console.log("Directory Created");
});

```

### Reading a Directory

The `readdir()` method displays the contents of a folder.

```

const fs = require("fs");
fs.readdir("./", (err, files) => {
if (err) throw err;
console.log(files);
});

```

This returns an array containing all files and folders in the specified directory.

### Removing a Directory

The `rmdir()` method removes an empty directory.

```

const fs = require("fs");
fs.rmdir("Projects", (err) => {
if (err) throw err;
console.log("Directory Removed");
});

```

This operation helps manage unnecessary folders.

## Best Practices and Applications

### Error Handling

File operations may fail due to missing files, incorrect paths, or permission issues. Proper error handling ensures the application does not crash unexpectedly. Example:

```

const fs = require("fs");
fs.readFile("data.txt", "utf8", (err, data) => {
if (err) {
console.log("Error:", err.message);
return;
}
console.log(data);
});

```

Handling errors improves application reliability and user experience.

### Real-World Applications

File system operations are used in many applications:

- Saving user data.

- Managing configuration files.

- Uploading and storing images.

- Reading log files.

- Creating reports.

- Managing project resources.

- Processing documents and media files.

Almost every backend application uses file system operations in some form.

### Best Practices

To work efficiently with the File System module:

- Prefer asynchronous methods for better performance.

- Always handle file operation errors.

- Use meaningful file and folder names.

- Avoid overwriting important files accidentally.

- Organize files into appropriate directories.

- Validate file paths before performing operations.

Following these practices results in secure and maintainable applications.

### Advantages of File System Operations

Using the File System module provides several benefits:

- Built into Node.js (no installation required).

- Fast and efficient.

- Supports both asynchronous and synchronous operations.

- Simplifies file and directory management.

- Enables data storage without external databases for small applications.

- Essential for backend development and automation.

These advantages make the `fs` module one of the most widely used core modules in Node.js.

### Conclusion

The **File System (fs) module** is one of the most important built-in modules in Node.js, providing developers with powerful tools to manage files and directories. Through operations such as reading, writing, appending, deleting, renaming files, and creating or managing directories, developers can build applications that efficiently store and retrieve data. The module supports both asynchronous and synchronous methods, allowing flexibility based on application requirements. By understanding file system operations and following best practices such as proper error handling and organized file management, we can develop reliable, efficient, and scalable Node.js applications.');

-- Lecture 12: Streams & Buffers in Node.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Streams & Buffers in Node.js', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Streams & Buffers in Node.js

## Introduction to Streams & Buffers

In many Node.js applications, we work with large amounts of data such as videos, images, audio files, and documents. Loading an entire file into memory before processing it can consume a large amount of system resources and reduce application performance. To solve this problem, Node.js provides **Streams** and **Buffers**. A **Buffer** is a temporary area in memory used to store binary data before it is processed. A **Stream** is a mechanism that allows data to be processed piece by piece instead of loading the entire data into memory at once. Think of filling a swimming pool with a bucket versus using a water pipe. Carrying buckets represents loading the entire file into memory, while the pipe represents a stream that continuously delivers water. Streams make data transfer faster and more memory-efficient. Streams and Buffers are widely used in file handling, media streaming, network communication, and data processing.

## Understanding Buffers

### What is a Buffer?

A **Buffer** is a temporary memory area that stores raw binary data. It is commonly used when working with files, network requests, or data streams. Buffers allow Node.js to process binary data efficiently before it is written, transmitted, or displayed.

### Creating a Buffer

A Buffer can be created using the `Buffer` class.

```

const buffer = Buffer.from("Hello Node.js");
console.log(buffer);

```

**Output:**

```

<Buffer 48 65 6c 6c 6f 20 4e 6f 64 65 2e 6a 73>

```

The output represents the binary form of the text.

### Converting a Buffer to a String

```

const buffer = Buffer.from("Hello Node.js");
console.log(buffer.toString());

```

**Output:** `Hello Node.js` The `toString()` method converts binary data back into readable text.

### Uses of Buffers

Buffers are commonly used for:

- File handling.

- Image processing.

- Audio and video processing.

- Network communication.

- Binary data storage.

Buffers act as temporary storage before data is processed.

## Understanding Streams

### What is a Stream?

A **Stream** is a continuous flow of data that allows information to be processed in small chunks instead of all at once. Streams improve performance because they reduce memory usage and begin processing data immediately without waiting for the entire file. Node.js provides four main types of streams.

### Types of Streams

- **Readable Stream** – Reads data.

- **Writable Stream** – Writes data.

- **Duplex Stream** – Performs both reading and writing.

- **Transform Stream** – Modifies data while reading or writing.

Each type serves a different purpose depending on the application\'s requirements.

### Reading a File Using Streams

```

const fs = require("fs");
const readStream = fs.createReadStream("data.txt", "utf8");
readStream.on("data", (chunk) => {
console.log(chunk);
});

```

Instead of loading the complete file into memory, the file is read one chunk at a time.

### Writing to a File Using Streams

```

const fs = require("fs");
const writeStream = fs.createWriteStream("output.txt");
writeStream.write("Welcome to Node.js!");
writeStream.end();

```

This writes data directly into the file using a writable stream.

## Working with Streams

### Piping Streams

Node.js allows one stream to be connected directly to another using the `pipe()` method. Example:

```

const fs = require("fs");
const readStream = fs.createReadStream("input.txt");
const writeStream = fs.createWriteStream("output.txt");
readStream.pipe(writeStream);

```

The `pipe()` method transfers data from the readable stream to the writable stream automatically.

### Advantages of Streams

Streams provide several benefits:

- Process large files efficiently.

- Reduce memory consumption.

- Improve application performance.

- Start processing data immediately.

- Suitable for real-time applications.

Because of these advantages, streams are widely used in backend development.

### Real-World Applications

Streams are commonly used in:

- Video streaming platforms.

- Music streaming services.

- File uploads and downloads.

- Live chat applications.

- Network communication.

- Data processing systems.

Applications that transfer large amounts of data rely heavily on streams.

## Best Practices and Benefits

### Best Practices

To work effectively with Streams and Buffers:

- Use streams for large files instead of reading entire files into memory.

- Handle stream errors properly.

- Close streams after use.

- Use `pipe()` whenever possible to simplify stream operations.

- Process data in manageable chunks.

- Avoid unnecessary memory allocation.

Following these practices improves application performance and reliability.

### Advantages of Streams & Buffers

Using Streams and Buffers offers many benefits:

- Efficient memory usage.

- Faster data processing.

- Better performance for large files.

- Support for binary data.

- Improved scalability.

- Essential for real-time applications.

These features make Streams and Buffers fundamental components of Node.js.

### Common Challenges

Although Streams and Buffers are powerful, developers may encounter some challenges:

- Managing stream errors.

- Understanding binary data.

- Handling large numbers of simultaneous streams.

- Ensuring proper stream closure to avoid resource leaks.

With proper error handling and coding practices, these challenges can be managed effectively.

### Conclusion

**Streams** and **Buffers** are essential features of Node.js that enable efficient handling of data. Buffers temporarily store binary data in memory, while Streams process data in small chunks, reducing memory usage and improving application performance. Together, they make it possible to work with large files, media content, network communication, and real-time applications efficiently. By understanding the different types of streams, using buffers appropriately, and following best practices, developers can build fast, scalable, and memory-efficient Node.js applications.');

-- Lecture 13: Error Handling in Node.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Error Handling in Node.js', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Error Handling in Node.js

## Introduction to Error Handling

No matter how carefully we write our code, errors are inevitable. A file may not exist, a database connection may fail, or a user may provide invalid input. If these errors are not handled properly, the application may crash or behave unexpectedly. This is why **Error Handling** is an essential part of Node.js development. **Error Handling** is the process of detecting, managing, and responding to errors so that an application can continue running safely or provide meaningful feedback to the user. Think of driving a car. Even the best drivers prepare for unexpected situations by wearing seat belts and using brakes. Similarly, error handling acts as a safety mechanism that helps our applications recover from unexpected problems. Proper error handling improves application reliability, stability, and user experience.

## Types of Errors in Node.js

### What are Errors?

An **error** is an unexpected event that interrupts the normal execution of a program. Errors can occur due to programming mistakes, invalid user input, missing files, network failures, or system issues. Some common types of errors include:

- Syntax Errors

- Runtime Errors

- Logical Errors

- System Errors

Understanding different types of errors helps developers identify problems and apply appropriate solutions.

### Syntax Errors

Syntax errors occur when the JavaScript code violates language rules. Example: `console.log("Hello"` The missing closing parenthesis causes a syntax error, preventing the program from running.

### Runtime Errors

Runtime errors occur while the program is executing. Example:

```

const fs = require("fs");
fs.readFile("missing.txt", "utf8", (err, data) => {
if (err)
console.log(err.message);
});

```

If the file does not exist, Node.js generates a runtime error.

### Logical Errors

Logical errors occur when the program runs successfully but produces incorrect results. Example:

```

let total = 10 - 5;
console.log(total);

```

If the intention was to add the numbers instead of subtracting them, the program contains a logical error.

## Handling Errors

### Using try...catch

The `try...catch` statement is used to handle errors that occur during program execution. Example:

```

try {
let result = 10 / 0;
console.log(result);
} catch (error) {
console.log(error.message);
}

```

If an error occurs inside the `try` block, execution immediately moves to the `catch` block.

### Throwing Custom Errors

Developers can create their own errors using the `throw` statement. Example:

```

function checkAge(age) {
if (age < 18) {
throw new Error("Age must be 18 or above.");
}
console.log("Access Granted");
}
try {
checkAge(15);
} catch (error) {
console.log(error.message);
}

```

Custom errors help validate user input and enforce business rules.

### Handling Errors in Asynchronous Code

Asynchronous operations often return errors through callback functions. Example:

```

const fs = require("fs");
fs.readFile("data.txt", "utf8", (err, data) => {
if (err) {
console.log(err.message);
return;
}
console.log(data);
});

```

Always checking for errors before using the returned data prevents unexpected application failures.

## Error Handling with Promises and Async/Await

### Handling Errors with Promises

Promises use the `.catch()` method to handle errors.

```

const fs = require("fs").promises;
fs.readFile("data.txt", "utf8")
.then((data) => {
console.log(data);
})
.catch((error) => {
console.log(error.message);
});

```

The `.catch()` method captures any errors that occur during the Promise execution.

### Handling Errors with Async/Await

When using Async/Await, errors are handled using `try...catch`.

```

const fs = require("fs").promises;
async function readFile() {
try {
const data = await fs.readFile("data.txt", "utf8");
console.log(data);
} catch (error) {
console.log(error.message);
}
}
readFile();

```

This approach provides clean and readable error handling for asynchronous operations.

## Best Practices and Benefits

### Best Practices

To handle errors effectively:

- Always use proper error handling in your applications.

- Display meaningful error messages.

- Validate user input before processing it.

- Use `try...catch` with Async/Await.

- Handle Promise rejections using `.catch()`.

- Avoid exposing sensitive system information in error messages.

- Log errors for debugging purposes.

Following these practices helps build reliable and secure applications.

### Advantages of Proper Error Handling

Proper error handling provides several benefits:

- Prevents application crashes.

- Improves user experience.

- Simplifies debugging.

- Makes applications more reliable.

- Enhances application security.

- Helps identify problems quickly.

These advantages make error handling an essential part of professional software development.

### Real-World Applications

Error handling is used in almost every Node.js application, including:

- File management systems.

- Database applications.

- REST APIs.

- Authentication systems.

- E-commerce websites.

- Banking applications.

- Cloud-based services.

Without proper error handling, these applications could fail unexpectedly and provide a poor user experience.

### Conclusion

**Error Handling** is a fundamental concept in Node.js that ensures applications remain stable, secure, and reliable even when unexpected problems occur. By understanding different types of errors, using `try...catch`, throwing custom errors, handling asynchronous errors through callbacks, Promises, and Async/Await, and following best practices, developers can build applications that respond gracefully to failures instead of crashing. Mastering error handling not only improves code quality but also creates a better experience for users, making it an essential skill for every Node.js developer.');

-- Lecture 14: Building a Node.js CLI Application
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a Node.js CLI Application', 14, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a Node.js CLI Application

## Introduction to Node.js CLI Applications

A **Command-Line Interface (CLI) Application** is a program that runs in the terminal or command prompt, allowing users to interact with it by typing commands instead of using a graphical interface. Many popular developer tools, such as Git, npm, and Node.js itself, are CLI applications. Node.js is an excellent platform for building CLI applications because it is fast, lightweight, and provides access to built-in modules for handling user input, files, and system operations. Think of a CLI application as having a conversation with your computer. Instead of clicking buttons, you type commands, and the application responds with the requested output. CLI applications are commonly used for automation, project management, file processing, and developer tools.

## Creating a Simple CLI Application

### Project Setup

Create a new project folder and initialize it with npm.

```

mkdir my-cli-app
cd my-cli-app
npm init -y

```

Create a file named **app.js**.

### Printing Output

The simplest CLI application displays a message in the terminal.

```

console.log("Welcome to My Node.js CLI Application!");

```

Run the application: `node app.js` **Output:**

```

Welcome to My Node.js CLI Application!

```

This is the basic structure of every Node.js CLI program.

### Reading Command-Line Arguments

Node.js provides the `process.argv` property to access values entered by the user.

```

const name = process.argv[2];
console.log("Hello,", name);

```

Run the program: `node app.js Ali` **Output:** `Hello, Ali` The first two elements of `process.argv` contain the Node.js executable and the file name, while the remaining elements contain the user\'s input.

## Building a Simple CLI Project

### Creating a Calculator CLI

We can create a simple calculator that accepts two numbers and an operator.

```

const num1 = Number(process.argv[2]);
const operator = process.argv[3];
const num2 = Number(process.argv[4]);
let result;
switch (operator) {
case "+":
result = num1 + num2;
break;
case "-":
result = num1 - num2;
break;
case "*":
result = num1 * num2;
break;
case "/":
result = num1 / num2;
break;
default:
console.log("Invalid Operator");
process.exit();
}
console.log("Result:", result);

```

Run the program: `node app.js 10 + 5` **Output:** `Result: 15` This demonstrates how CLI applications can process user input and perform useful tasks.

### Validating User Input

Always check whether the user has entered valid data.

```

if (isNaN(num1) || isNaN(num2)) {
console.log("Please enter valid numbers.");
process.exit();
}

```

Input validation prevents unexpected errors and improves the user experience.

## Useful Features for CLI Applications

### Using Core Modules

CLI applications often use Node.js core modules such as:

- **fs** – Read and write files.

- **path** – Handle file paths.

- **os** – Access operating system information.

- **process** – Read command-line arguments and control the application.

These modules help developers build powerful command-line tools without installing additional packages.

### Handling Errors

Use `try...catch` or validation checks to prevent the application from crashing.

```

try {
console.log("Application Running...");
console.log(error.message);
}

```

Proper error handling makes CLI applications more reliable.

### Real-World CLI Applications

Node.js CLI applications are used for:

- Project generators.

- File management tools.

- Automation scripts.

- Build tools.

- Code formatters.

- Package managers.

- System utilities.

Many tools developers use every day are built as CLI applications.

## Best Practices and Benefits

### Best Practices

To build effective CLI applications:

- Keep commands simple and easy to remember.

- Validate all user input.

- Display meaningful error messages.

- Organize code into modules.

- Handle unexpected errors properly.

- Write clear documentation for commands.

Following these practices results in applications that are easier to use and maintain.

### Advantages of CLI Applications

Building CLI applications offers several benefits:

- Fast execution.

- Low resource usage.

- Easy automation.

- Ideal for repetitive tasks.

- Improve developer productivity.

- Easy to distribute and maintain.

Because of these advantages, CLI applications remain an important part of modern software development.

### Common Challenges

While developing CLI applications, developers may face some challenges:

- Handling invalid user input.

- Managing command-line arguments.

- Providing helpful error messages.

- Organizing larger CLI projects.

- Ensuring compatibility across different operating systems.

Understanding these challenges helps developers create more user-friendly command-line tools.

### Conclusion

A **Node.js CLI Application** allows users to interact with a program through the command line instead of a graphical interface. By using `process.argv`, developers can accept user input, process commands, and build useful tools such as calculators, automation scripts, file managers, and project generators. Combined with Node.js core modules like **fs**, **path**, **os**, and **process**, CLI applications become powerful, lightweight, and efficient. By following best practices such as input validation, proper error handling, and modular code organization, developers can create reliable and professional command-line tools that simplify everyday development tasks.');
