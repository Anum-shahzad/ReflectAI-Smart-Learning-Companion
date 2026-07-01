-- =============================================
-- ReflectAI Database Schema – Full Version
-- =============================================

CREATE DATABASE IF NOT EXISTS reflectai;
USE reflectai;

CREATE TABLE IF NOT EXISTS users (
  id           INT PRIMARY KEY AUTO_INCREMENT,
  name         VARCHAR(100)        NOT NULL,
  email        VARCHAR(191)        NOT NULL UNIQUE,
  password     VARCHAR(255)        NOT NULL,
  created_at   TIMESTAMP           DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS evaluations (
  id              INT PRIMARY KEY AUTO_INCREMENT,
  user_id         INT          NOT NULL,
  topic           VARCHAR(255) NOT NULL,
  explanation     TEXT         NOT NULL,
  accuracy_score  INT          NOT NULL,
  clarity_score   INT          NOT NULL,
  depth_score     INT          NOT NULL,
  feedback        TEXT,
  created_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS saved_notes (
  id                INT PRIMARY KEY AUTO_INCREMENT,
  user_id           INT          NOT NULL,
  topic_name        VARCHAR(255) NOT NULL,
  generated_content LONGTEXT     NOT NULL,
  created_at        TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS chatbot_history (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  user_id    INT          NOT NULL,
  message    TEXT         NOT NULL,
  role       ENUM('user','assistant') NOT NULL,
  created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS programming_languages (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  name        VARCHAR(100)  NOT NULL,
  description TEXT,
  icon        VARCHAR(30)   DEFAULT 'code.svg',
  color       VARCHAR(20)   DEFAULT '#6366f1',
  created_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS lectures (
  id               INT PRIMARY KEY AUTO_INCREMENT,
  language_id      INT          NOT NULL,
  title            VARCHAR(255) NOT NULL,
  order_number     INT          NOT NULL DEFAULT 1,
  difficulty_level ENUM('beginner','intermediate','advanced') DEFAULT 'beginner',
  created_at       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (language_id) REFERENCES programming_languages(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS lecture_content (
  id           INT PRIMARY KEY AUTO_INCREMENT,
  lecture_id   INT  NOT NULL,
  content      LONGTEXT NOT NULL,
  youtube_link VARCHAR(500),
  created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (lecture_id) REFERENCES lectures(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_progress (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  user_id    INT     NOT NULL,
  lecture_id INT     NOT NULL,
  completed  BOOLEAN DEFAULT FALSE,
  score      INT     DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY unique_progress (user_id, lecture_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (lecture_id) REFERENCES lectures(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS quizzes (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  lecture_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (lecture_id) REFERENCES lectures(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS quiz_questions (
  id           INT PRIMARY KEY AUTO_INCREMENT,
  quiz_id      INT          NOT NULL,
  question_text TEXT        NOT NULL,
  option_a     VARCHAR(500) NOT NULL,
  option_b     VARCHAR(500) NOT NULL,
  option_c     VARCHAR(500) NOT NULL,
  option_d     VARCHAR(500) NOT NULL,
  correct_option CHAR(1)    NOT NULL,
  created_at   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS quiz_results (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  user_id    INT NOT NULL,
  quiz_id    INT NOT NULL,
  score      INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

-- SEED
INSERT IGNORE INTO users (name, email, password) VALUES (
  'Demo User', 'demo@reflectai.com',
  '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'
);

INSERT IGNORE INTO programming_languages (id, name, description, icon, color) VALUES
(1, 'Python',     'Versatile language for AI, data science, and web dev.', 'python.svg', '#3b82f6'),
(2, 'JavaScript', 'Language of the web — frontend and backend.',           'javascript.svg', '#f59e0b'),
(3, 'C++',        'High-performance systems and competitive programming.', 'cplusplus.svg', '#ef4444'),
(4, 'Java',       'Enterprise and Android development powerhouse.',        'java.svg', '#f97316'),
(5, 'Rust',       'Memory-safe systems language with zero-cost abstractions.', 'rust.svg', '#dc2626'),
(6, 'TypeScript', 'JavaScript with types — scales for large codebases.',   'typescript.svg', '#6366f1');

INSERT IGNORE INTO lectures (id, language_id, title, order_number, difficulty_level) VALUES
(1, 1, 'Introduction to Python',        1, 'beginner'),
(2, 1, 'Variables & Data Types',        2, 'beginner'),
(3, 1, 'Control Flow & Loops',          3, 'beginner'),
(4, 1, 'Functions & Scope',             4, 'beginner'),
(5, 1, 'Lists, Tuples & Dictionaries',  5, 'beginner'),
(6, 1, 'Object-Oriented Programming',   6, 'intermediate'),
(7, 1, 'File Handling & Exceptions',    7, 'intermediate'),
(8, 1, 'Modules & Packages',            8, 'intermediate'),
(9,  2, 'JavaScript Fundamentals',      1, 'beginner'),
(10, 2, 'DOM Manipulation',             2, 'beginner'),
(11, 2, 'Functions & Closures',         3, 'intermediate'),
(12, 2, 'Async JS & Promises',          4, 'intermediate'),
(13, 2, 'ES6+ Modern Features',         5, 'intermediate'),
(14, 2, 'Node.js Basics',               6, 'advanced'),
(15, 3, 'C++ Fundamentals',             1, 'beginner'),
(16, 3, 'Pointers & Memory',            2, 'intermediate'),
(17, 3, 'OOP in C++',                   3, 'intermediate'),
(18, 4, 'Java Basics',                  1, 'beginner'),
(19, 4, 'Java OOP',                     2, 'intermediate'),
(20, 6, 'TypeScript Basics',            1, 'beginner'),
(21, 6, 'Interfaces & Generics',        2, 'intermediate');

INSERT IGNORE INTO lecture_content (lecture_id, content, youtube_link) VALUES
(1, '## Introduction to Python\n\nPython is a high-level, interpreted programming language created by **Guido van Rossum** in 1991.\n\n### Why Python?\n- Simple, readable syntax\n- Used in AI, data science, web dev, automation\n- Huge ecosystem of libraries\n\n### Your First Program\n\n```python\nprint("Hello, World!")\nprint("Welcome to ReflectAI 🚀")\n```\n\n### Key Concepts\n- Python files use `.py` extension\n- `print()` displays output\n- `#` starts a comment\n- Indentation is mandatory\n\n```python\n# Variables\nname = "Alice"\nage = 21\nprint(f"My name is {name}, I am {age} years old.")\n```\n\n### Python is Interpreted\nPython runs line by line — no compile step needed.\n\n```python\n>>> 2 + 2\n4\n>>> "hello".upper()\n"HELLO"\n```\n\n### Installation\n1. Download from [python.org](https://python.org)\n2. Add to PATH\n3. Verify: `python --version`', 'https://www.youtube.com/watch?v=kqtD5dpn9C8'),

(2, '## Variables & Data Types\n\nVariables store data. Python infers types automatically.\n\n### Creating Variables\n\n```python\nname       = "Alice"   # str\nage        = 21        # int\ngpa        = 3.85      # float\nis_student = True      # bool\nnothing    = None      # NoneType\n```\n\n### Python Data Types\n\n| Type | Example |\n|------|---------|\n| str  | "hello" |\n| int  | 42      |\n| float| 3.14    |\n| bool | True    |\n| None | None    |\n\n### Type Checking\n\n```python\nprint(type(42))       # <class ''int''>\nprint(type("hello"))  # <class ''str''>\n```\n\n### String Operations\n\n```python\nfirst = "Reflect"\nlast  = "AI"\nfull  = first + last           # "ReflectAI"\nmsg   = f"Welcome to {full}!"  # f-string\nprint("hello".upper())         # HELLO\nprint(len("Python"))           # 6\n```\n\n### Type Conversion\n\n```python\nage_int  = int("21")     # 21\nscore    = float("98.5") # 98.5\ntext     = str(100)      # "100"\n```', 'https://www.youtube.com/watch?v=OH86oLzVzzw');

INSERT IGNORE INTO quizzes (id, lecture_id) VALUES (1, 1), (2, 2);

INSERT IGNORE INTO quiz_questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(1, 'Who created Python?', 'Linus Torvalds', 'Guido van Rossum', 'James Gosling', 'Bjarne Stroustrup', 'B'),
(1, 'What does print() do?', 'Creates a variable', 'Displays output to the screen', 'Reads user input', 'Declares a function', 'B'),
(1, 'Which symbol starts a comment in Python?', '//', '/* */', '#', '--', 'C'),
(1, 'Python files use which extension?', '.java', '.cpp', '.js', '.py', 'D'),
(2, 'Which is a valid variable name?', '2name', 'my-name', 'my_name', 'my name', 'C'),
(2, 'What type is True in Python?', 'str', 'int', 'bool', 'None', 'C'),
(2, 'How do you get string length?', 'string.size()', 'len(string)', 'string.length', 'count(string)', 'B'),
(2, 'What will int("42") return?', '"42"', '42.0', '42', 'Error', 'C');
