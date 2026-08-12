-- =============================================
-- ReflectAI — TypeScript Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'TypeScript' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to TypeScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to TypeScript', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to TypeScript

TypeScript has become one of the most popular programming languages for modern web development. If JavaScript is the foundation of the web, then TypeScript is the blueprint that helps developers build stronger and more reliable applications. It extends JavaScript by adding features such as static typing, interfaces, and advanced development tools while remaining fully compatible with JavaScript. Imagine constructing a building without a blueprint. You might eventually finish it, but mistakes would be difficult to detect until something went wrong. JavaScript is flexible enough to let us build quickly, but TypeScript provides the blueprint that catches many errors before the application even runs. In these lecture notes, we will explore the fundamentals of TypeScript, understand why it was created, and learn how it improves software development.

## Understanding TypeScript

### What is TypeScript?

TypeScript is an open-source programming language developed by Microsoft. It is a superset of JavaScript, which means every valid JavaScript program is also valid TypeScript. Developers can write TypeScript code and then compile it into plain JavaScript that browsers and JavaScript engines understand. Unlike JavaScript, which checks many errors only while the program is running, TypeScript performs static type checking during development. This allows us to identify mistakes before the application is executed. For example:

```

let name: string = "John";
let age: number = 25;
console.log(name);
console.log(age);

```

Here, TypeScript ensures that `name` always stores text and `age` always stores numbers.

### Why Was TypeScript Created?

As JavaScript projects became larger and more complex, developers encountered several challenges:

- Difficult debugging

- Runtime errors

- Poor code maintainability

- Lack of type safety

- Difficulty collaborating on large projects

TypeScript addresses these problems by introducing optional static typing, better tooling, and improved code organization. Instead of discovering mistakes after deploying an application, developers can catch them while writing code.

### Features of TypeScript

Some of the major features include:

- Static typing

- Object-oriented programming support

- Interfaces

- Classes

- Modules

- Generics

- Type inference

- Better IntelliSense support

- Compatibility with JavaScript

These features make TypeScript highly suitable for enterprise-level applications.

## Why Learn TypeScript?

### Advantages of TypeScript

Learning TypeScript offers many benefits.

### 1. Early Error Detection

TypeScript detects type-related mistakes during compilation. Example:

```

let salary: number = 50000;
salary = "High";

```

The compiler immediately reports an error because a string cannot be assigned to a number.

### 2. Better Code Readability

Type definitions clearly explain what kind of data variables, functions, and objects should contain.

```

function greet(name: string): string {
return "Hello " + name;
}

```

Anyone reading the code immediately understands that the function accepts a string and returns a string.

### 3. Easier Team Collaboration

When multiple developers work on the same project, clearly defined types reduce confusion and improve communication.

### 4. Excellent IDE Support

Editors like Visual Studio Code provide:

- Auto-completion

- Error highlighting

- Intelligent suggestions

- Code navigation

- Refactoring tools

This significantly increases developer productivity.

### 5. Scalability

TypeScript is ideal for:

- Enterprise applications

- Large web applications

- Backend development

- Mobile development

- Cloud applications

Its structured nature makes large projects easier to maintain.

## Installing and Setting Up TypeScript

### Prerequisites

Before installing TypeScript, we need:

- Node.js

- npm (Node Package Manager)

### Installing TypeScript

Install TypeScript globally using npm: `npm install -g typescript` To verify the installation: `tsc --version` The terminal displays the installed TypeScript version.

### Creating the First TypeScript File

Create a file: `app.ts` Write the following code:

```

let message: string = "Welcome to TypeScript";
console.log(message);

```

Compile the file: `tsc app.ts` TypeScript generates: `app.js` Execute it using Node.js: `node app.js` Output: `Welcome to TypeScript`

### TypeScript Compilation Process

The development process follows these steps:

```

TypeScript Code (.ts)
↓
TypeScript Compiler (tsc)
↓
JavaScript Code (.js)
↓
Browser or Node.js

```

This compilation process ensures that browsers only execute standard JavaScript.

## Basic Syntax of TypeScript

### Variables

Variables can have explicit data types.

```

let city: string = "London";
let temperature: number = 30;
let isSunny: boolean = true;

```

### Data Types

TypeScript supports several built-in data types.

### String

```

let language: string = "TypeScript";

```

### Number

```

let marks: number = 95;

```

### Boolean

```

let passed: boolean = true;

```

### Array

```

let subjects: string[] = ["Math", "Physics", "English"];

```

or

```

let scores: Array<number> = [90, 80, 70];

```

### Tuple

A tuple stores values of different types in a fixed order.

```

let student: [string, number];
student = ["Ali", 20];

```

### Enum

Enums represent named constants.

```

enum Color {
Red,
Green,
Blue
}
let favorite = Color.Green;

```

### Any

The `any` type disables type checking.

```

let value: any;
value = 10;
value = "Hello";
value = true;

```

Although useful in some situations, excessive use of `any` defeats the purpose of TypeScript.

### Unknown

`unknown` is safer than `any` because values must be checked before use.

```

let input: unknown = "Hello";

```

### Void

Used mainly for functions that return nothing.

```

function display(): void {
console.log("Welcome");
}

```

### Type Inference

TypeScript often determines types automatically.

```

let age = 18;

```

The compiler understands that `age` is a number without explicitly writing the type.

## TypeScript Compared with JavaScript

### JavaScript Example

```

let price = 500;
price = "Cheap";

```

JavaScript allows this without immediate errors.

### TypeScript Example

```

let price: number = 500;
price = "Cheap";

```

The compiler reports an error because the assigned value is not a number.

### Key Differences

| Feature | JavaScript | TypeScript |
|---|---|---|
| Typing | Dynamic | Static (optional) |
| Compilation | Not required | Required |
| Error Detection | Runtime | Compile time |
| IDE Support | Good | Excellent |
| Large Projects | Harder | Easier |
| Learning Curve | Easier | Slightly higher |

### When Should We Use TypeScript?

TypeScript is particularly useful for:

- Large-scale applications

- Business software

- React projects

- Angular applications

- Node.js backend development

- Collaborative team projects

- Applications requiring long-term maintenance

For very small scripts or prototypes, JavaScript alone may be sufficient. However, as project size grows, TypeScript becomes increasingly valuable.

### Real-World Applications

Many well-known organizations use TypeScript because it improves reliability and maintainability. Examples include:

- Web applications

- Enterprise software

- Cloud platforms

- E-commerce websites

- Banking systems

- Educational platforms

- Content management systems

TypeScript integrates seamlessly with modern frameworks such as React, Angular, Vue, and Node.js, making it a preferred choice for full-stack development.

### Conclusion

TypeScript is more than just an extension of JavaScript—it is a powerful tool that helps us write cleaner, safer, and more maintainable code. By introducing static typing, interfaces, classes, and enhanced development tools, it reduces runtime errors and improves productivity, especially in large applications. Since TypeScript compiles into standard JavaScript, developers gain all its advantages without sacrificing compatibility with existing browsers or JavaScript environments. As modern software projects continue to grow in complexity, learning TypeScript is a valuable investment that equips us to build scalable, reliable, and professional applications with greater confidence.');

-- Lecture 2: Basic Types in TypeScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Basic Types in TypeScript', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Basic Types in TypeScript

TypeScript is a statically typed superset of JavaScript that helps developers write more reliable and maintainable code. One of its most powerful features is its type system. Types define what kind of data a variable can store, allowing the TypeScript compiler to catch errors during development rather than at runtime. Think of types as labels on storage boxes—they tell us exactly what belongs inside. In this lecture, we will explore the fundamental data types provided by TypeScript, understand how they work, and learn when to use each one.

## Introduction to Basic Types

### What Are Data Types?

A data type specifies the kind of value that a variable can hold. By assigning types, we make our code easier to understand and less prone to errors. For example:

```

let username: string = "Alice";
let age: number = 22;

```

Here, `username` can only store text, while `age` can only store numbers.

### Why Are Types Important?

Using types provides several benefits:

- Detects errors during compilation.

- Improves code readability.

- Makes debugging easier.

- Enhances IDE features like auto-completion.

- Prevents accidental assignment of incorrect values.

### Type Annotation vs Type Inference

### Type Annotation

We explicitly specify the data type.

```

let city: string = "London";

```

### Type Inference

TypeScript automatically determines the type.

```

let city = "London";

```

In both cases, `city` is treated as a string.

## Primitive Data Types

Primitive types represent single values and form the foundation of TypeScript.

### 1. String

The `string` type stores textual data.

```

let firstName: string = "John";
let message: string = "Welcome to TypeScript";

```

### Common String Operations

```

let language: string = "TypeScript";
console.log(language.length);
console.log(language.toUpperCase());
console.log(language.toLowerCase());

```

**Output:**

```

10
TYPESCRIPT
typescript

```

### 2. Number

The `number` type stores both integers and floating-point values.

```

let age: number = 25;
let price: number = 99.99;
let temperature: number = -5;

```

### Example

```

let a: number = 15;
let b: number = 5;
console.log(a + b);
console.log(a * b);

```

**Output**

```

20
75

```

### 3. Boolean

The `boolean` type stores either `true` or `false`.

```

let isStudent: boolean = true;
let hasLicense: boolean = false;

```

### Example

```

let isLoggedIn: boolean = true;
if (isLoggedIn) {
console.log("Welcome!");
}

```

### 4. BigInt

`bigint` is used for extremely large integers that exceed the safe range of the `number` type.

```

let largeNumber: bigint = 9007199254740995n;

```

### When to Use BigInt

- Financial systems

- Scientific calculations

- Large database IDs

### 5. Symbol

A `symbol` creates a unique value.

```

let id1 = Symbol("id");
let id2 = Symbol("id");
console.log(id1 === id2);

```

**Output** `false` Every symbol is unique, even if they share the same description.

## Collection Types

Collection types store multiple values.

### 1. Arrays

Arrays hold multiple values of the same type.

### Method 1

```

let numbers: number[] = [10, 20, 30];

```

### Method 2

```

let colors: Array<string> = ["Red", "Green", "Blue"];

```

### Accessing Elements

```

console.log(numbers[0]);
console.log(colors[1]);

```

**Output**

```

10
Green

```

### Adding Elements

```

numbers.push(40);

```

### 2. Tuples

A tuple stores multiple values of different types in a fixed order.

```

let employee: [number, string];
employee = [101, "Ali"];

```

### Example

```

let student: [string, number, boolean];
student = ["Sara", 20, true];

```

Each position has a predefined type.

## Special Types

TypeScript provides several special-purpose types.

### 1. Any

The `any` type disables type checking.

```

let value: any;
value = 10;
value = "Hello";
value = true;

```

### Advantages

- Flexible

- Useful when migrating JavaScript projects

### Disadvantages

- Removes type safety

- Can introduce runtime errors

### 2. Unknown

`unknown` is a safer alternative to `any`.

```

let input: unknown = "Hello";

```

Before using an `unknown` value, its type must be checked.

```

if (typeof input === "string") {
console.log(input.toUpperCase());
}

```

### 3. Void

`void` is mainly used for functions that do not return any value.

```

function display(): void {
console.log("Hello");
}

```

### 4. Null

Represents the intentional absence of a value.

```

let data: null = null;

```

### 5. Undefined

Represents a variable that has been declared but not assigned a value.

```

let value: undefined = undefined;

```

### 6. Never

The `never` type represents values that never occur.

### Example

```

function throwError(message: string): never {
throw new Error(message);
}

```

Functions that always throw an error or never finish executing use the `never` type.

## Type Safety and Best Practices

### Type Checking Example

Correct code:

```

let marks: number = 90;
marks = 95;

```

Incorrect code:

```

let marks: number = 90;
marks = "Excellent";

```

