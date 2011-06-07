#!/bin/bash

source 000_config.sh

# ---------------- reset database

cat << EOF | mysql -u root
	GRANT ALL PRIVILEGES ON myapp.* TO myapp@localhost IDENTIFIED BY 'myapp';
	FLUSH PRIVILEGES;
EOF

cp $TOP/src/database.yml config/database.yml
rake db:drop
rake db:create
rake db:migrate
