#!/bin/sh

proto_file_dir=./protobuf
api_proto_files=$(find ${proto_file_dir}/api -type f -name '*.proto')
api_out_dir=./pkg/domain/proto/api

# If the paths=source_relative flag is specified,
# the output file is placed in the same relative directory as the input file.
# For example, an input file protos/buzz.proto results in an output file at protos/buzz.pb.go.

protoc \
  -I=${proto_file_dir} \
  --go_out=:${api_out_dir} \
  --go-grpc_out=require_unimplemented_servers=false:${api_out_dir} \
  --grpc-gateway_out=logtostderr=true:${api_out_dir} \
  ${api_proto_files};