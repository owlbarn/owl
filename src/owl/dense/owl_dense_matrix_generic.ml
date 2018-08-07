(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_ndarray

include Owl_dense_ndarray_generic


(* area function *)

let shape x =
  let x_shape = shape x in
  assert (Array.length x_shape = 2);
  x_shape.(0), x_shape.(1)


(* creation functions *)

let empty k m n = Owl_dense_ndarray_generic.empty k [|m;n|]


let create k m n a = Owl_dense_ndarray_generic.create k [|m;n|] a


let zeros k m n = Owl_dense_ndarray_generic.zeros k [|m;n|]


let ones k m n = Owl_dense_ndarray_generic.ones k [|m;n|]


let init k m n f = Owl_dense_ndarray_generic.init k [|m;n|] f


let init_2d k m n f =
  let x = empty k m n in
  let y = Bigarray.array2_of_genarray x in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      Bigarray.Array2.unsafe_set y i j (f i j)
    done;
  done;
  x


let eye k n = Owl_dense_ndarray_generic.eye k n


let sequential k ?a ?step m n =
  Owl_dense_ndarray_generic.sequential k ?a ?step [|m;n|]


let linspace k a b n =
  let x = Owl_dense_ndarray_generic.linspace k a b n in
  reshape x [|1;n|]


let logspace k ?base a b n =
  let x = Owl_dense_ndarray_generic.logspace k ?base a b n in
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


let triu ?(k=0) x =
  let _kind = kind x in
  let m, n = shape x in
  let y = zeros _kind m n in

  let ofs = ref (Pervasives.(min n (max 0 k))) in
  let len = ref (Pervasives.(max 0 (min n (n - k)))) in
  let loops = Pervasives.(max 0 (min m (n - k))) in

  for i = 0 to loops - 1 do
    _owl_copy _kind !len ~ofsx:!ofs ~incx:1 ~ofsy:!ofs ~incy:1 x y;
    if i + k >= 0 then (
      ofs := !ofs + n + 1;
      len := !len - 1
    )
    else ofs := !ofs + n
  done;
  (* return the final upper triangular matrix *)
  y


let tril ?(k=0) x =
  let _kind = kind x in
  let m, n = shape x in
  let y = zeros _kind m n in

  let row_i = Pervasives.(min m (abs (min 0 k))) in
  let len = ref (Pervasives.(min n ((max 0 k) + 1))) in
  let ofs = ref (row_i * n) in

  for i = row_i to m - 1 do
    _owl_copy _kind !len ~ofsx:!ofs ~incx:1 ~ofsy:!ofs ~incy:1 x y;
    ofs := !ofs + n;
    if !len < n then
      len := !len + 1
  done;
  (* return the final lower triangular matrix *)
  y


let symmetric ?(upper=true) x =
  let _kind = kind x in
  let m, n = shape x in
  assert (m = n);
  let y = copy x in

  let ofs = ref 0 in
  let incx, incy =
    match upper with
    | true  -> 1, m
    | false -> m, 1
  in
  for i = 0 to m - 1 do
    _owl_copy _kind (m - i) ~ofsx:!ofs ~incx ~ofsy:!ofs ~incy y y;
    ofs := !ofs + n + 1
  done;
  (* return the symmetric matrix *)
  y


let bidiagonal ?(upper=true) dv ev =
  let m = numel dv in
  let n = numel ev in
  assert (m - n = 1);

  let x = zeros (kind dv) m m in
  let _x = Bigarray.array2_of_genarray x in
  let _dv = flatten dv |> Bigarray.array1_of_genarray in
  let _ev = flatten ev |> Bigarray.array1_of_genarray in

  let i, j = match upper with
    | true  -> 0, 1
    | false -> 1, 0
  in
  for k = 0 to m - 2 do
    _x.{k, k} <- _dv.{k};
    _x.{k+i, k+j} <- _ev.{k}
  done;
  _x.{m-1, m-1} <- _dv.{m-1};
  x


let hermitian ?(upper=true) x =
  let m, n = shape x in
  assert (m = n);

  let y = copy x in
  let _y = flatten y |> Bigarray.array1_of_genarray in
  let _conj_op = _owl_conj (kind x) in
  let ofs = ref 0 in

  let incx, incy =
    match upper with
    | true  -> 1, m
    | false -> m, 1
  in
  for i = 0 to m - 1 do
    (* copy and conjugate *)
    _conj_op (m - i) ~ofsx:!ofs ~incx ~ofsy:!ofs ~incy y y;
    (* set the imaginary part to zero by default. *)
    let a = _y.{!ofs} in
    _y.{!ofs} <- Complex.( {re = a.re; im = 0.} );
    ofs := !ofs + n + 1
  done;
  (* return the symmetric matrix *)
  y


let uniform k ?a ?b m n = Owl_dense_ndarray_generic.uniform k ?a ?b [|m;n|]


let gaussian k ?mu ?sigma m n = Owl_dense_ndarray_generic.gaussian k ?mu ?sigma [|m;n|]


let bernoulli k ?p m n = Owl_dense_ndarray_generic.bernoulli k ?p [|m;n|]


let toeplitz ?c r =
  let c = match c with
    | Some c -> c
    | None   -> conj r
  in
  let m = numel c in
  let n = numel r in
  Owl_dense_ndarray_generic.(set c [|0;0|] (get r [|0;0|]));
  let _kind = kind r in
  let x = empty _kind m n in
  let ofs = ref 0 in
  let loops = Pervasives.min m n in

  for i = 0 to loops - 1 do
    _owl_copy _kind (n - i) ~ofsx:0 ~incx:1 ~ofsy:!ofs ~incy:1 r x;
    _owl_copy _kind (m - i) ~ofsx:0 ~incx:1 ~ofsy:!ofs ~incy:n c x;
    ofs := !ofs + n + 1;
  done;
  x


let hankel ?r c =
  let m = numel c in
  let r = match r with
    | Some r -> r
    | None   -> zeros (kind c) 1 m
  in
  let n = numel r in
  Owl_dense_ndarray_generic.(set r [|0;0|] (get c [|0;m-1|]));
  let _kind = kind r in
  let x = empty _kind m n in
  let ofs = ref ( (m - 1) * n ) in
  let loops = Pervasives.min m n in

  for i = 0 to loops - 1 do
    _owl_copy _kind (n - i) ~ofsx:0 ~incx:1 ~ofsy:!ofs ~incy:1 r x;
    _owl_copy _kind (m - i) ~ofsx:i ~incx:1 ~ofsy:i ~incy:n c x;
    ofs := !ofs - n + 1;
  done;
  x


let kron a b =
  let int_floor q r = int_of_float((float_of_int q) /. (float_of_int r)) in
  let nra, nca = shape a in
  let nrb, ncb = shape b in
  let nrk, nck = ((nra*nrb), (nca*ncb)) in
  let k = empty (kind a) nrk nck in
  let _mul_op = _mul_elt (kind a) in

  let _a = Bigarray.array2_of_genarray a in
  let _b = Bigarray.array2_of_genarray b in
  let _k = Bigarray.array2_of_genarray k in

  for i = 1 to nrk do
    for j = 1 to nck do
      let ai = (int_floor (i-1) nrb) + 1 in
      let aj = (int_floor (j-1) ncb) + 1 in
      let bi = ((i-1) mod nrb) + 1 in
      let bj = ((j-1) mod ncb) + 1 in
      _k.{i-1,j-1} <- _mul_op _a.{ai-1,aj-1} _b.{bi-1,bj-1}
    done
  done;
  k


(* obtain properties *)

let get x i j = Owl_dense_ndarray_generic.get x [|i;j|]


let set x i j a = Owl_dense_ndarray_generic.set x [|i;j|] a


let swap_rows x i i' =
  let m, n = shape x in
  Owl_matrix._matrix_swap_rows (kind x) x m n i i'


let swap_cols x j j' =
  let m, n = shape x in
  Owl_matrix._matrix_swap_cols (kind x) x m n j j'


let transpose x =
  let k = kind x in
  let m, n = shape x in
  let y = empty k n m in
  Owl_matrix._matrix_transpose k x y;
  y


let ctranspose x =
  let k = kind x in
  let m, n = shape x in
  let y = empty k n m in
  Owl_matrix._matrix_ctranspose k x y;
  y


(* iteration functions *)


let iteri_rows f x =
  for i = 0 to (row_num x) - 1 do
    f i (row x i)
  done


let iter_rows f x = iteri_rows (fun _ y -> f y) x


let iter2i_rows f x y =
  assert (row_num x = row_num y);
  iteri_rows (fun i u -> f i u (row y i)) x


let iter2_rows f x y = iter2i_rows (fun _ u v -> f u v) x y


let _row x i =
  (* get row i of x, but return as a column vector *)
  let y = slice_left x [|i|] in
  reshape y [|(col_num x); 1|]


let iteri_cols f x =
  let y = transpose x in
  for i = 0 to (col_num x) - 1 do
    f i (_row y i)
  done


let iter_cols f x = iteri_cols (fun _ y -> f y) x


let mapi_rows f x = Array.init (row_num x) (fun i -> f i (row x i))


let map_rows f x = mapi_rows (fun _ y -> f y) x


let mapi_cols f x =
  let y = transpose x in
  Array.init (col_num x) (fun i -> f i (_row y i))


let map_cols f x = mapi_cols (fun _ y -> f y) x


let mapi_by_row d f x =
  let y = empty (kind x) (row_num x) d in
  iteri_rows (fun i z ->
    copy_row_to (f i z) y i
  ) x; y


let map_by_row d f x = mapi_by_row d (fun _ y -> f y) x


let mapi_by_col d f x =
  let y = empty (kind x) d (col_num x) in
  iteri_cols (fun j z ->
    copy_col_to (f j z) y j
  ) x;
  y


let map_by_col d f x = mapi_by_col d (fun _ y -> f y) x


let mapi_at_row f x i =
  let v = mapi (fun j y -> f j y) (row x i) in
  let y = copy x in
  copy_row_to v y i;
  y


let map_at_row f x i = mapi_at_row (fun _ y -> f y) x i


let mapi_at_col f x j =
  let v = mapi (fun i y -> f i y) (col x j) in
  let y = copy x in
  copy_col_to v y j;
  y


let map_at_col f x j = mapi_at_col (fun _ y -> f y) x j


let filteri_rows f x =
  let s = Owl_utils.Stack.make () in
  iteri_rows (fun i v ->
    if (f i v) then Owl_utils.Stack.push s i
  ) x;
  Owl_utils.Stack.to_array s


let filter_rows f x = filteri_rows (fun _ v -> f v) x


let filteri_cols f x =
  let s = Owl_utils.Stack.make () in
  iteri_cols (fun i v ->
    if (f i v) then Owl_utils.Stack.push s i
  ) x;
  Owl_utils.Stack.to_array s


let filter_cols f x = filteri_cols (fun _ v -> f v) x


let _fold_basic iter_fun f a x =
  let r = ref a in
  iter_fun (fun y -> r := f !r y) x;
  !r


let fold_rows f a x = _fold_basic iter_rows f a x


let fold_cols f a x = _fold_basic iter_cols f a x


let iteri_2d f x =
  let y = array2_of_genarray x in
  let m, n = shape x in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      f i j (Array2.unsafe_get y i j)
    done
  done


let mapi_2d f x =
  let y = copy x in
  let z = array2_of_genarray y in
  let m, n = shape y in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      let a = Array2.unsafe_get z i j in
      Array2.unsafe_set z i j (f i j a)
    done
  done;
  y


let filteri_2d f x =
  let s = Owl_utils.Stack.make () in
  let y = array2_of_genarray x in
  let m, n = shape x in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      let a = Array2.unsafe_get y i j in
      if f i j a = true then
        Owl_utils.Stack.push s (i, j)
    done
  done;
  Owl_utils.Stack.to_array s


let foldi_2d ?axis f a x =
  foldi_nd ?axis (fun k acc b ->
    let i = k.(0) and j = k.(1) in
    f i j acc b
  ) a x


let scani_2d ?axis f x =
  scani_nd ?axis (fun k a b ->
    let i = k.(0) and j = k.(1) in
    f i j a b
  ) x


let iter2i_2d f x y =
  assert (same_shape x y);
  let m, n = shape x in
  let x = array2_of_genarray x in
  let y = array2_of_genarray y in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      let a = Array2.unsafe_get x i j in
      let b = Array2.unsafe_get y i j in
      f i j a b
    done
  done


let map2i_2d f x y =
  assert (same_shape x y);
  let m, n = shape x in
  let z = copy x in
  let x = array2_of_genarray z in
  let y = array2_of_genarray y in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      let a = Array2.unsafe_get x i j in
      let b = Array2.unsafe_get y i j in
      Array2.unsafe_set x i j (f i j a b)
    done
  done;
  z


let sum_cols x = sum ~axis:1 x


let sum_rows x = sum ~axis:0 x


let mean_cols x = mean ~axis:1 x


let mean_rows x = mean ~axis:0 x


let min_cols x =
  mapi_cols (fun j v ->
    let r, i = min_i v in r, i.(0), j
  ) x

let min_rows x =
  mapi_rows (fun i v ->
    let r, j = min_i v in r, i, j.(1)
  ) x

let max_cols x =
  mapi_cols (fun j v ->
    let r, i = max_i v in r, i.(0), j
  ) x

let max_rows x =
  mapi_rows (fun i v ->
    let r, j = max_i v in r, i, j.(1)
  ) x


let mean' x = _mean_elt (kind x) (sum' x) (numel x)


