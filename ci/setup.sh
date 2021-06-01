#!/bin/bash
set -e

sudo -u postgres bash -c 'mkdir -p ./pgsql/data; export PATH=$PATH:/usr/lib/postgresql/13/bin:/usr/local/bin; find . -name pg_ctl; find . -name postgresql-setup; /usr/lib/postgresql/13/bin/pg_ctl initdb -D ./pgsql/data -o "-E=UTF8"; /usr/lib/postgresql/13/bin/pg_ctl start -D ./pgsql/data
# sudo -i -u postgres bash -c 'mkdir -p ./pgsql/data; export PATH=$PATH:/usr/lib/postgresql/13/bin:/usr/local/bin; find . -name pg_ctl; find . -name postgresql-setup; /usr/lib/postgresql/13/bin/pg_ctl initdb -D ./pgsql/data -o "-E=UTF8"; /usr/lib/postgresql/13/bin/pg_ctl start -D ./pgsql/data

/usr/local/bin/bundle config set --local path 'vendor/bundle';  /usr/local/bin/bundle install; ./bin/setup; /usr/local/bin/bundle exec rails test'