The compiler reports an error because a string cannot be assigned to a number.

### Choosing the Right Type

| Situation | Recommended Type |
|---|---|
| Names | string |
| Age | number |
| Yes/No Values | boolean |
| Lists | array |
| Mixed Fixed Values | tuple |
| Unknown Input | unknown |
| No Return Value | void |
| Extremely Large Integers | bigint |
| Unique Identifiers | symbol |

### Best Practices

### 1. Prefer Specific Types

Use:

```

let salary: number = 50000;

```

Instead of:

```

let salary: any = 50000;

```

**2. Avoid Overusing** `any` Only use `any` when absolutely necessary, such as when working with legacy JavaScript code.

### 3. Let TypeScript Infer Types

Instead of writing:

```

let country: string = "Pakistan";

```

We can write:

```

let country = "Pakistan";

```

TypeScript automatically infers that `country` is a string. **4. Use** `unknown` **Instead of** `any` **for External Data** When receiving data from APIs or user input, prefer `unknown` because it forces type checking before use.

| Type | Description | Example |
|---|---|---|
| string | Text values | "Hello" |
| number | Numeric values | 25, 3.14 |
| boolean | True or false | true |
| bigint | Very large integers | 123456789n |
| symbol | Unique identifiers | Symbol("id") |
| array | Collection of same type | [1,2,3] |
| tuple | Fixed mixed types | ["Ali", 20] |
| any | Any value | "Hi", 5, true |
| unknown | Unknown value with type checking | API input |
| void | No return value | Function |
| null | Intentional empty value | null |
| undefined | Unassigned value | undefined |
| never | Never returns | Error function |

### Conclusion

Basic types are the foundation of TypeScript programming. They allow us to define exactly what kind of data our variables, functions, and objects should contain, making our code safer, more readable, and easier to maintain. By using types such as `string`, `number`, `boolean`, `array`, `tuple`, and special types like `unknown`, `void`, and `never`, we can catch errors early and build more robust applications. As we continue learning TypeScript, mastering these basic types will make advanced concepts like interfaces, classes, generics, and modules much easier to understand and use effectively.');

-- Lecture 3: Arrays & Tuples
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Arrays & Tuples', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Arrays & Tuples

Arrays and tuples are essential data structures in TypeScript that allow us to store multiple values efficiently. While an array stores a collection of values of the same type, a tuple stores a fixed number of values that can have different data types. Understanding the difference between these two structures is important because they are widely used in real-world applications such as storing lists of products, employee records, coordinates, and function return values. Think of an array as a bookshelf filled with books of the same category, while a tuple is like an ID card where each field has a specific meaning and position, such as a name, age, and ID number. In this lecture, we will explore arrays, tuples, their syntax, operations, advantages, and best practices.

## Introduction to Arrays

### What is an Array?

An **array** is a collection of multiple values stored in a single variable. All elements in an array are generally of the same data type. Instead of creating many separate variables, we can store related values in one array.

### Syntax

```

let arrayName: dataType[] = [value1, value2, value3];

```

Example:

```

let numbers: number[] = [10, 20, 30, 40];

```

Here, the array `numbers` contains only numeric values.

### Alternative Array Syntax

TypeScript also supports the generic array syntax.

```

let fruits: Array<string> = ["Apple", "Banana", "Orange"];

```

Both syntaxes produce the same result.

### Advantages of Arrays

Arrays provide several benefits:

- Store multiple values in one variable.

- Reduce code repetition.

- Easy to loop through.

- Fast access using indexes.

- Simplify data management.

- Improve code organization.

## Working with Arrays

### Accessing Array Elements

Each array element has an index starting from **0**.

```

let colors: string[] = ["Red", "Green", "Blue"];
console.log(colors[0]);
console.log(colors[2]);

```

**Output**

```

Red
Blue

```

### Adding Elements

```

let numbers: number[] = [1, 2, 3];
numbers.push(4);
console.log(numbers);

```

**Output** `[1, 2, 3, 4]`

### Removing Elements

**Using** `pop()`

```

let fruits: string[] = ["Apple", "Banana", "Orange"];
fruits.pop();
console.log(fruits);

```

**Output** `["Apple", "Banana"]`

### Updating Elements

```

let cities: string[] = ["Lahore", "Karachi", "Islamabad"];
cities[1] = "Multan";
console.log(cities);

```

**Output**

```

["Lahore", "Multan", "Islamabad"]

```

### Array Length

```

let marks: number[] = [90, 85, 88];
console.log(marks.length);

```

**Output** `3`

### Looping Through Arrays

**Using** `for...of`

```

let subjects: string[] = ["Math", "Physics", "English"];
for (let subject of subjects) {
console.log(subject);

```

**Output**

```

Math
Physics
English

```

**Using** `forEach()`

```

let numbers: number[] = [10, 20, 30];
numbers.forEach((num) => {
console.log(num);
});

```

## Array Methods

TypeScript arrays inherit all standard JavaScript array methods. `push()` Adds an element to the end.

```

let values = [1, 2];
values.push(3);
pop()

```

Removes the last element.

```

values.pop();
shift()

```

Removes the first element.

```

let letters = ["A", "B", "C"];
letters.shift();
unshift()

```

Adds an element to the beginning.

```

letters.unshift("X");
includes()

```

Checks whether an element exists.

```

let colors = ["Red", "Green"];
console.log(colors.includes("Red"));

```

**Output**

```

true
sort()

```

Sorts array elements.

```

let numbers = [4, 2, 1, 3];
numbers.sort();
console.log(numbers);

```

**Output**

```

[1, 2, 3, 4]
map()

```

Creates a new array by transforming each element.

```

let numbers = [1, 2, 3];
let doubled = numbers.map(num => num * 2);
console.log(doubled);

```

**Output** `[2, 4, 6]`

## Introduction to Tuples

### What is a Tuple?

A **tuple** is a special type of array that stores a fixed number of elements where each position has a predefined data type. Unlike arrays, tuples allow different types of values in a specific order.

### Syntax

```

let student: [string, number];

```

### Creating a Tuple

```

let employee: [number, string];
employee = [101, "Ali"];
console.log(employee);

```

**Output** `[101, "Ali"]` The first value must be a number, and the second must be a string.

### Tuple with Multiple Types

```

let student: [string, number, boolean];
student = ["Sara", 20, true];

```

Here:

- Name → string

- Age → number

- Passed → boolean

Each value must appear in the correct position.

### Accessing Tuple Elements

```

let person: [string, number] = ["Ahmed", 25];
console.log(person[0]);
console.log(person[1]);

```

**Output**

```

Ahmed
25

```

### Updating Tuple Values

```

let product: [number, string];
product = [1, "Laptop"];
product[1] = "Desktop";
console.log(product);

```

## Arrays vs Tuples

Although arrays and tuples look similar, they serve different purposes.

### Comparison Table

| Feature | Array | Tuple |
|---|---|---|
| Data Types | Same type | Different types allowed |
| Length | Flexible | Usually fixed |
| Element Order | Not significant | Very important |
| Best Use | Lists of similar data | Structured records |
| Example | Student names | Student ID, Name, Age |

### When Should We Use Arrays?

Arrays are ideal for storing collections of similar values. Examples:

- Student names

- Product prices

- Book titles

- City names

Example:

```

let marks: number[] = [80, 85, 90, 95];

```

### When Should We Use Tuples?

Tuples are useful when each value has a specific meaning. Examples:

- Employee record

- GPS coordinates

- Database rows

- API responses

- User information

Example:

```

let coordinate: [number, number] = [45.2, 80.6];

```

### Best Practices

### 1. Use Arrays for Similar Data

Good example:

```

let temperatures: number[] = [30, 32, 28];

```

### 2. Use Tuples for Fixed Records

Good example:

```

let book: [number, string] = [101, "TypeScript Guide"];

```

### 3. Choose Meaningful Variable Names

Instead of:

```

let a: number[] = [1, 2, 3];

```

Use:

```

let scores: number[] = [1, 2, 3];

```

Meaningful names improve readability.

### 4. Avoid Mixing Data Types in Arrays

Instead of:

```

let data = [10, "Ali", true];

```

Use a tuple if different types are required:

```

let data: [number, string, boolean] = [10, "Ali", true];

```

### 5. Use TypeScript\'s Type Checking

Always define the expected type for arrays and tuples to catch errors during compilation.

### Quick Summary

| Concept | Description | Example |
|---|---|---|
| Array | Collection of similar values | number[] |
| Generic Array | Alternative array syntax | Array<string> |
| Tuple | Fixed collection of mixed types | [string, number] |
| push() | Adds an element | array.push(5) |
| pop() | Removes the last element | array.pop() |
| shift() | Removes the first element | array.shift() |
| unshift() | Adds at the beginning | array.unshift(1) |
| length | Returns number of elements | array.length |
| map() | Creates a transformed array | array.map () |
| includes() | Checks for a value | array.includes() |

### Conclusion

Arrays and tuples are fundamental data structures in TypeScript that help us organize and manage collections of data effectively. Arrays are best suited for storing multiple values of the same type with a flexible size, making them ideal for lists such as names, marks, or products. Tuples, on the other hand, are designed for fixed-size collections where each element has a specific type and position, making them perfect for structured records like employee details or coordinates. By understanding when to use arrays and when to use tuples, we can write cleaner, safer, and more maintainable TypeScript code while taking full advantage of TypeScript\'s powerful type system.');

-- Lecture 4: Functions & Type Annotations
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Functions & Type Annotations', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Functions & Type Annotations

Functions are one of the most important building blocks of any programming language. They allow us to organize code into reusable, manageable, and logical units. In TypeScript, functions become even more powerful because we can specify the types of parameters and return values using **type annotations**. This ensures that functions receive the correct kind of data and produce the expected output, reducing bugs and improving code quality. Think of a function as a vending machine. You insert the correct item (input), the machine processes it, and you receive the correct product (output). If you insert the wrong item, the machine refuses it. Similarly, TypeScript checks the input and output of functions during compilation, preventing many common programming mistakes. In this lecture, we will explore functions, type annotations, parameter types, return types, optional and default parameters, rest parameters, function types, and best practices.

## Introduction to Functions

### What is a Function?

A **function** is a reusable block of code designed to perform a specific task. Instead of writing the same code repeatedly, we can place it inside a function and call it whenever needed.

### Syntax

```

function functionName(parameters): returnType {
// code
}

```

### Example of a Simple Function

```

function greet(): void {
console.log("Welcome to TypeScript!");
}
greet();

```

**Output** `Welcome to TypeScript!` Since the function does not return any value, its return type is `void`.

### Advantages of Functions

Functions provide many benefits:

- Reduce code duplication.

- Improve readability.

- Make debugging easier.

- Encourage modular programming.

- Simplify maintenance.

- Increase code reusability.

## Type Annotations

### What are Type Annotations?

A **type annotation** explicitly specifies the type of a variable, parameter, or return value. It tells TypeScript what kind of data is expected.

### Example

```

function greet(name: string): string {
return "Hello " + name;
}

```

Here:

- `name: string` → Parameter type

- `: string` → Return type

### Calling the Function

```

console.log(greet("Ali"));

```

**Output** `Hello Ali` If we pass a number instead of a string, the TypeScript compiler reports an error.

### Parameter Type Checking

Correct:

```

function square(num: number): number {
return num * num;
}
console.log(square(5));

```

**Output** `25` Incorrect:

```

square("Five");

```

This produces a compile-time error because a string is not allowed where a number is expected.

## Function Parameters

### Required Parameters

By default, all parameters are required.

```

function add(a: number, b: number): number {
return a + b;
}
console.log(add(10, 5));

```

**Output** `15` Calling the function without both arguments results in an error.

### Optional Parameters

