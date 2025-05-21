# Storage-Node-Guide-Zero-Gravity-0G

**Hardware Requirement**

Memory: 16 GB RAM  
CPU: 4 cores  
Disk: 500GB / 1T NVME SSD  
Bandwidth: 500 MBps for Download / Upload  

1. Install dependencies for building from source  
```bash
sudo apt-get update 
sudo apt-get install clang cmake build-essential openssl pkg-config libssl-dev
```

2. Install Go
```bash
cd $HOME && \
ver="1.22.0" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile && \
source ~/.bash_profile && \
go version
```

3. Install Rustup
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
```bash
. "$HOME/.cargo/env"
```

4. Download and install binary
```bash
cd $HOME
rm -rf 0g-storage-node
git clone https://github.com/0glabs/0g-storage-node.git
cd 0g-storage-node
git checkout v1.0.0
git submodule update --init
```

Build
```bash
cargo build --release
```

5. Set config
```bash
rm -rf $HOME/0g-storage-node/run/config.toml
curl -o $HOME/0g-storage-node/run/config.toml https://raw.githubusercontent.com/fallblight/Storage-Node-Zero-Gravity-0G/main/config.toml
```
Input your evm private key without "0X"
```bash
printf '\033[34mEnter your private key: \033[0m' && read EVM_PRIVATE_KEY
```
Save config
```bash
sed -i 's|^\s*#\?\s*miner_key\s*=.*|miner_key = "'"$EVM_PRIVATE_KEY"'"|' $HOME/0g-storage-node/run/config.toml && echo -e "\033[32mPrivate key has been successfully added to the config file.\033[0m"
```

6. Create service
```bash
sudo tee /etc/systemd/system/zgs.service > /dev/null <<EOF
[Unit]
Description=ZGS Node
After=network.target

[Service]
User=$USER
WorkingDirectory=$HOME/0g-storage-node/run
ExecStart=$HOME/0g-storage-node/target/release/zgs_node --config $HOME/0g-storage-node/run/config.toml
Restart=on-failure
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

7. Start node
```bash
sudo systemctl daemon-reload && \
sudo systemctl enable zgs && \
sudo systemctl restart zgs && \
sudo systemctl status zgs
```

8. Check logs

Full logs
```bash
tail -f ~/0g-storage-node/run/log/zgs.log.$(TZ=UTC date +%Y-%m-%d)
```
Hit logs
```bash
tail -f ~/0g-storage-node/run/log/zgs.log.$(TZ=UTC date +%Y-%m-%d) | grep hit
```
9. Check local block
```bash
while true; do
    response=$(curl -s -X POST http://localhost:5678 -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"zgs_getStatus","params":[],"id":1}')
    logSyncHeight=$(echo $response | jq '.result.logSyncHeight')
    connectedPeers=$(echo $response | jq '.result.connectedPeers')
    echo -e "logSyncHeight: \033[32m$logSyncHeight\033[0m, connectedPeers: \033[34m$connectedPeers\033[0m"
    sleep 5;
done
```
#
### Stop storage node
```bash
sudo systemctl stop zgs
```

Delete storage node
```bash
sudo systemctl disable zgs
sudo rm /etc/systemd/system/zgs.service
rm -rf $HOME/0g-storage-node
```



































