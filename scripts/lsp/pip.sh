#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. ${base_dir}/utils.sh

echo "installing black"
silencer "python3 -m pip install black"
echo "installed black"
echo "installing isort"
silencer "python3 -m pip install isort"
echo "installed isort"
echo "installing flake8"
silencer "python3 -m pip install flake8"
echo "installed flake8"
