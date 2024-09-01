FROM ruby:3.3.4

WORKDIR /app

COPY Gemfile Gemfile.lock ./backend/

RUN cd backend && bundle check || bundle install --jobs 4

COPY ../ .
