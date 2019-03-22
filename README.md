## Introduction

This repository contains Kali Linux automated boostrap procedure with some basic DEV tools installed.

Bootstrap script `bootstrap_kali.sh` will install all basic tools (list below) to prepare system for work:

1. Install: 
- `Python3` with `virtualenv`, `virtualenvwrapper`, `pipenv`
- `vim` and `Visual Studio Code` with a list of pre-loaded extensions
- `Docker` Community Edition, 
- `curl`, `terminator`
- `Chromium` browser
2. Full-Upgrade of the distribution on each subsequent call.

## Getting started

1. Clone the repository:

        cd <repository_root_dir>
        git clone git@github.com:patryk-gpl/kali-linux.git

2. Switch to a root user and run the bootstrap script:

        su -
        cd <repository_root_dir>/kali-linux
        chmod +x bootstrap_kali.sh
        ./bootstrap_kali.sh

## Notes

1. Git commits are following Karma, Git commit messages [naming convention](http://karma-runner.github.io/3.0/dev/git-commit-msg.html): 