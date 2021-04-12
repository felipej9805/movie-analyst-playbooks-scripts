echo 'Export variables from .env file...'
set -o allexport; . ~/.env; set +o allexport
. /home/ubuntu/.bashrc
. /home/ubuntu/.profile
echo 'Read variable host ...'
env_path=$1
container_name="backend_host"

echo 'Building image...'
sudo docker build --build-arg PORT=${PORT} \
--build-arg DB_HOST=${DB_HOST} \
--build-arg DB_USER=${DB_USER} \
--build-arg DB_PASS=${DB_PASS} \
--build-arg DB_NAME=${DB_NAME} -t 9805/mybackend /home/ubuntu/movie-analyst-api/

echo 'Starting run backend Container...'
echo '################################################################################'
sudo docker rm -f $container_name > /dev/null 2>&1

sudo docker run -d -p 3000:3000 --name $container_name 9805/mybackend

echo 'Adding script to automatic restart containers...'
echo '################################################################################'
sudo install -m 777 /dev/null /etc/rc.local
sudo echo -e '#!/bin/bash\nsudo docker restart $(sudo docker ps -aq)\nexit 0' > /etc/rc.local

echo '################################################################################'
echo 'Backend container is ready... :)'
echo '################################################################################'

