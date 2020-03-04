> The startup script running on the bottom right terminal is launching Kubernetes (minikube), starting a local container registry, installing riff's build and streaming components and installing kafka. Once you see a prompt, you can click on the commands below at your own pace, and they will be copied and run for you in the terminal on the right.

Run `watch kubectl get pods -A`{{execute AllPods}} and switch to `All pods` terminal to see all the system as well as user pods being created.

When using the streaming runtime, messages flow between functions using streams, which are backed by some concrete messaging system, such as Apache Kafka, Apache Pulsar etc. *Gateways* abstract away the protocol details of concrete messaging systems (riff uses [liiklus](https://github.com/bsideup/liiklus) to that effect), as well as the way to provision topics/queues corresponding to each stream.
Since we have kafka installed in our cluster, let us create a kafka gateway.
```
riff streaming kafka-gateway create franz --bootstrap-servers kafka.kafka:9092 --tail
```{{execute interrupt}}
Let us now create streams that allow the flow of messages. In our case, this will create topics in kafka.
```
riff streaming stream create in  --gateway franz --content-type application/json
riff streaming stream create out --gateway franz --content-type application/json
```{{execute}}
