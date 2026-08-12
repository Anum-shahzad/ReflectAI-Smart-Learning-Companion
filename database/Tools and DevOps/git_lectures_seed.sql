-- =============================================
-- ReflectAI — Git Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'Git' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to Version Control & Git
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to Version Control & Git', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to Version Control & Git

## What is Version Control?

Version Control is a system that helps us keep track of changes made to files over time. Imagine you are writing an assignment. First, you save it as **Assignment.docx**. Later, you make changes and save it as **Assignment_Final.docx**, then **Assignment_Final_2.docx**, and finally **Assignment_Final_ReallyFinal.docx**. This quickly becomes confusing. Version Control solves this problem by recording every change in an organized way. Instead of creating many copies of the same file, it keeps a complete history of all modifications. This means we can see what changed, who changed it, and even return to an older version if something goes wrong. Think of Version Control as a **time machine for your files**. If you make a mistake today, you can travel back to yesterday\'s version without losing your work. Version Control is widely used by software developers, but it is also useful for writers, designers, researchers, and anyone who works on digital files.

## Why Do We Need Version Control?

As projects become larger, managing files manually becomes difficult. Developers often work in teams, and many people may edit the same project at the same time. Without Version Control, files can easily get lost, overwritten, or mixed up. Version Control helps solve these problems in several ways.

### 1. Keeps Track of Changes

Every modification is recorded. We can easily see what was changed and when it happened.

### 2. Restores Previous Versions

If a new update causes errors, we can return to an earlier version instead of rewriting everything.

### 3. Supports Team Collaboration

Multiple people can work on the same project without interfering with each other\'s work. Everyone\'s changes are managed in an organized manner.

### 4. Prevents Data Loss

Even if someone accidentally deletes or changes important code, previous versions are still available.

### 5. Makes Development Organized

Instead of guessing which file is the latest one, Version Control maintains a clear history of the project. Without Version Control, software development would be like several people trying to write in the same notebook at the same time. With Version Control, everyone gets their own workspace, and all changes are combined safely.

## What is Git?

Git is the world\'s most popular Version Control System. It was created in **2005** by **Linus Torvalds**, the creator of the Linux operating system. Git is a **distributed version control system**, which means every developer has a complete copy of the project\'s history on their own computer. This makes Git fast, reliable, and able to work even without an internet connection. Unlike ordinary file-saving methods, Git records snapshots of a project instead of simply replacing files. Every important change is saved so it can be viewed or restored whenever needed. Today, Git is used by millions of developers and by companies ranging from small startups to large technology organizations. It has become an essential tool in modern software development.

## How Does Git Work?

Git works by keeping a history of changes made to a project. Instead of storing dozens of separate copies, it records each important update as a checkpoint. Imagine you are building a website.

- You create the homepage.

- You add a navigation menu.

- You improve the design.

- You fix some bugs.

Git remembers each of these steps. If one update introduces a problem, you can go back to the earlier working version. Each saved checkpoint represents the project\'s condition at a specific moment. This allows developers to experiment with confidence because they know previous versions are always available. Git also compares different versions efficiently, making it easy to identify what has changed between updates.

## Key Features of Git

Git offers many useful features that make software development easier and more organized.

### 1. Version Tracking

Git records every important change made to a project. Nothing important is lost.

### 2. Fast Performance

Since Git stores project history locally, most operations are completed very quickly.

### 3. Distributed System

Every developer has a complete copy of the repository, making work possible even without internet access.

### 4. Collaboration

Many developers can work on the same project simultaneously without overwriting each other\'s work.

### 5. Backup and Recovery

If mistakes happen, Git allows developers to restore previous versions easily.

### 6. Project History

Git keeps a complete timeline of project development, making it simple to understand how a project has evolved over time.

## Basic Git Terminology (Introduction)

Before learning Git commands, it is helpful to understand a few common terms.

### Repository (Repo)

A repository is the main storage area for a project. It contains all project files along with their complete version history.

### Commit

A commit is a saved checkpoint of the project. It records the changes made since the previous commit.

### History

History is the complete record of all commits made in the repository. It shows how the project has changed over time.

### Branch

A branch is a separate line of development where new features or experiments can be created without affecting the main project.

### Merge

Merging combines changes from one branch into another after the work has been completed. These terms will become clearer as we continue learning Git in future lessons.

## Advantages of Using Git

Git has become the industry standard because it offers several important benefits.

- It keeps projects organized.

- It allows developers to work together efficiently.

- It reduces the risk of losing important work.

- It makes debugging easier by tracking every change.

- It supports both individual and team projects.

- It allows developers to experiment safely without damaging the original project.

- It provides a reliable backup of the entire project history.

Whether you are creating a small website or a large software application, Git helps manage the project efficiently.

## Real-Life Example of Git

Imagine five students are assigned to build a college website. Without Git, each student edits different copies of the project. When they combine their work, files become mixed up, and someone may accidentally overwrite another person\'s changes. With Git, each student works on their own copy while Git records every change. Later, everyone\'s work is combined into one organized project. If any mistake appears, the team can quickly return to an earlier working version. This is why Git is compared to a **smart project manager** —it keeps everyone\'s work organized and prevents confusion.

### Conclusion

Version Control is an essential system for managing changes in digital projects. It allows us to track modifications, recover previous versions, and collaborate efficiently with others. Git is the most widely used Version Control System because it is fast, reliable, and designed for both individual developers and teams. Rather than creating multiple copies of files, Git maintains a complete history of every important change, making software development safer, more organized, and easier to manage. Understanding the basic concepts of Version Control and Git provides a strong foundation before moving on to Git installation, commands, repositories, commits, branches, and collaborative workflows in future lessons.');

-- Lecture 2: Installing Git & Initial Configuration
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Installing Git & Initial Configuration', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Installing Git & Initial Configuration

## Introduction to Git Installation

Before we can use Git to manage our projects, we need to install it on our computer. Installing Git is a simple one-time process. Once it is installed, we can use Git for all our future software development projects. Git is available for all major operating systems, including **Windows**, **macOS**, and **Linux**. Regardless of the operating system, the purpose remains the same—to provide us with a powerful version control system that helps track changes, manage project history, and collaborate with other developers. After installation, we perform an **initial configuration**. This tells Git who we are so that every change we save (called a commit) is associated with our name and email address. Think of Git installation as buying a new notebook, while the initial configuration is writing your name on the first page. From that point onward, every piece of work can be identified as yours.

## Installing Git on Different Operating Systems

### Installing Git on Windows

Installing Git on Windows is straightforward. 1. Download the Git installer from the official Git website. 2. Run the installer. 3. Follow the installation wizard. 4. Leave most settings at their default values unless you have a specific requirement. 5. Complete the installation. Once installed, Git provides a command-line interface called **Git Bash**, which allows us to use Git commands. Git also works inside **Command Prompt**, **PowerShell**, and popular code editors such as **Visual Studio Code**.

### Installing Git on macOS

On macOS, Git can be installed in several ways.

- Download the installer from the official Git website.

- Install it using package managers like **Homebrew**.

- Install Apple\'s Command Line Tools, which also include Git.

After installation, Git becomes available through the macOS Terminal.

### Installing Git on Linux

Most Linux distributions provide Git through their package manager. For example:

### Ubuntu / Debian

```

sudo apt update
sudo apt install git

```

### Fedora

`sudo dnf install git`

### CentOS / RHEL

`sudo yum install git` After installation, Git is available through the Linux Terminal.

## Verifying Git Installation

After installing Git, we should verify that it has been installed correctly. Open your terminal, command prompt, or Git Bash and type: `git --version`

### Example Output

`git version 2.50.1` The version number may be different depending on the latest release. If Git displays its version number, it means the installation was successful. If the command is not recognized, Git may not have been installed correctly or its installation path may not be configured properly.

## Initial Git Configuration

After installing Git, the next step is the **initial configuration**. Git needs to know who is making changes to the project. Every commit stores the author\'s information. The two most important settings are:

- User Name

- Email Address

These settings are stored in Git\'s configuration file.

### Setting the User Name

Use the following command:

```

git config --global user.name "John Smith"

```

Replace **John Smith** with your own name. Example:

```

git config --global user.name "Anum Shahzad"

```

From now on, Git will use this name for all your commits.

### Setting the Email Address

Use the following command:

```

git config --global user.email "john@example.com"

```

Example:

```

git config --global user.email "Anum@gmail.com"

```

This email identifies the author of each commit. **Note:** If you plan to use GitHub, it is generally recommended to use the same email address associated with your GitHub account.

## Understanding the Option

`--global` You may notice that the previous commands used the `--global` option. This means the configuration applies to **all Git repositories** on your computer for the current user. For example:

```

git config --global user.name "Anum Shahzad"

```

Now every new Git project will automatically use this name. Without `--global`, the configuration applies only to the current project. There are three levels of Git configuration:

| Configuration Level | Description |
|---|---|
| System | Applies to every user on the computer. |
| Global | Applies to the current user and all their repositories. |
| Local | Applies only to the current Git repository. |

In most cases, beginners use the **global configuration**.

## Viewing Git Configuration

After configuring Git, we can check the saved settings. To display all Git configuration values: `git config --list`

### Example Output

```

user.name=Anum Shahzad
user.email=anum@gmail.com

```

To display only the user name: `git config user.name` To display only the email address: `git config user.email` These commands help us verify that Git has stored the correct information.

## Changing Git Configuration

If we accidentally entered the wrong name or email, we can simply run the configuration command again. For example:

```

git config --global user.name "Saba"

```

Or change the email:

```

git config --global user.email "Saba@gmail.com"

```

Git replaces the old value with the new one. There is no need to uninstall or reinstall Git.

## Why Initial Configuration is Important

Some beginners wonder why Git asks for a name and email address. The reason is simple. Every commit records:

- Who made the change.

- When the change was made.

- What changes were made.

This information becomes very useful when many developers work on the same project. If a bug appears, the team can identify which changes were introduced and who made them. Even when working alone, commit history helps us track our own progress.

## Best Practices for Git Configuration

To avoid problems later, follow these best practices:

- Install Git only from the official Git website or your operating system\'s package manager.

- Verify the installation using `git --version`.

- Configure your name and email before creating your first repository.

- Use your real name for professional projects.

- Use the same email address linked to your Git hosting service (such as GitHub) if you plan to push code online.

- Double-check your configuration using `git config --list`.

Following these practices ensures your Git environment is correctly set up from the beginning.

## Common Beginner Mistakes

Many beginners encounter small issues during setup. Here are some common ones:

### 1. Forgetting to Configure Name and Email

Without this information, Git may prevent you from creating commits or ask you to configure it later.

### 2. Typing the Command Incorrectly

For example: `git config user.name` This only displays the current value. To set a value, include the new name:

```

git config --global user.name "Anum Shahzad"

```

### 3. Using an Incorrect Email

Using a different email from your GitHub account can make your commits appear as unverified or not linked to your profile.

