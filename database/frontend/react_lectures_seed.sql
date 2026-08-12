-- =============================================
-- ReflectAI — React Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'React' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to React
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to React', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to React

## What is React?

### Definition of React

React is an **open-source JavaScript library** used for building user interfaces, especially for web applications that require dynamic and interactive content. It focuses only on the **View layer** of the MVC (Model-View-Controller) architecture. Unlike traditional web development where every page change requires loading a new HTML page from the server, React updates only the parts of the webpage that have changed. This results in a smoother and faster user experience.

### Key Characteristics

- Open-source JavaScript library

- Developed and maintained by Meta (Facebook)

- Component-based architecture

- Uses a Virtual DOM

- Supports reusable UI components

- Ideal for Single Page Applications (SPAs)

### History of React

React was created by **Jordan Walke**, a software engineer at Facebook, in **2011**. It was initially used within Facebook before being released as an open-source project in **2013**. Since then, React has become one of the most widely adopted frontend technologies. Companies like Netflix, Instagram, Airbnb, WhatsApp Web, and many others use React to build highly interactive applications.

## Why Do We Use React?

Before React, developers often struggled to manage large web applications using plain JavaScript. Updating different parts of a webpage manually became difficult as applications grew. React solves these challenges by making UI development easier and more organized.

### Advantages of React

### 1. Reusable Components

Instead of writing the same code repeatedly, we create a component once and reuse it wherever needed. **Example:** A button component can be used across multiple pages without rewriting its code.

### 2. Fast Performance

React uses the **Virtual DOM**, which compares changes before updating the actual webpage. This minimizes unnecessary rendering and improves speed.

### 3. Easy to Learn

Anyone with basic knowledge of HTML, CSS, and JavaScript can start learning React relatively quickly.

### 4. Strong Community Support

Millions of developers contribute tutorials, libraries, tools, and solutions, making React beginner-friendly.

### 5. Better Code Organization

Large applications become easier to manage because each feature is separated into independent components.

## Core Concepts of React

### 1. Components

A component is an independent, reusable piece of the user interface. Imagine building a house.

- Door = Component

- Window = Component

- Roof = Component

- Kitchen = Component

Together they create the complete house. Similarly, React applications consist of multiple components.

### Types of Components

### Functional Components

These are simple JavaScript functions that return JSX.

```

function Welcome() {
return <h1>Hello World!</h1>;
}

```

Functional components are the modern standard in React.

### Class Components

Earlier versions of React used class-based components.

```

class Welcome extends React.Component {
render() {
return <h1>Hello World!</h1>;
}
}

```

Although still supported, functional components with Hooks are now preferred.

### 2. JSX (JavaScript XML)

JSX allows us to write HTML-like syntax inside JavaScript. Example:

```

const element = <h1>Welcome to React</h1>;

```

Instead of writing:

```

React.createElement("h1", null, "Welcome to React");

```

JSX makes the code easier to read and write.

### Benefits of JSX

- Simple syntax

- Easy debugging

- Combines HTML and JavaScript

- Improves readability

### 3. Virtual DOM

The DOM (Document Object Model) represents the webpage structure. Normally, changing the DOM directly is slow. React introduces a **Virtual DOM**, which is a lightweight copy of the real DOM.

### Working Process

1. User performs an action. 2. React updates the Virtual DOM. 3. React compares the old and new Virtual DOM. 4. Only changed elements are updated in the real DOM. This process is called **Reconciliation**.

### 4. Props

Props (Properties) are used to pass data from a parent component to a child component. Example:

```

function Welcome(props) {
return <h1>Hello {props.name}</h1>;
}
<Welcome name="Ali" />

```

Output: `Hello Ali`

### Characteristics of Props

- Read-only

- Passed from parent to child

- Used for communication between components

### 5. State

State stores data that can change over time. Example:

```

const [count, setCount] = useState(0);

```

Whenever the state changes, React automatically updates the user interface. Examples include:

- Counter value

- Login status

- Shopping cart items

- Form inputs

## React Features

### Component-Based Architecture

React divides the UI into small, independent components. Benefits include:

- Easier maintenance

- Better testing

- Improved code reuse

### One-Way Data Binding

Data flows from parent components to child components. This makes debugging easier because developers always know where the data originates.

### Declarative Programming

Instead of telling React **how** to update the interface step by step, we simply describe **what** the interface should look like. Example:

```

return <h1>Welcome</h1>;

```

React handles the rest automatically.

### React Hooks

Hooks allow functional components to use features like state and lifecycle methods. Common Hooks include:

- useState()

- useEffect()

- useContext()

- useReducer()

- useRef()

Example:

```

const [name, setName] = useState("");

```

### Fast Rendering

Through the Virtual DOM and efficient rendering techniques, React minimizes unnecessary updates and delivers better performance.

## Setting Up a React Project

There are several ways to create a React project.

### Using Vite (Recommended)

Install Node.js first. Create a project:

```

npm create vite@latest my-app

```

Move into the project: `cd my-app` Install dependencies: `npm install` Run the development server: `npm run dev`

### Project Structure

A basic React project usually contains:

```

my-app/
│
├── node_modules/
├── public/
├── src/
│ ├── App.jsx
│ ├── main.jsx
│ ├── components/
│
├── package.json
└── vite.config.js

```

### Important Files

### main.jsx

The entry point of the application.

```

import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
ReactDOM.createRoot(document.getElementById("root")).render(
<App />
);

```

### App.jsx

The main component.

```

function App() {
return (
<h1>Welcome to React!</h1>
);
}
export default App;

```

### Simple React Example

```

function Greeting() {
return (
<div>
<h1>Hello Students!</h1>
<p>Welcome to React.</p>
</div>
);
}
export default Greeting;

```

Output:

```

Hello Students!
Welcome to React.

```

### React vs Traditional JavaScript

| Feature | Traditional JavaScript | React |
|---|---|---|
| UI Updates | Manual | Automatic |
| Code Reusability | Limited | High |
| Performance | Slower for large apps | Faster with Virtual DOM |
| Components | Not Built-in | Component-Based |
| Maintenance | Difficult | Easier |
| Learning Curve | Moderate | Easy with JavaScript knowledge |

### Real-World Applications of React

React is used in a wide range of industries because of its flexibility and performance. Some common applications include:

- Social media platforms

- E-commerce websites

- Online learning portals

- Banking dashboards

- Hospital management systems

- Portfolio websites

- News portals

- Chat applications

- Project management tools

- Customer relationship management (CRM) systems

### Best Practices for Beginners

- Learn HTML, CSS, and JavaScript before React.

- Build small projects to strengthen your understanding.

- Break large interfaces into reusable components.

- Keep components simple and focused on a single task.

- Use meaningful variable and component names.

- Practice using Hooks such as `useState()` and `useEffect()`.

- Organize files into folders for better maintainability.

- Write clean, readable, and reusable code.

### Conclusion

React has transformed the way we build modern web applications by introducing a component-based approach, reusable code, and efficient rendering through the Virtual DOM. Instead of managing complex user interfaces manually, we can focus on creating small, independent components that work together seamlessly. Its simplicity, excellent performance, and strong community support make it an ideal choice for both beginners and professional developers. As we continue learning React, concepts such as components, JSX, props, state, hooks, and routing will enable us to build increasingly powerful, scalable, and interactive web applications with confidence.');

-- Lecture 2: Setting Up a React Project
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Setting Up a React Project', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Setting Up a React Project

React is one of the most popular JavaScript libraries for building modern web applications. Before we can start creating components or designing user interfaces, we need to set up a React development environment. Fortunately, modern tools have made this process simple and efficient. In these lecture notes, we will learn how to install the required software, create a React project, understand its folder structure, and run the application successfully.

## Prerequisites for React Development

Before creating a React project, we need a few essential tools installed on our computer.

### 1. Install Node.js

React applications use **Node.js** to manage packages and run development tools. Node.js includes **npm (Node Package Manager)**, which allows us to install React and other libraries.

### Steps to Install Node.js

1. Visit the official Node.js website. 2. Download the **LTS (Long-Term Support)** version. 3. Run the installer and follow the setup wizard. 4. Restart your computer if required.

### Verify Installation

Open the terminal or command prompt and type: `node -v` Example Output: `v22.10.0` Check npm: `npm -v` Example Output: `10.9.0` If both commands return version numbers, the installation was successful.

### 2. Install a Code Editor

Although any text editor can be used, **Visual Studio Code (VS Code)** is the most popular choice for React development.

### Useful VS Code Extensions

- ES7+ React Snippets

- Prettier

- ESLint

- Auto Rename Tag

- Live Server (for HTML projects)

These extensions improve productivity and code formatting.

### 3. Basic Knowledge Required

Before learning React, we should understand:

- HTML

- CSS

- JavaScript (ES6+)

- Variables

- Functions

- Objects

- Arrays

- Arrow Functions

- Modules

A solid JavaScript foundation makes React much easier to learn.

## Creating a React Project

Today, **Vite** is the recommended tool for creating React projects because it is lightweight, fast, and easy to configure.

### Step 1: Create the Project

Open the terminal and run:

```

npm create vite@latest my-react-app

```

Here:

- **npm** → Node Package Manager

- **create vite@latest** → Creates a new Vite project

- **my-react-app** → Project folder name

### Step 2: Choose Project Settings

During setup, Vite asks a few questions. Example:

```

Project name: my-react-app
Framework: React
Variant: JavaScript

```

You may also choose **TypeScript** if required, but JavaScript is recommended for beginners.

### Step 3: Move into the Project Folder

`cd my-react-app` Now the terminal is inside your project.

### Step 4: Install Dependencies

`npm install` This command downloads all required packages listed in the `package.json` file.

### Step 5: Start the Development Server

`npm run dev` Example Output:

```

Local: http://localhost:5173/

```

Open the displayed URL in your browser to see the default React application.

## Understanding the React Project Structure

Once the project is created, several folders and files are generated automatically.

```

my-react-app/
│
├── node_modules/
├── public/
├── src/
│ ├── assets/
│ ├── App.jsx
│ ├── main.jsx
│
├── package.json
├── package-lock.json
├── vite.config.js
└── index.html

```

Let us understand the purpose of each important folder and file.

### 1. node_modules

This folder contains all installed packages and dependencies.

### Important Points

- Automatically created after running `npm install`

- Usually very large

- Should never be edited manually

### 2. public Folder

The `public` folder stores static files. Examples include:

- Images

- Icons

- PDF files

- Fonts

Files inside this folder are served directly without processing.

### 3. src Folder

The `src` folder is the heart of every React application. It contains:

- Components

- CSS files

- Images

- JavaScript files

- Application logic

Most development work happens inside this folder.

### 4. App.jsx

This is the main component of the application. Example:

```

function App() {
return (
<h1>Welcome to React!</h1>
);
}
export default App;

```

The `App` component is displayed when the application starts.

### 5. main.jsx

This is the entry point of the React application. Example:

```

import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
ReactDOM.createRoot(document.getElementById("root")).render(
<App />
);

```

It connects the `App` component to the HTML page.

### 6. package.json

This file contains project information. It includes:

- Project name

- Version

- Scripts

- Dependencies

- Development dependencies

Example:

```

{
"name": "my-react-app",
"version": "1.0.0"
}

```

### 7. vite.config.js

This configuration file controls how Vite builds and serves the application. Beginners usually do not need to modify it.

### 8. index.html

Unlike traditional HTML projects, React mainly uses a single HTML file. Inside it, we find: `<div id="root"></div>` React injects the entire application into this `<div>`.

## Running and Managing the React Project

Once the setup is complete, we can manage the project using npm commands.

### Common Commands

### Start Development Server

`npm run dev` Runs the project in development mode.

### Install a Package

`npm install package-name` Example: `npm install axios` Installs the Axios library for making HTTP requests.

### Remove a Package

`npm uninstall package-name` Example: `npm uninstall axios` Removes the installed package.

### Build for Production

`npm run build` Creates an optimized production-ready version of the application.

### Preview Production Build

`npm run preview` Allows us to preview the production build locally before deployment.

## Creating Your First React Component

React applications are built using components. Create a new file inside the `src` folder named **Greeting.jsx**.

```

function Greeting() {
return (
<div>
<h1>Hello Students!</h1>
<p>Welcome to React Development.</p>
</div>
);
}
export default Greeting;

```

Now import it into `App.jsx`.

```

import Greeting from "./Greeting";
function App() {
return (
<Greeting />
);
}
export default App;

```

Output:

```

Hello Students!
Welcome to React Development.

```

This demonstrates how React encourages reusable UI components.

### Understanding the Development Workflow