let add_diag x a =
  let m, n = shape x in
  let m = Pervasives.min m n in
  let y = copy x in
  let _op = _add_elt (kind x) in
  for i = 0 to m - 1 do
    let b = Owl_dense_ndarray_generic.get x [|i;i|] in
    Owl_dense_ndarray_generic.set y [|i;i|] (_op b a)
  done;
  y


(* io operations *)

let of_array k x m n =
  let open Bigarray in
  let y = Array1.of_array k C_layout x |> genarray_of_array1 in
  Owl_dense_ndarray_generic.reshape y [|m; n|]


let save_txt ?(sep="\t") ?(append=false) x f =
  let perm = 0o666 in (* will be AND'ed with user's umask *)
  let open_flags = if append
                   then [Open_wronly; Open_creat; Open_append; Open_text]
		   else [Open_wronly; Open_creat; Open_trunc;  Open_text]
  in
  let _op = Owl_utils.elt_to_str (kind x) in
  let h = open_out_gen open_flags perm f in
  iter_rows (fun y ->
    iter (fun z -> Printf.fprintf h "%s%s" (_op z) sep) y;
    Printf.fprintf h "\n"
  ) x;
  close_out h


let load_txt ?(sep="\t") k f =
  let _op = Owl_utils.elt_of_str k in
  let h = open_in f in
  let s = input_line h in
  let n = List.length(Str.split (Str.regexp sep) s) in
  let m = ref 1 in (* count lines in the input file *)
  (
    try while true do
      ignore(input_line h); m := !m + 1
    done with End_of_file -> ()
  );
  let x = zeros k !m n in
  seek_in h 0;
  for i = 0 to !m - 1 do
    let s = Str.split (Str.regexp sep) (input_line h) in
    List.iteri (fun j y -> set x i j (_op y)) s
  done;
  close_in h; x