### 4. Not Checking the Installation

Always run: `git --version` to confirm that Git is installed successfully before continuing.

### Conclusion

Installing Git is the first step toward using a professional version control system. After installation, the initial configuration allows Git to identify the author of every commit by storing a user name and email address. Verifying the installation, configuring your identity, and understanding the purpose of the `--global` option provide a solid foundation for future Git usage. Once Git is installed and configured correctly, you are ready to create repositories, track project changes, and explore the powerful features that make Git an essential tool for modern software development.');

-- Lecture 3: Git Configuration Files
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Git Configuration Files', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Git Configuration Files

## Introduction to and Git Configuration Files

`.gitignore` When working on a Git project, not every file should be stored in the repository. Some files are temporary, automatically generated, or contain sensitive information such as passwords or API keys. Tracking these files can make the repository larger, cluttered, and less secure. Git provides a special file called `.gitignore` to tell Git which files and folders should be ignored. In addition, Git uses **configuration files** to store settings such as the user\'s name, email address, default editor, and other preferences. These settings help Git identify who made each commit and how Git should behave. Understanding both `.gitignore` and Git configuration files is important because they help keep projects organized, secure, and easier to manage.

## What is ?

`.gitignore` A `.gitignore` file is a special text file that tells Git **not to track specific files or folders**. When Git sees a file or folder listed inside `.gitignore`, it ignores it while checking for changes. This is useful for:

- Temporary files

- Log files

- Cache files

- Build or compiled files

- Dependency folders

- Secret configuration files

- Operating system-generated files

Instead of manually ignoring files every time, we simply add them to the `.gitignore` file.

### Why Do We Need ?

`.gitignore` Without `.gitignore`, Git may track unnecessary files, making the repository larger and harder to manage. For example:

- Temporary files change frequently.

- Build files can be generated again automatically.

- Passwords and API keys should never be shared publicly.

Using `.gitignore` keeps the repository clean and secure.

## Creating a File

`.gitignore` Creating a `.gitignore` file is simple. Create a file named: `.gitignore` Inside this file, write the names of files or folders that Git should ignore.

### Ignoring a Single File

Example: `config.txt` Git will ignore the file named: `config.txt`

### Ignoring Multiple Files

Example:

```

config.txt
notes.txt
secret.txt

```

Git ignores all three files.

### Ignoring a Folder

Example: `node_modules/` Git ignores the entire **node_modules** folder and everything inside it. This is one of the most common entries in JavaScript and Node.js projects.

### Ignoring File Types

Suppose we want Git to ignore all log files. `*.log` Git ignores files such as:

```

error.log
server.log
project.log

```

The `*` symbol is called a **wildcard**, and it represents any number of characters.

## Common Examples

`.gitignore` Here is an example of a `.gitignore` file:

```

node_modules/
*.log
.env
build/
temp/

```

### Explanation

| Entry | Purpose |
|---|---|
| node_modules/ | Ignores installed packages. |
| *.log | Ignores all log files. |
| .env | Ignores environment variables and secret keys. |
| build/ | Ignores compiled project files. |
| temp/ | Ignores temporary files. |

These are commonly ignored files in many software projects.

## Important Rule About

`.gitignore` The `.gitignore` file only affects **untracked files**. If Git is **already tracking** a file, simply adding it to `.gitignore` will **not** stop Git from tracking it.

### Example

Suppose `config.txt` has already been committed. Adding this line: `config.txt` to `.gitignore` will not remove it from Git tracking. To stop tracking the file while keeping it on your computer, use: `git rm --cached config.txt` Then commit the change. After that, `.gitignore` will prevent Git from tracking the file again.

## What are Git Configuration Files?

Git uses **configuration files** to store user preferences and project settings. These settings include:

- User name

- Email address

- Default editor

- Default branch name

- Color settings

- Aliases

Git reads these settings whenever it performs operations such as creating commits.

### Viewing Current Configuration

To display all Git settings, use: `git config --list` This command shows every configuration currently being used by Git.

## Levels of Git Configuration

Git has three configuration levels.

### 1. System Configuration

Applies to every user on the computer. Command: `git config --system` This level is usually managed by a system administrator.

### 2. Global Configuration

Applies to the current user across all Git repositories. Example:

```

git config --global user.name "Anum"
git config --global user.email "anum@example.com"

```

Every commit created by Anum will use this name and email unless a local configuration overrides them.

### 3. Local Configuration

Applies only to the current repository. Example:

```

git config --local user.name "Project User"

```

This setting affects only the current project.

## Setting User Name and Email

Before making commits, Git should know who is creating them.

### Set User Name

```

git config --global user.name "Anum"

```

### Set Email Address

```

git config --global user.email "anum@example.com"

```

These values are stored in the global Git configuration file and are added to future commits.

## Checking Individual Configuration Values

Instead of viewing every setting, we can check a specific one.

### Check User Name

`git config user.name`

### Check Email

`git config user.email` Git displays the current value stored in the configuration.

## Practical Workflow Example

Suppose **Anum** is setting up Git on a new computer.

### Step 1: Configure User Name

```

git config --global user.name "Anum"

```

### Step 2: Configure Email

```

git config --global user.email "anum@example.com"

```

### Step 3: Verify Settings

`git config --list` **Step 4: Create a** `.gitignore` **File** Contents:

```

node_modules/
.env
*.log

```

Now Git:

- Identifies Anum as the author of commits.

- Ignores unnecessary files and folders.

This creates a clean and professional Git project.

## Common Beginner Mistakes

**1. Forgetting to Create** `.gitignore` **Early** It is best to create a `.gitignore` file at the beginning of a project before unnecessary files are tracked.

### 2. Storing Sensitive Information

Never commit files containing:

- Passwords

- API keys

- Database credentials

Instead, add them to `.gitignore`. **3. Assuming** `.gitignore` **Removes Tracked Files** Remember: `.gitignore` does **not** stop tracking files that have already been committed.

### 4. Incorrect User Configuration

If your name or email is incorrect, future commits will show the wrong author information. Always verify your configuration using: `git config --list`

## Best Practices

To use `.gitignore` and Git configuration effectively:

- Create a `.gitignore` file when starting a new project.

- Ignore temporary, generated, and sensitive files.

- Configure your user name and email before making commits.

- Review your Git configuration periodically.

- Never store passwords or secret keys in a public repository.

- Use meaningful configuration settings for consistent project history.

Following these practices helps keep repositories clean, secure, and easy to maintain.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git config --list | Displays all Git configuration settings. |
| git config --global user.name "Anum" | Sets the global user name. |
| git config --global user.email "anum@example.com " | Sets the global email address. |
| git config user.name | Displays the current user name. |
| git config user.email | Displays the current email address. |
| git rm --cached filename | Stops tracking a file while keeping it on the local computer. |

### Conclusion

The `.gitignore` file and **Git configuration files** are essential tools for maintaining clean, secure, and organized Git repositories. The `.gitignore` file prevents unnecessary or sensitive files from being tracked, while Git configuration files store important settings such as the user\'s name, email, and other preferences. By creating a proper `.gitignore` file at the beginning of a project and configuring Git correctly, developers can improve project organization, protect sensitive information, and ensure that every commit is correctly attributed to its author. These practices are fundamental for both individual developers and collaborative software development teams.');

-- Lecture 4: Creating a Repository (git init)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Creating a Repository (git init)', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Creating a Repository (git init)

## Introduction to a Git Repository

Before Git can start tracking files, it needs a place to store all the project\'s history and information. This place is called a **Git repository**, often shortened to **repo**. A repository is the main storage area where Git keeps your project files and records every important change. It acts like a **digital notebook** that remembers everything you do in your project. Think of a repository as a **library**. The project files are the books, and Git is the librarian that records when books are added, updated, or removed. Instead of forgetting changes, Git keeps a complete history so you can review or restore previous versions whenever needed. Every Git project begins by creating a repository.

## What is ?

`git init` The command used to create a new Git repository is: `git init` The word `init` stands for **initialize**. When we run this command, Git initializes the current folder as a Git repository. This means Git starts monitoring the project and prepares it for version control. It is important to understand that `git init` **does not create your project files**. It simply tells Git to begin tracking the folder in which the command is executed. For example, if you already have a website project, running `git init` inside its folder allows Git to start managing that project.

## What Happens When We Run ?

`git init` When the `git init` command is executed, Git performs several tasks automatically. **1. Creates a Hidden** `.git` **Folder** The most important action is creating a hidden folder named: `.git` This folder contains all the information Git needs to manage the project. Inside the `.git` folder, Git stores:

- Project history

- Commit information

- Branch details

- Configuration files

- References to tracked files

As long as the `.git` folder exists, Git recognizes the project as a repository. **Note:** Never delete the `.git` folder unless you intentionally want to remove Git version control from the project.

### 2. Starts Version Control

After initialization, Git begins monitoring the project. Initially, none of the files are tracked. Git is simply ready to start recording changes once files are added.

### 3. Creates the Default Branch

Git also prepares the repository with a default branch (commonly named **main**). This branch will later contain the primary version of the project.

## Steps to Create a Repository

Creating a Git repository is a simple process.

### Step 1: Create or Open a Project Folder

For example: `MyWebsite` This folder contains your project files.

### Step 2: Open Terminal or Git Bash

Navigate to the project folder using the terminal. Example: `cd MyWebsite` The `cd` command means **Change Directory**.

### Step 3: Run the Initialization Command

Type: `git init` Git will initialize the repository.

### Step 4: Confirmation Message

You may see an output similar to:

```

Initialized empty Git repository in C:/Projects/MyWebsite/.git/

```

This message confirms that Git has successfully created the repository.

## Understanding the Folder

`.git` The hidden `.git` folder is the heart of every Git repository. It stores all the information required for version control. Some important data stored inside this folder includes:

- Commit history

- Branch information

- Repository configuration

- Object database

- References

- Logs

Your project files remain outside the `.git` folder, while Git stores their history inside it. If the `.git` folder is deleted, Git will no longer recognize the folder as a repository, and all version history will be lost.

## Repository Before and After

`git init`

### Before Initialization

```

MyWebsite/
│
├── index.html
├── style.css
└── script.js

```

At this stage, Git is not managing the project. **After Running** `git init`

```

MyWebsite/
│
├── .git/
├── index.html
├── style.css
└── script.js

```

Notice that the hidden `.git` folder has been added. This single folder transforms an ordinary project into a Git repository.

## Why Do We Use ?

`git init` The `git init` command is important because it allows Git to begin managing a project. Some major benefits include:

### 1. Enables Version Control

Git starts tracking project changes after the repository is initialized.

### 2. Organizes Project History

Every future commit becomes part of the repository\'s history.

### 3. Supports Team Collaboration

Other developers can later clone or contribute to the repository.

### 4. Makes Backup Easier

Every saved version becomes part of Git\'s permanent history until removed intentionally.

