const express = require('express');
const Groq    = require('groq-sdk');
const db      = require('../config/db');
const auth    = require('../middleware/auth');

const router = express.Router();
router.use(auth);

// GET /api/paths — all programming languages
router.get('/', async (req, res) => {
  try {
    const [langs] = await db.query('SELECT * FROM programming_languages ORDER BY id');

    // Get lecture count per language
    const [counts] = await db.query(
      `SELECT language_id, COUNT(*) as lecture_count
       FROM lectures GROUP BY language_id`
    );

    // Get user progress
    const [progress] = await db.query(
      `SELECT l.language_id, COUNT(up.id) as completed_count
       FROM user_progress up
       JOIN lectures l ON l.id = up.lecture_id
       WHERE up.user_id = ? AND up.completed = TRUE
       GROUP BY l.language_id`,
      [req.user.id]
    );

    const countMap    = Object.fromEntries(counts.map(r => [r.language_id, r.lecture_count]));
    const progressMap = Object.fromEntries(progress.map(r => [r.language_id, r.completed_count]));

    const languages = langs.map(l => ({
      ...l,
      lecture_count:    countMap[l.id] || 0,
      completed_count:  progressMap[l.id] || 0,
    }));

    res.json({ languages });
  } catch (err) {
    console.error('Paths error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/paths/:langId/lectures
router.get('/:langId/lectures', async (req, res) => {
  try {
    const [lectures] = await db.query(
      `SELECT l.*, 
              up.completed, up.score,
              q.id as quiz_id
       FROM lectures l
       LEFT JOIN user_progress up ON up.lecture_id = l.id AND up.user_id = ?
       LEFT JOIN quizzes q ON q.lecture_id = l.id
       WHERE l.language_id = ?
       ORDER BY l.order_number`,
      [req.user.id, req.params.langId]
    );

    const [lang] = await db.query(
      'SELECT * FROM programming_languages WHERE id = ?',
      [req.params.langId]
    );

    if (!lang.length) return res.status(404).json({ error: 'Language not found' });

    res.json({ language: lang[0], lectures });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/paths/lecture/:lectureId — single lecture
router.get('/lecture/:lectureId', async (req, res) => {
  try {
    const [lectures] = await db.query(
      `SELECT l.*, pl.name as language_name, pl.icon as language_icon,
              lc.content, lc.youtube_link,
              up.completed, up.score,
              q.id as quiz_id
       FROM lectures l
       JOIN programming_languages pl ON pl.id = l.language_id
       LEFT JOIN lecture_content lc ON lc.lecture_id = l.id
       LEFT JOIN user_progress up ON up.lecture_id = l.id AND up.user_id = ?
       LEFT JOIN quizzes q ON q.lecture_id = l.id
       WHERE l.id = ?`,
      [req.user.id, req.params.lectureId]
    );

    if (!lectures.length) return res.status(404).json({ error: 'Lecture not found' });

    // Mark as viewed (but not completed yet)
    await db.query(
      `INSERT INTO user_progress (user_id, lecture_id, completed)
       VALUES (?, ?, FALSE)
       ON DUPLICATE KEY UPDATE lecture_id = lecture_id`,
      [req.user.id, req.params.lectureId]
    );

    // Get next and prev lectures
    const lecture = lectures[0];
    const [siblings] = await db.query(
      `SELECT id, title, order_number FROM lectures
       WHERE language_id = ? ORDER BY order_number`,
      [lecture.language_id]
    );

    const idx  = siblings.findIndex(s => s.id === lecture.id);
    const prev = siblings[idx - 1] || null;
    const next = siblings[idx + 1] || null;

    res.json({ lecture, prev, next });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

// POST /api/paths/lecture/:lectureId/complete
router.post('/lecture/:lectureId/complete', async (req, res) => {
  try {
    await db.query(
      `INSERT INTO user_progress (user_id, lecture_id, completed)
       VALUES (?, ?, TRUE)
       ON DUPLICATE KEY UPDATE completed = TRUE, updated_at = NOW()`,
      [req.user.id, req.params.lectureId]
    );
    res.json({ message: 'Lecture marked as complete' });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/paths/quiz/:lectureId — get quiz for a lecture
router.get('/quiz/:lectureId', async (req, res) => {
  try {
    const [quizzes] = await db.query(
      'SELECT * FROM quizzes WHERE lecture_id = ?',
      [req.params.lectureId]
    );

    if (!quizzes.length) return res.status(404).json({ error: 'No quiz for this lecture' });

    const quiz = quizzes[0];
    const [questions] = await db.query(
      `SELECT id, question_text, option_a, option_b, option_c, option_d
       FROM quiz_questions WHERE quiz_id = ?`,
      [quiz.id]
    );

    res.json({ quiz_id: quiz.id, questions });
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

// POST /api/paths/quiz/:quizId/submit
router.post('/quiz/:quizId/submit', async (req, res) => {
  const { answers } = req.body; // { questionId: 'A', ... }
  try {
    const [questions] = await db.query(
      'SELECT id, correct_option FROM quiz_questions WHERE quiz_id = ?',
      [req.params.quizId]
    );

    let correct = 0;
    const results = questions.map(q => {
      const given   = (answers[q.id] || '').toUpperCase();
      const isRight = given === q.correct_option.toUpperCase();
      if (isRight) correct++;
      return { id: q.id, given, correct: q.correct_option, isRight };
    });

    const score = Math.round((correct / questions.length) * 100);

    await db.query(
      'INSERT INTO quiz_results (user_id, quiz_id, score) VALUES (?, ?, ?)',
      [req.user.id, req.params.quizId, score]
    );

    // Update user_progress score if quiz is linked to a lecture
    const [quizRow] = await db.query(
      'SELECT lecture_id FROM quizzes WHERE id = ?',
      [req.params.quizId]
    );
    if (quizRow.length) {
      await db.query(
        `INSERT INTO user_progress (user_id, lecture_id, completed, score)
         VALUES (?, ?, TRUE, ?)
         ON DUPLICATE KEY UPDATE score = ?, completed = TRUE, updated_at = NOW()`,
        [req.user.id, quizRow[0].lecture_id, score, score]
      );
    }

    res.json({ score, correct, total: questions.length, results });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