A typical React workflow follows these steps: 1. Create a React project using Vite. 2. Open the project in VS Code. 3. Create reusable components. 4. Write JSX inside components. 5. Import components into `App.jsx`. 6. Save the file. 7. Vite automatically refreshes the browser using **Hot Module Replacement (HMR)**, allowing changes to appear instantly without manually reloading the page.

### Common Errors and Solutions

| Error | Cause | Solution |
|---|---|---|
| node is not recognized | Node.js is not installed or not added to the system PATH | Install Node.js and restart the terminal |
| npm is not recognized | npm installation issue | Reinstall Node.js |
| Cannot find module | Missing dependencies | Run npm install |
| Port already in use | Another application is using the same port | Stop the other process or use a different port |
| Blank page in browser | Incorrect component import/export | Check imports and exports carefully |

### Best Practices

- Install the latest **LTS** version of Node.js.

- Use **Vite** for new React projects due to its speed and simplicity.

- Organize components inside dedicated folders.

- Keep component names in **PascalCase** (e.g., `UserProfile.jsx`).

- Regularly save your work to take advantage of Vite\'s automatic updates.

- Avoid editing files inside the `node_modules` folder.

- Use meaningful file and folder names for better project organization.

- Learn basic terminal commands to improve development efficiency.

### Conclusion

Setting up a React project is the first step toward building modern, interactive web applications. By installing Node.js, choosing a code editor like VS Code, and using Vite to create a project, we can quickly establish a powerful development environment. Understanding the project structure, important files such as `App.jsx` and `main.jsx`, and essential npm commands enables us to work confidently with React. As we continue learning, this foundation will help us build reusable components, manage application logic effectively, and develop scalable, high-performance web applications with ease.');

-- Lecture 3: JSX Syntax
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'JSX Syntax', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# JSX Syntax

JSX (JavaScript XML) is one of the most important concepts in React. It allows us to write HTML-like code inside JavaScript, making it easier to create and manage user interfaces. Instead of writing complex JavaScript functions to build web pages, JSX lets us describe what we want the interface to look like using familiar HTML syntax. Although it resembles HTML, JSX is not HTML—it is a syntax extension for JavaScript that is converted into regular JavaScript by tools like Babel before being executed by the browser. Think of JSX as a translator between developers and React. We write simple, readable code, and JSX transforms it into JavaScript that React understands.

## What is JSX?

### Definition of JSX

**JSX (JavaScript XML)** is a syntax extension for JavaScript that allows developers to write HTML-like elements inside JavaScript code. It makes React components easier to read, write, and maintain. JSX is not required to use React, but it is the standard way of building React applications because of its simplicity and readability.

### Example

```

const element = <h1>Welcome to React!</h1>;

```

The above JSX is converted into JavaScript similar to:

```

const element = React.createElement(
"h1",
null,
"Welcome to React!"
);

```

Although both produce the same result, JSX is much cleaner and easier to understand.

### Features of JSX

- Looks similar to HTML.

- Written inside JavaScript files.

- Makes UI code simple and readable.

- Supports JavaScript expressions.

- Used to create React elements.

- Compiled into JavaScript before execution.

## Writing JSX

### Basic JSX Example

```

function App() {
return (
<h1>Hello Students!</h1>
);
}

```

Output: `Hello Students!` The `return` statement sends JSX to React, which then displays it in the browser.

### Multiple Elements in JSX

JSX requires all elements to have **one parent element**. ❌ Incorrect:

```

return (
<h1>Hello</h1>
<p>Welcome</p>
);

```

This causes an error because there are two top-level elements.

### Correct Method

Wrap elements inside a parent element.

```

return (
<div>
<h1>Hello</h1>
<p>Welcome</p>
</div>
);

```

### Using React Fragment

If we do not want an extra `<div>`, we can use a **Fragment**.

```

return (
<>
<h1>Hello</h1>
<p>Welcome</p>
</>
);

```

Fragments group multiple elements without adding extra HTML to the webpage.

## JSX Expressions

One of the biggest advantages of JSX is that we can write JavaScript expressions inside curly braces `{}`.

### Displaying Variables

```

function App() {
const name = "Ali";
return (
<h1>Hello {name}</h1>
);
}

```

Output: `Hello Ali`

### Using Arithmetic Expressions

```

function App() {
return (
<h2>{10 + 20}</h2>
);
}

```

Output: `30`

### Calling Functions

```

function greet() {
return "Welcome!";
}
function App() {
return (
<h1>{greet()}</h1>
);
}

```

Output: `Welcome!`

### Using Object Properties

```

const student = {
name: "Sara",
age: 20
};
function App() {
return (
<h2>{student.name}</h2>
);
}

```

Output: `Sara`

## JSX Rules

JSX follows several important rules that developers must remember.

### 1. Close Every Tag

Every HTML tag must be closed. ✅ Correct: `<img src="image.jpg" />` ❌ Incorrect: `<img src="image.jpg">`

### 2. Use camelCase for Attributes

Many HTML attributes have different names in JSX because they follow JavaScript naming conventions.

| HTML | JSX |
|---|---|
| class | className |
| for | htmlFor |
| tabindex | tabIndex |

### Example

```

<h1 className="title">
Welcome
</h1>

```

### 3. One Parent Element

Every JSX expression must return a single parent element. Correct:

```

<div>
<h1>Hello</h1>
<p>Students</p>
</div>

```

### 4. Use Curly Braces for JavaScript

JavaScript expressions must always be enclosed in `{}`.

```

const age = 21;
<h2>Age: {age}</h2>

```

### 5. Attribute Values

String values use quotation marks. `<img src="logo.png" />` JavaScript values use curly braces.

```

<img src={imagePath} />

```

## JSX Attributes and Styling

### Adding Attributes

```

function App() {
return (
<img
src="logo.png"
alt="React Logo"
/>
);
}

```

### Inline CSS

React uses JavaScript objects for inline styling.

```

function App() {
return (
<h1
style={{
color: "blue",
}}
>
Welcome
</h1>
);
}

```

Notice:

- CSS properties use **camelCase**.

- Values are written inside a JavaScript object.

### Using CSS Classes

Instead of `class`, React uses `className`.

```

<h1 className="heading">
React
</h1>

```

CSS:

```

.heading {
color: red;
}

```

## Conditional Rendering in JSX

JSX allows conditions using JavaScript expressions.

### Using Ternary Operator

```

const isLoggedIn = true;
function App() {
return (
<h1>
{isLoggedIn ? "Welcome!" : "Please Login"}
</h1>
);
}

```

Output: `Welcome!`

### Using Logical AND (&&)

```

const showMessage = true;
function App() {
return (
<>
{showMessage && <h2>Hello Students!</h2>}
</>
);
}

```

The heading appears only when the condition is true.

## Rendering Lists with JSX

JSX can display multiple items using JavaScript\'s `map()` method.

```

const fruits = [
"Apple",
"Banana",
"Mango"
];
function App() {
return (
<ul>
{fruits.map((fruit, index) => (
<li key={index}>
{fruit}
</li>
))}
</ul>
);
}

```

Output:

```

• Apple
• Banana
• Mango

```

The `key` prop helps React efficiently identify and update list items.

## Comments in JSX

Comments inside JSX use curly braces and JavaScript comment syntax.

```

function App() {
return (
<div>
{/* This is a JSX comment */}
<h1>Hello React</h1>
</div>
);
}

```

Comments improve code readability without affecting the output.

## JSX vs HTML

| Feature | HTML | JSX |
|---|---|---|
| Attribute for CSS class | class | className |
| Label attribute | for | htmlFor |
| JavaScript support | Separate <script> | Directly inside {} |
| Styling | Standard CSS | CSS or JavaScript object |
| Multiple root elements | Allowed | Requires one parent element or Fragment |
| Compilation | Runs directly in browser | Compiled into JavaScript |

### Common JSX Errors

| Error | Cause | Solution |
|---|---|---|
| Adjacent JSX elements must be wrapped | Multiple root elements | Wrap them in a <div> or <>...</> |
| Unexpected token | Missing closing tag | Close all tags properly |
| class is not allowed | Using HTML attribute | Replace class with className |
| for is not allowed | HTML attribute used | Replace with htmlFor |
| Objects are not valid as a React child | Trying to display an object directly | Display a property, e.g., {user.name } |

### Best Practices for Writing JSX

- Use meaningful component names in **PascalCase**.

- Keep JSX clean and readable with proper indentation.

- Wrap multiple elements inside a parent element or a React Fragment.

- Use `className` instead of `class`.

- Use `htmlFor` instead of `for`.

- Close all tags properly.

- Use curly braces `{}` only for JavaScript expressions.

- Use unique `key` values when rendering lists.

- Keep complex logic outside JSX whenever possible for better readability.

### Conclusion

JSX is the foundation of React development because it combines the power of JavaScript with the simplicity of HTML-like syntax. It allows us to create user interfaces that are easy to read, maintain, and update. By understanding JSX rules, expressions, attributes, styling, conditional rendering, and list rendering, we can build React applications more efficiently. Although JSX may look like HTML, remembering its unique syntax—such as `className`, `htmlFor`, camelCase attributes, and JavaScript expressions inside curly braces—will help us write clean, error-free, and professional React code.');

-- Lecture 4: Components (Functional Components)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Components (Functional Components)', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Components (Functional Components)

Functional Components are the building blocks of modern React applications. Instead of creating one large file containing all the code for a webpage, React encourages us to divide the user interface into small, reusable components. Each component performs a specific task and can be reused throughout the application. Modern React development primarily uses Functional Components because they are simple, lightweight, and work seamlessly with React Hooks. Imagine building a car. The wheels, engine, doors, and steering wheel are all separate parts, but together they form a complete vehicle. Similarly, React applications are built by combining many small components, each responsible for a specific part of the user interface.

## What are Functional Components?

### Definition

A **Functional Component** is a JavaScript function that returns JSX (JavaScript XML). It represents a reusable part of the user interface and is the preferred way to create components in modern React. Unlike Class Components, Functional Components are easier to write, easier to understand, and support React Hooks for managing state and side effects.

### Basic Syntax

```

function Welcome() {
return <h1>Welcome to React!</h1>;
}
export default Welcome;

```

When this component is rendered, it displays: `Welcome to React!`

### Characteristics of Functional Components

- Written as JavaScript functions.

- Return JSX.

- Reusable across multiple pages.

- Easy to read and maintain.

- Can use React Hooks.

- Lightweight and efficient.

- Preferred in modern React applications.

## Creating Functional Components

Creating a Functional Component involves just a few simple steps.

### Step 1: Create a Component

Create a file named **Greeting.jsx** inside the `src` folder.

```

function Greeting() {
return (
<h1>Hello Students!</h1>
);
}
export default Greeting;

```

### Step 2: Import the Component

Open `App.jsx` and import the component.

```

import Greeting from "./Greeting";
function App() {
return (
<Greeting />
);
}
export default App;

```

### Output

`Hello Students!` This demonstrates how components can be created once and reused whenever needed.

## Naming Rules for Functional Components

React follows specific naming conventions for components.

### 1. Use PascalCase

Component names should begin with a capital letter. ✅ Correct:

```

function StudentCard() {
return <h2>Student</h2>;
}

```

❌ Incorrect:

```

function studentCard() {
return <h2>Student</h2>;
}

```

React treats lowercase names as HTML elements instead of components.

### 2. One Component Per File

It is recommended to store each component in its own file. Example:

```

src/
│
├── App.jsx
├── Header.jsx
├── Footer.jsx
├── Navbar.jsx
└── StudentCard.jsx

```

This keeps the project organized and easier to maintain.

## Returning JSX from Functional Components

Every Functional Component must return a single JSX element.

### Returning a Single Element

```

function App() {
return (
<h1>React Components</h1>
);
}

```

### Returning Multiple Elements

Multiple elements must be wrapped inside one parent element.

```

function App() {
return (
<div>
<h1>Welcome</h1>
<p>Learning React is fun.</p>
</div>
);
}

```

### Using React Fragment

Instead of an extra `<div>`, React Fragments can be used.

```

function App() {
return (
<>
<h1>Hello</h1>
<p>Students</p>
</>
);
}

```

Fragments group multiple elements without adding unnecessary HTML to the page.

## Reusing Functional Components

One of React\'s greatest strengths is component reusability.

### Example

```

function Button() {
return (
<button>Click Me</button>
);
}

```

Use it multiple times:

```

function App() {
return (
<>
<Button />
<Button />
<Button />
</>
);
}

```

Output:

```

Click Me
Click Me
Click Me

```

Instead of writing the same button repeatedly, we create it once and reuse it.

## Functional Components with Props

