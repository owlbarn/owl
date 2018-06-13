(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Neural network: Neuron definitions *)

open Owl_types


(* Make functor starts *)

module Make
  (A : Ndarray_Algodiff)
  = struct

  include Owl_algodiff_generic.Make (A)


  (* module for initialising weight matrix *)
  module Init = struct

    type typ =
      | Uniform  of float * float
      | Gaussian of float * float
      | Standard
      | Tanh
      | GlorotNormal
      | GlorotUniform
      | LecunNormal
      | Custom   of (int array -> t)

    let calc_fans s =
      let _prod x = Array.fold_left (fun p q -> p * q) 1 x in
      let l = Array.length s in
      let fan_in, fan_out =
        (* for matrices *)
        if l = 2 then
          float_of_int s.(0), float_of_int s.(1)
        (* for convolution kernels 1d, 2d, 3d *)
        else if l > 2 && l < 6 then (
          let s' = Array.sub s 0 (l - 2) in
          let receptive = _prod s' in
          let i = s.(l - 2) * receptive |> float_of_int in
          let o = s.(l - 1) * receptive |> float_of_int in
          i, o
        )
        (* for no specific assumptions *)
        else (
          let i_o = _prod s |> float_of_int |> Pervasives.sqrt in
          i_o, i_o
        )
      in
      fan_in, fan_out

    let run t s x =
      let fan_in, fan_out = calc_fans s in
      let r0 = sqrt (1. /. fan_in) in
      let r1 = sqrt (6. /. (fan_in +. fan_out)) in
      let r2 = sqrt (2. /. (fan_in +. fan_out)) in
      match x with
      | Arr _ -> (
          match t with
          | Uniform (a, b)       -> Arr.(uniform ~a:(A.float_to_elt a) ~b:(A.float_to_elt b) s)
          | Gaussian (mu, sigma) -> Arr.(gaussian ~mu:(A.float_to_elt mu) ~sigma:(A.float_to_elt sigma) s)
          | Standard             -> Arr.(uniform ~a:(A.float_to_elt (-.r0)) ~b:(A.float_to_elt r0) s)
          | Tanh                 -> Arr.(uniform ~a:(A.float_to_elt (-.r1)) ~b:(A.float_to_elt r1) s)
          | GlorotUniform        -> Arr.(uniform ~a:(A.float_to_elt (-.r1)) ~b:(A.float_to_elt r1) s)
          | GlorotNormal         -> Arr.(gaussian ~sigma:(A.float_to_elt r2) s)
          | LecunNormal          -> Arr.(gaussian ~sigma:(A.float_to_elt r0) s)
          | Custom f             -> f s
        )
      | _     -> failwith "Owl_neural:init:run"

    let to_string = function
      | Uniform (a, b)  -> Printf.sprintf "uniform (%g, %g)" a b
      | Gaussian (a, b) -> Printf.sprintf "gaussian (%g, %g)" a b
      | Standard        -> Printf.sprintf "standard"
      | Tanh            -> Printf.sprintf "tanh"
      | GlorotUniform   -> Printf.sprintf "glorot_uniform"
      | GlorotNormal    -> Printf.sprintf "glorot_normal"
      | LecunNormal     -> Printf.sprintf "lecun_normal"
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

    let copy l = create l.in_shape

    let run x l =
      (* check the input shape, a bit overhead but worth it *)
      let check_shape = function
        | Arr _ -> (
            let in_shape = Arr.shape x in
            let in_shape = Array.(sub in_shape 1 (length in_shape - 1)) in
            assert (in_shape = l.in_shape)
          )
        | _     -> failwith "Owl_neural:Input:run:check_shape"
      in
      check_shape (primal x); x

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      Printf.sprintf "    Input : in/out:[*,%s]\n" in_str

    let to_name () = "input"

  end


  (* module for various activation functions *)
  module Activation = struct

    type typ =
      | Elu                 (* Exponential linear unit *)
      | Relu                (* Rectified linear unit *)
      | Sigmoid             (* Element-wise sigmoid *)
      | HardSigmoid         (* Linear approximation of sigmoid *)
      | Softmax of int      (* Softmax along specified axis *)
      | Softplus            (* Element-wise softplus *)
      | Softsign            (* Element-wise softsign *)
      | Tanh                (* Element-wise tanh *)
      | Relu6               (* Element-wise relu6 *)
      | LeakyRelu of float  (* Leaky version of a Rectified Linear Unit *)
      | TRelu of float      (* Thresholded Rectified Linear Unit *)
      | Custom of (t -> t)  (* Element-wise customised activation *)
      | None                (* None activation *)

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
      | Elu         -> Maths.((relu x) + (x |> neg |> relu |> neg |> exp) - _f 1.)
      | Relu        -> Maths.relu x
      | Sigmoid     -> Maths.sigmoid x
      | HardSigmoid -> Maths.(max2 (_f 0.) (min2 (_f 1.) ((_f 0.2) * x + (_f 0.5))))
      | Softmax a   -> Maths.softmax ~axis:a x
      | Softplus    -> Maths.softplus x
      | Softsign    -> Maths.softsign x
      | Tanh        -> Maths.tanh x
      | Relu6       -> Maths.(min2 (relu x) (_f 6.))
      | LeakyRelu a -> Maths.((relu x) - (_f a) * (x |> neg |> relu))
      | TRelu a     -> Maths.(relu (x - _f a))
      | Custom f    -> f x
      | None        -> x

    let copy l = create l.activation

    let run x l = run_activation x l.activation

    let activation_to_string = function
      | Elu         -> Printf.sprintf "%s" "elu"
      | Relu        -> Printf.sprintf "%s" "relu"
      | Sigmoid     -> Printf.sprintf "%s" "sigmoid"
      | HardSigmoid -> Printf.sprintf "%s" "hard_sigmoid"
      | Softmax a   -> Printf.sprintf "%s %i" "softmax" a
      | Softplus    -> Printf.sprintf "%s" "softplus"
      | Softsign    -> Printf.sprintf "%s" "softsign"
      | Tanh        -> Printf.sprintf "%s" "tanh"
      | Relu6       -> Printf.sprintf "%s" "relu6"
      | LeakyRelu a -> Printf.sprintf "%s %g" "leaky_relu" a
      | TRelu a     -> Printf.sprintf "%s %g" "threshold_relu" a
      | Custom _    -> Printf.sprintf "%s" "customise"
      | None        -> Printf.sprintf "%s" "none"

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
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
      l.w <- Init.run l.init_typ [|m; n|] l.w;
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

    let copy l =
      let l' = create l.out_shape.(0) l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

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
      l.w <- Init.run l.init_typ [|m;n|] l.w

    let reset l = Mat.reset l.w

    let mktag t l = l.w <- make_reverse l.w t

    let mkpar l = [|l.w|]

    let mkpri l = [|primal l.w|]

    let mkadj l = [|adjval l.w|]

    let update l u = l.w <- u.(0) |> primal'

    let copy l =
      let l' = create l.out_shape.(0) l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

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

    let create ?time_steps ?inputs hiddens o act init_typ =
      let i = match inputs with Some i -> i | None -> 0 in
      let t = match time_steps with Some i -> i | None -> 0 in
      let h = hiddens in
      {
        whh       = Mat.empty h h;
        wxh       = Mat.empty 0 h;
        why       = Mat.empty h o;
        bh        = Mat.empty 1 h;
        by        = Mat.empty 1 o;
        h         = Mat.empty 0 h;
        hiddens   = hiddens;
        act       = act;
        init_typ  = init_typ;
        in_shape  = [|t;i|];
        out_shape = [|o|];
      }

    let connect out_shape l =
      assert Array.(length out_shape = length l.in_shape);
      l.in_shape.(0) <- out_shape.(0);
      l.in_shape.(1) <- out_shape.(1)

    let init l =
      let i = l.in_shape.(1) in
      let o = l.out_shape.(0) in
      let h = l.hiddens in
      l.whh <- Init.run l.init_typ [|h;h|] l.whh;
      l.wxh <- Init.run l.init_typ [|i;h|] l.wxh;
      l.why <- Init.run l.init_typ [|h;o|] l.why;
      l.bh  <- Mat.zeros 1 h;
      l.by  <- Mat.zeros 1 o

    let reset l =
      Mat.reset l.whh;
      Mat.reset l.wxh;
      Mat.reset l.why;
      Mat.reset l.bh;
      Mat.reset l.by

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

    let copy l =
      let l' = create l.hiddens l.out_shape.(0) l.act l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l =
      let s = shape x in
      l.h <- Mat.zeros s.(0) l.hiddens;
      let act x = Activation.run_activation x l.act in
      for i = 0 to l.in_shape.(0) - 1 do
        let t = Maths.get_slice [[];[i];[]] x in
        let t = Maths.reshape t [|s.(0);s.(2)|] in
        (* recurrent logic, calculate the hidden state *)
        l.h <- act Maths.((l.h *@ l.whh) + (t *@ l.wxh) + l.bh);
      done;
      Maths.((l.h *@ l.why) + l.by)

    let to_string l =
      let t = l.in_shape.(0) in
      let i = l.in_shape.(1) in
      let o = l.out_shape.(0) in
      let h = l.hiddens in
      Printf.sprintf "    Recurrent : matrix in:(*,%i,%i) out:(*,%i) \n" t i o ^
      Printf.sprintf "    init      : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    params    : %i\n" (h*h + i*h + h*o + h + o) ^
      Printf.sprintf "    whh       : %i x %i\n" h h ^
      Printf.sprintf "    wxh       : %i x %i\n" i h ^
      Printf.sprintf "    why       : %i x %i\n" h o ^
      Printf.sprintf "    bh        : %i x %i\n" 1 h ^
      Printf.sprintf "    by        : %i x %i\n" 1 o ^
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

    let create ?time_steps ?inputs o init_typ  =
      let i = match inputs with Some i -> i | None -> 0 in
      let t = match time_steps with Some i -> i | None -> 0 in
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
        c   = Mat.empty 0 o;
        h   = Mat.empty 0 o;
        init_typ  = init_typ;
        in_shape  = [|t;i|];
        out_shape = [|o|];
      }

    let connect out_shape l =
      assert Array.(length out_shape = length l.in_shape);
      l.in_shape.(0) <- out_shape.(0);
      l.in_shape.(1) <- out_shape.(1)

    let init l =
      let i = l.in_shape.(1) in
      let o = l.out_shape.(0) in
      l.wxi <- Init.run l.init_typ [|i;o|] l.wxi;
      l.whi <- Init.run l.init_typ [|o;o|] l.whi;
      l.wxc <- Init.run l.init_typ [|i;o|] l.wxc;
      l.whc <- Init.run l.init_typ [|o;o|] l.whc;
      l.wxf <- Init.run l.init_typ [|i;o|] l.wxf;
      l.whf <- Init.run l.init_typ [|o;o|] l.whf;
      l.wxo <- Init.run l.init_typ [|i;o|] l.wxo;
      l.who <- Init.run l.init_typ [|o;o|] l.who;
      l.bi  <- Mat.zeros 1 o;
      l.bc  <- Mat.zeros 1 o;
      l.bf  <- Mat.zeros 1 o;
      l.bo  <- Mat.zeros 1 o

    let reset l =
      Mat.reset l.wxi;
      Mat.reset l.whi;
      Mat.reset l.wxc;
      Mat.reset l.whc;
      Mat.reset l.wxf;
      Mat.reset l.whf;
      Mat.reset l.wxo;
      Mat.reset l.who;
      Mat.reset l.bi;
      Mat.reset l.bc;
      Mat.reset l.bf;
      Mat.reset l.bo

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

    let copy l =
      let l' = create l.out_shape.(0) l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l =
      let s = shape x in
      l.h <- Mat.zeros s.(0) l.out_shape.(0);
      l.c <- Mat.zeros s.(0) l.out_shape.(0);
      for i = 0 to l.in_shape.(0) - 1 do
        let t = Maths.get_slice [[];[i];[]] x in
        let t = Maths.reshape t [|s.(0);s.(2)|] in
        (* lstm logic, calculate the output *)
        let i  = Maths.(((t *@ l.wxi) + (l.h *@ l.whi) + l.bi) |> sigmoid) in
        let c' = Maths.(((t *@ l.wxc) + (l.h *@ l.whc) + l.bc) |> tanh) in
        let f  = Maths.(((t *@ l.wxf) + (l.h *@ l.whf) + l.bf) |> sigmoid) in
        l.c <- Maths.((i * c') + (f * l.c));
        let o  = Maths.(((t *@ l.wxo) + (l.h *@ l.who) + l.bo) |> sigmoid) in
        l.h <- Maths.(o * (tanh l.c))
      done;
      l.h

    let to_string l =
      let t = l.in_shape.(0) in
      let i = l.in_shape.(1) in
      let o = l.out_shape.(0) in
      Printf.sprintf "    LSTM   : in:(*,%i,%i) out:(*,%i) \n" i t o ^
      Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    params : %i\n" (i*o + o*o + i*o + o*o + i*o + o*o + i*o + o*o + o + o + o + o) ^
      Printf.sprintf "    wxi    : %i x %i\n" i o ^
      Printf.sprintf "    whi    : %i x %i\n" o o ^
      Printf.sprintf "    wxc    : %i x %i\n" i o ^
      Printf.sprintf "    whc    : %i x %i\n" o o ^
      Printf.sprintf "    wxf    : %i x %i\n" i o ^
      Printf.sprintf "    whf    : %i x %i\n" o o ^
      Printf.sprintf "    wxo    : %i x %i\n" i o ^
      Printf.sprintf "    who    : %i x %i\n" o o ^
      Printf.sprintf "    bi     : %i x %i\n" 1 o ^
      Printf.sprintf "    bc     : %i x %i\n" 1 o ^
      Printf.sprintf "    bf     : %i x %i\n" 1 o ^
      Printf.sprintf "    bo     : %i x %i\n" 1 o ^
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

    let create ?time_steps ?inputs o init_typ =
      let i = match inputs with Some i -> i | None -> 0 in
      let t = match time_steps with Some i -> i | None -> 0 in
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
        h   = Mat.empty 0 o;
        init_typ  = init_typ;
        in_shape  = [|t;i|];
        out_shape = [|o|];
      }

    let connect out_shape l =
      assert Array.(length out_shape = length l.in_shape);
      l.in_shape.(0) <- out_shape.(0);
      l.in_shape.(1) <- out_shape.(1)

    let init l =
      let i = l.in_shape.(1) in
      let o = l.out_shape.(0) in
      l.wxz <- Init.run l.init_typ [|i;o|] l.wxz;
      l.whz <- Init.run l.init_typ [|o;o|] l.whz;
      l.wxr <- Init.run l.init_typ [|i;o|] l.wxr;
      l.whr <- Init.run l.init_typ [|o;o|] l.whr;
      l.wxh <- Init.run l.init_typ [|i;o|] l.wxh;
      l.whh <- Init.run l.init_typ [|o;o|] l.whh;
      l.bz  <- Mat.zeros 1 o;
      l.br  <- Mat.zeros 1 o;
      l.bh  <- Mat.zeros 1 o

    let reset l =
      Mat.reset l.wxz;
      Mat.reset l.whz;
      Mat.reset l.wxr;
      Mat.reset l.whr;
      Mat.reset l.wxh;
      Mat.reset l.whh;
      Mat.reset l.bz;
      Mat.reset l.br;
      Mat.reset l.bh

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

    let copy l =
      let l' = create l.out_shape.(0) l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l =
      let s = shape x in
      l.h <- Mat.zeros s.(0) l.out_shape.(0);
      for i = 0 to l.in_shape.(0) - 1 do
        let t = Maths.get_slice [[];[i];[]] x in
        let t = Maths.reshape t [|s.(0);s.(2)|] in
        (* gru logic, calculate the output *)
        let z  = Maths.(((t *@ l.wxz) + (l.h *@ l.whz) + l.bz) |> sigmoid) in
        let r  = Maths.(((t *@ l.wxr) + (l.h *@ l.whr) + l.br) |> sigmoid) in
        let h' = Maths.(((t *@ l.wxh) + ((l.h * r) *@ l.whh))  |> tanh) in
        l.h <- Maths.((_f 1. - z) * h' + (z * l.h));
      done;
      l.h

    let to_string l =
      let t = l.in_shape.(0) in
      let i = l.in_shape.(1) in
      let o = l.out_shape.(0) in
      Printf.sprintf "    GRU    : matrix in:(*,%i,%i) out:(*,%i) \n" t i o ^
      Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    params : %i\n" (i*o + o*o + i*o + o*o + i*o + o*o + o + o + o) ^
      Printf.sprintf "    wxz    : %i x %i\n" i o ^
      Printf.sprintf "    whz    : %i x %i\n" o o ^
      Printf.sprintf "    wxr    : %i x %i\n" i o ^
      Printf.sprintf "    whr    : %i x %i\n" o o ^
      Printf.sprintf "    wxh    : %i x %i\n" i o ^
      Printf.sprintf "    whh    : %i x %i\n" o o ^
      Printf.sprintf "    bz     : %i x %i\n" 1 o ^
      Printf.sprintf "    br     : %i x %i\n" 1 o ^
      Printf.sprintf "    bh     : %i x %i\n" 1 o ^
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

    let create ?inputs padding kernel stride init_typ =
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
        init_typ  = init_typ;
        in_shape  = in_shape;
        out_shape = [|0;o|];
      }

    let connect out_shape l =
      assert Array.(length out_shape = length l.in_shape);
      assert (out_shape.(1) = l.in_shape.(1));
      l.in_shape.(0) <- out_shape.(0);
      let out_cols =
        Owl_utils.calc_conv1d_output_shape
        l.padding l.in_shape.(0) l.kernel.(0) l.stride.(0)
      in
      l.out_shape.(0) <- out_cols

    let init l =
      l.w <- Init.run l.init_typ l.kernel l.w;
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

    let copy l =
      let l' = create l.padding l.kernel l.stride l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l = Maths.((conv1d ~padding:l.padding x l.w l.stride) + l.b)

    let to_string l =
      let ws = Arr.shape l.w in
      let bn = Arr.shape l.b in
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    Conv1D : tensor in:[*;%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    params : %i\n" (ws.(0)*ws.(1)*ws.(2) + bn.(0)) ^
      Printf.sprintf "    kernel : %i x %i x %i\n" ws.(0) ws.(1) ws.(2) ^
      Printf.sprintf "    b      : %i\n" bn.(0) ^
      Printf.sprintf "    stride : [%i]\n" l.stride.(0) ^
      ""

    let to_name () = "conv1d"

  end


  (* definition of TransposeConv1D neuron *)
  module TransposeConv1D = struct

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

    let create ?inputs padding kernel stride init_typ =
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
        init_typ  = init_typ;
        in_shape  = in_shape;
        out_shape = [|0;o|];
      }

    let connect out_shape l =
      assert Array.(length out_shape = length l.in_shape);
      assert (out_shape.(1) = l.in_shape.(1));
      l.in_shape.(0) <- out_shape.(0);
      let out_cols =
        Owl_utils.calc_transpose_conv1d_output_shape
        l.padding l.in_shape.(0) l.kernel.(0) l.stride.(0)
      in
      l.out_shape.(0) <- out_cols

    let init l =
      l.w <- Init.run l.init_typ l.kernel l.w;
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

    let copy l =
      let l' = create l.padding l.kernel l.stride l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l = Maths.((transpose_conv1d ~padding:l.padding x l.w l.stride) + l.b)

    let to_string l =
      let ws = Arr.shape l.w in
      let bn = Arr.shape l.b in
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    TransposeConv1D : tensor in:[*;%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    params : %i\n" (ws.(0)*ws.(1)*ws.(2) + bn.(0)) ^
      Printf.sprintf "    kernel : %i x %i x %i\n" ws.(0) ws.(1) ws.(2) ^
      Printf.sprintf "    b      : %i\n" bn.(0) ^
      Printf.sprintf "    stride : [%i]\n" l.stride.(0) ^
      ""

    let to_name () = "transpose_conv1d"

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

    let create ?inputs padding kernel stride init_typ =
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
        init_typ  = init_typ;
        in_shape  = in_shape;
        out_shape = [|0;0;o|];
      }

    let connect out_shape l =
      assert Array.(length out_shape = length l.in_shape);
      assert (out_shape.(2) = l.in_shape.(2));
      l.in_shape.(0) <- out_shape.(0);
      l.in_shape.(1) <- out_shape.(1);
      let out_cols, out_rows =
        Owl_utils.calc_conv2d_output_shape
        l.padding l.in_shape.(0) l.in_shape.(1) l.kernel.(0) l.kernel.(1)
        l.stride.(0) l.stride.(1)
      in
      l.out_shape.(0) <- out_cols;
      l.out_shape.(1) <- out_rows

    let init l =
      l.w <- Init.run l.init_typ l.kernel l.w;
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

    let copy l =
      let l' = create l.padding l.kernel l.stride l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l = Maths.((conv2d ~padding:l.padding x l.w l.stride) + l.b)

    let to_string l =
      let ws = Arr.shape l.w in
      let bn = Arr.shape l.b in
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    Conv2D : tensor in:[*;%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    params : %i\n" (ws.(0)*ws.(1)*ws.(2)*ws.(3) + bn.(0)) ^
      Printf.sprintf "    kernel : %i x %i x %i x %i\n" ws.(0) ws.(1) ws.(2) ws.(3) ^
      Printf.sprintf "    b      : %i\n" bn.(0) ^
      Printf.sprintf "    stride : [%i; %i]\n" l.stride.(0) l.stride.(1) ^
      ""

    let to_name () = "conv2d"

  end


  (* definition of TransposeConv2D neuron *)
  module TransposeConv2D = struct

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

    let create ?inputs padding kernel stride init_typ =
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
        init_typ  = init_typ;
        in_shape  = in_shape;
        out_shape = [|0;0;o|];
      }

    let connect out_shape l =
      assert Array.(length out_shape = length l.in_shape);
      assert (out_shape.(2) = l.in_shape.(2));
      l.in_shape.(0) <- out_shape.(0);
      l.in_shape.(1) <- out_shape.(1);
      let out_cols, out_rows =
        Owl_utils.calc_transpose_conv2d_output_shape
        l.padding l.in_shape.(0) l.in_shape.(1) l.kernel.(0) l.kernel.(1)
        l.stride.(0) l.stride.(1)
      in
      l.out_shape.(0) <- out_cols;
      l.out_shape.(1) <- out_rows

    let init l =
      l.w <- Init.run l.init_typ l.kernel l.w;
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

    let copy l =
      let l' = create l.padding l.kernel l.stride l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l = Maths.((transpose_conv2d ~padding:l.padding x l.w l.stride) + l.b)

    let to_string l =
      let ws = Arr.shape l.w in
      let bn = Arr.shape l.b in
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    TransposeConv2D : tensor in:[*;%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    params : %i\n" (ws.(0)*ws.(1)*ws.(2)*ws.(3) + bn.(0)) ^
      Printf.sprintf "    kernel : %i x %i x %i x %i\n" ws.(0) ws.(1) ws.(2) ws.(3) ^
      Printf.sprintf "    b      : %i\n" bn.(0) ^
      Printf.sprintf "    stride : [%i; %i]\n" l.stride.(0) l.stride.(1) ^
      ""

    let to_name () = "transpose_conv2d"

  end


  (* definition of Conv3D neuron *)
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

    let create ?inputs padding kernel stride init_typ =
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
        init_typ  = init_typ;
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
        Owl_utils.calc_conv3d_output_shape
        l.padding l.in_shape.(0) l.in_shape.(1) l.in_shape.(2)
        l.kernel.(0) l.kernel.(1) l.kernel.(2)
        l.stride.(0) l.stride.(1) l.stride.(2)
      in
      l.out_shape.(0) <- out_cols;
      l.out_shape.(1) <- out_rows;
      l.out_shape.(2) <- out_dpts

    let init l =
      l.w <- Init.run l.init_typ l.kernel l.w;
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

    let copy l =
      let l' = create l.padding l.kernel l.stride l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l = Maths.((conv3d ~padding:l.padding x l.w l.stride) + l.b)

    let to_string l =
      let ws = Arr.shape l.w in
      let bn = Arr.shape l.b in
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    Conv3D : tensor in:[*;%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    params : %i\n" (ws.(0)*ws.(1)*ws.(2)*ws.(3)*ws.(4) + bn.(0)) ^
      Printf.sprintf "    kernel : %i x %i x %i x %i x %i\n" ws.(0) ws.(1) ws.(2) ws.(3)  ws.(4) ^
      Printf.sprintf "    b      : %i\n" bn.(0) ^
      Printf.sprintf "    stride : [%i; %i; %i]\n" l.stride.(0) l.stride.(1) l.stride.(2) ^
      ""

    let to_name () = "conv3d"

  end


  (* definition of TransposeConv3D neuron *)
  module TransposeConv3D = struct

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

    let create ?inputs padding kernel stride init_typ =
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
        init_typ  = init_typ;
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
        Owl_utils.calc_transpose_conv3d_output_shape
        l.padding l.in_shape.(0) l.in_shape.(1) l.in_shape.(2)
        l.kernel.(0) l.kernel.(1) l.kernel.(2)
        l.stride.(0) l.stride.(1) l.stride.(2)
      in
      l.out_shape.(0) <- out_cols;
      l.out_shape.(1) <- out_rows;
      l.out_shape.(2) <- out_dpts

    let init l =
      l.w <- Init.run l.init_typ l.kernel l.w;
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

    let copy l =
      let l' = create l.padding l.kernel l.stride l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l = Maths.((transpose_conv3d ~padding:l.padding x l.w l.stride) + l.b)

    let to_string l =
      let ws = Arr.shape l.w in
      let bn = Arr.shape l.b in
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    TransposeConv3D : tensor in:[*;%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    init   : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    params : %i\n" (ws.(0)*ws.(1)*ws.(2)*ws.(3)*ws.(4) + bn.(0)) ^
      Printf.sprintf "    kernel : %i x %i x %i x %i x %i\n" ws.(0) ws.(1) ws.(2) ws.(3)  ws.(4) ^
      Printf.sprintf "    b      : %i\n" bn.(0) ^
      Printf.sprintf "    stride : [%i; %i; %i]\n" l.stride.(0) l.stride.(1) l.stride.(2) ^
      ""

    let to_name () = "transpose_conv3d"

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
      l.w <- Init.run l.init_typ [|m;n|] l.w;
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

    let copy l =
      let l' = create l.out_shape.(0) l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l =
      let m = Mat.row_num l.w in
      let n = Arr.numel x / m in
      let x = Maths.reshape x [|n;m|] in
      let y = Maths.((x *@ l.w) + l.b) in
      y

    let to_string l =
      let wm = Array.fold_left (fun a b -> a * b) 1 l.in_shape in
      let wn = l.out_shape.(0) in
      let bn = l.out_shape.(0) in
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
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
      let out_cols = Owl_utils.calc_conv1d_output_shape
        l.padding l.in_shape.(0) l.kernel.(0) l.stride.(0)
      in
      l.out_shape.(0) <- out_cols;
      l.out_shape.(1) <- out_shape.(1)

    let copy l = create l.padding l.kernel l.stride

    let run x l = Maths.(max_pool1d l.padding x l.kernel l.stride)

    let to_string l =
      let padding_s = match l.padding with
        | SAME  -> "SAME"
        | VALID -> "VALID"
      in
      Printf.sprintf "    MaxPool1D : tensor in:[*,%i,%i] out:[*,%i,%i]\n" l.in_shape.(0) l.in_shape.(1) l.out_shape.(0) l.out_shape.(1) ^
      Printf.sprintf "    padding   : %s\n" padding_s ^
      Printf.sprintf "    kernel    : [%i]\n" l.kernel.(0) ^
      Printf.sprintf "    stride    : [%i]\n" l.stride.(0) ^
      ""

    let to_name () = "maxpool1d"

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
      let out_cols, out_rows = Owl_utils.calc_conv2d_output_shape
        l.padding l.in_shape.(0) l.in_shape.(1) l.kernel.(0) l.kernel.(1) l.stride.(0) l.stride.(1)
      in
      l.out_shape.(0) <- out_cols;
      l.out_shape.(1) <- out_rows;
      l.out_shape.(2) <- out_shape.(2)

    let copy l = create l.padding l.kernel l.stride

    let run x l = Maths.(max_pool2d l.padding x l.kernel l.stride)

    let to_string l =
      let padding_s = match l.padding with
        | SAME  -> "SAME"
        | VALID -> "VALID"
      in
      Printf.sprintf "    MaxPool2D : tensor in:[*,%i,%i,%i] out:[*,%i,%i,%i]\n" l.in_shape.(0) l.in_shape.(1) l.in_shape.(2) l.out_shape.(0) l.out_shape.(1) l.out_shape.(2) ^
      Printf.sprintf "    padding   : %s\n" padding_s ^
      Printf.sprintf "    kernel    : [%i; %i]\n" l.kernel.(0) l.kernel.(1) ^
      Printf.sprintf "    stride    : [%i; %i]\n" l.stride.(0) l.stride.(1) ^
      ""

    let to_name () = "maxpool2d"

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
      let out_cols = Owl_utils.calc_conv1d_output_shape
        l.padding l.in_shape.(0) l.kernel.(0) l.stride.(0)
      in
      l.out_shape.(0) <- out_cols;
      l.out_shape.(1) <- out_shape.(1)

    let copy l = create l.padding l.kernel l.stride

    let run x l = Maths.(avg_pool1d l.padding x l.kernel l.stride)

    let to_string l =
      let padding_s = match l.padding with
        | SAME  -> "SAME"
        | VALID -> "VALID"
      in
      Printf.sprintf "    AvgPool1D : tensor in:[*,%i,%i] out:[*,%i,%i]\n" l.in_shape.(0) l.in_shape.(1) l.out_shape.(0) l.out_shape.(1) ^
      Printf.sprintf "    padding   : %s\n" padding_s ^
      Printf.sprintf "    kernel    : [%i]\n" l.kernel.(0) ^
      Printf.sprintf "    stride    : [%i]\n" l.stride.(0) ^
      ""

    let to_name () = "avgpool1d"

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
      let out_cols, out_rows = Owl_utils.calc_conv2d_output_shape
        l.padding l.in_shape.(0) l.in_shape.(1) l.kernel.(0) l.kernel.(1) l.stride.(0) l.stride.(1)
      in
      l.out_shape.(0) <- out_cols;
      l.out_shape.(1) <- out_rows;
      l.out_shape.(2) <- out_shape.(2)

    let copy l = create l.padding l.kernel l.stride

    let run x l = Maths.(avg_pool2d l.padding x l.kernel l.stride)

    let to_string l =
      let padding_s = match l.padding with
        | SAME  -> "SAME"
        | VALID -> "VALID"
      in
      Printf.sprintf "    AvgPool2D : tensor in:[*,%i,%i,%i] out:[*,%i,%i,%i]\n" l.in_shape.(0) l.in_shape.(1) l.in_shape.(2) l.out_shape.(0) l.out_shape.(1) l.out_shape.(2) ^
      Printf.sprintf "    padding   : %s\n" padding_s ^
      Printf.sprintf "    kernel    : [%i; %i]\n" l.kernel.(0) l.kernel.(1) ^
      Printf.sprintf "    stride    : [%i; %i]\n" l.stride.(0) l.stride.(1) ^
      ""

    let to_name () = "avgpool2d"

  end


  (* definition of GlobalMaxPool1D neuron *)
  module GlobalMaxPool1D = struct

    type neuron_typ = {
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create () = {
      in_shape  = [|0;0|];
      out_shape = [|0|];
    }

    let connect out_shape l =
      assert Array.(length out_shape = 2);
      l.in_shape.(0) <- out_shape.(0);
      l.in_shape.(1) <- out_shape.(1);
      l.out_shape.(0) <- out_shape.(1)

    let copy l = create ()

    let run x l =
      let kernel = [|l.in_shape.(0)|] in
      let a = Maths.max_pool1d VALID x kernel [|1|] in
      let s = Arr.shape a in
      let b, o = s.(0), s.(2) in
      Arr.reshape a [|b; o|]

    let to_string l =
      Printf.sprintf "    GlobalMaxPool1D : in:[*,%i,%i] out:[*,%i]\n" l.in_shape.(0) l.in_shape.(1) l.out_shape.(0) ^
      ""

    let to_name () = "global_maxpool1d"

  end


  (* definition of GlobalMaxPool2D neuron *)
  module GlobalMaxPool2D = struct

    type neuron_typ = {
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create () = {
      in_shape  = [|0;0;0|];
      out_shape = [|0|];
    }

    let connect out_shape l =
      assert Array.(length out_shape = 3);
      l.in_shape.(0) <- out_shape.(0);
      l.in_shape.(1) <- out_shape.(1);
      l.in_shape.(2) <- out_shape.(2);
      l.out_shape.(0) <- out_shape.(2)

    let copy l = create ()

    let run x l =
      let kernel = [|l.in_shape.(0); l.in_shape.(1)|] in
      let a = Maths.max_pool2d VALID x kernel [|1;1|] in
      let s = Arr.shape a in
      let b, o = s.(0), s.(3) in
      Arr.reshape a [|b; o|]

    let to_string l =
      Printf.sprintf "    GlobalMaxPool2D : in:[*,%i,%i,%i] out:[*,%i]\n" l.in_shape.(0) l.in_shape.(1) l.in_shape.(2) l.out_shape.(0) ^
      ""

    let to_name () = "global_maxpool2d"

  end


  (* definition of GlobalAvgPool1D neuron *)
  module GlobalAvgPool1D = struct

    type neuron_typ = {
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create () = {
      in_shape  = [|0;0|];
      out_shape = [|0|];
    }

    let connect out_shape l =
      assert Array.(length out_shape = 2);
      l.in_shape.(0) <- out_shape.(0);
      l.in_shape.(1) <- out_shape.(1);
      l.out_shape.(0) <- out_shape.(1)

    let copy l = create ()

    let run x l =
      let kernel = [|l.in_shape.(0)|] in
      let a = Maths.avg_pool1d VALID x kernel [|1|] in
      let s = Arr.shape a in
      let b, o = s.(0), s.(2) in
      Arr.reshape a [|b; o|]

    let to_string l =
      Printf.sprintf "    GlobalAvgPool1D : in:[*,%i,%i] out:[*,%i]\n" l.in_shape.(0) l.in_shape.(1) l.out_shape.(0) ^
      ""

    let to_name () = "global_avgpool1d"

  end


  (* definition of GlobalAvgPool2D neuron *)
  module GlobalAvgPool2D = struct

    type neuron_typ = {
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create () = {
      in_shape  = [|0;0;0|];
      out_shape = [|0|];
    }

    let connect out_shape l =
      assert Array.(length out_shape = 3);
      l.in_shape.(0) <- out_shape.(0);
      l.in_shape.(1) <- out_shape.(1);
      l.in_shape.(2) <- out_shape.(2);
      l.out_shape.(0) <- out_shape.(2)

    let copy l = create ()

    let run x l =
      let kernel = [|l.in_shape.(0); l.in_shape.(1)|] in
      let a = Maths.avg_pool2d VALID x kernel [|1;1|] in
      let s = Arr.shape a in
      let b, o = s.(0), s.(3) in
      Arr.reshape a [|b; o|]

    let to_string l =
      Printf.sprintf "    GlobalAvgPool2D : in:[*,%i,%i,%i] out:[*,%i]\n" l.in_shape.(0) l.in_shape.(1) l.in_shape.(2) l.out_shape.(0) ^
      ""

    let to_name () = "global_avgpool2d"

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

    let copy l = create l.lambda

    let run x l = l.lambda x

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
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

    let copy l = create l.rate

    let run x l =
      let a = _f (1. /. (1. -. l.rate)) in
      let b = Maths.(dropout ~rate:l.rate x) in
      Maths.(a * b)

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    Dropout : in:[*,%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    rate    : %g\n" l.rate

    let to_name () = "dropout"

  end


  (* definition of Reshape neuron *)
  module Reshape = struct

    type neuron_typ = {
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create ?inputs o =
      let in_shape = match inputs with
        | Some i -> i
        | None   -> [||]
      in
      {
        in_shape  = in_shape;
        out_shape = o;
      }

    let connect out_shape l =
      let m = Array.fold_left (fun a b -> a * b) 1 out_shape in
      let n = Array.fold_left (fun a b -> a * b) 1 l.out_shape in
      assert (m = n);
      l.in_shape <- Array.copy out_shape

    let copy l = create l.out_shape

    let run x l =
      let x_shape = shape x in
      let out_shape = Array.append [|x_shape.(0)|] l.out_shape in
      Maths.reshape x out_shape

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    Reshape : in:[*,%s] out:[*,%s]\n" in_str out_str

    let to_name () = "reshape"

  end


  (* definition of Flatten neuron *)
  module Flatten = struct

    type neuron_typ = {
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create () = {
        in_shape  = [||];
        out_shape = [||];
      }

    let connect out_shape l =
      let o = Array.fold_left (fun a b -> a * b) 1 out_shape in
      l.in_shape <- Array.copy out_shape;
      l.out_shape <- [|o|]

    let copy l = create ()

    let run x l = Maths.reshape x [|(shape x).(0); l.out_shape.(0)|]

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      Printf.sprintf "    Flatten : in:[*,%s] out:[*,%i]\n" in_str l.out_shape.(0)

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

    let connect out_shapes l =
      Array.iter (fun s -> assert (s = out_shapes.(0))) out_shapes;
      l.in_shape <- Array.copy out_shapes.(0);
      l.out_shape <- Array.copy out_shapes.(0)

    let copy l = create ()

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
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
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

    let connect out_shapes l =
      Array.iter (fun s -> assert (s = out_shapes.(0))) out_shapes;
      l.in_shape <- Array.copy out_shapes.(0);
      l.out_shape <- Array.copy out_shapes.(0)

    let copy l = create ()

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
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
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

    let connect out_shapes l =
      (* for dot neuron, two matrices must have [*,m][m,n] shape *)
      let m = out_shapes.(1).(0) in
      let n = out_shapes.(1).(1) in
      assert (m = out_shapes.(0).(1));
      l.in_shape <- [|m; n|];
      l.out_shape <- [|n|]

    let copy l = create ()

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

    let connect out_shapes l =
      Array.iter (fun s -> assert (s = out_shapes.(0))) out_shapes;
      l.in_shape <- Array.copy out_shapes.(0);
      l.out_shape <- Array.copy out_shapes.(0)

    let copy l = create ()

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
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
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

    let connect out_shapes l =
      Array.iter (fun s -> assert (s = out_shapes.(0))) out_shapes;
      l.in_shape <- Array.copy out_shapes.(0);
      l.out_shape <- Array.copy out_shapes.(0)

    let copy l = create ()

    let run x l =
      let n = Array.length x in
      (* at least two inputs *)
      assert (n > 1);
      let acc = ref x.(0) in
      for i = 1 to n - 1 do
        acc := Maths.(!acc + x.(i))
      done;
      Maths.(!acc / _f (float_of_int n))

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    Average : in:[*,%s] out:[*,%s]\n" in_str out_str

    let to_name () = "average"

  end


  (* definition of Concatenate neuron *)
  module Concatenate = struct

    type neuron_typ = {
      mutable axis      : int;
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create axis = {
      axis      = axis;
      in_shape  = [||];
      out_shape = [||];
    }

    let connect out_shapes l =
      let s0 = out_shapes.(0) in
      let _d = ref 0 in
      Array.iter (fun s1 ->
        Array.iteri (fun i d ->
          if (i + 1) <> l.axis then assert (d = s0.(i))
          else _d := !_d + d
        ) s1
      ) out_shapes;
      l.in_shape <- Array.copy s0;
      l.out_shape <- Array.copy s0;
      (* should not concatenate along batchs axis *)
      assert (l.axis > 0);
      l.in_shape.(l.axis - 1) <- (-1);
      l.out_shape.(l.axis - 1) <- !_d

    let copy l = create l.axis

    let run x l =
      let n = Array.length x in
      (* at least two inputs *)
      assert (n > 1);
      let acc = ref x.(0) in
      for i = 1 to n - 1 do
        acc := Maths.(concat l.axis !acc x.(i))
      done;
      !acc

    let to_string l =
      let in_str = Owl_utils_array.to_string (fun i ->
        if i = -1 then "*" else string_of_int i
      ) l.in_shape
      in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    Concatenate : in:[*,%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    axis : %i\n" l.axis ^
      ""

    let to_name () = "concatenate"

  end


  (* definition of Batch Normalisation neuron *)
  module Normalisation = struct

    type neuron_typ = {
      mutable axis      : int;
      mutable beta      : t;
      mutable gamma     : t;
      mutable mu        : t;
      mutable var       : t;
      mutable decay     : t;
      mutable training  : bool;
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create ?(training=true) ?(decay=0.99) ?mu ?var axis = {
      axis      = axis;
      beta      = Arr.empty [|0|];
      gamma     = Arr.empty [|0|];
      mu        = (match mu with Some a -> Arr a | None -> Arr.empty [|0|]);
      var       = (match var with Some a -> Arr a | None -> Arr.empty [|0|]);
      decay     = _f decay;
      training  = training;
      in_shape  = [||];
      out_shape = [||];
    }

    let connect out_shape l =
      if l.axis < 0 then l.axis <- Array.(length out_shape + l.axis + 1);
      l.in_shape <- Array.copy out_shape;
      l.out_shape <- Array.copy out_shape

    let init l =
      let s = Array.(make (length l.in_shape + 1) 1) in
      s.(l.axis) <- l.in_shape.(l.axis - 1);
      l.beta <- Arr.zeros s;
      l.gamma <- Arr.ones s;
      l.mu <- Arr.zeros s;
      l.var <- Arr.ones s

    let reset l =
      Arr.reset l.beta;
      Arr.reset l.gamma

    let mktag t l =
      l.beta <- make_reverse l.beta t;
      l.gamma <- make_reverse l.gamma t

    let mkpar l = [|l.beta; l.gamma|]

    let mkpri l = [|primal l.beta; primal l.gamma|]

    let mkadj l = [|adjval l.beta; adjval l.gamma|]

    let update l u =
      l.beta <- u.(0) |> primal';
      l.gamma <- u.(1) |> primal'

    let copy l =
      let l' = create ~training:l.training ~decay:(unpack_flt l.decay) ~mu:(unpack_arr l.mu) ~var:(unpack_arr l.var) l.axis in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    (* Reference: https://arxiv.org/abs/1502.03167.
       Implementaton in Keras: https://bit.ly/2vBsvgI.*)
    let run x l =
      if l.training = true then (
        let a = _f (float_of_int ((numel x) / (shape x).(l.axis))) in
        let s = Owl_utils_array.(range 0 (length l.in_shape)
          |> filter (fun x -> x != l.axis)) in
        let mu' = Maths.((sum_reduce ~axis:s x) / a) in
        let var' = Maths.((sum_reduce ~axis:s ((x - mu') * (x - mu'))) / a) in
        l.mu <- Maths.(l.decay * l.mu + (_f 1. - l.decay) * mu') |> primal';
        l.var <- Maths.(l.decay * l.var + (_f 1. - l.decay) * var') |> primal';
      );
      let x' = Maths.((x - l.mu) / sqrt (l.var + _f 1e-8)) in
      Maths.(x' * l.gamma + l.beta)

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      let s = Array.(make (length l.in_shape + 1) 1) in s.(l.axis) <- l.in_shape.(l.axis - 1);
      let s_str = Owl_utils_array.to_string string_of_int s in
      Printf.sprintf "    Normalisation : in:[*,%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    training      : %b\n" l.training ^
      Printf.sprintf "    axis          : %i\n" l.axis ^
      Printf.sprintf "    decay         : %g\n" (unpack_flt l.decay) ^
      Printf.sprintf "    params        : %i\n" (l.in_shape.(l.axis - 1) * 2) ^
      Printf.sprintf "    beta          : [%s]\n" s_str ^
      Printf.sprintf "    gamma         : [%s]\n" s_str

    let to_name () = "normalisation"

  end


  (* definition of GaussianNoise neuron *)
  module GaussianNoise = struct

    type neuron_typ = {
      mutable sigma     : float;
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create sigma = {
      sigma;
      in_shape  = [||];
      out_shape = [||];
    }

    let connect out_shape l =
      l.in_shape <- Array.copy out_shape;
      l.out_shape <- Array.copy out_shape

    let copy l = create l.sigma

    let run x l =
      let s = shape x in
      let a = match (primal' x) with
        | Arr _ -> Arr.gaussian ~sigma:(A.float_to_elt l.sigma) s
        | _     -> failwith "owl_neural_neuron:gaussiannoise:run"
      in
      Maths.(x + a)

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    GaussianNoise : in:[*,%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    sigma         : %g\n" l.sigma

    let to_name () = "gaussian_noise"

  end


  (* definition of GaussianDropout neuron *)
  module GaussianDropout = struct

    type neuron_typ = {
      mutable rate      : float;
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create rate = {
      rate      = rate;
      in_shape  = [||];
      out_shape = [||];
    }

    let connect out_shape l =
      l.in_shape <- Array.copy out_shape;
      l.out_shape <- Array.copy out_shape

    let copy l = create l.rate

    let run x l =
      let s = shape x in
      let sigma = Pervasives.sqrt (l.rate /. (1. -. l.rate)) in
      let a = match (primal' x) with
        | Arr _ -> Arr.gaussian ~sigma:(A.float_to_elt sigma) s
        | _     -> failwith "owl_neural_neuron:gaussiandropout:run"
      in
      Maths.(x * (a + _f 1.))

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    GaussianDropout : in:[*,%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    rate            : %g\n" l.rate

    let to_name () = "gaussian_dropout"

  end


  (* definition of AlphaDropout neuron *)
  module AlphaDropout = struct

    type neuron_typ = {
      mutable rate      : float;
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create rate = {
      rate      = rate;
      in_shape  = [||];
      out_shape = [||];
    }

    let connect out_shape l =
      l.in_shape <- Array.copy out_shape;
      l.out_shape <- Array.copy out_shape

    let copy l = create l.rate

    let run x l =
      (* parameters of affine transformation *)
      let alpha = 1.6732632423543772848170429916717 in
      let scale = 1.0507009873554804934193349852946 in
      let p = (-.alpha) *. scale in
      let a = ((1. -. l.rate) *. (1. +. l.rate *. p ** 2.)) ** (-0.5) in
      let b = (-.a) *. p *. l.rate in

      let s = shape x in
      let mask = match (primal' x) with
        | Arr _ -> Arr A.(bernoulli ~p:(1. -. l.rate) s)
        | _     -> failwith "owl_neural_neuron:alphadropout:run"
      in

      let p = _f p in
      let a = _f a in
      let b = _f b in
      let x = Maths.(x * mask + p * (_f 1. - mask)) in
      Maths.(a * x + b)

    let to_string l =
      let in_str = Owl_utils_array.to_string string_of_int l.in_shape in
      let out_str = Owl_utils_array.to_string string_of_int l.out_shape in
      Printf.sprintf "    AlphaDropout : in:[*,%s] out:[*,%s]\n" in_str out_str ^
      Printf.sprintf "    rate         : %g\n" l.rate

    let to_name () = "alpha_dropout"

  end


  (* definition of Embedding neuron *)
  module Embedding = struct

    type neuron_typ = {
      mutable w         : t;
      mutable init_typ  : Init.typ;
      mutable in_dim    : int;
      mutable in_shape  : int array;
      mutable out_shape : int array;
    }

    let create ?inputs in_dim out_dim init_typ =
      let i = match inputs with Some i -> i | None -> 0 in
      {
        w         = Mat.empty 0 0;
        init_typ  = init_typ;
        in_dim    = in_dim;
        in_shape  = [|i|];
        out_shape = [|i;out_dim|];
      }

    let connect out_shape l =
      assert Array.(length out_shape = 1);
      l.in_shape.(0) <- out_shape.(0);
      l.out_shape.(0) <- out_shape.(0)

    let init l =
      let m = l.in_dim in
      let n = l.out_shape.(1) in
      l.w <- Init.run l.init_typ [|m;n|] l.w

    let reset l = Mat.reset l.w

    let mktag t l = l.w <- make_reverse l.w t

    let mkpar l = [|l.w|]

    let mkpri l = [|primal l.w|]

    let mkadj l = [|adjval l.w|]

    let update l u = l.w <- u.(0) |> primal'

    let copy l =
      let l' = create l.in_dim l.out_shape.(1) l.init_typ in
      mkpri l |> Array.map copy_primal' |> update l';
      l'

    let run x l =
      let x = primal' x |> unpack_arr in
      let s = A.shape x in
      let m, n = s.(0), s.(1) in
      let y = A.one_hot l.in_dim (A.reshape x [|m * n|]) in
      let y = Maths.((Arr y) *@ l.w) in
      Maths.reshape y [|m; n; l.out_shape.(1)|]

    let to_string l =
      let wm, wn = l.in_dim, l.out_shape.(1) in
      Printf.sprintf "    Embedding : matrix in:(*,%i) out:(*,%i,%i) \n" l.in_shape.(0) l.out_shape.(0) l.out_shape.(1) ^
      Printf.sprintf "    init      : %s\n" (Init.to_string l.init_typ) ^
      Printf.sprintf "    in_dim    : %i\n" l.in_dim ^
      Printf.sprintf "    params    : %i\n" (wm * wn) ^
      Printf.sprintf "    w         : %i x %i\n" wm wn ^
      ""

    let to_name () = "embedding"

  end


  (* TODO: definition of Masking neuron *)
  module Masking = struct

  end


  (* type definition and basic functions of neurons *)

  type neuron =
    | Input           of Input.neuron_typ
    | Linear          of Linear.neuron_typ
    | LinearNoBias    of LinearNoBias.neuron_typ
    | Embedding       of Embedding.neuron_typ
    | LSTM            of LSTM.neuron_typ
    | GRU             of GRU.neuron_typ
    | Recurrent       of Recurrent.neuron_typ
    | Conv1D          of Conv1D.neuron_typ
    | Conv2D          of Conv2D.neuron_typ
    | Conv3D          of Conv3D.neuron_typ
    | TransposeConv1D of TransposeConv1D.neuron_typ
    | TransposeConv2D of TransposeConv2D.neuron_typ
    | TransposeConv3D of TransposeConv3D.neuron_typ
    | FullyConnected  of FullyConnected.neuron_typ
    | MaxPool1D       of MaxPool1D.neuron_typ
    | MaxPool2D       of MaxPool2D.neuron_typ
    | AvgPool1D       of AvgPool1D.neuron_typ
    | AvgPool2D       of AvgPool2D.neuron_typ
    | GlobalMaxPool1D of GlobalMaxPool1D.neuron_typ
    | GlobalMaxPool2D of GlobalMaxPool2D.neuron_typ
    | GlobalAvgPool1D of GlobalAvgPool1D.neuron_typ
    | GlobalAvgPool2D of GlobalAvgPool2D.neuron_typ
    | Dropout         of Dropout.neuron_typ
    | Reshape         of Reshape.neuron_typ
    | Flatten         of Flatten.neuron_typ
    | Lambda          of Lambda.neuron_typ
    | Activation      of Activation.neuron_typ
    | GaussianNoise   of GaussianNoise.neuron_typ
    | GaussianDropout of GaussianDropout.neuron_typ
    | AlphaDropout    of AlphaDropout.neuron_typ
    | Normalisation   of Normalisation.neuron_typ
    | Add             of Add.neuron_typ
    | Mul             of Mul.neuron_typ
    | Dot             of Dot.neuron_typ
    | Max             of Max.neuron_typ
    | Average         of Average.neuron_typ
    | Concatenate     of Concatenate.neuron_typ


  let get_in_out_shape = function
    | Input l           -> Input.(l.in_shape, l.out_shape)
    | Linear l          -> Linear.(l.in_shape, l.out_shape)
    | LinearNoBias l    -> LinearNoBias.(l.in_shape, l.out_shape)
    | Embedding l       -> Embedding.(l.in_shape, l.out_shape)
    | LSTM l            -> LSTM.(l.in_shape, l.out_shape)
    | GRU l             -> GRU.(l.in_shape, l.out_shape)
    | Recurrent l       -> Recurrent.(l.in_shape, l.out_shape)
    | Conv1D l          -> Conv1D.(l.in_shape, l.out_shape)
    | Conv2D l          -> Conv2D.(l.in_shape, l.out_shape)
    | Conv3D l          -> Conv3D.(l.in_shape, l.out_shape)
    | TransposeConv1D l -> TransposeConv1D.(l.in_shape, l.out_shape)
    | TransposeConv2D l -> TransposeConv2D.(l.in_shape, l.out_shape)
    | TransposeConv3D l -> TransposeConv3D.(l.in_shape, l.out_shape)
    | FullyConnected l  -> FullyConnected.(l.in_shape, l.out_shape)
    | MaxPool1D l       -> MaxPool1D.(l.in_shape, l.out_shape)
    | MaxPool2D l       -> MaxPool2D.(l.in_shape, l.out_shape)
    | AvgPool1D l       -> AvgPool1D.(l.in_shape, l.out_shape)
    | AvgPool2D l       -> AvgPool2D.(l.in_shape, l.out_shape)
    | GlobalMaxPool1D l -> GlobalMaxPool1D.(l.in_shape, l.out_shape)
    | GlobalMaxPool2D l -> GlobalMaxPool2D.(l.in_shape, l.out_shape)
    | GlobalAvgPool1D l -> GlobalAvgPool1D.(l.in_shape, l.out_shape)
    | GlobalAvgPool2D l -> GlobalAvgPool2D.(l.in_shape, l.out_shape)
    | Dropout l         -> Dropout.(l.in_shape, l.out_shape)
    | Reshape l         -> Reshape.(l.in_shape, l.out_shape)
    | Flatten l         -> Flatten.(l.in_shape, l.out_shape)
    | Lambda l          -> Lambda.(l.in_shape, l.out_shape)
    | Activation l      -> Activation.(l.in_shape, l.out_shape)
    | GaussianNoise l   -> GaussianNoise.(l.in_shape, l.out_shape)
    | GaussianDropout l -> GaussianDropout.(l.in_shape, l.out_shape)
    | AlphaDropout l    -> AlphaDropout.(l.in_shape, l.out_shape)
    | Normalisation l   -> Normalisation.(l.in_shape, l.out_shape)
    | Add l             -> Add.(l.in_shape, l.out_shape)
    | Mul l             -> Mul.(l.in_shape, l.out_shape)
    | Dot l             -> Dot.(l.in_shape, l.out_shape)
    | Max l             -> Max.(l.in_shape, l.out_shape)
    | Average l         -> Average.(l.in_shape, l.out_shape)
    | Concatenate l     -> Concatenate.(l.in_shape, l.out_shape)


  let get_in_shape x = x |> get_in_out_shape |> fst


  let get_out_shape x = x |> get_in_out_shape |> snd


  let connect out_shapes l = match l with
    | Input l           -> () (* always the first neuron *)
    | Linear l          -> Linear.connect out_shapes.(0) l
    | LinearNoBias l    -> LinearNoBias.connect out_shapes.(0) l
    | Embedding l       -> Embedding.connect out_shapes.(0) l
    | LSTM l            -> LSTM.connect out_shapes.(0) l
    | GRU l             -> GRU.connect out_shapes.(0) l
    | Recurrent l       -> Recurrent.connect out_shapes.(0) l
    | Conv1D l          -> Conv1D.connect out_shapes.(0) l
    | Conv2D l          -> Conv2D.connect out_shapes.(0) l
    | Conv3D l          -> Conv3D.connect out_shapes.(0) l
    | TransposeConv1D l -> TransposeConv1D.connect out_shapes.(0) l
    | TransposeConv2D l -> TransposeConv2D.connect out_shapes.(0) l
    | TransposeConv3D l -> TransposeConv3D.connect out_shapes.(0) l
    | FullyConnected l  -> FullyConnected.connect out_shapes.(0) l
    | MaxPool1D l       -> MaxPool1D.connect out_shapes.(0) l
    | MaxPool2D l       -> MaxPool2D.connect out_shapes.(0) l
    | AvgPool1D l       -> AvgPool1D.connect out_shapes.(0) l
    | AvgPool2D l       -> AvgPool2D.connect out_shapes.(0) l
    | GlobalMaxPool1D l -> GlobalMaxPool1D.connect out_shapes.(0) l
    | GlobalMaxPool2D l -> GlobalMaxPool2D.connect out_shapes.(0) l
    | GlobalAvgPool1D l -> GlobalAvgPool1D.connect out_shapes.(0) l
    | GlobalAvgPool2D l -> GlobalAvgPool2D.connect out_shapes.(0) l
    | Dropout l         -> Dropout.connect out_shapes.(0) l
    | Reshape l         -> Reshape.connect out_shapes.(0) l
    | Flatten l         -> Flatten.connect out_shapes.(0) l
    | Lambda l          -> Lambda.connect out_shapes.(0) l
    | Activation l      -> Activation.connect out_shapes.(0) l
    | GaussianNoise l   -> GaussianNoise.connect out_shapes.(0) l
    | GaussianDropout l -> GaussianDropout.connect out_shapes.(0) l
    | AlphaDropout l    -> AlphaDropout.connect out_shapes.(0) l
    | Normalisation l   -> Normalisation.connect out_shapes.(0) l
    | Add l             -> Add.connect out_shapes l
    | Mul l             -> Mul.connect out_shapes l
    | Dot l             -> Dot.connect out_shapes l
    | Max l             -> Max.connect out_shapes l
    | Average l         -> Average.connect out_shapes l
    | Concatenate l     -> Concatenate.connect out_shapes l


  let init = function
    | Linear l          -> Linear.init l
    | LinearNoBias l    -> LinearNoBias.init l
    | Embedding l       -> Embedding.init l
    | LSTM l            -> LSTM.init l
    | GRU l             -> GRU.init l
    | Recurrent l       -> Recurrent.init l
    | Conv1D l          -> Conv1D.init l
    | Conv2D l          -> Conv2D.init l
    | Conv3D l          -> Conv3D.init l
    | TransposeConv1D l -> TransposeConv1D.init l
    | TransposeConv2D l -> TransposeConv2D.init l
    | TransposeConv3D l -> TransposeConv3D.init l
    | FullyConnected l  -> FullyConnected.init l
    | Normalisation l   -> Normalisation.init l
    | _                 -> () (* activation, etc. *)


  let reset = function
    | Linear l          -> Linear.reset l
    | LinearNoBias l    -> LinearNoBias.reset l
    | Embedding l       -> Embedding.reset l
    | LSTM l            -> LSTM.reset l
    | GRU l             -> GRU.reset l
    | Recurrent l       -> Recurrent.reset l
    | Conv1D l          -> Conv1D.reset l
    | Conv2D l          -> Conv2D.reset l
    | Conv3D l          -> Conv3D.reset l
    | TransposeConv1D l -> TransposeConv1D.reset l
    | TransposeConv2D l -> TransposeConv2D.reset l
    | TransposeConv3D l -> TransposeConv3D.reset l
    | FullyConnected l  -> FullyConnected.reset l
    | Normalisation l   -> Normalisation.reset l
    | _                 -> () (* activation, etc. *)


  let mktag t = function
    | Linear l          -> Linear.mktag t l
    | LinearNoBias l    -> LinearNoBias.mktag t l
    | Embedding l       -> Embedding.mktag t l
    | LSTM l            -> LSTM.mktag t l
    | GRU l             -> GRU.mktag t l
    | Recurrent l       -> Recurrent.mktag t l
    | Conv1D l          -> Conv1D.mktag t l
    | Conv2D l          -> Conv2D.mktag t l
    | Conv3D l          -> Conv3D.mktag t l
    | TransposeConv1D l -> TransposeConv1D.mktag t l
    | TransposeConv2D l -> TransposeConv2D.mktag t l
    | TransposeConv3D l -> TransposeConv3D.mktag t l
    | FullyConnected l  -> FullyConnected.mktag t l
    | Normalisation l   -> Normalisation.mktag t l
    | _                 -> () (* activation, etc. *)


  let mkpar = function
    | Linear l          -> Linear.mkpar l
    | LinearNoBias l    -> LinearNoBias.mkpar l
    | Embedding l       -> Embedding.mkpar l
    | LSTM l            -> LSTM.mkpar l
    | GRU l             -> GRU.mkpar l
    | Recurrent l       -> Recurrent.mkpar l
    | Conv1D l          -> Conv1D.mkpar l
    | Conv2D l          -> Conv2D.mkpar l
    | Conv3D l          -> Conv3D.mkpar l
    | TransposeConv1D l -> TransposeConv1D.mkpar l
    | TransposeConv2D l -> TransposeConv2D.mkpar l
    | TransposeConv3D l -> TransposeConv3D.mkpar l
    | FullyConnected l  -> FullyConnected.mkpar l
    | Normalisation l   -> Normalisation.mkpar l
    | _                 -> [||] (* activation, etc. *)


  let mkpri = function
    | Linear l          -> Linear.mkpri l
    | LinearNoBias l    -> LinearNoBias.mkpri l
    | Embedding l       -> Embedding.mkpri l
    | LSTM l            -> LSTM.mkpri l
    | GRU l             -> GRU.mkpri l
    | Recurrent l       -> Recurrent.mkpri l
    | Conv1D l          -> Conv1D.mkpri l
    | Conv2D l          -> Conv2D.mkpri l
    | Conv3D l          -> Conv3D.mkpri l
    | TransposeConv1D l -> TransposeConv1D.mkpri l
    | TransposeConv2D l -> TransposeConv2D.mkpri l
    | TransposeConv3D l -> TransposeConv3D.mkpri l
    | FullyConnected l  -> FullyConnected.mkpri l
    | Normalisation l   -> Normalisation.mkpri l
    | _                 -> [||] (* activation, etc. *)


  let mkadj = function
    | Linear l          -> Linear.mkadj l
    | LinearNoBias l    -> LinearNoBias.mkadj l
    | Embedding l       -> Embedding.mkadj l
    | LSTM l            -> LSTM.mkadj l
    | GRU l             -> GRU.mkadj l
    | Recurrent l       -> Recurrent.mkadj l
    | Conv1D l          -> Conv1D.mkadj l
    | Conv2D l          -> Conv2D.mkadj l
    | Conv3D l          -> Conv3D.mkadj l
    | TransposeConv1D l -> TransposeConv1D.mkadj l
    | TransposeConv2D l -> TransposeConv2D.mkadj l
    | TransposeConv3D l -> TransposeConv3D.mkadj l
    | FullyConnected l  -> FullyConnected.mkadj l
    | Normalisation l   -> Normalisation.mkadj l
    | _                 -> [||] (* activation, etc. *)


  let update l u = match l with
    | Linear l          -> Linear.update l u
    | LinearNoBias l    -> LinearNoBias.update l u
    | Embedding l       -> Embedding.update l u
    | LSTM l            -> LSTM.update l u
    | GRU l             -> GRU.update l u
    | Recurrent l       -> Recurrent.update l u
    | Conv1D l          -> Conv1D.update l u
    | Conv2D l          -> Conv2D.update l u
    | Conv3D l          -> Conv3D.update l u
    | TransposeConv1D l -> TransposeConv1D.update l u
    | TransposeConv2D l -> TransposeConv2D.update l u
    | TransposeConv3D l -> TransposeConv3D.update l u
    | FullyConnected l  -> FullyConnected.update l u
    | Normalisation l   -> Normalisation.update l u
    | _                 -> () (* activation, etc. *)


  let copy = function
    | Input l           -> Input Input.(copy l)
    | Linear l          -> Linear Linear.(copy l)
    | LinearNoBias l    -> LinearNoBias LinearNoBias.(copy l)
    | Embedding l       -> Embedding Embedding.(copy l)
    | LSTM l            -> LSTM LSTM.(copy l)
    | GRU l             -> GRU GRU.(copy l)
    | Recurrent l       -> Recurrent Recurrent.(copy l)
    | Conv1D l          -> Conv1D Conv1D.(copy l)
    | Conv2D l          -> Conv2D Conv2D.(copy l)
    | Conv3D l          -> Conv3D Conv3D.(copy l)
    | TransposeConv1D l -> TransposeConv1D TransposeConv1D.(copy l)
    | TransposeConv2D l -> TransposeConv2D TransposeConv2D.(copy l)
    | TransposeConv3D l -> TransposeConv3D TransposeConv3D.(copy l)
    | FullyConnected l  -> FullyConnected FullyConnected.(copy l)
    | MaxPool1D l       -> MaxPool1D MaxPool1D.(copy l)
    | MaxPool2D l       -> MaxPool2D MaxPool2D.(copy l)
    | AvgPool1D l       -> AvgPool1D AvgPool1D.(copy l)
    | AvgPool2D l       -> AvgPool2D AvgPool2D.(copy l)
    | GlobalMaxPool1D l -> GlobalMaxPool1D GlobalMaxPool1D.(copy l)
    | GlobalMaxPool2D l -> GlobalMaxPool2D GlobalMaxPool2D.(copy l)
    | GlobalAvgPool1D l -> GlobalAvgPool1D GlobalAvgPool1D.(copy l)
    | GlobalAvgPool2D l -> GlobalAvgPool2D GlobalAvgPool2D.(copy l)
    | Dropout l         -> Dropout Dropout.(copy l)
    | Reshape l         -> Reshape Reshape.(copy l)
    | Flatten l         -> Flatten Flatten.(copy l)
    | Lambda l          -> Lambda Lambda.(copy l)
    | Activation l      -> Activation Activation.(copy l)
    | GaussianNoise l   -> GaussianNoise GaussianNoise.(copy l)
    | GaussianDropout l -> GaussianDropout GaussianDropout.(copy l)
    | AlphaDropout l    -> AlphaDropout AlphaDropout.(copy l)
    | Normalisation l   -> Normalisation Normalisation.(copy l)
    | Add l             -> Add Add.(copy l)
    | Mul l             -> Mul Mul.(copy l)
    | Dot l             -> Dot Dot.(copy l)
    | Max l             -> Max Max.(copy l)
    | Average l         -> Average Average.(copy l)
    | Concatenate l     -> Concatenate Concatenate.(copy l)


  let run a l = match l with
    | Input l           -> Input.run a.(0) l
    | Linear l          -> Linear.run a.(0) l
    | LinearNoBias l    -> LinearNoBias.run a.(0) l
    | Embedding l       -> Embedding.run a.(0) l
    | LSTM l            -> LSTM.run a.(0) l
    | GRU l             -> GRU.run a.(0) l
    | Recurrent l       -> Recurrent.run a.(0) l
    | Conv1D l          -> Conv1D.run a.(0) l
    | Conv2D l          -> Conv2D.run a.(0) l
    | Conv3D l          -> Conv3D.run a.(0) l
    | TransposeConv1D l -> TransposeConv1D.run a.(0) l
    | TransposeConv2D l -> TransposeConv2D.run a.(0) l
    | TransposeConv3D l -> TransposeConv3D.run a.(0) l
    | FullyConnected l  -> FullyConnected.run a.(0) l
    | MaxPool1D l       -> MaxPool1D.run a.(0) l
    | MaxPool2D l       -> MaxPool2D.run a.(0) l
    | AvgPool1D l       -> AvgPool1D.run a.(0) l
    | AvgPool2D l       -> AvgPool2D.run a.(0) l
    | GlobalMaxPool1D l -> GlobalMaxPool1D.run a.(0) l
    | GlobalMaxPool2D l -> GlobalMaxPool2D.run a.(0) l
    | GlobalAvgPool1D l -> GlobalAvgPool1D.run a.(0) l
    | GlobalAvgPool2D l -> GlobalAvgPool2D.run a.(0) l
    | Dropout l         -> Dropout.run a.(0) l
    | Reshape l         -> Reshape.run a.(0) l
    | Flatten l         -> Flatten.run a.(0) l
    | Lambda l          -> Lambda.run a.(0) l
    | Activation l      -> Activation.run a.(0) l
    | GaussianNoise l   -> GaussianNoise.run a.(0) l
    | GaussianDropout l -> GaussianDropout.run a.(0) l
    | AlphaDropout l    -> AlphaDropout.run a.(0) l
    | Normalisation l   -> Normalisation.run a.(0) l
    | Add l             -> Add.run a l
    | Mul l             -> Mul.run a l
    | Dot l             -> Dot.run a l
    | Max l             -> Max.run a l
    | Average l         -> Average.run a l
    | Concatenate l     -> Concatenate.run a l


  let to_string = function
    | Input l           -> Input.to_string l
    | Linear l          -> Linear.to_string l
    | LinearNoBias l    -> LinearNoBias.to_string l
    | Embedding l       -> Embedding.to_string l
    | LSTM l            -> LSTM.to_string l
    | GRU l             -> GRU.to_string l
    | Recurrent l       -> Recurrent.to_string l
    | Conv1D l          -> Conv1D.to_string l
    | Conv2D l          -> Conv2D.to_string l
    | Conv3D l          -> Conv3D.to_string l
    | TransposeConv1D l -> TransposeConv1D.to_string l
    | TransposeConv2D l -> TransposeConv2D.to_string l
    | TransposeConv3D l -> TransposeConv3D.to_string l
    | FullyConnected l  -> FullyConnected.to_string l
    | MaxPool1D l       -> MaxPool1D.to_string l
    | MaxPool2D l       -> MaxPool2D.to_string l
    | AvgPool1D l       -> AvgPool1D.to_string l
    | AvgPool2D l       -> AvgPool2D.to_string l
    | GlobalMaxPool1D l -> GlobalMaxPool1D.to_string l
    | GlobalMaxPool2D l -> GlobalMaxPool2D.to_string l
    | GlobalAvgPool1D l -> GlobalAvgPool1D.to_string l
    | GlobalAvgPool2D l -> GlobalAvgPool2D.to_string l
    | Dropout l         -> Dropout.to_string l
    | Reshape l         -> Reshape.to_string l
    | Flatten l         -> Flatten.to_string l
    | Lambda l          -> Lambda.to_string l
    | Activation l      -> Activation.to_string l
    | GaussianNoise l   -> GaussianNoise.to_string l
    | GaussianDropout l -> GaussianDropout.to_string l
    | AlphaDropout l    -> AlphaDropout.to_string l
    | Normalisation l   -> Normalisation.to_string l
    | Add l             -> Add.to_string l
    | Mul l             -> Mul.to_string l
    | Dot l             -> Dot.to_string l
    | Max l             -> Max.to_string l
    | Average l         -> Average.to_string l
    | Concatenate l     -> Concatenate.to_string l


  let to_name = function
    | Input _           -> Input.to_name ()
    | Linear _          -> Linear.to_name ()
    | LinearNoBias _    -> LinearNoBias.to_name ()
    | Embedding _       -> Embedding.to_name ()
    | LSTM _            -> LSTM.to_name ()
    | GRU _             -> GRU.to_name ()
    | Recurrent _       -> Recurrent.to_name ()
    | Conv1D _          -> Conv1D.to_name ()
    | Conv2D _          -> Conv2D.to_name ()
    | Conv3D _          -> Conv3D.to_name ()
    | TransposeConv1D _ -> TransposeConv1D.to_name ()
    | TransposeConv2D _ -> TransposeConv2D.to_name ()
    | TransposeConv3D _ -> TransposeConv3D.to_name ()
    | FullyConnected _  -> FullyConnected.to_name ()
    | MaxPool1D _       -> MaxPool1D.to_name ()
    | MaxPool2D _       -> MaxPool2D.to_name ()
    | AvgPool1D _       -> AvgPool1D.to_name ()
    | AvgPool2D _       -> AvgPool2D.to_name ()
    | GlobalMaxPool1D _ -> GlobalMaxPool1D.to_name ()
    | GlobalMaxPool2D _ -> GlobalMaxPool2D.to_name ()
    | GlobalAvgPool1D _ -> GlobalAvgPool1D.to_name ()
    | GlobalAvgPool2D _ -> GlobalAvgPool2D.to_name ()
    | Dropout _         -> Dropout.to_name ()
    | Reshape _         -> Reshape.to_name ()
    | Flatten _         -> Flatten.to_name ()
    | Lambda _          -> Lambda.to_name ()
    | Activation _      -> Activation.to_name ()
    | GaussianNoise _   -> GaussianNoise.to_name ()
    | GaussianDropout _ -> GaussianDropout.to_name ()
    | AlphaDropout _    -> AlphaDropout.to_name ()
    | Normalisation _   -> Normalisation.to_name ()
    | Add _             -> Add.to_name ()
    | Mul _             -> Mul.to_name ()
    | Dot _             -> Dot.to_name ()
    | Max _             -> Max.to_name ()
    | Average _         -> Average.to_name ()
    | Concatenate _     -> Concatenate.to_name ()



end

(* Make functor ends *)
