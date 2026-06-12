const express = require('express');
const db      = require('../config/db');
const auth    = require('../middleware/auth');

const router = express.Router();
router.use(auth);

// GET /api/analytics — full analytics for the user
router.get('/', async (req, res) => {
  try {
    const uid = req.user.id;

    // Overall evaluation stats
    const [[stats]] = await db.query(
      `SELECT
         COUNT(*)                    AS total_evaluations,
         ROUND(AVG(accuracy_score))  AS avg_accuracy,
         ROUND(AVG(clarity_score))   AS avg_clarity,
         ROUND(AVG(depth_score))     AS avg_depth,
         MAX(accuracy_score)         AS best_accuracy,
         MAX(clarity_score)          AS best_clarity,
         MAX(depth_score)            AS best_depth
       FROM evaluations WHERE user_id = ?`,
      [uid]
    );

    // Score trend (last 10 evaluations)
    const [trend] = await db.query(
      `SELECT topic, accuracy_score, clarity_score, depth_score, created_at
       FROM evaluations WHERE user_id = ?
       ORDER BY created_at DESC LIMIT 10`,
      [uid]
    );

    // Topics evaluated
    const [topics] = await db.query(
      `SELECT topic, COUNT(*) as attempts,
              ROUND(AVG(accuracy_score)) as avg_score
       FROM evaluations WHERE user_id = ?
       GROUP BY topic ORDER BY attempts DESC LIMIT 10`,
      [uid]
    );

    // Progress stats
    const [[progressStats]] = await db.query(
      `SELECT
         COUNT(*) AS lectures_viewed,
         SUM(completed) AS lectures_completed
       FROM user_progress WHERE user_id = ?`,
      [uid]
    );

    // Quiz stats
    const [[quizStats]] = await db.query(
      `SELECT COUNT(*) AS quizzes_taken,
              ROUND(AVG(score)) AS avg_quiz_score,
              MAX(score) AS best_quiz_score
       FROM quiz_results WHERE user_id = ?`,
      [uid]
    );

    // Notes saved
    const [[notesStats]] = await db.query(
      'SELECT COUNT(*) AS notes_count FROM saved_notes WHERE user_id = ?',
      [uid]
    );

    // Weekly activity (last 7 days)
    const [activity] = await db.query(
      `SELECT DATE(created_at) as day, COUNT(*) as count
       FROM evaluations
       WHERE user_id = ? AND created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
       GROUP BY DATE(created_at) ORDER BY day`,
      [uid]
    );

    res.json({
      evaluations: { ...stats, trend: trend.reverse(), topics },
      progress: progressStats,
      quizzes: quizStats,
      notes: notesStats,
      activity,
    });

  } catch (err) {
    console.error('Analytics error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
