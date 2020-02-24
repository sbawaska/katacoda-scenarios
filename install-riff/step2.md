We need a registry to push the container image that is built by riff. You can use dockerhub, gcr or any other container registry. This tutorial is running a local registry. We will set a environment variable to point to the registry

`export REGISTRY=[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Now, provide the registry credentials so that riff can push the built images:
`riff credentials apply my-reg --registry http://$REGISTRY --default-image-prefix $REGISTRY`{{execute}}
In our case there are no credentials, only configure the registry URL.

Then create a function using code from a repository:
`riff function create square --git-repo https://github.com/projectriff-samples/node-square --artifact square.js --tail`{{execute}}
The output of this command will show that the repository is first cloned, then it's content analyzed to determine the language of the function, an appropriate buildpack is then selected, followed by the image being build and then pushed to the registry.
