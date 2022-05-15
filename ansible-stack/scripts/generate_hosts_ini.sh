#!/bin/sh

BASEDIR=$(dirname $0)
DIR="$( cd "$( dirname "$0" )" && pwd )"

eipsfile="terraform-aws-ec2-instance/info/eips.txt"

i=0
{
printf "[webserver]"
for x in $(cat $DIR/../../${eipsfile}); do echo
    i=$((i+1))
    printf "webserver$i ansible_host=$x ansible_user=ec2-user"
done

printf "\n\n"

cat << EOF
[linux:children]
webserver

[linux:vars]
ansible_ssh_extra_args = -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
ansible_become = true
EOF
} > $DIR/../environments/aws/hosts.ini