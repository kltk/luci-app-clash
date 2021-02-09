#!/bin/sh

file=$1
shift

if [ ! -e $file ]; then
  echo <<-EOF
	Useage: call_fun.sh functions.sh fun arg1...
	EOF
else
  . $file
  "$@"
fi
