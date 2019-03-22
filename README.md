## Introduction

This repository contains Kali Linux automated bootstrap procedure with some basic DEV tools installed.

The main script `bootstrap_kali.sh` will install all basic tools (list below) to prepare Kali as DEV environment:

1. Install:
- `python3` with `python3-pip`, `virtualenv`, `virtualenvwrapper`, `pipenv`
- `python-pip` with `virtualenvwrapper`
- `vim` and `Visual Studio Code`
- `Docker` Community Edition (CE),
- `curl`, `terminator`
- `chromium` browser
2. Full-Upgrade of the distribution on each subsequent script trigger.

Bootstrap procedure is [idempotent](https://whatis.techtarget.com/definition/idempotence)


## Getting started

1. Clone the repository:

        cd <repository_root_dir>
        git clone git@github.com:patryk-gpl/kali-linux.git

2. Switch to a root user and run the bootstrap script:

        su -
        cd <repository_root_dir>/kali-linux
        chmod +x bootstrap_kali.sh scripts/*.sh
        ./bootstrap_kali.sh

## Notes

1. Git commits are following Karma, Git commit messages [naming convention](http://karma-runner.github.io/3.0/dev/git-commit-msg.html).
2. The bootstrap procedure has been tested with `Kali GNU/Linux Rolling`, release `2019.1`.
