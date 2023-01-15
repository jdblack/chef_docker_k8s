
# Derived from "M.Peter"
# https://gist.github.com/mpneuried/0594963ad38e68917ef189b4e6a269db

SHELL := bash

include Version

.PHONY: help tag-latest
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


run: build
	docker run -i -t --rm --env-file=~/.dyndns.conf $(APP_NAME)

build:
	docker build . -t $(APP_NAME)

tag: tag-latest tag-version ## Generate container tags 

release: build publish

tag-latest: 
	@$(foreach REPO, $(REGISTRIES), \
		echo Tagging $(APP_NAME) in $(REPO):latest ; \
		docker tag $(APP_NAME) $(REPO)/$(APP_NAME):latest ; \
	)

tag-version: ## Generate container `latest` tag
	@$(foreach REPO, $(REGISTRIES), \
		echo Tagging $(APP_NAME) in $(REPO):$(VERSION) ; \
		docker tag $(APP_NAME) $(REPO)/$(APP_NAME):$(VERSION) ; \
	)


publish: publish-latest publish-version ## Publish the `{version}` ans `latest` tagged containers to Registry

publish-latest: tag-latest ## Publish the `latest` taged container to Registry
	@$(foreach REPO, $(REGISTRIES), \
		echo Push $(APP) to $(REPO):latest ; \
		docker push $(REPO)/$(APP_NAME):latest ; \
	)

publish-version: tag-version ## Publish the `{version}` taged container to Registry
	@$(foreach REPO, $(REGISTRIES), \
		echo Push $(APP) to $(REPO):$(VERSION) ; \
		docker push $(REPO)/$(APP_NAME):$(VERSION) ; \
	)

version:
	@echo $(VERSION)

