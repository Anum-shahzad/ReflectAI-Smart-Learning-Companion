-- =============================================
-- ReflectAI — Django Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'Django' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to Django
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to Django', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to Django

## What is Django?

**Django** is a **high-level, open-source Python web framework** used to build secure, scalable, and maintainable web applications quickly. It follows the principle of **"Don\'t Repeat Yourself (DRY)"**, which encourages developers to write reusable and efficient code. Django was created to simplify web development by providing many built-in features, such as user authentication, database management, URL routing, security, and an admin panel. Instead of building everything from scratch, developers can focus on creating the application\'s unique features. Think of Django as a fully equipped toolbox. Instead of buying every tool separately, you get everything needed to build a complete web application in one package.

## Features of Django

Django is one of the most popular Python frameworks because of its powerful built-in features.

### 1. Fast Development

Django provides many built-in components, allowing developers to build applications quickly with less code.

### 2. Open Source

Django is free to use and supported by a large developer community.

### 3. Secure

Django includes protection against many common web attacks, such as:

- SQL Injection

- Cross-Site Scripting (XSS)

- Cross-Site Request Forgery (CSRF)

- Clickjacking

### 4. Scalable

Django can handle both small projects and large applications with millions of users.

### 5. Built-in Admin Panel

One of Django\'s most powerful features is its automatic admin interface, which allows developers to manage application data without writing additional code.

### 6. ORM (Object-Relational Mapping)

Django uses an ORM that allows developers to work with databases using Python code instead of writing SQL queries. Example: `Student.objects.all()` instead of:

```

SELECT * FROM students;

```

### 7. URL Routing

Django provides a clean way to map URLs to specific views. Example: `path("home/", views.home)`

## Django Architecture (MVT Pattern)

Django follows the **MVT (Model-View-Template)** architecture.

### 1. Model

The **Model** manages the application\'s data and communicates with the database. Example:

```

from django.db import models
class Student(models.Model):
name = models.CharField(max_length=100)
age = models.IntegerField()

```

The model defines the structure of the database table.

### 2. View

A **View** contains the application\'s business logic. It receives requests, processes data, and returns responses. Example:

```

from django.http import HttpResponse
def home(request):
return HttpResponse("Welcome to Django")

```

### 3. Template

Templates are HTML files that display data to users. Example: `<h1>Welcome to Django</h1>` Templates separate the user interface from application logic.

### How MVT Works

1. User sends a request. 2. URL routes the request to a View. 3. The View interacts with the Model. 4. The Model retrieves or stores data. 5. The View sends data to a Template. 6. The Template generates the HTML page. 7. The browser displays the response.

## Installing and Creating a Django Project

### Step 1: Install Python

Before installing Django, Python must already be installed. Check the version: `python --version`

### Step 2: Install Django

Use pip to install Django. `pip install django` Verify installation: `django-admin --version`

### Step 3: Create a New Django Project

A folder named **myproject** is created.

### Step 4: Move into the Project

`cd myproject`

### Step 5: Run the Development Server

`python manage.py runserver` By default, Django runs on: `http://127.0.0.1:8000/` Opening this URL in a browser displays Django\'s welcome page.

### Project Structure

```

myproject/
│── manage.py
└── myproject/
│── __init__.py
│── settings.py
│── urls.py
│── asgi.py
│── wsgi.py

```

### Important Files

File Purpose Manages Django manage.py commands settings.py Project configuration urls.py URL routing Deployment wsgi.py configuration Asynchronous asgi.py deployment support

## Creating the First Django App

A Django project can contain multiple applications. Create an app:

```

python manage.py startapp students

```

Project structure becomes:

```

students/
│── admin.py
│── apps.py
│── models.py
│── tests.py
│── views.py

```

### Create a View

Open **views.py**

```

from django.http import HttpResponse
def home(request):
return HttpResponse("Hello Django")

```

### Configure URL

Create **students/urls.py**

```

from django.urls import path
from . import views
urlpatterns = [
path("", views.home)
]

```

Include the app URLs in the main **urls.py**

```

from django.urls import include, path
urlpatterns = [
path("", include("students.urls"))
]

```

Now visiting: `http://127.0.0.1:8000/` will display: `Hello Django`

## Advantages, Limitations, and Best Practices

### Advantages of Django

- Fast web development.

- Built-in authentication system.

- Powerful ORM for database management.

- Secure by default.

- Automatic admin interface.

- Excellent documentation.

- Highly scalable.

- Large and active community.

### Limitations of Django

- Can be heavy for very small projects.

- Learning curve for beginners.

- Less flexible than lightweight frameworks like Flask.

- Some built-in features may not be needed for simple applications.

### Best Practices

### 1. Keep Apps Modular

Divide large projects into smaller apps such as:

- Users

- Students

- Products

- Orders

### 2. Use Virtual Environments

Create an isolated environment for project dependencies. `python -m venv venv` Activate it before installing packages.

### 3. Store Sensitive Information Securely

Never hardcode:

- Secret keys

- Database passwords

- API keys

Use environment variables instead.

### 4. Follow Django Naming Conventions

Use meaningful names for:

- Apps

- Models

- Views

- Templates

- URLs

This improves readability and maintenance.

### 5. Keep Django Updated

Update Django regularly to receive security patches, bug fixes, and new features. `pip install --upgrade django`

## Common Mistakes

**1. Forgetting to Add an App to** `INSTALLED_APPS` After creating an app, it must be added to `INSTALLED_APPS` in settings.py. Otherwise, Django will not recognize it.

### 2. Not Running the Development Server

Creating a project alone is not enough. Run: `python manage.py runserver` to start the application.

### 3. Incorrect URL Configuration

If URLs are not properly configured in urls.py, users may receive a **404 Not Found** error.

### 4. Editing Generated Files Incorrectly

Files such as settings.py and urls.py should be modified carefully, as incorrect changes can prevent the project from running.

### 5. Ignoring Virtual Environments

Installing packages globally can create version conflicts between projects. Always use a virtual environment for better dependency management.

### Conclusion

Django is a powerful, secure, and high-level Python web framework that simplifies the development of modern web applications. Its MVT architecture, built-in ORM, authentication system, automatic admin panel, URL routing, and strong security features enable developers to create scalable and maintainable applications with minimal effort. By understanding Django\'s project structure, creating applications, configuring URLs, and following best practices such as modular development, virtual environments, and secure configuration management, developers can build professional web applications efficiently and prepare for more advanced Django concepts.');

-- Lecture 2: Django Project & App Structure
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Django Project & App Structure', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Django Project & App Structure

## Understanding Django Project and App

When developing a web application in Django, it is important to understand the difference between a **Project** and an **App**. These two components form the foundation of every Django application. A **Project** is the complete web application that contains all the settings and configurations. An **App** is a smaller module inside the project that performs a specific task or feature. Think of a **Project** as a university and each **App** as a department. The university manages everything, while each department focuses on a specific responsibility such as admissions, library, or examinations. For example, an online university management system may have:

- Student App

- Teacher App

- Course App

- Attendance App

- Library App

All these apps work together inside one Django project.

## Creating a Django Project

### Step 1: Create a New Project

Use the following command:

```

django-admin startproject myproject

```

A new project named **myproject** will be created.

### Step 2: Navigate to the Project

`cd myproject`

### Step 3: Run the Development Server

`python manage.py runserver` The default URL is: `http://127.0.0.1:8000/` If the installation is successful, Django displays its welcome page.

### Project Structure

```

myproject/
│── manage.py
└── myproject/
│── __init__.py
│── settings.py
│── urls.py
│── asgi.py
│── wsgi.py

```

### Explanation of Project Files

### 1. manage.py

This file is used to manage the Django project. Examples:

```

python manage.py runserver
python manage.py migrate
python manage.py createsuperuser

```

### 2. init.py

This file tells Python that the folder should be treated as a Python package. Normally, developers do not modify this file.

### 3. settings.py

This is one of the most important files. It contains:

- Installed Apps

- Database configuration

- Secret Key

- Middleware

- Static files

- Templates

- Language

- Time Zone

Example:

```

INSTALLED_APPS = [
"django.contrib.admin",
"django.contrib.auth",
]

```

### 4. urls.py

This file maps URLs to views. Example:

```

from django.urls import path
urlpatterns = [
path("", home),
]

```

### 5. wsgi.py

Used for deploying Django applications on production web servers. Most beginners rarely modify this file.

### 6. asgi.py

Supports asynchronous applications such as WebSockets and asynchronous communication.

## Creating a Django App

A Django project may contain one or many apps. Create a new app:

```

python manage.py startapp students

```

This creates a folder named **students**.

### App Structure

```

students/
│── migrations/
│── __init__.py
│── admin.py
│── apps.py
│── models.py
│── tests.py
│── views.py

```

### Explanation of App Files

### 1. migrations/

Stores database migration files. Example command:

```

python manage.py makemigrations

```

### 2. admin.py

Registers models so they appear in the Django Admin Panel. Example:

```

from django.contrib import admin
from .models import Student
admin.site.register(Student)

```

### 3. apps.py

Contains the configuration for the Django application. Usually generated automatically. Example:

```

from django.apps import AppConfig
class StudentsConfig(AppConfig):
default_auto_field = "django.db.models.BigAutoField"
name = "students"

```

### 4. models.py

Defines database tables. Example:

```

from django.db import models
class Student(models.Model):
name = models.CharField(max_length=100)
age = models.IntegerField()

```

### 5. tests.py

Contains unit tests for the application. Example:

```

from django.test import TestCase

```

Developers write test cases here.

### 6. views.py

Contains business logic. Example:

```

from django.http import HttpResponse
def home(request):
return HttpResponse("Welcome")

```

## Connecting an App to the Project

Creating an app is not enough. It must be connected to the project.

### Step 1: Register the App

Open **settings.py** Add the app name.

```

INSTALLED_APPS = [
"students",
]

```

Without this step, Django will not recognize the app.

### Step 2: Create URLs

Create:

```

students/urls.py
from django.urls import path
from . import views
urlpatterns = [
path("", views.home)
]

```

### Step 3: Connect App URLs

Open: `myproject/urls.py` Example:

```

from django.urls import include, path
urlpatterns = [
path("", include("students.urls"))
]

```

### Step 4: Create a View

Inside:

```

views.py
from django.http import HttpResponse
def home(request):
return HttpResponse("Hello Django")

```

Now visiting `http://127.0.0.1:8000/` displays `Hello Django`

## Working Flow of a Django Project

The complete flow is: 1. User enters a URL in the browser. 2. Django checks urls.py. 3. The URL is matched with a View. 4. The View performs the required logic. 5. If needed, the View communicates with the Model. 6. The Model interacts with the database. 7. The View returns a Template or HTTP response. 8. The browser displays the result.

### Simple Diagram

```

Browser
↓
URL
↓
urls.py
↓
View
↓
Model
↓
Database
↓
View
↓
Template
↓
Browser

```

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Keep Apps Small and Focused

Each app should perform one specific function. Examples:

- Students

- Teachers

- Courses

- Payments

### 2. Use Meaningful Names

Use clear names for:

- Projects

- Apps

- Models

- Views

- URLs

This improves readability and maintenance.

### 3. Register Every App

Always add new apps to: `INSTALLED_APPS` Otherwise, Django will ignore them.

### 4. Organize URLs

Keep each app\'s URLs inside its own urls.py file instead of placing all routes in the project\'s main urls.py.

### 5. Separate Logic Properly

- Models → Database

- Views → Business Logic

- Templates → User Interface

- URLs → Routing

This makes the application modular and easier to maintain.

### Advantages of Django\'s Structure

- Modular development.

- Easy maintenance.

- Code reusability.

- Better organization.

- Supports teamwork.

- Easy debugging.

- Scalable architecture.

### Common Mistakes

**1. Forgetting to Add the App to** `INSTALLED_APPS` The app will not work until it is registered in settings.py.

### 2. Not Creating urls.py Inside the App

Without URL routing, Django cannot direct requests to the appropriate views.

### 3. Mixing Business Logic with Templates

Business logic should remain inside **views.py**, while templates should only handle presentation.

### 4. Keeping Everything in One App

Large projects should be divided into multiple apps instead of placing all functionality into a single app.

### 5. Ignoring Project Organization

Using meaningful folder structures and separating responsibilities makes applications easier to maintain, debug, and scale.

### Conclusion

The Django Project and App Structure provides a clean, modular, and organized way to build web applications. A **Project** manages the overall application, while **Apps** divide functionality into reusable modules. Understanding the purpose of important files such as manage.py, settings.py, urls.py, models.py, views.py, and admin.py, along with properly registering apps and organizing URLs, enables developers to create scalable and maintainable Django applications. By following Django\'s recommended structure and best practices, developers can efficiently build professional web applications that are easy to manage and extend.');

-- Lecture 3: Models & Migrations in Django
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Models & Migrations in Django', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Models & Migrations in Django

## Understanding Models

A **Model** is one of the most important components in Django. It represents the structure of the data stored in the database. Every model is mapped to a database table, and every object (record) of that model represents a row in that table. Instead of writing SQL queries manually, Django allows us to define database tables using Python classes. Django automatically creates the corresponding tables in the database. Think of a model as a blueprint for building a house. The blueprint defines what the house will look like, and the database table is the actual house built from that blueprint.

### What is a Model?

A **Model** is a Python class that inherits from `models.Model`. Example:

```

from django.db import models
class Student(models.Model):
name = models.CharField(max_length=100)
age = models.IntegerField()
department = models.CharField(max_length=100)

```

In this example:

- `Student` is the model.

- Django creates a **Student** table in the database.

- Each attribute becomes a column in the table.

### How Models Work

Flow of a model:

```

Python Model
↓
Django ORM
↓
Database Table
↓
Stored Data

```

The Django ORM automatically converts Python code into SQL queries.

## Model Fields

Each attribute inside a model is called a **Field**. Fields define the type of data stored in the database.

### Common Field Types

