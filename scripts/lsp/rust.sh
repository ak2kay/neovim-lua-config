#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. ${base_dir}/utils.sh

if ! command -v rustup &>/dev/null; then
	echo "install rust"
	curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

source $HOME/.cargo/env

echo "add rust-src"
silencer "rustup component add rust-src"

if ! command -v stylua &>/dev/null; then
	echo "install stylua"
	silencer "cargo install stylua"
fi

if ! command -v selene &>/dev/null; then
	echo "install selene"
	silencer "cargo install selene"
fi
