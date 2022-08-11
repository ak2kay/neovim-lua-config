#!/bin/bash

if command -v live555MediaServer &>/dev/null; then
	echo "live555MediaServer is alreay installed"
	exit 0
fi

wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz
tar xvf live555-latest.tar.gz
cd live
./genMakefiles linux
make
sudo make install
rm -rf ../live
rm -rf ../live555-latest.tar.gz
