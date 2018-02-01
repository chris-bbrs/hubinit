#!/bin/bash

name=${PWD##*/}

private='false'
description=''
SSH='false'

while getopts 'pd:s' flag; do
  case "${flag}" in
    p) private='true' ;;
	d) description="${OPTARG}";;
	s) SSH='true' ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

read -r -p "Enter host username:" username

curl -u "$username" https://api.github.com/user/repos -d '{"name":"'$name'", "private":"'$private'", "description":"'$description'"}'

git remote add origin https://github.com/$username/$name.git

if $SSH ; then
	git remote set-url origin git@github.com:$username/$name.git
fi

git push origin master