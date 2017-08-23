#!/usr/bin/env owl

open Owl


let test_ols () =
  let x = Mat.uniform 1000 3 in
  let p = Mat.uniform 3 1 in
  let y = Mat.(x *@ p) in
  let r = Regression.D.ols ~i:false x y in
  Mat.(p - r.(0) |> print)


let test_lasso () =
  let x = Mat.uniform 1000 3 in
  let p = Mat.uniform 3 1 in
  let y = Mat.(x *@ p) in
  let r = Regression.D.lasso ~i:false x y in
  Mat.(p - r.(0) |> print)


let test_ridge () =
  let x = Mat.uniform 1000 3 in
  let p = Mat.uniform 3 1 in
  let y = Mat.(x *@ p) in
  let r = Regression.D.ridge ~i:true ~a:1e-4 x y in
  Mat.(p - r.(0) |> print)


let _ =
  test_lasso ()
