#!/bin/bash

source 000_config.sh

# ---------------- rails new app

cd  $TOP/tmp
rm -rf myapp
rails new myapp

# ---------------- replace Gemfile

cd  $TOP/tmp/myapp
[[ ! -f Gemfile ]] && sed "s;TOP;$TOP;" < $TOP/src/Gemfile > Gemfile

# ---------------- http://guides.rubyonrails.org/getting_started.html

cd  $TOP/tmp/myapp
rails generate controller home index

rm public/index.html

rails generate scaffold Post name:string title:string content:text

# ---------------- add home controller and view

cp -pr $TOP/src/app $TOP/tmp/myapp
cp -pr $TOP/src/config $TOP/tmp/myapp
cp -pr $TOP/src/public $TOP/tmp/myapp

# ---------------- https://github.com/indirect/jquery-rails

rails generate jquery:install --ui --force

# ---------------- https://github.com/amatsuda/kaminari

# rails g kaminari:config
# rails g kaminari:views default

vim -s $TOP/src/scripts/add_paginate_finder.vim $TOP/tmp/myapp/app/controllers/posts_controller.rb
vim -s $TOP/src/scripts/add_pagination.vim $TOP/tmp/myapp/app/views/posts/index.html.erb
