#!/usr/bin/env bash
set -e

# Step 1: Set up environment
cd /app

COMPOSE_FILE="docker-compose.yml"

if [ ! -f "$COMPOSE_FILE" ]; then
  echo "docker-compose.yml not found"
  exit 1
fi

# Step 2: Fix Mongo username mapping 
sed -i 's/MONGO_INITDB_ROOT_USERNAME: \${MONGO_PASSWORD}/MONGO_INITDB_ROOT_USERNAME: \${MONGO_INITDB_ROOT_USERNAME}/' "$COMPOSE_FILE"

# Step 3: Fix Mongo password mapping
sed -i 's/MONGO_INITDB_ROOT_PASSWORD: \${MONGO_USERNAME}/MONGO_INITDB_ROOT_PASSWORD: \${MONGO_INITDB_ROOT_PASSWORD}/' "$COMPOSE_FILE"

# Step 4: Start application
echo "Starting application"
docker compose up -d --build
sleep 8

Step 5: Verify
curl -s http://localhost:3000/health | grep -q "ok"