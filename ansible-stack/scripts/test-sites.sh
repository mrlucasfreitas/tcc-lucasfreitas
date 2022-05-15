#!/bin/bash

eipsfile="terraform-aws-ec2-instance/info/eips.txt"

for x in \$(cat ${eipsfile}); do
  if [ \$(curl -LI http://\$x -o /dev/null -w '%{http_code}\n' -s) == "200" ]; then
    echo "\033[32m[OK] - http://\$x\033[0m";
  else
    echo "\033[31m[ERROR] - http://\$x\033[0m";
  fi
done