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

# ---------------- https://github.com/indirect/jquery-rails

rails generate jquery:install --ui --force

# ---------------- http://www.mkyong.com/jquery/jquery-hello-world/

cp $TOP/src/app/views/home/index.html.erb $TOP/tmp/myapp/app/views/home/index.html.erb

