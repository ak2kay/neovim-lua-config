#!/bin/bash

if command -v mosh &>/dev/null; then
	echo "you have installed mosh, exiting now"
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
./configure
echo "building"
make
echo "installing"
sudo make install
