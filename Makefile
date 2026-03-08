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

# Composer install (pakai Docker). Gunakan api-install bila container api sudah jalan, api-composer bila belum.
api-install:
	docker compose -f docker-compose.dev.yml exec api sh -lc "composer install"
api-composer:
	docker compose -f docker-compose.dev.yml run --rm api sh -lc "composer install"

api-migrate:
	docker compose -f docker-compose.dev.yml exec api sh -lc "php artisan migrate"

api-clear:
	docker compose -f docker-compose.dev.yml exec api sh -lc "php artisan optimize:clear"

# Hapus route cache (setelah ubah routes) agar rute baru (mis. upload-image) langsung dipakai
api-route-clear:
	docker compose -f docker-compose.dev.yml exec api sh -lc "php artisan route:clear"

app-bundle:
	docker compose -f docker-compose.dev.yml run --rm app sh -lc "npm run build:bundle"

# --- PODMAN COMMANDS ---
podman-dev-up:
	podman compose -f docker-compose.dev.yml up --build

podman-dev-down:
	podman compose -f docker-compose.dev.yml down -v

podman-dev-logs:
	podman compose -f docker-compose.dev.yml logs -f --tail=200

podman-api-sh:
	podman compose -f docker-compose.dev.yml exec api sh

podman-api-install:
	podman compose -f docker-compose.dev.yml exec api sh -lc "composer install"

podman-api-composer:
	podman compose -f docker-compose.dev.yml run --rm api sh -lc "composer install"

podman-api-migrate:
	podman compose -f docker-compose.dev.yml exec api sh -lc "php artisan migrate"

podman-api-clear:
	podman compose -f docker-compose.dev.yml exec api sh -lc "php artisan optimize:clear"

podman-api-route-clear:
	podman compose -f docker-compose.dev.yml exec api sh -lc "php artisan route:clear"

podman-app-bundle:
	podman compose -f docker-compose.dev.yml run --rm app sh -lc "npm run build:bundle"

# Mengizinkan Podman menggunakan port 80 dan 443 (Direkomendasikan)
sudo sysctl net.ipv4.ip_unprivileged_port_start=80

cd /mnt/c/infra-shineedu
export PODMAN_COMPOSE_PROVIDER=podman-compose