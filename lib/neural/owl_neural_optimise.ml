(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type batch =
  | Fullbatch
  | Minibatch of int
  | Stochastic

type params = {
  mutable pochs : int;
  mutable batch : batch;
}
