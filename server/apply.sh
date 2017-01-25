#!/bin/bash -e
cd $(dirname $0)

if [ "_$1" = "_--dry-run" ]; then
  dryrun="--dry-run"
  shift
fi

if [ "$#" -lt "1" ]; then
  echo "Usage: $0 [--dry-run] host [ssh options ...]" 1>&2
  echo "host is {HOST}.nw.techconf.cookpad.com" 1>&2
  echo "server/hosts/{HOST}.rb will be applied" 1>&2
  exit 1
fi


host_name=$1
host=${host_name}.nw.techconf.cookpad.com
recipe=hosts/${host_name}.rb
shift

remote_user="$(ssh "$@" "${host}" whoami)"
remote_tmpdir=/tmp/mitamae-${USER}-${remote_user}-mitamae
set -x
ssh "$@" "${host}" sh -c "echo ok && mkdir -p '$remote_tmpdir'/itamae"

SUM=0d5691c942ef02adbaa37e0f7bba41965781b1c771116afa32ac118e2a004a2d
ssh "$@" "${host}" "sudo bash -xc 'if [ -x /opt/mitamae/bin/mitamae ] && [ "'"_$(openssl dgst -r -sha256 /opt/mitamae/bin/mitamae|cut -d"'" "'" -f1)"'" = _$SUM ]; then exit 0; fi; mkdir -p /opt/mitamae/bin && curl --progress-bar -Lo /opt/mitamae/bin/mitamae https://github.com/k0kubun/mitamae/releases/download/v1.3.2/mitamae-x86_64-linux ; if [ "'"_$(openssl dgst -r -sha256 /opt/mitamae/bin/mitamae|cut -d"'" "'" -f1)"'" != _$SUM ]; then echo "'"mitamae shasum mismatch"'" 2>&1; mv /opt/mitamae/bin/mitamae{,.broken}; exit 1; else chmod +x /opt/mitamae/bin/mitamae; pacman -Syu --noconfirm rsync sudo; fi'"

rsync --rsh "ssh $*" -azvi $(pwd)/ ${host}:${remote_tmpdir}/itamae

ssh "$@" "${host}" "sudo sh -c 'cd $remote_tmpdir/itamae && /opt/mitamae/bin/mitamae local ${dryrun} ./site.rb ${recipe}'"

