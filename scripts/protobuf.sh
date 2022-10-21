#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. "${base_dir}/lsp/utils.sh"

if command -v protoc &>/dev/null; then
	protoc_current_version=$(protoc --version | awk '{print $2}')
	if [ "${protoc_current_version}" = 3.21.1 ]; then
		echo "You have expected version of protobuf, reinstall? [Y/N]"
		if ! asksure; then
			exit 0
		fi
	fi
fi

download_link="https://github.com/protocolbuffers/protobuf/archive/refs/tags/v21.1.tar.gz"
download_name="proto.tar.gz"
echo "downloading protobuf"
curl -L ${download_link} -o ${download_name}
echo "protobuf v21.1 downloaded"
echo "untar protobuf"
tar -xvzf ${download_name}
echo "untar protobuf finished"
rm -rf ${download_name}
cd "protobuf-21.1"
echo "gen configure"
./autogen.sh
echo "configuring"
./configure
echo "building"
make
echo "installing"
sudo make install
echo "refresh ldconfig"
sudo ldconfig /usr/local/lib
rm -rf "protobuf-21.1"
