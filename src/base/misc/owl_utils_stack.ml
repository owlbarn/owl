(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* A naive implementation of stack for Owl's internal use. *)


type 'a t = {
  mutable used : int;
  mutable size : int;
  mutable data : 'a array;
}

let allocate_space x = Array.(append x (copy x))

let make () = {
  used = 0;
  size = 0;
  data = [||];
}

let push s x =
  if s.size = 0 then s.data <- [|x|];
  if s.used = s.size then (
    s.data <- allocate_space s.data;
    s.size <- Array.length s.data;
  );
  s.data.(s.used) <- x;
  s.used <- s.used + 1

let pop s = match s.used with
  | 0 -> None
  | i -> s.used <- i - 1; Some s.data.(s.used)

let peek s = match s.used with
  | 0 -> None
  | i -> Some s.data.(i - 1)

let is_empty s = s.used = 0

let mem s x = Array.mem x s.data

let memq s x = Array.memq x s.data

let to_array s = Array.sub s.data 0 s.used
