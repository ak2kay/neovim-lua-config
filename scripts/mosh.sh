#!/bin/bash

if command -v mosh &>/dev/null; then
	mosh_version=$(mosh -v | head -n 1| awk '{print $2}')
	if [[ "${mosh_version}" > "1.3.2" ]]; then
		echo "you have installed mosh latest enough(>=1.3.2), which supports vim true color, exiting now"
	fi
	exit 0
fi

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. "${base_dir}"/lsp/utils.sh

bash "${base_dir}"/protobuf.sh

echo "installing deps"
sudo apt install -y libssl-dev zlib1g-dev libncurses5-dev

repo_path=${HOME}/github
ensureTargetDir "${repo_path}"

cd "${repo_path}" || exit
if [[ ! -d "mosh" ]]; then
	echo "cloning mosh"
	git clone https://github.com/mobile-shell/mosh
	echo "mosh cloned"
fi
cd mosh || exit
echo "updating mosh repo"
git pull
echo "mosh repo updated"
echo "gen configure"
./autogen.sh
echo "configuring"
if [[ $1 -eq "global" ]]; then
	PKG_CONFIG_PATH=${HOME}/.local/lib/pkgconfig PROTOC=${HOME}/.local/bin/protoc ./configure
else
	PKG_CONFIG_PATH=${HOME}/.local/lib/pkgconfig PROTOC=${HOME}/.local/bin/protoc ./configure --prefix=${HOME}/.local
fi
echo "building"
make
echo "installing"
if [[ $1 -eq "global" ]]; then
	sudo make install
else
	make install
fi
