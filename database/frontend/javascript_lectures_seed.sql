-- =============================================
-- ReflectAI — JavaScript Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'JavaScript' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to JavaScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to JavaScript', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to JavaScript

## What is JavaScript and Why Does It Matter?

Let us begin with a question we often overlook: what makes a website interactive ? Why do buttons respond, forms validate instantly, and pages update without refreshing? The answer lies in **JavaScript**. JavaScript is a high-level, dynamic programming language primarily used to create interactive effects within web browsers. If HTML is the skeleton and CSS is the skin, then JavaScript is the nervous system—it brings everything to life. Initially developed for simple tasks like form validation, JavaScript has evolved into a powerful language capable of building full-scale web applications, mobile apps, and even server-side systems. Why should we learn it? Because JavaScript is everywhere. It runs in browsers, powers modern frameworks, and forms the backbone of web development.

## Basic Syntax and Structure of JavaScript

Before we dive deep, we must understand the building blocks. Just like learning a new spoken language, we begin with vocabulary and grammar.

### A. Writing Your First JavaScript Code

Let us start simple:

```

console.log("Hello, JavaScript!");

```

This line prints output to the browser console. It may seem small, but it introduces us to execution and output.

### B. Variables and Data Types

Variables store data. In JavaScript, we declare them using:

- `var` (older way)

- `let` (modern and preferred)

- `const` (for constant values)

```

let name = "John";
const age = 25;

```

JavaScript supports different data types:

- String → text

- Number → numeric values

- Boolean → true/false

- Undefined and Null

Think of variables as containers holding different kinds of information.

## Operators and Expressions

Operators perform operations:

- Arithmetic (`+`, `-`, `*`, `/`)

- Comparison (`==`, `===`, `>`, `<`)

- Logical (`&&`, `||`)

They allow us to manipulate data and make decisions.

## Control Structures and Functions

Now that we have data, what do we do with it? We control the flow of execution.

### A. Conditional Statements

Conditions help us make decisions.

```

if (age > 18) {
console.log("Adult");
} else {
console.log("Minor");
}

```

This is like asking: Should we go outside? If it rains, we stay in; otherwise, we go out.

### B. Loops

Loops allow us to repeat actions.

```

for (let i = 0; i < 5; i++) {
console.log(i);
}

```

Instead of writing the same code multiple times, we automate repetition.

## Functions

Functions are reusable blocks of code.

```

function greet(name) {
return "Hello " + name;
}

```

Think of functions as machines: input goes in, processing happens, and output comes out. Functions improve:

- Reusability

- Organization

- Readability

## Objects and the Document Object Model (DOM)

Here is where JavaScript becomes truly powerful.

### A. Objects in JavaScript

Objects store data in key-value pairs.

```

let person = {
name: "Ali",
age: 22
};

```

Objects represent real-world entities. They combine properties and behaviors in one structure.

### B. The DOM (Document Object Model)

Now let us ask: how does JavaScript interact with a webpage? The answer is the **DOM**. It represents the HTML document as a tree structure. Using JavaScript, we can:

- Change content

- Modify styles

- Add or remove elements

Example:

```

document.getElementById("demo").innerHTML = "Hello World!";

```

This line changes the content of an HTML element. Think of the DOM as a bridge between JavaScript and HTML.

## Event Handling

JavaScript responds to user actions like clicks, typing, or mouse movement.

```

button.addEventListener("click", function() {
alert("Button clicked!");
});

```

Events make applications interactive and responsive.

## Modern JavaScript and Practical Usage

JavaScript has evolved significantly. Let us explore some modern concepts.

### A. ES6 Features

Modern JavaScript (ES6 and beyond) introduced:

- Arrow functions

- Template literals

- Destructuring

- Modules

Example:

```

const add = (a, b) => a + b;

```

Cleaner, shorter, and more expressive.

### B. Asynchronous Programming

JavaScript can handle tasks like fetching data from servers without freezing the page. Concepts include:

- Callbacks

- Promises

- Async/Await

```

async function fetchData() {
let response = await fetch("url");
let data = await response.json();
}

```

This allows smooth user experiences.

## Real-World Applications

JavaScript is used in:

- Web development (front-end and back-end)

- Mobile apps

- Game development

- APIs and server-side programming

Frameworks like React, Angular, and Node.js extend its capabilities even further.

### Conclusion

JavaScript is more than just a scripting language—it is the heartbeat of modern web development. It transforms static pages into dynamic, interactive experiences that respond to users in real time. We explored its fundamentals, from variables and functions to objects and the DOM, and saw how modern features make development more efficient. As we continue learning, we realize that JavaScript is not just about writing code—it is about creating experiences. So let us ask ourselves: are we simply building websites, or are we crafting interactive worlds? With JavaScript in our hands, the possibilities are endless.');

-- Lecture 2: Variables & Data Types
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Variables & Data Types', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Variables & Data Types

## Introduction to Variables

Let us begin with a simple idea: how does a program remember anything? If we calculate a number, store a name, or track a user’s input— where does all that information go? The answer lies in **variables**. A variable is like a labeled container. Imagine placing water, juice, or oil into different bottles and labeling them accordingly. In programming, variables hold data, and their names help us identify what is stored inside. For example:

```

let age = 20;

```

Here, `age` is the container, and `20` is the value inside it. Variables allow us to:

- Store data

- Modify values

- Reuse information

Without variables, programming would be like trying to write without memory—impossible and chaotic.

## Declaring Variables in Programming

Now that we understand what variables are, let us explore how we create them.

### A. Variable Declaration

In modern programming languages like JavaScript, we use:

- `let` → for values that can change

- `const` → for values that remain constant

- `var` → older method (less recommended)

```

let name = "Ali";
const pi = 3.14;

```

Why different keywords? Because they define how flexible or restricted the variable is.

### B. Naming Rules and Conventions

Variable names must follow certain rules:

- Cannot start with numbers

- Cannot contain spaces

- Should not use reserved keywords

Good naming is important. Consider this:

```

let x = 50;

```

Versus:

```

let totalMarks = 50;

```

Which one is clearer? Obviously the second. Naming is not just syntax—it is communication.

## Scope of Variables

Scope defines where a variable can be accessed.

- **Local scope** → accessible within a block

- **Global scope** → accessible throughout the program

```

let globalVar = "I am global";
function test() {
let localVar = "I am local";
}

```

Understanding scope prevents confusion and errors. Now let us ask: what kind of data can variables store? Numbers? Text? True or false values? The answer is all of the above, and more. Data types define the kind of value a variable can hold.

### A. Primitive Data Types

These are the basic building blocks.

### 1. Number

Represents numeric values.

```

let price = 100;

```

### 2. String

Represents text.

```

let message = "Hello World";

```

### 3. Boolean

Represents true or false.

```

let isActive = true;

```

### 4. Undefined and Null

- `undefined` → variable declared but not assigned

- `null` → intentionally empty value

These types help manage absence of data.

### B. Non-Primitive (Reference) Data Types

These are more complex structures.

### 1. Objects

```

let person = {
name: "Sara",
age: 25
};

```

Objects store multiple values in a single variable.

### 2. Arrays

```

let numbers = [1, 2, 3, 4];

```

Arrays store multiple values in an ordered list. Think of primitive types as single items, and reference types as collections.

## Dynamic Typing and Type Conversion

Here is something interesting—JavaScript is dynamically typed. But what does that mean?

### A. Dynamic Typing

In JavaScript, we do not need to declare a variable’s data type explicitly.

```

let value = 10;
value = "Now I am text";

```

The same variable can hold different types at different times. This flexibility is powerful, but it also requires caution.

### B. Type Conversion

Sometimes we need to convert data from one type to another.

### 1. Implicit Conversion

JavaScript automatically converts types.

```

let result = "5" + 2; // "52"

```

### 2. Explicit Conversion

We manually convert types.

```

let num = Number("5"); // 5

```

Why does this matter? Because incorrect conversions can lead to unexpected results.

## Type Checking

We can check a variable’s type using:

```

typeof value;

```

This helps us debug and understand our data.

## Best Practices and Real-World Understanding

### A. Importance of Variables and Data Types

Let us reflect: why are variables and data types so important? They:

- Store and manage data

- Enable logical operations

- Form the foundation of all programs

Without them, programming would be impossible.

### B. Best Practices

To write clean and efficient code, we should:

- Use meaningful variable names

- Prefer `const` when values do not change

- Avoid unnecessary global variables

- Understand data types before using them

These practices improve readability and reduce errors.

## Common Mistakes

Beginners often:

- Confuse `null` and `undefined`

- Use incorrect data types

- Ignore type conversions

- Use unclear variable names

Avoiding these mistakes will make coding smoother.

## Real-World Analogy

Think of variables as labeled boxes in a warehouse:

- Each box has a label (name)

- Each box contains a specific item (data type)

If labels are unclear or items are mixed, confusion arises. The same applies to programming.

### Conclusion

Variables and data types are the foundation of programming. They allow us to store, organize, and manipulate data efficiently. From simple numbers and strings to complex objects and arrays, they form the building blocks of every application. We explored how variables are declared, how data types define their content, and how dynamic typing adds flexibility. Along the way, we saw how proper usage leads to clean and reliable code. As we continue our journey, let us remember this: mastering variables and data types is like learning the alphabet of programming. Once we understand them deeply, we can build anything—from simple scripts to complex systems—with confidence and clarity.');

-- Lecture 3: Operators & Expressions
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Operators & Expressions', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Operators & Expressions

## Introduction to Operators and Expressions

Let us start with a simple thought: how does a program do anything? Storing data is one thing, but how do we manipulate it, compare it, or make decisions based on it? This is where **operators and expressions** step in. An **operator** is a symbol that performs an operation on values, while an **expression** is a combination of variables, values, and operators that produces a result. Think of it like basic mathematics:

- `5 + 3` → here, `+` is the operator

- The whole `5 + 3` → is an expression

In programming, expressions are everywhere. Every calculation, every decision, every condition relies on them. Without operators, our programs would be like calculators without buttons—completely useless.

## Types of Operators

Now let us explore the different types of operators. Each type serves a unique purpose, much like tools in a toolbox.

### A. Arithmetic Operators

These are the most familiar ones. They perform mathematical operations.

- `+` → Addition

- `-` → Subtraction

- `*` → Multiplication

- `/` → Division

- `%` → Modulus (remainder)

```

let result = 10 + 5;

```

Arithmetic operators help us perform calculations. Whether it is computing totals or processing data, they are essential.

### B. Assignment Operators

Assignment operators are used to assign values to variables.

- `=` → Assign

- `+=` → Add and assign

- `-=` → Subtract and assign

```

let x = 10;
x += 5; // x becomes 15

```

Think of this as updating the contents of a container.

## Comparison Operators

These operators compare values and return a boolean result (`true` or `false`).

- `==` → Equal to

- `===` → Strict equal (value + type)

- `!=` → Not equal

- `> < >= <=` → Relational comparisons

```

let check = (10 > 5); // true

```

These are crucial for decision-making.

## Logical Operators

Logical operators combine conditions.

- `&&` → AND

- `||` → OR

- `!` → NOT

```

let result = (10 > 5 && 5 < 3); // false

```

They act like reasoning tools, helping us evaluate multiple conditions.

### E. Increment and Decrement Operators

These operators increase or decrease values by one.

- `--` → Decrement

