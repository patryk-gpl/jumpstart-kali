#!/bin/bash -e
#
# Bootstrap Kali linix with set of DEV Tools. More details in README.md
work_dir=$(dirname $(realpath $0))
scripts_dir=$work_dir/scripts

declare -xr LOG_OUT="/tmp/bootstrap_out.log"
declare -xr LOG_ERR="/tmp/bootstrap_err.log"
declare -xr DEFAULT_USER=kali

source $scripts_dir/common.sh

#main
clear
rm -f $LOG_OUT $LOG_ERR 2>/dev/null

$scripts_dir/create_default_user_group.sh
$scripts_dir/install_default_tools.sh
$scripts_dir/install_docker.sh
$scripts_dir/install_vscode.sh

printHeaderAndFooter "lsb_release -a 2>/dev/null"
