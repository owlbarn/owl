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

let write_init_typ = (
  fun ob sum ->
    match sum with
      | `Uniform x ->
        Bi_outbuf.add_string ob "<\"Uniform\":";
        (
          fun ob x ->
            Bi_outbuf.add_char ob '(';
            (let x, _ = x in
            (
              Yojson.Safe.write_float
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, x = x in
            (
              Yojson.Safe.write_float
            ) ob x
            );
            Bi_outbuf.add_char ob ')';
        ) ob x;
        Bi_outbuf.add_char ob '>'
      | `Gaussian x ->
        Bi_outbuf.add_string ob "<\"Gaussian\":";
        (
          fun ob x ->
            Bi_outbuf.add_char ob '(';
            (let x, _ = x in
            (
              Yojson.Safe.write_float
            ) ob x
            );
            Bi_outbuf.add_char ob ',';
            (let _, x = x in
            (
              Yojson.Safe.write_float
            ) ob x
            );
            Bi_outbuf.add_char ob ')';
        ) ob x;
        Bi_outbuf.add_char ob '>'
      | `Standard -> Bi_outbuf.add_string ob "<\"Standard\">"
      | `Tanh -> Bi_outbuf.add_string ob "<\"Tanh\">"
)
let string_of_init_typ ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_init_typ ob x;
  Bi_outbuf.contents ob
