# Owl - OCaml Scientific Computing 
[![build](https://github.com/owlbarn/owl/actions/workflows/main.yml/badge.svg)](https://github.com/owlbarn/owl/actions/workflows/main.yml)
[![build](https://github.com/owlbarn/owl/actions/workflows/deploy_docker.yml/badge.svg)](https://github.com/owlbarn/owl/actions/workflows/deploy_docker.yml)
[![build](https://github.com/owlbarn/owl/actions/workflows/os.yml/badge.svg)](https://github.com/owlbarn/owl/actions/workflows/os.yml)

Owl is a dedicated system for scientific and engineering computing. The system is developed in OCaml and licensed under MIT. The project is originated by [Liang Wang](https://liang.ocaml.xyz) and currently led by [Jianxin Zhao](https://jianxin.ocaml.xyz). The history of the project can be seen on the [Wikipedia](https://en.wikipedia.org/wiki/Owl_Scientific_Computing) page.

## Functionalities 

Owl provides a wide range of scientific computing functionalities: 

- mathematical function, from the basic `log`, `sin` etc., to special functions such as the Beta and Gamma functions
- integration; interpolation and extrapolation
- statistics and probability; e.g. generation of random number and various distributions 
- various computation on n-dimensional arrays (tensors), including advanced slicing and broadcasting 
- linear algebra
- ordinary differential equations 
- discrete Fourier Transform algorithms for signal processing 
- algorithmic differentiation, or automatic differentiation
- various optimization algorithms
- regression algorithms
- deep neural network and natural language processing with the optional support of computation graph optimization
- dataframe processing
- visualization (with the help of external package `owl-plot`)

## Installation

Please follow the [tutorial](https://ocaml.xyz/tutorial/chapters/introduction.html) about installing Owl. You can also start by trying the [docker images](https://hub.docker.com/r/matrixanger/owl). 

## Mission

Our mission is to push the frontier of high-performance scientific computing, provide both researchers and industry programmers a powerful framework to write concise, fast and safe analytical code. The system aims to serve as the de-facto tool for computation intensive tasks in OCaml.
Owl is the de-facto scientific computing library in OCaml. Currently we aim to actively maintain it and keep it stable, utilizing the limited time and human resource we have.

The current code base is designed to be concise and self-contained. 
We encourage anyone who would like to build up their own tools based on Owl to create new repositories in the [Owlbarn](https://github.com/owlbarn) organization. 

## Owl Code Structure 

To help potential developers to understand the structure of Owl, here we briefly describe its overall design. More detailed description can be found in the [documentation](https://ocaml.xyz/docs/) and the Owl [books](https://ocaml.xyz/).

![Owl architecture 1](examples/owl-structure1.svg)

Owl provides a basic data structure for modern numerical computing: n-dimensional array (Ndarray). It is based on the mathematics, linear algebra, and statistics functions, which are built on both OCaml and C functions and libraries. 

![Owl architecture 2](examples/owl-structure2.svg)

Sharing the same set of interface with Ndarray is the `base` system data architecture, which is implemented in pure OCaml. It is also based on modules that are implemented in OCaml. However, though it is sufficient for daily use for normal computing, the base version Ndarray does not implement some advanced functions as in the previous Owl version Ndarray, and its performance is understandably much slower.

![Owl architecture 3](examples/owl-structure3.svg)

Besides these two types of Ndarray, another type is CGraph-Ndarray, which can be used to support symbolic style computing like TensorFlow v1. It facilitate building computation graph and computation optimization. 
The CGraph-Ndarray can be built up by wrapping up either of the previous two types of Ndarray, which are used for actual execution of computing.
All three types of Ndarray can be used to support advanced computing modules, including algorithmic differentiation, optimization, and neural networks.


## Code of Contributing 

In principle any change to the code base is made via a GitHub Pull Request (PR). Pull requests must be reviewed and approved by at least two key developers in the Owl Team.

Team members are responsible for the issues and PRs concerning the domain aspects they claim, and are also responsible for fixing the problems caused by accepting such PRs.

If a PR is large or involves significant update or changes to the code structure, an issue should be submitted for the community and team members to discuss, and it then can be decided by the corresponding team member and project leader.

If an issue or PR does not belong to any team member's domain aspect, the response will also be on a best-effort basis with no guaranteed response time. 

Please check the full [contributing rules](CONTRIBUTING.md) and [code of conduct](CODE_OF_CONDUCT.md) of the Owl project for more detail. 

## Community 

The Owl community is based on the [OCaml Discourse](https://discuss.ocaml.org/) and [Owl Slack channel](https://owl-dev-team.slack.com/).  All participants in the community are encouraged to provide support for new users within the project management infrastructure. Those seeking technical support should also recognize that all support activities within the project is voluntary and is therefore provided as and when time permits.