Props (Properties) allow us to pass data from a parent component to a child component.

### Example

```

function Student(props) {
return (
<h2>Name: {props.name}</h2>
);
}

```

Using the component:

```

function App() {
return (
<>
<Student name="Ali" />
<Student name="Sara" />
<Student name="Ahmed" />
</>
);
}

```

Output:

```

Name: Ali
Name: Sara
Name: Ahmed

```

Props make components dynamic and reusable with different data.

### Using Destructuring

Instead of writing props.name, we can use destructuring.

```

function Student({ name }) {
return (
<h2>{name}</h2>
);
}

```

This makes the code shorter and cleaner.

## Functional Components with React Hooks

Modern Functional Components can manage data using **Hooks**.

### Using useState

```

import { useState } from "react";
function Counter() {
const [count, setCount] = useState(0);
return (
<>
<h2>{count}</h2>
<button onClick={() => setCount(count + 1)}>
Increase
</button>
</>
);
}
export default Counter;

```

Whenever the button is clicked, the displayed number increases automatically.

### Using useEffect

```

import { useEffect } from "react";
function App() {
useEffect(() => {
console.log("Component Loaded");
}, []);
return <h1>Hello React</h1>;
}

```

`useEffect()` performs actions such as fetching data, updating the document title, or handling side effects after the component renders.

## Advantages of Functional Components

Functional Components provide many benefits over older Class Components.

### Advantages

- Less code to write.

- Easy to understand.

- Better readability.

- Supports React Hooks.

- Faster development.

- Easier debugging.

- Improved performance in modern React.

- Encourages reusable code.

## Functional Components vs Class Components

| Feature | Functional Components | Class Components |
|---|---|---|
| Syntax | JavaScript Function | ES6 Class |
| Code Length | Short | Longer |
| Readability | High | Moderate |
| State Management | Hooks ( useState) | this.state |
| Lifecycle Methods | useEffect | Class lifecycle methods |
| Performance | Lightweight | Slightly heavier |
| Modern Usage | Recommended | Mostly used in older projects |

## Common Mistakes

### 1. Component Name Starts with Lowercase

❌ Incorrect

```

function header() {
return <h1>Header</h1>;
}

```

✅ Correct

```

function Header() {
return <h1>Header</h1>;
}

```

### 2. Forgetting to Export

```

export default Header;

```

Without exporting, the component cannot be imported into other files.

### 3. Forgetting to Return JSX

❌ Incorrect

```

function App() {
<h1>Hello</h1>;
}

```

✅ Correct

```

function App() {
return <h1>Hello</h1>;
}

```

### 4. Returning Multiple Root Elements

❌ Incorrect

```

return (
<h1>Hello</h1>
<p>React</p>
);

```

✅ Correct

```

return (
<>
<h1>Hello</h1>
<p>React</p>
</>
);

```

## Best Practices

- Use **PascalCase** for component names.

- Keep each component focused on a single responsibility.

- Store one component per file.

- Use Functional Components instead of Class Components for new projects.

- Use React Hooks for state and side effects.

- Use props to make components reusable.

- Write clean and properly indented JSX.

- Avoid placing too much logic inside the JSX; keep components simple and maintainable.

### Real-World Example

Consider an e-commerce website. Instead of creating one large page, we can divide it into reusable Functional Components:

- **Header** – Displays the website logo and navigation.

- **Navbar** – Contains links to different pages.

- **ProductCard** – Shows product details.

- **Cart** – Displays selected items.

- **Footer** – Contains contact information and copyright details.

Each component can be developed, tested, and reused independently, making the application easier to build and maintain.

### Conclusion

Functional Components are the foundation of modern React development. They allow us to create clean, reusable, and organized user interfaces using simple JavaScript functions. With support for JSX, props, and React Hooks such as `useState` and `useEffect`, Functional Components provide everything needed to build dynamic and interactive web applications. By following best practices and organizing applications into small, reusable components, we can develop scalable, maintainable, and efficient React projects with greater ease and productivity.');

-- Lecture 5: Props in React
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Props in React', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Props in React

Props, short for **Properties**, are one of the most fundamental concepts in React. They allow us to pass data from one component to another, making components dynamic, reusable, and flexible. Instead of creating multiple components with nearly identical code, we can create a single component and customize its behavior using props. Think of a component as a **template** and props as the **information** we provide to that template. For example, a greeting card template remains the same, but the recipient\'s name changes. Similarly, React components stay the same while props provide different values each time they are used.

## What are Props?

### Definition

**Props (Properties)** are read-only inputs that allow a **parent component** to pass data to a **child component**. They make components reusable by allowing different values to be displayed without changing the component\'s internal code.

### Key Characteristics of Props

- Passed from parent to child.

- Read-only (cannot be modified by the child).

- Used to transfer data between components.

- Make components reusable and dynamic.

- Can pass different types of data.

### Why Do We Use Props?

Without props, we would need to create separate components for every piece of data. For example, instead of creating:

- StudentAli

- StudentSara

- StudentAhmed

We create a single **Student** component and pass different names using props. This approach reduces code duplication and improves maintainability.

## Passing Props to a Component

A parent component passes props using attributes, just like HTML attributes.

### Example

### Child Component (Student.jsx)

```

function Student(props) {
return (
<h2>Name: {props.name}</h2>
);
}
export default Student;

```

### Parent Component (App.jsx)

```

import Student from "./Student";
function App() {
return (
<>
<Student name="Ali" />
<Student name="Sara" />
<Student name="Ahmed" />
</>
);
}
export default App;

```

### Output

```

Name: Ali
Name: Sara
Name: Ahmed

```

The same component is reused with different data.

## Accessing Props

There are two common ways to access props inside a Functional Component.

### Method 1: Using the props Object

```

function Employee(props) {
return (
<h2>{props.name}</h2>
);
}

```

The `props` object contains all properties passed from the parent component.

### Method 2: Using Destructuring

A cleaner approach is to destructure the props object.

```

function Employee({ name }) {
return (
<h2>{name}</h2>
);
}

```

If multiple props exist:

```

function Employee({ name, age, department }) {
return (
<>
<h2>{name}</h2>
<p>Age: {age}</p>
<p>Department: {department}</p>
</>
);
}

```

Destructuring improves readability and reduces repetitive code.

## Passing Different Types of Props

Props can hold almost any JavaScript value.

### 1. String Props

```

<Greeting message="Welcome to React!" />

```

### 2. Number Props

```

<Student marks={95} />

```

### 3. Boolean Props

```

<User isLoggedIn={true} />

```

### 4. Array Props

```

<List items={["Apple", "Banana", "Mango"]} />

```

### 5. Object Props

```

const student = {
name: "Ali",
age: 20
};
<Student data={student} />

```

Accessing the object:

```

function Student({ data }) {
return (
<>
<h2>{data.name}</h2>
<p>{data.age}</p>
</>
);
}

```

### 6. Function Props

Functions can also be passed as props.

```

function Button({ clickHandler }) {
return (
<button onClick={clickHandler}>
Click Me
</button>
);
}

```

Using the component:

```

<Button clickHandler={() => alert("Button Clicked")} />

```

This technique allows child components to communicate actions back to the parent.

## Multiple Props

A component can receive more than one prop.

### Example

```

function Student({ name, age, city }) {
return (
<>
<h2>{name}</h2>
<p>Age: {age}</p>
<p>City: {city}</p>
</>
);
}

```

Using the component:

```

<Student
name="Ali"
age={20}
city="Lahore"
/>

```

Output:

```

Ali
Age: 20
City: Lahore

```

## Default Props

Sometimes a prop is not provided. We can assign a default value.

### Using Default Parameters

```

function Welcome({ name = "Guest" }) {
return (
<h2>Hello {name}</h2>
);
}

```

Usage: `<Welcome />` Output: `Hello Guest` If a value is passed: `<Welcome name="Sara" />` Output: `Hello Sara`

## Children Prop

React automatically provides a special prop called `children`. It represents everything placed between the opening and closing component tags.

### Example

```

function Card({ children }) {
return (
<div className="card">
{children}
</div>
);
}

```

Using the component:

```

<Card>
<h2>React Course</h2>
<p>Learn React from scratch.</p>
</Card>

```

Output:

```

React Course
Learn React from scratch.

```

The `children` prop makes components highly flexible and reusable.

## Props are Read-Only

Props should **never be modified** inside a child component. ❌ Incorrect

```

function Student(props) {
props.name = "Ahmed";
}

```

This causes unexpected behavior and breaks React\'s data flow. ✅ Correct

```

function Student(props) {
return (
<h2>{props.name}</h2>
);
}

```

React follows **one-way data flow**, meaning data moves from the parent component to the child component only.

## Props vs State

| Feature | Props | State |
|---|---|---|
| Definition | Data passed from parent | Data managed within a component |
| Editable | No (Read-only) | Yes |
| Controlled By | Parent component | Current component |
| Purpose | Pass data | Store changing data |
| Direction | Parent → Child | Local to component |
| Example | Student name | Counter value |

## Common Mistakes

### 1. Forgetting Curly Braces

❌ Incorrect `<Student marks="95 + 5" />` This passes the text `"95 + 5"`. ✅ Correct

```

<Student marks={95 + 5} />
100

```

### 2. Incorrect Prop Name

❌ Parent

```

<Student studentName="Ali" />

```

❌ Child `props.name` The names do not match. ✅ Correct

```

<Student name="Ali" />
props.name

```

### 3. Modifying Props

Never change the value of a prop inside the child component. Instead, let the parent component provide updated values.

## Best Practices

- Use descriptive prop names.

- Use destructuring for cleaner code.

- Keep props read-only.

- Pass only the data needed by the child component.

- Use default values when appropriate.

- Use the `children` prop for flexible layouts.

- Keep components focused on a single responsibility.

- Avoid passing unnecessary or excessive props.

### Real-World Example

Imagine an online shopping website. A single **ProductCard** component can display different products using props.

```

<ProductCard
name="Laptop"
price={85000}
brand="Dell"
/>
<ProductCard
name="Smartphone"
price={55000}
brand="Samsung"
/>
<ProductCard
name="Headphones"
price={7000}
brand="Sony"
/>

```

Instead of creating separate components for every product, we reuse one component and pass different information through props. This keeps the application organized, scalable, and easy to maintain.

### Conclusion

Props are an essential feature of React that allow components to communicate through a simple and efficient one-way data flow. By passing data from parent components to child components, props make applications more dynamic, reusable, and maintainable. Whether passing strings, numbers, objects, arrays, functions, or even other components through the `children` prop, props provide the flexibility needed to build scalable user interfaces. Understanding how to use props effectively is a key step toward mastering React and developing clean, reusable, and professional web applications.');

-- Lecture 6: State & useState Hook
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'State & useState Hook', 6, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# State & useState Hook

State is one of the most important concepts in React because it allows components to store and manage data that can change over time. Without state, React components would only display static content. By using state, we can create dynamic applications where user interactions—such as clicking buttons, filling out forms, or updating counters—automatically change what appears on the screen. In modern React, state is managed using the **useState Hook**. The `useState` Hook enables Functional Components to store and update data while automatically re-rendering the user interface whenever the data changes. Think of state as the **memory of a component**. Just as a person remembers information and updates it over time, a React component remembers its current data through state and updates the interface whenever that data changes.

## What is State?

### Definition

**State** is a built-in React object that stores data that can change during the lifetime of a component. Whenever the state changes, React automatically updates the component and re-renders the user interface. State allows React applications to respond dynamically to user actions.

### Examples of State

- Counter value

- Login status

- User profile information

- Shopping cart items

- Form input values

- Theme (Light/Dark mode)

- Number of likes on a post

### Characteristics of State

- Stores dynamic data.

- Managed within a component.

- Can be updated over time.

- Causes the component to re-render when changed.

- Managed using Hooks in Functional Components.

## What is the useState Hook?

### Definition

The **useState Hook** is a built-in React Hook that allows Functional Components to create and manage state. Before Hooks were introduced, only Class Components could manage state. With `useState`, Functional Components can now perform the same task in a simpler and more efficient way.

### Importing useState

Before using `useState`, it must be imported from React.

```

import { useState } from "react";

```

### Basic Syntax

```

const [state, setState] = useState(initialValue);

```

### Explanation

- **state** → Stores the current value.

- **setState** → Updates the value.

- **initialValue** → The starting value of the state.

### Example

```

import { useState } from "react";
function Counter() {
const [count, setCount] = useState(0);
return <h1>{count}</h1>;
}

```

Initially, the value of `count` is **0**.

## How useState Works

The `useState` Hook always returns **two values** inside an array.

```

const [count, setCount] = useState(0);

```

