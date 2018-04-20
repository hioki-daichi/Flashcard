#!/bin/sh

psql -U postgres -h localhost -p 15432 -d flashcard_development -c 'drop table health'
psql -U postgres -h localhost -p 15432 -d flashcard_development < data/schema.sql
