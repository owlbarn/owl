(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017
 *   Ben Catterall <bpwc2@cam.ac.uk>
 *   Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl

type lda_typ = SimpleLDA | FTreeLDA | LightLDA | SparseLDA

type model = {
  mutable n_d : int;                      (* number of documents *)
  mutable n_k : int;                      (* number of topics *)
  mutable n_v : int;                      (* number of vocabulary *)

  mutable alpha   : float;                (* model hyper-parameters *)
  mutable beta    : float;                (* model hyper-parameters *)
  mutable alpha_k : float;                (* model hyper-parameters *)
  mutable beta_v  : float;                (* model hyper-parameters *)

  mutable t_dk : float array array;       (* document-topic table: num of tokens assigned to each topic in each doc *)
  mutable t_wk : float array array;       (* word-topic table: num of tokens assigned to each topic for each word *)
  mutable t__k : float array;             (* number of tokens assigned to a topic: k = sum_w t_wk = sum_d t_dk *)
  mutable t__z : int array array;         (* table of topic assignment of each token in each document *)

  mutable iter : int;                     (* number of iterations *)
  mutable data : Owl_nlp_corpus.t;        (* training data, tokenised*)
  mutable vocb : (string, int) Hashtbl.t; (* vocabulary, or dictionary if you prefer *)
}

let include_token m w d k =
  m.t__k.(k) <- (m.t__k.(k) +. 1.);
  m.t_wk.(w).(k) <- (m.t_wk.(w).(k) +. 1.);
  m.t_dk.(d).(k) <- (m.t_dk.(d).(k) +. 1.)

let exclude_token m w d k =
  m.t__k.(k) <- (m.t__k.(k) -. 1.);
  m.t_wk.(w).(k) <- (m.t_wk.(w).(k) -. 1.);
  m.t_dk.(d).(k) <- (m.t_dk.(d).(k) -. 1.)

let show_info m i t =
  Log.info "iter#%i t(s):%.1f t_dk:%.3f t_wk:%.3f" i t 0. 0.

(* implement several LDA with specific samplings *)

module SimpleLDA = struct

  let init m = ()

  let sampling m d doc =
    let p = Array.make m.n_k 0. in
    Array.iteri (fun i w ->
      let k = m.t__z.(d).(i) in
      exclude_token m w d k;
      (* make cdf function *)
      let x = ref 0. in
      for j = 0 to m.n_k - 1 do
        x := !x +. (m.t_dk.(d).(j) +. m.alpha_k) *. (m.t_wk.(w).(j) +. m.beta) /. (m.t__k.(j) +. m.beta_v);
        p.(j) <- !x;
      done;
      (* draw a sample *)
      let u = Stats.Rnd.uniform () *. !x in
      let k = ref 0 in
      while p.(!k) < u do k := !k + 1 done;
      include_token m w d !k;
      m.t__z.(d).(i) <- !k;
    ) doc

end


module SparseLDA = struct

  let s = ref 0.    (* Cache of s *)
  let q = ref [| |] (* Cache of q *)
  let r_non_zero : (int, float) Hashtbl.t ref = ref (Hashtbl.create 1) (*  *)
  let q_non_zero : (int, bool)  Hashtbl.t ref = ref (Hashtbl.create 1) (*  *)

  let exclude_token_sparse m w d k ~s ~r ~q =
    let t__klocal = ref m.t__k.(k) in
    (* Reduce s, r  l *)
    s := !s -. (m.beta *. m.alpha_k) /. (!t__klocal +. m.beta_v);
    r := !r -. (m.beta *. m.t_dk.(d).(k)) /. (m.beta_v +. !t__klocal);
    exclude_token m w d k;
    (* add back in  s,r *)
    t__klocal :=  m.t__k.(k);
    Array.set !q k ((m.alpha_k +. m.t_dk.(d).(k)) /. (m.beta_v +. !t__klocal));
    let r_local = m.t_dk.(d).(k) in
    (match r_local with
    | 0. ->  Hashtbl.remove !r_non_zero k
    | _  -> (
        Hashtbl.replace !r_non_zero k r_local;
        r := !r +. (m.beta *. r_local) /. (m.beta_v +. !t__klocal)
      )
    );
    s := !s +. (m.beta *. m.alpha_k) /. (!t__klocal +. m.beta_v)

  let include_token_sparse m w d k ~s ~r ~q =
    let t__klocal = ref m.t__k.(k) in
    (* Reduce s, r  l *)
    s := !s -. (m.beta *. m.alpha_k) /. (!t__klocal +. m.beta_v);
    r := !r -. (m.beta *. m.t_dk.(d).(k)) /. (m.beta_v +. !t__klocal);
    include_token m w d k;
    (* add back in s, r *)
    t__klocal :=  m.t__k.(k);
    s := !s +. (m.beta *. m.alpha_k) /. (!t__klocal +. m.beta_v);
    let r_local = m.t_dk.(d).(k) in
    (match r_local with
    | 0. ->  Hashtbl.remove !r_non_zero k
    | _  -> (
        Hashtbl.replace !r_non_zero k r_local;
        r := !r +. (m.beta *. r_local) /. (m.beta_v +. !t__klocal)
      )
    );
    Array.set !q k ((m.alpha_k +. m.t_dk.(d).(k)) /. (m.beta_v +. !t__klocal))

  let init m =
    (* reset module parameters, maybe wrap into model? *)
    s := 0.;
    q := [| |];
    Hashtbl.reset !r_non_zero;
    Hashtbl.reset !q_non_zero;
    (* s is independent of document *)
    let k = ref 0 in
    while !k < m.n_k do
      let t__klocal = m.t__k.(!k) in
      s := !s +. (1. /. (m.beta_v +. t__klocal));
      k := !k + 1;
    done;
    q := (Array.make (m.n_k) 0.);
    r_non_zero := (Hashtbl.create m.n_k);
    q_non_zero := (Hashtbl.create m.n_k);
    s := !s *. (m.alpha_k *. m.beta)

  let sampling m d doc =
    let k = ref 0 in
    let r = ref 0. in (* Cache of r *)
    (* Calculate r *)
    Hashtbl.clear !r_non_zero;
    while !k < m.n_k do
      let t__klocal = m.t__k.(!k) in
      let r_local = m.t_dk.(d).(!k) in
      (* Sparse representation of r *)
      if r_local != 0. then (
        let r_val = r_local /. (m.beta_v +.  t__klocal) in
        r := !r +. r_val;
        Hashtbl.add !r_non_zero !k r_val;
      );
      (* Build up our q cache *)
      (* TODO: efficiently handle t_dk = 0 *)
      Array.set !q !k ((m.alpha_k +. m.t_dk.(d).(!k)) /. (m.beta_v +. t__klocal));
      k := !k + 1;
    done;
    r := !r *. m.beta;

    (* Process the document *)
    Array.iteri (fun i w ->
        let k = m.t__z.(d).(i) in
        exclude_token_sparse m w d k s r q;
        (* Calculate q *)
        let qsum = ref 0. in
        let k_q = ref 0 in
        Hashtbl.clear !q_non_zero;
        (* This bit makes it (K) rather than O(K_d + K_w) *)
        while !k_q < m.n_k do
          let q_local = m.t_wk.(w).(!k_q) in
          if q_local != 0. then (
            qsum := !qsum +. !q.(!k_q) *. q_local;
            Hashtbl.add !q_non_zero !k_q true;
          );
          k_q := !k_q + 1;
        done;
        k_q := 0;
        let u = ref (Stats.Rnd.uniform () *. (!s +. !r +. !qsum)) in
        let k = ref 0 in
        (* Work out which factor to sample from *)
        if !u < !s then (
          (* sum up *)
          u := !u /. (m.alpha_k *. m.beta); (* Don't need this *)
          let slocal = ref 0. in
          while !slocal < !u do
            slocal := !slocal +. ( 1. /. (m.beta_v +. m.t__k.(!k_q)) );
            k_q := !k_q + 1;
          done;
          (* Found our topic (we went past it by one) *)
          k := !k_q - 1;
        )
        else if !u < (!s +. !r) then (
          (* Iterate over set of non-zero r *)
          u := (!u -. !s) /. m.beta; (* compare just to r and don't need !beta *)
          let rlocal = ref 0. in
          (* TODO: pick largest (order by decreasing) for efficiency *)
          Hashtbl.iter (fun key data -> if !rlocal < !u then (
                    rlocal := !rlocal +. (data) /. ( m.beta_v +. m.t__k.(key) );
                    k := key)
              ) !r_non_zero
        )
        else (
          u := !u -. (!s +. !r);
          let qlocal = ref 0. in
          (* Iterate over set of non-zero q *)
          (* TODO: make descending *)
          Hashtbl.iter (fun key _ ->
            if !qlocal < !u then (
              qlocal := !qlocal +. !q.(key) *. m.t_wk.(w).(key);
              k := key
            )
          ) !q_non_zero
        );
        include_token_sparse m w d !k s r q;
        m.t__z.(d).(i) <- !k;
      ) doc

end


module FTreeLDA = struct

  let init m = ()

  let sampling m d doc = ()

end


module LightLDA = struct

  let init m = ()

  let sampling m d doc = ()

end


(* init the model based on: topics, vocabulary, tokens *)
let init ?(iter=100) k v d =
  Log.info "init the model";
  (* set basic model stats *)
  let n_d = Owl_nlp_corpus.count_num_doc d in
  let n_v = Hashtbl.length v in
  let n_k = k in
  (* set model hyper-parameters *)
  let alpha = 50. in
  let beta = 0.1 in
  let alpha_k = alpha /. (float_of_int n_k) in
  let beta_v = (float_of_int n_v) *. beta in
  (* init model parameters *)
  let t_dk = Array.init n_d (fun _ -> Array.make n_k 0.) in
  let t_wk = Array.init n_v (fun _ -> Array.make n_k 0.) in
  let t__k = Array.make n_k 0. in
  (* set document data and vocabulary *)
  let data = d in
  let vocb = v in
  (* init a partial model *)
  let m = {
    n_d;
    n_k;
    n_v;
    alpha;
    beta;
    alpha_k;
    beta_v;
    t_dk;
    t_wk;
    t__k;
    t__z = [||];
    iter;
    data;
    vocb;
  }
  in
  (* randomise the topic assignment for each token *)
  m.t__z <- Owl_nlp_corpus.mapi_tokenised_docs (fun i s ->
    Array.init (Array.length s) (fun j ->
      let k' = Stats.Rnd.uniform_int ~a:0 ~b:(k - 1) () in
      include_token m s.(j) i k';
      k'
    )
  ) d;
  m

(* general training function *)
let train typ m =
  let sampling = match typ with
    | SimpleLDA -> SimpleLDA.sampling
    | FTreeLDA  -> FTreeLDA.sampling
    | LightLDA  -> LightLDA.sampling
    | SparseLDA -> SparseLDA.sampling
  in
  let init = match typ with
    | SimpleLDA -> SimpleLDA.init
    | FTreeLDA  -> FTreeLDA.init
    | LightLDA  -> LightLDA.init
    | SparseLDA -> SparseLDA.init
  in
  init m;
  for i = 0 to m.iter - 1 do
    let t0 = Unix.gettimeofday () in
    Owl_nlp_corpus.iteri_tokenised_docs (
      fun j doc ->
      (* Log.info "iteration #%i - doc#%i" i j; *)
      sampling m j doc
    ) m.data;
    let t1 = Unix.gettimeofday () in
    show_info m i (t1 -. t0);
  done
