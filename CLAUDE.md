@AGENTS.md

## Ports

**Registry:** `C:\2026_agentic_projects\PORTS.md` — canonical list of assigned local-dev ports across all active projects on this machine. Check it before starting any port-consuming process; register changes there.

**This project runs on port 3000** (`npm run dev`). `loopsmith-hello` is the template seed port in the 3000 range.

### Onboarding a new agentic app (template behavior — inherit in downstream projects)

When this template is used to scaffold a new project on this laptop:

1. **Pick the next free slot** in the 3000 range from `PORTS.md` (current growth rule: +100 per new project; next available published at the bottom of the registry).
2. **Set the port explicitly** in the scaffolded `package.json` (e.g., `"dev": "next dev -p 3300"`) — do not rely on framework default.
3. **Register the new project** in `PORTS.md` (add a row with port, project, script, stack, notes) **before the first `npm run dev`**.
4. **Replace this `## Ports` section** in the new project's `CLAUDE.md` with its own entry — keep the "Registry" pointer line; drop the template onboarding steps (they live here, in `loopsmith-hello`, which is the source of truth).

`boss` lives outside the 3000 range (at 5100) as a documented exception — see `PORTS.md`. Future exceptions follow the same pattern: carve out explicitly, document the rationale in `PORTS.md` Notes.

### Collision behavior — framework-dependent (read before starting any dev server)

Registry discipline (above) prevents *active-project* collisions. *Zombie* collisions — stale dev servers from prior sessions holding a port — are handled differently by different frameworks:

- **Next.js 16+** (idigdata, loopsmith-hello, any new Next project) — **hard-fails with `EADDRINUSE` regardless of config.** The silent-fallback behavior that existed in Next 15 was removed in v16. If the assigned port is held by a zombie, the dev server will not start. Fix: find the PID, kill it.

  ```
  netstat -ano | findstr :3100
  taskkill //F //PID <pid>
  ```

- **Vite / webpack-dev-server / CRA / Turbopack-via-non-Next** — default is silent fallback (framework picks the next free port). Do NOT set `strictPort: true` or equivalent; the fallback is the ergonomics. If a config sets strictPort anywhere, flag for removal.

Principle: don't configure hard-fail where the framework gives you a choice. Kill zombies where the framework chose hard-fail for you.
