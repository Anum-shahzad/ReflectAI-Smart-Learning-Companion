-- =============================================
-- ReflectAI — Docker Course Seed (replaces placeholder lectures)
-- Run this in your MySQL database (schema.sql must already be applied)
-- Resolves language_id by name — no hardcoded IDs, safe against
-- whatever IDs your live DB currently has assigned.
-- =============================================
USE reflectai;

SET @lang_id = (SELECT id FROM programming_languages WHERE name = 'Docker' LIMIT 1);

-- Clean slate: remove existing (placeholder) lectures for this language.
-- Cascades to lecture_content / user_progress / quizzes via ON DELETE CASCADE.
DELETE FROM lectures WHERE language_id = @lang_id;

-- Lecture 1: Introduction to Docker & Containerization
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Introduction to Docker & Containerization', 1, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Introduction to Docker & Containerization

## Introduction to Docker and Containerization

Modern software development requires applications to run consistently across different environments. Developers often encounter the classic problem: **"It works on my machine, but not on yours."** Differences in operating systems, installed libraries, software versions, and configurations can cause applications to behave differently on different computers. To solve this problem, **containerization** was introduced. Containerization packages an application together with all its dependencies, libraries, configuration files, and runtime environment into a single unit called a **container**. This ensures that the application behaves the same way regardless of where it is deployed. **Docker** is the world\'s most popular containerization platform. It allows developers to build, package, distribute, and run applications inside lightweight containers. Docker has become a standard tool in software development, DevOps, cloud computing, and continuous integration/continuous deployment (CI/CD). Think of a container like a **shipping container** used in global transportation. Whether the container is moved by truck, train, or ship, its contents remain secure and unchanged. Similarly, a Docker container packages an application so it runs consistently across laptops, servers, and cloud platforms.

## Understanding Containerization

### What is Containerization?

Containerization is the process of packaging an application with everything it needs to run, including:

- Source code

- Runtime environment

- Libraries

- Dependencies

- Configuration files

- System tools

The packaged application is called a **container**. Unlike traditional software installations, containers eliminate dependency conflicts because each container carries its own isolated environment.

### Why Do We Need Containerization?

Before containers became popular, developers commonly faced problems such as:

- Missing libraries

- Different software versions

- Operating system incompatibilities

- Difficult deployments

- Complex server configurations

For example: A developer creates a web application using:

- Python 3.12

- Flask

- SQLite

It works perfectly on their computer. However, another developer only has Python 3.9 installed. The application may fail due to version incompatibilities. With Docker, the application and its required Python version are packaged together, ensuring consistent execution everywhere.

### How Containerization Works

The process generally follows these steps:

```

Write Application
↓
Create Dockerfile
↓
Build Docker Image
↓
Run Docker Container
↓
Application Runs Anywhere

```

This workflow simplifies development and deployment.

## What is Docker?

Docker is an open-source platform used to build, ship, and run containerized applications. Docker enables developers to:

- Build applications

- Package dependencies

- Create reusable images

- Run isolated containers

- Share applications easily

- Deploy consistently across environments

Docker is widely used in:

- Software Development

- DevOps

- Cloud Computing

- Microservices

- Continuous Integration (CI)

- Continuous Deployment (CD)

### History of Docker

Docker was first released in **2013** by **Docker, Inc.** Since then, it has become one of the most important tools in modern software engineering due to its speed, portability, and ease of use.

### Key Features of Docker

Docker offers several powerful features:

- Lightweight containers

- Fast startup times

- Cross-platform compatibility

- Easy application deployment

- Version-controlled images

- Isolation between applications

- Efficient resource utilization

- Integration with cloud services

These features make Docker suitable for projects ranging from small applications to large enterprise systems.

## Virtual Machines vs Containers

Many beginners confuse containers with virtual machines (VMs), but they are different technologies.

| Feature | Virtual Machine | Docker Container |
|---|---|---|
| Operating System | Full OS | Shares host OS kernel |
| Startup Time | Minutes | Seconds |
| Resource Usage | High | Low |
| Size | Several GB | Usually MB to a few hundred MB |
| Performance | Slower | Faster |
| Isolation | Hardware-level | Operating system-level |

### Virtual Machine Architecture

```

Hardware
↓
Host Operating System
↓
Hypervisor
↓
Guest Operating System
↓
Application

```

Each VM includes its own complete operating system.

### Docker Architecture

```

Hardware
↓
Host Operating System
↓
Docker Engine
↓
Containers
↓
Applications

```

Containers share the host operating system\'s kernel, making them lightweight and efficient.

## Docker Architecture

Docker consists of several important components.

### Docker Engine

The Docker Engine is the core software responsible for creating and managing containers. It includes:

- Docker Daemon

- Docker CLI

- REST API

### Docker Daemon

The Docker Daemon (`dockerd`) runs in the background and manages:

- Images

- Containers

- Networks

- Volumes

It performs the actual work requested by Docker commands.

### Docker CLI

The Docker Command Line Interface (CLI) allows users to interact with Docker. Example: `docker run hello-world` The CLI sends commands to the Docker Daemon.

### Docker Images

A Docker image is a read-only template containing everything needed to create a container. An image includes:

- Application code

- Libraries

- Runtime

- Environment variables

- Configuration

Images are reusable and can be shared through registries like Docker Hub.

### Docker Containers

A container is a running instance of a Docker image. One image can create multiple independent containers. Example:

```

Image
↓
Container 1
Container 2
Container 3

```

Each container operates independently.

### Docker Registry

A Docker registry stores Docker images. Popular registries include:

- Docker Hub

- GitHub Container Registry (GHCR)

- Amazon Elastic Container Registry (ECR)

- Google Artifact Registry

- Azure Container Registry (ACR)

Developers can upload and download images from these registries.

## Benefits of Docker

Docker provides numerous advantages.

### Consistency

Applications run the same in development, testing, and production environments.

### Portability

Containers can run on:

- Windows

- Linux

- macOS

- Cloud platforms

- Virtual machines

### Fast Deployment

Containers start within seconds. This significantly reduces deployment time.

### Isolation

Each container has its own environment. Applications do not interfere with one another.

### Resource Efficiency

Containers consume fewer resources than virtual machines because they share the host operating system kernel.

### Scalability

Multiple containers can run simultaneously, making it easy to scale applications as demand grows.

## Installing Docker

Installing Docker depends on the operating system being used.

### Installing Docker on Windows

### System Requirements

- Windows 10 or Windows 11 (64-bit)

- Hardware virtualization enabled

- WSL 2 (Windows Subsystem for Linux) recommended

- Administrator privileges

### Installation Steps

**Step 1:** Download Docker Desktop from the official Docker website. **Step 2:** Run the installer. **Step 3:** Enable the following options if prompted:

- Use WSL 2 instead of Hyper-V (recommended)

- Add Docker to PATH

**Step 4:** Restart the computer if required. **Step 5:** Launch Docker Desktop. Docker starts automatically in the background.

### Installing Docker on macOS

### System Requirements

- macOS 12 or later (or the version supported by the current Docker Desktop release)

- Apple Silicon (M-series) or Intel processor

- Administrator privileges

### Installation Steps

1. Download Docker Desktop for macOS. 2. Open the installer package. 3. Drag Docker into the Applications folder. 4. Launch Docker Desktop. 5. Grant any requested permissions. 6. Wait until Docker finishes starting.

### Installing Docker on Linux (Ubuntu Example)

### Step 1: Update Packages

`sudo apt update`

### Step 2: Install Required Packages

```

sudo apt install ca-certificates curl gnupg

```

### Step 3: Add Docker\'s Official Repository

Follow Docker\'s official installation instructions to add the Docker repository and GPG key for your Ubuntu version.

### Step 4: Install Docker

```

sudo apt install docker-ce docker-ce-cli containerd.io

```

### Step 5: Start Docker

`sudo systemctl start docker`

### Step 6: Enable Docker at Startup

`sudo systemctl enable docker` Docker is now installed and ready for use.

## Verifying the Installation

After installation, verify Docker is working correctly.

### Check Docker Version

`docker --version` Example output:

```

Docker version 28.x.x, build xxxxxxx

```

### Check Docker Information

`docker info` This command displays detailed information about:

- Docker Engine

- Storage driver

- Running containers

- Images

- CPU and memory usage

- Network configuration

### Run the Hello World Container

`docker run hello-world` Expected output:

```

Hello from Docker!
This message shows that your installation appears to be working correctly.

```

This confirms that Docker can download images and run containers successfully.

## Basic Docker Commands

Some essential Docker commands include:

### Check Docker Version

`docker --version`

### Display System Information

`docker info`

### Download an Image

`docker pull nginx`

### List Downloaded Images

`docker images`

### Run a Container

`docker run nginx`

### List Running Containers

`docker ps`

### List All Containers

`docker ps -a`

### Stop a Container

`docker stop <container_id>`

### Remove a Container

`docker rm <container_id>`

### Remove an Image

`docker rmi <image_name>`

## Common Installation Issues

New users may encounter a few common problems.

### Virtualization Disabled

Docker may fail to start if hardware virtualization is disabled in the BIOS/UEFI settings.

### Docker Daemon Not Running

If Docker commands return connection errors, ensure the Docker service is running.

### Permission Denied (Linux)

If Docker requires `sudo` for every command, add your user to the Docker group:

```

sudo usermod -aG docker $USER

```

Log out and back in for the change to take effect.

### Network or Download Errors

If Docker cannot pull images, check:

- Internet connection

- Firewall settings

- Proxy configuration (if applicable)

## Best Practices

To work effectively with Docker:

- Install Docker from official sources.

- Keep Docker Desktop or Docker Engine updated.

- Verify installation using `docker run hello-world`.

- Learn basic Docker commands before advanced features.

- Remove unused images and containers to free disk space.

- Read official documentation for version-specific instructions.

- Use meaningful image and container names.

- Test containers in a development environment before production deployment.

### Conclusion

Docker has revolutionized modern software development by making applications portable, lightweight, and consistent across different environments. Through containerization, developers can package applications with all required dependencies, eliminating compatibility issues and simplifying deployment. Docker\'s architecture, including images, containers, the Docker Engine, and registries, provides a powerful ecosystem for building and distributing software efficiently. By installing Docker correctly and becoming familiar with its basic commands, we establish a strong foundation for learning more advanced topics such as Dockerfiles, Docker Compose, networking, volumes, multi-container applications, and Kubernetes. Docker is now an essential skill for developers, DevOps engineers, and cloud professionals, making it a valuable tool in today\'s software development landscape.');

-- Lecture 2: Images vs Containers
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Images vs Containers', 2, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Images vs Containers

## Introduction to Docker Images and Containers

When learning Docker, one of the first concepts we must understand is the difference between **Docker Images** and **Docker Containers**. Although these terms are closely related, they are not the same. A Docker image serves as the blueprint for an application, while a Docker container is the running instance created from that blueprint. Think of a Docker image as a **recipe** for baking a cake. The recipe lists all the ingredients and instructions needed to make the cake. A Docker container, on the other hand, is the **actual baked cake** produced from that recipe. We can bake many cakes using the same recipe, just as we can create many containers from the same image. Understanding this relationship is essential because every Docker application begins with an image and runs inside one or more containers.

## Understanding Docker Images

### What is a Docker Image?

A **Docker Image** is a read-only template that contains everything required to run an application. It acts as the foundation from which containers are created. A Docker image typically includes:

- Application source code

- Runtime environment

- Required libraries

- Dependencies

- Environment variables

- Configuration files

- Operating system components (minimal base image)

An image cannot execute by itself. It must first be used to create a container.

### Characteristics of Docker Images

Docker images have several important characteristics:

- Read-only after creation

- Reusable across multiple projects

- Portable between systems

- Lightweight compared to virtual machine images

- Versioned using tags

- Easy to share through registries

Because images are reusable, developers can distribute applications without worrying about missing dependencies.

### How Docker Images are Created

Images are usually built from a **Dockerfile**, which contains instructions for assembling the application\'s environment. Example Dockerfile:

```

FROM python:3.12
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "app.py"]

```

After writing the Dockerfile, we build the image using: `docker build -t myapp .` This creates a Docker image named **myapp**.

### Image Layers

Docker images consist of multiple **layers**. Example:

```

Application Code
↑
Python Libraries
↑
Python Runtime
↑
Ubuntu Base Image

```

Each instruction in the Dockerfile creates a new layer. Benefits of layered images include:

- Faster builds

- Reduced storage usage

- Efficient caching

- Easier updates

If only the application code changes, Docker reuses the previous layers instead of rebuilding everything.

## Understanding Docker Containers

### What is a Docker Container?

A **Docker Container** is a running instance of a Docker image. When Docker starts an image, it creates a container that includes:

- Running application

- Writable storage layer

- Network settings

- Isolated environment

- Process management

Containers execute applications in isolation from the host system and from other containers.

### Characteristics of Containers

Docker containers have the following properties:

- Lightweight

- Fast startup

- Portable

- Isolated

- Temporary by default

- Writable while running

Unlike images, containers can change during execution because they have a writable layer.

### Creating a Container

Suppose we have an image called: `nginx` We create a container using: `docker run nginx` Docker performs the following steps: 1. Checks if the image exists locally. 2. Downloads the image if necessary. 3. Creates a container. 4. Starts the application. The container begins running immediately after creation.

### Container Lifecycle

Containers move through several states during their lifetime.

```

Image
↓
Container Created
↓
Running
↓
Stopped
↓
Restarted
↓
Removed

```

Containers can be started, stopped, restarted, or deleted as needed.

## Key Differences Between Images and Containers

Although images and containers work together, they serve different purposes.

| Feature | Docker Image | Docker Container |
|---|---|---|
| Definition | Blueprint for an application | Running instance of an image |
| State | Static | Dynamic |
| Writable | No (read-only) | Yes (writable layer) |
| Execution | Cannot run by itself | Executes the application |
| Purpose | Store application and dependencies | Run the application |
| Multiple Instances | Can create many containers | Each container is independent |
| Storage | Stored locally or in registries | Stored on the local Docker host while running or stopped |

