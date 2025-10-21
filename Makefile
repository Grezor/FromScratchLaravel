SHELL=/bin/bash

CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)

# -- Start Docker
start:
	@docker compose up -d

stop:
	@docker compose down

restart: stop start
# -- End Docker

# -- Start Environment
build: stop
	@docker compose build --pull

build\:no-cache: stop
	@docker compose build --pull --no-cache

clear-cache:
	@echo "clear-cache start"
	@bin/artisan cache:clear
	@bin/artisan config:clear
	@bin/artisan route:clear
	@bin/artisan view:clear
	@bin/artisan event:clear
	@echo "✅ clear-cache terminée"

optimize-project:
	@echo "start"
	@bin/artisan config:cache
	@bin/artisan route:cache
	@bin/artisan view:cache
	@bin/artisan event:cache
	@bin/artisan optimize
	@bin/artisan queue:restart
	@echo "✅ terminée !"

restart-and-clear:
	@make clear-cache
	@make optimize-project


db: start
	@sleep 1s
	@bin/artisan db:wipe
	@bin/artisan migrate

db\:test: start
	@sleep 1s
	@bin/artisan db:wipe --env=test
	@bin/artisan migrate --env=test

install: start db rights
	@sleep 1s
	@bin/composer install
	@npm i

fixture: db
	@bin/artisan db:seed

rights: start
	@sudo chmod -R 777 storage
	@sudo chmod -R 777 bootstrap/cache
	@sudo chown -R ${CURRENT_UID}:${CURRENT_GID} ./

tinker:
	@bin/artisan tinker

queue-work:
	@bin/artisan queue:work

queue-failed:
	@bin/artisan queue:failed

queue-retry:
	@bin/artisan queue:retry all

migrate-fresh:
	@bin/artisan migrate:fresh --seed

storage-link:
	@bin/artisan storage:link

key-generate:
	@bin/artisan key:generate

new-controller-%:
	@php artisan make:controller $*


make-model:
	@bin/artisan make:model Example -m

make-seeder:
	@bin/artisan make:seeder ExampleSeeder

route-list:
	@bin/artisan route:list

event-list:
	@bin/artisan event:list

schedule-run:
	@bin/artisan schedule:run

schedule-list:
	@bin/artisan schedule:list

check-env:
	@bin/artisan env

# -- End Environment

# -- Start Frontend

npmdev:
	@npm run dev

npmbuild:
	@npm run build

# -- End Frontend

# -- Maintenance

composer-update:
	@composer update

composer-dump:
	@composer dump-autoload -o

log-clear:
	@truncate -s 0 storage/logs/laravel.log
	@echo "✅ log-clear terminée"

# -- End Maintenance