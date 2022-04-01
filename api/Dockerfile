#FROM ruby:3.1.1-alpine
 
# RUN apt-get install libpq-dev
# RUN apk add --no-cache bash
# RUN /bin/sh
# RUN apk update && apk add --virtual build-dependencies build-base

# RUN gem install bundler
# #RUN gem install rails 
# #-v 7.0.2.3

FROM ruby:3.1.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
COPY ./backend/ /myapp

RUN bundle install
RUN rake db:create

RUN rake db:migrate

CMD bundle exec rails s



