#!/bin/sh

bundle exec rake db:drop db:setup db:migrate db:seed
