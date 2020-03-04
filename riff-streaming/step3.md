Let us know deploy the container from previous step into our k8s cluster by creating a streaming processor and specfying the input and output streams
```
riff streaming processor create time-averager \
  --function-ref time-averager \
  --input in \
  --output out
```{{execute}}

Before starting to push events, let us watch the input events `kubectl exec riff-dev -it -- subscribe in --payload-encoding raw`{{execute T2}} and output events `kubectl exec riff-dev -it -- subscribe out --payload-encoding raw`{{execute T3}}

Now, we can push events to the input stream using:
```
kubectl exec riff-dev -it -- publish in --content-type application/json --payload 10
```{{execute}}
You can change the payload and see the average computed over the past 10 seconds in the `Output Events` tab.
> Note: The windowing function implemented by the streaming processor is currently hardcoded to create windows every minute.
