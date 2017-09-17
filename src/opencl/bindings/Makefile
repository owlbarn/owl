all:
	./owl_opencl_parser.ml opencl12/ owl_opencl_bindings.ml owl_opencl_generated.ml
	./owl_opencl_stubgen.ml -ml > owl_opencl_ctypes.ml
	./owl_opencl_stubgen.ml -c \
		| sed 's/char\*\*/const char\*\*/g' \
		| sed 's/void\*\*/const void\*\*/g' \
		> owl_opencl_generated_stub.c

install:
	cp owl_opencl_generated* ../

clean:
	rm owl_opencl_ctypes.ml
	rm owl_opencl_bindings.ml
	rm owl_opencl_generated*
