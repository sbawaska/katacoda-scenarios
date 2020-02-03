We need a registry to push the container image that was built by riff build. You can use dockerhub, gcr or any other container registry. For this tutorial we will run a registry locally in minikube by running `minikube addons enable registry`{{execute}}. This will start a pod named `registry` and create a service named `registry` in the `kube-system` namespace.
Now, tell riff about the registry where it should push the built images:
`echo -n foo | riff credentials apply my-reg --registry http://registry.kube-system.svc.cluster.local --registry-user tutorial --default-image-prefix registry.kube-system.svc.cluster.local/tutorial`{{execute}}
Then create a function using code from a repository:
`riff function create hello --git-repo https://github.com/projectriff-samples/hello.js --artifact hello.js --tail`{{execute}}