let semidef k n =
  let x = uniform k n n in
  dot (transpose x) x


let shuffle_rows x =
  let m, n = shape x in
  let y = copy x in
  for i = 0 to m - 1 do
    swap_rows y i (Owl_stats.uniform_int_rvs ~a:0 ~b:(m-1))
  done; y


let shuffle_cols x =
  let m, n = shape x in
  let y = copy x in
  for i = 0 to n - 1 do
    swap_cols y i (Owl_stats.uniform_int_rvs ~a:0 ~b:(n-1))
  done; y


let shuffle x = x |> shuffle_rows |> shuffle_cols


let meshgrid k xa xb ya yb xn yn =
  let u = linspace k xa xb xn in
  let v = linspace k ya yb yn in
  let x = map_by_row xn (fun _ -> u) (empty k yn xn) in
  let y = map_by_row yn (fun _ -> v) (empty k xn yn) in
  x, transpose y

let meshup x y =
  let k = kind x in
  let xn = numel x in
  let yn = numel y in
  let x = map_by_row xn (fun _ -> x) (empty k yn xn) in
  let y = map_by_row yn (fun _ -> y) (empty k xn yn) in
  x, transpose y


(* Hadamard Matrix *)

let _hadamard_12 = Array.map float_of_int
  [|
    1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
    1;-1; 1;-1; 1; 1; 1;-1;-1;-1; 1;-1;
    1;-1;-1; 1;-1; 1; 1; 1;-1;-1;-1; 1;
    1; 1;-1;-1; 1;-1; 1; 1; 1;-1;-1;-1;
    1;-1; 1;-1;-1; 1;-1; 1; 1; 1;-1;-1;
    1;-1;-1; 1;-1;-1; 1;-1; 1; 1; 1;-1;
    1;-1;-1;-1; 1;-1;-1; 1;-1; 1; 1; 1;
    1; 1;-1;-1;-1; 1;-1;-1; 1;-1; 1; 1;
    1; 1; 1;-1;-1;-1; 1;-1;-1; 1;-1; 1;
    1; 1; 1; 1;-1;-1;-1; 1;-1;-1; 1;-1;
    1;-1; 1; 1; 1;-1;-1;-1; 1;-1;-1; 1;
    1; 1;-1; 1; 1; 1;-1;-1;-1; 1;-1;-1;
  |]


