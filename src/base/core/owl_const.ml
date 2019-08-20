(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray


(** Maths constants *)

let e       = 2.718281828459045235360287471352662498  (* e *)

let euler   = 0.577215664901532860606512090082402431  (* Euler constant *)

let log2e   = 1.442695040888963407359924681001892137  (* log2_e *)

let log10e  = 0.434294481903251827651128918916605082  (* log_10 e *)

let loge2   = 0.693147180559945309417232121458176568  (* log_e 2 *)

let loge10  = 2.302585092994045684017991454684364208  (* log_e 10 *)

let logepi  = 1.144729885849400174143427351353058711  (* log_e pi *)

let sqrt1_2 = 0.707106781186547524400844362104849039  (* 1/sqrt(2) *)

let sqrt2   = 1.414213562373095048801688724209698079  (* sqrt(2) *)

let sqrt3   = 1.732050807568877293527446341505872366  (* sqrt(3) *)

let sqrtpi  = 1.772453850905516027298167483341145182  (* sqrt(pi) *)

let pi      = 3.141592653589793238462643383279502884  (* pi *)

let pi2     = 6.283185307179586476925286766559005768  (* 2*pi *)

let pi4     = 12.56637061435917295385057353311801153  (* 4*pi *)

let pi_2    = 1.570796326794896619231321691639751442  (* pi/2 *)

let pi_4    = 0.785398163397448309615660845819875721  (* pi/4 *)

let eps     = 1e-15                                   (* platform dependent error *)


(** Functions that return constants using Bigarray kind *)

let zero : type a b. (a, b) kind -> a = function
  | Float32        -> 0.0
  | Complex32      -> Complex.zero
  | Float64        -> 0.0
  | Complex64      -> Complex.zero
  | Int8_signed    -> 0
  | Int8_unsigned  -> 0
  | Int16_signed   -> 0
  | Int16_unsigned -> 0
  | Int32          -> 0l
  | Int64          -> 0L
  | Int            -> 0
  | Nativeint      -> 0n
  | Char           -> '\000'


let one : type a b. (a, b) kind -> a = function
  | Float32        -> 1.0
  | Complex32      -> Complex.one
  | Float64        -> 1.0
  | Complex64      -> Complex.one
  | Int8_signed    -> 1
  | Int8_unsigned  -> 1
  | Int16_signed   -> 1
  | Int16_unsigned -> 1
  | Int32          -> 1l
  | Int64          -> 1L
  | Int            -> 1
  | Nativeint      -> 1n
  | Char           -> '\001'


let neg_one : type a b. (a, b) kind -> a = function
  | Float32        -> -1.0
  | Float64        -> -1.0
  | Complex32      -> Complex.({re=(-1.); im=0.})
  | Complex64      -> Complex.({re=(-1.); im=0.})
  | Int8_signed    -> -1
  | Int8_unsigned  -> -1
  | Int16_signed   -> -1
  | Int16_unsigned -> -1
  | Int32          -> -1l
  | Int64          -> -1L
  | Int            -> -1
  | Nativeint      -> -1n
  | Char           -> '\255'


let pos_inf : type a b. (a, b) kind -> a = function
  | Float32   -> infinity
  | Float64   -> infinity
  | Complex32 -> Complex.({re = infinity; im = infinity})
  | Complex64 -> Complex.({re = infinity; im = infinity})
  | _         -> failwith "pos_inf: unsupported operation"


let neg_inf : type a b. (a, b) kind -> a = function
  | Float32   -> neg_infinity
  | Float64   -> neg_infinity
  | Complex32 -> Complex.({re = neg_infinity; im = neg_infinity})
  | Complex64 -> Complex.({re = neg_infinity; im = neg_infinity})
  | _         -> failwith "neg_inf: unsupported operation"


let min_float32 = ~-.340282346638528859811704183484516925440.0


let max_float32 = 340282346638528859811704183484516925440.0


let min_float64 = Stdlib.min_float


let max_float64 = Stdlib.max_float


(** Unit prefixes *)

module Prefix = struct

  let fine_structure = 7.297352533e-3

  let avogadro = 6.02214199e23

  let yotta = 1e24

  let zetta = 1e21

  let exa = 1e18

  let peta = 1e15

  let tera = 1e12

  let giga = 1e9

  let mega = 1e6

  let kilo = 1e3

  let hecto = 1e2

  let deca = 1e1

  let deci = 1e-1

  let centi = 1e-2

  let milli = 1e-3

  let micro = 1e-6

  let nano = 1e-9

  let pico = 1e-12

  let femto = 1e-15

  let atto = 1e-18

  let zepto = 1e-21

  let yocto = 1e-24

end


(** Values of physical constants *)

module CGS = struct

  let speed_of_light = 2.99792458e10

  let gravitational_constant = 6.673e-8

  let plancks_constant_h = 6.62606896e-27

  let plancks_constant_hbar = 1.05457162825e-27

  let astronomical_unit = 1.49597870691e13

  let light_year = 9.46053620707e17

  let parsec = 3.08567758135e18

  let grav_accel = 9.80665e2

  let electron_volt = 1.602176487e-12

  let mass_electron = 9.10938188e-28

  let mass_muon = 1.88353109e-25

  let mass_proton = 1.67262158e-24

  let mass_neutron = 1.67492716e-24

  let rydberg = 2.17987196968e-11

  let boltzmann = 1.3806504e-16

  let molar_gas = 8.314472e7

  let standard_gas_volume = 2.2710981e4

  let minute = 6e1

  let hour = 3.6e3

  let day = 8.64e4

  let week = 6.048e5

  let inch = 2.54e0

  let foot = 3.048e1

  let yard = 9.144e1

  let mile = 1.609344e5

  let nautical_mile = 1.852e5

  let fathom = 1.8288e2

  let mil = 2.54e-3

  let point = 3.52777777778e-2

  let texpoint = 3.51459803515e-2

  let micron = 1e-4

  let angstrom = 1e-8

  let hectare = 1e8

  let acre = 4.04685642241e7

  let barn = 1e-24

  let liter = 1e3

  let us_gallon = 3.78541178402e3

  let quart = 9.46352946004e2

  let pint = 4.73176473002e2

  let cup = 2.36588236501e2

  let fluid_ounce = 2.95735295626e1

  let tablespoon = 1.47867647813e1

  let teaspoon = 4.92892159375e0

  let canadian_gallon = 4.54609e3

  let uk_gallon = 4.546092e3

  let miles_per_hour = 4.4704e1

  let kilometers_per_hour = 2.77777777778e1

  let knot = 5.14444444444e1

  let pound_mass = 4.5359237e2

  let ounce_mass = 2.8349523125e1

  let ton = 9.0718474e5

  let metric_ton = 1e6

  let uk_ton = 1.0160469088e6

  let troy_ounce = 3.1103475e1

  let carat = 2e-1

  let unified_atomic_mass = 1.660538782e-24

  let gram_force = 9.80665e2

  let pound_force = 4.44822161526e5

  let kilopound_force = 4.44822161526e8

  let poundal = 1.38255e4

  let calorie = 4.1868e7

  let btu = 1.05505585262e10

  let therm = 1.05506e15

  let horsepower = 7.457e9

  let bar = 1e6

  let std_atmosphere = 1.01325e6

  let torr = 1.33322368421e3

  let meter_of_mercury = 1.33322368421e6

  let inch_of_mercury = 3.38638815789e4

  let inch_of_water = 2.490889e3

  let psi = 6.89475729317e4

  let poise = 1e0

  let stokes = 1e0

  let stilb = 1e0

  let lumen = 1e0

  let lux = 1e-4

  let phot = 1e0

  let footcandle = 1.076e-3

  let lambert = 1e0

  let footlambert = 1.07639104e-3

  let curie = 3.7e10

  let roentgen = 2.58e-7

  let rad = 1e2

  let solar_mass = 1.98892e33

  let bohr_radius = 5.291772083e-9

  let newton = 1e5

  let dyne = 1e0

  let joule = 1e7

  let erg = 1e0

  let stefan_boltzmann_constant = 5.67040047374e-5

  let thomson_cross_section = 6.65245893699e-25

end


module CGSM = struct

  let speed_of_light = 2.99792458e10

  let gravitational_constant = 6.673e-8

  let plancks_constant_h = 6.62606896e-27

  let plancks_constant_hbar = 1.05457162825e-27

  let astronomical_unit = 1.49597870691e13

  let light_year = 9.46053620707e17

  let parsec = 3.08567758135e18

  let grav_accel = 9.80665e2

  let electron_volt = 1.602176487e-12

  let mass_electron = 9.10938188e-28

  let mass_muon = 1.88353109e-25

  let mass_proton = 1.67262158e-24

  let mass_neutron = 1.67492716e-24

  let rydberg = 2.17987196968e-11

  let boltzmann = 1.3806504e-16

  let molar_gas = 8.314472e7

  let standard_gas_volume = 2.2710981e4

  let minute = 6e1

  let hour = 3.6e3

  let day = 8.64e4

  let week = 6.048e5

  let inch = 2.54e0

  let foot = 3.048e1

  let yard = 9.144e1

  let mile = 1.609344e5

  let nautical_mile = 1.852e5

  let fathom = 1.8288e2

  let mil = 2.54e-3

  let point = 3.52777777778e-2

  let texpoint = 3.51459803515e-2

  let micron = 1e-4

  let angstrom = 1e-8

  let hectare = 1e8

  let acre = 4.04685642241e7

  let barn = 1e-24

  let liter = 1e3

  let us_gallon = 3.78541178402e3

  let quart = 9.46352946004e2

  let pint = 4.73176473002e2

  let cup = 2.36588236501e2

  let fluid_ounce = 2.95735295626e1

  let tablespoon = 1.47867647813e1

  let teaspoon = 4.92892159375e0

  let canadian_gallon = 4.54609e3

  let uk_gallon = 4.546092e3

  let miles_per_hour = 4.4704e1

  let kilometers_per_hour = 2.77777777778e1

  let knot = 5.14444444444e1

  let pound_mass = 4.5359237e2

  let ounce_mass = 2.8349523125e1

  let ton = 9.0718474e5

  let metric_ton = 1e6

  let uk_ton = 1.0160469088e6

  let troy_ounce = 3.1103475e1

  let carat = 2e-1

  let unified_atomic_mass = 1.660538782e-24

  let gram_force = 9.80665e2

  let pound_force = 4.44822161526e5

  let kilopound_force = 4.44822161526e8

  let poundal = 1.38255e4

  let calorie = 4.1868e7

  let btu = 1.05505585262e10

  let therm = 1.05506e15

  let horsepower = 7.457e9

  let bar = 1e6

  let std_atmosphere = 1.01325e6

  let torr = 1.33322368421e3

  let meter_of_mercury = 1.33322368421e6

  let inch_of_mercury = 3.38638815789e4

  let inch_of_water = 2.490889e3

  let psi = 6.89475729317e4

  let poise = 1e0

  let stokes = 1e0

  let stilb = 1e0

  let lumen = 1e0

  let lux = 1e-4

  let phot = 1e0

  let footcandle = 1.076e-3

  let lambert = 1e0

  let footlambert = 1.07639104e-3

  let curie = 3.7e10

  let roentgen = 2.58e-8

  let rad = 1e2

  let solar_mass = 1.98892e33

  let bohr_radius = 5.291772083e-9

  let newton = 1e5

  let dyne = 1e0

  let joule = 1e7

  let erg = 1e0

  let stefan_boltzmann_constant = 5.67040047374e-5

  let thomson_cross_section = 6.65245893699e-25

  let bohr_magneton = 9.27400899e-21

  let nuclear_magneton = 5.05078317e-24

  let electron_magnetic_moment = 9.28476362e-21

  let proton_magnetic_moment = 1.410606633e-23

  let faraday = 9.64853429775e3

  let electron_charge = 1.602176487e-20

end


module MKS = struct

  let speed_of_light = 2.99792458e8

  let gravitational_constant = 6.673e-11

  let plancks_constant_h = 6.62606896e-34

  let plancks_constant_hbar = 1.05457162825e-34

  let astronomical_unit = 1.49597870691e11

  let light_year = 9.46053620707e15

  let parsec = 3.08567758135e16

  let grav_accel = 9.80665e0

  let electron_volt = 1.602176487e-19

  let mass_electron = 9.10938188e-31

  let mass_muon = 1.88353109e-28

  let mass_proton = 1.67262158e-27

  let mass_neutron = 1.67492716e-27

  let rydberg = 2.17987196968e-18

  let boltzmann = 1.3806504e-23

  let molar_gas = 8.314472e0

  let standard_gas_volume = 2.2710981e-2

  let minute = 6e1

  let hour = 3.6e3

  let day = 8.64e4

  let week = 6.048e5

  let inch = 2.54e-2

  let foot = 3.048e-1

  let yard = 9.144e-1

  let mile = 1.609344e3

  let nautical_mile = 1.852e3

  let fathom = 1.8288e0

  let mil = 2.54e-5

  let point = 3.52777777778e-4

  let texpoint = 3.51459803515e-4

  let micron = 1e-6

  let angstrom = 1e-10

  let hectare = 1e4

  let acre = 4.04685642241e3

  let barn = 1e-28

  let liter = 1e-3

  let us_gallon = 3.78541178402e-3

  let quart = 9.46352946004e-4

  let pint = 4.73176473002e-4

  let cup = 2.36588236501e-4

  let fluid_ounce = 2.95735295626e-5

  let tablespoon = 1.47867647813e-5

  let teaspoon = 4.92892159375e-6

  let canadian_gallon = 4.54609e-3

  let uk_gallon = 4.546092e-3

  let miles_per_hour = 4.4704e-1

  let kilometers_per_hour = 2.77777777778e-1

  let knot = 5.14444444444e-1

  let pound_mass = 4.5359237e-1

  let ounce_mass = 2.8349523125e-2

  let ton = 9.0718474e2

  let metric_ton = 1e3

  let uk_ton = 1.0160469088e3

  let troy_ounce = 3.1103475e-2

  let carat = 2e-4

  let unified_atomic_mass = 1.660538782e-27

  let gram_force = 9.80665e-3

  let pound_force = 4.44822161526e0

  let kilopound_force = 4.44822161526e3

  let poundal = 1.38255e-1

  let calorie = 4.1868e0

  let btu = 1.05505585262e3

  let therm = 1.05506e8

  let horsepower = 7.457e2

  let bar = 1e5

  let std_atmosphere = 1.01325e5

  let torr = 1.33322368421e2

  let meter_of_mercury = 1.33322368421e5

  let inch_of_mercury = 3.38638815789e3

  let inch_of_water = 2.490889e2

  let psi = 6.89475729317e3

  let poise = 1e-1

  let stokes = 1e-4

  let stilb = 1e4

  let lumen = 1e0

  let lux = 1e0

  let phot = 1e4

  let footcandle = 1.076e1

  let lambert = 1e4

  let footlambert = 1.07639104e1

  let curie = 3.7e10

  let roentgen = 2.58e-4

  let rad = 1e-2

  let solar_mass = 1.98892e30

  let bohr_radius = 5.291772083e-11

  let newton = 1e0

  let dyne = 1e-5

  let joule = 1e0

  let erg = 1e-7

  let stefan_boltzmann_constant = 5.67040047374e-8

  let thomson_cross_section = 6.65245893699e-29

  let bohr_magneton = 9.27400899e-24

  let nuclear_magneton = 5.05078317e-27

  let electron_magnetic_moment = 9.28476362e-24

  let proton_magnetic_moment = 1.410606633e-26

  let faraday = 9.64853429775e4

  let electron_charge = 1.602176487e-19

  let vacuum_permittivity = 8.854187817e-12

  let vacuum_permeability = 1.25663706144e-6

  let debye = 3.33564095198e-30

  let gauss = 1e-4

end


module SI = struct

  let speed_of_light = 2.99792458e8

  let gravitational_constant = 6.673e-11

  let plancks_constant_h = 6.62606896e-34

  let plancks_constant_hbar = 1.05457162825e-34

  let astronomical_unit = 1.49597870691e11

  let light_year = 9.46053620707e15

  let parsec = 3.08567758135e16

  let grav_accel = 9.80665e0

  let electron_volt = 1.602176487e-19

  let mass_electron = 9.10938188e-31

  let mass_muon = 1.88353109e-28

  let mass_proton = 1.67262158e-27

  let mass_neutron = 1.67492716e-27

  let rydberg = 2.17987196968e-18

  let boltzmann = 1.3806504e-23

  let molar_gas = 8.314472e0

  let standard_gas_volume = 2.2710981e-2

  let minute = 6e1

  let hour = 3.6e3

  let day = 8.64e4

  let week = 6.048e5

  let inch = 2.54e-2

  let foot = 3.048e-1

  let yard = 9.144e-1

  let mile = 1.609344e3

  let nautical_mile = 1.852e3

  let fathom = 1.8288e0

  let mil = 2.54e-5

  let point = 3.52777777778e-4

  let texpoint = 3.51459803515e-4

  let micron = 1e-6

  let angstrom = 1e-10

  let hectare = 1e4

  let acre = 4.04685642241e3

  let barn = 1e-28

  let liter = 1e-3

  let us_gallon = 3.78541178402e-3

  let quart = 9.46352946004e-4

  let pint = 4.73176473002e-4

  let cup = 2.36588236501e-4

  let fluid_ounce = 2.95735295626e-5

  let tablespoon = 1.47867647813e-5

  let teaspoon = 4.92892159375e-6

  let canadian_gallon = 4.54609e-3

  let uk_gallon = 4.546092e-3

  let miles_per_hour = 4.4704e-1

  let kilometers_per_hour = 2.77777777778e-1

  let knot = 5.14444444444e-1

  let pound_mass = 4.5359237e-1

  let ounce_mass = 2.8349523125e-2

  let ton = 9.0718474e2

  let metric_ton = 1e3

  let uk_ton = 1.0160469088e3

  let troy_ounce = 3.1103475e-2

  let carat = 2e-4

  let unified_atomic_mass = 1.660538782e-27

  let gram_force = 9.80665e-3

  let pound_force = 4.44822161526e0

  let kilopound_force = 4.44822161526e3

  let poundal = 1.38255e-1

  let calorie = 4.1868e0

  let btu = 1.05505585262e3

  let therm = 1.05506e8

  let horsepower = 7.457e2

  let bar = 1e5

  let std_atmosphere = 1.01325e5

  let torr = 1.33322368421e2

  let meter_of_mercury = 1.33322368421e5

  let inch_of_mercury = 3.38638815789e3

  let inch_of_water = 2.490889e2

  let psi = 6.89475729317e3

  let poise = 1e-1

  let stokes = 1e-4

  let stilb = 1e4

  let lumen = 1e0

  let lux = 1e0

  let phot = 1e4

  let footcandle = 1.076e1

  let lambert = 1e4

  let footlambert = 1.07639104e1

  let curie = 3.7e10

  let roentgen = 2.58e-4

  let rad = 1e-2

  let solar_mass = 1.98892e30

  let bohr_radius = 5.291772083e-11

  let newton = 1e0

  let dyne = 1e-5

  let joule = 1e0

  let erg = 1e-7

  let stefan_boltzmann_constant = 5.67040047374e-8

  let thomson_cross_section = 6.65245893699e-29

  let bohr_magneton = 9.27400899e-24

  let nuclear_magneton = 5.05078317e-27

  let electron_magnetic_moment = 9.28476362e-24

  let proton_magnetic_moment = 1.410606633e-26

  let faraday = 9.64853429775e4

  let electron_charge = 1.602176487e-19

  let vacuum_permittivity = 8.854187817e-12

  let vacuum_permeability = 1.25663706144e-6

  let debye = 3.33564095198e-30

  let gauss = 1e-4

end
