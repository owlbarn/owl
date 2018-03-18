(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* An extended version of OCaml's array for Owl's internal use. *)


include Array


(* filter array, f : int -> 'a -> bool * 'b *)
let filteri_v f x =
  let r = Owl_utils_stack.make () in
  iteri (fun i a ->
    let y, z = f i a in
    if y = true then Owl_utils_stack.push r z
  ) x;
  Owl_utils_stack.to_array r


(* filter array, f : 'a -> bool * 'b *)
let filter_v f x = filteri_v (fun _ y -> f y) x


(* filter array, f : int -> 'a -> bool *)
let filteri f x =
  if Array.length x = 0 then [||]
  else (
    let r = Owl_utils_stack.make () in
    iteri (fun i a ->
      if f i a then Owl_utils_stack.push r a
    ) x;
    Owl_utils_stack.to_array r
  )


(* filter array, f : 'a -> bool *)
let filter f x = filteri (fun _ y -> f y) x


let mapi f x =
  let n = Array.length x in
  if n = 0 then [||]
  else (
    let r = Owl_utils_stack.make () in
    iteri (fun i a -> Owl_utils_stack.push r (f i a)) x;
    Owl_utils_stack.to_array r
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
    let z0 = Owl_utils_stack.make () in
    let z1 = Owl_utils_stack.make () in
    for i = 1 to c - 1 do
      let a, b = f i x.(i) y.(i) in
      Owl_utils_stack.push z0 a;
      Owl_utils_stack.push z1 b;
    done;
    Owl_utils_stack.(to_array z0, to_array z1)
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
    done with _ -> b := false
  );
  !b


(* swap the ith and jth element in an array *)
let swap x i j =
  let a = x.(i) in
  x.(i) <- x.(j);
  x.(j) <- a
