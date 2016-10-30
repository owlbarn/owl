(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex sparse matrix ]
  The default format is compressed row storage (CRS).
 *)

open Bigarray
open Owl_types.Sparse_complex

type spmat = spmat_record

type elt = Complex.t

let _make_int_array x = Array.make x 0
let _make_elt_array x = Array1.create complex64 c_layout x

let zeros m n =
  let c = max (m * n / 100) 181024 in
  {
    m   = m;
    n   = n;
    i   = _make_int_array c;
    d   = _make_elt_array c;
    p   = _make_int_array c;
    nz  = 0;
    typ = 0;
    h   = Hashtbl.create c;
  }

let _is_triplet x = x.typ = 0

let _remove_ith_triplet x i =
  Log.debug "_remove_ith_triplet";
  for j = i to x.nz - 2 do
    x.i.(j) <- x.i.(j + 1);
    x.p.(j) <- x.p.(j + 1);
    x.d.{j} <- x.d.{j + 1};
    Hashtbl.replace x.h (x.i.(j) * x.n + x.p.(j)) j;
  done

(* for debug purpose *)
let _print_complex x = Printf.printf "{re = %f; im = %f} " Complex.(x.re) Complex.(x.im)

(* for debug purpose *)
let _print_array x =
  Array.iter (fun y -> print_int y; print_char ' ') x;
  print_endline ""

let _triplet2crs x =
  (* TODO: can be optimised by sorting col number *)
  Log.debug "convert triplet -> crs";
  if _is_triplet x = false then failwith "not in triplet format";
  let i = Array.sub x.i 0 x.nz in
  let q = _make_int_array x.m in
  Array.iter (fun c -> q.(c) <- q.(c) + 1) i;
  let p = _make_int_array (x.m + 1) in
  Array.iteri (fun i c -> p.(i + 1) <- p.(i) + c) q;
  let d = _make_elt_array x.nz in
  for j = 0 to x.nz - 1 do
    let c = x.d.{j} in
    let r_i = x.i.(j) in
    let pos = p.(r_i + 1) - q.(r_i) in
    d.{pos} <- c;
    i.(pos) <- x.p.(j);
    q.(r_i) <- q.(r_i) - 1;
  done;
  x.i <- i;
  x.d <- d;
  x.p <- p;
  x.typ <- 2

let _crs2triplet x = None

let _allocate_more_space x =
  if x.nz < Array.length x.i then ()
  else (
    Log.debug "allocate space %i" x.nz;
    x.i <- Array.append x.i (_make_int_array x.nz);
    x.p <- Array.append x.p (_make_int_array x.nz);
    let d = _make_elt_array (x.nz * 2) in
    for j = 0 to x.nz - 1 do
      d.{j} <- x.d.{j}
    done;
    x.d <- d;
  )

let set x i j y =
  if _is_triplet x = false then
    failwith "only triplet format is mutable.";
  _allocate_more_space x;
  let k = i * x.n + j in
  match y = Complex.zero with
  | true  -> (
    if Hashtbl.mem x.h k then (
      let l = Hashtbl.find x.h k in
      let t = x.d.{l} in
      _remove_ith_triplet x l;
      Hashtbl.remove x.h k;
      if t <> Complex.zero then x.nz <- x.nz - 1
    )
    )
  | false -> (
    let l = (
      if Hashtbl.mem x.h k then (
        Hashtbl.find x.h k
      )
      else (
        let t = x.nz in
        x.nz <- x.nz + 1;
        Hashtbl.add x.h k t;
        t
      )
    )
    in
    x.i.(l) <- i;
    x.p.(l) <- j;
    x.d.{l} <- y;
    )

let _get_triplet x i j =
  let k = i * x.n + j in
  if Hashtbl.mem x.h k then (
    let l = Hashtbl.find x.h k in
    x.d.{l}
  )
  else Complex.zero

let _get_crs x i j =
  let a = x.p.(i) in
  let b = x.p.(i + 1) in
  let k = ref a in
  while !k < b && x.i.(!k) <> j do k := !k + 1 done;
  if !k < b then x.d.{!k}
  else Complex.zero

let get x i j =
  match x.typ with
  | 0 -> _get_triplet x i j
  | 2 -> _get_crs x i j
  | _ -> failwith "unsupported sparse format."

let shape x = (x.m, x.n)

let row_num x = x.m

let col_num x = x.n

let numel x = (row_num x) * (col_num x)

let nnz x = x.nz

let density x =
  let a, b = nnz x, numel x in
  (float_of_int a) /. (float_of_int b)

let eye n =
  let x = zeros n n in
  for i = 0 to (row_num x) - 1 do
      set x i i Complex.one
  done;
  x