Field Description `CharField` Stores short text `TextField` Stores long text `IntegerField` Stores whole numbers `FloatField` Stores decimal numbers `BooleanField` Stores True or False `DateField` Stores dates `DateTimeField` Stores date and time `EmailField` Stores email addresses `ImageField` Stores image paths `FileField` Stores file paths

### Example Model

```

from django.db import models
class Student(models.Model):
name = models.CharField(max_length=100)
age = models.IntegerField()
email = models.EmailField()
department = models.CharField(max_length=100)
is_active = models.BooleanField(default=True)

```

This creates a table containing:

- Name

- Age

- Email

- Department

- Active Status

### Field Options

Fields can include additional options. Example:

```

name = models.CharField(
max_length=100,
unique=True
)

```

Common options: Option Purpose `max_length` Maximum characters `default` Default value `null=True` Allows NULL in database `blank=True` Allows empty form values `unique=True` Prevents duplicate values

## Understanding Migrations

### What is a Migration?

A **Migration** is Django\'s way of updating the database whenever models change. Instead of manually creating or modifying tables using SQL, Django automatically generates migration files. Think of migrations as construction instructions. If the blueprint (model) changes, migrations update the building (database) accordingly.

### Why are Migrations Needed?

Whenever you:

- Create a new model

- Add a field

- Remove a field

- Rename a field

- Change a field type

the database must also be updated. Migrations keep the database synchronized with the models.

### Creating Migrations

After creating or modifying a model, run:

```

python manage.py makemigrations

```

Example Output:

```

Migrations for \'students\':
students/migrations/0001_initial.py

```

Django creates a migration file but does **not** update the database yet.

### Applying Migrations

Run: `python manage.py migrate` Example Output:

```

Applying students.0001_initial... OK

```

Now the database table is created.

### Migration Workflow

```

Create Model
↓
python manage.py makemigrations
Migration File Created
↓
python manage.py migrate
↓
Database Updated

```

## Working with Models

### Creating Objects

Open the Django shell: `python manage.py shell` Create a student:

```

from students.models import Student
student = Student(
name="Ali",
age=20,
department="Computer Science"
)
student.save()

```

The record is stored in the database.

### Retrieve All Records

`Student.objects.all()`

### Retrieve One Record

`Student.objects.get(id=1)`

### Filter Records

```

Student.objects.filter(
department="Computer Science"
)

```

### Update a Record

```

student.age = 21
student.save()

```

### Delete a Record

```

student = Student.objects.get(id=1)
student.delete()

```

The selected record is permanently removed.

### Useful Migration Commands

### Create Migrations

```

python manage.py makemigrations

```

### Apply Migrations

`python manage.py migrate`

### Show Migration Status

```

python manage.py showmigrations

```

### Create SQL Without Executing

```

python manage.py sqlmigrate students 0001

```

This displays the SQL that Django will execute.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Always Run Migrations After Changing Models

Whenever a model changes:

```

python manage.py makemigrations
python manage.py migrate

```

Never forget the second command.

### 2. Use Meaningful Model Names

Good examples:

- Student

- Teacher

- Product

- Employee

Avoid unclear names such as:

- Test

- Data

### 3. Choose Appropriate Field Types

Use:

- `EmailField` for email addresses.

- `IntegerField` for whole numbers.

- `DateField` for dates.

Selecting the correct field improves data validation and consistency.

### 4. Keep Models Simple

Each model should represent a single real-world entity. For example:

- Student

- Course

- Teacher

instead of combining unrelated data into one model.

### 5. Back Up Important Data

Before making major schema changes, back up the database to prevent accidental data loss.

### Advantages of Models and Migrations

- No need to write SQL manually.

- Automatic database table creation.

- Easy schema updates.

- Database independence.

- Strong integration with Django ORM.

- Improved maintainability.

- Simplified database management.

### Common Mistakes

**1. Forgetting to Run** `migrate` Running only:

```

python manage.py makemigrations

```

creates migration files but does **not** update the database.

### 2. Editing Migration Files Manually

Migration files should generally not be modified unless absolutely necessary, as incorrect changes may lead to database inconsistencies.

### 3. Using Incorrect Field Types

For example, storing numbers in a `CharField` instead of an `IntegerField` can make data validation and calculations difficult.

### 4. Deleting Migration Files Randomly

Removing migration files without understanding their purpose can cause synchronization issues between the models and the database.

### 5. Ignoring Database Updates

Changing models without creating and applying migrations causes the code and database schema to become inconsistent, resulting in runtime errors.

### Conclusion

Models and Migrations are the backbone of database management in Django. Models define the structure of database tables using Python classes, while Migrations automatically synchronize these models with the database without requiring manual SQL. By understanding model fields, choosing appropriate field types, creating and applying migrations correctly, and using Django\'s ORM to perform CRUD operations, developers can build robust, scalable, and maintainable database-driven applications efficiently.');

-- Lecture 4: Django Admin Panel
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Django Admin Panel', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Django Admin Panel

## Understanding the Django Admin Panel

The **Django Admin Panel** is one of Django\'s most powerful built-in features. It provides a ready-made web interface for managing the application\'s database without writing additional code. Through the admin panel, developers and administrators can add, update, delete, and search records directly from a browser. Instead of creating separate pages to manage data, Django automatically generates an administration interface for registered models. This saves development time and simplifies database management. Think of the Django Admin Panel as the **control room** of a web application. While users interact with the website, administrators use the admin panel to manage all the application\'s data.

### Features of Django Admin Panel

The Django Admin Panel allows administrators to:

- Add new records.

- View existing records.

- Update records.

- Delete records.

- Search records.

- Filter records.

- Manage users and permissions.

- Manage groups.

- View registered models.

### Default Admin URL

After running the Django server, the admin panel is available at: `http://127.0.0.1:8000/admin/`

## Setting Up the Django Admin Panel

### Step 1: Apply Initial Migrations

Before using the admin panel, create the required database tables. `python manage.py migrate` This creates tables for:

- Users

- Groups

- Authentication

- Sessions

- Admin

### Step 2: Create a Superuser

Create an administrator account.

```

python manage.py createsuperuser

```

Example:

```

Username: admin
Email: admin@example.com
Password: ********

```

After entering the details successfully:

```

Superuser created successfully.

```

### Step 3: Start the Development Server

`python manage.py runserver` Open: `http://127.0.0.1:8000/admin/` Log in using the superuser credentials.

## Registering Models in the Admin Panel

Creating a model alone is not enough. It must be registered in the admin panel before it becomes visible.

### Example Student Model

```

from django.db import models
class Student(models.Model):
name = models.CharField(max_length=100)
age = models.IntegerField()
department = models.CharField(max_length=100)

```

### Register the Model

Open: `admin.py` Add:

```

from django.contrib import admin
from .models import Student
admin.site.register(Student)

```

Restart the server if necessary. Now the **Student** model appears in the admin panel.

### Adding Student Records

Click:

```

Student
↓
Add Student

```

Fill in:

- Name

- Age

- Department

Click: `Save` The record is stored in the database.

## Customizing the Admin Panel

Django allows developers to customize how models appear in the admin interface.

### Display Specific Fields

```

from django.contrib import admin
from .models import Student
class StudentAdmin(admin.ModelAdmin):
list_display = ("id", "name", "age", "department")
admin.site.register(Student, StudentAdmin)

```

Now the admin panel displays these columns.

### Add Search Functionality

```

class StudentAdmin(admin.ModelAdmin):
search_fields = ("name", "department")

```

Administrators can search students by name or department.

### Add Filters

```

class StudentAdmin(admin.ModelAdmin):
list_filter = ("department",)

```

This creates a filter section for departments.

### Ordering Records

```

class StudentAdmin(admin.ModelAdmin):
ordering = ("name",)

```

Students are displayed alphabetically.

### Complete Example

```

from django.contrib import admin
from .models import Student
class StudentAdmin(admin.ModelAdmin):
list_display = ("id", "name", "age", "department")
search_fields = ("name",)
list_filter = ("department",)
ordering = ("name",)
admin.site.register(Student, StudentAdmin)

```

## Managing Users and Permissions

The Django Admin Panel also manages authentication. Administrators can:

- Create users.

- Edit users.

- Delete users.

- Reset passwords.

- Assign permissions.

- Create groups.

### User Roles

### Superuser

A superuser has full access. They can:

- Manage all models.

- Create users.

- Delete users.

- Change permissions.

- Access every part of the admin panel.

### Staff User

A staff user can log into the admin panel but only access the sections they have permission to use.

### Changing User Permissions

Open:

```

Users
↓
Select User
↓
Permissions

```

Assign permissions such as:

- Add

- Change

- Delete

- View

for each registered model.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Register Every Required Model

Only registered models appear in the admin panel. Example: `admin.site.register(Student)`

### 2. Customize Model Display

Use:

- `list_display`

- `search_fields`

- `list_filter`

- `ordering`

to improve usability.

### 3. Use Strong Superuser Credentials

Always choose:

- Strong passwords.

- Unique usernames.

This protects the admin panel from unauthorized access.

### 4. Limit Permissions

Avoid giving every user full administrative access. Assign only the permissions required for their role.

### 5. Keep the Admin Panel Secure

- Use HTTPS in production.

- Update Django regularly.

- Restrict admin access to trusted users.

- Use strong passwords and secure authentication practices.

### Advantages of Django Admin Panel

- Automatically generated interface.

- No additional coding required.

- Easy CRUD operations.

- Built-in authentication.

- User and permission management.

- Search and filtering capabilities.

- Saves development time.

- Highly customizable.

### Common Mistakes

### 1. Forgetting to Register Models

If a model is not registered in admin.py, it will not appear in the admin panel.

### 2. Not Creating a Superuser

Without a superuser account, administrators cannot log into the admin panel. Create one using:

```

python manage.py createsuperuser

```

### 3. Giving Excessive Permissions

Avoid granting full administrative rights to every staff user. Assign permissions based on their responsibilities.

### 4. Ignoring Security

Leaving the admin panel exposed with weak passwords or outdated software increases security risks.

### 5. Not Customizing Large Models

When models contain many records, failing to use search, filters, and ordering can make the admin panel difficult to navigate and manage.

### Conclusion

The Django Admin Panel is one of Django\'s most valuable built-in features, providing a powerful web-based interface for managing application data. By creating a superuser, registering models, customizing the admin interface with search, filters, ordering, and list displays, and properly managing user permissions, developers can efficiently administer their applications without building separate management pages. Following security best practices and using the admin panel effectively makes Django applications easier to maintain, more secure, and more productive for administrators.');

-- Lecture 5: Views (Function-Based & Class-Based) in Django
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Views (Function-Based & Class-Based) in Django', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Views (Function-Based & Class-Based) in Django

## Understanding Views in Django

A **View** is one of the core components of Django. It contains the **business logic** of a web application. Whenever a user sends a request through a URL, Django passes that request to a View. The View processes the request, communicates with the database (if needed), and returns a response to the user. A response can be:

- An HTML page

- A JSON response

- Plain text

- A file

- A redirect

Think of a View as the **manager of a restaurant**. The customer (browser) places an order (request), the manager processes it, communicates with the kitchen (database), and finally serves the meal (response).

### How Views Work

```

User
↓
Browser
↓
URL
↓
urls.py
↓
View
↓
Model (Optional)
↓
Database
↓
View
↓
Template / Response
↓
Browser

```

### Types of Views

Django provides two types of views:

- **Function-Based Views (FBV)**

- **Class-Based Views (CBV)**

Both perform the same tasks but are written differently.

## Function-Based Views (FBV)

A **Function-Based View (FBV)** is a Python function that receives an HTTP request and returns an HTTP response. It is the simplest and easiest way to create views, making it ideal for beginners and small projects.

### Creating a Function-Based View

Open: `views.py` Write:

```

from django.http import HttpResponse
def home(request):
return HttpResponse("Welcome to Django")

```

### Explanation

- `request` contains information sent by the user.

- `HttpResponse()` sends data back to the browser.

### Connecting the View

Inside urls.py

```

from django.urls import path
from . import views
urlpatterns = [
path("", views.home)
]

```

Now opening: `http://127.0.0.1:8000/` Displays: `Welcome to Django`

### Function-Based View Returning HTML

Instead of returning plain text, a view can render an HTML page.

```

from django.shortcuts import render
def home(request):
return render(request, "home.html")

```

`render()` loads an HTML template and returns it to the browser.

### Passing Data to a Template

```

from django.shortcuts import render
data = {
"name": "Ali",
"course": "Django"
}
return render(request, "home.html", data)

```

Inside **home.html**

```

<h1>{{ name }}</h1>
<p>{{ course }}</p>

```

Output:

```

Ali
Django

```

### Advantages of Function-Based Views

- Easy to understand.

- Less code for simple tasks.

- Beginner-friendly.

- Flexible.

- Simple debugging.

### Limitations of Function-Based Views

- Code repetition in large projects.

- Difficult to organize complex applications.

- Less reusable.

## Class-Based Views (CBV)

A **Class-Based View (CBV)** is a Python class that handles requests using methods. Instead of writing separate functions, we create a class and define methods such as:

- `get()`

- `post()`

- `put()`

- `delete()`

CBVs reduce repetitive code and improve code reusability.

### Basic Class-Based View

```

from django.views import View
from django.http import HttpResponse
class HomeView(View):
def get(self, request):
return HttpResponse("Welcome to Django")

```

### Connecting the Class-Based View

```

from django.urls import path
from .views import HomeView
urlpatterns = [
path("", HomeView.as_view())
]

```

`as_view()` converts the class into a callable view that Django can execute.

### Handling GET and POST Requests

```

from django.views import View
from django.http import HttpResponse
class StudentView(View):
def get(self, request):
return HttpResponse("GET Request")
def post(self, request):
return HttpResponse("POST Request")

```

The browser automatically calls the correct method depending on the HTTP request.

### Rendering a Template

```

from django.views import View
from django.shortcuts import render
class HomeView(View):
def get(self, request):
return render(request, "home.html")

```

### Passing Data to a Template

```

from django.views import View
from django.shortcuts import render
class HomeView(View):
def get(self, request):
data = {
"name": "Sara",
"course": "Python"
}
return render(request, "home.html", data)

```

