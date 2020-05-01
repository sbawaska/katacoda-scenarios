## Deploy an application

We are going to deploy the [Hello world sample application](https://knative.dev/docs/serving/samples/hello-world/helloworld-go/). This application reads in an env variable TARGET and prints `Hello ${TARGET}!`. If TARGET is not specified, it will use `World` as the TARGET.

We will now deploy the application by specfying the image location and the `TARGET` env variable.

```
kn service create demo --image gcr.io/knative-samples/helloworld-go --env TARGET=blue
```{{execute}}
