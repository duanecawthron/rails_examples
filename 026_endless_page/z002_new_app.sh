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

# ---------------- https://github.com/mislav/will_paginate

vim -s $TOP/src/scripts/add_paginate_finder.vim $TOP/tmp/myapp/app/controllers/posts_controller.rb
vim -s $TOP/src/scripts/add_pagination.vim $TOP/tmp/myapp/app/views/posts/index.html.erb

# ---------------- http://railscasts.com/episodes/114-endless-page

cat << EOF > app/views/posts/_post.html.erb
  <tr>
    <td><%= post.content %></td>
    <td><%= link_to 'Show', post %></td>
    <td><%= link_to 'Edit', edit_post_path(post) %></td>
    <td><%= link_to 'Destroy', post, :confirm => 'Are you sure?', :method => :delete %></td>
  </tr>
EOF

cat << EOF > app/views/posts/index.html.erb
<h1>Listing posts</h1>

<table>
  <tr>
    <th>Content</th>
    <th></th>
    <th></th>
    <th></th>
  </tr>

<%= render :partial => @posts %>
<%= render @posts %>

</table>

<br />
<%= will_paginate @posts %>

<br />

<%= link_to 'New Post', new_post_path %>
EOF



exit 0
cat << EOF > app/views/posts/_post.html.erb
<table>
  <tr>
    <th>Content</th>
    <th></th>
    <th></th>
    <th></th>
  </tr>

<% @posts.each do |post| %>
  <tr>
    <td><%= post.content %></td>
    <td><%= link_to 'Show', post %></td>
    <td><%= link_to 'Edit', edit_post_path(post) %></td>
    <td><%= link_to 'Destroy', post, :confirm => 'Are you sure?', :method => :delete %></td>
  </tr>
<% end %>
</table>
EOF

cat << EOF > app/views/posts/index.html.erb
<h1>Listing posts</h1>

<%= render :partial => @posts %>

<br />
<%= will_paginate @posts %>

<br />

<%= link_to 'New Post', new_post_path %>
EOF



exit 0

cat << EOF > app/views/posts/index.js.rjs
page.insert_html :bottom, :posts, :partial => @posts
if @posts.total_pages > @posts.current_page
  page.call 'checkScroll'
else
  page[:loading].hide
end
EOF

cat << EOF > applicaton_helper.rb
def javascript(*args)
  content_for(:head) { javascript_include_tag(*args) }
end
EOF

cat << EOF > app/views/posts/index.html.erb
<% title "Posts" %>
<% javascript :defaults, 'endless_page' %>

<div id="posts">
  <%= render :partial => @posts %>
</div>
<p id="loading">Loading more page results...</p>
EOF

cat << EOF > app/public/javascripts/endless_page.js
var currentPage = 1;

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    new Ajax.Request('/posts.js?page=' + currentPage, {asynchronous:true, evalScripts:true, method:'get'});
  } else {
    setTimeout("checkScroll()", 250);
  }
}

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

document.observe('dom:loaded', checkScroll);
EOF


exit 0
./app/controllers/application_controller.rb
./app/controllers/home_controller.rb
./app/controllers/posts_controller.rb
./app/helpers/application_helper.rb
./app/helpers/home_helper.rb
./app/helpers/posts_helper.rb
./app/models/post.rb
./app/views/home/index.html.erb
./app/views/layouts/application.html.erb
./app/views/posts/_form.html.erb
./app/views/posts/edit.html.erb
./app/views/posts/index.html.erb
./app/views/posts/new.html.erb
./app/views/posts/show.html.erb

