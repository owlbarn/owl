(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Currently, the lifting is done by element-by-elment copying. This will be
  very inefficient on large data chunks. The performance of this module needs
  to be improved in the future. *)

open Bigarray
open Owl_ext_types


(* lift precision *)

module DAS_DAD = struct

  module M = Owl_dense_ndarray_generic

  let src_typ = Float32
  let dst_typ = Float64
  let unpack_src = unpack_das
  let pack_dst = pack_dad

  let lift src =
    let src = unpack_src src in
    let dst = M.(empty dst_typ (shape src)) in
    M.iteri (fun i a -> M.set dst i a) src;
    pack_dst dst

end


module DAC_DAZ = struct

  module M = Owl_dense_ndarray_generic

  let src_typ = Complex32
  let dst_typ = Complex64
  let unpack_src = unpack_dac
  let pack_dst = pack_daz

  let lift src =
    let src = unpack_src src in
    let dst = M.(empty dst_typ (shape src)) in
    M.iteri (fun i a -> M.set dst i a) src;
    pack_dst dst

end


module DMS_DMD = struct

  module M = Owl_dense_matrix_generic

  let src_typ = Float32
  let dst_typ = Float64
  let unpack_src = unpack_dms
  let pack_dst = pack_dmd

  let lift src =
    let src = unpack_src src in
    let m, n = M.shape src in
    let dst = M.(empty dst_typ m n) in
    M.iteri (fun i j a -> M.set dst i j a) src;
    pack_dst dst

end


module DMC_DMZ = struct

  module M = Owl_dense_matrix_generic

  let src_typ = Complex32
  let dst_typ = Complex64
  let unpack_src = unpack_dmc
  let pack_dst = pack_dmz

  let lift src =
    let src = unpack_src src in
    let m, n = M.shape src in
    let dst = M.(empty dst_typ m n) in
    M.iteri (fun i j a -> M.set dst i j a) src;
    pack_dst dst

end


(* lift element type *)

module F_C = struct

  let lift src = Complex.({re = unpack_flt src; im = 0.}) |> pack_cpx

end


module DAS_DAC = struct

  module M = Owl_dense_ndarray_generic

  let src_typ = Float32
  let dst_typ = Complex32
  let unpack_src = unpack_das
  let pack_dst = pack_dac

  let lift src =
    let src = unpack_src src in
    let dst = M.(empty dst_typ (shape src)) in
    M.iteri (fun i a -> M.set dst i Complex.({re=a; im=0.})) src;
    pack_dst dst

end


module DAD_DAZ = struct

  module M = Owl_dense_ndarray_generic

  let src_typ = Float64
  let dst_typ = Complex64
  let unpack_src = unpack_dad
  let pack_dst = pack_daz

  let lift src =
    let src = unpack_src src in
    let dst = M.(empty dst_typ (shape src)) in
    M.iteri (fun i a -> M.set dst i Complex.({re=a; im=0.})) src;
    pack_dst dst

end


module DMS_DMC = struct

  module M = Owl_dense_matrix_generic

  let src_typ = Float32
  let dst_typ = Complex32
  let unpack_src = unpack_dms
  let pack_dst = pack_dmc

  let lift src =
    let src = unpack_src src in
    let m, n = M.shape src in
    let dst = M.(empty dst_typ m n) in
    M.iteri (fun i j a -> M.set dst i j Complex.({re=a; im=0.})) src;
    pack_dst dst

end


module DMD_DMZ = struct

  module M = Owl_dense_matrix_generic

  let src_typ = Float64
  let dst_typ = Complex64
  let unpack_src = unpack_dmd
  let pack_dst = pack_dmz

  let lift src =
    let src = unpack_src src in
    let m, n = M.shape src in
    let dst = M.(empty dst_typ m n) in
    M.iteri (fun i j a -> M.set dst i j Complex.({re=a; im=0.})) src;
    pack_dst dst

end


(* lift both precision and element type *)

module DAS_DAZ = struct

  let lift src = src |> DAS_DAD.lift |> DAD_DAZ.lift

end


module DMS_DMZ = struct

  let lift src = src |> DMS_DMD.lift |> DMD_DMZ.lift

end


(* ends here *)
