Let's now create a time-averager function that emits an average of the input numbers computed every 10 seconds. Copy the code below to the editor on the right.
<pre class="file" data-filename="TimeAverager.java" data-target="prepend">
package com.acme;

import java.time.Duration;
import java.util.function.Function;
import reactor.core.publisher.Flux;
import reactor.math.MathFlux;

public class TimeAverager implements Function<Flux<Float>, Flux<Float>> {

	@Override
	public Flux<Float> apply(Flux<Float> floatFlux) {
		return floatFlux.window(Duration.ofSeconds(10)).flatMap(MathFlux::averageFloat);
	}
}
</pre>
