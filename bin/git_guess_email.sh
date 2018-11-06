#!/bin/bash

remote=`git remote -v | awk '/\(push\)$/ {print $2}'`
email=caetanosauer@gmail.com # default

if [[ $remote == *gitlab.tableausoftware.com* ]]; then
  email=csauer@tableau.com
fi

echo "========================================================================"
echo "Configuring user.email as $email"
echo "========================================================================"
git config user.email $email
