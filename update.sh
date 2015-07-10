#!/bin/sh
set -e

cd "$(dirname "$0")"

versions=("$@")
if [ ${#versions[@]} -eq 0 ]; then
    versions=(*/)
fi
versions=("${versions[@]%/}")

snapshotVersion=$(curl -sSL http://emacs.secretsauce.net/dists/unstable/main/binary-amd64/Packages | grep ^Version: | head -1 | awk '{print $2}')
caskVersion=$(git ls-remote https://github.com/cask/cask.git HEAD | awk '{print $1}')

release() {
    sed 's/{{ emacs_version }}/'$1'/; s/{{ key_id }}/'$2'/; s/{{ cask_version }}/'$3'/;' Dockerfile.template > $1/Dockerfile
}

snapshot() {
    sed 's/{{ emacs_version }}/'$1'/; s/{{ cask_version }}/'$2'/;' Dockerfile.template-snapshot > snapshot/Dockerfile
}

for version in "${versions[@]}"; do
    case "$version" in
        "24.4") release $version A0B0F199 $caskVersion ;;
        "24.5") release $version 7C207910 $caskVersion ;;
        "snapshot") snapshot $snapshotVersion $caskVersion ;;
    esac
done
