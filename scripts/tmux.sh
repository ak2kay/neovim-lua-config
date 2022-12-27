#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. "${base_dir}"/lsp/utils.sh

distro=$(cat /etc/*-release | grep DISTRIB_ID | awk -F "=" '{print $2}')
if [[ ${distro} != "Ubuntu" ]]; then
	echo "this script supports Ubuntu distro only"
	exit 0
fi

repo_path=${HOME}/github
ensureTargetDir "${repo_path}"

echo "installing tmux deps"
sudo apt update
sudo apt-get install -y libevent-dev libncurses5-dev bison byacc
echo "tmux deps are installed"

cd "${repo_path}" || exit
if [[ ! -d "tmux" ]]; then
	echo "clonig tmux"
	git clone https://github.com/tmux/tmux.git
	echo "tmux cloned"
fi
cd tmux
echo "updating tmux repo"
git checkout master
git pull && git pull --tags --force
echo "tmux repo updated"
git checkout $(git describe --abbrev=0 --tags)

echo "building tmux"
sh autogen.sh
./configure && make
sudo make install
echo "tmux $(git describe --abbrev=0 --tags) installed"
