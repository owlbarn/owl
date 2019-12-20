############################################################
# Dockerfile to build OpenBLAS image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ocaml/opam2:ubuntu
USER opam

##################### PREREQUISITES ########################

RUN sudo apt-get update
RUN sudo apt-get install -y git gfortran apt-utils

WORKDIR /home/opam
RUN git clone https://github.com/xianyi/OpenBLAS.git
RUN make -C /home/opam/OpenBLAS/
