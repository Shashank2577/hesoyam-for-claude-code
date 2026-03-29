# Stack: Ruby on Rails

> ECC configuration tuned for Rails 7.2+, Hotwire, PostgreSQL, and convention-over-configuration patterns.

## CLAUDE.md

```markdown
# Project: [Name]

## Stack
- Ruby 3.3+ / Rails 7.2+
- PostgreSQL with ActiveRecord
- Hotwire (Turbo + Stimulus)
- Tailwind CSS via tailwindcss-rails
- Sidekiq for background jobs
- RSpec for testing

## Conventions
- Follow Rails conventions. Don't fight the framework.
- Fat models, skinny controllers — but extract Service Objects when models exceed ~200 lines
- Concerns for shared model behavior (prefer composition over deep inheritance)
- Strong Parameters for all controller inputs
- Scopes for common queries (no raw SQL in controllers)
- I18n for all user-facing strings from day one

## Code Style
- Rubocop with rubocop-rails, rubocop-rspec, rubocop-performance
- 2-space indent, no trailing whitespace
- Single quotes unless interpolation needed
- Frozen string literals enabled globally
- Guard clauses over nested conditionals

## File Structure
app/
├── controllers/     # Thin controllers, REST-only
├── models/          # Domain logic lives here
├── services/        # Complex operations spanning multiple models
├── jobs/            # Sidekiq background jobs
├── mailers/         # ActionMailer classes
├── views/           # ERB templates (or ViewComponents)
├── components/      # ViewComponent classes (if used)
├── javascript/      # Stimulus controllers
└── assets/          # Tailwind entry point

## Testing
- RSpec with FactoryBot + Faker
- Shoulda Matchers for model validations
- Capybara + Playwright for system tests
- SimpleCov for coverage (target: 85%+)
- VCR or WebMock for external API mocking

## Commands
- Dev: `bin/rails server`
- Console: `bin/rails console`
- Test: `bundle exec rspec`
- Migrate: `bin/rails db:migrate`
- Routes: `bin/rails routes`
- Lint: `bundle exec rubocop`
- Generate: `bin/rails generate [type] [name]`
```

## Recommended ECC Agents

- `code-reviewer.md` — Ruby idioms, Rails patterns, N+1 query detection
- `security-reviewer.md` — SQL injection, mass assignment, CSRF, XSS via raw HTML
- `tdd-guide.md` — RSpec-first development, test pyramid adherence
- `build-error-resolver.md` — Bundler conflicts, gem native extension failures

## Recommended Skills

- `coding-standards/ruby` — Ruby idioms, Rubocop compliance
- `backend-patterns/rails` — ActiveRecord patterns, migration safety
- `backend-patterns/api-design` — REST resource design, JSON:API or jbuilder

## Recommended MCPs

| MCP | Purpose | Enable? |
|-----|---------|---------|
| GitHub | PR management | Yes |
| PostgreSQL | Direct DB queries during debug | If needed |
| Redis | Sidekiq queue inspection | If needed |

**Keep total MCPs under 10.** Rails has excellent CLI tooling (`rails console`, `rails routes`, `rails dbconsole`) — prefer skills that wrap these over MCP integrations.

## Hooks

```json
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "script": "block-force-push.sh"
    },
    {
      "matcher": "Write|Edit",
      "script": "warn-on-migration-change.sh"
    }
  ]
}
```

## Rails-Specific Gotchas

1. **Never edit existing migrations.** Always create a new migration. Claude sometimes tries to modify old migration files — block this with a hook.
2. **Use `bin/rails` not `rails`.** The binstub ensures the correct bundled version.
3. **Avoid N+1 queries.** Always use `.includes()` or `.preload()` for associations in index actions. The `bullet` gem catches these in development.
4. **Migration safety.** Use `strong_migrations` gem to catch unsafe migrations (adding columns with defaults on large tables, etc.).
