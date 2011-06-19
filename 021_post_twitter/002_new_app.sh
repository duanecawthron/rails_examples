#!/bin/bash

source 000_config.sh

# ---------------- rails new app

cd  $TOP/tmp
rm -rf myapp
rails new myapp

# ---------------- replace Gemfile

cd  $TOP/tmp/myapp
mv Gemfile Gemfile.orig
cp ../../src/Gemfile .

# ---------------- http://guides.rubyonrails.org/getting_started.html

cd  $TOP/tmp/myapp
rails generate controller home index

rm public/index.html

rails generate scaffold Post content:text

cp -pr $TOP/src/app $TOP/tmp/myapp
cp -pr $TOP/src/config $TOP/tmp/myapp

