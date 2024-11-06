############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
############################################################

FROM ubuntu

##################### PREREQUISITES ########################

RUN apt-get update
RUN apt-get -y install aspcud libshp-dev libopenblas-dev liblapacke-dev build-essential wget 
RUN apt-get -y install opam pkg-config zlib1g-dev

ENV OCAML_VER=5.1.0
RUN yes | opam init --disable-sandboxing --comp $OCAML_VER && eval $(opam config env) 
RUN opam install -y dune ocaml-compiler-libs ctypes alcotest utop conf-openblas dune-configurator stdio npy

####################   INSTALL OWL  #######################

ENV OWLPATH /root/owl
# ENV PATH /root/.opam/${OCAML_VER}/bin:/usr/local/sbin/:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
# ENV CAML_LD_LIBRARY_PATH /root/.opam/${OCAML_VER}/lib/stublibs
#ENV OWL_CFLAGS "-g -O3 -Ofast -march=native -funroll-loops -ffast-math -DSFMT_MEXP=19937 -fno-strict-aliasing -Wno-tautological-constant-out-of-range-compare"

RUN cd /root && git clone https://github.com/owlbarn/owl.git

RUN cd $OWLPATH \
    && eval `opam config env ` \
    && make && make install

############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /root/.ocamlinit \
    && opam config env >> /root/.bashrc \
    && bash -c "source /root/.bashrc"

WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
