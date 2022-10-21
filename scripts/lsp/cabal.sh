#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. "${base_dir}"/utils.sh

PATH=${HOME}/.cabal/bin:${PATH}

install() {
	machine_out="$(uname -s)"
	case "${machine_out}" in
	Linux*) machine=Linux ;;
	Darwin*) machine=Mac ;;
	CYGWIN*) machine=Cygwin ;;
	MINGW*) machine=MinGw ;;
	*) machine="UNKNOWN:${machine_out}" ;;
	esac
	echo "installing cabal on ${machine}"
	if [[ ${machine} = "Linux" ]]; then
		sudo apt update
		sudo apt install -y cabal-install
	fi
	if [[ ${machine} = "Mac" ]]; then
		brew install cabal-install
	fi
	echo "cabal installed"
}

install

echo "update cabal package list"
cabal update
echo "cabal package list update done"
echo "install shellcheck"
cabal install ShellCheck
