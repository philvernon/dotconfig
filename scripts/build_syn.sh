#!/bin/bash

ROOT="/Users/philipvernon/Documents/syn-repos/synthesis"
CONFIG_FILE="$ROOT/config.yml"
ENV_FILE="$ROOT/.env"

echo $CONFIG_FILE

if [ -f $CONFIG_FILE ] && [ -f $ENV_FILE ]; then
  echo "files exist"
  cd "$ROOT"
  ./docker-compose-synthesis.sh
fi

