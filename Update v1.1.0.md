# Update Storage Node to v.1.1.0

1. Stop storage node
```bash
sudo systemctl stop zgs
```
2. Install dependencies for building from source
```bash
sudo apt-get update
sudo apt-get openssl libssl-dev pkg-config
sudo apt install protobuf-compiler
```
3. Backup config.toml
```bash
cd $HOME
mv $HOME/0g-storage-node/run/config.toml $HOME/config_backup.toml
```
4. Update storage node
```bash
cd $HOME/0g-storage-node
git fetch --all --tags
git checkout v1.1.0
git submodule update --init
cargo build --release
```
5. Move back the config.toml
```bash
mv $HOME/config_backup.toml $HOME/0g-storage-node/run/config.toml
```
6. Restart node
```bash
sudo systemctl restart zgs && sudo systemctl status zgs
```
