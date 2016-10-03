#!/bin/bash

docker build -t my-ruby-app ./docker-app
docker build -t my-nginx ./docker-nginx
docker run --name ruby-app -p 4567:4567 -d my-ruby-app
docker run -p 80:80 --name nginx-container \
  -v $(pwd)/html:/usr/share/nginx/html:ro \
  -v $(pwd)/docker-nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
  --link ruby-app:app \
  -P -d my-nginx
