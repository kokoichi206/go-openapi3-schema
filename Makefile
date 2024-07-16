.DEFAULT_GOAL := help

.PHONY: help
help:	## https://postd.cc/auto-documented-makefile/
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

EXTERNAL_TOOLS := \
	golang.org/x/lint/golint@latest

.PHONY: bootstrap
bootstrap: ## Install external tools
	for t in $(EXTERNAL_TOOLS); do \
		echo "Installing $$t ..." ; \
		go install $$t ; \
	done

.PHONY: build
build:	## Build the project
	go build -o bin/main ./cmd/

.PHONY: test
test:	## Run tests
	go test -race -cover -shuffle=on ./... -v

.PHONY: lint
lint:	## Run linters
	golint ./...
