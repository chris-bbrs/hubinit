#!/bin/bash

set -e

repo=${PWD##*/}
private='false'
description=''
SSH='false'
remote_name='origin'

while getopts 'pd:sn:r:' flag; do
  case "${flag}" in
    p) private='true';;
	d) description="${OPTARG}";;
	s) SSH='true'git;;
	n) repo="${OPTARG}";;
	r) remote_name="${OPTARG}";;
    *) error "Unexpected option ${flag}";;
  esac
done

read -r -p "Enter host username: " username
read -rs -p "Enter host password for user '$username': " password

curl -u "$username:$password" https://api.github.com/user/repos -d '{"name":"'$repo'", "private":"'$private'", "description":"'$description'"}'

git remote add $remote_name https://github.com/$username/$repo.git

if $SSH ; then
	git remote set-url $remote_name git@github.com:$username/$repo.git
	git push $remote_name master
else
	expect -f expected.expect $username $password $remote_name
fi

