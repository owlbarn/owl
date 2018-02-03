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
(** e *)

val euler : float
(** Euler constant *)

val log2e : float
(** log2_e *)

val log10e : float
(** log_10 e *)

val loge2 : float
(** log_e 2 *)

val loge10 : float
(** log_e 10 *)

val logepi : float
(** log_e pi *)

val sqrt1_2 : float
(** 1/sqrt(2) *)

val sqrt2 : float
(** sqrt(2) *)

val sqrt3 : float
(** sqrt(3) *)

val sqrtpi : float
(** sqrt(pi) *)

val pi : float
(** pi *)

val pi2 : float
(** 2*pi *)

val pi4 : float
(** 4*pi *)

val pi_2 : float
(** pi/2 *)

val pi_4 : float
(** pi/4 *)


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

module Prefix : sig
  val fine_structure : float
  (** fine_structure *)

  val avogadro : float
  (** avogadro *)

  val yotta : float
  (** yotta *)

  val zetta : float
  (** zetta *)

  val exa : float
  (** exa *)

  val peta : float
  (** peta *)

  val tera : float
  (** tera *)

  val giga : float
  (** giga *)

  val mega : float
  (** mega *)

  val kilo : float
  (** kilo *)

  val hecto : float
  (** hecto *)

  val deca : float
  (** deca *)

  val deci : float
  (** deci *)

  val centi : float
  (** centi *)

  val milli : float
  (** milli *)

  val micro : float
  (** micro *)

  val nano : float
  (** nano *)

  val pico : float
  (** pico *)

  val femto : float
  (** femto *)

  val atto : float
  (** atto *)

  val zepto : float
  (** zepto *)

  val yocto : float
  (** yocto *)

end


(** {6 SI: International System of Units} *)

