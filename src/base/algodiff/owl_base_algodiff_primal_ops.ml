module S = struct
  include Owl_base_dense_ndarray.S
  module Scalar = Owl_base_maths

  module Mat = struct
    let eye = Owl_base_dense_matrix_s.eye

    let tril = Owl_base_dense_matrix_s.tril

    let triu = Owl_base_dense_matrix_s.triu

    let diagm = Owl_base_dense_matrix_s.diagm
  end

  module Linalg = struct
    include Owl_base_linalg_s

    let qr a =
      let q, r, _ = qr a in
      q, r


    let lq x = lq x
  end
end

module D = struct
  include Owl_base_dense_ndarray_d
  module Scalar = Owl_base_maths

  module Mat = struct
    let eye = Owl_base_dense_matrix_d.eye

    let tril = Owl_base_dense_matrix_d.tril

    let triu = Owl_base_dense_matrix_d.triu

    let diagm = Owl_base_dense_matrix_d.diagm
  end

  module Linalg = struct
    include Owl_base_linalg_d

    let qr a =
      let q, r, _ = qr a in
      q, r


    let lq x = lq x
  end
end
