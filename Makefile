build:
	xcodebuild \
	-workspace Superapp.xcworkspace \
	-scheme Superapp \
	-destination 'platform=iOS Simulator,name=iPhone 15 Pro 17.4,OS=17.4'

clean:
	git clean -dfX