Optional parameters are marked with the `?` symbol.

```

function introduce(name: string, age?: number): void {
console.log(name, age);
}
introduce("Sara");
introduce("Ahmed", 22);

```

**Output**

```

Sara undefined
Ahmed 22

```

### Default Parameters

Default parameters automatically receive a value if no argument is passed.

```

function welcome(name: string = "Guest"): void {
console.log("Welcome " + name);
}
welcome();
welcome("Ali");

```

**Output**

```

Welcome Guest
Welcome Ali

```

### Rest Parameters

Rest parameters allow a function to accept multiple arguments.

```

function total(...numbers: number[]): number {
let sum = 0;
for (let num of numbers) {
sum += num;
}
return sum;
}
console.log(total(10, 20, 30));

```

**Output** `60` Rest parameters are useful when the number of arguments is unknown.

## Return Types and Function Expressions

### Return Types

The return type tells TypeScript what kind of value a function will return.

### Returning a Number

```

function multiply(a: number, b: number): number {
return a * b;
}

```

### Returning a Boolean

```

function isAdult(age: number): boolean {
return age >= 18;
}

```

### Returning Nothing (void)

```

function displayMessage(): void {
}

```

Functions with the `void` type do not return a value.

### Function Expressions

Functions can also be stored inside variables.

```

const subtract = function(a: number, b: number): number {
return a - b;
};
console.log(subtract(20, 5));

```

**Output** `15`

### Arrow Functions

Arrow functions provide a shorter syntax.

```

const divide = (a: number, b: number): number => {
return a / b;
};
console.log(divide(20, 4));

```

**Output** `5` For a single expression:

```

const square = (num: number): number => num * num;

```

## Function Types and Best Practices

### Function Type Variables

We can define the type of a function variable.

```

let calculate: (x: number, y: number) => number;
calculate = (a, b) => a + b;
console.log(calculate(4, 6));

```

**Output** `10`

### Using Type Aliases for Functions

Type aliases make function types reusable.

```

type MathOperation = (a: number, b: number) => number;
let add: MathOperation = (x, y) => x + y;
console.log(add(2, 3));
console.log(multiply(2, 3));

```

**Output**

```

5
6

```

### Function Overloading

Function overloading allows multiple function signatures with different parameter types.

```

function combine(a: string, b: string): string;
function combine(a: number, b: number): number;
function combine(a: any, b: any): any {
return a + b;
}
console.log(combine(5, 10));
console.log(combine("Hello ", "World"));

```

**Output**

```

15
Hello World

```

### Best Practices

### 1. Always Specify Parameter Types

Good practice:

```

function calculateArea(radius: number): number {
return 3.14 * radius * radius;
}

```

### 2. Specify Return Types

Explicit return types improve readability and prevent accidental mistakes.

```

function getName(): string {
return "John";
}

```

### 3. Use Meaningful Function Names

Good examples:

- `calculateTotal()`

- `printInvoice()`

- `findStudent()`

- `validateEmail()`

Meaningful names make code easier to understand.

### 4. Keep Functions Small

A function should perform one specific task. Small functions are easier to test, debug, and reuse.

### 5. Use Arrow Functions When Appropriate

Arrow functions are concise and commonly used for callbacks and simple operations.

### Quick Summary

| Concept | Description | Example |
|---|---|---|
| Function | Reusable block of code | function greet(){} |
| Type Annotation | Defines parameter or return type | name: string |
| Required Parameter | Must be provided | add(a, b) |
| Optional Parameter | May be omitted | age?: number |
| Default Parameter | Has a default value | name = "Guest" |
| Rest Parameter | Accepts multiple values | ...numbers |
| Return Type | Specifies returned value | : number |
| Function Expression | Function stored in a variable | const add = function(){} |
| Arrow Function | Short function syntax | (a, b) => a + b |
| Function Type | Defines a function\'s signature | (x, y) => number |
| Function Overloading | Multiple function signatures | combine() |

### Conclusion

Functions and type annotations are essential features of TypeScript that make code more structured, reliable, and maintainable. By defining parameter types and return types, we ensure that functions receive valid inputs and produce expected outputs, allowing many errors to be caught during compilation instead of at runtime. Features such as optional parameters, default parameters, rest parameters, arrow functions, function expressions, and function overloading provide flexibility while maintaining type safety. Mastering these concepts enables us to write cleaner, more reusable, and professional TypeScript code, forming a strong foundation for advanced topics such as classes, interfaces, generics, and modules.');

-- Lecture 5: Interfaces & Type Aliases in TypeScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Interfaces & Type Aliases in TypeScript', 5, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Interfaces & Type Aliases in TypeScript

As TypeScript applications grow larger, organizing and describing the structure of data becomes increasingly important. Imagine building a house without a blueprint—every room might end up in the wrong place. Similarly, writing code without defining the shape of objects can lead to confusion and bugs. TypeScript solves this problem through **Interfaces** and **Type Aliases**. These features allow us to define reusable data structures, making our code more readable, maintainable, and less error-prone. Although both Interfaces and Type Aliases can describe the shape of objects, they have unique capabilities and are used in different situations. In this lecture, we will explore both concepts, understand their differences, and learn best practices for using them effectively.

## Introduction to Interfaces

### What is an Interface?

An **interface** is a blueprint that defines the structure of an object. It specifies what properties and methods an object should have without providing their implementation. Think of an interface as a contract. If an object promises to follow the interface, it must include all the required properties with the correct data types.

### Syntax

```

interface Student {
name: string;
age: number;
}

```

Now any object of type `Student` must contain both `name` and `age`.

### Creating an Object Using an Interface

```

interface Student {
name: string;
age: number;
}
let student1: Student = {
name: "Ali",
age: 20
};
console.log(student1);

```

**Output**

```

{ name: \'Ali\', age: 20 }

```

If we omit a required property or use the wrong data type, TypeScript reports a compile-time error.

### Benefits of Interfaces

Interfaces provide several advantages:

- Improve code readability.

- Ensure consistency across objects.

- Reduce duplicate code.

- Improve IntelliSense support.

- Detect errors during development.

- Make large projects easier to maintain.

## Working with Interfaces

### Optional Properties

Sometimes not every property is required. We can make a property optional using the `?` symbol.

```

interface Employee {
id: number;
name: string;
department?: string;
}

```

Example:

```

let emp: Employee = {
id: 101,
name: "Sara"
};

```

Here, `department` is optional.

### Readonly Properties

A property marked with `readonly` cannot be modified after it is initialized.

```

interface User {
readonly id: number;
name: string;
}
let user: User = {
id: 1,
name: "Ahmed"
};

```

`// user.id = 2;` ❌ `Error user.name = "Ali"; //` ✔ `Allowed` Readonly properties help protect important data from accidental changes.

### Methods in Interfaces

Interfaces can also describe methods.

```

interface Calculator {
add(a: number, b: number): number;
}

```

Implementation:

```

let calculator: Calculator = {
add(a, b) {
return a + b;
}
};
console.log(calculator.add(5, 3));

```

**Output** `8`

### Extending Interfaces

One interface can inherit properties from another using the `extends` keyword.

```

interface Person {
name: string;
}
interface Teacher extends Person {
subject: string;
}
let teacher: Teacher = {
name: "John",
subject: "Mathematics"
};

```

This promotes code reuse and avoids duplication.

## Introduction to Type Aliases

### What is a Type Alias?

A **Type Alias** creates a new name for an existing type. Unlike interfaces, type aliases can represent objects, primitive types, unions, tuples, intersections, and function types.

### Syntax

```

type Student = {
name: string;
age: number;
};

```

Usage:

```

let student: Student = {
name: "Sara",
age: 21
};

```

This works similarly to an interface for object types.

### Type Aliases for Primitive Types

Type aliases are not limited to objects.

```

type ID = number;
let studentId: ID = 101;

```

This makes code easier to understand by giving meaningful names to types.

### Type Aliases for Tuples

```

type Coordinate = [number, number];
let point: Coordinate = [10, 20];

```

### Type Aliases for Functions

```

type Multiply = (a: number, b: number) => number;
let multiply: Multiply = (x, y) => x * y;
console.log(multiply(4, 5));

```

**Output** `20`

## Advanced Type Aliases

### Union Types

A union allows a variable to hold more than one type.

```

type ID = number | string;
let userId: ID;
userId = 1001;
userId = "EMP1001";

```

This is useful when data can have multiple valid formats.

### Intersection Types

Intersection types combine multiple types into one.

```

type Person = {
name: string;
};
type Employee = {
salary: number;
};
type Staff = Person & Employee;
let staff: Staff = {
name: "Ahmed",
salary: 50000
};

```

The object must satisfy both types.

### Literal Types

Type aliases can restrict values to specific literals.

```

type Status = "Pending" | "Approved" | "Rejected";
let application: Status = "Approved";

```

Any other value produces a compiler error.

### Reusable Custom Types

```

type Product = {
id: number;
name: string;
price: number;
};
let phone: Product = {
id: 1,
name: "Smartphone",
price: 30000
};

```

Creating reusable custom types reduces code duplication.

## Interfaces vs Type Aliases

Although Interfaces and Type Aliases often appear similar, they have important differences.

### Comparison Table

| Feature | Interface | Type Alias |
|---|---|---|
| Object Types | ✔ Yes | ✔ Yes |
| Primitive Types | ✘ No | ✔ Yes |
| Union Types | ✘ No | ✔ Yes |
| Tuple Types | ✘ No | ✔ Yes |
| Intersection Types | Limited | ✔ Yes |
| Extending | Uses extends | Uses & |
| Declaration Merging | ✔ Supported | ✘ Not Supported |

### Declaration Merging

Interfaces support declaration merging.

```

interface Person {
name: string;
}
interface Person {
age: number;
}
let person: Person = {
name: "Ali",
age: 20
};

```

Both interface declarations are automatically combined. Type aliases cannot do this.

### When Should We Use Interfaces?

Interfaces are recommended when:

- Defining object structures.

- Creating contracts for classes.

- Designing APIs.

- Building large-scale applications.

- Extending existing object types.

### When Should We Use Type Aliases?

Type aliases are recommended when:

- Creating union types.

- Creating intersection types.

- Defining tuples.

- Defining function types.

- Naming primitive types.

- Working with literal types.

### Best Practices

### 1. Use Interfaces for Object Structures

```

interface Employee {
id: number;
name: string;
}

```

### 2. Use Type Aliases for Complex Types

```

type Result = string | number;

```

### 3. Use Meaningful Names

Good examples:

```

type UserID = number;
interface Product {
name: string;
price: number;
}

```

Meaningful names improve readability.

### 4. Avoid Duplicate Definitions

Instead of rewriting object structures repeatedly, define them once using an interface or type alias and reuse them throughout the application.

### Quick Summary

| Concept | Purpose | Example |
|---|---|---|
| Interface | Defines object structure | interface Student {} |
| Type Alias | Creates custom types | type Student = {} |
| Optional Property | Property may be omitted | name?: string |
| Readonly Property | Cannot be modified | readonly id |
| Extends | Inherits another interface | extends Person |
| Union Type | Multiple possible types | string \\| number |
| Intersection Type | Combines multiple types | Person & Employee |
| Literal Type | Restricts allowed values | "Yes" \\| "No" |

### Conclusion

Interfaces and Type Aliases are two of the most powerful features in TypeScript for defining and organizing data structures. Interfaces are ideal for describing object shapes, supporting inheritance, and enabling declaration merging, making them an excellent choice for large applications. Type Aliases, on the other hand, offer greater flexibility by supporting primitive types, unions, tuples, intersections, and function types. By understanding the strengths of both and using each where it fits best, we can write cleaner, more maintainable, and scalable TypeScript code that is easier to understand and less prone to errors.');

