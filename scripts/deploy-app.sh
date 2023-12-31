#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

files=(
  env.sh
  webapp/python/app.py
  webapp/python/models.py
  webapp/sql/initdb.d/10_schema.sql
  webapp/pdns/u.isucon.dev.zone
)

for server in ${servers[@]}
do
  echo "============= ${server} ============="
  # Stop Go service and enable Python service
  # ssh ${server} sudo systemctl stop isupipe-go.service
  # ssh ${server} sudo systemctl disable isupipe-go.service
  # ssh ${server} sudo systemctl enable isupipe-python.service

  # Stop Python service
  # TODO: Fix Systemd Unit name
  ssh ${server} sudo systemctl stop isupipe-python.service

  for file in ${files[@]}
  do
    scp ../${file} ${server}:/home/isucon/${file}
  done

  # Lotate Logs
  # ssh ${server} "sudo gzip -c /var/log/nginx/access.log > /var/tmp/access.log.$(date +%Y%m%d-%H%M%S)"
  ssh ${server} sudo rm -f /var/log/nginx/access.log
  
  # Restart services
  ssh ${server} sudo systemctl start isupipe-python.service
  ssh ${server} sudo rm -f /var/log/mysql/mysql-slow.log
  ssh ${server} sudo mysqladmin flush-logs
  ssh ${server} sudo nginx -s reopen
  echo "============= ${server} ============="
  echo
done
