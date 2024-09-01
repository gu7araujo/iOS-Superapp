build:
	xcodebuild \
	-workspace Superapp.xcworkspace \
	-scheme Superapp \
	-destination 'platform=iOS Simulator,name=iPhone 15 Pro Max,OS=17.4'

clean:
	git clean -dfX

install:
	pod install --repo-update

open:
	open Superapp.xcworkspace