```

let a = 5;
a++; // a becomes 6

```

Simple, yet very useful in loops and counters.

## Understanding Expressions

Now that we know operators, let us talk about expressions. Remember, an expression is any combination that produces a value.

### A. Simple Expressions

These involve a single operation:

```

let sum = 5 + 3;

```

### B. Complex Expressions

These involve multiple operators:

```

let result = (5 + 3) * 2;

```

Here, multiple operations combine to produce a final value.

## Operator Precedence

Here is an important concept: not all operators are equal. Some are executed before others. For example:

```

let result = 5 + 3 * 2; // result is 11

```

Multiplication happens before addition. To control this, we use parentheses:

```

let result = (5 + 3) * 2; // result is 16

```

Think of precedence like rules in mathematics—order matters.

## Practical Use of Operators in Programming

Let us move from theory to real-world application.

### A. Decision Making

Operators help us make decisions:

```

if (age >= 18) {
console.log("Eligible to vote");
}

```

Here, the comparison operator determines the program’s path.

### B. Loop Control

Operators control loops:

```

for (let i = 0; i < 5; i++) {
console.log(i);
}

```

The increment operator and comparison operator work together.

## Data Manipulation

We use operators to modify data:

```

let total = 100;
total -= 20; // total becomes 80

```

This is common in applications like billing systems or games.

## Real-World Analogy

Think of operators as verbs in a sentence:

- Add

- Compare

- Change

- Decide

Expressions are complete sentences that produce meaning. Without verbs, sentences lose purpose—just like programs without operators.

## Best Practices and Common Pitfalls

### A. Best Practices

To use operators effectively, we should:

- Use parentheses for clarity

- Prefer strict equality (`===`) over loose equality (`==`)

- Keep expressions simple and readable

- Avoid overly complex conditions

Clarity is more important than cleverness.

### B. Common Mistakes

Many beginners:

- Confuse `==` with `===`

- Ignore operator precedence

- Write overly complex expressions

- Misuse logical operators

For example:

```

if (a = 5) // mistake (assignment instead of comparison)

```

Such errors can cause unexpected behavior.

## Debugging Expressions

When something goes wrong:

- Break expressions into smaller parts

- Print intermediate results

- Check operator usage

Debugging is like solving a puzzle—step by step.

### Conclusion

Operators and expressions are the driving force behind programming logic. They allow us to perform calculations, make decisions, and control the flow of execution. Without them, our programs would be static and lifeless. We explored different types of operators, how expressions are formed, and how they are used in real-world scenarios. Along the way, we learned the importance of clarity, correctness, and simplicity. As we continue our journey, let us remember: programming is not just about writing code—it is about expressing logic clearly. And operators are the language through which that logic comes to life.');

-- Lecture 4: Control Structures (If Statements and Loops)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Control Structures (If Statements and Loops)', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Control Structures (If Statements and Loops)

## Introduction to Control Structures

Control structures are one of the most important concepts in JavaScript because they determine the flow of a program. Imagine giving directions to a friend. You would not simply list every possible instruction at once. Instead, you would say things like, "If you see a traffic signal, stop," or "Keep walking until you reach the library." Programming works in much the same way. Control structures allow us to make decisions and repeat tasks without writing the same code repeatedly. Without them, programs would execute every statement from top to bottom without any flexibility. By using control structures, we can create dynamic applications that respond to user input, process data efficiently, and automate repetitive work. JavaScript mainly uses two categories of control structures:

- Decision-making statements (`if`, `else if`, `else`)

- Looping statements (`for`, `while`, `do...while`)

These structures make programs smarter, more organized, and easier to maintain.

## Decision Making with If Statements

### What is an If Statement?

An `if` statement is used to execute a block of code only when a specified condition is true. If the condition is false, the code inside the `if` block is skipped. **Syntax**

```

if (condition) {
// Code to execute if condition is true
}

```

**Example**

```

let age = 20;
if (age >= 18) {
console.log("You are eligible to vote.");
}

```

In this example, the condition `age >= 18` is true, so the message is displayed.

### The Else Statement

Sometimes we want to perform another action when the condition is false. The `else` statement handles this situation. **Syntax**

```

if (condition) {
// True block
} else {
// False block
}

```

**Example**

```

let age = 16;
if (age >= 18) {
console.log("Eligible to vote");
} else {
console.log("Not eligible to vote");
}

```

Since the condition is false, the second message is printed.

### The Else If Statement

What if there are multiple conditions? JavaScript provides the `else if` statement. **Syntax**

```

if (condition1) {
} else if (condition2) {
} else {
}

```

**Example**

```

let marks = 82;
if (marks >= 90) {
console.log("Grade A");
} else if (marks >= 80) {
console.log("Grade B");
} else if (marks >= 70) {
console.log("Grade C");
} else {
console.log("Fail");
}

```

The program checks each condition one by one until it finds a true condition.

### Nested If Statements

An `if` statement can be placed inside another `if` statement. **Example**

```

let age = 22;
let hasLicense = true;
if (age >= 18) {
if (hasLicense) {
console.log("You can drive.");
}
}

```

Nested conditions are useful when multiple requirements must be satisfied.

## Looping in JavaScript

### What are Loops?

Loops execute the same block of code repeatedly until a specified condition becomes false. Think of a teacher writing "Practice makes perfect" 100 times on the board. Instead of writing the statement repeatedly, a loop performs the repetition automatically. JavaScript supports three major loops:

- `for` loop

- `while` loop

- `do...while` loop

### The For Loop

A `for` loop is commonly used when we already know how many times we want to repeat a task. **Syntax**

```

for (initialization; condition; update) {
// Code
}

```

The three parts are:

- **Initialization:** Starts the loop variable.

- **Condition:** Determines whether the loop continues.

- **Update:** Changes the loop variable after each iteration.

**Example**

```

for (let i = 1; i <= 5; i++) {
console.log(i);
}

```

**Output**

```

1
2
3
4
5

```

The loop starts with `i = 1`, continues while `i <= 5`, and increases `i` by one after every iteration.

### Using For Loop with Arrays

Arrays often work together with loops. **Example**

```

let fruits = ["Apple", "Banana", "Mango"];
for (let i = 0; i < fruits.length; i++) {
console.log(fruits[i]);
}

```

This loop prints every element in the array.

## While and Do...While Loops

### The While Loop

A `while` loop repeats as long as the condition remains true. **Syntax**

```

while (condition) {
// Code
}

```

**Example**

```

let count = 1;
while (count <= 5) {
console.log(count);
count++;
}

```

The condition is checked before each iteration. If it becomes false, the loop stops immediately.

### The Do...While Loop

Unlike the `while` loop, the `do...while` loop executes the code at least once because the condition is checked after execution. **Syntax**

```

do {
// Code
} while (condition);

```

**Example**

```

let number = 1;
do {
console.log(number);
number++;
} while (number <= 5);

```

Even if the condition is false initially, the loop body executes once. **Example**

```

let x = 10;
do {
console.log(x);
} while (x < 5);

```

**Output** `10` The statement runs once before checking the condition.

### Difference Between While and Do...While

| While Loop | Do...While Loop |
|---|---|
| Condition is checked first. | Condition is checked after execution. |
| May execute zero times. | Executes at least once. |
| Suitable when execution depends on the condition. | Suitable when at least one execution is required. |

## Loop Control Statements

Sometimes we want to change the normal behavior of loops. JavaScript provides two important statements for this purpose.

### Break Statement

The `break` statement immediately terminates the loop. **Example**

```

for (let i = 1; i <= 10; i++) {
if (i == 6) {
break;
}
console.log(i);
}

```

**Output**

```

1
2
3
4
5

```

The loop stops when `i` becomes 6.

### Continue Statement

The `continue` statement skips the current iteration and moves to the next one. **Example**

```

for (let i = 1; i <= 5; i++) {
if (i == 3) {
continue;
}
console.log(i);
}

```

**Output**

```

1
2
4
5

```

The number 3 is skipped.

### Common Mistakes in Loops

**Infinite Loop** If the loop condition never becomes false, the program runs forever. **Incorrect**

```

let i = 1;
while (i <= 5) {
console.log(i);
}

```

Here, `i` is never incremented. **Correct**

```

let i = 1;
while (i <= 5) {
console.log(i);
i++;
}

```

Always ensure the loop variable changes so that the condition eventually becomes false.

### Choosing the Right Loop

- Use a **for loop** when the number of iterations is known.

- Use a **while loop** when the number of iterations depends on a condition.

- Use a **do...while loop** when the code must execute at least once.

Selecting the appropriate loop makes programs easier to read and improves efficiency.

### Conclusion

Control structures form the backbone of JavaScript programming. Decision-making statements such as `if`, `else if`, and `else` enable programs to choose different actions based on specific conditions, making applications responsive and intelligent. Looping structures like `for`, `while`, and `do...while` eliminate repetitive coding by automating repeated tasks. Additionally, control statements such as `break` and `continue` provide greater flexibility by allowing us to stop or skip iterations when necessary. As we continue learning JavaScript, mastering these control structures will help us write cleaner, more efficient, and more powerful programs capable of solving real-world problems.');

-- Lecture 5: Functions in JavaScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Functions in JavaScript', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Functions in JavaScript

## Introduction to Functions in JavaScript

Functions are one of the most important building blocks of JavaScript. They allow us to group a set of statements into a single reusable block of code. Instead of writing the same code repeatedly, we can write it once inside a function and call it whenever we need it. Think of a function as a machine: you provide an input, the machine processes it, and it gives you an output. This makes programming faster, cleaner, and easier to manage. Imagine you are preparing tea every morning. Instead of memorizing every step each day, you simply follow the same recipe. In programming, a function acts like that recipe—it stores instructions that can be reused whenever required. Functions improve code readability, reduce duplication, simplify debugging, and make programs more modular. Almost every JavaScript application, from simple calculators to complex web applications, relies heavily on functions.

## Defining and Calling Functions

### What is a Function?

A function is a named block of code that performs a specific task. It executes only when it is called (invoked). **Syntax**

```

function functionName() {
// Code to execute
}

```

**Example**

```

function greet() {
console.log("Welcome to JavaScript!");
}
greet();

```

**Output** `Welcome to JavaScript!` Here, `greet()` is the function name. The code inside the braces runs only when the function is called.

### Why Do We Use Functions?

Functions provide several advantages:

- Avoid repeating the same code.

- Make programs easier to read.

- Simplify testing and debugging.

- Break large programs into smaller, manageable parts.

- Promote code reusability.

For example, instead of writing the code to calculate a student\'s average marks multiple times, we can create one function and reuse it wherever needed.

### Function Naming Rules

When naming functions:

- The name should begin with a letter, underscore (`_`), or dollar sign (`$`).

- It should clearly describe the function\'s purpose.

- JavaScript follows **camelCase** naming convention.

**Good Examples**

```

calculateTotal()
displayMessage()
findMaximum()

```

**Poor Examples**

```

abc()
test1()
x()

```

Meaningful names make programs easier to understand.

## Function Parameters and Return Values

### Function Parameters

Parameters are variables listed inside the parentheses of a function definition. They allow us to pass data into the function. **Syntax**

```

function functionName(parameter1, parameter2) {
// Code
}

```

**Example**

```

function greet(name) {
console.log("Hello " + name);
}
greet("Ali");
greet("Sara");

```

**Output**

```

Hello Ali
Hello Sara

```

