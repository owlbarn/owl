(** [ Topic Model ] Experimental for LDA model  *)

module MS = Owl_sparse_real
module MD = Owl_dense_real

module Model = struct

  let n_d = ref 0          (* number of documents *)
  let n_k = ref 1          (* number of topics *)
  let n_v = ref 0          (* number of vocabulary *)

  let alpha = ref 0.1      (* model hyper-parameters *)
  let beta = ref 0.1       (* model hyper-parameters *)
  let alpha_k = ref 0.1
  let beta_v = ref 0.1

  let t_dk = ref (MS.zeros 1 1)        (* document-topic table: num of tokens assigned to each topic in each doc *)
  let t_wk = ref (MS.zeros 1 1)        (* word-topic table: num of tokens assigned to each topic for each word *)
  let t__k = ref (MS.zeros 1 1)        (* number of tokens assigned to a topic: k = sum_w t_wk = sum_d t_dk *)
  let t__z = ref [| [||] |]            (* table of topic assignment of each token in each document *)

  let data = ref [| [ ] |]  (* training data *)
  let n_iter = 1_000        (* number of iterations *)

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
    List.iteri (fun i w ->
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
    ) !data.(d)

  (* init the model based on: vocabulary, topics, tokens *)
  let init k v d =
    Log.info "init the model";
    data := d;
    (* set model parameters *)
    n_d  := Array.length d;
    n_v  := v;
    n_k  := k;
    t_dk := MS.zeros !n_d !n_k;
    t_wk := MS.zeros !n_v !n_k;
    t__k := MS.zeros 1 !n_k;
    (* set model hyper-parameters *)
    alpha := 50.;
    alpha_k := !alpha /. (float_of_int k);
    beta := 0.1;
    beta_v := (float_of_int v) *. !beta;
    (* randomise the topic assignment for each token *)
    t__z := Array.mapi (fun i s ->
      Array.init (List.length s) (fun j ->
        let k' = Owl_stats.Rnd.uniform_int ~a:0 ~b:(k - 1) () in
        include_token (List.nth s j) i k';
        k'
      )
    ) d;
    ()

  let likelihood () =
    let _sum = ref 0. in
    let n_token = ref 0 in
    (* every document *)
    for i = 0 to !n_d - 1 do
      let dlen = Array.length !t__z.(i) in
      n_token := !n_token + dlen;
      let dsum = ref 0. in
      (* every token *)
      for j = 0 to dlen - 1 do
        let wsum = ref 0. in
        let w = List.nth !data.(i) j in
        (* every topic *)
        for k = 0 to !n_k - 1 do
          wsum := !wsum +. (MS.get !t_dk i k +. !alpha_k) *. (MS.get !t_wk w k +. !beta) /. (MS.get !t__k 0 k +. !beta_v);
        done;
        dsum := !dsum +. (Owl_maths.log2 !wsum);
      done;
      let dlen = float_of_int dlen in
      _sum := !_sum +. !dsum -. dlen *. (Owl_maths.log2 dlen);
    done;
    !_sum /. (float_of_int !n_token)

  let train () =
    for i = 0 to n_iter - 1 do
      Log.info "iteration #%i - likelihood = %.3f" i (likelihood ());
      for j = 0 to !n_d - 1 do
        (* Log.info "iteration #%i - doc#%i" i j; *)
        sampling j
      done
    done
end
