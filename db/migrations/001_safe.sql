-- Safe migration: creating initial table and indexes safely
SET lock_timeout = '2s';

CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    email TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Creating index concurrently is non-blocking for concurrent writes
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_users_email ON users(email);

-- Adding a column with a default value does not rewrite table in Postgres 11+
ALTER TABLE users ADD COLUMN active BOOLEAN DEFAULT TRUE NOT NULL;
