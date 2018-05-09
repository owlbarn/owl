(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let metropolis ?burnin ?thin ~inital ~proprvs ~proppdf ~pdf nsamples =
  let step = match step with Some a -> a | None -> 0.1 in
  let burnin = match burnin with Some a -> a | None -> 1000 in
  let thin = match thin with Some a -> a | None -> 10 in

  let niter = burnin + thin * nsamples in
  let x = Array.copy inital in
  let samples = Array.make niter x in

  for i = 0 to niter - 1 do
    let x' = Array.map proprvs x in
    let y = f x in
    let y' = f x' in
    let p' = (
      if y' >= y then p'
      else if std_uniform_rvs () < (y' /. y) then p'
      else Array.copy p ) in
    Array.iteri (fun i x -> p.(i) <- x) p';
    if (i >= burnin) && (i mod thin = 0) then
      s.( (i - burnin) / thin ) <- (Array.copy p)
  done;

  s
