> The startup script running on the bottom right terminal is launching Kubernetes (minikube), starting a local container registry, installing riff's build and streaming components and installing kafka. Once you see a prompt, you can click on the commands below at your own pace, and they will be copied and run for you in the terminal on the right.

First let's ensure that kubernetes is running by issuing `kubectl get pods -A`{{execute}} and waiting for all pods in `kube-system` to start.
Run `watch kubectl get pods -A`{{execute T2}} and switch to `All pods` terminal to see all the system as well as user pods being created.

