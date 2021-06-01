#!/bin/bash
set -e

bundle config set --local path 'vendor/bundle'
bundle install
./bin/setup
bundle exec rails test

