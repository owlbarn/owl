# How to contribute changes

The following is a set of guidelines for proposing changes to the
OCaml distribution. These are just guidelines, not rules, use your
best judgment and feel free to propose changes to this document itself
in a pull request.

Owl is currently under acive maintain. Besides coding, there are many other
ways you can contribute. Bug reporting, typo fix, ask/answer questions, and
improvement of existing documents are all well appriciated.

## Coding Guidelines

Generally we follow the coding style specified in this file:
http://www.cs.cornell.edu/courses/cs3110/2011sp/Handouts/style.htm

A few more points:

- When using patterns,
1) ormat the code a bit by making two "->" aligned,
2) use the first default `|` explicitly, and
3) the `None` condition should come after `Some` condition. For example:

```ocaml
match l with
  | Some list -> List.map float_of_int list
  | None      -> []
```
- Do not have line longer than 80 columns.
- Use spaces rather than tab.

## Test before a PR

- `utop` provide a convenient environment for playing with `Owl`. However, a piece of code running correctly in `utop` doesn't always mean that it is error-free. Compile the code and run `.native`.

- With the  `zoo` system finished, you can test an example script with `owl` command.

- `make` your code base locally before the PR to ensure no compilation errors.

- If you want to improve a current example of `owl`, make sure its perforamce is no worse than the original one.

- That being said, you are encouraged to use the `zoo` system to share any code snippets in `owl`.

## Documentation

- Make sure the grammar is correct.
