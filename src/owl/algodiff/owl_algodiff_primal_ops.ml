module S = struct

  include Owl_dense_ndarray.S

  module Scalar = Owl_maths

  module Mat = struct

     let eye = Owl_dense_matrix.S.eye

     let tril = Owl_dense_matrix.S.tril

     let triu = Owl_dense_matrix.S.triu

     let diagm = Owl_dense_matrix.S.diagm

  end

  module Linalg = struct

    include Owl_linalg.S

    let qr a =
      let q, r, _ = qr a in
      q, r

    let lq x = lq x

  end

end

module D = struct

  include Owl_dense_ndarray.D

  module Scalar = Owl_maths

  module Mat = struct

     let eye = Owl_dense_matrix.D.eye

     let tril = Owl_dense_matrix.D.tril

     let triu = Owl_dense_matrix.D.triu

     let diagm = Owl_dense_matrix.D.diagm

  end

  module Linalg = struct

    include Owl_linalg.D

    let qr a =
      let q, r, _ = qr a in
      q, r

    let lq x = lq x

  end

end
