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

(* advanced operations *)

let create kind dimension a =
  let x = empty kind dimension in
  let _ = fill x a in
  x

let zeros kind dimension = create kind dimension (_zero kind)

let ones kind dimension = create kind dimension (_one kind)

let clone x =
  let y = empty (kind x) (shape x) in
  Genarray.blit x y;
  y

let flatten x =
  let n = numel x in
  reshape x [|1;n|]

let _iteri_all_axis f x =
  let s = shape x in
  let d = num_dims x in
  let i = Array.make d 0 in
  let k = ref 0 in
  let n = (numel x) - 1 in
  for j = 0 to n do
    f (Array.copy i) (get x i);
    if j <> n then (
      k := d - 1;
      while not (i.(!k) <- i.(!k) + 1; i.(!k) < s.(!k)) do
        i.(!k) <- 0;
        k := !k - 1;
      done
    )
  done

let _iteri_fix_axis axis f x =
  let s = shape x in
  let n = ref (numel x) in
  let l = ref [||] in
  let i = Array.mapi (fun i a ->
    match a with
    | Some a -> (n := !n / s.(i); a)
    | None -> (l := Array.append [|i|] !l; 0)
  ) axis
  in
  let n = !n - 1 in
  let l = !l in
  for j = 0 to n do
    f (Array.copy i) (get x i);
    if j <> n then (
      let m = ref 0 in
      let k = ref l.(!m) in
      while not (i.(!k) <- i.(!k) + 1; i.(!k) < s.(!k)) do
        i.(!k) <- 0;
        m := !m + 1;
        k := l.(!m);
      done
    )
  done

let iteri ?axis f x =
  match axis with
  | Some a -> _iteri_fix_axis a f x
  | None   -> _iteri_all_axis f x

let iter ?axis f x = iteri ?axis (fun _ y -> f y) x

let iter2i f x y =
  let s = shape x in
  let d = num_dims x in
  let i = Array.make d 0 in
  let k = ref 0 in
  let n = (numel x) - 1 in
  for j = 0 to n do
    f (Array.copy i) (get x i) (get y i);
    k := d - 1;
    i.(!k) <- i.(!k) + 1;
    while not (i.(!k) < s.(!k)) && j <> n do
      i.(!k) <- 0;
      k := !k - 1;
      i.(!k) <- i.(!k) + 1;
    done
  done

let iter2 f x y = iter2i (fun _ a b -> f a b) x y

let mapi ?axis f x =
  let y = clone x in
  iteri ?axis (fun i z -> set y i (f i z)) x; y

let map ?axis f x = mapi ?axis (fun _ y -> f y) x

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

let fold ?axis f a x = foldi ?axis (fun _ y c -> f y c) a x

let nnz x =
  let z = _zero (kind x) in
  fold (fun y c -> if y = z then c else c + 1) 0 x

let density x = (nnz x |> float_of_int) /. (numel x |> float_of_int)

(* TODO *)

let check_slice_axis axis s =
  if Array.length axis <> Array.length s then
    failwith "check_slice_axis: length does not match";
  let has_none = ref false in
  Array.iteri (fun i a ->
    match a with
    | Some a -> if a < 0 || a >= s.(i) then failwith "check_slice_axis: boundary error"
    | None -> has_none := true
  ) axis;
  if !has_none = false then failwith "check_slice_axis: there should be at least one None"

let slice axis x =
  let s0 = shape x in
  (* check axis is within boundary, has at least one None *)
  check_slice_axis axis s0;
  let s1 = ref [||] in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None -> s1 := Array.append !s1 [|s0.(i)|]
  ) axis;
  let y = empty (kind x) !s1 in
  let k = Array.make (num_dims y) 0 in
  let t = ref 0 in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None -> (k.(!t) <- i; t := !t + 1)
  ) axis;
  let j = Array.make (num_dims y) 0 in
  iteri ~axis (fun i a ->
    Array.iteri (fun m m' -> j.(m) <- i.(m')) k;
    set y j a
  ) x;
  y

