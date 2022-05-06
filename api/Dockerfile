FROM ruby:3.1.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /ror

#gem installer
COPY ./backend/ /ror

RUN bundle install
