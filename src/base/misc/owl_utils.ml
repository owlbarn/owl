(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Helper functions used in the library *)


include Owl_utils_conv

include Owl_utils_ndarray

module Stack = Owl_utils_stack

module Array = Owl_utils_array


(* Adjust the index according to the [0, m). m is the boundary, i can be negative. *)
let adjust_index i m =
  if i >= 0 && i < m then i
  else if i < 0 && i >= -m then i + m
  else raise Owl_exception.INDEX_OUT_OF_BOUND


(* Computes a left fold over a range of integers from a to b (inclusive) *)
let range_fold a b ~f ~init =
  let rec go acc x =
    if x > b
    then acc
    else go (f acc x) (x + 1)
  in go init a


let array_reverse x =
  let d = Array.length x - 1 in
  let n = d / 2 in
  for i = 0 to n do
    let t = x.(i) in
    x.(i) <- x.(d - i);
    x.(d - i) <- t;
  done


(* insert element [a] at position [i] in [x] *)
let array_insert x i a =
  let n = Array.length x in
  assert (i <= n);
  let y = Array.make (n + 1) a in
  Array.blit x 0 y 0 i;
  Array.blit x i y (i + 1) (n - i);
  y


(* get the suffix a file name *)
let get_suffix s =
  let parts = String.split_on_char '.' s in
  List.(nth parts (length parts - 1))


let count_dup l =
  match l with
  | []     -> []
  | hd::tl ->
      let acc,x,c = List.fold_left
        (fun (acc,x,c) y -> if y = x then acc,x,c+1 else (x,c)::acc, y,1)
        ([],hd,1) tl
      in (x,c)::acc


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


(* search the list given a value, return the position of its first occurrence *)
let list_search x l =
  let rec _search x l c =
    match l with
    | []     -> raise Not_found
    | hd::tl -> if hd = x then c else _search x tl (c + 1)
  in
  _search x l 0


(* flatten an array2 then convert to array1 *)
let array2_to_array1 x =
  let open Bigarray in
  let m = Array2.dim1 x in
  let n = Array2.dim2 x in
  let c = m * n in
  let x = genarray_of_array2 x in
  reshape_1 x c


(* pretty-print an array to string *)
let string_of_array ?(prefix="") ?(suffix="") ?(sep=",") string_of_x x =
  let s = Array.to_list x |> List.map string_of_x |> String.concat sep in
  Printf.sprintf "%s%s%s" prefix s suffix

(* iter function for ['a array array] type *)
let aarr_iter f x = Array.iter (Array.iter f) x

(* iteri function for ['a array array] type *)
let aarr_iteri f x = Array.iteri (fun i y -> Array.iteri (fun j z -> f i j z) y) x

(* map function for ['a array array] type *)
let aarr_map f x = Array.map (Array.map f) x

(* mapi function for ['a array array] type *)
let aarr_mapi f x = Array.mapi (fun i y -> Array.mapi (fun j z -> f i j z) y) x

(* map2 function for ['a array array] type, x and y must have the same shape. *)
let aarr_map2 f x y = Array.map2 (Array.map2 f) x y

(* map2i function for ['a array array] type, x and y must have the same shape. *)
let aarr_map2i f x0 x1 =
  Array.map2i (fun i y0 y1 ->
    Array.map2i (fun j z0 z1 -> f i j z0 z1) y0 y1
  ) x0 x1

(* map3i function for ['a array array] type, all must have the same shape. *)
let aarr_map3i f x0 x1 x2 =
  Array.init (Array.length x0) (fun i ->
    Array.init (Array.length x0.(i)) (fun j ->
      f i j x0.(i).(j) x1.(i).(j) x2.(i).(j)
    )
  )

(* map3 function for ['a array array] type, all must have the same shape. *)
let aarr_map3 f x0 x1 x2 =
  Array.init (Array.length x0) (fun i ->
    Array.init (Array.length x0.(i)) (fun j ->
      f x0.(i).(j) x1.(i).(j) x2.(i).(j)
    )
  )

(* map4 function for ['a array array] type, all must have the same shape. *)
let aarr_map4 f x0 x1 x2 x3 =
  Array.init (Array.length x0) (fun i ->
    Array.init (Array.length x0.(i)) (fun j ->
      f x0.(i).(j) x1.(i).(j) x2.(i).(j) x3.(i).(j)
    )
  )

(* convert array of array to list of list, shape remains the same *)
let aarr2llss x = Array.map Array.to_list x |> Array.to_list

(* convert list of list to array of array, shape remains the same *)
let llss2aarr x = List.map Array.of_list x |> Array.of_list

(* fold function for ['a array array] type, by flatten the array *)
let aarr_fold f a x =
  let a = ref a in
  Array.iter (Array.iter (fun b -> a := f !a b)) x;
  !a

(* make a matrix of array array type, fill with value a *)
let aarr_matrix m n a = Array.init m (fun _ -> Array.make n a)

(* extend passed in array by appending n slots *)
let array1_extend x n =
  let open Bigarray in
  let m = Array1.dim x in
  let y = Array1.(create (kind x) c_layout (m + n)) in
  let z = Array1.sub y 0 m in
  Array1.blit x z;
  y

(* make a copy of the passed in array1 *)
let array1_copy x =
  let open Bigarray in
  let y = Array1.(create (kind x) c_layout (dim x)) in
  Array1.blit x y;
  y


(* format time period into human-readable format *)
let format_time t =
  if t < 60. then
    Printf.sprintf "%02is" (int_of_float t)
  else if t >= 60. && t < 3600. then (
    let m = int_of_float (t /. 60.) in
    let s = (int_of_float t) mod 60 in
    Printf.sprintf "%02im%02is" m s
  )
  else (
    let h = int_of_float (t /. 3600.) in
    let m = int_of_float (t /. 60.) mod 60 in
    Printf.sprintf "%ih%02im" h m
  )


(* read a file of a given path *)
let read_file ?(trim=true) f =
  let h = open_in f in
  let s = Stack.make () in
  (
    try while true do
      let l = match trim with
        | true  -> input_line h |> String.trim
        | false -> input_line h
      in
      Stack.push s l;
    done with End_of_file -> ()
  );
  close_in h;
  Stack.to_array s


let read_file_string f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  Bytes.to_string s


(* write a file of a given path *)
let write_file f s =
  let h = open_out f in
  Printf.fprintf h "%s" s;
  close_out h


(** measure the time spent in a function in millisecond *)
let time f =
  let t = Unix.gettimeofday () in
  f ();
  (Unix.gettimeofday () -. t) *. 1000.


(** TODO: return the the distance between [1.0] and the next larger representable
  floating-point value. *)
let eps
  : type a b. (a, b) Bigarray.kind -> float
  =
  let open Bigarray in
  function
  | Float32   -> 2. ** (-23.)
  | Float64   -> 2. ** (-52.)
  | Complex32 -> 2. ** (-23.)
  | Complex64 -> 2. ** (-52.)
  | _         -> failwith "owl_utils:eps"



(* ends here *)
