-- 001_notes.sql
-- Creates the `notes` table used by the hello-world CRUD round-trip.
-- Downstream clones that keep Supabase wiring can `psql -f` this against
-- a fresh Supabase project to recreate the table.

create table if not exists public.notes (
  id uuid primary key default gen_random_uuid(),
  body text not null,
  created_at timestamptz not null default now()
);

-- RLS on; permissive policies for the hello-world anon-only flow.
-- Downstream projects should TIGHTEN these before production — add an
-- auth check, scope by user_id, etc. This policy is a learning scaffold,
-- not a production template.

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
