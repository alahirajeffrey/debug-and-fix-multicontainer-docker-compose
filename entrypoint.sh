#!/bin/sh
set -e

if [ -z "$MONGO_URI" ]; then
  echo "❌ MONGO_URI is not set"
fi

if [ -z "$PORT" ]; then
  echo "❌ PORT is not set"
fi

node dist/server.js &
NODE_PID=$!

sleep 2

if ! kill -0 "$NODE_PID" 2>/dev/null; then
  echo "❌ Node application failed to start"
else
  echo "✅ Node application started (PID $NODE_PID)"
fi

tail -f /dev/null