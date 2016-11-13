(** [ Topic Model ] Experimental for LDA model  *)

open Owl

module MS = Sparse.Real
module MD = Dense.Real

type lda_typ = SimpleLDA | FTreeLDA | LightLDA

let n_d = ref 0                   (* number of documents *)
let n_k = ref 0                   (* number of topics *)
let n_v = ref 0                   (* number of vocabulary *)

let alpha = ref 0.                (* model hyper-parameters *)
let beta = ref 0.                 (* model hyper-parameters *)
let alpha_k = ref 0.              (* model hyper-parameters *)
let beta_v = ref 0.               (* model hyper-parameters *)

let t_dk = ref (MS.zeros 1 1)     (* document-topic table: num of tokens assigned to each topic in each doc *)
let t_wk = ref (MS.zeros 1 1)     (* word-topic table: num of tokens assigned to each topic for each word *)
let t__k = ref (MD.zeros 1 1)     (* number of tokens assigned to a topic: k = sum_w t_wk = sum_d t_dk *)
let t__z = ref [| [||] |]         (* table of topic assignment of each token in each document *)

let n_iter = 1_000                (* number of iterations *)
let data = ref [| [||] |]         (* training data, tokenised*)
let vocb : (string, int) Hashtbl.t ref = ref (Hashtbl.create 1)    (* vocabulary, or dictionary if you prefer *)

let include_token w d k =
  MD.(set !t__k 0 k (get !t__k 0 k +. 1.));
  MS.(set !t_wk w k (get !t_wk w k +. 1.));
  MS.(set !t_dk d k (get !t_dk d k +. 1.))

let exclude_token w d k =
  MD.(set !t__k 0 k (get !t__k 0 k -. 1.));
  MS.(set !t_wk w k (get !t_wk w k -. 1.));
  MS.(set !t_dk d k (get !t_dk d k -. 1.))

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
        wsum := !wsum +. (MS.get !t_dk i k +. !alpha_k) *. (MS.get !t_wk w k +. !beta) /. (MD.get !t__k 0 k +. !beta_v);
      done;
      dsum := !dsum +. (Maths.log2 !wsum);
    done;
    let dlen = float_of_int dlen in
    _sum := !_sum +. !dsum -. dlen *. (Maths.log2 dlen);
  done;
  !_sum /. (float_of_int !n_token)

let show_info i =
  let s = match i mod 10 = 0 with
    | true  -> Printf.sprintf " likelihood:%.3f" (likelihood ())
    | false -> ""
  in
  Log.info "iteration #%i - t_dk:%.3f t_wk:%.3f %s" i (MS.density !t_dk) (MS.density !t_wk) s

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
        x := !x +. (MS.get !t_dk d j +. !alpha_k) *. (MS.get !t_wk w j +. !beta) /. (MD.get !t__k 0 j +. !beta_v);
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

(* init the model based on: topics, vocabulary, tokens *)
let init k v d =
  Log.info "init the model";
  data := d;
  vocb := v;
  (* set model parameters *)
  n_d  := Array.length d;
  n_v  := Hashtbl.length v;
  n_k  := k;
  t_dk := MS.zeros !n_d !n_k;
  t_wk := MS.zeros !n_v !n_k;
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
    | FTreeLDA -> FTreeLDA.sampling
    | LightLDA -> LightLDA.sampling
  in
  for i = 0 to n_iter - 1 do
    show_info i;
    for j = 0 to !n_d - 1 do
      (* Log.info "iteration #%i - doc#%i" i j; *)
      sampling j
    done
  done