### 5. Provides a Foundation for Git Commands

Most Git commands require the project to already be a repository.

## Common Beginner Mistakes

When learning Git, beginners often make a few common mistakes. **1. Running** `git init` **in the Wrong Folder** Always make sure you are inside the correct project directory before initializing Git. Check your current directory if you\'re unsure.

### 2. Initializing Multiple Times

Some students repeatedly run: `git init` This usually does not harm the repository. Git simply reinitializes the existing repository. **3. Deleting the** `.git` **Folder** Removing the hidden `.git` folder permanently removes Git tracking and the complete commit history.

### 4. Expecting Files to Be Tracked Automatically

After running `git init`, Git does **not** automatically track files. Files must be added manually using Git commands (covered in later lessons).

## Real-Life Example

Imagine you have created a project called **Student Management System**. Initially, it is just a normal folder containing files like:

- `index.html`

- `style.css`

- `app.js`

Git knows nothing about these files. After entering the project folder and running: `git init` Git creates the hidden `.git` folder and begins managing the project. From this point onward, every important update can be saved, tracked, and restored whenever needed. It is similar to opening a new diary. The diary is empty at first, but now it is ready to record every important event.

## Best Practices When Creating a Repository

To keep your projects organized, follow these best practices:

- Create a separate repository for each project.

- Run `git init` only once when starting a new project.

- Keep the `.git` folder safe and do not modify its contents manually.

- Verify that you are inside the correct project folder before initializing Git.

- Use meaningful project folder names for easier management.

Following these practices will help you build clean and well-organized Git projects.

### Conclusion

Creating a repository is the first practical step in using Git. By running the `git init` command, we initialize a project for version control and create the hidden `.git` folder that stores the project\'s complete history and configuration. Although `git init` does not automatically track files, it prepares the project for future Git operations such as adding files, making commits, creating branches, and collaborating with others. Understanding how repositories work provides a strong foundation for learning the remaining Git commands and workflows.');

-- Lecture 5: Checking Status & History
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Checking Status & History', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Checking Status & History

## Introduction to Checking Project Status and History

As we work on a Git project, files are constantly being created, modified, staged, and committed. It is important to know **what has changed**, **what is ready to be committed**, and **what has happened in the project\'s history**. Git provides several commands to help us monitor our project:

- `git status` – Shows the current status of the repository.

- `git log` – Displays the commit history.

- `git diff` – Shows the differences between file versions.

These commands help us understand our project\'s current state and make informed decisions before creating new commits. Think of these commands as the **dashboard of a car**. Just as a dashboard shows your speed, fuel level, and engine status, these Git commands show the health and progress of your project.

## Checking Repository Status ( )

`git status` The `git status` command displays the current state of the Git repository.

### Syntax

`git status` This command tells us:

- Which files have been modified.

- Which files are staged.

- Which files are not being tracked.

- Whether the working directory is clean.

It is one of the most frequently used Git commands because developers usually run it before staging or committing changes.

### Example

Suppose we modify `index.html`. Running: `git status` may display:

```

On branch main
Changes not staged for commit:
modified: index.html

```

This means Git has detected changes, but they have **not** been staged yet.

### After Staging the File

If we run: `git add index.html` and then execute: `git status` Git may display:

```

Changes to be committed:
modified: index.html

```

This means the file is now in the **Staging Area** and is ready for the next commit.

### When Everything is Saved

After committing the changes:

```

git commit -m "Updated homepage"

```

Running: `git status` may display:

```

On branch main
nothing to commit, working tree clean

```

This means the repository is fully updated and there are no pending changes.

## Viewing Commit History ( )

`git log` Git stores every commit permanently in the repository. To view the commit history, we use: `git log` This command displays all previous commits, starting with the most recent one. Each commit includes:

- Commit ID (Hash)

- Author\'s name

- Author\'s email

- Date and time

- Commit message

### Example Output

```

commit a8f5f167f44f4964e6c998dee827110c
Author: Anum Shahzad <anum@gmail.com>
Date: Mon Aug 3 10:20:15 2026
Added login page
commit b9d8c3ef7345fd88a75d239d3d2c9f98
Author: Anum Shahzad <anum@gmail.com>
Date: Sun Aug 2 09:10:45 2026
Created homepage

```

From this output, we can easily understand how the project has developed over time.

### Why is Useful?

`git log` The `git log` command helps us:

- View all previous commits.

- Track project progress.

- Identify when changes were made.

- Find older versions of the project.

- Understand the development history.

It is especially useful when debugging or reviewing past work.

### Short Version of Commit History

Sometimes the complete log is too long. Git provides a shorter version: `git log --oneline`

### Example Output

```

a8f5f16 Added login page
b9d8c3e Created homepage

```

This displays only:

- Short Commit ID

- Commit Message

Many developers prefer this format because it is quick and easy to read.

## Comparing Changes ( )

`git diff` The `git diff` command shows the differences between file versions. Instead of simply telling us that a file changed, Git shows **exactly what changed**.

### Syntax

`git diff`

### Example

Suppose the original file contains: `<h1>Welcome</h1>` After editing it becomes:

```

<h1>Welcome to My Website</h1>

```

Running: `git diff` will highlight the differences. Example:

```

- <h1>Welcome</h1>
+ <h1>Welcome to My Website</h1>

```

### Understanding the Symbols

- `-` indicates removed content.

- `+` indicates newly added content.

This makes it very easy to identify what has been changed.

## When Should We Use ?

`git diff` The `git diff` command is useful when we want to:

- Review changes before staging.

- Check for accidental edits.

- Compare different versions of files.

- Understand what has been modified.

Many developers run `git diff` before committing to ensure only the intended changes are included.

## Relationship Between , , and

`status diff log` These three commands serve different purposes but work together.

| Command | Purpose |
|---|---|
| git status | Shows the current state of the repository. |
| git diff | Displays the exact changes in modified files. |
| git log | Shows the complete history of commits. |

Think of them as answering three different questions:

- `git status` → What is happening right now?

- `git diff` → What exactly changed?

- `git log` → What happened in the past?

## Typical Git Workflow Using These Commands

A developer usually follows this workflow:

### Step 1: Modify Files

Edit project files. ↓

### Step 2: Check Status

`git status` See which files have changed. ↓

### Step 3: Review Changes

`git diff` Verify the modifications. ↓

### Step 4: Stage Files

`git add .` ↓

### Step 5: Commit Changes

```

git commit -m "Added contact page"

```

↓

### Step 6: View History

`git log` Confirm the new commit has been added. This workflow helps maintain a clean and organized project history.

## Real-Life Example

Imagine you are writing a research paper.

- `git status` is like checking which pages still need editing.

- `git diff` is like comparing today\'s draft with yesterday\'s draft to see what sentences changed.

- `git log` is like looking through every previous version of your paper to understand how it has evolved.

Together, these commands give you complete control over your work.

## Common Beginner Mistakes

### 1. Forgetting to Check Status

Many beginners edit files and immediately commit them. Always run: to know the current state of your repository. **2. Skipping** `git diff` Without reviewing changes, you may accidentally commit unwanted edits. Running: `git diff` helps avoid mistakes. **3. Confusing** `git log` **with** `git status` Remember:

- `git status` shows the **current** state.

- `git log` shows the **past** history.

### 4. Ignoring the Commit History

Developers often forget to check previous commits. Using: `git log` helps verify that your commits have been saved correctly.

## Best Practices

To use these commands effectively:

- Run `git status` frequently while working.

- Use `git diff` before staging or committing changes.

- Check `git log` regularly to review project history.

- Write meaningful commit messages so the log is easy to understand.

- Review your changes carefully before creating a commit.

These habits improve code quality and make collaboration much easier.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git status | Shows the current status of the repository. |
| git diff | Displays the differences between modified files. |
| git log | Shows the complete commit history. |
| git log --oneline | Displays a short, one-line version of the commit history. |

### Conclusion

The commands `git status`, `git log`, and `git diff` are essential tools for monitoring and managing a Git repository. `git status` keeps us informed about the current state of our files, `git diff` allows us to review the exact changes before saving them, and `git log` provides a complete history of all commits made in the project. By using these commands regularly, we can work more confidently, avoid mistakes, and maintain a clear and organized development history. Understanding how to check the present, compare changes, and review the past is a fundamental skill for every Git user.');

-- Lecture 6: Staging & Committing Changes
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Staging & Committing Changes', 6, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Staging & Committing Changes

## Introduction to Staging and Committing

After creating a Git repository using `git init`, Git is ready to track our project. However, simply creating or editing files is **not enough**. Git does not automatically save every change we make. Instead, Git follows a two-step process: **1. Stage** the changes. **2. Commit** the staged changes. This process gives us complete control over what gets saved in the project\'s history. We can choose which changes are ready and which ones still need more work. Think of it like sending a parcel. First, you **pack the items into a box** (staging). Then, you **send the box** (committing). Only after sending it does the package become part of the delivery history.

## What is Staging?

**Staging** is the process of selecting the files or changes that we want Git to save in the next commit. When a file is staged, it is placed into a special area called the **Staging Area** (also known as the **Index**). The staging area acts like a waiting room. Files stay there until we decide to permanently save them by creating a commit. For example:

- You edit three files.

- Two files are complete.

- One file is still unfinished.

Instead of saving everything, Git allows you to stage only the completed files. This makes Git very flexible and organized.

### The Command

`git add` The command used to stage files is: `git add filename`

### Example

Suppose we have a file named: `index.html` To stage it, type: `git add index.html` Now Git knows that this file should be included in the next commit.

### Staging Multiple Files

To stage more than one file: `git add index.html style.css` Both files are added to the staging area.

### Staging All Files

To stage every modified file in the project: `git add .` The dot (`.`) means **all files in the current directory and its subdirectories**. This is one of the most commonly used Git commands.

## What is a Commit?

A **commit** is a permanent snapshot of the staged changes. Every commit represents the project at a particular point in time. Think of a commit as taking a **photograph** of your project. The photo captures exactly how the project looks at that moment. Later, you can always return to that version if needed. Each commit includes:

- The saved changes

- The author\'s name

- The author\'s email

- Date and time

- A commit message describing the changes

Every commit has its own unique identification number called a **Commit ID (Hash)**.

### The Command

`git commit` To create a commit, use:

```

git commit -m "Your commit message"

```

The `-m` option allows us to write a short message describing what changes were made.

### Example

```

git commit -m "Created homepage layout"

```

Git saves all staged changes and records them in the repository history.

## Why Are Commit Messages Important?

A commit message explains **what changes were made**. Imagine looking at a project six months later. Which message is more useful? ❌ Bad Message `Update` ✅ Good Message

```

Added login page and fixed navigation menu

```

A good commit message should:

- Be short

- Be clear

- Describe the changes

- Explain the purpose of the update

Good commit messages make project history much easier to understand.

## Git Workflow: From Editing to Committing

The basic Git workflow follows these steps:

