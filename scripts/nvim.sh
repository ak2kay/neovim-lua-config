#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -x

ensureTargetDir() {
  dir=${1}
  if [[ ! -d "${dir}" ]]; then
    mkdir -p ${dir}
  fi
}

distro=$(cat /etc/*-release | grep DISTRIB_ID | awk -F "=" '{print $2}')
if [[ ${distro} != "Ubuntu" ]]; then
   echo "this script supports Ubuntu distro only"
   exit 0
fi

repo_path="${HOME}/github"
ensureTargetDir repo_path

sudo apt update
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen libsqlite3-dev sqlite3

cd repo_path
if [[ ! -d "neovim" ]]; then
  git clone https://github.com/neovim/neovim
fi
cd neovim
git pull && git pull --tags
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