-- Lecture 6: Classes & Access Modifiers
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Classes & Access Modifiers', 6, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Classes & Access Modifiers

TypeScript enhances JavaScript by adding powerful object-oriented programming (OOP) features. One of its most important features is **Classes**, which allow us to create reusable blueprints for objects. Along with classes, TypeScript introduces **Access Modifiers** that control the visibility and accessibility of properties and methods, making our code more secure, organized, and maintainable. Think of a class as the blueprint of a house. The blueprint defines the structure, but the actual house is built from it. Similarly, a class defines the properties and behaviors of an object, while objects are the real instances created from that class. Access modifiers act like doors and locks—some parts of the house are open to everyone, while others are restricted to authorized people only. In these lecture notes, we will explore classes, constructors, inheritance, and the three primary access modifiers in TypeScript.

## Introduction to Classes

### What is a Class?

A **class** is a blueprint for creating objects. It groups together related properties (data) and methods (functions) into a single unit. **Syntax:**

```

class Student {
name: string;
age: number;
introduce(): void {
console.log(`My name is ${this.name}`);
}
}

```

Here:

- `name` and `age` are properties.

- `introduce()` is a method.

- `this` refers to the current object.

### Creating an Object

Objects are created using the `new` keyword.

```

class Student {
name: string = "Ali";
age: number = 20;
}
const student1 = new Student();
console.log(student1.name);
console.log(student1.age);

```

**Output:**

```

Ali
20

```

Each object has its own copy of the class properties.

### Why Use Classes?

Classes provide several advantages:

- Organize code logically.

- Promote code reusability.

- Support object-oriented programming.

- Simplify maintenance.

- Improve readability.

Instead of writing similar code repeatedly, we define one class and create multiple objects from it.

## Constructors and Class Members

### What is a Constructor?

A **constructor** is a special method that automatically runs when an object is created.

```

class Student {
name: string;
age: number;
constructor(name: string, age: number) {
this.name = name;
this.age = age;
}
}

```

Creating objects:

```

const student1 = new Student("Ali", 20);
const student2 = new Student("Sara", 22);
console.log(student1.name);
console.log(student2.name);

```

**Output:**

```

Ali
Sara

```

The constructor initializes object properties during creation.

### Methods Inside Classes

Methods define the behavior of objects.

```

class Car {
brand: string;
constructor(brand: string) {
this.brand = brand;
}
start(): void {
console.log(`${this.brand} is starting.`);
}
}
const car = new Car("Toyota");
car.start();

```

**Output:** `Toyota is starting.`

### Readonly Properties

Sometimes a property should not change after initialization.

```

class Employee {
readonly id: number;
constructor(id: number) {
this.id = id;
}
}

```

Attempting to modify `id` later will produce a TypeScript error.

## Access Modifiers

Access modifiers determine **who can access class members**. TypeScript provides three main access modifiers:

- `public`

- `private`

- `protected`

### Public Access Modifier

The `public` modifier is the default. Members can be accessed from anywhere.

```

class Student {
public name: string;
constructor(name: string) {
this.name = name;
}
}
const student = new Student("Ali");
console.log(student.name);

```

Since `name` is public, it is accessible outside the class.

### Private Access Modifier

Private members are only accessible inside the class.

```

class BankAccount {
private balance: number = 1000;
showBalance(): void {
console.log(this.balance);
}
}
const account = new BankAccount();
account.showBalance();

```

Attempting this:

```

console.log(account.balance);

```

Produces a TypeScript error because `balance` is private. Private properties help protect sensitive information.

### Protected Access Modifier

Protected members are accessible inside the class and its subclasses but **not outside**.

```

class Animal {
protected name: string;
constructor(name: string) {
this.name = name;
}
}

```

Subclass:

```

class Dog extends Animal {
bark(): void {
console.log(`${this.name} is barking.`);
}
}
const dog = new Dog("Buddy");
dog.bark();

```

However:

```

console.log(dog.name);

```

Produces an error because `name` is protected.

## Inheritance and Encapsulation

### Inheritance

Inheritance allows one class to reuse the properties and methods of another class.

```

class Person {
constructor(public name: string) {}
introduce(): void {
console.log(`I am ${this.name}`);
}
}
class Student extends Person {
study(): void {
console.log(`${this.name} is studying.`);
}
}
const student = new Student("Ali");
student.introduce();
student.study();

```

The `Student` class inherits everything from `Person`.

### Method Overriding

A subclass can provide its own implementation of a parent method.

```

speak(): void {
console.log("Animal speaks");
}
}
class Dog extends Animal {
speak(): void {
console.log("Dog barks");
}
}
const dog = new Dog();
dog.speak();

```

**Output:** `Dog barks`

### Encapsulation

Encapsulation means hiding internal implementation details and exposing only what is necessary. Example:

```

class BankAccount {
private balance = 5000;
deposit(amount: number): void {
this.balance += amount;
}
getBalance(): number {
return this.balance;
}
}

```

Users cannot directly modify the balance but can interact through methods.

## Advanced Concepts and Best Practices

### Parameter Properties

TypeScript provides a shortcut for declaring and initializing properties. Instead of writing:

```

class Student {
name: string;
age: number;
constructor(name: string, age: number) {
this.name = name;
this.age = age;
}
}

```

We can write:

```

class Student {
constructor(
public name: string,
public age: number
) {}
}

```

This is cleaner and commonly used in TypeScript applications.

### Getters and Setters

Getters retrieve values, while setters update them safely.

```

class Employee {
private salary = 50000;
get Salary(): number {
return this.salary;
}
set Salary(amount: number) {
if (amount > 0) {
this.salary = amount;
}
}
}

```

Usage:

```

const emp = new Employee();
emp.Salary = 60000;
console.log(emp.Salary);

```

### Static Members

Static members belong to the class itself rather than its objects.

```

class MathHelper {
static PI = 3.14159;
static square(x: number): number {
return x * x;
}
}
console.log(MathHelper.PI);
console.log(MathHelper.square(5));

```

Objects are not required to access static members.

### Advantages of Access Modifiers

- Improve code security.

- Prevent accidental modifications.

- Support encapsulation.

- Make large applications easier to maintain.

- Clearly define class responsibilities.

- Improve code readability.

### Common Mistakes

### 1. Accessing Private Members Outside the Class

Incorrect:

```

class Student {
private marks = 90;
}
const student = new Student();
console.log(student.marks);

```

This results in a compilation error. Correct:

```

class Student {
private marks = 90;
getMarks() {
return this.marks;
}
}

```

**2. Forgetting to Use** `this` Incorrect:

```

class Student {
name = "Ali";
show() {
console.log(name);
}
}

```

Correct:

```

class Student {
name = "Ali";
show() {
console.log(this.name);
}
}

```

### 3. Choosing the Wrong Access Modifier

Using `public` for sensitive data can expose important information. For confidential properties such as passwords, account balances, or API keys, use `private` and provide controlled access through methods when necessary.

### Real-World Applications

Classes and access modifiers are widely used in professional TypeScript development, including:

- User authentication systems

- Banking and financial software

- Student management systems

- Inventory and product management

- Healthcare applications

- E-commerce platforms

- Game development

- Enterprise business applications

For example, in an online banking application, the account balance should be private, while methods such as `deposit()` and `withdraw()` provide controlled access. Similarly, in a student management system, public methods can display student information while private fields securely store sensitive data.

### Conclusion

Classes and access modifiers are essential building blocks of object-oriented programming in TypeScript. Classes help us organize related data and behavior into reusable blueprints, while constructors simplify object initialization. Access modifiers such as **public**, **private**, and **protected** control visibility, improve encapsulation, and protect sensitive information. Features like inheritance, method overriding, parameter properties, getters, setters, and static members make TypeScript classes even more powerful. By mastering these concepts, we can build secure, scalable, and maintainable applications that follow modern software development best practices.');

-- Lecture 7: Enums in TypeScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Enums in TypeScript', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Enums in TypeScript

Enums (short for **enumerations**) are one of the unique features provided by TypeScript. They allow us to define a collection of named constants, making our code more readable, maintainable, and less prone to errors. Instead of remembering arbitrary numbers or strings, we can use meaningful names that clearly represent specific values. Think of an enum as a menu in a restaurant. Rather than asking customers to remember item numbers like 1, 2, or 3, the menu displays descriptive names such as Burger , Pizza , and Pasta . Similarly, enums replace confusing values with understandable names.

## Introduction to Enums

An enum is a special TypeScript data type that groups related constants together. These constants often represent fixed values that do not change throughout the program. **Why Do We Need Enums?** Without enums, developers often use numbers or strings directly in their code. Example without enums:

```

let userRole = 1;
if (userRole === 1) {
console.log("Administrator");
}

```

Although this works, another programmer may not know what `1` represents. Using an enum makes the code much clearer:

```

enum UserRole {
Admin,
Editor,
Viewer
}
let role = UserRole.Admin;
if (role === UserRole.Admin) {
console.log("Administrator");
}

```

Now anyone reading the code immediately understands its meaning. **Advantages of Enums**

- Improves code readability.

- Prevents invalid values.

- Makes code easier to maintain.

- Reduces typing mistakes.

- Organizes related constants in one place.

## Numeric Enums

By default, TypeScript creates **numeric enums**. The first member starts at `0`, and each following member increases by `1`. **Syntax**

```

enum Direction {
North,
East,
South,
West
}

```

The values become:

```

North = 0
East = 1
South = 2
West = 3

```

**Example**

```

enum Direction {
North,
East,
South,
West
}
let move = Direction.East;
console.log(move);

```

**Output** `1` **Assigning Custom Values** We can specify our own numeric values.

```

enum StatusCode {
Success = 200,
NotFound = 404,
ServerError = 500
}
console.log(StatusCode.Success);

```

**Output** `200` **Auto Increment** Once the first value is assigned, the remaining values automatically increase.

```

enum Month {
January = 1,
February,
March,
April
}

```

Result:

```

January = 1
February = 2
March = 3
April = 4

```

## String Enums

Instead of numbers, enums can also store strings. **Syntax**

```

enum Color {
Red = "RED",
Green = "GREEN",
Blue = "BLUE"
}

```

**Example**

```

enum Color {
Red = "RED",
Green = "GREEN",
Blue = "BLUE"
}
let favorite = Color.Blue;
console.log(favorite);

```

**Output** `BLUE` **Why Use String Enums?** String enums provide more meaningful values, especially when working with:

- APIs

- Databases

- JSON data

- Configuration files

Example:

```

enum PaymentStatus {
Pending = "pending",
Completed = "completed",
Failed = "failed"
}
let payment = PaymentStatus.Completed;

```

The stored value is easy to understand without looking at the enum definition.

## Advanced Enum Features

**Reverse Mapping** Numeric enums support reverse mapping. Example:

```

enum Days {
Monday,
Tuesday,
Wednesday
}
console.log(Days[0]);

```

**Output** `Monday` This feature allows us to retrieve the name from its numeric value. String enums do **not** support reverse mapping. **Computed Members** Enum values can be calculated.

```

enum Size {
Small = 10,
Medium = Small * 2,
}
console.log(Size.Large);

```

**Output** `40` **Constant Members** Constant members are evaluated during compilation.

```

enum Discount {
None = 0,
Student = 10,
Teacher = 20
}

```

These values remain fixed and improve performance. **Heterogeneous Enums** TypeScript allows mixing strings and numbers, although this is generally discouraged.

```

enum Mixed {
Yes = 1,
No = "NO"
}

```

While valid, mixed enums reduce readability and consistency.

## Practical Applications of Enums

Enums are widely used in real-world software development because many applications deal with predefined categories. **User Roles**

```

enum UserRole {
Admin,
Manager,
Employee,
Guest
}
let currentUser = UserRole.Manager;

```