### Advantages of Class-Based Views

- Reusable code.

- Better organization.

- Supports inheritance.

- Less repetitive code.

- Ideal for large projects.

### Limitations of Class-Based Views

- Harder to understand initially.

- More complex syntax.

- Not suitable for very simple views.

## Function-Based Views vs Class-Based Views

Feature Function-Based View Class-Based View Structure Function Class Beginner Friendly Yes Moderate Code Reusability Low High Inheritance No Yes Suitable For Small projects Large projects Complexity Low Higher Code Organization Simple Better

### When Should We Use FBV?

Choose Function-Based Views when:

- The application is small.

- The logic is simple.

- Learning Django.

- Creating quick prototypes.

### When Should We Use CBV?

Choose Class-Based Views when:

- Building large applications.

- Code reuse is important.

- Multiple HTTP methods are required.

- Using Django\'s generic views.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Keep Views Small

A view should perform one specific task. Good example:

- Show students.

- Add student.

- Delete student.

Avoid placing unrelated logic in a single view.

### 2. Use FBV for Simple Logic

If the view only displays a page or performs a straightforward task, a Function-Based View is usually sufficient.

### 3. Use CBV for Complex Applications

When a view handles multiple request methods or shares behavior with other views, Class-Based Views provide better organization and code reuse.

### 4. Separate Business Logic

Avoid writing complex database operations directly inside views. Move reusable logic to models, forms, or utility functions where appropriate.

### 5. Use Meaningful View Names

Examples:

- `StudentListView`

- `HomeView`

- `CourseView`

- `student_detail`

Clear names improve readability and maintenance.

### Advantages of Django Views

- Handle user requests.

- Return different types of responses.

- Easy integration with templates.

- Support database interaction.

- Flexible design.

- Reusable components.

- Support both simple and advanced applications.

### Common Mistakes

### 1. Forgetting to Connect the View

Creating a view without adding it to urls.py means it cannot be accessed through a browser. **2. Forgetting** `as_view()` **in CBV** Incorrect: `path("", HomeView)` Correct: `path("", HomeView.as_view())` Without `as_view()`, Django cannot execute the class-based view.

### 3. Writing Too Much Logic Inside Views

Large amounts of business logic make views difficult to read and maintain. Keep views focused on handling requests and responses.

### 4. Returning the Wrong Response Type

A Django view must always return an appropriate response object, such as `HttpResponse`, `JsonResponse`, or the result of `render()`.

### 5. Choosing the Wrong View Type

Using Class-Based Views for extremely simple tasks can make the code unnecessarily complex, while using Function-Based Views for large, repetitive applications can lead to duplicated code.

### Conclusion

Views are the heart of a Django application, acting as the bridge between user requests, business logic, and responses. Django provides two approaches for creating views: **Function-Based Views (FBVs)**, which are simple, flexible, and ideal for beginners or small projects, and **Class-Based Views (CBVs)**, which offer better organization, code reuse, and scalability for larger applications. By understanding both approaches, selecting the appropriate type for each situation, and following best practices, developers can create clean, maintainable, and efficient Django applications.');

-- Lecture 6: URL Routing & URLconf in Django
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'URL Routing & URLconf in Django', 6, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# URL Routing & URLconf in Django

## Understanding URL Routing & URLconf

Every web application needs a way to determine which code should execute when a user visits a specific web address. In Django, this responsibility is handled by **URL Routing** through a configuration system called **URLconf (URL Configuration)**. When a user enters a URL in the browser, Django compares that URL with the patterns defined in urls.py. If a matching pattern is found, Django calls the corresponding **View**, which processes the request and returns a response. Think of URL Routing as a GPS navigation system. A user provides a destination (URL), and Django finds the correct route (URL pattern) to reach the appropriate view.

### What is URL Routing?

**URL Routing** is the process of mapping URLs to specific views. Example:

```

http://127.0.0.1:8000/students/

```

can call: `students.views.student_list`

### What is URLconf?

**URLconf (URL Configuration)** is a collection of URL patterns stored inside a file named **urls.py**. Each URL pattern tells Django:

- Which URL to match.

- Which view should handle the request.

### How URL Routing Works

```

Browser
↓
URL Request
↓
urls.py
↓
Matching URL Pattern
↓
View
↓
Response
↓
Browser

```

## Creating URL Patterns

### Project-Level URLs

Every Django project contains a main urls.py file. Example:

```

from django.contrib import admin
from django.urls import path
urlpatterns = [
path("admin/", admin.site.urls),
]

```

### Explanation

- `path()` creates a URL pattern.

- `"admin/"` is the URL.

- admin.site.urls opens the Django Admin Panel.

### Creating a View

Inside views.py

```

from django.http import HttpResponse
def home(request):
return HttpResponse("Welcome to Django")

```

### Connecting the View

```

from django.urls import path
from . import views
urlpatterns = [
path("", views.home),
]

```

Now visiting: `http://127.0.0.1:8000/` displays: `Welcome to Django`

## App-Level URL Configuration

Large projects usually have multiple apps. Instead of placing all URLs in one file, Django recommends creating a separate urls.py inside each app.

### Create App URLs

Inside:

```

students/urls.py
from django.urls import path
from . import views
urlpatterns = [
path("", views.home),
]

```

### Include App URLs

Open the project\'s urls.py

```

from django.urls import include, path
urlpatterns = [
path("students/", include("students.urls")),
]

```

Now the URL becomes:

```

http://127.0.0.1:8000/students/

```

### Benefits of App-Level URLs

- Better organization.

- Easier maintenance.

- Supports large projects.

- Keeps routing modular.

## Dynamic URL Routing

Sometimes URLs contain dynamic values. Example: `/students/5/` The number **5** is a parameter.

### Integer Parameter

```

path("students/<int:id>/", views.student)

```

View:

```

from django.http import HttpResponse
def student(request, id):
return HttpResponse(f"Student ID: {id}")

```

Visiting: `/students/5/` Displays: `Student ID: 5`

### String Parameter

```

path("student/<str:name>/", views.studentName)

```

View:

```

def studentName(request, name):
return HttpResponse(name)

```

URL: `student/Ali/` Response: `Ali`

### Slug Parameter

A slug is commonly used in blog URLs.

```

path("blog/<slug:title>/", views.blog)

```

Example URL: `blog/python-basics/`

### UUID Parameter

Useful for uniquely identifying records.

```

path("user/<uuid:id>/", views.user)

```

## URL Naming and Reverse Routing

### Named URLs

Assign a name to each URL.

```

path(
"home/",
views.home,
name="home"
)

```

### Using Reverse Routing

Instead of hardcoding URLs: `<a href="/home/">Home</a>` Use:

```

<a href="{% url \'home\' %}">Home</a>

```

Advantages:

- Easier maintenance.

- Automatic URL updates.

- Reduces broken links.

### Using in Views

```

reverse()
from django.urls import reverse
url = reverse("home")

```

This returns the URL associated with the name `"home"`.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Use App-Level URLs

Instead of placing every route inside the project\'s urls.py, create a separate urls.py for each app.

### 2. Use Meaningful URL Names

Good examples:

- home

- login

- student-detail

- course-list

Meaningful names improve readability.

### 3. Use Named URLs

Always assign names to URL patterns. Example:

```

path(
"about/",
views.about,
name="about"
)

```

### 4. Keep URLs Simple

Good: `/students/` Avoid unnecessarily long or confusing URLs.

### 5. Use Dynamic Parameters When Needed

Instead of creating multiple routes:

```

/student1/
/student2/
/student3/

```

Use:

```

path(
"student/<int:id>/",
views.student
)

```

This makes the application more flexible.

### Advantages of URL Routing

- Clean URL structure.

- Easy navigation.

- Modular routing.

- Supports dynamic URLs.

- Simplifies project organization.

- Improves maintainability.

- Enables reverse URL lookup.

### Common Mistakes

### 1. Forgetting to Include App URLs

If `include()` is not used in the project\'s urls.py, Django cannot route requests to the app.

### 2. Missing Trailing Slash

Django commonly expects URLs to end with a slash (`/`). Omitting it may result in redirects or errors depending on project settings.

### 3. Hardcoding URLs

Instead of writing: `<a href="/home/">` Use named URLs with:

```

{% url \'home\' %}

```

This improves maintainability.

### 4. Incorrect Parameter Types

If the URL expects: `<int:id>` but a string is provided, Django will not match the URL pattern and will return a **404 Not Found** error.

### 5. Keeping All Routes in One File

For large projects, storing every route in a single urls.py file makes the project difficult to maintain. Use separate URL configuration files for each app.

### Conclusion

URL Routing and URLconf are fundamental parts of every Django application. They connect user requests to the appropriate views by defining URL patterns in urls.py. Django supports project-level and app-level URL configurations, dynamic URL parameters, named URLs, and reverse routing, making applications more modular and maintainable. By organizing URLs properly, using meaningful names, leveraging dynamic routes, and following Django\'s best practices, developers can build clean, scalable, and user-friendly web applications.');

-- Lecture 7: Templates & Template Language in Django
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Templates & Template Language in Django', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Templates & Template Language in Django

## Understanding Templates in Django

A **Template** in Django is an **HTML file** that defines how data is displayed to users in a web browser. While **Views** handle the application\'s logic, **Templates** are responsible for the presentation layer (user interface). Templates allow developers to combine **HTML** with dynamic data using the **Django Template Language (DTL)**. Instead of creating static web pages, templates generate content dynamically based on data received from views. Think of a template as a **blank certificate**. The certificate design (HTML) remains the same, but the student\'s name, course, and grade (dynamic data) change each time it is printed.

### How Templates Work

```

User
↓
Browser
↓
URL
↓
View
↓
Template
↓
HTML Page
↓
Browser

```

The View collects data, sends it to the Template, and the Template generates the final HTML page displayed in the browser.

### Why Use Templates?

Templates provide several advantages:

- Separate design from business logic.

- Create reusable web pages.

- Display dynamic data.

- Improve code organization.

- Simplify maintenance.

## Creating and Configuring Templates

### Step 1: Create a Templates Folder

Inside the project directory, create a folder named: `templates/` Project structure:

```

myproject/
│── manage.py
│── templates/
│ home.html
│── myproject/
│── students/

```

### Step 2: Configure Templates

Open: `settings.py` Locate the `TEMPLATES` setting and update the `DIRS` list.

```

from pathlib import Path
BASE_DIR = Path(__file__).resolve().parent.parent
TEMPLATES = [
{
"BACKEND": "django.template.backends.django.DjangoTemplates",
"DIRS": [BASE_DIR / "templates"],
"APP_DIRS": True,
},
]

```

Now Django knows where to find template files.

### Step 3: Create an HTML Template

Create: `templates/home.html` Example:

```

<!DOCTYPE html>
<html>
<head>
<title>Home</title>
</head>
<body>
<h1>Welcome to Django</h1>
</body>
</html>

```

### Step 4: Render the Template

Open:

```

views.py
from django.shortcuts import render
def home(request):
return render(request, "home.html")

```

Open: `http://127.0.0.1:8000/` The browser displays the HTML page.

## Django Template Language (DTL)

The **Django Template Language (DTL)** allows developers to insert dynamic data into HTML. There are three main components:

- Variables

- Tags

- Filters

### 1. Variables

Variables display data passed from the View. View:

```

from django.shortcuts import render
def home(request):
data = {
"name": "Ali",
"course": "Django"
}
return render(request, "home.html", data)

```

Template:

```

<h1>{{ name }}</h1>
<p>{{ course }}</p>

```

Output:

```

Ali
Django

```

Variables are enclosed inside:

```

{{ }}

```

### 2. Template Tags

Tags perform logic such as loops and conditions. Tags use:

```

{% %}

```

### If Statement

```

{% if age >= 18 %}
<p>Adult</p>
{% else %}
<p>Minor</p>
{% endif %}

```

### For Loop

View:

```

def home(request):
students = [
"Ali",
"Sara",
"Ahmed"
]
return render(
request,
"home.html",
{
"students": students
}
)

```

Template:

```

<ul>
{% for student in students %}
<li>{{ student }}</li>
{% endfor %}
</ul>

```

Output:

```

Ali
Sara
Ahmed

```

### 3. Filters

Filters modify displayed data. Syntax:

```

{{ variable|filter }}

```

Example:

```

{{ name|upper }}

```

Output: `ALI`

### Common Filters

Filter Purpose Converts text to `upper` uppercase Converts text to `lower` lowercase `title` Capitalizes each word `length` Counts items Displays a default value if `default` empty Example:

```

{{ course|title }}

```

Output: `Django`

## Template Inheritance

Template inheritance allows multiple pages to share a common layout. Instead of repeating HTML code, create one **base template** and let other templates inherit it.

### Create Base Template

```

<!DOCTYPE html>
<html>
<head>
<title>Django Website</title>
</head>
<body>
<h1>My Website</h1>
{% block content %}
{% endblock %}
</body>
</html>

```

Save as: `base.html`

### Create Child Template

```

{% extends "base.html" %}
{% block content %}
<h2>Home Page</h2>
<p>Welcome to Django.</p>
{% endblock %}

```

The child template automatically inherits the layout from `base.html`.

### Advantages of Template Inheritance

- Eliminates duplicate code.

- Easier maintenance.

- Consistent website design.

- Faster development.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Separate Logic from Templates

Templates should only display data. Avoid writing complex business logic inside HTML.

### 2. Use Template Inheritance

Create a shared `base.html` file for common elements such as:

- Header

- Navigation

- Footer

This improves consistency and reduces repetition.

### 3. Keep Templates Organized

Store templates in clearly named folders. Example:

```

templates/
base.html
home.html
students/
list.html
detail.html

```

### 4. Use Meaningful Variable Names

Good examples:

- `student`

- `course`

- `teacher`

Avoid unclear names like:

- `x`

- `data1`

- `temp`

### 5. Use Built-in Filters

Instead of modifying data in the view, use template filters where appropriate for simple formatting tasks.

### Advantages of Django Templates

