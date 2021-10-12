.PHONY: run-api
run-api: ## apiサーバーの起動
	go run ./cmd/api/main.go

.PHONY: run-gateway
run-gateway: ## gatewayプロキシサーバーの起動
	go run ./cmd/gateway/main.go

.PHONY: protoc
protoc: ## gRPCのstubコードの生成
	# protoc
	docker-compose run --rm --entrypoint sh protoc ./scripts/protoc.sh

	# gofmt,goimportsで整形
	gofmt -s -w pkg/domain/proto/
	gofmt -s -w protobuf/
	goimports -w -local "github.com/todo-server" pkg/domain/proto/

.PHONY: fmt
fmt: ## ファイルのフォーマット整形
	gofmt -s -w cmd/ pkg/
	goimports -w -local "github.com/todo-server" cmd/ pkg/

.PHONY: build-api
TAG := $(tag)
build-api: ## apiイメージのビルド & プッシュ
	docker build -f ./build/docker/api/Dockerfile -t mitsugu1128/todo-server-api:${TAG} .
	docker push mitsugu1128/todo-server-api:${TAG}

.PHONY: build-gateway
TAG := $(tag)
build-gateway: ## gatewayイメージのビルド & プッシュ
	docker build -f ./build/docker/gateway/Dockerfile -t mitsugu1128/todo-server-gateway:${TAG} .
	docker push mitsugu1128/todo-server-gateway:${TAG}