| Part | Purpose |
|---|---|
| count | Stores the current state value |
| setCount | Updates the state value |
| 0 | Initial state value |

Whenever `setCount()` is called, React updates the value and automatically refreshes the component.

### Updating State

```

import { useState } from "react";
function Counter() {
const [count, setCount] = useState(0);
return (
<>
<h2>{count}</h2>
<button onClick={() => setCount(count + 1)}>
Increase
</button>
</>
);
}

```

### Output

Initially: `0` After clicking the button: `1` After clicking again: `2` React updates the displayed value automatically without refreshing the entire page.

## Updating Different Types of State

The `useState` Hook can store many different types of data.

### 1. String State

```

import { useState } from "react";
function App() {
const [name, setName] = useState("Ali");
return (
<>
<h2>{name}</h2>
<button onClick={() => setName("Sara")}>
Change Name
</button>
</>
);
}

```

### 2. Number State

```

const [age, setAge] = useState(20);

```

### 3. Boolean State

```

const [isLoggedIn, setIsLoggedIn] = useState(false);

```

Useful for login/logout functionality.

### 4. Array State

```

const [fruits, setFruits] = useState([
"Apple",
"Banana",
"Mango"
]);

```

### 5. Object State

```

const [student, setStudent] = useState({
name: "Ali",
age: 20
});

```

Updating an object:

```

setStudent({
...student,
age: 21
});

```

The spread operator (`...`) copies the existing object and updates only the specified property.

## Event Handling with useState

State is commonly updated in response to user events.

### Counter Example

```

import { useState } from "react";
function Counter() {
const [count, setCount] = useState(0);
return (
<>
<h2>{count}</h2>
<button onClick={() => setCount(count + 1)}>
Increase
</button>
<button onClick={() => setCount(count - 1)}>
Decrease
</button>
</>
);
}

```

This component increases or decreases the counter whenever a button is clicked.

### Toggle Example

```

import { useState } from "react";
function Toggle() {
const [isOn, setIsOn] = useState(false);
return (
<>
<h2>{isOn ? "ON" : "OFF"}</h2>
<button
onClick={() => setIsOn(!isOn)}
>
Toggle
</button>
</>
);
}

```

This example switches between **ON** and **OFF** every time the button is pressed.

## State in Forms

The `useState` Hook is widely used to handle user input.

```

import { useState } from "react";
function Form() {
const [name, setName] = useState("");
return (
<>
<input
type="text"
value={name}
onChange={(e) =>
setName(e.target.value)
}
/>
<h2>{name}</h2>
</>
);
}

```

As the user types into the input field, the displayed text updates instantly.

## Rules of the useState Hook

To use `useState` correctly, React provides several important rules.

### 1. Call Hooks at the Top Level

✅ Correct

```

const [count, setCount] = useState(0);

```

Do not call Hooks inside loops, conditions, or nested functions.

### 2. Use Hooks Only in Functional Components

Hooks cannot be used inside regular JavaScript functions.

### 3. Never Update State Directly

❌ Incorrect

```

count = count + 1;

```

✅ Correct

```

setCount(count + 1);

```

Always use the setter function returned by `useState`.

## State vs Props

| Feature | State | Props |
|---|---|---|
| Definition | Stores changing data | Receives data from parent |
| Editable | Yes | No (Read-only) |
| Controlled By | Current component | Parent component |
| Purpose | Manage dynamic data | Pass data between components |
| Example | Counter value | Student name |

## Common Mistakes

### 1. Updating State Directly

❌ Incorrect

```

count++;

```

✅ Correct

```

setCount(count + 1);

```

### 2. Forgetting to Import useState

❌ Incorrect

```

const [count, setCount] = useState(0);

```

This causes an error because `useState` has not been imported. ✅ Correct

```

import { useState } from "react";

```

### 3. Modifying Objects Incorrectly

❌ Incorrect

```

student.age = 22;

```

✅ Correct

```

setStudent({
...student,
age: 22
});

```

Always create a new object instead of modifying the existing one directly.

## Best Practices

- Use meaningful state variable names.

- Keep state as simple as possible.

- Update state using the setter function only.

- Use one state variable for each independent piece of data.

- Avoid storing unnecessary or duplicate data in state.

- Use the spread operator when updating objects or arrays.

- Follow React Hook rules consistently.

- Keep state management inside the component that owns the data.

### Real-World Applications of useState

The `useState` Hook is used in many real-world React applications, such as:

- Login and registration forms

- Shopping cart quantity management

- Like and favorite buttons

- Theme switching (Light/Dark mode)

- Image sliders and carousels

- To-do list applications

- Quiz and examination systems

- Search bars with live filtering

- User profile editing

- Product quantity counters in e-commerce websites

These examples show how `useState` helps create interactive and responsive user interfaces.

### Conclusion

State is the foundation of dynamic React applications because it allows components to store and update data over time. The `useState` Hook provides a simple and powerful way for Functional Components to manage state without the complexity of Class Components. By understanding how to create, update, and manage different types of state, we can build interactive features such as counters, forms, toggles, and shopping carts with ease. Mastering the `useState` Hook is an essential step toward becoming a skilled React developer and creating modern, responsive web applications.');

-- Lecture 7: Event Handling in React
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Event Handling in React', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Event Handling in React

Event handling is an essential part of React because it allows applications to respond to user interactions. Whether a user clicks a button, types in a text box, submits a form, or moves the mouse, React uses **events** to detect these actions and execute specific functions. Without event handling, React applications would be static and unable to interact with users. React\'s event system is similar to JavaScript\'s event handling, but it uses a more consistent and efficient approach called **Synthetic Events**. This provides the same behavior across different browsers, making React applications more reliable and easier to develop. Imagine a television remote. Pressing different buttons performs different actions, such as changing channels or adjusting the volume. Similarly, in React, different user actions trigger different events, allowing the application to respond accordingly.

## What is Event Handling?

### Definition

**Event Handling** is the process of responding to user actions such as clicking buttons, typing text, submitting forms, hovering over elements, or pressing keyboard keys. React uses **event handlers**, which are JavaScript functions executed whenever an event occurs.

### Common User Events

Some of the most frequently used events in React include:

- Mouse click

- Double click

- Keyboard input

- Form submission

- Mouse hover

- Mouse movement

- Focus and blur

- Copy and paste

- Scrolling

### Why Event Handling is Important

Event handling makes applications:

- Interactive

- Dynamic

- User-friendly

- Responsive

- Easy to control

Without event handling, users could not interact with the application.

## React Event Syntax

React event names use **camelCase** instead of lowercase HTML event names.

### Basic Syntax

```

<button onClick={handleClick}>
Click Me
</button>

```

Here:

- `onClick` is the event.

- `handleClick` is the function that runs when the button is clicked.

### Creating an Event Handler

```

function App() {
function handleClick() {
alert("Button Clicked!");
}
return (
<button onClick={handleClick}>
Click Me
</button>
);
}
export default App;

```

Whenever the button is clicked, an alert box appears.

### Using Arrow Functions

```

<button
onClick={() => alert("Hello React")}
>
Click
</button>

```

Arrow functions are useful when passing arguments or executing multiple statements.

## Types of Events in React

React supports many built-in events.

### 1. Mouse Events

Mouse events occur when the user interacts with the mouse.

### onClick

```

<button
onClick={() => alert("Clicked")}
>
Click
</button>

```

### onDoubleClick

```

<button
onDoubleClick={() => alert("Double Click")}
>
Double Click
</button>

```

### onMouseOver

```

<h2
onMouseOver={() => alert("Mouse Over")}
>
Hover Here
</h2>

```

### onMouseOut

```

<h2
onMouseOut={() => alert("Mouse Left")}
>
Move Mouse Away
</h2>

```

## Keyboard Events

Keyboard events occur when the user presses keys.

### onKeyDown

```

<input
onKeyDown={() => console.log("Key Pressed")}
/>

```

This event is triggered as soon as a key is pressed.

### onKeyUp

```

<input
onKeyUp={() => console.log("Key Released")}
/>

```

This event occurs when the user releases a key.

## Form Events

React frequently uses events to manage forms.

### onChange

```

import { useState } from "react";
function App() {
const [name, setName] = useState("");
return (
<input
type="text"
value={name}
onChange={(e) =>
setName(e.target.value)
}
/>
);
}

```

Whenever the user types, the state updates automatically.

### onSubmit

```

function App() {
function handleSubmit(event) {
event.preventDefault();
alert("Form Submitted");
}
return (
<form onSubmit={handleSubmit}>
<button type="submit">
Submit
</button>
</form>
);
}

```

`event.preventDefault()` prevents the page from refreshing after form submission.

## The Event Object

Whenever an event occurs, React automatically passes an **event object** to the event handler.

### Example

```

function handleClick(event) {
console.log(event);
}
<button onClick={handleClick}>
Click
</button>

```

The event object contains useful information such as:

- Event type

- Target element

- Mouse position

- Keyboard key

- Current value

### Accessing Input Values

```

function App() {
function handleChange(event) {
console.log(event.target.value);
}
return (
<input
onChange={handleChange}
/>
);
}

```

Here, event.target.value returns the text entered by the user.

## Passing Arguments to Event Handlers

Sometimes we need to pass additional data.

### Example

```

function greet(name) {
alert("Hello " + name);
}
function App() {
return (
<button
onClick={() => greet("Ali")}
>
Click
</button>
);
}

```

Output: `Hello Ali` Arrow functions allow us to pass arguments safely.

## Event Handling with useState

Events are often combined with the `useState` Hook to create interactive applications.

### Counter Example

```

import { useState } from "react";
function Counter() {
const [count, setCount] = useState(0);
return (
<>
<h2>{count}</h2>
<button
onClick={() => setCount(count + 1)}
>
Increase
</button>
</>
);
}

```

Every button click updates the counter.

### Toggle Example

```

import { useState } from "react";
function App() {
const [isOn, setIsOn] = useState(false);
return (
<>
<h2>
{isOn ? "ON" : "OFF"}
</h2>
<button
onClick={() => setIsOn(!isOn)}
>
Toggle
</button>
</>
);
}

```

Each click changes the displayed status.

## React Synthetic Events

React does not use the browser\'s native events directly. Instead, it uses **Synthetic Events**.

### Definition

A **Synthetic Event** is a wrapper around the browser\'s native event that provides consistent behavior across all browsers.

### Advantages

- Cross-browser compatibility

- Better performance

- Consistent event handling

- Easier to use

Developers use Synthetic Events just like normal JavaScript events, but React handles the differences internally.

## Common React Events

| Event | Purpose |
|---|---|
| onClick | Triggered when an element is clicked |
| onDoubleClick | Triggered on a double click |
| onChange | Triggered when an input value changes |
| onSubmit | Triggered when a form is submitted |
| onKeyDown | Triggered when a key is pressed |
| onKeyUp | Triggered when a key is released |
| onMouseOver | Triggered when the mouse enters an element |
| onMouseOut | Triggered when the mouse leaves an element |
| onFocus | Triggered when an element gains focus |
| onBlur | Triggered when an element loses focus |

## Common Mistakes

### 1. Calling the Function Immediately

❌ Incorrect

```

<button onClick={handleClick()}>
Click
</button>

```

This executes the function immediately when the component renders. ✅ Correct

```

<button onClick={handleClick}>
Click
</button>

```

### 2. Forgetting Arrow Function for Arguments

❌ Incorrect

```

<button onClick={greet("Ali")}>
Click
</button>

```

✅ Correct

```

onClick={() => greet("Ali")}
>
Click
</button>

```

### 3. Forgetting preventDefault()

If a form is submitted without `preventDefault()`, the browser refreshes the page.

```

event.preventDefault();

```

Always use it when handling form submissions in React.

## Best Practices

- Use descriptive event handler names such as `handleClick` or `handleSubmit`.

- Write event handlers as separate functions for better readability.

- Use arrow functions only when necessary, such as passing arguments.

- Avoid placing complex logic directly inside JSX.

- Use `preventDefault()` for form submissions when needed.

- Combine events with `useState` to create dynamic interfaces.

- Keep event handlers focused on a single responsibility.

- Follow React\'s camelCase naming convention for all events.

### Real-World Applications of Event Handling

Event handling is used in almost every React application, including:

- Login and registration forms

- Shopping cart quantity buttons

- Search bars with live filtering

- Navigation menus

- Image galleries and sliders

- Like and favorite buttons

- Theme switchers (Light/Dark mode)

- Online quizzes and exams

- Chat applications

- E-commerce checkout forms

These features rely on event handling to respond instantly to user interactions and provide a smooth user experience.

### Conclusion

