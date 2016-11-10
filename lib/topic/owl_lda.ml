(** [ Topic Model ] Experimental for LDA model  *)

module MX = Owl_sparse_real

module Model = struct

  (* model hyper-parameters *)
  let aplha = 0.0
  let beta = 0.0

  let n_d = 0      (* number of documents *)
  let n_k = 0      (* number of topics *)
  let n_v = 0      (* number of vocabulary *)

  let t_dk = MX.zeros 0 0  (* document-topic table: num of tokens assigned to each topic in each doc *)
  let t_wk = MX.zeros 0 0  (* word-topic table: num of tokens assigned to each topic for each word *)
  let t__k = MX.zeros 1 0  (* number of tokens assigned to a topic: k = sum_w t_wk = sum_d t_dk *)
  let t__z = MX.zeros 0 0  (* table of topic assignment of each token in each document *)

  let data = MX.zeros 0 0  (* training data *)
  let n_iter = 1_000       (* number of iterations *)

  let init () = ()

  let add_to_topic w d k = None

  let remove_from_topic w d k =
    let w = int_of_float w in
    let d = int_of_float d in
    let k = int_of_float k in
    MX.(set t__k 0 k (get t__k 0 k -. 1.));
    MX.(set t_wk w k (get t_wk w k -. 1.));
    ()

  let sampling d =
    MX.iter_nz (fun _ i w ->
      let w = int_of_float w in
      let k = MX.get t__z d i |> int_of_float in
      remove_from_topic w d k
    ) (MX.row data d)

  let train () =
    for i = 0 to n_iter - 1 do
      for j = 0 to MX.num_row t_dk - 1 do
        sampling j
      done
    done

end