module SI : sig
  val speed_of_light : float
  (** speed_of_light *)

  val gravitational_constant : float
  (** gravitational_constant *)

  val plancks_constant_h : float
  (** plancks_constant_h *)

  val plancks_constant_hbar : float
  (** plancks_constant_hbar *)

  val astronomical_unit : float
  (** astronomical_unit *)

  val light_year : float
  (** light_year *)

  val parsec : float
  (** parsec *)

  val grav_accel : float
  (** grav_accel *)

  val electron_volt : float
  (** electron_volt *)

  val mass_electron : float
  (** mass_electron *)

  val mass_muon : float
  (** mass_muon *)

  val mass_proton : float
  (** mass_proton *)

  val mass_neutron : float
  (** mass_neutron *)

  val rydberg : float
  (** rydberg *)

  val boltzmann : float
  (** boltzmann *)

  val molar_gas : float
  (** molar_gas *)

  val standard_gas_volume : float
  (** standard_gas_volume *)

  val minute : float
  (** minute *)

  val hour : float
  (** hour *)

  val day : float
  (** day *)

  val week : float
  (** week *)

  val inch : float
  (** inch *)

  val foot : float
  (** foot *)

  val yard : float
  (** yard *)

  val mile : float
  (** mile *)

  val nautical_mile : float
  (** nautical_mile *)

  val fathom : float
  (** fathom *)

  val mil : float
  (** mil *)

  val point : float
  (** point *)

  val texpoint : float
  (** texpoint *)

  val micron : float
  (** micron *)

  val angstrom : float
  (** angstrom *)

  val hectare : float
  (** hectare *)

  val acre : float
  (** acre *)

  val barn : float
  (** barn *)

  val liter : float
  (** liter *)

  val us_gallon : float
  (** us_gallon *)

  val quart : float
  (** quart *)

  val pint : float
  (** pint *)

  val cup : float
  (** cup *)

  val fluid_ounce : float
  (** fluid_ounce *)

  val tablespoon : float
  (** tablespoon *)

  val teaspoon : float
  (** teaspoon *)

  val canadian_gallon : float
  (** canadian_gallon *)

  val uk_gallon : float
  (** uk_gallon *)

  val miles_per_hour : float
  (** miles_per_hour *)

  val kilometers_per_hour : float
  (** kilometers_per_hour *)

  val knot : float
  (** knot *)

  val pound_mass : float
  (** pound_mass *)

  val ounce_mass : float
  (** ounce_mass *)

  val ton : float
  (** ton *)

  val metric_ton : float
  (** metric_ton *)

  val uk_ton : float
  (** uk_ton *)

  val troy_ounce : float
  (** troy_ounce *)

  val carat : float
  (** carat *)

  val unified_atomic_mass : float
  (** unified_atomic_mass *)

  val gram_force : float
  (** gram_force *)

  val pound_force : float
  (** pound_force *)

  val kilopound_force : float
  (** kilopound_force *)

  val poundal : float
  (** poundal *)

  val calorie : float
  (** calorie *)

  val btu : float
  (** btu *)

  val therm : float
  (** therm *)

  val horsepower : float
  (** horsepower *)

  val bar : float
  (** bar *)

  val std_atmosphere : float
  (** std_atmosphere *)

  val torr : float
  (** torr *)

  val meter_of_mercury : float
  (** meter_of_mercury *)

  val inch_of_mercury : float
  (** inch_of_mercury *)

  val inch_of_water : float
  (** inch_of_water *)

  val psi : float
  (** psi *)

  val poise : float
  (** poise *)

  val stokes : float
  (** stokes *)

  val stilb : float
  (** stilb *)

  val lumen : float
  (** lumen *)

  val lux : float
  (** lux *)

  val phot : float
  (** phot *)

  val footcandle : float
  (** footcandle *)

  val lambert : float
  (** lambert *)

  val footlambert : float
  (** footlambert *)

  val curie : float
  (** curie *)

  val roentgen : float
  (** roentgen *)

  val rad : float
  (** rad *)

  val solar_mass : float
  (** solar_mass *)

  val bohr_radius : float
  (** bohr_radius *)

  val newton : float
  (** newton *)

  val dyne : float
  (** dyne *)

  val joule : float
  (** joule *)

  val erg : float
  (** erg *)

  val stefan_boltzmann_constant : float
  (** stefan_boltzmann_constant *)

  val thomson_cross_section : float
  (** thomson_cross_section *)

  val bohr_magneton : float
  (** bohr_magneton *)

  val nuclear_magneton : float
  (** nuclear_magneton *)

  val electron_magnetic_moment : float
  (** electron_magnetic_moment *)

  val proton_magnetic_moment : float
  (** proton_magnetic_moment *)

  val faraday : float
  (** faraday *)

  val electron_charge : float
  (** electron_charge *)

  val vacuum_permittivity : float
  (** vacuum_permittivity *)

  val vacuum_permeability : float
  (** vacuum_permeability *)

  val debye : float
  (** debye *)

  val gauss : float
  (** gauss *)

end


(** {6 MKS: MKS system of units} *)

