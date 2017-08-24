#!/usr/bin/env owl
(* Test Regression module *)

open Owl

let generate_data () =
  let x = Mat.uniform 1000 3 in
  let p = Mat.uniform 3 1 in
  let y = Mat.(x *@ p) in
  x, p, y


let test_ols () =
  let x, p, y = generate_data () in
  let r = Regression.D.ols ~i:false x y in
  Mat.(p - r.(0) |> print)


let test_lasso () =
  let x, p, y = generate_data () in
  let r = Regression.D.lasso ~i:false x y in
  Mat.(p - r.(0) |> print)


let test_ridge () =
  let x, p, y = generate_data () in
  let r = Regression.D.ridge ~i:true ~a:1e-4 x y in
  Mat.(p - r.(0) |> print)


let _ =
  Log.info "test ols"; test_ols (); flush_all ();
  Log.info "test lasso"; test_lasso (); flush_all ();
  Log.info "test ridge"; test_ridge (); flush_all ()