Here, `name` is the parameter, while `"Ali"` and `"Sara"` are arguments passed during the function call.

### Multiple Parameters

A function can receive more than one parameter. **Example**

```

function add(num1, num2) {
console.log(num1 + num2);
}
add(10, 20);

```

**Output** `30` Parameters make functions flexible because the same function can work with different values.

### Return Statement

Sometimes we want a function to produce a value instead of simply displaying it. The `return` statement sends a value back to the caller. **Syntax**

```

function functionName() {
return value;
}

```

**Example**

```

function multiply(a, b) {
return a * b;
}
let result = multiply(5, 4);
console.log(result);

```

**Output** `20` The `return` statement immediately ends the function and sends the result back.

### Functions Without Return

Not every function returns a value. **Example**

```

function welcome() {
console.log("Welcome!");
}
welcome();

```

This function performs an action but does not return anything.

## Types of Functions in JavaScript

### Function Declaration

This is the most common way to create a function. **Example**

```

function square(number) {
return number * number;
}
console.log(square(6));

```

### Function Expression

A function can also be stored inside a variable. **Example**

```

const multiply = function(a, b) {
return a * b;
};
console.log(multiply(4, 5));

```

Function expressions are useful when functions need to be assigned to variables or passed as arguments.

### Arrow Functions

Arrow functions were introduced in ES6. They provide a shorter and cleaner syntax. **Syntax**

```

const functionName = (parameters) => {
// Code
};

```

**Example**

```

const add = (a, b) => {
return a + b;
};
console.log(add(8, 7));

```

A shorter version is:

```

const add = (a, b) => a + b;
console.log(add(8, 7));

```

Arrow functions are widely used in modern JavaScript because they are concise and easier to write.

### Anonymous Functions

An anonymous function has no name. **Example**

```

setTimeout(function() {
console.log("Executed after 2 seconds");
}, 2000);

```

Anonymous functions are commonly used when a function is needed only once.

## Scope, Benefits, and Best Practices of Functions

### Variable Scope

Scope determines where variables can be accessed. **Local Variables** Variables declared inside a function are called local variables.

```

function test() {
let message = "Hello";
console.log(message);
}
test();

```

The variable `message` cannot be used outside the function. **Global Variables** Variables declared outside functions are global variables.

```

let company = "ABC Technologies";
function display() {
console.log(company);
}
display();

```

Global variables are accessible throughout the program, but excessive use should be avoided because they can make programs difficult to manage.

### Advantages of Functions

Functions offer many benefits:

- Reduce code duplication.

- Improve readability.

- Simplify maintenance.

- Encourage modular programming.

- Make debugging easier.

- Increase code reusability.

- Save development time.

Large software applications are divided into hundreds or even thousands of small functions working together.

### Best Practices

To write effective functions:

- Give functions meaningful names.

- Keep each function focused on one task.

- Avoid writing very long functions.

- Use parameters instead of hard-coded values.

- Return values when appropriate.

- Write reusable and well-organized code.

Following these practices results in cleaner, more professional programs.

### Common Mistakes

**Forgetting to Call the Function**

```

function greet() {
console.log("Hello");
}

```

Nothing happens until the function is called. **Correct**

```

greet();

```

**Missing Return Statement Incorrect**

```

function sum(a, b) {
a + b;
}
console.log(sum(5, 3));

```

**Output** `undefined` **Correct**

```

function sum(a, b) {
return a + b;
}
console.log(sum(5, 3));

```

**Output** `8` **Using Incorrect Parameters**

```

function subtract(a, b) {
return a - b;
}
subtract(10);

```

Since the second argument is missing, the result becomes `NaN`. Always provide the required number of arguments or define default values.

### Conclusion

Functions are the heart of JavaScript programming because they help us organize, simplify, and reuse code efficiently. By grouping related statements into reusable blocks, we can write cleaner, shorter, and more maintainable programs. Understanding function declarations, function expressions, arrow functions, parameters, return values, and variable scope enables us to build dynamic and interactive applications with confidence. As we continue exploring JavaScript, mastering functions will become essential, since nearly every feature in modern web development depends on them. A solid understanding of functions lays the foundation for writing efficient, scalable, and professional JavaScript code.');

-- Lecture 6: Arrays in JavaScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Arrays in JavaScript', 6, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Arrays in JavaScript

## Introduction to Arrays

Arrays are one of the most useful data structures in JavaScript. They allow us to store multiple values in a single variable instead of creating separate variables for each value. Imagine keeping your books on a bookshelf. Instead of placing each book in a different room, you organize them together on one shelf. Similarly, an array stores related pieces of data in one place, making our programs more organized and efficient. Without arrays, managing large amounts of data would become difficult. For example, if we wanted to store the names of 100 students, creating 100 separate variables would be impractical. An array solves this problem by storing all the names in a single variable. Arrays are commonly used in web development to manage lists of products, user information, marks, messages, images, and much more. Learning arrays is essential because they are used in almost every JavaScript application.

## Creating and Accessing Arrays

### What is an Array?

An array is a special JavaScript object used to store multiple values in an ordered collection. Each value in an array is called an **element**, and every element has an **index**. Array indexing starts from **0**, not 1. **Syntax**

```

let arrayName = [value1, value2, value3];

```

**Example**

```

let fruits = ["Apple", "Banana", "Mango"];

```

In this example:

- Index **0** → Apple

- Index **1** → Banana

- Index **2** → Mango

### Accessing Array Elements

We can access elements by using their index number. **Example**

```

let fruits = ["Apple", "Banana", "Mango"];
console.log(fruits[0]);
console.log(fruits[2]);

```

**Output**

```

Apple
Mango

```

If we try to access an index that does not exist, JavaScript returns `undefined`.

### Modifying Array Elements

Array elements can be changed by assigning a new value. **Example**

```

let colors = ["Red", "Green", "Blue"];
colors[1] = "Yellow";
console.log(colors);

```

**Output** `["Red", "Yellow", "Blue"]` Arrays are mutable, meaning their contents can be modified after creation.

## Common Array Properties and Methods

### The length Property

The `length` property returns the total number of elements in an array. **Example**

```

let students = ["Ali", "Sara", "Ahmed", "Fatima"];
console.log(students.length);

```

**Output** `4` The `length` property is very useful when processing arrays with loops.

### Adding Elements

### push() Method

Adds one or more elements to the end of the array.

```

let fruits = ["Apple", "Banana"];
fruits.push("Orange");
console.log(fruits);

```

**Output**

```

["Apple", "Banana", "Orange"]

```

### unshift() Method

Adds elements to the beginning of the array.

```

let numbers = [2, 3, 4];
numbers.unshift(1);
console.log(numbers);

```

**Output** `[1, 2, 3, 4]`

### Removing Elements

### pop() Method

Removes the last element.

```

let fruits = ["Apple", "Banana", "Mango"];
fruits.pop();
console.log(fruits);

```

**Output** `["Apple", "Banana"]`

### shift() Method

Removes the first element.

```

let numbers = [1, 2, 3];
numbers.shift();
console.log(numbers);

```

**Output** `[2, 3]`

## Looping Through Arrays

### Using the For Loop

The `for` loop is the most common way to access every element of an array. **Example**

```

let fruits = ["Apple", "Banana", "Mango"];
for (let i = 0; i < fruits.length; i++) {
console.log(fruits[i]);
}

```

**Output**

```

Apple
Banana
Mango

```

The loop starts at index 0 and continues until the last element.

### Using the for...of Loop

JavaScript provides a simpler way to iterate through arrays. **Example**

```

let fruits = ["Apple", "Banana", "Mango"];
for (let fruit of fruits) {
console.log(fruit);
}

```

**Output**

```

Apple
Banana
Mango

```

The `for...of` loop is easier to read because it directly accesses each element.

### Searching in Arrays

We can determine whether an element exists in an array using the `includes()` method. **Example**

```

let colors = ["Red", "Blue", "Green"];
console.log(colors.includes("Blue"));
console.log(colors.includes("Black"));

```

**Output**

```

true
false

```

This method returns `true` if the value exists and `false` otherwise.

## Useful Array Methods and Best Practices

### Joining Array Elements

The `join()` method combines all array elements into a single string. **Example**

```

let words = ["JavaScript", "is", "easy"];
console.log(words.join(" "));

```

**Output** `JavaScript is easy`

### Sorting Arrays

The `sort()` method arranges elements alphabetically by default.

```

let names = ["Sara", "Ali", "Ahmed"];
names.sort();
console.log(names);

```

**Output** `["Ahmed", "Ali", "Sara"]`

### Reversing an Array

The `reverse()` method reverses the order of elements.

```

let numbers = [1, 2, 3, 4];
numbers.reverse();
console.log(numbers);

```

**Output** `[4, 3, 2, 1]`

### Common Mistakes

**Accessing an Invalid Index**

```

let fruits = ["Apple", "Banana"];
console.log(fruits[5]);

```

**Output** `undefined` Always ensure the index exists before accessing it. **Forgetting That Arrays Start at Zero**

```

let colors = ["Red", "Green", "Blue"];
console.log(colors[1]);

```

**Output** `Green` Remember that the first element is at index **0**, not **1**. **Using the Wrong Loop Condition**

```

let numbers = [10, 20, 30];
for (let i = 0; i <= numbers.length; i++) {
console.log(numbers[i]);
}

```

The last iteration tries to access an index that does not exist. **Correct Version**

```

for (let i = 0; i < numbers.length; i++) {
console.log(numbers[i]);
}

```

Using `<` instead of `<=` prevents an extra iteration.

### Advantages of Arrays

Arrays provide several benefits:

- Store multiple values in a single variable.

- Make data organized and easy to manage.

- Reduce the need for multiple variables.

- Work efficiently with loops.

- Support many built-in methods for adding, removing, searching, and sorting data.

- Improve code readability and maintainability.

Arrays are one of the most frequently used features in JavaScript because they simplify handling collections of data.

### Conclusion

Arrays are a fundamental part of JavaScript and play a vital role in organizing and managing data efficiently. They allow us to store multiple values in a single variable, access elements using indexes, and manipulate data using powerful built-in methods such as `push()`, `pop()`, `shift()`, `unshift()`, `sort()`, `reverse()`, `join()`, and `includes()`. By combining arrays with loops, we can process large collections of data quickly and effectively. Mastering arrays is an essential step toward becoming a skilled JavaScript developer, as they are widely used in web applications, data processing, and real-world programming projects.');

-- Lecture 7: Objects in JavaScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Objects in JavaScript', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Objects in JavaScript

## Introduction to Objects in JavaScript

Objects are one of the most powerful and commonly used features in JavaScript. They allow us to store multiple related pieces of information in a single variable. While an array stores values in order using indexes, an object stores data as **key-value pairs**, making it easier to represent real-world entities. Think of an object as a student\'s identity card. The card contains different details such as the student\'s name, age, roll number, and department. Instead of storing each detail in separate variables, we can keep them together in one object. This approach makes our code more organized, readable, and easier to maintain. Objects are used extensively in JavaScript applications to represent users, products, employees, cars, books, orders, and many other real-world entities. Understanding objects is essential because almost every modern JavaScript framework and application relies on them.

## Creating and Accessing Objects

### What is an Object?

An object is a collection of related data stored as **properties**. Each property consists of a **key** (property name) and a **value**. **Syntax**

```

let objectName = {
key1: value1,
key2: value2,
key3: value3
};

```

