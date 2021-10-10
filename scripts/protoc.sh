#!/bin/sh

proto_file_dir=./protobuf
api_proto_files=$(find ${proto_file_dir}/api -type f -name '*.proto')
proto_out_dir=./pkg/domain/proto

# If the paths=source_relative flag is specified,
# the output file is placed in the same relative directory as the input file.
# For example, an input file protos/buzz.proto results in an output file at protos/buzz.pb.go.

protoc \
  -I=${proto_file_dir} \
  --go_out=paths=source_relative:${proto_out_dir} \
  --go-grpc_out=paths=source_relative,require_unimplemented_servers=false:${proto_out_dir} \
  --grpc-gateway_out=paths=source_relative,logtostderr=true:${proto_out_dir} \
  ${api_proto_files};