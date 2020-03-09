echo "Starting kubernetes using minikube..."
minikube start > /dev/null 2>&1 &

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

# install helm 3
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo "tools installed!"

echo "Waiting for Kubernetes to start. This may take a few moments, please wait..."
while [ `minikube status &>/dev/null; echo $?` -ne 0 ]; do sleep 1; done
echo "Kubernetes Started"

echo "installing riff build"
kubectl create ns apps
kapp deploy -n apps -a cert-manager -f https://storage.googleapis.com/projectriff/release/0.6.0-snapshot/cert-manager.yaml -y
kapp deploy -n apps -a kpack -f https://storage.googleapis.com/projectriff/release/0.6.0-snapshot/kpack.yaml -y
kapp deploy -n apps -a riff-builders -f https://storage.googleapis.com/projectriff/release/0.6.0-snapshot/riff-builders.yaml -y
kapp deploy -n apps -a riff-build -f https://storage.googleapis.com/projectriff/release/0.6.0-snapshot/riff-build.yaml -y
echo "riff build installed"

echo "installing riff streaming runtime"
kapp deploy -n apps -a keda -f https://storage.googleapis.com/projectriff/release/0.6.0-snapshot/keda.yaml -y
kapp deploy -n apps -a riff-streaming-runtime -f https://storage.googleapis.com/projectriff/release/0.6.0-snapshot/riff-streaming-runtime.yaml -y
echo "riff streaming runtime installed!"

echo "installing kafka"
helm repo add incubator https://storage.googleapis.com/kubernetes-charts-incubator
kubectl create namespace kafka

helm install kafka --namespace kafka incubator/kafka --set replicas=1 --set zookeeper.replicaCount=1 --wait
echo "kafka installed!"

# run dev-utils pod
kubectl create serviceaccount riff-dev
kubectl create rolebinding riff-dev-edit --clusterrole=edit --serviceaccount=default:riff-dev
kubectl run riff-dev --serviceaccount=riff-dev --generator=run-pod/v1 --image=projectriff/dev-utils

# start registry
echo "starting a local registry for built container images"
docker run -d -p 5000:5000 --name registry registry:2
