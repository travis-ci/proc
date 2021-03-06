GOOS := $(shell go env GOOS)
GOARCH := $(shell go env GOARCH)
SOURCES := $(shell git ls-files '*.go')
TARGETS := \
	build/$(GOOS)/$(GOARCH)/travis-job

.PHONY: all
all: build test
	
.PHONY: build
build: $(TARGETS)

build/$(GOOS)/$(GOARCH)/travis-job: $(SOURCES)
	go build -o $@ ./cmd/travis-job/...

.PHONY: clean
clean:
	$(RM) -r ./build ./tmp/travis-job-*

.PHONY: test
test:
	go test -v ./...

example-payload.json: tmp $(SOURCES)
	jq -M . $@ >tmp/$(notdir $@) && mv -v tmp/$(notdir $@) $@

tmp:
	mkdir -p $@