**Example**

```

let student = {
name: "Ali",
age: 20,
department: "Computer Science"
};

```

In this example:

- `name`, `age`, and `department` are **keys**.

- `"Ali"`, `20`, and `"Computer Science"` are **values**.

### Accessing Object Properties

We can access object properties using two methods:

### 1. Dot Notation

```

let student = {
name: "Ali",
age: 20
};
console.log(student.name);
console.log(student.age);

```

**Output**

```

Ali
20

```

### 2. Bracket Notation

```

let student = {
name: "Ali",
age: 20
console.log(student["name"]);
console.log(student["age"]);

```

**Output**

```

Ali
20

```

Bracket notation is useful when the property name is stored in a variable or contains spaces.

### Modifying Object Properties

We can easily change the value of an existing property. **Example**

```

let student = {
name: "Ali",
age: 20
};
student.age = 21;
console.log(student);

```

**Output**

```

{ name: "Ali", age: 21 }

```

Objects are mutable, meaning their properties can be updated after creation.

## Adding, Removing, and Working with Properties

### Adding New Properties

New properties can be added at any time. **Example**

```

let student = {
name: "Ali"
};
student.city = "Lahore";
console.log(student);

```

**Output**

```

{ name: "Ali", city: "Lahore" }

```

### Deleting Properties

The `delete` keyword removes a property from an object. **Example**

```

let student = {
name: "Ali",
age: 20
};
delete student.age;
console.log(student);

```

**Output**

```

{ name: "Ali" }

```

### Checking if a Property Exists

We can use the `in` operator to check whether a property exists. **Example**

```

let student = {
name: "Ali",
age: 20
};
console.log("age" in student);
console.log("address" in student);

```

**Output**

```

true
false

```

This is useful when working with objects that may not contain every property.

## Object Methods and Looping Through Objects

### What is an Object Method?

A method is simply a function stored inside an object. Methods allow objects to perform actions. **Example**

```

let student = {
name: "Ali",
greet: function() {
console.log("Hello, my name is " + this.name);
}
};
student.greet();

```

**Output** `Hello, my name is Ali` The keyword `this` refers to the current object.

### Looping Through Object Properties

We can use the `for...in` loop to access every property of an object. **Example**

```

let student = {
name: "Ali",
age: 20,
city: "Lahore"
};
for (let key in student) {
console.log(key + ": " + student[key]);
}

```

**Output**

```

name: Ali
age: 20
city: Lahore

```

The loop visits each property one by one.

### Object.keys() Method

The `Object.keys()` method returns an array containing all property names. **Example**

```

let student = {
name: "Ali",
age: 20,
city: "Lahore"
};
console.log(Object.keys(student));

```

**Output** `["name", "age", "city"]`

## Nested Objects, Advantages, and Best Practices

### Nested Objects

An object can contain another object as one of its properties. **Example**

```

let student = {
name: "Ali",
address: {
city: "Lahore",
country: "Pakistan"
}
};
console.log(student.address.city);

```

**Output** `Lahore` Nested objects help organize complex data efficiently.

### Difference Between Arrays and Objects

| Arrays | Objects |
|---|---|
| Store data using indexes. | Store data using key-value pairs. |
| Ordered collection of values. | Collection of named properties. |
| Access elements using indexes. | Access properties using keys. |
| Best for lists of similar items. | Best for representing real-world entities. |

For example:

- Use an **array** to store a list of student names.

### Advantages of Objects

Objects offer many benefits:

- Organize related data together.

- Represent real-world entities effectively.

- Improve code readability.

- Allow properties and methods in one structure.

- Easily expandable by adding new properties.

- Widely used in APIs, databases, and web applications.

Because of these advantages, objects are considered the foundation of JavaScript programming.

### Common Mistakes

**Accessing a Non-Existing Property**

```

let student = {
name: "Ali"
};
console.log(student.age);

```

**Output** `undefined` Always verify that the property exists before using it. **Using Dot Notation with Invalid Property Names**

```

let person = {
"first name": "Sara"
};

```

This will not work: `person.first name` **Correct**

```

console.log(person["first name"]);

```

Bracket notation should be used when property names contain spaces or special characters. **Forgetting the** `this` **Keyword Incorrect**

```

let student = {
name: "Ali",
greet: function() {
console.log(name);
}
};

```

**Correct**

```

let student = {
name: "Ali",
greet: function() {
console.log(this.name);
}
};

```

The `this` keyword refers to the current object and allows access to its properties.

### Conclusion

Objects are one of the most important concepts in JavaScript because they allow us to organize related data and behavior into a single structure. By storing information as key-value pairs, objects make our programs more readable, flexible, and efficient. We can create objects, access and modify their properties, add or remove data, define methods, use nested objects, and iterate through properties using loops. Understanding objects is essential for building modern web applications, as they are widely used to represent users, products, settings, and many other real-world entities. Mastering objects provides a strong foundation for advanced JavaScript topics such as JSON, classes, APIs, and object-oriented programming, making them an indispensable part of every JavaScript developer\'s toolkit.');

-- Lecture 8: DOM Manipulation in JavaScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'DOM Manipulation in JavaScript', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# DOM Manipulation in JavaScript

## Introduction to DOM Manipulation

The **Document Object Model (DOM)** is one of the most important concepts in JavaScript. It allows JavaScript to interact with HTML documents by accessing, modifying, adding, or removing elements dynamically. In simple words, the DOM acts as a bridge between JavaScript and a web page. Imagine a web page as a house. HTML builds the structure, CSS decorates it, and JavaScript acts as the owner who can move furniture, repaint walls, or even add new rooms whenever needed. Without the DOM, JavaScript would not be able to change the content or appearance of a webpage after it has loaded. DOM manipulation is used to create interactive websites such as online forms, image galleries, calculators, navigation menus, shopping carts, and many other modern web applications.

## Understanding the Document Object Model (DOM)

### What is the DOM?

The Document Object Model (DOM) is a programming interface that represents an HTML document as a tree of objects. Every HTML element becomes an object that JavaScript can access and manipulate. Consider the following HTML:

```

<html>
<head>
<title>My Website</title>
</head>
<body>
<h1>Hello World</h1>
<p>Welcome to JavaScript.</p>
</body>
</html>

```

The DOM views this document as a tree:

```

Document
│
└── html
├── head
│ └── title
└── body
├── h1
└── p

```

Each element is called a **node**, and JavaScript can access any node in the tree.

### Why is DOM Manipulation Important?

DOM manipulation allows us to:

- Change text on a webpage.

- Modify HTML elements.

- Change CSS styles.

- Create and remove elements.

- Respond to user actions.

- Build interactive web applications.

Without the DOM, web pages would remain static and could not respond to user interactions.

## Selecting and Accessing HTML Elements

Before changing an element, JavaScript must first find it.

### Selecting by ID

The `getElementById()` method selects an element using its unique ID. **HTML** `<h1 id="title">Welcome</h1>` **JavaScript**

```

let heading = document.getElementById("title");
console.log(heading);

```

This method returns the HTML element with the specified ID.

### Selecting by Class Name

The `getElementsByClassName()` method selects all elements with the same class. **HTML**

```

<p class="message">Hello</p>
<p class="message">Welcome</p>

```

**JavaScript**

```

let messages = document.getElementsByClassName("message");
console.log(messages);

```

Since multiple elements may have the same class, this method returns a collection of elements.

### Selecting by Tag Name

The `getElementsByTagName()` method selects elements based on their HTML tag.

```

let paragraphs = document.getElementsByTagName("p");

```

This returns all paragraph elements.

### Using querySelector()

The `querySelector()` method selects the first matching element using CSS selectors.

```

let heading = document.querySelector("h1");

```

Or

```

let heading = document.querySelector("#title");

```

This method is flexible because it supports IDs, classes, and element names.

### Using querySelectorAll()

The `querySelectorAll()` method selects all matching elements.

```

let paragraphs = document.querySelectorAll("p");

```

It returns a list of all matching elements.

## Modifying HTML Content and Styles

### Changing Text Content

The `textContent` property changes only the text inside an element. **HTML**

```

<h1 id="title">Old Title</h1>

```

**JavaScript**

```

document.getElementById("title").textContent = "New Title";

```

### Changing HTML Content

The `innerHTML` property changes the HTML inside an element.

```

document.getElementById("title").innerHTML = "<b>JavaScript</b>";

```

The text becomes bold because HTML tags are interpreted.

### Changing CSS Styles

JavaScript can directly modify CSS properties.

```

let heading = document.getElementById("title");
heading.style.color = "blue";
heading.style.fontSize = "30px";

```

The heading now appears blue with a larger font size.

### Changing Attributes

The `setAttribute()` method changes or adds attributes. **HTML** `<img id="photo">` **JavaScript**

```

document.getElementById("photo").setAttribute("src", "image.jpg");

```

This changes the image displayed on the webpage.

## Creating, Removing, and Responding to Events

### Creating New Elements

JavaScript can create new HTML elements dynamically.

```

let paragraph = document.createElement("p");
paragraph.textContent = "This is a new paragraph.";

```

However, the element will not appear until it is added to the document.

### Adding Elements to the Page

The `appendChild()` method inserts a new element into the webpage.

```

document.body.appendChild(paragraph);

```

The newly created paragraph now becomes visible.

### Removing Elements

The `remove()` method deletes an element.

```

let heading = document.getElementById("title");
heading.remove();

```

The heading disappears from the webpage.

### Handling Events

JavaScript responds to user actions such as mouse clicks and keyboard input through **events**. **HTML**

```

<button id="btn">Click Me</button>

```

**JavaScript**

```

document.getElementById("btn").addEventListener("click", function() {
alert("Button Clicked!");
});

```

Whenever the button is clicked, an alert box appears. Common events include:

- `click`

- `mouseover`

- `mouseout`

- `keydown`

- `keyup`

- `submit`

- `change`

Events make websites interactive and responsive.

### Common Mistakes in DOM Manipulation

**Selecting an Element That Does Not Exist**

```

let heading = document.getElementById("heading");
heading.textContent = "Hello";

```

If the element with ID `"heading"` does not exist, JavaScript produces an error. **Correct Practice**

```

let heading = document.getElementById("heading");
if (heading) {
heading.textContent = "Hello";
}

```

Always ensure the element exists before modifying it. **Forgetting to Wait for the Page to Load** If JavaScript runs before HTML elements are created, it cannot find them. **Solution** Place the `<script>` tag just before the closing `</body>` tag or use the `DOMContentLoaded` event.

```

document.addEventListener("DOMContentLoaded", function() {
console.log("Page Loaded");
});

```

**Confusing** `textContent` **and** `innerHTML`

```

element.textContent = "<b>Hello</b>";

```

**Output** `<b>Hello</b>` The tags appear as plain text. Using:

```

element.innerHTML = "<b>Hello</b>";

```

**Output Hello** The HTML is rendered correctly.

### Advantages of DOM Manipulation

DOM manipulation provides many benefits:

- Creates interactive web pages.

- Updates webpage content without refreshing.

- Allows dynamic creation and deletion of elements.

- Improves user experience.

- Supports event-driven programming.

- Enables modern web applications like online shopping, games, dashboards, and social media platforms.

Because of these advantages, DOM manipulation is considered one of the core skills every JavaScript developer must master.

### Conclusion

