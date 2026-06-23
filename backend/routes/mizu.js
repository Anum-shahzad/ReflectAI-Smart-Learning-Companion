const express = require('express');
const Groq    = require('groq-sdk');
const auth    = require('../middleware/auth');

const router = express.Router();
router.use(auth);

const MIZU_PERSONA = `You are Mizu — a tiny sarcastic AI water blob who lives on ReflectAI, a learning platform for CS students.

ABSOLUTE FORMAT RULES — these are not suggestions, they are hard limits:
- Maximum 6 words. Never more. Count them.
- One short sentence only. No commas creating two clauses.
- NEVER use "..." or trail off. Every sentence must be complete.
- NEVER use ellipsis. Finish the thought in 6 words or fewer.
- No greetings. No "Hey". Jump straight to the reaction.
- This is a text bubble next to a tiny character, not a chat message. Think meme caption, not sentence.

VOICE: blunt, sarcastic, deadpan, like a done-with-this-but-secretly-rooting-for-you friend.

EXACT CALIBRATION EXAMPLES — match this length and tone exactly:

Trigger: eval_result, score 28 (low)
Good: "Bro seriously?"
Good: "We need to talk."

Trigger: eval_result, score 55 (mid)
Good: "Okay, not bad."
Good: "Mid. We can fix that."

Trigger: eval_result, score 90 (high)
Good: "Okay show off."
Good: "Wait, actually impressive."

Trigger: tab_switch to evaluate
Good: "Let's see what you got."
Good: "Prove it then."

Trigger: tab_switch to learn
Good: "Ooo bro's motivated today."
Good: "Look who's studying."

Trigger: tab_switch to notes
Good: "Topic. Go. I'll cook."
Good: "Give me something to work with."

Trigger: tab_switch to history
Good: "Let's see the damage."
Good: "Past scores don't lie."

Trigger: tab_switch to analytics
Good: "Numbers time. No hiding now."
Good: "Let's see the pattern."

Trigger: idle_short
Good: "You good over there?"
Good: "Still alive?"

Trigger: idle_long
Good: "It's been a while, bro."
Good: "I'm still here. Waiting."

Trigger: typing_active
Good: "Keep going."
Good: "There it is."

Trigger: typing_stopped
Good: "Why'd you stop?"
Good: "Stuck already?"

Trigger: notes_generated
Good: "Notes done. Actually read them."
Good: "There. Don't waste it."

RULE: Every single response must be 6 words or fewer, one complete thought, zero ellipsis. If you cannot say it in 6 words, cut it down further. Brevity over completeness of explanation — react with attitude, not detail.`;

function buildPrompt(trigger, data) {
  switch (trigger) {

    case 'eval_result': {
      const avg = Math.round((data.accuracy + data.clarity + data.depth) / 3);
      return [
        `User just submitted an evaluation on "${data.topic}".`,
        `Average score: ${avg}/100.`,
        `React as Mizu in 6 words or fewer. Match the energy to the score — harsh if low, hyped if high, deadpan if mid.`,
      ].join(' ');
    }

    case 'notes_generated': {
      return `User generated notes on "${data.topic}". React as Mizu in 6 words or fewer.`;
    }

    case 'tab_switch': {
      const tabDescriptions = {
        evaluate:  'the Evaluate tab, about to explain a concept',
        history:   'their Evaluation History',
        analytics: 'Analytics, looking at performance data',
        learn:     'the Learn tab, about to study',
        notes:     'Notes Generator',
        chatbot:   'the AI Chatbot to talk to Mizu directly',
        settings:  'Settings',
      };
      const desc = tabDescriptions[data.tab] || data.tab;
      return `User just opened ${desc}. React as Mizu in 6 words or fewer.`;
    }

    case 'idle_short': {
      return `User has been idle about ${data.seconds} seconds on "${data.tab}". React as Mizu in 6 words or fewer.`;
    }

    case 'idle_long': {
      return `User has been idle over ${data.seconds} seconds on "${data.tab}". React as Mizu in 6 words or fewer, a bit more pointed.`;
    }

    case 'typing_active': {
      return `User is actively typing an explanation about "${data.topic}". React as Mizu in 6 words or fewer, encouraging.`;
    }

    case 'typing_stopped': {
      return `User stopped typing mid-explanation about "${data.topic}". React as Mizu in 6 words or fewer.`;
    }

    default:
      return `User is on "${data.tab || 'dashboard'}". Say something in character as Mizu, 6 words or fewer.`;
  }
}

// Hard safety net: enforce word limit + strip any ellipsis even if the model ignores instructions
function enforceShort(line) {
  if (!line) return line;
  let cleaned = line.replace(/\.\.\.|…/g, '').trim();
  const words = cleaned.split(/\s+/);
  if (words.length > 7) {
    cleaned = words.slice(0, 7).join(' ');
  }
  // Ensure it ends with proper punctuation, not a dangling word
  if (!/[.!?]$/.test(cleaned)) {
    cleaned += '.';
  }
  return cleaned;
}

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
        { role: 'system', content: MIZU_PERSONA },
        { role: 'user',   content: userPrompt   },
      ],
      temperature: 0.85,
      max_tokens: 20,   // hard cap — forces brevity at the token level
    });

    const raw  = response.choices[0].message.content.trim();
    const line = enforceShort(raw);
    res.json({ line });

  } catch (err) {
    console.error('Mizu react error:', err.message);
    res.json({ line: null });
  }
});

module.exports = router;
