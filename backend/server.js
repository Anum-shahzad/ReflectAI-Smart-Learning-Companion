require('dotenv').config();
const express = require('express');
const cors    = require('cors');

const authRoutes      = require('./routes/auth');
const evaluateRoutes  = require('./routes/evaluate');
const notesRoutes     = require('./routes/notes');
const chatRoutes      = require('./routes/chat');
const pathsRoutes     = require('./routes/paths');
const analyticsRoutes = require('./routes/analytics');
const mizuRoutes = require('./routes/mizu');

const app  = express();
const PORT = process.env.PORT || 5001;

app.use(cors({ origin: process.env.CLIENT_URL || 'http://localhost:5173' }));
app.use(express.json({ limit: '50kb' }));

app.use('/api/auth',      authRoutes);
app.use('/api/evaluate',  evaluateRoutes);
app.use('/api/notes',     notesRoutes);
app.use('/api/chat',      chatRoutes);
app.use('/api/paths',     pathsRoutes);
app.use('/api/analytics', analyticsRoutes);
app.use('/api/mizu',      mizuRoutes);

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.use((req, res) => {
  res.status(404).json({ error: `Route ${req.method} ${req.path} not found` });
});

app.use((err, req, res, next) => {
  console.error('Unhandled error:', err);
  res.status(500).json({ error: 'Internal server error' });
});

app.listen(PORT, () => {
  console.log(`\n🚀  ReflectAI backend running on http://localhost:${PORT}`);
  console.log(`   Health: http://localhost:${PORT}/api/health\n`);
});
