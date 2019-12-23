############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM owlbarn/openblas:ubuntu

FROM ocaml/opam2:ubuntu
USER root

#################### INSTALL OPENBLAS ######################

WORKDIR /home/opam
COPY --from=0 /home/opam/OpenBLAS OpenBLAS
RUN make -C OpenBLAS/ install
RUN ldconfig /opt/OpenBLAS/lib/

##################### PREREQUISITES ########################

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y pkg-config m4 zlib1g libplplot-dev plplot-driver-cairo
RUN apt-get remove plplot-driver-qt -y
RUN opam install alcotest utop

####################   INSTALL OWL  #######################

COPY . owl
WORKDIR /home/opam/owl
ENV OWL_DISABLE_LAPACKE_LINKING_FLAG 1
ENV OWL_COMPILE_CFLAGS "-I/opt/OpenBLAS/include -I/home/opam/OpenBLAS/lapack-netlib/LAPACKE/include/ -L/opt/OpenBLAS/lib"
RUN CFLAGS=${OWL_COMPILE_CFLAGS} opam pin .

####################   POST CONFIG  #######################

RUN echo "#require \"owl-top\";; open Owl;;" >> /home/opam/.ocamlinit
RUN echo 'eval $(opam env)' >> /home/opam/.bashrc
ENTRYPOINT /bin/bash
