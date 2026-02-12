dev-up:
	docker compose -f docker-compose.dev.yml up --build

# Generate sertifikat mkcert (trusted di browser). Wajib dijalankan sekali sebelum dev-up.
# Di Windows/Git Bash: script otomatis unduh mkcert ke .certs/ bila belum ada.
certs:
	@bash scripts/setup-certs.sh

dev-down:
	docker compose -f docker-compose.dev.yml down -v

dev-logs:
	docker compose -f docker-compose.dev.yml logs -f --tail=200

api-sh:
	docker compose -f docker-compose.dev.yml exec api sh

api-install:
	docker compose -f docker-compose.dev.yml exec api sh -lc "composer install"

api-migrate:
	docker compose -f docker-compose.dev.yml exec api sh -lc "php artisan migrate"

api-clear:
	docker compose -f docker-compose.dev.yml exec api sh -lc "php artisan optimize:clear"

app-bundle:
	docker compose -f docker-compose.dev.yml run --rm app sh -lc "npm run build:bundle"

