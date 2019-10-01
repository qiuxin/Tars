#!/bin/bash
yum install -y glibc-devel
yum install -y flex
yum install -y bison
yum install -y cmake
yum install -y ncurses-devel
yum install -y zlib-devel
yum install -y perl
yum install -y wget
yum install -y net-tools
yum install -y gcc
yum install -y gcc-c++
yum install -y flex
yum install -y make
yum install -y git
yum install -y expect
yum install -y tar
yum install -y epel-release
yum install -y nodejs
yum install -y npm
#npm install -g n
npm i -g pm2
yum install -y lrzsz
echo "Finish basic tool installation">>$CodePath/Tars/shellDeploy/deploy_log
