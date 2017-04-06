(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* NOTE: this is an experimental module being built now *)

open Owl_algodiff_ad
type t = Owl_algodiff_ad.t


(* module for initialising weight matrix *)
module Init = struct

  type typ =
    | Uniform  of float * float
    | Gaussian of float * float
    | Custom   of (int -> int -> float)

  let run t m n = match t with
    | Uniform (a, b)       -> Mat.(add (uniform ~scale:(b-.a) m n) (F a))
    | Gaussian (mu, sigma) -> Mat.(add (gaussian ~sigma m n) (F mu))
    | Custom f             -> Mat.(empty m n |> mapi (fun i j _ -> f i j))

  let to_string = function
    | Uniform (a, b)  -> Printf.sprintf "uniform (%g, %g)" a b
    | Gaussian (a, b) -> Printf.sprintf "gaussian (%g, %g)" a b
    | Custom _        -> Printf.sprintf "customise"

end


(* module for various activation functions *)
module Activation = struct

  type typ =
    | Relu
    | Sigmoid
    | Softmax
    | Tanh
    | Custom of (t -> t)

  let run x l = match l with
    | Relu     -> Maths.relu x
    | Sigmoid  -> Maths.sigmoid x
    | Softmax  -> Mat.map_by_row Maths.softmax x
    | Tanh     -> Maths.tanh x
    | Custom f -> f x

  let to_string = function
    | Relu     -> "Activation layer: relu\n"
    | Sigmoid  -> "Activation layer: sigmoid\n"
    | Softmax  -> "Activation layer: softmax\n"
    | Tanh     -> "Activation layer: tanh\n"
    | Custom _ -> "Activation layer: customise\n"

end


(* definition of linear layer *)
module Linear = struct

  type layer = {
    mutable w : t;
    mutable b : t;
    mutable init_typ : Init.typ;
  }

  let create i o init_typ = {
    w = Mat.empty i o;
    b = Mat.empty 1 o;
    init_typ = init_typ;
  }

  let init l =
    let m, n = Mat.shape l.w in
    l.w <- Init.run l.init_typ m n;
    l.b <- Mat.zeros 1 n

  let reset l =
    Mat.reset l.w;
    Mat.reset l.b

  let mktag t l =
    l.w <- make_reverse l.w t;
    l.b <- make_reverse l.b t

  let mkpar l = [|l.w; l.b|]

  let mkpri l = [|primal l.w; primal l.b|]

  let mkadj l = [|adjval l.w; adjval l.b|]

  let update l u =
    l.w <- u.(0) |> primal';
    l.b <- u.(1) |> primal'

  let run x l = Maths.((x $@ l.w) + l.b)

  let to_string l =
    let wm, wn = Mat.shape l.w in
    let bn = Mat.col_num l.b in
    Printf.sprintf "Linear layer:
    init : %s
    params : %i
    w : %i x %i
    b : %i\n"
    (Init.to_string l.init_typ) (wm * wn + bn) wm wn bn

end


(* definition of LTSM layer *)
module LTSM = struct

  type layer = {
    mutable wxi : t;
    mutable init_typ : Init.typ;
  }

  let create init_typ = {
    wxi = Mat.empty 1 1;
    init_typ = init_typ;
  }

  let init l = ()

  let reset l = ()

  let mktag t l = ()

  let mkpar l = [||]

  let mkpri l = [||]

  let mkadj l = [||]

  let update l u = ()

  let run x l = F 0.

  let to_string l = "LTSM"

end


(* definition of recurrent layer *)
module Recurrent = struct

  type layer = {
    mutable whh      : t;
    mutable wxh      : t;
    mutable why      : t;
    mutable bh       : t;
    mutable by       : t;
    mutable h        : t;
    mutable act      : Activation.typ;
    mutable init_typ : Init.typ;
  }

  let create i h o act init_typ = {
    whh = Mat.empty h h;
    wxh = Mat.empty i h;
    why = Mat.empty h o;
    bh  = Mat.empty 1 h;
    by  = Mat.empty 1 o;
    h   = Mat.empty 1 h;
    act = act;
    init_typ = init_typ;
  }

  let init l =
    l.whh <- Init.run l.init_typ (Mat.row_num l.whh) (Mat.col_num l.whh);
    l.wxh <- Init.run l.init_typ (Mat.row_num l.wxh) (Mat.col_num l.wxh);
    l.why <- Init.run l.init_typ (Mat.row_num l.why) (Mat.col_num l.why);
    l.bh  <- Init.run l.init_typ 1 (Mat.col_num l.bh);
    l.by  <- Init.run l.init_typ 1 (Mat.col_num l.by);
    l.h   <- Init.run l.init_typ 1 (Mat.col_num l.bh)

  let reset l =
    Mat.reset l.whh;
    Mat.reset l.wxh;
    Mat.reset l.why;
    Mat.reset l.bh;
    Mat.reset l.by;
    Mat.reset l.h

  let mktag t l =
    l.whh <- make_reverse l.whh t;
    l.wxh <- make_reverse l.wxh t;
    l.why <- make_reverse l.why t;
    l.bh  <- make_reverse l.bh t;
    l.by  <- make_reverse l.by t

  let mkpar l = [| l.whh; l.wxh; l.why; l.bh; l.by |]

  let mkpri l = [| primal l.whh; primal l.wxh; primal l.why; primal l.bh; primal l.by |]

  let mkadj l = [| adjval l.whh; adjval l.wxh; adjval l.why; adjval l.bh; adjval l.by |]

  let update l u =
    l.whh <- u.(0) |> primal';
    l.wxh <- u.(1) |> primal';
    l.why <- u.(2) |> primal';
    l.bh  <- u.(3) |> primal';
    l.by  <- u.(4) |> primal'

  let run x l = F 0.

  let to_string l = "Recurrent"

