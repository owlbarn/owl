open Owl_converter_types

let make_attrdef ?(typ="DT_EMPTY") name =
  { name = name;
    typ  = typ;
    default_value = Some (ATTR_String "nil");
    allowed_values = Some (ATTR_AttrLst [| ATTR_String "nil" |]);
    has_minimum = None;
    minimum = None
  }


let make_attr_pair ?(value=ATTR_String "nil") key =
  { key = key; value = value }
