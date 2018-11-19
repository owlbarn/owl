(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Ndarray: module aliases *)


module Operator = struct
  include Owl_operator.Make_Basic (Owl_dense_ndarray_generic)
  include Owl_operator.Make_Extend (Owl_dense_ndarray_generic)
  include Owl_operator.Make_Ndarray (Owl_dense_ndarray_generic)
end


module Generic = struct
  include Owl_dense_ndarray_generic
  include Operator

  (* inject function aliases *)

  let inv = Owl_linalg_generic.inv

  let mpow = Owl_linalg_generic.mpow

  let qr x =
    let q, r, _ = Owl_linalg_generic.qr ~thin:true ~pivot:false x in
    (q,r)

end


module S = struct
  include Owl_dense_ndarray_s
  include Operator
  module Scalar = Owl_maths

  (* inject function aliases *)

  let inv = Owl_linalg_s.inv

  let mpow = Owl_linalg_s.mpow

  let qr x =
    let q, r, _ = Owl_linalg_s.qr ~thin:true ~pivot:false x in
    (q,r)

end


module D = struct
  include Owl_dense_ndarray_d
  include Operator
  module Scalar = Owl_maths

  (* inject function aliases *)

  let inv = Owl_linalg_d.inv

  let mpow = Owl_linalg_d.mpow

  let qr x =
    let q, r, _ = Owl_linalg_d.qr ~thin:true ~pivot:false x in
    (q,r)

end


module C = struct
  include Owl_dense_ndarray_c
  include Operator

  (* inject function aliases *)

  let inv = Owl_linalg_c.inv

  let mpow = Owl_linalg_c.mpow

  let qr x =
    let q, r, _ = Owl_linalg_c.qr ~thin:true ~pivot:false x in
    (q,r)

end


module Z = struct
  include Owl_dense_ndarray_z
  include Operator

  (* inject function aliases *)

  let inv = Owl_linalg_z.inv
  
  let mpow = Owl_linalg_z.mpow

  let qr x =
    let q, r, _ = Owl_linalg_z.qr ~thin:true ~pivot:false x in
    (q,r)

end


module Any = struct
  include Owl_dense_ndarray_a
end
