FROM ubuntu:12.04

ENV http_proxy http://wwwafip.afip.gob.ar:80
ENV https_proxy http://wwwafip.afip.gob.ar:80

RUN export http_proxy=http://wwwafip.afip.gob.ar:80
RUN export https_proxy=http://wwwafip.afip.gob.ar:80

RUN apt-get update

RUN apt-get install -y ruby1.9.1 ruby1.9.1-dev make g++

RUN gem install sinatra
RUN gem install thin
RUN gem install wrest

ADD ws /ws
ADD setup /setup

EXPOSE 8080

CMD ["/setup/init.sh"]
