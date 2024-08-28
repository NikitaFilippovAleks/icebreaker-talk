dev:
	docker compose -f docker-compose.yml -f docker-compose.override.development.yml up
dev_build:
	docker compose -f docker-compose.yml -f docker-compose.override.development.yml up --build
dev_build_watch:
	docker compose -f docker-compose.yml watch

rails new . --api --name=IcebreakerTalkBackend --database=postgresql --skip-docker --skip-test