module MKS : sig
  val speed_of_light : float
  (** speed_of_light *)

  val gravitational_constant : float
  (** gravitational_constant *)

  val plancks_constant_h : float
  (** plancks_constant_h *)

  val plancks_constant_hbar : float
  (** plancks_constant_hbar *)

  val astronomical_unit : float
  (** astronomical_unit *)

  val light_year : float
  (** light_year *)

  val parsec : float
  (** parsec *)

  val grav_accel : float
  (** grav_accel *)

  val electron_volt : float
  (** electron_volt *)

  val mass_electron : float
  (** mass_electron *)

  val mass_muon : float
  (** mass_muon *)

  val mass_proton : float
  (** mass_proton *)

  val mass_neutron : float
  (** mass_neutron *)

  val rydberg : float
  (** rydberg *)

  val boltzmann : float
  (** boltzmann *)

  val molar_gas : float
  (** molar_gas *)

  val standard_gas_volume : float
  (** standard_gas_volume *)

  val minute : float
  (** minute *)

  val hour : float
  (** hour *)

  val day : float
  (** day *)

  val week : float
  (** week *)

  val inch : float
  (** inch *)

  val foot : float
  (** foot *)

  val yard : float
  (** yard *)

  val mile : float
  (** mile *)

  val nautical_mile : float
  (** nautical_mile *)

  val fathom : float
  (** fathom *)

  val mil : float
  (** mil *)

  val point : float
  (** point *)

  val texpoint : float
  (** texpoint *)

  val micron : float
  (** micron *)

  val angstrom : float
  (** angstrom *)

  val hectare : float
  (** hectare *)

  val acre : float
  (** acre *)

  val barn : float
  (** barn *)

  val liter : float
  (** liter *)

  val us_gallon : float
  (** us_gallon *)

  val quart : float
  (** quart *)

  val pint : float
  (** pint *)

  val cup : float
  (** cup *)

  val fluid_ounce : float
  (** fluid_ounce *)

  val tablespoon : float
  (** tablespoon *)

  val teaspoon : float
  (** teaspoon *)

  val canadian_gallon : float
  (** canadian_gallon *)

  val uk_gallon : float
  (** uk_gallon *)

  val miles_per_hour : float
  (** miles_per_hour *)

  val kilometers_per_hour : float
  (** kilometers_per_hour *)

  val knot : float
  (** knot *)

  val pound_mass : float
  (** pound_mass *)

  val ounce_mass : float
  (** ounce_mass *)

  val ton : float
  (** ton *)

  val metric_ton : float
  (** metric_ton *)

  val uk_ton : float
  (** uk_ton *)

  val troy_ounce : float
  (** troy_ounce *)

  val carat : float
  (** carat *)

  val unified_atomic_mass : float
  (** unified_atomic_mass *)

  val gram_force : float
  (** gram_force *)

  val pound_force : float
  (** pound_force *)

  val kilopound_force : float
  (** kilopound_force *)

  val poundal : float
  (** poundal *)

  val calorie : float
  (** calorie *)

  val btu : float
  (** btu *)

  val therm : float
  (** therm *)

  val horsepower : float
  (** horsepower *)

  val bar : float
  (** bar *)

  val std_atmosphere : float
  (** std_atmosphere *)

  val torr : float
  (** torr *)

  val meter_of_mercury : float
  (** meter_of_mercury *)

  val inch_of_mercury : float
  (** inch_of_mercury *)

  val inch_of_water : float
  (** inch_of_water *)

  val psi : float
  (** psi *)

  val poise : float
  (** poise *)

  val stokes : float
  (** stokes *)

  val stilb : float
  (** stilb *)

  val lumen : float
  (** lumen *)

  val lux : float
  (** lux *)

  val phot : float
  (** phot *)

  val footcandle : float
  (** footcandle *)

  val lambert : float
  (** lambert *)

  val footlambert : float
  (** footlambert *)

  val curie : float
  (** curie *)

  val roentgen : float
  (** roentgen *)

  val rad : float
  (** rad *)

  val solar_mass : float
  (** solar_mass *)

  val bohr_radius : float
  (** bohr_radius *)

  val newton : float
  (** newton *)

  val dyne : float
  (** dyne *)

  val joule : float
  (** joule *)

  val erg : float
  (** erg *)

  val stefan_boltzmann_constant : float
  (** stefan_boltzmann_constant *)

  val thomson_cross_section : float
  (** thomson_cross_section *)

  val bohr_magneton : float
  (** bohr_magneton *)

  val nuclear_magneton : float
  (** nuclear_magneton *)

  val electron_magnetic_moment : float
  (** electron_magnetic_moment *)

  val proton_magnetic_moment : float
  (** proton_magnetic_moment *)

  val faraday : float
  (** faraday *)

  val electron_charge : float
  (** electron_charge *)

  val vacuum_permittivity : float
  (** vacuum_permittivity *)

  val vacuum_permeability : float
  (** vacuum_permeability *)

  val debye : float
  (** debye *)

  val gauss : float
  (** gauss *)

end


(** {6 CGS: Centimetre–gram–second system of units} *)

