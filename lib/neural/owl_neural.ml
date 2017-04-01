(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff_ad
type t = Owl_algodiff_ad.t


module Init = struct

  type typ =
    | Uniform  of float * float
    | Gaussian of float * float
    | Custom   of (int -> int -> float)

  let initialise t m n = match t with
    | Uniform (a, b)  -> Mat.uniform m n
    | Gaussian (a, b) -> Mat.uniform m n
    | Custom f        -> Mat.uniform m n

  let to_string = function
    | Uniform (a, b)  -> Printf.sprintf "uniform (%g, %g)" a b
    | Gaussian (a, b) -> Printf.sprintf "gaussian (%g, %g)" a b
    | Custom _        -> Printf.sprintf "customise"

end


module Activation = struct

  type typ =
    | Sigmoid
    | Tanh
    | Custom of (t -> t)

  let run x l = match l with
    | Sigmoid  -> Maths.(sigmoid x)
    | Tanh     -> Maths.(tanh x)
    | Custom f -> f x

  let to_string = function
    | Sigmoid  -> "Activation layer: sigmoid\n"
    | Tanh     -> "Activation layer: tanh\n"
    | Custom _ -> "Activation layer: customise\n"

end


module Linear = struct

  type layer = {
    mutable w : t;
    mutable b : t;
    mutable init_typ : Init.typ;
  }

  let create m n init_typ = {
    w = Mat.zeros m n;
    b = Mat.zeros 1 n;
    init_typ = init_typ;
  }

  let init l =
    let m, n = Mat.shape l.w in
    l.w <- Init.initialise l.init_typ m n;
    l.b <- Mat.zeros 1 n

  let reset l =
    Mat.reset l.w;
    Mat.reset l.b

  let run x l = Maths.(x * l.w + l.b)

  let to_string l =
    let wm, wn = Mat.shape l.w in
    let bn = Mat.col_num l.b in
    Printf.sprintf "Linear layer:
    init : %s
    params : %i
    w : %i x %i
    b : %i
    "
    (Init.to_string l.init_typ) (wm * wn + bn) wm wn bn

end


module LTSM = struct

  type layer = {
    mutable wxi : t;
    mutable init_typ : Init.typ;
  }

  let create init_typ = {
    wxi = Mat.zeros 1 1;
    init_typ = init_typ;
  }

  let init l = ()

  let reset l = ()

  let run x l = F 0.

end



module Recurrent = struct

  type layer = {
    mutable w : t;
    mutable b : t;
    mutable init_typ : Init.typ;
  }

  let create init_typ = {
    w = Mat.zeros 1 1;
    b = Mat.zeros 1 1;
    init_typ = init_typ;
  }

  let init l = ()

  let reset l = ()

  let run x l = F 0.

end


type layer =
  | Linear     of Linear.layer
  | LTSM       of LTSM.layer
  | Recurrent  of Recurrent.layer
  | Activation of Activation.typ

type network = {
  mutable layers : layer list;
}

let network () = { layers = []; }

let add_layer nn l = nn.layers <- nn.layers @ [l]

let add_activation nn l = nn.layers <- nn.layers @ [Activation l]

let init nn = List.iter (function
  | Linear l    -> Linear.init l
  | LTSM l      -> LTSM.init l
  | Recurrent l -> Recurrent.init l
  | _           -> ()
  ) nn.layers

let reset nn = List.iter (function
  | Linear l    -> Linear.reset l
  | LTSM l      -> LTSM.reset l
  | Recurrent l -> Recurrent.reset l
  | _           -> ()
  ) nn.layers

(* FIXME *)
let run x nn = List.iter (function
  | Linear l    -> Linear.run x l |> ignore
  | LTSM l      -> LTSM.run x l |> ignore
  | Recurrent l -> Recurrent.run x l |> ignore
  | Activation l -> Activation.run x l |> ignore
  ) nn.layers

let linear ~inputs ~outputs ~init_typ = Linear (Linear.create inputs outputs init_typ)


(* helper functions *)

let _layer_info = function
  | Linear l     -> Linear.to_string l
  | Recurrent l  -> "Recurrent"
  | LTSM l       -> "LTSM"
  | Activation l -> Activation.to_string l

let print nn =
  Printf.printf "Neural network info\n\n";
  List.iteri (fun i l ->
    Printf.printf "(%i): %s\n" i (_layer_info l)
  ) nn.layers

(* ends here *)
