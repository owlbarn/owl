(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let check p e =
  if p = false then raise e

exception NOT_IMPLEMENTED

exception FOUND

exception NOT_FOUND

exception EMPTY_ARRAY

exception TEST_FAIL

exception NOT_SQUARE

exception DIFFERENT_SHAPE

exception NOT_BROADCASTABLE

exception NOT_CONVERGE

exception MAX_ITERATION

exception SINGULAR
