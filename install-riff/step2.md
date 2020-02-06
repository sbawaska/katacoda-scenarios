We need a registry to push the container image that is built by riff. You can use dockerhub, gcr or any other container registry. For this tutorial we will start the container registry provided by minikube as an addon.
`minikube addons enable registry`{{execute}}

Now, provide the registry credentials so that riff can push the built images:
`riff credentials apply my-reg --registry http://$(minikube ip):5000 --default-image-prefix $(minikube ip):5000`
In our case there are no credentials, only configure the registry URL.

Then create a function using code from a repository:
`riff function create square --git-repo https://github.com/projectriff-samples/node-square --artifact square.js --tail`{{execute}}
The output of this command will show that the repository is first cloned, then it's content analyzed to determine the language of the function, an appropriate buildpack is then selected, followed by the image being build and then pushed to the registry (in our case, dockerhub).
