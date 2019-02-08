## The naming scheme

- The one or more output nodes' names are all put in the node collection that is named "result".

- Each node has a unique name. The name could be layered in the "xx/xx/xx..." style.

- The checkpoint file is always named "owl_model"

- All the node in Owl's cgraph needs to be named. If not already named, it will be named in the format "owlnode+id".

- The saver related node has its own fixed naming rules that's the same with TF's.


## Other rules

- If an owlnode returns multiple tfnodes, the output node that others should connect to is put in the first element of the returned array.
