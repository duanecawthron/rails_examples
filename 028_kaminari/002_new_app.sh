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

cat << EOF > config/routes.rb
Myapp::Application.routes.draw do
  get "home/index"
  root :to => "home#index"
end
EOF

rails generate scaffold Post name:string title:string content:text

cat << EOF > app/views/home/index.html.erb
<h1>Hello, Rails!</h1>
<%= link_to "My Blog", posts_path %>
EOF

# ---------------- https://github.com/amatsuda/kaminari

# rails g kaminari:config
# rails g kaminari:views default

vim -s $TOP/src/scripts/add_paginate_finder.vim $TOP/tmp/myapp/app/controllers/posts_controller.rb
vim -s $TOP/src/scripts/add_pagination.vim $TOP/tmp/myapp/app/views/posts/index.html.erb

