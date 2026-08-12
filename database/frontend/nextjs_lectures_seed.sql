-- =============================================
-- ReflectAI — Next.js Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'Next.js' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to Next.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to Next.js', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to Next.js

Next.js is one of the most popular React frameworks used for building modern web applications. While React helps us create interactive user interfaces, Next.js extends React by providing powerful features such as server-side rendering, static site generation, routing, image optimization, API routes, and excellent performance out of the box. Instead of spending time configuring different tools, we can focus on building applications that are fast, scalable, and user-friendly. Think of React as a powerful engine and Next.js as a complete car. The engine gives us power, but the car includes the steering wheel, brakes, navigation, and everything else needed for a smooth journey. Similarly, Next.js provides all the essential tools developers need to create production-ready applications with minimal setup.

## Understanding Next.js

### What is Next.js?

Next.js is an open-source React framework created by Vercel. It simplifies web development by offering a complete framework for building full-stack applications. Instead of only handling the frontend, Next.js also allows us to create backend APIs, optimize images, manage routing, and improve application performance. Unlike traditional React projects that require additional libraries for routing and server-side rendering, Next.js includes these features by default. **Key Characteristics**

- Built on top of React

- Supports both frontend and backend development

- Automatic routing system

- Fast rendering techniques

- SEO-friendly architecture

- Excellent developer experience

### Why Do We Need Next.js?

React alone is excellent for building user interfaces, but developers often face challenges such as:

- Slow initial page loading

- Poor Search Engine Optimization (SEO)

- Complex project configuration

- Manual routing setup

- Performance optimization

Next.js solves these problems by providing built-in solutions. Imagine opening a large shopping mall. React gives us the building materials, while Next.js provides the architect\'s blueprint, electrical wiring, elevators, and security system. Everything works together seamlessly.

## Features of Next.js

### 1. File-Based Routing

One of the biggest advantages of Next.js is automatic routing. Instead of installing React Router and defining routes manually, Next.js creates routes automatically based on the folder structure. Example:

```

app/
page.js
about/
page.js
contact/
page.js

```

Generated routes:

```

/
/about
/contact

```

This makes projects easier to organize and maintain.

### 2. Server-Side Rendering (SSR)

Normally, React applications render pages inside the browser. With Server-Side Rendering, the server generates the HTML before sending it to the user\'s browser. **Benefits**

- Faster first page load

- Better SEO

- Improved user experience

- Faster indexing by search engines

This approach is ideal for:

- News websites

- E-commerce stores

- Blogs

- Business websites

### 3. Static Site Generation (SSG)

Instead of generating pages every time someone visits, Next.js can build pages once during deployment. Advantages include:

- Extremely fast loading

- Better security

- Lower server cost

- High scalability

Examples:

- Portfolio websites

- Documentation

- Landing pages

- Company websites

### 4. Client-Side Rendering (CSR)

Some applications need constant interaction with users. Examples include:

- Dashboards

- Social media feeds

- Chat applications

Next.js supports client-side rendering whenever necessary.

### 5. Incremental Static Regeneration (ISR)

Sometimes static pages need updates without rebuilding the entire website. ISR allows pages to regenerate automatically after a specified interval. Benefits:

- Fast performance

- Fresh content

- Lower deployment costs

### 6. Built-in Image Optimization

Images are often the largest files on a webpage. Next.js provides the `<Image>` component, which automatically:

- Compresses images

- Resizes images

- Loads images lazily

- Improves Core Web Vitals

Example:

```

import Image from "next/image";
<Image
src="/profile.jpg"
width={300}
height={300}
alt="Profile"
/>

```

### 7. API Routes

Next.js allows us to build backend APIs inside the same project. Example: `app/api/users/route.js` This can handle:

- GET requests

- POST requests

- PUT requests

- DELETE requests

No separate Express server is required for many applications.

## Project Structure in Next.js

A typical Next.js project contains several folders.

```

my-app/
app/
public/
components/
styles/
node_modules/
package.json
next.config.js

```

### The app Folder

Modern Next.js uses the **App Router**. Example:

```

app/
layout.js
page.js
about/
page.js

```

**page.js** Represents a page. `app/page.js` Displays the homepage. **layout.js** Provides a common layout shared across multiple pages. Examples include:

- Navigation bar

- Footer

- Sidebar

This prevents code duplication.

### Public Folder

Stores static assets. Examples:

```

public/
logo.png
hero.jpg

```

These files can be accessed directly.

### Components Folder

Reusable UI components are stored here. Example:

```

components/
Navbar.jsx
Footer.jsx
Button.jsx
Card.jsx

```

This promotes modular and maintainable code.

## Rendering Methods in Next.js

One of the most powerful concepts in Next.js is choosing how a page is rendered.

### 1. Server-Side Rendering (SSR)

Page generated for every request. Ideal for:

- Live stock prices

- Weather updates

- User dashboards

Advantages:

- Fresh data

- Better SEO

Disadvantages:

- Slightly slower than static pages

### 2. Static Site Generation (SSG)

Generated once during build time. Best for:

- Blogs

- Documentation

- Portfolios

Advantages:

- Very fast

- Secure

- Low hosting costs

### 3. Client-Side Rendering (CSR)

Rendered in the browser. Suitable for:

- Interactive dashboards

- Chat systems

- Analytics panels

Advantages:

- Dynamic interfaces

- Smooth user interactions

### 4. Incremental Static Regeneration (ISR)

Combines static generation with automatic updates. Ideal for:

- Product catalogs

- News websites

- Educational platforms

### Comparison

| Feature | SSR | SSG | CSR | ISR |
|---|---|---|---|---|
| Speed | Medium | Very Fast | Medium | Fast |
| SEO | Excellent | Excellent | Limited | Excellent |
| Dynamic Data | Yes | No | Yes | Yes |
| Build Time | Low | High | Low | Medium |

## Advantages and Real-World Applications

### Advantages of Next.js

**Excellent Performance** Automatic optimizations improve loading speed without additional configuration. **Better SEO** Search engines can easily crawl server-rendered pages, making websites more discoverable. **Easy Routing** Developers simply create folders and files instead of configuring routing manually. **Full-Stack Development** Frontend and backend can exist in one project. **Developer Productivity** Features like Hot Reloading, TypeScript support, and built-in optimization reduce development time.

### Common Use Cases

Next.js is widely used for:

- E-commerce websites

- Business websites

- SaaS platforms

- Educational portals

- Portfolio websites

- News platforms

- Blogs

- Dashboards

- Content Management Systems (CMS)

Many modern companies choose Next.js because it delivers fast performance, strong SEO, and a smooth development experience.

### Getting Started with Next.js

**Step 1: Install Node.js** Ensure Node.js is installed on your system. **Step 2: Create a New Project**

```

npx create-next-app@latest my-app

```

**Step 3: Navigate to the Project** `cd my-app` **Step 4: Start the Development Server** `npm run dev` **Step 5: Open the Application** Visit: `http://localhost:3000` Any changes you make to the code are automatically reflected in the browser through Fast Refresh, making development quick and efficient.

### Next.js vs React

| Feature | React | Next.js |
|---|---|---|
| Routing | External library required | Built-in |
| SEO | Limited | Excellent |
| Rendering | Client-side by default | Multiple rendering methods |
| Backend APIs | Separate server required | Built-in API routes |
| Image Optimization | Manual | Automatic |
| Project Configuration | More setup | Minimal setup |
| Performance | Good | Excellent |

### Conclusion

Next.js has transformed modern web development by building upon React and providing a complete framework for creating high-performance, production-ready applications. With features such as file-based routing, server-side rendering, static site generation, incremental static regeneration, built-in API routes, and automatic image optimization, it removes much of the complexity developers traditionally face. Whether we are building a personal portfolio, an e-commerce platform, a blog, or a large enterprise application, Next.js offers the flexibility, speed, and scalability needed to deliver exceptional user experiences. By learning Next.js, we gain the ability to create fast, SEO-friendly, and maintainable web applications that meet modern industry standards.');

-- Lecture 2: Pages & Layouts in Next.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Pages & Layouts in Next.js', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Pages & Layouts in Next.js

Pages and layouts are the foundation of every Next.js application. They determine how users navigate through a website and how common interface elements are shared across different pages. With the introduction of the **App Router**, Next.js uses a simple folder-based structure where files and directories automatically define the application\'s routes and layouts. This approach makes projects easier to organize, maintain, and scale.

### Pages in Next.js

