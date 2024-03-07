############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
############################################################

FROM arm64v8/ubuntu

##################### PREREQUISITES ########################

RUN apt-get update
RUN apt-get -y install git build-essential ocaml wget unzip aspcud m4 pkg-config bubblewrap
RUN apt-get -y install libshp-dev libopenblas-dev liblapacke-dev

ENV VER=2.1.5
RUN wget https://github.com/ocaml/opam/releases/download/$VER/opam-full-$VER.tar.gz \
    && tar -xvf opam-full-$VER.tar.gz \
    && cd opam-full-$VER \
    && ./configure && make lib-ext && make && make install

ENV OCAML_VER=5.1.0
RUN yes | opam init --disable-sandboxing --comp $OCAML_VER && eval $(opam config env) 

RUN apt-get install zlib1g-dev
RUN opam install -y dune ocaml-compiler-libs ctypes alcotest utop conf-openblas dune-configurator stdio npy

####################   Setup Env  #######################

ENV OWLPATH /root/owl
ENV PATH /root/.opam/${OCAML_VER}/bin:/usr/local/sbin/:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /root/.opam/${OCAML_VER}/lib/stublibs

ENV OWL_CFLAGS "-g -O3 -Ofast -march=native -funroll-loops -ffast-math -DSFMT_MEXP=19937 -fno-strict-aliasing -Wno-tautological-constant-out-of-range-compare"
ENV EIGENCPP_OPTFLAGS "-Ofast -march=native -funroll-loops -ffast-math"
ENV EIGEN_FLAGS "-O3 -Ofast -march=native -funroll-loops -ffast-math"

####################   INSTALL OWL  #######################

RUN cd /root && git clone https://github.com/owlbarn/owl.git

# HACK: remove unrecognised sse compiler option on arm; add libraries for linking
RUN sed -i -- 's/linux_elf/linux_eabihf/g' $OWLPATH/src/owl/config/configure.ml \
    && sed -i -- 's/-mfpmath=sse//g' $OWLPATH/src/owl/config/configure.ml \
    && sed -i -- 's/-msse2//g' $OWLPATH/src/owl/config/configure.ml

RUN cd $OWLPATH \
    && eval `opam config env ` \
    && make && make install

############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /root/.ocamlinit \
    && opam config env >> /root/.bashrc \
    && bash -c "source /root/.bashrc"

WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
