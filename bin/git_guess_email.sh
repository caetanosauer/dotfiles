#!/bin/bash

remote=`git remote -v | awk '/\(push\)$/ {print $2}'`
email=caetanosauer@gmail.com # default


case "$remote" in 
    *gitlab.tableausoftware.com*)
        email=csauer@tableau.com
        ;;
esac

echo "========================================================================"
echo "Configuring user.email as $email"
echo "========================================================================"
git config user.email $email