The key idea is simple: **Image = Template Container = Running Application**

## Relationship Between Images and Containers

A single Docker image can create multiple containers. Example:

```

Docker Image
│
┌───┼────────────┐
│ │ │
▼ ▼ ▼
Container A Container B Container C

```

Each container:

- Runs independently.

- Has its own process.

- Has its own writable layer.

- Can be started or stopped without affecting the others.

This makes Docker ideal for running multiple instances of the same application.

## Image and Container Workflow

The normal Docker workflow is:

```

Write Dockerfile
↓
Build Docker Image
↓
↓
Run Container
↓
Application Executes

```

Every Docker application follows this basic process.

### Example Workflow

Step 1: Create Dockerfile. ↓ Step 2: Build image.

```

docker build -t student-app .

```

↓ Step 3: Run container. `docker run student-app` ↓ Application starts successfully.

## Managing Docker Images

Docker provides commands to manage images.

### List Images

`docker images` Example output:

```

REPOSITORY TAG IMAGE ID
nginx latest 1ab23cd
python 3.12 9ef456g
myapp latest 7xy890z

```

### Download an Image

`docker pull ubuntu` Docker downloads the Ubuntu image from Docker Hub.

### Remove an Image

`docker rmi ubuntu` Unused images can be removed to free storage space.

### Build an Image

`docker build -t website .` This creates a new image named **website**.

## Managing Docker Containers

Docker also provides commands for managing containers.

### Run a Container

`docker run nginx`

### Run in Detached Mode

`docker run -d nginx` The `-d` flag runs the container in the background.

### List Running Containers

`docker ps`

### List All Containers

`docker ps -a` Shows both running and stopped containers.

### Stop a Container

`docker stop <container_id>` Gracefully stops the running container.

### Restart a Container

```

docker restart <container_id>

```

Restarts the container.

### Remove a Container

`docker rm <container_id>` Deletes the container permanently.

## Images vs Containers: Real-World Analogy

Imagine building houses.

### Blueprint

A blueprint contains:

- Design

- Measurements

- Materials

- Construction plan

The blueprint itself cannot be lived in. This is like a **Docker Image**.

### House

The completed house:

- Exists physically.

- Can be occupied.

- Can be painted.

- Can be renovated.

This is like a **Docker Container**. One blueprint can build many houses. Similarly: One Docker image can create many containers.

## Common Mistakes Beginners Make

### Confusing Images with Containers

Many beginners think images are already running applications. In reality:

- Images store applications.

- Containers run applications.

### Editing Images Directly

Images are read-only. To make changes: 1. Modify the Dockerfile or source code. 2. Rebuild the image. 3. Create a new container.

### Deleting Containers but Keeping Images

Removing a container does not delete the image. Example: `docker rm container1` The image still exists and can create new containers.

### Deleting Images While Containers Exist

Docker usually prevents deleting an image if it is still being used by existing containers. Containers depending on an image should be removed first.

## Best Practices

To work efficiently with Docker images and containers:

- Build images from clean and well-organized Dockerfiles.

- Use meaningful image names and tags.

- Keep images as small as possible by using lightweight base images.

- Remove unused images and containers regularly.

- Avoid making manual changes inside running containers; update the Dockerfile instead.

- Tag images with version numbers (e.g., `v1.0`, `v2.1`) instead of relying only on `latest`.

- Use one container for one main application or service whenever practical.

- Store reusable images in a container registry such as Docker Hub or GitHub Container Registry.

Following these practices makes applications easier to maintain, deploy, and scale.

## Summary Table

| Aspect | Docker Image | Docker Container |
|---|---|---|
| Nature | Blueprint | Running application |
| State | Static | Active or stopped |
| Writable | No | Yes |
| Purpose | Package application | Execute application |
| Created From | Dockerfile | Docker Image |
| Can Run? | No | Yes |
| Multiple Copies | Yes | Yes |
| Lifetime | Until deleted | Until stopped or removed |

### Conclusion

Docker Images and Docker Containers are the two core building blocks of Docker. A Docker image is a reusable, read-only template that contains an application along with all its dependencies and configuration, while a Docker container is the live, isolated environment created from that image where the application actually runs. Understanding the distinction between images and containers is fundamental to using Docker effectively. By mastering how images are built, how containers are created and managed, and how both work together, we establish a solid foundation for more advanced Docker topics such as Dockerfiles, Docker Compose, networking, persistent storage, container orchestration, and Kubernetes.');

-- Lecture 3: Writing a Dockerfile
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Writing a Dockerfile', 3, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Writing a Dockerfile

## Introduction to Dockerfiles

One of the most important concepts in Docker is the **Dockerfile**. A Dockerfile is a simple text file that contains a set of instructions used to build a **Docker Image** automatically. Instead of manually installing software, copying files, and configuring an application every time, we write these steps once in a Dockerfile. Docker then follows these instructions to create a consistent and reusable image. Think of a Dockerfile as a **recipe** for cooking a meal. The recipe lists the ingredients and the order in which they should be used. Similarly, a Dockerfile tells Docker exactly how to prepare the application\'s environment, ensuring the same result every time it is built. Dockerfiles make application deployment faster, more reliable, and easier to automate. Whether we are building a small web application or a large enterprise system, Dockerfiles provide a repeatable way to package software.

## What is a Dockerfile?

A **Dockerfile** is a plain text file named **Dockerfile** (without any file extension). It contains instructions that Docker reads from top to bottom to build an image. A Dockerfile defines:

- The base image

- Application files

- Dependencies

- Environment variables

- Working directory

- Network ports

- Startup command

Once written, the Dockerfile can be reused to build identical images on any system that has Docker installed.

### Why Do We Use Dockerfiles?

Dockerfiles provide several advantages:

- Automate image creation

- Ensure consistent environments

- Simplify deployment

- Reduce manual configuration

- Support version control

- Improve collaboration

- Integrate with CI/CD pipelines

Without Dockerfiles, developers would need to manually configure every container, increasing the chance of errors and inconsistencies.

## Basic Structure of a Dockerfile

A Dockerfile consists of instructions written one per line. Example:

```

FROM python:3.12
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]

```

Docker executes these instructions in the order they appear.

### How Docker Builds an Image

The build process follows these steps:

```

Dockerfile
↓
Docker Build
↓
Docker Image
↓
Docker Container
↓
Application Runs

```

Every successful Docker application begins with a properly written Dockerfile.

## Common Dockerfile Instructions

Dockerfiles use predefined instructions, each serving a specific purpose.

### 1. FROM

The `FROM` instruction specifies the base image. Syntax: `FROM image-name:tag` Example: `FROM ubuntu:24.04` or `FROM node:20` or `FROM python:3.12` The `FROM` instruction is usually the first command in a Dockerfile because every image starts from an existing base image.

### 2. WORKDIR

`WORKDIR` sets the working directory inside the container. Example: `WORKDIR /app` All subsequent commands will execute inside this directory. Without `WORKDIR`, Docker uses the root directory by default.

### 3. COPY

The `COPY` instruction copies files from the host computer into the Docker image. Syntax: `COPY source destination` Example: `COPY . .` This copies all files from the current project directory into the current working directory inside the image. Another example: `COPY package.json /app/` Only the specified file is copied.

### 4. ADD

`ADD` is similar to `COPY` but provides additional functionality. `ADD project.zip /app/` It can also extract local compressed archives automatically. For most file-copying tasks, `COPY` is preferred because it is simpler and more predictable.

### 5. RUN

`RUN` executes commands during the image build process. Example: `RUN apt update` Example:

```

RUN pip install -r requirements.txt

```

Each `RUN` instruction creates a new image layer.

### 6. CMD

`CMD` specifies the default command that runs when a container starts. Example: `CMD ["python", "app.py"]` Only one `CMD` instruction should normally appear in a Dockerfile. If multiple `CMD` instructions are present, only the last one takes effect.

### 7. ENTRYPOINT

`ENTRYPOINT` defines the main executable that always runs when the container starts. Example: `ENTRYPOINT ["python"]` Combined with: `CMD ["app.py"]` The container runs: `python app.py` Unlike `CMD`, `ENTRYPOINT` is intended for fixed startup behavior.

### 8. EXPOSE

The `EXPOSE` instruction documents the network port the application listens on. Example: `EXPOSE 3000` Example: `EXPOSE 8080 EXPOSE` does **not** publish the port to the host by itself; it simply indicates which port the application uses.

### 9. ENV

`ENV` sets environment variables. Example: `ENV APP_ENV=production` Example: `ENV PORT=5000` Environment variables make applications easier to configure without modifying code.

### 10. LABEL

`LABEL` adds metadata to the image. Example:

```

LABEL author="John Doe"
LABEL version="1.0"

```

Labels help identify image information such as version, maintainer, or project description.

### 11. USER

`USER` specifies which user executes subsequent commands. Example: `USER appuser` Running applications as a non-root user improves security.

## Building a Simple Dockerfile

Suppose we have a Python application. Project structure:

```

student-app/
│
├── app.py
├── requirements.txt
└── Dockerfile

```

Example Dockerfile:

```

FROM python:3.12
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]

```

### Explanation

| Instruction | Purpose |
|---|---|
| FROM | Uses Python as the base image |
| WORKDIR | Sets /app as the working directory |
| COPY | Copies project files into the image |
| RUN | Installs Python dependencies |
| EXPOSE | Documents port 5000 |
| CMD | Starts the application |

## Building the Docker Image

After writing the Dockerfile, build the image using:

```

docker build -t student-app .

```

Explanation:

- `docker build` → Builds an image.

- `-t` → Assigns a name (tag) to the image.

- `student-app` → Image name.

- `.` → Uses the current directory as the build context.

Docker reads the Dockerfile and creates the image step by step.

### Viewing Images

To display all available images: `docker images` Example output:

```

REPOSITORY TAG IMAGE ID
student-app latest ab123cd
python 3.12 ef456gh

```

## Running a Container from the Image

Once the image is built, create a container: `docker run student-app` To map the container\'s port to the host machine:

```

docker run -p 5000:5000 student-app

```

Explanation:

- First `5000` → Host machine port.

- Second `5000` → Container port.

The application is now accessible through the host on port `5000`.

## Docker Build Cache

Docker speeds up image creation by using a **build cache**. Example Dockerfile:

```

FROM python:3.12
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

```

If only the application code changes, Docker reuses the cached dependency installation layer instead of reinstalling packages. Benefits include:

- Faster builds

- Reduced resource usage

- Improved developer productivity

## Dockerfile Best Practices

Writing efficient Dockerfiles improves performance, security, and maintainability.

### Use Official Base Images

Choose trusted images from official repositories whenever possible. Example: `FROM python:3.12-slim` Smaller base images reduce download size and improve security.

### Keep Images Small

Avoid installing unnecessary software. Smaller images:

- Download faster

- Deploy faster

- Consume less storage

- Have fewer security vulnerabilities

### Combine RUN Commands

Instead of:

```

RUN apt update
RUN apt install -y curl

```

Use:

```

RUN apt update && apt install -y curl

```

This reduces the number of image layers.

### Use .dockerignore

Create a `.dockerignore` file to exclude unnecessary files from the build context. Example:

```

node_modules
.git
.env
__pycache__

```

This speeds up builds and reduces image size.

### Avoid Running as Root

For better security, create and use a non-root user whenever practical.

```

RUN useradd appuser
USER appuser

```

### Use Specific Image Tags

Instead of: `FROM node:latest` Prefer: `FROM node:20` Specific tags make builds more predictable and reproducible.

## Common Dockerfile Mistakes

### 1. Forgetting the Build Context

Running: `docker build` without specifying the build context (such as `.`) results in an error. Correct: `docker build -t app .`

### 2. Incorrect File Paths

Incorrect paths in `COPY` instructions may cause build failures. Always verify source and destination locations.

### 3. Too Many Layers

Using many separate `RUN` commands creates unnecessary image layers and increases image size.

### 4. Large Images

Installing unnecessary packages leads to larger images, slower downloads, and increased storage usage.

### 5. Exposing the Wrong Port

Ensure the port specified in `EXPOSE` matches the application\'s listening port.

## Real-World Example

Suppose we build a Node.js web application. Project structure:

```

node-app/
│
├── package.json
├── server.js
├── public/
└── Dockerfile

```

Dockerfile:

```

FROM node:20
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]

```

Build: `docker build -t node-app .` Run:

```

docker run -p 3000:3000 node-app

```

The application is now running inside a Docker container and is accessible on the host machine through port `3000`.

## Summary of Common Dockerfile Instructions

| Instruction | Purpose |
|---|---|
| FROM | Specifies the base image |
| WORKDIR | Sets the working directory |
| COPY | Copies files into the image |
| ADD | Copies files and supports additional features like extracting local archives |
| RUN | Executes commands during image build |
| CMD | Defines the default startup command |
| ENTRYPOINT | Specifies the main executable |
| EXPOSE | Documents the application\'s port |
| ENV | Sets environment variables |
| LABEL | Adds metadata to the image |
| USER | Specifies the user for subsequent instructions |

### Conclusion

A Dockerfile is the foundation of every Docker image and plays a vital role in creating consistent, portable, and reproducible application environments. By defining a series of instructions such as selecting a base image, copying project files, installing dependencies, configuring `.dockerignore`, and avoiding root execution—helps improve performance, security, and maintainability. Mastering Dockerfiles is an essential step toward advanced containerization topics, including Docker Compose, multi-stage builds, image optimization, and container orchestration with Kubernetes.');

-- Lecture 4: Building & Running Images
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Building & Running Images', 4, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Building & Running Images

## Introduction to Building and Running Docker Images

After creating a Dockerfile, the next step in the Docker workflow is building an image and running it as a container. These two operations form the core of Docker usage. Building an image packages the application and its dependencies into a reusable unit, while running the image creates a container where the application executes. Think of the process like constructing and driving a car. The blueprint and manufacturing process produce the car, similar to building a Docker image. Once the car is ready, it can be driven on the road, just as a Docker image can be run as a container. Understanding how to build and run Docker images is essential because every Docker-based application follows this workflow. Whether deploying a small website or a large microservices system, developers repeatedly build images and run containers.

