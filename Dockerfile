ARG name=build

FROM quay.io/projectquay/golang:1.20 as builder
WORKDIR /
COPY . .
RUN make $name

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot"]
