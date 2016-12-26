(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) t = {
  mutable s : int array;
  mutable h : (int array, int) Hashtbl.t;
  mutable d : ('a, 'b, c_layout) Array1.t;
}

let nnz x =
  let _stats = Hashtbl.stats x.h in
  Hashtbl.(_stats.num_bindings)

let _make_elt_array k n =
  let x = Array1.create k c_layout n in
  Array1.fill x (_zero k);
  x

let _allocate_more_space x =
  let c = nnz x in
  if  c < Array1.dim x.d then ()
  else (
    Log.debug "allocate space %i" c;
    x.d <- Owl_utils.array1_extend x.d c;
  )

let _remove_ith_item x i =
  Log.debug "_remove_ith_item";
  for j = i to (nnz x) - 2 do
    x.d.{j} <- x.d.{j + 1}
  done;
  Hashtbl.filter_map_inplace (fun k v ->
    if v = i then None
    else if v > i then Some (v - 1)
    else Some v
  ) x.h

(* check whether x is in slice s *)
let _in_slice s x =
  let r = ref true in
  (try
    Array.iteri (fun i v ->
      match v with
      | Some v -> (
        if v <> x.(i) then (
          r := false;
          failwith "not in the slice";
          )
        )
      | None -> ()
    ) s
  with exn -> ());
  !r

let empty k s =
  let n = Array.fold_right (fun c a -> c * a) s 1 in
  let c = max (n / 1000) 1024 in
  {
    s = Array.copy s;
    h = Hashtbl.create c;
    d = _make_elt_array k c;
  }

let shape x = Array.copy x.s

let num_dims x = Array.length x.s

let nth_dim x i = x.s.(i)

let numel x = Array.fold_right (fun c a -> c * a) x.s 1

let density x =
  let a = float_of_int (nnz x) in
  let b = float_of_int (numel x) in
  a /. b

let kind x = Array1.kind (x.d)

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

let clone x = {
  s = Array.copy x.s;
  h = Hashtbl.copy x.h;
  d = Owl_utils.array1_clone x.d;
}

let get x i =
  try let j = Hashtbl.find x.h i in
    Array1.unsafe_get x.d j
  with exn -> _zero (kind x)

let set x i a =
  let _a0 = _zero (kind x) in
  if a = _a0 then (
    try let j = Hashtbl.find x.h i in
      Array1.unsafe_set x.d j _a0;
      _remove_ith_item x j;
    with exn -> ()
  )
  else (
    try let j = Hashtbl.find x.h i in
      Array1.unsafe_set x.d j a;
    with exn -> (
      let j = nnz x in
      Hashtbl.add x.h (Array.copy i) j;
      Array1.unsafe_set x.d j a
    )
  )

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

let iter ?axis f x = iteri ?axis (fun _ y -> f y) x

let mapi ?axis f x =
  let y = clone x in
  iteri ?axis (fun i z -> set y i (f i z)) y;
  y

let map ?axis f x =
  let y = clone x in
  iteri ?axis (fun i z -> set y i (f z)) y;
  y

let _iteri_all_axis_nz f x = Hashtbl.iter (fun i j -> f i (x.d.{j})) x.h

let _iteri_fix_axis_nz axis f x =
  Hashtbl.iter (fun i j ->
    if _in_slice axis i = true then f i (x.d.{j})
  ) x.h

let _iter_all_axis_nz f x = Owl_utils.array1_iter (fun i y -> f y) x.d

let iteri_nz ?axis f x =
  match axis with
  | Some a -> _iteri_fix_axis_nz a f x
  | None   -> _iteri_all_axis_nz f x

let iter_nz ?axis f x =
  match axis with
  | Some a -> _iteri_fix_axis_nz a (fun _ y -> f y) x
  | None   -> _iter_all_axis_nz f x

let mapi_nz ?axis f x =
  let y = clone x in (
  match axis with
  | Some a -> Hashtbl.iter (fun i j ->
    if _in_slice a i = true then y.d.{j} <- f i (x.d.{j})
    ) y.h
  | None   -> Hashtbl.iter (fun i j -> y.d.{j} <- f i (x.d.{j})) y.h
  );
  y

