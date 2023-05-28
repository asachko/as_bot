FROM --platform=${BUILDPLATFORM} quay.io/projectquay/golang:1.20 AS builder
ARG TARGETOS
ARG TARGETARCH

WORKDIR /go/src/app
COPY . .
RUN make get
RUN make test
RUN make build

FROM scratch AS binary
WORKDIR /
COPY --from=builder /go/src/app .
ENTRYPOINT [ "as_bot" ]