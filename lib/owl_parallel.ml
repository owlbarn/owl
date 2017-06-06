(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Experimental module, do not use now *)


module type Mapre_Engine = sig

  val map : ('a -> 'b) -> string -> string

  val map_partition: ('a list -> 'b list) -> string -> string

  val union : string -> string -> string

  val reduce : ('a -> 'a -> 'a) -> string -> 'a option

  val collect : string -> 'a list

  val workers : unit -> string list

  val myself : unit -> string

  val load : string -> string

  val save : string -> string -> int

end


module type Ndarray = sig

  type arr
  type elt

  val shape : arr -> int array

  val zeros : int array -> arr

  val ones  : int array -> arr

  val uniform : ?scale:float -> int array -> arr

  val numel : arr -> int

  val get : arr -> int array -> elt

  val set : arr -> int array -> elt -> unit

  val map : ?axis:int option array -> (elt -> elt) -> arr -> arr

  val map2 : ?axis:int option array -> (elt -> elt -> elt) -> arr -> arr -> arr

  val sin : arr -> arr

  val add : arr -> arr -> arr

  val sub : arr -> arr -> arr

  val mul : arr -> arr -> arr

  val div : arr -> arr -> arr

end


module Make_Distributed (M : Ndarray) (E : Mapre_Engine) = struct

  type distr_arr = {
    mutable id      : string;
    mutable shape   : int array;
    mutable c_start : int array;
    mutable c_len   : int array;
  }

  let make_distr_arr id shape c_start c_len = {
    id;
    shape;
    c_start;
    c_len;
  }

  let divide_to_chunks shape n =
    let total_sz = Array.fold_left (fun a b -> a * b) 1 shape in
    let chunk_sz = total_sz / n in
    match chunk_sz = 0 with
    | true  -> [| (0, total_sz) |]
    | false -> (
        Array.init n (fun i ->
          let c_start = i * chunk_sz in
          let c_len = match i = n - 1 with
            | true  -> total_sz - c_start
            | false -> chunk_sz
          in
          c_start, c_len
        )
      )

  (* make a distributed version of [create_fun d], the elements will be
  distributed among the working nodes. *)
  let distributed_create create_fun d =
    let workers = E.workers () in
    let chunks = divide_to_chunks d (List.length workers) in
    let c_start = Array.map fst chunks in
    let c_len = Array.map snd chunks in
    let id = E.map (fun _ ->
      let me = E.myself () in
      let pos = Owl_utils.list_search me workers in
      me, create_fun [|c_len.(pos)|]
    ) ""
    in
    make_distr_arr id d c_start c_len

  let zeros d =
    let create_fun d = M.zeros d in
    distributed_create create_fun d

  let ones d =
    let create_fun d = M.ones d in
    distributed_create create_fun d

  let uniform ?scale d =
    let create_fun d = M.uniform ?scale d in
    distributed_create create_fun d

  let map_chunk f x =
    let y_id = E.map (fun (node_id, arr) ->
      node_id, f arr
    ) x.id
    in
    let shape = Array.copy x.shape in
    let c_start = Array.copy x.c_start in
    let c_len = Array.copy x.c_len in
    make_distr_arr y_id shape c_start c_len

  let map f x = map_chunk (M.map f) x

  let map2_chunk f x y =
    assert (x.shape = y.shape);
    let z_id = E.union x.id y.id in
    let z_id = E.map_partition (fun l ->
      let x_node_id, x_arr = List.nth l 0 in
      let y_node_id, y_arr = List.nth l 1 in
      [ (x_node_id, f x_arr y_arr) ]
    ) z_id
    in
    let shape = Array.copy x.shape in
    let c_start = Array.copy x.c_start in
    let c_len = Array.copy x.c_len in
    make_distr_arr z_id shape c_start c_len

  let map2 f x y = map2_chunk (M.map2 f) x y

  let fold f x a =
    let y_id = E.map (fun (node_id, arr) ->
      let b = ref M.(get arr [|0|]) in
      for i = 1 to M.numel arr - 1 do
        b := f !b M.(get arr [|i|])
      done;
      !b
    ) x.id in
    E.collect y_id
    |> List.fold_left (fun b c -> f b (List.nth c 0)) a

  let sin x = map_chunk M.sin x

  let add x y = map2_chunk M.add x y

  let sub x y = map2_chunk M.sub x y

  let mul x y = map2_chunk M.mul x y

  let div x y = map2_chunk M.div x y

end



module Make_Shared (M : Ndarray) (E : Mapre_Engine) = struct


end



module type Ndarray_Any = sig

  type 'a arr

  val shape : 'a arr -> int array

  val numel : 'a arr -> int

  val create : int array -> 'a -> 'a arr

end


module Make_Distributed_Any (M : Ndarray_Any) (E : Mapre_Engine) = struct

  type distr_arr = {
    mutable id      : string;
    mutable shape   : int array;
    mutable c_start : int array;
    mutable c_len   : int array;
  }

  let make_distr_arr id shape c_start c_len = {
    id;
    shape;
    c_start;
    c_len;
  }

  let divide_to_chunks shape n =
    let total_sz = Array.fold_left (fun a b -> a * b) 1 shape in
    let chunk_sz = total_sz / n in
    match chunk_sz = 0 with
    | true  -> [| (0, total_sz) |]
    | false -> (
        Array.init n (fun i ->
          let c_start = i * chunk_sz in
          let c_len = match i = n - 1 with
            | true  -> total_sz - c_start
            | false -> chunk_sz
          in
          c_start, c_len
        )
      )

  let distributed_create create_fun d =
    let workers = E.workers () in
    let chunks = divide_to_chunks d (List.length workers) in
    let c_start = Array.map fst chunks in
    let c_len = Array.map snd chunks in
    let id = E.map (fun _ ->
      let me = E.myself () in
      let pos = Owl_utils.list_search me workers in
      me, create_fun [|c_len.(pos)|]
    ) ""
    in
    make_distr_arr id d c_start c_len

end