module CGS : sig
  val speed_of_light : float
  (** speed_of_light *)

  val gravitational_constant : float
  (** gravitational_constant *)

  val plancks_constant_h : float
  (** plancks_constant_h *)

  val plancks_constant_hbar : float
  (** plancks_constant_hbar *)

  val astronomical_unit : float
  (** astronomical_unit *)

  val light_year : float
  (** light_year *)

  val parsec : float
  (** parsec *)

  val grav_accel : float
  (** grav_accel *)

  val electron_volt : float
  (** electron_volt *)

  val mass_electron : float
  (** mass_electron *)

  val mass_muon : float
  (** mass_muon *)

  val mass_proton : float
  (** mass_proton *)

  val mass_neutron : float
  (** mass_neutron *)

  val rydberg : float
  (** rydberg *)

  val boltzmann : float
  (** boltzmann *)

  val molar_gas : float
  (** molar_gas *)

  val standard_gas_volume : float
  (** standard_gas_volume *)

  val minute : float
  (** minute *)

  val hour : float
  (** hour *)

  val day : float
  (** day *)

  val week : float
  (** week *)

  val inch : float
  (** inch *)

  val foot : float
  (** foot *)

  val yard : float
  (** yard *)

  val mile : float
  (** mile *)

  val nautical_mile : float
  (** nautical_mile *)

  val fathom : float
  (** fathom *)

  val mil : float
  (** mil *)

  val point : float
  (** point *)

  val texpoint : float
  (** texpoint *)

  val micron : float
  (** micron *)

  val angstrom : float
  (** angstrom *)

  val hectare : float
  (** hectare *)

  val acre : float
  (** acre *)

  val barn : float
  (** barn *)

  val liter : float
  (** liter *)

  val us_gallon : float
  (** us_gallon *)

  val quart : float
  (** quart *)

  val pint : float
  (** pint *)

  val cup : float
  (** cup *)

  val fluid_ounce : float
  (** fluid_ounce *)

  val tablespoon : float
  (** tablespoon *)

  val teaspoon : float
  (** teaspoon *)

  val canadian_gallon : float
  (** canadian_gallon *)

  val uk_gallon : float
  (** uk_gallon *)

  val miles_per_hour : float
  (** miles_per_hour *)

  val kilometers_per_hour : float
  (** kilometers_per_hour *)

  val knot : float
  (** knot *)

  val pound_mass : float
  (** pound_mass *)

  val ounce_mass : float
  (** ounce_mass *)

  val ton : float
  (** ton *)

  val metric_ton : float
  (** metric_ton *)

  val uk_ton : float
  (** uk_ton *)

  val troy_ounce : float
  (** troy_ounce *)

  val carat : float
  (** carat *)

  val unified_atomic_mass : float
  (** unified_atomic_mass *)

  val gram_force : float
  (** gram_force *)

  val pound_force : float
  (** pound_force *)

  val kilopound_force : float
  (** kilopound_force *)

  val poundal : float
  (** poundal *)

  val calorie : float
  (** calorie *)

  val btu : float
  (** btu *)

  val therm : float
  (** therm *)

  val horsepower : float
  (** horsepower *)

  val bar : float
  (** bar *)

  val std_atmosphere : float
  (** std_atmosphere *)

  val torr : float
  (** torr *)

  val meter_of_mercury : float
  (** meter_of_mercury *)

  val inch_of_mercury : float
  (** inch_of_mercury *)

  val inch_of_water : float
  (** inch_of_water *)

  val psi : float
  (** psi *)

  val poise : float
  (** poise *)

  val stokes : float
  (** stokes *)

  val stilb : float
  (** stilb *)

  val lumen : float
  (** lumen *)

  val lux : float
  (** lux *)

  val phot : float
  (** phot *)

  val footcandle : float
  (** footcandle *)

  val lambert : float
  (** lambert *)

  val footlambert : float
  (** footlambert *)

  val curie : float
  (** curie *)

  val roentgen : float
  (** roentgen *)

  val rad : float
  (** rad *)

  val solar_mass : float
  (** solar_mass *)

  val bohr_radius : float
  (** bohr_radius *)

  val newton : float
  (** newton *)

  val dyne : float
  (** dyne *)

  val joule : float
  (** joule *)

  val erg : float
  (** erg *)

  val stefan_boltzmann_constant : float
  (** stefan_boltzmann_constant *)

  val thomson_cross_section : float
  (** thomson_cross_section *)

end


(** {6 CGSM: Unit Systems in Electromagnetism} *)