let _hadamard_20 = Array.map float_of_int
  [|
    1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
    1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;
    1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;
    1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1;
    1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1;
    1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;
    1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;
    1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;
    1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;
    1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1;
    1;-1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;
    1; 1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1;
    1;-1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;
    1; 1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1;
    1; 1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1;
    1; 1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1;
    1; 1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1;
    1;-1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;
    1;-1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;
    1; 1;-1;-1; 1; 1;-1;-1;-1;-1; 1;-1; 1;-1; 1; 1; 1; 1;-1;-1;
  |]


let hadamard k n =
  (* function to build up hadamard matrix recursively *)
  let rec _make_hadamard
    (cp_op  : ('a, 'b) Owl_core_types.owl_arr_op18)
    (neg_op : ('a, 'b) Owl_core_types.owl_arr_op18)
    len n base x =
    if len = base then ()
    else (
      let len' = len / 2 in
      _make_hadamard cp_op neg_op len' n base x;
      let ofsx = ref 0 in
      for i = 0 to len' - 1 do
        let x1_ofs = !ofsx + len' in
        let x2_ofs = !ofsx + len' * n in
        let x3_ofs = x2_ofs + len' in
        cp_op len' ~ofsx:!ofsx ~incx:1 ~ofsy:x1_ofs ~incy:1 x x;
        cp_op len' ~ofsx:!ofsx ~incx:1 ~ofsy:x2_ofs ~incy:1 x x;
        cp_op len' ~ofsx:!ofsx ~incx:1 ~ofsy:x3_ofs ~incy:1 x x;
        (* negate the bottom right block *)
        neg_op len' ~ofsx:x3_ofs ~incx:1 ~ofsy:x3_ofs ~incy:1 x x;
        ofsx := !ofsx + n;
      done;
    )
  in
  (* function to convert the pre-calculated hadamard array into type k *)
  let _float_array_to_k : type a b. (a, b) kind -> float array -> a array =
    fun k a -> match k with
    | Bigarray.Float32   -> a
    | Bigarray.Float64   -> a
    | Bigarray.Complex32 -> Array.map (fun b -> Complex.({re=b; im=0.})) a
    | Bigarray.Complex64 -> Array.map (fun b -> Complex.({re=b; im=0.})) a
    | _                  -> failwith "Owl_dense_matrix_generic.hadamard"
  in
  (* start building, only deal with pow2 of n, n/12, n/20. *)
  let x = empty k n n in
  let cp_op = _owl_copy k in
  let neg_op = _owl_neg k in
  if Owl_maths.is_pow2 n then (
    Owl_dense_ndarray_generic.set x [|0;0|] (Owl_const.one k);
    _make_hadamard cp_op neg_op n n 1 x;
    x
  )
  else if Owl_maths.is_pow2 (n / 12) && Pervasives.(n mod 12) = 0 then (
    let y = _float_array_to_k k _hadamard_12 in
    let y = of_array k y 12 12 in
    let _area = area 0 0 11 11 in
    copy_area_to y _area x _area;
    _make_hadamard cp_op neg_op n n 12 x;
    x
  )
  else if Owl_maths.is_pow2 (n / 20) && Pervasives.(n mod 20) = 0 then (
    let y = _float_array_to_k k _hadamard_20 in
    let y = of_array k y 20 20 in
    let _area = area 0 0 19 19 in
    copy_area_to y _area x _area;
    _make_hadamard cp_op neg_op n n 20 x;
    x
  )
  else
    failwith "Owl_dense_matrix_generic:hadamard"


