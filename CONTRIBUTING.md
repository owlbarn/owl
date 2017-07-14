todo ...


Coding style:

Generally we follow the coding style specified in this file:
http://www.cs.cornell.edu/courses/cs3110/2011sp/Handouts/style.htm

A few more points:

- When using patterns, 1) ormat the code a bit by making two "->" aligned, 2) use the first default `|` explicitly, and 3) the `None` condition should come after `Some` condition. For example:

```ocaml
match l with
  | Some list -> List.map float_of_int list
  | None      -> []
```
