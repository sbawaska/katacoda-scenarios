> The startup script running on the right is launching Kubernetes (minikube) starting a local container registry and installing riff CLI, kapp and ytt utilities. Once you see a prompt, you can click on the commands below at your own pace, and they will be copied and run for you in the terminal on the right.

First let's ensure that kubernetes is running by issuing `kubectl get pods -A`{{execute}} and waiting for all pods in `kube-system` to start.
Run `watch kubectl get pods -A`{{execute T2}} and switch to `All pods` terminal to see all the system as well as user pods being created.

We will use [kapp](https://get-kapp.io/) to install riff within the kubernetes cluster. kapp works by converging application resources based on comparison between provided files and live objects in the cluster.
Let us start off by creating a namespace for kapp to store its configuration.
`kubectl create ns apps`{{execute}}

We will now install riff's build component. This component will analyze your function and build a container by providing an appropriate language runtime and function invoker layer.

```
kapp deploy -n apps -a cert-manager -f https://storage.googleapis.com/projectriff/release/0.5.0/cert-manager.yaml -y

kapp deploy -n apps -a kpack -f https://storage.googleapis.com/projectriff/release/0.5.0/kpack.yaml -y

kapp deploy -n apps -a riff-builders -f https://storage.googleapis.com/projectriff/release/0.5.0/riff-builders.yaml -y

kapp deploy -n apps -a riff-build -f https://storage.googleapis.com/projectriff/release/0.5.0/riff-build.yaml -y
```{{execute}}

We now install the knative serving component. knative serving provides the automatic scaling up and down to zero, routing and point-in-time snapshots of deployed code and configurations.

```
ytt -f https://storage.googleapis.com/projectriff/release/0.5.0/contour.yaml -f https://storage.googleapis.com/projectriff/charts/overlays/service-nodeport.yaml --file-mark contour.yaml:type=yaml-plain | kapp deploy -n apps -a contour -f - -y

kapp deploy -n apps -a knative -f https://storage.googleapis.com/projectriff/release/0.5.0/knative.yaml -y

kapp deploy -n apps -a riff-knative-runtime -f https://storage.googleapis.com/projectriff/release/0.5.0/riff-knative-runtime.yaml -y
```{{execute}}
