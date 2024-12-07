.ONESHELL: # Source: https://stackoverflow.com/a/30590240
.SILENT: # https://stackoverflow.com/a/11015111

run-local:
	echo "\n-------------------------------------------------------------------------\n"
	echo "Go to http://localhost:8888/tree?token=25708b9f-4733-4d20-93a6-dac3359f5a9b"
	echo "\n-------------------------------------------------------------------------\n"
	if docker-compose ps --filter "status=running" | grep dmml-notebooks >/dev/null; then \
		echo "Container is already running."; \
	else \
		echo "Container is not running. Starting it now..."; \
		docker-compose down; \
		docker-compose up -d; \
	fi;

stop-local:
	docker-compose down

test: run-local
	echo "\n\n-------\nMypy checks\n-------"
	docker-compose exec notebooks mypy --install-types --non-interactive ./libs > /dev/null 2>&1  # hidden output
	docker-compose exec notebooks mypy --no-warn-incomplete-stub --disable-error-code import-untyped --explicit-package-bases ./libs

	echo "\n\n-------\nPycodestyle checks\n-------"
	docker-compose exec notebooks pycodestyle --max-line-length=200 ./libs
	
	echo "\n\n-------\nPytest checks\n-------"
	docker-compose exec notebooks python3 -m pytest ./tests