let magic k n =
  assert (n >= 3);
  let a0 = Owl_const.zero k in
  let a1 = Owl_const.one k in

  let _magic_odd n a =
    let x = zeros k n n in
    let i = ref 0 in
    let j = ref (n / 2) in
    let ac = ref (float_of_int a |> _float_typ_elt k) in
    let m = n * n + a - 1 |> float_of_int |> _float_typ_elt k in

    while !ac <= m do
      if (get x !i !j) = a0 then (
        set x !i !j !ac;
        ac := _add_elt k !ac a1
      )
      else (
        let i' = (!i - 1 + n) mod n in
        let j' = (!j + 1) mod n in
        if (get x i' j') = a0 then (
          i := i';
          j := j'
        )
        else i := (!i + 1) mod n
      )
    done;
    x
  in

  let _magic_doubly_even n =
    let x = zeros k n n in

    let _seq_inc x i0 j0 i1 j1 =
      for i = i0 to i1 do
        let ac = ref (n * i + j0 + 1 |> float_of_int |> _float_typ_elt k) in
        for j = j0 to j1 do
          set x i j !ac;
          ac := _add_elt k !ac a1
        done
      done
    in
    let _seq_dec x i0 j0 i1 j1 =
      let ac = ref (n * n |> float_of_int |> _float_typ_elt k) in
      for i = i0 to i1 do
        for j = j0 to j1 do
          if (get x i j) = a0 then set x i j !ac;
          ac := _sub_elt k !ac a1
        done
      done
    in

    let m = n / 4 in
    _seq_inc x 0 0 (m - 1) (m - 1);
    _seq_inc x 0 (3 * m) (m - 1) (4 * m - 1);
    _seq_inc x m m (3 * m - 1) (3 * m - 1);
    _seq_inc x (3 * m) 0 (4 * m - 1) (m - 1);
    _seq_inc x (3 * m) (3 * m) (4 * m - 1) (4 * m - 1);
    _seq_dec x 0 0 (n - 1) (n - 1);
    x
  in

  let _magic_singly_even n =
    let m = n / 2 in
    let m2 = m * m in
    let xa = _magic_odd m 1 in
    let xb = _magic_odd m (m2 + 1) in
    let xc = _magic_odd m (2 * m2 + 1) in
    let xd = _magic_odd m (3 * m2 + 1) in

    let m3 = m / 2 in
    let xa' = concat_horizontal (get_slice [[];[0;m3-1]] xd) (get_slice [[];[m3;-1]] xa) in
    let xd' = concat_horizontal (get_slice [[];[0;m3-1]] xa) (get_slice [[];[m3;-1]] xd) in
    let xb' =
      if m3 - 1 = 0 then xb
      else concat_horizontal (get_slice [[];[0;m-m3]] xb) (get_slice [[];[1-m3;-1]] xc)
    in
    let xc' =
      if m3 - 1 = 0 then xc
      else concat_horizontal (get_slice [[];[0;m-m3]] xc) (get_slice [[];[1-m3;-1]] xb)
    in
    set xa' m3 0  (get xa m3 0);
    set xa' m3 m3 (get xd m3 m3);
    set xd' m3 0  (get xd m3 0);
    set xd' m3 m3 (get xa m3 m3);
    concat_horizontal (concat_vertical xa' xd') (concat_vertical xc' xb')
  in

  (* n is odd *)
  if Owl_maths.is_odd n then _magic_odd n 1
  (* n is doubly even *)
  else if n mod 4 = 0 then _magic_doubly_even n
  (* n is singly even *)
  else _magic_singly_even n


