#
# Dockerfile for Travis CI for Owl
# Liang Wang <ryanrhymes@gmail.com>
#

FROM ocaml/opam2:ubuntu-16.04-ocaml-4.06.0
USER opam

RUN sudo apt-get update -y && sudo apt-get install -y \
      aspcud \
      camlp4-extra \
      gfortran \
      git \
      liblapacke-dev \
      libopenblas-dev \
      libplplot-dev \
      libshp-dev \
      m4 \
      pkg-config \
      unzip \
      wget

RUN opam update -yu && opam switch 4.06.0 \
    && opam config exec -- opam install -y \
         alcotest \
         base \
         configurator \
         ctypes \
         eigen \
         jbuilder \
         oasis \
         ocaml-compiler-libs \
         plplot \
         stdio \
         utop

ENV OWLPATH /home/opam/owl

RUN cd /home/opam && git clone https://github.com/owlbarn/owl.git

RUN sed -i -- 's/-lopenblas/-lopenblas -llapacke/g' \
      $OWLPATH/src/owl/config/configure.ml  # FIXME: hacking
RUN sed -i -- 's:/usr/local/opt/openblas/lib:/usr/lib/x86_64-linux-gnu/:g' \
      $OWLPATH/src/owl/config/configure.ml  # FIXME: hacking

RUN opam config exec -- make -C $OWLPATH \
    && opam config exec -- make -C $OWLPATH install \
    && opam config exec -- make -C $OWLPATH test \
    && opam config exec -- make -C $OWLPATH clean

RUN echo "#require \"owl_top\";; open Owl;;" >> /home/opam/.ocamlinit
WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
