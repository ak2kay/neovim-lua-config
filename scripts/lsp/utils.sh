#!/bin/bash

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
		mkdir -p ${dir}
	fi
}

silencer() {
	bash -c "${1} &>/dev/null"
}
