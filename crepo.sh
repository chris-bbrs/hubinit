#!/bin/bash

set -e

repo=${PWD##*/}
private='false'
description=''
SSH='false'
remote_name='origin'
create='false'

while getopts 'pd:sn:r:c' flag; do
  case "${flag}" in
    p) private='true';;
	d) description="${OPTARG}";;
	n) repo="${OPTARG}";;
	c) create='true';;
	s)  if $create; then
			printf "Unexpected option -${flag}\n"
			exit 1;
		fi
	   SSH='true';;
	r)  if $create; then
			printf "Unexpected option -${flag}\n"
			exit 1;
		fi
	   remote_name="${OPTARG}";;
    *) exit 1 ;;
  esac
done

read -r -p "Enter host username: " username
read -rs -p "Enter host password for user '$username': " password

curl -u "$username:$password" https://api.github.com/user/repos -d '{"name":"'$repo'", "private":"'$private'", "description":"'$description'"}'

if [ create == true ]; then
	exit 0
fi

git remote add $remote_name https://github.com/$username/$repo.git

if $SSH ; then
	git remote set-url $remote_name git@github.com:$username/$repo.git
	git push $remote_name master
else
	expect -f expected.expect $username $password $remote_name
fi

