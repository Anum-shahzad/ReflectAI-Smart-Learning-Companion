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
// Body: { message, history, conversation_id } — conversation_id optional;
// if omitted, a new conversation is created automatically (first message of a new chat).
router.post('/', async (req, res) => {
  const { message, history, conversation_id } = req.body;
  if (!message) return res.status(400).json({ error: 'Message is required' });

  try {
    let conversationId = conversation_id;

    // No conversation yet (first message of a brand new chat) — create one.
    // Title it from the first ~40 chars of the message.
    if (!conversationId) {
      const title = message.length > 40 ? message.slice(0, 40) + '…' : message;
      const [result] = await db.query(
        'INSERT INTO chat_conversations (user_id, title) VALUES (?, ?)',
        [req.user.id, title]
      );
      conversationId = result.insertId;
    } else {
      // Make sure this conversation actually belongs to the requesting user
      const [owned] = await db.query(
        'SELECT id FROM chat_conversations WHERE id = ? AND user_id = ?',
        [conversationId, req.user.id]
      );
      if (!owned.length) return res.status(404).json({ error: 'Conversation not found' });
    }

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

    // Save both messages to DB, tied to this conversation
    await db.query(
      'INSERT INTO chatbot_history (user_id, conversation_id, message, role) VALUES (?, ?, ?, ?)',
      [req.user.id, conversationId, message, 'user']
    );
    await db.query(
      'INSERT INTO chatbot_history (user_id, conversation_id, message, role) VALUES (?, ?, ?, ?)',
      [req.user.id, conversationId, reply, 'assistant']
    );

    res.json({ reply, conversation_id: conversationId });

  } catch (err) {
    console.error('Chat error:', err.message);
    res.status(500).json({ error: 'Mizu is having a moment. Try again. ' + err.message });
  }
});

// POST /api/chat/conversations — explicitly start a new empty conversation
// (used by the "New Chat" button before the user has typed anything)
router.post('/conversations', async (req, res) => {
  try {
    const [result] = await db.query(
      'INSERT INTO chat_conversations (user_id, title) VALUES (?, ?)',
      [req.user.id, 'New Chat']
    );
    res.json({ id: result.insertId, title: 'New Chat' });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/chat/conversations — list this user's conversations, most recent first
router.get('/conversations', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT c.id, c.title, c.created_at,
              (SELECT message FROM chatbot_history h
                 WHERE h.conversation_id = c.id
                 ORDER BY h.id DESC LIMIT 1) AS last_message
       FROM chat_conversations c
       WHERE c.user_id = ?
       ORDER BY c.id DESC`,
      [req.user.id]
    );
    res.json({ conversations: rows });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/chat/history?conversation_id=X — get messages for one conversation
// (ordered by id, never created_at — avoids same-second ordering bugs)
router.get('/history', async (req, res) => {
  const { conversation_id } = req.query;
  if (!conversation_id) return res.json({ history: [] });

  try {
    const [owned] = await db.query(
      'SELECT id FROM chat_conversations WHERE id = ? AND user_id = ?',
      [conversation_id, req.user.id]
    );
    if (!owned.length) return res.status(404).json({ error: 'Conversation not found' });

    const [rows] = await db.query(
      `SELECT message, role, created_at FROM (
         SELECT message, role, created_at, id FROM chatbot_history
         WHERE conversation_id = ? ORDER BY id DESC LIMIT 100
       ) recent ORDER BY id ASC`,
      [conversation_id]
    );
    res.json({ history: rows });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// DELETE /api/chat/conversations/:id — delete one conversation and its messages
router.delete('/conversations/:id', async (req, res) => {
  try {
    const [result] = await db.query(
      'DELETE FROM chat_conversations WHERE id = ? AND user_id = ?',
      [req.params.id, req.user.id]
    );
    if (!result.affectedRows) return res.status(404).json({ error: 'Conversation not found' });
    res.json({ message: 'Conversation deleted' });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// DELETE /api/chat/history — clear ALL of this user's chat history (every conversation)
router.delete('/history', async (req, res) => {
  try {
    await db.query(
      'DELETE FROM chat_conversations WHERE user_id = ?',
      [req.user.id]
    ); // ON DELETE CASCADE removes chatbot_history rows too
    res.json({ message: 'Chat history cleared' });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