DOM manipulation is a fundamental concept in JavaScript that enables us to interact with and modify HTML documents dynamically. By understanding how to select elements, change content, update styles, create and remove elements, and respond to user events, we can build engaging and interactive websites. The Document Object Model serves as the connection between JavaScript and the webpage, allowing us to transform static pages into dynamic applications. As we continue learning JavaScript, mastering DOM manipulation will become essential for developing responsive, user-friendly, and professional web applications.');

-- Lecture 9: Events Handling in JavaScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Events Handling in JavaScript', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Events Handling in JavaScript

## Introduction to Event Handling in JavaScript

Event handling is one of the most exciting features of JavaScript because it allows web pages to respond to user actions. Without events, a website would simply display information and remain static. With event handling, however, a webpage becomes interactive, responding to clicks, keyboard input, mouse movements, form submissions, and many other user interactions. Think of a doorbell. It remains silent until someone presses the button. As soon as the button is pressed, the bell rings. Similarly, an event in JavaScript waits for a user action, and once that action occurs, a function is executed automatically. This process is known as **event handling**. Modern websites such as online shopping stores, social media platforms, online quizzes, and banking systems rely heavily on event handling to provide an interactive and user-friendly experience.

## Understanding Events in JavaScript

### What is an Event?

An **event** is an action or occurrence that happens in the browser. It can be triggered either by the user or by the browser itself. Some common examples include:

- Clicking a button

- Pressing a keyboard key

- Moving the mouse

- Submitting a form

- Loading a webpage

- Scrolling a page

- Changing the value of an input field

Whenever an event occurs, JavaScript can detect it and execute a specific function called an **event handler**.

### What is an Event Handler?

An **event handler** is a JavaScript function that runs automatically when a particular event occurs. **Example**

```

<button onclick="showMessage()">Click Me</button>
function showMessage() {
alert("Button Clicked!");
}

```

When the user clicks the button, the `showMessage()` function executes and displays an alert message.

### Why is Event Handling Important?

Event handling allows us to:

- Make websites interactive.

- Respond to user actions.

- Validate forms before submission.

- Build games and animations.

- Create responsive user interfaces.

- Improve the overall user experience.

Without event handling, web pages would be unable to react to user input.

## Common JavaScript Events

JavaScript provides many built-in events. Some of the most commonly used are described below.

### Click Event

The `click` event occurs when a user clicks an element. **Example**

```

<button id="btn">Click Me</button>
document.getElementById("btn").addEventListener("click", function() {
alert("Button Clicked!");
});

```

The alert appears whenever the button is clicked.

### Double Click Event

The `dblclick` event occurs when an element is double-clicked.

```

document.getElementById("btn").addEventListener("dblclick", function() {
alert("Button Double Clicked!");
});

```

### Mouse Events

JavaScript can detect mouse movements and actions. Common mouse events include:

- `mouseover`

- `mouseout`

- `mousemove`

- `mousedown`

- `mouseup`

**Example**

```

document.getElementById("box").addEventListener("mouseover", function() {
console.log("Mouse is over the box.");
});

```

### Keyboard Events

Keyboard events occur when the user presses or releases keys. Common keyboard events include:

- `keydown`

- `keyup`

- `keypress` (older event, less commonly used today)

**Example**

```

document.addEventListener("keydown", function() {
console.log("Key Pressed");
});

```

These events are useful for games, shortcuts, and form validation.

### Form Events

Forms also generate events. Common form events include:

- `submit`

- `change`

- `focus`

- `blur`

- `input`

**Example**

```

document.getElementById("myForm").addEventListener("submit", function() {
alert("Form Submitted");
});

```

## Methods of Handling Events

JavaScript provides several ways to attach events to HTML elements.

### Inline Event Handling

Events can be written directly inside HTML. **Example**

```

<button onclick="showMessage()">Click Me</button>

```

Although simple, this method is not recommended for large applications because it mixes HTML with JavaScript.

### Using DOM Properties

We can assign an event handler through JavaScript.

```

let button = document.getElementById("btn");
button.onclick = function() {
alert("Button Clicked");
};

```

This separates JavaScript from HTML and improves code organization.

### Using addEventListener()

The recommended and most flexible method is `addEventListener()`. **Syntax**

```

element.addEventListener("event", function() {
// Code
});

```

**Example**

```

let button = document.getElementById("btn");
button.addEventListener("click", function() {
alert("Welcome!");
});

```

**Advantages of addEventListener()**

- Keeps HTML and JavaScript separate.

- Allows multiple event handlers on the same element.

- Easier to maintain and debug.

- Widely used in professional web development.

## Event Object, Event Propagation, and Best Practices

### The Event Object

Whenever an event occurs, JavaScript creates an **event object** containing information about the event. **Example**

```

document.getElementById("btn").addEventListener("click", function(event) {
console.log(event.type);
});

```

**Output** `click` The event object contains useful information such as:

- Event type

- Mouse position

- Keyboard key pressed

- Target element

### Event Propagation

When an event occurs on an element inside another element, JavaScript determines how the event travels through the DOM. This process is called **event propagation**. There are two main phases:

### Event Bubbling

The event starts from the target element and moves upward through its parent elements. Example:

```

<div>
<button>Click</button>
</div>

```

If the button is clicked, the event first affects the button and then the surrounding `<div>`.

### Event Capturing

In capturing, the event travels from the outermost parent element down to the target element. By default, JavaScript uses **event bubbling**, although capturing can be enabled when needed.

### Preventing Default Behavior

Some HTML elements have default actions. For example, a form submits automatically when the submit button is clicked. The `preventDefault()` method stops the default behavior. **Example**

```

document.getElementById("myForm").addEventListener("submit", function(event) {
event.preventDefault();
alert("Form submission prevented.");
});

```

This is commonly used for client-side form validation.

### Common Mistakes

**Forgetting Parentheses When Calling a Function Incorrect**

```

button.onclick = showMessage();

```

This immediately executes the function instead of waiting for the click event. **Correct**

```

button.onclick = showMessage;

```

Or

```

button.addEventListener("click", showMessage);

```

**Selecting an Element Before It Exists**

```

let button = document.getElementById("btn");

```

If the HTML has not loaded yet, `button` becomes `null`. **Solution** Place the `<script>` tag before the closing `</body>` tag or use the `DOMContentLoaded` event. **Forgetting to Prevent Form Submission** If validation is required, always use:

```

event.preventDefault();

```

Otherwise, the page may refresh before validation finishes.

### Advantages of Event Handling

Event handling offers many benefits:

- Makes websites interactive.

- Improves user experience.

- Responds instantly to user actions.

- Supports dynamic web applications.

- Enables animations, games, and live updates.

- Separates behavior from webpage structure when using `addEventListener()`.

Because of these advantages, event handling is considered one of the core concepts of JavaScript programming.

### Conclusion

Event handling is a fundamental part of JavaScript that transforms static webpages into dynamic and interactive applications. By responding to user actions such as mouse clicks, keyboard input, form submissions, and page events, JavaScript creates a more engaging and responsive user experience. We have learned how to use common events, attach event handlers through different methods, work with the event object, understand event propagation, and prevent default browser behavior when necessary. Among all approaches, `addEventListener()` is the most recommended because it produces clean, flexible, and maintainable code. Mastering event handling provides a strong foundation for developing professional web applications, as nearly every modern website depends on events to communicate effectively with its users.');

-- Lecture 10: ES6+ Features in JavaScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'ES6+ Features in JavaScript', 10, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# ES6+ Features in JavaScript

## Introduction to ES6+ Features

ECMAScript 6 (ES6), officially released in **2015**, introduced major improvements to JavaScript. Since then, new versions of ECMAScript have continued to add useful features, and together these modern additions are commonly referred to as **ES6+ features**. Before ES6, JavaScript programs were often lengthy and difficult to maintain. Developers had to write more code to perform simple tasks. ES6+ introduced cleaner syntax, improved readability, and powerful programming features that make development faster and more efficient. Think of ES6+ as upgrading from an old mobile phone to a modern smartphone. Both perform the same basic functions, but the newer version is faster, easier to use, and packed with powerful capabilities. Today, almost every modern JavaScript application uses ES6+ features because they produce cleaner, shorter, and more maintainable code.

## Variables and Template Literals

### let and const

Before ES6, JavaScript only had the `var` keyword for declaring variables. ES6 introduced `let` and `const`, which provide better control over variables.

### let

The `let` keyword declares variables whose values can change. **Example**

```

let age = 20;
age = 21;
console.log(age);

```

**Output** `21`

### const

The `const` keyword declares variables whose values cannot be reassigned. **Example**

```

const PI = 3.14159;
console.log(PI);

```

Trying to assign another value to `PI` results in an error.

### Difference Between var, let, and const

| var | let | const |
|---|---|---|
| Can be redeclared. | Cannot be redeclared in the same scope. | Cannot be redeclared or reassigned. |
| Function scoped. | Block scoped. | Block scoped. |
| Older method. | Modern method. | Used for constant values. |

In modern JavaScript, developers usually prefer `let` and `const` instead of `var`.

### Template Literals

Template literals allow us to create strings more easily using **backticks ( )**. **Old Method**

```

let name = "Ali";
console.log("Hello " + name);

```

**ES6 Method**

```

let name = "Ali";
console.log(`Hello ${name}`);

```

**Output** `Hello Ali` Template literals make string formatting simpler and more readable.

## Arrow Functions, Default Parameters, and Destructuring

### Arrow Functions

Arrow functions provide a shorter syntax for writing functions. **Traditional Function**

```

function add(a, b) {
return a + b;
}

```

**Arrow Function**

```

const add = (a, b) => a + b;
console.log(add(5, 3));

```

**Output** `8` Arrow functions reduce unnecessary code and are widely used in modern JavaScript.

### Default Parameters

Default parameters allow a function to use predefined values if no argument is provided. **Example**

```

function greet(name = "Guest") {
console.log(`Hello ${name}`);
}
greet();
greet("Sara");

```

**Output**

```

Hello Guest
Hello Sara

```

This feature eliminates the need for additional condition checks.

### Destructuring

Destructuring allows us to extract values from arrays and objects easily. **Array Destructuring**

```

let colors = ["Red", "Green", "Blue"];
let [first, second] = colors;
console.log(first);
console.log(second);

```

**Output**

```

Red
Green

```

**Object Destructuring**

```

let student = {
name: "Ali",
age: 20
};
let { name, age } = student;
console.log(name);
console.log(age);

```

**Output**

```

Ali
20

```

Destructuring makes code cleaner and easier to read.

## Spread Operator, Rest Operator, and Modules

### Spread Operator (...)

The spread operator expands the elements of an array or object. **Example**

```

let numbers = [1, 2, 3];
let newNumbers = [...numbers, 4, 5];
console.log(newNumbers);

```

**Output** `[1, 2, 3, 4, 5]` It is commonly used to copy arrays and combine multiple arrays.

### Rest Operator (...)

The rest operator collects multiple values into a single array. **Example**

```

function sum(...numbers) {
console.log(numbers);
}
sum(10, 20, 30);

```

**Output** `[10, 20, 30]` The rest operator is useful when the number of function arguments is unknown.

### Modules

Modules allow JavaScript code to be divided into separate files. This makes programs more organized and reusable. **Exporting**

```

export function greet() {
console.log("Hello");
}

```

**Importing**

```

import { greet } from "./script.js";
greet();

```

