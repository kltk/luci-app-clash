#!/bin/sh

ensure_download() {
  url=$1
  target=$(realpath $2)
  filename=$(basename $target)
  shift 2
  #tmpfile=`mktemp`
  tmpfile="/tmp/$filename"
  options="-c --no-check-certificate --user-agent=\"Clash/OpenWRT\""
  wget $options $@ $url -O $tmpfile 2>&1
  if [ $? -eq 0 ]; then
    mv $tmpfile $target
  else
    return 1
  fi
}
