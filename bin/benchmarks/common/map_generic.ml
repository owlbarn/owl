module type SizeSig = sig
  val size : int
end


module Make(M : Owl_types.Ndarray_Basic) = struct
  module MakeOfSize(Size : SizeSig) = struct

    let f0 = (fun _ -> 0.)
    let f1 = (fun _ -> 1.)
    let f2 = (fun x -> x +. 11.)
    let f3 = (fun x -> x *. 2.)
    let f4 = (fun x -> x /. 2.)

    let funs = [f0; f1; f2; f3; f4]

    let v = ref (M.empty [|Size.size|])

    let _ =
      begin
        for rep = 0 to 10 do
          List.iter (fun f -> v := M.map f !v) funs
        done
      end

    let _ = Printf.printf "done!\n"

  end
end
