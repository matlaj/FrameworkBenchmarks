# Build the app locally.
.PHONY: build
build:
	rebar3 release

# Connect to the containerized app via a remote Erlang shell.
.PHONY: remote
remote:
	docker exec -it tfb-server ./_build/default/rel/hello_world/bin/hello_world remote

# Run TFB in benchmark mode.
.PHONY: benchmark
benchmark:
	cd ../../.. && \
	./tfb --mode benchmark --test-lang Erlang --test cowboy

# Run TFB in verify mode.
.PHONY: verify
verify:
	cd ../../../ && \
	./tfb --mode verify --test-lang Erlang --test cowboy

# Run TFB in debug mode.
.PHONY: debug
debug:
	cd ../../../ && \
	./tfb --mode debug --test-lang Erlang --test cowboy --type plaintext