A **page** represents a unique route or screen in the application. Every page is created using a `page.js` (or `page.tsx`) file inside the `app` directory. The location of the file determines the URL automatically, eliminating the need for manual route configuration. For example:

```

app/
│── page.js
│── about/
│ └── page.js
│── contact/
│ └── page.js

```

This structure generates the following routes:

- `/` → Home Page

- `/about` → About Page

- `/contact` → Contact Page

A simple page example:

```

export default function Home() {
return (
<h1>Welcome to Next.js</h1>
);
}

```

When users visit the homepage, this component is automatically rendered.

### Layouts in Next.js

A **layout** is a reusable wrapper that surrounds one or more pages. It allows developers to share common user interface elements such as:

- Navigation bars

- Footers

- Sidebars

- Headers

- Theme providers

Instead of rewriting these components for every page, they are placed inside a `layout.js` file and automatically applied to all child pages. Example:

```

app/
│── layout.js
│── page.js
│── about/
│ └── page.js

```

Example code:

```

export default function RootLayout({ children }) {
return (
<html lang="en">
<body>
<header>My Website</header>
{children}
<footer>© 2026 My Website</footer>
</body>
</html>
);
}

```

Here, the header and footer appear on every page, while `{children}` displays the content of the current page.

### Nested Layouts

Next.js also supports **nested layouts**, allowing different sections of an application to have their own unique layouts. Example:

```

app/
│── layout.js
│── dashboard/
│ ├── layout.js
│ ├── page.js
│ └── settings/
│ └── page.js

```

In this structure:

- The root `layout.js` is shared across the entire application.

- The `dashboard/layout.js` is only applied to dashboard-related pages.

- Pages inside the dashboard inherit both layouts automatically.

This feature is particularly useful for applications with dashboards, admin panels, or user account sections.

### Benefits of Pages & Layouts

Using pages and layouts provides several advantages:

- Automatic file-based routing without extra configuration.

- Reusable layouts reduce duplicate code.

- Better organization of project files.

- Easier maintenance and scalability.

- Consistent user interface across multiple pages.

- Improved developer productivity.

### Common Folder Structure

```

app/
│── layout.js
│── page.js
│── about/
│ └── page.js
│── dashboard/
│ ├── layout.js
│ ├── page.js
│ └── analytics/
│ └── page.js

```

This structure creates a clean, organized application where pages define routes and layouts manage shared UI components.

### Conclusion

Pages and layouts are fundamental concepts in Next.js that simplify application development. Pages automatically create routes based on the project\'s folder structure, while layouts allow developers to share common interface components across multiple pages without repeating code. Together, they improve code organization, maintain consistency, and make Next.js applications easier to build, maintain, and scale.');

-- Lecture 3: Dynamic Routes
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Dynamic Routes', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Dynamic Routes

in Next.js allow developers to create pages whose URLs contain **variable values** instead of fixed paths. Rather than creating a separate page for every item, developers can create a single dynamic page that displays different content based on the URL parameter. This makes applications more flexible, scalable, and easier to maintain. Imagine a library with thousands of books. Instead of building a separate room for every book, the library uses a numbering system to locate each one. Similarly, Dynamic Routes use URL parameters to identify and display different content using the same page component.

### Why Do We Need Dynamic Routes?

Without Dynamic Routes, developers would need to create individual pages for every piece of content. For example, an online store with hundreds of products would require pages like:

```

/products/laptop
/products/mobile
/products/headphones
/products/camera

```

Creating each page manually would be time-consuming and difficult to maintain. With Dynamic Routes, a single page can display all products by reading the value from the URL.

### Creating a Dynamic Route

In the **App Router**, Dynamic Routes are created by placing the folder name inside **square brackets** `[ ]`. Example project structure:

```

app/
│── products/
│ └── [id]/
│ └── page.js

```

Here, `[id]` is a dynamic segment that can represent any product ID. Examples of generated URLs:

```

/products/1
/products/25
/products/100

```

All these URLs use the same `page.js` file.

### Accessing Route Parameters

Next.js automatically passes the dynamic parameter through the `params` object. Example:

```

export default function ProductPage({ params }) {
return (
<div>
<h1>Product ID: {params.id}</h1>
</div>
);
}

```

If the user visits: `/products/15` The page displays: `Product ID: 15`

### Multiple Dynamic Parameters

A route can contain more than one dynamic segment. Example folder structure:

```

app/
│── blog/
│ └── [category]/
│ └── [slug]/
│ └── page.js

```

Possible URL:

```

/blog/technology/nextjs-routing

```

Example component:

```

export default function BlogPost({ params }) {
return (
<div>
<h2>Category: {params.category}</h2>
<h3>Post: {params.slug}</h3>
</div>
);
}

```

Output:

```

Category: technology
Post: nextjs-routing

```

### Catch-All Dynamic Routes

Sometimes a URL may contain multiple path segments. Next.js provides **Catch-All Routes** using three dots (`...`). Example:

```

app/
│── docs/
│ └── [...slug]/
│ └── page.js

```

Possible URLs:

```

/docs/react
/docs/react/hooks
/docs/react/hooks/useState

```

Example:

```

export default function Docs({ params }) {
return (
<div>
<p>{params.slug.join(" / ")}</p>
</div>
);
}

```

For the URL: `/docs/react/hooks` Output: `react / hooks`

### Optional Catch-All Routes

If the route should work **with or without additional URL segments**, use **double square brackets**. Example:

```

app/
│── docs/
│ └── [[...slug]]/
│ └── page.js

```

This route matches:

```

/docs
/docs/react
/docs/react/hooks

```

This provides greater flexibility for documentation websites and nested content.

### Advantages of Dynamic Routes

Dynamic Routes provide several important benefits:

- Reduce duplicate code.

- Automatically handle multiple URLs.

- Improve project organization.

- Make applications easier to scale.

- Support dynamic data from databases or APIs.

- Simplify maintenance for large applications.

### Common Use Cases

Dynamic Routes are widely used in applications such as:

- E-commerce product pages

- Blog articles

- User profile pages

- News websites

- Course details

- Documentation websites

- Category and subcategory pages

For example:

```

/products/101
/blog/introduction-to-nextjs
/users/john-doe
/courses/web-development

```

Each URL is handled by a single dynamic page.

### Best Practices

- Use descriptive parameter names such as `[id]`, `[slug]`, or `[username]`.

- Validate route parameters before displaying data.

- Fetch data based on the dynamic parameter.

- Use Catch-All Routes only when multiple URL segments are required.

- Keep folder names organized for better project structure.

### Dynamic Routes vs Static Routes

| Feature | Static Routes | Dynamic Routes |
|---|---|---|
| URL Structure | Fixed | Variable |
| Number of Pages | One page per route | One page for many routes |
| Scalability | Limited | Excellent |
| Maintenance | More effort | Easier |
| Common Use | Home, About, Contact | Products, Blogs, User Profiles |

### Conclusion

Dynamic Routes are a powerful feature of Next.js that allow developers to create flexible and scalable applications using variable URL segments. By using square brackets to define dynamic parameters, a single page can display different content based on the requested URL. Features such as multiple parameters, Catch-All Routes, and Optional Catch-All Routes make routing even more versatile. Dynamic Routes reduce code duplication, improve maintainability, and are essential for building modern applications such as blogs, e-commerce websites, dashboards, and documentation platforms.');

-- Lecture 4: Client vs Server Components in Next.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Client vs Server Components in Next.js', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Client vs Server Components in Next.js

One of the most important features introduced in modern Next.js is the concept of **Client Components** and **Server Components**. These components determine **where the code is executed** —either on the server before being sent to the browser or directly in the user\'s browser after the page loads. By separating rendering responsibilities, Next.js improves performance, reduces the amount of JavaScript sent to the client, and creates faster, more efficient web applications. Think of it like preparing a meal. A **Server Component** is like a chef preparing the food in the kitchen before serving it to customers, while a **Client Component** is like the customer adding ketchup or seasoning at the table. The heavy work is done beforehand, and only interactive actions happen afterward.

### What are Server Components?

A **Server Component** is rendered on the server before the page reaches the user\'s browser. In the **App Router**, all components are **Server Components by default** unless specified otherwise. Server Components are ideal for:

- Fetching data from databases

- Calling APIs

- Rendering static content

- Displaying product information

- Building blog pages

### Example

```

export default async function Home() {
const res = await fetch("https://api.example.com/posts");
const posts = await res.json();
return (
<div>
<h1>Latest Posts</h1>
<p>{posts.length} posts found.</p>
</div>
);
}

```

