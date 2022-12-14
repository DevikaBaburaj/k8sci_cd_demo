FROM ubuntu:bionic

MAINTAINER Devika KB

ENV NGINX_VERSION 1.14.0-0ubuntu1.10

RUN apt-get update && apt-get install -y curl
RUN apt-get update && apt-get install -y nginx=$NGINX_VERSION

WORKDIR /var/www/html
ADD index.html .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

