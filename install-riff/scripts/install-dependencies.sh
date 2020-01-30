#!/bin/bash

# install riff cli
wget https://storage.googleapis.com/projectriff/riff-cli/releases/v0.5.0-snapshot/riff-linux-amd64.tgz
tar xvzf riff-linux-amd64.tgz
rm riff-linux-amd64.tgz
mv ./riff /usr/local/bin/riff

# install kapp
curl -L https://k14s.io/install.sh | bash

# install helm3
rm /usr/local/bin/helm
curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
