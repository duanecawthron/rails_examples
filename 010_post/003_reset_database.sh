#!/bin/bash

source 000_config.sh

# ---------------- reset database

rake db:drop
rake db:create
rake db:migrate