let map_nz ?axis f x =
  match axis with
  | Some a -> mapi_nz ~axis:a (fun _ z -> f z) x
  | None   -> (
    let y = clone x in
    Owl_utils.array1_iteri (fun i z -> y.d.{i} <- (f z)) y.d;
    y
    )

let _exists_basic iter_fun f x =
  try iter_fun (fun y ->
    if (f y) = true then failwith "found"
  ) x; false
  with exn -> true

let exists f x = _exists_basic iter f x

let not_exists f x = not (exists f x)

let for_all f x = let g y = not (f y) in not_exists g x

let exists_nz f x = _exists_basic iter_nz f x

let not_exists_nz f x = not (exists_nz f x)

let for_all_nz f x = let g y = not (f y) in not_exists_nz g x

let is_zero x = (nnz x) = 0

let is_positive x =
  let _a0 = _zero (kind x) in
  if (nnz x) < (numel x) then false
  else for_all (( < ) _a0) x

let is_negative x =
  let _a0 = _zero (kind x) in
  if (nnz x) < (numel x) then false
  else for_all (( > ) _a0) x

let is_nonpositive x =
  let _a0 = _zero (kind x) in
  for_all_nz (( >= ) _a0) x

let is_nonnegative x =
  let _a0 = _zero (kind x) in
  for_all_nz (( <= ) _a0) x

let add x1 x2 =
  let k = kind x1 in
  let _a0 = _zero k in
  let __add_elt = _add_elt k in
  let y = empty k (shape x1) in
  let _ = iteri_nz (fun i a ->
    let b = get x2 i in
    if b = _a0 then set y i a
  ) x1 in
  let _ = iteri_nz (fun i a ->
    let b = get x1 i in
    set y i (__add_elt a b)
  ) x2 in
  y

let neg x = map_nz (_neg_elt (kind x)) x

let sub x1 x2 = add x1 (neg x2)

let mul x1 x2 =
  let k = kind x1 in
  let _a0 = _zero k in
  let __mul_elt = _mul_elt k in
  let y = empty (kind x1) (shape x1) in
  let _ = iteri_nz (fun i a ->
    let b = get x2 i in
    if b <> _a0 then set y i (__mul_elt a b)
  ) x1 in
  y

let div x1 x2 =
  let k = kind x1 in
  let _a0 = _zero k in
  let __div_elt = _div_elt k in
  let __inv_elt = _inv_elt k in
  let y = empty (kind x1) (shape x1) in
  let _ = iteri_nz (fun i a ->
    let b = get x2 i in
    if b <> _a0 then set y i (__div_elt a (__inv_elt b))
  ) x1 in
  y

let is_equal x1 x2 =
  if (nnz x1) <> (nnz x2) then false
  else (sub x1 x2 |> is_zero)

let is_unequal x1 x2 = not (is_equal x1 x2)

let is_greater x1 x2 = is_positive (sub x1 x2)

let is_smaller x1 x2 = is_greater x2 x1

let equal_or_greater x1 x2 = is_nonnegative (sub x1 x2)

let equal_or_smaller x1 x2 = equal_or_greater x2 x1

(* input/output functions *)

let print_index i =
  Printf.printf "[ ";
  Array.iter (fun x -> Printf.printf "%i " x) i;
  Printf.printf "] "

let print_element k v =
  let s = (_owl_elt_to_str k) v in
  Printf.printf "%s" s

let print x =
  let _op = _owl_elt_to_str (kind x) in
  iteri (fun i y ->
    print_index i;
    Printf.printf "%s\n" (_op y)
  ) x

let pp_spnda x =
  let _op = _owl_elt_to_str (kind x) in
  let k = shape x in
  let s = _calc_stride k in
  let _pp = fun i j -> (
    for i' = i to j do
      _index_1d_nd i' k s;
      print_index k;
      Printf.printf "%s\n" (_op (get x k))
    done
  )
  in
  let n = numel x in
  if n <= 40 then (
    _pp 0 (n - 1)
  )
  else (
    _pp 0 19;
    print_endline "......";
    _pp (n - 20) (n - 1)
  )


(* ends here *)
