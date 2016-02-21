#!/bin/bash

set -ex

JETTY_VERSION='9.3.7.v20160115'
GB_VERSION='3.11'
DEFAULT_USER='ec2-user'
DEFAULT_GROUP='ec2-user'
JETTY_USER='jetty'
JETTY_GROUP='jetty'

sudo yum update -y
sudo yum install git -y


## Install dependencies
sudo yum install -y nginx java-1.8.0-openjdk-devel
sudo alternatives --set java /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java

## Prepare dirs
sudo install -o ${DEFAULT_USER} -g ${DEFAULT_GROUP} -d /opt/src
sudo install -o ${JETTY_USER} -g ${JETTY_GROUP} -d /opt/gitbucket


## Download  latest stable jetty to /opt
wget ftp://ftp.jaist.ac.jp/pub/eclipse/jetty/stable-9/dist/jetty-distribution-${JETTY_VERSION}.tar.gz -O /opt/src/jetty.tar.gz

## Extract jetty
sudo tar xvzf /opt/src/jetty.tar.gz -C /opt/gitbucket/
sudo mv /opt/gitbucket/jetty-distribution-${JETTY_VERSION} /opt/gitbucket/jetty
sudo chown jetty.jetty -R /opt/gitbucket/jetty


## Copy initial script
sudo install -o root -g root -m 0755 /opt/gitbucket/jetty/bin/jetty.sh /etc/init.d/gitbucket

# Extract gitbucket
mkdir -p ROOT
wget https://github.com/takezoe/gitbucket/releases/download/${GB_VERSION}/gitbucket.war -O root.war
sudo mv root.war /opt/gitbucket/jetty/webapps/
sudo chown -R ${JETTY_USER}.${JETTY_GROUP} /opt/gitbucket/jetty/webapps/
