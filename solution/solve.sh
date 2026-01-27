#!/usr/bin/env bash
set -e

echo "Starting application"
docker compose up -d

echo "Waiting for /health to return 200..."

MAX_RETRIES=10
SLEEP_SECONDS=2

for i in $(seq 1 $MAX_RETRIES); do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3000/health || true)

  if [ "$STATUS" = "200" ]; then
    echo "✅ /health returned 200"
    break
  fi

  echo "Attempt $i/$MAX_RETRIES: /health returned ${STATUS:-"no response"}"
  sleep $SLEEP_SECONDS
done

if [ "$STATUS" != "200" ]; then
  echo "❌ Service failed health check"
  docker compose down
  exit 1
fi

echo "Shutting down application"
sleep $SLEEP_SECONDS
docker compose down
