#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

# on /home/isucon/
files=(
  env.sh
  webapp/python/main.py
  webapp/sql/init.sh
  webapp/sql/01_Schema.sql
)

for file in ${files[@]}
do
  scp -r isucon13-1:/home/isucon/${file} ../${file}
done
