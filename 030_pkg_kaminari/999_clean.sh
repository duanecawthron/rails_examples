#!/bin/bash

source 000_config.sh

# ---------------- delete files

cd $TOP
rm -rf $TOP/tmp

# ---------------- delete gemset

rvm gemset use global
rvm --force gemset delete $PROJECT
