Ensure that kubernetes is running by running `kubectl get pods -A`{{execute}} and waiting for all pods in `kube-system` to start.
Open an additional terminal by clicking on the `+` next to Terminal and run `watch kubectl get pods -A` to see all the system as well as user pods being created.

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

We now install the knative serving component. knative serving provides the automatic scaling up and down to zero, routing and point-in-time snapshots of deployed code and configurations.

```
ytt -f https://storage.googleapis.com/projectriff/release/0.5.0-snapshot/contour.yaml -f https://storage.googleapis.com/projectriff/charts/overlays/service-nodeport.yaml --file-mark contour.yaml:type=yaml-plain | kapp deploy -n apps -a contour -f - -y

kapp deploy -n apps -a knative -f https://storage.googleapis.com/projectriff/release/0.5.0-snapshot/knative.yaml -y

kapp deploy -n apps -a riff-knative-runtime -f https://storage.googleapis.com/projectriff/release/0.5.0-snapshot/riff-knative-runtime.yaml -y
```{{execute}}
