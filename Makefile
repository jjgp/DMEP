.PHONY: infinite_scroll
infinite_scroll:
	pushd Server; npm start -- --authorization false; popd;

.PHONY: signin
signin:
	pushd Server; npm start; popd;

.PHONY: timeout
timeout:
	pushd Server; npm start -- --timeout 10000; popd;