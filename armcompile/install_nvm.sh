#!/bin/bash

## 安装nvm
## install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source ~/.bashrc
nvm install v8.11.3
npm install -g pm2 --registry=https://registry.npm.taobao.org
echo "install nvm && pm2"