### Step 1: Create or Modify Files

Example:

```

index.html
style.css
script.js

```

You edit these files. ↓

### Step 2: Stage the Changes

`git add .` Git places the modified files into the staging area. ↓

### Step 3: Commit the Changes

```

git commit -m "Added homepage styling"

```

Git permanently saves the staged files into the repository history. This three-step workflow is repeated throughout software development.

## Checking the Repository Status

Git provides a command to check what is happening in the repository. `git status` This command tells us:

- Which files have changed

- Which files are staged

- Which files are not staged

- Whether there is anything ready to commit

### Example Output

```

Changes to be committed:
modified: index.html
Changes not staged for commit:
modified: style.css

```

From this output, we know:

- `index.html` is staged.

- `style.css` still needs to be staged.

The `git status` command is one of the most frequently used Git commands because it helps us understand the current state of our repository.

## Understanding the Git Workflow Diagram

The complete Git workflow can be visualized as:

```

Working Directory
│
│ Edit Files
▼
Staging Area
│
git add
▼
Repository
│
git commit
▼
Saved Project History

```

### Working Directory

This is where we create and edit project files.

### Staging Area

This is a temporary area where selected changes wait before being committed.

### Repository

This is where Git permanently stores the project\'s history.

## Real-Life Example

Imagine you are writing a book. You write three chapters.

- Chapter 1 is complete.

- Chapter 2 is complete.

- Chapter 3 is unfinished.

You decide to submit only Chapters 1 and 2 to your publisher. The process looks like this:

- Writing the chapters → Working Directory

- Selecting completed chapters → Staging Area

- Publishing the selected chapters → Commit

Git works in exactly the same way.

## Common Beginner Mistakes

### 1. Forgetting to Stage Files

Many beginners try:

```

git commit -m "Updated project"

```

without staging files first. Git will display a message saying there is nothing to commit because no files were added to the staging area.

### 2. Using Poor Commit Messages

Avoid messages like: `Update` or `Fixed stuff` Instead write: `Added user registration page` or `Fixed login validation bug`

### 3. Forgetting to Check Status

Always run: `git status` before committing. It helps verify that the correct files are staged.

### 4. Staging Unnecessary Files

Using: `git add .` stages all modified files. Always review your changes before committing to ensure only the intended files are included.

## Best Practices for Staging and Committing

Follow these practices to keep your Git history clean and organized:

- Commit regularly instead of saving many changes at once.

- Write meaningful commit messages.

- Check the repository status before committing.

- Stage only the files that are ready.

- Keep each commit focused on a single task or feature.

- Test your code before creating a commit whenever possible.

These habits make collaboration easier and simplify debugging in the future.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git status | Shows the current status of the repository. |
| git add filename | Stages a specific file. |
| git add . | Stages all modified files in the current directory. |
| git commit -m "message" | Saves staged changes with a descriptive message. |

### Conclusion

Staging and committing are two of the most important concepts in Git. The **staging area** allows us to choose which changes should be included in the next version of the project, while a **commit** permanently saves those selected changes into the repository\'s history. By following the workflow of **editing → staging → committing**, we can maintain a clean, organized, and reliable record of our project\'s development. Writing clear commit messages and checking the repository status regularly are essential habits that help both individual developers and teams work more efficiently with Git.');

-- Lecture 7: Undoing Changes
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Undoing Changes', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Undoing Changes

## Introduction to Undoing Changes in Git

Mistakes are a normal part of software development. Sometimes we accidentally modify a file, stage the wrong changes, or even create a commit that contains errors. Fortunately, Git provides several commands that allow us to undo mistakes safely. The three most commonly used commands for undoing changes are:

- `git reset` – Moves or removes commits and unstages changes.

- `git revert` – Creates a new commit that reverses the changes of a previous commit.

- `git checkout` – Restores files or switches between branches (older method).

Each command has a different purpose, so it is important to understand when to use each one. Think of these commands like an **eraser with different modes**. Sometimes you only erase your latest pencil marks (`reset`), sometimes you cross out a mistake without removing history (`revert`), and sometimes you restore a previous version of your work (`checkout`).

## Understanding

`git reset` The `git reset` command is used to move the current branch to a previous commit or to remove files from the staging area. It is commonly used when:

- You staged the wrong files.

- You want to undo recent commits.

- You want to return to an earlier state of the project.

### Basic Syntax

`git reset` This command removes staged files from the staging area but keeps the changes in the working directory.

### Unstaging a File

Suppose you accidentally staged `index.html`. `git add index.html` To remove it from the staging area: `git reset index.html` The file is no longer staged, but your changes are still saved in the file.

### Resetting to a Previous Commit

Git also allows us to move back to an earlier commit. Example: `git reset HEAD~1` This moves the branch back by one commit. The latest commit is removed from the branch history, but depending on the reset mode, the file changes may still remain.

### Types of Reset

Git provides three main reset modes.

### 1. Soft Reset

`git reset --soft HEAD~1`

- Removes the latest commit.

- Keeps all changes staged.

- Files remain unchanged.

### 2. Mixed Reset (Default)

`git reset --mixed HEAD~1`

- Removes the latest commit.

- Keeps the file changes.

- Removes files from the staging area.

This is the default reset mode.

### 3. Hard Reset

`git reset --hard HEAD~1`

- Removes the latest commit.

- Deletes all file changes.

- Permanently removes uncommitted work.

**Warning:** `git reset --hard` permanently discards changes that have not been committed. Use it with caution.

## Understanding

`git revert` Unlike `git reset`, the `git revert` command does **not delete history**. Instead, it creates a **new commit** that reverses the changes made by a previous commit. This makes it much safer for shared repositories.

### Syntax

`git revert commit-id`

### Example

Suppose a commit introduced a bug. Its commit ID is: `a8f5f16` To reverse it: `git revert a8f5f16` Git creates a new commit that undoes everything introduced by that earlier commit. The original commit remains in the project history.

### Why Use ?

`git revert git revert` is useful because:

- It preserves project history.

- It is safe for team projects.

- It clearly records that a change was intentionally reversed.

- Other developers are not affected by rewritten history.

## Understanding

`git checkout` Older versions of Git used `git checkout` for two purposes:

- Switching between branches.

- Restoring files.

Although modern Git recommends using `git switch` and `git restore`, many projects still use `git checkout`.

### Restoring a File

Suppose `index.html` has unsaved changes. To restore the last committed version: `git checkout -- index.html` Git replaces the modified file with the version from the latest commit. Any unsaved changes in that file are lost.

### Switching Branches

The same command can also switch branches. Example: `git checkout main` This changes the current working branch to **main**. Because `git checkout` performs multiple tasks, newer Git versions introduced separate commands:

- `git switch` → Switch branches.

- `git restore` → Restore files.

## vs vs

```

git reset git revert git checkout

```

These commands may seem similar, but they serve different purposes.

| Command | Main Purpose | Changes History? | Safe for Shared Projects? |
|---|---|---|---|
| git reset | Removes commits or unstages changes | Yes | Usually No |
| git revert | Creates a new commit that reverses changes | No | Yes |
| git checkout | Restores files or switches branches | No | Yes |

## Real-Life Example

Imagine you are writing a book. **Using** `git reset` You remove the last chapter because you decide it was written incorrectly. **Using** `git revert` Instead of deleting the chapter, you add a new chapter explaining why the previous chapter is incorrect. The original chapter remains for historical reference. **Using** `git checkout` You replace the current draft of one page with the version saved yesterday. Each command solves a different problem.

## Common Beginner Mistakes

**1. Using** `git reset --hard` **Without Understanding It** This command permanently deletes uncommitted changes. Always be certain before using it. **2. Using** `git reset` **on Shared Branches** Rewriting history on branches shared with other developers can cause synchronization problems. For shared repositories, prefer: `git revert`

### 3. Restoring the Wrong File

Running: `git checkout -- filename` will discard the current changes in that file. Double-check the filename before executing the command. **4. Confusing** `reset` **and** `revert` Remember:

- **Reset** removes or moves commits.

- **Revert** creates a new commit that cancels previous changes.

## Best Practices

To safely undo changes:

- Use `git status` before undoing anything.

- Use `git revert` for public or shared repositories.

- Use `git reset` mainly for local work before sharing commits.

- Avoid `git reset --hard` unless you are certain you no longer need the changes.

- Review your commit history using `git log` before resetting or reverting.

- Test your project after undoing changes.

Following these practices helps prevent accidental data loss.

## Practical Workflow Example

Suppose you accidentally commit a bug.

### Step 1: Check Commit History

`git log` Find the commit ID.

### Step 2: Reverse the Commit

`git revert commit-id` Git creates a new commit that removes the bug. If you simply staged the wrong file: `git reset index.html` The file is unstaged but your work remains. If you want to discard changes in a file: `git checkout -- index.html` Git restores the last committed version of the file.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git reset | Unstages files or moves the branch to a previous commit. |
| git reset --soft HEAD~1 | Removes the latest commit while keeping changes staged. |
| git reset --mixed HEAD~1 | Removes the latest commit and unstages the changes. |
| git reset --hard HEAD~1 | Removes the latest commit and permanently deletes changes. |
| git revert commit-id | Creates a new commit that reverses an earlier commit. |
| git checkout -- filename | Restores a file to its last committed version. |
| git checkout branch-name | Switches to another branch (older method). |

### Conclusion

Undoing changes is an essential skill for every Git user. The `git reset` command is useful for removing commits or unstaging changes during local development, `git revert` safely reverses commits by creating a new commit without changing project history, and `git checkout` can restore files or switch between branches in older versions of Git. Understanding the differences between these commands helps developers recover from mistakes, protect important work, and maintain a clean and reliable project history. By choosing the appropriate command for each situation and following best practices, developers can confidently manage changes and avoid unnecessary data loss.');

-- Lecture 8: Branching
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Branching', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Branching

## Introduction to Branching

As software projects grow, developers often need to work on new features, fix bugs, or test ideas without affecting the main project. This is where **branching** becomes useful. A **branch** in Git is an independent line of development. It allows us to work on new changes separately from the main project. Once the work is complete and tested, it can be merged back into the main branch. Think of a branch as a **separate road** leading from a highway. You can travel down the side road, complete your work, and later return to the main highway without disturbing other traffic. Branching is one of Git\'s most powerful features because it allows multiple developers to work on different tasks simultaneously.

## What is a Branch?

A **branch** is simply a pointer to a series of commits. Every Git repository starts with a default branch, usually called **main**. When we create a new branch:

- The new branch starts from the current version of the project.

- Changes made in the new branch do not affect the main branch.

- We can freely experiment without worrying about damaging the original project.

For example: Suppose the **main** branch contains a working website. You want to add a login page. Instead of editing the **main** branch directly, you create a new branch called: `login-feature` Now you can work on the login system safely. If something goes wrong, the **main** branch remains unchanged.

## Why Do We Use Branches?

