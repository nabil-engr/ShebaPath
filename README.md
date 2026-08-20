# ShebaPath — Bangladesh Services Portal

Government-service guide website for Bangladesh (driving licence, passport,
NID, birth certificate, trade licence guides + a small blog + account system).

<h3>
    <a href="https://shebapath.vercel.app/bd-services/"
       target="_blank"
       rel="noopener noreferrer">
        Live Site
    </a>
</h3>

## Structure

- `frontend/` — Angular 20 app (standalone components, signals)
- `backend/`  — ASP.NET Core Web API (C#), Npgsql direct (no ORM), cookie-based
  auth (`bd_session`), BCrypt password hashing

## Backend

- Runs on port 8000 by default
- Connects directly to PostgreSQL via Npgsql (no EF Core)
- Tables used: `bd_users`, `bd_guides`, `bd_blog_posts` (all `bd_`-prefixed to
  avoid collisions if sharing a database with other projects)

## Frontend

- Angular CLI app (`ng serve` / `ng build`)
- Dev proxy: `/bd-services/api/*` → `http://localhost:8000` (see `proxy.conf.json`)
- Base href is hardcoded as `/bd-services/` in `src/index.html` — change this
  if you're not deploying under that sub-path
- Run dev server with: `ng serve --proxy-config proxy.conf.json`

## Production deployment

- The Angular frontend is configured for Vercel under `/bd-services/`.
- Vercel proxies `/bd-services/api/*` to the ASP.NET Core API on Render.
- The API reads Neon connection settings only from `PGHOST`, `PGPORT`,
  `PGUSER`, `PGPASSWORD`, and `PGDATABASE`; secrets must never be committed.
- `/bd-services/api/healthz` checks the API process. `/bd-services/api/readyz`
  additionally checks database connectivity.
- `backend/schema.sql` documents a fresh database. Never apply it or another
  SQL file to production without a Neon backup/restore point and review.

## Setup

1. Create a fresh PostgreSQL database from `backend/schema.sql`.
2. Set the five `PG*` environment variables listed above.
3. `cd backend && dotnet run`
4. `cd frontend && npm install && ng serve --proxy-config proxy.conf.json`
