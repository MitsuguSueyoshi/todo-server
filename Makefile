.PHONY: protoc
protoc: ## protobufコードの生成
	# protoc
	docker-compose run --rm --entrypoint sh protoc ./scripts/protoc.sh