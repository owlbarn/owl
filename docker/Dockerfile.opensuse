############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ocaml/opam2:opensuse-42.3
USER opam

##################### PREREQUISITES ########################

RUN sudo zypper -n update
RUN sudo zypper -n in git wget unzip m4 pkg-config gcc-fortran
RUN sudo zypper ref && sudo zypper -n in openblas-devel && sudo update-alternatives --config libblas.so.3
RUN sudo zypper -n in plplot-devel
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
