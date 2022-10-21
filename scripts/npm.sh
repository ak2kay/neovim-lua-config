#!/bin/bash

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

dest=/tmp/nodesource_setup.sh
curl -sL https://deb.nodesource.com/setup_16.x -o ${dest}
echo "add node source"
sudo bash ${dest}
sudo apt install nodejs
bash "${base_dir}"/lsp/npm.sh
