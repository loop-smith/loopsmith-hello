# CHANGELOG — loopsmith-hello

**Append-only history of stack changes in the living reference.** Each entry captures what moved, why, what downstream projects need to know when they pull, and when the round-trip was re-verified. Most recent on top.

The ritual at `paved/rituals/verify-hello-world.md` defines when to add an entry and what to include.

---

## 2026-04-21 — living-reference baseline

**Bumps:** none — this entry documents the baseline being properly laid down, not a version change.

**What changed:**

- `STACK.md` authored — pinned versions + opt-in list + baked-in design decisions + verification cadence.
- `CHANGELOG.md` authored (this file) — starts the append-only log.
- `.env.example` authored — commits the Supabase env var names (no values) so downstream clones see what needs wiring.
- `supabase/migrations/001_notes.sql` authored — the `notes` table schema is now in version control; downstream clones can `psql -f` it against a fresh Supabase project.
- `README.md` rewritten — replaced the `create-next-app` boilerplate with a living-reference doc (what this project is, how to clone, how to verify).
- `CLAUDE.md` Ports stanza extended with framework-dependent collision behavior (Next 16 hard-fails on `EADDRINUSE`; other frameworks silent-hop).

**Migration notes (for downstream projects):**

- Nothing to pull — this release is about paper-trail discipline, not code. Stack pins are unchanged from the prior working state.
- If you have a downstream project that cloned hello-world BEFORE this baseline (idigdata, pulse), you already have the code. Adopt the discipline separately: write your own project's `STACK.md` + document any deliberate drift.

**Verified end-to-end:** N/A — no functional change. Prior verification (2026-04-20 CRUD round-trip) still stands.

---

## 2026-04-20 — initial functional baseline

**Bumps:** initial scaffold at the pins below.

- next: 16.2.4
- react: 19.2.4
- @supabase/supabase-js: 2.104.0
- tailwindcss: 4.x
- typescript: 5.x

**Migration notes (for downstream projects):** this is the scaffold. Clone the whole project, strip what you don't need (e.g., Supabase for a static site), document the strip in your project's `STACK.md`.

**Verified end-to-end:** 2026-04-20 — CRUD round-trip against `hfpityhncpapaeypqfco.supabase.co`. Create a note, list, refresh, delete all worked; Supabase dashboard confirmed row-level state matched.
