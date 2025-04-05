#!/bin/bash
echo "Starting system monitor..."

# Single check by default
if curl -s http://localhost:3000/health | grep -q "OK"; then
  echo "System is healthy!"
  exit 0
else
  echo "System down! Waiting for auto-restart..."
  sleep 5  # Give restart policy time to kick in
  if curl -s http://localhost:3000/health | grep -q "OK"; then
    echo "System recovered!"
    exit 0
  else
    echo "Forcing recovery..."
    docker start chaos-app 2>/dev/null || echo "Already restarting..."
    sleep 2
    if curl -s http://localhost:3000/health | grep -q "OK"; then
      echo "System recovered after forced start!"
      exit 0
    else
      echo "System failed to recover!"
      exit 1
    fi
  fi
fi

# Optional: Add "loop" as an argument to run continuously
if [ "$1" == "loop" ]; then
  echo "Switching to continuous monitoring mode..."
  while true; do
    if curl -s http://localhost:3000/health | grep -q "OK"; then
      echo "System is healthy!"
    else
      echo "System down! Waiting for auto-restart..."
      sleep 5
      if ! curl -s http://localhost:3000/health | grep -q "OK"; then
        echo "Forcing recovery..."
        docker start chaos-app 2>/dev/null || echo "Already restarting..."
      fi
    fi
    sleep 2
  done
fi