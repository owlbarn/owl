(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


op

let metropolis ?burnin ?thin ?step ~inital ~proposal ~pdf nsamples =
  let step = match step with Some a -> a | None -> 0.1 in
  let burnin = match burnin with Some a -> a | None -> 1000 in
  let thin = match thin with Some a -> a | None -> 10 in

  let p = Array.copy inital in
  let n = burnin + thin * nsamples in
  let s = Array.make n p in
  for i = 0 to n - 1 do
    let p' = Array.map (fun x -> gaussian_rvs ~mu:0. ~sigma:stepsize +. x) p in
    let y, y' = f p, f p' in
    let p' = (
      if y' >= y then p'
      else if std_uniform_rvs () < (y' /. y) then p'
      else Array.copy p ) in
    Array.iteri (fun i x -> p.(i) <- x) p';
    if (i >= burnin) && (i mod thin = 0) then
      s.( (i - burnin) / thin ) <- (Array.copy p)
  done; s
