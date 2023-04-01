# syntax=docker/dockerfile:1

FROM alpine 
LABEL maintainer="Wójcik"
LABEL email="s95612@pollub.edu.pl"

ARG BASE_VERSION=3.16.4

WORKDIR /app
RUN echo $BASE_VERSION > version.txt
COPY app.js /app
RUN apk add nodejs npm
RUN npm install express
RUN npm install os
RUN npm install fs
EXPOSE 3000
RUN node app.js

FROM nginx
RUN apt-get update && apt-get install -y curl
COPY myserver.config /etc/nginx/sites-available/myserver
RUN mkdir /etc/nginx/sites-enabled
RUN ln -s /etc/nginx/sites-available/myserver /etc/nginx/sites-enabled/
#RUN rm /etc/nginx/conf.d/default.conf
#COPY default.conf /etc/nginx/cont.d/

HEALTHCHECK --interval=30s --timeout=3s \
CMD curl -f http:localhost:80 || exit 1

EXPOSE 80
CMD ["nginx","-g","daemon off;"]
