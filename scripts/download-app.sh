#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

# on /home/isucon/
files=(
  env.sh
  webapp/python/app.py
  webapp/python/models.py
  webapp/sql/init.sh
  webapp/sql/init.sql
  webapp/sql/initdb.d/00_create_database.sql
  webapp/sql/initdb.d/10_schema.sql
  webapp/pdns/init_zone.sh
  webapp/pdns/named.conf
  webapp/pdns/u.isucon.dev.zone
)

for file in ${files[@]}
do
  scp -r isucon13-1:/home/isucon/${file} ../${file}
done
