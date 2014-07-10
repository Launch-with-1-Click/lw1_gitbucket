#!/bin/bash

set -ex

JETTY_VERSION='9.2.1.v20140609'
GB_VERSION='2.1'
DEFAULT_USER='ec2-user'
DEFAULT_GROUP='ec2-user'
JETTY_USER='jetty'
JETTY_GROUP='jetty'

sudo yum update -y
sudo yum install git -y


## Install dependencies
sudo yum install -y nginx java-1.7.0-openjdk-devel

## Prepare dirs
sudo install -o ${DEFAULT_USER} -g ${DEFAULT_GROUP} -d /opt/src
sudo install -o ${JETTY_USER} -g ${JETTY_GROUP} -d /opt/gitbucket


## Download  latest stable jetty to /opt
wget ftp://ftp.jaist.ac.jp/pub/eclipse/jetty/stable-9/dist/jetty-distribution-${JETTY_VERSION}.tar.gz -O /opt/src/jetty.tar.gz

## Extract jetty
sudo tar xvzf /opt/src/jetty.tar.gz -C /opt/gitbucket/
sudo mv /opt/gitbucket/jetty-distribution-${JETTY_VERSION} /opt/gitbucket/jetty


## Copy initial script
sudo install -o root -g root -m 0755 /opt/gitbucket/jetty/bin/jetty.sh /etc/init.d/gitbucket

# Extract gitbucket
mkdir ROOT
wget https://github.com/takezoe/gitbucket/releases/download/${GB_VERSION}/gitbucket.war -O ROOT/gitbucket.war
cd ROOT
sudo jar xvf gitbucket.war
sudo rm -f gitbucket.war
cd ..
sudo mv ROOT /opt/gitbucket/jetty/webapps/
sudo chown -R ${JETTY_USER}.${JETTY_GROUP} /opt/gitbucket/jetty/webapps/ROOT
