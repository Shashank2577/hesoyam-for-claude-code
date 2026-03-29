# Stack: Next.js Fullstack

> ECC configuration tuned for Next.js App Router, Tailwind, Prisma, and tRPC.

## CLAUDE.md

```markdown
# Project: [Name]

## Stack
- Next.js 15+ (App Router)
- TypeScript (strict mode)
- Tailwind CSS v4
- Prisma ORM with PostgreSQL
- tRPC for type-safe API
- NextAuth.js for authentication

## Conventions
- App Router with server components by default
- Client components only when interactivity is needed ('use client')
- Server Actions for mutations
- Zod schemas for all validation (shared between client and server)
- Prisma schema is the source of truth for DB types

## Code Style
- Functional components with hooks
- Named exports (no default exports except pages/layouts)
- Barrel exports via index.ts per feature folder
- Path aliases: @/ maps to src/

## File Structure
src/
├── app/           # Next.js App Router
├── components/    # Shared UI components
├── features/      # Feature modules (co-located logic)
├── lib/           # Utilities, configs, clients
├── server/        # tRPC routers, server-only logic
└── styles/        # Global styles

## Testing
- Vitest for unit tests
- Playwright for E2E
- MSW for API mocking

## Commands
- Dev: `pnpm dev`
- Build: `pnpm build`
- Test: `pnpm test`
- DB: `pnpm prisma migrate dev`
- Lint: `pnpm lint`
```

## Recommended ECC Agents

- `code-reviewer.md` — TypeScript + React patterns
- `architect.md` — App Router architecture decisions
- `e2e-runner.md` — Playwright test execution
- `security-reviewer.md` — XSS, CSRF, auth bypass checks

## Recommended Skills

- `frontend-patterns/react` — React patterns and hooks
- `frontend-patterns/nextjs` — App Router, Server Components, Server Actions
- `coding-standards/typescript` — TS strict mode conventions