## Understanding the Docker Build Process

### What Does Building an Image Mean?

Building an image means converting a Dockerfile into a Docker image. During the build process, Docker:

- Reads the Dockerfile.

- Executes instructions one by one.

- Creates image layers.

- Packages the application and dependencies.

- Stores the finished image locally.

The resulting image can then be used to create one or more containers.

### Docker Build Workflow

The image creation process follows this sequence:

```

Application Code
↓
Dockerfile
↓
docker build
↓
Docker Image
↓
docker run
↓
Container

```

This workflow forms the foundation of containerized application deployment.

### What is a Build Context?

The **build context** is the set of files available to Docker during the build process. Example project:

```

project/
│
├── app.py
├── requirements.txt
├── Dockerfile
└── README.md

```

When running: `docker build .` Docker sends all files in the current directory to the Docker daemon as the build context.

## Building Docker Images

The most common command for building images is: `docker build -t myapp .`

### Explanation

| Part | Meaning |
|---|---|
| docker build | Builds an image |
| -t | Adds a tag (name) |
| myapp | Image name |
| . | Current directory as build context |

After execution, Docker creates an image named **myapp**.

### Example Build Process

Suppose we have the following Dockerfile:

```

FROM python:3.12
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "app.py"]

```

Build command:

```

docker build -t student-app .

```

Docker performs these actions:

```

Download Base Image
↓
Create Working Directory
↓
Copy Files
↓
Install Dependencies
↓
Configure Startup Command
↓
Create Image

```

The completed image is stored locally.

### Viewing Available Images

To display all local images: `docker images` Example output:

```

REPOSITORY TAG IMAGE ID
student-app latest a123bc4
python 3.12 d567ef8
nginx latest x901yz2

```

This command helps verify successful image creation.

### Tagging Images

Tags identify image versions. Example:

```

docker build -t student-app:v1 .

```

Another version:

```

docker build -t student-app:v2 .

```

Tags make it easy to manage multiple releases.

### Building Without Cache

Docker normally uses cached layers to speed up builds. To rebuild everything:

```

docker build --no-cache -t myapp .

```

This forces Docker to execute all instructions again.

## Understanding Docker Images

### Image Structure

Docker images consist of multiple layers. Example:

```

Application Files
↑
Python Packages
↑
Python Runtime
↑
Linux Base Image

```

Each layer represents an instruction in the Dockerfile.

### Why Layers Matter

Layers provide several advantages:

- Faster builds

- Reduced storage usage

- Efficient image sharing

- Easier updates

If only the application code changes, Docker reuses previously built layers whenever possible.

### Inspecting an Image

To display detailed image information: `docker inspect myapp` Information includes:

- Image ID

- Creation date

- Environment variables

- Configuration settings

- Layer details

### Viewing Image History

To see image layers: `docker history myapp` This command shows how the image was constructed.

## Running Docker Images

### What Happens When an Image Runs?

A Docker image is only a template. When we execute: `docker run myapp` Docker: 1. Finds the image. 2. Creates a container. 3. Adds a writable layer. 4. Starts the application. The container begins running immediately.

### Basic Run Command

Syntax: `docker run image-name` Example: `docker run nginx` This creates and starts a container using the Nginx image.

### Running a Named Container

Instead of using a random container name:

```

docker run --name webserver nginx

```

Container name: `webserver` Naming containers simplifies management.

### Running in Detached Mode

Normally, containers run in the foreground. To run in the background: `docker run -d nginx` The `-d` flag stands for **detached mode**. Benefits:

- Terminal remains available.

- Container continues running independently.

- Useful for web servers and APIs.

## Port Mapping

### Why Port Mapping is Needed

Applications inside containers are isolated. Suppose a web application listens on: `Port 5000` inside the container. Without port mapping, the host machine cannot access it.

### Mapping Ports

Syntax:

```

docker run -p host_port:container_port image-name

```

Example:

```

docker run -p 5000:5000 student-app

```

Explanation:

| Port | Purpose |
|---|---|
| First 5000 | Host machine |
| Second 5000 | Container |

Users can now access: `http://localhost:5000`

### Another Example

`docker run -p 8080:80 nginx` Result:

```

Host Port 8080
↓
Container Port 80

```

Visiting: `http://localhost:8080` opens the Nginx website.

## Managing Running Containers

### Viewing Running Containers

`docker ps` Example output:

```

CONTAINER ID IMAGE
a12bc34 nginx
d56ef78 student-app

```

Only active containers are displayed. `docker ps -a` Displays:

- Running containers

- Stopped containers

- Exited containers

### Stopping a Container

`docker stop container_id` Example: `docker stop a12bc34` Docker shuts down the container gracefully.

### Starting a Stopped Container

`docker start container_id` Example: `docker start a12bc34` The container resumes execution.

### Restarting a Container

`docker restart container_id` This combines stop and start operations.

### Removing a Container

`docker rm container_id` Example: `docker rm a12bc34` The container is permanently deleted.

## Running Interactive Containers

Some containers require direct user interaction. Example: `docker run -it ubuntu`

### Explanation

| Flag | Purpose |
|---|---|
| -i | Interactive mode |
| -t | Terminal access |

Result: Users can execute Linux commands inside the container.

### Exiting Interactive Mode

To leave the container: `exit` The container stops after exiting unless configured otherwise.

## Viewing Container Logs

Applications often generate logs. To display logs: `docker logs container_id` Example: `docker logs webserver` Logs help:

- Debug issues

- Monitor applications

- Track errors

- Verify startup success

### Following Logs in Real Time

`docker logs -f webserver` The `-f` option continuously streams new log entries.

## Executing Commands Inside Running Containers

Sometimes we need to inspect a running container. Example:

```

docker exec -it webserver bash

```

This opens a shell inside the container. Once inside:

```

ls
pwd
cat config.txt

```

can be executed normally.

### Common Uses

- Troubleshooting

- Viewing files

- Testing commands

- Checking configurations

This feature is extremely useful during development and debugging.

## Best Practices for Building and Running Images

### Use Meaningful Image Names

Instead of: `app` Use: `student-management-system` Clear names improve maintainability.

### Tag Versions Properly

Example:

```

v1.0
v1.1
v2.0

```

Version tags make deployments predictable.

### Use Small Base Images

Example: `FROM python:3.12-slim` Smaller images:

- Download faster

- Consume less storage

- Improve security

### Clean Up Unused Resources

Remove unused containers: `docker container prune` Remove unused images: `docker image prune` This prevents storage waste.

### Avoid Running as Root

Whenever possible: `USER appuser` Running applications as non-root users improves security.

## Common Mistakes

### Forgetting Port Mapping

A web application may run successfully inside a container but remain inaccessible externally. Always map ports correctly.

### Using Latest Tags Everywhere

Example: `FROM node:latest` This can introduce unexpected updates. Prefer: `FROM node:20`

### Not Naming Containers

Unnamed containers are harder to manage. Use:

```

docker run --name api-server myapp

```

### Leaving Unused Containers

Old containers consume resources and create confusion. Regular cleanup is recommended.

### Ignoring Logs

Logs provide valuable debugging information. Always check logs when applications fail to start.

## Complete Workflow Example

Consider a Flask application. **Step 1: Build Image** `docker build -t flask-app .` ↓ **Step 2: Verify Image** `docker images` ↓ **Step 3: Run Container**

```

docker run -d -p 5000:5000 --name flask-container flask-app

```

↓ **Step 4: Check Running Containers** `docker ps` ↓ **Step 5: View Logs** `docker logs flask-container` ↓ **Step 6: Stop Container** `docker stop flask-container` ↓ **Step 7: Remove Container** `docker rm flask-container` This workflow represents a typical Docker development cycle.

### Conclusion

Building and running Docker images are fundamental skills in containerized application development. The build process transforms a Dockerfile into a reusable image that contains everything required for an application to run, while the run process creates a container that interactive sessions, logging, and debugging, we gain the ability to deploy applications consistently across different systems. Following best practices such as using meaningful names, proper version tags, lightweight base images, and regular cleanup helps create efficient and maintainable Docker environments. These skills form the foundation for more advanced topics such as Docker Compose, networking, volumes, container registries, CI/CD pipelines, and Kubernetes orchestration.');

-- Lecture 5: Docker CLI Commands – Complete Lecture Notes
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Docker CLI Commands – Complete Lecture Notes', 5, 'beginner');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Docker CLI Commands

## Introduction to Docker CLI

The **Docker Command Line Interface (CLI)** is the primary tool used to interact with Docker. It allows us to build images, create containers, manage networks, inspect resources, and perform many other Docker-related tasks using simple terminal commands. Think of the Docker CLI as the **remote control for Docker**. Just as a remote control lets us manage a television without touching it directly, the Docker CLI allows us to control Docker Engine by typing commands into a terminal. Every command entered into the Docker CLI is sent to the **Docker Daemon**, which performs the requested operation. Learning Docker CLI commands is one of the most important steps toward becoming proficient with Docker.

## Understanding Docker CLI

### What is Docker CLI?

The Docker CLI is a command-line program installed with Docker Desktop or Docker Engine. It enables users to:

- Build Docker images

- Run containers

- Stop containers

- Remove images

- Manage networks

- Create volumes

- View logs

- Inspect Docker resources

- Push and pull images from registries

Instead of using a graphical interface, Docker CLI provides a fast, flexible, and scriptable way to manage Docker.

### Basic Docker Command Syntax

Most Docker commands follow this format: `docker <command> <options>` Example: `docker images` Here:

- `docker` → Calls the Docker CLI.

- `images` → Lists available Docker images.

Another example: `docker ps` This command displays all currently running containers.

### How Docker CLI Works

The communication flow is:

```

User
↓
Docker CLI
↓
Docker Daemon
↓
Docker Resources

```

The Docker Daemon performs the requested operations and returns the results to the CLI.

## Docker Information Commands

These commands help verify Docker installation and display system information.

### 1. Check Docker Version

Displays the installed Docker version. `docker --version` Example output:

```

Docker version 28.x.x, build abc123

```

This command confirms that Docker is installed correctly.

### 2. Display Detailed Docker Information

`docker info` This command provides information about:

- Docker Engine

- Number of containers

- Number of images

- Storage driver

- CPU usage

- Memory

- Operating system

- Docker root directory

It is commonly used when troubleshooting Docker installations.

### 3. Display Docker Help

`docker --help` This command lists all available Docker commands and usage information. To view help for a specific command: `docker run --help`

## Docker Image Commands

Images are templates used to create containers.

### 1. List Images

`docker images` Example output:

```

REPOSITORY TAG IMAGE ID
ubuntu latest abc123
nginx latest xyz456
python 3.12 mno789

```

This displays all images stored locally.

### 2. Download an Image

`docker pull nginx` Docker downloads the Nginx image from Docker Hub. Another example: `docker pull python:3.12` If the image already exists locally, Docker does not download it again.

### 3. Build an Image

`docker build -t myapp .` Explanation:

| Option | Purpose |
|---|---|
| docker build | Builds an image |
| -t | Assigns a tag (name) |
| myapp | Image name |
| . | Current directory (build context) |

### 4. Remove an Image

`docker rmi nginx` Or remove using the image ID: `docker rmi abc123` Docker prevents removal if the image is still used by existing containers.

### 5. Inspect an Image

`docker inspect nginx` This displays detailed information such as:

- Image ID

- Layers

- Environment variables

- Creation time

- Architecture

### 6. View Image History

`docker history nginx` This shows each layer used to build the image.

## Docker Container Commands

Containers are running instances of Docker images.

### 1. Run a Container

`docker run nginx` Docker automatically: 1. Finds the image. 2. Creates a container. 3. Starts the application.

### 2. Run a Named Container

```

docker run --name webserver nginx

```

Using meaningful names makes containers easier to identify.

### 3. Run in Detached Mode

`docker run -d nginx` The `-d` option runs the container in the background.

### 4. Interactive Mode

`docker run -it ubuntu` Options:

- `-i` → Interactive mode

- `-t` → Terminal access

This opens a shell inside the Ubuntu container.

### 5. Port Mapping

`docker run -p 8080:80 nginx` Explanation:

| Port | Description |
|---|---|
| 8080 | Host machine |
| 80 | Container |

The application becomes accessible at: `http://localhost:8080`

## Managing Containers

### 1. List Running Containers

`docker ps` Example:

```

CONTAINER ID IMAGE
a123bc nginx
d456ef python

```

### 2. List All Containers

`docker ps -a` Displays:

- Running containers

- Stopped containers

- Exited containers

### 3. Stop a Container

`docker stop webserver` Docker stops the running container gracefully.

### 4. Start a Container

`docker start webserver` Starts a previously stopped container.

### 5. Restart a Container

`docker restart webserver` Equivalent to stopping and starting the container.

### 6. Remove a Container

`docker rm webserver` Deletes the specified container.

### 7. Force Remove a Running Container

`docker rm -f webserver` This stops and removes the container immediately.

## Container Inspection Commands

### 1. View Logs

`docker logs webserver` Logs help diagnose application behavior.

### 2. Follow Logs Continuously

`docker logs -f webserver` Displays new log entries as they are generated.

### 3. Execute Commands Inside a Running Container

```

docker exec -it webserver bash

```

This opens a shell inside the container. Example commands:

```

ls
pwd
cat config.txt

```

### 4. Inspect a Container

`docker inspect webserver` Shows detailed configuration information, including:

- Networking

- Volumes

- Environment variables

- Container ID

- Mount points

## Docker Volume Commands

Volumes provide persistent storage for containers.

### Create a Volume

```

docker volume create myvolume

```

### List Volumes

`docker volume ls`

### Inspect a Volume

```

docker volume inspect myvolume

```

### Remove a Volume

`docker volume rm myvolume` Volumes preserve data even after containers are removed.