Event handling is a fundamental feature of React that enables applications to respond to user interactions such as clicks, keyboard input, mouse movements, and form submissions. React simplifies event handling through its Synthetic Event system, providing consistent behavior across different browsers. By understanding event syntax, the event object, common event types, and how to combine events with the `useState` Hook, we can build interactive, responsive, and user-friendly web applications. Mastering event handling is an essential step toward creating professional React applications that deliver a seamless experience for users.');

-- Lecture 8: Conditional Rendering in React
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Conditional Rendering in React', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Conditional Rendering in React

Conditional Rendering is a powerful feature in React that allows us to display different content based on certain conditions. Instead of always showing the same user interface, React can decide what to display depending on variables, user actions, or application state. This helps us create dynamic, interactive, and user-friendly applications. For example, when a user logs into a website, they may see a **"Welcome"** message and a **Logout** button. If they are not logged in, the page instead displays **"Please Login"** and a **Login** button. This behavior is achieved using Conditional Rendering. Think of Conditional Rendering like a traffic signal. When the light is green, vehicles move forward. When it is red, they stop. Similarly, React displays different content based on whether a condition is true or false.

## What is Conditional Rendering?

### Definition

**Conditional Rendering** is the process of displaying different UI elements or components based on specific conditions. React evaluates a condition and renders the appropriate content. It works similarly to JavaScript conditional statements such as:

- `if`

- `if...else`

- Ternary Operator (`? :`)

- Logical AND (`&&`)

### Why Do We Use Conditional Rendering?

Conditional Rendering allows applications to:

- Display content based on user actions.

- Show or hide elements dynamically.

- Improve user experience.

- Create personalized interfaces.

- Control access to certain features.

### Real-Life Examples

- Login and Logout pages.

- Shopping cart messages.

- Loading screens.

- Error messages.

- Admin and User dashboards.

- Online examination results.

- Theme switching (Light/Dark mode).

## Using if Statement

The `if` statement is useful when we need to perform multiple operations before returning JSX.

### Example

```

function App() {
const isLoggedIn = true;
if (isLoggedIn) {
return <h1>Welcome Back!</h1>;
}
return <h1>Please Login</h1>;
}
export default App;

```

### Output

```

Welcome Back!
Please Login

```

## Using if...else Statement

The `if...else` statement explicitly handles both conditions.

### Example

```

function App() {
const age = 20;
if (age >= 18) {
return <h2>Eligible to Vote</h2>;
} else {
return <h2>Not Eligible</h2>;
}
}

```

### Output

`Eligible to Vote` This method is useful when different blocks of JSX need to be returned.

## Using the Ternary Operator

The **ternary operator** is the most commonly used method for Conditional Rendering because it is concise and easy to read.

### Syntax

```

condition ? trueValue : falseValue

```

### Example

```

function App() {
const isLoggedIn = false;
return (
<h1>
{isLoggedIn ? "Welcome!" : "Please Login"}
</h1>
);
}

```

### Output

`Please Login` The ternary operator is ideal for simple conditions.

### Another Example

```

function App() {
const marks = 85;
return (
<h2>
</h2>
);
}

```

Output: `Pass`

## Using Logical AND (&&)

The logical AND (`&&`) operator is used when we want to display something **only if a condition is true**.

### Syntax

`condition && expression`

### Example

```

function App() {
const isAdmin = true;
return (
<>
{isAdmin && <h2>Admin Panel</h2>}
</>
);
}

```

### Output

`Admin Panel` If `isAdmin` is `false`, nothing is displayed.

### Practical Example

```

const items = 5;
return (
<>
{items > 0 && <p>You have items in your cart.</p>}
</>
);

```

The message appears only when the cart contains items.

## Using Logical OR (||)

The logical OR (`||`) operator provides a default value when the first value is falsy.

### Example

```

function App() {
const username = "";
return (
<h2>
{username || "Guest"}
</h2>
);
}

```

### Output

`Guest` If `username` contains a value, that value is displayed instead.

## Conditional Rendering with Components

Entire components can also be rendered conditionally.

### Example

```

function Login() {
return <h2>Please Login</h2>;
}
function Dashboard() {
return <h2>Welcome to Dashboard</h2>;
}
function App() {
const isLoggedIn = true;
return (
<>
{isLoggedIn ? <Dashboard /> : <Login />}
</>
);
}

```

### Output

`Welcome to Dashboard` React renders different components depending on the condition.

## Conditional Rendering with useState

Conditional Rendering is commonly used with the `useState` Hook.

### Example

```

import { useState } from "react";
function App() {
const [loggedIn, setLoggedIn] = useState(false);
return (
<>
<h2>
{loggedIn ? "Welcome!" : "Please Login"}
</h2>
<button
onClick={() => setLoggedIn(!loggedIn)}
>
Toggle Login
</button>
</>
);
}

```

### Working

Initially: `Please Login` After clicking the button: `Welcome!` Each click changes the displayed message.

## Returning null

Sometimes we do not want to render anything. React allows a component to return `null`.

### Example

```

function Message({ show }) {
if (!show) {
return null;
}
return <h2>Hello Students!</h2>;
}

```

If `show` is `false`, nothing appears on the screen.

## Comparison of Conditional Rendering Methods

| Method | Best Used For |
|---|---|
| if | Complex conditions before returning JSX |
| if...else | Two separate return values |
| Ternary ( ? :) | Simple true/false conditions |
| Logical AND ( &&) | Show content only when condition is true |
| Logical OR (` |  |
| return null | Hide a component completely |

## Common Mistakes

### 1. Using if Inside JSX

❌ Incorrect

```

return (
<div>
{if (isLoggedIn)}
</div>
);

```

JavaScript statements like `if` cannot be written directly inside JSX. ✅ Correct

```

return (
<div>
{isLoggedIn ? "Welcome" : "Login"}
</div>
);

```

### 2. Forgetting Curly Braces

❌ Incorrect

```

<h2>isLoggedIn ? "Yes" : "No"</h2>

```

✅ Correct

```

<h2>{isLoggedIn ? "Yes" : "No"}</h2>

```

### 3. Using && with Numbers

```

const count = 0;
{count && <p>Items</p>}

```

Since `0` is falsy, nothing is rendered. Instead, write:

```

{count > 0 && <p>Items</p>}

```

## Best Practices

- Use the **ternary operator** for simple conditions.

- Use **if** statements for complex logic.

- Use **&&** when displaying optional elements.

- Return `null` when a component should not render.

- Keep conditional expressions short and readable.

- Avoid deeply nested ternary operators, as they reduce readability.

- Store complex conditions in variables before using them in JSX.

- Combine Conditional Rendering with `useState` to create interactive interfaces.

### Real-World Applications

Conditional Rendering is widely used in React applications, including:

- Login and Logout systems.

- Role-based dashboards (Admin/User).

- Shopping cart notifications.

- Loading indicators while fetching data.

- Error and success messages.

- Online quiz result pages.

- Product availability status.

- Theme switching (Light/Dark mode).

- Displaying user profile information.

- Showing or hiding navigation menus.

These applications rely on Conditional Rendering to provide personalized and responsive user experiences.

### Conclusion

Conditional Rendering is a core feature of React that allows developers to display different content based on specific conditions. By using JavaScript techniques such as `if`, `if...else`, the ternary operator, logical `&&`, logical `||`, and `return null`, we can build dynamic and interactive user interfaces. When combined with the `useState` Hook, Conditional Rendering enables applications to respond instantly to user actions and changing data. Mastering this concept is essential for developing professional, user-friendly, and responsive React applications.');

-- Lecture 9: Lists & Keys in React
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Lists & Keys in React', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Lists & Keys in React

Lists and Keys are fundamental concepts in React that allow developers to display multiple pieces of data efficiently. Instead of writing the same JSX repeatedly, React enables us to generate UI elements dynamically from arrays using JavaScript methods such as `map()`. To help React identify each item uniquely, every rendered element in a list should have a **key**. Imagine a classroom attendance sheet. Every student has a unique roll number, making it easy for the teacher to identify each student even if their seating arrangement changes. Similarly, React uses **keys** to uniquely identify elements in a list, ensuring efficient updates and better performance.

## What are Lists in React?

### Definition

A **List** in React is a collection of similar elements displayed by looping through an array and rendering JSX for each item. Instead of manually creating multiple elements, React allows us to generate them dynamically using JavaScript.

### Why Do We Use Lists?

Lists help us:

- Display multiple items efficiently.

- Reduce repetitive code.

- Improve code readability.

- Make applications dynamic.

- Render data received from APIs or databases.

### Real-Life Examples

Lists are commonly used to display:

- Product catalogs

- Student records

- Employee lists

- Shopping cart items

- News articles

- Comments on social media

- Search results

- Notifications

- Messages

- Menu items

## Rendering Lists Using map()

The `map()` method is the most common way to render lists in React.

### What is map()?

The `map()` method loops through each item in an array and returns a new array of JSX elements.

### Basic Example

```

function App() {
const fruits = [
"Apple",
"Banana",
"Mango"
];
return (
<ul>
{fruits.map((fruit) => (
<li>{fruit}</li>
))}
</ul>
);
}

```

### Output

```

• Apple
• Banana
• Mango

```

Each fruit in the array becomes a separate `<li>` element.

### Rendering Numbers

```

const numbers = [10, 20, 30];
function App() {
return (
<>
{numbers.map((num) => (
<h2>{num}</h2>
))}
</>
);
}

```

Output:

```

10
20
30

```

## Understanding Keys

### Definition

A **Key** is a unique identifier assigned to elements in a list. It helps React determine which items have changed, been added, or removed. Keys improve rendering performance and prevent unnecessary updates.

### Why are Keys Important?

React uses keys to:

- Identify individual list items.

- Track changes efficiently.

- Improve rendering performance.

- Minimize unnecessary DOM updates.

- Maintain component state correctly.

Without keys, React may not correctly update the user interface when list data changes.

### Basic Syntax

```

array.map((item) => (
<Component key={uniqueValue} />
));

```

## Using Keys Correctly

### Using a Unique ID

The best practice is to use a unique ID from the data.

```

const students = [
{ id: 1, name: "Ali" },
{ id: 2, name: "Sara" },
{ id: 3, name: "Ahmed" }
];
function App() {
return (
<ul>
{students.map((student) => (
<li key={student.id}>
{student.name}
</li>
))}
</ul>
);
}

```

### Output

```

• Ali
• Sara
• Ahmed

```

Using a unique ID is the recommended approach.

### Using the Array Index

If unique IDs are unavailable, the array index can be used.

```

const fruits = [
"Apple",
"Banana",
"Mango"
];
function App() {
return (
<ul>
{fruits.map((fruit, index) => (
<li key={index}>
{fruit}
</li>
))}
</ul>
);
}

```

Although this works, it is generally recommended only for static lists that never change order.

## Rendering Objects in Lists

Lists often contain objects instead of simple strings.

### Example

```

const employees = [
{
id: 1,
name: "Ali",
department: "HR"
},
{
id: 2,
name: "Sara",
department: "IT"
}
];
function App() {
return (
<div>
{employees.map((employee) => (
<div key={employee.id}>
<h2>{employee.name}</h2>
<p>{employee.department}</p>
</div>
))}
</div>
);
}

```

Output:

```

Ali
HR
Sara
IT

```

React creates one section for each employee object.

## Rendering Components in a List

Instead of rendering HTML elements directly, we can render reusable components.

### Student Component

```

function Student({ name }) {
return <h2>{name}</h2>;
}

```

### App Component

```

const students = [
{
id: 1,
name: "Ali"
},
{
id: 2,
name: "Sara"
}
];
function App() {
<>
{students.map((student) => (
<Student
key={student.id}
name={student.name}
/>
))}
</>
);
}

```

Each student is displayed using the reusable `Student` component.

## Filtering Lists Before Rendering

We can combine `filter()` with `map()` to display only selected items.

### Example

```

const numbers = [
10,
15,
20,
25
];
function App() {
return (
<>
{numbers
.filter((num) => num > 15)
.map((num) => (
<h2 key={num}>
{num}
</h2>
))}
</>
);
}

```

### Output

```

20
25

```

Only numbers greater than 15 are displayed.

## Common Mistakes

### 1. Forgetting the Key

❌ Incorrect

```

{students.map((student) => (
<li>
{student.name}
</li>
))}

```

React displays a warning because each list item needs a unique key. ✅ Correct

```

{students.map((student) => (
<li key={student.id}>
{student.name}
</li>
))}

