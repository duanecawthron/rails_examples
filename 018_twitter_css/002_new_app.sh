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

# ---------------- http://www.noupe.com/ajax/create-a-simple-twitter-app.html

cd  $TOP/tmp/myapp

rm -f ./public/index.html

rails generate model post message:text
rails generate controller posts

# same as 017_twitter_ajax
cp -p $TOP/src/app/views/posts/index.html.erb $TOP/tmp/myapp/app/views/posts/index.html.erb
cp -p $TOP/src/config/routes.rb $TOP/tmp/myapp/config/routes.rb
cp -p $TOP/src/app/controllers/posts_controller.rb $TOP/tmp/myapp/app/controllers/posts_controller.rb
cp -p $TOP/src/app/views/posts/index.html.erb $TOP/tmp/myapp/app/views/posts/index.html.erb
cp -p $TOP/src/app/views/posts/_post.html.erb $TOP/tmp/myapp/app/views/posts/_post.html.erb
cp -p $TOP/src/app/views/posts/_message_form.html.erb $TOP/tmp/myapp/app/views/posts/_message_form.html.erb
cp -p $TOP/src/app/views/posts/create.js.rjs $TOP/tmp/myapp/app/views/posts/create.js.rjs

# The following files were changed or added compared to 017_twitter_ajax.

# new file
cp -p $TOP/src/public/stylesheets/layout.css $TOP/tmp/myapp/public/stylesheets/layout.css

# add stylesheet_link_tag
cp -p $TOP/src/app/views/layouts/posts.html.erb $TOP/tmp/myapp/app/views/layouts/posts.html.erb
