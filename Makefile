
test:
	go clean -testcache
	go test -v ./...

run:
	go run ./cmd/MODULE.go

.PHONY: build
build:
	rm -rf ./build/
	mkdir -p ./build/
	go build \
		-o ./build/MODULE \
		-gcflags -m=2 \
		./cmd/ 

# TODO: remove this.
init:
	bash ./init.sh

# TODO: remove this if you don't need it.
hub_update:
	@hub_ctrl ${HUB_MODE} ln "$(realpath ./build/MODULE)"

