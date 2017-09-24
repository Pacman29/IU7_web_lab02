FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get install -y wget curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y nginx

COPY ./port.sh /etc/nginx/sites-available/
RUN chmod +x /etc/nginx/sites-available/port.sh
COPY ./default /etc/nginx/sites-available/
COPY ./IU7_web_lab02_listen.conf /etc/nginx/sites-available/

ADD . /Frontend
WORKDIR /Frontend
RUN npm install

CMD /etc/nginx/sites-available/port.sh /etc/nginx/sites-available/IU7_web_lab02_listen.conf \
    && service nginx start \
    && PORT=8080 node app.js