```

### 2. Using Non-Unique Keys

❌ Incorrect `<li key="student">` Every item receives the same key, which causes React to misidentify list elements.

### 3. Using Index for Dynamic Lists

Using the array index is not recommended when items can be:

- Added

- Removed

- Reordered

Instead, use a unique ID whenever possible.

## Keys vs Props

| Feature | Keys | Props |
|---|---|---|
| Purpose | Identify list items | Pass data to components |
| Accessible Inside Component | No | Yes |
| Required for Lists | Yes | Optional |
| Helps React Update UI | Yes | No |
| Passed by Parent | Yes | Yes |

## Performance Benefits of Keys

Keys allow React to:

- Update only the necessary components.

- Reduce unnecessary re-rendering.

- Improve application performance.

- Preserve component state when lists change.

Without proper keys, React may recreate elements unnecessarily, resulting in slower performance and unexpected behavior.

## Best Practices

- Always provide a unique `key` for list items.

- Prefer unique IDs over array indexes.

- Use the `map()` method for rendering lists.

- Combine `filter()` and `map()` when displaying selected data.

- Keep list-rendering code clean and readable.

- Use reusable components for large lists.

- Avoid duplicate keys.

- Do not use randomly generated values (such as `Math.random()`) as keys because they change on every render.

### Real-World Applications

Lists and Keys are used in almost every React application, including:

- E-commerce product listings.

- Student and employee management systems.

- Shopping carts.

- Social media posts and comments.

- Online chat applications.

- News feeds.

- Search results.

- To-do lists.

- Music playlists.

- Notification panels.

These applications depend on lists to display dynamic data efficiently and on keys to ensure React updates the interface correctly.

### Conclusion

Lists and Keys are essential features in React for displaying collections of data efficiently. By using JavaScript\'s `map()` method, we can dynamically generate user interface elements from arrays, eliminating repetitive code. Keys provide unique identifiers that help React efficiently detect changes, update only the necessary elements, and maintain component state. Following best practices—such as using unique IDs, avoiding duplicate keys, and rendering reusable components—ensures that React applications remain fast, scalable, and easy to maintain. Mastering Lists and Keys is a crucial step toward building professional, data-driven React applications.');

-- Lecture 10: Forms in React
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Forms in React', 10, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Forms in React

Forms are one of the most essential features of web applications because they allow users to enter, update, and submit data. Whether users are logging in, registering, searching, placing orders, or providing feedback, forms make user interaction possible. In React, forms are managed differently from traditional HTML. Instead of letting the browser control form data, React typically uses **state** to control the values of form elements. This approach provides better control, easier validation, and a more interactive user experience. Think of a form as a conversation between the user and the application. The user provides information, React processes it, and the application responds accordingly.

## What are Forms in React?

### Definition

A **React Form** is a collection of input elements used to collect user data. React manages form data using **state** and event handlers, making forms interactive and easy to control. Unlike traditional HTML forms, React often uses **Controlled Components**, where React state becomes the single source of truth.

### Common Uses of Forms

Forms are used in many applications, including:

- User login

- User registration

- Search bars

- Contact forms

- Online examinations

- Feedback forms

- Shopping checkout pages

- Payment forms

- Booking systems

- Profile editing

### Why Use React Forms?

React forms provide:

- Better control over input values.

- Easy validation.

- Dynamic updates.

- Improved user experience.

- Seamless integration with React state.

## Controlled Components

### Definition

A **Controlled Component** is a form element whose value is controlled by React state. The value displayed in the input field always comes from the component\'s state, and any changes are handled using the `onChange` event.

### Example

```

import { useState } from "react";
function App() {
const [name, setName] = useState("");
return (
<>
<input
type="text"
value={name}
onChange={(e) =>
setName(e.target.value)
}
/>
<h2>{name}</h2>
</>
);
}
export default App;

```

### How It Works

1. The input starts with an empty value. 2. The user types into the input field. 3. The `onChange` event is triggered. 4. `setName()` updates the state. 5. React re-renders the component with the updated value.

## Handling Different Form Inputs

React supports many types of form elements.

### 1. Text Input

```

const [username, setUsername] = useState("");
<input
type="text"
value={username}
onChange={(e) =>
setUsername(e.target.value)
}
/>

```

### 2. Password Input

```

const [password, setPassword] = useState("");
<input
type="password"
value={password}
onChange={(e) =>
setPassword(e.target.value)
}
/>

```

### 3. Textarea

```

const [message, setMessage] = useState("");
<textarea
value={message}
onChange={(e) =>
setMessage(e.target.value)
}
/>

```

### 4. Select Dropdown

```

const [city, setCity] = useState("");
<select
value={city}
onChange={(e) =>
setCity(e.target.value)
}
>
<option value="">Select City</option>
<option value="Lahore">Lahore</option>
<option value="Karachi">Karachi</option>
<option value="Islamabad">Islamabad</option>
</select>

```

### 5. Checkbox

```

const [accepted, setAccepted] = useState(false);
<input
type="checkbox"
checked={accepted}
onChange={(e) =>
setAccepted(e.target.checked)
}
/>

```

The `checked` property is used instead of `value` for checkboxes.

### 6. Radio Buttons

```

const [gender, setGender] = useState("");
<input
type="radio"
value="Male"
checked={gender === "Male"}
onChange={(e) =>
setGender(e.target.value)
}
/>
Male
<input
type="radio"
value="Female"
checked={gender === "Female"}
onChange={(e) =>
setGender(e.target.value)
}
/>
Female

```

Only one radio button can be selected at a time.

## Handling Form Submission

Forms are submitted using the `onSubmit` event.

### Example

```

import { useState } from "react";
function App() {
const [name, setName] = useState("");
function handleSubmit(event) {
event.preventDefault();
alert("Submitted: " + name);
}
return (
<form onSubmit={handleSubmit}>
<input
type="text"
value={name}
onChange={(e) =>
setName(e.target.value)
}
/>
<button type="submit">
Submit
</button>
</form>
);
}

```

### Why Use event.preventDefault()?

Normally, submitting an HTML form refreshes the webpage.

```

event.preventDefault();

```

This prevents the page from reloading, allowing React to handle the submission without interrupting the user experience.

## Handling Multiple Inputs

Instead of creating separate state variables for every input, we can store all form data in one object.

### Example

```

import { useState } from "react";
function App() {
const [formData, setFormData] = useState({
name: "",
email: ""
});
function handleChange(event) {
setFormData({
...formData,
[event.target.name]: event.target.value
});
}
return (
<>
<input
name="name"
value={formData.name}
onChange={handleChange}
/>
<input
name="email"
value={formData.email}
onChange={handleChange}
/>
</>
);
}

```

This approach is especially useful for large forms.

## Form Validation

Validation ensures users enter correct and complete information before submission.

### Simple Validation Example

```

function handleSubmit(event) {
event.preventDefault();
if (name === "") {
alert("Name is required.");
} else {
alert("Form Submitted");
}
}

```

Validation improves data quality and user experience.

### Common Validation Rules

- Required fields

- Minimum length

- Maximum length

- Email format

- Password strength

- Phone number format

- Numeric values only

## Controlled vs Uncontrolled Components

| Feature | Controlled Component | Uncontrolled Component |
|---|---|---|
| Data Managed By | React State | DOM |
| Value Controlled By | useState | HTML Input |
| Validation | Easy | More Difficult |
| Recommended | Yes | Rarely Used |
| Best For | Most React Forms | Simple or legacy forms |

React applications generally prefer **Controlled Components**.

## Common Mistakes

### 1. Forgetting onChange

❌ Incorrect

```

<input value={name} />

```

The input becomes read-only because React controls its value without allowing updates. ✅ Correct

```

<input
value={name}
onChange={(e) =>
setName(e.target.value)
}
/>

```

### 2. Forgetting preventDefault()

```

event.preventDefault();

```

Without it, the browser refreshes the page after form submission.

### 3. Updating State Incorrectly

❌ Incorrect

```

formData.name = "Ali";

```

Never modify state directly. ✅ Correct

```

setFormData({
...formData,
name: "Ali"
});

```

Always use the setter function to update state.

## Best Practices

- Use **Controlled Components** whenever possible.

- Store form values in state using `useState`.

- Use descriptive variable names.

- Validate user input before submission.

- Prevent unnecessary page reloads using `event.preventDefault()`.

- Keep forms simple and organized.

- Group related form fields together.

- Use reusable input components for large applications.

- Display clear error messages when validation fails.

### Real-World Applications

React forms are widely used in modern web applications, including:

- Login and registration pages.

- Contact and feedback forms.

- Online shopping checkout.

- Job application forms.

- Student admission portals.

- Online examination systems.

- Hotel and flight booking forms.

- Banking applications.

- User profile management.

- Product review and rating forms.

These applications rely on React forms to collect, validate, and process user information efficiently.

### Conclusion

Forms are a vital part of React applications because they enable users to interact with the system by entering and submitting data. By using **Controlled Components**, the `useState` Hook, and event handlers such as `onChange` and `onSubmit`, React provides complete control over form data and user interactions. Features like validation, multiple input handling, and proper state management help developers create reliable, secure, and user-friendly forms. Mastering React forms is an essential step toward building professional web applications that efficiently collect and process user information.');

-- Lecture 11: useEffect Hook & Side Effects
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'useEffect Hook & Side Effects', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# useEffect Hook & Side Effects

The **useEffect Hook** is one of the most powerful and frequently used Hooks in React. While the `useState` Hook manages a component\'s data, the `useEffect` Hook manages tasks that happen **after** the component has been rendered. These tasks are called **side effects**. Side effects include activities such as fetching data from an API, updating the browser title, setting timers, subscribing to events, or interacting with external systems. Without `useEffect`, handling these operations in Functional Components would be difficult. Think of a classroom. The teacher first writes the lesson on the board (rendering the UI). After that, students ask questions, attendance is taken, and homework is assigned. These additional activities are similar to **side effects** —they happen after the main task is completed.

## What is the useEffect Hook?

### Definition

The **useEffect Hook** is a built-in React Hook that allows Functional Components to perform **side effects** after rendering. It replaces lifecycle methods such as `componentDidMount()`, `componentDidUpdate()`, and `componentWillUnmount()` that were used in Class Components.

### Importing useEffect

Before using `useEffect`, import it from React.

```

import { useEffect } from "react";

```

### Basic Syntax

```

useEffect(() => {
// Side effect code
});

```

The function inside `useEffect()` runs **after every render** by default.

### Example

```

import { useEffect } from "react";
function App() {
useEffect(() => {
console.log("Component Rendered");
});
return <h1>Hello React</h1>;
}

```

Every time the component renders, the message appears in the browser console.

## What are Side Effects?

### Definition

A **side effect** is any operation that affects something outside the component or interacts with external resources. Unlike rendering JSX, side effects perform tasks such as retrieving data, updating the browser, or communicating with APIs.

### Examples of Side Effects

- Fetching data from an API.

- Updating the webpage title.

- Setting timers.

- Listening for keyboard or mouse events.

- Accessing local storage.

- Starting animations.

- Opening WebSocket connections.

- Playing audio or video.

- Logging information to the console.

### Why Do We Need Side Effects?

Without side effects, React applications could only display static content. Side effects make applications interactive and capable of working with external data and browser features.

## Dependency Array

The second argument of `useEffect` is called the **dependency array**. It controls **when** the effect should run.

### 1. No Dependency Array

```

useEffect(() => {
console.log("Runs after every render");
});

```

### Behavior

- Runs after the initial render.

- Runs after every re-render.

### 2. Empty Dependency Array

```

useEffect(() => {
console.log("Runs only once");
}, []);

```

### Behavior

- Runs only once after the component is first rendered.

- Similar to `componentDidMount()` in Class Components.

This is commonly used for API requests.

### 3. Dependency Array with Variables

```

useEffect(() => {
console.log("Count Updated");
}, [count]);

```

### Behavior

The effect runs:

- On the initial render.

- Whenever `count` changes.

It does **not** run when unrelated state changes.

## useEffect with useState

The `useEffect` Hook is often used together with the `useState` Hook.

### Example

```

import { useState, useEffect } from "react";
function Counter() {
const [count, setCount] = useState(0);
useEffect(() => {
console.log("Count changed:", count);
}, [count]);
return (
<>
<h2>{count}</h2>
<button
onClick={() => setCount(count + 1)}
>
Increase
</button>
</>
);
}

```

Whenever the button is clicked:

- The state updates.

- The component re-renders.

- `useEffect` executes because `count` changed.

## Common Uses of useEffect

### 1. Updating the Browser Title

```

import { useState, useEffect } from "react";
function App() {
const [count, setCount] = useState(0);
useEffect(() => {
document.title = `Count: ${count}`;
}, [count]);
return (
<button
onClick={() => setCount(count + 1)}
>
Increase
</button>
);
}

