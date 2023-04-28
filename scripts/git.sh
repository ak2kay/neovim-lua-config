#!/bin/bash

set -o errexit
set -o pipefail

echo "check linux distro, this script only support ubuntu for now"
distro=$(cat /etc/*-release | grep DISTRIB_ID | awk -F "=" '{print $2}')
if [[ ${distro} != "Ubuntu" ]]; then
	echo "this script supports Ubuntu distro only"
	exit 0
fi
echo "linux distro check pass"

if command -v git &>/dev/null; then
	git_version=$(git version | awk '{print $3}')
	if [[ "${git_version}" > "2.31.0" ]]; then
		echo "you have install ${git_version} git, which meets the need (>=2.31.0), exiting now"
		exit 0
	fi
fi

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. "${base_dir}"/lsp/utils.sh

echo "installing git deps"
sudo apt update
sudo apt install -y libz-dev libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext cmake gcc
echo "git deps are installed"

ensureTargetDir tmp
cd tmp

curl -o git.tar.gz https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.39.3.tar.gz

tar -zxf git.tar.gz

cd git-*

make -j $(($(nproc) / 2)) prefix=${HOME}/.local all
make prefix=${HOME}/.local install

cd ../..
rm -rf tmp
