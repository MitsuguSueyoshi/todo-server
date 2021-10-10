package main

import (
	"context"
	"flag"
	"log"
	"net"

	"google.golang.org/grpc"

	pbapi"github.com/todo-server/pkg/domain/proto/api"
)

var (
	// gRPCサーバーエンドポイント
	serverAddr string
)

func init() {
	flag.StringVar(&serverAddr, "serverAddr", ":9090", "(required) target endpoint of handler")
	flag.Parse()
}

type itemServer struct {}

func (s *itemServer) GetItem(ctx context.Context, req *pbapi.GetItemRequest) (*pbapi.GetItemResponse,error)  {
	itemName := "テスト"

	return &pbapi.GetItemResponse{ItemName: itemName},nil
}

func main() {
	// リッスン処理
	lis, err := net.Listen("tcp", serverAddr)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	// gRPCサーバー作成
	s := grpc.NewServer()

	// 各APIサーバーの登録
	pbapi.RegisterItemServer(s, &itemServer{})

	// 起動
	log.Println("gRPC server started to serve")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
	return
}