```

The browser tab title updates whenever the counter changes.

### 2. Fetching Data from an API

```

import { useEffect } from "react";
function App() {
useEffect(() => {
fetch("https://jsonplaceholder.typicode.com/users")
.then((response) => response.json())
.then((data) => console.log(data));
}, []);
return <h1>Users</h1>;
}

```

The API request runs only once after the component loads.

### 3. Setting a Timer

```

import { useEffect } from "react";
function App() {
useEffect(() => {
const timer = setInterval(() => {
console.log("Running");
}, 1000);
return () => clearInterval(timer);
}, []);
return <h1>Timer</h1>;
}

```

The timer starts when the component mounts and stops when it unmounts.

## Cleanup Function

Some side effects need cleanup to avoid memory leaks. A cleanup function is returned from `useEffect`.

### Syntax

```

useEffect(() => {
// Side effect
return () => {
// Cleanup code
};
}, []);

```

### Example

```

useEffect(() => {
window.addEventListener("resize", handleResize);
return () => {
window.removeEventListener("resize", handleResize);
};
}, []);

```

This removes the event listener when the component is removed from the page.

## Execution Flow of useEffect

Consider this example:

```

useEffect(() => {
console.log("Effect Executed");
}, [count]);

```

### Execution Flow

1. Component renders. 2. React displays the UI. 3. `useEffect` runs. 4. User updates `count`. 5. Component re-renders. 6. `useEffect` runs again because `count` changed. This ensures that side effects always execute **after** rendering.

## Common Mistakes

### 1. Missing Dependency Array

```

useEffect(() => {
console.log("Runs repeatedly");
});

```

Without a dependency array, the effect executes after every render, which may cause unnecessary processing.

### 2. Incorrect Dependencies

```

useEffect(() => {
console.log(count);
}, []);

```

If `count` changes, this effect will not run because it is missing from the dependency array. Correct:

```

useEffect(() => {
console.log(count);
}, [count]);

```

### 3. Forgetting Cleanup

```

setInterval(() => {
console.log("Running");
}, 1000);

```

Without cleanup, multiple timers continue running and waste system resources. Always clear timers and remove event listeners when necessary.

## useEffect vs useState

| Feature | useState | useEffect |
|---|---|---|
| Purpose | Store and update state | Perform side effects |
| Returns | State value and setter function | Nothing |
| Causes Re-render | Yes | No (unless state is updated inside it) |
| Common Uses | Forms, counters, toggles | API calls, timers, event listeners |
| Runs | During rendering | After rendering |

## Best Practices

- Use `useEffect` only for side effects.

- Always provide a dependency array when appropriate.

- Include all required dependencies in the array.

- Use cleanup functions for timers, subscriptions, and event listeners.

- Keep effects small and focused on one task.

- Avoid updating state unnecessarily inside `useEffect`, as it can cause repeated re-renders.

- Separate unrelated side effects into different `useEffect` Hooks.

- Test effects carefully to ensure they run at the correct times.

### Real-World Applications of useEffect

The `useEffect` Hook is widely used in modern React applications, including:

- Fetching data from REST APIs.

- Displaying weather information.

- Updating page titles dynamically.

- Implementing authentication checks.

- Managing timers and countdowns.

- Listening for keyboard and mouse events.

- Synchronizing data with local storage.

- Real-time chat applications using WebSockets.

- Tracking user activity.

- Loading user profiles after login.

These applications rely on `useEffect` to perform tasks that occur after the user interface has been rendered.

### Conclusion

The `useEffect` Hook is a fundamental part of modern React development because it enables Functional Components to perform side effects efficiently. Whether fetching data, updating the document title, managing timers, or handling event listeners, `useEffect` ensures these operations occur after the component has rendered. Understanding dependency arrays, cleanup functions, and the execution flow of `useEffect` allows developers to create responsive, efficient, and maintainable React applications. Mastering this Hook is essential for building real-world applications that interact with external systems and provide a smooth user experience.');

-- Lecture 12: Context API
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Context API', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Context API

The **Context API** is a built-in feature of React that allows data to be shared across multiple components without passing props manually through every level of the component tree. As React applications grow larger, passing the same data through many intermediate components becomes difficult and repetitive. This problem is known as **Prop Drilling**. The Context API solves this issue by providing a central place where data can be stored and accessed by any component that needs it. Think of the Context API like a **school notice board**. Instead of every teacher individually informing each student about an announcement, the notice is placed on a central board where everyone can access it. Similarly, the Context API stores shared data in one place so that any component can read it without repeatedly passing props.

## What is the Context API?

### Definition

The **Context API** is a built-in React feature used to share data globally between components without passing props through every intermediate component. It helps manage data that is needed by multiple components.

### Why Do We Need the Context API?

Without the Context API, data must be passed from parent to child through props. For example:

```

App
└── Header
└── Navbar
└── UserProfile

```

If `UserProfile` needs user information, the data must pass through `Header` and `Navbar`, even though they do not use it. This unnecessary passing of props is called **Prop Drilling**. The Context API eliminates this problem.

### Common Uses

The Context API is commonly used for:

- User authentication

- Theme switching (Light/Dark mode)

- Language selection

- Shopping cart data

- User profile information

- Application settings

- Notifications

- Global configuration

## Creating Context

The first step is to create a context using `createContext()`.

### Import

```

import { createContext } from "react";

```

### Creating Context

```

import { createContext } from "react";
const UserContext = createContext();
export default UserContext;

```

`createContext()` creates a Context object that can be shared throughout the application.

## Provider Component

The **Provider** supplies data to all child components.

### Syntax

```

<UserContext.Provider value={data}>
<App />
</UserContext.Provider>

```

The `value` prop contains the shared data.

### Example

```

import UserContext from "./UserContext";
function App() {
const user = "Ali";
return (
<UserContext.Provider value={user}>
<Home />
</UserContext.Provider>
);
}

```

Now every child component inside `Home` can access the value `"Ali"`.

## Consuming Context with useContext

React provides the **useContext Hook** to access shared data.

### Import

```

import { useContext } from "react";

```

### Syntax

```

const value = useContext(UserContext);

```

### Example

```

import { useContext } from "react";
import UserContext from "./UserContext";
function Profile() {
const user = useContext(UserContext);
return <h2>{user}</h2>;
}

```

### Output

`Ali` The `Profile` component accesses the data directly without receiving props.

## Complete Example of Context API

### Step 1: Create Context

```

import { createContext } from "react";
const ThemeContext = createContext();
export default ThemeContext;

```

### Step 2: Provide Data

```

import ThemeContext from "./ThemeContext";
function App() {
return (
<ThemeContext.Provider value="Dark">
<Home />
</ThemeContext.Provider>
);
}

```

### Step 3: Consume Data

```

import { useContext } from "react";
import ThemeContext from "./ThemeContext";
function Home() {
const theme = useContext(ThemeContext);
return <h2>{theme} Theme</h2>;
}

```

### Output

`Dark Theme` This demonstrates how data flows from the Provider to child components.

## Context with Objects

The Provider can share objects as well as simple values.

### Example

```

const user = {
name: "Ali",
};
<UserContext.Provider value={user}>
<Profile />
</UserContext.Provider>

```

Accessing the data:

```

const user = useContext(UserContext);
return (
<>
<h2>{user.name}</h2>
<p>{user.age}</p>
</>
);

```

### Output

```

Ali
20

```

Objects allow multiple related values to be shared through one context.

## Context with useState

Context is often combined with the `useState` Hook to share dynamic data.

### Example

```

import { useState } from "react";
const [theme, setTheme] = useState("Light");
<ThemeContext.Provider
value={{ theme, setTheme }}
>
<App />
</ThemeContext.Provider>

```

Using the context:

```

const { theme, setTheme } = useContext(ThemeContext);
<button
onClick={() => setTheme("Dark")}
>
Change Theme
</button>

```

The shared theme updates automatically in every component using the context.

## Context API vs Props

| Feature | Context API | Props |
|---|---|---|
| Purpose | Share global data | Pass data between components |
| Data Flow | Direct access | Parent to child |
| Prop Drilling | Eliminates it | Can cause it |
| Best For | Shared application data | Component-specific data |
| Complexity | Moderate | Simple |

## Advantages of Context API

- Eliminates prop drilling.

- Simplifies data sharing.

- Reduces repetitive code.

- Improves code readability.

- Built into React (no additional library required).

- Works well with Hooks.

- Makes global data easier to manage.

## Limitations of Context API

Although the Context API is powerful, it is not always the best solution. Some limitations include:

- Frequent updates can cause unnecessary re-renders.

- Large applications may become difficult to manage with many contexts.

- Not intended as a complete replacement for advanced state management libraries.

For very large applications with complex global state, libraries like **Redux** or **Zustand** may be more suitable.

## Common Mistakes

### 1. Forgetting the Provider

❌ Incorrect

```

const user = useContext(UserContext);

```

If the component is not wrapped inside `UserContext.Provider`, the value may be `undefined` or the default value.

### 2. Importing the Wrong Context

Always import the correct context object.

```

import UserContext from "./UserContext";

```

### 3. Using Context for Everything

The Context API should only store data that needs to be shared by multiple components. Avoid storing local component data in Context unnecessarily.

## Best Practices

- Use Context only for shared or global data.

- Keep contexts focused on a single responsibility (e.g., ThemeContext, AuthContext).

- Combine Context with `useState` or `useReducer` for dynamic data.

- Avoid creating too many nested Providers.

- Use meaningful names for contexts.

- Store only necessary global information in Context.

- Split large contexts into smaller ones when appropriate.

- Continue using props for component-specific data.

### Real-World Applications

The Context API is widely used in professional React applications, including:

- User authentication systems.

- Light and Dark theme switching.

- Multi-language applications.

- Shopping cart management.

- User profile information.

- Notification systems.

- Global application settings.

- Online learning platforms.

- Banking dashboards.

- E-commerce websites.

These applications use the Context API to efficiently share data across multiple components without excessive prop passing.

### Conclusion

The Context API is an essential React feature that simplifies the sharing of data across components. By eliminating prop drilling, it makes applications cleaner, easier to maintain, and more scalable. Using `createContext()`, `Provider`, and the `useContext` Hook, developers can efficiently manage global data such as themes, authentication, and application settings. Although it is not a replacement for advanced state management solutions in very large applications, the Context API is an excellent built-in tool for handling shared state in most React projects. Mastering the Context API is an important step toward building modern, maintainable, and efficient React applications.');

-- Lecture 13: React Router
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'React Router', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# React Router

React Router is a popular library used in React applications to enable **client-side routing**. In traditional websites, navigating from one page to another causes the browser to reload the entire webpage. However, React Router allows users to switch between different pages or views without refreshing the entire application. This creates faster, smoother, and more responsive web applications known as **Single Page Applications (SPAs)**. Think of React Router as a GPS navigation system. Instead of rebuilding the entire road every time you change your destination, the GPS simply changes the route while keeping you on the same journey. Similarly, React Router changes the displayed component without reloading the entire webpage.

## What is React Router?

### Definition

**React Router** is a routing library for React that allows developers to navigate between different components or pages in a Single Page Application without refreshing the browser. It maps URLs to React components, enabling smooth navigation.

### Why Do We Need React Router?

Without React Router:

- Every page navigation reloads the entire website.

- The application becomes slower.

- User experience is less interactive.

With React Router:

- Navigation is fast.

- Pages change instantly.

- Only the required component is updated.

- The application behaves like a desktop application.

### Real-Life Examples

React Router is commonly used in:

- E-commerce websites

- Social media platforms

- Learning management systems

- Banking applications

- Hospital management systems

- Portfolio websites

- Dashboard applications

- Blogging platforms

- News websites

- Online booking systems

## Installing React Router

React Router is installed using **npm**.

### Installation Command

`npm install react-router-dom` After installation, the routing features become available in the React project.

### Importing Required Components

```

import {
BrowserRouter,
Routes,
Route
} from "react-router-dom";

```

### Main Components

- `BrowserRouter`

- `Routes`

- `Route`

- `Link`

- `NavLink`

- `useNavigate`

- `useParams`

## BrowserRouter

### Definition

`BrowserRouter` is the main routing component. It wraps the entire React application and enables routing.

### Example

```

import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import {
BrowserRouter
} from "react-router-dom";
const root = ReactDOM.createRoot(
document.getElementById("root")
);
root.render(
<BrowserRouter>
<App />
</BrowserRouter>
);

```

Every component inside `BrowserRouter` can use routing features.

## Routes and Route

### Routes

The `Routes` component groups multiple routes together.

### Route

Each `Route` maps a URL path to a React component.

### Example

```

