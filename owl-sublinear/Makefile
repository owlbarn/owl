all: countmin_memprof countmin_perf_comparison

countmin_memprof: countmin_memprof.ml
	ocamlbuild -use-ocamlfind -pkgs 'owl,owl-base,owl-plplot,ocaml-getrusage' 'countmin_memprof.byte'

countmin_perf_comparison: countmin_perf_comparison.ml
	ocamlbuild -use-ocamlfind -pkgs 'owl,owl-base,owl-plplot' 'countmin_perf_comparison.byte'

distributed: countmin_perf_comparison.ml
	ocamlbuild -use-ocamlfind -pkgs 'owl,owl-base,owl-plplot' 'countmin_distributed.byte'

clean:
	rm *.native *.byte