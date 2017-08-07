(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Neural network: Neuron definitions *)

open Owl_algodiff.S
type t = Owl_algodiff.S.t


(* module for initialising weight matrix *)
module Init = struct

  type typ =
    | Uniform  of float * float
    | Gaussian of float * float
    | Standard
    | Tanh
    | Custom   of (int -> int -> float)

  let run t m n = match t with
    | Uniform (a, b)       -> Mat.(add (uniform ~scale:(b-.a) m n) (F a))
    | Gaussian (mu, sigma) -> Mat.(add (gaussian ~sigma m n) (F mu))
    | Standard             -> let r = sqrt (1. /. float_of_int m) in Mat.(add (uniform ~scale:(2.*.r) m n) (F (-.r)))
    | Tanh                 -> let r = sqrt (6. /. float_of_int (m + n)) in Mat.(add (uniform ~scale:(2.*.r) m n) (F (-.r)))
    | Custom f             -> Mat.(empty m n |> mapi (fun i j _ -> f i j))

  let to_string = function
    | Uniform (a, b)  -> Printf.sprintf "uniform (%g, %g)" a b
    | Gaussian (a, b) -> Printf.sprintf "gaussian (%g, %g)" a b
    | Standard        -> Printf.sprintf "standard"
    | Tanh            -> Printf.sprintf "tanh"
    | Custom _        -> Printf.sprintf "customise"

    let to_name () = "init"

end


(* definition of Input neuron *)
module Input = struct

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create inputs = {
    in_shape  = Array.copy inputs;
    out_shape = Array.copy inputs;
  }

  let run x l =
    (* check the input shape, a bit overhead but worth it *)
    let check_shape = function
      | Arr _ -> (
          let in_shape = Arr.shape x in
          let in_shape = Array.(sub in_shape 1 (length in_shape - 1)) in
          assert (in_shape = l.in_shape)
        )
      | Mat _ -> assert (Mat.col_num x = l.in_shape.(0))
      | _     -> failwith "Owl_neural:Input:run:check_shape"
    in
    check_shape x; x

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    Printf.sprintf "    Input : in/out:[*,%s]\n" in_str

  let to_name () = "input"

end


(* module for various activation functions *)
module Activation = struct

  type typ =
    | Relu
    | Sigmoid
    | Softmax
    | Tanh
    | Custom of (t -> t)
    | None

  type neuron_typ = {
    mutable activation : typ;
    mutable in_shape   : int array;
    mutable out_shape  : int array;
  }

  let create activation = {
    activation;
    in_shape  = [||];
    out_shape = [||];
  }

  let connect out_shape l =
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- Array.copy out_shape

  let run_activation x activation =
    match activation with
    | Relu     -> Maths.relu x
    | Sigmoid  -> Maths.sigmoid x
    | Softmax  -> Mat.map_by_row Maths.softmax x  (* FIXME: this probably needs to be fixed *)
    | Tanh     -> Maths.tanh x
    | Custom f -> f x
    | None     -> x

  let run x l = run_activation x l.activation

  let activation_to_string = function
    | Relu     -> "relu"
    | Sigmoid  -> "sigmoid"
    | Softmax  -> "softmax"
    | Tanh     -> "tanh"
    | Custom _ -> "customise"
    | None     -> "none"

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let act_str = activation_to_string l.activation in
    Printf.sprintf "    Activation : %s in/out:[*,%s]\n" act_str in_str ^
    ""

  let to_name () = "activation"

end


(* definition of linear neuron *)
module Linear = struct

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create ?inputs o init_typ =
    let in_shape = match inputs with
      | Some i -> [|i|]
      | None   -> [|0|]
    in
    {
      w         = Mat.empty 0 0;
      b         = Mat.empty 0 0;
      init_typ  = init_typ;
      in_shape  = in_shape;
      out_shape = [|o|];
    }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    l.in_shape.(0) <- out_shape.(0)

  let init l =
    let m = l.in_shape.(0) in
    let n = l.out_shape.(0) in
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

  let run x l = Maths.((x *@ l.w) + l.b)

  let to_string l =
    let wm, wn = l.in_shape.(0), l.out_shape.(0) in
    let bm, bn = 1, l.out_shape.(0) in
    Printf.sprintf "    Linear : matrix in:(*,%i) out:(*,%i) \n" l.in_shape.(0) l.out_shape.(0) ^
    Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "    params : %i\n" (wm * wn + bn) ^
    Printf.sprintf "    w      : %i x %i\n" wm wn ^
    Printf.sprintf "    b      : %i x %i\n" bm bn ^
    ""

  let to_name () = "linear"

end


