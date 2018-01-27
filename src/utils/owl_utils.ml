(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
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
  let parts = Str.(split (regexp "\\.")) s in
  List.(nth parts (length parts - 1))

let count_dup l =
  match l with
  | [] -> []
  | hd::tl -> let acc,x,c =
                List.fold_left
                  (fun (acc,x,c) y -> if y = x then acc,x,c+1 else (x,c)::acc, y,1)
                  ([],hd,1)
                  tl
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

(* check if passed-in variable is a row vector *)
let check_row_vector x = assert ((Bigarray.Genarray.dims x).(0) = 1)

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


(* A simple stack implementation *)

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

  let is_empty s = s.size = 0

  let mem s x = Array.mem x s.data

  let memq s x = Array.memq x s.data

  let to_array s = Array.sub s.data 0 s.used

end


(* Enhanced Array module *)

module Array = struct

  include Array

  (* filter array, f : int -> 'a -> bool * 'b *)
  let filteri_v f x =
    let r = Stack.make () in
    iteri (fun i a ->
      let y, z = f i a in
      if y = true then Stack.push r z
    ) x;
    Stack.to_array r

  (* filter array, f : 'a -> bool * 'b *)
  let filter_v f x = filteri_v (fun _ y -> f y) x

  (* filter array, f : int -> 'a -> bool *)
  let filteri f x =
    if Array.length x = 0 then [||]
    else (
      let r = Stack.make () in
      iteri (fun i a ->
        if f i a then Stack.push r a
      ) x;
      Stack.to_array r
    )

  (* filter array, f : 'a -> bool *)
  let filter f x = filteri (fun _ y -> f y) x

  let mapi f x =
    let n = Array.length x in
    if n = 0 then [||]
    else (
      let r = Stack.make () in
      iteri (fun i a -> Stack.push r (f i a)) x;
      Stack.to_array r
    )

  let map f x = mapi (fun _ y -> f y) x

  (* deal with the issue: OCaml 4.02.3 does not have Array.iter2
    eventually we need to move to OCaml 4.03.0 *)
  let iter2 f x y =
    let c = min (Array.length x) (Array.length y) in
    for i = 0 to c - 1 do
      f x.(i) y.(i)
    done

  let iter3 f x y z =
    let c = min (Array.length x) (Array.length y) |> min (Array.length z) in
    for i = 0 to c - 1 do
      f x.(i) y.(i) z.(i)
    done

  let map2i f x y =
    let c = min (Array.length x) (Array.length y) in
    Array.init c (fun i -> f i x.(i) y.(i))

  (* map two arrays, and split into two arrays, f returns 2-tuple *)
  let map2i_split2 f x y =
    let c = min (Array.length x) (Array.length y) in
    match c with
    | 0 -> [||], [||]
    | _ -> (
      let z0 = Stack.make () in
      let z1 = Stack.make () in
      for i = 1 to c - 1 do
        let a, b = f i x.(i) y.(i) in
        Stack.push z0 a;
        Stack.push z1 b;
      done;
      Stack.(to_array z0, to_array z1)
    )

  (* pad n value of v to the left/right of array x *)
  let pad s x v n =
    let l = Array.length x in
    let y = Array.make (l + n) v in
    let _ = match s with
      | `Left  -> Array.blit x 0 y n l
      | `Right -> Array.blit x 0 y 0 l
    in y

  (* [x] is greater or equal than [y] elementwise *)
  let greater_eqaul x y =
    let la = Array.length x in
    let lb = Array.length y in
    assert (la = lb);
    let b = ref true in
    (
      try for i = 0 to la - 1 do
        if x.(i) < y.(i) then failwith "found"
      done with exn -> b := false
    );
    !b

end


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


(* read a file of a given path *)
let read_file f =
  let h = open_in f in
  let s = Stack.make () in
  (
    try while true do
      let l = input_line h |> String.trim in
      Stack.push s l;
    done with End_of_file -> ()
  );
  close_in h;
  Stack.to_array s


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


(* TODO: optimise - read file into a string *)
let read_file_string f =
  read_file f
  |> Array.fold_left (fun a s -> a ^ s ^ "\n") ""


(* write a file of a given path *)
let write_file f s =
  let h = open_out f in
  Printf.fprintf h "%s" s;
  close_out h


(* The following function relates to performance measurement *)


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
