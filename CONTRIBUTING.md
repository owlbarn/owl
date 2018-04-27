# How to Contribute

The following is a set of guidelines for proposing changes to the
OCaml distribution. These are just guidelines, not rules, use your
best judgment and feel free to propose changes to this document itself
in a pull request.

Owl is currently under active maintaining. Besides coding, there are many other
ways you can contribute. Bug reporting, typo fix, asking/answering questions,
and improvement of existing documents are all well appreciated.


## Coding Guidelines

Generally we follow the coding style specified in this file:
http://www.cs.cornell.edu/courses/cs3110/2011sp/Handouts/style.htm

A few more points:

- When using patterns,
1) format the code a bit by making two "->" aligned,
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

- `utop` provides a convenient environment for playing with `Owl`. However, a
piece of code running correctly in `utop` doesn't always mean that it is
error-free. Compile the code and run `.native`.

- With the  `zoo` system finished, you can test an example script with `owl`
command.

- `make` your code base locally before the PR to ensure no compilation errors.

- If you want to improve a current example of `owl`, make sure its perforamce
is no worse than the original one.

- That being said, you are encouraged to use the `zoo` system to share any code
snippets in `owl`.

- Keep corner cases in mind. For example, does your code also work for complex
 +numbers?


## Submit a Proposal

Before you start implementing something, especially something significant.
Please submit a proposal first on
[owl's issue tracker](https://github.com/ryanrhymes/owl/issues). This first
can ensure you get enough support from me in the following development. Second,
this avoids unnecessary duplicated work in case someone else already started
working the same feature, which indeed happened before. Last, you may find
someone who is willing to help you in tackling the the problem together.

The format of the proposal aims to be light: state what algorithm/feature you
want to contribute to which module. In case something more significant that
can be a standalone module, please also briefly specify the included functions,
although these can be subject to changes in future implementation.


## Documentation

- Be concise, simple, and correct.
- Make sure the grammar is correct.
- Refer to the original paper whenever possible.
- Use both long documentation in `mli` and short inline documentation in code.


## Agreement on Commits

This is a must read before committing your code to Owl's repository. You should
use `git commit -s` to sign off your commits. If omitted, I will assume you are
complied with DCO and implicitly signed off.

```text
Developer's Certificate of Origin 1.1

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or

(b) The contribution is based upon previous work that, to the best
    of my knowledge, is covered under an appropriate open source
    license and I have the right under that license to submit that
    work with modifications, whether created in whole or in part
    by me, under the same open source license (unless I am
    permitted to submit under a different license), as indicated
    in the file; or

(c) The contribution was provided directly to me by some other
    person who certified (a), (b) or (c) and I have not modified
    it.

(d) I understand and agree that this project and the contribution
    are public and that a record of the contribution (including all
    personal information I submit with it, including my sign-off) is
    maintained indefinitely and may be redistributed consistent with
    this project or the open source license(s) involved.
```