Since this component runs on the server, the user receives an already-rendered HTML page, resulting in faster loading and better SEO.

### Advantages of Server Components

- Faster initial page load

- Better Search Engine Optimization (SEO)

- Reduced JavaScript sent to the browser

- Secure access to databases and secret API keys

- Improved application performance

### Limitations

Server Components **cannot** use:

- `useState`

- `useEffect`

- Browser APIs (such as `window` or `document`)

- Event handlers like `onClick`

### What are Client Components?

A **Client Component** runs inside the user\'s browser after the page has loaded. These components are required whenever the application needs user interaction or browser-specific functionality. To create a Client Component, add the following directive at the top of the file:

```

"use client";

```

Client Components are commonly used for:

- Buttons

- Forms

- Search bars

- Modals

- Dropdown menus

- Interactive dashboards

### Example

```

"use client";
import { useState } from "react";
export default function Counter() {
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

This component updates the counter whenever the user clicks the button, making it interactive.

### Advantages of Client Components

- Support interactivity

- Can use React Hooks

- Access browser APIs

- Handle user events

- Provide dynamic user experiences

### Limitations

- Larger JavaScript bundle

- Slower initial loading compared to Server Components

- Less SEO-friendly when rendering dynamic content entirely on the client

### Key Differences Between Client and Server Components

| Feature | Server Components | Client Components |
|---|---|---|
| Execution Location | Server | Browser |
| Default in App Router | Yes | No |
| Supports useState | No | Yes |
| Supports useEffect | No | Yes |
| Supports Event Handlers | No | Yes |
| Access to Browser APIs | No | Yes |
| Access to Databases | Yes | No |
| SEO | Excellent | Good (depends on usage) |
| JavaScript Sent to Browser | Less | More |

### When Should We Use Each?

### Use Server Components When:

- Fetching data from a database or API

- Displaying blog articles

- Building product pages

- Rendering dashboards with server-side data

### Use Client Components When:

- Creating forms

- Building interactive buttons

- Managing user input

- Using animations

- Handling clicks and browser events

- Working with React Hooks

### Combining Server and Client Components

One of the greatest strengths of Next.js is that **Server Components and Client Components can work together**. A Server Component can fetch data efficiently and then pass it as props to a Client Component for interactivity. Example:

```

// Server Component
import Counter from "./Counter";
export default function Home() {
return (
<div>
<h1>Welcome</h1>
<Counter />
</div>
);
}

```

Here:

- The **Home** component is rendered on the server.

- The **Counter** component is rendered in the browser because it uses `"use client"`.

This hybrid approach provides the best balance between performance and user interaction.

### Best Practices

- Use **Server Components by default** whenever possible.

- Create **Client Components only for interactive features**.

- Keep Client Components small to reduce JavaScript bundle size.

- Fetch sensitive data only in Server Components.

- Avoid adding `"use client"` unless browser-specific functionality is required.

### Conclusion

Client Components and Server Components are fundamental concepts in modern Next.js development. **Server Components** improve performance, security, and SEO by rendering content on the server, while **Client Components** enable interactive features such as forms, buttons, and state management in the browser. By understanding the strengths of each and combining them effectively, developers can build fast, scalable, and highly interactive web applications that deliver an excellent user experience.');

-- Lecture 5: Data Fetching in Next.js (fetch, getServerSideProps, getStaticProps)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Data Fetching in Next.js (fetch, getServerSideProps, getStaticProps)', 5, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Data Fetching in Next.js

Data fetching is one of the most important aspects of building dynamic web applications. In **Next.js**, data can be retrieved from APIs, databases, or external services before or during page rendering. Next.js provides multiple data-fetching methods, allowing developers to choose the best approach based on whether the data is static, dynamic, or updated frequently. Think of a website as a newspaper. Some information, like the company logo or contact details, rarely changes and can be printed in advance. Other information, such as weather updates or stock prices, changes frequently and must be fetched whenever someone reads the newspaper. Next.js provides different data-fetching methods to efficiently handle both situations.

### Why is Data Fetching Important?

Most modern websites rely on external data sources such as:

- Databases

- REST APIs

- GraphQL APIs

- Content Management Systems (CMS)

- Cloud services

Data fetching allows applications to display up-to-date information, personalize user experiences, and interact with backend services.

### 1. Using in the App Router

`fetch()` In the **App Router** (introduced in Next.js 13+), the recommended way to fetch data is by using the built-in `fetch()` function inside **Server Components**. Example:

```

export default async function Posts() {
const response = await fetch("https://api.example.com/posts");
const posts = await response.json();
return (
<div>
<h1>Total Posts: {posts.length}</h1>
</div>
);
}

```

Since this code runs on the server by default, the page is rendered with the fetched data before it reaches the browser. **Benefits of** `fetch()`

- Built into JavaScript and Next.js.

- Supports caching and revalidation.

- Works directly in Server Components.

- Improves application performance.

- Simplifies data fetching.

### Caching with

`fetch()` Next.js allows developers to control how fetched data is cached.

### Static Data (Cached)

```

const response = await fetch(
"https://api.example.com/posts",
{
cache: "force-cache",
}
);

```

The data is cached and reused for future requests, making it suitable for static content.

### Dynamic Data (No Cache)

```

const response = await fetch(
"https://api.example.com/posts",
{
cache: "no-store",
}
);

```

The data is fetched every time a request is made, ensuring users always receive the latest information.

### 2.

`getServerSideProps() getServerSideProps()` is used in the **Pages Router** to fetch data **on every request**. The server retrieves the data before rendering the page, ensuring that users always receive fresh and up-to-date content. Example:

```

export async function getServerSideProps() {
const response = await fetch(
"https://api.example.com/posts"
);
const posts = await response.json();
return {
props: {
posts,
},
};
}
export default function Home({ posts }) {
return <h1>Total Posts: {posts.length}</h1>;
}

```

**When to Use** `getServerSideProps()`

- Real-time dashboards

- News websites

- Weather applications

- Stock market data

- User-specific pages

### Advantages

- Always returns fresh data.

- Excellent SEO.

- Suitable for dynamic content.

### Disadvantages

- Runs on every request.

- Higher server usage.

- Slightly slower than static pages.

**Note:** `getServerSideProps()` is only available in the **Pages Router** and is **not supported in the App Router**.

### 3.

`getStaticProps() getStaticProps()` is another Pages Router function that fetches data **during the build process**. The generated page becomes a static HTML file, making it extremely fast. Example:

```

export async function getStaticProps() {
const response = await fetch(
"https://api.example.com/posts"
);
const posts = await response.json();
return {
props: {
posts,
},
};
}
export default function Home({ posts }) {
return <h1>Total Posts: {posts.length}</h1>;
}

```

**When to Use** `getStaticProps()`

- Blogs

- Documentation

- Portfolio websites

- Company websites

- Landing pages

### Advantages

- Extremely fast.

- Excellent SEO.

- Low server cost.

- Highly scalable.

### Disadvantages

- Data does not update until the site is rebuilt.

- Not suitable for real-time applications.

**Note:** `getStaticProps()` is also only available in the **Pages Router**. In the **App Router**, similar behavior is achieved using `fetch()` with caching and revalidation.

### Data Fetching Methods Comparison

| Feature | fetch() (App Router) | getServerSideProps() | getStaticProps() |
|---|---|---|---|
| Router | App Router | Pages Router | Pages Router |
| Runs At | Server (default) | Every request | Build time |
| Fresh Data | Yes (with no-store) | Yes | No |
| Caching | Configurable | No | Built-in |
| SEO | Excellent | Excellent | Excellent |
| Best For | Modern Next.js apps | Dynamic pages | Static pages |

### Best Practices

- Use `fetch()` for all new projects using the **App Router**.

- Use `cache: "force-cache"` for static content.

- Use `cache: "no-store"` for frequently changing data.

- Use `getServerSideProps()` only in legacy or Pages Router projects requiring real-time data.

- Use `getStaticProps()` only in Pages Router projects for content that changes infrequently.

- Always handle errors when fetching data.

Example:

```

