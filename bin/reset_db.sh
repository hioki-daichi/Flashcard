#!/bin/sh

bundle exec rake db:drop db:create db:migrate db:seed
