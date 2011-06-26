#!/bin/bash

source 000_config.sh

# ---------------- reset database

rake db:drop
rake db:create
rake db:migrate

cat << EOF | rails console
Post.create!(:content => "My first post" ) 
Post.create!(:content => "Post number two!" )  
EOF
