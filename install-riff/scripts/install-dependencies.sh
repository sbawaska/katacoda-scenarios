#!/bin/bash

# install riff cli
wget https://storage.googleapis.com/projectriff/riff-cli/releases/v0.5.0-snapshot/riff-linux-amd64.tgz
tar xvzf riff-linux-amd64.tgz
rm riff-linux-amd64.tgz
mv ./riff /usr/local/bin/riff

# install kapp
wget https://github.com/k14s/kapp/releases/download/v0.18.0/kapp-linux-amd64
tar xvzf kapp-linux-amd64
rm kapp-linux-amd64
mv ./kapp /user/local/bin/kapp