- Clean separation of design and logic.

- Dynamic content generation.

- Reusable layouts through inheritance.

- Easy integration with views.

- Simple syntax.

- Built-in tags and filters.

- Easy to maintain.

### Common Mistakes

### 1. Forgetting to Configure the Templates Directory

If the `templates` folder is not added to the `DIRS` setting in settings.py, Django may not locate template files.

### 2. Using Incorrect Syntax

Variables:

```

{{ name }}

```

Tags:

```

{% for student in students %}

```

Mixing these syntaxes causes template errors.

### 3. Writing Business Logic Inside Templates

Templates should focus on presentation. Complex calculations or database operations belong in views or models. **4. Forgetting** `{% endfor %}` **or** `{% endif %}` Every loop and conditional block must be properly closed. Incorrect:

```

{% for student in students %}

```

Correct:

```

{% for student in students %}
...
{% endfor %}

```

### 5. Not Using Template Inheritance

Copying the same HTML into multiple pages makes maintenance difficult. Using `base.html` with `{% extends %}` keeps layouts consistent and easier to update.

### Conclusion

Templates and the Django Template Language (DTL) form the presentation layer of a Django application. Templates display dynamic content while keeping business logic separate from the user interface. Through variables, tags, and filters, developers can generate flexible and interactive web pages, while template inheritance promotes code reuse and consistent layouts across the application. By organizing templates properly, using inheritance, and following Django\'s best practices, developers can create maintainable, scalable, and professional web interfaces.');

-- Lecture 8: Forms & ModelForms in Django
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Forms & ModelForms in Django', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Forms & ModelForms in Django

## Understanding Forms in Django

A **Form** in Django is used to collect input from users through web pages. Forms allow users to enter information such as names, email addresses, passwords, comments, and other data. Django provides a powerful form system that simplifies form creation, validation, and processing. Instead of manually validating user input, Django automatically checks the entered data and reports errors if the data is invalid. This makes applications more secure and reduces development time. Think of a form as an **admission form** at a university. Students fill in their information, and the university verifies whether all required details are correct before accepting the application.

### Why Use Django Forms?

Django Forms provide several benefits:

- Automatic input validation.

- Easy HTML form generation.

- Protection against security issues.

- Cleaner code.

- Easy integration with templates and models.

### Types of Forms

Django provides two main types of forms:

- **Forms**

- **ModelForms**

## Django Forms

A **Form** is created manually using Django\'s `forms.Form` class. It is suitable when the form is **not directly connected to a database model**.

### Step 1: Create forms.py

Inside your app folder, create: `forms.py`

### Step 2: Create a Form

```

from django import forms
class StudentForm(forms.Form):
name = forms.CharField(max_length=100)
age = forms.IntegerField()
email = forms.EmailField()

```

### Explanation

This form contains:

- Name

- Age

- Email

Django automatically validates these fields.

### Step 3: Create a View

```

from django.shortcuts import render
from .forms import StudentForm
def student_form(request):
form = StudentForm()
return render(
request,
"student_form.html",
{
"form": form
}
)

```

### Step 4: Create the Template

```

<form method="POST">
{% csrf_token %}
{{ form.as_p }}
<button type="submit">
Submit
</button>
</form>

```

### Explanation

- `method="POST"` sends form data securely.

- `{% csrf_token %}` protects against Cross-Site Request Forgery (CSRF) attacks.

- `{{ form.as_p }}` displays each field inside a paragraph.

### Handling Form Submission

```

from django.shortcuts import render
from .forms import StudentForm
def student_form(request):
if request.method == "POST":
form = StudentForm(request.POST)
if form.is_valid():
return render(
request,
"success.html"
)
else:
form = StudentForm()
return render(
request,
"student_form.html",
{
"form": form
}
)

```

### Accessing Form Data

```

if form.is_valid():
name = form.cleaned_data["name"]
age = form.cleaned_data["age"]
email = form.cleaned_data["email"]

```

`cleaned_data` contains validated user input.

## ModelForms

A **ModelForm** automatically creates a form from a Django model. Instead of defining fields manually, Django generates them from the model. ModelForms reduce code duplication and are commonly used in database-driven applications.

### Create a Model

```

from django.db import models
class Student(models.Model):
name = models.CharField(max_length=100)
age = models.IntegerField()
email = models.EmailField()

```

### Create a ModelForm

```

from django import forms
from .models import Student
class StudentModelForm(forms.ModelForm):
class Meta:
model = Student
fields = "__all__"

```

### Explanation

- `model` specifies the database model.

- `fields = "__all__"` includes all model fields in the form.

### Using a ModelForm

```

from django.shortcuts import render
from .forms import StudentModelForm
def add_student(request):
if request.method == "POST":
form = StudentModelForm(request.POST)
if form.is_valid():
form.save()
else:
form = StudentModelForm()
return render(
request,
"student_form.html",
{
"form": form
}
)

```

The `save()` method automatically stores the data in the database.

### Selecting Specific Fields

Instead of using all fields:

```

fields = [
"name",
"age"
]

```

Only the selected fields appear in the form.

### Excluding Fields

```

exclude = [
"email"
]

```

All fields except `email` are included.

## Form Validation

Django automatically validates user input. Example: `email = forms.EmailField()` If the user enters an invalid email, Django displays an error message.

### Required Fields

```

name = forms.CharField(
required=True
)

```

Users cannot leave this field empty.

### Custom Validation

```

from django import forms
class StudentForm(forms.Form):
age = forms.IntegerField()
def clean_age(self):
age = self.cleaned_data["age"]
if age < 18:
raise forms.ValidationError(
"Age must be at least 18."
)
return age

```

If the entered age is below 18, Django displays the validation error.

### Displaying Errors

```

{{ form.errors }}

```

This shows all validation errors on the page.

## Best Practices, Advantages, and Common Mistakes

### Best Practices

### 1. Always Use CSRF Protection

Include:

```

{% csrf_token %}

```

in every POST form to protect against CSRF attacks.

### 2. Use ModelForms for Database Models

If a form is directly related to a model, prefer `ModelForm` to reduce repetitive code and simplify maintenance.

### 3. Validate User Input

Always use: `form.is_valid()` before processing or saving data.

### 4. Use Meaningful Field Names

Examples:

- name

- email

- age

- department

Meaningful names improve readability and maintenance.

### 5. Display Validation Errors

Always show validation errors to users so they can correct their input. Example:

```

{{ form.errors }}

```

### Advantages of Django Forms

- Automatic validation.

- Easy HTML generation.

- Secure form processing.

- Reduced code duplication.

- Easy integration with templates.

- Built-in error handling.

- Protection against common web vulnerabilities.

### Advantages of ModelForms

- Automatically generates form fields from models.

- Saves data directly to the database.

- Less coding required.

- Easier maintenance.

- Consistent with model definitions.

### Forms vs ModelForms

Feature Form ModelForm Connected to Database No Yes Manual Fields Yes No Automatic Field No Yes Generation Automatic Save No Yes (`save()`) Best Used For Custom forms Database models

### Common Mistakes

**1. Forgetting** `{% csrf_token %}` Without a CSRF token, Django blocks POST requests and displays a **403 Forbidden** error. **2. Skipping** `form.is_valid()` Never save or process form data before validating it. Incorrect: `form.save()` Correct:

```

if form.is_valid():
form.save()

```

**3. Using** `Form` **Instead of** `ModelForm` When working with database models, using a regular `Form` requires writing extra code to save data manually. A `ModelForm` is usually the better choice.

### 4. Forgetting request.POST

Incorrect: `form = StudentForm()` Correct:

```

form = StudentForm(request.POST)

```

Without request.POST, submitted data will not be processed.

### 5. Ignoring Validation Errors

If validation fails, display the errors to users instead of silently ignoring them.

### Conclusion

Forms and ModelForms are essential components of Django for collecting, validating, and processing user input. **Forms** are ideal for custom input that is not directly linked to a database, while **ModelForms** automatically generate forms from models and simplify database operations through methods like `save()`. Django\'s built-in validation, CSRF protection, and error handling make form processing secure and efficient. By choosing the appropriate form type, validating input correctly, and following best practices, developers can build reliable, user-friendly, and maintainable web applications.');

-- Lecture 9: Django ORM & QuerySets
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Django ORM & QuerySets', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Django ORM & QuerySets

## Introduction to Django ORM

### What is Django ORM?

The **Django Object-Relational Mapper (ORM)** is one of Django\'s most powerful features. It acts as a bridge between Python code and relational databases such as PostgreSQL, MySQL, SQLite, and Oracle. Instead of writing raw SQL queries, we interact with the database using Python classes and methods. Think of the ORM as a translator. We speak Python, the database speaks SQL, and the ORM translates our Python instructions into SQL commands automatically. This allows us to focus on application logic instead of memorizing complex SQL syntax. For example, instead of writing:

```

SELECT * FROM students WHERE age > 18;

```

We simply write:

```

Student.objects.filter(age__gt=18)

```

The ORM generates the SQL behind the scenes.

### Why Use Django ORM?

There are several reasons why developers love Django ORM:

- It reduces the amount of SQL code we write.

- It improves code readability.

- It provides database independence.

- It helps prevent SQL injection attacks.

- It integrates seamlessly with Django models.

- It simplifies CRUD (Create, Read, Update, Delete) operations.

In short, the ORM lets us work with databases using Python objects instead of SQL statements.

## Understanding Models and the ORM

### What is a Model?

A Django model is a Python class that represents a database table. Every attribute inside the model represents a column in that table. Example:

```

from django.db import models
class Student(models.Model):
name = models.CharField(max_length=100)
age = models.IntegerField()
email = models.EmailField()

```

This model creates a table named **Student** with three columns:

- name

- age

- email

Each object created from this model represents one row in the database. Example:

```

student = Student(
name="Ali",
age=21,
email="ali@example.com"
)
student.save()

```

This inserts a new record into the database.

### How Django ORM Maps Objects

Suppose our database table looks like this: id name age email 1 Ali 21 ali@example.com 2 Sara 20 sara@example.com Django converts each row into a Python object. Example:

```

student = Student.objects.get(id=1)
print(student.name)
print(student.age)

```

Output:

```

Ali
21

```

We never directly interact with SQL tables. Instead, we work with Python objects.

## QuerySets in Django

### What is a QuerySet?

A **QuerySet** is a collection of database queries. Whenever we retrieve data from a Django model, Django returns a QuerySet. Example:

```

students = Student.objects.all()

```

Here, `students` is a QuerySet containing every Student object. One important feature of QuerySets is that they are **lazy**.

### Lazy Evaluation

Lazy evaluation means Django does not immediately execute the SQL query. Example:

```

students = Student.objects.all()

```

No SQL is executed yet. Only when we do something like:

```

for student in students:
print(student.name)

```

does Django finally send the SQL query to the database. This makes applications more efficient because unnecessary database operations are avoided.

### Common QuerySet Methods

### all()

Returns all objects. `Student.objects.all()`

### filter()

Returns objects matching specific conditions.

```

Student.objects.filter(age=20)

```

SQL Equivalent:

```

SELECT * FROM student
WHERE age = 20;

```

### exclude()

Returns all objects except those matching the condition.

```

Student.objects.exclude(age=20)

```

### get()

Retrieves exactly one object. `Student.objects.get(id=1)` If multiple objects exist, Django raises an exception. If no object exists, Django also raises an exception.

### first()

Returns the first object. `Student.objects.first()`

### last()

Returns the last object. `Student.objects.last()`

### count()

Counts objects. `Student.objects.count()`

### exists()

Checks if records exist.

```

Student.objects.filter(age=25).exists()

```

Returns: `True` or `False`

## Filtering Data Using QuerySets

Django provides lookup operators.

### Greater Than

```

Student.objects.filter(age__gt=18)

```

SQL: `WHERE age > 18`

### Less Than

```

Student.objects.filter(age__lt=25)

```

### Greater Than or Equal

```

Student.objects.filter(age__gte=20)

```

### Less Than or Equal

```

Student.objects.filter(age__lte=30)

```

### Contains

```

Student.objects.filter(name__contains="Ali")

```

Case-sensitive.

### Case-Insensitive Contains

```

Student.objects.filter(name__icontains="ali")

```

Matches:

- Ali

- ALI

- ali

### Starts With

```

Student.objects.filter(name__startswith="A")

```

### Ends With

```

Student.objects.filter(name__endswith="a")

```

### In Lookup

```

Student.objects.filter(age__in=[18,20,22])

```

Equivalent SQL: `WHERE age IN (18,20,22)`

### Range Lookup

```

Student.objects.filter(age__range=(18,25))

```

### Combining Filters

Multiple conditions can be combined.

```

Student.objects.filter(
age__gt=18,
name__icontains="a"
)

```

This returns students older than 18 whose names contain "a".

### Using Q Objects

Sometimes we need OR conditions. Example:

```

from django.db.models import Q
Student.objects.filter(
Q(age=20) | Q(age=25)
)

```

This returns students aged either 20 or 25. For AND:

```

Student.objects.filter(
Q(age=20) &
Q(name__icontains="Ali")
)

```

## CRUD Operations with Django ORM

### Create

Creating new records:

```

student = Student(
name="Ahmed",
age=22,
email="ahmed@example.com"
)
student.save()

```

Shortcut:

```

Student.objects.create(
name="Ahmed",
age=22,
email="ahmed@example.com"
)

```

### Read

Retrieve all: `Student.objects.all()` Retrieve one: `Student.objects.get(id=1)`

### Update

```

student = Student.objects.get(id=1)
student.age = 25
student.save()

```

Bulk update:

```

Student.objects.filter(age=20).update(age=21)

```

### Delete

Delete one object:

```

student = Student.objects.get(id=1)
student.delete()

```

Delete multiple:

```

Student.objects.filter(age=20).delete()

```

Delete all:

```

Student.objects.all().delete()

```

## Ordering, Limiting, and Aggregation

### Ordering Results

Ascending:

```

Student.objects.order_by("age")

```

Descending:

```

Student.objects.order_by("-age")

```

### Limiting Records

