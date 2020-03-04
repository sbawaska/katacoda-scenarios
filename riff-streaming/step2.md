Let's now create a time-averager function that emits an average of the input numbers computed every 10 seconds. Copy the code below to the editor on the right.
<pre class="file" data-filename="TimeAverager.java" data-target="replace">package com.acme;

import java.time.Duration;
import java.util.function.Function;
import reactor.core.publisher.Flux;
import reactor.math.MathFlux;

public class TimeAverager implements Function&lt;Flux&lt;Float&gt;, Flux&lt;Float&gt;&gt; {

	@Override
	public Flux&lt;Float&gt; apply(Flux&lt;Float&gt; floatFlux) {
		return floatFlux.window(Duration.ofSeconds(10)).flatMap(MathFlux::averageFloat);
	}
}
</pre>

We will now build a container with a language runtime and a riff invoker for this function. We need a registry to push the container image that is built by riff. You can use dockerhub, gcr or any other container registry. This tutorial is running a local registry. We will set a environment variable to point to the registry

`export REGISTRY=[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com`{{execute}}

Now, provide the registry credentials so that riff can push the built images:
`riff credentials apply my-reg --registry http://$REGISTRY --default-image-prefix $REGISTRY`{{execute}}
In our case there are no credentials, only configure the registry URL.

Build the function using `riff function create time-averager --local-path ./time-averager --tail`{{execute}}

The logs here show that the programming language was detected as Java and the appropriate runtime and invoker layer were added to build a container.
