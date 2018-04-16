(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Interpolation and Extrapolation *)


let polint xs ys x =
  let n = Array.length xs in
  assert Array.(length ys = n);
  let c = Array.copy ys in
  let d = Array.copy ys in
  let ns = ref 0 in
  let dy = ref 0. in
  let dif = ref (abs_float (x -. xs.(0))) in

  for i = 0 to n - 1 do
    let dift = abs_float (x -. xs.(i)) in
    if dift < !dif then (
      ns := i;
      dif := dift;
    )
  done;

  let y = ref ys.(!ns) in
  ns := !ns - 1;

  for m = 0 to n - 2 do
    for i = 0 to n - m - 2 do
      let ho = xs.(i) -. x in
      let hp = xs.(i + m + 1) -. x in
      let w = c.(i + 1) -. d.(i) in
      let den = ho -. hp in
      assert (den <> 0.);
      let den = w /. den in
      c.(i) <- ho *. den;
      d.(i) <- hp *. den;
    done;

    if (2 * !ns + 2) < (n - m - 1) then
      dy := c.(!ns + 1)
    else (
      dy := d.(!ns);
      ns := !ns - 1;
    );
    y := !y +. !dy;
  done;

  !y, !dy


(* TODO: not tested yet *)
let ratint xs ys x =
  let n = Array.length xs in
  assert Array.(length ys = n);
  let c = Array.copy ys in
  let d = Array.copy ys in

  let hh = ref (abs_float (x -. xs.(0))) in
  let y = ref 0. in
  let dy = ref 0. in
  let ns = ref 0 in
  let eps = 1e-25 in

  try (
    for i = 0 to n do
      let h = abs_float (x -. xs.(i)) in
      if h = 0. then (
        y := ys.(i);
        dy := 0.;
        raise Owl_exception.FOUND
      )
      else if h < !hh then (
        ns := i;
        hh := h;
        c.(i) <- ys.(i);
        d.(i) <- ys.(i) +. eps
      )
    done;

    y := ys.(!ns);
    ns := !ns - 1;

    for m = 1 to n - 1 do
      for i = 1 to n - m do
        let w = c.(i) -. d.(i-1) in
        let h = xs.(i+m-1) -. x in
        let t = (xs.(i-1) -. x) *. d.(i-1) /. h in
        let dd = t -. c.(i) in
        if dd = 0. then failwith "Has a pole";
        let dd = w /. dd in
        d.(i-1) <- c.(i) *. dd;
        c.(i-1) <- t *. dd;
      done;
    done;

    !y, !dy
  )
  with Owl_exception.FOUND -> !y, !dy | e -> raise e