Branches make software development more organized. Some major advantages are:

### 1. Safe Experimentation

Developers can test new ideas without affecting the main project.

### 2. Team Collaboration

Different team members can work on different features at the same time. For example:

- Developer A → Login System

- Developer B → Payment Module

- Developer C → Dashboard

Each developer works in a separate branch.

### 3. Easy Bug Fixes

Critical bugs can be fixed in a separate branch without interrupting ongoing development.

### 4. Organized Development

Every feature or improvement can have its own branch, making project management much easier.

## Creating a Branch ( )

`git branch` The command used to create a new branch is: `git branch branch-name`

### Example

`git branch login-feature` This creates a new branch named: `login-feature` However, **creating a branch does not automatically switch to it**. You are still working on your current branch.

### Viewing All Branches

To see all available branches: `git branch`

### Example Output

```

* main
login-feature

```

The asterisk (`*`) indicates the branch you are currently using. In this example:

- Current branch → **main**

- Another available branch → **login-feature**

## Switching Branches ( )

`git checkout` Older versions of Git use the `git checkout` command to move from one branch to another.

### Syntax

`git checkout branch-name`

### Example

`git checkout login-feature` Now Git switches to the **login-feature** branch. Any new changes you make will belong only to this branch.

### Creating and Switching in One Command

Git also allows us to create and switch to a new branch immediately. `git checkout -b contact-page` This command performs two actions: 1. Creates the branch. 2. Switches to it automatically.

## Switching Branches ( )

`git switch` Modern versions of Git introduced the `git switch` command. It is easier to understand because it is designed specifically for switching branches.

### Syntax

`git switch branch-name`

### Example

`git switch login-feature` Git immediately changes to the selected branch.

### Creating and Switching with

`git switch` Instead of using `checkout -b`, we can write: `git switch -c dashboard` The `-c` option means **create**. This command:

- Creates the **dashboard** branch.

- Switches to it immediately.

Many developers prefer `git switch` because its purpose is much clearer than `git checkout`.

## Understanding Branch Workflow

A typical branching workflow looks like this:

```

main
│
├───────────────
│
├── login-feature
│
├── payment-system
│
└── dashboard

```

Each branch develops independently. Once a feature is complete and tested, it can later be merged into the **main** branch. This keeps the main branch stable while allowing continuous development.

## Real-Life Example

Imagine a team is developing an **Online Shopping Website**. The **main** branch contains the live version of the website. Different developers create separate branches:

```

main
├── login-feature
├── payment-feature
├── search-feature
└── dark-mode

```

Each developer works independently. The login developer can modify authentication without affecting payment or search features. Once everything is tested, the branches are merged into the **main** branch. This is one of the biggest reasons why Git is so effective for teamwork.

## vs

`git checkout git switch` Both commands can switch branches, but there are some differences.

| Feature | git checkout | git switch |
|---|---|---|
| Switch branches | Yes | Yes |
| Create new branch | checkout -b | switch -c |
| Restore files | Yes | No |
| Easier for beginners | Less clear | More user-friendly |

**Why Was** `git switch` **Introduced?** The `git checkout` command performs multiple tasks, such as switching branches and restoring files, which can sometimes confuse beginners. The `git switch` command was introduced to focus only on switching branches, making it simpler and easier to use.

## Common Beginner Mistakes

### 1. Forgetting to Switch Branches

Creating a branch with: `git branch login-feature` does **not** move you to that branch. You must switch using: `git switch login-feature` or `git checkout login-feature`

### 2. Working on the Wrong Branch

Always check your current branch before making changes. Run: `git branch` The branch marked with `*` is your current branch.

### 3. Giving Confusing Branch Names

Avoid names like:

```

branch1
test123
new

```

Use meaningful names such as:

```

login-feature
payment-system
bug-fix
profile-page

```

Meaningful names make teamwork much easier. **4. Making Large Changes Directly in** `main` Avoid developing new features directly in the **main** branch. Instead, create a separate branch for each feature or bug fix.

## Best Practices for Branching

To keep your Git workflow organized:

- Create a separate branch for every new feature.

- Give branches meaningful names.

- Keep the **main** branch stable and free from unfinished work.

- Delete branches that are no longer needed after merging.

- Switch to the correct branch before starting work.

- Check your current branch regularly using `git branch`.

Following these practices makes projects easier to manage, especially when working in teams.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git branch | Displays all branches. |
| git branch branch-name | Creates a new branch. |
| git checkout branch-name | Switches to an existing branch (older method). |
| git checkout -b branch-name | Creates and switches to a new branch. |
| git switch branch-name | Switches to an existing branch (recommended). |
| git switch -c branch-name | Creates and switches to a new branch. |

### Conclusion

Branching is one of Git\'s most valuable features because it allows developers to work on new features, fix bugs, and experiment without affecting the main project. The `git branch` command creates new branches, `git checkout` and `git switch` allow us to move between branches, and each branch provides an isolated environment for development. By using branches effectively, developers can organize their work, collaborate efficiently with team members, and keep the main project stable while continuously adding new functionality. Understanding branching is an essential step toward mastering Git and modern software development workflows.');

-- Lecture 9: Merging Branches
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Merging Branches', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Merging Branches

## Introduction to Merging Branches

In the previous lesson, we learned that a **branch** allows us to work on new features or fix bugs without affecting the main project. However, once the work on a branch is complete, we usually want to add those changes back to the main branch. This process is called **merging**. **Merging** is the process of combining the changes from one branch into another. It allows the work done in separate branches to become part of the main project. Think of branches as **different roads** leading to the same destination. Each road may take a different path, but eventually, they all meet at the same point. Merging is the point where these roads join together. Merging is an essential part of Git because it allows teams to work independently while still producing a single, complete project.

## What is Git Merge?

Git provides the `git merge` command to combine changes from one branch into another.

### Syntax

`git merge branch-name` Before running this command, you must first switch to the branch that will **receive** the changes. For example:

- **main** → The destination branch.

- **login-feature** → The branch containing completed work.

To merge the **login-feature** branch into **main**, we first switch to **main** and then merge.

## Steps to Merge a Branch

Suppose we have two branches:

```

main
login-feature

```

The **login-feature** branch contains a completed login system.

### Step 1: Switch to the Main Branch

`git switch main` or `git checkout main` Now we are working on the **main** branch.

### Step 2: Merge the Feature Branch

Run: `git merge login-feature` Git combines the changes from **login-feature** into **main**. If there are no conflicts, the merge is completed successfully.

### Step 3: Verify the Merge

Use: `git log` or `git status`

## Understanding How Merging Works

Suppose the project starts like this:

```

main
│
├── Initial Commit

```

A new branch is created:

```

main
│
├── Initial Commit
│
└── login-feature

```

The developer adds the login page inside the **login-feature** branch. Later, the branch is merged back into **main**. After merging:

```

main
│
├── Initial Commit
├── Login Feature Added

```

Now the main branch contains all the completed work from the feature branch.

## Fast-Forward Merge

One common type of merge is called a **Fast-Forward Merge**. This happens when the main branch has **not changed** since the feature branch was created. Example:

```

Initial Commit
│
├── main
│
└── login-feature
│
├── Login Page
├── Validation
└── Final Version

```

If **main** has no additional commits, Git simply moves the **main** pointer forward. This is called a **Fast-Forward Merge** because no extra merge commit is needed. It is quick, simple, and keeps the project history clean.

## Three-Way Merge

Sometimes both branches have changed after they were separated. Example:

```

Initial Commit
│
├── main
│ ├── Homepage Updated
│
└── login-feature
├── Login Page Added

```

Now both branches contain new commits. When merging, Git creates a **Merge Commit** that combines the histories of both branches. This process is known as a **Three-Way Merge** because Git compares:

- The common ancestor.

- The main branch.

- The feature branch.

This allows Git to combine changes from both branches into one complete project.

## Merge Conflicts

Sometimes Git cannot automatically combine changes. This situation is called a **Merge Conflict**. A conflict usually happens when:

- Two developers edit the same line of the same file.

- One developer deletes a file while another edits it.

- Git cannot determine which version should be kept.

### Example

Suppose the original file contains: `<h1>Welcome</h1>`

### Main Branch Changes

```

<h1>Welcome to Our Website</h1>

```

### Feature Branch Changes

`<h1>Welcome User</h1>` When Git tries to merge these branches, it cannot decide which heading is correct. Instead of guessing, Git asks the developer to resolve the conflict manually.

## Resolving Merge Conflicts

When a merge conflict occurs:

### Step 1

Open the affected file. Git marks the conflicting sections. Example:

```

<<<<<<< HEAD
Welcome to Our Website
=======
Welcome User
>>>>>>> login-feature

```

### Step 2

Choose the correct content or combine both versions. Example:

```

<h1>Welcome to Our Website</h1>

```

or

```

<h1>Welcome User to Our Website</h1>

```

### Step 3

Save the file.

### Step 4

Stage the resolved file. `git add index.html`

### Step 5

Complete the merge. `git commit` The conflict is now resolved.

## Deleting a Merged Branch

Once a branch has been successfully merged, it is often no longer needed. We can delete it using: `git branch -d login-feature` This removes the branch while keeping all of its merged changes in the **main** branch. Deleting old branches keeps the repository clean and organized.

## Real-Life Example

Imagine a team is developing a **University Management System**. The project has three branches:

```

main
├── student-module
├── teacher-module
└── fee-module

```

Each developer works independently. After completing their work:

- Student Module → Merged into **main**

- Teacher Module → Merged into **main**

- Fee Module → Merged into **main**

The final **main** branch now contains all three completed features. This workflow allows multiple developers to work simultaneously without interfering with each other\'s progress.

## Common Beginner Mistakes

### 1. Merging While on the Wrong Branch

Always switch to the destination branch before merging. Example: `git switch main` Then merge: `git merge login-feature`

### 2. Ignoring Merge Conflicts

Never leave conflict markers in your code. Always resolve conflicts before creating the final commit.

### 3. Deleting a Branch Before Merging

Do not delete a feature branch until you are sure its work has been merged successfully. Even if Git merges successfully, always test the project to ensure everything works correctly.

## Best Practices for Merging

Follow these practices for a smooth Git workflow:

- Keep feature branches focused on a single task.

- Merge frequently to reduce the chances of conflicts.

- Test your code before merging.

- Pull the latest changes before starting a merge in collaborative projects.

- Delete merged branches to keep the repository organized.

- Review the merge using `git log` or `git status` after completion.

These habits make collaboration easier and reduce development errors.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git merge branch-name | Merges the specified branch into the current branch. |
| git switch main | Switches to the main branch before merging. |
| git checkout main | Older command for switching to the main branch. |
| git add filename | Stages resolved files after fixing merge conflicts. |
| git commit | Completes the merge after resolving conflicts. |
| git branch -d branch-name | Deletes a branch after it has been merged. |

### Conclusion

