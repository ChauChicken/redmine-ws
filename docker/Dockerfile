FROM ubuntu:12.04

RUN sudo apt-get install -y ruby1.9.1 ruby1.9.1-dev

RUN gem install sinatra
RUN gem install thin
RUN gem install wrest

ADD ['/config', 'setup']

RUN /setup/config.sh

CMD ["ruby projets.rb"]
