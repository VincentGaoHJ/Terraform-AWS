#!/bin/sh

for i in 1 2 3; do
  echo "Import: meta_exist$i"
  terraform import aws_iam_user.multiple_exist_users[$i] meta_exist$i
done
read