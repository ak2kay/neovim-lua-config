#!/bin/bash
# Note: this config will delete your current neovim config && apply config in this repo

set -o errexit
set -o pipefail

default_xdg_config_path="${HOME}/.config/nvim"

asksure() {
	echo -n "this script will delete your current neovim config in ${XDG_CONFIG_HOME}(${default_xdg_config_path} if emtpy) and ${XDG_DATA_HOME}(${default_xdg_config_path} if empty). Are you sure (Y/N)? "
	while read -r -n 1 -s answer; do
		if [[ $answer = [YyNn] ]]; then
			[[ $answer = [Yy] ]] && retval=0
			[[ $answer = [Nn] ]] && retval=1
			break
		fi
	done

	echo # just a final linefeed, optics...

	return $retval
}

ensureTargetDir() {
	dir=${1}
	if [[ ! -d "${dir}" ]]; then
		mkdir -p "${dir}"
	fi
}
### using it
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

		if [[ ${machine} = "Linux" ]]; then
			sudo apt install stow
		elif [[ ${machine} = "Mac" ]]; then
			brew install stow
		else
			echo "Please install stow first"
		fi
	fi

	stow --restow --target="${default_xdg_config_path}" .
else
	echo "Exit..."
fi
