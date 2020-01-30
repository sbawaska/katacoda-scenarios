Ensure that kubernetes is running by running `kubectl get pods -A`{{execute}} and waiting for all pods in `kube-system` to start.

We will use [kapp](https://get-kapp.io/) to install riff within the kubernetes cluster. kapp works by converging application resources based on comparison between provided files and live objects in the cluster.
Let us start off by creating a namespace for kapp to store its configuration.
`kubectl create ns apps`{{execute}}

We will now install riff build. This component will analyze your function and build a container by providing an appropriate language runtime and function invoker layer.

```
kapp deploy -n apps -a cert-manager -f https://storage.googleapis.com/projectriff/release/0.5.0-snapshot/cert-manager.yaml -y
kapp deploy -n apps -a kpack -f https://storage.googleapis.com/projectriff/release/0.5.0-snapshot/kpack.yaml -y
kapp deploy -n apps -a riff-builders -f https://storage.googleapis.com/projectriff/release/0.5.0-snapshot/riff-builders.yaml -y
kapp deploy -n apps -a riff-build -f https://storage.googleapis.com/projectriff/release/0.5.0-snapshot/riff-build.yaml -y
```{{execute}}
