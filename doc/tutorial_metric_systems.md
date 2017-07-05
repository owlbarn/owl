In many scientific computing problems, numbers are not abstract but reflect the realistic meanings. In other words, these numbers only make sense on top of a well-defined metric system.

## What Is A Metric System

For example, when we talk about the distance between two objects, I write down a number `30`. But what does `30` mean in reality? Is it meters, kilometers, miles, or lightyears? Another example, what is the speed of light? Well, this is really depends on what metrics you are using, e.g., `km/s`, `m/s`, `mile/h` ...

Things can get really messy in computation if we do not unify the metric system in a numerical library. The translation between different metrics are often important in real-world application. I do not intend to dig deep into the metric system here, so please read online articles to find out more, e.g., [Wiki: Outline of the metric system](https://en.wikipedia.org/wiki/Outline_of_the_metric_system).


## Metric Systems in Owl

There are four metrics adopted in Owl, and all of them are wrapped in `Owl.Const` module.

* `Const.SI`: [International System of Units](https://en.wikipedia.org/wiki/International_System_of_Units)
* `Const.MKS`: [MKS system of units](https://en.wikipedia.org/wiki/MKS_system_of_units)
* `Const.CGS`: [Centimetre–gram–second system of units](https://en.wikipedia.org/wiki/Centimetre%E2%80%93gram%E2%80%93second_system_of_units)
* `Const.CGSM`: [Electromagnetic System of Units](https://en.wikipedia.org/wiki/Centimetre%E2%80%93gram%E2%80%93second_system_of_units#CGS_approach_to_electromagnetic_units)

All the metrics defined in these four systems can be found in the interface file [owl_const.mli](https://github.com/ryanrhymes/owl/blob/master/lib/owl_const.mli).

In general, SI is much newer and recommended to use. International System of Units (French: Système international d'unités, SI), historically also called the MKSA system of units for metre–kilogram–second–ampere. The SI system of units extends the MKS system and has 7 base units, by expressing any measurement of physical quantities using fundamental units of Length, Mass, Time, Electric Current, Thermodynamic Temperature, Amount of substance and Luminous Intensity, which are Metre, Kilogram, Second, Ampere, Kelvin, Mole and Candela respectively.

Here is a nice [one-page poster](http://www.npl.co.uk/upload/pdf/units-of-measurement-poster.pdf) from NPL to summarise what have talked about SI.

[[image/metric_001.png]]


## SI Prefix

As a computer scientist, you must be familiar with `kilo`, `mega`, `giga` these prefixes. SI system includes the definition of these prefixes as well. But be careful (especially for computer science guys), the base is `10` instead of 2.

These prefixes are defined in `Const.Prefix` module.

```ocaml
Const.Prefix.peta;;
Const.Prefix.tera;;
Const.Prefix.giga;;
Const.Prefix.mega;;
Const.Prefix.kilo;;
Const.Prefix.hecto;;
...
```


## Some Examples

Now we can safely talk about the distance between two objects, light of speed, and many other real-world stuff with atop of a well-defined metric system in Owl. See the following examples.

```ocaml
Const.SI.light_year;;     (* light year in SI system *)
Const.MKS.light_year;;    (* light year in MKS system *)
Const.CGS.light_year;;    (* light year in CGS system *)
Const.CGSM.light_year;;   (* light year in CGSM system *)
```

How about Planck's constant?

```ocaml
Const.SI.plancks_constant_h;;     (* in SI system *)
Const.MKS.plancks_constant_h;;    (* in MKS system *)
Const.CGS.plancks_constant_h;;    (* in CGS system *)
Const.CGSM.plancks_constant_h;;   (* in CGSM system *)
```

Enjoy Owl! Happy hacking!