Modules improve project organization, especially in large applications.

## Promises, Async/Await, and Other ES6+ Features

### Promises

A **Promise** represents the result of an asynchronous operation. It can be in one of three states:

- Pending

- Fulfilled

- Rejected

**Example**

```

let promise = new Promise((resolve, reject) => {
resolve("Data Loaded");
});
promise.then(result => console.log(result));

```

**Output** `Data Loaded` Promises help avoid deeply nested callback functions.

### Async and Await

The `async` and `await` keywords simplify asynchronous programming and make code easier to understand. **Example**

```

async function showMessage() {
return "Welcome!";
}
showMessage().then(message => console.log(message));

```

Or with `await`:

```

async function getData() {
let result = await Promise.resolve("Success");
console.log(result);
}
getData();

```

`async` and `await` make asynchronous code appear similar to synchronous code.

### Classes

ES6 introduced the `class` keyword to simplify object-oriented programming. **Example**

```

class Student {
constructor(name) {
this.name = name;
}
display() {
console.log(this.name);
}
}
let s1 = new Student("Ali");
s1.display();

```

Classes provide a cleaner syntax for creating objects and methods.

### Enhanced Object Literals

ES6 allows shorter syntax when creating objects. **Example**

```

let name = "Ali";
let age = 20;
let student = {
name,
age
};
console.log(student);

```

The property names are automatically matched with variable names.

### Advantages of ES6+ Features

ES6+ offers many benefits:

- Cleaner and shorter syntax.

- Improved readability.

- Better code organization.

- Easier maintenance.

- Enhanced support for asynchronous programming.

- Reduced code duplication.

- Better support for large-scale applications.

- Improved performance and developer productivity.

Because of these advantages, ES6+ has become the standard for modern JavaScript development.

### Common Mistakes

**Using** `const` **for Reassignment Incorrect**

```

const age = 20;
age = 21;

```

This produces an error because `const` variables cannot be reassigned. **Correct**

```

let age = 20;
age = 21;

```

**Forgetting Backticks in Template Literals Incorrect**

```

let name = "Ali";
console.log("Hello ${name}");

```

**Output**

```

Hello ${name}

```

**Correct**

```

console.log(`Hello ${name}`);

```

**Output** `Hello Ali` **Confusing Spread and Rest Operators** Although both use `...`, they serve different purposes. **Spread Operator**

```

let arr1 = [1, 2];
let arr2 = [...arr1, 3];

```

Expands elements. **Rest Operator**

```

function show(...items) {
console.log(items);
}

```

Collects elements. Understanding this distinction prevents common programming errors.

### Conclusion

ES6+ features have transformed JavaScript into a more powerful, efficient, and developer-friendly programming language. Features such as `let`, `const`, template literals, arrow functions, default parameters, destructuring, spread and rest operators, modules, promises, `async/await`, classes, and enhanced object literals help us write cleaner, shorter, and more maintainable code. These modern improvements simplify both small programs and large-scale applications while improving readability and reducing errors. As we continue our journey in JavaScript, mastering ES6+ features is essential because they are widely used in modern web development, frameworks such as React and Angular, and professional software projects around the world.');

-- Lecture 11: Asynchronous JavaScript (Promises, AsyncAwait)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Asynchronous JavaScript (Promises, AsyncAwait)', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Asynchronous JavaScript (Promises, Async/Await)

## Introduction to Asynchronous JavaScript

Asynchronous JavaScript is one of the most important concepts in modern web development. It allows JavaScript to perform long-running tasks without freezing or blocking the rest of the program. Instead of waiting for one task to finish before starting another, JavaScript can continue executing other code and return to the completed task later. Imagine ordering food at a restaurant. After placing your order, you do not stand in the kitchen waiting for it to cook. Instead, you sit at your table, chat with friends, or check your phone. When the food is ready, the waiter serves it. This is exactly how asynchronous programming works. JavaScript starts a task, continues doing other work, and processes the result when it becomes available. Asynchronous programming is essential for handling operations such as:

- Fetching data from a server

- Reading files

- Uploading images

- Downloading resources

- Waiting for timers

- Communicating with APIs

Without asynchronous programming, websites would become slow and unresponsive while waiting for these operations to complete.

## Synchronous vs Asynchronous Programming

### What is Synchronous Programming?

In synchronous programming, JavaScript executes one statement at a time. Each task must finish before the next one begins. **Example**

```

console.log("Task 1");
console.log("Task 2");
console.log("Task 3");

```

**Output**

```

Task 1
Task 2
Task 3

```

The program follows the exact order in which the statements are written.

### What is Asynchronous Programming?

In asynchronous programming, JavaScript can begin a task and continue executing other code without waiting for that task to finish. **Example**

```

console.log("Start");
setTimeout(() => {
console.log("Task Completed");
}, 2000);
console.log("End");

```

**Output**

```

Start
End
Task Completed

```

Although the `setTimeout()` function appears before `"End"`, it executes later because it is asynchronous.

### Why Do We Need Asynchronous JavaScript?

Without asynchronous programming:

- Web pages would freeze while loading data.

- Users would experience delays.

- Applications would feel slow and unresponsive.

Asynchronous programming improves performance and provides a smoother user experience by allowing multiple tasks to progress efficiently.

## Promises in JavaScript

### What is a Promise?

A **Promise** is a JavaScript object that represents the eventual result of an asynchronous operation. It acts like a promise in real life—you are guaranteed either a successful result or an explanation of why the task failed. A Promise can be in one of three states:

- **Pending** – The operation is still running.

- **Fulfilled** – The operation completed successfully.

- **Rejected** – The operation failed.

### Creating a Promise

**Syntax**

```

let promise = new Promise((resolve, reject) => {
});

```

- `resolve()` is called when the task succeeds.

- `reject()` is called when the task fails.

**Example**

```

let promise = new Promise((resolve, reject) => {
resolve("Data Loaded Successfully");
});
promise.then(result => {
console.log(result);
});

```

**Output** `Data Loaded Successfully`

### Handling Errors with catch()

If a Promise is rejected, the `catch()` method handles the error. **Example**

```

let promise = new Promise((resolve, reject) => {
reject("Unable to Load Data");
});
promise
.then(result => console.log(result))
.catch(error => console.log(error));

```

**Output** `Unable to Load Data` Using `catch()` prevents programs from crashing when errors occur.

### Using finally()

The `finally()` method executes regardless of whether the Promise succeeds or fails. **Example**

```

let promise = Promise.resolve("Success");
promise
.then(result => console.log(result))
.finally(() => console.log("Process Finished"));

```

**Output**

```

Success
Process Finished

```

This is useful for cleanup tasks such as hiding loading indicators.

## Async and Await

### What is async?

The `async` keyword declares an asynchronous function. Every `async` function automatically returns a Promise. **Example**

```

async function greet() {
return "Welcome!";
}
greet().then(message => console.log(message));

```

**Output** `Welcome!` Even though a string is returned, JavaScript wraps it inside a Promise.

### What is await?

The `await` keyword pauses the execution of an `async` function until a Promise is completed. **Example**

```

async function getMessage() {
let result = await Promise.resolve("JavaScript is Awesome!");
console.log(result);
}
getMessage();

```

**Output** `JavaScript is Awesome!` The `await` keyword can only be used inside an `async` function.

### Why Use async/await?

Before `async/await`, developers relied heavily on chained `.then()` methods, which became difficult to read in complex programs. **Using Promises**

```

fetchData()
.then(data => processData(data))
.then(result => display(result))
.catch(error => console.log(error));

```

**Using async/await**

```

async function displayData() {
let data = await fetchData();
let result = await processData(data);
display(result);
}
catch(error) {
console.log(error);
}
}

```

The second version is cleaner, easier to understand, and resembles normal sequential code.

## Error Handling, Best Practices, and Real-World Applications

### Error Handling with try...catch

When using `async/await`, errors are handled using `try...catch`. **Example**

```

async function loadData() {
try {
let result = await Promise.reject("Server Error");
console.log(result);
}
catch(error) {
console.log(error);
}
}
loadData();

```

**Output** `Server Error` Using `try...catch` makes programs more reliable and user-friendly.

### Real-World Applications of Asynchronous JavaScript

Asynchronous programming is used in many real-life situations, including:

- Loading weather information from an API.

- Displaying social media posts.

- Uploading profile pictures.

- Online banking transactions.

- Chat and messaging applications.

- Video and music streaming services.

- Online shopping websites.

These applications require continuous interaction without interrupting the user experience.

### Advantages of Promises and Async/Await

Using Promises and `async/await` provides several benefits:

- Prevents blocking of the main program.

- Improves application performance.

- Makes code cleaner and easier to understand.

- Simplifies asynchronous programming.

- Handles errors efficiently.

- Reduces deeply nested callback functions.

- Enhances code maintainability.

These features are essential for building modern, responsive web applications.

### Common Mistakes

**Forgetting the** `await` **Keyword Incorrect**

```

async function test() {
let data = Promise.resolve("Hello");
console.log(data);
}

```

**Output**

```

Promise { <fulfilled> }

```

**Correct**

```

async function test() {
let data = await Promise.resolve("Hello");
console.log(data);
}

```

**Output** `Hello` **Using** `await` **Outside an Async Function Incorrect**

```

let data = await Promise.resolve("Hello");

```

This causes a syntax error because `await` can only be used inside an `async` function (or top-level await in supported module contexts). **Correct**

```

async function example() {
let data = await Promise.resolve("Hello");
console.log(data);
}
example();

```

**Ignoring Promise Errors Incorrect**

```

fetchData().then(result => console.log(result));

```

If the Promise is rejected, the error is not handled. **Correct**

```

fetchData()
.then(result => console.log(result))
.catch(error => console.log(error));

```

Or with `async/await`:

```

try {
let result = await fetchData();
}
catch(error) {
console.log(error);

```

Handling errors properly makes applications more stable and easier to debug.

### Conclusion

Asynchronous JavaScript is a fundamental concept that allows applications to perform time-consuming operations without blocking the execution of other code. By using **Promises**, developers can manage asynchronous tasks more effectively, while `async` and `await` provide a cleaner and more readable way to write asynchronous code. Features such as `then()`, `catch()`, `finally()`, and `try...catch` make it easier to handle successful operations and errors gracefully. From fetching API data to processing user requests, asynchronous programming powers nearly every modern web application. Mastering Promises and `async/await` is therefore essential for anyone who wants to build fast, responsive, and professional JavaScript applications.');

-- Lecture 12: Error Handling in JavaScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Error Handling in JavaScript', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Error Handling in JavaScript

## Introduction to Error Handling in JavaScript

JavaScript is one of the most widely used programming languages for creating interactive websites and web applications. However, no matter how carefully we write our code, errors are inevitable. Imagine driving a car without brakes—one small obstacle could lead to disaster. Similarly, a JavaScript program without proper error handling can crash unexpectedly, frustrate users, and make debugging difficult. Error handling is the process of detecting, managing, and responding to errors in a controlled manner. Instead of allowing our application to stop working, we can catch errors, display meaningful messages, log problems for developers, and even recover gracefully. By mastering error handling, we write applications that are reliable, maintainable, and user-friendly.

## Understanding JavaScript Errors

### A. What is an Error?

An error is a problem that prevents a JavaScript program from executing correctly. Some errors stop the program immediately, while others produce incorrect results without generating any warning. For example:

