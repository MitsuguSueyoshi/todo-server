.PHONY: protoc
protoc: ## gRPCのstubコードの生成
	# protoc
	docker-compose run --rm --entrypoint sh protoc ./scripts/protoc.sh

	# gofmt,goimportsで整形
	gofmt -s -w pkg/domain/proto/
	gofmt -s -w protobuf/
	goimports -w -local "github.com/todo-server" pkg/domain/proto/

.PHONY: fmt
fmt:
	# gofmt,goimportsで整形
	gofmt -s -w cmd/ pkg/
	goimports -w -local "github.com/todo-server" cmd/ pkg/