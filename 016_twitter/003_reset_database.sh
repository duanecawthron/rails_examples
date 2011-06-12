#!/bin/bash

source 000_config.sh

# ---------------- reset database

rake db:drop
rake db:create
rake db:migrate

cat << EOF | rails console
Post.create!(:message => "My first post" ) 
Post.create!(:message => "Post number two!" )  
EOF
