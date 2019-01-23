open Owl_converter_types

let make_attrdef () = {
  name = "EmptyAttr";
  typ  = "string";
  default_value  = ATTR_String "nil";
  allowed_values = ATTR_AttrLst [| ATTR_String "nil" |];
  has_minimum = false;
  minimum = 0
}


let make_attr_pair () =
  {key = "empty_attr"; value = ATTR_String "nil"; }