**Traffic Signals**

```

enum TrafficLight {
Red,
Yellow,
Green
}
let signal = TrafficLight.Green;

```

**Order Status**

```

enum OrderStatus {
Pending,
Processing,
Shipped,
Delivered,
Cancelled
}

```

**Game Levels**

```

enum GameLevel {
Easy,
Medium,
Hard
}

```

**HTTP Response Codes**

```

enum HttpStatus {
OK = 200,
BadRequest = 400,
Unauthorized = 401,
NotFound = 404,
ServerError = 500
}

```

These examples demonstrate how enums simplify code by replacing "magic numbers" and hard-coded strings with meaningful names.

## Enums vs Union Types

TypeScript also provides **union types**, which can sometimes replace enums. Using an enum:

```

enum Theme {
Light,
Dark
}
let currentTheme: Theme = Theme.Light;

```

Using a union type:

```

type Theme = "light" | "dark";
let currentTheme: Theme = "light";

```

**Comparison**

| Feature | Enum | Union Type |
|---|---|---|
| Named constants | ✅ | ❌ |
| String values | ✅ | ✅ |
| Numeric values | ✅ | ❌ |
| Runtime object | ✅ | ❌ |
| Simpler for fixed strings | ❌ | ✅ |

Modern TypeScript projects often prefer union types for simple string values because they produce smaller JavaScript output. However, enums remain an excellent choice when named constants, numeric values, or runtime access are required.

## Best Practices

To write clean and maintainable TypeScript code, follow these guidelines:

- Use descriptive enum names.

- Prefer string enums when exchanging data with APIs.

- Use numeric enums when sequential numeric values are needed.

- Avoid heterogeneous enums.

- Do not use enums for values that frequently change.

- Group related constants inside a single enum.

- Use PascalCase for enum names and members.

Example:

```

enum PaymentMethod {
Cash,
CreditCard,
DebitCard,
BankTransfer
}

```

This naming convention makes code professional and consistent.

## Common Mistakes

**1. Using Magic Numbers**

```

let level = 2;

```

Better:

```

enum Level {
Beginner,
Intermediate,
Expert
}
let level = Level.Expert;

```

**2. Mixing Data Types**

```

enum Result {
Pass = 1,
Fail = "Fail"
}

```

Avoid this unless absolutely necessary. **3. Choosing Enums for Every Situation** If you only need a few string literals, a union type is often simpler.

```

type Size = "Small" | "Medium" | "Large";

```

Choosing the right tool keeps your code lightweight and easier to understand.

### Conclusion

Enums are a powerful TypeScript feature that allows us to represent a fixed set of related constants with meaningful names. They improve code readability, reduce errors, and make applications easier to maintain. TypeScript supports both numeric and string enums, each serving when appropriate—we can write cleaner, safer, and more maintainable TypeScript applications. Mastering enums is an important step toward becoming a confident and efficient TypeScript developer.');

-- Lecture 8: Union & Intersection Types in TypeScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Union & Intersection Types in TypeScript', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Union & Intersection Types in TypeScript

TypeScript extends JavaScript by introducing a powerful type system that helps us write safer, cleaner, and more maintainable code. Among its most useful features are **Union Types** and **Intersection Types**. These concepts allow us to create flexible and reusable type definitions while reducing bugs during development. Imagine building a bridge. Sometimes we need a road that can support either cars or bicycles. Other times, we need a structure that satisfies every engineering requirement simultaneously. Union Types work like the first scenario—they allow multiple possibilities. Intersection Types resemble the second—they combine multiple requirements into one complete structure. In these lecture notes, we will explore how Union and Intersection Types work, why they are important, and how they improve software development.

## Understanding Union Types

### What is a Union Type?

A **Union Type** allows a variable, parameter, or property to hold **one of several possible types**. It is represented using the vertical bar (`|`) symbol. **Syntax:**

```

let value: string | number;

```

In this example, the variable `value` can contain either a string or a number.

```

value = "Hello";
value = 100;

```

Both assignments are valid because they match one of the allowed types.

### Why Do We Need Union Types?

In real-world applications, data often comes in different forms. For example:

- A user ID may be a number in one system.

- The same ID may be a string in another system.

- An API response might return different data types depending on the request.

Without Union Types, we would need separate variables or complicated logic. Union Types provide a cleaner solution. Example:

```

function printId(id: number | string) {
console.log("ID:", id);
}
printId(101);
printId("A102");

```

Here, the function accepts either a number or a string.

### Type Narrowing

Since TypeScript does not automatically know which type is currently stored, we often narrow the type before using it.

```

function printLength(value: string | string[]) {
if (typeof value === "string") {
console.log(value.length);
} else {
console.log(value.length);
}
}

```

The `typeof` operator helps TypeScript identify whether `value` is a string or an array.

## Common Uses of Union Types

### Optional Values

Union Types commonly represent nullable data.

```

let username: string | null;
username = "John";
username = null;

```

This indicates that the variable may either contain a string or no value.

### Multiple Parameter Types

Functions become more flexible.

```

function multiply(value: number | string) {
if (typeof value === "number") {
return value * 2;
}
return Number(value) * 2;
}

```

Output:

```

multiply(10) → 20
multiply("15") → 30

```

### Union of Custom Types

Suppose we have two interfaces.

```

interface Dog {
bark(): void;
}
interface Cat {
meow(): void;
}

```

Now we can create a Union Type.

```

function makeSound(animal: Dog | Cat) {
if ("bark" in animal) {
animal.bark();
} else {
animal.meow();
}
}

```

The `in` operator helps determine which object type is currently being used.

## Understanding Intersection Types

### What is an Intersection Type?

An **Intersection Type** combines **multiple types into a single type**. It is represented using the ampersand (`&`) symbol.

```

type Employee = {
id: number;
};
type Person = {
name: string;
};
type Staff = Employee & Person;

```

Now `Staff` contains properties from both types.

```

const worker: Staff = {
id: 1,
name: "Alice"
};

```

The object must satisfy both type definitions.

### Why Use Intersection Types?

As applications grow, many objects share common properties. Instead of repeating code, we combine existing types. This improves:

- Code reusability

- Maintainability

- Scalability

- Readability

Think of it as combining LEGO blocks to build larger structures rather than creating every piece from scratch.

### Combining Multiple Interfaces

```

interface Student {
name: string;
}
interface Athlete {
sport: string;
}
type StudentAthlete = Student & Athlete;

```

Usage:

```

const player: StudentAthlete = {
name: "Ali",
sport: "Football"
};

```

The object contains all required properties.

## Union Types vs Intersection Types

Although both combine types, they serve different purposes. | Feature | Union (`|`) | Intersection (`&`) ||---------|--------------|--------------------|| Meaning | One of many types | Combination of all types || Object Requirement | Match one type | Match every type || Flexibility | High | More restrictive || Symbol | `|` | `&` | **Example of Union**

```

type Result = string | number;
let data: Result;
data = "Passed";
data = 95;

```

Only one type is needed. **Example of Intersection**

```

type A = {
name: string;
};
type B = {
age: number;
};
type Person = A & B;
const user: Person = {
name: "Sara",
age: 20
};

```

Both properties are mandatory.

### Choosing the Right One

Use **Union Types** when:

- Data may have multiple possible forms.

- Function parameters accept different input types.

- API responses vary.

Use **Intersection Types** when:

- Combining interfaces.

- Creating complex object models.

- Reusing existing type definitions.

## Advanced Concepts and Best Practices

### Discriminated Unions

One powerful TypeScript feature is the **Discriminated Union**, where each type contains a common property used to identify it.

```

interface Circle {
kind: "circle";
radius: number;
}
interface Square {
kind: "square";
side: number;
}
type Shape = Circle | Square;

```

Now we can safely determine the type.

```

function area(shape: Shape) {
if (shape.kind === "circle") {
return Math.PI * shape.radius ** 2;
}
return shape.side ** 2;
}

```

This technique is widely used in React applications, APIs, and state management.

### Intersection with Multiple Types

Intersection Types are not limited to two types.

```

type A = {
a: string;
};
type B = {
b: number;
};
type C = {
c: boolean;
};
type ABC = A & B & C;

```

Usage:

```

const obj: ABC = {
a: "Hello",
b: 10,
c: true
};

```

### Advantages of Union Types

- Increase code flexibility.

- Reduce duplicate functions.

- Handle multiple input formats.

- Improve developer productivity.

- Make APIs easier to use.

### Advantages of Intersection Types

- Combine multiple interfaces efficiently.

- Reduce repeated property definitions.

- Create scalable object models.

- Improve maintainability.

### Common Mistakes

### 1. Accessing Properties Without Narrowing

Incorrect:

```

function show(data: string | number) {
console.log(data.length);
}

```

This produces an error because numbers do not have a `length` property. Correct:

```

if (typeof data === "string") {
console.log(data.length);
}

```

### 2. Forgetting Required Properties in Intersections

Incorrect:

```

type Person = {
name: string;
};
type Employee = {
id: number;
};
type Staff = Person & Employee;
const user: Staff = {
name: "Ahmed"
};

```

The `id` property is missing. Correct:

```

const user: Staff = {
name: "Ahmed",
id: 10
};

```

### Real-World Applications

Union and Intersection Types are used extensively in modern TypeScript projects, including:

- React component props

- REST API request and response models

- Authentication systems

- E-commerce product management

- Banking applications

- User role management

- Form validation

- State management libraries

For example, a payment system may accept either a credit card, a digital wallet, or bank transfer using a Union Type, while an authenticated administrator could be modeled as the intersection of `User` and `AdminPermissions`.

### Conclusion

Union and Intersection Types are fundamental features that make TypeScript both expressive and reliable. **Union Types** allow variables and functions to work with one of several possible types, making applications flexible enough to handle real-world data variations. **Intersection Types**, on the other hand, merge multiple type definitions into a single, comprehensive type, encouraging code reuse and strong object modeling. By understanding when to use each approach, applying type narrowing effectively, and following best practices such as discriminated unions, we can write applications that are easier to maintain, less prone to runtime errors, and better prepared for growth. Mastering these concepts is an essential step toward becoming a proficient TypeScript developer.');

-- Lecture 9: Type Narrowing & Type Guards
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Type Narrowing & Type Guards', 9, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Type Narrowing & Type Guards

TypeScript is designed to catch errors before our code runs, making applications more reliable and easier to maintain. One of the most important concepts that helps achieve this is **Type Narrowing**. Type narrowing allows TypeScript to determine a more specific type from a broader one, enabling us to safely access properties and methods without causing runtime errors. This process is made possible through **Type Guards**, which are conditions or checks that help TypeScript identify the exact type of a variable. Imagine a mystery box containing either a book, a laptop, or a phone. Before using the item, we first open the box and identify what is inside. Similarly, TypeScript first identifies the type of a variable before allowing us to use type-specific features. In these lecture notes, we will explore type narrowing, built-in and custom type guards, and their practical applications in real-world development.

## Understanding Type Narrowing

### What is Type Narrowing?

**Type Narrowing** is the process of reducing a variable\'s possible types to a more specific type using conditional checks. Consider a variable that can hold either a string or a number.

```

let value: string | number;

```

Since `value` may contain either type, TypeScript prevents us from using methods that belong only to one type until we determine which type it currently holds.

### Why Do We Need Type Narrowing?

Suppose we have the following function:

```

function printValue(value: string | number) {
console.log(value);
}

```

This function works because `console.log()` accepts both strings and numbers. However, the following code causes an error:

```

function showLength(value: string | number) {
console.log(value.length);
}

```

The error occurs because:

- Strings have a `length` property.

- Numbers do not.

TypeScript requires us to narrow the type before accessing properties that are not common to all possible types.

