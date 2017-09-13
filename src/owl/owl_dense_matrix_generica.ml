(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_common

include Owl_dense_ndarray_generic


(* creation functions *)

let empty k m n = Owl_dense_ndarray_generic.empty k [|m;n|]

let create k m n a = Owl_dense_ndarray_generic.create k [|m;n|] a

let zeros k m n = Owl_dense_ndarray_generic.zeros k [|m;n|]

let ones k m n = Owl_dense_ndarray_generic.ones k [|m;n|]

let init k m n f = Owl_dense_ndarray_generic.init k [|m;n|] f

let init_nd k m n f =
  let x = empty k m n in
  let y = Bigarray.array2_of_genarray x in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      Bigarray.Array2.unsafe_set y i j (f i j)
    done;
  done;
  x

let eye k n =
  let x = zeros k n n in
  let y = Bigarray.array2_of_genarray x in
  let a = _one k in
  for i = 0 to n - 1 do
    Bigarray.Array2.unsafe_set y i i a
  done;
  x

let sequential k ?a ?step m n =
  Owl_dense_ndarray_generic.sequential k ?a ?step [|m;n|]

let linspace k a b n =
  let x = Owl_dense_ndarray_generic.linspace k a b n in
  reshape x [|1;n|]

let logspace k ?(base=Owl_maths.e) a b n =
  let x = Owl_dense_ndarray_generic.logspace k ~base a b n in
  Owl_dense_ndarray_generic.reshape x [|1;n|]

let diagm ?(k=0) v =
  let open Pervasives in
  let n = numel v in
  let u = reshape v [|n|] in
  let x = zeros (kind v) (n + abs k) (n + abs k) in
  let i, j =
    match k < 0 with
    | true  -> abs k, 0
    | false -> 0, abs k
  in
  for k = 0 to n - 1 do
    set x [|i+k; j+k|] (get u [|k|])
  done;
  x

(* obtain properties *)

let get x i j = Owl_dense_ndarray_generic.get x [|i;j|]

let set x i j a = Owl_dense_ndarray_generic.set x [|i;j|] a

let _is_matrix x =
  let x_shape = shape x in
  assert (Array.length x_shape = 2);
  x_shape.(0), x_shape.(1)

let row_num x = _is_matrix x |> fst

let col_num x = _is_matrix x |> snd

let row x i =
  let m, n = _is_matrix x in
  assert (i < m);
  let y = Bigarray.Genarray.slice_left x [|i|] in
  reshape y [|1;n|]

let col x j =
  let m, n = _is_matrix x in
  assert (j < n);
  let y = empty (kind x) m 1 in
  let x' = flatten x |> Bigarray.array1_of_genarray in
  let y' = flatten y |> Bigarray.array1_of_genarray in
  _owl_copy m ~ofsx:j ~incx:n ~ofsy:0 ~incy:1 x' y';
  y

let concat_vertical x1 x2 = concatenate ~axis:0 [|x1;x2|]

let concat_horizontal x1 x2 = concatenate ~axis:1 [|x1;x2|]

(* let rows = ... *)

(* let cols = ... *)

(* let swap_rows = ... *)

(* let swap_cols = ... *)

let transpose x =
  let m, n = _is_matrix x in
  let y = empty (kind x) n m in
  let x' = Bigarray.array2_of_genarray x in
  let y' = Bigarray.array2_of_genarray y in
  Owl_backend_gsl_linalg.transpose_copy (kind x) y' x';
  y

let ctranspose x =
  let m, n = _is_matrix x in
  let y = empty (kind x) n m in
  let x' = flatten x |> Bigarray.array1_of_genarray in
  let y' = flatten y |> Bigarray.array1_of_genarray in
  (* different strategies depends on row/col ratio *)
  let len, incx, incy, iofx, iofy, loops =
    match m <= n with
    | true  -> n, 1, m, n, 1, m
    | false -> m, n, 1, 1, m, n
  in
  let _op = _owl_conj (kind x) in
  let ofsx = ref 0 in
  let ofsy = ref 0 in
  for i = 0 to loops - 1 do
    _op len ~ofsx:!ofsx ~incx ~ofsy:!ofsy ~incy x' y';
    ofsx := !ofsx + iofx;
    ofsy := !ofsy + iofy;
  done;
  y

(* let replace_row = ... *)

(* let replace_col = ... *)
