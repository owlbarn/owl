#!/usr/bin/env owl
#zoo "5ca2fdebb0ccb9ecee6f4331972a9087"
(* Performance test of slicing function *)

open Owl
open Perf_common


let run_perftest c =
  let x = Arr.uniform [|10; 3000; 3000|] in
  let y = Arr.uniform [|3000; 3000; 10|] in
  (* slice definitions for testing *)
  let s0 = [L[-1;0]; R[]; R[]] in
  let s1 = [L[-1;0]; R[-1;0]; R[]] in
  let s2 = [L[-1;0]; R[-1;0]; R[-1;0;]] in
  let s3 = [R[]; L[-1;0]; R[]] in
  let s4 = [R[]; R[-1;0]; L[-1;0]] in
  let s5 = [R[]; R[]; L[-1;0]] in
  let s6 = [R[]; L[0;-1]; R[-1;0;]] in
  let s7 = [R[]; L[0;-1]; R[-1;0;-2]] in
  let s8 = [R[]; R[0;-1;2]; L[-1;0;-2]] in
  let s9 = [L[-1;0]; R[]; L[-1;0;-2]] in
  (* config then test *)
  let c = 1 in
  test_op "get_slice s0 x     " c (fun () -> Arr.get_slice s0 x);
  test_op "get_slice s1 x     " c (fun () -> Arr.get_slice s1 x);
  test_op "get_slice s2 x     " c (fun () -> Arr.get_slice s2 x);
  test_op "get_slice s3 x     " c (fun () -> Arr.get_slice s3 x);
  test_op "get_slice s4 x     " c (fun () -> Arr.get_slice s4 x);
  test_op "get_slice s5 x     " c (fun () -> Arr.get_slice s5 x);
  test_op "get_slice s6 x     " c (fun () -> Arr.get_slice s6 x);
  test_op "get_slice s7 x     " c (fun () -> Arr.get_slice s7 x);
  test_op "get_slice s8 x     " c (fun () -> Arr.get_slice s8 x);
  test_op "get_slice s9 x     " c (fun () -> Arr.get_slice s9 x);
  test_op "get_slice s0 y     " c (fun () -> Arr.get_slice s0 y);
  test_op "get_slice s1 y     " c (fun () -> Arr.get_slice s1 y);
  test_op "get_slice s2 y     " c (fun () -> Arr.get_slice s2 y);
  test_op "get_slice s3 y     " c (fun () -> Arr.get_slice s3 y);
  test_op "get_slice s4 y     " c (fun () -> Arr.get_slice s4 y);
  test_op "get_slice s5 y     " c (fun () -> Arr.get_slice s5 y);
  test_op "get_slice s6 y     " c (fun () -> Arr.get_slice s6 y);
  test_op "get_slice s7 y     " c (fun () -> Arr.get_slice s7 y);
  test_op "get_slice s8 y     " c (fun () -> Arr.get_slice s8 y);
  test_op "get_slice s9 y     " c (fun () -> Arr.get_slice s9 y)


let _ = run_perftest 5
