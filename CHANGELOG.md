# CHANGELOG — loopsmith-hello

**Append-only history of stack changes in the living reference.** Each entry captures what moved, why, what downstream projects need to know when they pull, and when the round-trip was re-verified. Most recent on top.

The ritual at `paved/rituals/verify-hello-world.md` defines when to add an entry and what to include.

---

## 2026-04-26 — Layer 1 toolchain hardening

**Bumps:** none on the existing Next/React/TS/Tailwind/Supabase pin block. New dev dependencies pinned canonical.

**What changed:**

- ESLint 9 flat config wired (`eslint.config.mjs`) — extends `js.configs.recommended`, `tseslint.configs.recommended`, `eslint-config-next` 16.2.4, `eslint-config-prettier`.
- Prettier 3 wired (`.prettierrc` + `.prettierignore`).
- Vitest 3 wired (`vitest.config.ts`, node environment) + smoke test at `src/lib/__tests__/sanity.test.ts`.
- Husky 9 wired (`.husky/pre-commit` runs lint-staged).
- lint-staged 15 wired (config inline in `package.json`).
- `package.json` scripts added: `lint`, `lint:fix`, `typecheck`, `test`, `test:watch`, `format`, `format:check`, `prepare`.
- `.gitignore` `.env*` rule paired with `!.env.example` allowlist exception (closes the silent-ignore hole; downstream `cp -R` clones inherit the corrected behavior).
- `001_notes.sql` RLS comments hardened — unmissable warning header at top of the policies block; commented-out tightening recipe appended at the bottom. Policy semantics unchanged (permissive; verify-hello-world ritual still passes).
- `STACK.md` "Layer 1 toolchain — pinned canonical" section added; baked-in design decisions extended.
- `src/app/page.tsx` cleaned up to satisfy React 19 lint rules — removed dead `setLoading(true)` (state was already true from `useState(true)` init); added an inline `eslint-disable-next-line react-hooks/set-state-in-effect` on the mount-time `loadNotes()` call inside `useEffect`. The proper React 19 idiom (Suspense + `use()` or server component) is a scaffold-level refactor outside this dispatch's scope.

**Migration notes (for downstream projects):**

When a downstream project (idigdata, pulse, idigdata-app, or any future Next clone) is ready to pull this in:

1. Copy the toolchain dev-dep block into your `package.json` `devDependencies` (or run the same `npm install --save-dev` command from this dispatch).
2. Copy `eslint.config.mjs`, `.prettierrc`, `.prettierignore`, `vitest.config.ts` from `loopsmith-hello` to your project root.
3. Add the new scripts to your `package.json` (matching the names in this changelog).
4. Run `npx husky init` to wire `.husky/pre-commit`, then replace its contents with `npx lint-staged`.
5. Add the `lint-staged` config block to your `package.json`.
6. Fix your own `.gitignore` `!.env.example` line if it has the same hole.
7. Run `npm run lint`, `npm run typecheck`, `npm run test` to verify; expect lint warnings on existing code (this is the _new_ template tier — pre-existing code may not be conformant; remediate as a separate pass).
8. Update your project's own `STACK.md` to record the toolchain adoption.

**Verified end-to-end:** 2026-04-26 (this dispatch). `npm install` clean; `npm run lint` passes; `npm run typecheck` passes; `npm run test` passes (1 test); `npm run build` clean; `npm run dev` boots on :3000 (200 OK); pre-commit hook fires on a no-op staged change (lint-staged's "Prevented an empty git commit" guard observed — confirms hook wiring; behavior is correct).

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
