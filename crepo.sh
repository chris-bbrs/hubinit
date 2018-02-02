#!/bin/bash

set -e

name=${PWD##*/}
private='false'
description=''
SSH='false'

while getopts 'pd:sn:' flag; do
  case "${flag}" in
    p) private='true' ;;
	d) description="${OPTARG}";;
	s) SSH='true' ;;
	n) name="${OPTARG}";;
    *) error "Unexpected option ${flag}" ;;
  esac
done

read -r -p "Enter host username: " username
read -rs -p "Enter host password for user '$username': " password

curl -u "$username:$password" https://api.github.com/user/repos -d '{"name":"'$name'", "private":"'$private'", "description":"'$description'"}'

git remote add origin https://github.com/$username/$name.git

if $SSH ; then
	git remote set-url origin git@github.com:$username/$name.git
	git push origin master
else
	expect -f expected.expect $username $password
fi

