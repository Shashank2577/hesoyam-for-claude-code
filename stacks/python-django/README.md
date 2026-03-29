# Stack: Python Django

> ECC configuration tuned for Django 5+, DRF, Celery, and PostgreSQL with opinionated project structure.

## CLAUDE.md

```markdown
# Project: [Name]

## Stack
- Python 3.12+
- Django 5+
- Django REST Framework (DRF) for APIs
- PostgreSQL with Django ORM
- Celery + Redis for async tasks
- uv for package management

## Conventions
- Apps are features, not layers. Each Django app owns its models, views, serializers, and tests.
- Class-Based Views (CBVs) for CRUD, function-based for custom logic
- DRF Serializers for all API input/output validation
- Django signals sparingly — prefer explicit service calls
- Settings split: base.py, local.py, production.py, test.py
- Environment variables via django-environ (never hardcode secrets)

## Code Style
- Ruff for linting and formatting (replaces black, isort, flake8)
- Type hints on all public function signatures
- Docstrings on all public classes and non-trivial functions
- Django naming: plural app names, singular model names

## Project Structure
config/
├── settings/
│   ├── base.py          # Shared settings
│   ├── local.py         # Development overrides
│   ├── production.py    # Production overrides
│   └── test.py          # Test overrides
├── urls.py              # Root URL configuration
├── celery.py            # Celery app configuration
└── wsgi.py

apps/
├── users/               # Custom user model + auth
│   ├── models.py
│   ├── serializers.py
│   ├── views.py
│   ├── urls.py
│   ├── admin.py
│   ├── tasks.py         # Celery tasks
│   ├── signals.py
│   └── tests/
│       ├── test_models.py
│       ├── test_views.py
│       └── factories.py
├── core/                # Shared utilities
│   ├── models.py        # Abstract base models (TimeStamped, etc.)
│   ├── permissions.py
│   └── pagination.py
└── [feature_app]/       # One app per domain feature

## Testing
- pytest-django with pytest-factoryboy
- Factory Boy for test data
- Coverage target: 85%+
- Separate test settings (SQLite or test DB)

## Commands
- Dev: `uv run python manage.py runserver`
- Test: `uv run pytest -v`
- Migrate: `uv run python manage.py migrate`
- New migration: `uv run python manage.py makemigrations [app]`
- Shell: `uv run python manage.py shell_plus` (django-extensions)
- Lint: `uv run ruff check . && uv run ruff format --check .`
- Type check: `uv run mypy .`
- Celery: `uv run celery -A config worker -l info`
```

## Recommended ECC Agents

- `code-reviewer.md` — Django patterns, ORM usage, DRF serializer review
- `security-reviewer.md` — OWASP Django-specific: ORM injection, CSRF, XSS, auth bypass
- `tdd-guide.md` — pytest-django workflow
- `build-error-resolver.md` — Migration conflicts, dependency resolution
- `architect.md` — App boundaries, service layer design

## Recommended Skills

- `coding-standards/python` — PEP 8, type hints, Ruff compliance
- `backend-patterns/django` — ORM optimization, queryset patterns, migration safety
- `backend-patterns/api-design` — DRF viewsets, pagination, filtering, versioning

## Recommended MCPs

| MCP | Purpose | Enable? |
|-----|---------|---------|
| GitHub | PR management | Yes |
| PostgreSQL | Direct DB queries during debug | If needed |
| Redis | Celery queue inspection | If needed |

**Keep total MCPs under 10.** Django's `manage.py` commands and `shell_plus` cover most needs via CLI skills.

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

## Django-Specific Gotchas

1. **Always use a custom User model from day one.** Switching later is extremely painful. Extend `AbstractUser` at minimum.
2. **Never edit existing migrations.** Create new ones. Squash when the count gets unwieldy.
3. **Use `select_related()` and `prefetch_related()`** for all queryset-heavy views. Django Debug Toolbar catches N+1 in development.
4. **Avoid fat views.** Extract business logic into service functions or model methods. Views should only handle HTTP concerns.
5. **Settings imports matter.** Always import from `django.conf import settings`, never directly from the settings module.
