(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

type ('a, 'b) view = {
  mutable prev  : ('a, 'b) view option;           (* point to the previous view *)
  mutable func  : (int array -> int array);       (* index transformation function *)
  mutable shape : int array;                      (* shape of the view, for checking boundary *)
  mutable data  : ('a, 'b) Owl_dense_ndarray.t;   (* point to the raw data set *)
}

let _append_view p n =
  n.prev <- Some p;
  let f = n.func in
  let g = p.func in
  n.func <- (fun i -> g (f i))

let create x = {
  prev  = None;
  func  = (fun i -> i);
  shape = Owl_dense_ndarray.shape x;
  data  = x;
}

let num_dims x = Array.length x.shape

let shape x = Array.copy x.shape

let nth_dim x i = Array.get x.shape i

let kind x = Owl_dense_ndarray.kind x.data

let numel x = Array.fold_right (fun c a -> c * a) (shape x) 1

let get x i =
  match x.prev = None with
  | true  -> Owl_dense_ndarray.get x.data i
  | false -> Owl_dense_ndarray.get x.data (x.func i)

let set x i =
  match x.prev = None with
  | true  -> Owl_dense_ndarray.set x.data i
  | false -> Owl_dense_ndarray.set x.data (x.func i)

let transpose x =
  let func = (fun i ->
    let i' = Array.copy i in
    Owl_utils.reverse_array i';
    i'
  ) in
  let s = shape x in
  let _ = Owl_utils.reverse_array s in
  let y = {
    prev = None;
    func = func;
    shape = s;
    data = x.data
  }
  in _append_view x y;
  y

let iteri f x =
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

let slice axis x =
  (* TODO: check the validity of the axis *)
  let s0 = shape x in
  let s1 = ref [||] in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None -> s1 := Array.append !s1 [|s0.(i)|]
  ) axis;
  let s = !s1 in
  let i' = Array.make (Array.length axis) 0 in
  let j' = Array.make (Array.length s) 0 in
  let k = ref 0 in
  Array.iteri (fun i a ->
    match a with
    | Some a -> (i'.(i) <- a)
    | None   -> (j'.(!k) <- i; k := !k + 1)
  ) axis;
  let func = (fun i ->
    Array.iteri (fun k a -> i'.(j'.(k)) <- a) i;
    i'
  ) in
  let y = {
    prev = None;
    func = func;
    shape = s;
    data = x.data
  }
  in _append_view x y;
  y

let collapse x = None

let print x =
  let t = kind x in
  iteri (fun i y ->
    Owl_dense_ndarray.print_index i;
    Owl_dense_ndarray.print_element t y
  ) x

(* ends here *)
