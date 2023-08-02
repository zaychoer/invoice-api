# Invoice API

## Description

Invoice REST API

## Prerequisites

- Docker desktop
- Ruby: 3.2.2
- Rails: 7.0.6
- MYSQL: 8 (Optional)

## Features

- [x] Database MYSQL
- [x] Sign in and sign up via email.
- [x] Docker containers for Ruby on Rails development in Visual Studio Code. ([References](https://dev.to/konyu/how-to-use-docker-containers-for-ruby-on-rails-development-in-visual-studio-code-23np)).
- [x] Rspec. ([Refrences](https://rspec.info/))
- [x] Solargraph. ([References](https://solargraph.org/))
- [x] Rubocop. ([References](https://rubocop.org/))
- [x] Swagger (Need Improvement). ([References](https://github.com/rswag/rswag))

## Quick run

```bash
git clone https://github.com/zaychoer/invoice-api.git
cd invoices-api
cp env-example .env
docker compose up -d
docker compose run --rm web bundle install
docker compose run --rm web bin/rails db:create
docker compose run --rm web bin/rails db:migrate
```

### Generate `devise_jwt_secret_key` before running `docker compose up -d`

```bash
rake secret -> generate key

EDITOR="code --wait" rails credentials:edit -> to open credential.yaml.enc file
```

Place your generate key inside credentials.yaml.enc like this

```bash
devise_jwt_secret_key: generate key
```

For check status run

```bash
docker compose logs
```

### Commands

If you set up Docker Compose to start Rails at startup, it is convenient to compare the commands to Rails from outside the container and the commands to Rails from inside the container, as shown in the table below.

| Commands to Rails from outside the container                   | Commands to Rails from inside the container |
| -------------------------------------------------------------- | ------------------------------------------- |
| docker compose run --rm web bundle install                     | bundle install                              |
| docker compose run --rm web bin/rails db:migrate               | bin/rails db:migrate                        |
| docker compose exec web bin/rails c                            | bin/rails c                                 |
| docker compose exec web bundle exec rspec                      | bundle exec rspec                           |
| docker compose run -e EDITOR=vi web bin/rails credentials:edit | bin/rails credentials:edit                  |

## Comfortable development

```bash
git clone https://github.com/zaychoer/invoice-api.git
cd invoices-api
cp env-example .env
bundle install
rails db:create
rails db:migrate
```

### Generate `devise_jwt_secret_key` before running `bundle install`

```bash
rake secret -> generate key

EDITOR="code --wait" rails credentials:edit -> to open credential.yaml.enc file
```

Place your generate key inside credentials.yaml.enc like this

```bash
devise_jwt_secret_key: generate key
```

- Change `DB_USER=your-own-user`
- Change `DB_HOST=your-own-db-host`
- Change `DB_PASSWORD=your-own-db-password`

Run additional container:

```bash
docker compose up -d db adminer
```

## Links

- Swagger: http://localhost:3000/api-docs
- Adminer (client for DB): http://localhost:9090/

```bash
Auth for Adminer
System : MySQL
Server : db
User : root
Password : password
```

## Tests

```bash
bundle exec rspec
```

## Tests in Docker

```bash
docker compose exec web bundle exec rspec
```

## Tests with Postman

- Invoice Api Postman Collection ([Link](https://github.com/zaychoer/invoice-api/blob/main/Invoice%20API.postman_collection.json))

## References

- Rails 7: API-only app with Devise and JWT for authentication. ([Link](https://rspec.info/))
- How to use Docker containers for Ruby on Rails development in Visual Studio Code. ([Link](https://dev.to/konyu/how-to-use-docker-containers-for-ruby-on-rails-development-in-visual-studio-code-23np))
