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

cat << EOF > app/views/home/index.html.erb
<h1>Hello, Rails!</h1>
EOF

# ---------------- devise

rails generate devise:install
rails generate devise user

cat << EOF >  ./app/controllers/home_controller.rb
class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
  end
end
EOF

