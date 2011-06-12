#!/bin/bash

source 000_config.sh

# ---------------- rails new app

function new_app {
	cd  $TOP/tmp
	rm -rf myapp $1
	rails new myapp
	cd  $TOP/tmp/myapp
}

# ---------------- generator model

new_app m1
rails generate model post message:text
cd  $TOP/tmp
mv myapp m1

# ---------------- generator model and controller

new_app m2
rails generate model post message:text
rails generate controller posts
cd  $TOP/tmp
mv myapp m2

# Compare to m1, rails generate controller adds these files.
#   Only in m2/app/controllers: posts_controller.rb
#   Only in m2/app/helpers: posts_helper.rb
#   Only in m2/app/views: posts
#   Only in m2/test/functional: posts_controller_test.rb
#   Only in m2/test/unit: helpers

# ---------------- generator model and scaffold_controller

new_app m3
rails generate model post message:text
rails generate scaffold_controller posts
cd  $TOP/tmp
mv myapp m3

# Compared to m2, rails generate scaffold_controller adds these files.
#   Only in m3/app/views/posts: _form.html.erb
#   Only in m3/app/views/posts: edit.html.erb
#   Only in m3/app/views/posts: index.html.erb
#   Only in m3/app/views/posts: new.html.erb
#   Only in m3/app/views/posts: show.html.erb
# Also, in m2, these files are empty. In m3, these files have code for the controller.
#   Files app/controllers/posts_controller.rb differ
#   Files test/functional/posts_controller_test.rb differ

# ---------------- generator model, scaffold_controller and stylesheets

new_app m4
rails generate model post message:text
rails generate scaffold_controller posts
rails generate stylesheets
cd  $TOP/tmp
mv myapp m4

# Compared to m3, rails generate stylesheets adds this file.
#   Only in m4/public/stylesheets: scaffold.css

# ---------------- generator model and scaffold

new_app m5
rails generate scaffold Post message:text
cd  $TOP/tmp
mv myapp m5

# Compared to m3, rails generate scaffold adds one line to m5/config/routes.rb.
#   resources :posts
