#!/bin/bash
filename="/home/ubuntu/.env"
n=1
while read line; do
echo "export ${line}" >> .bashrc
echo "export ${line}" >> .profile

n=$((n+1))
done < $filename
. .bashrc
. .profile