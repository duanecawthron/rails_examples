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

rails generate scaffold Post content:text

cat << EOF > app/views/home/index.html.erb
<h1>Hello, Rails!</h1>
<%= link_to "My Blog", posts_path %>
EOF

# ---------------- add respond_to format.json to the controller

cp $TOP/src/app/controllers/posts_controller.rb $TOP/tmp/myapp/app/controllers

# ---------------- https://github.com/indirect/jquery-rails

rails generate jquery:install --ui --force

# ---------------- http://blog.project-sierra.de/archives/1788

$TOP/src/scripts/download.sh
cp $TOP/src/download/jquery.tmpl.js $TOP/tmp/myapp/public/javascripts
cp $TOP/src/app/views/home/index.html.erb $TOP/tmp/myapp/app/views/home/index.html.erb
vim -s $TOP/src/scripts/add_javascript_include_tag.vim $TOP/tmp/myapp/app/views/layouts/application.html.erb
