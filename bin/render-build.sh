#!/bin/bash
set -e

echo "==> Installing dependencies..."
bundle install

echo "==> Precompiling assets..."
bundle exec rails assets:precompile

echo "==> Running database migrations..."
bundle exec rails db:migrate

echo "==> Build complete!"
