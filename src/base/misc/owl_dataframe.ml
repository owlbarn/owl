(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type elt =
  | Int'    of int
  | Float'  of float
  | String' of string


type series =
  | Int    of int array
  | Float  of float array
  | String of string array
  | Any


type t = {
  mutable data : series array;
  mutable head : (string, int) Hashtbl.t;
  mutable used : int;
  mutable size : int;
}


let unpack_int' = function Int' x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_float' = function Float' x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_string' = function String' x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_int = function Int x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_float = function Float x -> x | _ -> raise Owl_exception.NOT_SUPPORTED

let unpack_string = function String x -> x | _ -> raise Owl_exception.NOT_SUPPORTED


let make head_names =
  let col_num = Array.length head_names in
  let data = Array.make col_num Any in
  let head = Hashtbl.create 64 in
  Array.iteri (fun i s ->
    assert (Hashtbl.mem head s = false);
    Hashtbl.add head s i
  ) head_names;
  let used = 0 in
  let size = 0 in
  { data; head; used; size }


let allocate_space data =
  Array.(map (function
    | Int c    -> Int (append c (copy c))
    | Float c  -> Float (append c (copy c))
    | String c -> String (append c (copy c))
    | Any      -> Any
  ) data)


let assign x i a =
  match a with
  | Int' a    -> (unpack_int x).(i) <- a
  | Float' a  -> (unpack_float x).(i) <- a
  | String' a -> (unpack_string x).(i) <- a


let init_series n a =
  match a with
  | Int' a    -> Int (Array.make n a)
  | Float' a  -> Float (Array.make n a)
  | String' a -> String (Array.make n a)


let length_series x =
  match x with
  | Int a    -> Array.length a
  | Float a  -> Array.length a
  | String a -> Array.length a
  | Any      -> 0


let append x row =
  if x.size = 0 then (
    let n = 16 in
    x.data <- Array.map (init_series n) row;
    x.size <- n;
    x.used <- 1
  )
  else (
    if x.used = x.size then (
      x.data <- allocate_space x.data;
      x.size <- length_series x.data.(0)
    );
    Array.iteri (fun i a -> assign x.data.(i) x.used a) row;
    x.used <- x.used + 1
  )


let get_row x i = ()


let get_col x j = ()
