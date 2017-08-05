(* Auto-generated from "owl_zoo_specs_neural.atd" *)


type padding = Owl_zoo_specs_neural_t.padding

type init_typ = Owl_zoo_specs_neural_t.init_typ

type activation_typ = Owl_zoo_specs_neural_t.activation_typ

type param = Owl_zoo_specs_neural_t.param = {
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

type neuron = Owl_zoo_specs_neural_t.neuron

type node = Owl_zoo_specs_neural_t.node = {
  name: string;
  neuron: neuron;
  param: param;
  prev: string list;
  next: string list
}

type graph = Owl_zoo_specs_neural_t.graph = {
  nnid: string;
  root: string;
  topo: node list;
  weights: string option
}

val write_padding :
  Bi_outbuf.t -> padding -> unit
  (** Output a JSON value of type {!padding}. *)

val string_of_padding :
  ?len:int -> padding -> string
  (** Serialize a value of type {!padding}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_padding :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> padding
  (** Input JSON data of type {!padding}. *)

val padding_of_string :
  string -> padding
  (** Deserialize JSON data of type {!padding}. *)

val write_init_typ :
  Bi_outbuf.t -> init_typ -> unit
  (** Output a JSON value of type {!init_typ}. *)

val string_of_init_typ :
  ?len:int -> init_typ -> string
  (** Serialize a value of type {!init_typ}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_init_typ :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> init_typ
  (** Input JSON data of type {!init_typ}. *)

val init_typ_of_string :
  string -> init_typ
  (** Deserialize JSON data of type {!init_typ}. *)

val write_activation_typ :
  Bi_outbuf.t -> activation_typ -> unit
  (** Output a JSON value of type {!activation_typ}. *)

val string_of_activation_typ :
  ?len:int -> activation_typ -> string
  (** Serialize a value of type {!activation_typ}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_activation_typ :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> activation_typ
  (** Input JSON data of type {!activation_typ}. *)

val activation_typ_of_string :
  string -> activation_typ
  (** Deserialize JSON data of type {!activation_typ}. *)

val write_param :
  Bi_outbuf.t -> param -> unit
  (** Output a JSON value of type {!param}. *)

val string_of_param :
  ?len:int -> param -> string
  (** Serialize a value of type {!param}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_param :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> param
  (** Input JSON data of type {!param}. *)

val param_of_string :
  string -> param
  (** Deserialize JSON data of type {!param}. *)

val write_neuron :
  Bi_outbuf.t -> neuron -> unit
  (** Output a JSON value of type {!neuron}. *)

val string_of_neuron :
  ?len:int -> neuron -> string
  (** Serialize a value of type {!neuron}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_neuron :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> neuron
  (** Input JSON data of type {!neuron}. *)

val neuron_of_string :
  string -> neuron
  (** Deserialize JSON data of type {!neuron}. *)

val write_node :
  Bi_outbuf.t -> node -> unit
  (** Output a JSON value of type {!node}. *)

val string_of_node :
  ?len:int -> node -> string
  (** Serialize a value of type {!node}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_node :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> node
  (** Input JSON data of type {!node}. *)

val node_of_string :
  string -> node
  (** Deserialize JSON data of type {!node}. *)

val write_graph :
  Bi_outbuf.t -> graph -> unit
  (** Output a JSON value of type {!graph}. *)

val string_of_graph :
  ?len:int -> graph -> string
  (** Serialize a value of type {!graph}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_graph :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> graph
  (** Input JSON data of type {!graph}. *)

val graph_of_string :
  string -> graph
  (** Deserialize JSON data of type {!graph}. *)

