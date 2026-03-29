# Stack: Java Spring Boot

> ECC configuration tuned for Spring Boot 3.3+, Spring Security, JPA/Hibernate, and hexagonal architecture.

## CLAUDE.md

```markdown
# Project: [Name]

## Stack
- Java 21+ (LTS)
- Spring Boot 3.3+
- Spring Security with OAuth2/JWT
- Spring Data JPA with Hibernate
- PostgreSQL
- Gradle (Kotlin DSL) or Maven
- Flyway for database migrations
- MapStruct for DTO mapping

## Architecture
- Hexagonal Architecture (Ports & Adapters)
- Domain layer has zero framework dependencies
- Application layer orchestrates use cases
- Infrastructure layer implements ports (DB, HTTP, messaging)

## Conventions
- Records for DTOs and Value Objects (Java 21+)
- Sealed interfaces for domain result types
- Constructor injection only (no field injection, no @Autowired on fields)
- Package-by-feature, not package-by-layer
- Interfaces for all ports (driven and driving)
- Custom exceptions extending a base `DomainException`

## Code Style
- Google Java Format (auto-formatted)
- No wildcard imports
- Final fields by default
- Optional<T> for return types, never for parameters
- Null-safety annotations (@NonNull, @Nullable) on public API boundaries

## Project Structure
src/main/java/com/example/project/
├── domain/                   # Pure domain logic (no Spring)
│   ├── model/                # Entities, Value Objects, Aggregates
│   ├── port/
│   │   ├── in/              # Driving ports (use case interfaces)
│   │   └── out/             # Driven ports (repository interfaces)
│   └── service/             # Domain services implementing use cases
├── application/              # Use case orchestration
│   ├── dto/                 # Request/Response DTOs (Records)
│   └── mapper/              # MapStruct mappers
├── infrastructure/           # Framework adapters
│   ├── web/                 # REST controllers
│   ├── persistence/         # JPA entities, repositories, adapters
│   ├── security/            # Spring Security config
│   └── config/              # Spring configuration classes
└── ProjectApplication.java

## Testing
- JUnit 5 + AssertJ + Mockito
- Testcontainers for integration tests
- @WebMvcTest for controller slice tests
- @DataJpaTest for repository slice tests
- ArchUnit for architecture rule enforcement
- Test naming: `should_[expected]_when_[condition]`

## Commands
- Build: `./gradlew build`
- Test: `./gradlew test`
- Run: `./gradlew bootRun`
- Lint: `./gradlew spotlessCheck`
- Format: `./gradlew spotlessApply`
- Docker: `docker compose up --build`
- Migrate: `./gradlew flywayMigrate`
```

## Recommended ECC Agents

```
agents/
├── code-reviewer.md           # Java/Spring-specific code review
├── architect.md               # Hexagonal architecture compliance
├── security-reviewer.md       # Spring Security, OWASP Java, SQL injection
├── build-error-resolver.md    # Gradle/Maven dependency hell, classpath issues
└── tdd-guide.md               # JUnit 5 TDD workflow
```

## Recommended Skills

- `coding-standards/java` — Java 21+ conventions, records, sealed types
- `backend-patterns/spring` — Spring Boot starters, auto-configuration, profiles
- `backend-patterns/jpa` — Hibernate N+1, fetch strategies, query optimization
- `backend-patterns/api-design` — REST conventions, OpenAPI/Swagger, error handling

## Recommended MCPs

| MCP | Purpose | Enable? |
|-----|---------|---------|
| GitHub | PR management | Yes |
| PostgreSQL | Direct DB queries | If needed |
| Docker | Container management | If needed |

**Keep total MCPs under 10.** Spring Boot Actuator and the Gradle/Maven CLI cover most operational needs. Prefer CLI-wrapping skills over MCP integrations.

## Hooks

```json
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [{ "type": "command", "command": "block-force-push.sh" }]
    },
    {
      "matcher": "Write|Edit",
      "hooks": [{ "type": "command", "command": "check-no-field-injection.sh" }]
    }
  ],
  "PostToolUse": [
    {
      "matcher": "Write|Edit",
      "hooks": [{ "type": "command", "command": "verify-architecture-rules.sh" }]
    }
  ]
}
```

## Spring Boot-Specific Gotchas

1. **Never use field injection.** Always constructor injection. Claude defaults to `@Autowired` on fields — the hook above catches this.
2. **Don't put domain logic in controllers.** Controllers call application services, which call domain services. No business logic in the web layer.
3. **Flyway migrations are immutable.** Never edit a migration that has been applied. Always create a new versioned migration.
4. **Lazy loading pitfalls.** Default JPA fetch type is LAZY for collections — use `@EntityGraph` or explicit fetch joins to avoid N+1 in production.
5. **Profile-specific configs.** Use `application-{profile}.yml` for environment overrides, not runtime conditionals in code.
6. **ArchUnit tests are not optional.** They enforce hexagonal boundaries at build time: domain must not import from infrastructure.
