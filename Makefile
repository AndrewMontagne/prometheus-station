INV=\033[7m
NC=\033[0m

.PHONY: all clean build run

all: clean mapmerge build run

clean:
	@echo -e '\n${INV} ###   CLEAN   ### ${NC}\n'
	@rm -fv *.dmb *.rsc *.int *.lk

mapmerge:
	@echo -e '\n${INV} ### MAP MERGE ### ${NC}\n'
	@python3 ./mit/tools/mapmerge.py ./cc-by-sa-nc/maps/*.dmm

build: mapmerge
	@echo -e '\n${INV} ###   BUILD   ### ${NC}\n'
	@dm.exe prometheus.dme

run:
	@echo -e '\n${INV} ###    RUN    ### ${NC}\n'
	@echo "Starting server..."
	@DreamDaemon.exe prometheus.dmb 3665 -safe &
	@sleep 1
	@echo "Connecting..."
	@DreamSeeker.exe byond://localhost:3665; true
	@echo "Shutting down server..."
	@taskkill.exe /IM "dreamdaemon.exe" /F > /dev/null
	@echo ""