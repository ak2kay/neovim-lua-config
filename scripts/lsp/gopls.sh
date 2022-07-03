#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

script=$(readlink -f "$0")
base_dir=$(dirname "$script")

. ${base_dir}/utils.sh

PATH=${HOME}/.local/go/bin:${PATH}

downloadGolang() {
	machine_out="$(uname -s)"
	case "${machine_out}" in
	Linux*) machine=Linux ;;
	Darwin*) machine=Mac ;;
	CYGWIN*) machine=Cygwin ;;
	MINGW*) machine=MinGw ;;
	*) machine="UNKNOWN:${machine_out}" ;;
	esac
	echo ${machine}
	arch_out="$(uname -i)"
	case "${arch_out}" in
	x86_64*) arch=x86_64 ;;
	i*86) arch=x32 ;;
	arm*) arch=arm ;;
	aarch64*) arch=arm ;;
	esac
	echo ${arch}

	if [[ ${machine} = "Linux" ]]; then
		case "${arch}" in
		x86_64) download_link="https://go.dev/dl/go1.18.1.linux-amd64.tar.gz" ;;
		arm) download_link="https://go.dev/dl/go1.18.1.linux-arm64.tar.gz" ;;
		x32) download_link="https://go.dev/dl/go1.18.1.linux-386.tar.gz" ;;
		esac
	fi
	if [[ ${machine} = "Mac" ]]; then
		case "${arch}" in
		x86_64) download_link="https://go.dev/dl/go1.18.1.darwin-amd64.tar.gz" ;;
		arm) download_link="https://go.dev/dl/go1.18.1.darwin-arm64.tar.gz" ;;
		esac
	fi
	if [[ -z "${download_link}" ]]; then
		echo "no match download link"
		exit 1
	fi
	ensureTargetDir ${HOME}/.local
	echo "downloading golang: ${download_link}"
	silencer "curl -L ${download_link} -o go.tar.gz"
	echo "golang: ${download_link} downloaded"
	echo "untracting golang"
	silencer "tar -xvzf ./go.tar.gz -C ${HOME}/.local"
	echo "golang untracted"
	rm -rf ./go.tar.gz
}

if ! command -v go &>/dev/null; then
	downloadGolang
fi

cd /tmp
echo "install gopls"
silencer "go install golang.org/x/tools/gopls@latest"
# shell formatter
echo "install shfmt"
silencer "go install mvdan.cc/sh/v3/cmd/shfmt@latest"

echo "install gofumpt"
silencer "go install mvdan.cc/gofumpt@latest"
echo "install goimports"
silencer "go install golang.org/x/tools/cmd/goimports@latest"
echo "install golangci-lint"
silencer "go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.45.2"
echo "all deps installed"
