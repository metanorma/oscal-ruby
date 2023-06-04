export SPEC ?= spec
SPEC_FILE = $(subst ../,, $(SPEC))
export RUBY_IMAGE ?= ruby:3.1.2-slim

.PHONY: up
up:
	docker-compose up

.PHONY: down
down:
	docker-compose down

.PHONY: test
test: rspec

.PHONY: ssh
ssh:
	docker-compose run lib bash

.PHONY: install
install:
	docker-compose run lib bin/setup

.PHONY: console
console:
	docker-compose run lib bin/console

.PHONY: rspec
rspec:
	docker-compose run lib bin/rspec ${SPEC_FILE}

.PHONY: rake
rake:
	docker-compose run lib bundle exec rake

.PHONY: lint
lint:
	docker-compose run lib bundle exec rubocop

.PHONY: setup
setup:
	docker-compose build --build-arg RUBY_IMAGE=${RUBY_IMAGE}
	docker-compose run lib bin/setup
