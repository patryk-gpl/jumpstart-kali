#!/bin/bash -e

DEFAULT_GID=1000
DEFAULT_UID=1000
DEFAULT_USER=kali
DEFAULT_GROUP=kali
DEFAULT_PASSWORD=kali
LOG_OUT="/tmp/bootstrap_out.log"
LOG_ERR="/tmp/bootstrap_err.log"

function eLog() {
  echo
  echo "== $(date +'%Y-%m-%d %H:%M:%S') $@ ==" | tee -a $LOG_OUT
}

function printHeaderAndFooter() {
  printf "\n"
  printf '=%.0s' {1..50}
  printf "\n"
  eval $@
  printf "=%.0s" {1..50}
  printf "\n"
}

#main
clear
rm -f $LOG_OUT $LOG_ERR 2>/dev/null

if [[ "$(id -u)" -ne "0" ]]; then
  eLog "Detected other user than root. Run this script with root privileges. Aborting.."
  exit 1
fi

if [[ "$(grep -c $DEFAULT_GID /etc/group)" -eq "0" ]]; then
  eLog "Creating group $DEFAULT_GROUP with GID = $DEFAULT_GID"
  groupadd -g $DEFAULT_GID $DEFAULT_GROUP
else
  eLog "Group $DEFAULT_GROUP with GID = $DEFAULT_GID already exist"
fi

if [[ "$(grep -c $DEFAULT_UID /etc/passwd)" -eq "0" ]]; then
  eLog "Creating user $DEFAULT_USER with UID = $DEFAULT_UID"
  useradd -g $DEFAULT_GID -m -s /bin/bash $DEFAULT_USER
  eLog "Set default default password as $DEFAULT_USER. Please change it upon first use"
  echo "$DEFAULT_USER:$DEFAULT_PASSWORD" | chpasswd
else
  eLog "User $DEFAULT_USER with UID = $DEFAULT_UID already exist"
fi

eLog "Update APT packages"
apt-get update

eLog "Install Python3.7, pip, vim"
apt-get install -y \
          curl \
          lsb-release \
          python3-pip \
          python3.7 \
          vim \
          2>>$LOG_ERR

eLog "Install virtualenv, virtualenvwrapper, pipenv"
pip3 install virtualenv virtualenvwrapper pipenv  2>>$LOG_ERR

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

eLog "Perform full Kali upgrade"
apt-get full-upgrade -y 2>>$LOG_ERR

eLog "Removing unused packages from the system"
apt-get autoremove -y 2>>$LOG_ERR

if dpkg -l code >/dev/null; then
  eLog "Skip Visual Studio Code installation as it seems it has been installed already!"
else
  eLog "Install Visual Studio Code"
  curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
  apt-get update
  apt-get install -y code
fi

printHeaderAndFooter "lsb_release -a 2>/dev/null"
