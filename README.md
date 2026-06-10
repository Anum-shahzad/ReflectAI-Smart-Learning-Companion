# ReflectAI

An AI-powered learning platform for students. ReflectAI combines structured lecture content with AI tools — a tutor chatbot, smart note generation, self-evaluation with scoring, and a progress dashboard — all in one place.

---

## Tech Stack

**Frontend** — React 18, Vite, Tailwind CSS, React Router, Axios  
**Backend** — Node.js, Express.js  
**Database** — MySQL  
**AI** — Groq SDK (Llama 3.3 70B)  
**Auth** — JWT, bcrypt  

---

## Features

- User registration and login with JWT authentication
- Structured lecture viewer for HTML, Java, and JavaScript courses
- AI chatbot tutor (Mizu) powered by Groq for answering study questions
- AI-generated smart notes from any topic
- Self-evaluation system where AI scores your understanding
- Analytics dashboard to track progress over time

---

## Project Structure

```
ReflectAI/
├── backend/
│   ├── config/db.js
│   ├── middleware/auth.js
│   ├── routes/
│   │   ├── auth.js
│   │   ├── chat.js
│   │   ├── notes.js
│   │   ├── evaluate.js
│   │   ├── analytics.js
│   │   └── paths.js
│   ├── server.js
│   └── package.json
├── frontend/
│   ├── src/
│   │   ├── api/axios.js
│   │   ├── context/AuthContext.jsx
│   │   ├── components/
│   │   ├── pages/
│   │   ├── main.jsx
│   │   └── index.css
│   ├── index.html
│   └── package.json
├── database/
│   ├── schema.sql
│   ├── html_lectures_seed.sql
│   └── java_lectures_seed.sql
├── .env.example
└── README.md
```

---

## Setup

### Requirements

- Node.js v18+
- XAMPP (for MySQL)
- Groq API key — https://console.groq.com/keys

### Database

1. Start Apache and MySQL from the XAMPP Control Panel
2. Open phpMyAdmin at `http://localhost/phpmyadmin`
3. Create a new database named `reflectai`
4. Import `database/schema.sql`, then the two seed files

### Backend

```bash
cd backend
cp .env.example .env
# Fill in your values in .env
npm install
npm run dev
```

### Frontend

```bash
cd frontend
npm install
npm run dev
```

The app runs at `http://localhost:5173`

---

## Environment Variables

```env
PORT=5000
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=reflectai
JWT_SECRET=your_secret_here
GROQ_API_KEY=gsk_...
CLIENT_URL=http://localhost:5173
```

---

## API Endpoints

| Method | Route | Auth | Description |
|--------|-------|------|-------------|
| POST | /api/auth/register | No | Create account |
| POST | /api/auth/login | No | Login, returns JWT |
| GET | /api/auth/me | Yes | Get current user |
| POST | /api/chat | Yes | AI tutor message |
| GET | /api/chat/history | Yes | Get chat history |
| DELETE | /api/chat/history | Yes | Clear chat history |
| POST | /api/notes | Yes | Generate notes |
| GET | /api/notes | Yes | Get saved notes |
| POST | /api/evaluate | Yes | Submit for AI scoring |
| GET | /api/evaluate/history | Yes | Past evaluations |
| GET | /api/analytics | Yes | User progress data |
| GET | /api/paths | Yes | Learning paths |
| GET | /api/health | No | Health check |
