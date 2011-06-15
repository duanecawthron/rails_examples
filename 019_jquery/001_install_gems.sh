#!/bin/bash

source 000_config.sh

cd $TOP/tmp
[[ ! -f Gemfile ]] && cp ../src/Gemfile .
gem install rails

# Must reload RVM. Otherwise, bundle install fails
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
bundle install