module CGSM : sig
  val speed_of_light : float
  (** speed_of_light *)

  val gravitational_constant : float
  (** gravitational_constant *)

  val plancks_constant_h : float
  (** plancks_constant_h *)

  val plancks_constant_hbar : float
  (** plancks_constant_hbar *)

  val astronomical_unit : float
  (** astronomical_unit *)

  val light_year : float
  (** light_year *)

  val parsec : float
  (** parsec *)

  val grav_accel : float
  (** grav_accel *)

  val electron_volt : float
  (** electron_volt *)

  val mass_electron : float
  (** mass_electron *)

  val mass_muon : float
  (** mass_muon *)

  val mass_proton : float
  (** mass_proton *)

  val mass_neutron : float
  (** mass_neutron *)

  val rydberg : float
  (** rydberg *)

  val boltzmann : float
  (** boltzmann *)

  val molar_gas : float
  (** molar_gas *)

  val standard_gas_volume : float
  (** standard_gas_volume *)

  val minute : float
  (** minute *)

  val hour : float
  (** hour *)

  val day : float
  (** day *)

  val week : float
  (** week *)

  val inch : float
  (** inch *)

  val foot : float
  (** foot *)

  val yard : float
  (** yard *)

  val mile : float
  (** mile *)

  val nautical_mile : float
  (** nautical_mile *)

  val fathom : float
  (** fathom *)

  val mil : float
  (** mil *)

  val point : float
  (** point *)

  val texpoint : float
  (** texpoint *)

  val micron : float
  (** micron *)

  val angstrom : float
  (** angstrom *)

  val hectare : float
  (** hectare *)

  val acre : float
  (** acre *)

  val barn : float
  (** barn *)

  val liter : float
  (** liter *)

  val us_gallon : float
  (** us_gallon *)

  val quart : float
  (** quart *)

  val pint : float
  (** pint *)

  val cup : float
  (** cup *)

  val fluid_ounce : float
  (** fluid_ounce *)

  val tablespoon : float
  (** tablespoon *)

  val teaspoon : float
  (** teaspoon *)

  val canadian_gallon : float
  (** canadian_gallon *)

  val uk_gallon : float
  (** uk_gallon *)

  val miles_per_hour : float
  (** miles_per_hour *)

  val kilometers_per_hour : float
  (** kilometers_per_hour *)

  val knot : float
  (** knot *)

  val pound_mass : float
  (** pound_mass *)

  val ounce_mass : float
  (** ounce_mass *)

  val ton : float
  (** ton *)

  val metric_ton : float
  (** metric_ton *)

  val uk_ton : float
  (** uk_ton *)

  val troy_ounce : float
  (** troy_ounce *)

  val carat : float
  (** carat *)

  val unified_atomic_mass : float
  (** unified_atomic_mass *)

  val gram_force : float
  (** gram_force *)

  val pound_force : float
  (** pound_force *)

  val kilopound_force : float
  (** kilopound_force *)

  val poundal : float
  (** poundal *)

  val calorie : float
  (** calorie *)

  val btu : float
  (** btu *)

  val therm : float
  (** therm *)

  val horsepower : float
  (** horsepower *)

  val bar : float
  (** bar *)

  val std_atmosphere : float
  (** std_atmosphere *)

  val torr : float
  (** torr *)

  val meter_of_mercury : float
  (** meter_of_mercury *)

  val inch_of_mercury : float
  (** inch_of_mercury *)

  val inch_of_water : float
  (** inch_of_water *)

  val psi : float
  (** psi *)

  val poise : float
  (** poise *)

  val stokes : float
  (** stokes *)

  val stilb : float
  (** stilb *)

  val lumen : float
  (** lumen *)

  val lux : float
  (** lux *)

  val phot : float
  (** phot *)

  val footcandle : float
  (** footcandle *)

  val lambert : float
  (** lambert *)

  val footlambert : float
  (** footlambert *)

  val curie : float
  (** curie *)

  val roentgen : float
  (** roentgen *)

  val rad : float
  (** rad *)

  val solar_mass : float
  (** solar_mass *)

  val bohr_radius : float
  (** bohr_radius *)

  val newton : float
  (** newton *)

  val dyne : float
  (** dyne *)

  val joule : float
  (** joule *)

  val erg : float
  (** erg *)

  val stefan_boltzmann_constant : float
  (** stefan_boltzmann_constant *)

  val thomson_cross_section : float
  (** thomson_cross_section *)

  val bohr_magneton : float
  (** bohr_magneton *)

  val nuclear_magneton : float
  (** nuclear_magneton *)

  val electron_magnetic_moment : float
  (** electron_magnetic_moment *)

  val proton_magnetic_moment : float
  (** proton_magnetic_moment *)

  val faraday : float
  (** faraday *)

  val electron_charge : float
  (** electron_charge *)

end
