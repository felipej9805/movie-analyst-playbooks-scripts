echo 'Export variables from .env file...'
set -o allexport; . ~/.env; set +o allexport
. /home/ubuntu/.bashrc
. /home/ubuntu/.profile

echo 'Building image...'
sudo docker build --build-arg MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -t 9805/mydatabase /home/ubuntu/movie-analyst-api/data_model/

echo 'Read variable host ...'
env_path=$1
container_name="database_host"

echo 'Creating volume for data ...'
echo '################################################################################'
sudo docker volume create db-data

echo 'Starting run database Container...'
echo '################################################################################'
sudo docker rm -f $container_name > /dev/null 2>&1
sudo docker run -d -p 3306:3306 --name $container_name --mount source=db-data,target=/var/lib/mysql 9805/mydatabase
sudo docker exec -it $container_name bash -c "skip-grant-tables >> /etc/mysql/mysql.conf.d/mysqld.cnf"
sudo docker restart $container_name
echo 'Adding script to automatic restart containers...'
echo '################################################################################'
sudo install -m 777 /dev/null /etc/rc.local
sudo echo -e '#!/bin/bash\nsudo docker restart $(sudo docker ps -aq)\nexit 0' > /etc/rc.local

echo '################################################################################'
echo 'Database container is ready... :)'
echo '################################################################################'

