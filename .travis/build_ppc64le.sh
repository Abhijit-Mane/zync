#!/bin/bash

set -ev

# config & install
bundle config set --local path 'vendor/bundle'
bundle install
./bin/setup

# run tests
bundle exec rails test
