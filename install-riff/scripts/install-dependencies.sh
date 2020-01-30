#!/bin/bash

echo "installing required tools..."
# install riff cli
wget https://storage.googleapis.com/projectriff/riff-cli/releases/v0.5.0-snapshot/riff-linux-amd64.tgz
tar xvzf riff-linux-amd64.tgz
rm riff-linux-amd64.tgz
mv ./riff /usr/local/bin/riff

# install kapp
wget https://github.com/k14s/kapp/releases/download/v0.19.0/kapp-linux-amd64
mv ./kapp-linux-amd64 /usr/local/bin/kapp
chmod +x /usr/local/bin/kapp

# install ytt
wget https://github.com/k14s/ytt/releases/download/v0.25.0/ytt-linux-amd64
mv ./ytt-linux-amd64 /usr/local/bin/ytt
chmod +x /usr/local/bin/ytt

# install helm3
rm /usr/local/bin/helm
curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo "tools installed!"
