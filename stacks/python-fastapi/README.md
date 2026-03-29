# Stack: Python FastAPI

> ECC configuration for FastAPI microservices with SQLAlchemy, Alembic, and async patterns.

## CLAUDE.md

```markdown
# Project: [Name]

## Stack
- Python 3.12+
- FastAPI with async endpoints
- SQLAlchemy 2.0 (async)
- Alembic for migrations
- Pydantic v2 for validation
- uv for package management

## Conventions
- Type hints on all function signatures
- Pydantic models for request/response schemas
- Repository pattern for database access
- Dependency injection via FastAPI Depends()
- Structured logging with structlog

## Project Structure
src/
├── api/           # Route handlers
│   ├── v1/        # API version 1
│   └── deps.py    # Shared dependencies
├── core/          # Config, security, exceptions
├── models/        # SQLAlchemy models
├── schemas/       # Pydantic schemas
├── services/      # Business logic
├── repositories/  # Database access
└── utils/         # Shared utilities

## Testing
- pytest with pytest-asyncio
- Factory Boy for test data
- httpx.AsyncClient for API tests
- Coverage target: 80%+

## Commands
- Dev: `uv run uvicorn src.main:app --reload`
- Test: `uv run pytest -v`
- Migrate: `uv run alembic upgrade head`
- New migration: `uv run alembic revision --autogenerate -m "[name]"`
- Lint: `uv run ruff check . && uv run ruff format --check .`
- Type check: `uv run mypy src/`
```

## Recommended Agents

- `python-reviewer.md` — Python code review with async patterns
- `security-reviewer.md` — SQL injection, auth bypass, SSRF
- `tdd-guide.md` — pytest-first development
- `build-error-resolver.md` — uv/pip dependency resolution

## Key Skills

- `coding-standards/python` — PEP 8, type hints, async patterns
- `backend-patterns/sqlalchemy` — Query optimization, relationship loading
- `backend-patterns/api-design` — REST conventions, pagination, error responses