let _random_basic f m n =
  let c = int_of_float ((float_of_int (m * n)) *. 0.15) in
  let x = zeros m n in
  for k = 0 to c do
    let i = Owl_stats.Rnd.uniform_int ~a:0 ~b:(m-1) () in
    let j = Owl_stats.Rnd.uniform_int ~a:0 ~b:(n-1) () in
    set x i j (f ())
  done;
  x

let binary m n = _random_basic (fun () -> Complex.one) m n

let uniform ?(scale=1.) m n =
  _random_basic (fun () ->
    let re = Owl_stats.Rnd.uniform () *. scale in
    let im = Owl_stats.Rnd.uniform () *. scale in
    Complex.({re; im})
  ) m n

let uniform_int ?(a=0) ?(b=99) m n =
  _random_basic (fun () ->
    let re = Owl_stats.Rnd.uniform_int ~a ~b () |> float_of_int in
    let im = Owl_stats.Rnd.uniform_int ~a ~b () |> float_of_int in
    Complex.({re; im})
  ) m n

let iteri f x =
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      f i j (get x i j)
    done
  done

let iter f x = iteri (fun _ _ y -> f y) x

let reset x =
  x.p <- _make_int_array (Array.length x.i);
  x.nz <- 0;
  x.typ <- 0;
  Hashtbl.reset x.h

let row x i =
  let y = zeros 1 (col_num x) in
  for j = 0 to (col_num x) - 1 do
    set y 0 j (get x i j)
  done;
  y

let col x i =
  let y = zeros (row_num x) 1 in
  for j = 0 to (row_num x) - 1 do
    set y j 0 (get x j i)
  done;
  y

