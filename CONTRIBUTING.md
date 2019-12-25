# How to Contribute

Owl is a large open source project, to guarantee quality of the software and sustainable development, we enforce the following rules in day-to-day research, development, and project mangement.

Besides coding, there are many other ways you can contribute. Bug reporting, typo fix, asking/answering questions, and improvement of existing documents are all well welcome.


## Coding Style

Coding style guarantees a consistent taste of code written by different people. It improves code readability and maintainability in large software projects. 

- OCaml is the main developing language in Owl. We use [ocamlformat](https://github.com/ocaml-ppx/ocamlformat) to enforce the style of OCaml code. 

- There is also a significant amount of C code in the project. For the C code, we apply the [Linux kernel coding style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html). 

- The coding style does not apply to the vendor's code direcly imported into Owl source code tree.


## Unit Tests

All the code must be well tested before submitting a pull request.

- If existing functions are modified, you need to run the unit tests to make sure the changes do not break any tests.

- If existing functions are modified, you may also need to add more unit tests for various edge cases which are not covered before.

- If new functions are added, you must add corresponding unit tests and make sure edge cases are well covered.


## Pull Requests

- Minor improvement changes can be submitted directly in a pull request. The title and description of the pull request shall clearly describe the purpose of the PR, potential issues and caveats.

- For significant changes, please first submit a proposal on Owl's [issue tracker](https://github.com/ryanrhymes/owl/issues) to initialise the discussion with Owl Team.

- For sub libraries building atop of Owl, if you want the library to be included in the owlbarn organisation, please also submit the proposal on issue tracker. Note that the license of the library must be compliant with owlbarn, i.e. MIT or BSD compliant. Exception is possible but must be discussed with Owl Team first.

- Pull requests must be reviewed and approved by at least two key developers in Owl Team. A designated person in Owl Team will be responsible for assigning reviewers, tagging a pull request, and final merging to the master branch.


## Documentation

For inline documentation in the code, the following rules apply.

- Be concise, simple, and correct.
- Make sure the grammar is correct.
- Refer to the original paper whenever possible.
- Use both long documentation in `mli` and short inline documentation in code.

For serious technical writing, please contribute to Owl's [Tutorial Book](https://github.com/owlbarn/owl_tutorials).

- Fixing typos, grammar issues, broken links, and improving tutorial tooling are considered as minor changes. You can submit pull requests directly to Tutorial Book reporsitory.

- Extending existing chapters are medium changes and you need to submit a proposal to Tutorial Book issue tracker.

- Contributing a standalone chapter also requires submitting a chapter proposal. Alternatively, you can write to [me](ryanrhymes@gmail.com) directly to discuss about the chapter.


## Agreement on Commits

You must read the following agreement before committing any code to Owl's repository. You should use `git commit -s` to sign off your commits. If omitted, we will assume you have agreed with with the DCO and implicitly signed off.

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


## Becoming A Team Memeber

Owl Team is open and always welcomes new members to join. If you are enthusiastic about scientific computing and numerical algorithms, you can be one of us. As a team member, you need to be aware of the following things.

- You will be included in the [owlbarn organisation](https://github.com/owlbarn).

- You will have access to Team Channel on Slack and join the R&D discussion. Your opinions matter in Owl's future roadmap.

- You need to be responsible for one aspect (or one or multiple related modules) in Owl and lead its development. E.g. Jianxin is responsible core tensor operations and symbolic maths; Calvin focusses on Algodiff.

- You need to review the pull requests related to the area you are specialised in.

- We value persistence. Being a team member requires you actively get involved in maintaining Owl and contributing to its code base. The team membership becomes invalidated automatically if your contributions cease.

- Team memebership is considered after you have made some significant contributions to Owl's code base or its ecosystem. You can always drop [me](ryanrhymes@gmail.com) a line to discuss.

