#!/bin/sh

dir=/var/lib/clash/version

fetch_version() {
  url="https://api.github.com/repos/$user/$repo/tags"
  curl -sL $url | jq ".[0].name"
}

check_version() {
  name=$1
  user=$2
  repo=$3
  filepath="$dir/${name}"
  latest_version=$(fetch_version $user $repo)
  if [ "$?" -eq "0" ]; then
    mkdir -p $dir
    rm -rf $filepath
    if [ $latest_version ]; then
      echo $latest_version >$filepath
    elif [$latest_version == ""]; then
      echo 0 >$filepath
    fi
  fi
}

get_version() {
  name=$1
  sed -n 1p "$dir/${name}"
}
