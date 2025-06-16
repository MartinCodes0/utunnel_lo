#!/bin/bash

# تعیین معماری سیستم
ARCH=$(uname -m)

# تعیین آدرس دانلود بر اساس معماری
case $ARCH in
    "x86_64")
        URL="https://github.com/aliamg1356/utunnel/releases/download/v1.0.0/utunnel_manager_amd64"
        ;;
    "aarch64" | "arm64")
        URL="https://github.com/aliamg1356/utunnel/releases/download/v1.0.0/utunnel_manager_arm64"
        ;;
    "i386" | "i686")
        URL="https://github.com/aliamg1356/utunnel/releases/download/v1.0.0/utunnel_manager_386"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# بررسی وجود فایل و سالم بودن
if [ -x ./utunnel_manager ]; then
    echo "utunnel_manager already exists and is executable. Skipping download."
else
    echo "Downloading utunnel_manager for $ARCH..."
    
    # بررسی اینکه wget یا curl نصب است
    if command -v wget > /dev/null; then
        wget -O utunnel_manager "$URL"
    elif command -v curl > /dev/null; then
        curl -L -o utunnel_manager "$URL"
    else
        echo "Error: Neither wget nor curl is installed."
        exit 1
    fi

    # بررسی موفقیت دانلود
    if [ ! -f "utunnel_manager" ]; then
        echo "Failed to download utunnel_manager"
        exit 1
    fi

    chmod +x utunnel_manager
fi

# اجرای فایل
echo "Starting utunnel_manager..."
./utunnel_manager
