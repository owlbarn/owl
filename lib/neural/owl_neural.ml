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
    | Tanh
    | Custom   of (int -> int -> float)

  let run t m n = match t with
    | Uniform (a, b)       -> Mat.(add (uniform ~scale:(b-.a) m n) (F a))
    | Gaussian (mu, sigma) -> Mat.(add (gaussian ~sigma m n) (F mu))
    | Tanh                 -> let r = sqrt (6. /. float_of_int (m + n)) in Mat.(add (uniform ~scale:(2.*.r) m n) (F (-.r)))
    | Custom f             -> Mat.(empty m n |> mapi (fun i j _ -> f i j))

  let to_string = function
    | Uniform (a, b)  -> Printf.sprintf "uniform (%g, %g)" a b
    | Gaussian (a, b) -> Printf.sprintf "gaussian (%g, %g)" a b
    | Tanh            -> Printf.sprintf "tanh"
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
    | Softmax  -> Mat.map_by_row Maths.softmax x  (* FIXME: this probably needs to be fixed *)
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
    init   : %s
    params : %i
    w      : %i x %i
    b      : %i\n"
    (Init.to_string l.init_typ) (wm * wn + bn) wm wn bn

end


(* definition of LSTM layer *)
module LSTM = struct

  type layer = {
    mutable wxi : t;
    mutable whi : t;
    mutable wxc : t;
    mutable whc : t;
    mutable wxf : t;
    mutable whf : t;
    mutable wxo : t;
    mutable who : t;
    mutable bi  : t;
    mutable bc  : t;
    mutable bf  : t;
    mutable bo  : t;
    mutable c   : t;
    mutable h   : t;
    mutable init_typ : Init.typ;
  }

  let create i m = {
    wxi = Mat.empty i m;
    whi = Mat.empty m m;
    wxc = Mat.empty i m;
    whc = Mat.empty m m;
    wxf = Mat.empty i m;
    whf = Mat.empty m m;
    wxo = Mat.empty i m;
    who = Mat.empty m m;
    bi  = Mat.empty 1 m;
    bc  = Mat.empty 1 m;
    bf  = Mat.empty 1 m;
    bo  = Mat.empty 1 m;
    c   = Mat.empty 1 m;
    h   = Mat.empty 1 m;
    init_typ = Init.Tanh;
  }

  let init l =
    l.wxi <- Init.run l.init_typ (Mat.row_num l.wxi) (Mat.col_num l.wxi);
    l.whi <- Init.run l.init_typ (Mat.row_num l.whi) (Mat.col_num l.whi);
    l.wxc <- Init.run l.init_typ (Mat.row_num l.wxc) (Mat.col_num l.wxc);
    l.whc <- Init.run l.init_typ (Mat.row_num l.whc) (Mat.col_num l.whc);
    l.wxf <- Init.run l.init_typ (Mat.row_num l.wxf) (Mat.col_num l.wxf);
    l.whf <- Init.run l.init_typ (Mat.row_num l.whf) (Mat.col_num l.whf);
    l.wxo <- Init.run l.init_typ (Mat.row_num l.wxo) (Mat.col_num l.wxo);
    l.who <- Init.run l.init_typ (Mat.row_num l.who) (Mat.col_num l.who);
    l.bi  <- Mat.zeros 1 (Mat.col_num l.bi);
    l.bc  <- Mat.zeros 1 (Mat.col_num l.bc);
    l.bf  <- Mat.zeros 1 (Mat.col_num l.bf);
    l.bo  <- Mat.zeros 1 (Mat.col_num l.bo);
    l.c   <- Mat.zeros 1 (Mat.col_num l.c);
    l.h   <- Mat.zeros 1 (Mat.col_num l.h)

  let reset l =
    Mat.reset l.c;
    Mat.reset l.h

  let mktag t l =
    l.wxi <- make_reverse l.wxi t;
    l.whi <- make_reverse l.whi t;
    l.wxc <- make_reverse l.wxc t;
    l.whc <- make_reverse l.whc t;
    l.wxf <- make_reverse l.wxf t;
    l.whf <- make_reverse l.whf t;
    l.wxo <- make_reverse l.wxo t;
    l.who <- make_reverse l.who t;
    l.bi  <- make_reverse l.bi t;
    l.bc  <- make_reverse l.bc t;
    l.bf  <- make_reverse l.bf t;
    l.bo  <- make_reverse l.bo t

  let mkpar l = [|
    l.wxi;
    l.whi;
    l.wxc;
    l.whc;
    l.wxf;
    l.whf;
    l.wxo;
    l.who;
    l.bi;
    l.bc;
    l.bf;
    l.bo
  |]

  let mkpri l = [|
    primal l.wxi;
    primal l.whi;
    primal l.wxc;
    primal l.whc;
    primal l.wxf;
    primal l.whf;
    primal l.wxo;
    primal l.who;
    primal l.bi;
    primal l.bc;
    primal l.bf;
    primal l.bo
  |]

  let mkadj l = [|
    adjval l.wxi;
    adjval l.whi;
    adjval l.wxc;
    adjval l.whc;
    adjval l.wxf;
    adjval l.whf;
    adjval l.wxo;
    adjval l.who;
    adjval l.bi;
    adjval l.bc;
    adjval l.bf;
    adjval l.bo
  |]

  let update l u =
    l.wxi <- u.(0)  |> primal';
    l.whi <- u.(1)  |> primal';
    l.wxc <- u.(2)  |> primal';
    l.whc <- u.(3)  |> primal';
    l.wxf <- u.(4)  |> primal';
    l.whf <- u.(5)  |> primal';
    l.wxo <- u.(6)  |> primal';
    l.who <- u.(7)  |> primal';
    l.bi  <- u.(8)  |> primal';
    l.bc  <- u.(9)  |> primal';
    l.bf  <- u.(10) |> primal';
    l.bo  <- u.(11) |> primal'

  let run x l =
    let y = Mat.map_by_row (fun x ->
      let i  = Maths.(((x $@ l.wxi) + (l.h $@ l.whi) + l.bi) |> sigmoid) in
      let c' = Maths.(((x $@ l.wxc) + (l.h $@ l.whc) + l.bc) |> tanh) in
      let f  = Maths.(((x $@ l.wxf) + (l.h $@ l.whf) + l.bf) |> sigmoid) in
      l.c <- Maths.((i * c') + (f * l.c));
      let o  = Maths.(((x $@ l.wxo) + (l.h $@ l.who) + l.bo) |> sigmoid) in
      l.h <- Maths.(o * (tanh l.c));
      l.h
    ) x in
    l.c <- primal' l.c;
    l.h <- primal' l.h;
    y

  let to_string l =
    let wxim, wxin = Mat.shape l.wxi in
    let whim, whin = Mat.shape l.whi in
    let wxcm, wxcn = Mat.shape l.wxc in
    let whcm, whcn = Mat.shape l.whc in
    let wxfm, wxfn = Mat.shape l.wxf in
    let whfm, whfn = Mat.shape l.whf in
    let wxom, wxon = Mat.shape l.wxo in
    let whom, whon = Mat.shape l.who in
    let bim, bin = Mat.shape l.bi in
    let bcm, bcn = Mat.shape l.bc in
    let bfm, bfn = Mat.shape l.bf in
    let bom, bon = Mat.shape l.bo in
    Printf.sprintf "LSTM layer:\n" ^
    Printf.sprintf "init   : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "params : %i\n" (wxim*wxin + whim*whin + wxcm*wxcn + whcm*whcn + wxfm*wxfn + whfm*whfn + wxom*wxon + whom*whon + bim*bin + bcm*bcn + bfm*bfn + bom*bon) ^
    Printf.sprintf "wxi    : %i x %i\n" wxim wxin ^
    Printf.sprintf "whi    : %i x %i\n" whim whin ^
    Printf.sprintf "wxc    : %i x %i\n" wxcm wxcn ^
    Printf.sprintf "whc    : %i x %i\n" whcm whcn ^
    Printf.sprintf "wxf    : %i x %i\n" wxfm wxfn ^
    Printf.sprintf "whf    : %i x %i\n" whfm whfn ^
    Printf.sprintf "wxo    : %i x %i\n" wxom wxon ^
    Printf.sprintf "who    : %i x %i\n" whom whon ^
    Printf.sprintf "bi     : %i x %i\n" bim bin ^
    Printf.sprintf "bc     : %i x %i\n" bcm bcn ^
    Printf.sprintf "bf     : %i x %i\n" bfm bfn ^
    Printf.sprintf "bo     : %i x %i\n" bom bon ^
    ""

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
    l.bh  <- Mat.zeros 1 (Mat.col_num l.bh);
    l.by  <- Mat.zeros 1 (Mat.col_num l.by);
    l.h   <- Mat.zeros 1 (Mat.col_num l.h)

  let reset l = Mat.reset l.h

  let mktag t l =
    l.whh <- make_reverse l.whh t;
    l.wxh <- make_reverse l.wxh t;
    l.why <- make_reverse l.why t;
    l.bh  <- make_reverse l.bh t;
    l.by  <- make_reverse l.by t

  let mkpar l = [|
    l.whh;
    l.wxh;
    l.why;
    l.bh;
    l.by
  |]

  let mkpri l = [|
    primal l.whh;
    primal l.wxh;
    primal l.why;
    primal l.bh;
    primal l.by
  |]

  let mkadj l = [|
    adjval l.whh;
    adjval l.wxh;
    adjval l.why;
    adjval l.bh;
    adjval l.by
  |]

  let update l u =
    l.whh <- u.(0) |> primal';
    l.wxh <- u.(1) |> primal';
    l.why <- u.(2) |> primal';
    l.bh  <- u.(3) |> primal';
    l.by  <- u.(4) |> primal'

  let run x l =
    let act x = Activation.run x l.act in
    let y = Mat.map_by_row (fun x ->
      l.h <- act Maths.((l.h $@ l.whh) + (x $@ l.wxh) + l.bh);
      Maths.((l.h $@ l.why) + l.by)
    ) x in
    l.h <- primal' l.h;
    y

  let to_string l =
    let whhm, whhn = Mat.shape l.whh in
    let wxhm, wxhn = Mat.shape l.wxh in
    let whym, whyn = Mat.shape l.why in
    let bhm, bhn = Mat.shape l.bh in
    let bym, byn = Mat.shape l.by in
    Printf.sprintf "Recurrent layer:
    init   : %s
    params : %i
    whh    : %i x %i
    wxh    : %i x %i
    why    : %i x %i
    bh     : %i x %i
    by     : %i x %i
    act    : %s\n"
    (Init.to_string l.init_typ) (whhm * whhn + wxhm * wxhn + whym * whyn + bhm * bhn + bym * byn)
    whhm whhn wxhm wxhn whym whyn bhm bhn bym byn (Activation.to_string l.act)

end


(* type and functions of neural network *)

type layer =
  | Linear     of Linear.layer
  | LSTM       of LSTM.layer
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
    | LSTM l      -> LSTM.init l
    | Recurrent l -> Recurrent.init l
    | _           -> () (* activation *)
    ) nn.layers

  let reset nn = Array.iter (function
    | Linear l    -> Linear.reset l
    | LSTM l      -> LSTM.reset l
    | Recurrent l -> Recurrent.reset l
    | _           -> () (* activation *)
    ) nn.layers

  let mktag t nn = Array.iter (function
    | Linear l     -> Linear.mktag t l
    | LSTM l       -> LSTM.mktag t l
    | Recurrent l  -> Recurrent.mktag t l
    | _            -> () (* activation *)
    ) nn.layers

  let mkpar nn = Array.map (function
    | Linear l     -> Linear.mkpar l
    | LSTM l       -> LSTM.mkpar l
    | Recurrent l  -> Recurrent.mkpar l
    | _            -> [||] (* activation *)
    ) nn.layers

  let mkpri nn = Array.map (function
    | Linear l     -> Linear.mkpri l
    | LSTM l       -> LSTM.mkpri l
    | Recurrent l  -> Recurrent.mkpri l
    | _            -> [||] (* activation *)
    ) nn.layers

  let mkadj nn = Array.map (function
    | Linear l     -> Linear.mkadj l
    | LSTM l       -> LSTM.mkadj l
    | Recurrent l  -> Recurrent.mkadj l
    | _            -> [||] (* activation *)
    ) nn.layers

  let update nn us = Array.map2 (fun l u ->
    match l with
    | Linear l     -> Linear.update l u
    | LSTM l       -> LSTM.update l u
    | Recurrent l  -> Recurrent.update l u
    | _            -> () (* activation *)
    ) nn.layers us

  let run x nn = Array.fold_left (fun a l ->
    match l with
    | Linear l     -> Linear.run a l
    | LSTM l       -> LSTM.run a l
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
        | LSTM l       -> LSTM.to_string l
        | Recurrent l  -> Recurrent.to_string l
        | Activation l -> Activation.to_string l
      in
      s := !s ^ (Printf.sprintf "(%i): %s\n" i t)
    done; !s

end


(* helper functions *)

let linear ~inputs ~outputs ~init_typ = Linear (Linear.create inputs outputs init_typ)

let recurrent ~inputs ~hiddens ~outputs ~act_typ ~init_typ = Recurrent (Recurrent.create inputs hiddens outputs act_typ init_typ)

let lstm ~inputs ~cells = LSTM (LSTM.create inputs cells)

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