```

console.log("Hello");
console.lo("World");

```

The second line contains a typo (`console.lo` instead of `console.log`), causing JavaScript to throw an error.

### B. Types of JavaScript Errors

### 1. Syntax Errors

Syntax errors occur when the code violates JavaScript grammar rules. Since the browser cannot understand the code, execution stops before the program even starts. Example:

```

let x = ;

```

Here, the variable assignment is incomplete, resulting in a syntax error.

### 2. Reference Errors

Reference errors happen when we try to use a variable or function that has not been declared. Example:

```

console.log(username);

```

Output:

```

ReferenceError: username is not defined

```

### 3. Type Errors

Type errors occur when an operation is performed on an inappropriate data type. Example:

```

let num = 10;
num.toUpperCase();

```

Since numbers do not have a `toUpperCase()` method, JavaScript throws a TypeError.

### 4. Range Errors

Range errors occur when a value falls outside the acceptable range. Example:

```

let arr = new Array(-5);

```

Creating an array with a negative length produces a RangeError.

### 5. URI Errors

URI errors occur when invalid Uniform Resource Identifier (URI) functions are used. Example:

```

decodeURIComponent("%");

```

The invalid URI encoding triggers a URIError.

### 6. Custom Errors

Developers can create their own errors to handle specific situations. Example:

```

throw new Error("Invalid password.");

```

Custom errors make applications easier to understand and maintain.

## The Try-Catch-Finally Statement

One of JavaScript\'s most powerful error-handling mechanisms is the `try...catch...finally` statement. Think of it as a safety net beneath a tightrope walker. Even if something goes wrong, the fall is controlled. **A. The** `try` **Block** The `try` block contains code that may produce an error.

```

try {
console.log(user.name);
}

```

**B. The** `catch` **Block** If an error occurs inside the `try` block, execution immediately moves to the `catch` block.

```

try {
console.log(user.name);
}
catch(error) {
console.log(error.message);
}

```

The `error` object contains useful information such as:

- `name`

- `message`

- `stack`

Example:

```

console.log(error.name);
console.log(error.message);

```

**C. The** `finally` **Block** The `finally` block executes whether an error occurs or not. It is commonly used for cleanup tasks.

```

try {
console.log("Program started");
}
catch(error) {
console.log(error);
}
finally {
console.log("Program finished");
}

```

Output:

```

Program started
Program finished

```

## Complete Example

```

try {
let result = 10 / 0;
console.log(result);
}
catch(error) {
console.log("An error occurred.");
}
finally {
console.log("Execution completed.");
}

```

## Throwing Custom Errors

Sometimes JavaScript\'s built-in errors are not enough. We may need to define our own rules and generate meaningful error messages. **A. Using the** `throw` **Statement** The `throw` keyword manually generates an exception. Example:

```

let age = 15;
if(age < 18){
throw new Error("You must be at least 18 years old.");
}

```

### B. Validating User Input

Input validation is one of the most common uses of custom errors.

```

function divide(a, b){
if(b === 0){
throw new Error("Division by zero is not allowed.");
}
return a / b;
}
try{
console.log(divide(10,0));
}
catch(error){
console.log(error.message);
}

```

Output:

```

Division by zero is not allowed.

```

## Creating Custom Error Classes

JavaScript allows developers to create specialized error classes.

```

class ValidationError extends Error{
constructor(message){
super(message);
this.name = "ValidationError";
}
}
throw new ValidationError("Invalid email address.");

```

This approach makes large applications more organized and easier to debug.

## Best Practices for Error Handling

### A. Always Handle Expected Errors

Never assume that user input, API responses, or files will always be correct. Validate inputs before processing them. Bad Practice:

```

console.log(user.name);

```

Good Practice:

```

if(user){
console.log(user.name);
}

```

### B. Avoid Empty Catch Blocks

Ignoring errors makes debugging extremely difficult. Bad Example:

```

try{
riskyFunction();
}
catch(error){
}

```

Good Example:

```

try{
riskyFunction();
}
catch(error){
console.error(error.message);
}

```

## Use Meaningful Error Messages

Instead of writing:

```

throw new Error("Error");

```

Write:

```

throw new Error("Password must contain at least eight characters.");

```

Clear messages help both developers and users understand the issue quickly.

## Log Errors Properly

During development, logging errors is essential.

```

console.error(error);

```

For production applications, errors are often recorded in monitoring systems so developers can investigate issues later.

### E. Don\'t Overuse Try-Catch

Using `try...catch` everywhere can make code difficult to read. Instead, use it only where errors are likely to occur.

### F. Handle Asynchronous Errors

Modern JavaScript relies heavily on asynchronous programming using Promises and `async/await`. Example:

```

async function fetchData(){
try{
let response = await fetch("data.json");
let data = await response.json();
console.log(data);
}
catch(error){
console.log("Failed to fetch data.");
}
}

```

Without proper error handling, failed network requests can cause unexpected application behavior.

## Common Error Handling Scenarios

### A. Handling API Errors

When working with APIs, requests may fail due to internet issues, server errors, or invalid responses.

```

fetch("https://api.example.com/users")
.then(response => response.json())
.catch(error => console.log(error));

```

### B. Handling Form Validation

```

if(email === ""){
throw new Error("Email cannot be empty.");
}

```

This prevents invalid data from being processed.

## Handling File Operations

Whenever files are uploaded or processed, developers should verify:

- File type

- File size

- File format

- Upload success

Proper validation improves security and user experience.

## Debugging with Error Objects

The Error object provides valuable debugging information.

```

try{
test();
}
catch(error){
console.log(error.name);
console.log(error.message);
console.log(error.stack);
}

```

These details help identify exactly where the problem occurred.

## Advantages of Proper Error Handling

Effective error handling offers numerous benefits:

- Improves application stability.

- Prevents unexpected crashes.

- Simplifies debugging and maintenance.

- Enhances user experience with meaningful feedback.

- Protects applications from invalid input.

- Makes code more reliable and professional.

- Supports easier testing and troubleshooting.

- Increases overall software quality.

### Conclusion

Error handling is an essential part of JavaScript programming because errors are unavoidable in real-world applications. Rather than allowing a program to fail unexpectedly, we can anticipate problems and respond to them intelligently using tools such as `try`, `catch`, `finally`, and `throw`. Understanding different types of errors, creating custom exceptions, and following best practices enable us to build applications that are robust, secure, and easier to maintain. As we continue developing more complex software, effective error handling becomes not just a helpful technique but a fundamental skill that ensures our JavaScript applications remain dependable, user-friendly, and resilient even when unexpected situations arise.');

-- Lecture 13: Working with APIs in JavaScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Working with APIs in JavaScript', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Working with APIs in JavaScript

## Introduction to APIs in JavaScript

Modern web applications rarely work in isolation. Whether we are checking the weather, displaying live sports scores, logging into a website, making online payments, or scrolling through social media, our applications constantly communicate with external services. This communication is made possible through **Application Programming Interfaces (APIs).** Think of an API as a waiter in a restaurant. We (the client) tell the waiter what we want. The waiter delivers our request to the kitchen (the server), and once the food is ready, the waiter brings it back to us. In the same way, JavaScript sends a request to a server through an API and receives the requested data in return. Working with APIs is one of the most important skills for JavaScript developers because it enables applications to retrieve real-time information, exchange data, and connect with countless online services.

## Understanding APIs

### A. What is an API?

An **Application Programming Interface (API)** is a set of rules that allows two software applications to communicate with each other. APIs define how requests should be made, what information should be included, and what responses should be returned. Instead of accessing a database directly, JavaScript applications usually communicate with a server through an API. For example:

- Weather applications retrieve weather data from weather APIs.

- Google Maps displays locations using mapping APIs.

- Shopping websites retrieve products through e-commerce APIs.

- Banking apps communicate with secure financial APIs.

Without APIs, sharing information between applications would be extremely difficult.

### B. Why Do We Use APIs?

APIs provide several important benefits:

- Allow applications to exchange information.

- Access real-time data.

- Reduce development time.

- Improve scalability.

- Enable integration with third-party services.

- Simplify software communication.

- Increase application functionality.

Instead of building everything from scratch, we simply connect to existing services.

## Types of APIs

### 1. Public APIs

Public APIs are available for anyone to use. Examples include:

- Weather APIs

- Currency exchange APIs

- News APIs

### 2. Private APIs

Private APIs are used internally within an organization and require authentication.

### 3. Partner APIs

Partner APIs are shared only with approved business partners.

### 4. REST APIs

REST (Representational State Transfer) APIs are the most common type used in JavaScript development. They communicate over HTTP and usually exchange data in JSON format.

## API Endpoint

An endpoint is the specific URL where an API receives requests. Example:

```

https://api.example.com/users

```

This endpoint may return a list of users.

## HTTP Methods Used in APIs

Whenever JavaScript communicates with an API, it uses HTTP methods.

### A. GET Request

The GET method retrieves data from a server. Example:

```

fetch("https://jsonplaceholder.typicode.com/posts")

```

GET requests do not modify server data.

### B. POST Request

POST sends new data to the server. Example use cases:

- Registering a new user

- Creating a blog post

- Submitting a form

Example:

```

fetch("https://api.example.com/users",{
method:"POST"
})

```

## PUT Request

PUT updates an existing resource. Example: Updating user information.

## DELETE Request

DELETE removes information from the server. Example: Deleting a product from a shopping cart.

### E. PATCH Request

PATCH partially updates existing data. Example: Changing only a user\'s email without updating the entire profile.

## JSON: The Language of APIs

### A. What is JSON?

Most APIs exchange information using **JSON (JavaScript Object Notation).** JSON is lightweight, easy to read, and simple for computers to process. Example:

```

{
"id":1,
"name":"John",
"age":24
}

```

JavaScript can easily convert JSON into objects.

### B. Parsing JSON

When an API returns JSON, we convert it into a JavaScript object. Example:

```

let response = await fetch(url);
let data = await response.json();
console.log(data);

```

The `.json()` method parses the response body into a JavaScript object.

## Fetch API in JavaScript

The **Fetch API** is the modern way to communicate with servers in JavaScript. Its syntax is simple, flexible, and Promise-based. Basic syntax: `fetch(url)`

### A. Fetching Data

Example:

```

fetch("https://jsonplaceholder.typicode.com/users")
.then(response => response.json())
.then(data => {
console.log(data);
});

```

How it works: 1. JavaScript sends an HTTP request. 2. The server processes the request. 3. The server sends a response. 4. JavaScript converts JSON into an object. 5. The data is displayed.

### B. Using Async/Await

Modern JavaScript prefers `async/await`. Example:

```

async function getUsers(){
let response = await fetch("https://jsonplaceholder.typicode.com/users");
let users = await response.json();
console.log(users);
}
getUsers();

```

This syntax is easier to read than long Promise chains.

## Handling Errors

Network requests can fail because of:

- No internet connection

- Invalid URL

- Server failure

- Timeout

- Authentication issues

Example:

```

async function getData(){
try{
let response = await fetch("https://jsonplaceholder.typicode.com/posts");
let data = await response.json();
console.log(data);
}
catch(error){
console.log("Error:",error.message);
}
}

```

Using `try...catch` prevents unexpected application crashes.

## Sending Data to an API

APIs not only return data—they also accept data. Example:

