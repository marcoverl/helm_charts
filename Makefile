RELEASE ?= stable
GH_PAGES ?= https://dodas-ts.github.io/helm_charts
COMMIT_MSG ?= "Doc update"

CURRENT_BRANCH = "master" 

.PHONY: build-helm-repo

all: build-helm-repo

help:
	@echo "Available commands:\n"
	@echo "- build-helm			: "

travis:
	./scripts/build_travis.sh

push-helm-repo:
	./scripts/build_charts.sh
