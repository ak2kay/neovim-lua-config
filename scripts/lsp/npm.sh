#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

command_name=(pyright-langserver bash-language-server typescript-language-server tsc vscode-json-language-server eslint_d prettierd fixjson write-good)
npm_package_name=(pyright bash-language-server typescript-language-server typescript vscode-langservers-extracted eslint_d @fsouza/prettierd fixjson write-good)

for i in "${!command_name[@]}"; do
	if ! command -v "${command_name[$i]}" &>/dev/null; then
		echo "installing ${npm_package_name[$i]}"
		sudo npm install --location=global "${npm_package_name[$i]}"
		echo "installed ${npm_package_name[$i]}"
	else
		echo "updating ${npm_package_name[$i]}"
		sudo npm update --location=global "${npm_package_name[$i]}"
		echo "updated ${npm_package_name[$i]}"
	fi
done
