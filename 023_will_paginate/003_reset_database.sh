#!/bin/bash

source 000_config.sh

# ---------------- reset database

rake db:drop
rake db:create
rake db:migrate

cat << EOF | rails console
Post.create!(:content => "My first post" ) 
Post.create!(:content => "Post number two!" )  
Post.create!(:content => "Post number 3!" )  
Post.create!(:content => "Post number 4!" )  
Post.create!(:content => "Post number 5!" )  
Post.create!(:content => "Post number 6!" )  
Post.create!(:content => "Post number 7!" )  
Post.create!(:content => "Post number 8!" )  
Post.create!(:content => "Post number 9!" )  
Post.create!(:content => "Post number 10!" )  
Post.create!(:content => "Post number 11!" )  
Post.create!(:content => "Post number 12!" )  
Post.create!(:content => "Post number 13!" )  
Post.create!(:content => "Post number 14!" )  
Post.create!(:content => "Post number 15!" )  
Post.create!(:content => "Post number 16!" )  
Post.create!(:content => "Post number 17!" )  
Post.create!(:content => "Post number 18!" )  
Post.create!(:content => "Post number 19!" )  
EOF
