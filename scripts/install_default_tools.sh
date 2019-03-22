#!/bin/bash -e
#
# This script will create a default group and user
work_dir=$(dirname $(realpath $0))
source $work_dir/common.sh

isPrivilegedUser

eLog "Update APT packages"
apt-get update

eLog "Install Python3.7, pip, vim"
apt-get install -y \
          chromium \
          curl \
          lsb-release \
          python-pip \
          python3-pip \
          python3.7 \
          terminator \
          vim \
          2>>$LOG_ERR

eLog "Install apt-file"
apt-get install -y \
          apt-file \
          2>>$LOG_ERR

eLog "Update apt-file cache"
apt-file update

eLog "Install virtualenv, virtualenvwrapper, pipenv"
pip install virtualenvwrapper
pip3 install virtualenv virtualenvwrapper pipenv  2>>$LOG_ERR

eLog "Perform full Kali upgrade"
apt-get full-upgrade -y 2>>$LOG_ERR

eLog "Removing unused packages from the system"
apt-get autoremove -y 2>>$LOG_ERR