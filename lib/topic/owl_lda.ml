(** [ Topic Model ] Experimental for LDA model  *)

module MS = Owl_sparse_real
module MD = Owl_dense_real

module Model = struct

  let n_d = 0          (* number of documents *)
  let n_k = 1          (* number of topics *)
  let n_v = 0          (* number of vocabulary *)

  let alpha = 0.0      (* model hyper-parameters *)
  let beta = 0.0       (* model hyper-parameters *)
  let alpha_k = 0.0
  let beta_v = 0.0

  let t_dk = MS.zeros 1 1        (* document-topic table: num of tokens assigned to each topic in each doc *)
  let t_wk = MS.zeros 1 1        (* word-topic table: num of tokens assigned to each topic for each word *)
  let t__k = MS.zeros 1 n_k      (* number of tokens assigned to a topic: k = sum_w t_wk = sum_d t_dk *)
  let t__z = MS.zeros 1 1        (* table of topic assignment of each token in each document *)

  let data = MS.zeros 1 1  (* training data *)
  let n_iter = 1_000       (* number of iterations *)

  let init () = ()

  let include_token w d k =
    MS.(set t__k 0 k (get t__k 0 k +. 1.));
    MS.(set t_wk w k (get t_wk w k +. 1.));
    MS.(set t_dk d k (get t_dk d k +. 1.))

  let exclude_token w d k =
    MS.(set t__k 0 k (get t__k 0 k -. 1.));
    MS.(set t_wk w k (get t_wk w k -. 1.));
    MS.(set t_dk d k (get t_dk d k -. 1.))

  let sampling d =
    let p = MD.zeros 1 n_k in
    MS.iteri_nz (fun _ i w ->
      let w = int_of_float w in
      let k = MS.get t__z d i |> int_of_float in
      exclude_token w d k;
      (* make cdf function *)
      let x = ref 0. in
      for j = 0 to n_k - 1 do
        x := !x +. (MS.get t_dk d j +. alpha_k) *. (MS.get t_wk w j +. beta) /. (MS.get t__k 0 j +. beta_v);
        MD.set p 0 j !x;
      done;
      (* draw a sample *)
      let u = Owl_stats.Rnd.uniform () *. !x in
      let k = ref 0 in
      while (MD.get p 0 !k) < u do k := !k + 1 done;
      include_token w d !k;
      MS.set t__z d i (float_of_int !k);
    ) (MS.row data d)

  let train () =
    for i = 0 to n_iter - 1 do
      for j = 0 to n_d - 1 do
        sampling j
      done
    done

  let load_data f =
    let x = Owl_topic_utils.load_data f in
    x

end
