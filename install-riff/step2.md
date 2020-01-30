We need a registry to push the container image that was built by riff build. You can use dockerhub, gcr or any other container registry. For this tutorial we will run a registry locally in minikube by running `minikube addons enable registry`{{execute}}. This will start a pod named `registry` and create a service named `registry` in the `kube-system` namespace.
Now, tell riff about the registry where it should push the built images:
`riff credentials apply my-creds --registry http://registry.kube-system.svc.cluster.local --registry-user tutorial --set-default-image-prefix`{{execute}}