Merging is the process of combining changes from one branch into another, allowing completed work to become part of the main project. Using the `git merge` command, developers can safely integrate new features, bug fixes, and improvements while maintaining an organized project history. Git supports **Fast-Forward** and **Three-Way Merges**, and although merge conflicts may sometimes occur, they can be resolved by carefully reviewing and combining the conflicting changes. By following good branching and merging practices, developers can collaborate efficiently, keep the main branch stable, and ensure that all completed work is successfully integrated into the project.');

-- Lecture 10: Resolving Merge Conflicts
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Resolving Merge Conflicts', 10, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Resolving Merge Conflicts

## Introduction to Merge Conflicts

Git is designed to help developers work together efficiently. Most of the time, Git can automatically combine changes from different branches. However, there are situations where Git cannot determine which changes should be kept. This situation is called a **merge conflict**. A **merge conflict** occurs when Git finds two or more conflicting changes in the same part of a file and cannot merge them automatically. Instead of making the wrong decision, Git stops the merge and asks the developer to resolve the conflict manually. Think of two students editing the same paragraph in a document at the same time. One student changes the title to **"Student Management System"**, while the other changes it to **"University Management System."** Since both edited the same line differently, someone must decide which title should be kept. Git works in the same way. Although merge conflicts may seem difficult at first, they are a normal part of software development and can be resolved with a few simple steps.

## What Causes Merge Conflicts?

Merge conflicts usually occur when two branches contain incompatible changes. Some common causes include:

### 1. Editing the Same Line

Two developers modify the same line of code in different ways.

### Example

**Main Branch**

```

<h1>Welcome to Our Website</h1>

```

**Feature Branch** `<h1>Welcome User</h1>` Git cannot decide which heading should remain.

### 2. One Developer Deletes a File While Another Edits It

Suppose:

- Developer A deletes `about.html`.

- Developer B updates `about.html`.

Git cannot determine whether the file should exist or be deleted.

### 3. Simultaneous Changes to the Same Section

Two developers edit different words within the same paragraph or code block. Even though both changes are valid, Git may not know how to combine them safely.

### 4. Outdated Branches

If a branch has not been updated for a long time, many changes may have occurred in the main branch. Merging these branches later increases the chances of conflicts.

## How Git Detects a Merge Conflict

Suppose we have two branches:

```

main
login-feature

```

Both branches modify the same line. When we run: `git merge login-feature` Git attempts to combine the changes. If it cannot merge automatically, it displays a message similar to:

```

Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed.
Fix conflicts and then commit the result.

```

This message means Git has paused the merge and is waiting for the developer to resolve the conflict.

## Understanding Conflict Markers

When a conflict occurs, Git inserts **conflict markers** into the affected file. Example:

```

<<<<<<< HEAD
<h1>Welcome to Our Website</h1>
=======
<h1>Welcome User</h1>
>>>>>>> login-feature

```

These markers help identify the conflicting changes.

### Meaning of Each Marker

`<<<<<<< HEAD` This represents the version from the **current branch** (the branch you are currently on). `=======` This separates the two versions. `>>>>>>> login-feature` This represents the version from the branch being merged. These markers are temporary and must be removed after resolving the conflict.

## Steps to Resolve a Merge Conflict

Resolving conflicts is usually straightforward.

### Step 1: Identify the Conflict

Git tells you which file contains the conflict. Example: `index.html`

### Step 2: Open the File

Open the conflicted file in your code editor. You will see the conflict markers.

### Step 3: Decide Which Changes to Keep

You have three options:

- Keep the current branch\'s version.

- Keep the incoming branch\'s version.

- Combine both versions.

For example: Original conflict:

```

<<<<<<< HEAD
Welcome to Our Website
=======
Welcome User
>>>>>>> login-feature

```

Resolved version:

```

<h1>Welcome User to Our Website</h1>

```

The conflict markers are removed, and the final content is saved.

### Step 4: Save the File

After editing, save the file normally.

### Step 5: Stage the Resolved File

Tell Git that the conflict has been resolved. `git add index.html`

### Step 6: Complete the Merge

Finally, create the merge commit. `git commit` Git completes the merge successfully.

## Checking Repository Status During a Conflict

While resolving conflicts, the following command is very useful: `git status` Git may display:

```

You have unmerged paths.
Fix conflicts and run "git add".

```

After resolving and staging the files, running: `git status` will show that the repository is ready for the merge commit.

## Real-Life Example

Imagine two students are working on the same PowerPoint presentation. Student A changes the title to: `Software Engineering` Student B changes the title to: `Software Development` When they combine their work, the computer cannot decide which title should remain. They discuss it and agree on:

```

Software Engineering and Development

```

This is exactly how merge conflict resolution works in Git.

## Tips to Reduce Merge Conflicts

Although conflicts cannot always be avoided, they can be reduced.

### 1. Pull the Latest Changes Frequently

Regularly update your branch before starting new work.

### 2. Commit Changes Often

Small commits are easier to merge than large ones.

### 3. Use Separate Feature Branches

Keep each branch focused on one feature or task.

### 4. Communicate with Team Members

If multiple developers are working on the same files, discuss responsibilities in advance.

### 5. Merge Regularly

Avoid leaving branches unmerged for long periods, as this increases the likelihood of conflicts.

## Common Beginner Mistakes

### 1. Deleting the Wrong Code

Always review both versions carefully before choosing what to keep.

### 2. Leaving Conflict Markers in the File

Never leave markers like:

```

<<<<<<<
=======
>>>>>>>

```

These must be removed before completing the merge.

### 3. Forgetting to Stage the Resolved File

After fixing the conflict, remember to run: `git add filename` Otherwise, Git will not know the conflict has been resolved.

### 4. Forgetting the Final Commit

After staging the resolved files, complete the merge by running: `git commit` Without this step, the merge remains incomplete.

## Best Practices for Resolving Merge Conflicts

Follow these practices for smoother collaboration:

- Read the conflict carefully before making changes.

- Understand both versions before deciding which one to keep.

- Test the project after resolving conflicts.

- Commit frequently to reduce large conflicts.

- Pull the latest changes before starting new work.

- Use meaningful branch names and organize your workflow.

These habits make conflict resolution faster and reduce the chances of future issues.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git merge branch-name | Attempts to merge another branch into the current branch. |
| git status | Shows files with merge conflicts and repository status. |
| git add filename | Marks a conflicted file as resolved after editing. |
| git commit | Completes the merge after all conflicts are resolved. |

### Conclusion

Merge conflicts occur when Git cannot automatically combine changes from different branches because the same part of a file has been modified in conflicting ways. Rather than making an incorrect decision, Git asks the developer to resolve the conflict manually. By understanding conflict markers, carefully reviewing the changes, editing the affected files, staging the resolved versions, and completing the merge with a commit, developers can successfully resolve conflicts while preserving important work. Although merge conflicts are common in collaborative software development, following good practices such as frequent commits, regular merges, and clear communication helps minimize them and ensures a smooth development process.');

-- Lecture 11: Rebasing
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Rebasing', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Rebasing

## Introduction to Rebasing

As we learned in previous lessons, Git allows us to create branches so we can work on new features without affecting the main project. After completing our work, we usually combine branches using **merge**. However, Git also provides another method called **rebase**. **Rebasing** is the process of moving or replaying commits from one branch onto another branch. Instead of creating a merge commit, Git places your branch\'s commits on top of the latest commits from the target branch, creating a cleaner and more linear project history. Think of rebasing as **moving your work to the front of the line**. Imagine you wrote several pages in a notebook, but someone updated the first few pages before you finished. Instead of mixing everything together, you simply rewrite your pages after the newest pages so the notebook reads smoothly from beginning to end. Rebasing is commonly used to keep the Git history clean and easy to understand.

## What is Git Rebase?

Git provides the `git rebase` command to move commits from one branch onto another.

### Syntax

`git rebase branch-name` When we run this command, Git temporarily removes the commits from the current branch, updates it with the latest commits from the target branch, and then reapplies our commits one by one. Unlike merging, rebasing usually **does not create a merge commit**. Instead, it creates a straight-line history.

### Simple Example

Suppose we have:

```

main
A ----- B
feature
C ----- D

```

Here:

- `A` and `B` are commits on the **main** branch.

- `C` and `D` are commits on the **feature** branch.

If new commits are added to **main**:

```

main
A ----- B ----- E ----- F
feature
C ----- D

```

Running: `git rebase main` moves commits **C** and **D** after **F**. Result:

```

main
A ----- B ----- E ----- F
\\
C\' ----- D\'

```

Notice that `C\'` and `D\'` are **new commits** because Git has replayed them on top of the updated **main** branch.

## Why Do We Use Rebase?

Rebasing offers several advantages.

### 1. Creates a Clean History

The commit history becomes straight and easier to read. Instead of many merge commits, the project history looks like one continuous timeline.

### 2. Keeps the Branch Up to Date

If the **main** branch has received new commits, rebasing updates your branch before merging.

### 3. Makes Project History Easier to Understand

Developers can follow the sequence of commits without unnecessary branching paths.

### 4. Simplifies Code Reviews

A clean commit history makes it easier for team members to review changes.

## Steps to Perform a Rebase

Suppose we have:

- **main**

- **login-feature**

The **main** branch has received new updates.

### Step 1: Switch to the Feature Branch

`git switch login-feature` or `git checkout login-feature`

### Step 2: Rebase onto the Main Branch

`git rebase main` Git moves the feature branch commits onto the latest version of the **main** branch.

### Step 3: Continue Working

If no conflicts occur, the rebase finishes automatically. The feature branch is now updated and ready to be merged into **main**.

## Rebase vs Merge

Although both commands combine branches, they work differently.

| Feature | Merge | Rebase |
|---|---|---|
| Combines branches | Yes | Yes |
| Creates merge commit | Usually | Usually No |
| Keeps branch history | Yes | Rewrites commit history |
| Produces linear history | Not always | Yes |
| Best for shared branches | Yes | Use carefully |

### Visual Comparison

### Using Merge

```

A --- B --- E
\\ \\
C --- D --- M

```

`M` represents the merge commit.

### Using Rebase

`A --- B --- E --- C\' --- D\'` The history is cleaner because no merge commit is created.

## Rebase Conflicts

Just like merging, rebasing can also produce conflicts. If Git cannot replay a commit automatically, it pauses and displays a conflict message. Example:

```

CONFLICT (content):
Merge conflict in index.html

```

This means Git needs your help before continuing.

## Resolving Rebase Conflicts

When a conflict occurs:

### Step 1: Open the Conflicted File

Git marks the conflicting sections.

### Step 2: Resolve the Conflict

Choose the correct version or combine both changes. Remove the conflict markers.

### Step 3: Stage the Resolved File

`git add index.html`

### Step 4: Continue the Rebase

`git rebase --continue` Git proceeds to replay the remaining commits.

### Canceling a Rebase