let rows x l =
  let m, n = Array.length l, col_num x in
  let y = zeros m n in
  Array.iteri (fun i i' ->
    for j = 0 to n - 1 do
      set y i j (get x i' j)
    done
  ) l;
  y

let cols x l =
  let m, n = row_num x, Array.length l in
  let y = zeros m n in
  Array.iteri (fun j j' ->
    for i = 0 to m - 1 do
      set y i j (get x i j')
    done
  ) l;
  y

let mapi f x =
  let y = zeros (row_num x) (col_num x) in
  iteri (fun i j z -> set y i j (f i j z)) x;
  y

let map f x = mapi (fun _ _ y -> f y) x

let _fold_basic iter_fun f a x =
  let r = ref a in
  iter_fun (fun y -> r := f !r y) x; !r

let fold f a x = _fold_basic iter f a x

let filteri f x =
  let r = ref [||] in
  iteri (fun i j y ->
    if (f i j y) then r := Array.append !r [|(i,j)|]
  ) x; !r

let filter f x = filteri (fun _ _ y -> f y) x

let iteri_nz f x =
  if _is_triplet x then _triplet2crs x;
  for i = 0 to x.m - 1 do
    for k = x.p.(i) to x.p.(i + 1) - 1 do
      let j = x.i.(k) in
      let y = Array1.get x.d k in
      f i j y
    done
  done

let iter_nz f x = iteri_nz (fun _ _ y -> f y) x

let _disassemble_rows x =
  if _is_triplet x then _triplet2crs x;
  let d = Array.init (row_num x) (fun _ -> zeros 1 (col_num x)) in
  let _ = iteri_nz (fun i j z -> set d.(i) 0 j z) x in
  d

let _disassemble_cols x =
  if _is_triplet x then _triplet2crs x;
  let d = Array.init (col_num x) (fun _ -> zeros (row_num x) 1) in
  let _ = iteri_nz (fun i j z -> set d.(j) i 0 z) x in
  d

let iteri_rows f x = Array.iteri (fun i y -> f i y) (_disassemble_rows x)

let iter_rows f x = iteri_rows (fun _ y -> f y) x

let iteri_cols f x = Array.iteri (fun j y -> f j y) (_disassemble_cols x)

let iter_cols f x = iteri_cols (fun _ y -> f y) x

let mapi_nz f x =
  let y = zeros (row_num x) (col_num x) in
  iteri_nz (fun i j z -> set y i j (f i j z)) x;
  y

let map_nz f x = mapi_nz (fun _ _ y -> f y) x

let fold_nz f a x = _fold_basic iter_nz f a x

let filteri_nz f x =
  let r = ref [||] in
  iteri_nz (fun i j y ->
    if (f i j y) then r := Array.append !r [|(i,j)|]
  ) x; !r

let filter_nz f x = filteri_nz (fun _ _ y -> f y) x

let mapi_rows f x =
  let a = _disassemble_rows x in
  Array.init (row_num x) (fun i -> f i a.(i))

let map_rows f x = mapi_rows (fun _ y -> f y) x

let mapi_cols f x =
  let a = _disassemble_cols x in
  Array.init (col_num x) (fun i -> f i a.(i))

let map_cols f x = mapi_cols (fun _ y -> f y) x

let fold_rows f a x = _fold_basic iter_rows f a x

let fold_cols f a x = _fold_basic iter_cols f a x

let iteri_rows_nz f x = iteri_rows (fun i y -> if y.nz != 0 then f i y) x

let iter_rows_nz f x = iteri_rows_nz (fun _ y -> f y) x

let iteri_cols_nz f x = iteri_cols (fun i y -> if y.nz != 0 then f i y) x

let iter_cols_nz f x = iteri_cols_nz (fun _ y -> f y) x

let mapi_rows_nz f x =
  let a = _disassemble_rows x in
  let r = ref [||] in
  Array.iteri (fun i y ->
    if (nnz y) != 0 then r := Array.append !r [|f i y|]
  ) a; !r

let map_rows_nz f x = mapi_rows_nz (fun _ y -> f y) x

let mapi_cols_nz f x =
  let a = _disassemble_cols x in
  let r = ref [||] in
  Array.iteri (fun i y ->
    if (nnz y) != 0 then r := Array.append !r [|f i y|]
  ) a; !r

let map_cols_nz f x = mapi_cols_nz (fun _ y -> f y) x

let fold_rows_nz f a x = _fold_basic iter_rows_nz f a x

let fold_cols_nz f a x = _fold_basic iter_cols_nz f a x

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

let clone x =
  let d = _make_elt_array (Array1.dim x.d) in
  let _ = Array1.blit x.d d in
  {
    m   = x.m;
    n   = x.n;
    i   = Array.copy x.i;
    d   = d;
    p   = Array.copy x.p;
    nz  = x.nz;
    typ = x.typ;
    h   = Hashtbl.copy x.h;
  }

let nnz_rows x =
  let s = Hashtbl.create 1000 in
  let _ = iteri_nz (fun i _ _ -> if not (Hashtbl.mem s i) then Hashtbl.add s i 0) x in
  Hashtbl.fold (fun k v l -> l @ [k]) s [] |> Array.of_list

let nnz_cols x =
  let s = Hashtbl.create 1000 in
  let _ = iteri_nz (fun _ j _ -> if not (Hashtbl.mem s j) then Hashtbl.add s j 0) x in
  Hashtbl.fold (fun k v l -> l @ [k]) s [] |> Array.of_list

let row_num_nz x = nnz_rows x |> Array.length

let col_num_nz x = nnz_cols x |> Array.length

(** matrix mathematical operations *)

let mul_scalar x y = map_nz (fun z -> Complex.(mul z y)) x

let div_scalar x y = mul_scalar x (Complex.inv y)

let add x1 x2 =
  let y = zeros (row_num x1) (col_num x1) in
  let _ = iteri_nz (fun i j a ->
    let b = get x2 i j in
    if b = Complex.zero then set y i j a
  ) x1 in
  let _ = iteri_nz (fun i j a ->
    let b = get x1 i j in
    set y i j Complex.(add a b)
  ) x2 in
  y

let neg x = map_nz Complex.neg x

let dot x1 x2 =
  let m1, n1 = shape x1 in
  let m2, n2 = shape x2 in
  if n1 <> m2 then failwith "dimension mistach";
  let y = zeros m1 n2 in
  iteri_nz (fun i j a ->
    iteri_nz (fun i' j' b ->
      if j = i' then (
        let c = get y i j' in
        set y i j' Complex.(add c (mul a b))
      )
    ) x2
  ) x1;
  y

let sub x1 x2 = add x1 (neg x2)

let mul x1 x2 =
  let y = zeros (row_num x1) (col_num x1) in
  let _ = iteri_nz (fun i j a ->
    let b = get x2 i j in
    if b <> Complex.zero then set y i j (Complex.mul a b)
  ) x1 in
  y

let div x1 x2 =
  let y = zeros (row_num x1) (col_num x1) in
  let _ = iteri_nz (fun i j a ->
    let b = get x2 i j in
    if b <> Complex.zero then set y i j Complex.(mul a (inv b))
  ) x1 in
  y

let abs x = map_nz (fun y -> Complex.({re = norm y; im = 0.})) x

let sum x = fold_nz Complex.add Complex.zero x

let average x =
  let a = sum x in
  let b = Complex.({re = float_of_int (numel x); im = 0.}) in
  Complex.div a b

let power x c = map_nz (fun y -> Complex.pow y c) x

let is_zero x = x.nz = 0

let is_positive x =
  if x.nz < (x.m * x.n) then false
  else for_all (( < ) Complex.zero) x

let is_negative x =
  if x.nz < (x.m * x.n) then false
  else for_all (( > ) Complex.zero) x

let is_nonnegative x =
  for_all_nz (( <= ) Complex.zero) x

let minmax x =
  let xmin = ref Complex.({re = infinity; im = infinity}) in
  let xmax = ref Complex.({re = neg_infinity; im = neg_infinity}) in
  iter_nz (fun y ->
    if y < !xmin then xmin := y;
    if y > !xmax then xmax := y;
  ) x;
  match x.nz < (numel x) with
  | true  -> (min !xmin Complex.zero), (max !xmax Complex.zero)
  | false -> !xmin, !xmax

let min x = fst (minmax x)

let max x = snd (minmax x)

let is_equal x1 x2 = sub x1 x2 |> is_zero

let is_unequal x1 x2 = not (is_equal x1 x2)

let is_greater x1 x2 = is_positive (sub x1 x2)

let is_smaller x1 x2 = is_greater x2 x1

let equal_or_greater x1 x2 = is_nonnegative (sub x1 x2)

let equal_or_smaller x1 x2 = equal_or_greater x2 x1

(** advanced matrix methematical operations *)

let diag x =
  let m = Pervasives.min (row_num x) (col_num x) in
  let y = zeros 1 m in
  iteri_nz (fun i j z ->
    if i = j then set y 0 j z else ()
  ) x; y

let trace x = sum (diag x)

(** transform to and from different types *)

let to_dense x =
  let m, n = shape x in
  let y = Owl_dense_complex.zeros m n in
  iteri (fun i j z -> Owl_dense_complex.set y i j z) x;
  y

let of_dense x =
  let m, n = Owl_dense_complex.shape x in
  let y = zeros m n in
  Owl_dense_complex.iteri (fun i j z -> set y i j z) x;
  y

let sum_rows x =
  let y = Owl_dense_complex.ones 1 (row_num x) |> of_dense in
  dot y x

let sum_cols x =
  let y = Owl_dense_complex.ones (col_num x) 1 |> of_dense in
  dot x y

let average_rows x =
  let m, n = shape x in
  let a = 1. /. (float_of_int m) in
  let y = Owl_dense_complex.create 1 m Complex.({re = a; im = 0.}) |> of_dense in
  dot y x

let average_cols x =
  let m, n = shape x in
  let a = 1. /. (float_of_int n) in
  let y = Owl_dense_complex.create n 1 Complex.({re = a; im = 0.}) |> of_dense in
  dot x y

(** formatted input / output operations *)

let print x =
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      let c = get x i j in
      Printf.printf "(%.2f, %.2fi) " Complex.(c.re) Complex.(c.im)
    done;
    print_endline ""
  done

let pp_spmat x =
  let m, n = shape x in
  let c = nnz x in
  let p = 100. *. (density x) in
  (* let mz, nz = row_num_nz x, col_num_nz x in *)
  let mz, nz = 0, 0 in
  let _ = if m < 100 && n < 100 then Owl_dense_complex.pp_dsmat (to_dense x) in
  Printf.printf "shape = (%i,%i) | (%i,%i); nnz = %i (%.1f%%)\n" m n mz nz c p

let save x f =
  let s = Marshal.to_string x [] in
  let h = open_out f in
  output_string h s;
  close_out h

let load f =
  let h = open_in f in
  let s = really_input_string h (in_channel_length h) in
  Marshal.from_string s 0

(** permutation and draw functions *)

let permutation_matrix d =
  let l = Array.init d (fun x -> x) |> Owl_stats.shuffle in
  let y = zeros d d in
  let _ = Array.iteri (fun i j -> set y i j Complex.one) l in y

let draw_rows ?(replacement=true) x c =
  let m, n = shape x in
  let a = Array.init m (fun x -> x) |> Owl_stats.shuffle in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in
  let y = zeros c m in
  let _ = Array.iteri (fun i j -> set y i j Complex.one) l in
  dot y x, l

let draw_cols ?(replacement=true) x c =
  let m, n = shape x in
  let a = Array.init n (fun x -> x) |> Owl_stats.shuffle in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in
  let y = zeros n c in
  let _ = Array.iteri (fun j i -> set y i j Complex.one) l in
  dot x y, l

let shuffle_rows x =
  let y = permutation_matrix (row_num x) in dot y x

let shuffle_cols x =
  let y = permutation_matrix (col_num x) in dot x y

let shuffle x = x |> shuffle_rows |> shuffle_cols

let ones m n = Owl_dense_complex.ones m n |> of_dense

(** short-hand infix operators *)

let ( +@ ) = add

let ( -@ ) = sub

let ( *@ ) = mul

let ( /@ ) = div

let ( $@ ) = dot

let ( **@ ) = power

let ( *$ ) x a = mul_scalar x a

let ( $* ) a x = mul_scalar x a

let ( /$ ) x a = div_scalar x a

let ( $/ ) a x = div_scalar x a

let ( =@ ) = is_equal

let ( >@ ) = is_greater

let ( <@ ) = is_smaller

let ( <>@ ) = is_unequal

let ( >=@ ) = equal_or_greater

let ( <=@ ) = equal_or_smaller




(** ends here *)
