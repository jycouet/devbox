#!/bin/bash

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