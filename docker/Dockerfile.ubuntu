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
RUN apt-get update -y
RUN apt-get install -y m4 wget unzip aspcud libshp-dev libplplot-dev gfortran pkg-config git
RUN cd /home/opam/opam-repository && git pull --quiet origin master
RUN opam update -q

####################   INSTALL OWL  #######################

ENV OWLPATH /home/opam/owl
ENV OWL_DISABLE_LAPACKE_LINKING_FLAG 1
ENV OWL_COMPILE_CFLAGS "-I/opt/OpenBLAS/include -I/home/opam/OpenBLAS/lapack-netlib/LAPACKE/include/ -L/opt/OpenBLAS/lib"
RUN CFLAGS=${OWL_COMPILE_CFLAGS} opam install owl owl-top owl-plplot utop -y

############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /home/opam/.ocamlinit \
    && echo 'eval $(opam env)' >> /home/opam/.bashrc

WORKDIR $OWLPATH
ENTRYPOINT /bin/bash