try {
const response = await fetch("https://api.example.com/posts");
if (!response.ok) {
throw new Error("Failed to fetch data");
}
const posts = await response.json();
} catch (error) {
console.log(error);

```

### Conclusion

Data fetching is a core feature of Next.js that enables applications to retrieve and display information from external sources efficiently. In the **App Router**, the built-in `fetch()` function is the recommended approach, offering flexible caching and excellent performance. In the **Pages Router**, `getServerSideProps()` is used for dynamic, request-based data, while `getStaticProps()` is ideal for static content generated during the build process. By understanding when and how to use each method, developers can build fast, scalable, and SEO-friendly web applications that deliver the right data at the right time.');

-- Lecture 6: Static Site Generation (SSG)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Static Site Generation (SSG)', 6, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Static Site Generation (SSG)

is one of the most powerful rendering techniques provided by Next.js. In SSG, HTML pages are **generated at build time** rather than when a user requests them. This means that when a visitor opens a webpage, the pre-built HTML file is served immediately, resulting in extremely fast loading speeds and excellent performance. Think of SSG like printing thousands of copies of a book before customers arrive. Since the books are already printed, they can be handed out instantly. Similarly, with Static Site Generation, web pages are created in advance, allowing users to access them without waiting for the server to generate the page.

### How Static Site Generation Works

The SSG process follows these simple steps: 1. The developer builds the Next.js application using the build command. 2. Next.js generates static HTML files for eligible pages. 3. These files are stored on the server or Content Delivery Network (CDN). 4. When users visit the website, the pre-generated HTML is served immediately. Because no server-side rendering is needed for every request, pages load much faster and consume fewer server resources.

### Features of Static Site Generation

Static Site Generation offers several important features:

- Pages are generated during the build process.

- Very fast page loading.

- Excellent Search Engine Optimization (SEO).

- Lower server workload.

- Easy deployment using CDNs.

- Improved security since there is no server-side processing for each request.

- Better scalability for high-traffic websites.

### Creating a Static Page

In the **App Router**, Next.js automatically generates a page as static whenever possible. Example:

```

export default function Home() {
return (
<div>
<h1>Welcome to My Website</h1>
<p>This page is statically generated.</p>
</div>
);
}

```

Since this page does not request dynamic data, Next.js generates it during the build process and serves it as a static HTML file.

### Fetching Static Data

When fetching data that rarely changes, Next.js can generate the page at build time. Example:

```

export default async function Products() {
const res = await fetch("https://api.example.com/products", {
cache: "force-cache",
});
const products = await res.json();
return (
<div>
<h1>Products</h1>
<p>Total Products: {products.length}</p>
</div>
);

```

The `force-cache` option tells Next.js to cache the data, allowing the page to be statically generated during the build.

### Advantages of Static Site Generation

### 1. Extremely Fast Performance

Since pages are already generated, users receive content almost instantly without waiting for server processing.

### 2. Better SEO

Search engines receive fully rendered HTML pages, making it easier to crawl and index website content.

### 3. Lower Server Costs

Static files require very little server processing, reducing hosting expenses and improving efficiency.

### 4. High Scalability

Static websites can easily handle thousands or even millions of visitors because static files can be distributed through a CDN.

### 5. Improved Security

Since there is no server-side code executing on every request, there are fewer opportunities for server-based attacks.

### Limitations of Static Site Generation

Although SSG is highly efficient, it is not suitable for every application. Some limitations include:

- Content remains unchanged until the site is rebuilt.

- Not ideal for real-time applications.

- Frequent data updates require rebuilding the website or using Incremental Static Regeneration (ISR).

### Common Use Cases

Static Site Generation is best suited for websites where content changes infrequently, such as:

- Personal portfolios

- Blogs

- Documentation websites

- Company websites

- Landing pages

- Educational websites

- Marketing pages

These websites benefit from fast loading speeds and excellent SEO while requiring minimal server resources.

### SSG vs Server-Side Rendering (SSR)

| Feature | Static Site Generation (SSG) | Server-Side Rendering (SSR) |
|---|---|---|
| Page Generation | During build time | On every request |
| Loading Speed | Very Fast | Fast |
| SEO | Excellent | Excellent |
| Server Usage | Low | Higher |
| Best For | Static content | Frequently changing data |
| Scalability | Excellent | Good |

### Best Practices

- Use SSG for pages that rarely change.

- Store static assets in the `public` folder.

- Combine SSG with a CDN for maximum performance.

- Use **Incremental Static Regeneration (ISR)** when content needs periodic updates.

- Avoid SSG for pages requiring real-time or user-specific data.

### Conclusion

Static Site Generation (SSG) is a powerful rendering method in Next.js that creates web pages during the build process, allowing them to be served instantly to users. It offers outstanding performance, excellent SEO, lower hosting costs, improved security, and exceptional scalability. While it is ideal for websites with mostly static content—such as blogs, portfolios, documentation, and marketing pages—it may not be suitable for applications requiring real-time updates. By choosing SSG where appropriate, developers can build fast, reliable, and highly optimized web applications that provide an outstanding user experience.');

-- Lecture 7: Server-Side Rendering (SSR)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Server-Side Rendering (SSR)', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Server-Side Rendering (SSR)

is a rendering technique in Next.js where a web page is **generated on the server every time a user requests it**. Instead of sending an empty page and letting the browser build the content, the server prepares the complete HTML first and then sends it to the user\'s browser. This ensures that users always receive the latest data while also improving Search Engine Optimization (SEO). Imagine ordering a freshly cooked meal at a restaurant. The chef prepares the meal only after receiving your order, ensuring it is fresh and up to date. Similarly, with Server-Side Rendering, the server generates a fresh page whenever a user visits the website.

### How Server-Side Rendering Works

The SSR process follows these steps: 1. A user requests a webpage. 2. The Next.js server receives the request. 3. The server fetches the required data from APIs or databases. 4. The server generates the HTML page. 5. The completed HTML is sent to the user\'s browser. 6. React hydrates the page, making it interactive. Since the page is created for every request, users always receive the most recent information.

### Features of Server-Side Rendering

Server-Side Rendering offers several important features:

- Pages are generated on every request.

- Displays real-time or frequently updated data.

- Excellent Search Engine Optimization (SEO).

- Supports dynamic content.

- Securely accesses databases and private APIs on the server.

- Improves the initial user experience by delivering fully rendered HTML.

### Creating a Server-Side Rendered Page

In the **App Router**, pages become server-rendered when they fetch dynamic data with caching disabled. Example:

```

export default async function NewsPage() {
const res = await fetch("https://api.example.com/news", {
cache: "no-store",
});
const news = await res.json();
return (
<div>
<h1>Latest News</h1>
<p>Total Articles: {news.length}</p>
</div>
);
}

```

The `cache: "no-store"` option tells Next.js to fetch fresh data for every request, making the page server-side rendered.

### Advantages of Server-Side Rendering

### 1. Always Shows Fresh Data

Since pages are generated for each request, users always see the latest content.

### 2. Better SEO

Search engines receive fully rendered HTML pages, making it easier to crawl and index website content.

### 3. Improved User Experience

Users can view meaningful content immediately instead of waiting for JavaScript to load all data.

### 4. Secure Data Fetching

Sensitive operations such as database queries and API requests remain on the server, keeping private information secure.

### 5. Ideal for Dynamic Applications

SSR is well suited for applications where data changes frequently. Examples include:

- News websites

- Stock market dashboards

- Weather applications

- E-commerce product availability

- Sports scoreboards

### Limitations of Server-Side Rendering

Although SSR is powerful, it has some drawbacks:

- Every request requires server processing.

- Higher server resource usage than Static Site Generation (SSG).

- Slightly slower response time compared to serving pre-built static pages.

- Increased hosting costs for high-traffic websites.

### Common Use Cases

Server-Side Rendering is most appropriate for applications with frequently changing content, such as:

- E-commerce websites with live inventory

- News portals

- Financial dashboards

- Booking systems

- Social media feeds

- Personalized user dashboards

- Real-time analytics platforms

These applications benefit from always displaying current and accurate information.

### SSR vs Static Site Generation (SSG)

| Feature | Server-Side Rendering (SSR) | Static Site Generation (SSG) |
|---|---|---|
| Page Generation | On every request | During build time |
| Data Freshness | Always up to date | Fixed until rebuilt |
| Loading Speed | Fast | Very Fast |
| SEO | Excellent | Excellent |
| Server Usage | Higher | Lower |
| Best For | Dynamic content | Static content |

### Best Practices

- Use SSR only for pages that require real-time or frequently changing data.

- Keep server-side data fetching efficient to reduce response times.

- Avoid unnecessary API calls during rendering.

- Use SSG whenever content changes rarely to improve performance.

- Combine SSR with Client Components only when user interaction is needed.

### Conclusion

Server-Side Rendering (SSR) is a powerful feature of Next.js that generates web pages on the server for every user request. It ensures that visitors always receive the most up-to-date content while providing excellent SEO and improved initial page loading. Although SSR requires more server resources than Static Site Generation, it is the ideal choice for applications with dynamic, frequently changing data. By understanding when to use SSR, developers can build fast, reliable, and highly responsive web applications that deliver an exceptional user experience.');

-- Lecture 8: API Routes in Next.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'API Routes in Next.js', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# API Routes in Next.js

**API Routes** in Next.js allow developers to build **backend functionality directly inside a Next.js application**. Instead of creating a separate backend using frameworks like Express.js, developers can write server-side code within the same project to handle requests, interact with databases, authenticate users, and process data. This makes Next.js a **full-stack framework**, capable of managing both the frontend and backend in a single application. Think of a restaurant where the dining area (frontend) and the kitchen (backend) are located in the same building. Customers place their orders through the dining area, while the kitchen prepares the food and sends it back. Similarly, the frontend sends requests to API Routes, which process the requests on the server and return the appropriate responses.

### What are API Routes?

API Routes are server-side functions that respond to HTTP requests such as:

- **GET** – Retrieve data

- **POST** – Create new data

- **PUT** – Update existing data

- **PATCH** – Partially update data

- **DELETE** – Remove data

These routes run only on the server, meaning sensitive information such as API keys and database credentials remains secure.

### Creating an API Route

In the **App Router**, API Routes are created inside the `app/api` directory using a file named `route.js` (or `route.ts`). Example folder structure:

```

app/
│── api/
│ └── hello/
│ └── route.js

```

Example API Route:

```

export async function GET() {
return Response.json({
message: "Hello, Welcome to Next.js API!"
});
}

```

When the user visits: `/api/hello` The browser returns:

```

{
"message": "Hello, Welcome to Next.js API!"
}

```

### Handling Different HTTP Methods

A single API Route can handle multiple HTTP methods by exporting functions with the corresponding names.

### GET Request

Used to retrieve data.

```

export async function GET() {
return Response.json({
message: "Fetching data..."
});
}

```

### POST Request

Used to create new data.

```

export async function POST(request) {
const data = await request.json();
return Response.json({
received: data
});
}

```

### PUT Request

Used to update existing records.

```

export async function PUT() {
return Response.json({
message: "Data updated successfully."
});
}

```

### DELETE Request

Used to remove data.

```

export async function DELETE() {
return Response.json({
message: "Data deleted successfully."
});
}

```

### Accessing Request Data

API Routes can read information sent by the client. Example:

```

export async function POST(request) {
const body = await request.json();
return Response.json({
username: body.username
});
}

```

If the client sends:

```

{
"username": "John"
}

```

The API returns:

```

{
"username": "John"
}

```

### Using Dynamic API Routes

Just like pages, API Routes can also be dynamic. Folder structure:

```

app/
│── api/
│ └── users/
│ └── [id]/
│ └── route.js

```

Example:

```

export async function GET(request, { params }) {
return Response.json({
userId: params.id
});
}

```

Request: `/api/users/25` Response:

```

{
"userId": "25"
}

```

### Common Use Cases

API Routes are commonly used for:

- User authentication

- Database operations

- Contact forms

- Payment processing

- File uploads

- Sending emails

- Fetching external API data

- CRUD (Create, Read, Update, Delete) operations

### Advantages of API Routes

API Routes provide several important benefits:

- Frontend and backend in one project.

- No need for a separate Express.js server for many applications.

- Secure server-side execution.

- Easy integration with databases.

- Supports RESTful APIs.

- Simplifies deployment and maintenance.

- Reduces project complexity.

### Best Practices

- Keep sensitive data, such as API keys, on the server.

- Validate user input before processing requests.

- Return appropriate HTTP status codes.

- Handle errors using `try...catch` blocks.

- Organize API files into meaningful folders.

- Use environment variables for configuration.

Example with error handling:

```

export async function GET() {
try {
return Response.json({
message: "Success"
});
} catch (error) {
return Response.json(
{ error: "Something went wrong." },
{ status: 500 }
);
}
}

```

### API Routes vs Express.js

| Feature | Next.js API Routes | Express.js |
|---|---|---|
| Setup | Built into Next.js | Requires separate installation |
| Backend Server | Included | Separate server required |
| Routing | File-based | Manual configuration |
| Deployment | Single application | Separate frontend and backend deployment |
| Best For | Full-stack Next.js apps | Large standalone backend services |

### Conclusion

API Routes are a powerful feature of Next.js that enable developers to build server-side functionality within the same project as the frontend. They support standard HTTP methods such as **GET**, **POST**, **PUT**, **PATCH**, and **DELETE**, making it easy to create RESTful APIs for tasks like authentication, database access, form handling, and CRUD operations. By combining frontend and backend development in one framework, API Routes simplify project structure, improve security, and make Next.js an excellent choice for building modern full-stack web applications.');

-- Lecture 9: Styling in Next.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Styling in Next.js', 9, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Styling in Next.js

Styling is an essential part of web development because it determines how a website looks and feels to users. **Next.js** provides multiple ways to style applications, allowing developers to choose the method that best fits their project\'s size and requirements. Whether creating a simple webpage or a large enterprise application, Next.js offers built-in support for CSS, CSS Modules, Sass, Tailwind CSS, and CSS-in-JS solutions. Think of a website as a house. HTML provides the structure, JavaScript adds functionality, and CSS acts as the paint, furniture, and decorations that make the house attractive and comfortable. Similarly, styling transforms a plain webpage into an engaging and professional user interface.

### Why is Styling Important?

Good styling improves both the appearance and usability of a website. It helps developers:

- Create attractive user interfaces.

- Improve user experience (UX).

- Maintain consistent designs.

- Build responsive layouts.

- Enhance accessibility.

- Strengthen brand identity.

### 1. Global CSS

Global CSS applies styles across the entire application. It is commonly used for styling elements such as the body, headings, fonts, colors, and overall page layout. In the **App Router**, global styles are typically stored in a file named `globals.css`. Project structure:

```

app/
│── globals.css
│── layout.js
│── page.js

```

Example:

```

body {
margin: 0;
padding: 0;
font-family: Arial, sans-serif;
}
h1 {
color: navy;
}

```

The global stylesheet is imported in `layout.js`.

```

import "./globals.css";

```

Global CSS is ideal for website-wide styles that should be shared by all pages.

### 2. CSS Modules

**CSS Modules** provide locally scoped styles, preventing class name conflicts between components. This makes them an excellent choice for medium and large applications. Example:

```

components/
│── Button.module.css
│── Button.js

```

CSS Module:

```

.button {
background-color: blue;
color: white;
padding: 10px 20px;
}

```

Component:

```

import styles from "./Button.module.css";
export default function Button() {
return (
<button className={styles.button}>
Click Me
</button>
);
}

```

### Advantages

- Prevents style conflicts.

- Easy to maintain.

- Automatically scopes CSS to individual components.

### 3. Sass (SCSS)

Next.js supports **Sass**, a CSS preprocessor that adds powerful features such as variables, nesting, mixins, and reusable styles. Example:

```

$primary: blue;
.button {
background: $primary;
&:hover {
background: darkblue;
}
}

```

Developers typically save Sass files using the `.scss` extension.

### Benefits of Sass

- Variables for reusable values.

- Nested selectors.

- Better organization.

- Cleaner and more maintainable code.

### 4. Tailwind CSS

**Tailwind CSS** is one of the most popular styling frameworks used with Next.js. Instead of writing custom CSS, developers apply utility classes directly in HTML or JSX. Example:

```

export default function Home() {
return (
<div className="bg-blue-500 text-white p-6 rounded-lg">
Welcome to Next.js
</div>
);
}

```

### Advantages

- Rapid development.

- Minimal custom CSS.

- Responsive design utilities.

- Highly customizable.

- Excellent performance with unused CSS removed during production builds.

### 5. Inline Styles

Inline styles apply CSS directly within a component using JavaScript objects. Example:

```

export default function Home() {
return (
<h1
style={{
color: "blue",
textAlign: "center",
}}
>
Hello Next.js
</h1>
);
}

```

Inline styles are useful for simple or dynamic styling but are generally not recommended for large projects.

### 6. CSS-in-JS

Next.js also supports CSS-in-JS libraries such as **styled-components** and **Emotion**, allowing developers to write CSS directly inside JavaScript components. Example:

```

const buttonStyle = {
backgroundColor: "green",
color: "white",
padding: "12px",
};
export default function Button() {
return (
<button style={buttonStyle}>
Submit
</button>
);
}

```

CSS-in-JS is useful when styles depend on component state or props.

### Comparison of Styling Methods

| Styling Method | Scope | Best For |
|---|---|---|
| Global CSS | Entire application | Common styles and layouts |
| CSS Modules | Individual components | Component-specific styling |
| Sass (SCSS) | Global or component | Large projects with reusable styles |
| Tailwind CSS | Utility-based | Fast and responsive UI development |
| Inline Styles | Single element | Dynamic or small styling changes |
| CSS-in-JS | Component-based | Dynamic styling with JavaScript |

### Best Practices

- Use **Global CSS** for fonts, resets, and common styles.

- Prefer **CSS Modules** for reusable components.

- Use **Tailwind CSS** for rapid development and responsive layouts.

- Use **Sass** when advanced CSS features are required.

- Avoid excessive inline styles in large applications.

- Keep styling organized by grouping related files together.

### Common Folder Structure

```

app/
│── globals.css
│── layout.js
│── page.js
components/
│── Navbar.js
│── Navbar.module.css
│── Button.js
│── Button.module.css
styles/
│── variables.scss
│── mixins.scss

```

This structure keeps styles modular, organized, and easy to maintain.

### Conclusion

Styling in Next.js is flexible and developer-friendly, offering multiple approaches to designing modern web applications. Developers can choose from **Global CSS**, **CSS Modules**, **Sass**, **Tailwind CSS**, **Inline Styles**, and **CSS-in-JS**, depending on their project\'s requirements. While Global CSS is suitable for application-wide styling, CSS Modules provide scoped styles for individual components, and Tailwind CSS enables rapid UI development using utility classes. By selecting the appropriate styling method and following best practices, developers can create responsive, maintainable, and visually appealing Next.js applications.');

-- Lecture 10: Image & Font Optimization in Next.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Image & Font Optimization in Next.js', 10, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Image & Font Optimization

Modern websites rely heavily on images and fonts to create visually appealing user interfaces. However, large image files and unoptimized fonts can slow down page loading, negatively affecting user experience and Search Engine Optimization (SEO). **Next.js** provides built-in **Image Optimization** and **Font Optimization** features that automatically improve website performance without requiring complex configurations. Think of a website as a delivery service. If packages (images and fonts) are too large, delivery takes longer. Next.js acts like a smart delivery system, compressing packages and sending only what is needed, ensuring users receive content quickly and efficiently.

### Why Image & Font Optimization is Important

Optimizing images and fonts provides several benefits:

- Faster page loading.

- Better website performance.

- Improved Core Web Vitals.

- Enhanced Search Engine Optimization (SEO).

- Reduced bandwidth usage.

- Better user experience across different devices.

### Image Optimization in Next.js

Next.js provides a built-in `Image` component through the `next/image` package. Unlike the standard HTML `<img>` tag, the `Image` component automatically optimizes images for better performance. **Benefits of the** `Image` **Component**

- Automatic image compression.

- Responsive image resizing.

- Lazy loading by default.

- Modern image format support (such as WebP).

- Reduced layout shifts.

- Faster loading times.

### Using the Component

`Image` First, import the component:

```

import Image from "next/image";

```

Example:

```

import Image from "next/image";
export default function Home() {
return (
<Image
src="/profile.jpg"
alt="Profile Picture"
width={300}
height={300}
/>
);
}

```

In this example:

- `src` specifies the image location.

- `alt` provides alternative text for accessibility.

- `width` and `height` define the image dimensions, helping prevent layout shifts.

### Loading Images from External Sources

Next.js also supports loading images from external websites. Example:

```

import Image from "next/image";
export default function Home() {
return (
<Image
src="https://example.com/photo.jpg"
alt="External Image"
width={600}
height={400}
/>
);
}

```

To use external images, their domains must be added to the `next.config.js` file. Example:

```

module.exports = {
images: {
domains: ["example.com"],
},
};

```

### Lazy Loading

The `Image` component automatically uses **lazy loading**, meaning images are loaded only when they are about to appear on the screen.

### Advantages

- Faster initial page load.

- Reduced network usage.

- Improved website performance.

- Better user experience.

### Font Optimization in Next.js

Fonts also affect website performance. Downloading large font files can delay page rendering. Next.js includes the `next/font` package, which automatically optimizes fonts by self-hosting them and reducing unnecessary network requests.

### Benefits of Font Optimization

- Faster font loading.

- Reduced layout shifts.

- Improved Core Web Vitals.

- Better performance.

- No external font requests.

### Using Google Fonts

Next.js makes it easy to use Google Fonts through the `next/font/google` package. Example:

```

import { Roboto } from "next/font/google";
const roboto = Roboto({
subsets: ["latin"],
weight: ["400", "700"],
});
export default function Home() {
return (
<main className={roboto.className}>
<h1>Welcome to Next.js</h1>
</main>
);
}

```

The font is automatically optimized and loaded efficiently.

### Using Local Fonts

Developers can also use fonts stored inside their project. Example:

```

import localFont from "next/font/local";
const myFont = localFont({
src: "./fonts/MyFont.woff2",
});
export default function Home() {
return (
<main className={myFont.className}>
<h1>Local Font Example</h1>
</main>
);
}

```

This approach gives complete control over custom fonts while maintaining optimization.

### Advantages of Image & Font Optimization

Image and font optimization offers many advantages:

- Faster website loading.

- Better Search Engine Optimization (SEO).

- Improved Core Web Vitals.

- Reduced bandwidth consumption.

- Enhanced accessibility.

- Better performance on mobile devices.

- Improved user satisfaction.

### Best Practices

- Use the `Image` component instead of the HTML `<img>` tag.

- Always provide meaningful `alt` text for images.

- Specify image `width` and `height`.

- Compress large images before adding them to the project.

- Use modern formats such as WebP whenever possible.

- Use the `next/font` package instead of manually importing fonts.

- Load only the required font weights and subsets.

- Store frequently used images inside the `public` folder.

### Image Optimization vs Standard HTML Images

| Feature | HTML <img> | Next.js Image Component |
|---|---|---|
| Automatic Optimization | No | Yes |
| Lazy Loading | Manual | Built-in |
| Responsive Images | Manual | Automatic |
| Layout Shift Prevention | No | Yes |
| Performance | Good | Excellent |

### Google Fonts vs

`next/font`

| Feature | Traditional Google Fonts | next/font |
|---|---|---|
| External Requests | Yes | No |
| Self-Hosted | No | Yes |
| Performance | Good | Excellent |
| Layout Shift | Possible | Minimized |
| Optimization | Limited | Automatic |

### Conclusion

Image and Font Optimization are essential features of Next.js that help developers build fast, responsive, and high-performance web applications. The `next/image` component automatically optimizes images through resizing, compression, responsive loading, and lazy loading, while the `next/font` package optimizes both Google and local fonts by self-hosting them and reducing unnecessary network requests. By using these built-in optimization tools and following best practices, developers can significantly improve website speed, user experience, SEO, and overall application performance.');

-- Lecture 11: Middleware & Authentication in Next.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Middleware & Authentication in Next.js', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Middleware & Authentication in Next.js

Modern web applications often need to **protect sensitive pages**, verify user identity, and control access to resources. **Next.js** provides **Middleware** and **Authentication** features to help developers secure applications efficiently. Middleware allows code to run before a request reaches a page or API route, while Authentication verifies whether a user is authorized to access protected content. Think of a shopping mall with a security guard at the entrance. Before anyone enters, the guard checks whether they have permission to access certain areas. Similarly, Middleware checks incoming requests before they reach the application, while Authentication confirms the user\'s identity.

### What is Middleware?

**Middleware** is a special function that runs **before a request is completed**. It intercepts incoming requests and can modify, redirect, block, or allow them based on specific conditions. Middleware is commonly used for:

- Authentication

- Authorization

- Redirecting users

- Logging requests

- URL rewriting

- Internationalization (i18n)

- Security checks

In Next.js, Middleware is created using a file named `middleware.js` (or `middleware.ts`) in the project\'s root directory. Project structure:

```

my-app/
│── app/
│── public/
│── middleware.js
│── package.json

```

### Creating Middleware

Example:

```

import { NextResponse } from "next/server";
export function middleware(request) {
return NextResponse.next();
}

```

Here:

- `request` contains information about the incoming request.

- NextResponse.next `()` allows the request to continue to its destination.

### Redirecting Users with Middleware

Middleware can redirect users to another page. Example:

```

import { NextResponse } from "next/server";
export function middleware(request) {
return NextResponse.redirect(
new URL("/login", request.url)
);
}

```

When a user visits a protected page, they are automatically redirected to the login page. Middleware can run only for selected routes using the **matcher** configuration. Example:

```

export const config = {
matcher: ["/dashboard/:path*"],
};

```

This means Middleware executes only for routes inside:

```

/dashboard
/dashboard/profile
/dashboard/settings

```

Other pages remain unaffected.

### What is Authentication?

**Authentication** is the process of verifying a user\'s identity before granting access to an application or its resources. Common authentication methods include:

- Username and Password

- Email and Password

- One-Time Password (OTP)

- Social Login (Google, GitHub, Facebook)

- JSON Web Tokens (JWT)

- OAuth Authentication

Authentication ensures that only valid users can access protected features.

### How Authentication Works

A typical authentication process follows these steps: 1. The user enters login credentials. 2. The server verifies the information. 3. If valid, the server creates a session or token. 4. The user receives access to protected pages. 5. Middleware checks the session or token for future requests. This process keeps applications secure while providing a smooth user experience.

### Checking Authentication in Middleware

Middleware can verify whether a user is logged in before allowing access. Example:

```

import { NextResponse } from "next/server";
export function middleware(request) {
const token = request.cookies.get("token");
if (!token) {
return NextResponse.redirect(
new URL("/login", request.url)
);
}
return NextResponse.next();
}

```

If the authentication token is missing, the user is redirected to the login page.

### Authentication Methods in Next.js

Next.js supports several authentication approaches:

### 1. Session-Based Authentication

- Stores user sessions on the server.

- Suitable for traditional web applications.

- Secure but requires session management.

### 2. JWT (JSON Web Token)

- Stores authentication information inside a signed token.

- Widely used in REST APIs.

- Scalable and stateless.

### 3. OAuth Authentication

Allows users to sign in using third-party providers such as:

- Google

- GitHub

- Facebook

- Microsoft

This eliminates the need for users to create separate accounts.

### 4. NextAuth.js (Auth.js)

One of the most popular authentication libraries for Next.js. Features include:

- Social login support

- Email authentication

- JWT support

- Session management

- Database integration

It simplifies authentication for most Next.js applications.

### Advantages of Middleware & Authentication

Using Middleware and Authentication provides several benefits:

- Protects sensitive pages.

- Restricts unauthorized access.

- Improves application security.

- Supports role-based access control.

- Simplifies request handling.

- Enhances user experience with automatic redirects.

### Best Practices

- Protect sensitive routes using Middleware.

- Store sensitive information securely using HTTP-only cookies.

- Validate authentication tokens on every protected request.

- Never expose secret keys on the client side.

- Use HTTPS to encrypt user data.

- Prefer trusted authentication libraries such as NextAuth.js (Auth.js) for production applications.

- Implement proper error handling and logout functionality.

### Middleware vs Authentication

| Feature | Middleware | Authentication |
|---|---|---|
| Purpose | Intercepts requests | Verifies user identity |
| Runs When | Before every matched request | During login and protected requests |
| Main Use | Redirects, security, routing | User verification |
| Can Protect Routes | Yes | Yes |
| Checks User Identity | No (unless implemented) | Yes |

### Common Use Cases

Middleware and Authentication are widely used in:

- Admin dashboards

- Banking applications

- E-commerce websites

- Learning Management Systems (LMS)

- Social media platforms

- Healthcare applications

- Employee portals

- SaaS applications

These applications require secure access to user-specific data and protected resources.

### Conclusion

Middleware and Authentication are essential security features in Next.js that help developers build safe and reliable web applications. **Middleware** intercepts requests before they reach pages or API routes, enabling tasks such as redirection, route protection, and request handling. **Authentication** verifies user identity through methods such as sessions, JWTs, OAuth, or authentication libraries like **NextAuth.js (Auth.js)**. By combining Middleware with Authentication and following security best practices, developers can protect sensitive data, control user access, and create secure, scalable, and user-friendly Next.js applications.');

-- Lecture 12: Deployment in Next.js
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Deployment in Next.js', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Deployment in Next.js

After developing and testing a Next.js application, the final step is **deployment**. **Deployment** is the process of publishing a web application from a local development environment to a live server so that users around the world can access it through the internet. Next.js makes deployment simple by supporting various hosting platforms, with **Vercel** being the official and most recommended platform. Think of building a website like writing a book. While developing, the book stays on your computer where only you can read it. Deployment is like publishing the book, making it available for everyone to access and enjoy.

### Why is Deployment Important?

Deployment is essential because it:

- Makes the application accessible online.

- Allows users to interact with the website.

- Improves collaboration and testing.

- Supports continuous updates.

- Enables businesses to launch products and services.

Without deployment, a website remains available only on the developer\'s local machine.

### Preparing a Next.js Application for Deployment

Before deploying, developers should ensure that the application is production-ready.

### Checklist

- Fix all errors and warnings.

- Test every page and feature.

- Optimize images and fonts.

- Configure environment variables.

- Remove unnecessary files.

- Build the application successfully.

### Building the Application

Next.js creates an optimized production build using the following command: `npm run build` This command:

- Compiles the project.

- Optimizes JavaScript and CSS.

- Generates production-ready files.

- Detects build-time errors.

If the build completes successfully, the application is ready for deployment.

### Running the Production Server

After building the application, start the production server using: `npm start` This serves the optimized version of the application instead of the development version.

### Deploying with Vercel

**Vercel** is the official hosting platform for Next.js and provides seamless deployment with minimal configuration.

### Deployment Steps

1. Push the Next.js project to GitHub. 2. Sign in to the Vercel dashboard. 3. Import the GitHub repository. 4. Configure project settings if needed. 5. Click **Deploy**. 6. Vercel automatically builds and publishes the application. Whenever new changes are pushed to GitHub, Vercel automatically redeploys the application.

### Advantages of Vercel

- One-click deployment.

- Automatic deployments from GitHub.

- Built-in CDN for fast content delivery.

- Automatic HTTPS.

- Image optimization support.

- Excellent performance.

- Easy rollback to previous deployments.

### Deploying to Other Platforms

Although Vercel is recommended, Next.js applications can also be deployed to other hosting providers, including:

- Netlify

- AWS (Amazon Web Services)

- Microsoft Azure

- Google Cloud Platform (GCP)

- DigitalOcean

- Railway

- Render

The deployment process is similar: build the application, configure the hosting environment, and publish the project.

### Environment Variables

Applications often require sensitive information such as:

- API keys

- Database credentials

- Authentication secrets

Instead of writing these values directly into the code, developers use **environment variables**. Example:

```

.env.local
API_KEY=your_api_key
DATABASE_URL=your_database_url

```

These variables are securely accessed during runtime without exposing sensitive information.

### Production Best Practices

To ensure a successful deployment:

- Build the project before deployment.

- Store secrets using environment variables.

- Enable HTTPS for secure communication.

- Optimize images using the `next/image` component.

- Optimize fonts using the `next/font` package.

- Test the production build before publishing.

- Monitor application performance and errors.

### Common Deployment Commands

| Command | Purpose |
|---|---|
| npm install | Install project dependencies |
| npm run dev | Start the development server |
| npm run build | Create the production build |
| npm start | Run the production server |

### Common Deployment Workflow

```

Develop Application
│
▼
Test Features
│
▼
Run npm run build
│
▼
Push Code to GitHub
│
▼
Deploy to Vercel or Another Platform
│
▼
Application Goes Live

```

### Advantages of Deploying with Next.js

Deploying a Next.js application provides several benefits:

- Fast and optimized performance.

- Global content delivery through CDNs.

- Automatic HTTPS support.

- Easy scalability.

- Continuous deployment from GitHub.

- Improved SEO and user experience.

- Simplified maintenance and updates.

### Common Deployment Issues

Developers may encounter the following problems during deployment:

- Missing environment variables.

- Build failures due to coding errors.

- Incorrect API endpoints.

- Missing dependencies.

- Unsupported Node.js versions.

Testing the application locally with the production build helps identify and fix these issues before deployment.

### Conclusion

Deployment is the final stage of the Next.js development process, where an application is made available to users on the internet. Next.js simplifies deployment by providing optimized production builds and seamless integration with hosting platforms such as **Vercel**, while also supporting many other cloud providers. By following best practices—such as testing the application, optimizing assets, using environment variables, and monitoring performance—developers can ensure that their applications are secure, reliable, scalable, and ready for real-world use.');

-- Lecture 13: Building a Full Next.js Application
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a Full Next.js Application', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a Full Next.js Application

## Introduction to Building a Complete Next.js Application

Building a full Next.js application means combining all the concepts we have learned so far into one complete, production-ready project. Instead of creating isolated pages or small examples, we bring together routing, components, data fetching, APIs, authentication, databases, styling, optimization, and deployment. Next.js is a powerful React framework designed to help developers build modern web applications faster. Think of React as the engine of a car, while Next.js is the complete vehicle that provides structure, speed, and additional features. React helps us create user interfaces, but Next.js gives us the tools needed to build complete applications used by real businesses. A full Next.js application usually contains multiple layers:

- **Frontend Layer:** User interfaces, pages, components, and user interactions.

- **Backend Layer:** APIs, server-side logic, and data processing.

- **Database Layer:** Storage and management of application data.

- **Authentication Layer:** User registration, login, and security.

- **Deployment Layer:** Making the application available online.

When we build a complete application, we are not just writing code. We are designing an experience for users. Every button, page, API request, and database interaction works together like parts of a machine.

## Planning and Setting Up a Next.js Project

### Project Planning Before Coding

Before writing code, we should clearly understand what we want to build. Professional developers rarely start coding immediately because poor planning creates unnecessary problems later. For example, if we are building an e-commerce application, we should first identify:

- What pages are required?

- What features will users need?

- What data should be stored?

- How will users interact with the system?

- What technologies will support the application?

A simple project structure might include:

- Home page

- Product listing page

- Product details page

- User dashboard

- Authentication pages

- Admin panel

- API routes

Planning works like creating a building blueprint. A construction team does not build a house without a design, and developers should not build applications without proper planning.

### Creating a Next.js Application

We can create a new Next.js project using the official command:

```

npx create-next-app@latest my-app

```

During setup, Next.js asks several questions:

- TypeScript or JavaScript?

- Use Tailwind CSS?

- Use App Router?

- Enable ESLint?

- Use a source directory?

For modern applications, developers commonly choose:

- TypeScript for better code safety

- App Router for modern routing

- Tailwind CSS for styling

- ESLint for code quality

After installation, we enter the project folder: `cd my-app` Then we start the development server: `npm run dev` The application becomes available at: `http://localhost:3000`

## Structuring a Full Next.js Application

### Understanding Project Architecture

A well-organized project is easier to maintain, update, and scale. In professional development, folder structure matters because applications can grow from a few files into thousands of files. A typical Next.js structure looks like:

```

my-app/
│
├── app/
│ ├── page.jsx
│ ├── layout.jsx
│ ├── dashboard/
│ └── api/
│
├── components/
│ ├── Navbar.jsx
│ ├── Button.jsx
│ └── Card.jsx
│
├── lib/
│ └── database.js
│
├── public/
│
├── styles/
│
├── package.json
└── next.config.js

```

Each folder has a specific responsibility.

### App Folder

The `app` folder controls application routes. Example: `app/about/page.jsx` creates: `website.com/about` Next.js automatically converts folders into routes.

### Creating Reusable Components

A professional application should avoid repeating code. Instead of writing the same button or navigation menu multiple times, we create reusable components. Example:

```

function Button({text}) {
return (
<button>
{text}
</button>
);
}
export default Button;

```

Now we can use this component anywhere:

```

<Button text="Login" />
<Button text="Register" />

```

Reusable components improve:

- Development speed

- Code organization

- Maintenance

- Consistency

Components are like building blocks. Instead of creating every wall from scratch, we use prepared blocks to build faster.

## Adding Functionality to a Full Next.js Application

### Implementing Data Management

Most applications need data. A social media platform stores users and posts. An online store stores products and orders. A learning platform stores courses and progress. Next.js allows us to work with different databases, including:

- MongoDB

- PostgreSQL

- MySQL

- Firebase

A common approach is creating a database connection inside a utility file. Example:

```

import mongoose from "mongoose";
export async function connectDB(){
await mongoose.connect(process.env.MONGO_URL);
}

```

The database connection allows our application to communicate with stored information.

### Building API Routes

A full-stack application requires communication between frontend and backend. Next.js provides API routes that allow us to create backend functionality inside the same project. Example: `app/api/users/route.js` A simple API:

```

export async function GET(){
return Response.json({
message:"Users fetched successfully"
});
}

```

The frontend can request data: `fetch("/api/users")` API routes help us:

- Create users

- Save information

- Retrieve data

- Process requests

### Authentication and User Management

Authentication allows users to create accounts and access private features. A complete authentication system includes:

- Registration

- Login

- Password security

- Sessions

- Protected pages

- User permissions

Popular authentication solutions include:

- NextAuth.js

- Clerk

- Firebase Authentication

Example authentication flow: 1. User enters email and password. 2. Server verifies credentials. 3. Server creates a session. 4. User receives access to protected content. Security is a major part of application development. A beautiful application without security is like a house with expensive furniture but no doors.

### Styling the Application

Next.js supports multiple styling methods:

### CSS Modules

Example:

```

import styles from "./button.module.css";
<button className={styles.button}>
Click
</button>

```

### Tailwind CSS

Example:

```

<button className="bg-blue-500 text-white px-4 py-2">
Click
</button>

```

Tailwind CSS is popular because it allows developers to build interfaces quickly while maintaining consistency.

## Advanced Features and Deploying a Next.js Application

### Performance Optimization

Modern applications must be fast. Users expect websites to load instantly. Next.js provides several optimization features:

### Image Optimization

Instead of using normal images: `<img src="image.jpg"/>` Next.js provides:

```

import Image from "next/image";
<Image
src="/image.jpg"
width={500}
/>

```

This automatically optimizes images for better performance.

### Server-Side Rendering

Next.js can generate pages on the server before sending them to users. Benefits include:

- Faster loading

- Better SEO

- Improved user experience

For example, a news website benefits from server rendering because search engines can easily read the content.

### Handling Environment Variables

Applications often contain sensitive information:

- Database URLs

- API keys

- Authentication secrets

We store these values inside: `.env.local` Example:

```

DATABASE_URL=my_database_connection
API_KEY=my_secret_key

```

This keeps important information secure.

### Testing and Improving the Application

Before deployment, developers test applications carefully. Testing includes: **Functional Testing** Checking whether features work correctly. Example:

- Login works

- Forms submit correctly

- Data saves properly

**Performance Testing** Checking:

- Loading speed

- Server response time

- Resource usage

**Security Testing** Checking:

- Authentication problems

- Data protection

- Vulnerabilities

A professional application is not finished when it works. It is finished when it works reliably.

### Deploying a Next.js Application

After development, we need to make the application available online. Popular deployment platforms include:

- Vercel

- Netlify

- AWS

- DigitalOcean

The most common platform for Next.js is Vercel because it was created by the same company behind Next.js. Deployment steps usually include: 1. Push code to GitHub. 2. Connect repository to hosting platform. 3. Add environment variables. 4. Build the project. 5. Deploy the application. After deployment, users can access the application through a public URL.

## Building Real-World Applications with Next.js

A complete Next.js application combines many technologies and concepts together. Examples of real-world applications built with Next.js include:

- SaaS platforms

- E-commerce websites

- Social networks

- Learning management systems

- Dashboards

- Portfolio websites

A typical modern stack might include: **Frontend:**

- Next.js

- React

- Tailwind CSS

- TypeScript

**Backend:**

- Next.js API Routes

- Node.js services

**Database:**

- MongoDB

- PostgreSQL

**Authentication:**

- NextAuth.js

- Clerk

**Deployment:**

- Vercel

The power of Next.js comes from its ability to handle both frontend and backend development in one framework. Developers can build complete applications without managing multiple separate projects.

### Conclusion

Building a full Next.js application requires understanding how different parts of web development connect together. We combine components, routing, APIs, databases, authentication, styling, optimization, and deployment to create powerful digital products. Next.js provides a complete environment where developers can transform ideas into real-world applications. The framework removes many complex problems and allows us to focus on creating better user experiences. Learning to build full applications with Next.js is not just about learning a framework. It is about developing the mindset of a professional developer who can plan, create, optimize, and deliver complete solutions. With practice and continuous improvement, we can use Next.js to build applications that are fast, scalable, and ready for the modern web.');