## Docker Network Commands

Docker networks allow containers to communicate.

### List Networks

`docker network ls`

### Create a Network

```

docker network create app-network

```

### Inspect a Network

```

docker network inspect app-network

```

### Remove a Network

```

docker network rm app-network

```

Networks simplify communication between multiple containers.

## Docker System Commands

These commands manage Docker resources.

### View Disk Usage

`docker system df` Displays storage used by:

- Images

- Containers

- Volumes

- Build cache

### Remove Unused Resources

`docker system prune` Removes:

- Stopped containers

- Unused networks

- Unused images

- Build cache

To remove all unused images as well: `docker system prune -a` Be cautious, as this may delete resources you still need.

## Docker Registry Commands

Docker images can be shared using registries such as Docker Hub.

### Log In

`docker login` Prompts for Docker Hub credentials.

### Log Out

`docker logout` Ends the current registry session.

### Push an Image

```

docker push username/myapp:v1

```

Uploads an image to a registry.

### Pull an Image

```

docker pull username/myapp:v1

```

Downloads an image from a registry.

## Useful Docker CLI Options

| Option | Purpose |
|---|---|
| -d | Run container in detached mode |
| -it | Interactive terminal |
| --name | Assign a container name |
| -p | Map host and container ports |
| -v | Mount a volume |
| -e | Set an environment variable |
| --rm | Automatically remove the container after it exits |
| --help | Display help information |

Example:

```

docker run -d --name website -p 8080:80 nginx

```

## Common Docker CLI Workflow

A typical Docker workflow is:

```

Write Dockerfile
↓
Build Image
↓
View Images
↓
Run Container
↓
Check Running Containers
↓
View Logs
↓
Stop Container
↓
Remove Container
↓
Remove Image

```

Example commands:

```

docker build -t myapp .
docker images
docker run -d --name app1 -p 5000:5000 myapp
docker ps
docker logs app1
docker stop app1
docker rm app1
docker rmi myapp

```

Follow these best practices for efficient Docker management:

- Use meaningful names for containers and images.

- Tag images with version numbers instead of relying on `latest`.

- Remove unused containers and images regularly.

- Check logs when troubleshooting applications.

- Use official base images whenever possible.

- Keep Docker updated to the latest stable version.

- Verify commands with `--help` if unsure.

- Use volumes for persistent data instead of storing important data inside containers.

- Use custom networks for multi-container applications.

- Test Docker commands in a development environment before deploying to production.

## Common Mistakes to Avoid

Avoid these common errors when working with Docker CLI:

- Forgetting to map ports when running web applications.

- Using `docker rm` on running containers without stopping them first (unless using `-f`).

- Accidentally deleting important images with `docker system prune -a`.

- Running everything as the root user without considering security.

- Forgetting to name containers, making them difficult to identify.

- Ignoring container logs during debugging.

- Using outdated or unsupported image versions.

Learning from these mistakes helps create a more reliable and efficient Docker workflow.

### Conclusion

The Docker Command Line Interface (CLI) is the primary tool for managing Docker resources and is an essential skill for every developer working with containers. Through Docker CLI commands, we can build images, run containers, manage storage, configure networks, inspect resources, view logs, and interact with container registries efficiently. Mastering these commands enables us to automate development tasks, simplify deployments, and troubleshoot applications effectively. By following best practices such as using meaningful names, maintaining clean Docker environments, tagging image versions, and regularly removing unused resources, we can work more productively and build a strong foundation for advanced Docker topics like Docker Compose, container orchestration, CI/CD pipelines, and Kubernetes.');

-- Lecture 6: Environment Variables in Containers
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Environment Variables in Containers', 6, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Environment Variables in Containers

Environment variables are one of the most important concepts in containerized applications. They allow us to configure applications without changing the application code. Instead of hardcoding values such as database credentials, API keys, application modes, or server ports, we can store these values as environment variables and inject them into a container when it starts. Think of a container as a traveler carrying only the essentials. Instead of packing every possible item inside the suitcase, the traveler receives what they need at the destination. Environment variables work in a similar way—they provide configuration to a container at runtime, making applications more flexible, portable, and secure.

## Understanding Environment Variables

### What Are Environment Variables?

Environment variables are key-value pairs stored by the operating system or container runtime that applications can access while running. A simple example looks like this:

```

APP_NAME=MyApplication
PORT=3000
NODE_ENV=production

```

Here:

- **APP_NAME** identifies the application.

- **PORT** specifies the listening port.

- **NODE_ENV** defines the execution environment.

Applications simply read these variables instead of storing values directly in the source code.

### Why Do We Need Environment Variables?

Without environment variables, every time we moved our application from development to testing or production, we would need to edit the source code. For example: Development Database: `localhost` Production Database: `database.company.com` Instead of changing code, we simply modify: `DATABASE_URL=localhost` or

```

DATABASE_URL=database.company.com

```

The application remains exactly the same.

### Benefits

Environment variables provide several advantages:

- Code remains reusable.

- Configuration becomes flexible.

- Easier deployment.

- Better security than hardcoding values.

- Supports multiple environments.

- Makes automation easier.

## Using Environment Variables in Docker Containers

### Passing Variables During Container Execution

Docker allows us to pass variables using the **-e** option. Example:

```

docker run -e APP_NAME=InventoryApp nginx

```

Passing multiple variables:

```

docker run \\
-e PORT=8080 \\
-e NODE_ENV=production \\
-e DEBUG=false \\
myapp

```

The application inside the container can access these values immediately.

### Viewing Environment Variables

To inspect container variables:

```

docker exec container_name env

```

or `printenv` Example output:

```

HOSTNAME=95fd...
PATH=/usr/local/bin
PORT=8080
NODE_ENV=production

```

### Default Environment Variables

Containers already include several predefined variables. Examples include:

```

HOSTNAME
PATH
HOME
PWD

```

These are automatically created by Linux.

## Defining Environment Variables in Dockerfiles

### Using the ENV Instruction

Dockerfiles allow permanent environment variables. Example:

```

FROM node:20
ENV PORT=3000
ENV NODE_ENV=production
WORKDIR /app
COPY . .
CMD ["node","server.js"]

```

Here:

- PORT becomes available inside the container.

- NODE_ENV remains accessible whenever the container starts.

### Multiple Variables

Docker supports multiple variables.

```

ENV APP_NAME=StoreApp \\
VERSION=1.0 \\
AUTHOR=Admin

```

This improves readability.

### Overriding ENV Values

Runtime variables override Dockerfile variables. Dockerfile: `ENV PORT=3000` Runtime:

```

docker run -e PORT=5000 myapp

```

Result: `PORT=5000` The runtime value takes priority.

## Managing Environment Variables Efficiently

### Using .env Files

Instead of typing many variables manually, Docker can read them from a file. Example:

```

APP_NAME=ShopApp
PORT=8080
DATABASE_URL=mysql
DEBUG=false

```

Run:

```

docker run --env-file .env myapp

```

Advantages:

- Cleaner commands

- Easy maintenance

- Better teamwork

- Centralized configuration

### Environment Variables in Docker Compose

Docker Compose simplifies multi-container configuration. Example:

```

services:
app:
image: myapp
environment:
PORT: 3000
NODE_ENV: production
database:
image: mysql
environment:
MYSQL_ROOT_PASSWORD: root123

```

Compose automatically injects these values when containers start.

### Variable Substitution

Compose also supports substitution. Example:

```

environment:
PORT: ${PORT}

```

If the system contains: `PORT=8080` Docker Compose automatically uses it.

### Using Multiple Configuration Files

Projects often maintain separate files. Example: Development: `.env.development` Testing: `.env.testing` Production: `.env.production` Each environment contains different values while using the same application code.

## Security, Best Practices, and Troubleshooting

### Avoid Hardcoding Secrets

One of the biggest mistakes developers make is storing sensitive data inside source code. Bad example: `password = "admin123"` Better: `DB_PASSWORD=password123` Even better for production: Use dedicated secret-management solutions instead of plain environment variables for highly sensitive information. Examples include:

- Docker Secrets

- Kubernetes Secrets

- Cloud Secret Managers

### Common Environment Variables

Frequently used variables include:

| Variable | Purpose |
|---|---|
| PORT | Server port |
| NODE_ENV | Runtime environment |
| DATABASE_URL | Database connection |
| API_KEY | API authentication |
| DEBUG | Enable debugging |
| LOG_LEVEL | Logging configuration |

### Best Practices

We should always follow these recommendations:

- Never hardcode credentials.

- Use `.env` files for local development.

- Keep production secrets separate.

- Give variables meaningful names.

- Document required environment variables.

- Validate variables when the application starts.

- Avoid exposing secrets in logs.

- Use runtime overrides when needed.

### Common Problems

### 1. Variable Not Found

Cause: `Variable not defined.` Solution: Check: `printenv`

### 2. Wrong Variable Name

Incorrect: `Database_URL` Correct: `DATABASE_URL` Variable names are case-sensitive on most systems.

### 3. Missing .env File

If Docker cannot find the `.env` file:

```

docker run --env-file .env myapp

```

Verify the file exists in the specified location.

### 4. Container Uses Old Values

Sometimes configuration changes are not reflected because the container was created earlier. Solution:

```

docker stop mycontainer
docker rm mycontainer
docker run ...

```

Restarting with the updated configuration ensures the new values are applied.

### Real-World Example

Imagine we build an e-commerce application with three environments: **Development**

```

NODE_ENV=development
PORT=3000
DATABASE_URL=localhost

```

**Testing**

```

NODE_ENV=testing
PORT=4000
DATABASE_URL=test-db

```

**Production**

```

NODE_ENV=production
PORT=80
DATABASE_URL=prod-db

```

Notice that the application code never changes. Only the environment variables differ. This approach makes deployment faster, reduces errors, and keeps the application portable across different systems.

### Conclusion

Environment variables are a cornerstone of modern containerized applications because they separate configuration from code. By using Docker\'s `-e` option, `ENV` instructions in Dockerfiles, `.env` files, and Docker Compose configuration, we can build applications that are flexible, portable, and easier to maintain. Following best practices—such as avoiding hardcoded secrets, validating required variables, and managing sensitive information securely—helps us create reliable and production-ready containerized systems. Mastering environment variables is an essential step toward effective Docker and cloud-native development.');

-- Lecture 7: Volumes & Persistent Data
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Volumes & Persistent Data', 7, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Volumes & Persistent Data

## Introduction to Volumes and Persistent Data

One of Docker\'s greatest strengths is the ability to create lightweight and temporary containers. However, this also introduces an important challenge: **what happens to the application\'s data when a container is removed?** By default, any data stored inside a container is lost when that container is deleted. This is where **Docker Volumes** become essential. A **Docker Volume** is a storage mechanism that allows data to persist independently of the container. Even if a container stops, crashes, or is removed, the data stored in a volume remains available and can be reused by new containers. Think of a Docker container as a **rented apartment**. If you move out, everything left inside the apartment is gone. A Docker volume, on the other hand, is like a **secure storage locker**. No matter how many apartments you move between, your belongings remain safely stored in the locker until you decide to remove them. Persistent storage is crucial for applications that manage important information such as databases, uploaded files, logs, configuration files, and user-generated content.

## Understanding Persistent Data

### What is Persistent Data?

Persistent data is information that remains available even after an application or container stops running. Examples include:

- Database records

- User accounts

- Uploaded images

- Configuration files

- Application logs

- Backup files

- Reports

- Documents

Unlike temporary data, persistent data survives restarts and container replacement.

### Why Do We Need Persistent Storage?

Containers are designed to be **ephemeral**, meaning they are easy to create, stop, remove, and recreate. Without persistent storage:

```

Run Container
↓
Create Files
↓
Stop Container
↓
Remove Container
↓
All Files Lost

```

With Docker Volumes:

```

Create Volume
↓
Run Container
↓
Store Data
↓
Remove Container
↓
Data Still Exists

```

This ensures valuable information is never lost when containers are replaced.

### Real-World Examples

Persistent storage is required for many applications:

- **MySQL** – Stores databases.

- **PostgreSQL** – Stores relational data.

- **MongoDB** – Stores documents.

- **WordPress** – Stores uploaded media.

- **Web Applications** – Save user uploads.

- **Logging Systems** – Store application logs.

Without volumes, these applications would lose their data whenever their containers were recreated.

## What are Docker Volumes?

### Definition

A **Docker Volume** is a Docker-managed storage location used to persist and share data between containers. Unlike files stored inside a container, volume data exists outside the container\'s writable layer. Docker manages the lifecycle of volumes independently from containers.

### Characteristics of Docker Volumes

Docker volumes have several advantages:

- Persistent storage

- Independent of containers

- Easy backup and restoration

- High performance

- Portable across containers

- Secure storage management

- Simple sharing between containers

Volumes are the recommended method for storing application data in Docker.

### How Docker Volumes Work

The relationship between containers and volumes can be represented as:

```

Docker Volume
↑
│
Container A
Container B
Container C

```

Multiple containers can access the same volume if appropriate, making data sharing straightforward.

## Types of Docker Storage

Docker provides several ways to store data.

### 1. Volumes

Volumes are managed by Docker. Characteristics:

- Best performance

- Easy management

- Persistent

- Recommended for production

Example:

```

docker volume create myvolume

```

### 2. Bind Mounts

Bind mounts map an existing folder from the host machine into a container. Example:

```

docker run -v /home/user/data:/app/data myapp

```

Advantages:

- Easy file editing from the host

- Useful during development

Disadvantages:

- Depends on the host directory structure

- Less portable

### 3. tmpfs Mounts

A **tmpfs** mount stores data only in the system\'s memory (RAM). Characteristics:

- Very fast

- Temporary

- Data disappears when the container stops

Useful for:

- Temporary files

- Sensitive information

- Caches

## Creating and Managing Docker Volumes

### Create a Volume

To create a new volume:

```

docker volume create myvolume

```

Docker creates the volume and stores it in its managed storage area.

### List Volumes

To view all available volumes: `docker volume ls` Example output:

```

DRIVER VOLUME NAME
local myvolume
local database-data

```

### Inspect a Volume

To view detailed information:

```

docker volume inspect myvolume

```

The output includes:

- Volume name

- Driver

- Mount point

- Labels

- Scope

### Remove a Volume

To delete a volume: `docker volume rm myvolume` A volume cannot normally be removed while it is being used by a container.

### Remove Unused Volumes

Clean up unused volumes with: `docker volume prune` This removes all unused volumes and helps free disk space.

## Using Volumes with Containers

### Mounting a Volume

To attach a volume to a container:

```

docker run -v myvolume:/app/data myapp

```

Explanation:

| Part | Description |
|---|---|
| myvolume | Docker volume |
| /app/data | Directory inside the container |

Data written to `/app/data` is stored in the Docker volume instead of the container itself.

### Named Volume Example

Create a volume:

```

docker volume create student-data

```

Run a container:

```

docker run -v student-data:/data myapp

```

Even if the container is deleted, the files inside `student-data` remain available.

### Sharing Volumes Between Containers

Multiple containers can access the same volume. Example:

```

student-data
↑
│
Web Container
Backup Container

```

This allows one container to generate data while another processes or backs it up.

## Bind Mounts

### What is a Bind Mount?

A bind mount links a directory from the host machine directly into the container. Example:

```

docker run -v C:\\Projects\\Website:/app website

```

On Linux:

```

docker run -v /home/user/project:/app website

```

Changes made in either location are immediately reflected in the other.

### Advantages of Bind Mounts

- Easy development workflow

- Real-time file updates

- No need to rebuild the image after every code change

- Useful with code editors

### Disadvantages of Bind Mounts

- Platform-dependent paths

- Reduced portability

- Host directory must exist

- Less isolated than Docker-managed volumes

## Anonymous Volumes

Docker can create unnamed (anonymous) volumes automatically. Example:

```

docker run -v /app/data myapp

```

Docker generates a random volume name. Anonymous volumes are useful for temporary storage but are harder to manage because they lack descriptive names.

## Volume Lifecycle

The lifecycle of a Docker volume differs from that of a container.

```

Create Volume
↓
Attach to Container
↓
Store Data
↓
Stop Container
↓
Remove Container
↓
Volume Still Exists
↓
Reuse with New Container

```

This independence makes volumes ideal for long-term data storage.

## Backing Up and Restoring Volumes

### Why Back Up Volumes?

Backing up volumes protects important application data against accidental deletion, hardware failures, or corruption. Typical backup targets include:

- Databases

- Uploaded files

- Configuration files

- User documents

### General Backup Process

```

Volume
↓
Backup File
↓
External Storage

```

Restoring follows the reverse process:

```

Backup File
↓
Volume
↓
Application

```

Regular backups are a critical part of production system maintenance.

## Best Practices for Docker Volumes

To manage persistent storage effectively:

- Use **named volumes** for production applications.

- Store databases in dedicated volumes.

- Back up important volumes regularly.

- Use bind mounts primarily during development.

- Avoid storing critical data inside containers.

- Remove unused volumes periodically with `docker volume prune`.

- Use meaningful volume names (e.g., `mysql-data`, `wordpress-files`).

- Limit access to sensitive data where appropriate.

- Monitor disk usage to prevent storage issues.

Following these practices improves reliability, security, and maintainability.

## Common Mistakes to Avoid

Avoid these common errors:

### 1. Storing Important Data Inside Containers

Container storage is temporary. Important files should always be stored in volumes.

### 2. Deleting Volumes Accidentally

Running: `docker volume prune` without checking can remove valuable unused volumes. Review volumes before deleting them.

### 3. Using Anonymous Volumes Unnecessarily

Named volumes are easier to identify and manage than automatically generated anonymous volumes.

### 4. Confusing Volumes with Bind Mounts

Remember:

- **Volumes** → Managed by Docker, ideal for persistent production data.

- **Bind Mounts** → Managed by the host operating system, commonly used during development.

### 5. Forgetting to Back Up Data

Persistent storage does not replace a backup strategy. Important data should always be backed up regularly.

## Real-World Example

Suppose we run a MySQL database. Create a volume:

```

docker volume create mysql-data

```

Run MySQL:

```

docker run -d --name mysql-db -v mysql-data:/var/lib/mysql mysql

```

Workflow:

```

Create Volume
↓
Start MySQL Container
↓
Database Stores Records
↓
Stop Container
↓
Remove Container
↓
Run New MySQL Container
↓
Reconnect Same Volume
↓
Database Records Still Available

```

This demonstrates how volumes preserve data independently of containers.

## Summary Table

| Storage Type | Managed By | Persistent | Best Use Case |
|---|---|---|---|
| Volume | Docker | Yes | Databases, application data, production workloads |
| Bind Mount | Host Operating System | Yes | Development, live code editing |
| tmpfs Mount | System Memory (RAM) | No | Temporary files, caches, sensitive data |

### Conclusion

Docker Volumes provide a reliable solution for persistent data storage by keeping application data separate from the container lifecycle. Unlike container storage, which is temporary, volumes ensure that important information such as databases, uploaded files, configuration settings, and logs remains available even after containers are stopped or removed. Docker also supports bind mounts and tmpfs mounts, each designed for different scenarios such as development or temporary in-memory storage. By understanding how to create, manage, mount, back up, and maintain volumes, and by following best practices such as using named volumes and regular backups, we can build containerized applications that are both reliable and suitable for production environments. Mastering Docker volumes is a crucial step toward advanced topics like Docker Compose, multi-container applications, and Kubernetes persistent storage.');

-- Lecture 8: Networking in Docker – Complete Lecture Notes
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Networking in Docker – Complete Lecture Notes', 8, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Networking in Docker

## Introduction to Docker Networking

Docker allows applications to run inside isolated containers, but most real-world applications do not work alone. A web server may need to communicate with a database, an API service may need to interact with a cache server, and multiple microservices often need to exchange data. **Docker Networking** provides the communication system that enables containers to connect with each other, with the host machine, and with external networks. Think of Docker containers as **houses in a city**. Each house has its own address and privacy, but roads connect the houses so people can communicate and travel between them. Docker networks work like those roads, allowing containers to exchange information securely and efficiently. Understanding Docker networking is essential for building scalable and distributed applications.

## What is Docker Networking?

### Definition

Docker Networking is the system that allows Docker containers to communicate with:

- Other containers

- The host machine

- External systems

- The internet

Docker automatically creates networking environments that isolate containers while still allowing controlled communication.

### Why Do We Need Docker Networking?

Without networking:

- Containers cannot communicate.

- Databases cannot serve web applications.

- APIs cannot exchange data.

- Multi-container applications cannot function.

With Docker networking:

- Containers communicate securely.

- Applications become modular.

- Services can be scaled independently.

- Resources remain isolated when necessary.

### How Docker Networking Works

A simplified workflow is:

```

Client
│
▼
Host Machine
│
▼
Docker Network
│
┌─┴───────────────┐
│ │
▼ ▼
Web Container Database Container

```

The Docker network routes communication between connected containers.

## Network Drivers in Docker

Docker provides different network drivers for different use cases.

### 1. Bridge Network

The **Bridge** network is the default network created by Docker. Characteristics:

- Default for standalone containers.

- Containers on the same bridge network can communicate.

- Provides network isolation.

- Suitable for development and small applications.

Example: `docker run nginx` If no network is specified, Docker connects the container to the default bridge network.

### 2. Host Network

In the **Host** network, the container shares the host machine\'s network stack. Characteristics:

- No network isolation.

- Faster communication.

- No port mapping required.

- Commonly used for high-performance applications.

Example:

```

docker run --network host nginx

```

The application becomes directly accessible through the host network.

### 3. None Network

The **None** network disables networking completely. Characteristics:

- No internet access.

- No communication with other containers.

- Maximum network isolation.

Example:

```

docker run --network none ubuntu

```

Useful for testing or running highly isolated workloads.

### 4. Overlay Network

Overlay networks connect containers running on different Docker hosts. Characteristics:

- Used in Docker Swarm.

- Supports distributed applications.

- Enables multi-host communication.

- Suitable for production clusters.

### 5. Macvlan Network

A Macvlan network assigns each container its own MAC address, making it appear as a physical device on the network. Advantages:

- Direct communication with the physical network.

- Better compatibility with legacy applications.

- Improved network visibility.

## Docker Bridge Network

### What is the Bridge Network?

The bridge network acts as a virtual switch connecting containers on the same Docker host.

```

Docker Host
│
┌───┴────────────┐
│ Bridge Network │
├───────────────┤
│ Container A │
│ Container B │
│ Container C │
└───────────────┘

```

Containers connected to the bridge network can communicate using their IP addresses or container names (on user-defined bridge networks).

### Viewing Available Networks

List Docker networks: `docker network ls` Example output:

```

NETWORK ID NAME DRIVER
abc123 bridge bridge
def456 host host
ghi789 none null

```

### Inspecting a Network

View detailed information:

```

docker network inspect bridge

```

The output includes:

- Network ID

- Driver

- Subnet

- Gateway

- Connected containers

## Creating Custom Networks

### Why Create Custom Networks?

Although Docker provides a default bridge network, creating custom networks offers several advantages:

- Better container organization.

- Automatic DNS-based name resolution.

- Improved isolation.

- Easier management of multi-container applications.

### Create a Network

```

docker network create app-network

```

Docker creates a new bridge network named **app-network**.

### Run a Container on a Specific Network

```

docker run -d --network app-network --name web nginx

```

Another container:

```

docker run -d --network app-network --name database mysql

```

Both containers can now communicate using their names:

```

web
database

```

This is easier than remembering IP addresses.

### Connect an Existing Container

Attach a running container to a network:

```

docker network connect app-network web

```

### Disconnect a Container

Remove a container from a network:

```

docker network disconnect app-network web

```

## Container Communication

### Communication by IP Address

Each container receives an internal IP address. Example:

```

Web Container
172.18.0.2
Database Container
172.18.0.3

```

Containers can communicate using these addresses. However, IP addresses may change when containers are recreated.

### Communication by Container Name

On user-defined bridge networks, Docker provides automatic DNS resolution. Example:

```

Web Container
│
▼
Database

```

Instead of: `172.18.0.3` the application simply connects to: `database` This makes applications more reliable and easier to configure.

## Port Mapping

### Why Port Mapping is Necessary

Containers are isolated from the host machine. Without port mapping:

```

Browser
│
▼
Host

```

✖ `Container` The application cannot be reached.

### Publishing Ports

Example: `docker run -p 8080:80 nginx` Explanation:

| Port | Description |
|---|---|
| 8080 | Host machine |
| 80 | Container |

The application becomes accessible at: `http://localhost:8080`

### Multiple Port Mapping

Example:

```

docker run -p 8080:80 -p 8443:443 nginx

```

The container exposes both HTTP and HTTPS services.

## Network Management Commands

### List Networks

`docker network ls`

### Inspect a Network

```

docker network inspect app-network

```

### Remove a Network

```

docker network rm app-network

```

Docker only removes networks that are not currently in use.

### Remove Unused Networks

`docker network prune` This deletes all unused Docker networks and helps free system resources.

## Networking in Multi-Container Applications

Suppose we have a simple web application.

```

Internet
│
Web Server
│
▼
API Server
│
▼
Database

```

Docker implementation:

```

app-network
├── nginx
├── backend
└── mysql

```

Each container communicates using container names:

- `nginx`

- `backend`

- `mysql`

This architecture is commonly used in modern web applications.

## Docker DNS

Docker includes an internal DNS service for user-defined networks. Instead of: `172.18.0.5` Applications use: `database` Advantages:

- Easier configuration.

- Automatic updates.

- No need to remember IP addresses.

- Better maintainability.

## Best Practices for Docker Networking

Follow these recommendations when designing Docker networks:

- Use custom bridge networks for multi-container applications.

- Communicate using container names instead of IP addresses.

- Publish only the ports that need external access.

- Keep databases on internal networks whenever possible.

- Remove unused networks regularly.

- Separate development, testing, and production networks.

- Limit unnecessary communication between unrelated containers.

- Use overlay networks for distributed Docker Swarm deployments.

- Regularly inspect networks to verify connectivity and security.

These practices improve scalability, organization, and security.

## Common Mistakes to Avoid

### 1. Relying on Container IP Addresses

Container IP addresses can change after recreation. Use container names instead.

### 2. Exposing Too Many Ports

Publishing unnecessary ports increases the attack surface. Only expose required services.

### 3. Using the Default Bridge for Everything

While convenient, the default bridge lacks automatic DNS resolution between unrelated containers. Custom bridge networks are often a better choice.

### 4. Forgetting Port Mapping

A web application may run correctly inside a container but remain inaccessible because no host port is mapped.

### 5. Leaving Unused Networks

Unused networks consume resources and can make the Docker environment harder to manage. Clean them periodically.

## Real-World Example

Suppose we build a blog application. **Create a network**

```

docker network create blog-network

```

**Run MySQL**

```

docker run -d \\
--name mysql-db \\
--network blog-network \\
mysql

```

**Run Backend**

```

docker run -d \\
--name backend \\
--network blog-network \\
my-backend

```

**Run Nginx**

```

docker run -d \\
--name nginx \\
--network blog-network \\
-p 8080:80 \\
nginx

```

Application architecture:

```

Internet
│
▼
Nginx
│
▼
Backend
│
▼
MySQL

```

Each service communicates through the shared Docker network, while only Nginx is exposed to external users.

## Summary Table

| Network Driver | Description | Common Use Case |
|---|---|---|
| Bridge | Default isolated network on a single Docker host | Standalone containers, development |
| Host | Shares the host machine\'s network | High-performance networking |
| None | No networking | Testing, maximum isolation |
| Overlay | Connects containers across multiple Docker hosts | Docker Swarm, distributed systems |
| Macvlan | Gives containers their own MAC addresses | Legacy applications, direct LAN access |

### Conclusion

