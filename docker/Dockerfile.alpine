FROM ocaml/opam:alpine_ocaml-4.06.0
MAINTAINER Roger Stark

USER opam

RUN sudo apk update && \
    sudo apk add m4 wget unzip aspcud openblas-dev

RUN opam install -y oasis jbuilder ocaml-compiler-libs ctypes alcotest utop 

#################### SET UP ENV VARS #######################

ENV PATH /home/opam/.opam/4.06.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /home/opam/.opam/4.06.0/lib/stublibs
ENV LD_LIBRARY_PATH /usr/lib/:/usr/local/lib:/home/opam/.opam/4.06.0/lib/:/home/opam/.opam/4.06.0/lib/stublibs/:/home/opam/.opam/4.06.0/lib/stubslibs/

RUN echo "#require \"owl_top\";; open Owl;;" >> /home/opam/.ocamlinit \
    && bash -c 'echo -e "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> /home/opam/.profile' \
    && opam config env >> /home/opam/.profile \
    && bash -c "source /home/opam/.profile"

#################### INSTALL EIGEN   #######################

ENV EIGENPATH /home/opam/eigen
RUN cd /home/opam/ && git clone https://github.com/ryanrhymes/eigen.git

RUN sed -i -- 's/-Wno-extern-c-compat -Wno-c++11-long-long -Wno-invalid-partial-specialization/-Wno-ignored-attributes/g' $EIGENPATH/lib/Makefile \
    && sed -i -- 's/typedef int64_t INDEX;/#include <stdint.h>\ntypedef int64_t INDEX;/g' $EIGENPATH/lib/eigen_dsmat.h $EIGENPATH/lib/eigen_spmat.h \
    && sed -i -- 's/-flto/ /g' $EIGENPATH/lib/Makefile \
    && sed -i -- 's/-flto/ /g' $EIGENPATH/_oasis 

RUN cd $EIGENPATH \
    && sudo make oasis && sudo make && sudo make install 

####################   INSTALL OWL  #######################

ENV OWLPATH /home/opam/owl
RUN cd /home/opam && git clone https://github.com/ryanrhymes/owl.git

RUN rm -f $OWLPATH/src/owl/misc/owl_plot.* \
    && sed -i '/plplot/d' $OWLPATH/src/owl/jbuild \
    && sed -i '/module Plot = Owl_plot/d' $OWLPATH/src/owl/owl.ml \
    && sed -i '/output h$/,+2d; /h filename ;$/a *)' $OWLPATH/test/unit_stats_rvs.ml \
    && sed -i '/let plot_comparison/i (*' $OWLPATH/test/unit_stats_rvs.ml

RUN cd $OWLPATH \
    && make && make install

WORKDIR $OWLPATH
ENTRYPOINT /bin/sh
