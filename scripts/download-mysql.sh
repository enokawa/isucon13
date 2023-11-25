#!/bin/bash

# Run by isucon user

cd `dirname $0`

files=(
  etc/mysql/mysql.conf.d/mysqld.cnf
)

for file in ${files[@]}
do
  scp isucon13-1:/${file} ../${file}
done
