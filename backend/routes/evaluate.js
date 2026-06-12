const express = require('express');
const Groq     = require('groq-sdk');
const db       = require('../config/db');
const auth     = require('../middleware/auth');

const router = express.Router();

// All evaluation routes require auth
router.use(auth);

// ── POST /api/evaluate ────────────────────────
router.post('/', async (req, res) => {
  const { topic, explanation } = req.body;

  if (!topic || !explanation) {
    return res.status(400).json({ error: 'Topic and explanation are required' });
  }
  if (explanation.trim().length < 20) {
    return res.status(400).json({ error: 'Explanation is too short' });
  }

  try {
    const evaluation = await runAIEvaluation(topic, explanation);

    // Persist to database
    const [result] = await db.query(
      `INSERT INTO evaluations
         (user_id, topic, explanation, accuracy_score, clarity_score, depth_score, feedback)
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [
        req.user.id,
        topic,
        explanation,
        evaluation.accuracy,
        evaluation.clarity,
        evaluation.depth,
        JSON.stringify(evaluation),
      ]
    );

    res.json({ id: result.insertId, ...evaluation });

  } catch (err) {
    console.error('Evaluate error:', err.message);
    res.status(500).json({ error: 'Evaluation failed: ' + err.message });
  }
});

// ── GET /api/evaluate/history ─────────────────
router.get('/history', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT id, topic, accuracy_score, clarity_score, depth_score, created_at
       FROM evaluations
       WHERE user_id = ?
       ORDER BY created_at DESC
       LIMIT 50`,
      [req.user.id]
    );
    res.json({ history: rows });
  } catch (err) {
    console.error('History error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// ── GET /api/evaluate/:id ─────────────────────
router.get('/:id', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT * FROM evaluations WHERE id = ? AND user_id = ?',
      [req.params.id, req.user.id]
    );
    if (!rows.length) return res.status(404).json({ error: 'Not found' });

    const row = rows[0];
    const parsed = JSON.parse(row.feedback || '{}');
    res.json({ ...row, ...parsed });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// ── AI Evaluation ─────────────────────────────
async function runAIEvaluation(topic, explanation) {
  const groq = new Groq({ apiKey: process.env.GROQ_API_KEY });

  const prompt = `You are ReflectAI, an academic evaluation engine.
Evaluate this student's conceptual explanation and return ONLY valid JSON.

TOPIC: ${topic}
STUDENT EXPLANATION: ${explanation}

Return exactly this JSON structure (no markdown, no extra text):
{
  "accuracy": <integer 0-100>,
  "clarity": <integer 0-100>,
  "depth": <integer 0-100>,
  "missing_concepts": [<2-4 short strings>],
  "misconceptions": [<0-2 short strings, empty array if none>],
  "coverage": [
    {"concept": "<name>", "percentage": <0-100>, "status": "<covered|partial|missing>"},
    {"concept": "<name>", "percentage": <0-100>, "status": "<covered|partial|missing>"},
    {"concept": "<name>", "percentage": <0-100>, "status": "<covered|partial|missing>"}
  ],
  "academic_feedback": "<2-3 sentence academic feedback>",
  "revision_notes": ["<note 1>", "<note 2>", "<note 3>"]
}`;

  const response = await groq.chat.completions.create({
    model: 'llama-3.3-70b-versatile',
    messages: [{ role: 'user', content: prompt }],
    temperature: 0.3,
    response_format: { type: 'json_object' },
  });

  const raw = response.choices[0].message.content;
  return JSON.parse(raw);
}

module.exports = router;