### How Type Narrowing Works

```

function showLength(value: string | number) {
if (typeof value === "string") {
console.log(value.length);
}
}

```

Inside the `if` block, TypeScript knows that `value` is a string, making the `length` property safe to access.

## Built-in Type Guards

TypeScript provides several built-in type guards that automatically narrow types.

### The Type Guard

`typeof` The `typeof` operator is commonly used with primitive data types.

```

function print(value: string | number) {
if (typeof value === "string") {
console.log(value.toUpperCase());
} else {
console.log(value.toFixed(2));
}
}

```

If `value` is a string, we use `toUpperCase()`. Otherwise, it must be a number, allowing us to use `toFixed()`.

### The Type Guard

`instanceof` The `instanceof` operator checks whether an object is created from a specific class.

```

class Dog {
bark() {
console.log("Woof!");
}
}
class Cat {
meow() {
console.log("Meow!");
}
}
function makeSound(animal: Dog | Cat) {
if (animal instanceof Dog) {
animal.bark();
} else {
animal.meow();
}
}

```

This technique is useful when working with classes and object-oriented programming.

### The Type Guard

`in` The `in` operator checks whether an object contains a particular property.

```

interface Fish {
swim(): void;
}
interface Bird {
fly(): void;
}
function move(animal: Fish | Bird) {
if ("swim" in animal) {
animal.swim();
} else {
animal.fly();
}
}

```

The presence of the `swim` property tells TypeScript that the object is a `Fish`.

## Custom Type Guards

### What is a Custom Type Guard?

A **custom type guard** is a function that tells TypeScript the exact type of a value using the `is` keyword. **Syntax:**

```

function isString(value: unknown): value is string {
return typeof value === "string";
}

```

The return type `value is string` informs TypeScript that the function checks whether the value is a string.

### Using a Custom Type Guard

```

function isNumber(value: unknown): value is number {
return typeof value === "number";
}
function process(value: string | number) {
if (isNumber(value)) {
console.log(value.toFixed(2));
} else {
console.log(value.toUpperCase());
}
}

```

Custom type guards make code cleaner and easier to reuse.

### Custom Type Guard for Objects

```

interface Admin {
permissions: string[];
}
interface User {
username: string;
}
function isAdmin(person: Admin | User): person is Admin {
return "permissions" in person;
}

```

Usage:

```

function display(person: Admin | User) {
if (isAdmin(person)) {
console.log(person.permissions);
} else {
console.log(person.username);
}
}

```

## Discriminated Unions and Type Guards

### What are Discriminated Unions?

A discriminated union is a collection of object types that share a common property, often called a **discriminant**.

```

interface Circle {
kind: "circle";
radius: number;
}
interface Rectangle {
kind: "rectangle";
width: number;
height: number;
}
type Shape = Circle | Rectangle;

```

The `kind` property identifies the object type.

### Using Type Narrowing with Discriminated Unions

```

function area(shape: Shape): number {
if (shape.kind === "circle") {
return Math.PI * shape.radius ** 2;
}
return shape.width * shape.height;
}

```

TypeScript automatically narrows the type based on the value of the `kind` property.

### Switch Statement Narrowing

Switch statements also perform type narrowing.

```

function area(shape: Shape): number {
switch (shape.kind) {
case "circle":
return Math.PI * shape.radius ** 2;
case "rectangle":
return shape.width * shape.height;
}
}

```

This approach improves readability when handling multiple object types.

## Best Practices and Real-World Applications

### Advantages of Type Narrowing

Type narrowing offers many benefits:

- Prevents runtime errors.

- Improves code readability.

- Increases type safety.

- Makes IntelliSense more accurate.

- Simplifies debugging.

- Encourages better software design.

### Common Mistakes

### 1. Accessing Properties Without Narrowing

Incorrect:

```

function print(value: string | number) {
console.log(value.length);
}

```

This causes an error because numbers do not have a `length` property. Correct:

```

function print(value: string | number) {
if (typeof value === "string") {
console.log(value.length);
}
}

```

**2. Using** `any` **Instead of Type Guards** Incorrect:

```

function process(value: any) {
console.log(value.length);
}

```

Using `any` disables TypeScript\'s type checking. Better approach:

```

function process(value: string | string[]) {
if (typeof value === "string") {
console.log(value.length);
} else {
console.log(value.length);
}
}

```

### 3. Writing Complex Conditions Repeatedly

Instead of repeating the same checks in multiple places, create reusable custom type guards. Example:

```

function isString(value: unknown): value is string {
return typeof value === "string";
}

```

This keeps the code clean and avoids duplication.

### Real-World Applications

Type narrowing and type guards are widely used in professional TypeScript development, including:

- React component props handling.

- API request and response validation.

- User authentication systems.

- Form validation.

- State management libraries.

- Database record processing.

- E-commerce product filtering.

- Chat and messaging applications.

For example, an API may return either a successful response or an error response. By using discriminated unions and type guards, developers can safely determine which response was received and access only the appropriate properties.

```

interface SuccessResponse {
status: "success";
data: string;
}
interface ErrorResponse {
status: "error";
message: string;
}
type ApiResponse = SuccessResponse | ErrorResponse;
function handleResponse(response: ApiResponse) {
if (response.status === "success") {
console.log(response.data);
} else {
console.log(response.message);
}
}

```

This approach ensures that the correct properties are accessed based on the response type.

### Best Practices

- Prefer specific types instead of using `any`.

- Use `typeof` for primitive types.

- Use `instanceof` for class instances.

- Use `in` for checking object properties.

- Create reusable custom type guards for repeated logic.

- Use discriminated unions for complex object structures.

- Keep type guard functions simple and focused.

### Conclusion

Type Narrowing and Type Guards are essential features that make TypeScript powerful, safe, and developer-friendly. Type narrowing enables the compiler to determine the exact type of a variable at runtime, while type guards provide the logic needed to perform that narrowing. Built-in guards such as `typeof`, `instanceof`, and `in`, along with custom type guards and discriminated unions, allow us to write flexible applications without sacrificing type safety. By following best practices and using these techniques effectively, we can create cleaner, more maintainable, and error-free TypeScript applications that are well-suited for modern software development.');

-- Lecture 10: Generics in TypeScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Generics in TypeScript', 10, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Generics in TypeScript

TypeScript is designed to make JavaScript applications safer, more maintainable, and easier to scale. One of its most powerful features is **Generics**, which allow us to create reusable components that work with different data types while maintaining type safety. Instead of writing separate functions or classes for each data type, we can write one generic version that adapts to many types. Think of generics like a reusable mold. Just as one cake mold can produce cakes with different flavors, one generic function can work with strings, numbers, objects, or any other type without sacrificing correctness. In these lecture notes, we will explore what generics are, why they are useful, and how to use them effectively in TypeScript.

## Understanding Generics

### What Are Generics?

Generics are a feature that allows us to write code that can work with **multiple data types** while preserving type information. They use **type parameters**, which act as placeholders for actual types. **Syntax:**

```

function identity<T>(value: T): T {
return value;
}

```

Here:

- `T` is a generic type parameter.

- The function accepts a value of type `T`.

- It returns the same type `T`.

### Using a Generic Function

```

function identity<T>(value: T): T {
return value;
}
console.log(identity<string>("Hello"));
console.log(identity<number>(100));
console.log(identity<boolean>(true));

```

**Output:**

```

Hello
100
true

```

The same function works for different types without rewriting the code.

### Why Do We Need Generics?

Without generics, we often lose type information. Example using `any`:

```

function identity(value: any): any {
return value;
}

```

Although this works, TypeScript cannot verify the returned type, making the code less safe. Using generics:

```

function identity<T>(value: T): T {
return value;
}

```

Now TypeScript remembers the exact type being used.

## Generic Functions

### Type Inference

Most of the time, TypeScript automatically determines the generic type.

```

function identity<T>(value: T): T {
return value;
}
const message = identity("Welcome");

```

TypeScript automatically infers that `T` is `string`. There is no need to explicitly write:

```

identity<string>("Welcome");

```

### Generic Function with Multiple Parameters

```

function combine<T, U>(first: T, second: U): [T, U] {
return [first, second];
}
const result = combine("Age", 25);

```

Output: `["Age", 25]` Here:

- `T` becomes `string`.

- `U` becomes `number`.

### Generic Arrays

Generics work naturally with arrays.

```

function getFirstElement<T>(items: T[]): T {
return items[0];
}
const number = getFirstElement([10, 20, 30]);
const word = getFirstElement(["Apple", "Banana"]);

```

The return type automatically matches the array element type.

## Generic Interfaces and Classes

### Generic Interfaces

Interfaces can also use generic parameters.

```

interface Box<T> {
value: T;
}

```

Usage:

```

const numberBox: Box<number> = {
value: 100
};
const stringBox: Box<string> = {
value: "TypeScript"

```

The same interface works for different data types.

### Generic Classes

Classes can also be generic.

```

class Storage<T> {
private data: T[] = [];
add(item: T): void {
this.data.push(item);
}
getItems(): T[] {
return this.data;
}
}

```

Usage:

```

const numberStorage = new Storage<number>();
numberStorage.add(10);
numberStorage.add(20);
console.log(numberStorage.getItems());

```

Output: `[10, 20]` We can also create a storage object for strings.

```

const stringStorage = new Storage<string>();
stringStorage.add("Apple");
stringStorage.add("Orange");

```

### Generic Type Aliases

Type aliases can also use generics.

```

type Pair<T> = {
first: T;
second: T;
};

```

Example:

```

const coordinates: Pair<number> = {
first: 15,
second: 30
};

```

## Generic Constraints

### Why Do We Need Constraints?

Sometimes we want a generic type to have specific properties. Consider this function:

```

function printLength<T>(value: T) {
console.log(value.length);
}

```

This causes an error because not every type has a `length` property.

### Using the Keyword

`extends` We can restrict the generic type.

```

function printLength<T extends { length: number }>(value: T): void {
console.log(value.length);
}

```

Now it works for:

```

printLength("Hello");
printLength([1, 2, 3]);

```

But not for:

```

printLength(100);

```

Because numbers do not have a `length` property.

### Constraining with Interfaces

```

interface HasId {
id: number;
}
function printId<T extends HasId>(item: T): void {
console.log(item.id);
}

```

Usage:

```

printId({
id: 1,
name: "Ali"
});

```

This ensures every object passed has an `id` property.

## Advanced Generic Concepts and Best Practices

### Generic Default Types

We can assign default generic types.

```

interface Response<T = string> {
data: T;
}

```

Usage:

```

const result: Response = {
data: "Success"
};

```

If no type is provided, TypeScript uses `string`.

### Using Multiple Generic Types

Generics can accept several type parameters.

```

class KeyValue<K, V> {
constructor(
public key: K,
public value: V
) {}
}
const pair = new KeyValue<string, number>("Age", 25);

```

Here:

- `K` is `string`

- `V` is `number`

### Generic Utility Example

```

function wrap<T>(value: T): T[] {
return [value];
}
console.log(wrap(10));
console.log(wrap("Hello"));

```

Output:

```

[10]
["Hello"]

```

The function wraps any value into an array while preserving its type.

### Advantages of Generics

- Promote code reusability.

- Improve type safety.

- Reduce duplicate code.

- Preserve type information.

- Work seamlessly with functions, classes, interfaces, and type aliases.

- Improve code readability and maintainability.

- Catch type-related errors during development.

### Common Mistakes

**1. Using** `any` **Instead of Generics** Incorrect:

```

function identity(value: any): any {
return value;
}

```

This removes type safety. Correct:

```

function identity<T>(value: T): T {
return value;
}

```

### 2. Forgetting Constraints

```

function printLength<T>(item: T) {
console.log(item.length);
}

```

