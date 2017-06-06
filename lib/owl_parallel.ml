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

end


module type Ndarray = sig

  type arr

  val shape : arr -> int array

  val zeros : int array -> arr

  val uniform : ?scale:float -> int array -> arr

  val numel : arr -> int

end


module Make_Distributed (E : Mapre_Engine) (M : Ndarray) = struct

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

  let zeros d =
    let workers = E.workers () in
    let chunks = divide_to_chunks d (List.length workers) in
    let c_start = Array.map fst chunks in
    let c_len = Array.map snd chunks in
    let id = E.map (fun _ ->
      let me = E.myself () in
      let pos = Owl_utils.list_search me workers in
      me, M.zeros [|c_len.(pos)|]
    ) ""
    in
    make_distr_arr id d c_start c_len

  let uniform ?scale d =
    let workers = E.workers () in
    let chunks = divide_to_chunks d (List.length workers) in
    let c_start = Array.map fst chunks in
    let c_len = Array.map snd chunks in
    let id = E.map (fun _ ->
      let me = E.myself () in
      let pos = Owl_utils.list_search me workers in
      me, M.uniform ?scale [|c_len.(pos)|]
    ) ""
    in
    make_distr_arr id d c_start c_len


end
