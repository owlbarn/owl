(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_dense_common_types

(* include the base implementation of slicing function *)

include Owl_base_slicing


(* fancy slicing function *)

let get_fancy_array_typ axis x =
  let _kind = Genarray.kind x in
  (* check axis is within boundary then re-format *)
  let sx = Genarray.dims x in
  let axis = check_slice_definition axis sx in
  (* calculate the new shape for slice *)
  let sy = calc_slice_shape axis in
  let y = Genarray.create _kind C_layout sy in
  (* optimise the shape if possible *)
  let axis', x', y' = optimise_input_shape axis x y in
  (* slicing vs. fancy indexing *)
  if is_basic_slicing axis = true then (
    Owl_slicing_basic.get _kind axis' x' y';
    y
  )
  else (
    Owl_slicing_fancy.get _kind axis' x' y';
    y
  )


let set_fancy_array_typ axis x y =
  let _kind = Genarray.kind x in
  (* check axis is within boundary then re-format *)
  let sx = Genarray.dims x in
  let axis = check_slice_definition axis sx in
  (* validate the slice shape is the same as y's *)
  let sy = calc_slice_shape axis in
  assert (Genarray.dims y = sy);
  (* optimise the shape if possible *)
  let axis', x', y' = optimise_input_shape axis x y in
  (* slicing vs. fancy indexing *)
  if is_basic_slicing axis = true then
    Owl_slicing_basic.set _kind axis' x' y'
  else
    Owl_slicing_fancy.set _kind axis' x' y'


(* Basic slicing function *)

let get_slice_array_typ axis x =
  let _kind = Genarray.kind x in
  let sx = Genarray.dims x in
  let axis = check_slice_definition axis sx in
  let sy = calc_slice_shape axis in
  let y = Genarray.create _kind C_layout sy in
  let axis', x', y' = optimise_input_shape axis x y in
  Owl_slicing_basic.get _kind axis' x' y';
  y


let set_slice_array_typ axis x y =
  let _kind = Genarray.kind x in
  let sx = Genarray.dims x in
  let axis = check_slice_definition axis sx in
  let sy = calc_slice_shape axis in
  assert (Genarray.dims y = sy);
  let axis', x', y' = optimise_input_shape axis x y in
  Owl_slicing_basic.set _kind axis' x' y'


(* same as slice_array_typ function but take list type as slice definition *)
let get_fancy_list_typ axis x = get_fancy_array_typ (sdlist_to_sdarray axis) x


(* same as set_slice_array_typ function but take list type as slice definition *)
let set_fancy_list_typ axis x y = set_fancy_array_typ (sdlist_to_sdarray axis) x y


(* simplified get_slice function which accept list of list as slice definition *)
let get_slice_list_typ axis x =
  let axis = List.map (fun i -> R_ (Array.of_list i)) axis |> Array.of_list in
  get_slice_array_typ axis x


(* simplified set_slice function which accept list of list as slice definition *)
let set_slice_list_typ axis x y =
  let axis = List.map (fun i -> R_ (Array.of_list i)) axis |> Array.of_list in
  set_slice_array_typ axis x y



(* ends here *)
