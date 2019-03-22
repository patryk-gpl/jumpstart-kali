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

export -f eLog eLogShort