(* definition of linear no bias neuron *)
module LinearNoBias = struct

  type neuron_typ = {
    mutable w         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create ?inputs o init_typ =
    let in_shape = match inputs with
      | Some i -> [|i|]
      | None   -> [|0|]
    in
    {
      w         = Mat.empty 0 0;
      init_typ  = init_typ;
      in_shape  = in_shape;
      out_shape = [|o|];
    }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    l.in_shape.(0) <- out_shape.(0)

  let init l =
    let m = l.in_shape.(0) in
    let n = l.out_shape.(0) in
    l.w <- Init.run l.init_typ m n

  let reset l = Mat.reset l.w

  let mktag t l = l.w <- make_reverse l.w t

  let mkpar l = [|l.w|]

  let mkpri l = [|primal l.w|]

  let mkadj l = [|adjval l.w|]

  let update l u = l.w <- u.(0) |> primal'

  let run x l = Maths.(x *@ l.w)

  let to_string l =
    let wm, wn = l.in_shape.(0), l.out_shape.(0) in
    Printf.sprintf "    LinearNoBias : matrix in:(*,%i) out:(*,%i) \n" l.in_shape.(0) l.out_shape.(0) ^
    Printf.sprintf "    init         : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "    params       : %i\n" (wm * wn) ^
    Printf.sprintf "    w            : %i x %i\n" wm wn ^
    ""

  let to_name () = "linearnobias"

end


(* definition of recurrent neuron *)
module Recurrent = struct

  type neuron_typ = {
    mutable whh       : t;
    mutable wxh       : t;
    mutable why       : t;
    mutable bh        : t;
    mutable by        : t;
    mutable h         : t;
    mutable hiddens   : int;
    mutable act       : Activation.typ;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create ?inputs hiddens o act init_typ =
    let in_shape = match inputs with
      | Some i -> [|i|]
      | None   -> [|0|]
    in
    let h = hiddens in
    {
      whh       = Mat.empty h h;
      wxh       = Mat.empty 0 h;
      why       = Mat.empty h o;
      bh        = Mat.empty 1 h;
      by        = Mat.empty 1 o;
      h         = Mat.empty 1 h;
      hiddens   = hiddens;
      act       = act;
      init_typ  = init_typ;
      in_shape  = in_shape;
      out_shape = [|o|];
    }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    l.in_shape.(0) <- out_shape.(0)

  let init l =
    let i = l.in_shape.(0) in
    let o = l.out_shape.(0) in
    let h = l.hiddens in
    l.whh <- Init.run l.init_typ h h;
    l.wxh <- Init.run l.init_typ i h;
    l.why <- Init.run l.init_typ h o;
    l.bh  <- Mat.zeros 1 h;
    l.by  <- Mat.zeros 1 o;
    l.h   <- Mat.zeros 1 h

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
    l.by;
  |]

  let mkpri l = [|
    primal l.whh;
    primal l.wxh;
    primal l.why;
    primal l.bh;
    primal l.by;
  |]

  let mkadj l = [|
    adjval l.whh;
    adjval l.wxh;
    adjval l.why;
    adjval l.bh;
    adjval l.by;
  |]

  let update l u =
    l.whh <- u.(0) |> primal';
    l.wxh <- u.(1) |> primal';
    l.why <- u.(2) |> primal';
    l.bh  <- u.(3) |> primal';
    l.by  <- u.(4) |> primal'

  let run x l =
    let act x = Activation.run_activation x l.act in
    let y = Mat.map_by_row (fun x ->
      l.h <- act Maths.((l.h *@ l.whh) + (x *@ l.wxh) + l.bh);
      Maths.((l.h *@ l.why) + l.by)
    ) x in
    l.h <- primal' l.h;
    y

  let to_string l =
    let whhm, whhn = Mat.shape l.whh in
    let wxhm, wxhn = Mat.shape l.wxh in
    let whym, whyn = Mat.shape l.why in
    let bhm, bhn = Mat.shape l.bh in
    let bym, byn = Mat.shape l.by in
    Printf.sprintf "    Recurrent : matrix in:(*,%i) out:(*,%i) \n" l.in_shape.(0) l.out_shape.(0) ^
    Printf.sprintf "    init      : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "    params    : %i\n" (whhm * whhn + wxhm * wxhn + whym * whyn + bhm * bhn + bym * byn) ^
    Printf.sprintf "    whh       : %i x %i\n" whhm whhn ^
    Printf.sprintf "    wxh       : %i x %i\n" wxhm wxhn ^
    Printf.sprintf "    why       : %i x %i\n" whym whyn ^
    Printf.sprintf "    bh        : %i x %i\n" bhm bhn ^
    Printf.sprintf "    by        : %i x %i\n" bym byn ^
    Printf.sprintf "    act       : %s\n" (Activation.activation_to_string l.act)

  let to_name () = "recurrent"

end


(* definition of LSTM neuron *)
module LSTM = struct

  type neuron_typ = {
    mutable wxi       : t;
    mutable whi       : t;
    mutable wxc       : t;
    mutable whc       : t;
    mutable wxf       : t;
    mutable whf       : t;
    mutable wxo       : t;
    mutable who       : t;
    mutable bi        : t;
    mutable bc        : t;
    mutable bf        : t;
    mutable bo        : t;
    mutable c         : t;
    mutable h         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create ?inputs o =
    let in_shape = match inputs with
      | Some i -> [|i|]
      | None   -> [|0|]
    in
    {
      wxi = Mat.empty 0 o;
      whi = Mat.empty o o;
      wxc = Mat.empty 0 o;
      whc = Mat.empty o o;
      wxf = Mat.empty 0 o;
      whf = Mat.empty o o;
      wxo = Mat.empty 0 o;
      who = Mat.empty o o;
      bi  = Mat.empty 1 o;
      bc  = Mat.empty 1 o;
      bf  = Mat.empty 1 o;
      bo  = Mat.empty 1 o;
      c   = Mat.empty 1 o;
      h   = Mat.empty 1 o;
      init_typ = Init.Tanh;
      in_shape  = in_shape;
      out_shape = [|o|];
    }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    l.in_shape.(0) <- out_shape.(0)

  let init l =
    let i = l.in_shape.(0) in
    let o = l.out_shape.(0) in
    l.wxi <- Init.run l.init_typ i o;
    l.whi <- Init.run l.init_typ o o;
    l.wxc <- Init.run l.init_typ i o;
    l.whc <- Init.run l.init_typ o o;
    l.wxf <- Init.run l.init_typ i o;
    l.whf <- Init.run l.init_typ o o;
    l.wxo <- Init.run l.init_typ i o;
    l.who <- Init.run l.init_typ o o;
    l.bi  <- Mat.zeros 1 o;
    l.bc  <- Mat.zeros 1 o;
    l.bf  <- Mat.zeros 1 o;
    l.bo  <- Mat.zeros 1 o;
    l.c   <- Mat.zeros 1 o;
    l.h   <- Mat.zeros 1 o

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
    l.bo;
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
    primal l.bo;
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
    adjval l.bo;
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
      let i  = Maths.(((x *@ l.wxi) + (l.h *@ l.whi) + l.bi) |> sigmoid) in
      let c' = Maths.(((x *@ l.wxc) + (l.h *@ l.whc) + l.bc) |> tanh) in
      let f  = Maths.(((x *@ l.wxf) + (l.h *@ l.whf) + l.bf) |> sigmoid) in
      l.c <- Maths.((i * c') + (f * l.c));
      let o  = Maths.(((x *@ l.wxo) + (l.h *@ l.who) + l.bo) |> sigmoid) in
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
    Printf.sprintf "    LSTM   : matrix in:(*,%i) out:(*,%i) \n" l.in_shape.(0) l.out_shape.(0) ^
    Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "    params : %i\n" (wxim*wxin + whim*whin + wxcm*wxcn + whcm*whcn + wxfm*wxfn + whfm*whfn + wxom*wxon + whom*whon + bim*bin + bcm*bcn + bfm*bfn + bom*bon) ^
    Printf.sprintf "    wxi    : %i x %i\n" wxim wxin ^
    Printf.sprintf "    whi    : %i x %i\n" whim whin ^
    Printf.sprintf "    wxc    : %i x %i\n" wxcm wxcn ^
    Printf.sprintf "    whc    : %i x %i\n" whcm whcn ^
    Printf.sprintf "    wxf    : %i x %i\n" wxfm wxfn ^
    Printf.sprintf "    whf    : %i x %i\n" whfm whfn ^
    Printf.sprintf "    wxo    : %i x %i\n" wxom wxon ^
    Printf.sprintf "    who    : %i x %i\n" whom whon ^
    Printf.sprintf "    bi     : %i x %i\n" bim bin ^
    Printf.sprintf "    bc     : %i x %i\n" bcm bcn ^
    Printf.sprintf "    bf     : %i x %i\n" bfm bfn ^
    Printf.sprintf "    bo     : %i x %i\n" bom bon ^
    ""

  let to_name () = "lstm"

end


(* definition of Gated Recurrent Unit *)
module GRU = struct

  type neuron_typ = {
    mutable wxz       : t;
    mutable whz       : t;
    mutable wxr       : t;
    mutable whr       : t;
    mutable wxh       : t;
    mutable whh       : t;
    mutable bz        : t;
    mutable br        : t;
    mutable bh        : t;
    mutable h         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create ?inputs o =
    let in_shape = match inputs with
      | Some i -> [|i|]
      | None   -> [|0|]
    in
    {
      wxz = Mat.empty 0 o;
      whz = Mat.empty o o;
      wxr = Mat.empty 0 o;
      whr = Mat.empty o o;
      wxh = Mat.empty 0 o;
      whh = Mat.empty o o;
      bz  = Mat.empty 1 o;
      br  = Mat.empty 1 o;
      bh  = Mat.empty 1 o;
      h   = Mat.empty 1 o;
      init_typ = Init.Standard;
      in_shape  = in_shape;
      out_shape = [|o|];
    }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    l.in_shape.(0) <- out_shape.(0)

  let init l =
    let i = l.in_shape.(0) in
    let o = l.out_shape.(0) in
    l.wxz <- Init.run l.init_typ i o;
    l.whz <- Init.run l.init_typ o o;
    l.wxr <- Init.run l.init_typ i o;
    l.whr <- Init.run l.init_typ o o;
    l.wxh <- Init.run l.init_typ i o;
    l.whh <- Init.run l.init_typ o o;
    l.bz  <- Mat.zeros 1 o;
    l.br  <- Mat.zeros 1 o;
    l.bh  <- Mat.zeros 1 o;
    l.h   <- Mat.zeros 1 o

  let reset l = Mat.reset l.h

  let mktag t l =
    l.wxz <- make_reverse l.wxz t;
    l.whz <- make_reverse l.whz t;
    l.wxr <- make_reverse l.wxr t;
    l.whr <- make_reverse l.whr t;
    l.wxh <- make_reverse l.wxh t;
    l.whh <- make_reverse l.whh t;
    l.bz  <- make_reverse l.bz t;
    l.br  <- make_reverse l.br t;
    l.bh  <- make_reverse l.bh t

  let mkpar l = [|
    l.wxz;
    l.whz;
    l.wxr;
    l.whr;
    l.wxh;
    l.whh;
    l.bz;
    l.br;
    l.bh;
  |]

  let mkpri l = [|
    primal l.wxz;
    primal l.whz;
    primal l.wxr;
    primal l.whr;
    primal l.wxh;
    primal l.whh;
    primal l.bz;
    primal l.br;
    primal l.bh;
  |]

  let mkadj l = [|
    adjval l.wxz;
    adjval l.whz;
    adjval l.wxr;
    adjval l.whr;
    adjval l.wxh;
    adjval l.whh;
    adjval l.bz;
    adjval l.br;
    adjval l.bh;
  |]

  let update l u =
    l.wxz <- u.(0) |> primal';
    l.whz <- u.(1) |> primal';
    l.wxr <- u.(2) |> primal';
    l.whr <- u.(3) |> primal';
    l.wxh <- u.(4) |> primal';
    l.whh <- u.(5) |> primal';
    l.bz  <- u.(6) |> primal';
    l.br  <- u.(7) |> primal';
    l.bh  <- u.(8) |> primal'

  let run x l =
    let y = Mat.map_by_row (fun x ->
      let z  = Maths.(((x *@ l.wxz) + (l.h *@ l.whz) + l.bz) |> sigmoid) in
      let r  = Maths.(((x *@ l.wxr) + (l.h *@ l.whr) + l.br) |> sigmoid) in
      let h' = Maths.(((x *@ l.wxh) + ((l.h * r) *@ l.whh))  |> tanh) in
      l.h <- Maths.((F 1. - z) * h' + (z * l.h));
      l.h
    ) x in
    l.h <- primal' l.h;
    y

  let to_string l =
    let wxzm, wxzn = Mat.shape l.wxz in
    let whzm, whzn = Mat.shape l.whz in
    let wxrm, wxrn = Mat.shape l.wxr in
    let whrm, whrn = Mat.shape l.whr in
    let wxhm, wxhn = Mat.shape l.wxh in
    let whhm, whhn = Mat.shape l.whh in
    let bzm, bzn = Mat.shape l.bz in
    let brm, brn = Mat.shape l.br in
    let bhm, bhn = Mat.shape l.bh in
    Printf.sprintf "    GRU    : matrix in:(*,%i) out:(*,%i) \n" l.in_shape.(0) l.out_shape.(0) ^
    Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "    params : %i\n" (wxzm*wxzn + whzm*whzn + wxrm*wxrn + whrm*whrn + wxhm*wxhn + whhm*whhn + bzm*bzn + brm*brn + bhm*bhn) ^
    Printf.sprintf "    wxz    : %i x %i\n" wxzm wxzn ^
    Printf.sprintf "    whz    : %i x %i\n" whzm whzn ^
    Printf.sprintf "    wxr    : %i x %i\n" wxrm wxrn ^
    Printf.sprintf "    whr    : %i x %i\n" whrm whrn ^
    Printf.sprintf "    wxh    : %i x %i\n" wxhm wxhn ^
    Printf.sprintf "    whh    : %i x %i\n" whhm whhn ^
    Printf.sprintf "    bz     : %i x %i\n" bzm bzn ^
    Printf.sprintf "    br     : %i x %i\n" brm brn ^
    Printf.sprintf "    bh     : %i x %i\n" bhm bhn ^
    ""

  let to_name () = "gru"

end


(* definition of Conv1D neuron *)
module Conv1D = struct

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable padding   : padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create padding ?inputs kernel stride =
    let h, i, o = kernel.(0), kernel.(1), kernel.(2) in
    let in_shape = match inputs with
      | Some a -> assert (i = a.(1)); a
      | None   -> [|0;i|]
    in
    {
      w         = Arr.empty [|h;i;o|];
      b         = Arr.empty [|o|];
      kernel    = kernel;
      stride    = stride;
      padding   = padding;
      init_typ  = Init.Uniform (0.,1.);
      in_shape  = in_shape;
      out_shape = [|0;o|];
    }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    assert (out_shape.(1) = l.in_shape.(1));
    l.in_shape.(0) <- out_shape.(0);
    let out_cols =
      Owl_dense_ndarray_generic.calc_conv1d_output_shape
      l.padding l.in_shape.(0) l.kernel.(0) l.stride.(0)
    in
    l.out_shape.(0) <- out_cols

  (* FIXME *)
  let init l =
    l.w <- Maths.((Arr.(uniform (shape l.w)) - (F 0.5)) / (F 1000.));
    l.b <- Arr.(zeros (shape l.b))

  let reset l =
    Arr.reset l.w;
    Arr.reset l.b

  let mktag t l =
    l.w <- make_reverse l.w t;
    l.b <- make_reverse l.b t

  let mkpar l = [|l.w; l.b|]

  let mkpri l = [|primal l.w; primal l.b|]

  let mkadj l = [|adjval l.w; adjval l.b|]

  let update l u =
    l.w <- u.(0) |> primal';
    l.b <- u.(1) |> primal'

  let run x l = Maths.((conv1d ~padding:l.padding x l.w l.stride) + l.b)

  let to_string l =
    let ws = Arr.shape l.w in
    let bn = Arr.shape l.b in
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Conv1D : tensor in:[*;%s] out:[*,%s]\n" in_str out_str ^
    Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "    params : %i\n" (ws.(0)*ws.(1)*ws.(2) + bn.(0)) ^
    Printf.sprintf "    kernel : %i x %i x %i\n" ws.(0) ws.(1) ws.(2) ^
    Printf.sprintf "    b      : %i\n" bn.(0) ^
    Printf.sprintf "    stride : [%i]\n" l.stride.(0) ^
    ""

  let to_name () = "conv1d"

end


(* definition of Conv2D neuron *)
module Conv2D = struct

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable padding   : padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create padding ?inputs kernel stride =
    let w, h, i, o = kernel.(0), kernel.(1), kernel.(2), kernel.(3) in
    let in_shape = match inputs with
      | Some a -> assert (i = a.(2)); a
      | None   -> [|0;0;i|]
    in
    {
      w         = Arr.empty [|w;h;i;o|];
      b         = Arr.empty [|o|];
      kernel    = kernel;
      stride    = stride;
      padding   = padding;
      init_typ  = Init.Uniform (0.,1.);
      in_shape  = in_shape;
      out_shape = [|0;0;o|];
    }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    assert (out_shape.(2) = l.in_shape.(2));
    l.in_shape.(0) <- out_shape.(0);
    l.in_shape.(1) <- out_shape.(1);
    let out_cols, out_rows =
      Owl_dense_ndarray_generic.calc_conv2d_output_shape
      l.padding l.in_shape.(0) l.in_shape.(1) l.kernel.(0) l.kernel.(1)
      l.stride.(0) l.stride.(1)
    in
    l.out_shape.(0) <- out_cols;
    l.out_shape.(1) <- out_rows

  (* FIXME *)
  let init l =
    l.w <- Maths.((Arr.(uniform (shape l.w)) - (F 0.5)) / (F 1000.));
    l.b <- Arr.(zeros (shape l.b))

  let reset l =
    Arr.reset l.w;
    Arr.reset l.b

  let mktag t l =
    l.w <- make_reverse l.w t;
    l.b <- make_reverse l.b t

  let mkpar l = [|l.w; l.b|]

  let mkpri l = [|primal l.w; primal l.b|]

  let mkadj l = [|adjval l.w; adjval l.b|]

  let update l u =
    (* DEBUG
    let x = u.(0) |> primal' |> unpack_arr in
    let a = Owl_dense_ndarray_generic.sum x in
    Printf.printf "===> %g\n" a;
    flush_all (); exit 0; *)
    l.w <- u.(0) |> primal';
    l.b <- u.(1) |> primal'

  let run x l = Maths.((conv2d ~padding:l.padding x l.w l.stride) + l.b)

  let to_string l =
    let ws = Arr.shape l.w in
    let bn = Arr.shape l.b in
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Conv2D : tensor in:[*;%s] out:[*,%s]\n" in_str out_str ^
    Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "    params : %i\n" (ws.(0)*ws.(1)*ws.(2)*ws.(3) + bn.(0)) ^
    Printf.sprintf "    kernel : %i x %i x %i x %i\n" ws.(0) ws.(1) ws.(2) ws.(3) ^
    Printf.sprintf "    b      : %i\n" bn.(0) ^
    Printf.sprintf "    stride : [%i; %i]\n" l.stride.(0) l.stride.(1) ^
    ""

  let to_name () = "conv2d"

end


(* definition of Conv2D neuron *)
module Conv3D = struct

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable padding   : padding;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create padding ?inputs kernel stride =
    let w, h, d, i, o = kernel.(0), kernel.(1), kernel.(2), kernel.(3), kernel.(4) in
    let in_shape = match inputs with
      | Some a -> assert (i = a.(3)); a
      | None   -> [|0;0;0;i|]
    in
    {
      w         = Arr.empty [|w;h;d;i;o|];
      b         = Arr.empty [|o|];
      kernel    = kernel;
      stride    = stride;
      padding   = padding;
      init_typ  = Init.Uniform (0.,1.);
      in_shape  = in_shape;
      out_shape = [|0;0;0;o|];
    }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    assert (out_shape.(3) = l.in_shape.(3));
    l.in_shape.(0) <- out_shape.(0);
    l.in_shape.(1) <- out_shape.(1);
    l.in_shape.(2) <- out_shape.(2);
    let out_cols, out_rows, out_dpts =
      Owl_dense_ndarray_generic.calc_conv3d_output_shape
      l.padding l.in_shape.(0) l.in_shape.(1) l.in_shape.(2)
      l.kernel.(0) l.kernel.(1) l.kernel.(2)
      l.stride.(0) l.stride.(1) l.stride.(2)
    in
    l.out_shape.(0) <- out_cols;
    l.out_shape.(1) <- out_rows;
    l.out_shape.(2) <- out_dpts

  (* FIXME *)
  let init l =
    l.w <- Maths.((Arr.(uniform (shape l.w)) - (F 0.5)) / (F 1000.));
    l.b <- Arr.(zeros (shape l.b))

  let reset l =
    Arr.reset l.w;
    Arr.reset l.b

  let mktag t l =
    l.w <- make_reverse l.w t;
    l.b <- make_reverse l.b t

  let mkpar l = [|l.w; l.b|]

  let mkpri l = [|primal l.w; primal l.b|]

  let mkadj l = [|adjval l.w; adjval l.b|]

  let update l u =
    l.w <- u.(0) |> primal';
    l.b <- u.(1) |> primal'

  let run x l = Maths.((conv3d ~padding:l.padding x l.w l.stride) + l.b)

  let to_string l =
    let ws = Arr.shape l.w in
    let bn = Arr.shape l.b in
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Conv3D : tensor in:[*;%s] out:[*,%s]\n" in_str out_str ^
    Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "    params : %i\n" (ws.(0)*ws.(1)*ws.(2)*ws.(3)*ws.(4) + bn.(0)) ^
    Printf.sprintf "    kernel : %i x %i x %i x %i x %i\n" ws.(0) ws.(1) ws.(2) ws.(3)  ws.(4) ^
    Printf.sprintf "    b      : %i\n" bn.(0) ^
    Printf.sprintf "    stride : [%i; %i; %i]\n" l.stride.(0) l.stride.(1) l.stride.(2) ^
    ""

  let to_name () = "conv3d"

end


(* definition of FullyConnected neuron *)
module FullyConnected = struct

  type neuron_typ = {
    mutable w         : t;
    mutable b         : t;
    mutable init_typ  : Init.typ;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create ?inputs o init_typ =
    let in_shape = match inputs with
      | Some i -> [|i|]
      | None   -> [|0|]
    in
    {
      w         = Mat.empty 0 o;
      b         = Mat.empty 1 o;
      init_typ  = init_typ;
      in_shape  = in_shape;
      out_shape = [|o|];
    }

  let connect out_shape l =
    assert (Array.length out_shape > 0);
    l.in_shape <- Array.copy out_shape

  let init l =
    let m = Array.fold_left (fun a b -> a * b) 1 l.in_shape in
    let n = l.out_shape.(0) in
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
    (* DEBUG
    let x = u.(1) |> primal' |> unpack_mat in
    Owl_dense_matrix_generic.print x; flush_all (); exit 0; *)
    l.w <- u.(0) |> primal';
    l.b <- u.(1) |> primal'

  let run x l =
    let m = Mat.row_num l.w in
    let n = Arr.numel x / m in
    (* Log.info "===> %i %i\n" n m; flush_all(); *)
    let x = Maths.(reshape x [|n;m|] |> arr_to_mat) in
    (* Owl_dense_matrix_generic.print (unpack_mat x); *)
    let y = Maths.((x *@ l.w) + l.b) in
    (* Log.info "done!"; flush_all (); *)
    (* Owl_dense_matrix_generic.print (unpack_mat y); flush_all (); *)
    y

  let to_string l =
    let wm = Array.fold_left (fun a b -> a * b) 1 l.in_shape in
    let wn = l.out_shape.(0) in
    let bn = l.out_shape.(0) in
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    Printf.sprintf "    FullyConnected : tensor in:[*,%s] matrix out:(*,%i)\n" in_str l.out_shape.(0) ^
    Printf.sprintf "    init           : %s\n" (Init.to_string l.init_typ) ^
    Printf.sprintf "    params         : %i\n" (wm * wn + bn) ^
    Printf.sprintf "    w              : %i x %i\n" wm wn ^
    Printf.sprintf "    b              : %i x %i\n" 1 bn ^
    ""

  let to_name () = "fullyconnected"

end


(* definition of MaxPool1D neuron *)
module MaxPool1D = struct

  type neuron_typ = {
    mutable padding   : padding;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create padding kernel stride = {
    padding;
    kernel;
    stride;
    in_shape  = [|0;0|];
    out_shape = [|0;0|];
  }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    l.in_shape.(0) <- out_shape.(0);
    l.in_shape.(1) <- out_shape.(1);
    let out_cols = Owl_dense_ndarray_generic.calc_conv1d_output_shape
      l.padding l.in_shape.(0) l.kernel.(0) l.stride.(0)
    in
    l.out_shape.(0) <- out_cols;
    l.out_shape.(1) <- out_shape.(1)

  let run x l = Maths.(max_pool1d l.padding x l.kernel l.stride)

  let to_string l =
    let padding_s = match l.padding with
      | Owl_dense_ndarray_generic.SAME  -> "SAME"
      | Owl_dense_ndarray_generic.VALID -> "VALID"
    in
    Printf.sprintf "    MaxPool1D : tensor in:[*,%i,%i] out:[*,%i,%i]\n" l.in_shape.(0) l.in_shape.(1) l.out_shape.(0) l.out_shape.(1) ^
    Printf.sprintf "    padding   : %s\n" padding_s ^
    Printf.sprintf "    kernel    : [%i]\n" l.kernel.(0) ^
    Printf.sprintf "    stride    : [%i]\n" l.stride.(0) ^
    ""

  let to_name () = "maxpool1d"

end


(* definition of AvgPool1D neuron *)
module AvgPool1D = struct

  type neuron_typ = {
    mutable padding   : padding;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create padding kernel stride = {
    padding;
    kernel;
    stride;
    in_shape  = [|0;0|];
    out_shape = [|0;0|];
  }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    l.in_shape.(0) <- out_shape.(0);
    l.in_shape.(1) <- out_shape.(1);
    let out_cols = Owl_dense_ndarray_generic.calc_conv1d_output_shape
      l.padding l.in_shape.(0) l.kernel.(0) l.stride.(0)
    in
    l.out_shape.(0) <- out_cols;
    l.out_shape.(1) <- out_shape.(1)

  let run x l = Maths.(avg_pool1d l.padding x l.kernel l.stride)

  let to_string l =
    let padding_s = match l.padding with
      | Owl_dense_ndarray_generic.SAME  -> "SAME"
      | Owl_dense_ndarray_generic.VALID -> "VALID"
    in
    Printf.sprintf "    AvgPool1D : tensor in:[*,%i,%i] out:[*,%i,%i]\n" l.in_shape.(0) l.in_shape.(1) l.out_shape.(0) l.out_shape.(1) ^
    Printf.sprintf "    padding   : %s\n" padding_s ^
    Printf.sprintf "    kernel    : [%i]\n" l.kernel.(0) ^
    Printf.sprintf "    stride    : [%i]\n" l.stride.(0) ^
    ""

  let to_name () = "avgpool1d"

end


(* definition of MaxPool2D neuron *)
module MaxPool2D = struct

  type neuron_typ = {
    mutable padding   : padding;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create padding kernel stride = {
    padding;
    kernel;
    stride;
    in_shape  = [|0;0;0|];
    out_shape = [|0;0;0|];
  }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    l.in_shape.(0) <- out_shape.(0);
    l.in_shape.(1) <- out_shape.(1);
    l.in_shape.(2) <- out_shape.(2);
    let out_cols, out_rows = Owl_dense_ndarray_generic.calc_conv2d_output_shape
      l.padding l.in_shape.(0) l.in_shape.(1) l.kernel.(0) l.kernel.(1) l.stride.(0) l.stride.(1)
    in
    l.out_shape.(0) <- out_cols;
    l.out_shape.(1) <- out_rows;
    l.out_shape.(2) <- out_shape.(2)

  let run x l = Maths.(max_pool2d l.padding x l.kernel l.stride)

  let to_string l =
    let padding_s = match l.padding with
      | Owl_dense_ndarray_generic.SAME  -> "SAME"
      | Owl_dense_ndarray_generic.VALID -> "VALID"
    in
    Printf.sprintf "    MaxPool2D : tensor in:[*,%i,%i,%i] out:[*,%i,%i,%i]\n" l.in_shape.(0) l.in_shape.(1) l.in_shape.(2) l.out_shape.(0) l.out_shape.(1) l.out_shape.(2) ^
    Printf.sprintf "    padding   : %s\n" padding_s ^
    Printf.sprintf "    kernel    : [%i; %i]\n" l.kernel.(0) l.kernel.(1) ^
    Printf.sprintf "    stride    : [%i; %i]\n" l.stride.(0) l.stride.(1) ^
    ""

  let to_name () = "maxpool2d"

end


(* definition of AvgPool2D neuron *)
module AvgPool2D = struct

  type neuron_typ = {
    mutable padding   : padding;
    mutable kernel    : int array;
    mutable stride    : int array;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create padding kernel stride = {
    padding;
    kernel;
    stride;
    in_shape  = [|0;0;0|];
    out_shape = [|0;0;0|];
  }

  let connect out_shape l =
    assert Array.(length out_shape = length l.in_shape);
    l.in_shape.(0) <- out_shape.(0);
    l.in_shape.(1) <- out_shape.(1);
    l.in_shape.(2) <- out_shape.(2);
    let out_cols, out_rows = Owl_dense_ndarray_generic.calc_conv2d_output_shape
      l.padding l.in_shape.(0) l.in_shape.(1) l.kernel.(0) l.kernel.(1) l.stride.(0) l.stride.(1)
    in
    l.out_shape.(0) <- out_cols;
    l.out_shape.(1) <- out_rows;
    l.out_shape.(2) <- out_shape.(2)


  let run x l = Maths.(avg_pool2d l.padding x l.kernel l.stride)

  let to_string l =
    let padding_s = match l.padding with
      | Owl_dense_ndarray_generic.SAME  -> "SAME"
      | Owl_dense_ndarray_generic.VALID -> "VALID"
    in
    Printf.sprintf "    AvgPool2D : tensor in:[*,%i,%i,%i] out:[*,%i,%i,%i]\n" l.in_shape.(0) l.in_shape.(1) l.in_shape.(2) l.out_shape.(0) l.out_shape.(1) l.out_shape.(2) ^
    Printf.sprintf "    padding   : %s\n" padding_s ^
    Printf.sprintf "    kernel    : [%i; %i]\n" l.kernel.(0) l.kernel.(1) ^
    Printf.sprintf "    stride    : [%i; %i]\n" l.stride.(0) l.stride.(1) ^
    ""

  let to_name () = "avgpool2d"

end


(* TODO: definition of UpSampling1D neuron *)
module UpSampling1D = struct

end


(* TODO: definition of UpSampling2D neuron *)
module UpSampling2D = struct

end


(* TODO: definition of UpSampling3D neuron *)
module UpSampling3D = struct

end


(* TODO: definition of Padding1D neuron *)
module Padding1D = struct

end


(* TODO: definition of Padding2D neuron *)
module Padding2D = struct

end


(* TODO: definition of Padding3D neuron *)
module Padding3D = struct

end


(* definition of Lambda neuron *)
module Lambda = struct

  type neuron_typ = {
    mutable lambda    : t -> t;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create lambda = {
    lambda;
    in_shape  = [||];
    out_shape = [||];
  }

  let connect out_shape l =
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- Array.copy out_shape

  let run x l = l.lambda x

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Lambda       : in:[*,%s] out:[*,%s]\n" in_str out_str ^
    Printf.sprintf "    customised f : t -> t\n" ^
    ""

  let to_name () = "lambda"

end


(* definition of Dropout neuron *)
module Dropout = struct

  type neuron_typ = {
    mutable rate      : float;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create rate = {
    rate;
    in_shape  = [||];
    out_shape = [||];
  }

  let connect out_shape l =
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- Array.copy out_shape

  let run x l = Maths.(dropout ~rate:l.rate x)

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Dropout : in:[*,%s] out:[*,%s]\n" in_str out_str ^
    Printf.sprintf "    rate    : %g\n" l.rate

  let to_name () = "dropout"

end


(* definition of Reshape neuron *)
module Reshape = struct

  type neuron_typ = {
    mutable convert   : bool;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create ?(convert=false) ?inputs o =
    let in_shape = match inputs with
      | Some i -> i
      | None   -> [||]
    in
    {
      convert   = convert;
      in_shape  = in_shape;
      out_shape = o;
    }

  let connect out_shape l =
    let m = Array.fold_left (fun a b -> a * b) 1 out_shape in
    let n = Array.fold_left (fun a b -> a * b) 1 l.out_shape in
    assert (m = n);
    l.in_shape <- Array.copy out_shape

  let run x l =
    let x_shape = shape x in
    let out_shape = Array.append [|x_shape.(0)|] l.out_shape in
    let x = Maths.reshape x out_shape in
    match l.convert with
    | true  -> (
        match (primal' x) with
        | Arr _ -> Maths.arr_to_mat x
        | Mat _ -> Maths.mat_to_arr x
        | _     -> failwith "Owl_neural:Reshape:run"
      )
    | false -> x

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Reshape : in:[*,%s] out:[*,%s]\n" in_str out_str ^
    Printf.sprintf "    convert : %s\n" (string_of_bool l.convert)

  let to_name () = "reshape"

end


(* definition of Flatten neuron *)
module Flatten = struct

  type neuron_typ = {
    mutable convert   : bool;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create ?(convert=false) () = {
      convert   = convert;
      in_shape  = [||];
      out_shape = [||];
    }

  let connect out_shape l =
    let o = Array.fold_left (fun a b -> a * b) 1 out_shape in
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- [|o|]

  let run x l =
    let x = Maths.reshape x [|(shape x).(0); l.out_shape.(0)|] in
    match l.convert with
    | true  -> (
        match (primal' x) with
        | Arr _ -> Maths.arr_to_mat x
        | Mat _ -> Maths.mat_to_arr x
        | _     -> failwith "Owl_neural:Flatten:run"
      )
    | false -> x

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    Printf.sprintf "    Flatten : in:[*,%s] out:[*,%i]\n" in_str l.out_shape.(0) ^
    Printf.sprintf "    convert : %s\n" (string_of_bool l.convert)

  let to_name () = "flatten"

end


(* definition of Add neuron *)
module Add = struct

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create () = {
    in_shape  = [||];
    out_shape = [||];
  }

  let connect out_shape l =
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- Array.copy out_shape

  let run x l =
    let n = Array.length x in
    (* at least two inputs *)
    assert (n > 1);
    let acc = ref x.(0) in
    for i = 1 to n - 1 do
      acc := Maths.(!acc + x.(i))
    done;
    !acc

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Add : in:[*,%s] out:[*,%s]\n" in_str out_str

  let to_name () = "add"

end


(* definition of Multiply neuron *)
module Mul = struct

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create () = {
    in_shape  = [||];
    out_shape = [||];
  }

  let connect out_shape l =
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- Array.copy out_shape

  let run x l =
    let n = Array.length x in
    (* at least two inputs *)
    assert (n > 1);
    let acc = ref x.(0) in
    for i = 1 to n - 1 do
      acc := Maths.(!acc * x.(i))
    done;
    !acc

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Multiply : in:[*,%s] out:[*,%s]\n" in_str out_str

  let to_name () = "mul"

end


(* definition of Dot neuron *)
module Dot = struct

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create () = {
    in_shape  = [||];
    out_shape = [||];
  }

  let connect out_shape l =
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- [|out_shape.(1)|]

  let run x l =
    assert (Array.length x = 2);
    Maths.(x.(0) *@ x.(1))

  let to_string l =
    let m = l.in_shape.(0) in
    let n = l.in_shape.(1) in
    Printf.sprintf "    Dot : in:[*,%i] [%i,%i] out:[*,%i]\n" m m n n

  let to_name () = "dot"

end


(* definition of Max neuron *)
module Max = struct

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create () = {
    in_shape  = [||];
    out_shape = [||];
  }

  let connect out_shape l =
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- Array.copy out_shape

  let run x l =
    let n = Array.length x in
    (* at least two inputs *)
    assert (n > 1);
    let acc = ref x.(0) in
    for i = 1 to n - 1 do
      acc := Maths.(max2 !acc x.(i))
    done;
    !acc

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Max : in:[*,%s] out:[*,%s]\n" in_str out_str

  let to_name () = "max"

end


(* definition of Average neuron *)
module Average = struct

  type neuron_typ = {
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create () = {
    in_shape  = [||];
    out_shape = [||];
  }

  let connect out_shape l =
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- Array.copy out_shape

  let run x l =
    let n = Array.length x in
    (* at least two inputs *)
    assert (n > 1);
    let acc = ref x.(0) in
    for i = 1 to n - 1 do
      acc := Maths.(!acc + x.(i))
    done;
    Maths.(!acc / F (float_of_int n))

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Average : in:[*,%s] out:[*,%s]\n" in_str out_str

  let to_name () = "average"

end


(* TODO: definition of Concatenate neuron *)
module Concatenate = struct
(*
  type neuron_typ = {
    mutable axis      : int;
    mutable in_shape  : int array;
    mutable out_shape : int array;
  }

  let create () = {
    in_shape  = [||];
    out_shape = [||];
  }

  let connect out_shape l =
    l.in_shape <- Array.copy out_shape;
    l.out_shape <- Array.copy out_shape

  let run x l =
    let n = Array.length x in
    (* at least two inputs *)
    assert (n > 1);
    let acc = ref x.(0) in
    for i = 1 to n - 1 do
      acc := Maths.(!acc + x.(i))
    done;
    Maths.(!acc / F (float_of_int n))

  let to_string l =
    let in_str = Owl_utils.string_of_array string_of_int l.in_shape in
    let out_str = Owl_utils.string_of_array string_of_int l.out_shape in
    Printf.sprintf "    Average : in:[*,%s] out:[*,%s]\n" in_str out_str

  let to_name () = "average"
*)
end



(* TODO: definition of Normalisation neuron *)
module Normalisation = struct

end


(* TODO: definition of GaussianNoise neuron *)
module GaussianNoise = struct

end


(* TODO: definition of GaussianDropout neuron *)
module GaussianDropout = struct

end


(* TODO: definition of Masking neuron *)
module Masking = struct

end


(* type definition and basic functions of neurons *)

type neuron =
  | Input          of Input.neuron_typ
  | Linear         of Linear.neuron_typ
  | LinearNoBias   of LinearNoBias.neuron_typ
  | LSTM           of LSTM.neuron_typ
  | GRU            of GRU.neuron_typ
  | Recurrent      of Recurrent.neuron_typ
  | Conv1D         of Conv1D.neuron_typ
  | Conv2D         of Conv2D.neuron_typ
  | Conv3D         of Conv3D.neuron_typ
  | FullyConnected of FullyConnected.neuron_typ
  | MaxPool1D      of MaxPool1D.neuron_typ
  | MaxPool2D      of MaxPool2D.neuron_typ
  | AvgPool1D      of AvgPool1D.neuron_typ
  | AvgPool2D      of AvgPool2D.neuron_typ
  | Dropout        of Dropout.neuron_typ
  | Reshape        of Reshape.neuron_typ
  | Flatten        of Flatten.neuron_typ
  | Lambda         of Lambda.neuron_typ
  | Activation     of Activation.neuron_typ
  | Add            of Add.neuron_typ
  | Mul            of Mul.neuron_typ
  | Dot            of Dot.neuron_typ
  | Max            of Max.neuron_typ
  | Average        of Average.neuron_typ


let get_in_out_shape = function
  | Input l          -> Input.(l.in_shape, l.out_shape)
  | Linear l         -> Linear.(l.in_shape, l.out_shape)
  | LinearNoBias l   -> LinearNoBias.(l.in_shape, l.out_shape)
  | LSTM l           -> LSTM.(l.in_shape, l.out_shape)
  | GRU l            -> GRU.(l.in_shape, l.out_shape)
  | Recurrent l      -> Recurrent.(l.in_shape, l.out_shape)
  | Conv1D l         -> Conv1D.(l.in_shape, l.out_shape)
  | Conv2D l         -> Conv2D.(l.in_shape, l.out_shape)
  | Conv3D l         -> Conv3D.(l.in_shape, l.out_shape)
  | FullyConnected l -> FullyConnected.(l.in_shape, l.out_shape)
  | MaxPool1D l      -> MaxPool1D.(l.in_shape, l.out_shape)
  | MaxPool2D l      -> MaxPool2D.(l.in_shape, l.out_shape)
  | AvgPool1D l      -> AvgPool1D.(l.in_shape, l.out_shape)
  | AvgPool2D l      -> AvgPool2D.(l.in_shape, l.out_shape)
  | Dropout l        -> Dropout.(l.in_shape, l.out_shape)
  | Reshape l        -> Reshape.(l.in_shape, l.out_shape)
  | Flatten l        -> Flatten.(l.in_shape, l.out_shape)
  | Lambda l         -> Lambda.(l.in_shape, l.out_shape)
  | Activation l     -> Activation.(l.in_shape, l.out_shape)
  | Add l            -> Add.(l.in_shape, l.out_shape)
  | Mul l            -> Mul.(l.in_shape, l.out_shape)
  | Dot l            -> Dot.(l.in_shape, l.out_shape)
  | Max l            -> Max.(l.in_shape, l.out_shape)
  | Average l        -> Average.(l.in_shape, l.out_shape)

let get_in_shape x = x |> get_in_out_shape |> fst

let get_out_shape x = x |> get_in_out_shape |> snd


let connect out_shape l = match l with
  | Input l          -> () (* always the first neuron *)
  | Linear l         -> Linear.connect out_shape l
  | LinearNoBias l   -> LinearNoBias.connect out_shape l
  | LSTM l           -> LSTM.connect out_shape l
  | GRU l            -> GRU.connect out_shape l
  | Recurrent l      -> Recurrent.connect out_shape l
  | Conv1D l         -> Conv1D.connect out_shape l
  | Conv2D l         -> Conv2D.connect out_shape l
  | Conv3D l         -> Conv3D.connect out_shape l
  | FullyConnected l -> FullyConnected.connect out_shape l
  | MaxPool1D l      -> MaxPool1D.connect out_shape l
  | MaxPool2D l      -> MaxPool2D.connect out_shape l
  | AvgPool1D l      -> AvgPool1D.connect out_shape l
  | AvgPool2D l      -> AvgPool2D.connect out_shape l
  | Dropout l        -> Dropout.connect out_shape l
  | Reshape l        -> Reshape.connect out_shape l
  | Flatten l        -> Flatten.connect out_shape l
  | Lambda l         -> Lambda.connect out_shape l
  | Activation l     -> Activation.connect out_shape l
  | Add l            -> Add.connect out_shape l
  | Mul l            -> Mul.connect out_shape l
  | Dot l            -> Dot.connect out_shape l
  | Max l            -> Max.connect out_shape l
  | Average l        -> Average.connect out_shape l


let init = function
  | Linear l         -> Linear.init l
  | LinearNoBias l   -> LinearNoBias.init l
  | LSTM l           -> LSTM.init l
  | GRU l            -> GRU.init l
  | Recurrent l      -> Recurrent.init l
  | Conv1D l         -> Conv1D.init l
  | Conv2D l         -> Conv2D.init l
  | Conv3D l         -> Conv3D.init l
  | FullyConnected l -> FullyConnected.init l
  | _                -> () (* activation, etc. *)


let reset = function
  | Linear l          -> Linear.reset l
  | LinearNoBias l   -> LinearNoBias.reset l
  | LSTM l           -> LSTM.reset l
  | GRU l            -> GRU.reset l
  | Recurrent l      -> Recurrent.reset l
  | Conv1D l         -> Conv1D.reset l
  | Conv2D l         -> Conv2D.reset l
  | Conv3D l         -> Conv3D.reset l
  | FullyConnected l -> FullyConnected.reset l
  | _                -> () (* activation, etc. *)

let mktag t = function
  | Linear l         -> Linear.mktag t l
  | LinearNoBias l   -> LinearNoBias.mktag t l
  | LSTM l           -> LSTM.mktag t l
  | GRU l            -> GRU.mktag t l
  | Recurrent l      -> Recurrent.mktag t l
  | Conv1D l         -> Conv1D.mktag t l
  | Conv2D l         -> Conv2D.mktag t l
  | Conv3D l         -> Conv3D.mktag t l
  | FullyConnected l -> FullyConnected.mktag t l
  | _                -> () (* activation, etc. *)


let mkpar = function
  | Linear l         -> Linear.mkpar l
  | LinearNoBias l   -> LinearNoBias.mkpar l
  | LSTM l           -> LSTM.mkpar l
  | GRU l            -> GRU.mkpar l
  | Recurrent l      -> Recurrent.mkpar l
  | Conv1D l         -> Conv1D.mkpar l
  | Conv2D l         -> Conv2D.mkpar l
  | Conv3D l         -> Conv3D.mkpar l
  | FullyConnected l -> FullyConnected.mkpar l
  | _                -> [||] (* activation, etc. *)


let mkpri = function
  | Linear l         -> Linear.mkpri l
  | LinearNoBias l   -> LinearNoBias.mkpri l
  | LSTM l           -> LSTM.mkpri l
  | GRU l            -> GRU.mkpri l
  | Recurrent l      -> Recurrent.mkpri l
  | Conv1D l         -> Conv1D.mkpri l
  | Conv2D l         -> Conv2D.mkpri l
  | Conv3D l         -> Conv3D.mkpri l
  | FullyConnected l -> FullyConnected.mkpri l
  | _                -> [||] (* activation, etc. *)


let mkadj = function
  | Linear l         -> Linear.mkadj l
  | LinearNoBias l   -> LinearNoBias.mkadj l
  | LSTM l           -> LSTM.mkadj l
  | GRU l            -> GRU.mkadj l
  | Recurrent l      -> Recurrent.mkadj l
  | Conv1D l         -> Conv1D.mkadj l
  | Conv2D l         -> Conv2D.mkadj l
  | Conv3D l         -> Conv3D.mkadj l
  | FullyConnected l -> FullyConnected.mkadj l
  | _                -> [||] (* activation, etc. *)


let update l u = match l with
  | Linear l         -> Linear.update l u
  | LinearNoBias l   -> LinearNoBias.update l u
  | LSTM l           -> LSTM.update l u
  | GRU l            -> GRU.update l u
  | Recurrent l      -> Recurrent.update l u
  | Conv1D l         -> Conv1D.update l u
  | Conv2D l         -> Conv2D.update l u
  | Conv3D l         -> Conv3D.update l u
  | FullyConnected l -> FullyConnected.update l u
  | _                -> () (* activation, etc. *)


let run a l = match l with
  | Input l          -> Input.run a l
  | Linear l         -> Linear.run a l
  | LinearNoBias l   -> LinearNoBias.run a l
  | LSTM l           -> LSTM.run a l
  | GRU l            -> GRU.run a l
  | Recurrent l      -> Recurrent.run a l
  | Conv1D l         -> Conv1D.run a l
  | Conv2D l         -> Conv2D.run a l
  | Conv3D l         -> Conv3D.run a l
  | FullyConnected l -> FullyConnected.run a l
  | MaxPool1D l      -> MaxPool1D.run a l
  | MaxPool2D l      -> MaxPool2D.run a l
  | AvgPool1D l      -> AvgPool1D.run a l
  | AvgPool2D l      -> AvgPool2D.run a l
  | Dropout l        -> Dropout.run a l
  | Reshape l        -> Reshape.run a l
  | Flatten l        -> Flatten.run a l
  | Lambda l         -> Lambda.run a l
  | Activation l     -> Activation.run a l
  | _                -> failwith "Owl_neural_neuron:run"


let run_array a l = match l with
  | Input l          -> Input.run a.(0) l
  | Linear l         -> Linear.run a.(0) l
  | LinearNoBias l   -> LinearNoBias.run a.(0) l
  | LSTM l           -> LSTM.run a.(0) l
  | GRU l            -> GRU.run a.(0) l
  | Recurrent l      -> Recurrent.run a.(0) l
  | Conv1D l         -> Conv1D.run a.(0) l
  | Conv2D l         -> Conv2D.run a.(0) l
  | Conv3D l         -> Conv3D.run a.(0) l
  | FullyConnected l -> FullyConnected.run a.(0) l
  | MaxPool1D l      -> MaxPool1D.run a.(0) l
  | MaxPool2D l      -> MaxPool2D.run a.(0) l
  | AvgPool1D l      -> AvgPool1D.run a.(0) l
  | AvgPool2D l      -> AvgPool2D.run a.(0) l
  | Dropout l        -> Dropout.run a.(0) l
  | Reshape l        -> Reshape.run a.(0) l
  | Flatten l        -> Flatten.run a.(0) l
  | Lambda l         -> Lambda.run a.(0) l
  | Activation l     -> Activation.run a.(0) l
  | Add l            -> Add.run a l
  | Mul l            -> Mul.run a l
  | Dot l            -> Dot.run a l
  | Max l            -> Max.run a l
  | Average l        -> Average.run a l


let to_string = function
  | Input l          -> Input.to_string l
  | Linear l         -> Linear.to_string l
  | LinearNoBias l   -> LinearNoBias.to_string l
  | LSTM l           -> LSTM.to_string l
  | GRU l            -> GRU.to_string l
  | Recurrent l      -> Recurrent.to_string l
  | Conv1D l         -> Conv1D.to_string l
  | Conv2D l         -> Conv2D.to_string l
  | Conv3D l         -> Conv3D.to_string l
  | FullyConnected l -> FullyConnected.to_string l
  | MaxPool1D l      -> MaxPool1D.to_string l
  | MaxPool2D l      -> MaxPool2D.to_string l
  | AvgPool1D l      -> AvgPool1D.to_string l
  | AvgPool2D l      -> AvgPool2D.to_string l
  | Dropout l        -> Dropout.to_string l
  | Reshape l        -> Reshape.to_string l
  | Flatten l        -> Flatten.to_string l
  | Lambda l         -> Lambda.to_string l
  | Activation l     -> Activation.to_string l
  | Add l            -> Add.to_string l
  | Mul l            -> Mul.to_string l
  | Dot l            -> Dot.to_string l
  | Max l            -> Max.to_string l
  | Average l        -> Average.to_string l


let to_name = function
  | Input _          -> Input.to_name ()
  | Linear _         -> Linear.to_name ()
  | LinearNoBias _   -> LinearNoBias.to_name ()
  | LSTM _           -> LSTM.to_name ()
  | GRU _            -> GRU.to_name ()
  | Recurrent _      -> Recurrent.to_name ()
  | Conv1D _         -> Conv1D.to_name ()
  | Conv2D _         -> Conv2D.to_name ()
  | Conv3D _         -> Conv3D.to_name ()
  | FullyConnected _ -> FullyConnected.to_name ()
  | MaxPool1D _      -> MaxPool1D.to_name ()
  | MaxPool2D _      -> MaxPool2D.to_name ()
  | AvgPool1D _      -> AvgPool1D.to_name ()
  | AvgPool2D _      -> AvgPool2D.to_name ()
  | Dropout _        -> Dropout.to_name ()
  | Reshape _        -> Reshape.to_name ()
  | Flatten _        -> Flatten.to_name ()
  | Lambda _         -> Lambda.to_name ()
  | Activation _     -> Activation.to_name ()
  | Add _            -> Add.to_name ()
  | Mul _            -> Mul.to_name ()
  | Dot _            -> Dot.to_name ()
  | Max _            -> Max.to_name ()
  | Average _        -> Average.to_name ()



(* ends here *)
