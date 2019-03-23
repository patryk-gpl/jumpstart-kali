#!/bin/bash -e
#
# This script will create virtualenv(s) with molecule, ansible and Azure CLI
work_dir=$(dirname $(realpath $0))
source $work_dir/common.sh

isPrivilegedUser

declare -xr WORKON_HOME=/home/$DEFAULT_USER/.virtualenvs

molecule_version="2.20.0"
venv_molecule="$WORKON_HOME/molecule-${molecule_version}"
venv_azure_cli="$WORKON_HOME/azure-cli"

[[ -z $DEFAULT_USER ]] && eLog "DEFAULT_USER not found. Aborting.." && exit 1
su $DEFAULT_USER -c "
  cd ; createVenv $venv_molecule \"molecule==$molecule_version passlib\"
  cd ; createVenv $venv_azure_cli \"azure-cli\"
"