let read_init_typ = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 4 -> (
                      if String.unsafe_get s pos = 'T' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'h' then (
                        3
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 7 -> (
                      if String.unsafe_get s pos = 'U' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'm' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 8 -> (
                      match String.unsafe_get s pos with
                        | 'G' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'n' then (
                              1
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'S' -> (
                            if String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'd' then (
                              2
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            Ag_oj_run.read_number
                          ) p lb
                        in
                        incr len;
                        Yojson.Safe.read_space p lb;
                        Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        x
                      in
                      let x1 =
                        let x =
                          (
                            Ag_oj_run.read_number
                          ) p lb
                        in
                        incr len;
                        (try
                          Yojson.Safe.read_space p lb;
                          Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        with Yojson.End_of_tuple -> end_of_tuple := true);
                        x
                      in
                      if not !end_of_tuple then (
                        try
                          while true do
                            Yojson.Safe.skip_json p lb;
                            Yojson.Safe.read_space p lb;
                            Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                          done
                        with Yojson.End_of_tuple -> ()
                      );
                      (x0, x1)
                    with Yojson.End_of_tuple ->
                      Ag_oj_run.missing_tuple_fields p !len [ 0; 1 ]);
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Uniform x
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            Ag_oj_run.read_number
                          ) p lb
                        in
                        incr len;
                        Yojson.Safe.read_space p lb;
                        Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        x
                      in
                      let x1 =
                        let x =
                          (
                            Ag_oj_run.read_number
                          ) p lb
                        in
                        incr len;
                        (try
                          Yojson.Safe.read_space p lb;
                          Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        with Yojson.End_of_tuple -> end_of_tuple := true);
                        x
                      in
                      if not !end_of_tuple then (
                        try
                          while true do
                            Yojson.Safe.skip_json p lb;
                            Yojson.Safe.read_space p lb;
                            Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                          done
                        with Yojson.End_of_tuple -> ()
                      );
                      (x0, x1)
                    with Yojson.End_of_tuple ->
                      Ag_oj_run.missing_tuple_fields p !len [ 0; 1 ]);
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Gaussian x
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Standard
            | 3 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Tanh
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 4 -> (
                      if String.unsafe_get s pos = 'T' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'h' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 8 -> (
                      if String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 't' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'r' && String.unsafe_get s (pos+7) = 'd' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              `Standard
            | 1 ->
              `Tanh
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 7 -> (
                      if String.unsafe_get s pos = 'U' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'i' && String.unsafe_get s (pos+3) = 'f' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'm' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 8 -> (
                      if String.unsafe_get s pos = 'G' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'n' then (
                        1
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            Ag_oj_run.read_number
                          ) p lb
                        in
                        incr len;
                        Yojson.Safe.read_space p lb;
                        Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        x
                      in
                      let x1 =
                        let x =
                          (
                            Ag_oj_run.read_number
                          ) p lb
                        in
                        incr len;
                        (try
                          Yojson.Safe.read_space p lb;
                          Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        with Yojson.End_of_tuple -> end_of_tuple := true);
                        x
                      in
                      if not !end_of_tuple then (
                        try
                          while true do
                            Yojson.Safe.skip_json p lb;
                            Yojson.Safe.read_space p lb;
                            Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                          done
                        with Yojson.End_of_tuple -> ()
                      );
                      (x0, x1)
                    with Yojson.End_of_tuple ->
                      Ag_oj_run.missing_tuple_fields p !len [ 0; 1 ]);
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              `Uniform x
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  fun p lb ->
                    Yojson.Safe.read_space p lb;
                    let std_tuple = Yojson.Safe.start_any_tuple p lb in
                    let len = ref 0 in
                    let end_of_tuple = ref false in
                    (try
                      let x0 =
                        let x =
                          (
                            Ag_oj_run.read_number
                          ) p lb
                        in
                        incr len;
                        Yojson.Safe.read_space p lb;
                        Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        x
                      in
                      let x1 =
                        let x =
                          (
                            Ag_oj_run.read_number
                          ) p lb
                        in
                        incr len;
                        (try
                          Yojson.Safe.read_space p lb;
                          Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                        with Yojson.End_of_tuple -> end_of_tuple := true);
                        x
                      in
                      if not !end_of_tuple then (
                        try
                          while true do
                            Yojson.Safe.skip_json p lb;
                            Yojson.Safe.read_space p lb;
                            Yojson.Safe.read_tuple_sep2 p std_tuple lb;
                          done
                        with Yojson.End_of_tuple -> ()
                      );
                      (x0, x1)
                    with Yojson.End_of_tuple ->
                      Ag_oj_run.missing_tuple_fields p !len [ 0; 1 ]);
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              `Gaussian x
            | _ -> (
                assert false
              )
        )
)
let init_typ_of_string s =
  read_init_typ (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_activation_typ = (
  fun ob sum ->
    match sum with
      | `Relu -> Bi_outbuf.add_string ob "<\"Relu\">"
      | `Sigmoid -> Bi_outbuf.add_string ob "<\"Sigmoid\">"
      | `Softmax -> Bi_outbuf.add_string ob "<\"Softmax\">"
      | `Tanh -> Bi_outbuf.add_string ob "<\"Tanh\">"
      | `None -> Bi_outbuf.add_string ob "<\"None\">"
)
let string_of_activation_typ ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_activation_typ ob x;
  Bi_outbuf.contents ob
let read_activation_typ = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 4 -> (
                      match String.unsafe_get s pos with
                        | 'N' -> (
                            if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                              4
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'R' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'u' then (
                              0
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'T' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'h' then (
                              3
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 7 -> (
                      if String.unsafe_get s pos = 'S' then (
                        match String.unsafe_get s (pos+1) with
                          | 'i' -> (
                              if String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'd' then (
                                1
                              )
                              else (
                                raise (Exit)
                              )
                            )
                          | 'o' -> (
                              if String.unsafe_get s (pos+2) = 'f' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'm' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'x' then (
                                2
                              )
                              else (
                                raise (Exit)
                              )
                            )
                          | _ -> (
                              raise (Exit)
                            )
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Relu
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Sigmoid
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Softmax
            | 3 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Tanh
            | 4 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `None
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 4 -> (
                      match String.unsafe_get s pos with
                        | 'N' -> (
                            if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                              4
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'R' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'u' then (
                              0
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'T' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'h' then (
                              3
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 7 -> (
                      if String.unsafe_get s pos = 'S' then (
                        match String.unsafe_get s (pos+1) with
                          | 'i' -> (
                              if String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'm' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'd' then (
                                1
                              )
                              else (
                                raise (Exit)
                              )
                            )
                          | 'o' -> (
                              if String.unsafe_get s (pos+2) = 'f' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 'm' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'x' then (
                                2
                              )
                              else (
                                raise (Exit)
                              )
                            )
                          | _ -> (
                              raise (Exit)
                            )
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              `Relu
            | 1 ->
              `Sigmoid
            | 2 ->
              `Softmax
            | 3 ->
              `Tanh
            | 4 ->
              `None
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | _ -> (
                assert false
              )
        )
)
let activation_typ_of_string s =
  read_activation_typ (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__5 = (
  Ag_oj_run.write_option (
    Yojson.Safe.write_int
  )
)
let string_of__5 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__5 ob x;
  Bi_outbuf.contents ob
let read__5 = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 then (
                  match String.unsafe_get s pos with
                    | 'N' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                          0
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | 'S' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                          1
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | _ -> (
                        raise (Exit)
                      )
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  Ag_oj_run.read_int
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              (None : _ option)
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  Ag_oj_run.read_int
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
)
let _5_of_string s =
  read__5 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__4 = (
  Ag_oj_run.write_option (
    write_activation_typ
  )
)
let string_of__4 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__4 ob x;
  Bi_outbuf.contents ob
let read__4 = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 then (
                  match String.unsafe_get s pos with
                    | 'N' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                          0
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | 'S' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                          1
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | _ -> (
                        raise (Exit)
                      )
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_activation_typ
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              (None : _ option)
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_activation_typ
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
)
let _4_of_string s =
  read__4 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__3 = (
  Ag_oj_run.write_option (
    write_init_typ
  )
)
let string_of__3 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__3 ob x;
  Bi_outbuf.contents ob
let read__3 = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 then (
                  match String.unsafe_get s pos with
                    | 'N' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                          0
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | 'S' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                          1
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | _ -> (
                        raise (Exit)
                      )
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read_init_typ
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              (None : _ option)
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read_init_typ
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
)
let _3_of_string s =
  read__3 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    Yojson.Safe.write_int
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    Ag_oj_run.read_int
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__2 = (
  Ag_oj_run.write_option (
    write__1
  )
)
let string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
let read__2 = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 then (
                  match String.unsafe_get s pos with
                    | 'N' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                          0
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | 'S' -> (
                        if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                          1
                        )
                        else (
                          raise (Exit)
                        )
                      )
                    | _ -> (
                        raise (Exit)
                      )
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (None : _ option)
            | 1 ->
              Ag_oj_run.read_until_field_value p lb;
              let x = (
                  read__1
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'N' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              (None : _ option)
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                if len = 4 && String.unsafe_get s pos = 'S' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  raise (Exit)
                )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_comma p lb;
              Yojson.Safe.read_space p lb;
              let x = (
                  read__1
                ) p lb
              in
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_rbr p lb;
              (Some x : _ option)
            | _ -> (
                assert false
              )
        )
)
let _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_param : _ -> param -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    (match x.in_shape with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"in_shape\":";
      (
        write__1
      )
        ob x;
    );
    (match x.out_shape with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"out_shape\":";
      (
        write__1
      )
        ob x;
    );
    (match x.init_typ with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"init_typ\":";
      (
        write_init_typ
      )
        ob x;
    );
    (match x.activation_typ with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"activation_typ\":";
      (
        write_activation_typ
      )
        ob x;
    );
    (match x.hiddens with None -> () | Some x ->
      if !is_first then
        is_first := false
      else
        Bi_outbuf.add_char ob ',';
      Bi_outbuf.add_string ob "\"hiddens\":";
      (
        Yojson.Safe.write_int
      )
        ob x;
    );
    Bi_outbuf.add_char ob '}';
)
let string_of_param ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_param ob x;
  Bi_outbuf.contents ob
let read_param = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_in_shape = ref (None) in
    let field_out_shape = ref (None) in
    let field_init_typ = ref (None) in
    let field_activation_typ = ref (None) in
    let field_hiddens = ref (None) in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 7 -> (
                if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'd' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 's' then (
                  4
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'n' then (
                  match String.unsafe_get s (pos+2) with
                    | '_' -> (
                        if String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'h' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'e' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'i' -> (
                        if String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'p' then (
                          2
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
                else (
                  -1
                )
              )
            | 9 -> (
                if String.unsafe_get s pos = 'o' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 'e' then (
                  1
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'c' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'v' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = '_' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'y' && String.unsafe_get s (pos+13) = 'p' then (
                  3
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_in_shape := (
                Some (
                  (
                    read__1
                  ) p lb
                )
              );
            )
          | 1 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_out_shape := (
                Some (
                  (
                    read__1
                  ) p lb
                )
              );
            )
          | 2 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_init_typ := (
                Some (
                  (
                    read_init_typ
                  ) p lb
                )
              );
            )
          | 3 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_activation_typ := (
                Some (
                  (
                    read_activation_typ
                  ) p lb
                )
              );
            )
          | 4 ->
            if not (Yojson.Safe.read_null_if_possible p lb) then (
              field_hiddens := (
                Some (
                  (
                    Ag_oj_run.read_int
                  ) p lb
                )
              );
            )
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 7 -> (
                  if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'd' && String.unsafe_get s (pos+4) = 'e' && String.unsafe_get s (pos+5) = 'n' && String.unsafe_get s (pos+6) = 's' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'n' then (
                    match String.unsafe_get s (pos+2) with
                      | '_' -> (
                          if String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'h' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 'e' then (
                            0
                          )
                          else (
                            -1
                          )
                        )
                      | 'i' -> (
                          if String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'y' && String.unsafe_get s (pos+7) = 'p' then (
                            2
                          )
                          else (
                            -1
                          )
                        )
                      | _ -> (
                          -1
                        )
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 'o' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = '_' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'p' && String.unsafe_get s (pos+8) = 'e' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'c' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'v' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' && String.unsafe_get s (pos+10) = '_' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'y' && String.unsafe_get s (pos+13) = 'p' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_in_shape := (
                  Some (
                    (
                      read__1
                    ) p lb
                  )
                );
              )
            | 1 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_out_shape := (
                  Some (
                    (
                      read__1
                    ) p lb
                  )
                );
              )
            | 2 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_init_typ := (
                  Some (
                    (
                      read_init_typ
                    ) p lb
                  )
                );
              )
            | 3 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_activation_typ := (
                  Some (
                    (
                      read_activation_typ
                    ) p lb
                  )
                );
              )
            | 4 ->
              if not (Yojson.Safe.read_null_if_possible p lb) then (
                field_hiddens := (
                  Some (
                    (
                      Ag_oj_run.read_int
                    ) p lb
                  )
                );
              )
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        (
          {
            in_shape = !field_in_shape;
            out_shape = !field_out_shape;
            init_typ = !field_init_typ;
            activation_typ = !field_activation_typ;
            hiddens = !field_hiddens;
          }
         : param)
      )
)
let param_of_string s =
  read_param (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_neuron = (
  fun ob sum ->
    match sum with
      | `Input -> Bi_outbuf.add_string ob "<\"Input\">"
      | `Linear -> Bi_outbuf.add_string ob "<\"Linear\">"
      | `LinearNoBias -> Bi_outbuf.add_string ob "<\"LinearNoBias\">"
      | `LSTM -> Bi_outbuf.add_string ob "<\"LSTM\">"
      | `GRU -> Bi_outbuf.add_string ob "<\"GRU\">"
      | `Recurrent -> Bi_outbuf.add_string ob "<\"Recurrent\">"
      | `Conv2D -> Bi_outbuf.add_string ob "<\"Conv2D\">"
      | `Conv3D -> Bi_outbuf.add_string ob "<\"Conv3D\">"
      | `FullyConnected -> Bi_outbuf.add_string ob "<\"FullyConnected\">"
      | `MaxPool2D -> Bi_outbuf.add_string ob "<\"MaxPool2D\">"
      | `AvgPool2D -> Bi_outbuf.add_string ob "<\"AvgPool2D\">"
      | `Dropout -> Bi_outbuf.add_string ob "<\"Dropout\">"
      | `Reshape -> Bi_outbuf.add_string ob "<\"Reshape\">"
      | `Flatten -> Bi_outbuf.add_string ob "<\"Flatten\">"
      | `Lambda -> Bi_outbuf.add_string ob "<\"Lambda\">"
      | `Activation -> Bi_outbuf.add_string ob "<\"Activation\">"
      | `Add -> Bi_outbuf.add_string ob "<\"Add\">"
      | `Mul -> Bi_outbuf.add_string ob "<\"Mul\">"
      | `Dot -> Bi_outbuf.add_string ob "<\"Dot\">"
      | `Max -> Bi_outbuf.add_string ob "<\"Max\">"
      | `Average -> Bi_outbuf.add_string ob "<\"Average\">"
)
let string_of_neuron ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_neuron ob x;
  Bi_outbuf.contents ob
let read_neuron = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    
    match Yojson.Safe.start_any_variant p lb with
      | `Edgy_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 3 -> (
                      match String.unsafe_get s pos with
                        | 'A' -> (
                            if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'd' then (
                              16
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'D' -> (
                            if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 't' then (
                              18
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'G' -> (
                            if String.unsafe_get s (pos+1) = 'R' && String.unsafe_get s (pos+2) = 'U' then (
                              4
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'M' -> (
                            match String.unsafe_get s (pos+1) with
                              | 'a' -> (
                                  if String.unsafe_get s (pos+2) = 'x' then (
                                    19
                                  )
                                  else (
                                    raise (Exit)
                                  )
                                )
                              | 'u' -> (
                                  if String.unsafe_get s (pos+2) = 'l' then (
                                    17
                                  )
                                  else (
                                    raise (Exit)
                                  )
                                )
                              | _ -> (
                                  raise (Exit)
                                )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 4 -> (
                      if String.unsafe_get s pos = 'L' && String.unsafe_get s (pos+1) = 'S' && String.unsafe_get s (pos+2) = 'T' && String.unsafe_get s (pos+3) = 'M' then (
                        3
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 5 -> (
                      if String.unsafe_get s pos = 'I' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 't' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 6 -> (
                      match String.unsafe_get s pos with
                        | 'C' -> (
                            if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'v' then (
                              match String.unsafe_get s (pos+4) with
                                | '2' -> (
                                    if String.unsafe_get s (pos+5) = 'D' then (
                                      6
                                    )
                                    else (
                                      raise (Exit)
                                    )
                                  )
                                | '3' -> (
                                    if String.unsafe_get s (pos+5) = 'D' then (
                                      7
                                    )
                                    else (
                                      raise (Exit)
                                    )
                                  )
                                | _ -> (
                                    raise (Exit)
                                  )
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'L' -> (
                            match String.unsafe_get s (pos+1) with
                              | 'a' -> (
                                  if String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'a' then (
                                    14
                                  )
                                  else (
                                    raise (Exit)
                                  )
                                )
                              | 'i' -> (
                                  if String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'r' then (
                                    1
                                  )
                                  else (
                                    raise (Exit)
                                  )
                                )
                              | _ -> (
                                  raise (Exit)
                                )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 7 -> (
                      match String.unsafe_get s pos with
                        | 'A' -> (
                            if String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' then (
                              20
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'D' -> (
                            if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 't' then (
                              11
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'F' -> (
                            if String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'n' then (
                              13
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'R' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'p' && String.unsafe_get s (pos+6) = 'e' then (
                              12
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 9 -> (
                      match String.unsafe_get s pos with
                        | 'A' -> (
                            if String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = '2' && String.unsafe_get s (pos+8) = 'D' then (
                              10
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'M' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = '2' && String.unsafe_get s (pos+8) = 'D' then (
                              9
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'R' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 't' then (
                              5
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 10 -> (
                      if String.unsafe_get s pos = 'A' && String.unsafe_get s (pos+1) = 'c' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'v' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' then (
                        15
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 12 -> (
                      if String.unsafe_get s pos = 'L' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'N' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'B' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 's' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 14 -> (
                      if String.unsafe_get s pos = 'F' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'y' && String.unsafe_get s (pos+5) = 'C' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'c' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'd' then (
                        8
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | 0 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Input
            | 1 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Linear
            | 2 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `LinearNoBias
            | 3 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `LSTM
            | 4 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `GRU
            | 5 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Recurrent
            | 6 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Conv2D
            | 7 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Conv3D
            | 8 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `FullyConnected
            | 9 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `MaxPool2D
            | 10 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `AvgPool2D
            | 11 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Dropout
            | 12 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Reshape
            | 13 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Flatten
            | 14 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Lambda
            | 15 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Activation
            | 16 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Add
            | 17 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Mul
            | 18 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Dot
            | 19 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Max
            | 20 ->
              Yojson.Safe.read_space p lb;
              Yojson.Safe.read_gt p lb;
              `Average
            | _ -> (
                assert false
              )
        )
      | `Double_quote -> (
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              try
                match len with
                  | 3 -> (
                      match String.unsafe_get s pos with
                        | 'A' -> (
                            if String.unsafe_get s (pos+1) = 'd' && String.unsafe_get s (pos+2) = 'd' then (
                              16
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'D' -> (
                            if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 't' then (
                              18
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'G' -> (
                            if String.unsafe_get s (pos+1) = 'R' && String.unsafe_get s (pos+2) = 'U' then (
                              4
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'M' -> (
                            match String.unsafe_get s (pos+1) with
                              | 'a' -> (
                                  if String.unsafe_get s (pos+2) = 'x' then (
                                    19
                                  )
                                  else (
                                    raise (Exit)
                                  )
                                )
                              | 'u' -> (
                                  if String.unsafe_get s (pos+2) = 'l' then (
                                    17
                                  )
                                  else (
                                    raise (Exit)
                                  )
                                )
                              | _ -> (
                                  raise (Exit)
                                )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 4 -> (
                      if String.unsafe_get s pos = 'L' && String.unsafe_get s (pos+1) = 'S' && String.unsafe_get s (pos+2) = 'T' && String.unsafe_get s (pos+3) = 'M' then (
                        3
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 5 -> (
                      if String.unsafe_get s pos = 'I' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 't' then (
                        0
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 6 -> (
                      match String.unsafe_get s pos with
                        | 'C' -> (
                            if String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'v' then (
                              match String.unsafe_get s (pos+4) with
                                | '2' -> (
                                    if String.unsafe_get s (pos+5) = 'D' then (
                                      6
                                    )
                                    else (
                                      raise (Exit)
                                    )
                                  )
                                | '3' -> (
                                    if String.unsafe_get s (pos+5) = 'D' then (
                                      7
                                    )
                                    else (
                                      raise (Exit)
                                    )
                                  )
                                | _ -> (
                                    raise (Exit)
                                  )
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'L' -> (
                            match String.unsafe_get s (pos+1) with
                              | 'a' -> (
                                  if String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'b' && String.unsafe_get s (pos+4) = 'd' && String.unsafe_get s (pos+5) = 'a' then (
                                    14
                                  )
                                  else (
                                    raise (Exit)
                                  )
                                )
                              | 'i' -> (
                                  if String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'r' then (
                                    1
                                  )
                                  else (
                                    raise (Exit)
                                  )
                                )
                              | _ -> (
                                  raise (Exit)
                                )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 7 -> (
                      match String.unsafe_get s pos with
                        | 'A' -> (
                            if String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'g' && String.unsafe_get s (pos+6) = 'e' then (
                              20
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'D' -> (
                            if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'p' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'u' && String.unsafe_get s (pos+6) = 't' then (
                              11
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'F' -> (
                            if String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 't' && String.unsafe_get s (pos+4) = 't' && String.unsafe_get s (pos+5) = 'e' && String.unsafe_get s (pos+6) = 'n' then (
                              13
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'R' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'h' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'p' && String.unsafe_get s (pos+6) = 'e' then (
                              12
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 9 -> (
                      match String.unsafe_get s pos with
                        | 'A' -> (
                            if String.unsafe_get s (pos+1) = 'v' && String.unsafe_get s (pos+2) = 'g' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = '2' && String.unsafe_get s (pos+8) = 'D' then (
                              10
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'M' -> (
                            if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 'P' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = '2' && String.unsafe_get s (pos+8) = 'D' then (
                              9
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | 'R' -> (
                            if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'u' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 't' then (
                              5
                            )
                            else (
                              raise (Exit)
                            )
                          )
                        | _ -> (
                            raise (Exit)
                          )
                    )
                  | 10 -> (
                      if String.unsafe_get s pos = 'A' && String.unsafe_get s (pos+1) = 'c' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'v' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 't' && String.unsafe_get s (pos+7) = 'i' && String.unsafe_get s (pos+8) = 'o' && String.unsafe_get s (pos+9) = 'n' then (
                        15
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 12 -> (
                      if String.unsafe_get s pos = 'L' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'r' && String.unsafe_get s (pos+6) = 'N' && String.unsafe_get s (pos+7) = 'o' && String.unsafe_get s (pos+8) = 'B' && String.unsafe_get s (pos+9) = 'i' && String.unsafe_get s (pos+10) = 'a' && String.unsafe_get s (pos+11) = 's' then (
                        2
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | 14 -> (
                      if String.unsafe_get s pos = 'F' && String.unsafe_get s (pos+1) = 'u' && String.unsafe_get s (pos+2) = 'l' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'y' && String.unsafe_get s (pos+5) = 'C' && String.unsafe_get s (pos+6) = 'o' && String.unsafe_get s (pos+7) = 'n' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'e' && String.unsafe_get s (pos+10) = 'c' && String.unsafe_get s (pos+11) = 't' && String.unsafe_get s (pos+12) = 'e' && String.unsafe_get s (pos+13) = 'd' then (
                        8
                      )
                      else (
                        raise (Exit)
                      )
                    )
                  | _ -> (
                      raise (Exit)
                    )
              with Exit -> (
                  Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
                )
          in
          let i = Yojson.Safe.map_string p f lb in
          match i with
            | 0 ->
              `Input
            | 1 ->
              `Linear
            | 2 ->
              `LinearNoBias
            | 3 ->
              `LSTM
            | 4 ->
              `GRU
            | 5 ->
              `Recurrent
            | 6 ->
              `Conv2D
            | 7 ->
              `Conv3D
            | 8 ->
              `FullyConnected
            | 9 ->
              `MaxPool2D
            | 10 ->
              `AvgPool2D
            | 11 ->
              `Dropout
            | 12 ->
              `Reshape
            | 13 ->
              `Flatten
            | 14 ->
              `Lambda
            | 15 ->
              `Activation
            | 16 ->
              `Add
            | 17 ->
              `Mul
            | 18 ->
              `Dot
            | 19 ->
              `Max
            | 20 ->
              `Average
            | _ -> (
                assert false
              )
        )
      | `Square_bracket -> (
          Yojson.Safe.read_space p lb;
          let f =
            fun s pos len ->
              if pos < 0 || len < 0 || pos + len > String.length s then
                invalid_arg "out-of-bounds substring position or length";
              Ag_oj_run.invalid_variant_tag p (String.sub s pos len)
          in
          let i = Yojson.Safe.map_ident p f lb in
          match i with
            | _ -> (
                assert false
              )
        )
)
let neuron_of_string s =
  read_neuron (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_layer : _ -> layer -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"name\":";
    (
      Yojson.Safe.write_string
    )
      ob x.name;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"neuron\":";
    (
      write_neuron
    )
      ob x.neuron;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"param\":";
    (
      write_param
    )
      ob x.param;
    Bi_outbuf.add_char ob '}';
)
let string_of_layer ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_layer ob x;
  Bi_outbuf.contents ob
let read_layer = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_name = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_neuron = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_param = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 4 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  -1
                )
              )
            | 5 -> (
                if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'm' then (
                  2
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' then (
                  1
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_name := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_neuron := (
              (
                read_neuron
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_param := (
              (
                read_param
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 4 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 'p' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'a' && String.unsafe_get s (pos+4) = 'm' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'o' && String.unsafe_get s (pos+5) = 'n' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_name := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_neuron := (
                (
                  read_neuron
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_param := (
                (
                  read_param
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x7 then Ag_oj_run.missing_fields p [| !bits0 |] [| "name"; "neuron"; "param" |];
        (
          {
            name = !field_name;
            neuron = !field_neuron;
            param = !field_param;
          }
         : layer)
      )
)
let layer_of_string s =
  read_layer (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__6 = (
  Ag_oj_run.write_list (
    write_layer
  )
)
let string_of__6 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__6 ob x;
  Bi_outbuf.contents ob
let read__6 = (
  Ag_oj_run.read_list (
    read_layer
  )
)
let _6_of_string s =
  read__6 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_feedforward : _ -> feedforward -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"name\":";
    (
      Yojson.Safe.write_string
    )
      ob x.name;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"layers\":";
    (
      write__6
    )
      ob x.layers;
    Bi_outbuf.add_char ob '}';
)
let string_of_feedforward ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_feedforward ob x;
  Bi_outbuf.contents ob
let read_feedforward = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_name = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_layers = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 4 -> (
                if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                  0
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 's' then (
                  1
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_name := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_layers := (
              (
                read__6
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 4 -> (
                  if String.unsafe_get s pos = 'n' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 'l' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 'y' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_name := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_layers := (
                (
                  read__6
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "name"; "layers" |];
        (
          {
            name = !field_name;
            layers = !field_layers;
          }
         : feedforward)
      )
)
let feedforward_of_string s =
  read_feedforward (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
