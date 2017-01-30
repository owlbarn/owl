(** [ Topic Model ] Experimental for LDA model  *)

open Owl

module MS = Sparse.Dok_matrix
module MD = Dense.Real

type lda_typ = SimpleLDA | FTreeLDA | LightLDA | SparseLDA

let n_d = ref 0                        (* number of documents *)
let n_k = ref 0                        (* number of topics *)
let n_v = ref 0                        (* number of vocabulary *)

let alpha = ref 0.                     (* model hyper-parameters *)
let beta = ref 0.                      (* model hyper-parameters *)
let alpha_k = ref 0.                   (* model hyper-parameters *)
let beta_v = ref 0.                    (* model hyper-parameters *)

let t_dk = ref (MD.zeros 1 1)          (* document-topic table: num of tokens assigned to each topic in each doc *)
let t_wk = ref (MS.zeros float64 1 1)  (* word-topic table: num of tokens assigned to each topic for each word *)
let t__k = ref (MD.zeros 1 1)          (* number of tokens assigned to a topic: k = sum_w t_wk = sum_d t_dk *)
let t__z = ref [| [||] |]              (* table of topic assignment of each token in each document *)

let n_iter = ref 1_000                 (* number of iterations *)
let data = ref [| [||] |]              (* training data, tokenised*)
let vocb : (string, int) Hashtbl.t ref = ref (Hashtbl.create 1)    (* vocabulary, or dictionary if you prefer *)

let include_token w d k =
  MD.(set !t__k 0 k (get !t__k 0 k +. 1.));
  MS.(set !t_wk w k (get !t_wk w k +. 1.));
  MD.(set !t_dk d k (get !t_dk d k +. 1.))

let exclude_token w d k =
  MD.(set !t__k 0 k (get !t__k 0 k -. 1.));
  MS.(set !t_wk w k (get !t_wk w k -. 1.));
  MD.(set !t_dk d k (get !t_dk d k -. 1.))

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
      let w = !data.(i).(j) in
      (* every topic *)
      for k = 0 to !n_k - 1 do
        wsum := !wsum +. (MD.get !t_dk i k +. !alpha_k) *. (MS.get !t_wk w k +. !beta) /. (MD.get !t__k 0 k +. !beta_v);
      done;
      dsum := !dsum +. (Maths.log2 !wsum);
    done;
    let dlen = float_of_int dlen in
    _sum := !_sum +. !dsum -. dlen *. (Maths.log2 dlen);
  done;
  !_sum /. (float_of_int !n_token)

let show_info i =
  let s = match i mod 1 = 0 with
    | true  -> Printf.sprintf " likelihood:%.3f" (likelihood ())
    | false -> ""
  in
  Log.info "iteration #%i - t_dk:%.3f t_wk:%.3f %s" i (MD.density !t_dk) (MS.density !t_wk) s

(* implement several LDA with specific samplings *)

module SimpleLDA = struct

  let init () = ()

  let sampling d =
    let p = MD.zeros 1 !n_k in
    Array.iteri (fun i w ->
      let k = !t__z.(d).(i) in
      exclude_token w d k;
      (* make cdf function *)
      let x = ref 0. in
      for j = 0 to !n_k - 1 do
        x := !x +. (MD.get !t_dk d j +. !alpha_k) *. (MS.get !t_wk w j +. !beta) /. (MD.get !t__k 0 j +. !beta_v);
        MD.set p 0 j !x;
      done;
      (* draw a sample *)
      let u = Stats.Rnd.uniform () *. !x in
      let k = ref 0 in
      while (MD.get p 0 !k) < u do k := !k + 1 done;
      include_token w d !k;
      !t__z.(d).(i) <- !k;
    ) !data.(d)

end

module FTreeLDA = struct

  let init () = ()

  let sampling d = ()

end

module LightLDA = struct

  let init () = ()

  let sampling d = ()

end

