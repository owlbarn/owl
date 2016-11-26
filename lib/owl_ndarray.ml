(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t

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

let kind x = Genarray.kind x

let layout x = Genarray.layout x

(* let size_in_bytes x = Genarray.size_in_bytes x *)

let sub_left = Genarray.sub_left

let sub_right = Genarray.sub_right

let slice_left = Genarray.slice_left

let slice_right = Genarray.slice_right

let blit = Genarray.blit

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

let numel x =
  let d = shape x in
  Array.fold_right (fun c a -> c * a) d 1

let clone x =
  let y = empty (kind x) (shape x) in
  blit x y;
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

let iteri2 f x y =
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

let iter2 f x y = iteri2 (fun _ a b -> f a b) x y

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

(* some math operations *)

let re x = None

let im x = None

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

let _print_index i =
  Printf.printf "[ ";
  Array.iter (fun x -> Printf.printf "%i " x) i;
  Printf.printf "] "

let _print_element : type a b. (a, b) kind -> a -> unit = fun t v ->
  match t with
  | Float32 -> Printf.printf "%f\n" (Obj.magic v)
  | Float64 -> Printf.printf "%f\n" (Obj.magic v)
  | Int32   -> Printf.printf "%i\n" (Obj.magic (Int32.to_int v))
  | Int64   -> Printf.printf "%i\n" (Obj.magic (Int64.to_int v))
  | _       -> ()

let print x =
  let t = kind x in
  iteri (fun i y -> _print_index i; _print_element t y) x
