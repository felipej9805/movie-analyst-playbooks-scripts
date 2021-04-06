#!/bin/bash
echo 'Updating...'
echo '################################################################################'
sudo apt-get update -y

echo 'Downloading and adding Docker CE CPG key...'
echo '################################################################################'
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo 'Add the Docker CE repository to APT...'
echo '################################################################################'
sudo install -m 777 /dev/null /etc/apt/sources.list.d/docker.list
sudo echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

echo 'Updating the repository...'
echo '################################################################################'
sudo apt-get update -y

echo 'Installing docker-ce, docker-ce-cli and containerd.io...'
echo echo '################################################################################'
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo 'Create docker group...'
echo echo '################################################################################'
sudo groupadd docker

echo 'Add user to the docker group...'
echo echo '################################################################################'
sudo usermod -aG docker $USER