module SparseLDA = struct
  let s = ref 0.  (* Cache of s *)
  let q = ref [| |] (*Cache of q*)
  let r_non_zero :  (int, float) Hashtbl.t ref = ref (Hashtbl.create 1) (*  *)
  let q_non_zero :  (int, bool) Hashtbl.t ref = ref (Hashtbl.create 1) (*  *)

  let exclude_token_sparse w d k ~s ~r ~q =
    let t__klocal = ref ((MD.get !t__k 0 k) )in
    (* Reduce s, r  l*)
    s := !s -. (!beta *. !alpha_k) /. (!t__klocal +. !beta_v);
    r := !r -. (!beta *. (MD.get !t_dk d k)) /. (!beta_v +. !t__klocal);
    exclude_token w d k;
    (* add back in  s,r*)
    t__klocal :=  (MD.get !t__k 0 k);
    Array.set !q k ((!alpha_k +. (MD.get !t_dk d k)) /. (!beta_v +. !t__klocal));
    let r_local = (MD.get !t_dk d k) in
    (match r_local with
    | 0. ->  Hashtbl.remove !r_non_zero k
    | _  -> (Hashtbl.replace !r_non_zero k r_local;
      r := !r +. (!beta *. r_local) /. (!beta_v +. !t__klocal)
    ));
    s := !s +. (!beta *. !alpha_k) /. (!t__klocal +. !beta_v)

  let include_token_sparse w d k ~s ~r ~q =
    let t__klocal = ref (MD.get !t__k 0 k) in
    (* Reduce s, r  l*)
    s := !s -. (!beta *. !alpha_k)/.( !t__klocal +. !beta_v);
    r := !r -. (!beta *. (MD.get !t_dk d k)) /. (!beta_v +. !t__klocal);
    include_token w d k;
    (* add back in s, r*)
    t__klocal :=  (MD.get !t__k 0 k);
    s := !s +. (!beta *. !alpha_k)/.(!t__klocal +. !beta_v);
    let r_local = (MD.get !t_dk d k) in
    (match r_local with
    | 0. ->  Hashtbl.remove !r_non_zero k
    | _  -> (Hashtbl.replace !r_non_zero k r_local;
            r := !r +. (!beta *. r_local) /. (!beta_v +. !t__klocal))
    );
    Array.set !q k ((!alpha_k +. (MD.get !t_dk d k)) /. (!beta_v +. !t__klocal))

  let init () =
    (* s is independent of document *)
    let k = ref 0 in
    while !k < !n_k do
      let t__klocal = (MD.get !t__k 0 !k) in
      s := !s +. (1. /. (!beta_v +.  t__klocal ));
      k := !k + 1;
    done;
    q := (Array.make (!n_k) 0.);
    r_non_zero := (Hashtbl.create !n_k);
    q_non_zero := (Hashtbl.create !n_k);
    s := !s *. (!alpha_k *. !beta)

  let sampling d =
    let k = ref 0 in
    let r = ref 0. in (* Cache of r *)
    (* Calculate r *)
    Hashtbl.clear !r_non_zero;
    while !k < !n_k do
      let t__klocal = (MD.get !t__k 0 !k) in
      let r_local = (MD.get !t_dk d !k) in
      (* Sparse representation of r *)
      if r_local != 0. then (
        let r_val = r_local /. (!beta_v +.  t__klocal) in
        r := !r +. r_val;
        Hashtbl.add !r_non_zero !k r_val;
      );
      (* Build up our q cache *)
      (* TODO: efficiently handle t_dk = 0*)
      Array.set !q !k ((!alpha_k +. (MD.get !t_dk d !k)) /. (!beta_v +. t__klocal));
      k := !k + 1;
    done;
    r := !r *. !beta;

    (* Process the document *)
    Array.iteri (fun i w ->
        let k = !t__z.(d).(i) in
        exclude_token_sparse w d k s r q;
        (* Calculate q *)
        let qsum = ref 0. in
        let k_q = ref 0 in
        Hashtbl.clear !q_non_zero;
        (* This bit makes it (K) rather than O(K_d + K_w)*)
        while !k_q < !n_k do
          let q_local  =  (MS.get !t_wk w !k_q) in
          if q_local != 0. then (
            qsum := !qsum +. (Array.get !q !k_q) *. q_local;
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
          u := !u /. (!alpha_k *. !beta); (* Don't need this *)
          let slocal = ref 0. in
          while !slocal < !u do
            slocal := !slocal +. (1. /. (!beta_v +. (MD.get !t__k 0 !k_q) ));
            k_q := !k_q + 1;
          done;
          (* Found our topic (we went past it by one) *)
          k := !k_q - 1;
        )
        else if !u < (!s +. !r) then (
          (* Iterate over set of non-zero r *)
          u := (!u -. !s) /. !beta; (* compare just to r and don't need !beta *)
          let rlocal = ref 0. in
          (* TODO: pick largest (order by decreasing) for efficiency*)
          Hashtbl.iter (fun key data -> if !rlocal < !u then (
                    rlocal := !rlocal +. (data) /. (!beta_v +. (MD.get !t__k 0 key) );
                    k := key)
              ) !r_non_zero
        )
        else (
          u := !u -. (!s +. !r);
          let qlocal = ref 0. in
          (* Iterate over set of non-zero q *)
          (* TODO: make descending *)
          Hashtbl.iter (fun key _ -> if !qlocal < !u then (
                    qlocal := !qlocal +. (Array.get !q key) *. (MS.get !t_wk w key);
                    k := key)
              ) !q_non_zero
        );
        include_token_sparse w d !k s r q;
        !t__z.(d).(i) <- !k;
      ) !data.(d)
end

(* init the model based on: topics, vocabulary, tokens *)
let init ?(iter=100) k v d =
  Log.info "init the model";
  n_iter := iter;
  data := d;
  vocb := v;
  (* set model parameters *)
  n_d  := Array.length d;
  n_v  := Hashtbl.length v;
  n_k  := k;
  t_dk := MD.zeros !n_d !n_k;
  t_wk := MS.zeros float64 !n_v !n_k;
  t__k := MD.zeros 1 !n_k;
  (* set model hyper-parameters *)
  alpha := 50.;
  alpha_k := !alpha /. (float_of_int !n_k);
  beta := 0.1;
  beta_v := (float_of_int !n_v) *. !beta;
  (* randomise the topic assignment for each token *)
  t__z := Array.mapi (fun i s ->
    Array.init (Array.length s) (fun j ->
      let k' = Stats.Rnd.uniform_int ~a:0 ~b:(k - 1) () in
      include_token s.(j) i k';
      k'
    )
  ) d

(* general training function *)
let train typ =
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
  init ();
  for i = 0 to !n_iter - 1 do
    show_info i;
    for j = 0 to !n_d - 1 do
      (* Log.info "iteration #%i - doc#%i" i j; *)
      sampling j
    done
  done
