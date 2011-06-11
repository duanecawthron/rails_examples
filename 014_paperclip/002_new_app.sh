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

# ---------------- https://github.com/thoughtbot/paperclip/wiki/Usage

rails generate paperclip Post avatar

vim -s $TOP/src/use_post_create.vim $TOP/tmp/myapp/app/controllers/posts_controller.rb
vim -s $TOP/src/add_has_attached_file.vim $TOP/tmp/myapp/app/models/post.rb
vim -s $TOP/src/add_form_multipart.vim $TOP/tmp/myapp/app/views/posts/_form.html.erb
vim -s $TOP/src/add_form_file_field.vim $TOP/tmp/myapp/app/views/posts/_form.html.erb
vim -s $TOP/src/add_image.vim $TOP/tmp/myapp/app/views/posts/show.html.erb
