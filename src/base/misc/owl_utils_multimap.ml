(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* An implementation of an ordered multimap for Owl's internal use.
 * Simulates an ordered multimap using Map and Owl_utils.Stack values.
 * Functions behave in the same way as those in Map, with the difference that
 * one key can be bound to multiple values.
 * Access and removals are O(log n). *)
module Make (Ord : Map.OrderedType) = struct

  module Stack = Owl_utils.Stack

  module Map = Map.Make(Ord)

  type key = Ord.t

  type 'a t = ('a Stack.t) Map.t


  let _fail f_name = failwith ("owl_utils_multimap: " ^ f_name ^
                                 ": no stack should be empty")


  let empty = Map.empty


  let is_empty = Map.is_empty


  let mem = Map.mem


  let add k v map =
    if Map.mem k map then (
      let stack_k = Map.find k map in
      Stack.push stack_k v;
      map
    )
    else (
      let stack_k = Stack.make () in
      Stack.push stack_k v;
      Map.add k stack_k map
    )


  let remove k map =
    let stack_k = match Map.find_opt k map with
      | Some s -> s
      | None   -> raise Not_found in
    let () = match Stack.pop stack_k with
      | Some _ -> ()
      | None   -> _fail "remove" in
    if Stack.is_empty stack_k then Map.remove k map
    else map


  let find k map =
    let stack_k = match Map.find_opt k map with
      | Some s -> s
      | None   -> raise Not_found in
    match Stack.peek stack_k with
      | Some v -> v
      | None   -> _fail "find"


  let max_binding map =
    let k, stack = match Map.max_binding_opt map with
      | Some (k, s) -> k, s
      | None        -> raise Not_found in
    let v = match Stack.peek stack with
      | Some v -> v
      | None   -> _fail "max_binding"
    in
    k, v


  let find_first_opt f map =
    match Map.find_first_opt f map with
    | Some (k, s) -> (match Stack.peek s with
                      | Some v -> Some (k, v)
                      | None   -> _fail "find_first_opt")
    | None        -> None


end
