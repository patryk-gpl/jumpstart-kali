#!/bin/bash -e
#
# This script will create virtualenv(s) with Ansible and Azure CLI
work_dir=$(dirname $(realpath $0))
source $work_dir/common.sh

isPrivilegedUser

declare -xr WORKON_HOME=/home/$DEFAULT_USER/.virtualenvs

ansible_version="2.7.9"
venv_ansible="$WORKON_HOME/ansible-${ansible_version}"
venv_azure_cli="$WORKON_HOME/azure-cli"

[[ -z $DEFAULT_USER ]] && eLog "DEFAULT_USER not found. Aborting.." && exit 1
su $DEFAULT_USER -c "
  cd ; createVenv $venv_ansible \"ansible==$ansible_version passlib\"
  cd ; createVenv $venv_azure_cli \"azure-cli\"
"
