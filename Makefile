APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=asachko
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETARCH=arm64
IMAGE_TAG=${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

format: 
	gofmt -s -w ./

test:
	go test -v

get:
	go get

build: format get
	@echo "Building for OS ${TARGETOS} and Architecture ${TARGETARCH}"
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o as_bot -ldflags "-X="github.com/asachko/asbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${IMAGE_TAG} --platform ${TARGETARCH}

push:
	docker push ${IMAGE_TAG}

clean:
	rm -rf as_bot
	docker rmi -f ${IMAGE_TAG}

linux: TARGETOS=linux
linux: TARGETARCH=amd64
linux: image

Windows: TARGETOS=windows
Windows: TARGETARCH=amd64
Windows: image

macOS: TARGETOS=darwin
macOS: TARGETARCH=arm64
macOS: image