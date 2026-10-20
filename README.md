# TicketX

TicketX is a high-concurrency concert ticketing platform. Phase 1 establishes authentication and user management as a Go modular monolith.

## Stack

- Go
- PostgreSQL for users and primary data
- Redis for sessions, refresh-token state, and rate limiting
- Firebase Phone Authentication for web-based SMS verification
- Google OAuth 2.0
- Docker Compose, Make, and golang-migrate

## Architecture

Code is organized by feature under `internal/`. HTTP handlers depend on feature services, which use repositories and provider interfaces. Shared infrastructure lives under `pkg/`.

Firebase Phone Auth is performed in the Web App using the Firebase Web SDK and reCAPTCHA. The API must verify the resulting Firebase ID token with Firebase Admin SDK before trusting the phone number. Local development should use Firebase's configured test phone numbers; do not send real SMS from local environments by default.

Google sign-in uses an authorization-code flow. The backend validates the OAuth response and then issues TicketX access and refresh tokens. Refresh tokens are rotated and tracked in Redis.

## Local development

Requirements: Go, Docker Compose, Make, and golang-migrate.

1. Copy `.env.example` to `.env` and adjust local values if needed.
2. Start dependencies: `make compose-up`
3. Apply migrations: `make migrate-up`
4. Run the API: `make run`
5. Run tests: `make test`

The initial API only provides a health endpoint. Authentication endpoints and integrations are planned as GitHub Issues.

## Configuration

The API reads configuration from environment variables. See `.env.example`. Never commit real credentials, Firebase service-account keys, OAuth secrets, or production database credentials.

## Migrations

Migrations are stored in `migrations/` and managed with golang-migrate. Use `make migrate-up` and `make migrate-down`.

## Testing

Run unit tests with `make test`. Integration tests will use local PostgreSQL and Redis and should not call Google or Firebase services.
