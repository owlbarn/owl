(* Auto-generated from "owl_zoo_specs_neural.atd" *)


type padding = [ `SAME | `VALID ]

type init_typ = [
    `Uniform of (float * float)
  | `Gaussian of (float * float)
  | `Standard
  | `Tanh
]

type activation_typ = [ `Relu | `Sigmoid | `Softmax | `Tanh | `None ]

type param = {
  in_shape: int list option;
  out_shape: int list option;
  init_typ: init_typ option;
  activation_typ: activation_typ option;
  hiddens: int option;
  padding: padding option;
  kernel: int list option;
  stride: int list option;
  rate: float option
}

type neuron = [
    `Input | `Linear | `LinearNoBias | `LSTM | `GRU | `Recurrent | `Conv2D
  | `Conv3D | `FullyConnected | `MaxPool2D | `AvgPool2D | `Dropout | `Reshape
  | `Flatten | `Lambda | `Activation | `Add | `Mul | `Dot | `Max | `Average
]

type node = {
  name: string;
  neuron: neuron;
  param: param;
  prev: string list;
  next: string list
}

type graph = {
  nnid: string;
  root: string;
  topo: node list;
  weights: string option
}
