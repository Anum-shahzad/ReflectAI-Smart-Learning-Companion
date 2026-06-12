const express = require('express');
const Groq    = require('groq-sdk');
const db      = require('../config/db');
const auth    = require('../middleware/auth');

const router = express.Router();
router.use(auth);

const MIZU_SYSTEM_PROMPT = `You are Mizu, an AI learning companion for ReflectAI — a platform built for CS, engineering, and AI students.

CHARACTER:
- You are a watery, fluid-based entity with a bright pink glow and a slightly chaotic energy
- Highly intelligent coder. Messy but brilliant. Sarcastic but deeply caring.
- You're judgy in a humorous way, but NEVER insult the user personally — target the mistake, not the person
- You celebrate progress loudly and genuinely

TONE EXAMPLES:
- Strong answer: "Okay… that clarity? Clean. I'm actually impressed. Don't make it weird."
- Weak answer: "Hmm. We're missing some logic here. Let's tighten that up — together."
- Wrong answer: "Bro… are you serious right now? Did we even read the material? It's okay. Breathe. We fix it."
- User improves: "SEE?! That's what I'm talking about. Brain unlocked. 🔓"

CAPABILITIES:
- Answer general CS/programming/AI questions
- Help debug code
- Explain evaluation feedback
- Suggest study strategies
- Quiz the user on topics

RULES:
- Stay in character as Mizu always
- Be concise unless explaining something complex
- Use code blocks for any code snippets
- Add personality to your responses — don't be a boring chatbot
- You can use light emoji but don't overdo it`;

// POST /api/chat — send a message
router.post('/', async (req, res) => {
  const { message, history } = req.body;
  if (!message) return res.status(400).json({ error: 'Message is required' });

  try {
    // Build messages array with history
    const messages = [{ role: 'system', content: MIZU_SYSTEM_PROMPT }];

    if (history && Array.isArray(history)) {
      history.slice(-20).forEach(m => {
        if (m.role === 'user' || m.role === 'assistant') {
          messages.push({ role: m.role, content: m.message || m.content });
        }
      });
    }

    messages.push({ role: 'user', content: message });

    const groq  = new Groq({ apiKey: process.env.GROQ_API_KEY });
    const response = await groq.chat.completions.create({
      model: 'llama-3.3-70b-versatile',
      messages,
      temperature: 0.7,
      max_tokens: 1024,
    });

    const reply = response.choices[0].message.content;

    // Save both messages to DB
    await db.query(
      'INSERT INTO chatbot_history (user_id, message, role) VALUES (?, ?, ?)',
      [req.user.id, message, 'user']
    );
    await db.query(
      'INSERT INTO chatbot_history (user_id, message, role) VALUES (?, ?, ?)',
      [req.user.id, reply, 'assistant']
    );

    res.json({ reply });

  } catch (err) {
    console.error('Chat error:', err.message);
    res.status(500).json({ error: 'Mizu is having a moment. Try again. ' + err.message });
  }
});

// GET /api/chat/history — get chat history
router.get('/history', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT message, role, created_at FROM chatbot_history
       WHERE user_id = ? ORDER BY created_at DESC LIMIT 100`,
      [req.user.id]
    );
    res.json({ history: rows.reverse() });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// DELETE /api/chat/history — clear chat
router.delete('/history', async (req, res) => {
  try {
    await db.query('DELETE FROM chatbot_history WHERE user_id = ?', [req.user.id]);
    res.json({ message: 'Chat history cleared' });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
