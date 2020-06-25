(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let gcc_preprocess in_file =
  let out_file = Filename.temp_file "" "" in
  let cmd = Printf.sprintf "gcc -E -P %s -o %s" in_file out_file in
  let r = Sys.command cmd in
  if r <> 0 then failwith "gcc preprocess";
  let ic = open_in out_file in
  Fun.protect
    (fun () ->
      let n = in_channel_length ic in
      let s = Bytes.create n in
      really_input ic s 0 n;
      Bytes.to_string s)
    ~finally:(fun () -> close_in ic)


let post_process kernel_code = String.trim kernel_code

let make_kernel fname kernel_code =
  let h = open_out fname in
  Fun.protect
    (fun () ->
      let ml_code = Printf.sprintf "let code = \"\n%s\"\n" kernel_code in
      Printf.fprintf h "%s" ml_code)
    ~finally:(fun () -> close_out h)


let _ =
  let raw_kernel_code = gcc_preprocess "owl_opencl_kernel.h" in
  let kernel_code = post_process raw_kernel_code in
  make_kernel "owl_opencl_kernel_impl.ml" kernel_code
