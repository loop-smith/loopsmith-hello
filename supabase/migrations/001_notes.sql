-- 001_notes.sql
-- Creates the `notes` table used by the hello-world CRUD round-trip.
-- Downstream clones that keep Supabase wiring can `psql -f` this against
-- a fresh Supabase project to recreate the table.

create table if not exists public.notes (
  id uuid primary key default gen_random_uuid(),
  body text not null,
  created_at timestamptz not null default now()
);

-- =====================================================================
-- WARNING — DOWNSTREAM CLONES MUST TIGHTEN BEFORE SHIP-BAND
-- =====================================================================
-- The policies below are PERMISSIVE (anon can read/insert/delete every
-- row). This is a learning scaffold for the verify-hello-world ritual's
-- unauthenticated CRUD round-trip. It is NOT a production template.
--
-- Before promoting a downstream project past Explore-band (Mockup/POC),
-- replace these policies with auth-gated equivalents — e.g.:
--
--   create policy "users see own notes"
--     on public.notes for select
--     to authenticated
--     using (auth.uid() = user_id);
--
-- See `loopsmith/STANDARDS.md` Layer 3 (Data & Auth) for the per-stage
-- bar; Ship-band template tier requires verified RLS via test suite.
--
-- A worked example of tighter policies is in `boss/supabase/migrations/`
-- (the 17-table schema migration with client_id-scoped RLS).
-- =====================================================================

alter table public.notes enable row level security;

create policy "notes are readable by anyone"
  on public.notes
  for select
  to anon, authenticated
  using (true);

create policy "notes are insertable by anyone"
  on public.notes
  for insert
  to anon, authenticated
  with check (true);

create policy "notes are deletable by anyone"
  on public.notes
  for delete
  to anon, authenticated
  using (true);

-- =====================================================================
-- TIGHTENING RECIPE (commented out — uncomment + adapt for your project)
-- =====================================================================
-- Add a user_id column to notes:
--
--   alter table public.notes
--     add column user_id uuid references auth.users(id) on delete cascade;
--
-- Replace the permissive policies with auth-scoped versions:
--
--   drop policy "notes are readable by anyone" on public.notes;
--   drop policy "notes are insertable by anyone" on public.notes;
--   drop policy "notes are deletable by anyone" on public.notes;
--
--   create policy "users read own notes"
--     on public.notes for select
--     to authenticated
--     using (auth.uid() = user_id);
--
--   create policy "users insert own notes"
--     on public.notes for insert
--     to authenticated
--     with check (auth.uid() = user_id);
--
--   create policy "users delete own notes"
--     on public.notes for delete
--     to authenticated
--     using (auth.uid() = user_id);
-- =====================================================================
