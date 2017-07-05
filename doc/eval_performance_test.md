Performance is the key in many numerical applications, so I did one initial evaluation of Owl today. Frankly, I have been very busy in building up the whole system without spending too much time in optimising its performance, hence I was not sure how well Owl can perform. However, the initial results seem very promising. This definitely encourages me to keep developing Owl and further optimise its overall performance in the future.

In the evaluation, I focus on the performance of several operations on n-dimensional arrays. I used this version of [[Owl](https://github.com/ryanrhymes/owl/tree/1bb18a1012a932c54735e419dbcd58ee2dbcacc2)], and compare to Numpy (version 1.8.0rcl) and Julia (version 0.5.0). The evaluation is done on my MacBook Air (1.6GHz Intel Core i5, 8GB memory). **Last, note that the evaluation is performed on 2016.12.13.**


## Evaluated Operations

I evaluate eight operations with the detailed information listed as below. Each operation is performed 10 times and the average time is reported. All the ndarrays used in the evaluation are of the shape 10 x 1000 x 10000, `Float64` type, therefore 100 million float numbers in each ndarray.

* `empty` : create an empty ndarray of the shape 10 x 1000 x 10000 without initialising the elements.
* `create` : create an empty ndarray then initialise all the elements to 3.5
* `x + y` : add two ndarrays element-wise (both have the same shape mentioned before).
* `x * y` : multiply two ndarrays element-wise.
* `x + 2` : add the constant 2 to all the elements in a ndarray.
* `abs x` : calculate the absolute value of each element in a ndarray.
* `x < y` : check whether `x` is smaller than `y` element-wise.
* `map x` : apply a user-defined `f` function to each element and save the result in a new ndarray. In our case, `f(x) = sin(x) + 1`.
* `iter x` : iterate each element in a ndarray and perform some operations. Herein, we only check if the element is positive or negative.

Note that most operations will generate a new ndarray for saving the results except `iter x`. The code used in the evaluation can be downloaded from here: [[owl](https://gist.github.com/ryanrhymes/26fbb3c6bd1aeded9c69e0834df88b22)], [[numpy](https://gist.github.com/ryanrhymes/98b8262eaf9b851330976e2ab2f75bc2)], [[julia](https://gist.github.com/ryanrhymes/b8bf0d3df8e99d36896cc4a1ceefaefc)].


## Evaluation Results

The table below presents the evaluation results, i.e., the average time needed to finish the tested operation (in seconds). Simply put, Owl is the fastest regarding the operations tested. Hmm, not bad!

|            | Owl (OCaml)       | Numpy (Python)    | Julia (Julia)  |
|:----------:|:-----------------:|:-----------------:|:--------------:|
| empty      | 0.0000            | 0.0000            | 0.0000         |
| create     | 0.4051            | 0.4155            | 0.4874         |
| x + y      | 0.5402            | 0.5698            | 0.7514         |
| x * y      | 0.5330            | 0.5963            | 0.8649         |
| x + 2      | 0.4791            | 0.5246            | 0.6299         |
| x < y      | 0.1529            | 0.2209            | 0.6248         |
| abs x      | 0.4956            | 0.5186            | 0.5932         |
| map x      | 2.2181            | 51.4562           | 2.2582         |
| iter x     | 0.4429            | 37.6902           | 6.4385         |

Some things worth pointing out here are: Julia does not actually allocate the space for an empty ndarray whereas Owl and Numpy do. For operations like `x + y`, `x * y`, `x + y`, and etc., all three libraries (Owl, Numpy, and Julia) call the underlying BLAS/LAPACK functions, however you can still notice their performance difference. 

For `map` operation, it is essentially implemented using `for` loops in Python. Julia performs much better than Numpy in the `map` evaluation because of its highly optimised vectorisation operation. Even though a more efficient Python solution is to call vectorised `sin(x)` in Numpy directly, the point here is when you have to plug in your own function in `map` which may not be provided as a vectorised function, Python can be very very slow.


## Caveats & Further Investigation

Before we conclude, I need to emphasise a couple of caveats. Owl appeared to be the fastest in the aforementioned evaluation. It does not necessarily mean that Owl is always the fastest. E.g., if I replace the function `f` in `map x` test with `f x = (sin x) ** 2.`, then Julia is even faster than Owl. The reason is that the power function in Julia seems much faster than that in OCaml (I guess :). So, be careful about the math function you plug in `map`, their performance may be quite different in different languages even though their appear to be mathematically equivalent. 

Vectorisation can help a lot in improving the performance, and Julia is well-known for its optimisation using vectorisation. However, there are also a lot of cases you probably need to iterate the elements one by one especially whenever side-effects (or global variables) get involved. In all cases, Owl is really fast in iterating all the elements thanks to many optimisation done in OCaml.

Last thing that I will investigate a bit further is: I actually implemented a parallel version of `map` called `pmap` in Ndarray module. `pmap` can often improve the performance if multiple cores are used. However, the improvement is not really consistent and sometimes can be even slower than serial execution. At the moment, I haven't figured out the actual reason.

In general, Owl has performed very well and the future seems promising at the moment. Especially, considering the active development of multicore OCaml and the widely use of GPU in scientific computing, I believe Owl can be further optimised to achieve better performance. OCaml strikes a good balance between the high-level language and performance, I still think it can be an excellent option for scientific computing.