If you decide not to continue, use: `git rebase --abort` This restores the branch to its state before the rebase started.

## Real-Life Example

Imagine you are writing a textbook. While you are working on **Chapter 5**, another author updates **Chapters 1–4**. Instead of inserting your chapter into the old version, you rewrite **Chapter 5** so it follows the updated chapters. The book now reads naturally from beginning to end. This is exactly how Git rebasing works—it places your work on top of the latest version of the project.

## Common Beginner Mistakes

### 1. Rebasing the Wrong Branch

Always make sure you are on the correct branch before running: `git rebase main`

### 2. Ignoring Rebase Conflicts

If Git reports a conflict, resolve it before continuing. Do not skip the conflict resolution process.

### 3. Forgetting to Continue the Rebase

After resolving conflicts, remember to run: `git rebase --continue` Otherwise, the rebase remains incomplete.

### 4. Rebasing Shared Branches

Avoid rebasing branches that have already been shared with other developers. Since rebasing rewrites commit history, it can create confusion and synchronization problems for team members.

## Best Practices for Rebasing

To use rebasing effectively:

- Rebase your feature branch regularly to stay up to date with the main branch.

- Resolve conflicts carefully before continuing.

- Use rebase mainly for your local feature branches.

- Avoid rebasing branches that others are already using.

- Test your project after completing a rebase.

- Review the commit history with `git log` after rebasing.

These practices help maintain a clean and organized Git history.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git rebase branch-name | Rebases the current branch onto another branch. |
| git rebase --continue | Continues the rebase after resolving conflicts. |
| git rebase --abort | Cancels the rebase and restores the previous state. |
| git switch branch-name | Switches to another branch before rebasing. |
| git checkout branch-name | Older command for switching branches. |

## When Should We Use Rebase?

Rebasing is most useful when:

- You want a clean and linear commit history.

- You are updating your local feature branch with the latest changes from the **main** branch.

- You are preparing your work before merging it into the main branch.

- You are working individually on a feature branch.

However, if a branch has already been shared with others, merging is often the safer option because it preserves the original commit history.

### Conclusion

Rebasing is a powerful Git feature that allows developers to move their commits onto the latest version of another branch, creating a clean and linear project history. Unlike merging, rebasing usually does not create a merge commit, making the commit timeline easier to read and understand. Although conflicts may occur during a rebase, they can be resolved by editing the affected files, staging the changes, and continuing the rebase process. By using `git rebase` appropriately—especially for local feature branches—developers can maintain an organized Git history while keeping their work synchronized with the latest project updates.');

-- Lecture 12: Stashing Changes
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Stashing Changes', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Stashing Changes

## Introduction to Stashing Changes

While working on a project, there are times when we start making changes but suddenly need to switch to another task. For example, we may be developing a new feature when our team asks us to fix an urgent bug. Since our current work is incomplete, we may not want to commit it yet. Git provides a solution called **Stashing**. **Stashing** is the process of temporarily saving uncommitted changes so that we can work on something else without losing our progress. Later, we can restore those saved changes and continue working from where we left off. Think of a stash as putting unfinished work into a drawer. The work is kept safe inside the drawer, the desk becomes clean, and we can focus on another task. When we are ready, we simply open the drawer and continue our unfinished work. Stashing is useful because it allows developers to switch tasks without creating unnecessary commits.

## What is Git Stash?

Git provides the `git stash` command to temporarily save changes that have not yet been committed. When we run this command:

- Git saves the current modified files.

- The working directory becomes clean.

- The changes are stored in a special temporary area called the **stash**.

- The saved changes can be restored later.

Unlike a commit, a stash is **temporary** and is mainly intended for short-term use.

### Basic Syntax

`git stash` When this command is executed, Git stores all tracked, modified files and restores the working directory to the last committed state.

### Example

Suppose **Anum** is working on a website. She has modified:

```

index.html
style.css

```

Before finishing the feature, she receives an urgent request to fix a bug. Instead of committing incomplete work, she runs: `git stash` Git temporarily saves the changes, allowing Anum to work on the urgent bug without losing her unfinished feature.

## Viewing Stashed Changes

A project can contain multiple stashes. To view all saved stashes, use: `git stash list`

### Example Output

```

stash@{0}: WIP on main: Added login page
stash@{1}: WIP on main: Updated homepage

```

Each stash is given an index number such as:

- `stash@{0}`

- `stash@{1}`

The most recent stash appears at the top of the list.

## Restoring Stashed Changes

After finishing another task, we can restore our saved work. Git provides two commands for this purpose.

### Using

```

git stash apply
git stash apply

```

This restores the latest stash but **does not remove it** from the stash list. If multiple stashes exist, a specific stash can be restored. Example:

```

git stash apply stash@{1}

```

The selected stash is restored while remaining available in the stash list.

### Using

`git stash pop` Another commonly used command is: `git stash pop` This command:

- Restores the latest stash.

- Removes it from the stash list after applying it.

Many developers use `git stash pop` because it automatically cleans up the stash list.

## Deleting Stashes

Sometimes a stash is no longer needed.

### Delete One Stash

```

git stash drop stash@{0}

```

This removes the specified stash.

### Delete All Stashes

`git stash clear` This permanently deletes every stash stored in the repository. Use this command carefully because deleted stashes cannot be easily recovered.

## Naming a Stash

By default, Git assigns a generic message to each stash. To make stashes easier to identify, we can add a custom message.

### Syntax

`git stash save "message"`

### Example

```

git stash save "Working on login page"

```

Now the stash list becomes easier to understand. Example:

```

stash@{0}: Working on login page

```

Descriptive stash messages are especially useful when several stashes are stored. **Note:** In modern versions of Git, the recommended command is: This replaces the older `git stash save` command.

## Practical Workflow Example

Suppose **Anum** is adding a user profile page. Current work:

```

Modified:
profile.html
profile.css

```

Suddenly, a critical bug is reported.

### Step 1: Save Current Work

`git stash`

### Step 2: Fix the Bug

Edit the required files.

### Step 3: Commit the Bug Fix

```

git add .
git commit -m "Fixed login bug"

```

### Step 4: Restore Previous Work

`git stash pop` Anum can now continue working on the user profile page exactly where she stopped. This is one of the most common real-world uses of Git stash.

## Difference Between Stashing and Committing

Although both commands save work, they are used for different purposes.

| Feature | Git Stash | Git Commit |
|---|---|---|
| Saves changes | Yes | Yes |
| Permanent | No | Yes |
| Appears in project history | No | Yes |
| Used for temporary work | Yes | No |
| Requires a commit message | Optional | Yes |

### Simple Comparison

Use **Git Stash** when:

- Your work is incomplete.

- You need to switch tasks quickly.

- You do not want the incomplete work in the project\'s history.

Use **Git Commit** when:

- Your work is complete.

- You want to save it permanently.

- You want it recorded in the repository\'s history.

## Common Beginner Mistakes

### 1. Forgetting About Saved Stashes

Developers sometimes create a stash and forget it exists. Run: `git stash list` regularly to see your saved stashes. **2. Using** `git stash apply` **Repeatedly** Remember: `git stash apply` does not remove the stash. The same changes can be applied multiple times if you are not careful.

### 3. Accidentally Deleting All Stashes

Running: `git stash clear` removes every saved stash permanently. Always check whether important work is still stored before using this command.

### 4. Using Stash for Long-Term Storage

A stash is meant for temporary work. If your feature is complete or important, create a proper commit instead of relying on a stash.

## Best Practices

To use Git stash effectively:

- Use stash only for temporary work.

- Give meaningful names to important stashes.

- Restore stashes as soon as possible.

- Review your stash list regularly.

- Commit completed work instead of keeping it in the stash for a long time.

- Delete unnecessary stashes to keep the repository organized.

Following these practices makes it easier to manage unfinished work without creating confusion.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git stash | Temporarily saves current uncommitted changes. |
| git stash list | Displays all saved stashes. |
| git stash apply | Restores a stash without removing it from the list. |
| git stash apply stash@{0} | Restores a specific stash. |
| git stash pop | Restores the latest stash and removes it from the list. |
| git stash drop stash@{0} | Deletes a specific stash. |
| git stash clear | Deletes all stashes. |
| git stash push -m "message" | Saves a stash with a custom message. |

### Conclusion

Git Stash is a useful feature that allows developers to temporarily save unfinished work without creating a commit. It is especially helpful when an urgent task requires switching to another branch or fixing a critical issue. Commands such as `git stash`, `git stash list`, `git stash apply`, and `git stash pop` make it easy to save, view, restore, and manage temporary changes. By understanding when to use stashing instead of committing, developers can keep their repositories clean, avoid unnecessary commits, and resume unfinished work whenever they are ready.');

-- Lecture 13: Tags in Git
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Tags in Git', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Tags in Git

## Introduction to Tags

As a project grows, developers create many commits. After hundreds or even thousands of commits, it can become difficult to identify important versions of the project. For example, we may want to quickly find the version where Version 1.0 was released or where a major feature was completed. Git provides a feature called **Tags** to solve this problem. A **tag** is a label that points to a specific commit in the Git repository. Tags are usually used to mark important milestones such as software releases, completed versions, or major updates. Think of a tag as a **bookmark in a book**. Instead of searching through every page, you place a bookmark on an important page so you can return to it instantly. Git tags work in the same way by marking important commits. Tags make it easier to identify and access significant points in a project\'s history.

## What is a Git Tag?

A **Git Tag** is a reference that points to a specific commit. Unlike branches, tags do not change as new commits are added. Once a tag is created, it always points to the same commit unless it is manually deleted and recreated. Tags are commonly used to mark:

- Software releases

- Stable versions

- Project milestones

- Backup points before major changes

For example:

```

Version 1.0
Version 2.0
Version 3.0

```

Instead of remembering long commit IDs, developers can simply use meaningful tag names.

## Types of Git Tags

Git supports two main types of tags.

### 1. Lightweight Tags

A **Lightweight Tag** is simply a name that points to a commit. It does not store extra information such as the author\'s name, date, or message.

### Syntax

`git tag v1.0` This creates a lightweight tag named: `v1.0` pointing to the latest commit. Lightweight tags are useful for personal use or temporary labels.

### 2. Annotated Tags

An **Annotated Tag** stores additional information such as:

- Tag name

- Author

- Date

- Tag message

Annotated tags are recommended for official project releases.

### Syntax

```

git tag -a v1.0 -m "First stable release"

```

Here:

- `-a` means **annotated tag**.

- `-m` adds a descriptive message.

Most professional projects use annotated tags because they provide more information.

## Viewing Tags

To display all tags in the repository, use: `git tag`

### Example Output

```

v1.0
v1.1
v2.0

```

This command lists every tag available in the repository.

### Viewing Tag Details

To display detailed information about an annotated tag, use: `git show v1.0` Example output includes:

- Tag name

- Author

- Date

- Tag message

- Associated commit

This helps developers understand what the tagged version represents.

