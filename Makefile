up:
	docker compose --profile latest up -d
down:
	docker compose --profile latest down
update:
	docker system prune -a && git pull && docker compose pull && NODE_ENV=dev docker compose --profile latest up -d --force-recreate