Docker Networking is a fundamental feature that enables containers to communicate with one another, the host machine, and external systems while maintaining isolation and flexibility. Docker offers several networking options—including Bridge, Host, None, Overlay, and Macvlan—to support different application requirements, from simple standalone services to complex distributed systems. By creating custom networks, using container names for communication, publishing only necessary ports, and following networking best practices, we can build secure, scalable, and maintainable containerized applications. A solid understanding of Docker networking prepares us for advanced topics such as Docker Compose, service discovery, load balancing, container orchestration, and Kubernetes networking.');

-- Lecture 9: Docker Compose (Multi-Container Apps)
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Docker Compose (Multi-Container Apps)', 9, 'intermediate');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Docker Compose (Multi-Container Apps)

## Introduction to Docker Compose

As applications become more complex, they often require multiple containers working together instead of just one. For example, a web application may need a web server, a backend API, a database, and a cache. Running each container manually with long Docker commands can quickly become difficult and error-prone. **Docker Compose** solves this problem by allowing us to define and manage multi-container applications using a single configuration file. Think of Docker Compose as the **conductor of an orchestra**. Each musician (container) plays a different instrument, but the conductor ensures they start together, work in harmony, and produce a complete performance. Similarly, Docker Compose coordinates multiple containers so they function as a single application. Docker Compose simplifies development, testing, and deployment by automating the creation, networking, and management of related containers.

## What is Docker Compose?

### Definition

**Docker Compose** is a tool that allows us to define and manage multi-container Docker applications using a **YAML configuration file** named `docker-compose.yml` (or `compose.yaml` in newer versions). Instead of running multiple `docker run` commands, we define all services in one file and start them with a single command.

### Why Do We Need Docker Compose?

Without Docker Compose:

- Each container must be started manually.

- Networking must be configured separately.

- Volumes must be attached individually.

- Environment variables must be repeated.

- Managing multiple services becomes difficult.

With Docker Compose:

- One configuration file manages the entire application.

- Services start and stop together.

- Networks are created automatically.

- Volumes are managed consistently.

- Development becomes faster and more organized.

### Real-World Example

A blogging platform may require:

- Nginx (Web Server)

- Node.js (Backend API)

- MySQL (Database)

- Redis (Cache)

Instead of managing four separate containers manually, Docker Compose starts and manages them all together.

## Docker Compose Architecture

A typical multi-container application looks like this:

```

User
│
▼
Web Browser
│
▼
Nginx Server
│
▼
Backend API
│
┌─────────┴─────────┐
▼ ▼
MySQL Database Redis Cache

```

Each service runs in its own container but communicates through a shared Docker network created automatically by Docker Compose.

## Installing Docker Compose

Modern versions of Docker Desktop include Docker Compose by default. To verify installation: `docker compose version` Example output:

```

Docker Compose version v2.x.x

```

If Docker Compose is available, you are ready to create multi-container applications.

## Understanding the Compose File

Docker Compose uses a YAML file. File name: `docker-compose.yml` or `compose.yaml` This file defines:

- Services

- Images

- Build instructions

- Ports

- Volumes

- Networks

- Environment variables

- Dependencies

Everything needed to run the application is stored in one place.

## Basic Docker Compose File

Example:

```

services:
web:
image: nginx
ports:
- "8080:80"
database:
image: mysql

```

This configuration creates two services:

- Web server

- Database server

Docker Compose automatically creates a network so both services can communicate.

### Compose File Structure

A typical Compose file contains:

```

Services
│
├── Image
├── Build
├── Ports
├── Volumes
├── Environment
└── Networks

```

Each service represents one container.

## Understanding Compose Keywords

### 1. services

The `services` section defines the application\'s containers. Example:

```

services:
web:
database:

```

Each service has its own configuration.

### 2. image

Specifies which Docker image to use. Example: `image: nginx` or `image: mysql:8.0` Docker downloads the image automatically if it is not available locally.

### 3. build

Instead of downloading an image, Compose can build one from a Dockerfile. Example: `build: .` Docker builds the image from the current directory before starting the container.

### 4. ports

Maps host ports to container ports. Example:

```

ports:
- "3000:3000"

```

Syntax: `host_port:container_port`

### 5. volumes

Attach persistent storage. Example:

```

volumes:
- database-data:/var/lib/mysql

```

This ensures database files remain available even if the container is removed.

### 6. environment

Sets environment variables. Example:

```

environment:
MYSQL_ROOT_PASSWORD: password

```

These variables configure the application without modifying its code.

### 7. depends_on

Specifies service dependencies. Example:

```

depends_on:
- database

```

Docker Compose starts the database container before the web container. **Note:** `depends_on` controls startup order but does not guarantee that the dependent service is fully ready to accept connections.

## Running Docker Compose

### Start All Services

`docker compose up` Docker Compose:

- Creates networks.

- Creates volumes.

- Builds images if necessary.

- Starts all containers.

### Run in Background

`docker compose up -d` The `-d` option runs all containers in detached mode.

### Stop Services

`docker compose stop` Containers stop but remain available.

### Restart Services

`docker compose restart` Restarts all services.

### Remove Everything

`docker compose down` Removes:

- Containers

- Networks

Volumes remain unless explicitly removed.

### Remove Including Volumes

`docker compose down -v` This also removes associated volumes.

## Example Multi-Container Application

Project structure:

```

student-app/
│
├── Dockerfile
├── docker-compose.yml
├── app.py
└── requirements.txt

```

Compose file:

```

services:
web:
build: .
ports:
- "5000:5000"
database:
image: mysql:8.0
environment:
MYSQL_ROOT_PASSWORD: password

```

Workflow:

```

Compose File
↓
docker compose up
↓
Build Image
↓
Create Network
↓
Start Database
↓
Start Web Application

```

The application is fully operational with a single command.

## Networking in Docker Compose

Docker Compose automatically creates a dedicated network. Example:

```

Compose Network
├── web
├── database
└── redis

```

Containers communicate using service names: Instead of: `172.18.0.2` Applications connect using: `database` This built-in DNS simplifies application configuration.

## Volumes in Docker Compose

Persistent storage is easily defined. Example:

```

services:
database:
image: mysql
volumes:
- db-data:/var/lib/mysql
volumes:
db-data:

```

Benefits:

- Data survives container removal.

- Easy backups.

- Reusable across container recreations.

## Viewing Logs

Display logs: `docker compose logs` Follow logs continuously: `docker compose logs -f` Logs from all services appear together, making debugging easier.

## Scaling Services

Docker Compose can run multiple instances of a service. Example:

```

docker compose up --scale web=3

```

Result:

```

Web 1
Web 2
Web 3
Database

```

This is useful for load testing and horizontal scaling during development.

## Common Docker Compose Commands

| Command | Purpose |
|---|---|
| docker compose up | Start all services |
| docker compose up -d | Start services in detached mode |
| docker compose down | Stop and remove containers and networks |
| docker compose down - v | Remove containers, networks, and volumes |
| docker compose stop | Stop services |
| docker compose start | Start stopped services |
| docker compose restart | Restart services |
| docker compose ps | List running services |
| docker compose logs | View service logs |
| docker compose logs - f | Follow logs in real time |
| docker compose build | Build service images |
| docker compose pull | Download service images |
| docker compose exec | Run a command inside a running service container |

## Best Practices

Follow these best practices when using Docker Compose:

- Keep the Compose file simple and organized.

- Use meaningful service names such as `web`, `api`, and `database`.

- Store secrets securely instead of hardcoding them in the Compose file.

- Use named volumes for persistent data.

- Specify image versions instead of relying on `latest`.

- Use environment variables for configuration.

- Separate development and production configurations when necessary.

- Regularly remove unused containers, networks, and volumes.

- Use `depends_on` to define startup order where appropriate.

## Common Mistakes to Avoid

### 1. Forgetting to Expose Ports

Without port mapping, services cannot be accessed from the host machine.

### 2. Hardcoding Secrets

Avoid storing passwords and API keys directly in the Compose file. Use environment files (`.env`) or secret management tools when possible. **3. Assuming** `depends_on` **Waits for Readiness** `depends_on` only controls startup order. Applications should still handle retries or health checks to ensure dependent services are ready. **4. Using** `latest` **Everywhere** Using version-specific image tags produces more consistent and predictable deployments.

### 5. Not Using Volumes

## Real-World Example

Suppose we are building an online shopping platform. Services:

- Nginx

- Backend API

- MySQL

- Redis

Architecture:

```

Customer
│
▼
Nginx
│
▼
Backend API
┌───┴─────────┐
▼ ▼
MySQL Redis

```

With Docker Compose:

- One YAML file defines all services.

- One command starts the complete application.

- Networking and storage are configured automatically.

This approach simplifies both development and deployment.

## Summary Table

| Feature | Purpose |
|---|---|
| Services | Define application containers |
| Image | Specify the Docker image |
| Build | Build an image from a Dockerfile |
| Ports | Publish container ports |
| Volumes | Provide persistent storage |
| Environment | Configure applications using environment variables |
| Networks | Enable communication between services |
| depends_on | Control service startup order |

### Conclusion

Docker Compose is a powerful tool that simplifies the development and management of multi-container applications by allowing all services to be defined in a single YAML configuration file. It automatically handles networking, volumes, environment variables, and service orchestration, enabling developers to start, stop, and manage complete application stacks with just a few commands. By using Docker Compose, we reduce manual configuration, improve consistency across development environments, and make applications easier to maintain and deploy. Mastering Docker Compose provides a strong foundation for modern containerized development and prepares us for advanced technologies such as Docker Swarm, Kubernetes, and cloud-native application deployment.');

-- Lecture 10: Docker Hub & Image Registries
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Docker Hub & Image Registries', 10, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Docker Hub & Image Registries

## Introduction to Docker Hub and Image Registries

Imagine building a Docker image for your application on your computer. How can your teammates, clients, or production servers use the same image without rebuilding it? The answer is **Docker Image Registries**. A **Docker Image Registry** is a storage service where Docker images are stored, managed, versioned, and shared. The most popular public registry is **Docker Hub**, but there are also private registries for organizations and cloud platforms. Think of a Docker registry as a **digital library**. Instead of borrowing books, developers download Docker images. Likewise, developers can upload their own images so others can use them. Docker Hub and image registries make collaboration, deployment, and software distribution much easier by providing a centralized place to store container images.

## What is Docker Hub?

### Definition

**Docker Hub** is the official cloud-based registry provided by Docker. It hosts millions of Docker images that developers can download and use. Docker Hub allows users to:

- Store Docker images

- Share images with others

- Download official images

- Upload custom images

- Manage image versions

- Collaborate with teams

Many popular software packages, such as **Nginx**, **MySQL**, **Redis**, **Ubuntu**, **Python**, and **Node.js**, are available as official Docker Hub images.

### Why Use Docker Hub?

Docker Hub offers many advantages:

- Centralized image storage

- Easy image sharing

- Automatic image versioning

- Fast deployment

- Public and private repositories

- Integration with CI/CD pipelines

- Official verified images

- Global accessibility

Instead of sending large image files manually, developers simply upload them once and allow others to download them when needed.

### How Docker Hub Works

The workflow is straightforward:

```

Developer
│
▼
Build Docker Image
│
▼
Push Image
│
▼
Docker Hub
│
▼
Other Developers
│
▼
Pull Image
│
▼
Run Container

```

This enables consistent application deployment across different environments.

## Understanding Docker Image Registries

### What is an Image Registry?

A **Docker Image Registry** is a repository that stores Docker images. A registry allows users to:

- Upload images

- Download images

- Organize repositories

- Manage versions

- Control access permissions

Registries can be either public or private.

### Public vs Private Registries

### Public Registry

Characteristics:

- Accessible by anyone

- Ideal for open-source projects

- Easy sharing

- Large collection of official images

Example:

- Docker Hub

### Private Registry

Characteristics:

- Restricted access

- Used by organizations

- Better security

- Protects proprietary applications

Examples include:

- GitHub Container Registry

- Amazon Elastic Container Registry (ECR)

- Google Artifact Registry

- Azure Container Registry

- Self-hosted Docker Registry

### Popular Docker Image Registries

| Registry | Description |
|---|---|
| Docker Hub | Official public Docker registry |
| GitHub Container Registry | Stores container images within GitHub |
| Amazon ECR | Container registry for AWS |
| Google Artifact Registry | Container registry for Google Cloud |
| Azure Container Registry | Microsoft Azure container registry |
| Self-Hosted Registry | Organization-managed private registry |

Each registry supports image storage, versioning, and secure distribution.

## Docker Image Repositories

### What is a Repository?

A repository is a collection of related Docker images. Example:

```

student-app
├── v1.0
├── v1.1
├── v2.0
└── latest

```

Each version is identified using a **tag**. Repositories help organize multiple versions of the same application.

### Official Images

Docker Hub provides **Official Images** maintained by Docker or trusted software vendors. Examples:

- nginx

- ubuntu

- mysql

- redis

- python

- node

- postgres

Benefits:

- Regular security updates

- Trusted maintainers

- High-quality documentation

- Production-ready

Whenever possible, official images should be preferred.

## Docker Image Tags

### What is a Tag?

A **tag** identifies a specific version of an image. Example: `python:3.12` Here:

- `python` → Repository

- `3.12` → Tag

### Common Tags

Examples:

```

latest
v1.0
v2.1
18-alpine
20-bookworm

```

Tags make version management easier.

### Why Tags are Important

Benefits:

- Version control

- Easy rollback

- Stable deployments

- Clear release history

Instead of: `node:latest` prefer: `node:20` Specific versions reduce unexpected changes.

## Logging In to Docker Hub

Before pushing private images, authentication is required.

### Login

`docker login` Docker prompts for:

- Username

- Password or access token

Successful login: `Login Succeeded`

### Logout

`docker logout` This ends the current Docker Hub session.

## Pulling Images from Docker Hub

### Download an Image

`docker pull nginx` Docker performs:

```

Search Image
↓
Download Layers
↓
Store Image Locally

```

### Download a Specific Version

