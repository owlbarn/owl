(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Helper functions used in the library *)

let range a b =
  let r = Array.make (b - a + 1) 0 in
  for i = a to b do r.(i - a) <- i done; r


(* Computes a left fold over a range of integers from a to b (inclusive) *)
let range_fold a b ~f ~init =
  let rec go acc x =
    if x > b
    then acc
    else go (f acc x) (x + 1)
  in go init a


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

(* pad n value of v to the left/right of array x *)
let array_pad s x v n =
  let l = Array.length x in
  let y = Array.make (l + n) v in
  let _ = match s with
    | `Left  -> Array.blit x 0 y n l
    | `Right -> Array.blit x 0 y 0 l
  in y


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
  array_map2i (fun i y0 y1 ->
    array_map2i (fun j z0 z1 -> f i j z0 z1) y0 y1
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

(* convert array of array to list of list, shape remains the same *)
let aarr2llss x = Array.map Array.to_list x |> Array.to_list

(* convert list of list to array of array, shape remains the same *)
let llss2aarr x = List.map Array.of_list x |> Array.of_list

(* fold function for ['a array array] type, by flatten the array *)
let aarr_fold f a x =
  let a = ref a in
  Array.iter (Array.iter (fun b -> a := f !a b)) x;
  !a

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


module Stack = struct

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
    | i -> s.used <- i - 1; Some s.data.(i)

  let peek s = match s.used with
    | 0 -> None
    | i -> Some s.data.(i)

  let to_array s = Array.sub s.data 0 s.used

end


(* ends here *)
