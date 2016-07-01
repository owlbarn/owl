
type 'a spmt = {
  m : int;
  n : int;
  i : int array;
  d : 'a array;
  nz : int;
  nzmax : int;
}


let empty m n = {
  m = m; n = n; i = [||]; d = [||]; nz = 0; nzmax = 100;
}
