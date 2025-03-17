#!/bin/bash

set -e

bundle install
rails db:create db:migrate

# Start solargraph server
solargraph socket

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