`docker pull python:3.12` Only the requested version is downloaded.

### Verify Download

`docker images` Example output:

```

REPOSITORY TAG
python 3.12
nginx latest

```

## Building and Tagging Images

Suppose we build our own application.

### Build

```

docker build -t student-app .

```

This creates: `student-app:latest`

### Tag an Existing Image

Syntax: `docker tag source target` Example:

```

docker tag student-app username/student-app:v1

```

Now the image is ready to upload to Docker Hub.

## Pushing Images to Docker Hub

### Upload an Image

```

docker push username/student-app:v1

```

Docker:

- Uploads image layers.

- Skips layers already stored.

- Creates the repository if necessary.

Workflow:

```

Local Image
│
▼
docker push
│
▼
Docker Hub Repository

```

After uploading, the image becomes available according to the repository\'s visibility settings.

## Pulling Custom Images

Another developer can download the same image:

```

docker pull username/student-app:v1

```

Then run it:

```

docker run username/student-app:v1

```

This ensures everyone uses the same application version.

## Image Versioning Strategy

Good version management improves reliability. Example:

```

student-app
├── v1.0
├── v1.1
├── v1.2
├── v2.0
└── latest

```

Advantages:

- Easy upgrades

- Rollback support

- Clear release tracking

- Stable deployments

### Semantic Versioning

Many projects follow **Semantic Versioning (SemVer)**. Format: `MAJOR.MINOR.PATCH` Example: `2.5.1` Meaning:

| Part | Description |
|---|---|
| Major | Breaking changes |
| Minor | New features |
| Patch | Bug fixes |

## Docker Registry Workflow

A typical workflow is:

```

Write Dockerfile
↓
Build Image
↓
Test Image
↓
Tag Image
↓
Login to Registry
↓
Push Image
↓
Pull on Another Machine
↓
Run Container

```

This workflow is widely used in professional software development.

## Security Best Practices

When working with Docker registries:

- Use official images whenever possible.

- Scan images for known vulnerabilities.

- Avoid storing passwords inside images.

- Keep images updated.

- Remove unused tags.

- Use private repositories for confidential applications.

- Enable multi-factor authentication (MFA) on registry accounts.

- Limit repository access using appropriate permissions.

Security should always be part of the image management process.

## Common Docker Registry Commands

| Command | Purpose |
|---|---|
| docker login | Log in to a registry |
| docker logout | Log out of a registry |
| docker pull image | Download an image |
| docker push image | Upload an image |
| docker tag source target | Create a new image tag |
| docker images | List local images |
| docker search keyword | Search Docker Hub for public images |

## Best Practices

Follow these recommendations when using Docker Hub and image registries:

- Use meaningful repository names.

- Tag images with version numbers instead of relying on `latest`.

- Use official base images whenever possible.

- Regularly update images to include security patches.

- Remove outdated or unused image tags.

- Store sensitive applications in private registries.

- Document image usage and version history.

- Test images before pushing them to a registry.

- Keep repositories organized with consistent naming conventions.

## Common Mistakes to Avoid

**1. Using Only the** `latest` **Tag** The `latest` tag can change over time and lead to inconsistent deployments. Prefer version-specific tags.

### 2. Forgetting to Tag Before Pushing

Docker Hub requires images to be tagged with the correct repository name before they can be pushed.

### 3. Uploading Sensitive Information

Never include:

- Passwords

- API keys

- Private certificates

inside Docker images.

### 4. Ignoring Image Updates

Outdated images may contain security vulnerabilities. Update and rebuild images regularly.

### 5. Using Untrusted Images

Always verify the source of an image before using it, especially in production environments.

## Real-World Example

Suppose a development team builds a student management application. **Step 1: Build the image**

```

docker build -t student-app .

```

**Step 2: Tag the image**

```

docker tag student-app username/student-app:v1.0

```

**Step 3: Log in** `docker login` **Step 4: Push the image**

```

docker push username/student-app:v1.0

```

**Step 5: Another developer downloads it**

```

docker pull username/student-app:v1.0

```

**Step 6: Run the application**

```

docker run -p 5000:5000 username/student-app:v1.0

```

Every developer now runs the exact same application version, reducing compatibility issues and simplifying collaboration.

## Summary Table

| Concept | Description |
|---|---|
| Docker Hub | Official public Docker image registry |
| Image Registry | Service that stores and distributes Docker images |
| Repository | Collection of related Docker images |
| Tag | Identifies a specific image version |
| Push | Upload an image to a registry |
| Pull | Download an image from a registry |
| Official Image | Trusted image maintained by Docker or software vendors |
| Private Registry | Registry with restricted access for organizations |

### Conclusion

Docker Hub and Docker image registries play a vital role in modern containerized application development by providing a centralized platform for storing, sharing, and distributing Docker images. Registries enable developers to collaborate efficiently, maintain consistent application versions, and simplify deployments across development, testing, and production environments. By understanding repositories, image tags, versioning strategies, authentication, and the processes of pushing and pulling images, we can build reliable and repeatable deployment workflows. Following best practices—such as using official images, applying semantic versioning, securing repositories, and keeping images updated—ensures that containerized applications remain organized, secure, and easy to maintain. Mastering Docker Hub and image registries is an important step toward advanced DevOps practices, CI/CD pipelines, and cloud-native application deployment.');

-- Lecture 11: Multi-Stage Builds
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Multi-Stage Builds', 11, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Multi-Stage Builds

Multi-stage builds are one of Docker\'s most powerful features for creating **smaller, faster, and more secure container images**. Instead of using a single Docker image for both building and running an application, we split the process into multiple stages. Each stage has its own purpose, such as compiling source code, installing dependencies, or preparing the final application. Imagine building a house. During construction, we use scaffolding, heavy machinery, and various tools. Once the house is complete, we remove all the construction equipment before people move in. Multi-stage builds work the same way—we keep only what the application needs to run and discard everything else.

## Understanding Multi-Stage Builds

### What Is a Multi-Stage Build?

A multi-stage build is a Docker build process where multiple `FROM` instructions are used within a single Dockerfile. Each `FROM` starts a new stage with its own environment. The final image copies only the required files from earlier stages, leaving behind build tools and unnecessary files. Basic structure:

```

Build Stage
FROM node:20 AS builder
Runtime Stage
FROM nginx:latest

```

Here:

- The **builder stage** compiles the application.

- The **runtime stage** serves the compiled application.

- Only the final output is included in the production image.

### Why Use Multi-Stage Builds?

Without multi-stage builds, a Docker image often contains:

- Source code

- Development dependencies

- Build tools

- Compilers

- Temporary files

These increase the image size and security risks. With multi-stage builds:

- Smaller images

- Faster downloads

- Reduced attack surface

- Better performance

- Easier maintenance

### How Multi-Stage Builds Work

The build process generally follows these steps: 1. Create the build environment. 2. Install dependencies. 3. Compile or build the application. 4. Copy only the compiled output to a clean runtime image. 5. Discard everything else. This ensures the production image contains only what is necessary.

## Creating a Multi-Stage Dockerfile

### Example: Node.js Application

A typical Node.js multi-stage Dockerfile looks like this:

```

Stage 1 - Build
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
Stage 2 - Production
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package*.json ./
RUN npm install --omit=dev
CMD ["node", "dist/server.js"]

```

### Explanation

**Stage 1**

- Uses the full Node.js image.

- Installs development dependencies.

- Builds the application.

**Stage 2**

- Uses a lightweight Alpine image.

- Copies only the compiled application.

- Installs production dependencies only.

- Runs the application.

### Naming Build Stages

Stages can be named using the `AS` keyword. Example: `FROM golang:1.22 AS builder` Later, files are copied with:

```

COPY --from=builder /app/main .

```

Naming stages improves readability, especially in complex Dockerfiles.

### Copying Files Between Stages

Docker provides the `COPY --from` instruction. Syntax:

```

COPY --from=<stage-name> <source> <destination>

```

Example:

```

COPY --from=builder /app/build ./build

```

Only the required files are transferred.

## Practical Examples

### Example: React Application

```

Build Stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
Runtime Stage
FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html

```

The Node.js image is used only to build the React application. The final image contains:

- Nginx

- Static HTML

- CSS

- JavaScript

Node.js is completely excluded.

### Example: Go Application

```

FROM golang:1.22 AS builder
WORKDIR /src
COPY . .
RUN go build -o app
FROM alpine
COPY --from=builder /src/app .
CMD ["./app"]

```

Since Go compiles into a single binary, the final image becomes extremely small.

### Example: Java Application

```

FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /project
COPY . .
RUN mvn clean package
FROM eclipse-temurin:21-jre
COPY --from=builder /project/target/app.jar app.jar
CMD ["java","-jar","app.jar"]

```

Maven is needed only for building. The runtime image contains:

- Java Runtime

- Application JAR

## Benefits of Multi-Stage Builds

### Smaller Image Size

A traditional Docker image might be: `1.2 GB` Using multi-stage builds: `180 MB` Smaller images mean:

- Faster downloads

- Faster deployments

- Lower storage costs

### Improved Security

Development tools often include:

- Compilers

- Debugging utilities

- Package managers

Removing these reduces the number of components an attacker could potentially exploit.

### Faster Deployments

Smaller images:

- Upload faster

- Download faster

- Start containers more quickly

- Improve CI/CD pipeline performance

This is especially valuable in cloud environments.

### Cleaner Dockerfiles

Instead of maintaining separate Dockerfiles for development and production, we can keep everything in one organized file with clearly defined stages.

## Best Practices and Common Mistakes

### Best Practices

We should follow these recommendations:

- Use lightweight runtime images such as Alpine when appropriate.

- Name build stages using the `AS` keyword.

- Copy only the required files into the final image.

- Install production dependencies only in the runtime stage.

- Remove unnecessary temporary files.

- Keep build and runtime environments separate.

- Test the final image before deployment.

### Common Mistakes

### 1. Copying the Entire Project

Incorrect: `COPY --from=builder /app .` This may copy unnecessary files. Better:

```

COPY --from=builder /app/dist ./dist

```

Copy only what the application needs.

### 2. Using Large Runtime Images

Avoid using heavy images if they are unnecessary. Instead of: `FROM ubuntu` Prefer: `FROM alpine` or another lightweight runtime image compatible with your application.

### 3. Installing Development Dependencies in Production

Incorrect: `RUN npm install` Better: `RUN npm install --omit=dev` This keeps the production image smaller and more secure.

### 4. Forgetting to Name Stages

Unnamed stages can make Dockerfiles difficult to understand. Preferred: `FROM node:20 AS builder` instead of relying on stage numbers.

### Comparing Single-Stage and Multi-Stage Builds

| Feature | Single-Stage Build | Multi-Stage Build |
|---|---|---|
| Image Size | Large | Small |
| Build Tools Included | Yes | No |
| Production Ready | Less Efficient | Yes |
| Security | Lower | Higher |
| Deployment Speed | Slower | Faster |
| Maintenance | Moderate | Easier |

### Real-World Example

Suppose we build an online shopping application using React and Node.js. **Build Stage**

- Install Node.js dependencies.

- Compile React source code.

- Generate optimized production files.

**Runtime Stage**

- Use Nginx to serve the compiled website.

- Copy only the production build.

- Exclude source code, development packages, and build tools.

The result is a lightweight production image that starts quickly, consumes fewer resources, and is easier to deploy to cloud platforms or Kubernetes clusters.

### Conclusion

Multi-stage builds are a best practice for modern Docker development because they separate the build process from the runtime environment. By using multiple `FROM` instructions and copying only the necessary artifacts into the final image, we create containers that are smaller, faster, more secure, and easier to maintain. Whether we are developing Node.js, React, Go, Java, or other applications, multi-stage builds help streamline deployments, improve CI/CD pipelines, and produce production-ready container images that follow industry standards.');

-- Lecture 12: Debugging & Logs
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Debugging & Logs', 12, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Debugging & Logs

Debugging and logging are essential skills for anyone working with Docker containers. Even well-designed applications can encounter issues such as startup failures, configuration errors, network problems, or unexpected crashes. Docker provides powerful tools that help us inspect containers, view logs, monitor processes, and identify the root cause of problems. Think of debugging as being a detective investigating a mystery. Logs are the clues, Docker commands are the investigation tools, and our goal is to discover why an application is not behaving as expected. By mastering Docker\'s debugging and logging features, we can solve problems faster and maintain reliable applications.

## Understanding Debugging and Logs

### What Is Debugging?

Debugging is the process of identifying, analyzing, and fixing errors in an application or container. Common debugging tasks include:

- Finding startup errors

- Diagnosing network issues

- Checking missing files

- Verifying environment variables

- Monitoring resource usage

- Inspecting running processes

The goal is to restore the application to a healthy working state.

### What Are Logs?

Logs are records generated by applications and services while they run. A log may include:

- Startup messages

- Error reports

- Warning messages

- User requests

- Database connections

- System events

Example log:

```

Server started on port 3000
Connected to database
User login successful
Error: Database connection lost

```

Logs provide valuable information about what happens inside a container.

### Why Are Logs Important?

Logs help us:

- Identify application failures

- Monitor system behavior

- Detect security issues

- Troubleshoot production problems

- Analyze application performance

- Understand user activity

Without logs, finding the source of a problem becomes much more difficult.

## Viewing Docker Logs

### Using the Command

`docker logs` The most common command for viewing container logs is: `docker logs <container_name>` Example: `docker logs web-app` Docker displays all log messages generated by the application.

### Viewing Logs in Real Time

To continuously monitor logs: `docker logs -f web-app` The `-f` option means **follow**. Example output:

```

Server started
Database connected
User login
New order received

```

New log entries appear immediately as they are generated.

### Viewing Recent Logs

To display only the last few lines:

```

docker logs --tail 20 web-app

```

This shows the most recent 20 log entries.

### Viewing Logs with Timestamps

Add timestamps using: `docker logs -t web-app` Example:

```

2026-08-07T10:30:15 Server started
2026-08-07T10:30:20 Connected to database

```

