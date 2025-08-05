#!/bin/bash

while true; do
    response=$(curl -s -X POST http://localhost:5678 \
      -H "Content-Type: application/json" \
      -d '{"jsonrpc":"2.0","method":"zgs_getStatus","params":[],"id":1}')
    logSyncHeight=$(echo $response | jq '.result.logSyncHeight')
    connectedPeers=$(echo $response | jq '.result.connectedPeers')
    networkHeight=$(curl -s -X POST https://evmrpc-testnet.0g.ai \
      -H "Content-Type: application/json" \
      -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' \
      | jq -r '.result' | xargs printf "%d")
    left=$((networkHeight - logSyncHeight))

    echo -e "Local Height: \033[32m$logSyncHeight\033[0m, Network Height: \033[35m$networkHeight\033[0m, Blocks Left: \033[34m$left\033[0m, Peers: \033[34m$connectedPeers\033[0m"

    sleep 5
done