First five: `Student.objects.all()[:5]` Next five: `Student.objects.all()[5:10]` This behaves similarly to SQL\'s `LIMIT` and `OFFSET`.

### Aggregate Functions

Average:

```

from django.db.models import Avg
Student.objects.aggregate(
Avg("age")
)

```

Maximum:

```

from django.db.models import Max
Student.objects.aggregate(
Max("age")
)

```

Minimum:

```

from django.db.models import Min
Student.objects.aggregate(
Min("age")
)

```

Count:

```

from django.db.models import Count
Student.objects.aggregate(
Count("id")
)

```

Sum:

```

from django.db.models import Sum
Student.objects.aggregate(
Sum("age")
)

```

## Relationships in Django ORM

### ForeignKey

One-to-Many relationship.

```

class Course(models.Model):
name = models.CharField(max_length=100)
class Student(models.Model):
name = models.CharField(max_length=100)
course = models.ForeignKey(
Course,
on_delete=models.CASCADE
)

```

Retrieve all students in a course: `course.student_set.all()`

### ManyToManyField

Many students can enroll in many courses.

```

class Course(models.Model):
name = models.CharField(max_length=100)
class Student(models.Model):
name = models.CharField(max_length=100)
courses = models.ManyToManyField(Course)

```

Adding a course: `student.courses.add(course)`

### OneToOneField

One record relates to exactly one other record. Example:

```

class Profile(models.Model):
student = models.OneToOneField(
Student,
on_delete=models.CASCADE
)

```

Useful for user profiles.

## Query Optimization

### select_related()

Reduces database queries for ForeignKey relationships.

```

Student.objects.select_related("course")

```

Instead of multiple database hits, Django performs a SQL JOIN.

### prefetch_related()

Optimizes ManyToMany relationships.

```

Student.objects.prefetch_related("courses")

```

This significantly improves performance when retrieving related objects.

### values()

Returns dictionaries.

```

Student.objects.values(
"name",
"age"
)

```

Output:

```

[
{\'name\':\'Ali\',\'age\':20},
{\'name\':\'Sara\',\'age\':22}
]

```

### values_list()

Returns tuples.

```

Student.objects.values_list(
"name",
"age"
)

```

Output:

```

[
(\'Ali\',20),
(\'Sara\',22)
]

```

### distinct()

Removes duplicates.

```

Student.objects.values(
"age"
).distinct()

```

## Best Practices When Using Django ORM

**Use QuerySets Efficiently** Avoid unnecessary database calls. Store QuerySets in variables if they are reused. **Avoid N+1 Query Problems** Use `select_related()` for ForeignKey relationships and `prefetch_related()` for ManyToMany relationships to minimize database queries. **Use Bulk Operations** Prefer:

```

Student.objects.bulk_create([...])

```

instead of repeatedly calling `save()` inside loops. **Fetch Only Required Fields** Use:

```

Student.objects.values("name")

```

when only the student\'s name is needed. **Keep Business Logic in Models** Encapsulate reusable functionality inside model methods instead of duplicating logic throughout views or templates.

### Conclusion

Django ORM provides a powerful, Pythonic way to interact with relational databases without writing raw SQL for everyday tasks. By representing database tables as models and queries as QuerySets, we can create, retrieve, update, and delete data using clean, readable Python code. Features such as lazy evaluation, filtering, aggregations, relationships, and query optimization make the ORM both efficient and expressive. As we build larger Django applications, mastering QuerySets and understanding when to use tools like `select_related()`, `prefetch_related()`, and bulk operations will help us write faster, cleaner, and more maintainable code. Rather than thinking in terms of SQL statements, we begin to think in terms of Python objects—making database programming more intuitive, productive, and enjoyable.');

-- Lecture 10: Middleware in Django
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Middleware in Django', 10, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Middleware in Django

## Introduction to Middleware

### What is Middleware?

**Middleware** is a framework of hooks and components that sits between the **client\'s request** and the **server\'s response** in a Django application. It processes every request before it reaches the view and every response before it is sent back to the client. Think of middleware as a **security checkpoint at an airport**. Every passenger (request) must pass through security before boarding the plane (view). Similarly, every passenger returning (response) also passes through certain checks before leaving the airport. Middleware performs these checks automatically. In simple terms:

- **Request → Middleware → View**

- **View → Middleware → Response**

Middleware is executed automatically for every request unless configured otherwise.

### Why Do We Need Middleware?

Middleware helps developers perform common tasks globally without repeating code in every view. Some common uses include:

- User authentication

- Session management

- Security checks

- CSRF protection

- Logging requests

- Compressing responses

- Handling exceptions

- Caching

- Language localization

- Custom request processing

Without middleware, these tasks would need to be implemented repeatedly in multiple views, leading to duplicated code.

### How Middleware Works

The request-response cycle in Django looks like this:

```

Client
│
▼
Incoming Request
│
▼
Middleware
│
▼
URL Dispatcher
│
▼
View
│
▼
Response
│
▼
Middleware
│
▼
Client

```

Middleware processes requests **before** the view executes and processes responses **after** the view returns a response.

## Built-in Middleware in Django

Django comes with several built-in middleware classes that provide essential functionality. Example in settings.py:

```

MIDDLEWARE = [
"django.middleware.security.SecurityMiddleware",
"django.contrib.sessions.middleware.SessionMiddleware",
"django.middleware.common.CommonMiddleware",
"django.middleware.csrf.CsrfViewMiddleware",
"django.contrib.auth.middleware.AuthenticationMiddleware",
"django.contrib.messages.middleware.MessageMiddleware",
"django.middleware.clickjacking.XFrameOptionsMiddleware",
]

```

Each middleware performs a specific task.

### SecurityMiddleware

```

"django.middleware.security.SecurityMiddleware"

```

Provides security-related features such as:

- HTTPS redirection

- HSTS (HTTP Strict Transport Security)

- Secure cookies

- Protection against certain attacks

This middleware improves the overall security of Django applications.

### SessionMiddleware

```

"django.contrib.sessions.middleware.SessionMiddleware"

```

Handles user sessions. It allows Django to remember information between requests. Example:

```

request.session["username"] = "Ali"

```

Retrieve later: `request.session["username"]`

### CommonMiddleware

```

"django.middleware.common.CommonMiddleware"

```

Provides common functionality including:

- URL rewriting

- Handling trailing slashes

- Blocking invalid user agents

- Content-Length header management

### CsrfViewMiddleware

```

"django.middleware.csrf.CsrfViewMiddleware"

```

Protects against **Cross-Site Request Forgery (CSRF)** attacks. Forms should include:

```

{% csrf_token %}

```

Without a valid CSRF token, Django rejects unsafe requests such as POST.

### AuthenticationMiddleware

```

"django.contrib.auth.middleware.AuthenticationMiddleware"

```

Associates the logged-in user with every request. Example: `request.user` Allows access to properties such as:

```

request.user.username
request.user.email
request.user.is_authenticated

```

### MessageMiddleware

```

"django.contrib.messages.middleware.MessageMiddleware"

```

Supports one-time notification messages. Example:

```

from django.contrib import messages
messages.success(
request,
"Login Successful!"
)

```

Display in a template:

```

{% for message in messages %}
{{ message }}
{% endfor %}

```

### XFrameOptionsMiddleware

```

"django.middleware.clickjacking.XFrameOptionsMiddleware"

```

Protects against **Clickjacking** attacks by controlling whether the site can be embedded inside HTML `<iframe>` elements.

## Middleware Execution Process

### Request Phase

When a client sends a request: 1. Request reaches Django. 2. Middleware processes the request in order. 3. The request reaches the URL dispatcher. 4. The appropriate view executes. Example:

```

Client
↓
Middleware 1
↓
Middleware 2
↓
Middleware 3
View

```

Each middleware can modify the request before it reaches the view.

### Response Phase

After the view generates a response:

```

View
↓
Middleware 3
↓
Middleware 2
↓
Middleware 1
↓
Client

```

Notice that middleware executes in **reverse order** during the response phase. This allows each middleware to modify the outgoing response before it reaches the client.

### Middleware Order Matters

The order of middleware in the `MIDDLEWARE` list is important. For example:

```

MIDDLEWARE = [
MiddlewareA,
MiddlewareB,
MiddlewareC,
]

```

Execution order: **Request** `A → B → C` **Response** `C → B → A` Incorrect ordering may cause authentication, session handling, or security features to behave unexpectedly.

## Creating Custom Middleware

### Why Create Custom Middleware?

Custom middleware is useful when we want to apply application-wide functionality, such as:

- Logging requests

- Tracking visitors

- Measuring response times

- Restricting access

- Adding custom headers

- Recording analytics

Instead of writing the same code in multiple views, middleware lets us implement it once.

### Creating a Middleware Class

Create a file named middleware.py. Example:

```

class SimpleMiddleware:
def __init__(self, get_response):
self.get_response = get_response
def __call__(self, request):
print("Before View")
response = self.get_response(request)
print("After View")
return response

```

This middleware prints messages before and after the view executes.

### Registering Custom Middleware

Add it to settings.py.

```

MIDDLEWARE = [
...
"myapp.middleware.SimpleMiddleware",
]

```

Django automatically executes it for every request.

### Adding Custom Headers

Example:

```

class HeaderMiddleware:
def __init__(self, get_response):
self.get_response = get_response
def __call__(self, request):
response = self.get_response(request)
response["Project"] = "Student Portal"
return response

```

Every response now includes: `Project: Student Portal` Custom headers are useful for debugging, API versioning, or tracking responses.

## Middleware Methods

### The Method

`__init__()` Executed only once when the server starts. Example:

```

def __init__(self, get_response):
self.get_response = get_response

```

This method initializes the middleware. Executed for every request. Example:

```

def __call__(self, request):
response = self.get_response(request)
return response

```

This is where most middleware logic is implemented.

### Processing Requests

A middleware can modify incoming requests. Example:

```

request.custom_data = "Hello Django"

```

The view can later access: `request.custom_data` This enables middleware to pass additional information to views.

### Processing Responses

Middleware can also modify responses. Example: `response["Version"] = "1.0"` The client receives the modified response with the additional HTTP header.

## Practical Examples of Middleware

### Request Logging Middleware

```

class LoggingMiddleware:
def __init__(self, get_response):
self.get_response = get_response
def __call__(self, request):
print(request.path)
response = self.get_response(request)
return response

```

Every requested URL is printed to the console.

### Execution Time Middleware

```

import time
class TimerMiddleware:
def __init__(self, get_response):
self.get_response = get_response
def __call__(self, request):
start = time.time()
response = self.get_response(request)
end = time.time()
print(end - start)
return response

```

This middleware measures how long each request takes to process.

### Blocking Specific IP Addresses

```

from django.http import HttpResponse
class BlockIPMiddleware:
def __init__(self, get_response):
self.get_response = get_response
def __call__(self, request):
blocked = [
"192.168.1.100"
]
ip = request.META.get("REMOTE_ADDR")
if ip in blocked:
return HttpResponse(
"Access Denied"
)
return self.get_response(request)

```

This middleware prevents requests from specified IP addresses.

## Middleware vs Decorators

Although both middleware and decorators modify request handling, they serve different purposes. Feature Middleware Decorator Scope Entire application Individual view Execution Every request Specific view only Configuration settings.py Applied directly to views Best Use Global functionality View-specific behavior **Example of a Decorator**

```

from django.contrib.auth.decorators import login_required
@login_required
def dashboard(request):
return render(request, "dashboard.html")

```

The `login_required` decorator protects only the `dashboard` view, whereas middleware can apply similar logic across the whole application.

## Best Practices for Using Middleware

### Keep Middleware Lightweight

Since middleware runs on every request, avoid expensive operations such as heavy database queries or complex calculations.

### Maintain Correct Order

Arrange middleware carefully in settings.py because many components depend on the order in which they execute.

### Use Built-in Middleware Whenever Possible

Django\'s built-in middleware is well-tested and optimized. Prefer it over custom implementations unless additional functionality is required.

### Avoid Business Logic

Middleware should handle cross-cutting concerns like security, logging, and request processing—not application-specific business logic.

### Test Custom Middleware

Verify that custom middleware behaves correctly under different scenarios and does not negatively impact performance or security.

## Advantages and Limitations of Middleware

### Advantages

- Centralizes common functionality.

- Reduces code duplication.

- Improves maintainability.

- Enhances application security.

- Simplifies request and response processing.

- Can modify requests and responses globally.

### Limitations

- Runs on every request, which can affect performance if poorly implemented.

- Incorrect ordering may lead to unexpected behavior.

- Not suitable for view-specific business logic.

- Complex middleware can make debugging more challenging.

### Conclusion

Middleware is a fundamental component of Django that processes requests before they reach views and responses before they are returned to clients. It enables developers to implement application-wide functionality such as authentication, security, session management, logging, caching, and custom request processing in a clean and reusable manner. By understanding the request-response cycle, the purpose of Django\'s built-in middleware, and the process of creating custom middleware, we can build web applications that are more secure, maintainable, and efficient. Following best practices—such as keeping middleware lightweight, using the correct execution order, and reserving it for cross-cutting concerns—ensures that our Django applications remain scalable and perform reliably.');

-- Lecture 11: User Authentication & Permissions
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'User Authentication & Permissions', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# User Authentication & Permissions

## Introduction to User Authentication & Permissions

### What is Authentication?

Authentication is the process of verifying the identity of a user. Before allowing someone to access protected resources in a web application, the system must first answer the question: **"Who are you?"** In Django, authentication is handled by the built-in **Authentication Framework**, which provides a secure and flexible way to manage users, passwords, login sessions, and permissions. Instead of building an authentication system from scratch, Django offers a ready-made solution that follows modern security practices. For example, when a user enters a username and password, Django checks whether those credentials match a registered user in the database. If they do, the user is authenticated and can access protected parts of the application.

### What is Authorization?

Authentication and authorization are often confused, but they serve different purposes.

- **Authentication** identifies the user.

- **Authorization** determines what the authenticated user is allowed to do.

Imagine entering a university building:

