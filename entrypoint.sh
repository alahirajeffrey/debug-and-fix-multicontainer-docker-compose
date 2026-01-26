#!/bin/sh
set -e

if [ -z "$MONGO_URI" ]; then
  echo "❌ MONGO_URI is not set"
  exit 1
fi

if [ -z "$PORT" ]; then
  echo "❌ PORT is not set"
  exit 1
fi

exec node dist/server.js
