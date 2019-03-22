#!/bin/bash -e
#
# This script will install Visual Studio Code in Kali Linux
work_dir=$(dirname $(realpath $0))
source $work_dir/common.sh

isPrivilegedUser

if dpkg -l code >/dev/null; then
  eLog "Skip Visual Studio Code installation as it seems it has been installed already!"
else
  eLog "Install Visual Studio Code"
  curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list
  apt-get update
  apt-get install -y code
fi
