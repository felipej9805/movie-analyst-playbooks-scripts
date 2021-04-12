#!/bin/bash
filename="/home/ubuntu/.env"
n=1
while read line; do
echo "export ${line}" >> /home/ubuntu/.bashrc
echo "export ${line}" >> /home/ubuntu/.profile

n=$((n+1))
done < $filename
. .bashrc
. .profile