TypeScript reports an error because `length` is not guaranteed. Correct:

```

function printLength<T extends { length: number }>(item: T) {
console.log(item.length);
}

```

### 3. Overusing Generics

Not every function needs generics. Incorrect:

```

function greet<T>(name: T): T {
return name;
}

```

Better:

```

function greet(name: string): string {
return name;
}

```

Use generics only when the function truly needs to work with multiple types.

### Real-World Applications of Generics

Generics are widely used in professional TypeScript development, including:

- React components and hooks

- API request and response handling

- Collections such as arrays, maps, and sets

- Database repositories

- Data structures like stacks and queues

- Utility libraries

- Form validation systems

- State management solutions

- Promise-based asynchronous programming

For example, an API function can return different data models while maintaining type safety:

```

interface ApiResponse<T> {
success: boolean;
data: T;
}
const userResponse: ApiResponse<{ name: string; age: number }> = {
success: true,
data: {
name: "Sara",
age: 22
}
};

```

The response structure remains consistent while the `data` type can vary depending on the API endpoint.

### Conclusion

Generics are one of the most valuable features in TypeScript because they allow us to write flexible, reusable, and type-safe code. By using type parameters, we can create functions, classes, interfaces, and type aliases that work with many different data types without sacrificing compile-time safety. Features such as type inference, generic constraints, default generic types, and multiple type parameters make generics suitable for everything from simple utility functions to large-scale enterprise applications. Mastering generics enables us to build cleaner, more scalable software while reducing duplication and preventing many common programming errors.');

-- Lecture 11: Modules & Namespaces
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Modules & Namespaces', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Modules & Namespaces

As software projects grow, keeping all the code in a single file becomes difficult. Large applications require proper organization so that code remains readable, reusable, and easy to maintain. TypeScript provides two important mechanisms for organizing code: **Modules** and **Namespaces**. Both help developers avoid naming conflicts and structure applications effectively, but they are used in different scenarios. Think of a large library. Books are not placed randomly on shelves; instead, they are grouped into sections such as science, history, and literature. Similarly, modules and namespaces organize related code into logical groups, making applications easier to understand and manage. In these lecture notes, we will explore modules, namespaces, their differences, advantages, and best practices for using them in TypeScript.

## Introduction to Modules

### What is a Module?

A **module** is a file that contains variables, functions, classes, interfaces, or types that can be shared with other files using **export** and **import** statements. Every TypeScript file containing at least one `import` or `export` statement is treated as a module. Example:

```

// math.ts
export function add(a: number, b: number): number {
return a + b;
}

```

Another file can use this function by importing it.

```

// app.ts
import { add } from "./math";
console.log(add(5, 3));

```

**Output:** `8` Modules allow us to divide applications into smaller, reusable files.

### Why Use Modules?

Modules provide several benefits:

- Organize code into separate files.

- Prevent naming conflicts.

- Improve code readability.

- Promote code reusability.

- Simplify testing and debugging.

- Enable team collaboration on large projects.

Instead of one huge file, each feature can have its own module.

### How Modules Work

When we export a member, it becomes available to other files.

```

export const PI = 3.14159;

```

We can import it as follows:

```

import { PI } from "./constants";
console.log(PI);

```

Only exported members are accessible outside the module.

## Exporting and Importing

### Named Exports

Named exports allow multiple members to be exported from one file.

```

export function add(a: number, b: number): number {
return a + b;
}
export function subtract(a: number, b: number): number {
return a - b;
}

```

Import them like this:

```

import { add, subtract } from "./math";
console.log(add(10, 5));
console.log(subtract(10, 5));

```

### Default Exports

A module can also export one default member.

```

export default class User {
constructor(public name: string) {}
}

```

Import:

```

import User from "./User";
const user = new User("Ali");

```

Default exports do not require curly braces during import.

### Importing Everything

Sometimes we import all exported members.

```

import * as MathUtils from "./math";
console.log(MathUtils.add(5, 2));
console.log(MathUtils.subtract(8, 3));

```

This approach groups related functions under a single object.

## Understanding Namespaces

### What is a Namespace?

A **namespace** is a way of grouping related code under a single name within the same application. Namespaces were widely used before JavaScript introduced ES Modules. **Syntax:**

```

namespace MathOperations {
export function add(a: number, b: number): number {
return a + b;
}
}

```

Using the namespace:

```

console.log(MathOperations.add(5, 7));

```

**Output:** `12`

### Why Use Namespaces?

Namespaces help:

- Group related functions.

- Avoid global naming conflicts.

- Organize code inside a single application.

- Improve readability in older TypeScript projects.

### Exporting Namespace Members

Members must be marked with `export` to be accessible outside the namespace.

```

namespace Shapes {
export class Circle {
draw() {
console.log("Drawing Circle");
}
}
}

```

Usage:

```

const circle = new Shapes.Circle();
circle.draw();

```

Without the `export` keyword, the class would remain private to the namespace.

## Modules vs Namespaces

Although both organize code, they serve different purposes.

| Feature | Modules | Namespaces |
|---|---|---|
| Scope | Separate files | Same application or file |
| Keywords | import, export | namespace |
| Modern Usage | Recommended | Legacy or special cases |
| Dependency Management | Built into JavaScript | TypeScript-specific |
| Best For | Large applications | Older projects and libraries |

### When to Use Modules

Modules are recommended when:

- Building React applications.

- Creating Node.js projects.

- Developing Angular applications.

- Working with modern JavaScript.

- Organizing code across multiple files.

Example folder structure:

```

src/
│
├── models/
├── services/
├── utils/
├── app.ts
└── index.ts

```

Each folder contains related modules.

### When to Use Namespaces

Namespaces are mainly useful for:

- Legacy TypeScript projects.

- Older browser-based applications.

- Internal grouping without module systems.

- Existing codebases that already use namespaces.

Modern TypeScript development generally prefers modules.

## Advanced Concepts and Best Practices

### Module Re-Exports

Sometimes we combine multiple modules into one.

```

// index.ts
export * from "./math";
export * from "./student";

```

Now another file only imports from one location.

```

import { add, Student } from "./index";

```

This technique is known as creating a **barrel file**.

### Type-Only Imports

Sometimes we only need a type.

```

import type { User } from "./User";

```

This tells TypeScript that only type information is required, helping optimize the compiled JavaScript.

### Avoid Global Variables

Incorrect:

```

let count = 0;

```

Global variables can easily cause naming conflicts. Better:

```

export let count = 0;

```

Place the variable inside a module instead of the global scope.

### Advantages of Modules

- Better project organization.

- Improved code reusability.

- Easier maintenance.

- Strong encapsulation.

- Reduced naming conflicts.

- Excellent support in modern frameworks.

- Simplified collaboration among development teams.

### Advantages of Namespaces

- Organize related code.

- Avoid polluting the global scope.

- Useful in older TypeScript applications.

- Simple grouping mechanism.

### Common Mistakes

### 1. Forgetting to Export Members

Incorrect:

```

function add(a: number, b: number) {
return a + b;
}

```

Other files cannot access this function. Correct:

```

export function add(a: number, b: number) {
return a + b;
}

```

### 2. Incorrect Import Path

Incorrect:

```

import { add } from "math";

```

Correct:

```

import { add } from "./math";

```

Relative paths must begin with `./` or `../`.

### 3. Using Namespaces Instead of Modules in Modern Projects

Although namespaces still work, modern TypeScript applications use ES Modules because they integrate directly with JavaScript and are supported by tools such as React, Angular, Node.js, and modern bundlers.

### Real-World Applications

Modules are used extensively in modern TypeScript development, including:

- React component organization.

- Node.js backend applications.

- Angular feature modules.

- Utility libraries.

- API service layers.

- Authentication systems.

- Database access layers.

- State management solutions.

Namespaces are still found in:

- Legacy enterprise applications.

- Older browser-based TypeScript projects.

- Internal utility libraries that do not use module bundlers.

For example, in a large e-commerce application, separate modules may be created for user authentication, product management, shopping carts, payment processing, and order management. Each module handles a specific responsibility, making the application easier to develop, test, and maintain.

### Best Practices

- Prefer **ES Modules** over namespaces for new projects.

- Keep each module focused on a single responsibility.

- Export only what other files need.

- Use named exports when exporting multiple members.

- Use default exports only when a module has one primary export.

- Create barrel files (`index.ts`) to simplify imports.

- Use type-only imports when importing interfaces or types.

- Avoid unnecessary global variables.

### Conclusion

Modules and Namespaces are important tools for organizing TypeScript applications, but they serve different purposes. **Modules** use the standard JavaScript `import` and `export` system to divide code into reusable files, making them the preferred choice for modern development. **Namespaces** group related code under a single name and remain useful mainly in legacy projects or specialized scenarios. By understanding how modules and namespaces work, using exports and imports correctly, and following modern best practices, we can build scalable, maintainable, and well-structured TypeScript applications that are easier to develop and collaborate on.');

-- Lecture 12: TypeScript with React
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'TypeScript with React', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# TypeScript with React

React is one of the most popular JavaScript libraries for building modern user interfaces. While React provides flexibility for creating dynamic applications, combining it with **TypeScript** makes development even more powerful. TypeScript adds static typing to React, helping us detect errors during development, improve code quality, and make applications easier to maintain as they grow. Imagine building a skyscraper. React provides the construction materials, while TypeScript acts as the engineering blueprint that ensures every component fits together correctly. Without a blueprint, mistakes may only become visible after construction begins. With TypeScript, many problems are detected before the application even runs. In these lecture notes, we will explore how TypeScript integrates with React, how to type components, props, state, events, hooks, and best practices for building scalable React applications.

## Introduction to TypeScript with React

### What is TypeScript with React?

TypeScript with React means writing React components using TypeScript instead of plain JavaScript. This allows developers to define types for:

- Component props

- State variables

- Event handlers

- Hooks

- API responses

- Context data

The result is a more reliable and maintainable application.

### Why Use TypeScript in React?

TypeScript offers several advantages when working with React:

- Detects errors before runtime.

- Provides better IntelliSense and code completion.

- Makes components self-documenting.

- Improves refactoring.

- Reduces bugs in large projects.

- Makes teamwork easier.

Large companies such as Microsoft, Airbnb, and Shopify use TypeScript because it improves code quality and developer productivity.

### Creating a React TypeScript Project

Using **Vite**:

```

npm create vite@latest my-app -- --template react-ts

```

Move into the project directory: `cd my-app` Install dependencies: `npm install` Run the development server: `npm run dev` The project now supports React with TypeScript.

## Components and Props

### Typing Functional Components

A React component is simply a function that returns JSX.

```

interface WelcomeProps {
name: string;
}
function Welcome({ name }: WelcomeProps) {
return <h1>Hello, {name}!</h1>;
}
export default Welcome;

```

Usage: `<Welcome name="Ali" />` The `name` prop must be a string.

### Optional Props

Some props may not always be required.

```

interface UserProps {
name: string;
age?: number;
}
function User({ name, age }: UserProps) {
return (
<div>
<p>{name}</p>
<p>{age}</p>
</div>
);
}

```

The `?` symbol makes the `age` prop optional.

### Children Props

React components often receive child elements.

```

import { ReactNode } from "react";
interface CardProps {
children: ReactNode;
}
function Card({ children }: CardProps) {
return <div>{children}</div>;
}

```

Usage:

```

<Card>
<h2>Welcome</h2>
</Card>

```

`ReactNode` allows any valid React content.

## State, Events, and Hooks

### Typing useState

TypeScript automatically infers many state types.

```

const [count, setCount] = useState(0);

```

Here, `count` is inferred as a number.

```

const [name, setName] = useState<string>("");

```

Array example:

```

const [users, setUsers] = useState<string[]>([]);

```

