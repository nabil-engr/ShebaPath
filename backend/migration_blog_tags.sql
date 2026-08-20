-- Adds blog tags for databases created from the legacy schema.
-- Safe to re-run. Existing posts receive an empty tag list.

ALTER TABLE bd_blog_posts
  ADD COLUMN IF NOT EXISTS tags JSONB NOT NULL DEFAULT '[]'::jsonb;
