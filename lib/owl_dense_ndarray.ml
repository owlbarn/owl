(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

(* Some constants *)

let _zero : type a b. (a, b) kind -> a = function
    | Float32 -> 0.0 | Complex32 -> Complex.zero
    | Float64 -> 0.0 | Complex64 -> Complex.zero
    | Int8_signed -> 0 | Int8_unsigned -> 0
    | Int16_signed -> 0 | Int16_unsigned -> 0
    | Int32 -> 0l | Int64 -> 0L
    | Int -> 0 | Nativeint -> 0n
    | Char -> '\000'

let _one : type a b. (a, b) kind -> a = function
    | Float32 -> 1.0 | Complex32 -> Complex.one
    | Float64 -> 1.0 | Complex64 -> Complex.one
    | Int8_signed -> 1 | Int8_unsigned -> 1
    | Int16_signed -> 1 | Int16_unsigned -> 1
    | Int32 -> 1l | Int64 -> 1L
    | Int -> 1 | Nativeint -> 1n
    | Char -> '\001'

(* Basic functions from Genarray module *)

let empty kind dimension = Genarray.create kind c_layout dimension

let get x i = Genarray.get x i

let set x i a = Genarray.set x i a

let num_dims x = Genarray.num_dims x

let shape x = Genarray.dims x

let nth_dim x i = Genarray.nth_dim x i

let numel x = Array.fold_right (fun c a -> c * a) (shape x) 1

let kind x = Genarray.kind x

let layout x = Genarray.layout x

(* let size_in_bytes x = Genarray.size_in_bytes x *)

let sub_left = Genarray.sub_left

let sub_right = Genarray.sub_right

let slice_left = Genarray.slice_left

let slice_right = Genarray.slice_right

let copy src dst = Genarray.blit src dst

let fill x a = Genarray.fill x a

let reshape x dimension = reshape x dimension

let mmap = Genarray.map_file

let same_shape x y =
  if (num_dims x) <> (num_dims y) then false
  else (
    let s0 = shape x in
    let s1 = shape y in
    let b = ref true in
    Array.iteri (fun i d ->
      if s0.(i) <> s1.(i) then b := false
    ) s0;
    !b
  )

let clone x =
  let y = empty (kind x) (shape x) in
  Genarray.blit x y;
  y

(* types for interfacing to lacaml *)

type ('a, 'b) vec = ('a, 'b, fortran_layout) Array1.t
type ('a, 'b) vec_unop0 = (('a, 'b) vec) Lacaml.Common.Types.Vec.unop
type ('a, 'b) vec_unop1 = ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) vec -> 'a
type ('a, 'b) vec_binop = (('a, 'b) vec) Lacaml.Common.Types.Vec.binop
type ('a, 'b) vec_mapop = ('a -> 'a) -> ?n:int -> ?ofsy:int -> ?incy:int -> ?y:('a, 'b) vec -> ?ofsx:int -> ?incx:int -> ('a, 'b) vec -> ('a, 'b) vec
type ('a, 'b) vec_iter0 = ('a -> unit) -> ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) vec -> unit
type ('a, 'b) vec_iter1 = (int -> 'a -> unit) -> ?n:int -> ?ofsx:int -> ?incx:int -> ('a, 'b) vec -> unit

let _add_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( +. )
  | Float64   -> ( +. )
  | Complex32 -> Complex.add
  | Complex64 -> Complex.add
  | _         -> failwith "_add_elt: unsupported operation"

let _sub_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( -. )
  | Float64   -> ( -. )
  | Complex32 -> Complex.sub
  | Complex64 -> Complex.sub
  | _         -> failwith "_sub_elt: unsupported operation"

let _mul_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( *. )
  | Float64   -> ( *. )
  | Complex32 -> Complex.mul
  | Complex64 -> Complex.mul
  | _         -> failwith "_mul_elt: unsupported operation"

let _div_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( /. )
  | Float64   -> ( /. )
  | Complex32 -> Complex.div
  | Complex64 -> Complex.div
  | _         -> failwith "_div: unsupported operation"

let _add : type a b. (a, b) kind -> (a, b) vec_binop = function
  | Float32   -> Lacaml.S.Vec.add
  | Float64   -> Lacaml.D.Vec.add
  | Complex32 -> Lacaml.C.Vec.add
  | Complex64 -> Lacaml.Z.Vec.add
  | _         -> failwith "_add: unsupported operation"

let _sub : type a b. (a, b) kind -> (a, b) vec_binop = function
  | Float32   -> Lacaml.S.Vec.sub
  | Float64   -> Lacaml.D.Vec.sub
  | Complex32 -> Lacaml.C.Vec.sub
  | Complex64 -> Lacaml.Z.Vec.sub
  | _         -> failwith "_sub: unsupported operation"

let _mul : type a b. (a, b) kind -> (a, b) vec_binop = function
  | Float32   -> Lacaml.S.Vec.mul
  | Float64   -> Lacaml.D.Vec.mul
  | Complex32 -> Lacaml.C.Vec.mul
  | Complex64 -> Lacaml.Z.Vec.mul
  | _         -> failwith "_mul: unsupported operation"

let _div : type a b. (a, b) kind -> (a, b) vec_binop = function
  | Float32   -> Lacaml.S.Vec.div
  | Float64   -> Lacaml.D.Vec.div
  | Complex32 -> Lacaml.C.Vec.div
  | Complex64 -> Lacaml.Z.Vec.div
  | _         -> failwith "_div: unsupported operation"

let _min : type a b. (a, b) kind -> (a, b) vec_unop1 = function
  | Float32   -> Lacaml.S.Vec.min
  | Float64   -> Lacaml.D.Vec.min
  | Complex32 -> Lacaml.C.Vec.min
  | Complex64 -> Lacaml.Z.Vec.min
  | _         -> failwith "_min: unsupported operation"

let _max : type a b. (a, b) kind -> (a, b) vec_unop1 = function
  | Float32   -> Lacaml.S.Vec.max
  | Float64   -> Lacaml.D.Vec.max
  | Complex32 -> Lacaml.C.Vec.max
  | Complex64 -> Lacaml.Z.Vec.max
  | _         -> failwith "_max: unsupported operation"

let _abs : type a b. (a, b) kind -> (a, b) vec_unop0 = function
  | Float32   -> Lacaml.S.Vec.abs
  | Float64   -> Lacaml.D.Vec.abs
  | Complex32 -> failwith "_abs: unsupported operation"
  | Complex64 -> failwith "_abs: unsupported operation"
  | _         -> failwith "_abs: unsupported operation"

let _neg : type a b. (a, b) kind -> (a, b) vec_unop0 = function
  | Float32   -> Lacaml.S.Vec.neg
  | Float64   -> Lacaml.D.Vec.neg
  | Complex32 -> Lacaml.C.Vec.neg
  | Complex64 -> Lacaml.Z.Vec.neg
  | _         -> failwith "_abs: unsupported operation"

let _sum : type a b. (a, b) kind -> (a, b) vec_unop1 = function
  | Float32   -> Lacaml.S.Vec.sum
  | Float64   -> Lacaml.D.Vec.sum
  | Complex32 -> Lacaml.C.Vec.sum
  | Complex64 -> Lacaml.Z.Vec.sum
  | _         -> failwith "_abs: unsupported operation"

let _add_scalar : type a b. (a, b) kind -> (a -> (a, b) vec_unop0) = function
  | Float32   -> Lacaml.S.Vec.add_const
  | Float64   -> Lacaml.D.Vec.add_const
  | Complex32 -> Lacaml.C.Vec.add_const
  | Complex64 -> Lacaml.Z.Vec.add_const
  | _         -> failwith "_add_scalar: unsupported operation"

let _map_op : type a b. (a, b) kind -> (a, b) vec_mapop = function
  | Float32   -> Lacaml.S.Vec.map
  | Float64   -> Lacaml.D.Vec.map
  | Complex32 -> Lacaml.C.Vec.map
  | Complex64 -> Lacaml.Z.Vec.map
  | _         -> failwith "_map_op: unsupported operation"

let _iter_op : type a b. (a, b) kind -> (a, b) vec_iter0 = function
  | Float32   -> Lacaml.S.Vec.iter
  | Float64   -> Lacaml.D.Vec.iter
  | Complex32 -> Lacaml.C.Vec.iter
  | Complex64 -> Lacaml.Z.Vec.iter
  | _         -> failwith "_iter_op: unsupported operation"

let _iteri_op : type a b. (a, b) kind -> (a, b) vec_iter1 = function
  | Float32   -> Lacaml.S.Vec.iteri
  | Float64   -> Lacaml.D.Vec.iteri
  | Complex32 -> Lacaml.C.Vec.iteri
  | Complex64 -> Lacaml.Z.Vec.iteri
  | _         -> failwith "_iteri_op: unsupported operation"

let min x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  (_min (kind x)) y

let max x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  (_max (kind x)) y

let _check_paired_operands x y =
  if (kind x) <> (kind y) then failwith "_check_paired_operands: kind mismatch";
  if (shape x) <> (shape y) then failwith "_check_paired_operands: shape mismatch"

(* TODO: although generate clean code, but seems causing performance degradation *)
let _paired_arithmetic_op (op : ('a, 'b) kind -> ('a, 'b) vec_binop) x y =
  _check_paired_operands x y;
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (op (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let __investigate___add x y = _paired_arithmetic_op _add x y

let add x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_add (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let sub x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_sub (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let mul x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_mul (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let div x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_div (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let abs x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_abs (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let neg x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_neg (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let add_scalar x a =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_add_scalar (kind x)) a y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let sub_scalar x a =
  let k = kind x in
  let b = (_sub_elt k) (_zero k) (_one k) in
  add_scalar x ((_mul_elt k) a b)

let mul_scalar x a = None

let sum x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  (_sum (kind x)) y

(* TODO *)

let inv x = None

let exp x = None

let pow x = None

let mean x = None

let std x = None

let dot x = None

let tensordot x = None

let prod x = None

let cumsum axis x = None

(* advanced operations *)

let create kind dimension a =
  let x = empty kind dimension in
  let _ = fill x a in
  x

let zeros kind dimension = create kind dimension (_zero kind)

let ones kind dimension = create kind dimension (_one kind)

let flatten x =
  let n = numel x in
  reshape x [|1;n|]

let rec __iteri_fix_axis d j i l h f x =
  if j = d - 1 then (
    for k = l.(j) to h.(j) do
      i.(j) <- k;
      f i (get x i);
    done
  )
  else (
    for k = l.(j) to h.(j) do
      i.(j) <- k;
      __iteri_fix_axis d (j + 1) i l h f x
    done
  )

let _iteri_fix_axis axis f x =
  let d = num_dims x in
  let i = Array.make d 0 in
  let l = Array.make d 0 in
  let h = shape x in
  Array.iteri (fun j a ->
    match a with
    | Some b -> (l.(j) <- b; h.(j) <- b)
    | None   -> (h.(j) <- h.(j) - 1)
  ) axis;
  __iteri_fix_axis d 0 i l h f x

let iteri ?axis f x =
  match axis with
  | Some a -> _iteri_fix_axis a f x
  | None   -> _iteri_fix_axis (Array.make (num_dims x) None) f x

let _iter_all_axis f x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  (_iter_op (kind x)) f y

let iter ?axis f x =
  match axis with
  | Some a -> _iteri_fix_axis a (fun _ y -> f y) x
  | None   -> _iter_all_axis f x

(* TODO: optimise *)
let iter2i f x y =
  let s = shape x in
  let d = num_dims x in
  let i = Array.make d 0 in
  let k = ref 0 in
  let n = (numel x) - 1 in
  for j = 0 to n do
    f i (get x i) (get y i);
    k := d - 1;
    i.(!k) <- i.(!k) + 1;
    while not (i.(!k) < s.(!k)) && j <> n do
      i.(!k) <- 0;
      k := !k - 1;
      i.(!k) <- i.(!k) + 1;
    done
  done

let iter2 f x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  _iteri_op (kind x) (fun i a -> f a y'.{i}) x'

let mapi ?axis f x =
  let y = clone x in
  iteri ?axis (fun i z -> set y i (f i z)) y; y

let _map_all_axis f x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_map_op (kind x)) f y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let map ?axis f x =
  match axis with
  | Some a -> mapi ?axis (fun _ y -> f y) x
  | None   -> _map_all_axis f x

let _check_transpose_axis axis d =
  let info = "check_transpose_axiss fails" in
  if Array.length axis <> d then
    failwith info;
  let h = Hashtbl.create 16 in
  Array.iter (fun x ->
    if x < 0 || x >= d then failwith info;
    if Hashtbl.mem h x = true then failwith info;
    Hashtbl.add h x 0
  ) axis

let transpose ?axis x =
  let d = num_dims x in
  let a = match axis with
    | Some a -> a
    | None -> Array.init d (fun i -> d - i - 1)
  in
  (* check if axis is a correct permutation *)
  _check_transpose_axis a d;
  let s0 = shape x in
  let s1 = Array.map (fun j -> s0.(j)) a in
  let i' = Array.make d 0 in
  let y = empty (kind x) s1 in
  iteri (fun i z ->
    Array.iteri (fun k j -> i'.(k) <- i.(j)) a;
    set y i' z
  ) x;
  y

let swap a0 a1 x =
  let d = num_dims x in
  let a = Array.init d (fun i -> i) in
  let t = a.(a0) in
  a.(a0) <- a.(a1);
  a.(a1) <- t;
  transpose ~axis:a x

let filteri ?axis f x =
  let a = ref [||] in
  iteri ?axis (fun i y ->
    if f i y = true then a := Array.append !a [|i|]
  ) x;
  !a

let filter ?axis f x = filteri ?axis (fun _ y -> f y) x

let foldi ?axis f a x =
  let c = ref a in
  iteri ?axis (fun i y -> c := (f i y !c)) x;
  !c

let fold ?axis f a x =
  let c = ref a in
  iter ?axis (fun y -> c := (f y !c)) x;
  !c

let nnz x =
  let z = _zero (kind x) in
  fold (fun y c -> if y = z then c else c + 1) 0 x

let density x = (nnz x |> float_of_int) /. (numel x |> float_of_int)

let _check_slice_axis axis s =
  if Array.length axis <> Array.length s then
    failwith "check_slice_axis: length does not match";
  let has_none = ref false in
  Array.iteri (fun i a ->
    match a with
    | Some a -> if a < 0 || a >= s.(i) then failwith "check_slice_axis: boundary error"
    | None   -> has_none := true
  ) axis;
  if !has_none = false then failwith "check_slice_axis: there should be at least one None"

let slice axis x =
  let s0 = shape x in
  (* check axis is within boundary, has at least one None *)
  _check_slice_axis axis s0;
  let s1 = ref [||] in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None   -> s1 := Array.append !s1 [|s0.(i)|]
  ) axis;
  let y = empty (kind x) !s1 in
  let k = Array.make (num_dims y) 0 in
  let t = ref 0 in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None   -> (k.(!t) <- i; t := !t + 1)
  ) axis;
  let j = Array.make (num_dims y) 0 in
  iteri ~axis (fun i a ->
    Array.iteri (fun m m' -> j.(m) <- i.(m')) k;
    set y j a
  ) x;
  y

let rec _iteri_slice index axis f x =
  if Array.length axis = 0 then (
    f index (slice index x)
  )
  else (
    let s = shape x in
    for i = 0 to s.(axis.(0)) - 1 do
      index.(axis.(0)) <- Some i;
      _iteri_slice index (Array.sub axis 1 (Array.length axis - 1)) f x
    done
  )

let iteri_slice axis f x =
  let index = Array.make (num_dims x) None in
  _iteri_slice index axis f x

let iter_slice axis f x = iteri_slice axis (fun _ y -> f y) x

let copy_slice i src dst =
  let s = shape dst in
  _check_slice_axis i s;
  let j = Array.make (num_dims dst) 0 in
  let k = ref [||] in
  let m = ref 0 in
  Array.iteri (fun n a ->
    match a with
    | Some a' -> j.(n) <- a'
    | None    -> (k := Array.append !k [|n|]; m := !m + 1)
  ) i;
  let k = !k in
  iteri (fun i' a ->
    Array.iteri (fun m n -> j.(k.(m)) <- n) i';
    set dst j a
  ) src

(* TODO *)

let insert_slice = None

let remove_slice = None

let mapi_slice = None

let map_slice = None

(* TODO *)

let sort axis x = None

let diag x = None

let trace x = None

let repeat x = None

(* some comparison functions *)

let _compare_element_to_zero f x =
  let b = ref true in
  let z = _zero (kind x) in
  try iter (fun y ->
    if not (f y z) then (
      b := false;
      failwith "found";
    )
  ) x; !b
  with Failure _ -> !b

let is_zero x = _compare_element_to_zero ( = ) x

let is_positive x = _compare_element_to_zero ( > ) x

let is_negative x = _compare_element_to_zero ( < ) x

let is_nonnegative x = _compare_element_to_zero ( >= ) x

let is_nonpositive x = _compare_element_to_zero ( <= ) x

let _compare_elements_in_two f x y =
  let b = ref true in
  try iter2 (fun c d ->
    if not (f c d) then (
      b := false;
      failwith "found";
    )
  ) x y; !b
  with Failure _ -> !b

let is_equal x y = _compare_elements_in_two ( = ) x y

let is_unequal x y = _compare_elements_in_two ( <> ) x y

let is_greater x y = _compare_elements_in_two ( > ) x y

let is_smaller x y = _compare_elements_in_two ( < ) x y

let equal_or_greater x y = _compare_elements_in_two ( >= ) x y

let equal_or_smaller x y = _compare_elements_in_two ( <= ) x y

let exists f x =
  let b = ref false in
  try iter (fun y ->
    if (f y) then (
      b := true;
      failwith "found";
    )
  ) x; !b
  with Failure _ -> !b

let not_exists f x = not (exists f x)

let for_all f x = let g y = not (f y) in not_exists g x

(* input/output functions *)

let print_index i =
  Printf.printf "[ ";
  Array.iter (fun x -> Printf.printf "%i " x) i;
  Printf.printf "] "

let print_element : type a b. (a, b) kind -> a -> unit = fun t v ->
  match t with
  | Float32   -> Printf.printf "%f\n" v
  | Float64   -> Printf.printf "%f\n" v
  | Int32     -> Printf.printf "%i\n" (Int32.to_int v)
  | Int64     -> Printf.printf "%i\n" (Int64.to_int v)
  | Complex32 -> Printf.printf "{re = %f; im = %f}\n" Complex.(v.re) Complex.(v.im)
  | Complex64 -> Printf.printf "{re = %f; im = %f}\n" Complex.(v.re) Complex.(v.im)
  | _         -> ()

let print x =
  let t = kind x in
  iteri (fun i y -> print_index i; print_element t y) x

let save x f =
  let t = kind x in
  let s = Marshal.to_string (t,x) [] in
  let h = open_out f in
  output_string h s;
  close_out h

let load f =
  let h = open_in f in
  let s = really_input_string h (in_channel_length h) in
  let _, x = Marshal.from_string s 0
  in x

let _calc_stride s =
  let d = Array.length s in
  let r = Array.make d 1 in
  for i = 1 to d - 1 do
    r.(d - i - 1) <- s.(d - i) * r.(d - i)
  done;
  r

let _index_1d2nd i j s =
  j.(0) <- i / s.(0);
  for k = 1 to Array.length s - 1 do
    j.(k) <- (i mod s.(k - 1)) / s.(k);
  done

(* math operations. code might be verbose for performance concern. *)

let re x =
  let y = empty Float64 (shape x) in
  iteri (fun i c -> set y i Complex.(c.re) ) x;
  y

let im x =
  let y = empty Float64 (shape x) in
  iteri (fun i c -> set y i Complex.(c.im) ) x;
  y

let minmax x =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let min_i = ref 1 in
  let min_v = ref (x'.{!min_i}) in
  let max_i = ref 1 in
  let max_v = ref (x'.{!max_i}) in
  (_iteri_op (kind x)) (fun j y ->
    if y < !min_v then (min_v := y; min_i := j);
    if y > !max_v then (max_v := y; max_i := j);
  ) x';
  let s = _calc_stride (shape x) in
  let i = Array.copy s in
  let j = Array.copy s in
  _index_1d2nd (!min_i - 1) i s;
  _index_1d2nd (!max_i - 1) j s;
  !min_v, i, !max_v, j


(* TODO *)
(*let conj x = map Complex.conj x *)

let perf x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let s = _calc_stride (shape x) in
  let i = Array.copy s in
  (_iteri_op (kind x)) (fun j y ->
    _index_1d2nd (j - 1) i s
  ) x';
  ()




(* ends here *)
