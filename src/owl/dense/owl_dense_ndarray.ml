(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
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

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x

  let qr x =
    let q, r, _ = Owl_linalg_generic.qr ~thin:true ~pivot:false x in
    (q,r)
  
  let lq x = Owl_linalg_generic.lq ~thin:true x 

  let lyapunov a q = Owl_linalg_generic.lyapunov a q

  let discrete_lyapunov ?(solver=`default) a q = Owl_linalg_generic.discrete_lyapunov ~solver a q

  let linsolve ?(trans=false) ?(typ=`n) a b = Owl_linalg_generic.linsolve ~trans ~typ a b

end


module S = struct
  include Owl_dense_ndarray_s
  include Operator
  module Scalar = Owl_maths

  (* inject function aliases *)

  let inv = Owl_linalg_s.inv

  let logdet = Owl_linalg_s.logdet

  let svd ?(thin=true) = Owl_linalg_s.svd ~thin

  let chol = Owl_linalg_s.chol 

  let mpow = Owl_linalg_s.mpow

  let diagm ?(k=0) x = Owl_dense_matrix_generic.diagm ~k x 

  let eye n = Owl_dense_matrix_s.eye n

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x

  let qr x =
    let q, r, _ = Owl_linalg_s.qr ~thin:true ~pivot:false x in
    (q,r)

  let lq x = Owl_linalg_s.lq ~thin:true x 

  let lyapunov = Owl_linalg_s.lyapunov

  let discrete_lyapunov ?(solver=`default) a q = Owl_linalg_s.discrete_lyapunov ~solver a q

  let linsolve ?(trans=false) ?(typ=`n) a b = Owl_linalg_s.linsolve ~trans ~typ a b

end


module D = struct
  include Owl_dense_ndarray_d
  include Operator
  module Scalar = Owl_maths

  (* inject function aliases *)

  let inv = Owl_linalg_d.inv

  let logdet = Owl_linalg_d.logdet

  let svd ?(thin=true) = Owl_linalg_d.svd ~thin
              
  let chol = Owl_linalg_d.chol 

  let mpow = Owl_linalg_d.mpow

  let diagm ?(k=0) x = Owl_dense_matrix_generic.diagm ~k x 

  let eye n = Owl_dense_matrix_d.eye n

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x

  let qr x =
    let q, r, _ = Owl_linalg_d.qr ~thin:true ~pivot:false x in
    (q,r)

  let lq x = Owl_linalg_d.lq ~thin:true x 

  let lyapunov = Owl_linalg_d.lyapunov

  let discrete_lyapunov ?(solver=`default) a q = Owl_linalg_d.discrete_lyapunov ~solver a q

  let linsolve ?(trans=false) ?(typ=`n) a b = Owl_linalg_d.linsolve ~trans ~typ a b
end


module C = struct
  include Owl_dense_ndarray_c
  include Operator

  (* inject function aliases *)

  let inv = Owl_linalg_c.inv

  let mpow = Owl_linalg_c.mpow

  let eye n = Owl_dense_matrix_c.eye n

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x

  let qr x =
    let q, r, _ = Owl_linalg_c.qr ~thin:true ~pivot:false x in
    (q,r)

  let lq x = Owl_linalg_c.lq ~thin:true x 

  let lyapunov = Owl_linalg_c.lyapunov

  let discrete_lyapunov ?(solver=`default) a q = Owl_linalg_c.discrete_lyapunov ~solver a q

  let linsolve ?(trans=false) ?(typ=`n) a b = Owl_linalg_c.linsolve ~trans ~typ a b
end


module Z = struct
  include Owl_dense_ndarray_z
  include Operator

  (* inject function aliases *)

  let inv = Owl_linalg_z.inv

  let mpow = Owl_linalg_z.mpow

  let eye n = Owl_dense_matrix_z.eye n

  let tril ?(k=0) x = Owl_dense_matrix_generic.tril ~k x

  let triu ?(k=0) x = Owl_dense_matrix_generic.triu ~k x

  let qr x =
    let q, r, _ = Owl_linalg_z.qr ~thin:true ~pivot:false x in
    (q,r)

  let lq x = Owl_linalg_z.lq ~thin:true x 

  let lyapunov = Owl_linalg_z.lyapunov 

  let discrete_lyapunov ?(solver=`default) a q = Owl_linalg_z.discrete_lyapunov ~solver a q

  let linsolve ?(trans=false) ?(typ=`n) a b = Owl_linalg_z.linsolve ~trans ~typ a b
end


module Any = struct
  include Owl_dense_ndarray_a
end
