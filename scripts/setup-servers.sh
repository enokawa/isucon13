#!/bin/bash

# Run by isucon user

cd `dirname $0`

read servers < servers.txt

for server in ${servers[@]}
do
  echo "============= ${server} ============="
  scp setup.sh ${server}:/home/isucon/
  ssh ${server} sudo bash setup.sh
  ssh ${server} sudo hostnamectl set-hostname ${server} --static
  echo "============= ${server} ============="
  echo
done
