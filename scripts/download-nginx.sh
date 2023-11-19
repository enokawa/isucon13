#!/bin/bash

# Run by isucon user

cd `dirname $0`

files=(
  etc/nginx/nginx.conf
  etc/nginx/sites-available/isucon.conf
)

for file in ${files[@]}
do
  scp isucon13-1:/${file} ../${file}
done
