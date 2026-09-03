#!/bin/bash
set -e
mkdir -p state
export WEBAPP_URL="${WEBAPP_URL:-http://localhost:8000}"
exec uvicorn app:app --host 0.0.0.0 --port "${PORT:-8000}"
