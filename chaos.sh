#!/bin/bash
echo "Injecting chaos: Triggering app crash..."
# Set CRASH=true in the running container and call /health to trigger crash
docker exec chaos-app bash -c "export CRASH=true"
curl -s http://localhost:3000/health > /dev/null
sleep 3  # Wait for crash and restart
echo "Checking recovery..."
for i in {1..5}; do
  if curl -s http://localhost:3000/health | grep -q "OK"; then
    echo "System recovered successfully!"
    # Reset CRASH to false to ensure future runs work
    docker exec chaos-app bash -c "export CRASH=false"
    exit 0
  fi
  echo "Waiting for recovery... ($i/5)"
  sleep 2
done
echo "System failed to recover!"
exit 1