- Showing your student ID proves **who you are** (authentication).

- Accessing the library, laboratories, or faculty offices depends on your **permissions** (authorization).

Authentication comes first. Authorization follows.

### Why Are Authentication and Permissions Important?

Without authentication, anyone could access private data. Without permissions, every user would have unrestricted control over the application. A secure authentication system provides:

- User identity verification

- Password protection

- Secure login sessions

- Role-based access control

- Data privacy

- Protection against unauthorized access

These features are essential for applications such as online banking, e-commerce platforms, learning management systems, hospital management systems, and social media websites.

## Django Authentication System

### The Django Authentication Framework

Django includes a complete authentication framework within the `django.contrib.auth` application. It provides:

- User model

- Login functionality

- Logout functionality

- Password hashing

- Permission management

- Groups

- User sessions

- Authentication middleware

To enable authentication, include the following apps in `INSTALLED_APPS`:

```

INSTALLED_APPS = [
"django.contrib.admin",
"django.contrib.auth",
"django.contrib.contenttypes",
"django.contrib.sessions",
"django.contrib.messages",
"django.contrib.staticfiles",
]

```

After adding these applications, run migrations: `python manage.py migrate` This creates all required authentication-related database tables.

### The Built-in User Model

Django provides a default `User` model with common fields. Important fields include: Field Description username Unique username first_name User\'s first name last_name User\'s last name email Email address password Encrypted password Whether the account is is_active active is_staff Access to Django Admin Full administrative is_superuser privileges date_joined Registration date last_login Last login time Passwords are never stored in plain text. Django automatically hashes passwords using secure algorithms.

### Creating a Superuser

A superuser has complete access to the Django Admin panel. Create one using:

```

python manage.py createsuperuser

```

Example:

```

Username: admin
Email: admin@example.com
Password: ********

```

Run the server: `python manage.py runserver` Visit: `http://127.0.0.1:8000/admin/` Log in using the superuser credentials.

## User Registration, Login, and Logout

### Creating a New User

The recommended way to create a user is:

```

from django.contrib.auth.models import User
username="john",
email="john@example.com",
password="StrongPassword123"
)

```

Using `create_user()` ensures the password is hashed before storage.

### Authenticating a User

Use the `authenticate()` function to verify credentials.

```

from django.contrib.auth import authenticate
user = authenticate(
username="john",
password="StrongPassword123"
)

```

If the credentials are correct: `print(user)` Otherwise: `None`

### Logging In

Once authenticated, log the user into the current session.

```

from django.contrib.auth import login
login(request, user)

```

Django automatically creates a session and remembers the user until logout or session expiration.

### Logging Out

To log out:

```

from django.contrib.auth import logout
logout(request)

```

This removes the user\'s session information.

### Checking Authentication Status

Determine whether a user is logged in:

```

if request.user.is_authenticated:
print("User is logged in")
else:
print("Anonymous User")

```

This property is widely used in views and templates.

## Permissions and User Authorization

### What Are Permissions?

Permissions define which actions users can perform on models. Django automatically creates four default permissions for each model:

- Add

- Change

- Delete

- View

For a `Student` model, Django generates:

- `add_student`

- `change_student`

- `delete_student`

- `view_student`

### Checking Permissions

Use the `has_perm()` method:

```

if request.user.has_perm("school.add_student"):
print("Permission Granted")

```

Otherwise: `print("Permission Denied")`

### Adding Custom Permissions

Custom permissions can be defined inside a model.

```

class Student(models.Model):
name = models.CharField(max_length=100)
class Meta:
permissions = [
("can_publish", "Can Publish Student Data"),
]

```

Run:

```

python manage.py makemigrations
python manage.py migrate

```

The new permission becomes available in the Django Admin panel.

### Assigning Permissions

Grant a permission:

```

from django.contrib.auth.models import Permission
permission = Permission.objects.get(
codename="add_student"
)
user.user_permissions.add(permission)

```

Remove a permission:

```

user.user_permissions.remove(permission)

```

## User Groups and Role-Based Access Control

### What Are Groups?

Groups simplify permission management by assigning permissions to a collection of users. Instead of granting permissions individually, assign users to groups. Example groups:

- Students

- Teachers

- Librarians

- Managers

- Administrators

Each group can have its own permissions.

### Creating a Group

```

from django.contrib.auth.models import Group
teachers = Group.objects.create(
name="Teachers"
)

```

### Adding Permissions to a Group

```

teachers.permissions.add(permission)

```

Now every member of the "Teachers" group inherits that permission.

### Adding Users to Groups

`user.groups.add(teachers)` Remove a user: `user.groups.remove(teachers)`

### Checking Group Membership

```

if request.user.groups.filter(
name="Teachers"
).exists():
print("Teacher Logged In")

```

This is useful for role-based access control throughout an application.

## Protecting Views with Authentication

### Using the Decorator

`login_required` Protect function-based views by requiring authentication.

```

from django.contrib.auth.decorators import login_required
@login_required
def dashboard(request):
return render(request, "dashboard.html")

```

Anonymous users are redirected to the login page. Configure the login URL in settings.py: `LOGIN_URL = "/login/"`

### Using

`LoginRequiredMixin` For class-based views:

```

from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView
class StudentListView(
LoginRequiredMixin,
ListView
):
model = Student

```

Only authenticated users can access the view.

### PermissionRequiredMixin

Require a specific permission for a class-based view.

```

from django.contrib.auth.mixins import PermissionRequiredMixin
class StudentCreateView(
PermissionRequiredMixin,
CreateView
):
permission_required = "school.add_student"

```

Users without the required permission receive an access-denied response.

## Authentication in Django Templates

Templates can display different content based on authentication status.

```

{% if user.is_authenticated %}
<h2>Welcome {{ user.username }}</h2>
{% else %}
<a href="/login/">Login</a>
{% endif %}

```

This improves user experience by showing appropriate navigation and content.

### Displaying User Information

```

{{ user.username }}
{{ user.email }}
{{ user.first_name }}
{{ user.last_name }}

```

These variables are automatically available when the authentication context processor is enabled.

### Logout Link

```

<a href="{% url \'logout\' %}">
Logout
</a>

```

A common practice is to display this link only for authenticated users.

## Password Security and Best Practices

### Password Hashing

Passwords are stored as secure hashes, not plain text. Never save passwords manually like this: `user.password = "mypassword"` Instead, use:

```

user.set_password("mypassword")
user.save()

```

This ensures the password is hashed securely.

### Changing Passwords

```

user.set_password("NewPassword123")
user.save()

```

Django automatically updates the password hash.

### Password Validation

Django supports password validation rules such as:

- Minimum length

- Common password detection

- Numeric-only password prevention

- Similarity checks against user information

Example configuration:

```

AUTH_PASSWORD_VALIDATORS = [
{
"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
},
]

```

These validators help enforce stronger passwords.

## Best Practices for Authentication and Permissions

**Use Django\'s Built-in Authentication System** Avoid creating custom authentication logic unless your project has unique requirements. **Hash Passwords Properly** Always use `create_user()` or `set_password()` to ensure passwords are securely hashed. **Apply the Principle of Least Privilege** Grant users only the permissions they need to perform their tasks. Avoid assigning unnecessary administrative rights. **Protect Sensitive Views** Use `login_required`, `LoginRequiredMixin`, or `PermissionRequiredMixin` to secure pages that should not be publicly accessible. **Organize Users with Groups** Assign permissions to groups instead of individual users whenever possible. This simplifies management as your application grows. **Keep User Data Secure** Always use HTTPS in production, validate user input, and protect against common web vulnerabilities such as CSRF and session hijacking.

### Conclusion

Django\'s authentication and permission system provides a comprehensive foundation for building secure web applications. Authentication verifies user identities, while authorization ensures users can only perform actions they are permitted to do. By leveraging Django\'s built-in `User` model, secure password hashing, groups, permissions, decorators, and mixins, we can develop applications that are both secure and maintainable. Following best practices—such as using role-based access control, protecting sensitive views, and applying the principle of least privilege—helps ensure that our applications safeguard user data while delivering a seamless and reliable user experience.');

-- Lecture 12: Django REST Framework (DRF)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Django REST Framework (DRF)', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Django REST Framework (DRF)

## Introduction to Django REST Framework

### What is Django REST Framework?

**Django REST Framework (DRF)** is a powerful and flexible toolkit used for building **Web APIs** with Django. It extends Django by providing tools that make it easy to create, test, and manage RESTful APIs. An **API (Application Programming Interface)** allows different software applications to communicate with each other. For example:

- A mobile app communicates with a Django backend through an API.

- A React or Vue frontend retrieves data from a Django server using an API.

- Third-party applications can access your services through APIs.

Without DRF, developers would need to manually convert Python objects into JSON and handle HTTP requests. DRF automates these tasks and provides many additional features.

### Why Use Django REST Framework?

Django REST Framework offers several advantages:

- Easy API development

- Automatic serialization of data

- Built-in authentication and permissions

- Browsable API interface

- Support for CRUD operations

- Validation of incoming data

- Pagination, filtering, and searching

- Token and JWT authentication support

- Excellent documentation and community support

These features make DRF one of the most popular frameworks for building RESTful APIs in Python.

### What is REST?

**REST (Representational State Transfer)** is an architectural style for designing web services. REST uses standard HTTP methods to perform operations on resources. HTTP Method Action CRUD Operation GET Retrieve data Read POST Create new data Create PUT Update all fields Update PATCH Update selected fields Partial Update DELETE Remove data Delete For example: `GET /students/` Returns all students. `POST /students/` Creates a new student.

## Installing and Setting Up Django REST Framework

### Installation

Install DRF using pip:

```

pip install djangorestframework

```

### Adding DRF to Django

Include DRF in `INSTALLED_APPS`.

```

INSTALLED_APPS = [
"django.contrib.admin",
"django.contrib.auth",
"django.contrib.contenttypes",
"django.contrib.sessions",
"django.contrib.messages",
"django.contrib.staticfiles",
"rest_framework",
]

```

Run migrations if necessary: `python manage.py migrate`

### Creating a Sample Model

Example:

```

from django.db import models
class Student(models.Model):
name = models.CharField(max_length=100)
age = models.IntegerField()
email = models.EmailField()
def __str__(self):
return self.name

```

Create migrations:

```

python manage.py makemigrations
python manage.py migrate

```

## Serializers in Django REST Framework

### What is a Serializer?

A **Serializer** converts Django model instances into JSON and converts JSON data back into Python objects. Think of a serializer as a translator:

- Django Model → JSON

- JSON → Django Model

Without serializers, APIs cannot communicate effectively with clients.

### Creating a Serializer

```

from rest_framework import serializers
from .models import Student
class StudentSerializer(serializers.ModelSerializer):
class Meta:
model = Student
fields = "__all__"

```

Here:

- `ModelSerializer` automatically creates serializer fields.

- `fields="__all__"` includes every model field.

### Serializer Validation

Validation ensures incoming data is correct. Example:

```

class StudentSerializer(serializers.ModelSerializer):
class Meta:
model = Student
fields = "__all__"
def validate_age(self, value):
if value < 18:
raise serializers.ValidationError(
"Age must be at least 18."
)
return value

```

If invalid data is submitted, DRF returns an appropriate error response.

### Manual Serializer

Instead of `ModelSerializer`, we can define fields manually.

```

class StudentSerializer(serializers.Serializer):
name = serializers.CharField()
age = serializers.IntegerField()
email = serializers.EmailField()

```

Manual serializers are useful when data does not directly correspond to a database model.

## API Views in Django REST Framework

### APIView

`APIView` is the basic class for building REST APIs. Example:

```

from rest_framework.views import APIView
from rest_framework.response import Response
class StudentAPIView(APIView):
def get(self, request):
students = Student.objects.all()
serializer = StudentSerializer(
students,
many=True
)
return Response(serializer.data)

```

The `Response` object automatically returns JSON.

### Handling POST Requests

```

class StudentAPIView(APIView):
def post(self, request):
serializer = StudentSerializer(
data=request.data
)
if serializer.is_valid():
serializer.save()
return Response(serializer.data)
return Response(serializer.errors)

```

This creates a new student record.

### Function-Based API Views

DRF also supports function-based views.

```

from rest_framework.decorators import api_view
@api_view(["GET"])
def student_list(request):
students = Student.objects.all()
serializer = StudentSerializer(
students,
many=True
)
return Response(serializer.data)

```

## Generic Views and ViewSets

### Generic API Views

DRF provides generic views that reduce boilerplate code. Example:

```

from rest_framework import generics
class StudentListCreateView(
generics.ListCreateAPIView
):
queryset = Student.objects.all()
serializer_class = StudentSerializer

```

This single class automatically supports:

- GET

- POST

### Retrieve, Update, Delete View

```

class StudentDetailView(
generics.RetrieveUpdateDestroyAPIView
):
queryset = Student.objects.all()
serializer_class = StudentSerializer

```

Supports:

- GET

- PUT

- PATCH

- DELETE

A ViewSet combines multiple actions into one class.

```

from rest_framework import viewsets
class StudentViewSet(
viewsets.ModelViewSet
):
queryset = Student.objects.all()
serializer_class = StudentSerializer

```

`ModelViewSet` provides:

- List

- Create

- Retrieve

- Update

- Partial Update

- Delete

### Routers

Instead of manually creating URLs, routers generate them automatically.

```

from rest_framework.routers import DefaultRouter
router = DefaultRouter()
router.register(
"students",
StudentViewSet
)
urlpatterns = router.urls

```

Generated URLs include:

```

/students/
/students/1/

```

## Authentication and Permissions in DRF

### Authentication

Authentication identifies the user making the API request. DRF supports multiple authentication methods:

- Session Authentication

- Basic Authentication

- Token Authentication

- JWT Authentication

Example:

```

REST_FRAMEWORK = {
"DEFAULT_AUTHENTICATION_CLASSES": [
"rest_framework.authentication.SessionAuthentication",
"rest_framework.authentication.BasicAuthentication",
]
}

```

### Permissions