Object example:

```

interface User {
id: number;
name: string;
}
const [user, setUser] = useState<User | null>(null);

```

### Typing Event Handlers

React events should also be typed.

```

import { ChangeEvent } from "react";
function handleChange(event: ChangeEvent<HTMLInputElement>) {
console.log(event.target.value);
}

```

Button click example:

```

import { MouseEvent } from "react";
function handleClick(event: MouseEvent<HTMLButtonElement>) {
console.log("Clicked");
}

```

Typing events improves IntelliSense and prevents mistakes.

### Typing useRef

```

import { useRef } from "react";
const inputRef = useRef<HTMLInputElement>(null);

```

Accessing the element:

```

inputRef.current?.focus();

```

The optional chaining operator (`?.`) prevents errors when the reference is `null`.

## Advanced React with TypeScript

### Typing useEffect

The `useEffect` hook usually does not require explicit typing.

```

useEffect(() => {
console.log("Component Mounted");
}, []);

```

However, any variables inside the effect remain fully type-checked.

### Typing API Responses

Suppose we receive user data from an API.

```

interface User {
id: number;
name: string;
email: string;
}

```

Using the interface:

```

const [users, setUsers] = useState<User[]>([]);

```

Every user object must follow the interface.

### Typing Functions Passed as Props

Components often receive callback functions.

```

interface ButtonProps {
onClick: () => void;
}
function Button({ onClick }: ButtonProps) {
return <button onClick={onClick}>Click</button>;
}

```

Callback with parameters:

```

interface UserProps {
onSelect(id: number): void;
}

```

This ensures the callback receives a number.

### Using Generics with React Components

Generics make reusable components even more flexible.

```

interface ListProps<T> {
items: T[];
}
function List<T>({ items }: ListProps<T>) {
return (
<ul>
{items.map((item, index) => (
<li key={index}>{String(item)}</li>
))}
</ul>
);
}

```

Usage:

```

<List items={["Apple", "Banana"]} />
<List items={[10, 20, 30]} />

```

The same component works for multiple data types.

## Best Practices and Real-World Applications

### Advantages of Using TypeScript with React

Using TypeScript in React projects provides numerous benefits:

- Strong type safety.

- Better code completion.

- Easier debugging.

- Improved code documentation.

- Safer refactoring.

- Better collaboration in teams.

- Reduced runtime errors.

- Easier maintenance of large applications.

### Common Mistakes

**1. Using** `any` **Too Often** Incorrect:

```

function User(props: any) {
return <div>{props.name}</div>;
}

```

Correct:

```

interface UserProps {
name: string;
}
function User({ name }: UserProps) {
return <div>{name}</div>;
}

```

Avoid `any` whenever possible to preserve type safety.

### 2. Forgetting to Handle Null Values

Incorrect:

```

const inputRef = useRef<HTMLInputElement>(null);
inputRef.current.focus();

```

This may produce an error if `current` is `null`. Correct:

```

inputRef.current?.focus();

```

### 3. Not Typing State Properly

Incorrect:

```

const [user, setUser] = useState(null);

```

Correct:

```

interface User {
name: string;
}
const [user, setUser] = useState<User | null>(null);

```

This clearly defines the expected structure of the state.

### Real-World Applications

TypeScript with React is widely used in professional web development, including:

- E-commerce platforms

- Banking and financial systems

- Healthcare dashboards

- Learning management systems

- Customer relationship management (CRM) software

- Social media applications

- Project management tools

- SaaS (Software as a Service) platforms

- Administrative dashboards

For example, in an online shopping application, interfaces can define products, shopping carts, and user profiles. Components receive strongly typed props, state stores typed product lists, and API responses follow predefined interfaces. This reduces errors and ensures consistency throughout the application.

### Best Practices

- Define interfaces for component props.

- Avoid using `any`; prefer specific types.

- Type state variables explicitly when necessary.

- Use interfaces or type aliases for API responses.

- Type event handlers correctly.

- Use generics for reusable components.

- Keep components focused on a single responsibility.

- Organize types in separate files for large projects.

- Use optional chaining (`?.`) when working with nullable values.

- Take advantage of TypeScript\'s type inference instead of adding unnecessary type annotations.

### Conclusion

TypeScript and React form a powerful combination for building modern, scalable, and maintainable web applications. By adding static typing to React components, TypeScript helps developers catch errors early, write self-documenting code, and improve the overall development experience. Properly typing props, state, events, hooks, API responses, and reusable components leads to safer and more reliable applications. By following best practices and leveraging TypeScript\'s advanced features, we can build high-quality React applications that are easier to develop, test, maintain, and scale for real-world software projects.');

-- Lecture 13: Building a Type-Safe Project in TypeScript
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a Type-Safe Project in TypeScript', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a Type-Safe Project in TypeScript

Building modern software involves much more than writing code that works. A professional application should be reliable, maintainable, scalable, and easy to debug. One of the biggest advantages of TypeScript is its ability to help us build **type-safe projects**, where the compiler checks our code for type-related errors before it runs. This significantly reduces runtime bugs and improves overall code quality. Imagine constructing a bridge. Before the bridge is opened to the public, engineers inspect every beam, bolt, and support structure to ensure safety. Similarly, TypeScript acts as an inspector for our code, verifying that data types are used correctly before the application is executed. In these lecture notes, we will explore how to build a type-safe TypeScript project by organizing files, defining types, using interfaces, applying generics, and following best practices for real-world development.

## Introduction to Type-Safe Projects

### What is a Type-Safe Project?

A **type-safe project** is an application where TypeScript ensures that variables, functions, objects, and classes are used according to their defined types. This helps prevent unexpected errors during execution. Example:

```

let age: number = 25;

```

Valid assignment:

```

age = 30;

```

Invalid assignment:

```

age = "Thirty";

```

TypeScript reports an error before the application runs.

### Why Build a Type-Safe Project?

Type safety provides many benefits:

- Detects errors early.

- Improves code readability.

- Enhances maintainability.

- Makes refactoring safer.

- Provides better IntelliSense.

- Encourages reusable code.

- Simplifies teamwork in large projects.

Large-scale applications become easier to manage because developers know exactly what types are expected.

### Project Structure

A well-organized TypeScript project might look like this:

```

src/
│
├── models/
├── services/
├── utils/
├── components/
├── interfaces/
├── types/
├── app.ts
└── index.ts

```

Each folder has a specific responsibility, making the project easier to navigate and maintain.

## Defining Types and Interfaces

### Using Interfaces

Interfaces define the structure of objects.

```

interface User {
id: number;
name: string;
email: string;
}

```

Creating an object:

```

const user: User = {
id: 1,
name: "Ali",
email: "ali@example.com"
};

```

TypeScript ensures every required property exists.

### Using Type Aliases

Type aliases define reusable custom types.

```

type ProductID = string;

```

Usage:

```

let id: ProductID = "P100";

```

Type aliases improve readability and consistency.

### Optional and Readonly Properties

```

interface Product {
readonly id: number;
name: string;
description?: string;
}

```

Here:

- `readonly` prevents modification.

- `?` makes a property optional.

## Creating Reusable Components

### Generic Functions

Generics make functions reusable.

```

function identity<T>(value: T): T {
return value;
}

```

Usage:

```

identity("Hello");
identity(100);
identity(true);

```

One function works with multiple data types.

### Generic Interfaces

```

interface ApiResponse<T> {
success: boolean;
}

```

Usage:

```

interface User {
name: string;
}
const response: ApiResponse<User> = {
success: true,
data: {
name: "Sara"
}
};

```

### Reusable Utility Functions

```

function getFirstItem<T>(items: T[]): T {
return items[0];
}

```

Example:

```

getFirstItem([1, 2, 3]);
getFirstItem(["Apple", "Orange"]);

```

Generics eliminate duplicate code while preserving type safety.

## Organizing Application Logic

### Using Modules

Separate related code into modules.

```

// user.ts
export interface User {
id: number;
name: string;
}

```

Importing:

```

import { User } from "./user";

```

Modules improve project organization and encourage code reuse.

### Working with Classes

```

class UserService {
getUser(): string {
return "Ali";
}
}

```

Creating an object:

```

const service = new UserService();

```

Classes help encapsulate business logic.

### Using Access Modifiers

```

class BankAccount {
private balance = 1000;
getBalance(): number {
return this.balance;
}
}

```

Private members protect sensitive data from unauthorized access.

## Best Practices for Building Type-Safe Applications

### Avoid Using

`any` Incorrect:

```

let data: any = "Hello";

```

Better:

```

let data: string = "Hello";

```

Avoiding `any` allows TypeScript to perform effective type checking.

### Use Type Narrowing

```

function print(value: string | number) {
if (typeof value === "string") {
console.log(value.toUpperCase());
} else {
console.log(value.toFixed(2));
}
}

```

Type narrowing safely handles variables with multiple possible types.

### Validate API Responses

```

interface Product {
id: number;
name: string;
}
const products: Product[] = [];

```

Every product must match the interface before it is used in the application.

### Organize Types

Instead of defining interfaces repeatedly, create dedicated folders. Example:

```

types/
interfaces/
models/

```

This keeps projects clean and scalable.

### Enable Strict Mode

Enable strict type checking in `tsconfig.json`.

```

{
"compilerOptions": {
"strict": true
}
}

```

Strict mode catches more potential issues during compilation.

### Advantages of Type-Safe Projects

Building a type-safe application provides many advantages:

- Early error detection.

- Better documentation through types.

- Easier debugging.

- Improved collaboration.

- Reliable refactoring.

- Cleaner code architecture.

- Increased maintainability.

- Greater developer confidence.

### Common Mistakes

**1. Overusing** `any` Incorrect:

```

function process(data: any) {
return data;
}

```

Correct:

```

function process<T>(data: T): T {
return data;
}

```

Generics preserve type information while remaining flexible.

### 2. Ignoring Null Values

Incorrect:

```

let user: string = null;

```

Correct:

```

let user: string | null = null;

```

Explicitly handling `null` improves safety and clarity.

### 3. Mixing Responsibilities

Avoid placing authentication, database logic, UI code, and utility functions in the same file. Better organization:

```

services/
components/
utils/
models/

```

Each module should focus on one responsibility.

### Real-World Applications

Type-safe TypeScript projects are widely used in:

- React applications.

- Angular applications.

- Node.js backend services.

- Banking systems.

- Healthcare platforms.

- E-commerce websites.

- Learning management systems.

- Enterprise resource planning (ERP) software.

- Customer relationship management (CRM) systems.

- Cloud-based SaaS applications.

For example, an online banking system can use interfaces to define customer accounts, generics to process different transaction types, classes to manage account operations, and strict typing to ensure that every financial transaction follows the correct data structure. This reduces the risk of data inconsistencies and runtime failures.

### Best Practices Checklist

- Use meaningful interfaces and type aliases.

- Prefer `unknown` over `any` when the type is uncertain.

- Enable strict mode in `tsconfig.json`.

- Organize code into modules.

- Create reusable generic functions and classes.

- Keep components and services focused on a single responsibility.

- Use access modifiers to protect sensitive data.

- Validate API responses with interfaces.

- Use union types, intersection types, and type guards where appropriate.

- Maintain a clear folder structure for models, services, utilities, and types.

### Conclusion

Building a type-safe project in TypeScript is about more than adding type annotations—it is about creating a reliable architecture that supports long-term growth and maintainability. By organizing code into modules, defining interfaces and type aliases, using generics for reusability, applying classes and access modifiers for encapsulation, and enabling strict type checking, we can develop applications that are safer, easier to debug, and simpler to scale. Following these best practices not only reduces runtime errors but also improves collaboration, code quality, and developer productivity, making TypeScript an excellent choice for building modern, enterprise-grade software.');
