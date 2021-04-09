echo 'Export variables from .env file...'
set -o allexport; . ~/.env; set +o allexport
. .bashrc
. .profile
echo 'Read variable host ...'
env_path=$1
container_name="backend_host"

echo 'Starting run backend Container...'
echo '################################################################################'
sudo docker rm -f $container_name > /dev/null 2>&1

sudo docker run -d -p 3000:3000 --name $container_name 9805/mybackend:v1

echo 'Adding script to automatic restart containers...'
echo '################################################################################'
sudo install -m 777 /dev/null /etc/rc.local
sudo echo -e '#!/bin/bash\nsudo docker restart $(sudo docker ps -aq)\nexit 0' > /etc/rc.local

echo '################################################################################'
echo 'Backend container is ready... :)'
echo '################################################################################'

