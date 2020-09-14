FROM docker.io/library/golang:1.15.2 as builder
LABEL maintainer="maintainer@cilium.io"
ADD . /go/src/github.com/cilium/clustermesh-apiserver
WORKDIR /go/src/github.com/cilium/clustermesh-apiserver
RUN CGO_ENABLED=0 GOOS=linux go build

FROM docker.io/library/alpine:3.12.0 as certs
RUN apk --update add ca-certificates

FROM scratch
LABEL maintainer="maintainer@cilium.io"
COPY --from=builder /go/src/github.com/cilium/clustermesh-apiserver/clustermesh-apiserver /usr/bin/clustermesh-apiserver
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
WORKDIR /
CMD ["/usr/bin/clustermesh-apiserver"]
