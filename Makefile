dev-up:
	docker compose -f docker-compose.dev.yml up --build

# Generate sertifikat mkcert (trusted di browser). Wajib dijalankan sekali sebelum dev-up.
# Prasyarat: brew install mkcert
certs:
	@command -v mkcert >/dev/null 2>&1 || (echo "Instal mkcert dulu: brew install mkcert" && exit 1)
	mkdir -p .certs
	mkcert -install
	mkcert -cert-file .certs/cert.pem -key-file .certs/key.pem "*.shineeducationbali.test" "shineeducationbali.test"
	@echo "Sertifikat berhasil dibuat di .certs/"

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
	docker compose -f docker-compose.dev.yml exec app sh -lc "npm run build:bundle"

