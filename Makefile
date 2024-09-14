DB_HOST?=localhost
DB_NAME?=etu
DB_USER?=postgres
DB_PASSWORD?=password
DB_PORT?=5432

DOWN_LIMIT?=1

up:
	@DB_HOST=${DB_HOST} \
	DB_NAME=${DB_NAME} \
	DB_USER=${DB_USER} \
	DB_PORT=${DB_PORT} \
	DB_PASSWORD=${DB_PASSWORD} \
		sql-migrate up -env=main

down:
	@DB_HOST=${DB_HOST} \
	DB_NAME=${DB_NAME} \
	DB_USER=${DB_USER} \
	DB_PORT=${DB_PORT} \
	DB_PASSWORD=${DB_PASSWORD} \
		sql-migrate down -env=main -limit=${DOWN_LIMIT}

status:
	@DB_HOST=${DB_HOST} \
	DB_NAME=${DB_NAME} \
	DB_USER=${DB_USER} \
	DB_PORT=${DB_PORT} \
	DB_PASSWORD=${DB_PASSWORD} \
		sql-migrate status -env=main
