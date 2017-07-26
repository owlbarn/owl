(* Auto-generated from "owl_zoo_specs_neural.atd" *)


type init_typ = Owl_zoo_specs_neural_t.init_typ

type activation_typ = Owl_zoo_specs_neural_t.activation_typ

type param = Owl_zoo_specs_neural_t.param = {
  in_shape: int list option;
  out_shape: int list option;
  init_typ: init_typ option;
  activation_typ: activation_typ option;
  hiddens: int option
}

type neuron = Owl_zoo_specs_neural_t.neuron

type layer = Owl_zoo_specs_neural_t.layer = {
  name: string;
  neuron: neuron;
  param: param
}

type feedforward = Owl_zoo_specs_neural_t.feedforward = {
  name: string;
  layers: layer list
}

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

val write_layer :
  Bi_outbuf.t -> layer -> unit
  (** Output a JSON value of type {!layer}. *)

val string_of_layer :
  ?len:int -> layer -> string
  (** Serialize a value of type {!layer}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_layer :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> layer
  (** Input JSON data of type {!layer}. *)

val layer_of_string :
  string -> layer
  (** Deserialize JSON data of type {!layer}. *)

val write_feedforward :
  Bi_outbuf.t -> feedforward -> unit
  (** Output a JSON value of type {!feedforward}. *)

val string_of_feedforward :
  ?len:int -> feedforward -> string
  (** Serialize a value of type {!feedforward}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_feedforward :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> feedforward
  (** Input JSON data of type {!feedforward}. *)

val feedforward_of_string :
  string -> feedforward
  (** Deserialize JSON data of type {!feedforward}. *)

