# Stack: .NET Clean Architecture

> ECC configuration tuned for DDD, CQRS, EF Core, and microservices.

## CLAUDE.md

```markdown
# Project: [Name]

## Architecture
- Clean Architecture with DDD (Domain-Driven Design)
- CQRS with MediatR
- EF Core with PostgreSQL
- Result Pattern (no exceptions for control flow)

## Conventions
- Use `Result<T>` for all service method returns
- Domain events via MediatR notifications
- Value Objects for domain primitives (Email, Money, etc.)
- Entity IDs as strongly-typed wrappers
- Repository pattern with Unit of Work (EF Core DbContext)

## Code Style
- Nullable reference types enabled
- File-scoped namespaces
- Primary constructors where appropriate
- Async/await throughout (no .Result or .Wait())
- Constants in domain-specific static classes, NOT god files

## Testing
- xUnit + FluentAssertions + NSubstitute
- Integration tests use Testcontainers
- Test naming: `MethodName_StateUnderTest_ExpectedBehavior`

## Commands
- Build: `dotnet build`
- Test: `dotnet test --logger "console;verbosity=detailed"`
- Migrate: `dotnet ef migrations add [Name] -p src/Infrastructure -s src/Api`
- Docker: `docker compose up --build`
```

## Recommended ECC Agents

```
agents/
├── code-reviewer.md           # .NET-specific code review
├── architect.md               # Clean Architecture compliance
├── security-reviewer.md       # OWASP + .NET-specific checks
├── build-error-resolver.md    # NuGet, SDK, runtime errors
└── tdd-guide.md               # xUnit TDD workflow
```

## Recommended Skills

- `coding-standards/csharp` — C# conventions and patterns
- `backend-patterns/ef-core` — EF Core queries, migrations, configuration
- `backend-patterns/cqrs` — Command/Query separation with MediatR

## Recommended MCPs

Keep it lean. For a typical .NET project:

| MCP | Purpose | Enable? |
|-----|---------|---------|
| GitHub | PR management | Yes |
| PostgreSQL | Direct DB queries | If needed |
| Docker | Container management | If needed |
| Azure DevOps | CI/CD pipeline | If using Azure |

**Note:** Keep total MCPs under 10. Convert others to CLI-wrapping skills.

## Hooks

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [{ "type": "command", "command": "check-no-god-constants.sh" }]
      },
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": "block-force-push.sh" }]
      }
    ]
  }
}
```
