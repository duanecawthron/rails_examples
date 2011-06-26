#!/bin/bash

source 000_config.sh

cd $TOP/tmp

rm -rf out
mkdir -p out
cd out

curl http://localhost:3000 > home.txt

# From: http://en.wikipedia.org/wiki/Representational_State_Transfer
#
# Collection URI, such as http://localhost:3000/posts
#
# case 1	GET		List the URIs and perhaps other details of the collection's members.
# N/A		PUT		Replace the entire collection with another collection.
# case 3	POST	Create a new entry in the collection. The new entry's URL is assigned automatically and is usually returned by the operation.
# N/A		DELETE	Delete the entire collection.
#
# Element URI, such as http://localhost:3000/posts/1
#
# case 2	GET		Retrieve a representation of the addressed member of the collection, expressed in an appropriate Internet media type.
# case 4	PUT		Update the addressed member of the collection.
# N/A		POST	Treat the addressed member as a collection in its own right and create a new entry in it.
# case 5	DELETE	Delete the addressed member of the collection.

# -----------------------------------------------
# case 1
# GET /posts
# GET /posts.xml
# controller: def index

# show all posts
curl -H 'Accept: application/json' -H 'Content-Type: application/json' http://localhost:3000/posts > GET_posts.txt

# -----------------------------------------------
# case 2
# GET /posts/1
# GET /posts/1.xml
# controller: def show

# show post 1
curl -H 'Accept: application/json' -H 'Content-Type: application/json' http://localhost:3000/posts/1 > GET_posts_1a.txt

# -----------------------------------------------
# case 3
# POST /posts
# POST /posts.xml
# controller: def create

# create a new post
# http://stackoverflow.com/questions/5658510/curl-json-post-request-via-terminal-to-a-rails-app
curl -H "Accept: application/json" -H "Content-type: application/json" \
	-X POST \
	-d '{"post":{"content":"abc"}}'  \
	http://localhost:3000/posts > POST_posts.txt

# -----------------------------------------------
# case 4
# PUT /posts/1
# PUT /posts/1.xml
# controller: def update

# update element 1
curl -H "Accept: application/json" -H "Content-type: application/json" \
	-X PUT \
	-d '{"post":{"content":"abc"}}'  \
	http://localhost:3000/posts/1 > PUT_posts_1.txt

# see the update
curl -H 'Accept: application/json' -H 'Content-Type: application/json' http://localhost:3000/posts/1 > GET_posts_1b.txt

# -----------------------------------------------
# case 5
# DELETE /posts/1
# DELETE /posts/1.xml
# controller: def destroy

# delete element 1
curl -H "Accept: application/json" -H "Content-type: application/json" \
	-X DELETE \
	http://localhost:3000/posts/1 > DELETE_posts_1.txt

# show element 1 reports error
curl -H 'Accept: application/json' -H 'Content-Type: application/json' http://localhost:3000/posts/1 > GET_posts_1c.txt




exit 0
# -----------------------------------------------
When do we need to use authenticity_token?
-d 'authenticity_token=sEGbcYfbkP5wquhV/iros4TONZ3JaaZ2SVpgRjxsJX4='

# -----------------------------------------------
From Firefox, POST looks like this
Started POST "/posts" for 127.0.0.1 at Sat Jun 25 15:43:45 -0500 2011
  Processing by PostsController#create as HTML
  Parameters: {"commit"=>"Create Post", "post"=>{"content"=>"ddd"}, "authenticity_token"=>"sEGbcYfbkP5wquhV/iros4TONZ3JaaZ2SVpgRjxsJX4=", "utf8"=>"✓"}
  AREL (0.3ms)  INSERT INTO "posts" ("content", "updated_at", "created_at") VALUES ('ddd', '2011-06-25 20:43:45.930612', '2011-06-25 20:43:45.930612')
Redirected to http://localhost:3000/posts/4
Completed 302 Found in 12ms
