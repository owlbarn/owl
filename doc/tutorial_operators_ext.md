This tutorial will go through the operators and `Ext` module. The operators in Owl are implemented using functors. However, you do not need to work with functors directly in order to use the operators.


## Basic Operators

The operators have been included in each `Ndarray` and `Matrix` module. The following table summarises the operators currently implemented in Owl. In the table, both `x` and `y` represent either a matrix or an ndarray while `a` represents a scalar value.

| Operator | Example      | Operation         | Dense/Sparse | Ndarray/Matrix |
|:--------:|:------------:|:-----------------:|:------------:|:--------------:|
| `+`      | `x + y`      | element-wise add  | both         | both           |
| `-`      | `x - y`      | element-wise sub  | both         | both           |
| `*`      | `x * y`      | element-wise mul  | both         | both           |
| `/`      | `x / y`      | element-wise div  | both         | both           |
| `+$`     | `x +$ a`     | add scalar        | both         | both           |
| `-$`     | `x -$ a`     | sub scalar        | both         | both           |
| `*$`     | `x *$ a`     | mul scalar        | both         | both           |
| `/$`     | `x /$ a`     | div scalar        | both         | both           |
| `$+`     | `a $+ x`     | scalar add        | both         | both           |
| `$-`     | `a $- x`     | scalar sub        | both         | both           |
| `$*`     | `a $* x`     | scalar mul        | both         | both           |
| `$/`     | `a $/ x`     | scalar div        | both         | both           |
| `=`      | `x = y`      | comparison        | both         | both           |
| `!=`     | `x != y`     | comparison        | both         | both           |
| `<>`     | `x <> y`     | same as `!=`      | both         | both           |
| `>`      | `x > y`      | comparison        | both         | both           |
| `<`      | `x < y`      | comparison        | both         | both           |
| `>=`     | `x >= y`     | comparison        | both         | both           |
| `<=`     | `x <= y`     | comparison        | both         | both           |
| `=.`     | `x =. y`     | element-wise cmp  | Dense        | both           |
| `!=.`    | `x !=. y`    | element-wise cmp  | Dense        | both           |
| `<>.`    | `x <>. y`    | same as `!=.`     | Dense        | both           |
| `>.`     | `x >. y`     | element-wise cmp  | Dense        | both           |
| `<.`     | `x <. y`     | element-wise cmp  | Dense        | both           |
| `>=.`    | `x >=. y`    | element-wise cmp  | Dense        | both           |
| `<=.`    | `x <=. y`    | element-wise cmp  | Dense        | both           |
| `=$`     | `x =$ y`     | comp to scalar    | Dense        | both           |
| `!=$`    | `x !=$ y`    | comp to scalar    | Dense        | both           |
| `<>$`    | `x <>$ y`    | same as `!=`      | Dense        | both           |
| `>$`     | `x >$ y`     | compare to scalar | Dense        | both           |
| `<$`     | `x <$ y`     | compare to scalar | Dense        | both           |
| `>=$`    | `x >=$ y`    | compare to scalar | Dense        | both           |
| `<=$`    | `x <=$ y`    | compare to scalar | Dense        | both           |
| `=.$`    | `x =.$ y`    | element-wise cmp  | Dense        | both           |
| `!=.$`   | `x !=.$ y`   | element-wise cmp  | Dense        | both           |
| `<>.$`   | `x <>.$ y`   | same as `!=.$`    | Dense        | both           |
| `>.$`    | `x >.$ y`    | element-wise cmp  | Dense        | both           |
| `<.$`    | `x <.$ y`    | element-wise cmp  | Dense        | both           |
| `>=.$`   | `x >=.$ y`   | element-wise cmp  | Dense        | both           |
| `<=.$`   | `x <=.$ y`   | element-wise cmp  | Dense        | both           |
| `%`      | `x % y`      | mod divide        | Dense        | both           |
| `%$`     | `x %$ a`     | mod divide scalar | Dense        | both           |
| `**`     | `x ** y`     | power function    | Dense        | both           |
| `*@`     | `x *@ y`     | matrix multiply   | both         | Matrix         |
| `min2`   | `min2 x y`   | element-wise min  | both         | only `S`, `D`  |
| `max2`   | `max2 x y`   | element-wise max  | both         | only `S`, `D`  |

There are a list of things worth your attention as below.

