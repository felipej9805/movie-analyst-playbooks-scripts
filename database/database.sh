echo 'Read variable host ...'
env_path=$1
container_name="database_host"

echo 'Creating volume for data ...'
echo '################################################################################'
sudo docker volume create db-data

echo 'Starting run database Container...'
echo '################################################################################'
sudo docker rm -f $container_name > /dev/null 2>&1
docker run -d -p 3306:3306 --env-file $env_path --name $container_name --mount source=db-data,target=/var/lib/mysql 9805/mydatabase:v1

echo 'Adding script to automatic restart containers...'
echo '################################################################################'
sudo install -m 777 /dev/null /etc/rc.local
sudo echo -e '#!/bin/bash\nsudo docker restart $(sudo docker ps -aq)\nexit 0' > /etc/rc.local

echo '################################################################################'
echo 'Database container is ready... :)'
echo '################################################################################'

