############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ocaml/opam2:fedora-29
USER opam

##################### PREREQUISITES ########################

RUN sudo yum update -y
RUN sudo yum -y install git wget unzip m4 pkg-config gcc-gfortran
RUN sudo dnf -y install openblas-devel plplot-devel
RUN cd /home/opam/opam-repository && git pull --quiet origin master
RUN opam update -q

################## INSTALL OWL LIBRARY #####################

ENV OWLPATH /home/opam/owl
RUN opam install owl owl-top owl-plplot utop -y

############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /home/opam/.ocamlinit
RUN echo 'eval $(opam env)' >> /home/opam/.bashrc
WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
