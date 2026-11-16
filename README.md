# Aperture Demo

This repository demonstrates the [Aperture GitHub Action](https://github.com/Saaras-spec/aperture) detecting risky PostgreSQL migrations in pull requests.

## How it works

1. The `main` branch contains a baseline safe migration (`db/migrations/001_safe.sql`).
2. A feature branch (`add-unsafe-migration`) introduces an unsafe migration (`db/migrations/002_unsafe.sql`) containing:
   - `MG005`: `CREATE INDEX` without `CONCURRENTLY` (blocks concurrent writes).
   - `MG001`: `DROP COLUMN` (causes irreversible data loss).
3. When a pull request is opened from `add-unsafe-migration` targeting `main`:
   - The Aperture GitHub Action automatically scans the changed migration files using `git diff origin/main...HEAD`.
   - Detects the violations and blocks the pull request (exiting with code `1`).
   - Automatically posts a sticky diagnostic comment on the PR detailing the locking risks and providing copy-pasteable safe zero-downtime alternatives.
