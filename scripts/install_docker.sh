#!/bin/bash -e
#
# This script will install Docker Engine in Kali Linux
work_dir=$(dirname $(realpath $0))
source $work_dir/common.sh

isPrivilegedUser

if ! dpkg -l docker-ce >/dev/null; then
  eLog "Skip Docker installation as it seems to be installed already"
else
  eLog "Install Docker engine"
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - 2>>$LOG_ERR
  echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list
  apt-get update
  eLog "Remove any older version of Docker"
  apt-get remove docker docker-engine docker.io
  eLog "Install Docker-CE"
  apt-get install docker-ce -y
fi
