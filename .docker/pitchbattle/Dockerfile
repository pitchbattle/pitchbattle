FROM ruby:2.3.1-slim

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client nodejs git

ENV RAILS_ROOT /var/www/pitchbattle

WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . .
