package main

import (
	"flag"
	"io"
	"log"
	"net"
)

func handleConnection(src net.Conn, target string) {
	dst, err := net.Dial("tcp", target)
	if err != nil {
		log.Printf("failed to connect to target %s: %v", target, err)
		src.Close()
		return
	}
	defer dst.Close()
	go io.Copy(dst, src)
	io.Copy(src, dst)
}

func main() {
	listen := flag.String("listen", "0.0.0.0:9000", "local address to listen on")
	target := flag.String("target", "", "target address host:port")
	flag.Parse()
	if *target == "" {
		log.Fatal("target address required")
	}
	ln, err := net.Listen("tcp", *listen)
	if err != nil {
		log.Fatalf("failed to listen on %s: %v", *listen, err)
	}
	log.Printf("listening on %s, forwarding to %s", *listen, *target)
	for {
		conn, err := ln.Accept()
		if err != nil {
			log.Printf("accept error: %v", err)
			continue
		}
		go handleConnection(conn, *target)
	}
}
