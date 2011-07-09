#!/bin/bash

source 000_config.sh

# ---------------- https://github.com/amatsuda/kaminari

$TOP/src/scripts/download.sh

cd  $TOP/tmp
rm -rf kaminari
cp -pr $TOP/src/download/kaminari .

# ---------------- install required Gems

cd  $TOP/tmp/kaminari
bundle install

# ---------------- run the tests
#
# NOTE: MongoDB must be running on localhost
#

cd  $TOP/tmp/kaminari
cp $TOP/src/config/mongoid.yml config/mongoid.yml
rake

# ---------------- build the gem

cd  $TOP/tmp/kaminari
rake build
