# STACK — loopsmith-hello (living reference)

**This file is the authoritative pin record for the paved path.** Every new code project under `C:\2026_agentic_projects\` starts from a clone of this project at the versions pinned below. When these pins change, `CHANGELOG.md` records why; when the round-trip passes, `Last verified` moves forward. See `C:\Users\Paddo\OneDrive\Desktop\k2s\paved\REGISTRY.md` for the estate view and `C:\Users\Paddo\OneDrive\Desktop\k2s\paved\rituals\verify-hello-world.md` for the quarterly verification ritual.

## Pins

- **Next.js** — 16.2.4 (App Router, Turbopack default in dev)
- **React** — 19.2.4
- **React DOM** — 19.2.4
- **TypeScript** — ^5
- **Tailwind CSS** — ^4 (CSS-first config via `@theme` in `app/globals.css`)
- **@tailwindcss/postcss** — ^4
- **@supabase/supabase-js** — ^2.104.0
- **Node** — 20.x or later (Next 16 requires Node 20+)

## Opt-in (not pinned — adopt only when a project needs them)

- Server-side Supabase client (`@supabase/ssr`)
- Supabase auth (email/OAuth flows)
- Supabase realtime subscriptions
- Edge functions / server components reading secrets
- ESLint flat config + `eslint-config-next`

When a downstream project adopts any of these, note it in THAT project's own `STACK.md` as deliberate variation — not in this file.

## Design decisions baked into the scaffold

- **`src/app/` layout** (not flat `app/`). All page code, layouts, and route handlers live under `src/`. Import alias `@/` points to `src/`.
- **`src/lib/supabase.ts`** — singleton browser client created from `NEXT_PUBLIC_SUPABASE_URL` + `NEXT_PUBLIC_SUPABASE_ANON_KEY`. No server client by default; add if needed.
- **Supabase table: `notes`** — `id uuid pk`, `body text not null`, `created_at timestamptz default now()`. Schema lives in `supabase/migrations/001_notes.sql` so downstream clones can recreate it. CRUD round-trip against this table IS the verification target.
- **`next/font` not wired** — kept neutral; downstream projects add their own typography.
- **`.env.local` gitignored; `.env.example` committed** with the Supabase key names (no values). Downstream clones fill in their own project's URL + anon key.

## Current Supabase project

- **Project ref:** `memjaibupcvurxperjzn`
- **URL:** https://memjaibupcvurxperjzn.supabase.co
- **Tier / region:** Pro (Micro) / West US (Oregon) — us-west-2

## Last verified

- **2026-04-21** — Region-migration wiring verified on localhost:3000. `.env.local` updated, CLI linked, `001_notes.sql` pushed, RLS confirmed enabled on `notes`. Dev server boots cleanly against new project; `GET /` → 200. (Prior CRUD round-trip was verified 2026-04-20 against old project `hfpityhncpapaeypqfco.supabase.co`, since deleted.)

## Next scheduled verification

**2026-07-21** (quarterly cadence per `paved/rituals/verify-hello-world.md`). Ad-hoc verification allowed — and encouraged — when a major upstream release lands (Next major, Supabase breaking change, React major).

## Deliberate drift from any downstream project

If a project deviates from these pins or strips a baked-in decision (e.g., idigdata strips Supabase for a static-export marketing site), document it in the project's own `STACK.md` under "Deliberate drift from hello-world." Undocumented drift = mystery drift = broken pull-not-push.

## Migration notes

**2026-04-21 — baselined as living reference.** Prior to this date, hello-world existed as a functional scaffold but lacked `STACK.md` / `CHANGELOG.md` / `.env.example` / migration / living-reference README. Paper-trail discipline added to support the `paved/rituals/new-code-project.md` clone workflow.

**2026-04-21 — region migration.** New Supabase project in us-west-2 Micro (replaces prior us-east-1 Nano instance, ref `hfpityhncpapaeypqfco`). `.env.local` repointed to `memjaibupcvurxperjzn.supabase.co`; `001_notes.sql` re-applied via `supabase db push`. Part of the four-project region-migration closeout (see also pulse, boss, idigdata).
