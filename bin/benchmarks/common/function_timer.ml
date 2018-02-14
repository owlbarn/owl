let time_function f =
  let start_time = Sys.time () in
  let result = f () in
  let end_time = Sys.time () in
  Printf.printf "Execution time: %f seconds\n" (end_time -. start_time);
  result
