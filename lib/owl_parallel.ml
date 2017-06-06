(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Experimental module, do not use now *)


module type Mapre_Engine = sig

  val workers : unit -> string list

  val myself : unit -> string

  val load : string -> string

  val save : string -> string -> int

  val map : ('a -> 'b) -> string -> string

  val reduce : ('a -> 'a -> 'a) -> string -> 'a option

  val collect : string -> 'a list

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

  val print : arr -> unit

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

  let map f x =
    let id = E.map (fun (node_id, arr) ->
      (* NOTE: keep node_id as the consistent format! *)
      node_id, M.map f arr
    ) x.id in
    let shape = Array.copy x.shape in
    let c_start = Array.copy x.c_start in
    let c_len = Array.copy x.c_len in
    make_distr_arr id shape c_start c_len

  let fold f x a =
    let id = E.map (fun (node_id, arr) ->
      let b = ref M.(get arr [|0|]) in
      for i = 1 to M.numel arr - 1 do
        b := f !b M.(get arr [|i|])
      done;
      !b
    ) x.id in
    E.collect id
    |> List.fold_left (fun b c -> f b (List.nth c 0)) a



end
