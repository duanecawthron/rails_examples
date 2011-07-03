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

vim -s $TOP/src/scripts/add_responds_to_js.vim $TOP/tmp/myapp/app/controllers/posts_controller.rb

# ---------------- add posts javascript
#
# use sleep 2 to simulate slow response from server
#

cat << EOF > app/views/posts/index.js.rjs
sleep 2
page.insert_html :bottom, :posts, :partial => @posts
if @posts.total_pages > @posts.current_page
  page.call 'checkScroll'
else
  page[:loading].hide
end
EOF

# ---------------- create the partial

cat << EOF > app/views/posts/_post.html.erb
<div>
<%= post.content %>
<%= link_to 'Show', post %>
<%= link_to 'Edit', edit_post_path(post) %>
<%= link_to 'Destroy', post, :confirm => 'Are you sure?', :method => :delete %>
</div>
EOF

# ---------------- render the partial

cat << EOF > app/views/posts/index.html.erb
<h1>Listing posts</h1>

<%= link_to 'New Post', new_post_path %>
<br />

<div id="posts">
  <%= render :partial => @posts %>
</div>
<p id="loading">Loading more page results...</p>
EOF

# ---------------- add function checkScroll

cat << EOF > public/javascripts/application.js
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
