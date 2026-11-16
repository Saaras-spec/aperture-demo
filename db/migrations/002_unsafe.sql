-- Unsafe migration: violates MG001 and MG005
-- This migration will be flagged and blocked by Aperture in PR CI!

-- MG005: CREATE INDEX without CONCURRENTLY takes a ShareLock and blocks writes
CREATE INDEX idx_users_active ON users(active);

-- MG001: DROP COLUMN causes immediate, irreversible data loss
ALTER TABLE users DROP COLUMN email;
