# How to Contribute

Owl is a large open source project, to guarantee quality of the software and sustainable development, we enforce the following rules in day-to-day research, development, and project management.
Besides coding, there are many other ways you can contribute. Bug reporting, typo fix, asking/answering questions, and improvement of existing documents are all well welcome.

## Owl Team 

To achieve our mission, we are assembling an *Owl Team*. Anyone who can potentially give sufficient contributions recognized by the community can request to be a team member.
A team member is expected to make several valuable and significant contributions to the project in both quality and quantity. 
Typically a committer focuses on one specific aspect of the project and is a domain expert. 
We hope but cannot guarantee that the team members can cover all aspects of the code base.


Emphasis are put on the responsibility of each team member.
Each one should take responsibility of certain aspects of the code base, e.g. a module or maintenance for a specific OS platform.
Team members, together with their domain aspects and responsibilities, will be listed here and also on the [Owl website](https://ocaml.xyz/).

For anyone who is willing to contribute, some good starting points could be:
- Participate in discussion in issues, and help to fix them
- Fix [documentations](https://ocaml.xyz/docs/), mainly by changing the `.mli` files in the source code, based on which the documentations are generated
- Fix [tutorials](https://ocaml.xyz/tutorial/); the code could be not runnable, or the content could not display properly
- Add more examples and tests
- Fix issues listed in the [TODO list](https://github.com/orgs/owlbarn/projects/2/views/2)
- Propose to fix/improve anything that interests you during using Owl
- ... 

**Current team member:**

- [@jzstark](https://github.com/jzstark): Project leader. Manage overall architecture, roadmap，and tech vision. Community communication. Set research agenda.
- [@ryanrhymes](https://github.com/ryanrhymes): Potential commercialization, business opportunity & funding seeking.


## Coding Style

Coding style guarantees a consistent taste of code written by different people. It improves code readability and maintainability in large software projects. 

- OCaml is the main developing language in Owl. We use [ocamlformat](https://github.com/ocaml-ppx/ocamlformat) to enforce the style of OCaml code. 

- There is also a significant amount of C code in the project. For the C code, we apply the [Linux kernel coding style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html). 

- The coding style does not apply to the vendor's code directly imported into Owl source code tree.


## Unit Tests

All the code must be well tested before submitting a pull request.

- If existing functions are modified, you need to run the unit tests to make sure the changes do not break any tests.

- If existing functions are modified, you may also need to add more unit tests for various edge cases which are not covered before.

- If new functions are added, you must add corresponding unit tests and make sure edge cases are well covered.


## Pull Requests

- Minor improvement changes can be submitted directly in a pull request. The title and description of the pull request shall clearly describe the purpose of the PR, potential issues and caveats.

- For significant changes, please first submit a proposal on Owl's [issue tracker](https://github.com/owlbarn/owl/issues) to initialise the discussion with Owl Team.

- For sub libraries building atop of Owl, if you want the library to be included in the owlbarn organisation, please also submit the proposal on issue tracker. Note that the license of the library must be compliant with owlbarn, i.e. MIT or BSD compliant. Exception is possible but must be discussed with Owl Team first.

- Pull requests must be reviewed and approved by at least two key developers in Owl Team. A designated person in Owl Team will be responsible for assigning reviewers, tagging a pull request, and final merging to the master branch.


## Documentation

For inline documentation in the code, the following rules apply.

- Be concise, simple, and correct.
- Make sure the grammar is correct.
- Refer to the original paper whenever possible.
- Use both long documentation in `mli` and short inline documentation in code.

For serious technical writing, please contribute to Owl's [Tutorial Book](https://github.com/owlbarn/owl_tutorials).

- Fixing typos, grammar issues, broken links, and improving tutorial tooling are considered as minor changes. You can submit pull requests directly to Tutorial Book repository.

- Extending existing chapters are medium changes and you need to submit a proposal to Tutorial Book issue tracker.

- Contributing a standalone chapter also requires submitting a chapter proposal. Alternatively, you can write to [me](rho.ajax@gmail.com) directly to discuss about the chapter.


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