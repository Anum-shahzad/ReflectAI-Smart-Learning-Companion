-- =============================================
-- Migration: multi-conversation chat support
-- Run this against an EXISTING reflectai database
-- (schema.sql already has this baked in for fresh installs)
-- =============================================

USE reflectai;

CREATE TABLE IF NOT EXISTS chat_conversations (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  user_id    INT          NOT NULL,
  title      VARCHAR(255) DEFAULT 'New Chat',
  created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Backfill: give every existing user with chat history a single
-- conversation row, so old messages aren't orphaned.
INSERT INTO chat_conversations (user_id, title)
SELECT DISTINCT user_id, 'Previous chat'
FROM chatbot_history
WHERE user_id NOT IN (SELECT user_id FROM chat_conversations);

ALTER TABLE chatbot_history
  ADD COLUMN conversation_id INT NULL AFTER user_id;

-- Point all existing rows at their user's backfilled conversation
UPDATE chatbot_history h
JOIN chat_conversations c ON c.user_id = h.user_id
SET h.conversation_id = c.id
WHERE h.conversation_id IS NULL;

ALTER TABLE chatbot_history
  MODIFY COLUMN conversation_id INT NOT NULL,
  ADD FOREIGN KEY (conversation_id) REFERENCES chat_conversations(id) ON DELETE CASCADE;
