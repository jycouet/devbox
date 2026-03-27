#!/bin/bash

# Ensure PostgreSQL connection defaults (overridable via devbox.json env)
export PGHOST="${PGHOST:-127.0.0.1}"
export PGPORT="${PGPORT:-5432}"
export PGUSER="${PGUSER:-postgres}"

execute_and_log() {
    local topic="$1"
    local action="$2"
    
    echo "⌛ $topic - starting..."
    
    if eval "$action"; then
        echo "✅ $topic - done"
        return 0
    else
        echo "❌ $topic - error"
        return 1
    fi
} 