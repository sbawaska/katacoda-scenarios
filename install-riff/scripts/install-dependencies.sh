echo "Starting kubernetes using minikube..."
minikube start > /dev/null 2>&1 &

# start registry
echo "starting a local registry for built container images"
docker run -d -p 5000:5000 --name registry registry:2

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

echo "tools installed!"
echo "Waiting for Kubernetes to start. This may take a few moments, please wait..."
while [ `minikube status &>/dev/null; echo $?` -ne 0 ]; do sleep 1; done
echo "Kubernetes Started"
