module S = struct
  include Owl_dense_ndarray.S
  module Scalar = Owl_maths
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
  module Linalg = struct
    include Owl_linalg.D
    let qr a =
      let q, r, _ = qr a in
      q, r
    let lq x = lq x
  end
end
