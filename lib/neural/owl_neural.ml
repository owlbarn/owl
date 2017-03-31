(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff_ad
type t = Owl_algodiff_ad.t

type init_typ =
  | Init_Uniform of float * float
  | Init_Gaussian of float * float
  | Init_Custom of (int -> int -> float)

let initialise t m n = match t with
  | Init_Uniform (a, b) -> Mat.uniform m n
  | Init_Gaussian (a, b) -> Mat.uniform m n
  | Init_Custom f -> Mat.uniform m n

type activation =
  | Sigmoid
  | Tanh
  | Custom_Act of (t -> t)

type layer =
  | Linear of linear
  | Recurrent of recurrent
  | LTSM of ltsm
  | Activate of activation
and linear = {
  mutable w : t;
  mutable b : t;
  mutable init_typ : init_typ;
  mutable init : layer -> unit;
  mutable reset : layer -> unit;
  mutable run : t -> layer -> t;
}
and recurrent = {
  mutable whh : t;
}
and ltsm = {
  mutable wxi : t;
}

type network = {
  mutable layers : layer list;
}

let unpack_linear_layer = function Linear l -> l

let unpack_recurrent_layer = function Recurrent l -> l

let linear ~input ~output ~init_typ =
  let init l =
    let l = unpack_linear_layer l in
    l.w <- initialise init_typ input output;
    l.b <- Mat.zeros 1 output
  in
  let reset l =
    let l = unpack_linear_layer l in
    Mat.reset l.w;
    Mat.reset l.b
  in
  let run x l =
    let l = unpack_linear_layer l in
    Maths.(x * l.w + l.b)
  in
  let l = {
    w = Mat.zeros 1 1;
    b = Mat.zeros 1 1;
    init_typ = init_typ;
    init = init;
    reset = reset;
    run = run;
  }
  in Linear l

let network () = { layers = []; }

let add_layer nn l = nn.layers <- nn.layers @ [l]

let add_activation nn l = nn.layers <- nn.layers @ [Activate l]

(* let init nn = List.iter (fun l -> l.init l) nn.layers *)

let train () = None


(* helper functions *)

let _init_info = function
  | Init_Uniform (a, b)  -> Printf.sprintf "uniform (%g, %g)" a b
  | Init_Gaussian (a, b) -> Printf.sprintf "gaussian (%g, %g)" a b
  | Init_Custom _        -> Printf.sprintf "customise"

let _activation_info = function
  | Sigmoid      -> "sigmoid"
  | Tanh         -> "tanh"
  | Custom_Act _ -> "customise"

let _layer_info = function
  | Linear l    -> (
      let wm, wn = Mat.shape l.w in
      let bn = Mat.col_num l.b in
      Printf.sprintf "Linear layer:
      init : %s
      params : %i
      w : %i x %i
      b : %i
      "
      (_init_info l.init_typ) (wm * wn + bn) wm wn bn
    )
  | Recurrent _ -> "Recurrent"
  | LTSM _      -> "LTSM"
  | Activate a  -> Printf.sprintf "Activation layer: %s\n" (_activation_info a)

let print nn =
  Printf.printf "Neural network info\n\n";
  List.iteri (fun i l ->
    Printf.printf "(%i): %s\n" i (_layer_info l)
  ) nn.layers


(* ends here *)
