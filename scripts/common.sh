#!/bin/bash -e
#
# Common utility functions shared between various scripts

function eLog() {
  echo
  echo "== $(date +'%Y-%m-%d %H:%M:%S') $@ ==" | tee -a $LOG_OUT
}

function eLogShort() {
  echo "  => $@" | tee -a $LOG_OUT
}

function printHeaderAndFooter() {
  printf "\n"
  printf '=%.0s' {1..50}
  printf "\n"
  eval $@
  printf "=%.0s" {1..50}
  printf "\n"
}

function isPrivilegedUser() {
  if [[ "$(id -u)" -ne "0" ]]; then
    eLog "Detected other user than root. Run this script with root privileges. Aborting.."
    exit 1
  fi
}

function createVenv() {
  if [[ "$#" -ne "2" ]]; then
    echo "Usage: $0 <venv_location> <packages_list>"
  else
    local venv=$1
    local packages=$2

    eLog "Checking installation status of virtualenv $venv"
    eLogShort "Virtualenv: $venv"
    eLogShort "Python packages: $packages"

    if [ ! -d $venv ]; then
      eLog 'Installing virtualenv (python3): ' $venv
      virtualenv -p python3 $venv
      source $venv/bin/activate
      pip3 install $packages
      deactivate
    else
      eLog 'It seems requested virtualenv has been installed already'
    fi
  fi
}

export -f createVenv
export -f eLog eLogShort