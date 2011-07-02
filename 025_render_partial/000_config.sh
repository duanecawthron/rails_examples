#!/bin/bash

PROJECT=render_partial

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
rvm gemset use global
rvm gemset create $PROJECT
rvm use 1.8.7@$PROJECT

TOP=`pwd`
mkdir -p $TOP/tmp/myapp
cd $TOP/tmp/myapp
