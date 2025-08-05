#!/bin/bash

while true; do
    printf '\033[34mEnter RPC URL: \033[0m'
    read RPC_URL

    RPC_URL=$(echo "$RPC_URL" | xargs)  # Trim spaces

    if [[ "$RPC_URL" =~ ^https?:// ]]; then
        sed -i "s|^\s*#\?\s*blockchain_rpc_endpoint\s*=.*|blockchain_rpc_endpoint = \"$RPC_URL\"|" "$HOME/0g-storage-node/run/config.toml" && \
        echo -e "\033[32mRPC URL has been successfully added to the config file.\033[0m"
        break
    else
        echo -e "\033[31mInvalid RPC URL. It must start with http:// or https:// and have no leading spaces.\033[0m"
    fi
done
