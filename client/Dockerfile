FROM node:20

WORKDIR /app

COPY ./client/package.json ./client/yarn.lock ./client/

RUN cd client && yarn install --check-files

COPY . .
