# Implementing and evaluating sublinear algorithms in Owl
## Pratap Singh, Summer 2019, CSE @ IIT Madras



### June 3
- Forked Owl repository (https://github.com/pratapsingh1729/owl).  
- Compile files using `make && make install`.  The second is required to install all commands on the local system as if from opam.
- Ran example scripts.  Ran into issues with `computation_graph_*.ml`, `opencl_*.ml`, `regression.ml` due to not being able to load required modules from `Owl_base`, `Owl_plplot`.  Can work around by running in utop.
- Issue with `newton_method.ml`: 
  ```
  Exception: Failure "cos : [DR tag:3 ap:Arr(1,2)]".
  ```  
  Not sure how to debug this yet.
- The Docker image seems to have an old version of the code using jbuild instead of dune

### June 4
- Repo structure has changed - need to `open Owl_plplot` to get plot code.  However, `regression.ml` gives
  ```
  Exception: Failure "neg : [DR tag:5 ap:F(0.0736766)]".
  ```
- Need to update examples
- Module `Plot` is now found under `Owl_plplot`.

### June 5
- Asked about `regression.ml` bug on Owl slack, Jianxin fixed the issue (https://github.com/owlbarn/owl/pull/411).
- Rewrote `test_log.ml` to work.  Required parsing the output of `Owl.Regression.D.logistic` essentially by analogy to `svm.ml`.
- The `owl` command still doesn't properly link module `Owl_plplot`!  
