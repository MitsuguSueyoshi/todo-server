FROM golang:1.16.5
ARG PROTOBUF_VERSION=3.17.3

# はじめにインデックスファイルをダウンロード（更新）する必要がある(apt-get update)
# protocをインストールするためにunzipを用意
RUN apt-get update && apt-get install unzip

# protocのダウンロード
WORKDIR /tmp/protoc
RUN curl -L https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip -o protoc.zip && \
    unzip protoc.zip && \
    mv bin/* /usr/local/bin/ && \
    mv include/* /usr/local/include/

WORKDIR /usr/src/todo-server
COPY go.mod .
COPY go.sum .

# プラグインの導入
RUN go get google.golang.org/protobuf/cmd/protoc-gen-go && \
    go get google.golang.org/grpc/cmd/protoc-gen-go-grpc && \
    go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway

#ENTRYPOINT ["/usr/local/bin/protoc"]