# loopsmith-hello

**Living reference project for the `C:\2026_agentic_projects\` code tree.** Every new code project starts from a clone of this one. When the Next.js / Supabase / Tailwind stack moves, it moves here first — downstream projects pull on their own schedule.

This is not a product. It's a CRUD scaffold whose job is to demonstrate that the current pinned stack actually works end-to-end against a real Supabase instance. Keep it minimal.

## What's in here

- **Next.js 16 App Router** scaffold under `src/app/`. Home page lists `notes`, adds notes via a form, deletes individual notes.
- **Supabase wiring** at `src/lib/supabase.ts` — a browser client created from `NEXT_PUBLIC_SUPABASE_URL` + `NEXT_PUBLIC_SUPABASE_ANON_KEY`.
- **`notes` table schema** at `supabase/migrations/001_notes.sql`. Apply it to any fresh Supabase project to run the scaffold.
- **Tailwind 4** CSS-first config (no `tailwind.config.ts`; styling conventions live in `src/app/globals.css`).
- **`STACK.md`** — authoritative pin record. Read this first when cloning.
- **`CHANGELOG.md`** — append-only log of stack moves and verification checkpoints.

## Getting started

First time in this project:

```bash
cp .env.example .env.local
# Open .env.local and fill in your Supabase project URL + anon key.

npm install
npm run dev
```

Open http://localhost:3000. You should see an empty notes list. Add a note; it should appear; refresh the page; it should persist; delete it; it should disappear. Open the Supabase Dashboard → Table Editor → `notes` and confirm the rows match.

**Round-trip passes = scaffold is healthy on your machine.**

## Ports

This project runs on **port 3000** — the template seed in the 3000 range. When you scaffold a new project from this one, pick the next free slot in `C:\2026_agentic_projects\PORTS.md` (current growth rule: +100 per project) and set the port explicitly in `package.json`:

```json
"dev": "next dev -p 3300"
```

See the `## Ports` section in `CLAUDE.md` for the full onboarding mechanics — they live in the template so downstream clones inherit them.

**Next 16 note:** Next.js 16+ hard-fails on `EADDRINUSE` (silent fallback was removed in v16). If port 3000 is held by a zombie, the dev server will not start. Fix: `netstat -ano | findstr :3000` then `taskkill //F //PID <pid>`.

## Cloning this project to start a new one

Follow `C:\Users\Paddo\OneDrive\Desktop\k2s\paved\rituals\new-code-project.md` — the ritual walks the end-to-end flow: name check, clone, port assignment, optional Supabase + GitHub + deploy gates, REGISTRY entry, smoke test.

## Upgrading the stack

Follow `C:\Users\Paddo\OneDrive\Desktop\k2s\paved\rituals\verify-hello-world.md`. Quarterly cadence or ad-hoc when a major upstream release lands. The ritual is non-optional — a stale living reference is worse than no reference at all, because downstream projects cargo-cult patterns that no longer reflect current truth.

## Non-goals for this project

- **Not a feature showcase.** No auth, no realtime, no server components, no edge functions. Those are opt-in for downstream projects, not in the scaffold.
- **Not a design system.** Typography is neutral; palette is neutral. Downstream projects bring their own.
- **Not production-hardened.** Supabase RLS policies here are permissive (anon can CRUD anything in `notes`). Downstream projects tighten them before going live.

## File map

```
loopsmith-hello/
├── .env.example               # Committed template; copy to .env.local and fill in
├── CHANGELOG.md               # Append-only stack-move history
├── CLAUDE.md                  # Agent-facing project rules (imports AGENTS.md)
├── AGENTS.md                  # Next.js-specific agent guardrail
├── README.md                  # This file
├── STACK.md                   # Authoritative pin record
├── package.json
├── next.config.ts
├── postcss.config.mjs
├── tsconfig.json
├── src/
│   ├── app/                   # App Router — layout, page, globals.css
│   └── lib/
│       └── supabase.ts        # Browser client singleton
├── supabase/
│   └── migrations/
│       └── 001_notes.sql      # `notes` table schema
└── public/                    # Static assets (favicon, etc.)
```
