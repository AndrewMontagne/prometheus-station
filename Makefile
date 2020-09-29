INV=\033[7m
NC=\033[0m

SHELL := /bin/bash
.PHONY: all clean lint mapmerge-test mapmerge build run run-container

-include /byond/env.sh

all: clean lint mapmerge-test mapmerge build

clean:
	@echo -e '\n${INV} ###   CLEAN   ### ${NC}\n'
	@rm -fv *.dmb *.rsc *.int *.lk

lint:
	@echo -e '\n${INV} ###  LINTER   ### ${NC}\n'
	@DreamChecker

mapmerge-test:
	@echo -e '\n${INV} ### MAP MERGE ### ${NC}\n'
	@python3 ./mit/tools/mapmerge.py --test-only ./cc-by-sa-nc/maps/*.dmm

mapmerge:
	@echo -e '\n${INV} ### MAP MERGE ### ${NC}\n'
	@python3 ./mit/tools/mapmerge.py ./cc-by-sa-nc/maps/*.dmm

build:
	@echo -e '\n${INV} ###   BUILD   ### ${NC}\n'
	@mkdir -p /tmp/prometheus-station
	@rsync -ra --delete --exclude='/.*' --exclude='/data' ./* /tmp/prometheus-station
	@(cd /tmp/prometheus-station && DreamMaker prometheus.dme)
	@rsync -rai --delete /tmp/prometheus-station/* .

run:
	@echo -e '\n${INV} ###    RUN    ### ${NC}\n'
	@echo "Starting server... Connect at byond://localhost:5000"
	@DreamDaemon prometheus.dmb 5000 -safe -invisible
	@echo ""

run-container:
	@docker pull -q andrewmontagne/byond:latest && docker run --rm -it -p 5000:5000/tcp --mount type=bind,src=$(shell pwd -P),dst=/app andrewmontagne/byond:latest /bin/bash
