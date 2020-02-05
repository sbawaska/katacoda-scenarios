We will now deploy the built container on knative by running the command: 
```
riff knative deployer create knative-square --function-ref square --ingress-policy External --tail
```{{execute}}
We can now invoke the function using `curl`. We first need to figure out the IP address of minikube and ingress port.
```
MINIKUBE_IP=$(minikube ip)
INGRESS_PORT=$(kubectl get svc envoy-external  --namespace projectcontour --output 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')
```{{execute}}
Then invoke the function using curl:
```
curl http://$MINIKUBE_IP:$INGRESS_PORT/ -w '\n' \
  -H 'Host: knative-square.default.example.com' \
  -H 'Content-Type: application/json' \
  -d 7
```{{execute}}
