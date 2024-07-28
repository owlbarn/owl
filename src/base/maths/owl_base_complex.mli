(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** {5 Type definition and constants} *)

type t = Complex.t
(** Type definition for a complex number. *)

val zero : t
(** 
    Constant value representing the complex number zero (0 + 0i).
*)

val one : t
(** 
    Constant value representing the complex number one (1 + 0i).
*)

val i : t
(** 
    Constant value representing the imaginary unit i (0 + 1i).
*)

(** {5 Unary functions} *)

val neg : t -> t
(** 
    [neg z] returns the negation of the complex number [z].
    If [z = a + bi], then [neg z = -a - bi].
*)

val abs : t -> float
(** 
    [abs z] returns the magnitude (absolute value) of the complex number [z].
    This is computed as sqrt(Re(z)^2 + Im(z)^2).
*)

val abs2 : t -> float
(** 
    [abs2 z] returns the squared magnitude of the complex number [z].
    This is computed as Re(z)^2 + Im(z)^2.
*)

val logabs : t -> float
(** 
    [logabs z] returns the natural logarithm of the magnitude of the complex number [z].
*)

val conj : t -> t
(** 
    [conj z] returns the complex conjugate of the complex number [z].
    If [z = a + bi], then [conj z = a - bi].
*)

val inv : t -> t
(** 
    [inv z] returns the multiplicative inverse of the complex number [z].
    This is computed as 1 / z.
*)

val sqrt : t -> t
(** 
    [sqrt z] returns the square root of the complex number [z].
*)

val exp : t -> t
(** 
    [exp z] returns the exponential of the complex number [z], calculated as e^z.
*)

val exp2 : t -> t
(** 
    [exp2 z] returns 2 raised to the power of the complex number [z], calculated as 2^z.
*)

val exp10 : t -> t
(** 
    [exp10 z] returns 10 raised to the power of the complex number [z], calculated as 10^z.
*)

val expm1 : t -> t
(** 
    [expm1 z] returns the value of exp(z) - 1, providing a more accurate result for small values of [z].
*)

val log : t -> t
(** 
    [log z] returns the natural logarithm of the complex number [z].
*)

val log2 : t -> t
(** 
    [log2 z] returns the base-2 logarithm of the complex number [z].
*)

val log10 : t -> t
(** 
    [log10 z] returns the base-10 logarithm of the complex number [z].
*)

val log1p : t -> t
(** 
    [log1p z] returns the natural logarithm of (1 + z), providing a more accurate result for small values of [z].
*)

val sin : t -> t
(** 
    [sin z] returns the sine of the complex number [z].
*)

val cos : t -> t
(** 
    [cos z] returns the cosine of the complex number [z].
*)

val tan : t -> t
(** 
    [tan z] returns the tangent of the complex number [z].
*)

val cot : t -> t
(** 
    [cot z] returns the cotangent of the complex number [z].
*)

val sec : t -> t
(** 
    [sec z] returns the secant of the complex number [z].
*)

val csc : t -> t
(** 
    [csc z] returns the cosecant of the complex number [z].
*)

val sinh : t -> t
(** 
    [sinh z] returns the hyperbolic sine of the complex number [z].
*)

val cosh : t -> t
(** 
    [cosh z] returns the hyperbolic cosine of the complex number [z].
*)

val tanh : t -> t
(** 
    [tanh z] returns the hyperbolic tangent of the complex number [z].
*)

val sech : t -> t
(** 
    [sech z] returns the hyperbolic secant of the complex number [z].
*)

val csch : t -> t
(** 
    [csch z] returns the hyperbolic cosecant of the complex number [z].
*)

val coth : t -> t
(** 
    [coth z] returns the hyperbolic cotangent of the complex number [z].
*)

val asin : t -> t
(** 
    [asin z] returns the arcsine of the complex number [z].
*)

val acos : t -> t
(** 
    [acos z] returns the arccosine of the complex number [z].
*)

val atan : t -> t
(** 
    [atan z] returns the arctangent of the complex number [z].
*)

val asec : t -> t
(** 
    [asec z] returns the arcsecant of the complex number [z].
*)

val acsc : t -> t
(** 
    [acsc z] returns the arccosecant of the complex number [z].
*)

val acot : t -> t
(** 
    [acot z] returns the arccotangent of the complex number [z].
*)

val asinh : t -> t
(** 
    [asinh z] returns the inverse hyperbolic sine of the complex number [z].
*)

val acosh : t -> t
(** 
    [acosh z] returns the inverse hyperbolic cosine of the complex number [z].
*)

val atanh : t -> t
(** 
    [atanh z] returns the inverse hyperbolic tangent of the complex number [z].
*)

val asech : t -> t
(** 
    [asech z] returns the inverse hyperbolic secant of the complex number [z].
*)

val acsch : t -> t
(** 
    [acsch z] returns the inverse hyperbolic cosecant of the complex number [z].
*)

