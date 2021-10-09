# == build go binary ==
FROM golang:1.16.5-alpine as go-builder

WORKDIR /go/src/github.com/todo-server

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY cmd cmd
COPY pkg pkg

RUN go build -o gateway cmd/gateway/main.go

# == build docker image ==
FROM alpine

RUN apk add --no-cache ca-certificates tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata

COPY --from=go-builder /go/src/github.com/todo-server/gateway /gateway

ENTRYPOINT ["/gateway"]