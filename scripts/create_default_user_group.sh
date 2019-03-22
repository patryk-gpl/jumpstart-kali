#!/bin/bash
#
# This script will create a default group and user
work_dir=$(dirname $(realpath $0))
source $work_dir/common.sh
isPrivilegedUser

readonly DEFAULT_GID=1000
readonly DEFAULT_UID=1000
readonly DEFAULT_GROUP=kali
readonly DEFAULT_PASSWORD=kali

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