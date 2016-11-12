(** [ Topic Model ] Experimental for LDA model  *)

module MS = Owl_sparse_real
module MD = Owl_dense_real

module Model = struct

  let n_d = ref 0          (* number of documents *)
  let n_k = ref 1          (* number of topics *)
  let n_v = ref 0          (* number of vocabulary *)

  let alpha = ref 0.0      (* model hyper-parameters *)
  let beta = ref 0.0       (* model hyper-parameters *)
  let alpha_k = ref 0.0
  let beta_v = ref 0.0

  let t_dk = ref (MS.zeros 1 1)        (* document-topic table: num of tokens assigned to each topic in each doc *)
  let t_wk = ref (MS.zeros 1 1)        (* word-topic table: num of tokens assigned to each topic for each word *)
  let t__k = ref (MS.zeros 1 1)        (* number of tokens assigned to a topic: k = sum_w t_wk = sum_d t_dk *)
  let t__z = ref [| [||] |]            (* table of topic assignment of each token in each document *)

  let data = ref (MS.zeros 1 1)  (* training data *)
  let n_iter = 1_000       (* number of iterations *)

  let init_lda () = ()

  let include_token w d k =
    MS.(set !t__k 0 k (get !t__k 0 k +. 1.));
    MS.(set !t_wk w k (get !t_wk w k +. 1.));
    MS.(set !t_dk d k (get !t_dk d k +. 1.))

  let exclude_token w d k =
    MS.(set !t__k 0 k (get !t__k 0 k -. 1.));
    MS.(set !t_wk w k (get !t_wk w k -. 1.));
    MS.(set !t_dk d k (get !t_dk d k -. 1.))

  let sampling d =
    let p = MD.zeros 1 !n_k in
    MS.iteri_nz (fun _ i w ->
      let w = int_of_float w in
      let k = !t__z.(d).(i) in
      exclude_token w d k;
      (* make cdf function *)
      let x = ref 0. in
      for j = 0 to !n_k - 1 do
        x := !x +. (MS.get !t_dk d j +. !alpha_k) *. (MS.get !t_wk w j +. !beta) /. (MS.get !t__k 0 j +. !beta_v);
        MD.set p 0 j !x;
      done;
      (* draw a sample *)
      let u = Owl_stats.Rnd.uniform () *. !x in
      let k = ref 0 in
      while (MD.get p 0 !k) < u do k := !k + 1 done;
      include_token w d !k;
      !t__z.(d).(i) <- !k;
    ) (MS.row !data d)

  let train () =
    for i = 0 to n_iter - 1 do
      for j = 0 to !n_d - 1 do
        sampling j
      done
    done

  (* init the model based on: vocabulary, topics, tokens *)
  let init k v d =
    n_d := Array.length d;
    n_v := v;
    n_k := k;
    t_dk := MS.zeros !n_d !n_k;
    t_wk := MS.zeros !n_v !n_k;
    t__k := MS.zeros 1 !n_k;
    t__z := Array.map (fun s ->
      Array.make (List.length s) 0
    ) d;
    ()

end
