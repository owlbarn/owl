(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
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
  Array1.fill x (Owl_const.zero k);
  x

let _allocate_more_space x =
  let c = nnz x in
  if  c < Array1.dim x.d then ()
  else (
    Owl_log.debug "allocate space %i" c;
    x.d <- Owl_utils.array1_extend x.d c;
  )

let _remove_ith_item x i =
  Owl_log.debug "_remove_ith_item";
  for j = i to (nnz x) - 2 do
    x.d.{j} <- x.d.{j + 1}
  done;
  Hashtbl.filter_map_inplace (fun k v ->
    if v = i then None
    else if v > i then Some (v - 1)
    else Some v
  ) x.h

(* check whether index x is in slice s *)
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

let zeros k s =
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

let _check_same_shape x y =
  if same_shape x y = false then
    failwith "Owl_sparse_ndarray: _check_same_shape fails."

let copy x = {
  s = Array.copy x.s;
  h = Hashtbl.copy x.h;
  d = Owl_utils.array1_copy x.d;
}

let get x i =
  try let j = Hashtbl.find x.h i in
    Array1.unsafe_get x.d j
  with exn -> Owl_const.zero (kind x)

let set x i a =
  _allocate_more_space x;
  let _a0 = Owl_const.zero (kind x) in
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

let flatten x =
  let s = Owl_utils.calc_stride (shape x) in
  let y = copy x in
  Hashtbl.iter (fun i j ->
    let i' = Owl_utils.index_nd_1d i s in
    Hashtbl.remove y.h i;
    Hashtbl.add y.h [|i'|] j
  ) x.h;
  y.s <- [|numel x|];
  y

let reshape x s =
  let y = copy x in
  let s0 = Owl_utils.calc_stride (shape x) in
  let s1 = Owl_utils.calc_stride s in
  let i1 = Array.copy s in
  Hashtbl.iter (fun i j ->
    let k = Owl_utils.index_nd_1d i s0 in
    Owl_utils.index_1d_nd k i1 s1;
    Hashtbl.remove y.h i;
    Hashtbl.add y.h (Array.copy i1) j;
  ) x.h;
  y.s <- s;
  y

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
  let y = copy x in
  iteri ?axis (fun i z -> set y i (f i z)) y;
  y

let map ?axis f x =
  let y = copy x in
  iteri ?axis (fun i z -> set y i (f z)) y;
  y

let _iteri_all_axis_nz f x = Hashtbl.iter (fun i j -> f i (x.d.{j})) x.h

let _iteri_fix_axis_nz axis f x =
  Hashtbl.iter (fun i j ->
    if _in_slice axis i = true then f i (x.d.{j})
  ) x.h

let _iter_all_axis_nz f x =
  for i = 0 to (nnz x) - 1 do
    f (Array1.unsafe_get x.d i)
  done

let iteri_nz ?axis f x =
  match axis with
  | Some a -> _iteri_fix_axis_nz a f x
  | None   -> _iteri_all_axis_nz f x

let iter_nz ?axis f x =
  match axis with
  | Some a -> _iteri_fix_axis_nz a (fun _ y -> f y) x
  | None   -> _iter_all_axis_nz f x

let mapi_nz ?axis f x =
  let y = copy x in (
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
    let y = copy x in
    for i = 0 to (nnz y) do
      let a = f (Array1.unsafe_get y.d i) in
      Array1.unsafe_set y.d i a
    done;
    y
    )

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
  let y = zeros (kind x) s1 in
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
  let s = Owl_utils.Stack.make () in
  iteri ?axis (fun i y ->
    if f i y = true then
      let j = Array.copy i in
      Owl_utils.Stack.push s j
  ) x;
  Owl_utils.Stack.to_array s

let filter ?axis f x = filteri ?axis (fun _ y -> f y) x

let filteri_nz ?axis f x =
  let s = Owl_utils.Stack.make () in
  iteri_nz ?axis (fun i y ->
    if f i y = true then
      let j = Array.copy i in
      Owl_utils.Stack.push s j
  ) x;
  Owl_utils.Stack.to_array s

let filter_nz ?axis f x = filteri_nz ?axis (fun _ y -> f y) x

let _fold_basic ?axis iter_fun f a x =
  let r = ref a in
  iter_fun ?axis (fun y -> r := f !r y) x; !r

let fold ?axis f a x = _fold_basic ?axis iter f a x

let fold_nz ?axis f a x = _fold_basic ?axis iter_nz f a x

let foldi ?axis f a x =
  let c = ref a in
  iteri ?axis (fun i y -> c := (f i !c y)) x;
  !c

let foldi_nz ?axis f a x =
  let c = ref a in
  iteri_nz ?axis (fun i y -> c := (f i !c y)) x;
  !c

let slice axis x =
  (* make the index mapping *)
  let s = Owl_utils.Stack.make () in
  for i = 0 to Array.length axis - 1 do
    match axis.(i) with
    | Some _ -> ()
    | None   -> Owl_utils.Stack.push s i
  done;
  let m = Owl_utils.Stack.to_array s in
  (* create a new sparse ndarray for the slice *)
  let s0 = shape x in
  let s1 = Array.map (fun i -> s0.(i)) m in
  let y = zeros (kind x) s1 in
  (* only iterate non-zero elements *)
  iteri_nz (fun i v ->
    if _in_slice axis i = true then (
      let i' = Array.map (fun j -> i.(j)) m in
      set y i' v
    )
  ) x;
  y

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
  let _a0 = Owl_const.zero (kind x) in
  if (nnz x) < (numel x) then false
  else for_all (( < ) _a0) x

let is_negative x =
  let _a0 = Owl_const.zero (kind x) in
  if (nnz x) < (numel x) then false
  else for_all (( > ) _a0) x

let is_nonpositive x =
  let _a0 = Owl_const.zero (kind x) in
  for_all_nz (( >= ) _a0) x

let is_nonnegative x =
  let _a0 = Owl_const.zero (kind x) in
  for_all_nz (( <= ) _a0) x

let add_scalar x a =
  let _op = _add_elt (kind x) in
  map_nz (fun z -> _op z a) x

let sub_scalar x a = add_scalar x (_neg_elt (kind x) a)

let mul_scalar x a =
  let _op = _mul_elt (kind x) in
  map_nz (fun z -> _op z a) x

let div_scalar x a = mul_scalar x ((_inv_elt (kind x)) a)

let scalar_add a x =
  let _op = _add_elt (kind x) in
  map_nz (fun z -> _op a z) x

let scalar_sub a x =
  let _op = _sub_elt (kind x) in
  map_nz (fun z -> _op a z) x

let scalar_mul a x =
  let _op = _mul_elt (kind x) in
  map_nz (fun z -> _op a z) x

let scalar_div a x =
  let _op = _div_elt (kind x) in
  map_nz (fun z -> _op a z) x

let add x1 x2 =
  let k = kind x1 in
  let _a0 = Owl_const.zero k in
  let __add_elt = _add_elt k in
  let y = zeros k (shape x1) in
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
  let _a0 = Owl_const.zero k in
  let __mul_elt = _mul_elt k in
  let y = zeros (kind x1) (shape x1) in
  let _ = iteri_nz (fun i a ->
    let b = get x2 i in
    if b <> _a0 then set y i (__mul_elt a b)
  ) x1 in
  y

let div x1 x2 =
  let k = kind x1 in
  let _a0 = Owl_const.zero k in
  let __div_elt = _div_elt k in
  let __inv_elt = _inv_elt k in
  let y = zeros (kind x1) (shape x1) in
  let _ = iteri_nz (fun i a ->
    let b = get x2 i in
    if b <> _a0 then set y i (__div_elt a (__inv_elt b))
  ) x1 in
  y

let abs x =
  let _op = _abs_elt (kind x) in
  map_nz _op x

let sum x =
  let k = kind x in
  fold_nz (_add_elt k) (Owl_const.zero k) x

let mean x = (_mean_elt (kind x)) (sum x) (numel x)

let equal x1 x2 =
  _check_same_shape x1 x2;
  if (nnz x1) <> (nnz x2) then false
  else (sub x1 x2 |> is_zero)

let not_equal x1 x2 = not (equal x1 x2)

let greater x1 x2 =
  _check_same_shape x1 x2;
  is_positive (sub x1 x2)

let less x1 x2 = greater x2 x1

let greater_equal x1 x2 =
  _check_same_shape x1 x2;
  is_nonnegative (sub x1 x2)

let less_equal x1 x2 = greater_equal x2 x1

let minmax x =
  let k = kind x in
  let _a0 = Owl_const.zero k in
  let xmin = ref (Owl_const.pos_inf k) in
  let xmax = ref (Owl_const.neg_inf k) in
  iter_nz (fun y ->
    if y < !xmin then xmin := y;
    if y > !xmax then xmax := y;
  ) x;
  match (nnz x) < (numel x) with
  | true  -> (min !xmin _a0), (max !xmax _a0)
  | false -> !xmin, !xmax

let min x = fst (minmax x)

let max x = snd (minmax x)


(* input/output functions *)

let print_index i =
  Printf.printf "[ ";
  Array.iter (fun x -> Printf.printf "%i " x) i;
  Printf.printf "] "

let print_element k v =
  let s = (Owl_utils.elt_to_str k) v in
  Printf.printf "%s" s

let print x =
  let _op = Owl_utils.elt_to_str (kind x) in
  iteri (fun i y ->
    print_index i;
    Printf.printf "%s\n" (_op y)
  ) x

let pp_spnda x =
  let _op = Owl_utils.elt_to_str (kind x) in
  let k = shape x in
  let s = Owl_utils.calc_stride k in
  let _pp = fun i j -> (
    for i' = i to j do
      Owl_utils.index_1d_nd i' k s;
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

let save x f = Owl_utils.marshal_to_file x f

let load k f = Owl_utils.marshal_from_file f

let _random_basic a k f d =
  let x = zeros k d in
  let n = numel x in
  let c = int_of_float ((float_of_int n) *. a) in
  let i = Array.copy d in
  let s = Owl_utils.calc_stride d in
  for k = 0 to c - 1 do
    let j = Owl_stats.uniform_int_rvs ~a:0 ~b:(n-1) in
    Owl_utils.index_1d_nd j i s;
    set x i (f ())
  done;
  x

let binary ?(density=0.1) k s =
  let _a1 = Owl_const.one k in
  _random_basic density k (fun () -> _a1) s

let uniform ?(scale=1.) ?(density=0.1) k s =
  let _op = _owl_uniform_fun k in
  _random_basic density k (fun () -> _op scale) s

let to_array x =
  let y = Array.make (nnz x) ([||], Owl_const.zero (kind x)) in
  let j = ref 0 in
  iteri_nz (fun i v ->
    y.(!j) <- (Array.copy i, v);
    j := !j + 1;
  ) x;
  y

let of_array k s x =
  let y = zeros k s in
  Array.iter (fun (i,v) -> set y i v) x;
  y



(* ends here *)
