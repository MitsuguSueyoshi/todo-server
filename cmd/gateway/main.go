package main

import (
	"context"
	"flag"
	"log"
	"net/http"

	"github.com/grpc-ecosystem/grpc-gateway/runtime"
	"google.golang.org/grpc"

	pbapi "github.com/todo-server/pkg/domain/proto/api"
)

var (
	// gRPC-Gateway自体のエンドポイント
	gatewayAddr string
	// Call対象のgRPCサーバーエンドポイント
	serverAddr string
)

func init() {
	flag.StringVar(&gatewayAddr, "addr", ":8080", "(required) tcp host:port to connect")
	flag.StringVar(&serverAddr, "target", ":9090", "(required) target endpoint of handler")
	flag.Parse()
}

func main() {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	mux := runtime.NewServeMux()
	opts := []grpc.DialOption{grpc.WithInsecure()}

	// 各サーバーのエンドポイントの登録
	if err := pbapi.RegisterItemHandlerFromEndpoint(ctx, mux, serverAddr, opts); err != nil {
		log.Fatalf("failed to resister Item handler: %v", err)
	}

	// gRPC-gatewayのリバースプロキシの起動
	s := &http.Server{
		Addr:              gatewayAddr,
	}
	if err := s.ListenAndServe(); err != nil {
		log.Fatalf("failed to listen and serve: %v", err)
	}
}
