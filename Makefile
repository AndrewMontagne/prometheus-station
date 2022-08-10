INV=\033[7m
NC=\033[0m

SHELL := /bin/bash
.PHONY: *

-include /byond/env.sh

help: ## Shows this help prompt
	@echo "Usage: make target1 [target2] ..."
	@echo ""
	@echo "Target                          Description"
	@echo "================================================================================"
	@awk -F ':|##' '/^[^\t].+?:.*?##/ {printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF }' $(MAKEFILE_LIST)

dev: build ## Builds and runs
	@bash -c "make run"

debug: build ## Builds and runs, with debugging enabled
	@bash -c "AUXTOOLS_DEBUG=TRUE make run"

build: lint mapmerge docs compile ## Runs all the build stages

clean: ## Removes any intermediate files
	@echo -e '\n${INV} ###   CLEAN   ### ${NC}\n'
	@rm -fv *.dmb *.rsc *.int *.lk
	@rm -rfv /tmp/prometheus-station

lint: ## Runs linting checks on the codebase
	@echo -e '\n${INV} ###  LINTER   ### ${NC}\n'
	@DreamChecker -c dreamchecker.toml

docs: ## Generates documentation
	@echo -e '\n${INV} ###  DM DOCS  ### ${NC}\n'
	@rm -rf ./dmdoc/*
	@dmdoc

mapmerge-test:
	@echo -e '\n${INV} ### MAP MERGE ### ${NC}\n'
	@python3 ./mit/tools/mapmerge.py --test-only ./closed-source/maps/*.dmm

mapmerge: ## Merges any maps
	@echo -e '\n${INV} ### MAP MERGE ### ${NC}\n'
	@python3 ./mit/tools/mapmerge.py ./closed-source/maps/*.dmm

compile: ## Compiles the project proper
	@echo -e '\n${INV} ###   BUILD   ### ${NC}\n'
	@mkdir -p /tmp/prometheus-station
	@rsync -ra --delete --exclude='/.*' --exclude='/data' ./* /tmp/prometheus-station
	@(cd /tmp/prometheus-station && mv prometheus.dme prometheus.dme.old)
	@(cd /tmp/prometheus-station && python3 mit/tools/env.py > prometheus.dme)
	@(cd /tmp/prometheus-station && cat prometheus.dme.old >> prometheus.dme)
	@(cd /tmp/prometheus-station && DreamMaker -clean prometheus.dme)
	@(cd /tmp/prometheus-station && cp prometheus.dme.old prometheus.dme && rm prometheus.dme.old)
	@rsync -rai --delete /tmp/prometheus-station/* .

run: ## Runs the project
	@echo -e '\n${INV} ###    RUN    ### ${NC}\n'
	@echo "Starting server... Connect at byond://localhost:5000"
	@DreamDaemon prometheus.dmb 5000 -once -trusted -invisible -quiet -threads on
	@echo ""
