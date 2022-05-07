#!/bin/bash
# Note: this config will delete your current neovim config && apply config in this repo

set -o errexit
set -o nounset
set -o pipefail
set -x

default_xdg_config_path="${HOME}/.config/nvim"

ensureTargetDir() {
	dir=${1}
	if [[ ! -d "${dir}" ]]; then
		mkdir -p "${dir}"
	fi
}

rm -rf "${HOME}/.local/share/nvim"
rm -rf "${default_xdg_config_path}"

ensureTargetDir "${default_xdg_config_path}"

if ! command -v stow &>/dev/null; then
	machine_out="$(uname -s)"
	case "${machine_out}" in
	Linux*) machine=Linux ;;
	Darwin*) machine=Mac ;;
	CYGWIN*) machine=Cygwin ;;
	MINGW*) machine=MinGw ;;
	*) machine="UNKNOWN:${machine_out}" ;;
	esac
	echo "${machine}"

	if [[ ${machine} = "Linux" ]]; then
		sudo apt install stow
	elif [[ ${machine} = "Mac" ]]; then
		brew install stow
	else
		echo "Please install stow first"
	fi
fi

stow --restow --target="${default_xdg_config_path}" .
