package main

import (
    "log"
    "net"

	"google.golang.org/grpc"
)

const (
    port = ":50051"
)

func main() {
	// リッスン処理
	lis, err := net.Listen("tcp", port)
	if err != nil {
        log.Fatalf("failed to listen: %v", err)
    }

	// サーバー起動
	s := grpc.NewServer()
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}

