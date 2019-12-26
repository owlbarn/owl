(* Functor to make the CountMin sketch using a specified underlying table *)
module Make (T : Owl_countmin_table.Sig) : Owl_countmin_sketch_sig.Sig = struct
  (* the type of sketches *)
  type 'a sketch =
    { tbl : T.t
    ; w : int
    ; hash_fns : (int * int * int) array
    }

  (* the prime number to use for hashing *)
  let bigprime = (1 lsl 31) - 1

  (* Calculate (a*x + b) mod (2^31 - 1) *)
  let hash31 x a b =
    let result = (a * x) + b in
    ((result lsr 31) + result) land bigprime


  let init_lw l w =
    let gen_rand_int _ = Owl_base_stats_dist_uniform.uniform_int_rvs ((1 lsl 30) - 1) in
    let gen_rand_pair i = i, gen_rand_int (), gen_rand_int () in
    { tbl = T.init l w; w; hash_fns = Array.init l gen_rand_pair }


  let init ~epsilon ~delta =
    (* set l = log (1/delta) and w = 1/epsilon *)
    init_lw
      Owl_base_maths.(1. /. delta |> log2 |> ceil |> int_of_float)
      Owl_base_maths.(1. /. epsilon |> ceil |> int_of_float)


  let incr s x =
    let xh = Hashtbl.hash x in
    let iterfn (i, ai, bi) = T.incr i (hash31 xh ai bi mod s.w) s.tbl in
    Array.iter iterfn s.hash_fns


  let count s x =
    let xh = Hashtbl.hash x in
    let foldfn prv (i, ai, bi) = T.get i (hash31 xh ai bi mod s.w) s.tbl |> min prv in
    Array.fold_left foldfn max_int s.hash_fns


  let init_from { tbl = _; w; hash_fns } =
    let l = Array.length hash_fns in
    { tbl = T.init l w; w; hash_fns = Array.copy hash_fns }


  let merge s1 s2 =
    let open Owl_exception in
    let exn = INVALID_ARGUMENT "Attempt to merge non-mergeable count-min sketches" in
    check (s1.w = s2.w) exn;
    check (s1.hash_fns = s2.hash_fns) exn;
    try { tbl = T.merge s1.tbl s2.tbl; w = s1.w; hash_fns = s1.hash_fns } with
    | INVALID_ARGUMENT _ -> raise exn
end

module Native = Make (Owl_countmin_table.Native)
module Owl = Make (Owl_countmin_table.Owl)