val acoth : t -> t
(** 
    [acoth z] returns the inverse hyperbolic cotangent of the complex number [z].
*)


val arg : t -> float
(** [arg x] returns the angle of a complex number [x]. *)

val phase : t -> float
(** [phase x] returns the phase of a complex number [x]. *)

val floor : t -> t
(** [floor x] *)

val ceil : t -> t
(** [ceil x] *)

val round : t -> t
(** [round x] *)

val trunc : t -> t
(** [trunc x] *)

val fix : t -> t
(** [fix x] *)

(** {5 Binary functions} *)

val add : t -> t -> t
(** 
    [add z1 z2] returns the sum of the complex numbers [z1] and [z2].
*)

val sub : t -> t -> t
(** 
    [sub z1 z2] returns the difference of the complex numbers [z1] and [z2].
*)

val mul : t -> t -> t
(** 
    [mul z1 z2] returns the product of the complex numbers [z1] and [z2].
*)

val div : t -> t -> t
(** 
    [div z1 z2] returns the quotient of the complex numbers [z1] and [z2].
*)

val add_re : t -> float -> t
(** 
    [add_re z r] adds the real number [r] to the real part of the complex number [z].
    Returns a new complex number with the real part increased by [r].
*)

val add_im : t -> float -> t
(** 
    [add_im z i] adds the real number [i] to the imaginary part of the complex number [z].
    Returns a new complex number with the imaginary part increased by [i].
*)

val sub_re : t -> float -> t
(** 
    [sub_re z r] subtracts the real number [r] from the real part of the complex number [z].
    Returns a new complex number with the real part decreased by [r].
*)

val sub_im : t -> float -> t
(** 
    [sub_im z i] subtracts the real number [i] from the imaginary part of the complex number [z].
    Returns a new complex number with the imaginary part decreased by [i].
*)

val mul_re : t -> float -> t
(** 
    [mul_re z r] multiplies the real part of the complex number [z] by the real number [r].
    Returns a new complex number with the real part scaled by [r].
*)

val mul_im : t -> float -> t
(** 
    [mul_im z i] multiplies the imaginary part of the complex number [z] by the real number [i].
    Returns a new complex number with the imaginary part scaled by [i].
*)

val div_re : t -> float -> t
(** 
    [div_re z r] divides the real part of the complex number [z] by the real number [r].
    Returns a new complex number with the real part divided by [r].
*)

val div_im : t -> float -> t
(** 
    [div_im z i] divides the imaginary part of the complex number [z] by the real number [i].
    Returns a new complex number with the imaginary part divided by [i].
*)

val pow : t -> t -> t
(** 
    [pow z1 z2] raises the complex number [z1] to the power of [z2].
    Returns a new complex number representing [z1] raised to [z2].
*)

val polar : float -> float -> t
(** 
    [polar r theta] creates a complex number from the polar coordinates [r] (magnitude) and [theta] (angle in radians).
    Returns a new complex number.
*)

val rect : float -> float -> t
(** 
    [rect r phi] returns a complex number with polar coordinates [r] and [phi].
    Equivalent to [polar r phi].
*)

(** {5 Comparison functions} *)

val equal : t -> t -> bool
(** 
    [equal z1 z2] returns [true] if the complex numbers [z1] and [z2] are equal, [false] otherwise.
*)

val not_equal : t -> t -> bool
(** 
    [not_equal z1 z2] returns [true] if the complex numbers [z1] and [z2] are not equal, [false] otherwise.
*)

val less : t -> t -> bool
(** 
    [less z1 z2] returns [true] if the magnitude of the complex number [z1] is less than that of [z2].
*)

val greater : t -> t -> bool
(** 
    [greater z1 z2] returns [true] if the magnitude of the complex number [z1] is greater than that of [z2].
*)

val less_equal : t -> t -> bool
(** 
    [less_equal z1 z2] returns [true] if the magnitude of the complex number [z1] is less than or equal to that of [z2].
*)

val greater_equal : t -> t -> bool
(** 
    [greater_equal z1 z2] returns [true] if the magnitude of the complex number [z1] is greater than or equal to that of [z2].
*)


(** {5 Helper functions} *)

val complex : float -> float -> t
(** [complex re im] returns a complex number [{re; im}]. *)

val of_tuple : float * float -> t
(** [of_tuple (re, im)] returns a complex number [{re; im}]. *)

val to_tuple : t -> float * float
(** [to_tuple x] converts a complex number to tuple [(x.re; x.im)]. *)

val is_nan : t -> bool
(** [is_nan x] returns [true] if [x.re] is [nan] or [x.im] is [nan]. *)

val is_inf : t -> bool
(** [is_inf x] returns [true] if either [x.re] or [x.im] is [infinity] or [neg_infinity]. *)

val is_normal : t -> bool
(** [is_normal x] returns [true] if both [x.re] and [x.im] are [normal]. *)
