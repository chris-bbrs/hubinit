#!/bin/bash

name=${PWD##*/}

private='false'
description=''

while getopts 'vd:' flag; do
  case "${flag}" in
    v) private='true' ;;
	d) description="${OPTARG}";;
    *) error "Unexpected option ${flag}" ;;
  esac
done

read -r -p "Enter host username:" username

curl -u "$username" https://api.github.com/user/repos -d '{"name":"'$name'", "private":"'$private'", "description":"'$description'"}'

git remote add origin https://github.com/$username/$name
git push origin master