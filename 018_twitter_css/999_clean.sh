#!/bin/bash

source 000_config.sh

# ---------------- delete database

rake db:drop

# ---------------- delete files

cd $TOP
rm -rf cd $TOP/tmp

# ---------------- delete gemset

rvm gemset use global
rvm --force gemset delete $PROJECT
