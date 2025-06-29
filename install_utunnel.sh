#!/bin/bash
set -e
SCRIPT_DIR="$(dirname "$0")"
cd "$SCRIPT_DIR"

if ! command -v go >/dev/null; then
    echo "Go compiler is required to build utunnel_manager" >&2
    exit 1
fi

echo "Building utunnel_manager from source..."
go build -o utunnel_manager ./cmd/utunnel_manager

echo "Starting utunnel_manager..."
./utunnel_manager "$@"
