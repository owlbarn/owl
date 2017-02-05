(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type dual = Float of float | Node of node
and node = {
  v : dual;
  d : dual;
}
