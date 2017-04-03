(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Helper functions used in the library *)

let range a b =
  let r = Array.make (b - a + 1) 0 in
  for i = a to b do r.(i - a) <- i done; r

(* filter array, f : int -> 'a -> bool * 'b *)
let array_filteri_v f x =
  (* FIXME: bad idea if f is not pure *)
  let atype = snd (f 0 x.(0)) in
  let r = Array.make (Array.length x) atype and c = ref 0 in
  for i = 0 to Array.length x - 1 do
    let y, z = f i x.(i) in
    if y = true then (r.(!c) <- z; c := !c + 1)
  done;
  Array.sub r 0 !c

(* filter array, f : 'a -> bool * 'b *)
let array_filter_v f x = array_filteri_v (fun _ y -> f y) x

(* filter array, f : int -> 'a -> bool *)
let array_filteri f x =
  if Array.length x = 0 then [||]
  else (
    let r = Array.make (Array.length x) x.(0) and c = ref 0 in
    for i = 0 to Array.length x - 1 do
      if f i x.(i) then (r.(!c) <- x.(i); c := !c + 1)
    done;
    Array.sub r 0 !c
  )

(* filter array, f : 'a -> bool *)
let array_filter f x = array_filteri (fun _ y -> f y) x

let array_mapi f x =
  let atype = f 0 x.(0) in
  let r = Array.make (Array.length x) atype in
  for i = 0 to Array.length x - 1 do
    r.(i) <- f i x.(i)
  done; r

let array_map f x = array_mapi (fun _ y -> f y) x

(*
let array_exists f x =
  try Array.iter (fun a -> if f a then failwith "found") x; false
  with exn -> true

let array_mem a x =
  try Array.iter (fun b -> if b = a then failwith "found") x; false
  with exn -> true
*)

let reverse_array x =
  let d = Array.length x - 1 in
  let n = d / 2 in
  for i = 0 to n do
    let t = x.(i) in
    x.(i) <- x.(d - i);
    x.(d - i) <- t;
  done

(* get the suffix a file name *)
let get_suffix s =
  let parts = Str.(split (regexp "\\.")) s in
  List.(nth parts (length parts - 1))

(* deal with the issue: OCaml 4.02.3 does not have Array.iter2
  eventually we need to move to OCaml 4.03.0 *)
let array_iter2 f x y =
  let c = min (Array.length x) (Array.length y) in
  for i = 0 to c - 1 do
    f x.(i) y.(i)
  done

let array_iter3 f x y z =
  let c = min (Array.length x) (Array.length y) |> min (Array.length z) in
  for i = 0 to c - 1 do
    f x.(i) y.(i) z.(i)
  done

let array_map2i f x y =
  let c = min (Array.length x) (Array.length y) in
  Array.init c (fun i -> f i x.(i) y.(i))

(* map two arrays, and split into two arrays, f returns 2-tuple *)
let array_map2i_split2 f x y =
  let c = min (Array.length x) (Array.length y) in
  match c with
  | 0 -> [||], [||]
  | _ -> (
    let a, b = f 0 x.(0) y.(0) in
    let z0 = Array.make c a in
    let z1 = Array.make c b in
    for i = 1 to c - 1 do
      let a, b = f i x.(i) y.(i) in
      z0.(i) <- a;
      z1.(i) <- b;
    done;
    z0, z1
  )

let array_sum x = Array.fold_left (+.) 0. x

let array1_iter f x =
  let open Bigarray in
  for i = 0 to Array1.dim x - 1 do
    f (Array1.unsafe_get x i)
  done

let array1_iteri f x =
  let open Bigarray in
  for i = 0 to Array1.dim x - 1 do
    f i (Array1.unsafe_get x i)
  done

(* pad n value of v to the left/right of array x *)
let array_pad s x v n =
  let l = Array.length x in
  let y = Array.make (l + n) v in
  let _ = match s with
    | `Left  -> Array.blit x 0 y n l
    | `Right -> Array.blit x 0 y 0 l
  in y

(* extend passed in array by appending n slots *)
let array1_extend x n =
  let open Bigarray in
  let m = Array1.dim x in
  let y = Array1.(create (kind x) c_layout (m + n)) in
  let z = Array1.sub y 0 m in
  Array1.blit x z;
  y

(* make a copy of the passed in array1 *)
let array1_clone x =
  let open Bigarray in
  let y = Array1.(create (kind x) c_layout (dim x)) in
  Array1.blit x y;
  y

(* save a marshalled object to a file *)
let marshal_to_file x f =
  let s = Marshal.to_string x [] in
  let h = open_out f in
  output_string h s;
  close_out h

(* load a marshalled object from a file *)
let marshal_from_file f =
  let h = open_in f in
  let s = really_input_string h (in_channel_length h) in
  Marshal.from_string s 0

(* check if passed-in variable is a row vector *)
let check_row_vector x =
  if Bigarray.Array2.dim1 x <> 1 then
    failwith "error: the variable is not a row vector"