Permissions determine what authenticated users are allowed to do. Example:

```

from rest_framework.permissions import IsAuthenticated
class StudentViewSet(
viewsets.ModelViewSet
):
permission_classes = [
IsAuthenticated
]

```

Only logged-in users can access this API.

### Common Permission Classes

Permission Description AllowAny Everyone can access IsAuthenticated Only authenticated users IsAdminUser Only administrators IsAuthenticatedOrReadO Read for everyone, write nly for authenticated users

### Custom Permissions

Example:

```

from rest_framework.permissions import BasePermission
class IsTeacher(BasePermission):
def has_permission(
self,
request,
view
):
return request.user.is_staff

```

Use it:

```

permission_classes = [IsTeacher]

```

## Filtering, Searching, and Pagination

### Filtering

Enable filtering:

```

REST_FRAMEWORK = {
"DEFAULT_FILTER_BACKENDS": [
"django_filters.rest_framework.DjangoFilterBackend",
]
}

```

View: `filterset_fields = ["age"]` Example: `GET /students/?age=20`

### Searching

```

search_fields = [
"name",
"email"
]

```

Request: `GET /students/?search=Ali`

### Ordering

```

ordering_fields = [
"name",
"age"
]

```

Example: `GET /students/?ordering=age` Descending: `GET /students/?ordering=-age`

### Pagination

Example configuration:

```

REST_FRAMEWORK = {
"DEFAULT_PAGINATION_CLASS":
"rest_framework.pagination.PageNumberPagination",
"PAGE_SIZE": 10,
}

```

Each page returns only ten records.

## API Responses and Status Codes

### Response Object

Always use DRF\'s `Response`.

```

return Response(serializer.data)

```

It automatically converts Python objects into JSON.

### Status Codes

DRF provides readable HTTP status constants.

```

from rest_framework import status

```

Example:

```

return Response(
serializer.data,
status=status.HTTP_201_CREATED
)

```

Common status codes: Code Meaning 200 OK 201 Created 204 No Content 400 Bad Request 401 Unauthorized 403 Forbidden 404 Not Found 500 Internal Server Error

### Error Responses

Example:

```

return Response(
serializer.errors,
status=status.HTTP_400_BAD_REQUEST
)

```

Clients receive detailed validation errors in JSON format.

## Best Practices for Django REST Framework

### Use ModelSerializers Whenever Possible

They reduce repetitive code and automatically generate serializer fields based on models.

### Use ViewSets and Routers

They simplify URL configuration and provide complete CRUD functionality with minimal code.

### Validate Input Data

Always validate incoming data through serializers before saving it to the database.

### Protect APIs

Apply appropriate authentication and permission classes to prevent unauthorized access.

### Use Pagination

Limit the number of records returned in each response to improve performance and user experience.

### Optimize Database Queries

Use Django ORM features such as `select_related()` and `prefetch_related()` to reduce unnecessary database queries and improve API efficiency.

### Return Appropriate Status Codes

Use meaningful HTTP status codes so clients can correctly interpret the result of each request.

### Write Clear API Documentation

Well-documented APIs are easier to understand, maintain, and integrate with frontend or third-party applications.

### Conclusion

Django REST Framework is a robust toolkit for building secure, scalable, and maintainable RESTful APIs in Django. It simplifies API development through serializers, generic views, ViewSets, routers, authentication, permissions, filtering, pagination, and standardized responses. By leveraging DRF\'s built-in features and following best practices, we can rapidly develop high-quality APIs that serve web applications, mobile apps, and external services efficiently. Mastering Django REST Framework is an essential skill for modern Django developers, enabling them to build professional backend systems that are secure, performant, and easy to extend.');

-- Lecture 13: Caching & Background Tasks (Celery)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Caching & Background Tasks (Celery)', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Caching & Background Tasks (Celery)

## Introduction to Caching and Background Tasks

### What is Caching?

**Caching** is the process of storing frequently used data in a temporary storage area (called a **cache**) so it can be retrieved much faster than fetching it from its original source, such as a database. Imagine visiting a library every day to read the same book. Instead of walking to the shelf each time, you keep the book on your desk. The next time you need it, you can access it immediately. This is exactly how caching works in web applications. For example, if a webpage requires a database query that takes **3 seconds**, storing the result in the cache may reduce future requests to just **50 milliseconds**.

### Why Do We Need Caching?

Caching improves the performance of web applications by reducing unnecessary work. Benefits include:

- Faster page loading

- Reduced database queries

- Lower server load

- Better user experience

- Improved scalability

- Lower infrastructure costs

Large websites such as Facebook, Instagram, Amazon, and YouTube rely heavily on caching to serve millions of users efficiently.

### What are Background Tasks?

A **background task** is a job that runs separately from the main web request. Instead of making users wait until a long operation finishes, the application immediately responds while the task continues in the background. Examples include:

- Sending emails

- Processing uploaded images

- Generating PDF reports

- Exporting data

- Sending SMS notifications

- Creating backups

- Processing videos

These operations are ideal for background processing because they do not require an immediate response to the user.

### Why Use Celery?

**Celery** is a distributed task queue for Python that executes background jobs asynchronously. Instead of performing time-consuming work during an HTTP request, Celery sends the task to a worker process. Advantages include:

- Faster response times

- Asynchronous task execution

- Scheduled tasks

- Retry mechanisms

- Distributed processing

- Scalability across multiple workers

## Django Caching

### How Caching Works

Without caching:

```

User
│
▼
Django
│
▼
Database
│
▼
Response

```

Every request accesses the database. With caching:

```

User
│
▼
Django
│
▼
Cache
│
├── Cache Hit → Response
│
└── Cache Miss
│
▼
Database
│
▼
Store in Cache
│
▼
Response

```

If the requested data exists in the cache (**cache hit**), Django returns it immediately. Otherwise (**cache miss**), Django fetches it from the database and stores it in the cache for future requests.

### Types of Caching in Django

Django supports several caching strategies:

- Per-site caching

- Per-view caching

- Template fragment caching

- Low-level caching

Each strategy serves different performance needs.

### Configuring Cache

Example using local memory cache:

```

CACHES = {
"default": {
"BACKEND": "django.core.cache.backends.locmem.LocMemCache",
"LOCATION": "unique-cache",
}
}

```

For production, Redis or Memcached is generally preferred because they support distributed caching.

## Per-Site, Per-View, and Low-Level Caching

### Per-Site Caching

This caches the entire website. Example:

```

MIDDLEWARE = [
"django.middleware.cache.UpdateCacheMiddleware",
"django.middleware.common.CommonMiddleware",
"django.middleware.cache.FetchFromCacheMiddleware",
]

```

Configure cache duration:

```

CACHE_MIDDLEWARE_SECONDS = 600

```

The website is cached for **10 minutes**.

### Per-View Caching

Only specific views are cached. Example:

```

from django.views.decorators.cache import cache_page
@cache_page(60 * 15)
def home(request):
...

```

This view is cached for **15 minutes**.

### Template Fragment Caching

Cache only a portion of a template.

```

{% load cache %}
{% cache 300 sidebar %}
<h3>Popular Posts</h3>
{% endcache %}

```

Only the sidebar is cached.

### Low-Level Cache API

Store data manually.

```

from django.core.cache import cache
cache.set(
"username",
"Ali",
timeout=300
)

```

Retrieve: `cache.get("username")` Delete: `cache.delete("username")` Clear all: `cache.clear()`

## Cache Backends

### Local Memory Cache

`LocMemCache` Advantages:

- Easy to configure

- Fast

- Good for development

Limitations:

- Not shared between multiple servers

- Data is lost when the server restarts

### File-Based Cache

Stores cached data in files. `FileBasedCache` Suitable for small projects but slower than memory-based solutions.

### Database Cache

Stores cached data in a database table. Advantages:

- Persistent

- Easy setup

Disadvantages:

- Slower than Redis or Memcached

- Increases database workload

### Redis Cache

Redis is the most popular caching backend for Django. Advantages:

- Extremely fast

- Supports millions of operations per second

- Persistent storage (optional)

- Shared across multiple servers

- Also serves as a Celery message broker

Redis is commonly used in production environments.

### Memcached

Memcached stores data entirely in memory. Advantages:

- Very fast

- Lightweight

- Ideal for distributed caching

Unlike Redis, it focuses only on caching and does not provide advanced data structures.

## Introduction to Celery

### What is Celery?

Celery is an asynchronous task queue that allows long-running tasks to execute outside the main request-response cycle. Instead of this:

```

User
│
▼
Request
│
▼
Send Email
│
▼
Response

```

Celery performs:

```

User
│
▼
Request
│
▼
Queue Task
│
▼
Immediate Response
Background Worker
│
▼
Send Email

```

The user receives a response immediately while the background worker completes the email task.

### Installing Celery

Install Celery: `pip install celery` Install Redis client: `pip install redis` Redis is commonly used as the message broker.

### Creating Celery Configuration

Create celery.py.

```

from celery import Celery
app = Celery("project")
app.config_from_object(
"django.conf:settings",
namespace="CELERY"
)
app.autodiscover_tasks()

```

### Celery Settings

Example:

```

CELERY_BROKER_URL = "redis://127.0.0.1:6379/0"
CELERY_RESULT_BACKEND = "redis://127.0.0.1:6379/0"

```

The broker sends tasks to workers, while the result backend stores task outcomes.

## Creating and Executing Celery Tasks

### Creating a Task

Create tasks.py.

```

from celery import shared_task
@shared_task
def send_email():
print("Email Sent")

```

The `@shared_task` decorator registers the function as a Celery task.

### Running a Task

Execute asynchronously: `send_email.delay()` The task is placed into the queue and processed by a worker.

### Passing Arguments

```

@shared_task
def add(x, y):
return x + y

```

Run: `add.delay(5, 10)` Output: `15`

### Running Celery Worker

Start a worker:

```

celery -A project worker -l info

```

The worker continuously monitors the queue for new tasks.

## Periodic Tasks with Celery Beat

### What is Celery Beat?

Celery Beat is a scheduler that executes tasks automatically at specified intervals. Examples:

- Daily email reports

- Weekly database backups

- Monthly invoices

- Hourly data synchronization

### Scheduling Tasks

Example:

```

CELERY_BEAT_SCHEDULE = {
"daily-report": {
"task": "app.tasks.send_report",
"schedule": 86400,
},
}

```

This task executes every **24 hours**.

### Starting Celery Beat

```

celery -A project beat -l info

```

Celery Beat works together with Celery workers.

## Best Practices for Caching and Celery

### Cache Only Frequently Accessed Data

Avoid caching rarely used or rapidly changing information, as it may waste memory and provide little performance benefit.

### Choose Appropriate Cache Timeouts

Very short timeouts reduce caching benefits, while very long timeouts can lead to stale data. Select expiration times based on how frequently the data changes.

### Invalidate Cache When Data Changes

Clear or update cached data whenever the underlying database records are modified to ensure users receive accurate information.

### Use Redis in Production

Redis offers excellent performance for both caching and as a Celery message broker, making it a common production choice.

### Keep Celery Tasks Small

Design tasks to perform one clear responsibility. Smaller tasks are easier to monitor, retry, and maintain.

### Avoid Long Blocking Operations in Views

Move operations such as sending emails, image processing, report generation, and external API calls to Celery tasks to keep web requests responsive.

### Implement Retries for Temporary Failures

Configure retries for tasks that depend on external services, such as email providers or payment gateways, to improve reliability.

### Monitor Workers

Regularly monitor Celery workers and queues to detect failures, excessive task backlogs, or performance issues.

## Advantages and Limitations

### Advantages of Caching

- Faster application performance

- Reduced database load

- Lower server resource usage

- Improved scalability

- Better user experience

### Advantages of Celery

- Asynchronous processing

- Faster HTTP responses

- Scheduled task execution

- Automatic retries

- Scalable distributed task processing

### Limitations

- Adds infrastructure complexity

- Requires additional services such as Redis or RabbitMQ for production

- Cached data can become outdated if not invalidated correctly

- Celery workers must be running continuously to process queued tasks

### Conclusion

Caching and background task processing are essential techniques for building high-performance Django applications. Caching reduces response times by storing frequently accessed data in fast storage, minimizing repeated database queries and server workload. Celery complements this by executing long-running operations asynchronously, ensuring users receive immediate responses while time-intensive tasks are handled in the background. Together with tools like Redis and Celery Beat, Django developers can create applications that are faster, more scalable, and more responsive. By applying appropriate caching strategies, using efficient cache backends, designing focused Celery tasks, and following best practices for cache invalidation and worker management, we can build reliable systems capable of supporting modern web applications at scale.');

-- Lecture 14: Building a Django Web Application
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building a Django Web Application', 14, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building a Django Web Application

## Introduction to Building a Django Web Application

### What is a Django Web Application?

A **Django Web Application** is a dynamic website developed using the Django framework, where users can interact with data stored in a database. Django follows the **Model-View-Template (MVT)** architecture, making web development organized, scalable, and secure. Unlike static websites that only display fixed content, Django applications allow users to perform actions such as:

- Registering accounts

- Logging in

- Submitting forms

- Managing products

- Posting blogs

- Shopping online

- Booking appointments

- Managing student records

Examples of Django web applications include:

- E-commerce websites

- School Management Systems

- Hospital Management Systems

- Library Management Systems

- Blogging platforms

- Online Learning Systems

Django provides built-in tools that significantly reduce development time while maintaining security and performance.

### Why Use Django for Web Development?

Django is one of the most popular Python web frameworks because it offers:

- Rapid development

- Secure authentication

- Built-in Admin Panel

- Powerful ORM

- Template Engine

- URL Routing

- Form Handling

- Session Management

- Middleware

- Scalability

Many well-known organizations use Django because of its reliability and flexibility.

### Development Workflow

Building a Django web application typically follows these steps:

```

Project Planning
│
▼
Create Django Project
│
▼
Create Application
│
▼
Design Models
│
▼
Run Migrations
│
▼
Create Views
│
▼
Configure URLs
│
▼
Create Templates
│
▼
Add Static Files
│
▼
Test Application
│
▼
Deploy Project

```

