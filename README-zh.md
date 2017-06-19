# Owl - OCaml 数值计算库

Owl 是一个数值计算库。 它支持稠密或稀疏矩阵操作，线性代数，回归，快速傅里叶变换，以及许多高级数学和统计功能（比如马尔可夫链和蒙特卡洛方法）。Owl实现了算法微分，在其基础上开发机器学习及神经网络算法将会非常简便。[![Travis build 状态](https://travis-ci.org/ryanrhymes/owl.svg?branch=master)](https://travis-ci.org/ryanrhymes/owl)

完整的API文档请参见：

* on [mirage.io](http://docs.mirage.io/owl/index.html)
* on [cam.ac.uk](http://www.cl.cam.ac.uk/~lw525/owl/)

新手入门教程如下（英文，持续更新中）：

* [教程一：基本数据类型](https://github.com/ryanrhymes/owl/wiki/Tutorial:-Basic-Data-Types)
* [教程二：N维数组](https://github.com/ryanrhymes/owl/wiki/Tutorial:-N-Dimensional-Array)
* [教程三：矩阵操作](https://github.com/ryanrhymes/owl/wiki/Tutorial:-Matrix-Manipulation)
* [教程四：绘图](https://github.com/ryanrhymes/owl/wiki/Tutorial:-How-to-Plot-in-Owl%3F)
* [教程五：Metric系统](https://github.com/ryanrhymes/owl/wiki/Tutorial:-Metric-Systems)
* [教程六：索引与切片](https://github.com/ryanrhymes/owl/wiki/Tutorial:-Indexing-and-Slicing)
* [教程七：操作符与Ext模块](https://github.com/ryanrhymes/owl/wiki/Tutorial:-Operators-and-Ext-Module)
* [教程八：算法微分](https://github.com/ryanrhymes/owl/wiki/Tutorial:-Algorithmic-Differentiation)

[这里](https://github.com/ryanrhymes/owl/wiki/Evaluation:-Performance-Test)列出了一些简单的系统测试。Owl的一些未来发展计划可以参见[这里](https://github.com/ryanrhymes/owl/wiki/Future-Plan)。如果您对于Owl有任何反馈或建议，我都非常乐意倾听，这里是一些联系方式：
[Email](liang.wang@cl.cam.ac.uk)，
[Twitter](https://twitter.com/ryan_liang)，
[Google+](https://www.google.com/+RyanLiang)，
[Facebook](http://www.facebook.com/ryan.liang.wang)，
[Blogger](http://ryanrhymes.blogspot.com/)，
[LinkedIn](http://uk.linkedin.com/in/liangsuomi/)。

## 安装

Owl的安装需要 OCaml 4.04.0 版本。安装过程相对简单。首先，通过git下载当前repository。

```bash
git clone git@github.com:ryanrhymes/owl.git
```

之后安装所有依赖库。

```bash
opam install ctypes dolog eigen gsl oasis plplot
```
然后，编译病安装Owl模块。

```bash
make oasis
make && make install
```

Owl已经被整合入`utop`中。安装完成后，你可以打开`utop`并跟随接下来的教程动手实验。如果你希望`utop`自动导入`Owl`，你可以在个人的home文件夹下编辑`.ocamlinit`文件并添加文字如下（注：库文件名`owl`的开头为小写 ）：

```bash
#require "owl"
```

如果你想在安装前快速尝试`Owl`的功能，这里提供了一个[Docker映像](https://hub.docker.com/r/ryanrhymes/owl/)以供直接使用而无需上述的安装和配置过程。仅需要通过docker pull命令将映像文件拖至本地，启动docker container，然后在其中启动 `utop`即可。其中Owl的源代码被保存在 `/root/owl`文件夹下。

```bash
docker pull ryanrhymes/owl
docker run -t -i ryanrhymes/owl
```

## 使用模块

`Owl`当前拥有以下名字以`Owl_`打头的核心模块：`Owl_dense`, `Owl_sparse`, `Owl_maths`, `Owl_stats`, `Owl_const`, `Owl_fft`, `Owl_plot`，等等。启动 `utop`并加载`Owl`库后，这些模块就都可以使用了。此外，一种更加简便的使用方法是使用`.`而不是`_`来调用模块，例如`Owl.Dense`而不是`Owl_dense`。在以下教程中，为方便起见，我都会打开所有的`Owl`模块，并使用后一种调用方法。

```ocaml
open Owl;;
```


## 生成矩阵

[`Dense.Matrix`](https://github.com/ryanrhymes/owl/blob/master/lib/owl_dense_matrix.ml) 模块支持稠密矩阵操作，而 [`Sparse.Matrix`](https://github.com/ryanrhymes/owl/blob/master/lib/owl_sparse_matrix.ml) 模块测支持对应的稀疏矩阵操作。在`Dense.Matrix`共有五个子模块：

* `Dense.Matrix.S` 模块支持单精度浮点值 `float32`;
* `Dense.Matrix.D` 模块支持双精度浮点值 `float64`;
* `Dense.Matrix.C` 模块支持单精度复数`complex32`;
* `Dense.Matrix.Z` 模块支持双精度复数 `complex64`;
* `Dense.Matrix.Generic` 模块通过GADT支持以上所有类型.

首先，我们可以使用`Dense.Matrix.D.uniform_int`来生成一个5x5的随机稠密矩阵：

```ocaml
let x = Dense.Matrix.D.uniform_int 5 5;;
```
你现在应该可以在`utop`中看到如下输出：

```bash
   C0 C1 C2 C3 C4
R0 25  2 77 85 72
R1 71 92 98 87 53
R2 35 29 82 65 20
R3  2 29 66 42 12
R4 99 72 78 30 11
val x : Owl_dense_matrix_d.mat =
```

为了输入方便，考虑到64位浮点数是很常用的一种数值类型，我们可以用`Mat`作为`Dense.Matrix.D`的别名（alias）。同样，我们也提供了包含64位浮点数的向量和N维数组的别名，分别是`Vec`和`Arr`。`Mat`模块同样也提供其他生成矩阵的功能，例如：

```ocaml
let x = Mat.eye 5;;             (* 单位矩阵 *)
let x = Mat.zeros 5 5;;         (* 零矩阵 *)
let x = Mat.ones 5 5;;          (* 全一矩阵 *)
let x = Mat.uniform 5 5;;       (* 均匀分布随机矩阵 *)
let x = Mat.gaussian 5 5;;      (* 高斯分布随机矩阵 *)
...
```

和`Stats`结合使用，我们可以多种分布特征的矩阵。以下的代码首先生成一个空的稠密矩阵，然后用伯努利分布初始化矩阵元素。在`utop`中，你应该可以得到一个一半元素都为零的矩阵。

```ocaml
let x = Mat.empty 8 8 |> Mat.map (fun _ -> Stats.Rnd.bernoulli 0.5 |> float_of_int);;
```

或是拉普拉斯分布：

```ocaml
let x = Mat.empty 8 8 |> Mat.map (fun _ -> Stats.Rnd.laplace 0.2);;
```

利用`Dense`模块，我们可以生成linearly spaced interval和 meshgrids。

```ocaml
let x = Mat.linspace 0. 5. 6;;
```
该命令返回一个1x5的向量：
```bash
   C0  C1  C2  C3  C4  C5
R0  0   1   2   3   4   5
val x : Owl_dense_matrix_d.mat =
```

这个矩阵可以被很容易地用于其他的数字类型。例如，我们可以将`float32`类型的矩阵`x`造型（cast）为`complex64`类型的矩阵`y`。

```ocaml
let x = Dense.Matrix.S.uniform 3 3;;
let y = Dense.Matrix.Generic.cast_s2z x;;
```

矩阵可以被储存到文件中或从文件中加载。

```ocaml
Mat.save x "matrix_01.data";;
Mat.load "matrix_01.data";;
```

## 访问元素、行、列

`Dense.Matrix`和`Sparse.Matrix`模块都提供了一系列的操作来访问矩阵中的元素、行、列。详细文档请参见[`Dense.Matrix.Generic`](https://github.com/ryanrhymes/owl/blob/master/lib/owl_dense_matrix_generic.mli)。这里我们只给出几个简单的范例。

使用`Mat.set`和`Mat.get`来操作单个元素。

```ocaml
Mat.set x 0 1 2.5;;
Mat.get x 0 1;;
```

类似地，可以使用更加简短的表达方式：

```ocaml
x.{0,1} <- 2.5;;  (* 等同于 Mat.set x 0 1 2.5 *)
x.{0,1};;         (* 等同于 Mat.get x 0 1 *)
```
使用`Mat.row`和`Mat.col`来取出矩阵中的特定某行或列，或是使用`Mat.rows`和`Mat.cols`取出多行或多列。

```ocaml
Mat.row x 5;;            (* 取第五行 *)
Mat.cols x [|1;3;2|];;   (* 取一、三、二列 *)
```

生成一个随机矩阵，然后通过`Mat.map`将矩阵中所有元素都乘以10。

```ocaml
let x = Mat.(uniform 6 6 |> map (fun x -> x *. 10.));;
```

我们可以迭代地取出矩阵的每一行或每一列。以下代码使用`Mat.map_rows`计算每一行的和。

```ocaml
let x = Mat.(uniform 6 6 |> map_rows sum);;
```

我们可以通过`Mat.fold`折叠(fold)元素，或是使用`Mat.fold_rows`折叠行。类似地，同样提供过滤器`filter`操作。例如可以过滤掉矩阵x中所有不大于0.1的元素：

```ocaml
Mat.filter ((>) 0.1) x;;
```

我们可以做更复杂的操作，例如过滤掉那些和大于3的行。

```ocaml
Mat.filter_rows (fun r -> Mat.sum r > 3.) x;;
```

将行或列随机洗牌（shuffle）， 或是取出其中若干行或列。

```ocaml
Mat.shuffle_rows x;;
Mat.draw_cols x 3;;      (* 有替换地取出矩阵x中的三列 *)
...
```

在实际应用中， `Sparse.Matrix`模块提供了一个类似的用于稀疏矩阵的自己。此外，该模块还提供额外的功能，例如仅仅迭代非零元素的操作`Sparse.Matrix.Generic.iter_nz`等等。请阅读相关的完整[文档](https://github.com/ryanrhymes/owl/blob/master/lib/owl_sparse_matrix_generic.mli)。


## 线性代数

简单的矩阵操作如加减乘除等都被包括在了 `Dense`模块。此外，我们为这些常用操作提供了预定义的简短表示。

```ocaml
let x = Mat.uniform 6 6;;
let y = Mat.uniform 6 6;;
Mat.(x > y);;                (* x矩阵是否大于y？返回布尔值 *)
Mat.(x = y);;                (* x矩阵是否等于y？ *)
Mat.(x <. y);;               (* x矩阵是否小于y？返回 0/1 矩阵*)
...
```

Owl支持类似其他数值库的广播（broadcast）操作。一些基本的数学操作包括：

```ocaml
Mat.(x + y);;                (* 矩阵相加 *)
Mat.(x * y);;                (* 逐元素相乘 *)
Mat.(x *@ y);;               (* 矩阵相乘 *)
Mat.(x +$ 2.);;              (* 为x中的所有的元素加一个纯量 *)
...
```

在矩阵x中每个元素上应用`Maths`模块的多种功能。

```ocaml
Mat.(Maths.atanh @@ x);;        (* 应用atan功能*)
Mat.(Maths.airy_Ai @@ x);;      (* 应用Airy功能*)
...
```

当然，需要指出的是，`Mat`本身已经实现了很多重要的数学功能。它们都已经被矢量化，并且运行起来远比上面的例子要快，因为后者事实上调用了 `Mat.map`。
However, it is worth pointing out that `Mat` already implements many useful math functions. These functions are vectorised and are much faster than the example above which actually calls `Mat.map` for transformation.

```ocaml
Mat.sin x;;         (* Sine *)
Mat.erfc x;;        (* Erfc *)
Mat.round x;;       (* Round *)
Mat.signum x;;      (* Signum *)
Mat.sigmoid x;;     (* Sigmoid *)
...
```

水平或纵向连接两个矩阵。

```ocaml
Mat.(x @= y);;                (* 相当于 Mat.concat_vertical *)
Mat.(x @|| y);;               (* 相当于 Mat.concat_horizontal *)
```

更加高级的线性代数操作，例如SVD，QR分解，Cholesky分解等等，都被包括在`Linalg`模块中。
More advanced linear algebra operations such as `svd`, `qr`, and `cholesky` decomposition are included in `Linalg` module.

```ocaml
let u,s,v = Linalg.svd x;;  
let q,r = Linalg.qr x;;      
let l = Linalg.cholesky x;;  
...
```
## 回归

`Regression` 模块当前包括`linear`, `exponential`, `nonlinear`, `ols`, `ridge`, `lasso`, `svm`等几个组成部分。它们大多数都基于`Optimise`模块中实现的一个随机梯度下降算法。

下面用一个简单的例子来展示相关功能。首先，生成一个1000x3的测量值矩阵x。它的每一行都是一次独立的测量。

```ocaml
let x = Mat.uniform 1000 3;;
```

接下来，定义线性模型的参数，即p，一个3x1的矩阵。

```ocaml
let p = Mat.of_array [|0.2;0.4;0.8|] 3 1;;
```

然后我们根据x和p生成观察值y：

```ocaml
let y = Mat.(x *@ p);;
```

现在假设我们只知道x和y，那么怎样根据二者拟合出一个线性模型？非常简单：

```ocaml
let p' = Regression.linear x y;;
```

可以看到 p'等于`[|0.2; 0.4; 0.8|]`，也就是恰好等于p。关于其他回归，如`lasso`和`svm`，操作是基本一致的。详细说明请查阅Owl的文档。

## 绘图

Owl提供了一个单独的[绘图教程](https://github.com/ryanrhymes/owl/wiki/Tutorial:-How-to-Plot-in-Owl%3F)。这里我们简单地演示怎样使用`Plot` 模块。首先，生成两个Meshgrids，然后应用sin函数。

```ocaml
let x, y = Mat.meshgrid (-2.5) 2.5 (-2.5) 2.5 100 100 in
let z = Mat.(sin ((x * x) + (y * y))) in
Plot.mesh x y z;;
```

无论你使用的是那种终端，最后都应该可以生成如下所示的图：

![绘图示例01](examples/test_plot_01.png)

除了 `Plot.mesh`,  `Plot`还提供一些其他的基本绘图功能。虽然该模块还尚未完全成熟，但是它已经可以用简单的代码来实现一些较为复杂的绘图了。比如下面这段代码将会生成一个`2 x 2`的subplot。

```ocaml
let f p i = match i with
  | 0 -> Stats.Rnd.gaussian ~sigma:0.5 () +. p.(1)
  | _ -> Stats.Rnd.gaussian ~sigma:0.1 () *. p.(0)
in
let y = Stats.gibbs_sampling f [|0.1;0.1|] 5_000 |> Mat.of_arrays in
let h = Plot.create ~m:2 ~n:2 "test_plot_04.png" in
let _ = Plot.set_background_color h 255 255 255 in
let _ = Plot.subplot h 0 0 in
let _ = Plot.set_title h "Bivariate model" in
let _ = Plot.scatter ~h (Mat.col y 0) (Mat.col y 1) in
let _ = Plot.subplot h 0 1 in
let _ = Plot.set_title h "Distribution of y" in
let _ = Plot.set_xlabel h "y" in
let _ = Plot.set_ylabel h "Frequency" in
let _ = Plot.histogram ~h ~bin:50 (Mat.col y 1) in
let _ = Plot.subplot h 1 0 in
let _ = Plot.set_title h "Distribution of x" in
let _ = Plot.set_ylabel h "Frequency" in
let _ = Plot.histogram ~h ~bin:50 (Mat.col y 0) in
let _ = Plot.subplot h 1 1 in
let _ = Plot.set_foreground_color h 51  102 255 in
let _ = Plot.set_title h "Sine function" in
let _ = Plot.plot_fun ~h ~line_style:2 Maths.sin 0. 28. in
let _ = Plot.autocorr ~h (Mat.sequential 1 28) in
Plot.output h;;
```

绘制结果如下：

![绘图示例04](examples/test_plot_04.png)

## 数学与统计

`Maths`和`Stats`模块中包含了大量的基本和高级的数学/统计函数。其中大多数都通过接口连接到了[GSL](https://www.gnu.org/software/gsl/manual/html_node/)库。请在使用前阅读相关文档。我计划在未来添加对于其他数学库作为后端支持，以满足用户不同的开源licence需求。

[`Stats`](http://www.cl.cam.ac.uk/~lw525/owl/Stats.html)有三个子模块：[`Stats.Rnd`](http://www.cl.cam.ac.uk/~lw525/owl/Stats.Rnd.html) 用于随机数；[`Stats.Pdf`](http://www.cl.cam.ac.uk/~lw525/owl/Stats.Pdf.html)用于概率密度函数；[`Stats.Cdf`](http://www.cl.cam.ac.uk/~lw525/owl/Stats.Cdf.html) 则用于累计分布函数。此外，我还实现了其他的功能，比如用于相关系数的`Stats.kendall_tau`和`Stats.spearman_rho`；`Stats`模块中包含的两个MCMC（马尔可夫链蒙特卡罗）函数：Metropolis-Hastings (`Stats.metropolis_hastings`)和Gibbs 取样 (`Stats.gibbs_sampling`) 算法。

例如，下面的代码首先定义了一个概率密度函数`f`， 用于混合高斯模型。然后我们基于`f`使用 `Stats.metropolis_hastings`取100,000个样本。初始点为`0.1`。最后，调用`Plot.histogram`来绘制样本的分布。从分布中我们可以清楚地看到这是两个高斯模型的混合。

```ocaml
let f p = Stats.Pdf.((gaussian p.(0) 0.5) +. (gaussian (p.(0) -. 3.5) 1.)) in
let y = Stats.metropolis_hastings f [|0.1|] 100_000 |>  Mat.of_arrays in
Plot.histogram ~bin:100 y;;
```

下面的图展示了样本的分布：

![Plot example 02](examples/test_plot_02.png)


下面是另一个使用`Stats.gibbs_sampling`的例子，用于从一个二维分布中取样。Gibbs取样需要知道完整的条件概率分布，因此我们定义相应的随机数生成器（generator）：`f p i`，其中`p`是参数向量，而`i`则指明了哪一个参数用于取样。

```ocaml
let f p i = match i with
  | 0 -> Stats.Rnd.gaussian ~sigma:0.5 () +. p.(1)
  | _ -> Stats.Rnd.gaussian ~sigma:0.1 () *. p.(0)
in
let y = Stats.gibbs_sampling f [|0.1;0.1|] 5_000 |> Mat.of_arrays in
Plot.scatter (Mat.col y 0) (Mat.col y 1);;
```

我们从定义的分布中取出5000个样本，并且绘图如下：

![Plot example 03](examples/test_plot_03.png)

我计划下一步在`Stats`模块中加入小型的PPL（概率编程语言）。


## N维数组

Owl有一个非常强大模块来操作稠密N维数组，例如[`Dense.Ndarray`](https://github.com/ryanrhymes/owl/blob/master/lib/owl_dense_ndarray.ml).
Ndarray和Numpy与Julia中对应的模块非常相似。对于稀疏N维数组，你可以使用`Sparse.Ndarray`来提供一套相似的API。[这里](https://github.com/ryanrhymes/owl/wiki/Evaluation:-Performance-Test)有一个对于Ndarray的初步性能测试。

和`Matrix`模块相似，`Ndarray`同样也提供了五个子模块：`S` (`float32`), `D` (`float64`), `C` (`complex32`), `Z` (`complex64`), 和 `Generic` (全部类型)。`Owl`对于双精度浮点N维数组（如`Dense.Ndarray.D`）提供了便于使用的别名`Arr`。`Ndarray`同样也支持广播操作。

下面，我将展示一些使用`Dense.Ndarray`模块的例子。首先，我们生成空的`[|3;4;5|]`形状的N维数组。

```ocaml
let x0 = Dense.Ndarray.S.empty [|3;4;5|];;
let x1 = Dense.Ndarray.D.empty [|3;4;5|];;
let x2 = Dense.Ndarray.C.empty [|3;4;5|];;
let x3 = Dense.Ndarray.Z.empty [|3;4;5|];;
```

可以初始化赋值，生成全零、全一或随机的N维数组，

```ocaml
Dense.Ndarray.C.zeros [|3;4;5|];;
Dense.Ndarray.D.ones [|3;4;5|];;
Dense.Ndarray.S.create [|3;4;5|] 1.5;;
Dense.Ndarray.Z.create [|3;4;5|] Complex.({im=1.5; re=2.5});;
Dense.Ndarray.D.uniform [|3;4;5|];;
```

然后可以做一些数学运算。

```ocaml
let x = Arr.uniform [|3;4;5|];;
let y = Arr.uniform [|3;4;5|];;
let z = Arr.add x y;;
Arr.print z;;
```

Owl支持多种数学运算。它们支持矢量化运算，因此运行速度非常快。

```ocaml
Arr.sin x;;
Arr.tan x;;
Arr.exp x;;
Arr.log x;;
Arr.min x;;
Arr.add_scalar x 2.;;
Arr.mul_scalar x 2.;;
...
```

读取元素并对比两个N维数组是非常容易的。

```ocaml
Arr.is_zero x;;
Arr.is_positive x;;
Arr.is_nonnegative x;;
...
Arr.equal x y;;
Arr.greater x y;;
Arr.less_equal x y;;
...
```

使用自定义函数来检查每一个元素。

```ocaml
Arr.exists ((>) 2.) x;;
Arr.not_exists ((<) 2.) x;;
Arr.for_all ((=) 2.) x;;
```

最重要的是，你可以使用Owl来通过多种方式迭代一个N维数组。Owl提供了一个简单且灵活的方式来定义N维数组的“切片”。和"`Bigarray.slice_left`"函数相比，Owl中的切片不一定要从最左边的轴开始。比如说，在前面定义的`[|3;4;5|]`的N维数组，你可以通过如下方式定义一个切片：

```ocaml
let s0 = [ []; []; [] ]      (* (*,*,*), 也就是把整个数组作为一个slice *)
let s1 = [ [0]; []; [] ]     (* (0,*,*) *)
let s2 = [ []; [2]; [] ]     (* (*,2,*) *)
let s3 = [ []; []; [1] ]     (* (*,*,1) *)
let s4 = [ [1]; []; [2] ]    (* (1,*,2) *)
...
```

`slice`函数非常灵活。它基本和Numpy中的`slice`函数有着相同的语法。一些高级的用法请参见另外一篇单独的[教程](https://github.com/ryanrhymes/owl/wiki/Tutorial:-Indexing-and-Slicing)。 一些例子如下所示：

```ocaml
let s = [ [1]; []; [-1;0;-1]; ];;
let s = [ [1]; [0]; [-1;0;-1]; ];;
let s = [ [1]; [0]; [-2;0]; ];;
let s = [ [0]; [0;1]; [-2;0;-2]; ];;
...
```

有了以上这些切片定义，我们可以迭代并映射切片中的元素。比如，我们可以在切片`(0,*,*)`中所有元素加一。

```ocaml
Arr.map ~axis:[ [0]; []; [] ] (fun a -> a +. 1.) x;;
```

有许多其他函数可以帮助你在N维数组中迭代元素和切片：`iteri`, `iter`, `mapi`, `map`, `filteri`, `filter`, `foldi`, `fold`, `iteri_slice`, `iter_slice`, `iter2i`, `iter2`。请参见文档来查看它们的使用细节。

## 算法微分

算法微分（Algorithmic differentiation/Automatic Differentiation，AD）是Owl的另一个关键组件。它使得许多分析任务非常容易。这里的一篇[Wikipedia 文章](https://en.wikipedia.org/wiki/Automatic_differentiation)有助于理解这个概念。

`Algodiff`模块提供了对AD的支持。`Algodiff.Numerical`提供数字微分功能，`Algodiff.S`和`Algodiff.D`提供针对单精度和双精度浮点数的算法微分。关于二者的区别，请阅读那篇维基文章。简单来讲，`Algodiff.S/D`能够提供精确求导结果，而`Algodiff.Numerical`则是近似值。

`Algodiff.S`支持高阶导数。这里是一个计算`tanh`函数的四阶导数的例子。

```ocaml
open Algodiff.S;;

(* calculate derivatives of f0 *)
let f0 x = Maths.(tanh x);;
let f1 = f0 |> diff;;
let f2 = f0 |> diff |> diff;;
let f3 = f0 |> diff |> diff |> diff;;
let f4 = f0 |> diff |> diff |> diff |> diff;;
```

然后我们可以在`[-4, 4]`区间上绘制`tanh`及其四个导数。

```ocaml
let map f x = Vec.map (fun a -> a |> pack_flt |> f |> unpack_flt) x;;

(* calculate point-wise values *)
let x = Vec.linspace (-4.) 4. 200;;
let y0 = map f0 x;;
let y1 = map f1 x;;
let y2 = map f2 x;;
let y3 = map f3 x;;
let y4 = map f4 x;;

(* plot the values of all functions *)
let h = Plot.create "plot_021.png" in
Plot.set_foreground_color h 0 0 0;
Plot.set_background_color h 255 255 255;
Plot.plot ~h x y0;
Plot.plot ~h x y1;
Plot.plot ~h x y2;
Plot.plot ~h x y3;
Plot.plot ~h x y4;
Plot.output h;;
```

结果如下图所示。如果对详细内容感兴趣，请参见教程。

![plot021](https://raw.githubusercontent.com/wiki/ryanrhymes/owl/image/plot_021.png)

## 机器学习与神经网络

该部分内容还在开发中。当前的`Neural`模块被包裹在一个单独的库中，但很快就会被整合至 `Owl`的主库中。

下面展示了一个景点的MNIST实例，其中，我们训练了一个双层的神经网络，用于识别手写数字。首先，打开`utop`并加载`Owl_neural`库。

```ocaml
#require "owl_neural";;
open Owl_neural;;
open Feedforward;;
```

现在，定义一个双层的神经网络。

```ocaml
let nn = input [|784|]                      (* 定义一个 Feedforward 神经网络*)
  |> linear 300 ~act_typ:Activation.Tanh    (* 用Tanh activation 添加一个784x300的线性层 *)
  |> linear 10  ~act_typ:Activation.Softmax (* 用Softmax添加另一个300x10的线性层 *)
;;
```

仅仅三行代码，我们就完成了对该网络的定义。`Owl`的`Neural`模块建立在`Algodiff`模块之上，我认为后者是支持神经网络计算的一个非常强有力的工具。通过调用`print nn`，可以输出该神经网络的基本信息。

```bash
Feedforward network

(0): Input layer: in/out:[*,784]

(1): Linear layer: matrix in:(*,784) out:(*,300)
    init   : standard
    params : 235500
    w      : 784 x 300
    b      : 1 x 300

(2): Activation layer: tanh in/out:[*,300]

(3): Linear layer: matrix in:(*,300) out:(*,10)
    init   : standard
    params : 3010
    w      : 300 x 10
    b      : 1 x 10

(4): Activation layer: softmax in/out:[*,10]
```

怎样训练该网络？仅仅只需要两行代码来加载数据集并且开始训练。这里`Dataset.download_all ()`可以下载Owl示例中所需的所有的数据集，未解压时大概共1GB。

```ocaml
let x, _, y = Dataset.load_mnist_train_data () in
train nn x y;;
```

如果用户想要不一样的训练设置怎么办？在这里，训练和网络模块都是十分灵活且高度可定制的。我将在相关教程中讲述进一步的细节。

## 分布式和并行计算

Owl的分布式很并行计算依赖于我的另一个研究原型 —— Actor系统，一个专用于分布式数据处理的框架。我很快将介绍这一非常有趣的功能。

## 在不同的平台上运行Owl

如果你想在ARM平台（而非传统的x86平台）上运行Owl，安装过程是非常相似的。只是需要注意一点：Owl当前需要OCaml 4.04版本，而这一版本在目前的流行ARM机器，比如Raspberry Pi上，可能是不支持的。因此，你可能需要直接编译OCaml的[源代码](https://ocaml.org/releases/4.04.html)。此外，编译过程中，为了解决可能的gsl包兼容问题，在运行完`./configure`命令之后、 `make world.opt`命令之前，你需要运行命令：

```bash
sed -i -e 's/#define ARCH_ALIGN_DOUBLE/#undef ARCH_ALIGN_DOUBLE/g' config/m.h config/m-templ.h
```

同样，我们也提供了ARM平台上的[Docker映像文件](https://hub.docker.com/r/matrixanger/owl/)，方面用户快速熟悉该平台。直接运行：

```bash
docker run --name owl -it matrixanger/owl:arm
```

注意，在打开一个新的Container之后、打开`utop`之前，用户需要首先运行：

```bash
eval `opam config env`
```

## 如何加入

Owl现在正在积极开发中。我衷心期待来自各方的评论建议和代码贡献。除了在你的本地系统设立一个完整的开发系统之外，最容易的加入Owl的方法就是使用Owl的Docker映像（[x86](https://hub.docker.com/r/ryanrhymes/owl/)，[ARM](https://hub.docker.com/r/matrixanger/owl/)）。直接把文件pull到本地，然后就可以从`/root/owl`入手，尽情探索了！

祝您玩得愉快！

**致谢: 本系统部分地由EPSRC项目Contrive (EP/N028422/1)提供支持。**
