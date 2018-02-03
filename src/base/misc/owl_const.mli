(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Metric system: CGS, MKS, SI, and physical constants. *)

(** Values of physical constants
  CGS < MKS < SI. Read wikipedia on CGS and SI system for more details.

  International System of Units (French: Système international d'unités, SI),
  historically also called the MKSA system of units for
  metre–kilogram–second–ampere.

  The SI system of units extends the MKS system and has 7 base units, by
  expressing any measurement of physical quantities using fundamental units
  of Length, Mass, Time, Electric Current, Thermodynamic Temperature, Amount
  of substance and Luminous Intensity, which are Metre, Kilogram, Second,
  Ampere, Kelvin, Mole and Candela respectively.

  http://www.npl.co.uk/upload/pdf/units-of-measurement-poster.pdf
*)


(** {6 Maths constants} *)

val e : float
(** e = 2.718281828459045235360287471352662498 *)

val euler : float
(** euler = 0.577215664901532860606512090082402431 *)

val log2e : float
(** log2e = 1.442695040888963407359924681001892137 *)

val log10e : float
(** log10e = 0.434294481903251827651128918916605082 *)

val loge2 : float
(** loge2 = 0.693147180559945309417232121458176568 *)

val loge10 : float
(** loge10 = 2.302585092994045684017991454684364208 *)

val logepi : float
(** logepi = 1.144729885849400174143427351353058711 *)

val sqrt1_2 : float
(** sqrt1_2 = 0.707106781186547524400844362104849039 *)

val sqrt2 : float
(** sqrt2 = 1.414213562373095048801688724209698079 *)

val sqrt3 : float
(** sqrt3 = 1.732050807568877293527446341505872366 *)

val sqrtpi : float
(** sqrtpi = 1.772453850905516027298167483341145182 *)

val pi : float
(** pi = 3.141592653589793238462643383279502884 *)

val pi2 : float
(** pi2 = 6.283185307179586476925286766559005768 *)

val pi4 : float
(** pi4 = 12.56637061435917295385057353311801153 *)

val pi_2 : float
(** pi_2 = 1.570796326794896619231321691639751442 *)

val pi_4 : float
(** pi_4 = 0.785398163397448309615660845819875721 *)


(** {6 Constants depending on Bigarray kind} *)

val zero : ('a, 'b) Bigarray.kind -> 'a
(** ``zero kind`` returns value zero of the given number type ``kind``. *)

val one : ('a, 'b) Bigarray.kind -> 'a
(** ``one kind`` returns value one of the given number type ``kind``. *)

val neg_one : ('a, 'b) Bigarray.kind -> 'a
(** ``neg_one kind`` returns negative one of the given number type ``kind``. *)

val pos_inf : ('a, 'b) Bigarray.kind -> 'a
(** ``pos_inf kind`` returns positive infinity of the given number type ``kind``. *)

val neg_inf : ('a, 'b) Bigarray.kind -> 'a
(** ``neg_inf kind`` returns negative infinity of the given number type ``kind``. *)


(** {6 Unit prefixes} *)

module Prefix = struct

  val fine_structure : float
  (** fine_structure = 7.297352533e-3 *)

  val avogadro : float
  (** avogadro = 6.02214199e23 *)

  val yotta : float
  (** yotta = 1e24 *)

  val zetta : float
  (** zetta = 1e21 *)

  val exa : float
  (** exa = 1e18 *)

  val peta : float
  (** peta = 1e15 *)

  val tera : float
  (** tera = 1e12 *)

  val giga : float
  (** giga = 1e9 *)

  val mega : float
  (** mega = 1e6 *)

  val kilo : float
  (** kilo = 1e3 *)

  val hecto : float
  (** hecto = 1e2 *)

  val deca : float
  (** deca = 1e1 *)

  val deci : float
  (** deci = 1e-1 *)

  val centi : float
  (** centi = 1e-2 *)

  val milli : float
  (** milli = 1e-3 *)

  val micro : float
  (** micro = 1e-6 *)

  val nano : float
  (** nano = 1e-9 *)

  val pico : float
  (** pico = 1e-12 *)

  val femto : float
  (** femto = 1e-15 *)

  val atto : float
  (** atto = 1e-18 *)

  val zepto : float
  (** zepto = 1e-21 *)

  val yocto : float
  (** yocto = 1e-24 *)

end


(** {6 SI: International System of Units} *)

module SI = struct

  val speed_of_light : float
  (** speed_of_light = 2.99792458e8 *)

  val gravitational_constant : float
  (** gravitational_constant = 6.673e-11 *)

  val plancks_constant_h : float
  (** plancks_constant_h = 6.62606896e-34 *)

  val plancks_constant_hbar : float
  (** plancks_constant_hbar = 1.05457162825e-34 *)

  val astronomical_unit : float
  (** astronomical_unit = 1.49597870691e11 *)

  val light_year : float
  (** light_year = 9.46053620707e15 *)

  val parsec : float
  (** parsec = 3.08567758135e16 *)

  val grav_accel : float
  (** grav_accel = 9.80665e0 *)

  val electron_volt : float
  (** electron_volt = 1.602176487e-19 *)

  val mass_electron : float
  (** mass_electron = 9.10938188e-31 *)

  val mass_muon : float
  (** mass_muon = 1.88353109e-28 *)

  val mass_proton : float
  (** mass_proton = 1.67262158e-27 *)

  val mass_neutron : float
  (** mass_neutron = 1.67492716e-27 *)

  val rydberg : float
  (** rydberg = 2.17987196968e-18 *)

  val boltzmann : float
  (** boltzmann = 1.3806504e-23 *)

  val molar_gas : float
  (** molar_gas = 8.314472e0 *)

  val standard_gas_volume : float
  (** standard_gas_volume = 2.2710981e-2 *)

  val minute : float
  (** minute = 6e1 *)

  val hour : float
  (** hour = 3.6e3 *)

  val day : float
  (** day = 8.64e4 *)

  val week : float
  (** week = 6.048e5 *)

  val inch : float
  (** inch = 2.54e-2 *)

  val foot : float
  (** foot = 3.048e-1 *)

  val yard : float
  (** yard = 9.144e-1 *)

  val mile : float
  (** mile = 1.609344e3 *)

  val nautical_mile : float
  (** nautical_mile = 1.852e3 *)

  val fathom : float
  (** fathom = 1.8288e0 *)

  val mil : float
  (** mil = 2.54e-5 *)

  val point : float
  (** point = 3.52777777778e-4 *)

  val texpoint : float
  (** texpoint = 3.51459803515e-4 *)

  val micron : float
  (** micron = 1e-6 *)

  val angstrom : float
  (** angstrom = 1e-10 *)

  val hectare : float
  (** hectare = 1e4 *)

  val acre : float
  (** acre = 4.04685642241e3 *)

  val barn : float
  (** barn = 1e-28 *)

  val liter : float
  (** liter = 1e-3 *)

  val us_gallon : float
  (** us_gallon = 3.78541178402e-3 *)

  val quart : float
  (** quart = 9.46352946004e-4 *)

  val pint : float
  (** pint = 4.73176473002e-4 *)

  val cup : float
  (** cup = 2.36588236501e-4 *)

  val fluid_ounce : float
  (** fluid_ounce = 2.95735295626e-5 *)

  val tablespoon : float
  (** tablespoon = 1.47867647813e-5 *)

  val teaspoon : float
  (** teaspoon = 4.92892159375e-6 *)

  val canadian_gallon : float
  (** canadian_gallon = 4.54609e-3 *)

  val uk_gallon : float
  (** uk_gallon = 4.546092e-3 *)

  val miles_per_hour : float
  (** miles_per_hour = 4.4704e-1 *)

  val kilometers_per_hour : float
  (** kilometers_per_hour = 2.77777777778e-1 *)

  val knot : float
  (** knot = 5.14444444444e-1 *)

  val pound_mass : float
  (** pound_mass = 4.5359237e-1 *)

  val ounce_mass : float
  (** ounce_mass = 2.8349523125e-2 *)

  val ton : float
  (** ton = 9.0718474e2 *)

  val metric_ton : float
  (** metric_ton = 1e3 *)

  val uk_ton : float
  (** uk_ton = 1.0160469088e3 *)

  val troy_ounce : float
  (** troy_ounce = 3.1103475e-2 *)

  val carat : float
  (** carat = 2e-4 *)

  val unified_atomic_mass : float
  (** unified_atomic_mass = 1.660538782e-27 *)

  val gram_force : float
  (** gram_force = 9.80665e-3 *)

  val pound_force : float
  (** pound_force = 4.44822161526e0 *)

  val kilopound_force : float
  (** kilopound_force = 4.44822161526e3 *)

  val poundal : float
  (** poundal = 1.38255e-1 *)

  val calorie : float
  (** calorie = 4.1868e0 *)

  val btu : float
  (** btu = 1.05505585262e3 *)

  val therm : float
  (** therm = 1.05506e8 *)

  val horsepower : float
  (** horsepower = 7.457e2 *)

  val bar : float
  (** bar = 1e5 *)

  val std_atmosphere : float
  (** std_atmosphere = 1.01325e5 *)

  val torr : float
  (** torr = 1.33322368421e2 *)

  val meter_of_mercury : float
  (** meter_of_mercury = 1.33322368421e5 *)

  val inch_of_mercury : float
  (** inch_of_mercury = 3.38638815789e3 *)

  val inch_of_water : float
  (** inch_of_water = 2.490889e2 *)

  val psi : float
  (** psi = 6.89475729317e3 *)

  val poise : float
  (** poise = 1e-1 *)

  val stokes : float
  (** stokes = 1e-4 *)

  val stilb : float
  (** stilb = 1e4 *)

  val lumen : float
  (** lumen = 1e0 *)

  val lux : float
  (** lux = 1e0 *)

  val phot : float
  (** phot = 1e4 *)

  val footcandle : float
  (** footcandle = 1.076e1 *)

  val lambert : float
  (** lambert = 1e4 *)

  val footlambert : float
  (** footlambert = 1.07639104e1 *)

  val curie : float
  (** curie = 3.7e10 *)

  val roentgen : float
  (** roentgen = 2.58e-4 *)

  val rad : float
  (** rad = 1e-2 *)

  val solar_mass : float
  (** solar_mass = 1.98892e30 *)

  val bohr_radius : float
  (** bohr_radius = 5.291772083e-11 *)

  val newton : float
  (** newton = 1e0 *)

  val dyne : float
  (** dyne = 1e-5 *)

  val joule : float
  (** joule = 1e0 *)

  val erg : float
  (** erg = 1e-7 *)

  val stefan_boltzmann_constant : float
  (** stefan_boltzmann_constant = 5.67040047374e-8 *)

  val thomson_cross_section : float
  (** thomson_cross_section = 6.65245893699e-29 *)

  val bohr_magneton : float
  (** bohr_magneton = 9.27400899e-24 *)

  val nuclear_magneton : float
  (** nuclear_magneton = 5.05078317e-27 *)

  val electron_magnetic_moment : float
  (** electron_magnetic_moment = 9.28476362e-24 *)

  val proton_magnetic_moment : float
  (** proton_magnetic_moment = 1.410606633e-26 *)

  val faraday : float
  (** faraday = 9.64853429775e4 *)

  val electron_charge : float
  (** electron_charge = 1.602176487e-19 *)

  val vacuum_permittivity : float
  (** vacuum_permittivity = 8.854187817e-12 *)

  val vacuum_permeability : float
  (** vacuum_permeability = 1.25663706144e-6 *)

  val debye : float
  (** debye = 3.33564095198e-30 *)

  val gauss : float
  (** gauss = 1e-4 *)

end


(** {6 MKS: MKS system of units} *)

module MKS = struct

  val speed_of_light : float
  (** speed_of_light = 2.99792458e8 *)

  val gravitational_constant : float
  (** gravitational_constant = 6.673e-11 *)

  val plancks_constant_h : float
  (** plancks_constant_h = 6.62606896e-34 *)

  val plancks_constant_hbar : float
  (** plancks_constant_hbar = 1.05457162825e-34 *)

  val astronomical_unit : float
  (** astronomical_unit = 1.49597870691e11 *)

  val light_year : float
  (** light_year = 9.46053620707e15 *)

  val parsec : float
  (** parsec = 3.08567758135e16 *)

  val grav_accel : float
  (** grav_accel = 9.80665e0 *)

  val electron_volt : float
  (** electron_volt = 1.602176487e-19 *)

  val mass_electron : float
  (** mass_electron = 9.10938188e-31 *)

  val mass_muon : float
  (** mass_muon = 1.88353109e-28 *)

  val mass_proton : float
  (** mass_proton = 1.67262158e-27 *)

  val mass_neutron : float
  (** mass_neutron = 1.67492716e-27 *)

  val rydberg : float
  (** rydberg = 2.17987196968e-18 *)

  val boltzmann : float
  (** boltzmann = 1.3806504e-23 *)

  val molar_gas : float
  (** molar_gas = 8.314472e0 *)

  val standard_gas_volume : float
  (** standard_gas_volume = 2.2710981e-2 *)

  val minute : float
  (** minute = 6e1 *)

  val hour : float
  (** hour = 3.6e3 *)

  val day : float
  (** day = 8.64e4 *)

  val week : float
  (** week = 6.048e5 *)

  val inch : float
  (** inch = 2.54e-2 *)

  val foot : float
  (** foot = 3.048e-1 *)

  val yard : float
  (** yard = 9.144e-1 *)

  val mile : float
  (** mile = 1.609344e3 *)

  val nautical_mile : float
  (** nautical_mile = 1.852e3 *)

  val fathom : float
  (** fathom = 1.8288e0 *)

  val mil : float
  (** mil = 2.54e-5 *)

  val point : float
  (** point = 3.52777777778e-4 *)

  val texpoint : float
  (** texpoint = 3.51459803515e-4 *)

  val micron : float
  (** micron = 1e-6 *)

  val angstrom : float
  (** angstrom = 1e-10 *)

  val hectare : float
  (** hectare = 1e4 *)

  val acre : float
  (** acre = 4.04685642241e3 *)

  val barn : float
  (** barn = 1e-28 *)

  val liter : float
  (** liter = 1e-3 *)

  val us_gallon : float
  (** us_gallon = 3.78541178402e-3 *)

  val quart : float
  (** quart = 9.46352946004e-4 *)

  val pint : float
  (** pint = 4.73176473002e-4 *)

  val cup : float
  (** cup = 2.36588236501e-4 *)

  val fluid_ounce : float
  (** fluid_ounce = 2.95735295626e-5 *)

  val tablespoon : float
  (** tablespoon = 1.47867647813e-5 *)

  val teaspoon : float
  (** teaspoon = 4.92892159375e-6 *)

  val canadian_gallon : float
  (** canadian_gallon = 4.54609e-3 *)

  val uk_gallon : float
  (** uk_gallon = 4.546092e-3 *)

  val miles_per_hour : float
  (** miles_per_hour = 4.4704e-1 *)

  val kilometers_per_hour : float
  (** kilometers_per_hour = 2.77777777778e-1 *)

  val knot : float
  (** knot = 5.14444444444e-1 *)

  val pound_mass : float
  (** pound_mass = 4.5359237e-1 *)

  val ounce_mass : float
  (** ounce_mass = 2.8349523125e-2 *)

  val ton : float
  (** ton = 9.0718474e2 *)

  val metric_ton : float
  (** metric_ton = 1e3 *)

  val uk_ton : float
  (** uk_ton = 1.0160469088e3 *)

  val troy_ounce : float
  (** troy_ounce = 3.1103475e-2 *)

  val carat : float
  (** carat = 2e-4 *)

  val unified_atomic_mass : float
  (** unified_atomic_mass = 1.660538782e-27 *)

  val gram_force : float
  (** gram_force = 9.80665e-3 *)

  val pound_force : float
  (** pound_force = 4.44822161526e0 *)

  val kilopound_force : float
  (** kilopound_force = 4.44822161526e3 *)

  val poundal : float
  (** poundal = 1.38255e-1 *)

  val calorie : float
  (** calorie = 4.1868e0 *)

  val btu : float
  (** btu = 1.05505585262e3 *)

  val therm : float
  (** therm = 1.05506e8 *)

  val horsepower : float
  (** horsepower = 7.457e2 *)

  val bar : float
  (** bar = 1e5 *)

  val std_atmosphere : float
  (** std_atmosphere = 1.01325e5 *)

  val torr : float
  (** torr = 1.33322368421e2 *)

  val meter_of_mercury : float
  (** meter_of_mercury = 1.33322368421e5 *)

  val inch_of_mercury : float
  (** inch_of_mercury = 3.38638815789e3 *)

  val inch_of_water : float
  (** inch_of_water = 2.490889e2 *)

  val psi : float
  (** psi = 6.89475729317e3 *)

  val poise : float
  (** poise = 1e-1 *)

  val stokes : float
  (** stokes = 1e-4 *)

  val stilb : float
  (** stilb = 1e4 *)

  val lumen : float
  (** lumen = 1e0 *)

  val lux : float
  (** lux = 1e0 *)

  val phot : float
  (** phot = 1e4 *)

  val footcandle : float
  (** footcandle = 1.076e1 *)

  val lambert : float
  (** lambert = 1e4 *)

  val footlambert : float
  (** footlambert = 1.07639104e1 *)

  val curie : float
  (** curie = 3.7e10 *)

  val roentgen : float
  (** roentgen = 2.58e-4 *)

  val rad : float
  (** rad = 1e-2 *)

  val solar_mass : float
  (** solar_mass = 1.98892e30 *)

  val bohr_radius : float
  (** bohr_radius = 5.291772083e-11 *)

  val newton : float
  (** newton = 1e0 *)

  val dyne : float
  (** dyne = 1e-5 *)

  val joule : float
  (** joule = 1e0 *)

  val erg : float
  (** erg = 1e-7 *)

  val stefan_boltzmann_constant : float
  (** stefan_boltzmann_constant = 5.67040047374e-8 *)

  val thomson_cross_section : float
  (** thomson_cross_section = 6.65245893699e-29 *)

  val bohr_magneton : float
  (** bohr_magneton = 9.27400899e-24 *)

  val nuclear_magneton : float
  (** nuclear_magneton = 5.05078317e-27 *)

  val electron_magnetic_moment : float
  (** electron_magnetic_moment = 9.28476362e-24 *)

  val proton_magnetic_moment : float
  (** proton_magnetic_moment = 1.410606633e-26 *)

  val faraday : float
  (** faraday = 9.64853429775e4 *)

  val electron_charge : float
  (** electron_charge = 1.602176487e-19 *)

  val vacuum_permittivity : float
  (** vacuum_permittivity = 8.854187817e-12 *)

  val vacuum_permeability : float
  (** vacuum_permeability = 1.25663706144e-6 *)

  val debye : float
  (** debye = 3.33564095198e-30 *)

  val gauss : float
  (** gauss = 1e-4 *)

end


(** {6 CGS: Centimetre–gram–second system of units} *)

module CGS = struct

  val speed_of_light : float
  (** speed_of_light = 2.99792458e10 *)

  val gravitational_constant : float
  (** gravitational_constant = 6.673e-8 *)

  val plancks_constant_h : float
  (** plancks_constant_h = 6.62606896e-27 *)

  val plancks_constant_hbar : float
  (** plancks_constant_hbar = 1.05457162825e-27 *)

  val astronomical_unit : float
  (** astronomical_unit = 1.49597870691e13 *)

  val light_year : float
  (** light_year = 9.46053620707e17 *)

  val parsec : float
  (** parsec = 3.08567758135e18 *)

  val grav_accel : float
  (** grav_accel = 9.80665e2 *)

  val electron_volt : float
  (** electron_volt = 1.602176487e-12 *)

  val mass_electron : float
  (** mass_electron = 9.10938188e-28 *)

  val mass_muon : float
  (** mass_muon = 1.88353109e-25 *)

  val mass_proton : float
  (** mass_proton = 1.67262158e-24 *)

  val mass_neutron : float
  (** mass_neutron = 1.67492716e-24 *)

  val rydberg : float
  (** rydberg = 2.17987196968e-11 *)

  val boltzmann : float
  (** boltzmann = 1.3806504e-16 *)

  val molar_gas : float
  (** molar_gas = 8.314472e7 *)

  val standard_gas_volume : float
  (** standard_gas_volume = 2.2710981e4 *)

  val minute : float
  (** minute = 6e1 *)

  val hour : float
  (** hour = 3.6e3 *)

  val day : float
  (** day = 8.64e4 *)

  val week : float
  (** week = 6.048e5 *)

  val inch : float
  (** inch = 2.54e0 *)

  val foot : float
  (** foot = 3.048e1 *)

  val yard : float
  (** yard = 9.144e1 *)

  val mile : float
  (** mile = 1.609344e5 *)

  val nautical_mile : float
  (** nautical_mile = 1.852e5 *)

  val fathom : float
  (** fathom = 1.8288e2 *)

  val mil : float
  (** mil = 2.54e-3 *)

  val point : float
  (** point = 3.52777777778e-2 *)

  val texpoint : float
  (** texpoint = 3.51459803515e-2 *)

  val micron : float
  (** micron = 1e-4 *)

  val angstrom : float
  (** angstrom = 1e-8 *)

  val hectare : float
  (** hectare = 1e8 *)

  val acre : float
  (** acre = 4.04685642241e7 *)

  val barn : float
  (** barn = 1e-24 *)

  val liter : float
  (** liter = 1e3 *)

  val us_gallon : float
  (** us_gallon = 3.78541178402e3 *)

  val quart : float
  (** quart = 9.46352946004e2 *)

  val pint : float
  (** pint = 4.73176473002e2 *)

  val cup : float
  (** cup = 2.36588236501e2 *)

  val fluid_ounce : float
  (** fluid_ounce = 2.95735295626e1 *)

  val tablespoon : float
  (** tablespoon = 1.47867647813e1 *)

  val teaspoon : float
  (** teaspoon = 4.92892159375e0 *)

  val canadian_gallon : float
  (** canadian_gallon = 4.54609e3 *)

  val uk_gallon : float
  (** uk_gallon = 4.546092e3 *)

  val miles_per_hour : float
  (** miles_per_hour = 4.4704e1 *)

  val kilometers_per_hour : float
  (** kilometers_per_hour = 2.77777777778e1 *)

  val knot : float
  (** knot = 5.14444444444e1 *)

  val pound_mass : float
  (** pound_mass = 4.5359237e2 *)

  val ounce_mass : float
  (** ounce_mass = 2.8349523125e1 *)

  val ton : float
  (** ton = 9.0718474e5 *)

  val metric_ton : float
  (** metric_ton = 1e6 *)

  val uk_ton : float
  (** uk_ton = 1.0160469088e6 *)

  val troy_ounce : float
  (** troy_ounce = 3.1103475e1 *)

  val carat : float
  (** carat = 2e-1 *)

  val unified_atomic_mass : float
  (** unified_atomic_mass = 1.660538782e-24 *)

  val gram_force : float
  (** gram_force = 9.80665e2 *)

  val pound_force : float
  (** pound_force = 4.44822161526e5 *)

  val kilopound_force : float
  (** kilopound_force = 4.44822161526e8 *)

  val poundal : float
  (** poundal = 1.38255e4 *)

  val calorie : float
  (** calorie = 4.1868e7 *)

  val btu : float
  (** btu = 1.05505585262e10 *)

  val therm : float
  (** therm = 1.05506e15 *)

  val horsepower : float
  (** horsepower = 7.457e9 *)

  val bar : float
  (** bar = 1e6 *)

  val std_atmosphere : float
  (** std_atmosphere = 1.01325e6 *)

  val torr : float
  (** torr = 1.33322368421e3 *)

  val meter_of_mercury : float
  (** meter_of_mercury = 1.33322368421e6 *)

  val inch_of_mercury : float
  (** inch_of_mercury = 3.38638815789e4 *)

  val inch_of_water : float
  (** inch_of_water = 2.490889e3 *)

  val psi : float
  (** psi = 6.89475729317e4 *)

  val poise : float
  (** poise = 1e0 *)

  val stokes : float
  (** stokes = 1e0 *)

  val stilb : float
  (** stilb = 1e0 *)

  val lumen : float
  (** lumen = 1e0 *)

  val lux : float
  (** lux = 1e-4 *)

  val phot : float
  (** phot = 1e0 *)

  val footcandle : float
  (** footcandle = 1.076e-3 *)

  val lambert : float
  (** lambert = 1e0 *)

  val footlambert : float
  (** footlambert = 1.07639104e-3 *)

  val curie : float
  (** curie = 3.7e10 *)

  val roentgen : float
  (** roentgen = 2.58e-7 *)

  val rad : float
  (** rad = 1e2 *)

  val solar_mass : float
  (** solar_mass = 1.98892e33 *)

  val bohr_radius : float
  (** bohr_radius = 5.291772083e-9 *)

  val newton : float
  (** newton = 1e5 *)

  val dyne : float
  (** dyne = 1e0 *)

  val joule : float
  (** joule = 1e7 *)

  val erg : float
  (** erg = 1e0 *)

  val stefan_boltzmann_constant : float
  (** stefan_boltzmann_constant = 5.67040047374e-5 *)

  val thomson_cross_section : float
  (** thomson_cross_section = 6.65245893699e-25 *)

end


(** {6 CGSM: Unit Systems in Electromagnetism} *)

module CGSM = struct

  val speed_of_light : float
  (** speed_of_light = 2.99792458e10 *)

  val gravitational_constant : float
  (** gravitational_constant = 6.673e-8 *)

  val plancks_constant_h : float
  (** plancks_constant_h = 6.62606896e-27 *)

  val plancks_constant_hbar : float
  (** plancks_constant_hbar = 1.05457162825e-27 *)

  val astronomical_unit : float
  (** astronomical_unit = 1.49597870691e13 *)

  val light_year : float
  (** light_year = 9.46053620707e17 *)

  val parsec : float
  (** parsec = 3.08567758135e18 *)

  val grav_accel : float
  (** grav_accel = 9.80665e2 *)

  val electron_volt : float
  (** electron_volt = 1.602176487e-12 *)

  val mass_electron : float
  (** mass_electron = 9.10938188e-28 *)

  val mass_muon : float
  (** mass_muon = 1.88353109e-25 *)

  val mass_proton : float
  (** mass_proton = 1.67262158e-24 *)

  val mass_neutron : float
  (** mass_neutron = 1.67492716e-24 *)

  val rydberg : float
  (** rydberg = 2.17987196968e-11 *)

  val boltzmann : float
  (** boltzmann = 1.3806504e-16 *)

  val molar_gas : float
  (** molar_gas = 8.314472e7 *)

  val standard_gas_volume : float
  (** standard_gas_volume = 2.2710981e4 *)

  val minute : float
  (** minute = 6e1 *)

  val hour : float
  (** hour = 3.6e3 *)

  val day : float
  (** day = 8.64e4 *)

  val week : float
  (** week = 6.048e5 *)

  val inch : float
  (** inch = 2.54e0 *)

  val foot : float
  (** foot = 3.048e1 *)

  val yard : float
  (** yard = 9.144e1 *)

  val mile : float
  (** mile = 1.609344e5 *)

  val nautical_mile : float
  (** nautical_mile = 1.852e5 *)

  val fathom : float
  (** fathom = 1.8288e2 *)

  val mil : float
  (** mil = 2.54e-3 *)

  val point : float
  (** point = 3.52777777778e-2 *)

  val texpoint : float
  (** texpoint = 3.51459803515e-2 *)

  val micron : float
  (** micron = 1e-4 *)

  val angstrom : float
  (** angstrom = 1e-8 *)

  val hectare : float
  (** hectare = 1e8 *)

  val acre : float
  (** acre = 4.04685642241e7 *)

  val barn : float
  (** barn = 1e-24 *)

  val liter : float
  (** liter = 1e3 *)

  val us_gallon : float
  (** us_gallon = 3.78541178402e3 *)

  val quart : float
  (** quart = 9.46352946004e2 *)

  val pint : float
  (** pint = 4.73176473002e2 *)

  val cup : float
  (** cup = 2.36588236501e2 *)

  val fluid_ounce : float
  (** fluid_ounce = 2.95735295626e1 *)

  val tablespoon : float
  (** tablespoon = 1.47867647813e1 *)

  val teaspoon : float
  (** teaspoon = 4.92892159375e0 *)

  val canadian_gallon : float
  (** canadian_gallon = 4.54609e3 *)

  val uk_gallon : float
  (** uk_gallon = 4.546092e3 *)

  val miles_per_hour : float
  (** miles_per_hour = 4.4704e1 *)

  val kilometers_per_hour : float
  (** kilometers_per_hour = 2.77777777778e1 *)

  val knot : float
  (** knot = 5.14444444444e1 *)

  val pound_mass : float
  (** pound_mass = 4.5359237e2 *)

  val ounce_mass : float
  (** ounce_mass = 2.8349523125e1 *)

  val ton : float
  (** ton = 9.0718474e5 *)

  val metric_ton : float
  (** metric_ton = 1e6 *)

  val uk_ton : float
  (** uk_ton = 1.0160469088e6 *)

  val troy_ounce : float
  (** troy_ounce = 3.1103475e1 *)

  val carat : float
  (** carat = 2e-1 *)

  val unified_atomic_mass : float
  (** unified_atomic_mass = 1.660538782e-24 *)

  val gram_force : float
  (** gram_force = 9.80665e2 *)

  val pound_force : float
  (** pound_force = 4.44822161526e5 *)

  val kilopound_force : float
  (** kilopound_force = 4.44822161526e8 *)

  val poundal : float
  (** poundal = 1.38255e4 *)

  val calorie : float
  (** calorie = 4.1868e7 *)

  val btu : float
  (** btu = 1.05505585262e10 *)

  val therm : float
  (** therm = 1.05506e15 *)

  val horsepower : float
  (** horsepower = 7.457e9 *)

  val bar : float
  (** bar = 1e6 *)

  val std_atmosphere : float
  (** std_atmosphere = 1.01325e6 *)

  val torr : float
  (** torr = 1.33322368421e3 *)

  val meter_of_mercury : float
  (** meter_of_mercury = 1.33322368421e6 *)

  val inch_of_mercury : float
  (** inch_of_mercury = 3.38638815789e4 *)

  val inch_of_water : float
  (** inch_of_water = 2.490889e3 *)

  val psi : float
  (** psi = 6.89475729317e4 *)

  val poise : float
  (** poise = 1e0 *)

  val stokes : float
  (** stokes = 1e0 *)

  val stilb : float
  (** stilb = 1e0 *)

  val lumen : float
  (** lumen = 1e0 *)

  val lux : float
  (** lux = 1e-4 *)

  val phot : float
  (** phot = 1e0 *)

  val footcandle : float
  (** footcandle = 1.076e-3 *)

  val lambert : float
  (** lambert = 1e0 *)

  val footlambert : float
  (** footlambert = 1.07639104e-3 *)

  val curie : float
  (** curie = 3.7e10 *)

  val roentgen : float
  (** roentgen = 2.58e-8 *)

  val rad : float
  (** rad = 1e2 *)

  val solar_mass : float
  (** solar_mass = 1.98892e33 *)

  val bohr_radius : float
  (** bohr_radius = 5.291772083e-9 *)

  val newton : float
  (** newton = 1e5 *)

  val dyne : float
  (** dyne = 1e0 *)

  val joule : float
  (** joule = 1e7 *)

  val erg : float
  (** erg = 1e0 *)

  val stefan_boltzmann_constant : float
  (** stefan_boltzmann_constant = 5.67040047374e-5 *)

  val thomson_cross_section : float
  (** thomson_cross_section = 6.65245893699e-25 *)

  val bohr_magneton : float
  (** bohr_magneton = 9.27400899e-21 *)

  val nuclear_magneton : float
  (** nuclear_magneton = 5.05078317e-24 *)

  val electron_magnetic_moment : float
  (** electron_magnetic_moment = 9.28476362e-21 *)

  val proton_magnetic_moment : float
  (** proton_magnetic_moment = 1.410606633e-23 *)

  val faraday : float
  (** faraday = 9.64853429775e3 *)

  val electron_charge : float
  (** electron_charge = 1.602176487e-20 *)

end
