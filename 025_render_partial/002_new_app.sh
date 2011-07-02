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

# ---------------- create the partial
#
# to make the partial, move the following from posts/index.html.erb
#
cat << EOF > app/views/posts/_post.html.erb
  <tr>
    <td><%= post.name %></td>
    <td><%= post.title %></td>
    <td><%= post.content %></td>
    <td><%= link_to 'Show', post %></td>
    <td><%= link_to 'Edit', edit_post_path(post) %></td>
    <td><%= link_to 'Destroy', post, :confirm => 'Are you sure?', :method => :delete %></td>
  </tr>
EOF

# ---------------- render the partial
#
# do this (either one works)
# <%= render :partial => @posts %>
# Or
# <%= render @posts %>
# 
# instead of this
# 
# <% @posts.each do |post| %>
#   <tr>
#     <td><%= post.name %></td>
#     <td><%= post.title %></td>
#     <td><%= post.content %></td>
#     <td><%= link_to 'Show', post %></td>
#     <td><%= link_to 'Edit', edit_post_path(post) %></td>
#     <td><%= link_to 'Destroy', post, :confirm => 'Are you sure?', :method => :delete %></td>
#   </tr>
# <% end %>
#

cat << EOF > app/views/posts/index.html.erb
<h1>Listing posts</h1>

<table>
  <tr>
    <th>Name</th>
    <th>Title</th>
    <th>Content</th>
    <th></th>
    <th></th>
    <th></th>
  </tr>

<%= render :partial => @posts %>

</table>

<br />

<%= link_to 'New Post', new_post_path %>
EOF

