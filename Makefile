build:
	docker-compose -f docker-compose.yml build

run:
	docker-compose -f docker-compose.yml up

bash:
	docker exec -it cgtrader-search bash

install:
	docker exec -it cgtrader-search bash -c "bundle install"

migrate:
	docker exec -it cgtrader-search bash -c "rails db:migrate"

console:
	docker exec -it cgtrader-search bash -c "rails console"

import_prompts:
	docker exec -it cgtrader-search bash -c "LOG_ELASTICSEARCH=false rake db:import_prompts"
