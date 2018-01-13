(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


external shuffle : 'a array -> unit = "owl_stats_stub_shuffle"

external choose : src:'a array -> dst:'a array -> unit = "owl_stats_stub_choose"

external sample : src:'a array -> dst:'a array -> unit = "owl_stats_stub_sample"
