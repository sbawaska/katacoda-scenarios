## Install Knative Serving
> The startup script running on the right will install the `kn` cli and wait for kubernetes to start. Once you see a prompt, you can click on the commands below at your own pace, and they will be copied and run for you in the terminal on the right.

1. Install the `kn` cli
    ```
    wget https://storage.googleapis.com/knative-nightly/client/latest/kn-linux-amd64 -O kn
    chmod +x kn
    mv kn /usr/local/bin/
    ```{{execute}}