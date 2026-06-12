const express = require('express');
const Groq    = require('groq-sdk');
const db      = require('../config/db');
const auth    = require('../middleware/auth');

const router = express.Router();
router.use(auth);

const NOTES_SYSTEM_PROMPT = `You are ReflectAI's expert note generator for computer science and engineering students.
Generate comprehensive, structured, and visually organized study notes in Markdown format.

Your notes must include:
1. A clear title and brief intro
2. Key concepts with definitions
3. Code examples (where relevant) in proper code blocks with language tags
4. Bullet-pointed summaries
5. A "Quick Reference" section at the end
6. Practical applications or use cases
7. Common pitfalls or misconceptions to avoid

Format: Use proper Markdown (##, ###, bullets, code blocks, tables where useful).
Tone: Clear, academic but engaging. Suitable for CS/Engineering students.
Length: Comprehensive (600-1200 words).`;

// POST /api/notes/generate
router.post('/generate', async (req, res) => {
  const { topic } = req.body;
  if (!topic || topic.trim().length < 2) {
    return res.status(400).json({ error: 'Topic is required' });
  }

  try {
    const groq = new Groq({ apiKey: process.env.GROQ_API_KEY });
    const response = await groq.chat.completions.create({
      model: 'llama-3.3-70b-versatile',
      messages: [
        { role: 'system', content: NOTES_SYSTEM_PROMPT },
        { role: 'user',   content: `Generate comprehensive study notes on: ${topic}` },
      ],
      temperature: 0.4,
      max_tokens: 2048,
    });

    const content = response.choices[0].message.content;
    res.json({ content, topic });

  } catch (err) {
    console.error('Notes generate error:', err.message);
    res.status(500).json({ error: 'Failed to generate notes: ' + err.message });
  }
});

// POST /api/notes/save
router.post('/save', async (req, res) => {
  const { topic_name, generated_content } = req.body;
  if (!topic_name || !generated_content) {
    return res.status(400).json({ error: 'Topic and content are required' });
  }

  try {
    const [result] = await db.query(
      'INSERT INTO saved_notes (user_id, topic_name, generated_content) VALUES (?, ?, ?)',
      [req.user.id, topic_name, generated_content]
    );
    res.json({ id: result.insertId, message: 'Notes saved successfully' });
  } catch (err) {
    console.error('Notes save error:', err);
    res.status(500).json({ error: 'Failed to save notes' });
  }
});

// GET /api/notes
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT id, topic_name, created_at FROM saved_notes WHERE user_id = ? ORDER BY created_at DESC',
      [req.user.id]
    );
    res.json({ notes: rows });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/notes/:id
router.get('/:id', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT * FROM saved_notes WHERE id = ? AND user_id = ?',
      [req.params.id, req.user.id]
    );
    if (!rows.length) return res.status(404).json({ error: 'Note not found' });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// DELETE /api/notes/:id
router.delete('/:id', async (req, res) => {
  try {
    await db.query(
      'DELETE FROM saved_notes WHERE id = ? AND user_id = ?',
      [req.params.id, req.user.id]
    );
    res.json({ message: 'Note deleted' });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
