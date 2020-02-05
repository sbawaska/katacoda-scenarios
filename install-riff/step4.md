If you switch to the second terminal quickly enough, you will observe that a `knative-square-deployer-*` pod is created to service your request.

This pod will be terminated after about a minute and will disappear from the list. You can issue the `curl` command again in the first terminal and observe that the pod is started again to service the request.
