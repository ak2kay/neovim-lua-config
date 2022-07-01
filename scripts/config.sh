#!/bin/bash

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

bash ${base_dir}/nvim.sh
bash ${base_dir}/apply.sh
bash ${base_dir}/lsp/gopls.sh
