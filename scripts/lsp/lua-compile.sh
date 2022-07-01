#!/bin/bash
# rember to put ${HOME}/.local/bin to path
set -o errexit
set -o nounset
set -o pipefail

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. ${base_dir}/utils.sh

base_dir="${HOME}/github"
if [ -d "${base_dir}" ]; then
	echo "${base_dir} existed"
else
	mkdir ${base_dir}
fi
target_dir="${HOME}/.local/bin"
if [ -d "${target_dir}" ]; then
	echo "${target_dir} existed"
else
	mkdir -p ${target_dir}
fi

dir="${base_dir}/lua-language-server"
if [ -d "${dir}" ]; then
	echo "cloned"
else
	echo "cloning lua-language-server"
	silencer "git clone https://github.com/sumneko/lua-language-server ${dir}"
	echo "lua-language-server cloned"
fi

cd ${dir}
echo "comping"
silencer "git submodule update --init --recursive"
silencer "git pull"
cd 3rd/luamake
silencer "./compile/install.sh"
cd ../..
silencer "./3rd/luamake/luamake rebuild"
echo "compiled"
target_file="${HOME}/.local/bin/lua-language-server"
if [ -L "${target_file}" ]; then
	rm --force --recursive ${target_file}
fi
echo "installing"
ln -s ${dir}/bin/lua-language-server ${HOME}/.local/bin
echo "installed"
