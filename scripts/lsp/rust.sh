#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if ! command -v rustup &>/dev/null; then
	echo "install rust"
	curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

source "$HOME/.cargo/env"

rustup component add rust-src

if ! command -v stylua &>/dev/null; then
	cargo install stylua
fi

if ! command -v selene &>/dev/null; then
	cargo install selene
fi
