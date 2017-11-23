(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

module S = Pervasives


(* Functor of making Lazy module of different number types *)

module Make
  (A : InpureSig)
  = struct

  (* type definitions *)

  type state = Valid | Invalid

  type value =
    | Elt of A.elt
    | Arr of A.arr

  type node = {
    mutable name  : string;
    mutable op    : op;
    mutable prev  : node array;
    mutable next  : node array;
    mutable state : state;
    mutable value : value array;
  }
  and op =
    | Noop
    | Fun00 of (A.arr -> A.arr)
    | Fun01 of (A.arr -> unit)
    | Fun02 of (A.arr -> A.arr -> unit) * (A.arr -> A.arr -> A.arr)
    | Fun03 of (A.arr -> A.elt -> unit)
    | Fun04 of (A.elt -> A.arr -> unit)
    | Fun05 of (A.arr array -> A.arr)
    | Fun06 of (A.arr -> A.arr array)
    | ItemI of int (* select the ith item in an array *)


  (* core functions to manipulate computation graphs *)

  let node ?(name="") ?(prev=[||]) ?(next=[||]) ?(state=Invalid) ?(value=[||]) op = {
    name;
    op;
    prev;
    next;
    state;
    value;
  }


  let connect parents children =
    Array.iter (fun parent ->
      Array.iter (fun child ->
          parent.next <- (Array.append parent.next [|child|]);
          child.prev <- (Array.append child.prev [|parent|]);
      ) children
    ) parents


  let refnum x = Array.length x.next

  let unpack_arr = function Arr x -> x | _ -> failwith "owl_lazy: unpack_arr"

  let unpack_elt = function Elt x -> x | _ -> failwith "owl_lazy: unpack_elt"

  let check_noop x = assert (Array.length x.value > 0)

  let validate x = x.state <- Valid

  let invalidate x = x.state <- Invalid

  let shall_eval x = Array.length x.value = 0 || x.state = Invalid

  (* find the root inputs of x *)
  let find_roots x =
    let s = Owl_utils.Stack.make () in
    let rec _find_roots x =
      Array.iter (fun n ->
        if n.op = Noop then Owl_utils.Stack.push s n
        else _find_roots n
      ) x.prev
    in
    _find_roots x;
    Owl_utils.Stack.to_array s

  (* update x's dependency graph by invalidating stale nodes *)
  let update_dependency x = ()

  let allocate_1 x =
    let x_val = unpack_arr x.value.(0) in
    if refnum x = 1 then x_val
    else A.copy x_val


  let allocate_2 x y =
    let x_val = unpack_arr x.value.(0) in
    let y_val = unpack_arr y.value.(0) in
    let x_shp = A.shape x_val in
    let y_shp = A.shape y_val in
    if x_shp = y_shp then (
      if refnum x = 1 then Some (x_val, y_val)
      else if refnum y = 1 then Some (y_val, x_val)
      else if refnum x = 2 && x == y then Some (x_val, y_val)
      else Some (A.copy x_val, y_val)
    )
    else if Owl_utils.array_greater_eqaul x_shp y_shp && refnum x = 1 then Some (x_val, y_val)
    else if Owl_utils.array_greater_eqaul y_shp x_shp && refnum y = 1 then Some (y_val, x_val)
    else None


  let rec _eval_term x =
    if shall_eval x then (
      let _ = match x.op with
        | Noop         -> check_noop x
        | Fun00 f      -> ()
        | Fun01 f      -> _eval_map1 x f
        | Fun02 (f, g) -> _eval_map2 x f g
        | Fun03 f      -> ()
        | Fun04 f      -> ()
        | Fun05 f      -> ()
        | Fun06 f      -> ()
        | ItemI i      -> ()
      in
      validate x
    )

  (* [f] is inpure, for [arr -> arr] *)
  and _eval_map1 x f =
    let operand = x.prev.(0) in
    _eval_term operand;
    let a = allocate_1 operand in
    f a;
    x.value <- [|Arr a|]

  (* [f] is inpure and [g] is pure, for [arr -> arr -> arr] *)
  and _eval_map2 x f g =
    _eval_term x.prev.(0);
    _eval_term x.prev.(1);
    let a = unpack_arr x.prev.(0).value.(0) in
    let b = unpack_arr x.prev.(1).value.(0) in
    let c = match allocate_2 x.prev.(0) x.prev.(1) with
      | Some (p, q) -> f p q; p    (* in-place function, p will be written *)
      | None        -> g a b       (* pure function without touching a and b *)
    in
    x.value <- [|Arr c|]


  let eval x = _eval_term x

  let var () = node ~value:[||] Noop

  let assign x x_val =
    x.value <- [|x_val|];
    invalidate x

  let assign_arr x x_val = assign x (Arr x_val)

  let assign_elt x x_val = assign x (Elt x_val)

  let of_ndarray x = node ~value:[|Arr x|] Noop

  let to_ndarray x =
    _eval_term x;
    x.value.(0) |> unpack_arr


  (* unary and binary math functions *)

  let add x y =
    let z = node ~name:"add" (Fun02 (A.add_, A.add)) in
    connect [|x|] [|z|];
    connect [|y|] [|z|];
    z


  let sin x =
    let y = node ~name:"sin" (Fun01 A.sin_) in
    connect [|x|] [|y|];
    y



end
