FROM ruby:latest
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /code

WORKDIR /code

COPY Gemfile /code/Gemfile
COPY Gemfile.lock /code/Gemfile.lock

RUN bundle install

COPY . /code

EXPOSE 3000
