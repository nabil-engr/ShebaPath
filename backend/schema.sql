-- ShebaPath PostgreSQL schema
-- Intended for a NEW database. Do not run unreviewed against production.
-- Production changes should be applied through a versioned, backed-up migration.

CREATE TABLE IF NOT EXISTS bd_users (
    id                     SERIAL PRIMARY KEY,
    email                  TEXT NOT NULL UNIQUE,
    password_hash          TEXT NOT NULL,
    full_name              TEXT NOT NULL,
    phone                  TEXT,
    is_admin               BOOLEAN NOT NULL DEFAULT FALSE,
    reset_token            TEXT,
    reset_token_expires_at TIMESTAMPTZ,
    created_at             TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS categories (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL UNIQUE,
    slug        TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS tags (
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS bd_guides (
    id               SERIAL PRIMARY KEY,
    slug             TEXT NOT NULL UNIQUE,
    category_id      INTEGER NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
    title            TEXT NOT NULL,
    summary          TEXT NOT NULL,
    steps            JSONB NOT NULL DEFAULT '[]'::jsonb,
    requirements     JSONB NOT NULL DEFAULT '[]'::jsonb,
    fees             TEXT,
    processing_time  TEXT,
    office           TEXT,
    featured_image   TEXT,
    keywords         TEXT,
    meta_description TEXT,
    is_featured      BOOLEAN NOT NULL DEFAULT FALSE,
    is_published     BOOLEAN NOT NULL DEFAULT TRUE,
    published_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    last_verified    DATE NOT NULL DEFAULT CURRENT_DATE,
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS bd_blog_posts (
    slug            TEXT PRIMARY KEY,
    title           TEXT NOT NULL,
    excerpt         TEXT NOT NULL,
    content         TEXT NOT NULL,
    cover_image_url TEXT,
    tags            JSONB NOT NULL DEFAULT '[]'::jsonb,
    published_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS guide_tags (
    guide_id INTEGER NOT NULL REFERENCES bd_guides(id) ON DELETE CASCADE,
    tag_id   INTEGER NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (guide_id, tag_id)
);

CREATE TABLE IF NOT EXISTS bd_bookmarks (
    user_id    INTEGER NOT NULL REFERENCES bd_users(id) ON DELETE CASCADE,
    guide_id   INTEGER NOT NULL REFERENCES bd_guides(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (user_id, guide_id)
);

CREATE TABLE IF NOT EXISTS hero_slides (
    id            SERIAL PRIMARY KEY,
    guide_id      INTEGER REFERENCES bd_guides(id) ON DELETE SET NULL,
    image_url     TEXT NOT NULL,
    title         TEXT NOT NULL,
    subtitle      TEXT,
    button_text   TEXT,
    button_link   TEXT,
    display_order INTEGER NOT NULL DEFAULT 0,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS ix_bd_guides_public_order
    ON bd_guides (is_published, is_featured DESC, title);
CREATE INDEX IF NOT EXISTS ix_bd_guides_category
    ON bd_guides (category_id);
CREATE INDEX IF NOT EXISTS ix_bd_blog_posts_published
    ON bd_blog_posts (published_at DESC);
CREATE INDEX IF NOT EXISTS ix_bd_bookmarks_user_created
    ON bd_bookmarks (user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS ix_hero_slides_active_order
    ON hero_slides (is_active, display_order);
CREATE INDEX IF NOT EXISTS ix_bd_users_reset_token
    ON bd_users (reset_token) WHERE reset_token IS NOT NULL;
