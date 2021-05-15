#!/bin/bash
set -e

# Install
gem install bundler

#dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-ppc64le/pgdg-redhat-repo-latest.noarch.rpm
#dnf install -y postgresql13-server
#dnf install -y libpq5 libpq5-devel

#sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
#wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
#sudo apt-get -y install postgresql-12 
#sudo apt-get -y install postgresql-server-dev-12
#sudo apt-get -y libpq-dev
