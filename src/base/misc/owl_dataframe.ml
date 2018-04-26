(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type elt =
  | Int    of int
  | Float  of float
  | String of string


type t = {
  mutable data : elt array array;
  mutable head : (string, int) Hashtbl.t;
  mutable used : int;
  mutable size : int;
}


let make head_names =
  let col_num = Array.length head_names in
  let data = Array.make col_num [||] in
  let head = Hashtbl.create 64 in
  Array.iteri (fun i s ->
    assert (Hashtbl.mem head s = false);
    Hashtbl.add head s i
  ) head_names;
  let used = 0 in
  let size = 0 in
  { data; head; used; size }


let allocate_space data =
  Array.map (fun col ->
    Array.(append col (copy col))
  ) data


let append x row =
  if x.size = 0 then (
    let n = 16 in
    x.data <- Array.(map (make n) row);
    x.size <- n;
    x.used <- 1
  )
  else (
    if x.used = x.size then (
      x.data <- allocate_space x.data;
      x.size <- Array.length x.data.(0)
    );
    Array.iteri (fun i a -> x.data.(i).(x.used) <- a) row;
    x.used <- x.used + 1
  )