let rec _iteri_slice index axis f x =
  if Array.length axis = 0 then (
    f (Array.copy index) (slice index x)
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

let check_transpose_axis axis d =
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
  check_transpose_axis a d;
  let s0 = shape x in
  let s1 = Array.map (fun j -> s0.(j)) a in
  let y = empty (kind x) s1 in
  iteri (fun i z ->
    let i' = Array.map (fun j -> i.(j)) a in
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

(* TODO *)

let sort axis x = None

let diag x = None

let trace x = None

let repeat x = None

(* some math operations *)

let re x =
  let y = empty Float64 (shape x) in
  iteri (fun i c -> set y i Complex.(c.re) ) x;
  y

let im x =
  let y = empty Float64 (shape x) in
  iteri (fun i c -> set y i Complex.(c.im) ) x;
  y

let max ?axis x =
  let i = ref (Array.make (num_dims x) 0) in
  let z = ref (get x !i) in
  iteri ?axis (fun j y ->
    if y > !z then (z := y; i := j)
  ) x;
  !z, !i

let min ?axis x =
  let i = ref (Array.make (num_dims x) 0) in
  let z = ref (get x !i) in
  iteri ?axis (fun j y ->
    if y < !z then (z := y; i := j)
  ) x;
  !z, !i

let _add : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( +. )
  | Float64   -> ( +. )
  | Int       -> ( + )
  | Int32     -> Int32.add
  | Int64     -> Int64.add
  | Complex32 -> Complex.add
  | Complex64 -> Complex.add
  | _         -> failwith "_add: unsupported operation"

let _sub : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( -. )
  | Float64   -> ( -. )
  | Int       -> ( - )
  | Int32     -> Int32.sub
  | Int64     -> Int64.sub
  | Complex32 -> Complex.sub
  | Complex64 -> Complex.sub
  | _         -> failwith "_sub: unsupported operation"

let _mul : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( *. )
  | Float64   -> ( *. )
  | Int       -> ( * )
  | Int32     -> Int32.mul
  | Int64     -> Int64.mul
  | Complex32 -> Complex.mul
  | Complex64 -> Complex.mul
  | _         -> failwith "_mul: unsupported operation"

let _div : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( /. )
  | Float64   -> ( /. )
  | Int       -> ( / )
  | Int32     -> Int32.div
  | Int64     -> Int64.div
  | Complex32 -> Complex.div
  | Complex64 -> Complex.div
  | _         -> failwith "_div: unsupported operation"

let _abs : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> abs_float
  | Float64   -> abs_float
  | Int       -> abs
  | Int32     -> Int32.abs
  | Int64     -> Int64.abs
  | Complex32 -> (fun x -> Complex.({re = norm x; im = 0.}))
  | Complex64 -> (fun x -> Complex.({re = norm x; im = 0.}))
  | _         -> failwith "_abs: unsupported operation"

let _neg : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> ( -. ) 0.
  | Float64   -> ( -. ) 0.
  | Int       -> ( - ) 0
  | Int32     -> Int32.neg
  | Int64     -> Int64.neg
  | Complex32 -> Complex.neg
  | Complex64 -> Complex.neg
  | _         -> failwith "_neg: unsupported operation"

let _paired_arithmetic_op op x y =
  let z = clone x in
  let _op = op (kind x) in
  iter2i (fun i a b -> set z i (_op a b)) x y;
  z

let add x y = _paired_arithmetic_op (_add) x y

let sub x y = _paired_arithmetic_op (_sub) x y

let mul x y = _paired_arithmetic_op (_mul) x y

let div x y = _paired_arithmetic_op (_div) x y

let abs x = map (_abs (kind x)) x

let neg x = map (_neg (kind x)) x

let sum x =
  let z = _zero (kind x) in
  let op = _add (kind x) in
  fold op z x

let conj x = map Complex.conj x

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
