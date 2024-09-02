PRODUCT_NAME := Superapp
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
SIMULATOR_DESTINATION := 'platform=iOS Simulator,name=iPhone 15 Pro Max,OS=17.4'

build:
	xcodebuild \
	-workspace ${WORKSPACE_NAME} \
	-scheme ${PRODUCT_NAME} \
	-destination ${SIMULATOR_DESTINATION}

clean:
	git clean -dfX

install:
	pod install --repo-update

open:
	open ${WORKSPACE_NAME}

podfile:
	open Podfile

help:
	@echo "Usage: make [command]"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "[General]"
	@echo "help                  Displays this help."
	@echo "open                  Open Application."
	@echo "install               Install the dependences."
	@echo "clean                 Clean project."
	@echo "build                 Build the project."