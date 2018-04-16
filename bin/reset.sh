#!/bin/sh

. ./bin/reset_db.sh
pushd ./frontend/ && npm install && popd
