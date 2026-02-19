#!/bin/bash
set -e

echo "==> Installing dependencies..."
bundle install

echo "==> Precompiling assets..."
bundle exec rails assets:precompile

echo "==> Running database setup..."
bundle exec rails db:prepare

echo "==> Build complete!"
