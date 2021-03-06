Let us now deploy the container from previous step into our k8s cluster by creating a streaming processor and specfying the input and output streams
```
riff streaming processor create averager \
  --function-ref averager \
  --input in \
  --output out --tail
```{{execute T1}}

Before starting to push events, let us watch the input events `kubectl exec riff-dev -it -- subscribe in --payload-encoding raw`{{execute T3}} and output events `kubectl exec riff-dev -it -- subscribe out --payload-encoding raw`{{execute T4}}
> Note: You may have to click twice to run the above commands.

Now, we can push events to the input stream using:
```
kubectl exec riff-dev -it -- publish in --content-type application/json --payload 10
kubectl exec riff-dev -it -- publish in --content-type application/json --payload 20
kubectl exec riff-dev -it -- publish in --content-type application/json --payload -1
```{{execute T1}}
You can change the payload and see the average computed in the `OutputEvents` tab.
> Note: The windowing function implemented by the streaming processor is currently hardcoded to create windows every minute.
