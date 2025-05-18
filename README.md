# Storage-Node-Zero-Gravity-0G

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
cargo build --releasecargo build --release
```

5.





















