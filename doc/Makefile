ODIGDOC=/Users/liang/.opam/4.05.0/var/cache/odig/odoc/owl
DIR="../lib"
DOCS=\
	${DIR}/owl_cblas.mli \
	${DIR}/owl_lapacke.ml \
	${DIR}/owl_lapacke_generated.mli \
	${DIR}/owl_dense_matrix.ml \
	${DIR}/owl_dense_matrix_generic.mli \
	${DIR}/owl_dense_ndarray_generic.mli \
	${DIR}/owl_sparse_matrix_generic.mli \
	${DIR}/owl_sparse_ndarray_generic.mli \
	${DIR}/owl_linalg.mli \
	${DIR}/owl_maths.mli \
	${DIR}/owl_stats.mli \
	${DIR}/owl_regression.mli \
	${DIR}/owl_algodiff_generic.mli \
	${DIR}/owl_algodiff_numerical.mli \
	${DIR}/owl_plot.mli \
	${DIR}/owl_operator.ml \
	${DIR}/owl_fft.mli \
	${DIR}/owl_const.mli \
	${DIR}/neural/owl_neural.ml \
	${DIR}/neural/owl_neural_neuron.ml \
	${DIR}/neural/owl_neural_feedforward.ml \
	${DIR}/neural/owl_neural_graph.ml \
	${DIR}/neural/owl_neural_optimise.ml \
	${DIR}/nlp/owl_nlp.ml \
	${DIR}/nlp/owl_nlp_vocabulary.ml \
	${DIR}/nlp/owl_nlp_corpus.ml \
	${DIR}/nlp/owl_nlp_tfidf.ml \
	${DIR}/nlp/owl_nlp_lda.ml
INCDIR=\
	-I ../_build/lib \
	-I ../_build/lib/neural \
	-I ../_build/lib/nlp \
	-I `ocamlfind query ctypes` \
	-I `ocamlfind query gsl`
DOCFLAGS=-html -d .
all:
	### ocamldoc ${INCDIR} ${DOCFLAGS} ${DOCS}
	odig odoc owl && odig doc owl
install:
	### scp -i ~/.ssh/id_cam * lw525@slogin.cl.cam.ac.uk:~/public_html/owl/
	### scp -r -i ~/.ssh/id_cam /Users/liang/.opam/4.04.0/var/cache/odig/odoc/odoc.css lw525@slogin.cl.cam.ac.uk:~/public_html/
	scp -r -i ~/.ssh/id_cam ${ODIGDOC} lw525@slogin.cl.cam.ac.uk:~/public_html/
clean:
	rm -rf *.html *.css