```

fetch("https://jsonplaceholder.typicode.com/posts",{
method:"POST",
headers:{
"Content-Type":"application/json"
},
body:JSON.stringify({
title:"JavaScript",
body:"Working with APIs",
userId:1
})
})
.then(response=>response.json())
.then(data=>console.log(data));

```

### Explanation

- `method` specifies the HTTP request type.

- `headers` describe the data format.

- `body` contains the information being sent.

- `JSON.stringify()` converts a JavaScript object into JSON.

## API Response Status Codes

Servers respond with HTTP status codes that indicate the outcome of a request.

### 200 OK

The request completed successfully.

### 201 Created

A new resource was created successfully.

### 400 Bad Request

The request contains invalid information.

### 401 Unauthorized

Authentication is required.

### 403 Forbidden

The client does not have permission to access the resource.

### 404 Not Found

The requested resource could not be found.

### 500 Internal Server Error

The server encountered an unexpected problem. Understanding these status codes helps developers quickly diagnose issues.

## Authentication in APIs

Many APIs require authentication before granting access. Common authentication methods include:

- API Keys

- Bearer Tokens

- OAuth

- JSON Web Tokens (JWT)

Example:

```

fetch(url,{
headers:{
Authorization:"Bearer YOUR_TOKEN"
}
})

```

Authentication ensures that only authorized users or applications can access protected resources.

## Best Practices for Working with APIs

To build reliable and secure applications, we should follow these best practices:

- Always validate API responses before using the data.

- Use `try...catch` to handle errors gracefully.

- Check HTTP status codes before processing responses.

- Never expose secret API keys in client-side code.

- Use HTTPS to encrypt communication.

- Cache frequently requested data when appropriate.

- Avoid sending unnecessary requests.

- Write clean and reusable API functions.

- Display user-friendly error messages instead of technical details.

- Read the API documentation carefully before integration.

Following these practices improves performance, security, and maintainability.

## Real-World Applications of APIs

JavaScript APIs power countless modern applications, including:

- Weather forecasting applications.

- Online shopping websites.

- Banking and payment systems.

- Food delivery platforms.

- Social media feeds.

- Movie and music streaming services.

- GPS and navigation systems.

- AI-powered chatbots and virtual assistants.

- Flight and hotel booking platforms.

- Real-time messaging applications.

Without APIs, these applications would not be able to exchange data with external services efficiently.

## Advantages and Challenges of APIs

### Advantages

- Enables communication between different systems.

- Provides access to real-time information.

- Speeds up application development.

- Encourages software reuse.

- Improves scalability.

- Simplifies integration with third-party services.

### Challenges

- Network failures can interrupt communication.

- APIs may have rate limits.

- Authentication adds complexity.

- Poor documentation can slow development.

- Changes in API versions may require code updates.

Developers must design applications that can handle these challenges effectively.

### Conclusion

Working with APIs is a fundamental skill in JavaScript development because APIs connect applications to the vast ecosystem of online services. By understanding API concepts, HTTP methods, JSON, the Fetch API, authentication, and proper error handling, we can build dynamic, data-driven applications that deliver real-time experiences. Whether we are retrieving weather forecasts, processing online payments, displaying social media content, or integrating artificial intelligence services, APIs serve as the bridge between our application and external systems. As we continue to develop more advanced web applications, mastering API integration will enable us to create software that is powerful, scalable, secure, and responsive to the needs of modern users.');

-- Lecture 14: JavaScript Project Development Workflow
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'JavaScript Project Development Workflow', 14, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# JavaScript Project Development Workflow

## Introduction to Building Interactive JavaScript Projects

JavaScript is the heart of modern web development. While HTML provides the structure of a webpage and CSS enhances its appearance, JavaScript adds intelligence and interactivity. Every time we click a button, submit a form, play a game, search for information, or receive live updates without refreshing the page, JavaScript is working behind the scenes. Building an interactive project is one of the best ways to strengthen our programming skills. Instead of learning concepts in isolation, we combine variables, functions, events, loops, conditions, objects, APIs, and the Document Object Model (DOM) to create applications that users can actually interact with. It is much like assembling a machine from individual parts—each component performs a specific task, but together they create something meaningful. Interactive projects also teach us how to solve real-world problems, debug errors, and think logically. As developers, we should focus not only on making our applications work but also on creating experiences that are fast, responsive, and enjoyable for users.

## Planning an Interactive Project

### A. Understanding the Project Requirements

Every successful project begins with a clear plan. Before writing any code, we should understand what the application is supposed to do. For example, if we are creating a **To-Do List Application**, we should identify its main features:

- Add new tasks.

- Mark tasks as completed.

- Delete tasks.

- Edit existing tasks.

- Store tasks for future use.

Planning before coding reduces confusion and minimizes mistakes during development.

### B. Designing the User Interface (UI)

A user interface is the visual part of an application that users interact with. An effective UI should be:

- Simple and clean.

- Easy to navigate.

- Responsive on different devices.

- Visually attractive.

- User-friendly.

For example, a calculator should have clearly labeled buttons, while a weather application should display information in an organized format. Good design improves the overall user experience.

## Breaking the Project into Modules

Large projects become easier to manage when divided into smaller components. For example, a weather application can include:

- Search module.

- API communication module.

- Data processing module.

- Display module.

- Error handling module.

This modular approach makes development, testing, and maintenance much easier.

## Setting Up the Project Structure

A well-organized project keeps files easy to locate and maintain. Example folder structure:

```

Project/
│
├── index.html
├── style.css
├── script.js
├── images/
├── assets/
└── README.md

```

### HTML

Provides the webpage structure.

### CSS

Controls colors, layouts, animations, and responsiveness.

### JavaScript

Handles user interaction and application logic. Keeping these files separate improves readability and follows industry best practices.

## Making the Project Interactive

### A. Selecting HTML Elements

JavaScript interacts with webpage elements using the DOM. Example:

```

const button = document.getElementById("submitBtn");

```

The application can now access the selected button.

### B. Event Handling

Events allow JavaScript to respond to user actions. Common events include:

- Click

- Double click

- Mouse over

- Key press

- Input

- Submit

- Change

Example:

```

button.addEventListener("click", function(){
alert("Button Clicked!");
});

```

Whenever the user clicks the button, the function executes.

## Updating the DOM

One of JavaScript\'s greatest strengths is dynamically changing webpage content. Example:

```

document.getElementById("title").textContent = "Welcome!";

```

Instead of refreshing the page, JavaScript updates the content instantly.

## Creating Elements Dynamically

Interactive applications often generate content while running. Example:

```

const li = document.createElement("li");
li.textContent = "Study JavaScript";
document.getElementById("tasks").appendChild(li);

```

This creates a new list item without modifying the HTML file.

## Using Functions and Objects

Functions organize code into reusable blocks. Example:

```

function greet(name){
return "Hello " + name;
}
console.log(greet("Ali"));

```

Objects help store related information. Example:

```

const student = {
name:"Ali",
age:20,
course:"JavaScript"
};
console.log(student.name);

```

Combining functions and objects keeps applications organized and easier to maintain.

## Working with Forms and User Input

Interactive projects frequently collect information from users. Example:

```

const username = document.getElementById("username").value;

```

After collecting input, we should always validate it. Example:

```

if(username === ""){
alert("Please enter your name.");
}

```

Input validation prevents invalid data from entering the application.

## Using APIs in Interactive Projects

Many modern applications retrieve live data from external services. Example:

```

async function getUsers(){
const response = await fetch("https://jsonplaceholder.typicode.com/users");
const users = await response.json();
console.log(users);
}

```

API integration allows projects to display:

- Weather information.

- News headlines.

- Currency exchange rates.

- Movie details.

- Sports scores.

- Product information.

Real-time data makes applications more useful and engaging.

## Storing Data with Local Storage

Some applications need to remember user information even after the browser is closed. JavaScript provides **Local Storage**. Saving data:

```

localStorage.setItem("username","Ali");

```

Retrieving data:

```

const user = localStorage.getItem("username");

```

Removing data:

```

localStorage.removeItem("username");

```

Local Storage is commonly used in:

- To-do list applications.

- Theme preferences.

- Shopping carts.

- User settings.

## Handling Errors and Debugging

Even experienced developers encounter errors. The goal is not to avoid mistakes entirely but to handle them effectively. Example:

```

try{
let response = await fetch(url);
}
catch(error){
console.log(error.message);
}

```

Useful debugging techniques include:

- Reading error messages carefully.

- Using `console.log()`.

- Inspecting variables in browser Developer Tools.

- Testing one feature at a time.

- Writing small, reusable functions.

Debugging improves application stability and simplifies maintenance.

## Improving User Experience

An interactive project should feel smooth and responsive. We can improve the user experience by adding:

- Loading indicators.

- Smooth animations.

- Hover effects.

- Form validation.

- Confirmation messages.

- Responsive layouts.

- Clear navigation.

Example:

```

button.disabled = true;

```

Disabling a button while processing a request prevents duplicate submissions and enhances usability.

## Testing the Project

Before deployment, every feature should be tested thoroughly. Testing checklist:

- Do all buttons work?

- Are forms validated?

- Do API requests succeed?

- Does Local Storage function correctly?

- Does the project work on different browsers?

- Is the layout responsive on mobile devices?

- Are errors handled gracefully?

Regular testing ensures a reliable application.

## Real-World Interactive Project Ideas

Once we understand JavaScript fundamentals, we can build a wide range of practical applications, such as:

- To-Do List Manager.

- Weather Forecast App.

- Calculator.

- Quiz Application.

- Expense Tracker.

- Currency Converter.

- Notes Application.

- Digital Clock.

- Stopwatch and Timer.

- Image Gallery.

- Music Player.

- Chat Interface.

- Recipe Finder.

- Movie Search Application.

- Student Management System.

Each project introduces new concepts while reinforcing existing knowledge.

## Best Practices for Interactive JavaScript Projects

Professional developers follow coding practices that improve readability and maintainability. Some important guidelines include:

- Write meaningful variable and function names.

- Keep functions small and focused.

- Avoid repeating code unnecessarily.

- Separate HTML, CSS, and JavaScript files.

- Comment complex logic when needed.

- Validate all user input.

- Handle errors gracefully.

- Organize files into logical folders.

- Test features regularly.

- Optimize performance by minimizing unnecessary DOM updates.

These habits make projects easier to expand and maintain as they grow.

## Advantages of Building Interactive Projects

Creating interactive applications offers many benefits:

- Strengthens problem-solving skills.

- Reinforces JavaScript concepts through practical use.

- Improves debugging and logical thinking.

- Enhances understanding of the DOM and browser behavior.

- Builds confidence in developing real-world applications.

- Creates portfolio projects for internships and jobs.

- Encourages creativity and innovation.

- Prepares developers for advanced frameworks such as React, Vue, and Angular.

The more projects we build, the more comfortable we become with JavaScript development.

### Conclusion

Building an interactive project in JavaScript is one of the most effective ways to transform programming knowledge into practical experience. By combining HTML, CSS, and JavaScript, we can create dynamic applications that respond to user actions, process data, communicate with APIs, and store information locally. Throughout the development process, we learn to plan effectively, organize code, validate user input, handle errors, and optimize the user experience. Most importantly, interactive projects encourage us to think like software developers by solving real-world problems with clean, efficient, and maintainable code. As we continue practicing and exploring more complex projects, we strengthen both our technical skills and our confidence, preparing ourselves to build modern web applications that are engaging, reliable, and impactful.');