let max_pool ?padding x kernel stride =
  let m, n = shape x in
  let x = Owl_dense_ndarray_generic.reshape x [|1;m;n;1|] in
  let y = Owl_dense_ndarray_generic.max_pool2d ?padding x kernel stride in
  let s = Owl_dense_ndarray_generic.shape y in
  let m, n = s.(1), s.(2) in
  Owl_dense_ndarray_generic.reshape y [|m;n|]


let avg_pool ?padding x kernel stride =
  let m, n = shape x in
  let x = Owl_dense_ndarray_generic.reshape x [|1;m;n;1|] in
  let y = Owl_dense_ndarray_generic.avg_pool2d ?padding x kernel stride in
  let s = Owl_dense_ndarray_generic.shape y in
  let m, n = s.(1), s.(2) in
  Owl_dense_ndarray_generic.reshape y [|m;n|]


let cov ?b ~a =
  let a = match b with
    | Some b -> (
        let na = numel a in
        let nb = numel b in
        assert (na = nb);
        let a = reshape a [|na;1|] in
        let b = reshape b [|nb;1|] in
        concat_horizontal a b
      )
    | None   -> a
  in

  let mu = mean_rows a in
  let a = sub a mu in
  let a' = ctranspose a in
  let c = dot a' a in

  let n = row_num a - 1
    |> Pervasives.max 1
    |> float_of_int
    |> Owl_ndarray._float_typ_elt (kind a)
  in

  div_scalar c n


let mat2gray ?amin ?amax x =
  let amin = match amin with
    | Some a -> a
    | None   -> min' x
  in
  let amax = match amax with
    | Some a -> a
    | None   -> max' x
  in
  let x = clip_by_value ~amin ~amax x in
  let x = sub_scalar x amin in
  div_scalar x (_sub_elt (kind x) amax amin)


(* end here *)
