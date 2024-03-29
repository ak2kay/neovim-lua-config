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

echo "installing neovim deps"
sudo apt update
sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen libsqlite3-dev sqlite3
echo "neovim deps are installed"

cd "${repo_path}" || exit
if [[ ! -d "neovim" ]]; then
	echo "clonig neovim"
	git clone https://github.com/neovim/neovim
	echo "neovim cloned"
fi
cd neovim
echo "updating neovim repo"
git checkout master
git pull && git pull --tags --force
echo "neovim repo updated"
git checkout stable
nvim_repo_version=$(git tag | tail -n 1)
if command -v nvim &>/dev/null; then
	nvim_current_version=$(nvim --version | head -n 1 | awk '{print $2}')
	if [ "${nvim_repo_version}" = "${nvim_current_version}" ]; then
		echo "You have latest version nvim installed"
		exit 0
	fi
fi

echo "building neovim"
make distclean
make CMAKE_BUILD_TYPE=Release
echo "neovim built"
echo "installing neovim"
sudo make install
echo "neovim ${nvim_repo_version} installed"
