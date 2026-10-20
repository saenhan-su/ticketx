.PHONY: run test compose-up compose-down migrate-up migrate-down

run:
	go run ./cmd/api

test:
	go test ./...

compose-up:
	docker compose up -d

compose-down:
	docker compose down

migrate-up:
	migrate -path migrations -database "$${DATABASE_URL}" up

migrate-down:
	migrate -path migrations -database "$${DATABASE_URL}" down 1
