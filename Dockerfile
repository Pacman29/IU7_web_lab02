FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get install -y wget curl
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y nginx

COPY ./default /etc/nginx/sites-available/

ADD . /Frontend
WORKDIR /Frontend
RUN npm install

EXPOSE 80

CMD service nginx start && PORT=8080 node app.js