Following a structured workflow helps maintain code quality and simplifies future updates.

## Creating a Django Project

### Installing Django

Install Django using pip: `pip install django` Verify installation: `django-admin --version`

### Creating a New Project

Create a Django project:

```

django-admin startproject myproject

```

Navigate into the project folder: `cd myproject` Project structure:

```

myproject/
│
├── manage.py
│
├── myproject/
│ ├── settings.py
│ ├── urls.py
│ ├── asgi.py
│ ├── wsgi.py
│ └── __init__.py

```

### Running the Development Server

Start the server: `python manage.py runserver` Visit: `http://127.0.0.1:8000/` The default Django welcome page confirms that the project has been set up correctly.

### Creating an Application

Create a new app:

```

python manage.py startapp students

```

Register it in settings.py:

```

INSTALLED_APPS = [
...
"students",
]

```

Applications divide a project into manageable, reusable modules.

## Models and Database Design

### Creating Models

Models define the structure of the database. Example:

```

from django.db import models
class Student(models.Model):
name = models.CharField(max_length=100)
age = models.IntegerField()
email = models.EmailField()
def __str__(self):
return self.name

```

Each field becomes a database column.

### Creating Database Tables

Generate migrations:

```

python manage.py makemigrations

```

Apply migrations: `python manage.py migrate` Django automatically creates the corresponding database tables.

### Using Django ORM

Create a record:

```

Student.objects.create(
name="Ali",
age=21,
email="ali@example.com"
)

```

Retrieve all students: `Student.objects.all()` Update a student:

```

student = Student.objects.get(id=1)
student.age = 22
student.save()

```

Delete a student: `student.delete()` The ORM eliminates the need to write raw SQL for common database operations.

## Views, URLs, and Templates

### Creating Views

Views contain the application\'s business logic. Example:

```

from django.shortcuts import render
def home(request):
return render(
request,
"home.html"
)

```

The view processes the request and returns a response.

### Configuring URLs

Create urls.py inside the app:

```

from django.urls import path
from . import views
urlpatterns = [
path("", views.home)
]

```

Include app URLs in the project:

```

from django.urls import include, path
urlpatterns = [
path(
"",
include("students.urls")
)
]

```

This connects URLs to their corresponding views.

### Templates

Create: `templates/home.html` Example:

```

<!DOCTYPE html>
<html>
<head>
<title>Home</title>
</head>
<body>
<h1>Welcome to Django</h1>
</body>
</html>

```

Templates separate presentation from application logic.

### Passing Data to Templates

View:

```

def home(request):
context = {
"name": "Ali"
}
return render(
request,
"home.html",
context
)

```

Template:

```

<h2>Hello {{ name }}</h2>

```

Dynamic data is displayed using Django Template Language (DTL).

## Forms and User Input

### HTML Forms

Example:

```

<form method="POST">
{% csrf_token %}
<input
type="text"
name="name">
<button>
Submit
</button>

```

The CSRF token protects against Cross-Site Request Forgery attacks.

### Handling Form Data

```

def home(request):
if request.method == "POST":
name = request.POST["name"]
print(name)
return render(
request,
"home.html"
)

```

The submitted value is available in request.POST.

### Django Forms

Example:

```

from django import forms
class StudentForm(forms.Form):
name = forms.CharField()
age = forms.IntegerField()

```

Benefits include:

- Validation

- Cleaner code

- Automatic HTML generation

- Error handling

## User Authentication

### Creating Users

```

from django.contrib.auth.models import User
User.objects.create_user(
username="john",
password="password123"
)

```

Passwords are securely hashed before storage.

### Login

```

from django.contrib.auth import authenticate
user = authenticate(
username="john",
password="password123"
)

```

If authentication succeeds:

```

from django.contrib.auth import login
login(request, user)

```

### Logout

```

from django.contrib.auth import logout
logout(request)

```

The user\'s session is terminated.

### Protecting Views

```

from django.contrib.auth.decorators import login_required
@login_required
def dashboard(request):
return render(
request,
"dashboard.html"
)

```

Only authenticated users can access the dashboard.

## Static Files and Media Files

### Static Files

Static files include:

- CSS

- JavaScript

- Images

- Fonts

Configuration: `STATIC_URL = "static/"` Load static files:

```

{% load static %}

```

Example:

```

<link
rel="stylesheet"
href="{% static \'css/style.css\' %}">

```

### Media Files

Media files are uploaded by users. Configuration: `MEDIA_URL = "/media/"` Model example:

```

image = models.ImageField(
upload_to="students/"
)

```

Uploaded files are stored in the specified media directory.

## Django Admin Panel

### Registering Models

```

from django.contrib import admin
from .models import Student
admin.site.register(Student)

```

The model now appears in the Django Admin interface.

### Creating a Superuser

```

python manage.py createsuperuser

```

Access: `http://127.0.0.1:8000/admin/` The admin panel enables administrators to manage application data without writing custom management pages.

### Customizing Admin

```

@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
list_display = [
"name",
"age",
"email"
]

```

This improves the display and usability of the admin interface.

## Testing, Deployment, and Best Practices

### Testing

Run tests: `python manage.py test` Testing helps identify bugs before deployment.

### Deployment Checklist

Before deploying:

- Set `DEBUG = False`

- Configure `ALLOWED_HOSTS`

- Use a production database

- Collect static files

- Configure HTTPS

- Protect secret keys

- Perform security checks

Collect static files:

```

python manage.py collectstatic

```

### Best Practices

**Organize Code Properly** Separate models, views, templates, forms, and static files into logical directories for easier maintenance. **Reuse Components** Create reusable apps whenever possible to reduce duplication and simplify future projects. **Validate User Input** Always validate data submitted by users using Django Forms or ModelForms to improve security and data integrity. **Secure Your Application** Use Django\'s built-in authentication, CSRF protection, password hashing, and permissions to safeguard user data. **Optimize Database Queries** Use the Django ORM efficiently with methods like `select_related()` and `prefetch_related()` to improve application performance. **Write Tests Regularly** Automated tests help ensure that new changes do not break existing functionality. **Follow Django\'s Conventions** Adhering to Django\'s recommended project structure and coding standards makes applications easier to understand, maintain, and scale.

### Conclusion

Building a Django web application involves combining several core components into a cohesive system. Starting with project creation and application setup, developers design models to represent data, create views to process requests, configure URLs for navigation, and use templates to generate dynamic web pages. Django\'s built-in support for forms, authentication, static and media files, the administrative interface, and security features greatly simplifies development while promoting best practices. By following a structured workflow, validating user input, optimizing database interactions, writing tests, and preparing applications properly for deployment, we can develop secure, scalable, and maintainable web applications that meet real-world business and user requirements.

### Building a Django Web Application (Flower Café Management System)

**Project: Bloom & Brew Café Management System Goal:** By the end of this project, we will build a complete Django web application where café staff can manage menu items, flower bouquets, customer orders, reservations, and users through a beautiful web interface.

### Project Features

By the end of this project, our application will include:

- User Login & Logout

- Dashboard

- Menu Management (Coffee, Tea, Desserts)

- Flower Collection Management

- Customer Management

- Table Reservations

- Customer Orders

- Order Details

- Admin Panel

- Search Functionality

- Image Upload

- Responsive UI

### Database Design

Our project will have the following models:

```

Users
│
├── Customers
│
├── Flowers
│
├── Café Menu
│
├── Reservations
│
├── Orders
│
└── Order Items

```

## Step 1 – Create the Django Project

Install Django. `pip install django` Create project.

```

django-admin startproject bloombrew

```

Enter project. `cd bloombrew` Run server. `python manage.py runserver`

## Step 2 – Create the Application

Create an app.

```

python manage.py startapp cafe

```

Register it.

```

INSTALLED_APPS = [
...
"cafe",
]

```

## Step 3 – Design the Database

Instead of only one model, we\'ll create a complete café system.

### Customer Model

```

class Customer(models.Model):
first_name = models.CharField(max_length=50)
last_name = models.CharField(max_length=50)
email = models.EmailField(unique=True)
phone = models.CharField(max_length=20)
def __str__(self):
return self.first_name

```

### Flower Model

Every flower sold inside the café.

```

class Flower(models.Model):
name = models.CharField(max_length=100)
color = models.CharField(max_length=50)
price = models.DecimalField(
max_digits=8,
decimal_places=2
)
stock = models.PositiveIntegerField()
image = models.ImageField(
upload_to="flowers/"
)
def __str__(self):
return self.name

```

### Menu Item Model

```

class MenuItem(models.Model):
CATEGORY = [
("Coffee","Coffee"),
("Tea","Tea"),
("Dessert","Dessert"),
("Cold Drink","Cold Drink"),
]
name = models.CharField(max_length=100)
category = models.CharField(
max_length=30,
choices=CATEGORY
)
price = models.DecimalField(
max_digits=8,
decimal_places=2
)
available = models.BooleanField(default=True)
image = models.ImageField(
upload_to="menu/"
)
def __str__(self):
return self.name

```

### Reservation Model

```

class Reservation(models.Model):
customer = models.ForeignKey(
Customer,
on_delete=models.CASCADE
)
reservation_date = models.DateField()
reservation_time = models.TimeField()
guests = models.IntegerField()
table_number = models.IntegerField()

```

### Order Model

```

class Order(models.Model):
customer = models.ForeignKey(
Customer,
on_delete=models.CASCADE
)
created_at = models.DateTimeField(
auto_now_add=True
)
total_price = models.DecimalField(
max_digits=10,
decimal_places=2,
default=0
)
status = models.CharField(
max_length=30,
default="Pending"
)

```

### Order Item Model

```

class OrderItem(models.Model):
order = models.ForeignKey(
Order,
on_delete=models.CASCADE
)
menu_item = models.ForeignKey(
MenuItem,
on_delete=models.CASCADE
)
quantity = models.PositiveIntegerField()
subtotal = models.DecimalField(
max_digits=8,
decimal_places=2
)

```

## Step 4 – Run Migrations

```

python manage.py makemigrations
python manage.py migrate

```

## Step 5 – Register Models in Admin

```

admin.site.register(Customer)
admin.site.register(Flower)
admin.site.register(MenuItem)
admin.site.register(Reservation)
admin.site.register(Order)
admin.site.register(OrderItem)

```

Create admin account.

```

python manage.py createsuperuser

```

## Step 6 – Build the Homepage

Our homepage will display:

- Featured Coffee

- Fresh Flowers

- Today\'s Specials

- Reservation Button

Example layout:

```

---------------------------------------------------

```

🌸 `Bloom & Brew Café`

```

Fresh Coffee | Fresh Flowers
[ Order Coffee ]
[ Reserve Table ]
Featured Flowers

```

🌷 `Tulips` 🌹 `Roses` 🌻 `Sunflowers Today\'s Menu` ☕ `Latte` 🍰 `Cheesecake`

```

(cid:0) Matcha
---------------------------------------------------

```

## Step 7 – Create CRUD Operations

We\'ll build complete CRUD functionality for: **Flowers**

- Add Flower

- Edit Flower

- Delete Flower

- View Flowers

**Menu**

- Add Item

- Update Item

- Delete Item

- View Menu

**Customers**

- Register Customer

- Edit Customer

- Delete Customer

**Reservations**

- Create Reservation

- Update Reservation

- Cancel Reservation

**Orders**

- Create Order

- Add Items

- Complete Order

## Step 8 – User Authentication

Users will log in before accessing the dashboard. Features include:

- Login

- Logout

- Protected Dashboard

- Staff-only Pages

## Step 9 – Dashboard

The dashboard displays useful business information.

```

--------------------------------
Bloom & Brew Dashboard
Today\'s Orders : 18
Reservations : 9
Flowers in Stock : 150
Coffee Sold : 47
Revenue : $580
--------------------------------

```

## Step 10 – Upload Images

Both flowers and menu items include images. Example:

```

image = models.ImageField(
upload_to="flowers/"
)

```

This allows administrators to showcase products visually.

## Step 11 – Search Functionality

Customers can search by:

- Flower name

- Coffee name

- Dessert

- Tea

- Price

- Category

Example:

```

Search:
[ Lavender Latte ]
Results

```

✓ `Lavender Latte` ✓ `Lavender Bouquet`

## Step 12 – Improve the User Interface

We will use:

- Bootstrap 5

- Cards

- Navbar

- Footer

- Hero Banner

- Icons

- Soft pastel colors

- Responsive layout

Example pages:

- Home

- Menu

- Flowers

- Reservations

- Dashboard

- Contact

## Step 13 – Testing

We will test:

- User login

- Add flower

- Add menu item

- Reserve table

- Place order

- Delete record

- Image upload

- Search functionality

## Step 14 – Deployment

Before deployment: `DEBUG = False` Configure:

- Allowed Hosts

- Static Files

- Media Files

- Database

- Secret Key

- HTTPS

Then deploy the application to a production server.

### Final Project Structure

```

bloombrew/
│
├── manage.py
├── bloombrew/
│
├── cafe/
│ ├── models.py
│ ├── views.py
│ ├── urls.py
│ ├── forms.py
│ ├── admin.py
│ ├── templates/
│ │
│ ├── static/
│ │
│ └── media/
│
└── db.sqlite3

```

### Final Features

By the end of this project, we will have built a complete **Bloom & Brew Café Management System** with:

- Beautiful landing page

- Café menu management

- Flower inventory management

- Customer management

- Table reservations

- Order management

- Product image uploads

- User authentication

- Business dashboard

- Search functionality

- Django Admin panel

- Responsive design

### Conclusion

By completing this project, we will have developed a fully functional **Bloom & Brew Café Management System** that demonstrates the practical use of Django\'s core features, including models, views, templates, forms, authentication, file uploads, and the Django Admin interface. The application manages both café operations and flower inventory, making it more engaging and realistic than a basic CRUD project. It also provides an excellent foundation for adding advanced features later, such as online payments, shopping carts, customer reviews, REST APIs, or real-time order tracking, making it a strong portfolio project for aspiring Django developers.');