## Creating Tags

Git allows us to create tags for the latest commit or a specific commit.

### Creating a Tag for the Latest Commit

### Lightweight Tag

`git tag v2.0`

### Annotated Tag

```

git tag -a v2.0 -m "Second stable release"

```

This tag now points to the latest commit.

### Tagging a Specific Commit

Suppose a commit ID is: `a8f5f16` We can tag that commit by running:

```

git tag -a v1.0 a8f5f16 -m "Version 1.0 Release"

```

Now the tag points directly to that specific commit instead of the latest one.

## Viewing the Tagged Commit

Sometimes we want to view the project exactly as it was when a tag was created. We can switch to the tagged version using: `git checkout v1.0` Git temporarily moves us to the commit marked by the tag. This allows developers to inspect or test older versions of the project. **Note:** This places Git in a **detached HEAD** state, meaning you are viewing a specific commit rather than working on a branch. If you want to make new changes, create a new branch from the tag.

## Deleting Tags

If a tag is no longer needed, it can be removed.

### Delete a Local Tag

`git tag -d v1.0` Git deletes the specified tag from the local repository. Deleting a tag does **not** delete the commit it points to.

## Practical Workflow Example

Suppose **Anum** has completed the first version of a website.

### Step 1: Commit the Project

```

git add .
git commit -m "Completed website version 1.0"

```

### Step 2: Create an Annotated Tag

```

git tag -a v1.0 -m "First official release"

```

### Step 3: View All Tags

`git tag` Output: `v1.0`

### Step 4: View Tag Information

`git show v1.0` Git displays detailed information about the tagged release. Now, whenever Anum needs to return to Version 1.0, the tag makes it easy to locate that important milestone.

## Tags vs Branches

Although tags and branches may seem similar, they serve different purposes.

| Feature | Tag | Branch |
|---|---|---|
| Points to a commit | Yes | Yes |
| Moves with new commits | No | Yes |
| Used for releases | Yes | No |
| Used for ongoing development | No | Yes |
| Permanent reference | Yes | No |

### Simple Explanation

A **branch** continues to grow as new commits are added. A **tag** remains fixed at one specific commit. This is why tags are ideal for marking released versions.

## Common Beginner Mistakes

### 1. Confusing Tags with Branches

Remember:

- Branches continue to change.

- Tags remain fixed.

### 2. Forgetting to Add a Message

Instead of: `git tag v1.0` prefer:

```

git tag -a v1.0 -m "Version 1.0 Release"

```

Annotated tags provide more useful information.

### 3. Using Random Tag Names

Avoid names such as:

```

version
release
test

```

Use meaningful names like:

```

v1.0
v1.1
v2.0

```

These are easier to understand and follow.

### 4. Assuming Deleting a Tag Deletes the Commit

Deleting a tag only removes the label. The actual commit remains safely stored in the Git repository.

## Best Practices

To use Git tags effectively:

- Use tags for important releases and milestones.

- Prefer annotated tags for official versions.

- Use clear version names such as `v1.0`, `v2.0`, or `v3.1`.

- Add meaningful messages when creating annotated tags.

- Keep your tag names consistent throughout the project.

- Use tags instead of remembering long commit IDs.

These practices make project history easier to understand and manage.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git tag | Lists all tags in the repository. |
| git tag v1.0 | Creates a lightweight tag. |
| git tag -a v1.0 -m "message" | Creates an annotated tag with a message. |
| git tag -a v1.0 commit-id -m "message" | Creates a tag for a specific commit. |
| git show v1.0 | Displays detailed information about a tag. |
| git checkout v1.0 | Switches to the commit referenced by a tag. |
| git tag -d v1.0 | Deletes a local tag. |

### Conclusion

Git Tags provide a simple and effective way to mark important commits in a project\'s history. Unlike branches, tags remain permanently attached to a specific commit, making them ideal for identifying software releases, stable versions, and major milestones. Git supports both **Lightweight Tags** and **Annotated Tags**, with annotated tags being the preferred choice for official releases because they store additional information such as the author, date, and message. By using meaningful tag names and following consistent versioning practices, developers can easily locate important versions of their projects and maintain a well-organized Git history.');

-- Lecture 14: Managing a Full Project with Git
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Managing a Full Project with Git', 14, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Managing a Full Project with Git

## Introduction to Managing a Full Project with Git

Git is much more than a tool for saving files. It helps developers manage an entire software project from start to finish. Throughout a project\'s life, developers create files, make changes, fix bugs, add new features, collaborate with others, and release new versions. Git keeps track of every step, making development organized and reliable. Managing a full project with Git means using Git throughout the complete development process, from creating the repository to releasing the final version. Think of Git as a **project diary**. Every important action is recorded, allowing developers to review the past, return to earlier versions, and work together without losing progress. By following a proper Git workflow, projects become easier to maintain, update, and collaborate on.

## Starting a New Git Project

Every Git project begins by creating a repository.

### Step 1: Create a Project Folder

Example: `StudentManagementSystem` Move into the project folder: `cd StudentManagementSystem`

### Step 2: Initialize Git

Create a Git repository using: `git init` Git creates a hidden `.git` folder that stores the project\'s version history.

### Step 3: Check Repository Status

Verify the repository by running: `git status` Git displays the current status of the project.

## Creating Project Files

After initializing the repository, create the required project files. Example:

```

index.html
style.css
script.js
README.md

```

As files are added or modified, Git detects the changes. Check them using: `git status` Git shows all newly created files as **Untracked Files**.

## Staging and Committing Changes

Once the files are ready, they should be staged and committed. To stage all files: `git add .`

### Create a Commit

Save the staged files permanently.

```

git commit -m "Initial project setup"

```

The first commit usually contains the basic project structure. From this point onward, every important project update should be saved using meaningful commits.

## Organizing Development with Branches

As the project grows, it is better to avoid making changes directly in the **main** branch. Instead, create separate branches for new features.

### Example

Suppose **Anum** is developing a Student Management System. She wants to add a login feature. Create a branch: `git branch login-feature` Switch to it: `git switch login-feature` Now all login-related development happens in this branch without affecting the **main** branch. This approach keeps the project organized and reduces the risk of introducing errors into the main version.

## Checking Progress During Development

Git provides useful commands for monitoring project progress.

### Check Repository Status

`git status` Shows:

- Modified files

- Staged files

- Untracked files

### View Changes

`git diff` Displays the exact modifications made to files.

### View Commit History

`git log` Shows every commit made in the project. These commands help developers understand the current state of the project before making new commits.

## Managing Temporary Work with Git Stash

Sometimes development is interrupted by urgent tasks. Suppose Anum is working on the login page when a critical bug is reported. Instead of committing incomplete work, she saves it temporarily: `git stash` After fixing the urgent issue and committing it: `git stash pop` Her unfinished work is restored, allowing her to continue without losing progress. Git Stash is ideal for temporarily pausing one task while working on another.

## Merging Completed Features

When a feature is finished and tested, it should be merged into the **main** branch.

### Step 1: Switch to Main

`git switch main`

### Step 2: Merge the Feature Branch

`git merge login-feature` The completed login feature is now part of the main project. If Git detects conflicts, they must be resolved before completing the merge.

## Handling Project Versions with Tags

When an important version of the project is completed, create a tag. Suppose Version 1.0 is ready.

```

git tag -a v1.0 -m "First stable release"

```

This tag marks an important milestone. Later, developers can easily return to this version whenever needed. Tags are commonly used for official software releases.

## Using

`.gitignore` Not every file belongs in a Git repository. Create a `.gitignore` file to exclude unnecessary files. Example:

```

node_modules/
.env
*.log
build/

```

This prevents temporary files, dependencies, and sensitive information from being tracked. Using `.gitignore` keeps the repository clean and secure.

## Correcting Mistakes

Mistakes happen during development. Git provides several commands to fix them.

### Unstage a File

`git reset filename`

### Undo a Commit Safely

### Restore a File

`git checkout -- filename` These commands help recover from common development mistakes without damaging the project.

## Practical Project Workflow

Suppose **Anum** is building an **Online Library Management System**. The complete Git workflow might look like this:

### Step 1

Create the project. `git init`

### Step 2

Add project files. `git add .`

### Step 3

Create the first commit.

```

git commit -m "Initial project structure"

```

### Step 4

Create a new feature branch.

```

git switch -c book-management

```

### Step 5

Develop the feature. Check progress regularly.

```

git status
git diff

```

### Step 6

Commit completed work. `git add .`

### Step 7

Merge into the main branch.

```

git switch main
git merge book-management

```

### Step 8

Mark the release.

```

git tag -a v1.0 -m "First project release"

```

The project now has a complete Git history from beginning to release.

## Common Beginner Mistakes

### 1. Working Directly on the Main Branch

Always create a separate branch for new features.

### 2. Forgetting to Commit Frequently

Small, regular commits are easier to understand and manage than one large commit.

### 3. Writing Poor Commit Messages

Avoid messages like: `Update` Instead, write:

```

Added student registration module

```

**4. Ignoring** `.gitignore` Tracking unnecessary files makes the repository larger and more difficult to maintain.

### 5. Forgetting to Check Status

Run: `git status` frequently to stay informed about the project\'s current state.

## Best Practices for Managing a Full Git Project

Follow these practices throughout the project:

- Initialize Git at the beginning of the project.

- Commit small, meaningful changes regularly.

- Write clear and descriptive commit messages.

- Create separate branches for each feature or bug fix.

- Use `git status` and `git diff` before committing.

- Use Git Stash for temporary work.

- Merge completed features into the main branch after testing.

- Use tags to mark important releases.

- Keep a proper `.gitignore` file.

- Back up your work using a remote repository such as GitHub when collaborating.

Following these practices results in a clean, organized, and professional Git workflow.

## Summary of Important Commands

| Command | Purpose |
|---|---|
| git init | Creates a new Git repository. |
| git status | Shows the current repository status. |
| git add . | Stages all modified files. |
| git commit -m "message" | Saves staged changes permanently. |
| git switch -c branch-name | Creates and switches to a new branch. |
| git merge branch-name | Merges a branch into the current branch. |
| git stash | Temporarily saves unfinished work. |
| git stash pop | Restores the most recent stash. |
| git tag -a v1.0 -m "message" | Creates an annotated tag. |
| git log | Displays the commit history. |
| git diff | Shows changes made to files. |
| git reset, git revert, git checkout | Undo or restore changes when needed. |

### Conclusion

Managing a full project with Git involves much more than saving code. It includes initializing a repository, tracking file changes, creating meaningful commits, organizing development with branches, temporarily storing unfinished work using Git Stash, merging completed features, marking important releases with tags, and maintaining a clean repository with `.gitignore`. By following a structured Git workflow and using Git\'s powerful commands effectively, developers can build reliable projects, collaborate efficiently with team members, recover from mistakes, and maintain a clear and organized project history from the first commit to the final release.');
