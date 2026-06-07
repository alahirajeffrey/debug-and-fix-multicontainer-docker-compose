#!/usr/bin/env bash
set -e

# Step 1: fetch proper variables from environment
MONGO_USERNAME="$MONGO_INITDB_ROOT_USERNAME"
MONGO_PASSWORD="$MONGO_INITDB_ROOT_PASSWORD"

if [ -z "$MONGO_USERNAME" ] || [ -z "$MONGO_PASSWORD" ]; then
  echo "Missing environment variables"
  echo "MONGO_INITDB_ROOT_USERNAME and MONGO_INITDB_ROOT_PASSWORD must be set"
  exit 1
fi

# Step 2: Update mongo uri environment variable
export MONGO_URI="mongodb://$MONGO_USERNAME:$MONGO_PASSWORD@mongo:27017/appdb?authSource=admin"

# Step 3: Restart server 
node dist/server.js

