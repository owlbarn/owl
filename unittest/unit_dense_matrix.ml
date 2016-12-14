(* Build with `ocamlbuild -pkg alcotest simple.byte` *)

let matrix = Alcotest.testable Fmt.float Owl.Dense.Matrix.is_equal

(* A module with functions to test *)
module To_test = struct
  let capit letter = Char.uppercase letter
  let plus int_list = List.fold_left (fun a b -> a + b) 0 int_list
end

(* The tests *)
let capit () =
  Alcotest.(check char) "same chars"  'A' (To_test.capit 'a')

let plus () =
  Alcotest.(check int) "same ints" 7 (To_test.plus [1;1;2;3])

let test_set = [
  "Capitalize" , `Quick, capit;
  "Add entries", `Slow , plus ;
]

(* Run it *)
let () =
  Alcotest.run "My first test" [
    "test_set", test_set;
  ]
