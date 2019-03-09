############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM armv7/armhf-ubuntu:16.04
MAINTAINER Roger Stark <rho.ajax@gmail.com>


##################### PREREQUISITES ########################

RUN apt-get update
RUN apt-get -y install git build-essential ocaml wget unzip aspcud m4 pkg-config
RUN apt-get -y install libshp-dev libplplot-dev
RUN apt-get -y install libopenblas-dev liblapacke-dev

ENV VER=2.0.3
RUN wget https://github.com/ocaml/opam/releases/download/$VER/opam-full-$VER.tar.gz \
    && tar -xvf opam-full-$VER.tar.gz \
    && cd opam-full-$VER \
    && ./configure && make lib-ext && make && make install

RUN opam init && eval $(opam config env)

####################   INSTALL OWL  #######################

ENV OWLPATH /root/owl
ENV OWL_CFLAGS "-g -O3 -Ofast -march=native -funroll-loops -ffast-math -DSFMT_MEXP=19937 -fno-strict-aliasing -Wno-tautological-constant-out-of-range-compare"
ENV EIGENCPP_OPTFLAGS "-Ofast -march=native -funroll-loops -ffast-math"
ENV EIGEN_FLAGS "-O3 -Ofast -march=native -funroll-loops -ffast-math"
RUN opam install owl owl-plplot -y

############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /root/.ocamlinit \
    && opam config env >> /root/.bashrc \
    && bash -c "source /root/.bashrc"

WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
