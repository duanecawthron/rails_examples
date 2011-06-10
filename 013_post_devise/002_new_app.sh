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


# ---------------- devise

rails generate devise:install
rails generate devise user

# ---------------- post

rails generate scaffold Post name:string title:string content:text user:references

# generating the scaffold with user:references, adds belongs_to to app/models/user.rb
#  belongs_to :user
#
# the other side of the association must be added manually
#
# add has_many to app/models/user.rb
#   has_many :posts
cp -p $TOP/tmp/myapp/app/models/user.rb $TOP/tmp/myapp/app/models/user.rb.orig
vim -s $TOP/src/add_has_many_posts.vim $TOP/tmp/myapp/app/models/user.rb

# ---------------- http://guides.rubyonrails.org/getting_started.html

cd  $TOP/tmp/myapp
rails generate controller home index

rm public/index.html

cat << EOF > config/routes.rb
Myapp::Application.routes.draw do
  devise_for :users

  resources :posts

  get "home/index"
  root :to => "home#index"
end
EOF

cat << EOF > app/views/home/index.html.erb
<h1>Hello, Rails!</h1>
<%= link_to "My Blog", posts_path %>
EOF

# ---------------- devise

cat << EOF >  ./app/controllers/home_controller.rb
class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
  end
end
EOF

# ---------------- patch files

# when a post is created, set the post.user to the current_user
# add
#   @post.user = current_user
vim -s $TOP/src/assign_post_user.vim $TOP/tmp/myapp/app/controllers/posts_controller.rb

# do not show an input field for user in the post form (user will be current_user)
# delete
#   <div class="field">
#     <%= f.label :user %><br />
#     <%= f.text_field :user %>
#  </div>
vim -s $TOP/src/delete_form_user.vim $TOP/tmp/myapp/app/views/posts/_form.html.erb

# show user email in post views
vim -s $TOP/src/add_user_email.vim $TOP/tmp/myapp/app/views/posts/index.html.erb
vim -s $TOP/src/add_user_email.vim $TOP/tmp/myapp/app/views/posts/show.html.erb
