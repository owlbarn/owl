(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_types_x


module M = Owl_dense_ndarray


module S = struct

  let _elt = Float32

  let pack_box x = DAS x
  let unpack_box = function DAS x -> x

  let pack_elt x = F x
  let unpack_elt = function F x -> x

  let empty i = M.empty _elt i |> pack_box

  let create i a = M.create _elt i (unpack_elt a) |> pack_box

  let zeros i = M.zeros _elt i |> pack_box

  let ones i = M.ones _elt i |> pack_box

  let uniform ?scale i = M.uniform ?scale _elt i |> pack_box

  let sequential i = M.sequential _elt i |> pack_box


  let shape x = M.shape (unpack_box x)

  let num_dims x = M.num_dims (unpack_box x)

  let nth_dim x = M.nth_dim (unpack_box x)

  let numel x = M.numel (unpack_box x)

  let nnz x = M.nnz (unpack_box x)

  let density x = M.density (unpack_box x)

  let size_in_bytes x = M.size_in_bytes (unpack_box x)

  let same_shape x = M.same_shape (unpack_box x)
  

  let get x i = M.get (unpack_box x) i |> pack_elt

  let set x i a = M.set (unpack_box x) i (unpack_elt a)

end