- `*` is for element-wise multiplication; `*@` is for matrix multiplication. You can easily understand the reason if you read the source code of [`Algodiff`](https://github.com/ryanrhymes/owl/blob/master/lib/owl_algodiff_generic.ml) module. Using `*` for element-wise multiplication (for matrices) leads to the consistent implementation of algorithmic differentiation.

- `+$` has its corresponding operator `$+` if we flip the order of parameters. However, be very careful about the operator precedence since OCaml determines the precedence based on the first character of an infix. `+$` preserves the precedence whereas `$+` does not. Therefore, I do not recommend using `$+`. If you do use it, please use parentheses to explicitly specify the precedence. The same argument also applies to `-$`, `*$`, and `/$`.

- For comparison operators, e.g. both `=` and `=.` compare all the elements in two variables `x` and `y`. The difference is that `=` returns a boolean value whereas `=.` returns a matrix or ndarray of the same shape and same type as `x` and `y`. In the returned result, the value in a given position is `1` if the values of the corresponding position in `x` and `y` satisfy the predicate, otherwise it is `0`.

- For the comparison operators ended with `$`, they are used to compare a matrix/ndarray to a scalar value.

Operators are easy to use, here are some examples.

```ocaml
let x = Mat.uniform 5 5;;
let y = Mat.uniform 5 5;;

Mat.(x + y);;
Mat.(x * y);;
Mat.(x ** y);;
Mat.(x *@ y);;

...

(* please compare the returns of the following two examples *)
Mat.(x > y);;
Mat.(x >. y);;
```


## Extension Module

As you can see, operators above does not allow interoperation on different number types. E.g., you cannot add a `float32` matrix to `float64` matrix unless you explicitly call the `cast` functions in `Generic` module [(read this)](https://github.com/ryanrhymes/owl/wiki/Tutorial:-Basic-Data-Types#casting-into-another-type). It may become a bit annoying when you just want to do some simple experiments in `utop` since you need to type more code.

`Owl.Ext` module is specifically designed for this purpose, to make prototyping faster and easier. Once you open the module, `Ext` immediately provides a set of operators to allow you to interoperate on different number types, as below. It automatically casts types for you if necessary.

| Operator | Example      | Operation               |
|:--------:|:------------:|:-----------------------:|
| `+`      | `x + y`      | add                     |
| `-`      | `x - y`      | sub                     |
| `*`      | `x * y`      | mul                     |
| `/`      | `x / y`      | div                     |
| `=`      | `x = y`      | comparison, return bool |
| `!=`     | `x != y`     | comparison, return bool |
| `<>`     | `x <> y`     | same as `!=`            |
| `>`      | `x > y`      | comparison, return bool |
| `<`      | `x < y`      | comparison, return bool |
| `>=`     | `x >= y`     | comparison, return bool |
| `<=`     | `x <= y`     | comparison, return bool |
| `=.`     | `x =. y`     | element_wise comparison |
| `!=.`    | `x !=. y`    | element_wise comparison |
| `<>.`    | `x <>. y`    | same as `!=.`           |
| `>.`     | `x >. y`     | element_wise comparison |
| `<.`     | `x <. y`     | element_wise comparison |
| `>=.`    | `x >=. y`    | element_wise comparison |
| `<=.`    | `x <=. y`    | element_wise comparison |
| `%`      | `x % y`      | element_wise mod divide |
| `**`     | `x ** y`     | power function          |
| `*@`     | `x *@ y`     | matrix multiply         |
| `min2`   | `min2 x y`   | element-wise min        |
| `max2`   | `max2 x y`   | element-wise max        |


You may have noticed, the operators ended with `$` (e.g., `+$`, `-$` ...) disappeared from the table, which is simply because we can add/sub/mul/div a scalar with a matrix directly and we do not need these operators any more. Similar for comparison operators, because we can use the same `>` operator to compare a matrix to another matrix, or compare a matrix to a scalar, we do not need `>$` any longer. Allowing interoperation makes the operator table much shorter.

Currently, the operators in `Ext` only support interoperation on dense structures. Besides binary operators, `Ext` also implements most of the common math functions which can be applied to float numbers, complex numbers, matrices, and ndarray. These functions are:

`im`; `re`; `conj`, `abs`, `abs2`, `neg`, `reci`, `signum`, `sqr`, `sqrt`, `cbrt`, `exp`, `exp2`, `expm1`, `log`, `log10`, `log2`, `log1p`, `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `sinh`, `cosh`, `tanh`, `asinh`, `acosh`, `atanh`, `floor`, `ceil`, `round`, `trunc`, `erf`, `erfc`, `logistic`, `relu`, `softplus`, `softsign`, `softmax`, `sigmoid`, `log_sum_exp`, `l1norm`, `l2norm`, `l2norm_sqr`, `inv`, `trace`, `sum`, `prod`, `min`, `max`, `minmax`, `min_i`, `max_i`, `minmax_i`.


Note that `Ext` contains its own `Ext.Dense` module which further contains the following submodules.

- `Ext.Dense.Ndarray.S`
- `Ext.Dense.Ndarray.D`
- `Ext.Dense.Ndarray.C`
- `Ext.Dense.Ndarray.Z`
- `Ext.Dense.Matrix.S`
- `Ext.Dense.Matrix.D`
- `Ext.Dense.Matrix.C`
- `Ext.Dense.Matrix.Z`

These modules are simply the wrappers of the original modules in `Owl.Dense` module so they provide most of the APIs already implemented. The extra thing these wrapper modules does it to pack and unpack the raw number types for you automatically. However, you can certainly use the raw data types then use the constructors defined in [Owl_ext_types](https://github.com/ryanrhymes/owl/blob/master/lib/ext/owl_ext_types.ml) to wrap them up by yourself. The constructors are defined as below.

```ocaml
type ext_typ =
  | F   of float
  | C   of Complex.t
  | DMS of dms
  | DMD of dmd
  | DMC of dmc
  | DMZ of dmz
  | DAS of das
  | DAD of dad
  | DAC of dac
  | DAZ of daz
  | SMS of sms
  | SMD of smd
  | SMC of sms
  | SMZ of smd
  | SAS of sas
  | SAD of sad
  | SAC of sac
  | SAZ of saz
```

There are also corresponding `packing` and `unpacking` functions you can use, please read [owl_ext_types.ml](https://github.com/ryanrhymes/owl/blob/master/lib/ext/owl_ext_types.ml) for more details.


Before we finish this tutorial, let's see some examples to understand how convenient it is to use `Ext` module.

```ocaml
open Owl.Ext;;

let x = Dense.Matrix.S.uniform 5 5;;
let y = Dense.Matrix.C.uniform 5 5;;
let z = Dense.Matrix.D.uniform 5 5;;

x + F 5.;;
x * C Complex.({re = 2.; im = 3.});;
x - y;;
x / y;;
x *@ y;;

...

x > z;;
x >. z;;
(x >. z) * x;;
(x >. F 0.5) * x;;
(F 10. * x) + y *@ z;;

...

round (F 10. * (x *@ z));;
sin (F 5.) * cos (x + z);;
tanh (x * F 10. - z);;

...
```

Happy hacking, and enjoy Owl!
