                   #<REMOVE>
init:              #<REMOVE>
	bash ./init.sh   #<REMOVE>

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

install:
	ln "$(realpath ./build/MODULE)" -s ~/.local/bin/MODULE

hub_update:
	@hub_ctrl ${HUB_MODE} ln "$(realpath ./build/MODULE)"

