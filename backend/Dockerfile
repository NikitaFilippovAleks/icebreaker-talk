FROM ruby:3.3.4

WORKDIR /app

COPY ./backend/Gemfile ./backend/Gemfile.lock ./backend/

RUN cd backend && bundle check || bundle install --jobs 4

COPY . .