import {
Routes,
Route
} from "react-router-dom";
import Home from "./Home";
import About from "./About";
import Contact from "./Contact";
function App() {
return (
<Routes>
<Route
path="/"
element={<Home />}
/>
<Route
path="/about"
element={<About />}
/>
<Route
path="/contact"
element={<Contact />}
/>
</Routes>
);
}

```

### URL Mapping

| URL | Component Displayed |
|---|---|
| / | Home |
| /about | About |
| /contact | Contact |

## Navigation Using Link

Instead of HTML\'s `<a>` tag, React Router uses the **Link** component.

### Why Not Use ?

`<a>` The `<a>` tag reloads the webpage. `Link` changes the page without refreshing.

### Example

```

import { Link } from "react-router-dom";
function Navbar() {
return (
<nav>
<Link to="/">Home</Link>
<Link to="/about">About</Link>
<Link to="/contact">Contact</Link>
</nav>
);
}

```

Clicking the links updates the displayed page instantly.

## NavLink

`NavLink` works like `Link` but automatically applies styling to the active route.

### Example

```

import {
NavLink
} from "react-router-dom";
<NavLink to="/about">
About
</NavLink>

```

When the About page is active, `NavLink` can automatically apply an active class or style.

## useNavigate Hook

The `useNavigate` Hook allows navigation through JavaScript. It is useful after actions such as form submission or login.

### Import

```

import {
useNavigate
} from "react-router-dom";

```

### Example

```

import {
useNavigate
} from "react-router-dom";
function Login() {
const navigate = useNavigate();
function handleLogin() {
}
return (
<button
onClick={handleLogin}
>
Login
</button>
);
}

```

After clicking the button, the application navigates to the dashboard.

## Route Parameters

Sometimes URLs contain dynamic values. Example: `/products/10` Here, `10` represents a product ID.

### Creating a Dynamic Route

```

<Route
path="/product/:id"
element={<Product />}
/>

```

### Reading Parameters

```

import {
useParams
} from "react-router-dom";
function Product() {
const { id } = useParams();
return <h2>Product {id}</h2>;
}

```

If the URL is: `/product/25` Output: `Product 25`

## Nested Routes

React Router supports routes inside other routes.

### Example

```

<Route
path="/dashboard"
element={<Dashboard />}
>
<Route
path="profile"
element={<Profile />}
/>
<Route
path="settings"
element={<Settings />}
/>
</Route>

```

Nested routes help organize large applications with multiple sections.

## 404 Page (Not Found Route)

React Router allows developers to display a custom page when no route matches.

### Example

```

<Route
path="*"
element={<NotFound />}
/>

```

If a user enters an invalid URL, the `NotFound` component is displayed.

## Common Mistakes

### 1. Forgetting BrowserRouter

❌ Incorrect `<App />` Without `BrowserRouter`, routing features will not work. ✅ Correct

```

<BrowserRouter>
<App />
</BrowserRouter>

```

### 2. Using Instead of

`<a> Link` ❌ Incorrect

```

<a href="/about">
About
</a>

```

This reloads the page. ✅ Correct

```

<Link to="/about">
About
</Link>

```

### 3. Incorrect Route Path

Always ensure the URL path matches the `Route` definition. Example:

```

<Route
path="/about"
element={<About />}
/>

```

Navigate using: `<Link to="/about">`

## Best Practices

- Wrap the application with `BrowserRouter`.

- Use `Link` instead of HTML anchor tags.

- Use `NavLink` for navigation menus.

- Use meaningful route names.

- Organize routes logically.

- Use nested routes for large applications.

- Display a custom 404 page for invalid URLs.

- Use `useNavigate` for programmatic navigation.

- Use `useParams` for dynamic route values.

- Keep routing code clean and easy to maintain.

### Real-World Applications

React Router is used in almost every modern React application, including:

- Student management systems.

- Banking dashboards.

- Hospital management software.

- Portfolio websites.

- Blogging platforms.

- Learning management systems.

- Social networking websites.

- Hotel booking applications.

- Online food ordering systems.

These applications depend on React Router to provide smooth, fast, and efficient navigation without reloading the webpage.

### Conclusion

React Router is an essential library for building modern React applications because it enables seamless navigation between different pages without refreshing the browser. Using components such as `BrowserRouter`, `Routes`, `Route`, `Link`, and `NavLink`, along with Hooks like `useNavigate` and `useParams`, developers can create fast, dynamic, and user-friendly Single Page Applications. By understanding routing concepts, dynamic routes, nested routes, and best practices, developers can build scalable and maintainable applications that provide an excellent user experience. Mastering React Router is a key milestone in becoming a proficient React developer.');

-- Lecture 14: Building a React Application – Draggable To-Do List App
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a React Application – Draggable To-Do List App', 14, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a React Application – Draggable To-Do List App

Building a complete React application is the best way to combine everything we have learned into one practical project. Instead of studying concepts individually, we now use them together to create a real-world application. In these lecture notes, we will develop a **Draggable To-Do List App** with a **premium, minimal design**. The project will allow users to add tasks, mark them as completed, delete them, and rearrange them using drag-and-drop functionality. By the end of these notes, we will have a complete React project that demonstrates state management, event handling, conditional rendering, lists, Hooks, component-based architecture, and local storage. Imagine your project as a digital notebook. Instead of writing tasks on sticky notes that can easily be lost, you organize them neatly in a beautiful application where tasks can be moved around effortlessly.

## Project Overview

### Project Name

**Premium Draggable To-Do List**

### Project Features

Our application will include:

- Add new tasks

- Delete tasks

- Mark tasks as completed

- Drag and drop tasks

- Store tasks using Local Storage

- Responsive design

- Smooth animations

- Modern typography

- Clean color palette

### Technologies Used

- React

- JavaScript (ES6+)

- JSX

- CSS

- React Hooks

- Local Storage

- Drag and Drop API (or `react-beautiful-dnd`)

- React Icons (Optional)

### Final Application Structure

```

Todo-App/
│
├── public/
│
├── src/
│ ├── components/
│ │ Navbar.jsx
│ │ TodoInput.jsx
│ │ TodoItem.jsx
│ │ TodoList.jsx
│ │
│ ├── App.jsx
│ ├── App.css
│ ├── index.js
│
└── package.json

```

Keeping files organized makes projects easier to maintain.

## Creating the React Project

### Step 1: Create Project

```

npx create-react-app todo-app

```

or using Vite: `npm create vite@latest`

### Step 2: Install Dependencies

`npm install`

### Step 3: Start Development Server

`npm start` or for Vite: `npm run dev`

### Step 4: Install Drag and Drop Library

```

npm install @hello-pangea/dnd

```

This library provides modern drag-and-drop functionality and is the maintained successor to `react-beautiful-dnd`.

## Designing the User Interface

A premium application focuses on simplicity rather than unnecessary decorations.

### Color Palette

| Element | Color |
|---|---|
| Background | #F8FAFC |
| Cards | #FFFFFF |
| Primary | #6366F1 |
| Accent | #8B5CF6 |
| Success | #22C55E |
| Delete | #EF4444 |
| Text | #1E293B |
| Border | #E2E8F0 |

### Typography

Use:

- Poppins

- Inter

- Nunito

### UI Components

The application contains:

- Header

- Input field

- Add button

- Task cards

- Complete button

- Delete button

- Footer

Everything is centered with generous spacing for a clean, premium look.

## Building Components

React applications are built from reusable components.

### App Component

Responsible for:

- Managing state

- Rendering components

- Passing props

### TodoInput Component

Responsibilities:

- Receive user input

- Add tasks

- Clear input field

Example:

```

<TodoInput addTodo={addTodo} />

```

### TodoList Component

Displays every task.

```

<TodoList todos={todos} />

```

### TodoItem Component

Each task contains:

- Task title

- Complete button

- Delete button

- Drag handle

Example:

```

<TodoItem
todo={todo}
deleteTodo={deleteTodo}
toggleTodo={toggleTodo}
/>

```

## Managing State with useState

Our application stores tasks using the `useState` Hook.

```

const [todos, setTodos] = useState([]);

```

Each task looks like:

```

{
id: 1,
text: "Complete React Project",
completed: false
}

```

### Adding a Task

When the Add button is clicked: 1. Read input. 2. Create a new object. 3. Update state. 4. Clear the input.

### Deleting a Task

```

setTodos(
todos.filter(todo => todo.id !== id)
);

```

### Completing a Task

`completed: !todo.completed` Completed tasks appear with:

- Green checkmark

- Line-through text

- Reduced opacity

## Rendering Tasks

React displays tasks using `map()`. Example:

```

todos.map(todo => (
<TodoItem
key={todo.id}
todo={todo}
/>
))

```

The `key` helps React identify each task efficiently.

## Implementing Drag and Drop

Drag-and-drop makes the application interactive.

### Basic Flow

1. User clicks a task. 2. Drags it. 3. Drops it into a new position. 4. State updates. 5. React re-renders.

### Main Components

```

<DragDropContext>
<Droppable>
<Draggable>
</Draggable>
</Droppable>
</DragDropContext>

```

### Benefits

- Better user experience

- Flexible task organization

- Professional interface

- Interactive behavior

## Saving Data with Local Storage

Without Local Storage: Closing the browser removes all tasks. With Local Storage: Tasks remain even after refreshing.

### Saving Data

```

localStorage.setItem(
"todos",
JSON.stringify(todos)
);

```

### Loading Data

```

const savedTodos =
JSON.parse(
localStorage.getItem("todos")
);

```

Using `useEffect`, we can automatically save and retrieve tasks whenever the application loads or the task list changes.

## Styling the Application

A premium design emphasizes simplicity.

### Design Principles

- Soft shadows

- Rounded corners

- Plenty of white space

- Smooth transitions

- Consistent spacing

- Minimal icons

### Card Example

`──────────────────────────` ✓ `Complete Assignment ──────────────────────────`

### Hover Effect

- Slight scale increase

- Shadow becomes darker

- Smooth transition (0.3s)

### Buttons

Primary:

- Indigo

Delete:

- Red

Complete:

- Green

All buttons use rounded corners and subtle animations.

## Folder Organization

```

src
│
├── components
│ TodoInput.jsx
│ TodoItem.jsx
│ TodoList.jsx
│
├── App.jsx
├── App.css
├── index.js

```

Small reusable components improve readability and maintainability.

## Common Mistakes

### 1. Forgetting Keys

Incorrect:

```

todos.map(todo =>
<TodoItem />
)

```

Correct:

```

todos.map(todo =>
<TodoItem
key={todo.id}
/>
)

```

### 2. Updating State Directly

Incorrect:

```

todos.push(newTodo);

```

Correct:

```

setTodos([...todos, newTodo]);

```

### 3. Missing Local Storage

Without Local Storage, tasks disappear after refreshing. Always synchronize state with Local Storage.

### 4. Forgetting Drag-and-Drop IDs

Every draggable item must have a unique identifier.

## Best Practices

- Keep components small and reusable.

- Use descriptive variable names.

- Store tasks as objects, not strings.

- Use unique IDs for every task.

- Separate UI from business logic.

- Save data using Local Storage.

- Keep styling consistent.

- Avoid unnecessary re-renders.

- Organize project folders properly.

- Write clean, readable code.

## Possible Future Improvements

Once the basic application is complete, we can enhance it with additional features such as:

- Dark and Light mode

- Due dates

- Task categories

- Priority levels

- Search functionality

- Task filtering (All, Active, Completed)

- Progress bar

- Calendar integration

- Cloud synchronization

- User authentication

- Notifications and reminders

- Mobile-friendly gestures

These improvements make the project more practical and portfolio-worthy.

## Learning Outcomes

After completing this project, we will have practiced:

- Creating a React project

- Building reusable Functional Components

- Managing state with `useState`

- Using `useEffect` for Local Storage

- Handling events

- Rendering lists with `map()`

- Using unique keys

- Conditional rendering

- Passing props between components

- Implementing drag-and-drop functionality

- Designing a modern and responsive user interface

- Organizing a scalable React project structure

### Conclusion

Building a **Draggable To-Do List App** is an excellent way to bring together the core concepts of React into one complete, real-world project. Throughout this application, we use Functional Components, Hooks, props, state, conditional rendering, lists, event handling, Local Storage, and drag-and-drop functionality to create a responsive and interactive user experience. By following clean coding practices and designing a premium minimal interface with elegant colors and smooth interactions, we not only strengthen our React skills but also produce a professional-quality project suitable for a portfolio. Completing this application marks an important milestone toward becoming a confident and capable React developer.');
