#!/bin/bash
# Note: this config will delete your current neovim config && apply config in this repo

set -o errexit
set -o pipefail

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. ${base_dir}/lsp/utils.sh

default_xdg_config_path="${HOME}/.config/nvim"

if asksure; then
	echo "apply..."
	rm -rf "${HOME}/.local/share/nvim"
	rm -rf "${default_xdg_config_path}"
	rm -rf "${HOME}/.cache/nvim"

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

		echo "installing stow"
		if [[ ${machine} = "Linux" ]]; then
			silencer "sudo apt install stow"
		elif [[ ${machine} = "Mac" ]]; then
			silencer "brew install stow"
		else
			echo "Please install stow first"
		fi
		echo "stow installed"
	fi

	stow --restow --target="${default_xdg_config_path}" .
else
	echo "Exit..."
fi