end


(* type and functions of neural network *)

type layer =
  | Linear     of Linear.layer
  | LTSM       of LTSM.layer
  | Recurrent  of Recurrent.layer
  | Activation of Activation.typ

type network = {
  mutable layers : layer array;
}


(* Feedforward network module *)
module Feedforward = struct

  let create () = { layers = [||]; }

  let add_layer nn l = nn.layers <- Array.append nn.layers [|l|]

  let add_activation nn l = nn.layers <- Array.append nn.layers [|Activation l|]

  let init nn = Array.iter (function
    | Linear l    -> Linear.init l
    | LTSM l      -> LTSM.init l
    | Recurrent l -> Recurrent.init l
    | _           -> () (* activation *)
    ) nn.layers

  let reset nn = Array.iter (function
    | Linear l    -> Linear.reset l
    | LTSM l      -> LTSM.reset l
    | Recurrent l -> Recurrent.reset l
    | _           -> () (* activation *)
    ) nn.layers

  let mktag t nn = Array.iter (function
    | Linear l     -> Linear.mktag t l
    | LTSM l       -> LTSM.mktag t l
    | Recurrent l  -> Recurrent.mktag t l
    | _            -> () (* activation *)
    ) nn.layers

  let mkpar nn = Array.map (function
    | Linear l     -> Linear.mkpar l
    | LTSM l       -> LTSM.mkpar l
    | Recurrent l  -> Recurrent.mkpar l
    | _            -> [||] (* activation *)
    ) nn.layers

  let mkpri nn = Array.map (function
    | Linear l     -> Linear.mkpri l
    | LTSM l       -> LTSM.mkpri l
    | Recurrent l  -> Recurrent.mkpri l
    | _            -> [||] (* activation *)
    ) nn.layers

  let mkadj nn = Array.map (function
    | Linear l     -> Linear.mkadj l
    | LTSM l       -> LTSM.mkadj l
    | Recurrent l  -> Recurrent.mkadj l
    | _            -> [||] (* activation *)
    ) nn.layers

  let update nn us = Array.map2 (fun l u ->
    match l with
    | Linear l     -> Linear.update l u
    | LTSM l       -> LTSM.update l u
    | Recurrent l  -> Recurrent.update l u
    | _            -> () (* activation *)
    ) nn.layers us

  let run x nn = Array.fold_left (fun a l ->
    match l with
    | Linear l     -> Linear.run a l
    | LTSM l       -> LTSM.run a l
    | Recurrent l  -> Recurrent.run a l
    | Activation l -> Activation.run a l
    ) x nn.layers

  let forward nn x = mktag (tag ()) nn; run x nn, mkpar nn

  let backward nn y = reverse_prop (F 1.) y; mkpri nn, mkadj nn

  let train nn loss_fun x =
    mktag (tag ()) nn;
    let loss = loss_fun (run x nn) in
    reverse_prop (F 1.) loss;
    loss

  let to_string nn =
    let s = ref "Feedforward network\n\n" in
    for i = 0 to Array.length nn.layers - 1 do
      let t = match nn.layers.(i) with
        | Linear l     -> Linear.to_string l
        | LTSM l       -> LTSM.to_string l
        | Recurrent l  -> Recurrent.to_string l
        | Activation l -> Activation.to_string l
      in
      s := !s ^ (Printf.sprintf "(%i): %s\n" i t)
    done; !s

end


(* helper functions *)

let linear ~inputs ~outputs ~init_typ = Linear (Linear.create inputs outputs init_typ)

let print nn = Feedforward.to_string nn |> Printf.printf "%s"

let train ?params nn x y =
  Feedforward.init nn;
  let f = Feedforward.forward nn in
  let b = Feedforward.backward nn in
  let u = Feedforward.update nn in
  let p = match params with
    | Some p -> p
    | None   -> Owl_neural_optimise.Params.default ()
  in
  Owl_neural_optimise.train p f b u x y

let test_model nn x y =
  Mat.iter2_rows (fun u v ->
    Owl_dataset.print_mnist_image (unpack_mat u);
    let p = Feedforward.run u nn |> unpack_mat in
    Owl_dense_matrix_generic.print p;
    Printf.printf "prediction: %i\n" (let _, _, j = Owl_dense_matrix_generic.max_i p in j)
  ) x y


(* ends here *)
