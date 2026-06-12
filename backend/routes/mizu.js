const express = require('express');
const Groq    = require('groq-sdk');
const auth    = require('../middleware/auth');

const router = express.Router();
router.use(auth);

const MIZU_PERSONA = `You are Mizu — a small, opinionated AI water blob who lives on ReflectAI, a learning platform for CS and engineering students.

PERSONALITY:
- Blunt, sarcastic, but genuinely invested in the user succeeding
- You have strong opinions. You are never generic or vague.
- You react specifically to the data you are given. You never give advice that could apply to anyone.
- Slightly chaotic energy. Like a brilliant but messy senior student.
- You celebrate real progress loudly. You call out weak work directly but never personally.

FORMAT RULES — follow these exactly:
- Maximum 2 sentences. Never more.
- No bullet points. No lists. No headers.
- No greetings, no "Hey!", no "Great job!" openers.
- React to the SPECIFIC data. Mention the actual topic, score, or concept.
- Speak directly to the user. First person, present tense.
- Light sarcasm is fine. Mean-spirited is not.

TONE EXAMPLES by trigger:
- eval_high_score (score 88, topic "recursion"): "Recursion at 88 — you actually understand the call stack. That's rarer than it should be."
- eval_low_score (score 31, topic "pointers"): "31 on pointers. The concept clicked somewhere else before it got here — find that gap and fill it."
- eval_misconception (topic "OOP", misconception "confusing inheritance with composition"): "Inheritance vs composition is one of the most common mix-ups in OOP — they solve different problems."
- notes_generated (topic "neural networks"): "Neural networks notes are done. Read the backpropagation section twice — everyone skims it and everyone regrets it."
- idle_evaluate: "The explanation box is right there. Type something — anything. We go from there."
- idle_long: "You have been sitting here for a while. I'm not judging. I am, but I'm not saying it out loud."`;

// Build the user message from trigger + data
function buildPrompt(trigger, data) {
  switch (trigger) {

    case 'eval_result': {
      const avg = Math.round((data.accuracy + data.clarity + data.depth) / 3);
      const parts = [
        `The user just submitted an evaluation.`,
        `Topic: "${data.topic}"`,
        `Scores — Accuracy: ${data.accuracy}/100, Clarity: ${data.clarity}/100, Depth: ${data.depth}/100`,
        `Average: ${avg}/100`,
      ];
      if (data.misconceptions && data.misconceptions.length > 0) {
        parts.push(`Top misconception: "${data.misconceptions[0]}"`);
      }
      if (data.strengths && data.strengths.length > 0) {
        parts.push(`Top strength: "${data.strengths[0]}"`);
      }
      parts.push(`React to this specific result as Mizu. Be direct about the score and the topic.`);
      return parts.join('\n');
    }

    case 'notes_generated': {
      return [
        `The user just generated notes on the topic: "${data.topic}".`,
        `React as Mizu. Tell them one specific thing to pay attention to in this topic.`,
        `If you are not certain about the topic, say something about the value of good notes instead.`,
      ].join('\n');
    }

    case 'tab_switch': {
      const tabDescriptions = {
        evaluate:  'moved to the Evaluate tab — they are about to test their knowledge by explaining a concept',
        history:   'opened their Evaluation History — reviewing past scores',
        analytics: 'opened Analytics — looking at their performance data',
        learn:     'opened the Learn tab — about to study a programming language',
        notes:     'opened Notes Generator — about to generate study notes',
        chatbot:   'opened the AI Chatbot to talk with Mizu directly',
        settings:  'opened Settings',
      };
      const desc = tabDescriptions[data.tab] || `navigated to ${data.tab}`;
      return [
        `The user just ${desc}.`,
        `React as Mizu with one short, context-appropriate line. Be specific to what they are about to do.`,
      ].join('\n');
    }

    case 'idle_short': {
      return `The user has been idle on the "${data.tab}" tab for about ${data.seconds} seconds. React as Mizu — briefly nudge them back to work. Be specific to the tab they are on.`;
    }

    case 'idle_long': {
      return `The user has been completely idle for over ${data.seconds} seconds on the "${data.tab}" tab. React as Mizu — be a bit more pointed. They need a push.`;
    }

    case 'typing_active': {
      return `The user is actively typing an explanation about "${data.topic}" on the Evaluate tab. They have written about ${data.charCount} characters so far. Encourage them briefly as Mizu — react to the effort, not the quality (you haven't seen it yet).`;
    }

    case 'typing_stopped': {
      return `The user was typing an explanation about "${data.topic}" on the Evaluate tab but stopped after ${data.charCount} characters. They may be stuck. React as Mizu — nudge them to keep going or think about what's missing.`;
    }

    default:
      return `The user is on the "${data.tab || 'dashboard'}" tab. Say something short and in-character as Mizu.`;
  }
}

// POST /api/mizu/react
router.post('/react', async (req, res) => {
  const { trigger, data = {} } = req.body;

  if (!trigger) {
    return res.status(400).json({ error: 'trigger is required' });
  }

  try {
    const userPrompt = buildPrompt(trigger, data);

    const groq = new Groq({ apiKey: process.env.GROQ_API_KEY });
    const response = await groq.chat.completions.create({
      model: 'llama-3.3-70b-versatile',
      messages: [
        { role: 'system',  content: MIZU_PERSONA },
        { role: 'user',    content: userPrompt   },
      ],
      temperature: 0.75,
      max_tokens: 80,   // hard cap — Mizu must be short
    });

    const line = response.choices[0].message.content.trim();
    res.json({ line });

  } catch (err) {
    console.error('Mizu react error:', err.message);
    // Never crash the UI over a Mizu line — return a fallback silently
    res.json({ line: null });
  }
});

module.exports = router;