Timestamps help determine exactly when events occurred.

## Debugging Running Containers

### Listing Running Containers

Before debugging, check which containers are running: `docker ps` Example output:

```

CONTAINER ID IMAGE STATUS
7ab12345 nginx Up 5 minutes

```

To include stopped containers: `docker ps -a`

### Inspecting a Container

Docker provides detailed information through: `docker inspect web-app` The output includes:

- Container ID

- Image name

- IP address

- Mounted volumes

- Environment variables

- Network configuration

- Port mappings

This information helps identify configuration issues.

### Executing Commands Inside a Container

Open a shell inside a running container: `docker exec -it web-app bash` If Bash is unavailable: `docker exec -it web-app sh` Once inside, we can:

- Check files

- Run commands

- Verify application settings

- Test connectivity

### Checking Running Processes

Inside the container: `ps aux` or `top` These commands display active processes and resource usage.

## Common Debugging Techniques

### Checking Container Status

Determine whether a container is running: `docker ps` If the container has stopped: `docker ps -a` Look at the **STATUS** column for clues such as:

- Exited

- Restarting

- Created

### Checking Exit Codes

Inspect the container: `docker inspect web-app` Look for: `ExitCode` Common exit codes:

| Exit Code | Meaning |
|---|---|
| 0 | Successful execution |
| 1 | General application error |
| 125 | Docker execution error |
| 126 | Command cannot execute |
| 127 | Command not found |
| 137 | Process killed (often due to memory limits) |

Exit codes provide valuable hints about failures.

### Verifying Environment Variables

Inside the container: `printenv` Example:

```

NODE_ENV=production
PORT=3000
DATABASE_URL=mysql

```

Incorrect or missing environment variables are a common cause of startup failures.

### Checking Network Connectivity

Test communication with another service: `ping database` or `curl http://database:3306` These commands help identify networking problems between containers.

## Best Practices for Debugging and Logging

### Write Meaningful Log Messages

Good log message:

```

Database connection established successfully.

```

Poor log message: `Something went wrong.` Detailed logs make troubleshooting much easier.

### Use Log Levels

Applications should categorize log messages by importance. Common log levels:

| Level | Purpose |
|---|---|
| DEBUG | Detailed debugging information |
| INFO | Normal application events |
| WARNING | Potential issues |
| ERROR | Recoverable failures |
| CRITICAL | Serious system failures |

Using log levels helps filter information efficiently.

### Avoid Logging Sensitive Information

Never log:

- Passwords

- API keys

- Authentication tokens

- Credit card numbers

- Personal information

Incorrect: `Password = admin123` Correct:

```

User authentication successful.

```

Protecting sensitive data is essential for security and compliance.

### Monitor Resource Usage

Docker provides resource statistics: `docker stats` Example output:

```

CONTAINER CPU% MEM USAGE
web-app 12% 145MB
database 35% 600MB

```

This helps identify performance bottlenecks.

### Restart a Problematic Container

If troubleshooting requires a restart: `docker restart web-app` After restarting, check: `docker logs web-app` to confirm the application starts successfully.

## Common Debugging Scenarios

### Scenario 1: Container Stops Immediately

Possible causes:

- Application crash

- Missing command

- Invalid configuration

- Missing dependencies

Solution: `docker logs web-app` Review the error messages and correct the issue.

### Scenario 2: Application Is Not Accessible

Check:

- Port mappings

- Firewall rules

- Network configuration

- Container status

Useful commands:

```

docker ps
docker inspect web-app

```

Verify that the required ports are exposed and mapped correctly.

### Scenario 3: Database Connection Failure

Possible causes:

- Incorrect database hostname

- Wrong credentials

- Database container not running

- Network issues

Verify: `printenv` Check: `docker logs database` Ensure both containers are connected to the same Docker network.

### Scenario 4: High CPU or Memory Usage

Monitor resources: `docker stats` Investigate:

- Infinite loops

- Memory leaks

- Excessive requests

- Heavy background tasks

Optimizing the application can improve stability and performance.

### Scenario 5: Missing Files

Enter the container: `docker exec -it web-app sh` Check the filesystem: Confirm that all required files were copied during the image build process.

## Essential Docker Debugging Commands

| Command | Purpose |
|---|---|
| docker ps | List running containers |
| docker ps -a | List all containers |
| docker logs container | View container logs |
| docker logs -f container | Follow logs in real time |
| docker logs --tail 20 container | Show recent log entries |
| docker inspect container | Display detailed container information |
| docker exec -it container bash | Open a shell inside a container |
| docker stats | Monitor CPU and memory usage |
| docker restart container | Restart a container |
| printenv | Display environment variables |
| ps aux | Show running processes inside a container |

### Conclusion

Debugging and logging are fundamental skills for managing Docker containers effectively. Docker provides a rich set of tools, including `docker logs`, `docker inspect`, `docker exec`, and `docker stats`, that help us identify and resolve issues quickly. By writing meaningful log messages, using appropriate log levels, protecting sensitive information, and following systematic debugging practices, we can build applications that are easier to maintain, troubleshoot, and monitor. Mastering these techniques ensures faster problem resolution, improved reliability, and smoother deployments in both development and production environments.');

-- Lecture 13: Dockerizing a Full-Stack Application
INSERT INTO lectures (language_id, title, order_number, difficulty_level)
VALUES (@lang_id, 'Dockerizing a Full-Stack Application', 13, 'advanced');
SET @lec_id = LAST_INSERT_ID();
INSERT INTO lecture_content (lecture_id, content) VALUES (@lec_id, '# Dockerizing a Full-Stack Application

## Introduction to Dockerizing a Full-Stack Application

Modern web applications rarely consist of a single program. Instead, they are built using multiple components working together, such as a frontend for the user interface, a backend for business logic, and a database for storing information. Managing all these components separately can become complicated, especially when deploying the application on different machines. **Dockerizing a Full-Stack Application** solves this challenge by packaging each component into its own container while allowing them to communicate seamlessly. Think of a full-stack application as a **restaurant**. The dining area (frontend) interacts with customers, the kitchen (backend) prepares meals, and the pantry (database) stores ingredients. Each area has a different role, but together they deliver a complete service. Docker acts like the building that keeps every section organized and ensures they work together efficiently. By containerizing every part of the application, we create a consistent, portable, and scalable development environment.

## What is a Full-Stack Application?

### Definition

A **Full-Stack Application** consists of multiple layers that work together to deliver complete functionality to users. The common components are:

- Frontend (User Interface)

- Backend (Application Logic)

- Database (Data Storage)

- Optional Cache (Redis)

- Optional Reverse Proxy (Nginx)

### Typical Architecture

A simple architecture looks like this:

```

User
│
▼
Frontend (React)
│
▼
Backend API (Node.js)
│
▼
Database (MySQL/PostgreSQL)

```

Each layer performs a specific task while communicating with the others.

### Why Dockerize a Full-Stack Application?

Without Docker:

- Different machines require different software installations.

- Dependency conflicts occur.

- Development environments vary.

- Deployment becomes more complicated.

With Docker:

- Applications run consistently everywhere.

- Dependencies are isolated.

- Setup is faster.

- Deployment is simplified.

- Scaling individual services becomes easier.

## Components of a Dockerized Full-Stack Application

### 1. Frontend Container

The frontend provides the graphical interface users interact with. Examples:

- React

- Angular

- Vue.js

Responsibilities:

- Display web pages

- Handle user interactions

- Send API requests

### 2. Backend Container

The backend processes requests and communicates with the database. Examples:

- Node.js

- Express.js

- Django

- Flask

- Spring Boot

Responsibilities:

- Authentication

- Business logic

- API responses

- Data validation

### 3. Database Container

The database stores application data. Examples:

- MySQL

- PostgreSQL

- MongoDB

Responsibilities:

- Store records

- Retrieve information

- Manage relationships

- Ensure data persistence

### 4. Reverse Proxy (Optional)

A reverse proxy such as Nginx manages incoming traffic. Responsibilities:

- Route requests

- Serve static files

- SSL termination

- Load balancing

## Project Structure

A typical project organization:

```

fullstack-app/
│
├── frontend/
│ ├── Dockerfile
│ ├── package.json
│ └── src/
│
├── backend/
│ ├── Dockerfile
│ ├── package.json
│ └── server.js
│
├── docker-compose.yml
│
└── README.md

```

Keeping frontend and backend in separate folders improves organization and maintainability.

## Dockerizing the Frontend

### Frontend Dockerfile

Example:

```

FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]

```

**Explanation**

| Instruction | Purpose |
|---|---|
| FROM | Base image |
| WORKDIR | Working directory |
| COPY | Copy project files |
| RUN | Install dependencies |
| EXPOSE | Open application port |
| CMD | Start the application |

### Build Frontend Image

```

docker build -t frontend ./frontend

```

## Dockerizing the Backend

### Backend Dockerfile

Example:

```

FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 5000
CMD ["npm", "start"]

```

The backend Dockerfile is similar but exposes the backend port.

### Build Backend Image

```

docker build -t backend ./backend

```

## Adding the Database

Instead of creating a custom database image, we can use an official Docker Hub image. Example: `mysql:8.0` Advantages:

- Well-tested

- Secure

- Frequently updated

- Easy to configure

Persistent storage should be provided using Docker volumes.

## Using Docker Compose

Managing multiple containers manually can be difficult. Docker Compose simplifies the process. Example Compose file:

```

services:
frontend:
build: ./frontend
ports:
- "3000:3000"
backend:
build: ./backend
ports:
- "5000:5000"
database:
image: mysql:8.0
environment:
MYSQL_ROOT_PASSWORD: password

```

Docker Compose automatically creates:

- Containers

- Networks

- Communication between services

## Networking Between Services

Docker Compose creates a default network.

```

Compose Network
Frontend
│
▼
Backend
│
▼
Database

```

Instead of using IP addresses, services communicate using service names. Example: `database` instead of `172.18.0.4` This improves reliability because service names remain constant even if containers are recreated.

## Using Volumes for Persistent Data

Databases should never store important information inside containers. Example:

```

services:
database:
image: mysql
volumes:
- db-data:/var/lib/mysql
volumes:
db-data:

```

Benefits:

- Data survives container removal.

- Easy backups.

- Reusable storage.

- Reliable production deployments.

## Running the Complete Application

Start everything: `docker compose up` Run in background: `docker compose up -d` Docker Compose performs:

```

Read Compose File
│
▼
Build Images
│
▼
Create Network
│
▼
Create Volume
│
▼
Start Database
│
▼
Start Backend
│
▼
Start Frontend

```

The application becomes operational with a single command.

## Managing the Application

### View Running Containers

`docker compose ps`

### View Logs

`docker compose logs` Follow logs: `docker compose logs -f`

### Stop Application

`docker compose stop`

### Remove Everything

`docker compose down` Remove volumes as well: `docker compose down -v`

## Environment Variables

Applications often require configuration values. Example:

```

environment:
DB_HOST: database
DB_USER: root
DB_PASSWORD: password

```

Environment variables help keep configuration separate from application code. Common uses:

- Database credentials

- API URLs

- Secret keys

- Application modes (development/production)

## Best Practices

When Dockerizing full-stack applications:

- Use separate containers for each service.

- Use Docker Compose for orchestration.

- Store databases in named volumes.

- Use official base images.

- Keep Dockerfiles small and optimized.

- Use `.dockerignore` to exclude unnecessary files.

- Store secrets securely instead of hardcoding them.

- Use version-specific image tags instead of `latest`.

- Keep frontend, backend, and database independent for easier maintenance and scaling.

## Common Mistakes to Avoid

### 1. Putting Everything in One Container

Each major service should have its own container to improve scalability and maintainability.

### 2. Ignoring Persistent Storage

Without volumes, database data will be lost when containers are removed.

### 3. Hardcoding Credentials

Avoid placing passwords and API keys directly in Dockerfiles or Compose files.

### 4. Forgetting Port Mapping

Without published ports, users cannot access frontend or backend services from the host machine.

### 5. Using Large Base Images

Choose lightweight images (such as Alpine-based images where appropriate) to reduce image size and improve deployment speed.

## Real-World Example

Suppose we are developing an online student management system. Architecture:

```

Student
│
▼
React Frontend
│
▼
Node.js Backend
│
▼
MySQL Database

```

Deployment workflow:

```

Write Code
│
▼
Create Dockerfiles
│
▼
Write docker-compose.yml
│
▼
docker compose up
│
▼
Frontend Starts
│
▼
Backend Starts
│
▼
Database Starts
│
▼
Application Ready

```

With Docker Compose, every developer on the team can start the complete application using the same configuration, ensuring a consistent environment.

## Advantages of Dockerizing Full-Stack Applications

| Advantage | Description |
|---|---|
| Consistency | Same environment on every machine |
| Portability | Runs anywhere Docker is installed |
| Scalability | Services can be scaled independently |
| Isolation | Dependencies remain separated |
| Easy Deployment | One command starts the application |
| Simplified Collaboration | All developers use the same setup |
| Maintainability | Services are modular and easier to update |

## Summary Table

| Component | Purpose |
|---|---|
| Frontend | User interface and client- side interactions |
| Backend | Business logic and API processing |
| Database | Persistent data storage |
| Dockerfile | Defines how to build each service image |
| Docker Compose | Manages multiple containers together |
| Network | Enables communication between services |
| Volume | Stores persistent application data |
| Environment Variables | Configure services without changing code |

### Conclusion

Dockerizing a full-stack application allows us to package the frontend, backend, database, and supporting services into isolated containers that work together as a complete system. By using Dockerfiles to define each service and Docker Compose to manage networking, storage, and orchestration, we create applications that are portable, consistent, and easy to deploy across different environments. Following best practices—such as using separate containers for each service, named volumes for persistent data, environment variables for configuration, and official base images—results in reliable, maintainable, and scalable applications. Mastering the process of Dockerizing full-stack applications provides a strong foundation for modern DevOps workflows, continuous integration and deployment (CI/CD), cloud platforms, Docker Swarm, and Kubernetes.');
